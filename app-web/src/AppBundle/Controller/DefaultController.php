<?php

namespace AppBundle\Controller;

use AppBundle\Form\PublishForm;
use Sensio\Bundle\FrameworkExtraBundle\Configuration\Route;
use Symfony\Bundle\FrameworkBundle\Controller\Controller;
use Symfony\Component\Form\FormError;
use Symfony\Component\HttpFoundation\Request;

class DefaultController extends Controller
{
    /**
     * @Route("/", name="homepage")
     *
     * @param Request $request
     *
     * @return \Symfony\Component\HttpFoundation\Response
     */
    public function indexAction(Request $request)
    {
        $session = $this->get('session');
        $session->start();
        $sessionId = $session->getId();

        $cache = $this->get('doctrine_cache.providers.sc_memcached');

        $sessionCounter = 0;
        if ($cache->contains('session_visit'.$sessionId)) {
            $sessionCounter = $cache->fetch('session_visit'.$sessionId);
        }
        $cache->save('session_visit'.$sessionId, $sessionCounter);

        $globalCounter = 0;
        if ($cache->contains('visit_counter')) {
            $globalCounter = $cache->fetch('visit_counter');
        }
        $cache->save('visit_counter', $globalCounter);

        $form = $this->createForm(new PublishForm());

        $form->handleRequest($request);

        if ($form->isValid()) {
            try {
                $this->publish($form->getData());
            } catch (\Exception $exception) {
                $form->get('message')->addError(new FormError($exception->getMessage()));
            }
        }


        return $this->render('default/index.html.twig', [
            'baseDir' => realpath($this->container->getParameter('kernel.root_dir').'/..').DIRECTORY_SEPARATOR,
            'sessionCounter' => $sessionCounter,
            'globalCounter' => $globalCounter,
            'form' => $form->createView(),
        ]);
    }

    private function publish($message)
    {
        $this->get('old_sound_rabbit_mq.example_producer')->publish($message['message']);
    }

}

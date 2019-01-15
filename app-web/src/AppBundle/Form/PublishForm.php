<?php

namespace AppBundle\Form;


use Symfony\Component\Form\AbstractType;
use Symfony\Component\Form\Extension\Core\Type\SubmitType;
use Symfony\Component\Form\Extension\Core\Type\TextType;
use Symfony\Component\Form\FormBuilderInterface;

class PublishForm extends AbstractType
{

    /**
     * Builds the form.
     *
     * This method is called for each type in the hierarchy starting from the
     * top most type. Type extensions can further modify the form.
     *
     * @see FormTypeExtensionInterface::buildForm()
     *
     * @param FormBuilderInterface $builder The form builder
     * @param array                $options The options
     */
    public function buildForm(FormBuilderInterface $builder, array $options)
    {
        $builder->add('message', TextType::class ,[
            'required' => false,
            'attr' => ['class' => 'form-control'],
            'label' => 'Message'
        ]);

        $builder->add('submit', SubmitType::class ,[
            'label' => 'submit',
            'attr' => ['class' => 'btn']
        ]);

        $builder->setAttribute('novalidate', 'novalidate');
        $builder->setMethod('POST');
    }



}
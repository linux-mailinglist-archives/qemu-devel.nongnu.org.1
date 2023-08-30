Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A05D78D52E
	for <lists+qemu-devel@lfdr.de>; Wed, 30 Aug 2023 12:50:01 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qbIl1-0001cm-O5; Wed, 30 Aug 2023 06:49:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1qbIkz-0001ce-EP
 for qemu-devel@nongnu.org; Wed, 30 Aug 2023 06:49:05 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1qbIkw-0006yA-Sd
 for qemu-devel@nongnu.org; Wed, 30 Aug 2023 06:49:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1693392542;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=yEJGqrUgjZaux7/Z8NJYXnolw9er3g/yxRHuCaB8Xeo=;
 b=WRCDmSMffXKAcGsotuITsXdtvtT/YQk1eWbImYQbIGvsD73tUsO6/P3GQBcIynsOXKZFqf
 snLJXOPak7r+tZOiYLZy9I1UMB+fb2iTYvYGtoT5ztX5q+JHpZoL1jxWA9h+7pSUtmAkbc
 xHDyjFp87+BvmsVvsv2G+M7yuOwpI8o=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-204-Zlxa6a2IOKquQp5Zi5JmVQ-1; Wed, 30 Aug 2023 06:49:00 -0400
X-MC-Unique: Zlxa6a2IOKquQp5Zi5JmVQ-1
Received: by mail-ej1-f70.google.com with SMTP id
 a640c23a62f3a-99df23d6926so396635266b.0
 for <qemu-devel@nongnu.org>; Wed, 30 Aug 2023 03:49:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693392539; x=1693997339;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=yEJGqrUgjZaux7/Z8NJYXnolw9er3g/yxRHuCaB8Xeo=;
 b=Tg3D3GfYOHi/RwgQxUtD4FZ/NCnml7oiwMI3xfxcAyYeCeuhJ2EbtPCpYS4HohfwSX
 WRUQJn+dQq9u/ZgfMp6/jW8Jt890wp8nHLrl43J+7fb44HQJQRj0uzG3kZ2NcDizKW97
 9g1WASPKTdb1MRfjO2nXQIkdW8Gs8jSZiPVczS0gwD8Z2YCfGaw/S4JUSb1jI3ZYzjn7
 hH5fw+3d0KnSnnpy/3jW/mKegDBKV7M05vikvzuBWDrBbRrdl8PsoQuyS/2aSbDHTrrG
 FOGtWxQvhzWNeJ1A2VdYo9oiyq1IjSQ0WmX5TYq/piy9q0Z6s06hLSfEbLMGPxcyA8ql
 Mzjw==
X-Gm-Message-State: AOJu0YwJCQjZAbWrmjITl6kigbQGqHHGua2J2sgdab6JJfFCYXiB98zd
 KZCz9snTbHjvipbAPlxymwkwXhjHSJlcWrayrFnZ72BKXIpO/WM0AP6PwvG7K7qmi4YPEkJhA9B
 ag3mWK4tJOKOFHO4=
X-Received: by 2002:a17:906:1da1:b0:9a2:96d2:b1e6 with SMTP id
 u1-20020a1709061da100b009a296d2b1e6mr1337720ejh.75.1693392539661; 
 Wed, 30 Aug 2023 03:48:59 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFoo07q9qQhh3PTVaS9vkTanuQfVjvDVRj2yZsLPYwlcqESfzKikC6F/J+ZZRe/IrmVSeYDLA==
X-Received: by 2002:a17:906:1da1:b0:9a2:96d2:b1e6 with SMTP id
 u1-20020a1709061da100b009a296d2b1e6mr1337704ejh.75.1693392539284; 
 Wed, 30 Aug 2023 03:48:59 -0700 (PDT)
Received: from imammedo.users.ipa.redhat.com (nat-pool-brq-t.redhat.com.
 [213.175.37.10]) by smtp.gmail.com with ESMTPSA id
 t11-20020a1709066bcb00b0099cb1a2cab0sm7132902ejs.28.2023.08.30.03.48.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 30 Aug 2023 03:48:58 -0700 (PDT)
Date: Wed, 30 Aug 2023 12:48:56 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: "Liu, Jing2" <jing2.liu@intel.com>
Cc: =?UTF-8?B?Q8OpZHJpYw==?= Le Goater <clg@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 "pbonzini@redhat.com" <pbonzini@redhat.com>, "Tian, Kevin"
 <kevin.tian@intel.com>, "Chatre, Reinette" <reinette.chatre@intel.com>,
 "jing2.liu@linux.intel.com" <jing2.liu@linux.intel.com>
Subject: Re: [PATCH v1 3/4] vfio/pci: use an invalid fd to enable MSI-X
Message-ID: <20230830124856.60efa152@imammedo.users.ipa.redhat.com>
In-Reply-To: <DS0PR11MB8114DF931C88CD84C0E1BBEFA9E6A@DS0PR11MB8114.namprd11.prod.outlook.com>
References: <20230822072927.224803-1-jing2.liu@intel.com>
 <20230822072927.224803-4-jing2.liu@intel.com>
 <3716c573-fb2e-cc26-d77e-b930353f9b8d@redhat.com>
 <DS0PR11MB8114DF931C88CD84C0E1BBEFA9E6A@DS0PR11MB8114.namprd11.prod.outlook.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=imammedo@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

On Wed, 30 Aug 2023 10:03:33 +0000
"Liu, Jing2" <jing2.liu@intel.com> wrote:

> Hi C=C3=A9dric=EF=BC=8C
>=20
> On 8/29/2023 10:04 PM, C=C3=A9dric Le Goater wrote:
> > On 8/22/23 09:29, Jing Liu wrote: =20
> > > Guests typically enable MSI-X with all of the vectors masked in the
> > > MSI-X vector table. To match the guest state of device, Qemu enables
> > > MSI-X by =20
> >=20
> > QEMU is preferred to Qemu. =20
> Got it.=20
>=20
> >  =20
> > > enabling vector 0 with userspace triggering and immediately release.
> > > However the release function actually does not release it due to
> > > already using userspace mode.
> > >
> > > It is no need to enable triggering on host and rely on the mask bit to
> > > avoid spurious interrupts. Use an invalid fd (i.e. fd =3D -1) is enou=
gh
> > > to get MSI-X enabled.
> > >
> > > After dynamic MSI-X allocation is supported, the interrupt restoring
> > > also need use such way to enable MSI-X, therefore, create a function
> > > for that.
> > >
> > > Suggested-by: Alex Williamson <alex.williamson@redhat.com>
> > > Signed-off-by: Jing Liu <jing2.liu@intel.com>
> > > ---
> > > Changes since RFC v1:
> > > - A new patch. Use an invalid fd to get MSI-X enabled instead of using
> > >    userspace triggering. (Alex)
> > > ---
> > >   hw/vfio/pci.c | 50 ++++++++++++++++++++++++++++++++++++++++++------=
--
> > >   1 file changed, 42 insertions(+), 8 deletions(-)
> > >
> > > diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c index
> > > 31f36d68bb19..e24c21241a0c 100644
> > > --- a/hw/vfio/pci.c
> > > +++ b/hw/vfio/pci.c
> > > @@ -369,6 +369,39 @@ static void vfio_msi_interrupt(void *opaque)
> > >       notify(&vdev->pdev, nr);
> > >   }
> > >
> > > +/*
> > > + * Get MSI-X enabled, but no vector enabled, by setting vector 0 with
> > > +an invalid
> > > + * fd to kernel.
> > > + */
> > > +static int vfio_enable_msix_no_vec(VFIOPCIDevice *vdev)> +{
> > > +    struct vfio_irq_set *irq_set; =20
> >=20
> > This could be a 'g_autofree' variable. =20
>=20
> Thanks for pointing this to me. I just realized QEMU doc recommends=20
> g_autofree/g_autoptr to do automatic memory deallocation.
>=20
> I will replace to g_autofree style in next version.
>=20
> I have a question for a specific example (not related to this patch), and
> I failed to find an example in current QEMU code to understand it.
> If one g_autofree structure includes a pointer that we also allocate
> space for the inside pointer, could g_autofree release the inside space?

it might be too cumbersome for 1-off use
see following for how 'auto' works https://docs.gtk.org/glib/auto-cleanup.h=
tml
=20
> struct dummy1 {
>     int data;
>     struct *p;
> }
> struct p {
>     char member[];
> }
> void func() {
>     g_autofree struct *dummy1 =3D NULL;
>=20
>     dummy1 =3D g_malloc();
>     dummy1->p =3D g_malloc();
>     ...
>     return;	// is this correct or need g_free(p)?
> }
>=20
> >  =20
> > > +    int ret =3D 0, argsz;
> > > +    int32_t *fd;
> > > +
> > > +    argsz =3D sizeof(*irq_set) + sizeof(*fd);
> > > +
> > > +    irq_set =3D g_malloc0(argsz);
> > > +    irq_set->argsz =3D argsz;
> > > +    irq_set->flags =3D VFIO_IRQ_SET_DATA_EVENTFD |
> > > +                     VFIO_IRQ_SET_ACTION_TRIGGER;
> > > +    irq_set->index =3D VFIO_PCI_MSIX_IRQ_INDEX;
> > > +    irq_set->start =3D 0;
> > > +    irq_set->count =3D 1;
> > > +    fd =3D (int32_t *)&irq_set->data;
> > > +    *fd =3D -1;
> > > +
> > > +    ret =3D ioctl(vdev->vbasedev.fd, VFIO_DEVICE_SET_IRQS, irq_set);
> > > +    if (ret) {
> > > +        error_report("vfio: failed to enable MSI-X with vector 0 tri=
ck, %d",
> > > +                     ret); =20
> >=20
> > The above message seems redundant. I would simply return 'ret' and let =
the
> > caller report the error. Same as vfio_enable_vectors(). =20
>=20
> Understood. Will change.
>=20
> Thanks,
> Jing
>=20
> > Thanks,
> >=20
> > C.
> >=20
> >  =20
> > > +    }
> > > +
> > > +    g_free(irq_set);
> > > +
> > > +    return ret;
> > > +}
> > > +
> > >   static int vfio_enable_vectors(VFIOPCIDevice *vdev, bool msix)
> > >   {
> > >       struct vfio_irq_set *irq_set;
> > > @@ -618,6 +651,8 @@ static void
> > > vfio_commit_kvm_msi_virq_batch(VFIOPCIDevice *vdev)
> > >
> > >   static void vfio_msix_enable(VFIOPCIDevice *vdev)
> > >   {
> > > +    int ret;
> > > +
> > >       vfio_disable_interrupts(vdev);
> > >
> > >       vdev->msi_vectors =3D g_new0(VFIOMSIVector, vdev->msix->entries=
);
> > > @@ -640,8 +675,6 @@ static void vfio_msix_enable(VFIOPCIDevice *vdev)
> > >       vfio_commit_kvm_msi_virq_batch(vdev);
> > >
> > >       if (vdev->nr_vectors) {
> > > -        int ret;
> > > -
> > >           ret =3D vfio_enable_vectors(vdev, true);
> > >           if (ret) {
> > >               error_report("vfio: failed to enable vectors, %d", ret);
> > > @@ -655,13 +688,14 @@ static void vfio_msix_enable(VFIOPCIDevice *vde=
v)
> > >            * MSI-X capability, but leaves the vector table masked.  W=
e therefore
> > >            * can't rely on a vector_use callback (from request_irq() =
in the guest)
> > >            * to switch the physical device into MSI-X mode because th=
at may come =20
> > a =20
> > > -         * long time after pci_enable_msix().  This code enables vec=
tor 0 with
> > > -         * triggering to userspace, then immediately release the vec=
tor, leaving
> > > -         * the physical device with no vectors enabled, but MSI-X en=
abled, just
> > > -         * like the guest view.
> > > +         * long time after pci_enable_msix().  This code sets vector=
 0 with an
> > > +         * invalid fd to make the physical device MSI-X enabled, but=
 with no
> > > +         * vectors enabled, just like the guest view.
> > >            */
> > > -        vfio_msix_vector_do_use(&vdev->pdev, 0, NULL, NULL);
> > > -        vfio_msix_vector_release(&vdev->pdev, 0);
> > > +        ret =3D vfio_enable_msix_no_vec(vdev);
> > > +        if (ret) {
> > > +            error_report("vfio: failed to enable MSI-X, %d", ret);
> > > +        }
> > >       }
> > >
> > >       trace_vfio_msix_enable(vdev->vbasedev.name); =20
>=20



Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D3BA77B5564
	for <lists+qemu-devel@lfdr.de>; Mon,  2 Oct 2023 16:42:40 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qnK7g-0008UH-HO; Mon, 02 Oct 2023 10:42:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.williamson@redhat.com>)
 id 1qnK7Z-0008Lk-Nf
 for qemu-devel@nongnu.org; Mon, 02 Oct 2023 10:42:05 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.williamson@redhat.com>)
 id 1qnK7O-0001P6-Oj
 for qemu-devel@nongnu.org; Mon, 02 Oct 2023 10:42:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1696257713;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5+kLQQR8UI+8ZvRcKWIFwiXyKEaK8i196fLKyop+T/I=;
 b=CCbAqK0jEB99TX73w09g0KzgWtLGZKpOgzN+sMyJiMVtQVmJ90SOEznI8n6n8VARZwxt9p
 1VDKlRQYMbW/S6qUxffj5kP6/G91b6iKNEOX1OEF3PpKAevEGzuJiSwv5H0l+sS+2YdDAC
 S7SsS5lqQSocjL/MOKnDThHRYJ9ZVNs=
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com
 [209.85.166.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-342-gdxUnSf7O0mtXoCWOdEVyA-1; Mon, 02 Oct 2023 10:41:37 -0400
X-MC-Unique: gdxUnSf7O0mtXoCWOdEVyA-1
Received: by mail-il1-f197.google.com with SMTP id
 e9e14a558f8ab-35141a8fea5so127370835ab.1
 for <qemu-devel@nongnu.org>; Mon, 02 Oct 2023 07:41:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696257696; x=1696862496;
 h=content-transfer-encoding:mime-version:organization:references
 :in-reply-to:message-id:subject:cc:to:from:date:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=5+kLQQR8UI+8ZvRcKWIFwiXyKEaK8i196fLKyop+T/I=;
 b=uB/wQUOh1pEfjcUFfo/MB8nHOLgCWX+iI3Ay1gNnUUG+fMVQdhPgUXNiEx9zlQJMKQ
 Hg8/MHnDcHVnDr/iF0proKOlt33UwkVKLpjHE0/RLuti6cB6h8YCHR09mnVP5ofvACa9
 pS+6pdrppbzrQy/zuWLVD97Bwfu18W+WmUi7O8WPU2jIY59JPWsndAtQEYktg1FD5y5/
 JabUUXZaZhqpz64HO+qp1szhUrJ8e55VeCdHNd9YZupk69xY7DXqOYIExRgb0byfkcrJ
 /XDnn6BOyRkQgpNV3UCMlb/AbG/z8hTKnHM5wE5R4c0Bsucd+F/Dr3crb4xHWAEQ/IVl
 uVAA==
X-Gm-Message-State: AOJu0YyaDnfTxCjsT3YTPHeVtw1P7EI6bL+t4JBQ9iNNMOkNniKQOiN9
 Fu5D2z0be4xVqWYqjpKBbRxnaLT60+eWcY1Y6QZ48bLPPQOEEZhFim6xYIfkpyxRz9JGEOsmMAc
 z87FdaXdyGg3car8=
X-Received: by 2002:a05:6e02:1aad:b0:352:61f2:8fd5 with SMTP id
 l13-20020a056e021aad00b0035261f28fd5mr11843359ilv.18.1696257696609; 
 Mon, 02 Oct 2023 07:41:36 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHsc0+lM5W6cFaLXLaAquJ1UQAfJfc35VW1eH7D5YVF5sQdD8RUtSms1Hwwx/9kpMBLl0yw1Q==
X-Received: by 2002:a05:6e02:1aad:b0:352:61f2:8fd5 with SMTP id
 l13-20020a056e021aad00b0035261f28fd5mr11843350ilv.18.1696257696320; 
 Mon, 02 Oct 2023 07:41:36 -0700 (PDT)
Received: from redhat.com ([38.15.60.12]) by smtp.gmail.com with ESMTPSA id
 d11-20020a056e02050b00b0035259f8041fsm2727402ils.73.2023.10.02.07.41.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Oct 2023 07:41:35 -0700 (PDT)
Date: Mon, 2 Oct 2023 08:41:34 -0600
From: Alex Williamson <alex.williamson@redhat.com>
To: =?UTF-8?B?Q8OpZHJpYw==?= Le Goater <clg@redhat.com>
Cc: marcandre.lureau@redhat.com, qemu-devel@nongnu.org, kraxel@redhat.com,
 lersek@redhat.com, Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH v2 4/5] ramfb: make migration conditional
Message-ID: <20231002084134.22fee251.alex.williamson@redhat.com>
In-Reply-To: <f0e4b89b-b88b-edfa-7855-fa41d5c72b69@redhat.com>
References: <20231002111154.1002655-1-marcandre.lureau@redhat.com>
 <20231002111154.1002655-5-marcandre.lureau@redhat.com>
 <f0e4b89b-b88b-edfa-7855-fa41d5c72b69@redhat.com>
Organization: Red Hat
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=alex.williamson@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

On Mon, 2 Oct 2023 15:38:10 +0200
C=C3=A9dric Le Goater <clg@redhat.com> wrote:

> On 10/2/23 13:11, marcandre.lureau@redhat.com wrote:
> > From: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> >=20
> > RAMFB migration was unsupported until now, let's make it conditional.
> > The following patch will prevent machines <=3D 8.1 to migrate it.
> >=20
> > Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com> =20
> Maybe localize the new 'ramfb_migrate' attribute close to 'enable_ramfb'
> in VFIOPCIDevice. Anyhow,

Shouldn't this actually be tied to whether the device is migratable
(which for GVT-g - the only ramfb user afaik - it's not)?  What does it
mean to have a ramfb-migrate=3Dtrue property on a device that doesn't
support migration, or false on a device that does support migration.  I
don't understand why this is a user controllable property.  Thanks,

Alex

> > ---
> >   hw/vfio/pci.h                 | 1 +
> >   include/hw/display/ramfb.h    | 2 +-
> >   hw/display/ramfb-standalone.c | 8 +++++++-
> >   hw/display/ramfb.c            | 6 ++++--
> >   hw/vfio/display.c             | 4 ++--
> >   hw/vfio/pci.c                 | 1 +
> >   stubs/ramfb.c                 | 2 +-
> >   7 files changed, 17 insertions(+), 7 deletions(-)
> >=20
> > diff --git a/hw/vfio/pci.h b/hw/vfio/pci.h
> > index 2d836093a8..671cc78912 100644
> > --- a/hw/vfio/pci.h
> > +++ b/hw/vfio/pci.h
> > @@ -156,6 +156,7 @@ struct VFIOPCIDevice {
> >       OnOffAuto display;
> >       uint32_t display_xres;
> >       uint32_t display_yres;
> > +    bool ramfb_migrate;
> >       int32_t bootindex;
> >       uint32_t igd_gms;
> >       OffAutoPCIBAR msix_relo;
> > diff --git a/include/hw/display/ramfb.h b/include/hw/display/ramfb.h
> > index b33a2c467b..40063b62bd 100644
> > --- a/include/hw/display/ramfb.h
> > +++ b/include/hw/display/ramfb.h
> > @@ -4,7 +4,7 @@
> >   /* ramfb.c */
> >   typedef struct RAMFBState RAMFBState;
> >   void ramfb_display_update(QemuConsole *con, RAMFBState *s);
> > -RAMFBState *ramfb_setup(Error **errp);
> > +RAMFBState *ramfb_setup(bool migrate, Error **errp);
> >  =20
> >   /* ramfb-standalone.c */
> >   #define TYPE_RAMFB_DEVICE "ramfb"
> > diff --git a/hw/display/ramfb-standalone.c b/hw/display/ramfb-standalon=
e.c
> > index 8c0094397f..6bbd69ccdf 100644
> > --- a/hw/display/ramfb-standalone.c
> > +++ b/hw/display/ramfb-standalone.c
> > @@ -15,6 +15,7 @@ struct RAMFBStandaloneState {
> >       SysBusDevice parent_obj;
> >       QemuConsole *con;
> >       RAMFBState *state;
> > +    bool migrate;
> >   };
> >  =20
> >   static void display_update_wrapper(void *dev)
> > @@ -37,9 +38,13 @@ static void ramfb_realizefn(DeviceState *dev, Error =
**errp)
> >       RAMFBStandaloneState *ramfb =3D RAMFB(dev);
> >  =20
> >       ramfb->con =3D graphic_console_init(dev, 0, &wrapper_ops, dev);
> > -    ramfb->state =3D ramfb_setup(errp);
> > +    ramfb->state =3D ramfb_setup(ramfb->migrate, errp);
> >   }
> >  =20
> > +static Property ramfb_properties[] =3D {
> > +    DEFINE_PROP_BOOL("migrate", RAMFBStandaloneState, migrate,  true),
> > +    DEFINE_PROP_END_OF_LIST(),
> > +};
> >   static void ramfb_class_initfn(ObjectClass *klass, void *data)
> >   {
> >       DeviceClass *dc =3D DEVICE_CLASS(klass);
> > @@ -48,6 +53,7 @@ static void ramfb_class_initfn(ObjectClass *klass, vo=
id *data)
> >       dc->realize =3D ramfb_realizefn;
> >       dc->desc =3D "ram framebuffer standalone device";
> >       dc->user_creatable =3D true;
> > +    device_class_set_props(dc, ramfb_properties);
> >   }
> >  =20
> >   static const TypeInfo ramfb_info =3D {
> > diff --git a/hw/display/ramfb.c b/hw/display/ramfb.c
> > index 4aaaa7d653..73e08d605f 100644
> > --- a/hw/display/ramfb.c
> > +++ b/hw/display/ramfb.c
> > @@ -135,7 +135,7 @@ static const VMStateDescription vmstate_ramfb =3D {
> >       }
> >   };
> >  =20
> > -RAMFBState *ramfb_setup(Error **errp)
> > +RAMFBState *ramfb_setup(bool migrate, Error **errp)
> >   {
> >       FWCfgState *fw_cfg =3D fw_cfg_find();
> >       RAMFBState *s;
> > @@ -147,7 +147,9 @@ RAMFBState *ramfb_setup(Error **errp)
> >  =20
> >       s =3D g_new0(RAMFBState, 1);
> >  =20
> > -    vmstate_register(NULL, 0, &vmstate_ramfb, s);
> > +    if (migrate) {
> > +        vmstate_register(NULL, 0, &vmstate_ramfb, s);
> > +    }
> >       rom_add_vga("vgabios-ramfb.bin");
> >       fw_cfg_add_file_callback(fw_cfg, "etc/ramfb",
> >                                NULL, ramfb_fw_cfg_write, s,
> > diff --git a/hw/vfio/display.c b/hw/vfio/display.c
> > index bec864f482..3f6b251ccd 100644
> > --- a/hw/vfio/display.c
> > +++ b/hw/vfio/display.c
> > @@ -356,7 +356,7 @@ static int vfio_display_dmabuf_init(VFIOPCIDevice *=
vdev, Error **errp)
> >                                             &vfio_display_dmabuf_ops,
> >                                             vdev);
> >       if (vdev->enable_ramfb) {
> > -        vdev->dpy->ramfb =3D ramfb_setup(errp);
> > +        vdev->dpy->ramfb =3D ramfb_setup(vdev->ramfb_migrate, errp);
> >       }
> >       vfio_display_edid_init(vdev);
> >       return 0;
> > @@ -483,7 +483,7 @@ static int vfio_display_region_init(VFIOPCIDevice *=
vdev, Error **errp)
> >                                             &vfio_display_region_ops,
> >                                             vdev);
> >       if (vdev->enable_ramfb) {
> > -        vdev->dpy->ramfb =3D ramfb_setup(errp);
> > +        vdev->dpy->ramfb =3D ramfb_setup(vdev->ramfb_migrate, errp);
> >       }
> >       return 0;
> >   }
> > diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
> > index 3b2ca3c24c..6575b8f32d 100644
> > --- a/hw/vfio/pci.c
> > +++ b/hw/vfio/pci.c
> > @@ -3484,6 +3484,7 @@ static const TypeInfo vfio_pci_dev_info =3D {
> >  =20
> >   static Property vfio_pci_dev_nohotplug_properties[] =3D {
> >       DEFINE_PROP_BOOL("ramfb", VFIOPCIDevice, enable_ramfb, false),
> > +    DEFINE_PROP_BOOL("ramfb-migrate", VFIOPCIDevice, ramfb_migrate,  t=
rue),
> >       DEFINE_PROP_END_OF_LIST(),
> >   };
> >  =20
> > diff --git a/stubs/ramfb.c b/stubs/ramfb.c
> > index 48143f3354..8869a5db09 100644
> > --- a/stubs/ramfb.c
> > +++ b/stubs/ramfb.c
> > @@ -6,7 +6,7 @@ void ramfb_display_update(QemuConsole *con, RAMFBState =
*s)
> >   {
> >   }
> >  =20
> > -RAMFBState *ramfb_setup(Error **errp)
> > +RAMFBState *ramfb_setup(bool migrate, Error **errp)
> >   {
> >       error_setg(errp, "ramfb support not available");
> >       return NULL; =20
>=20



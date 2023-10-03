Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DA30C7B66BC
	for <lists+qemu-devel@lfdr.de>; Tue,  3 Oct 2023 12:49:11 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qncwZ-00031C-1j; Tue, 03 Oct 2023 06:47:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1qncwX-0002z8-5B
 for qemu-devel@nongnu.org; Tue, 03 Oct 2023 06:47:57 -0400
Received: from mail-qt1-x832.google.com ([2607:f8b0:4864:20::832])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1qncwV-0001vM-Gb
 for qemu-devel@nongnu.org; Tue, 03 Oct 2023 06:47:56 -0400
Received: by mail-qt1-x832.google.com with SMTP id
 d75a77b69052e-41517088479so24364081cf.1
 for <qemu-devel@nongnu.org>; Tue, 03 Oct 2023 03:47:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1696330074; x=1696934874; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HKOznQ+rlBkDAM03Paol71OYGLN6rxAm3HvstM8nrzs=;
 b=jvCPiqLhwsporV6FUlAscCfE8qDVFTEg14XOBr1oMWyv52njpmQ1L92fiLM1cXT235
 PgAZR+furGWq8bS8GEmFEWHelGdpNB9dyaIAOS50GU5lho3z7c8uOoptFq4srCDtLmoy
 8S9fv5S5b3gNt8c7DhySJsGA1KG0g354VdaJ5o2HpPVeZcV1KYi42jOmJImf1QREOSRj
 5a2Vuw86AOr1JJSHVGdnoi0EkFoLDGPzwGtyJBdTwGmo7ea+nprFIK5osJuhnlNPp7Jl
 Pc4XkPRtgYsV0WRdsDPYZkU8KoeV/S7saIfnvNoKivEqn8FiVCmN9GblXl5tz+9vzKnt
 yX+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696330074; x=1696934874;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=HKOznQ+rlBkDAM03Paol71OYGLN6rxAm3HvstM8nrzs=;
 b=mr6cfyCHFCSPRJhmvYR5f5LxBFW0n/YtdwxftvMbha1jXPtZ6eJEVJnd+iZpHpdoHF
 jMbqqV3wDYKs7liL4Ai7kvDUP8PL9RRvtU3Yj7xtqhOKtlqnBb5g3UslkfQWDFIqC9/5
 N9NsoljOnG1nmVvqVPVtbkPDaLGzaxZDoDMQBNU+3X4uZz76PlNKXBWLyf/H0Ov9lSek
 3SyB7WX8y2MdHgi3mvsISFP57HUtr17Hmf7uO9h46bQAQ2Uk/UPmlXYzFXHMdGSCDbdY
 bzrG99bgqzV3s9ISQ9ME95h6cimlNN8rReM9ze/XKTfkkjFp427amaETfOopM8ahNkqj
 LBDw==
X-Gm-Message-State: AOJu0YyDC2unA0yrMoBTxmpXFEAgvMsLUywyhsG+Fei8ck5wLB4bQqGc
 QRKbuZj64nKxlWMgsb2kYnJlJZ7GrDUb9MslrCQ=
X-Google-Smtp-Source: AGHT+IEWqSYN+aBFm6BvhsW0ULYjK95ra8YMNbWzmlImZfyRtJeZEmL8u2H0JNQlVgFhmlzQ+/wp4eQLJPB44cPfb2g=
X-Received: by 2002:a05:622a:1883:b0:417:b06f:6103 with SMTP id
 v3-20020a05622a188300b00417b06f6103mr2437620qtc.21.1696330074288; Tue, 03 Oct
 2023 03:47:54 -0700 (PDT)
MIME-Version: 1.0
References: <20231003085644.1220326-1-marcandre.lureau@redhat.com>
 <20231003085644.1220326-6-marcandre.lureau@redhat.com>
 <7df9e19a-4ead-516c-21b3-04d8e899d7e7@redhat.com>
In-Reply-To: <7df9e19a-4ead-516c-21b3-04d8e899d7e7@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Tue, 3 Oct 2023 14:47:42 +0400
Message-ID: <CAJ+F1C+=5uUjdO-DY9iAR0zL+XoPmY7NBjgV3AwvJV6sRqTGfQ@mail.gmail.com>
Subject: Re: [PATCH v3 5/5] hw/vfio: add ramfb migration support
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Cc: qemu-devel@nongnu.org, Alex Williamson <alex.williamson@redhat.com>,
 lersek@redhat.com, 
 kraxel@redhat.com, Eduardo Habkost <eduardo@habkost.net>, 
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Yanan Wang <wangyanan55@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::832;
 envelope-from=marcandre.lureau@gmail.com; helo=mail-qt1-x832.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Hi

On Tue, Oct 3, 2023 at 2:17=E2=80=AFPM C=C3=A9dric Le Goater <clg@redhat.co=
m> wrote:
>
> On 10/3/23 10:56, marcandre.lureau@redhat.com wrote:
> > From: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> >
> > Add a "VFIODisplay" subsection whenever "x-ramfb-migrate" is turned on.
> >
> > Turn it off by default on machines <=3D 8.1 for compatibility reasons.
>
>
> This change breaks linking on various platforms with :
>
> /usr/bin/ld: libqemu-xtensa-softmmu.fa.p/hw_vfio_display.c.o:(.data.rel+0=
x50): undefined reference to `ramfb_vmstate'
>
> Some stubs updates are missing it seems..
>

diff --git a/stubs/ramfb.c b/stubs/ramfb.c
index 48143f3354..cf64733b10 100644
--- a/stubs/ramfb.c
+++ b/stubs/ramfb.c
@@ -2,6 +2,8 @@
 #include "qapi/error.h"
 #include "hw/display/ramfb.h"

+const VMStateDescription ramfb_vmstate =3D {};
+


And I think we should also change the "needed" condition to:

diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
index 4689f2e5c1..b327844764 100644
--- a/hw/vfio/pci.c
+++ b/hw/vfio/pci.c
@@ -2613,7 +2613,7 @@ static bool vfio_display_needed(void *opaque)
     VFIOPCIDevice *vdev =3D opaque;

     /* the only thing that justifies the VFIODisplay sub-section atm */
-    return vdev->ramfb_migrate !=3D ON_OFF_AUTO_OFF;
+    return vdev->enable_ramfb && vdev->ramfb_migrate !=3D ON_OFF_AUTO_OFF;
 }



> Thanks,
>
> C.
>
> >
> > Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> > ---
> >   hw/vfio/pci.h     |  3 +++
> >   hw/core/machine.c |  1 +
> >   hw/vfio/display.c | 23 +++++++++++++++++++++++
> >   hw/vfio/pci.c     | 32 ++++++++++++++++++++++++++++++++
> >   4 files changed, 59 insertions(+)
> >
> > diff --git a/hw/vfio/pci.h b/hw/vfio/pci.h
> > index 2d836093a8..fd06695542 100644
> > --- a/hw/vfio/pci.h
> > +++ b/hw/vfio/pci.h
> > @@ -173,6 +173,7 @@ struct VFIOPCIDevice {
> >       bool no_kvm_ioeventfd;
> >       bool no_vfio_ioeventfd;
> >       bool enable_ramfb;
> > +    OnOffAuto ramfb_migrate;
> >       bool defer_kvm_irq_routing;
> >       bool clear_parent_atomics_on_exit;
> >       VFIODisplay *dpy;
> > @@ -226,4 +227,6 @@ void vfio_display_reset(VFIOPCIDevice *vdev);
> >   int vfio_display_probe(VFIOPCIDevice *vdev, Error **errp);
> >   void vfio_display_finalize(VFIOPCIDevice *vdev);
> >
> > +extern const VMStateDescription vfio_display_vmstate;
> > +
> >   #endif /* HW_VFIO_VFIO_PCI_H */
> > diff --git a/hw/core/machine.c b/hw/core/machine.c
> > index 47a07d1d9b..f2f8940a85 100644
> > --- a/hw/core/machine.c
> > +++ b/hw/core/machine.c
> > @@ -32,6 +32,7 @@
> >
> >   GlobalProperty hw_compat_8_1[] =3D {
> >       { "ramfb", "x-migrate", "off" },
> > +    { "vfio-pci-nohotplug", "x-ramfb-migrate", "off" }
> >   };
> >   const size_t hw_compat_8_1_len =3D G_N_ELEMENTS(hw_compat_8_1);
> >
> > diff --git a/hw/vfio/display.c b/hw/vfio/display.c
> > index bec864f482..de5bf71dd1 100644
> > --- a/hw/vfio/display.c
> > +++ b/hw/vfio/display.c
> > @@ -542,3 +542,26 @@ void vfio_display_finalize(VFIOPCIDevice *vdev)
> >       vfio_display_edid_exit(vdev->dpy);
> >       g_free(vdev->dpy);
> >   }
> > +
> > +static bool migrate_needed(void *opaque)
> > +{
> > +    /*
> > +     * If we are here, it's because vfio_display_needed(), which is on=
ly true
> > +     * when dpy->ramfb_migrate atm.
> > +     *
> > +     * If the migration condition is changed, we should check here if
> > +     * ramfb_migrate is true. (this will need a way to lookup the asso=
ciated
> > +     * VFIOPCIDevice somehow, or fields to be moved, ..)
> > +     */
> > +    return true;
> > +}
> > +
> > +const VMStateDescription vfio_display_vmstate =3D {
> > +    .name =3D "VFIODisplay",
> > +    .version_id =3D 1,
> > +    .minimum_version_id =3D 1,
> > +    .needed =3D migrate_needed,
> > +    .fields =3D (VMStateField[]) {
> > +        VMSTATE_STRUCT_POINTER(ramfb, VFIODisplay, ramfb_vmstate, RAMF=
BState),
> > +    }
> > +};
> > diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
> > index 3b2ca3c24c..4689f2e5c1 100644
> > --- a/hw/vfio/pci.c
> > +++ b/hw/vfio/pci.c
> > @@ -2608,6 +2608,25 @@ static bool vfio_msix_present(void *opaque, int =
version_id)
> >       return msix_present(pdev);
> >   }
> >
> > +static bool vfio_display_needed(void *opaque)
> > +{
> > +    VFIOPCIDevice *vdev =3D opaque;
> > +
> > +    /* the only thing that justifies the VFIODisplay sub-section atm *=
/
> > +    return vdev->ramfb_migrate !=3D ON_OFF_AUTO_OFF;
> > +}
> > +
> > +const VMStateDescription vmstate_vfio_display =3D {
> > +    .name =3D "VFIOPCIDevice/VFIODisplay",
> > +    .version_id =3D 1,
> > +    .minimum_version_id =3D 1,
> > +    .needed =3D vfio_display_needed,
> > +    .fields =3D (VMStateField[]){
> > +        VMSTATE_STRUCT_POINTER(dpy, VFIOPCIDevice, vfio_display_vmstat=
e, VFIODisplay),
> > +        VMSTATE_END_OF_LIST()
> > +    }
> > +};
> > +
> >   const VMStateDescription vmstate_vfio_pci_config =3D {
> >       .name =3D "VFIOPCIDevice",
> >       .version_id =3D 1,
> > @@ -2616,6 +2635,10 @@ const VMStateDescription vmstate_vfio_pci_config=
 =3D {
> >           VMSTATE_PCI_DEVICE(pdev, VFIOPCIDevice),
> >           VMSTATE_MSIX_TEST(pdev, VFIOPCIDevice, vfio_msix_present),
> >           VMSTATE_END_OF_LIST()
> > +    },
> > +    .subsections =3D (const VMStateDescription*[]) {
> > +        &vmstate_vfio_display,
> > +        NULL
> >       }
> >   };
> >
> > @@ -3275,6 +3298,14 @@ static void vfio_realize(PCIDevice *pdev, Error =
**errp)
> >           if (!vfio_migration_realize(vbasedev, errp)) {
> >               goto out_deregister;
> >           }
> > +        if (vbasedev->enable_migration =3D=3D ON_OFF_AUTO_OFF) {
> > +            if (vdev->ramfb_migrate =3D=3D ON_OFF_AUTO_AUTO) {
> > +                vdev->ramfb_migrate =3D ON_OFF_AUTO_OFF;
> > +            } else if (vdev->ramfb_migrate =3D=3D ON_OFF_AUTO_ON) {
> > +                error_setg(errp, "x-ramfb-migrate requires migration")=
;
> > +                goto out_deregister;
> > +            }
> > +        }
> >       }
> >
> >       vfio_register_err_notifier(vdev);
> > @@ -3484,6 +3515,7 @@ static const TypeInfo vfio_pci_dev_info =3D {
> >
> >   static Property vfio_pci_dev_nohotplug_properties[] =3D {
> >       DEFINE_PROP_BOOL("ramfb", VFIOPCIDevice, enable_ramfb, false),
> > +    DEFINE_PROP_ON_OFF_AUTO("x-ramfb-migrate", VFIOPCIDevice, ramfb_mi=
grate, ON_OFF_AUTO_AUTO),
> >       DEFINE_PROP_END_OF_LIST(),
> >   };
> >
>
>


--=20
Marc-Andr=C3=A9 Lureau


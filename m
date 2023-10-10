Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E61437BF3D1
	for <lists+qemu-devel@lfdr.de>; Tue, 10 Oct 2023 09:09:50 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qq6ra-0001IM-Ep; Tue, 10 Oct 2023 03:09:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1qq6rY-0001Hx-6j
 for qemu-devel@nongnu.org; Tue, 10 Oct 2023 03:09:04 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1qq6rW-0002y2-Gr
 for qemu-devel@nongnu.org; Tue, 10 Oct 2023 03:09:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1696921741;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=CQyYA+v2sBb7zewKQokjp4KWmKmZqiNgk5bgKJYsrZg=;
 b=HPyrszcg86g9LXmE0aOuK3rP2NKyUapRbJ6MYTX3U7YlJp7pMt5hR6wnD7pFjvb3Fmb7Yz
 T8pd8Pc/aJk7gNNk9xE/CCEr+FwvisWQI9T9yvSViZIHJLte8gVRWl0DtOiS+rqvjX3jTp
 cUKjWqqsNqCL8qwAMJBIHpdA6qvtRRI=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-207-0-vVRVUSPeSoAcXQvhSAeQ-1; Tue, 10 Oct 2023 03:08:49 -0400
X-MC-Unique: 0-vVRVUSPeSoAcXQvhSAeQ-1
Received: by mail-ed1-f71.google.com with SMTP id
 4fb4d7f45d1cf-50daa85e940so4112430a12.0
 for <qemu-devel@nongnu.org>; Tue, 10 Oct 2023 00:08:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696921728; x=1697526528;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=CQyYA+v2sBb7zewKQokjp4KWmKmZqiNgk5bgKJYsrZg=;
 b=O1KNrq7WZNPnGF8PedZlDiwYOVmJhsO+kDKV1iMGamU/QhSjV98CCLV95bCPoGbVQ4
 HyMWj9j6UfIzPIFDEXnJ/VvAZ2WpC+LeU5K5MXQ2T9V8BjQO31+NVz5dTuBmCpmSp6hn
 b+Ww3PV8S1+YFG0Lw8nzgsCKCMWeaOen5mf5BTIksPXYPKrMs6OD3mjf4DHskP3KWFbl
 Ji5hTUpfLOOhHNQgS5MrCuEfwN+PjRuP9aemHL7v6k8T8ID3lu7vXeptVR3abdEGyHDo
 ynKwpuaN6O8WvUcX1kotIVsSP5vLafjiZJ9u8AWkQXLRLNZ86KB1Mws7OKjkvdGbogKx
 8JQA==
X-Gm-Message-State: AOJu0Yw7hpQ/dsaZOWta+2hHzMmiL0U1w0RlviWtfII5ltz9McnkROjt
 DgQdjIo5y+DgHT55riKh+mz45974+d9nIjkI7VBWeCVC5gswpCapad0PVfu2Art1MrgBmiJ2qrV
 mmFqt7DJmhhyDunfahUEmWGJ3UDzdd18=
X-Received: by 2002:a05:6402:c4f:b0:53b:b110:1bd4 with SMTP id
 cs15-20020a0564020c4f00b0053bb1101bd4mr5534066edb.6.1696921727914; 
 Tue, 10 Oct 2023 00:08:47 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEHfjIFB5jtjlqAi8DGbt5YGaC8+bZGiUIgdQNZXVPiPSWgqApZenJ98crDHYZqd3I0TTdihUs34KXWdgbDw7Y=
X-Received: by 2002:a05:6402:c4f:b0:53b:b110:1bd4 with SMTP id
 cs15-20020a0564020c4f00b0053bb1101bd4mr5534044edb.6.1696921727520; Tue, 10
 Oct 2023 00:08:47 -0700 (PDT)
MIME-Version: 1.0
References: <20231009063247.119333-1-marcandre.lureau@redhat.com>
 <20231009063247.119333-4-marcandre.lureau@redhat.com>
 <a9f3a4e4-5084-897c-a9de-df80f5302e76@redhat.com>
 <40e84da6-a8cc-b4ea-4a81-0d0fded690dc@redhat.com>
In-Reply-To: <40e84da6-a8cc-b4ea-4a81-0d0fded690dc@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Date: Tue, 10 Oct 2023 11:08:34 +0400
Message-ID: <CAMxuvawrr40NSwWdQAVML=R+mB2Kb3SFjidF_TZY-0UcSJZr2A@mail.gmail.com>
Subject: Re: [PATCH v5 3/3] hw/vfio: add ramfb migration support
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Cc: Laszlo Ersek <lersek@redhat.com>, qemu-devel@nongnu.org, 
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Yanan Wang <wangyanan55@huawei.com>,
 Alex Williamson <alex.williamson@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mlureau@redhat.com;
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

Hi

On Tue, Oct 10, 2023 at 11:03=E2=80=AFAM C=C3=A9dric Le Goater <clg@redhat.=
com> wrote:
>
> On 10/9/23 12:19, Laszlo Ersek wrote:
> > On 10/9/23 08:32, marcandre.lureau@redhat.com wrote:
> >> From: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> >>
> >> Add a "VFIODisplay" subsection whenever "x-ramfb-migrate" is turned on=
.
> >>
> >> Turn it off by default on machines <=3D 8.1 for compatibility reasons.
> >>
> >> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> >> Reviewed-by: Laszlo Ersek <lersek@redhat.com>
> >> ---
> >>   hw/vfio/pci.h     |  3 +++
> >>   hw/core/machine.c |  1 +
> >>   hw/vfio/display.c | 21 +++++++++++++++++++++
> >>   hw/vfio/pci.c     | 44 ++++++++++++++++++++++++++++++++++++++++++++
> >>   stubs/ramfb.c     |  2 ++
> >>   5 files changed, 71 insertions(+)
> >>
> >> diff --git a/hw/vfio/pci.h b/hw/vfio/pci.h
> >> index 2d836093a8..fd06695542 100644
> >> --- a/hw/vfio/pci.h
> >> +++ b/hw/vfio/pci.h
> >> @@ -173,6 +173,7 @@ struct VFIOPCIDevice {
> >>       bool no_kvm_ioeventfd;
> >>       bool no_vfio_ioeventfd;
> >>       bool enable_ramfb;
> >> +    OnOffAuto ramfb_migrate;
> >>       bool defer_kvm_irq_routing;
> >>       bool clear_parent_atomics_on_exit;
> >>       VFIODisplay *dpy;
> >> @@ -226,4 +227,6 @@ void vfio_display_reset(VFIOPCIDevice *vdev);
> >>   int vfio_display_probe(VFIOPCIDevice *vdev, Error **errp);
> >>   void vfio_display_finalize(VFIOPCIDevice *vdev);
> >>
> >> +extern const VMStateDescription vfio_display_vmstate;
> >> +
> >>   #endif /* HW_VFIO_VFIO_PCI_H */
> >> diff --git a/hw/core/machine.c b/hw/core/machine.c
> >> index 6305f2d7a4..05aef2cf9f 100644
> >> --- a/hw/core/machine.c
> >> +++ b/hw/core/machine.c
> >> @@ -35,6 +35,7 @@
> >>   GlobalProperty hw_compat_8_1[] =3D {
> >>       { TYPE_PCI_BRIDGE, "x-pci-express-writeable-slt-bug", "true" },
> >>       { "ramfb", "x-migrate", "off" },
> >> +    { "vfio-pci-nohotplug", "x-ramfb-migrate", "off" }
> >>   };
> >>   const size_t hw_compat_8_1_len =3D G_N_ELEMENTS(hw_compat_8_1);
> >>
> >> diff --git a/hw/vfio/display.c b/hw/vfio/display.c
> >> index bec864f482..2739ba56ec 100644
> >> --- a/hw/vfio/display.c
> >> +++ b/hw/vfio/display.c
> >> @@ -542,3 +542,24 @@ void vfio_display_finalize(VFIOPCIDevice *vdev)
> >>       vfio_display_edid_exit(vdev->dpy);
> >>       g_free(vdev->dpy);
> >>   }
> >> +
> >> +static bool migrate_needed(void *opaque)
> >> +{
> >> +    VFIODisplay *dpy =3D opaque;
> >> +    bool ramfb_exists =3D dpy->ramfb !=3D NULL;
> >> +
> >> +    /* see vfio_display_migration_needed() */
> >> +    assert(ramfb_exists);
> >> +    return ramfb_exists;
> >> +}
> >> +
> >> +const VMStateDescription vfio_display_vmstate =3D {
> >> +    .name =3D "VFIODisplay",
> >> +    .version_id =3D 1,
> >> +    .minimum_version_id =3D 1,
> >> +    .needed =3D migrate_needed,
> >> +    .fields =3D (VMStateField[]) {
> >> +        VMSTATE_STRUCT_POINTER(ramfb, VFIODisplay, ramfb_vmstate, RAM=
FBState),
> >> +        VMSTATE_END_OF_LIST(),
> >> +    }
> >> +};
> >> diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
> >> index 3b2ca3c24c..e44ed21180 100644
> >> --- a/hw/vfio/pci.c
> >> +++ b/hw/vfio/pci.c
> >> @@ -2608,6 +2608,32 @@ static bool vfio_msix_present(void *opaque, int=
 version_id)
> >>       return msix_present(pdev);
> >>   }
> >>
> >> +static bool vfio_display_migration_needed(void *opaque)
> >> +{
> >> +    VFIOPCIDevice *vdev =3D opaque;
> >> +
> >> +    /*
> >> +     * We need to migrate the VFIODisplay object if ramfb *migration*=
 was
> >> +     * explicitly requested (in which case we enforced both ramfb=3Do=
n and
> >> +     * display=3Don), or ramfb migration was left at the default "aut=
o"
> >> +     * setting, and *ramfb* was explicitly requested (in which case w=
e
> >> +     * enforced display=3Don).
> >> +     */
> >> +    return vdev->ramfb_migrate =3D=3D ON_OFF_AUTO_ON ||
> >> +        (vdev->ramfb_migrate =3D=3D ON_OFF_AUTO_AUTO && vdev->enable_=
ramfb);
> >> +}
> >> +
> >> +const VMStateDescription vmstate_vfio_display =3D {
> >> +    .name =3D "VFIOPCIDevice/VFIODisplay",
> >> +    .version_id =3D 1,
> >> +    .minimum_version_id =3D 1,
> >> +    .needed =3D vfio_display_migration_needed,
> >> +    .fields =3D (VMStateField[]){
> >> +        VMSTATE_STRUCT_POINTER(dpy, VFIOPCIDevice, vfio_display_vmsta=
te, VFIODisplay),
> >> +        VMSTATE_END_OF_LIST()
> >> +    }
> >> +};
> >> +
> >>   const VMStateDescription vmstate_vfio_pci_config =3D {
> >>       .name =3D "VFIOPCIDevice",
> >>       .version_id =3D 1,
> >> @@ -2616,6 +2642,10 @@ const VMStateDescription vmstate_vfio_pci_confi=
g =3D {
> >>           VMSTATE_PCI_DEVICE(pdev, VFIOPCIDevice),
> >>           VMSTATE_MSIX_TEST(pdev, VFIOPCIDevice, vfio_msix_present),
> >>           VMSTATE_END_OF_LIST()
> >> +    },
> >> +    .subsections =3D (const VMStateDescription*[]) {
> >> +        &vmstate_vfio_display,
> >> +        NULL
> >>       }
> >>   };
> >>
> >> @@ -3271,6 +3301,19 @@ static void vfio_realize(PCIDevice *pdev, Error=
 **errp)
> >>           }
> >>       }
> >>
> >> +    if (vdev->ramfb_migrate =3D=3D ON_OFF_AUTO_ON && !vdev->enable_ra=
mfb) {
> >> +        warn_report("x-ramfb-migrate=3Don but ramfb=3Doff");
> >> +        vdev->ramfb_migrate =3D ON_OFF_AUTO_OFF;
> >
> > the warning could give a hint about the resultant action taken (i.e.,
> > forcing off x-ramfb-migrate), but don't repost just for that; it's a ni=
t.
>
> yes.
>
> How about :
>
>          warn_report("x-ramfb-migrate=3Don but ramfb=3Doff. Forcing x-ram=
fb-migrate to off.");

Sure, that's better.

>
> I can amend the patch if you agree.

 thanks!



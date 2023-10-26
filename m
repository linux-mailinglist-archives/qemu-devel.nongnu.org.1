Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 548817D88D3
	for <lists+qemu-devel@lfdr.de>; Thu, 26 Oct 2023 21:15:46 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qw5np-0008Ds-IT; Thu, 26 Oct 2023 15:13:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.williamson@redhat.com>)
 id 1qw5ni-0008C4-B9
 for qemu-devel@nongnu.org; Thu, 26 Oct 2023 15:13:50 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.williamson@redhat.com>)
 id 1qw5ng-0005co-KQ
 for qemu-devel@nongnu.org; Thu, 26 Oct 2023 15:13:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1698347628;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+pS53aD6Ur4TRLd9kTlFEEf+SjFk9fQpbavdsPCBHZg=;
 b=gBW72T+5F2+qyVSbkWwRxxjChDzrJBMLIUrpvIMbfEggZrEzVw2HasJBBXKbsxdhNAneIz
 WHb5Gv79utQZSlaDbzbFzPcqoGzH/D1gYT4NFqrGSFPa1qgglrZouFjoLtGoHj8E4Oi/TQ
 fWUoel98lhALvp4Hsn/7LVHphlUWdIg=
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com
 [209.85.166.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-636-b-rgRLPmN2-S1_aWAkcXqA-1; Thu, 26 Oct 2023 15:13:45 -0400
X-MC-Unique: b-rgRLPmN2-S1_aWAkcXqA-1
Received: by mail-io1-f71.google.com with SMTP id
 ca18e2360f4ac-7872be95468so104295039f.1
 for <qemu-devel@nongnu.org>; Thu, 26 Oct 2023 12:13:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698347625; x=1698952425;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+pS53aD6Ur4TRLd9kTlFEEf+SjFk9fQpbavdsPCBHZg=;
 b=bYk5awGCmH5fdBH+xP+x4UPRZVB48IR74LQby/Ul1uVk0GWo2pyyKu/kTcEyOZ52a6
 TFR+VKsUnx6C59846mrBAlu9jxF5ccrvOoRMf810ojE42FeVXV2pbkZSVkvWFCo8VPzE
 F4vsWqTfLWSc+glw55qy9CzyfVTCuZ+AuIJIMGIgnJYcQ4xog6las/bfIwkaUotRrykw
 XVwZ9VoNtTl8Dyt2xirYojOIx9m9bmbXqpuODJxAAFoldSYCPw8g7jjHjpSUvAUdmyl0
 SJFLuDe+G5C+BQMSxMeloYgxiszqY74eMZ6u1J5/W5KarzIaAY+tcpXlXRmQOMzoGecT
 BI/Q==
X-Gm-Message-State: AOJu0YwDvOYqqDd6kg+v8B0btliujOFeu7oc3ZX1H545w9iItT+raAeW
 vkAJiHh0XZTiCCI0GrZ7axg42dAjvAz1te8g4zGGLeo+8VAdH6Ke8KGHAjOV/jpDZHOlGzeIi1E
 Bt905cTY0/PBLeWM=
X-Received: by 2002:a05:6602:2e8f:b0:7a9:63ff:29ff with SMTP id
 m15-20020a0566022e8f00b007a963ff29ffmr776062iow.7.1698347624836; 
 Thu, 26 Oct 2023 12:13:44 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG7SFWQjU9znLAl7HvQRTmQlY8Gfj1olgZC717aiGb3AeAYtyMpeobW/fo1/RI7HSecJVvj1A==
X-Received: by 2002:a05:6602:2e8f:b0:7a9:63ff:29ff with SMTP id
 m15-20020a0566022e8f00b007a963ff29ffmr776045iow.7.1698347624492; 
 Thu, 26 Oct 2023 12:13:44 -0700 (PDT)
Received: from redhat.com ([38.15.60.12]) by smtp.gmail.com with ESMTPSA id
 f40-20020a05663832a800b0043194542229sm702528jav.52.2023.10.26.12.13.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Oct 2023 12:13:43 -0700 (PDT)
Date: Thu, 26 Oct 2023 13:13:42 -0600
From: Alex Williamson <alex.williamson@redhat.com>
To: =?UTF-8?B?Q8OpZHJpYw==?= Le Goater <clg@redhat.com>
Cc: qemu-devel@nongnu.org
Subject: Re: [PATCH] vfio/pci: Check return value of vfio_set_irq_signaling()
Message-ID: <20231026131342.25d438da.alex.williamson@redhat.com>
In-Reply-To: <20231026071043.1165994-1-clg@redhat.com>
References: <20231026071043.1165994-1-clg@redhat.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.35; x86_64-redhat-linux-gnu)
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
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Thu, 26 Oct 2023 09:10:43 +0200
C=C3=A9dric Le Goater <clg@redhat.com> wrote:

> and drop warning when ENOTTY is returned. Only useful for the mdev-mtty
> driver today, which has partial support for INTx: the AUTOMASK
> behavior is not implemented.

FWIW, I prefer not to carry a sentence through from subject to commit
log, I find it harder to follow.

Anyway, I'm not sure it's a great idea to suppress this warning.  We
really want drivers to implement the eventfd channel for INTx
unmasking.  I think we're only putting up with it for mtty because it's
a sample driver and it's a step forward versus the botched
implementation of the SET_IRQS ioctl that it previously had.  We could
implement the unmask eventfd channel for mtty, but it might be better
from a test coverage perspective to have it as a driver that forces the
QEMU INTx path to be exercised.

If we suppress this warning, as the de facto userspace driver for vfio
devices, we're declaring it ok to implement INTx without UNMASK eventfd
support when there's no technical reason it couldn't be implemented.

Maybe we should just let QEMU continue to complain about mtty?  Thanks,

Alex

> Signed-off-by: C=C3=A9dric Le Goater <clg@redhat.com>
> ---
>  hw/vfio/pci.c | 46 ++++++++++++++++++++++++++++++----------------
>  1 file changed, 30 insertions(+), 16 deletions(-)
>=20
> diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
> index b27011cee72a0fb3b2d57d297c0b5c2ccff9d9a6..5cbc771e55d83561011785e54=
a38dea042fc834c 100644
> --- a/hw/vfio/pci.c
> +++ b/hw/vfio/pci.c
> @@ -114,15 +114,16 @@ static void vfio_intx_eoi(VFIODevice *vbasedev)
>      vfio_unmask_single_irqindex(vbasedev, VFIO_PCI_INTX_IRQ_INDEX);
>  }
> =20
> -static void vfio_intx_enable_kvm(VFIOPCIDevice *vdev, Error **errp)
> +static int vfio_intx_enable_kvm(VFIOPCIDevice *vdev, Error **errp)
>  {
> +    int ret =3D 0;
>  #ifdef CONFIG_KVM
>      int irq_fd =3D event_notifier_get_fd(&vdev->intx.interrupt);
> =20
>      if (vdev->no_kvm_intx || !kvm_irqfds_enabled() ||
>          vdev->intx.route.mode !=3D PCI_INTX_ENABLED ||
>          !kvm_resamplefds_enabled()) {
> -        return;
> +        return 0;
>      }
> =20
>      /* Get to a known interrupt state */
> @@ -132,23 +133,26 @@ static void vfio_intx_enable_kvm(VFIOPCIDevice *vde=
v, Error **errp)
>      pci_irq_deassert(&vdev->pdev);
> =20
>      /* Get an eventfd for resample/unmask */
> -    if (event_notifier_init(&vdev->intx.unmask, 0)) {
> +    ret =3D event_notifier_init(&vdev->intx.unmask, 0);
> +    if (ret) {
>          error_setg(errp, "event_notifier_init failed eoi");
>          goto fail;
>      }
> =20
> -    if (kvm_irqchip_add_irqfd_notifier_gsi(kvm_state,
> -                                           &vdev->intx.interrupt,
> -                                           &vdev->intx.unmask,
> -                                           vdev->intx.route.irq)) {
> +    ret =3D kvm_irqchip_add_irqfd_notifier_gsi(kvm_state,
> +                                             &vdev->intx.interrupt,
> +                                             &vdev->intx.unmask,
> +                                             vdev->intx.route.irq);
> +    if (ret) {
>          error_setg_errno(errp, errno, "failed to setup resample irqfd");
>          goto fail_irqfd;
>      }
> =20
> -    if (vfio_set_irq_signaling(&vdev->vbasedev, VFIO_PCI_INTX_IRQ_INDEX,=
 0,
> -                               VFIO_IRQ_SET_ACTION_UNMASK,
> -                               event_notifier_get_fd(&vdev->intx.unmask),
> -                               errp)) {
> +    ret =3D vfio_set_irq_signaling(&vdev->vbasedev, VFIO_PCI_INTX_IRQ_IN=
DEX, 0,
> +                                 VFIO_IRQ_SET_ACTION_UNMASK,
> +                                 event_notifier_get_fd(&vdev->intx.unmas=
k),
> +                                 errp);
> +    if (ret) {
>          goto fail_vfio;
>      }
> =20
> @@ -159,7 +163,7 @@ static void vfio_intx_enable_kvm(VFIOPCIDevice *vdev,=
 Error **errp)
> =20
>      trace_vfio_intx_enable_kvm(vdev->vbasedev.name);
> =20
> -    return;
> +    return 0;
> =20
>  fail_vfio:
>      kvm_irqchip_remove_irqfd_notifier_gsi(kvm_state, &vdev->intx.interru=
pt,
> @@ -170,6 +174,7 @@ fail:
>      qemu_set_fd_handler(irq_fd, vfio_intx_interrupt, NULL, vdev);
>      vfio_unmask_single_irqindex(&vdev->vbasedev, VFIO_PCI_INTX_IRQ_INDEX=
);
>  #endif
> +    return ret;
>  }
> =20
>  static void vfio_intx_disable_kvm(VFIOPCIDevice *vdev)
> @@ -212,6 +217,7 @@ static void vfio_intx_disable_kvm(VFIOPCIDevice *vdev)
>  static void vfio_intx_update(VFIOPCIDevice *vdev, PCIINTxRoute *route)
>  {
>      Error *err =3D NULL;
> +    int ret;
> =20
>      trace_vfio_intx_update(vdev->vbasedev.name,
>                             vdev->intx.route.irq, route->irq);
> @@ -224,9 +230,13 @@ static void vfio_intx_update(VFIOPCIDevice *vdev, PC=
IINTxRoute *route)
>          return;
>      }
> =20
> -    vfio_intx_enable_kvm(vdev, &err);
> +    ret =3D vfio_intx_enable_kvm(vdev, &err);
>      if (err) {
> -        warn_reportf_err(err, VFIO_MSG_PREFIX, vdev->vbasedev.name);
> +        if (ret !=3D -ENOTTY) {
> +            warn_reportf_err(err, VFIO_MSG_PREFIX, vdev->vbasedev.name);
> +        } else {
> +            error_free(err);
> +        }
>      }
> =20
>      /* Re-enable the interrupt in cased we missed an EOI */
> @@ -300,9 +310,13 @@ static int vfio_intx_enable(VFIOPCIDevice *vdev, Err=
or **errp)
>          return -errno;
>      }
> =20
> -    vfio_intx_enable_kvm(vdev, &err);
> +    ret =3D vfio_intx_enable_kvm(vdev, &err);
>      if (err) {
> -        warn_reportf_err(err, VFIO_MSG_PREFIX, vdev->vbasedev.name);
> +        if (ret !=3D -ENOTTY) {
> +            warn_reportf_err(err, VFIO_MSG_PREFIX, vdev->vbasedev.name);
> +        } else {
> +            error_free(err);
> +        }
>      }
> =20
>      vdev->interrupt =3D VFIO_INT_INTx;



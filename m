Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E6DA70F098
	for <lists+qemu-devel@lfdr.de>; Wed, 24 May 2023 10:26:07 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q1joM-0007pc-NR; Wed, 24 May 2023 04:25:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1q1joK-0007pQ-H4
 for qemu-devel@nongnu.org; Wed, 24 May 2023 04:25:32 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1q1joI-0006W7-H3
 for qemu-devel@nongnu.org; Wed, 24 May 2023 04:25:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1684916729;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=51/hv/8d6jB4JcSWhhGQAjHy198F+qPbFnpYVRnE4To=;
 b=WwwYIMCVQIms2vO5tzdmnwTgmmod1iO6/BzMygrk9ye764fFt6nvZ4Tw4Ux7XpEmU/Vkm6
 8FK+9pvubu53MJYeCmxXgDEVnOUX+/Klw3t08r1kFLSXJwtY251neKTkxqy/0IkWtCA1/d
 cVuI+RBM4abfFaGwvLdgpoiQDV0gHc8=
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com
 [209.85.208.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-407-ea_1G6zPNJS8eG0QkCMCoQ-1; Wed, 24 May 2023 04:25:28 -0400
X-MC-Unique: ea_1G6zPNJS8eG0QkCMCoQ-1
Received: by mail-lj1-f199.google.com with SMTP id
 38308e7fff4ca-2add1fdcef0so3851691fa.3
 for <qemu-devel@nongnu.org>; Wed, 24 May 2023 01:25:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684916727; x=1687508727;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=51/hv/8d6jB4JcSWhhGQAjHy198F+qPbFnpYVRnE4To=;
 b=fy70uHTjj+GNDQ5dj4ZYVlYpAJbBBWFwEJbycj/LtVZLHUm+jjsjmiFuMRYIFHYnzJ
 X7ryeerCIvGO/FAgYJasykOTaywPwmgyS3I68yrc9b7yTRozHyvxSwQ8z9bK/mbOBQP1
 YsKHy7AQf4TlBWqpwAWgwhXyxQBpV2DU/UC3by1d32XUf+PiB44eocw4u0ZOKC+qfaaK
 qwrEKFK8XyMEF9IY1puApoIOr3Qmi4XF2wP8fdKaisuw3DPrjNEmV9Oh7oX03Lu+6Dqs
 qNV7VjNOukcSERjjBT7YOOoNsUFa2qRXe74+89QqgYX+gy7BpT8ynoUZIRDWXll9cwmN
 4/tg==
X-Gm-Message-State: AC+VfDxwqQEnrt3HaP6UmufdOUuWogeBBepylUGAqdIAxwJ6pcFAVhwg
 Ef5HvsrmGJh/jlENQQscBZe+sukTmVtj2yQ3PmQM0XIN3O2R+Yb+OIZTkOyuyDDJEWnhaD09jSd
 7IKDCbn7Sxnnqdw+aKiMux2MLxm9lCuI=
X-Received: by 2002:a2e:b301:0:b0:2a6:16b5:c658 with SMTP id
 o1-20020a2eb301000000b002a616b5c658mr6255557lja.31.1684916726762; 
 Wed, 24 May 2023 01:25:26 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ426KDHc/NMHta++QZkVQm5vtMAs9wOM/nluMlUG8/2fO+OMSF1l7+gSwT6mu8A8jVcdk8pEB7Zbs+NbwObBvw=
X-Received: by 2002:a2e:b301:0:b0:2a6:16b5:c658 with SMTP id
 o1-20020a2eb301000000b002a616b5c658mr6255548lja.31.1684916726393; Wed, 24 May
 2023 01:25:26 -0700 (PDT)
MIME-Version: 1.0
References: <20230512135122.70403-1-viktor@daynix.com>
 <20230512135122.70403-3-viktor@daynix.com>
 <CACGkMEvYV4jZTjejM04PRtdYPPLwW7JGnBRa3QXeWoizxJqQkw@mail.gmail.com>
 <CAPv0NP52FC-EEd0EFCMTxBj3PxQm3qQ_V+VL1tSu+QG1=Fvw_Q@mail.gmail.com>
In-Reply-To: <CAPv0NP52FC-EEd0EFCMTxBj3PxQm3qQ_V+VL1tSu+QG1=Fvw_Q@mail.gmail.com>
From: Jason Wang <jasowang@redhat.com>
Date: Wed, 24 May 2023 16:25:15 +0800
Message-ID: <CACGkMEvPudbXTaSrB9mqYeNGwK4_ShC+HKUrZojeCVKvXkXDKg@mail.gmail.com>
Subject: Re: [PATCH v3 2/3] vhost: register and change IOMMU flag depending on
 Device-TLB state
To: Viktor Prutyanov <viktor@daynix.com>
Cc: mst@redhat.com, qemu-devel@nongnu.org, yan@daynix.com, 
 yuri.benditovich@daynix.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=jasowang@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Sat, May 20, 2023 at 1:50=E2=80=AFAM Viktor Prutyanov <viktor@daynix.com=
> wrote:
>
> On Thu, May 18, 2023 at 9:14=E2=80=AFAM Jason Wang <jasowang@redhat.com> =
wrote:
> >
> > On Fri, May 12, 2023 at 9:51=E2=80=AFPM Viktor Prutyanov <viktor@daynix=
.com> wrote:
> > >
> > > The guest can disable or never enable Device-TLB. In these cases,
> > > it can't be used even if enabled in QEMU. So, check Device-TLB state
> > > before registering IOMMU notifier and select unmap flag depending on
> > > that. Also, implement a way to change IOMMU notifier flag if Device-T=
LB
> > > state is changed.
> > >
> > > Buglink: https://bugzilla.redhat.com/show_bug.cgi?id=3D2001312
> > > Signed-off-by: Viktor Prutyanov <viktor@daynix.com>
> > > ---
> > >  hw/virtio/vhost-backend.c         |  6 ++++++
> > >  hw/virtio/vhost.c                 | 30 ++++++++++++++++++-----------=
-
> > >  include/hw/virtio/vhost-backend.h |  3 +++
> > >  include/hw/virtio/vhost.h         |  1 +
> > >  4 files changed, 28 insertions(+), 12 deletions(-)
> > >
> > > diff --git a/hw/virtio/vhost-backend.c b/hw/virtio/vhost-backend.c
> > > index 8e581575c9..d39bfefd2d 100644
> > > --- a/hw/virtio/vhost-backend.c
> > > +++ b/hw/virtio/vhost-backend.c
> > > @@ -297,6 +297,11 @@ static void vhost_kernel_set_iotlb_callback(stru=
ct vhost_dev *dev,
> > >          qemu_set_fd_handler((uintptr_t)dev->opaque, NULL, NULL, NULL=
);
> > >  }
> > >
> > > +static void vhost_kernel_toggle_device_iotlb(struct vhost_dev *dev)
> > > +{
> > > +    vhost_toggle_device_iotlb(dev);
> > > +}
> > > +
> > >  const VhostOps kernel_ops =3D {
> > >          .backend_type =3D VHOST_BACKEND_TYPE_KERNEL,
> > >          .vhost_backend_init =3D vhost_kernel_init,
> > > @@ -328,6 +333,7 @@ const VhostOps kernel_ops =3D {
> > >          .vhost_vsock_set_running =3D vhost_kernel_vsock_set_running,
> > >          .vhost_set_iotlb_callback =3D vhost_kernel_set_iotlb_callbac=
k,
> > >          .vhost_send_device_iotlb_msg =3D vhost_kernel_send_device_io=
tlb_msg,
> > > +        .vhost_toggle_device_iotlb =3D vhost_kernel_toggle_device_io=
tlb,
> > >  };
> > >  #endif
> > >
> > > diff --git a/hw/virtio/vhost.c b/hw/virtio/vhost.c
> > > index 746d130c74..41c9fbf286 100644
> > > --- a/hw/virtio/vhost.c
> > > +++ b/hw/virtio/vhost.c
> > > @@ -781,7 +781,6 @@ static void vhost_iommu_region_add(MemoryListener=
 *listener,
> > >      Int128 end;
> > >      int iommu_idx;
> > >      IOMMUMemoryRegion *iommu_mr;
> > > -    int ret;
> > >
> > >      if (!memory_region_is_iommu(section->mr)) {
> > >          return;
> > > @@ -796,7 +795,9 @@ static void vhost_iommu_region_add(MemoryListener=
 *listener,
> > >      iommu_idx =3D memory_region_iommu_attrs_to_index(iommu_mr,
> > >                                                     MEMTXATTRS_UNSPEC=
IFIED);
> > >      iommu_notifier_init(&iommu->n, vhost_iommu_unmap_notify,
> > > -                        IOMMU_NOTIFIER_DEVIOTLB_UNMAP,
> > > +                        dev->vdev->device_iotlb_enabled ?
> > > +                            IOMMU_NOTIFIER_DEVIOTLB_UNMAP :
> > > +                            IOMMU_NOTIFIER_UNMAP,
> > >                          section->offset_within_region,
> > >                          int128_get64(end),
> > >                          iommu_idx);
> > > @@ -804,16 +805,8 @@ static void vhost_iommu_region_add(MemoryListene=
r *listener,
> > >      iommu->iommu_offset =3D section->offset_within_address_space -
> > >                            section->offset_within_region;
> > >      iommu->hdev =3D dev;
> > > -    ret =3D memory_region_register_iommu_notifier(section->mr, &iomm=
u->n, NULL);
> > > -    if (ret) {
> > > -        /*
> > > -         * Some vIOMMUs do not support dev-iotlb yet.  If so, try to=
 use the
> > > -         * UNMAP legacy message
> > > -         */
> > > -        iommu->n.notifier_flags =3D IOMMU_NOTIFIER_UNMAP;
> > > -        memory_region_register_iommu_notifier(section->mr, &iommu->n=
,
> > > -                                              &error_fatal);
> > > -    }
> >
> > So we lose this fallback. Is this really intended?
> >
> > E.g does it work if you are using virtio-iommu?
>
> It works for virtio-iommu because Linux guest doesn't enable PCI ATS in
> this situation. From my point of view, this fallback is not needed
> anymore, because it triggers only if Device-TLB isn't available on the
> host side but the guest misbehaves and tries to enable it.

Ok.

>
> Also, I would like to discuss two more points:
>
> 1. The patch series in its current form will fix the issue for
> vhost+iommu setup for any VirtIO device with any vhost backend when
> ATS is enabled at the beginning. But if ATS is enabled/disabled in the
> runtime it will only work for virtio-net with vhost-kernel. All other
> devices and backends are out of scope and will need to add almost the
> same device_iotlb_toggle and vhost_device_iotlb_toggle handlers. Since
> the issue is general for any device and any backend, is it normal from
> architectural point of view?

Yes, so I think it's better to fix others vhost backends. Actually I
wonder if we can have simply reuse vhost_toggle_device_iotlb() since
it's nothing specific to the vhost backend. It's just about the way to
receive IOTLB invalidation from vIOMMU.

>
> 2. When the series will be applied, we should enable DMA remapping for
> new Windows guest drivers, such as NetKVM. But if the user with enabled
> vhost+iommu updated the driver with old QEMU, the bug would reappear,
> because the guest doesn't know that the fix isn't present. May be we
> should discuss some mechanism to report that host is aware of guest's
> accept/reject of ATS/Device-TLB?

I'm not sure how this can help? Or anything makes this fix different
from other fixes?

One thing I can think is to backport the fixes to -stable.

Thanks

>
> Thanks,
> Viktor Prutyanov
>
> >
> > Thanks
> >
> > > +    memory_region_register_iommu_notifier(section->mr, &iommu->n,
> > > +                                          &error_fatal);
> > >      QLIST_INSERT_HEAD(&dev->iommu_list, iommu, iommu_next);
> > >      /* TODO: can replay help performance here? */
> > >  }
> > > @@ -841,6 +834,19 @@ static void vhost_iommu_region_del(MemoryListene=
r *listener,
> > >      }
> > >  }
> > >
> > > +void vhost_toggle_device_iotlb(struct vhost_dev *dev)
> > > +{
> > > +    struct vhost_iommu *iommu;
> > > +
> > > +    QLIST_FOREACH(iommu, &dev->iommu_list, iommu_next) {
> > > +        memory_region_unregister_iommu_notifier(iommu->mr, &iommu->n=
);
> > > +        iommu->n.notifier_flags =3D dev->vdev->device_iotlb_enabled =
?
> > > +                IOMMU_NOTIFIER_DEVIOTLB_UNMAP : IOMMU_NOTIFIER_UNMAP=
;
> > > +        memory_region_register_iommu_notifier(iommu->mr, &iommu->n,
> > > +                                              &error_fatal);
> > > +    }
> > > +}
> > > +
> > >  static int vhost_virtqueue_set_addr(struct vhost_dev *dev,
> > >                                      struct vhost_virtqueue *vq,
> > >                                      unsigned idx, bool enable_log)
> > > diff --git a/include/hw/virtio/vhost-backend.h b/include/hw/virtio/vh=
ost-backend.h
> > > index ec3fbae58d..10a3c36b4b 100644
> > > --- a/include/hw/virtio/vhost-backend.h
> > > +++ b/include/hw/virtio/vhost-backend.h
> > > @@ -133,6 +133,8 @@ typedef int (*vhost_set_config_call_op)(struct vh=
ost_dev *dev,
> > >
> > >  typedef void (*vhost_reset_status_op)(struct vhost_dev *dev);
> > >
> > > +typedef void (*vhost_toggle_device_iotlb_op)(struct vhost_dev *dev);
> > > +
> > >  typedef struct VhostOps {
> > >      VhostBackendType backend_type;
> > >      vhost_backend_init vhost_backend_init;
> > > @@ -181,6 +183,7 @@ typedef struct VhostOps {
> > >      vhost_force_iommu_op vhost_force_iommu;
> > >      vhost_set_config_call_op vhost_set_config_call;
> > >      vhost_reset_status_op vhost_reset_status;
> > > +    vhost_toggle_device_iotlb_op vhost_toggle_device_iotlb;
> > >  } VhostOps;
> > >
> > >  int vhost_backend_update_device_iotlb(struct vhost_dev *dev,
> > > diff --git a/include/hw/virtio/vhost.h b/include/hw/virtio/vhost.h
> > > index a52f273347..785832ed46 100644
> > > --- a/include/hw/virtio/vhost.h
> > > +++ b/include/hw/virtio/vhost.h
> > > @@ -320,6 +320,7 @@ bool vhost_has_free_slot(void);
> > >  int vhost_net_set_backend(struct vhost_dev *hdev,
> > >                            struct vhost_vring_file *file);
> > >
> > > +void vhost_toggle_device_iotlb(struct vhost_dev *dev);
> > >  int vhost_device_iotlb_miss(struct vhost_dev *dev, uint64_t iova, in=
t write);
> > >
> > >  int vhost_virtqueue_start(struct vhost_dev *dev, struct VirtIODevice=
 *vdev,
> > > --
> > > 2.35.1
> > >
> >
>



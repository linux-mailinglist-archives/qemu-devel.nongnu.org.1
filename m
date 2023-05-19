Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D438709E8F
	for <lists+qemu-devel@lfdr.de>; Fri, 19 May 2023 19:51:16 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q04FA-0005mL-T6; Fri, 19 May 2023 13:50:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <viktor@daynix.com>) id 1q04F7-0005m5-KO
 for qemu-devel@nongnu.org; Fri, 19 May 2023 13:50:18 -0400
Received: from mail-lj1-x22c.google.com ([2a00:1450:4864:20::22c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <viktor@daynix.com>) id 1q04Ew-0004n9-Rf
 for qemu-devel@nongnu.org; Fri, 19 May 2023 13:50:08 -0400
Received: by mail-lj1-x22c.google.com with SMTP id
 38308e7fff4ca-2af24ee004dso11112751fa.0
 for <qemu-devel@nongnu.org>; Fri, 19 May 2023 10:50:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20221208.gappssmtp.com; s=20221208; t=1684518604; x=1687110604;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=WNl6u3G8ySDvhyVfTAyGQfWTpUCy58hn+pwezZ8LUCk=;
 b=PVRAoaWLgDSBrIFgeEydh+3QnruRlKkPhzv4j4ANEb123hjDVZcWQL9soT1dYln1Hp
 V8KCe5lkv1UA8xmIKnLhLGMCjJ023GFeQrx9Kx1rjcx5WVjFNqLNlYaUyAWQphOKxNeQ
 SxvFZwSrOMlUXNVJ3YRRW6kz7TSk2TP/v8mWNzVGOa+fgMd4XyJS+wuQa+LiaiPdw7YZ
 ttO1z1EIy11dGyPKazcU93l138448zYYNW36F5JNIUocoI7KGYxGheupMqmsASlhQGFh
 /Z1nxGlV4idwylEsBGQpM27b0JGP9YZn1Rj/PaiD+/gARLPFaoCvBgWvtPmA005S2lsA
 3qGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684518604; x=1687110604;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=WNl6u3G8ySDvhyVfTAyGQfWTpUCy58hn+pwezZ8LUCk=;
 b=ivheZX+2PxhAIIErqYlODCE7y8jXX0TqoKZ4IXePvILt7w9ixrVqyD9IsVXNORSylZ
 tT6nOTC93IqJR3f2YOlJ3aVqSl+fiaxlzX4rNhfEg5hb2HfX64mH+M4VdwryNeUT2wKj
 YsCaT8JuAqTfcY4C3e4QiyIFXek6TzpvpmpYGveLGjPIiL0O0LinCPNlNjLFlmuG2mKv
 XnScv8T1EBX0ywgqD9Kqbykkjp1rYN0/4d6qNvza0H5Q/UBwcnUocmt5n7mO3e2GRbMf
 F/j8NEj6cMd+NwgmKbT43ynennJ2dx04QyRSOjAyfcqcuaWFYH+C4uTLsmy+Y2l0IC3O
 E2Wg==
X-Gm-Message-State: AC+VfDw+CKObjBKSdFkz+7x/eUq4Nvel560eZD7K3otemLuiYrqHJlKW
 zSgAgz8+jtcgdtdJ80gsa+Yqv62qUIS/yKtB2AG4Kw==
X-Google-Smtp-Source: ACHHUZ4Lqm/zpIny/AcFPjJldK7tbOjHQshLaNEkaT7HAHa9gwK8xBUA0AKGsk8dW9O+En+QDkjOFgP1cne6xGVLQ5M=
X-Received: by 2002:ac2:4c18:0:b0:4dd:9fd8:3a36 with SMTP id
 t24-20020ac24c18000000b004dd9fd83a36mr1079355lfq.1.1684518604054; Fri, 19 May
 2023 10:50:04 -0700 (PDT)
MIME-Version: 1.0
References: <20230512135122.70403-1-viktor@daynix.com>
 <20230512135122.70403-3-viktor@daynix.com>
 <CACGkMEvYV4jZTjejM04PRtdYPPLwW7JGnBRa3QXeWoizxJqQkw@mail.gmail.com>
In-Reply-To: <CACGkMEvYV4jZTjejM04PRtdYPPLwW7JGnBRa3QXeWoizxJqQkw@mail.gmail.com>
From: Viktor Prutyanov <viktor@daynix.com>
Date: Fri, 19 May 2023 20:49:52 +0300
Message-ID: <CAPv0NP52FC-EEd0EFCMTxBj3PxQm3qQ_V+VL1tSu+QG1=Fvw_Q@mail.gmail.com>
Subject: Re: [PATCH v3 2/3] vhost: register and change IOMMU flag depending on
 Device-TLB state
To: Jason Wang <jasowang@redhat.com>
Cc: mst@redhat.com, qemu-devel@nongnu.org, yan@daynix.com, 
 yuri.benditovich@daynix.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: none client-ip=2a00:1450:4864:20::22c;
 envelope-from=viktor@daynix.com; helo=mail-lj1-x22c.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Thu, May 18, 2023 at 9:14=E2=80=AFAM Jason Wang <jasowang@redhat.com> wr=
ote:
>
> On Fri, May 12, 2023 at 9:51=E2=80=AFPM Viktor Prutyanov <viktor@daynix.c=
om> wrote:
> >
> > The guest can disable or never enable Device-TLB. In these cases,
> > it can't be used even if enabled in QEMU. So, check Device-TLB state
> > before registering IOMMU notifier and select unmap flag depending on
> > that. Also, implement a way to change IOMMU notifier flag if Device-TLB
> > state is changed.
> >
> > Buglink: https://bugzilla.redhat.com/show_bug.cgi?id=3D2001312
> > Signed-off-by: Viktor Prutyanov <viktor@daynix.com>
> > ---
> >  hw/virtio/vhost-backend.c         |  6 ++++++
> >  hw/virtio/vhost.c                 | 30 ++++++++++++++++++------------
> >  include/hw/virtio/vhost-backend.h |  3 +++
> >  include/hw/virtio/vhost.h         |  1 +
> >  4 files changed, 28 insertions(+), 12 deletions(-)
> >
> > diff --git a/hw/virtio/vhost-backend.c b/hw/virtio/vhost-backend.c
> > index 8e581575c9..d39bfefd2d 100644
> > --- a/hw/virtio/vhost-backend.c
> > +++ b/hw/virtio/vhost-backend.c
> > @@ -297,6 +297,11 @@ static void vhost_kernel_set_iotlb_callback(struct=
 vhost_dev *dev,
> >          qemu_set_fd_handler((uintptr_t)dev->opaque, NULL, NULL, NULL);
> >  }
> >
> > +static void vhost_kernel_toggle_device_iotlb(struct vhost_dev *dev)
> > +{
> > +    vhost_toggle_device_iotlb(dev);
> > +}
> > +
> >  const VhostOps kernel_ops =3D {
> >          .backend_type =3D VHOST_BACKEND_TYPE_KERNEL,
> >          .vhost_backend_init =3D vhost_kernel_init,
> > @@ -328,6 +333,7 @@ const VhostOps kernel_ops =3D {
> >          .vhost_vsock_set_running =3D vhost_kernel_vsock_set_running,
> >          .vhost_set_iotlb_callback =3D vhost_kernel_set_iotlb_callback,
> >          .vhost_send_device_iotlb_msg =3D vhost_kernel_send_device_iotl=
b_msg,
> > +        .vhost_toggle_device_iotlb =3D vhost_kernel_toggle_device_iotl=
b,
> >  };
> >  #endif
> >
> > diff --git a/hw/virtio/vhost.c b/hw/virtio/vhost.c
> > index 746d130c74..41c9fbf286 100644
> > --- a/hw/virtio/vhost.c
> > +++ b/hw/virtio/vhost.c
> > @@ -781,7 +781,6 @@ static void vhost_iommu_region_add(MemoryListener *=
listener,
> >      Int128 end;
> >      int iommu_idx;
> >      IOMMUMemoryRegion *iommu_mr;
> > -    int ret;
> >
> >      if (!memory_region_is_iommu(section->mr)) {
> >          return;
> > @@ -796,7 +795,9 @@ static void vhost_iommu_region_add(MemoryListener *=
listener,
> >      iommu_idx =3D memory_region_iommu_attrs_to_index(iommu_mr,
> >                                                     MEMTXATTRS_UNSPECIF=
IED);
> >      iommu_notifier_init(&iommu->n, vhost_iommu_unmap_notify,
> > -                        IOMMU_NOTIFIER_DEVIOTLB_UNMAP,
> > +                        dev->vdev->device_iotlb_enabled ?
> > +                            IOMMU_NOTIFIER_DEVIOTLB_UNMAP :
> > +                            IOMMU_NOTIFIER_UNMAP,
> >                          section->offset_within_region,
> >                          int128_get64(end),
> >                          iommu_idx);
> > @@ -804,16 +805,8 @@ static void vhost_iommu_region_add(MemoryListener =
*listener,
> >      iommu->iommu_offset =3D section->offset_within_address_space -
> >                            section->offset_within_region;
> >      iommu->hdev =3D dev;
> > -    ret =3D memory_region_register_iommu_notifier(section->mr, &iommu-=
>n, NULL);
> > -    if (ret) {
> > -        /*
> > -         * Some vIOMMUs do not support dev-iotlb yet.  If so, try to u=
se the
> > -         * UNMAP legacy message
> > -         */
> > -        iommu->n.notifier_flags =3D IOMMU_NOTIFIER_UNMAP;
> > -        memory_region_register_iommu_notifier(section->mr, &iommu->n,
> > -                                              &error_fatal);
> > -    }
>
> So we lose this fallback. Is this really intended?
>
> E.g does it work if you are using virtio-iommu?

It works for virtio-iommu because Linux guest doesn't enable PCI ATS in
this situation. From my point of view, this fallback is not needed
anymore, because it triggers only if Device-TLB isn't available on the
host side but the guest misbehaves and tries to enable it.

Also, I would like to discuss two more points:

1. The patch series in its current form will fix the issue for
vhost+iommu setup for any VirtIO device with any vhost backend when
ATS is enabled at the beginning. But if ATS is enabled/disabled in the
runtime it will only work for virtio-net with vhost-kernel. All other
devices and backends are out of scope and will need to add almost the
same device_iotlb_toggle and vhost_device_iotlb_toggle handlers. Since
the issue is general for any device and any backend, is it normal from
architectural point of view?

2. When the series will be applied, we should enable DMA remapping for
new Windows guest drivers, such as NetKVM. But if the user with enabled
vhost+iommu updated the driver with old QEMU, the bug would reappear,
because the guest doesn't know that the fix isn't present. May be we
should discuss some mechanism to report that host is aware of guest's
accept/reject of ATS/Device-TLB?

Thanks,
Viktor Prutyanov

>
> Thanks
>
> > +    memory_region_register_iommu_notifier(section->mr, &iommu->n,
> > +                                          &error_fatal);
> >      QLIST_INSERT_HEAD(&dev->iommu_list, iommu, iommu_next);
> >      /* TODO: can replay help performance here? */
> >  }
> > @@ -841,6 +834,19 @@ static void vhost_iommu_region_del(MemoryListener =
*listener,
> >      }
> >  }
> >
> > +void vhost_toggle_device_iotlb(struct vhost_dev *dev)
> > +{
> > +    struct vhost_iommu *iommu;
> > +
> > +    QLIST_FOREACH(iommu, &dev->iommu_list, iommu_next) {
> > +        memory_region_unregister_iommu_notifier(iommu->mr, &iommu->n);
> > +        iommu->n.notifier_flags =3D dev->vdev->device_iotlb_enabled ?
> > +                IOMMU_NOTIFIER_DEVIOTLB_UNMAP : IOMMU_NOTIFIER_UNMAP;
> > +        memory_region_register_iommu_notifier(iommu->mr, &iommu->n,
> > +                                              &error_fatal);
> > +    }
> > +}
> > +
> >  static int vhost_virtqueue_set_addr(struct vhost_dev *dev,
> >                                      struct vhost_virtqueue *vq,
> >                                      unsigned idx, bool enable_log)
> > diff --git a/include/hw/virtio/vhost-backend.h b/include/hw/virtio/vhos=
t-backend.h
> > index ec3fbae58d..10a3c36b4b 100644
> > --- a/include/hw/virtio/vhost-backend.h
> > +++ b/include/hw/virtio/vhost-backend.h
> > @@ -133,6 +133,8 @@ typedef int (*vhost_set_config_call_op)(struct vhos=
t_dev *dev,
> >
> >  typedef void (*vhost_reset_status_op)(struct vhost_dev *dev);
> >
> > +typedef void (*vhost_toggle_device_iotlb_op)(struct vhost_dev *dev);
> > +
> >  typedef struct VhostOps {
> >      VhostBackendType backend_type;
> >      vhost_backend_init vhost_backend_init;
> > @@ -181,6 +183,7 @@ typedef struct VhostOps {
> >      vhost_force_iommu_op vhost_force_iommu;
> >      vhost_set_config_call_op vhost_set_config_call;
> >      vhost_reset_status_op vhost_reset_status;
> > +    vhost_toggle_device_iotlb_op vhost_toggle_device_iotlb;
> >  } VhostOps;
> >
> >  int vhost_backend_update_device_iotlb(struct vhost_dev *dev,
> > diff --git a/include/hw/virtio/vhost.h b/include/hw/virtio/vhost.h
> > index a52f273347..785832ed46 100644
> > --- a/include/hw/virtio/vhost.h
> > +++ b/include/hw/virtio/vhost.h
> > @@ -320,6 +320,7 @@ bool vhost_has_free_slot(void);
> >  int vhost_net_set_backend(struct vhost_dev *hdev,
> >                            struct vhost_vring_file *file);
> >
> > +void vhost_toggle_device_iotlb(struct vhost_dev *dev);
> >  int vhost_device_iotlb_miss(struct vhost_dev *dev, uint64_t iova, int =
write);
> >
> >  int vhost_virtqueue_start(struct vhost_dev *dev, struct VirtIODevice *=
vdev,
> > --
> > 2.35.1
> >
>


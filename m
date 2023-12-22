Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7564C81CE91
	for <lists+qemu-devel@lfdr.de>; Fri, 22 Dec 2023 19:48:44 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rGkYD-0001JS-8Z; Fri, 22 Dec 2023 13:47:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1rGkY9-0001HI-4o
 for qemu-devel@nongnu.org; Fri, 22 Dec 2023 13:47:09 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1rGkY7-0001xG-2l
 for qemu-devel@nongnu.org; Fri, 22 Dec 2023 13:47:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1703270825;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=t4md6q9je5FN32ht9YgftEgkI7n9dX92yTfQhNBL184=;
 b=MQ8q/MDNIGTa6dLnnvLu+dqPMZ1RDgWptFBl7tuIMvacM+9Wy9QUwL+D/tQK1MR1ySiJnY
 G6ml+o9TweNrN3twCgqNzEjwS2xYTrYLTQpzul7OoVBjRQPXawUzLktUPAYFSzPVf5EDBa
 pjtV8fD8Zy7mQ/zt1dC9tLdVOiFtHKM=
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com
 [209.85.166.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-637-mKdufBFePdKye7xg8AHKvQ-1; Fri, 22 Dec 2023 13:47:04 -0500
X-MC-Unique: mKdufBFePdKye7xg8AHKvQ-1
Received: by mail-io1-f70.google.com with SMTP id
 ca18e2360f4ac-7ba7d72a52dso297354239f.0
 for <qemu-devel@nongnu.org>; Fri, 22 Dec 2023 10:47:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703270823; x=1703875623;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=t4md6q9je5FN32ht9YgftEgkI7n9dX92yTfQhNBL184=;
 b=GEsYUPMW9LqSlywmO2IhlCu9adHCjCY7RbFp1WvUhgfy1UHDig+CfXAryyC1nRm7yN
 6sqf5NSiYMXZZ0EyvoFBH1flSXIaDpXXwJa4NTQtrtPJUMS2z50erBgeicAhGiybUCcf
 OHdBgnQsq3pufxW3RAgYZ171jlSySd3sAluV2v8gKqv+ivUtu84dPUqgMP62/nGPJqld
 7rLOnGDLVv2+roisNaPBR3KUsSMJDvfCJqeWRYzG9v+yoJDxDnMSfRUWLEiQadI2MfHg
 6W6neiqknQY4PNrlWEXZRCiAtSDzBd2OL8y75e7aOjU225MCwOKKczcib7YlD6NMhHcQ
 yJjA==
X-Gm-Message-State: AOJu0YyFWhKIMqZpnq5JT8of8xVS2xZ/ihBwyWMKLPl1RltYaRZ96OpV
 snGxTV1lItOnj3XhwypCyFHwiE7xzQTrvaDgsontql8rZwVaNa+OmzPCOAXcvONDzNEflngste/
 fy5GzK0DGqzUapxF5v/sFVKu5d6o3XBPZvOmUm6k=
X-Received: by 2002:a05:6e02:b46:b0:35f:d4dc:1b2f with SMTP id
 f6-20020a056e020b4600b0035fd4dc1b2fmr1762165ilu.116.1703270823527; 
 Fri, 22 Dec 2023 10:47:03 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHKBpI1vykYWa8NM1x0/n8m3VI6bSIPiaX5zPEvOS9g3pVt5SNGSvM1XIdAS/25gG/YIvcC/l8Hgh6YxkyGuPw=
X-Received: by 2002:a05:6e02:b46:b0:35f:d4dc:1b2f with SMTP id
 f6-20020a056e020b4600b0035fd4dc1b2fmr1762152ilu.116.1703270823168; Fri, 22
 Dec 2023 10:47:03 -0800 (PST)
MIME-Version: 1.0
References: <20230918044932.1433744-1-yajunw@nvidia.com>
 <20230918044932.1433744-3-yajunw@nvidia.com>
In-Reply-To: <20230918044932.1433744-3-yajunw@nvidia.com>
From: Eugenio Perez Martin <eperezma@redhat.com>
Date: Fri, 22 Dec 2023 19:46:26 +0100
Message-ID: <CAJaqyWeu-ZTc0dqYpMkqfa36F2KY12YuQ8iwcZHo-WANfcsBHw@mail.gmail.com>
Subject: Re: [RFC PATCH 2/5] vhost: Add support for presetup
To: Yajun Wu <yajunw@nvidia.com>
Cc: qemu-devel@nongnu.org, jasowang@redhat.com, mst@redhat.com, 
 Avihai Horon <avihaih@nvidia.com>, Jiri Pirko <jiri@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=eperezma@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.082,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Mon, Sep 18, 2023 at 6:56=E2=80=AFAM Yajun Wu <yajunw@nvidia.com> wrote:
>
> Add New API vhost_dev_start_presetup to notify backend the start
> and end of presetup.
>
> API vhost_dev_presetup to send out the device configurations:
> 1. acked_features
> 2. memory table
> 3. vring information
> 4. disable host/guest notifier.
>
> Signed-off-by: Yajun Wu <yajunw@nvidia.com>
> Reviewed-by: Avihai Horon <avihaih@nvidia.com>
> Reviewed-by: Jiri Pirko <jiri@nvidia.com>
> ---
>  hw/virtio/vhost.c         | 166 ++++++++++++++++++++++++++++++++------
>  include/hw/virtio/vhost.h |  12 +++
>  2 files changed, 152 insertions(+), 26 deletions(-)
>
> diff --git a/hw/virtio/vhost.c b/hw/virtio/vhost.c
> index e2f6ffb446..5b162590fb 100644
> --- a/hw/virtio/vhost.c
> +++ b/hw/virtio/vhost.c
> @@ -1138,24 +1138,71 @@ out:
>      return ret;
>  }
>
> -int vhost_virtqueue_start(struct vhost_dev *dev,
> -                          struct VirtIODevice *vdev,
> -                          struct vhost_virtqueue *vq,
> -                          unsigned idx)
> +static void vhost_virtqueue_memory_unmap(struct vhost_dev *dev,
> +                                         struct VirtIODevice *vdev,
> +                                         struct vhost_virtqueue *vq,
> +                                         unsigned idx)
> +{
> +    if (vq->used) {
> +        vhost_memory_unmap(dev, vq->used,
> +                           virtio_queue_get_used_size(vdev, idx),
> +                           1, virtio_queue_get_used_size(vdev, idx));
> +        vq->used =3D NULL;
> +    }
> +
> +    if (vq->avail) {
> +        vhost_memory_unmap(dev, vq->avail,
> +                           virtio_queue_get_avail_size(vdev, idx),
> +                           0, virtio_queue_get_avail_size(vdev, idx));
> +        vq->avail =3D NULL;
> +    }
> +
> +    if (vq->desc) {
> +        vhost_memory_unmap(dev, vq->desc,
> +                           virtio_queue_get_desc_size(vdev, idx),
> +                           0, virtio_queue_get_desc_size(vdev, idx));
> +        vq->desc =3D NULL;
> +    }
> +}

Can we split the vhost_virtqueue_memory_unmap in its own

> +
> +static int vhost_virtqueue_disable_notify(struct vhost_dev *dev,
> +                                          struct VirtIODevice *vdev,
> +                                          struct vhost_virtqueue *vq,
> +                                          unsigned idx)
>  {
> -    BusState *qbus =3D BUS(qdev_get_parent_bus(DEVICE(vdev)));
> -    VirtioBusState *vbus =3D VIRTIO_BUS(qbus);
> -    VirtioBusClass *k =3D VIRTIO_BUS_GET_CLASS(vbus);
> -    hwaddr s, l, a;
> -    int r;
>      int vhost_vq_index =3D dev->vhost_ops->vhost_get_vq_index(dev, idx);
>      struct vhost_vring_file file =3D {
>          .index =3D vhost_vq_index
>      };
> +    int r;
> +
> +    file.fd =3D -1;
> +    r =3D dev->vhost_ops->vhost_set_vring_kick(dev, &file);
> +    if (r) {
> +        VHOST_OPS_DEBUG(r, "vhost_set_vring_kick failed");
> +        return r;
> +    }
> +
> +    r =3D dev->vhost_ops->vhost_set_vring_call(dev, &file);
> +    if (r) {
> +        VHOST_OPS_DEBUG(r, "vhost_set_vring_call failed");
> +        return r;
> +    }
> +
> +    return 0;
> +}
> +
> +static int vhost_virtqueue_vring_setup(struct vhost_dev *dev,
> +                                       struct VirtIODevice *vdev,
> +                                       struct vhost_virtqueue *vq,
> +                                       unsigned idx)
> +{
> +    hwaddr s, l, a;
> +    int vhost_vq_index =3D dev->vhost_ops->vhost_get_vq_index(dev, idx);
>      struct vhost_vring_state state =3D {
>          .index =3D vhost_vq_index
>      };
> -    struct VirtQueue *vvq =3D virtio_get_queue(vdev, idx);
> +    int r;
>
>      a =3D virtio_queue_get_desc_addr(vdev, idx);
>      if (a =3D=3D 0) {
> @@ -1186,6 +1233,10 @@ int vhost_virtqueue_start(struct vhost_dev *dev,
>          }
>      }
>
> +    if (vq->desc) {
> +        vhost_virtqueue_memory_unmap(dev, vdev, vq, idx);
> +    }
> +

How is that we need to unmap from here? Actually, vq->desc should
always be NULL here, isn't it?

I guess it is because vhost_virtqueue_vring_setup is called twice in
vhost-net: One when the first device state reaches the destination,
and another time at vhost_virtqueue_start. Would it work to not call
vhost_virtqueue_vring_setup at vhost_virtqueue_start if vq->desc !=3D
NULL?

>      vq->desc_size =3D s =3D l =3D virtio_queue_get_desc_size(vdev, idx);
>      vq->desc_phys =3D a;
>      vq->desc =3D vhost_memory_map(dev, a, &l, false);
> @@ -1212,6 +1263,36 @@ int vhost_virtqueue_start(struct vhost_dev *dev,
>      if (r < 0) {
>          goto fail_alloc;
>      }
> +    return 0;
> +
> +fail_alloc:
> +fail_alloc_used:
> +fail_alloc_avail:
> +    vhost_virtqueue_memory_unmap(dev, vdev, vq, idx);
> +fail_alloc_desc:
> +    return r;
> +}
> +
> +int vhost_virtqueue_start(struct vhost_dev *dev,
> +                          struct VirtIODevice *vdev,
> +                          struct vhost_virtqueue *vq,
> +                          unsigned idx)
> +{
> +    BusState *qbus =3D BUS(qdev_get_parent_bus(DEVICE(vdev)));
> +    VirtioBusState *vbus =3D VIRTIO_BUS(qbus);
> +    VirtioBusClass *k =3D VIRTIO_BUS_GET_CLASS(vbus);
> +    int r;
> +    int vhost_vq_index =3D dev->vhost_ops->vhost_get_vq_index(dev, idx);
> +    struct vhost_vring_file file =3D {
> +        .index =3D vhost_vq_index
> +    };
> +    struct VirtQueue *vvq =3D virtio_get_queue(vdev, idx);
> +
> +    r =3D vhost_virtqueue_vring_setup(dev, vdev, vq, idx);
> +    if (r) {
> +        VHOST_OPS_DEBUG(r, "vhost_virtqueue_vring_setup failed");
> +        goto fail_vring_setup;
> +    }
>
>      file.fd =3D event_notifier_get_fd(virtio_queue_get_host_notifier(vvq=
));
>      r =3D dev->vhost_ops->vhost_set_vring_kick(dev, &file);
> @@ -1245,16 +1326,8 @@ int vhost_virtqueue_start(struct vhost_dev *dev,
>
>  fail_vector:
>  fail_kick:
> -fail_alloc:
> -    vhost_memory_unmap(dev, vq->used, virtio_queue_get_used_size(vdev, i=
dx),
> -                       0, 0);
> -fail_alloc_used:
> -    vhost_memory_unmap(dev, vq->avail, virtio_queue_get_avail_size(vdev,=
 idx),
> -                       0, 0);
> -fail_alloc_avail:
> -    vhost_memory_unmap(dev, vq->desc, virtio_queue_get_desc_size(vdev, i=
dx),
> -                       0, 0);
> -fail_alloc_desc:
> +    vhost_virtqueue_memory_unmap(dev, vdev, vq, idx);
> +fail_vring_setup:
>      return r;
>  }
>
> @@ -1296,12 +1369,7 @@ void vhost_virtqueue_stop(struct vhost_dev *dev,
>                                                  vhost_vq_index);
>      }
>
> -    vhost_memory_unmap(dev, vq->used, virtio_queue_get_used_size(vdev, i=
dx),
> -                       1, virtio_queue_get_used_size(vdev, idx));
> -    vhost_memory_unmap(dev, vq->avail, virtio_queue_get_avail_size(vdev,=
 idx),
> -                       0, virtio_queue_get_avail_size(vdev, idx));
> -    vhost_memory_unmap(dev, vq->desc, virtio_queue_get_desc_size(vdev, i=
dx),
> -                       0, virtio_queue_get_desc_size(vdev, idx));
> +    vhost_virtqueue_memory_unmap(dev, vdev, vq, idx);
>  }
>
>  static int vhost_virtqueue_set_busyloop_timeout(struct vhost_dev *dev,
> @@ -1921,6 +1989,43 @@ static int vhost_dev_set_vring_enable(struct vhost=
_dev *hdev, int enable)
>      return hdev->vhost_ops->vhost_set_vring_enable(hdev, enable);
>  }
>
> +int vhost_dev_presetup(struct vhost_dev *hdev, VirtIODevice *vdev)
> +{
> +    int i, r;
> +
> +    /* should only be called after backend is connected */
> +    assert(hdev->vhost_ops);
> +
> +    r =3D vhost_dev_set_features(hdev, hdev->log_enabled);
> +    if (r < 0) {
> +        return r;
> +    }
> +
> +    r =3D hdev->vhost_ops->vhost_set_mem_table(hdev, hdev->mem);
> +    if (r < 0) {
> +        VHOST_OPS_DEBUG(r, "vhost_set_mem_table failed");
> +        return r;
> +    }
> +
> +    for (i =3D 0; i < hdev->nvqs; ++i) {
> +        r =3D vhost_virtqueue_vring_setup(hdev, vdev,
> +                                        hdev->vqs + i,
> +                                        hdev->vq_index + i);
> +        if (r < 0) {
> +            VHOST_OPS_DEBUG(r, "vhost_virtqueue_setup failed");
> +            return r;
> +        }
> +        r =3D vhost_virtqueue_disable_notify(hdev, vdev,
> +                                           hdev->vqs + i,
> +                                           hdev->vq_index + i);

Why is this call needed? The vhost backend should not have any kick or
call fd configured at this moment, isn't it?

> +        if (r < 0) {
> +            return r;
> +        }
> +    }
> +
> +    return 0;
> +}
> +
>  /* Host notifiers must be enabled at this point. */
>  int vhost_dev_start(struct vhost_dev *hdev, VirtIODevice *vdev, bool vri=
ngs)
>  {
> @@ -2087,3 +2192,12 @@ int vhost_net_set_backend(struct vhost_dev *hdev,
>
>      return -ENOSYS;
>  }
> +
> +int vhost_dev_set_presetup_state(struct vhost_dev *hdev, bool start)
> +{
> +    if (!hdev->vhost_ops->vhost_presetup) {
> +        return -ENOTSUP;

I'm thinking if we must return an error here.

Presetup is only "warming up" the device, as all the information is
re-sent at vhost_dev_start. If we annotate the device state somewhere
(bool presetup_has_run), we can just call vhost_virtqueue_vring_setup
at vhost_virtqueue_start and configure the virtqueues selectively.

This way we enable migration between all the backends, either support
presetup or not.

> +    }
> +
> +    return hdev->vhost_ops->vhost_presetup(hdev, start);
> +}
> diff --git a/include/hw/virtio/vhost.h b/include/hw/virtio/vhost.h
> index 6a173cb9fa..95a8031d12 100644
> --- a/include/hw/virtio/vhost.h
> +++ b/include/hw/virtio/vhost.h
> @@ -192,6 +192,17 @@ void vhost_dev_disable_notifiers(struct vhost_dev *h=
dev, VirtIODevice *vdev);
>  bool vhost_config_pending(struct vhost_dev *hdev);
>  void vhost_config_mask(struct vhost_dev *hdev, VirtIODevice *vdev, bool =
mask);
>
> +/**
> + * vhost_dev_presetup() - pre-setup the vhost device in LM
> + * @hdev: common vhost_dev structure
> + * @vdev: the VirtIODevice structure
> + *
> + * During live migration, send out device information to backend in earl=
y
> + * running state. Backend can have enough time to prepare HW.
> + * Return: 0 on success, < 0 on error.
> + */
> +int vhost_dev_presetup(struct vhost_dev *hdev, VirtIODevice *vdev);
> +
>  /**
>   * vhost_dev_is_started() - report status of vhost device
>   * @hdev: common vhost_dev structure
> @@ -338,4 +349,5 @@ int vhost_dev_set_inflight(struct vhost_dev *dev,
>  int vhost_dev_get_inflight(struct vhost_dev *dev, uint16_t queue_size,
>                             struct vhost_inflight *inflight);
>  bool vhost_dev_has_iommu(struct vhost_dev *dev);
> +int vhost_dev_set_presetup_state(struct vhost_dev *hdev, bool start);
>  #endif
> --
> 2.27.0
>
>



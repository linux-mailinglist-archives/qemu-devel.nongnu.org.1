Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C527477B1E0
	for <lists+qemu-devel@lfdr.de>; Mon, 14 Aug 2023 08:58:57 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qVRWX-0003hl-9W; Mon, 14 Aug 2023 02:57:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1qVRWS-0003eg-IA
 for qemu-devel@nongnu.org; Mon, 14 Aug 2023 02:57:53 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1qVRWQ-0005RT-Qz
 for qemu-devel@nongnu.org; Mon, 14 Aug 2023 02:57:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1691996270;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=XJ7YhoieuVwnEnF1IVrSRK7/rUClTbIyUsTKguKRaPA=;
 b=GxBAKIKwcQSEh79FkE7XwXEX2x1E/8ENwrXD2Y3ShJnQEMYRDmE73lFDE1eG204328tvOl
 N1bhL2+wvSN/slfJKYPQRrkLkY5ULrcL/Q/OiePOwxW8DW/quJjHmJoihINMSMoZK7MBfY
 ai3cSNnLHcEfNfQgGbllV/iEZgqgvok=
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com
 [209.85.208.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-365-f4YyKM5cOHeuVnITkV2x5A-1; Mon, 14 Aug 2023 02:57:48 -0400
X-MC-Unique: f4YyKM5cOHeuVnITkV2x5A-1
Received: by mail-lj1-f199.google.com with SMTP id
 38308e7fff4ca-2ba1949656bso38563711fa.0
 for <qemu-devel@nongnu.org>; Sun, 13 Aug 2023 23:57:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691996267; x=1692601067;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=XJ7YhoieuVwnEnF1IVrSRK7/rUClTbIyUsTKguKRaPA=;
 b=f3w6vs+C7F3FseoGZmOdOKkN4/ExNBDX0fe4OHuPBcdVEAhpwGjffwJqbKbO+7Lqh3
 JmDsg+We3mZFnmXUDkn4IbwhJ4PQ5xqw+2DPvAolo3CcVphDAq4RzVmkQMNjV+KqOQX2
 NDX7Sc3GKPfjqSNjKvJ35q9QVWixg207maw8xQgr6H1cBFrAc0gK9S9owqA1w7roqZ69
 DszE3rhPF0MxB4kf5t+sl3R0MXrLf9wBJpFvLKfnkt9NEgMq9nqedfgHpucQzCb6jJjs
 iMegwMWH+Ifh5tHQIsIBZBHHXcnuVkNtGiQ1timkaosd8ZodLV0vMXYXOTUnSuibDy3C
 uj+g==
X-Gm-Message-State: AOJu0YzaHko6FdDYsqtj+zyltUyQ+xhsR2yFvRR4Ja4iYd59Gw0BREDo
 6rL7DzY0U6kHitO/EQ0eUBKjJydFBRd/67y09+SAcdiO0++Z+tUg1CR5ReMAfxnSD+iEysn3gpL
 53705fppv4J3yAwz4n5e5eEb771uHIxI=
X-Received: by 2002:a2e:b6c8:0:b0:2b9:b066:66a4 with SMTP id
 m8-20020a2eb6c8000000b002b9b06666a4mr6179870ljo.4.1691996266898; 
 Sun, 13 Aug 2023 23:57:46 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEG5Dr3BNM6XN203Kdsul14SiVGHMEiV3WRfcG3eR/4csPznvguonsC61E1LED8E1bCTRAj1yqK68+0lskbaEY=
X-Received: by 2002:a2e:b6c8:0:b0:2b9:b066:66a4 with SMTP id
 m8-20020a2eb6c8000000b002b9b06666a4mr6179850ljo.4.1691996266708; Sun, 13 Aug
 2023 23:57:46 -0700 (PDT)
MIME-Version: 1.0
References: <20230810153611.3410882-1-eperezma@redhat.com>
 <20230810153611.3410882-3-eperezma@redhat.com>
In-Reply-To: <20230810153611.3410882-3-eperezma@redhat.com>
From: Jason Wang <jasowang@redhat.com>
Date: Mon, 14 Aug 2023 14:57:35 +0800
Message-ID: <CACGkMEsytDHACaBuOofS8d7dTOV3=Ox=TY_XWa3nu+rzbeB0xQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/5] vdpa: export vhost_vdpa_set_vring_ready
To: =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>
Cc: qemu-devel@nongnu.org, Laurent Vivier <lvivier@redhat.com>, 
 Dragos Tatulea <dtatulea@nvidia.com>, si-wei.liu@oracle.com, 
 Parav Pandit <parav@mellanox.com>, Gautam Dawar <gdawar@xilinx.com>, 
 Zhu Lingshan <lingshan.zhu@intel.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Cindy Lu <lulu@redhat.com>, Harpreet Singh Anand <hanand@xilinx.com>,
 Stefano Garzarella <sgarzare@redhat.com>, 
 Hawkins Jiawei <yin31149@gmail.com>, Shannon Nelson <snelson@pensando.io>,
 Lei Yang <leiyang@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=jasowang@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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

On Thu, Aug 10, 2023 at 11:36=E2=80=AFPM Eugenio P=C3=A9rez <eperezma@redha=
t.com> wrote:
>
> The vhost-vdpa net backend needs to enable vrings in a different order
> than default, so export it.
>
> No functional change intended except for tracing, that now includes the
> (virtio) index being enabled and the return value of the ioctl.
>
> Still ignoring return value of this function if called from
> vhost_vdpa_dev_start, as reorganize calling code around it is out of
> the scope of this series.
>
> Signed-off-by: Eugenio P=C3=A9rez <eperezma@redhat.com>

Acked-by: Jason Wang <jasowang@redhat.com>

Thanks

> ---
>  include/hw/virtio/vhost-vdpa.h |  1 +
>  hw/virtio/vhost-vdpa.c         | 25 +++++++++++++------------
>  hw/virtio/trace-events         |  2 +-
>  3 files changed, 15 insertions(+), 13 deletions(-)
>
> diff --git a/include/hw/virtio/vhost-vdpa.h b/include/hw/virtio/vhost-vdp=
a.h
> index e64bfc7f98..5407d54fd7 100644
> --- a/include/hw/virtio/vhost-vdpa.h
> +++ b/include/hw/virtio/vhost-vdpa.h
> @@ -57,6 +57,7 @@ typedef struct vhost_vdpa {
>  } VhostVDPA;
>
>  int vhost_vdpa_get_iova_range(int fd, struct vhost_vdpa_iova_range *iova=
_range);
> +int vhost_vdpa_set_vring_ready(struct vhost_vdpa *v, unsigned idx);
>
>  int vhost_vdpa_dma_map(struct vhost_vdpa *v, uint32_t asid, hwaddr iova,
>                         hwaddr size, void *vaddr, bool readonly);
> diff --git a/hw/virtio/vhost-vdpa.c b/hw/virtio/vhost-vdpa.c
> index 42f2a4bae9..0d9975b5b5 100644
> --- a/hw/virtio/vhost-vdpa.c
> +++ b/hw/virtio/vhost-vdpa.c
> @@ -876,18 +876,17 @@ static int vhost_vdpa_get_vq_index(struct vhost_dev=
 *dev, int idx)
>      return idx;
>  }
>
> -static int vhost_vdpa_set_vring_ready(struct vhost_dev *dev)
> +int vhost_vdpa_set_vring_ready(struct vhost_vdpa *v, unsigned idx)
>  {
> -    int i;
> -    trace_vhost_vdpa_set_vring_ready(dev);
> -    for (i =3D 0; i < dev->nvqs; ++i) {
> -        struct vhost_vring_state state =3D {
> -            .index =3D dev->vq_index + i,
> -            .num =3D 1,
> -        };
> -        vhost_vdpa_call(dev, VHOST_VDPA_SET_VRING_ENABLE, &state);
> -    }
> -    return 0;
> +    struct vhost_dev *dev =3D v->dev;
> +    struct vhost_vring_state state =3D {
> +        .index =3D idx,
> +        .num =3D 1,
> +    };
> +    int r =3D vhost_vdpa_call(dev, VHOST_VDPA_SET_VRING_ENABLE, &state);
> +
> +    trace_vhost_vdpa_set_vring_ready(dev, idx, r);
> +    return r;
>  }
>
>  static int vhost_vdpa_set_config_call(struct vhost_dev *dev,
> @@ -1298,7 +1297,9 @@ static int vhost_vdpa_dev_start(struct vhost_dev *d=
ev, bool started)
>          if (unlikely(!ok)) {
>              return -1;
>          }
> -        vhost_vdpa_set_vring_ready(dev);
> +        for (int i =3D 0; i < dev->nvqs; ++i) {
> +            vhost_vdpa_set_vring_ready(v, dev->vq_index + i);
> +        }
>      } else {
>          vhost_vdpa_suspend(dev);
>          vhost_vdpa_svqs_stop(dev);
> diff --git a/hw/virtio/trace-events b/hw/virtio/trace-events
> index 7109cf1a3b..1cb9027d1e 100644
> --- a/hw/virtio/trace-events
> +++ b/hw/virtio/trace-events
> @@ -48,7 +48,7 @@ vhost_vdpa_set_features(void *dev, uint64_t features) "=
dev: %p features: 0x%"PRI
>  vhost_vdpa_get_device_id(void *dev, uint32_t device_id) "dev: %p device_=
id %"PRIu32
>  vhost_vdpa_reset_device(void *dev) "dev: %p"
>  vhost_vdpa_get_vq_index(void *dev, int idx, int vq_idx) "dev: %p idx: %d=
 vq idx: %d"
> -vhost_vdpa_set_vring_ready(void *dev) "dev: %p"
> +vhost_vdpa_set_vring_ready(void *dev, unsigned i, int r) "dev: %p, idx: =
%u, r: %d"
>  vhost_vdpa_dump_config(void *dev, const char *line) "dev: %p %s"
>  vhost_vdpa_set_config(void *dev, uint32_t offset, uint32_t size, uint32_=
t flags) "dev: %p offset: %"PRIu32" size: %"PRIu32" flags: 0x%"PRIx32
>  vhost_vdpa_get_config(void *dev, void *config, uint32_t config_len) "dev=
: %p config: %p config_len: %"PRIu32
> --
> 2.39.3
>



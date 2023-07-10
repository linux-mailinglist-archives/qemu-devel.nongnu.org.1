Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2172074CA53
	for <lists+qemu-devel@lfdr.de>; Mon, 10 Jul 2023 05:21:00 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qIhQo-0005qH-Dn; Sun, 09 Jul 2023 23:19:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1qIhQm-0005q7-QL
 for qemu-devel@nongnu.org; Sun, 09 Jul 2023 23:19:20 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1qIhQk-0003vM-Tt
 for qemu-devel@nongnu.org; Sun, 09 Jul 2023 23:19:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1688959157;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=hGnFu21W0nA35+1D9J3zFnt8zkkGMezAIw7+h7gwWhU=;
 b=Ffyr0fXloV8yizfKBcwEV3WgVq9zXLMLpY4XnVvf6zDNZU48pCehZBxOFW8hESIZxqAUOF
 CzhKXRfBljj66SR6AuTLPv3arN/lrq+ISebP8ujUdN/+1AExjDnW+go4nB+DMD4JTw4jw5
 0Z/UlxqiRNAQHMpLlkLvw6Qqd3k/8hw=
Received: from mail-lj1-f200.google.com (mail-lj1-f200.google.com
 [209.85.208.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-201-9PiKdzQ1OwG-6u7RCbP7Wg-1; Sun, 09 Jul 2023 23:19:14 -0400
X-MC-Unique: 9PiKdzQ1OwG-6u7RCbP7Wg-1
Received: by mail-lj1-f200.google.com with SMTP id
 38308e7fff4ca-2b6ff15946fso35578571fa.2
 for <qemu-devel@nongnu.org>; Sun, 09 Jul 2023 20:19:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688959153; x=1691551153;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=hGnFu21W0nA35+1D9J3zFnt8zkkGMezAIw7+h7gwWhU=;
 b=fiz3US1pgS/z48U0LV+bysuUe1L8HIvGea2jloaybrx4DKmci088kLEYo0XRDsybc1
 kfbsxM2BNzg8TO/PlDXi0dQCmAuIPYhiZtm+qb0KW/0YjJwcbL86r5rB754hAFYnv/mW
 bbKspkanEOIsbC49ppapt7B1Z0j6luKugwfxxgaKVbkKHcMw9g2GDYFegeb8jVRiHYa6
 1BAk7nnQx0gCtwb3xS8LAEraMEWqUrK7OxpQlLOiikhpLkoDYbBztzHv7NE4YPxA6x9M
 ugzv1LPuOyxUTitlfHue34+EhRQJcCxQjjy0yUGVKVykrLKVBQaReDcCABMi4+yXHHlp
 JHoA==
X-Gm-Message-State: ABy/qLbmnNEW1iC/T1sMgTfbL7f8d7KLl2dqEmA2zxDtgu2yHfHZHBvy
 bxbZTGVNJz1SvxKoAVn/uYxrjKHv/oGzM2/6kaffOb+mmlvf8g+eWVjzNkZqLVBbnz4xlNgFh5i
 0anGJs6tOTjRnlBcTRTFsjfoPvywWpIk=
X-Received: by 2002:a2e:3612:0:b0:2b2:1f2f:705f with SMTP id
 d18-20020a2e3612000000b002b21f2f705fmr8607431lja.4.1688959153384; 
 Sun, 09 Jul 2023 20:19:13 -0700 (PDT)
X-Google-Smtp-Source: APBJJlFrnMKgv7FE4H68ESXCxJNUHg/h8zoF5zcbAqIMcfMvDcm3+FFwfcGlGSjyuJjm4HFQ/iRAaiZDwX6SZe6ZfCg=
X-Received: by 2002:a2e:3612:0:b0:2b2:1f2f:705f with SMTP id
 d18-20020a2e3612000000b002b21f2f705fmr8607418lja.4.1688959153094; Sun, 09 Jul
 2023 20:19:13 -0700 (PDT)
MIME-Version: 1.0
References: <20230706191227.835526-1-eperezma@redhat.com>
 <20230706191227.835526-2-eperezma@redhat.com>
In-Reply-To: <20230706191227.835526-2-eperezma@redhat.com>
From: Jason Wang <jasowang@redhat.com>
Date: Mon, 10 Jul 2023 11:19:02 +0800
Message-ID: <CACGkMEs3ZkzwSiH6Xt2HRsajzKLqN3tw4F+2NxN7wF3dVVOj-Q@mail.gmail.com>
Subject: Re: [RFC PATCH 1/6] vdpa: export vhost_vdpa_set_vring_ready
To: =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>
Cc: qemu-devel@nongnu.org, Laurent Vivier <lvivier@redhat.com>, 
 "Michael S. Tsirkin" <mst@redhat.com>, Cindy Lu <lulu@redhat.com>,
 si-wei.liu@oracle.com, 
 Stefano Garzarella <sgarzare@redhat.com>, Shannon Nelson <snelson@pensando.io>,
 Gautam Dawar <gdawar@xilinx.com>, Harpreet Singh Anand <hanand@xilinx.com>,
 Parav Pandit <parav@mellanox.com>, 
 Dragos Tatulea <dtatulea@nvidia.com>, Zhu Lingshan <lingshan.zhu@intel.com>, 
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

On Fri, Jul 7, 2023 at 3:12=E2=80=AFAM Eugenio P=C3=A9rez <eperezma@redhat.=
com> wrote:
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
> ---
>  include/hw/virtio/vhost-vdpa.h |  1 +
>  hw/virtio/vhost-vdpa.c         | 28 ++++++++++++++++++++--------
>  hw/virtio/trace-events         |  2 +-
>  3 files changed, 22 insertions(+), 9 deletions(-)
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
> index 3c575a9a6e..5978d970ee 100644
> --- a/hw/virtio/vhost-vdpa.c
> +++ b/hw/virtio/vhost-vdpa.c
> @@ -528,6 +528,19 @@ int vhost_vdpa_get_iova_range(int fd, struct vhost_v=
dpa_iova_range *iova_range)
>      return ret < 0 ? -errno : 0;
>  }
>
> +int vhost_vdpa_set_vring_ready(struct vhost_vdpa *v, unsigned idx)
> +{
> +    struct vhost_dev *dev =3D v->dev;
> +    struct vhost_vring_state state =3D {
> +        .index =3D idx,
> +        .num =3D 1,
> +    };
> +    int r =3D vhost_vdpa_call(dev, VHOST_VDPA_SET_VRING_ENABLE, &state);
> +
> +    trace_vhost_vdpa_set_vring_ready(dev, idx, r);
> +    return r;
> +}
> +
>  /*
>   * The use of this function is for requests that only need to be
>   * applied once. Typically such request occurs at the beginning
> @@ -872,16 +885,15 @@ static int vhost_vdpa_get_vq_index(struct vhost_dev=
 *dev, int idx)
>      return idx;
>  }
>
> -static int vhost_vdpa_set_vring_ready(struct vhost_dev *dev)
> +static int vhost_vdpa_set_vrings_ready(struct vhost_dev *dev)
>  {
> +    struct vhost_vdpa *v =3D dev->opaque;
>      int i;
> -    trace_vhost_vdpa_set_vring_ready(dev);
> +
> +    assert(dev->vhost_ops->backend_type =3D=3D VHOST_BACKEND_TYPE_VDPA);

Nit: any reason we need to add this assert in this patch?

Thanks

> +
>      for (i =3D 0; i < dev->nvqs; ++i) {
> -        struct vhost_vring_state state =3D {
> -            .index =3D dev->vq_index + i,
> -            .num =3D 1,
> -        };
> -        vhost_vdpa_call(dev, VHOST_VDPA_SET_VRING_ENABLE, &state);
> +        vhost_vdpa_set_vring_ready(v, dev->vq_index + i);
>      }
>      return 0;
>  }
> @@ -1294,7 +1306,7 @@ static int vhost_vdpa_dev_start(struct vhost_dev *d=
ev, bool started)
>          if (unlikely(!ok)) {
>              return -1;
>          }
> -        vhost_vdpa_set_vring_ready(dev);
> +        vhost_vdpa_set_vrings_ready(dev);
>      } else {
>          vhost_vdpa_suspend(dev);
>          vhost_vdpa_svqs_stop(dev);
> diff --git a/hw/virtio/trace-events b/hw/virtio/trace-events
> index 8f8d05cf9b..4f6a6ba428 100644
> --- a/hw/virtio/trace-events
> +++ b/hw/virtio/trace-events
> @@ -46,7 +46,7 @@ vhost_vdpa_set_features(void *dev, uint64_t features) "=
dev: %p features: 0x%"PRI
>  vhost_vdpa_get_device_id(void *dev, uint32_t device_id) "dev: %p device_=
id %"PRIu32
>  vhost_vdpa_reset_device(void *dev, uint8_t status) "dev: %p status: 0x%"=
PRIx8
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



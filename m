Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 348307750FA
	for <lists+qemu-devel@lfdr.de>; Wed,  9 Aug 2023 04:39:07 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qTZ56-0001Ee-Tp; Tue, 08 Aug 2023 22:37:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1qTZ54-0001ER-3D
 for qemu-devel@nongnu.org; Tue, 08 Aug 2023 22:37:50 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1qTZ52-0005VC-7u
 for qemu-devel@nongnu.org; Tue, 08 Aug 2023 22:37:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1691548667;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=xDVgBZ8fbjeEcw/ZXdaveDgWFwdLNTnrGBRdeWJv+lE=;
 b=BPhfnMlxj0WSownjXn5zp/Nsy3ECMtl4u76ttnOzDnHaOTQwhuv6nkjmDt4m7HyyuuwdjV
 BwVqDSLNsSB/UT1YgUfbTQWkZebyAAPf9b0V3Zp2eNLlPeMRbaA7K8xRUGaoc19IjO/U83
 RcMgsZ/cBPez6hC4k7cmW2QUJm5Xfhg=
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com
 [209.85.208.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-255-oHriHf6sM9OvZKzeRwG9eA-1; Tue, 08 Aug 2023 22:37:45 -0400
X-MC-Unique: oHriHf6sM9OvZKzeRwG9eA-1
Received: by mail-lj1-f197.google.com with SMTP id
 38308e7fff4ca-2b9ba3d6191so61159501fa.2
 for <qemu-devel@nongnu.org>; Tue, 08 Aug 2023 19:37:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691548663; x=1692153463;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=xDVgBZ8fbjeEcw/ZXdaveDgWFwdLNTnrGBRdeWJv+lE=;
 b=dxaNCVr3KhnejzMRG5bHLhXOerXnByvS0OrXJ2D9ZZauG1B+af1Pc3JB3KB3eegxLm
 zN3Em1Oreu4NH5EbifykKEBeFeAv+GoGiVUPqcsrSFt8hfb8q6o5ApR6i0k5bhgRybmN
 CVGm0LuOXa5/tD5uCIafctbfTfmFeg+RUzkE5qR5qSx62aDirV8zVUDk6BiQUW4aGnWE
 DxuJFzVCnmAwogeUUldc1AZA2U1PFG1njZrvVEnB91X8V5LySi3+Bxx7dNVRCuXyttGO
 kvXEt0ZXDAtnlb8rlVjk758X6L7ZrfnEbkbC3nlVtWo4Aw60v6WuTlk202mScrd6mcvR
 MaGg==
X-Gm-Message-State: AOJu0YzD/+Y5YlEQBAE85l9n4HVaS7Y91ro+hLWbYrneQlj9yJiz68Z+
 d5RZxA2U1a3xWHcOhA16Qgvv9B8FV/PJSOAVuEMQniJjm5xCaEm7001uCzvDxz/czh7nrdCTDCz
 seLOQ0BPtvD0m3Zwwd08iiwkq1ru49LU=
X-Received: by 2002:a2e:7219:0:b0:2b9:3883:a765 with SMTP id
 n25-20020a2e7219000000b002b93883a765mr873392ljc.31.1691548663311; 
 Tue, 08 Aug 2023 19:37:43 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHC2Ilv0wd8IpVcD/GcGdfV90Vgql4hIzAbvwS8ZCP5Y6XVgohGca3w+qc4DYkocFKE46n+kyGTNfZwLOKcUh4=
X-Received: by 2002:a2e:7219:0:b0:2b9:3883:a765 with SMTP id
 n25-20020a2e7219000000b002b93883a765mr873381ljc.31.1691548662979; Tue, 08 Aug
 2023 19:37:42 -0700 (PDT)
MIME-Version: 1.0
References: <20230807222847.2837393-1-i.maximets@ovn.org>
In-Reply-To: <20230807222847.2837393-1-i.maximets@ovn.org>
From: Jason Wang <jasowang@redhat.com>
Date: Wed, 9 Aug 2023 10:37:31 +0800
Message-ID: <CACGkMEs8qVpaJCc=1jUyY_8-NE23fsjQBwSrbAn8n3sjihuv5g@mail.gmail.com>
Subject: Re: [PATCH] virtio: don't zero out memory region cache for indirect
 descriptors
To: Ilya Maximets <i.maximets@ovn.org>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, 
 Stefan Hajnoczi <stefanha@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=jasowang@redhat.com;
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

On Tue, Aug 8, 2023 at 6:28=E2=80=AFAM Ilya Maximets <i.maximets@ovn.org> w=
rote:
>
> Lots of virtio functions that are on a hot path in data transmission
> are initializing indirect descriptor cache at the point of stack
> allocation.  It's a 112 byte structure that is getting zeroed out on
> each call adding unnecessary overhead.  It's going to be correctly
> initialized later via special init function.  The only reason to
> actually initialize right away is the ability to safely destruct it.
> However, we only need to destruct it when it was used, i.e. when a
> desc_cache points to it.
>
> Removing these unnecessary stack initializations improves throughput
> of virtio-net devices in terms of 64B packets per second by 6-14 %
> depending on the case.  Tested with a proposed af-xdp network backend
> and a dpdk testpmd application in the guest, but should be beneficial
> for other virtio devices as well.
>
> Signed-off-by: Ilya Maximets <i.maximets@ovn.org>

Acked-by: Jason Wang <jasowang@redhat.com>

Btw, we can probably remove MEMORY_REGION_CACHE_INVALID.

Thanks

> ---
>  hw/virtio/virtio.c | 42 +++++++++++++++++++++++++++---------------
>  1 file changed, 27 insertions(+), 15 deletions(-)
>
> diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
> index 309038fd46..a65396e616 100644
> --- a/hw/virtio/virtio.c
> +++ b/hw/virtio/virtio.c
> @@ -1071,7 +1071,8 @@ static void virtqueue_split_get_avail_bytes(VirtQue=
ue *vq,
>      VirtIODevice *vdev =3D vq->vdev;
>      unsigned int idx;
>      unsigned int total_bufs, in_total, out_total;
> -    MemoryRegionCache indirect_desc_cache =3D MEMORY_REGION_CACHE_INVALI=
D;
> +    MemoryRegionCache indirect_desc_cache;
> +    MemoryRegionCache *desc_cache =3D NULL;
>      int64_t len =3D 0;
>      int rc;
>
> @@ -1079,7 +1080,6 @@ static void virtqueue_split_get_avail_bytes(VirtQue=
ue *vq,
>      total_bufs =3D in_total =3D out_total =3D 0;
>
>      while ((rc =3D virtqueue_num_heads(vq, idx)) > 0) {
> -        MemoryRegionCache *desc_cache =3D &caches->desc;
>          unsigned int num_bufs;
>          VRingDesc desc;
>          unsigned int i;
> @@ -1091,6 +1091,8 @@ static void virtqueue_split_get_avail_bytes(VirtQue=
ue *vq,
>              goto err;
>          }
>
> +        desc_cache =3D &caches->desc;
> +
>          vring_split_desc_read(vdev, &desc, desc_cache, i);
>
>          if (desc.flags & VRING_DESC_F_INDIRECT) {
> @@ -1156,7 +1158,9 @@ static void virtqueue_split_get_avail_bytes(VirtQue=
ue *vq,
>      }
>
>  done:
> -    address_space_cache_destroy(&indirect_desc_cache);
> +    if (desc_cache =3D=3D &indirect_desc_cache) {
> +        address_space_cache_destroy(&indirect_desc_cache);
> +    }
>      if (in_bytes) {
>          *in_bytes =3D in_total;
>      }
> @@ -1207,8 +1211,8 @@ static void virtqueue_packed_get_avail_bytes(VirtQu=
eue *vq,
>      VirtIODevice *vdev =3D vq->vdev;
>      unsigned int idx;
>      unsigned int total_bufs, in_total, out_total;
> -    MemoryRegionCache *desc_cache;
> -    MemoryRegionCache indirect_desc_cache =3D MEMORY_REGION_CACHE_INVALI=
D;
> +    MemoryRegionCache indirect_desc_cache;
> +    MemoryRegionCache *desc_cache =3D NULL;
>      int64_t len =3D 0;
>      VRingPackedDesc desc;
>      bool wrap_counter;
> @@ -1297,7 +1301,9 @@ static void virtqueue_packed_get_avail_bytes(VirtQu=
eue *vq,
>      vq->shadow_avail_idx =3D idx;
>      vq->shadow_avail_wrap_counter =3D wrap_counter;
>  done:
> -    address_space_cache_destroy(&indirect_desc_cache);
> +    if (desc_cache =3D=3D &indirect_desc_cache) {
> +        address_space_cache_destroy(&indirect_desc_cache);
> +    }
>      if (in_bytes) {
>          *in_bytes =3D in_total;
>      }
> @@ -1487,8 +1493,8 @@ static void *virtqueue_split_pop(VirtQueue *vq, siz=
e_t sz)
>  {
>      unsigned int i, head, max;
>      VRingMemoryRegionCaches *caches;
> -    MemoryRegionCache indirect_desc_cache =3D MEMORY_REGION_CACHE_INVALI=
D;
> -    MemoryRegionCache *desc_cache;
> +    MemoryRegionCache indirect_desc_cache;
> +    MemoryRegionCache *desc_cache =3D NULL;
>      int64_t len;
>      VirtIODevice *vdev =3D vq->vdev;
>      VirtQueueElement *elem =3D NULL;
> @@ -1611,7 +1617,9 @@ static void *virtqueue_split_pop(VirtQueue *vq, siz=
e_t sz)
>
>      trace_virtqueue_pop(vq, elem, elem->in_num, elem->out_num);
>  done:
> -    address_space_cache_destroy(&indirect_desc_cache);
> +    if (desc_cache =3D=3D &indirect_desc_cache) {
> +        address_space_cache_destroy(&indirect_desc_cache);
> +    }
>
>      return elem;
>
> @@ -1624,8 +1632,8 @@ static void *virtqueue_packed_pop(VirtQueue *vq, si=
ze_t sz)
>  {
>      unsigned int i, max;
>      VRingMemoryRegionCaches *caches;
> -    MemoryRegionCache indirect_desc_cache =3D MEMORY_REGION_CACHE_INVALI=
D;
> -    MemoryRegionCache *desc_cache;
> +    MemoryRegionCache indirect_desc_cache;
> +    MemoryRegionCache *desc_cache =3D NULL;
>      int64_t len;
>      VirtIODevice *vdev =3D vq->vdev;
>      VirtQueueElement *elem =3D NULL;
> @@ -1746,7 +1754,9 @@ static void *virtqueue_packed_pop(VirtQueue *vq, si=
ze_t sz)
>
>      trace_virtqueue_pop(vq, elem, elem->in_num, elem->out_num);
>  done:
> -    address_space_cache_destroy(&indirect_desc_cache);
> +    if (desc_cache =3D=3D &indirect_desc_cache) {
> +        address_space_cache_destroy(&indirect_desc_cache);
> +    }
>
>      return elem;
>
> @@ -3935,8 +3945,8 @@ VirtioQueueElement *qmp_x_query_virtio_queue_elemen=
t(const char *path,
>      } else {
>          unsigned int head, i, max;
>          VRingMemoryRegionCaches *caches;
> -        MemoryRegionCache indirect_desc_cache =3D MEMORY_REGION_CACHE_IN=
VALID;
> -        MemoryRegionCache *desc_cache;
> +        MemoryRegionCache indirect_desc_cache;
> +        MemoryRegionCache *desc_cache =3D NULL;
>          VRingDesc desc;
>          VirtioRingDescList *list =3D NULL;
>          VirtioRingDescList *node;
> @@ -4011,7 +4021,9 @@ VirtioQueueElement *qmp_x_query_virtio_queue_elemen=
t(const char *path,
>          } while (rc =3D=3D VIRTQUEUE_READ_DESC_MORE);
>          element->descs =3D list;
>  done:
> -        address_space_cache_destroy(&indirect_desc_cache);
> +        if (desc_cache =3D=3D &indirect_desc_cache) {
> +            address_space_cache_destroy(&indirect_desc_cache);
> +        }
>      }
>
>      return element;
> --
> 2.40.1
>



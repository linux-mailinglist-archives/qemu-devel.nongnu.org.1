Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 34E7E77C52A
	for <lists+qemu-devel@lfdr.de>; Tue, 15 Aug 2023 03:40:55 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qVj1q-0000yd-51; Mon, 14 Aug 2023 21:39:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1qVj1n-0000yG-Mn
 for qemu-devel@nongnu.org; Mon, 14 Aug 2023 21:39:23 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1qVj1l-0007g3-Kf
 for qemu-devel@nongnu.org; Mon, 14 Aug 2023 21:39:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1692063559;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ZFA1esZPyq7Muyaf+ByLSg5rPMTqjbx6OdEkYQlTOx4=;
 b=f7dML/bcyNHWrZBR2BjNM1U8QSBc6m7epnAonGVXzQEb2EYiZrgWcoj2tiKqX+/w2UFnsB
 whaXX9SEH6zagjZpojs44TVCbMu/UOLSIF5z0jQffCzP4wuynyMFAJ5mM9WJdMtzoMswga
 +84YJN93DpXEbu0FTs7cWL8jNasQIaA=
Received: from mail-lj1-f200.google.com (mail-lj1-f200.google.com
 [209.85.208.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-187-InYcJwnJOo2yKyE6ZehWmA-1; Mon, 14 Aug 2023 21:39:17 -0400
X-MC-Unique: InYcJwnJOo2yKyE6ZehWmA-1
Received: by mail-lj1-f200.google.com with SMTP id
 38308e7fff4ca-2b9bf493456so47793141fa.0
 for <qemu-devel@nongnu.org>; Mon, 14 Aug 2023 18:39:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692063556; x=1692668356;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ZFA1esZPyq7Muyaf+ByLSg5rPMTqjbx6OdEkYQlTOx4=;
 b=SpS0u/SYUukLBqzta+zi3ck0K6IlTMy7+ZFHHd0Nq02KSo9AECi2F9I+2hZ6yZdZPo
 mMU0Czu4y4RRCkEI5XLa4S4PyogSu2ITKJKJ0A41bdpvjW+4DaklSlJlT5J2V2v65p5E
 1m6j+9CPSuWBtE93IIDYG2QoaryHJEPXjYt4Dtm+4hwncWKEnp1zyqwm/0jN7CX4puud
 quugecqNxpHNxnbRI+kX/Fn6pnjcW488+riOdrLpSuX57H2PFVPY3VN4vQd86gi/XbWv
 n6n4Tdsqy65+rlA868cpnU8g6JxwW6C3JhqbaVWMumL9/MlaITzl6UXq++xGpVInAYvZ
 GhEA==
X-Gm-Message-State: AOJu0YxyVBYlxX3izndyWcT7+gQvVHXBkSA0DvCcMfF77QuXCV+n/n2r
 rg1FKZR8/+bnJ/r5Lztc9erGtX2I6+6GLqlzH9LNZPhIXJ8Y9sKQZnjk6Jm0sFASrSUsiY8YoAu
 BM22BIpqI/Ir2ZXeK0wm3DjnFy4LLgXI=
X-Received: by 2002:a2e:9cd8:0:b0:2b9:e53f:e201 with SMTP id
 g24-20020a2e9cd8000000b002b9e53fe201mr7797671ljj.31.1692063555941; 
 Mon, 14 Aug 2023 18:39:15 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGV9gMFMYhpvMUSaLY6ajIPk4ODyZiXONCc6pO9mz1ObrqAZ9KtlbOpxv6Mr99R8+vFMAYSEVfBeVpAOHVICfA=
X-Received: by 2002:a2e:9cd8:0:b0:2b9:e53f:e201 with SMTP id
 g24-20020a2e9cd8000000b002b9e53fe201mr7797668ljj.31.1692063555739; Mon, 14
 Aug 2023 18:39:15 -0700 (PDT)
MIME-Version: 1.0
References: <20230811143423.3258788-1-i.maximets@ovn.org>
In-Reply-To: <20230811143423.3258788-1-i.maximets@ovn.org>
From: Jason Wang <jasowang@redhat.com>
Date: Tue, 15 Aug 2023 09:39:04 +0800
Message-ID: <CACGkMEv2Ut2gYTx+a20iX9fenvwbaV1XgKit07BCNaAzFrqgsg@mail.gmail.com>
Subject: Re: [PATCH v2] virtio: don't zero out memory region cache for
 indirect descriptors
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

On Fri, Aug 11, 2023 at 10:33=E2=80=AFPM Ilya Maximets <i.maximets@ovn.org>=
 wrote:
>
> Lots of virtio functions that are on a hot path in data transmission
> are initializing indirect descriptor cache at the point of stack
> allocation.  It's a 112 byte structure that is getting zeroed out on
> each call adding unnecessary overhead.  It's going to be correctly
> initialized later via special init function.  The only reason to
> actually initialize right away is the ability to safely destruct it.
> Replacing a designated initializer with a function to only initialize
> what is necessary.
>
> Removal of the unnecessary stack initializations improves throughput
> of virtio-net devices in terms of 64B packets per second by 6-14 %
> depending on the case.  Tested with a proposed af-xdp network backend
> and a dpdk testpmd application in the guest, but should be beneficial
> for other virtio devices as well.
>
> Signed-off-by: Ilya Maximets <i.maximets@ovn.org>

Acked-by: Jason Wang <jasowang@redhat.com>

Thanks

> ---
>
> Version 2:
>
>   * Introduced an initialization function, so we don't need to compare
>     pointers in the end. [Stefan]
>   * Removed the now unused macro. [Jason]
>
>  hw/virtio/virtio.c    | 20 +++++++++++++++-----
>  include/exec/memory.h | 16 +++++++++++++---
>  2 files changed, 28 insertions(+), 8 deletions(-)
>
> diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
> index 309038fd46..3d768fda5a 100644
> --- a/hw/virtio/virtio.c
> +++ b/hw/virtio/virtio.c
> @@ -1071,10 +1071,12 @@ static void virtqueue_split_get_avail_bytes(VirtQ=
ueue *vq,
>      VirtIODevice *vdev =3D vq->vdev;
>      unsigned int idx;
>      unsigned int total_bufs, in_total, out_total;
> -    MemoryRegionCache indirect_desc_cache =3D MEMORY_REGION_CACHE_INVALI=
D;
> +    MemoryRegionCache indirect_desc_cache;
>      int64_t len =3D 0;
>      int rc;
>
> +    address_space_cache_init_empty(&indirect_desc_cache);
> +
>      idx =3D vq->last_avail_idx;
>      total_bufs =3D in_total =3D out_total =3D 0;
>
> @@ -1207,12 +1209,14 @@ static void virtqueue_packed_get_avail_bytes(Virt=
Queue *vq,
>      VirtIODevice *vdev =3D vq->vdev;
>      unsigned int idx;
>      unsigned int total_bufs, in_total, out_total;
> +    MemoryRegionCache indirect_desc_cache;
>      MemoryRegionCache *desc_cache;
> -    MemoryRegionCache indirect_desc_cache =3D MEMORY_REGION_CACHE_INVALI=
D;
>      int64_t len =3D 0;
>      VRingPackedDesc desc;
>      bool wrap_counter;
>
> +    address_space_cache_init_empty(&indirect_desc_cache);
> +
>      idx =3D vq->last_avail_idx;
>      wrap_counter =3D vq->last_avail_wrap_counter;
>      total_bufs =3D in_total =3D out_total =3D 0;
> @@ -1487,7 +1491,7 @@ static void *virtqueue_split_pop(VirtQueue *vq, siz=
e_t sz)
>  {
>      unsigned int i, head, max;
>      VRingMemoryRegionCaches *caches;
> -    MemoryRegionCache indirect_desc_cache =3D MEMORY_REGION_CACHE_INVALI=
D;
> +    MemoryRegionCache indirect_desc_cache;
>      MemoryRegionCache *desc_cache;
>      int64_t len;
>      VirtIODevice *vdev =3D vq->vdev;
> @@ -1498,6 +1502,8 @@ static void *virtqueue_split_pop(VirtQueue *vq, siz=
e_t sz)
>      VRingDesc desc;
>      int rc;
>
> +    address_space_cache_init_empty(&indirect_desc_cache);
> +
>      RCU_READ_LOCK_GUARD();
>      if (virtio_queue_empty_rcu(vq)) {
>          goto done;
> @@ -1624,7 +1630,7 @@ static void *virtqueue_packed_pop(VirtQueue *vq, si=
ze_t sz)
>  {
>      unsigned int i, max;
>      VRingMemoryRegionCaches *caches;
> -    MemoryRegionCache indirect_desc_cache =3D MEMORY_REGION_CACHE_INVALI=
D;
> +    MemoryRegionCache indirect_desc_cache;
>      MemoryRegionCache *desc_cache;
>      int64_t len;
>      VirtIODevice *vdev =3D vq->vdev;
> @@ -1636,6 +1642,8 @@ static void *virtqueue_packed_pop(VirtQueue *vq, si=
ze_t sz)
>      uint16_t id;
>      int rc;
>
> +    address_space_cache_init_empty(&indirect_desc_cache);
> +
>      RCU_READ_LOCK_GUARD();
>      if (virtio_queue_packed_empty_rcu(vq)) {
>          goto done;
> @@ -3935,13 +3943,15 @@ VirtioQueueElement *qmp_x_query_virtio_queue_elem=
ent(const char *path,
>      } else {
>          unsigned int head, i, max;
>          VRingMemoryRegionCaches *caches;
> -        MemoryRegionCache indirect_desc_cache =3D MEMORY_REGION_CACHE_IN=
VALID;
> +        MemoryRegionCache indirect_desc_cache;
>          MemoryRegionCache *desc_cache;
>          VRingDesc desc;
>          VirtioRingDescList *list =3D NULL;
>          VirtioRingDescList *node;
>          int rc; int ndescs;
>
> +        address_space_cache_init_empty(&indirect_desc_cache);
> +
>          RCU_READ_LOCK_GUARD();
>
>          max =3D vq->vring.num;
> diff --git a/include/exec/memory.h b/include/exec/memory.h
> index 68284428f8..b1c4329d11 100644
> --- a/include/exec/memory.h
> +++ b/include/exec/memory.h
> @@ -2664,9 +2664,6 @@ struct MemoryRegionCache {
>      bool is_write;
>  };
>
> -#define MEMORY_REGION_CACHE_INVALID ((MemoryRegionCache) { .mrs.mr =3D N=
ULL })
> -
> -
>  /* address_space_ld*_cached: load from a cached #MemoryRegion
>   * address_space_st*_cached: store into a cached #MemoryRegion
>   *
> @@ -2755,6 +2752,19 @@ int64_t address_space_cache_init(MemoryRegionCache=
 *cache,
>                                   hwaddr len,
>                                   bool is_write);
>
> +/**
> + * address_space_cache_init_empty: Initialize empty #MemoryRegionCache
> + *
> + * @cache: The #MemoryRegionCache to operate on.
> + *
> + * Initializes #MemoryRegionCache structure without memory region attach=
ed.
> + * Cache initialized this way can only be safely destroyed, but not used=
.
> + */
> +static inline void address_space_cache_init_empty(MemoryRegionCache *cac=
he)
> +{
> +    cache->mrs.mr =3D NULL;
> +}
> +
>  /**
>   * address_space_cache_invalidate: complete a write to a #MemoryRegionCa=
che
>   *
> --
> 2.40.1
>



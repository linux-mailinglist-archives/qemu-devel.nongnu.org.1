Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3591E70E0A9
	for <lists+qemu-devel@lfdr.de>; Tue, 23 May 2023 17:35:43 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q1U2W-0004Un-7x; Tue, 23 May 2023 11:35:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1q1U2U-0004Ts-0Y
 for qemu-devel@nongnu.org; Tue, 23 May 2023 11:35:06 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1q1U2R-000307-Go
 for qemu-devel@nongnu.org; Tue, 23 May 2023 11:35:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1684856102;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=YbqPQ3+fddGwi2dK1pYjN9CNZiJ3tvsF6HMsXfU0cEc=;
 b=V6CRvKPXbtgvUezbb8wy6bANNV0O0XA90c+BWpCVwDLUQjA/Oc0xQ9+UfyjS9LNkmr7oOR
 9rmPy9dKK2GDJc9tOCclpT4y5OobVS2zuEpGKajpQBjat+5g4JCRxdW7jaD1poUfPbW4BC
 CkjXnfln+x8b9Jjly64rNMPvuNd7G0k=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-196-99pvuJRFOTyVanwntkrt3w-1; Tue, 23 May 2023 11:35:00 -0400
X-MC-Unique: 99pvuJRFOTyVanwntkrt3w-1
Received: by mail-qt1-f199.google.com with SMTP id
 d75a77b69052e-3f386bb966cso11611841cf.1
 for <qemu-devel@nongnu.org>; Tue, 23 May 2023 08:35:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684856100; x=1687448100;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YbqPQ3+fddGwi2dK1pYjN9CNZiJ3tvsF6HMsXfU0cEc=;
 b=dV1gqrUO11BFKL+RkUdiyyBMlJ2ngGUCyNdGsbyPcQ/pBTq9MtSGGWIM6RnjO9yAoe
 LP7LAY/s7F9bNadLuqt++batHAJ6pHgMbYGlTI0jp3T2QhnRjCoQlWwExlDLM5vQcK1Z
 72au9DdsSu6iiqUXrQdBGB1SYh1BN+91JqAES9EcbXJaCZcxomkhiJD+Of5czVBYBFT9
 TzlSx9tBI8UiAuJZYnhUISTj6U0mUBjDdUaFTXXTyvDRSfbZuZM5S7OwAdktb43idZ2q
 W+IUbKn6w7UgzcC1OiMCz1rbYVWCApZ7gG+lczXTtxrxH0EiyE+pzT0/lO7zzXy0YTmi
 unvA==
X-Gm-Message-State: AC+VfDxGP+YWOxm3NRtb08/wrHiJAhPPY8HFMvhFxrb02mrNCnoxow+z
 zst1S7oUrHUnotlESRgjCE8QVlETtu+1sadz1eP+Ir9aoWNyvhvJIueaSqY+tfzSjuXwTj8QvDy
 TaPEdVR7ivVH0CCM=
X-Received: by 2002:ac8:5908:0:b0:3f6:b330:4bfb with SMTP id
 8-20020ac85908000000b003f6b3304bfbmr7025390qty.0.1684856099761; 
 Tue, 23 May 2023 08:34:59 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ43Busx1dcdHeydyhU+AiJDyL5YfP6W7dIgi9ZPWEFl8BT34zFSs7fCsXvFVA/oVFrg0+u11g==
X-Received: by 2002:ac8:5908:0:b0:3f6:b330:4bfb with SMTP id
 8-20020ac85908000000b003f6b3304bfbmr7025359qty.0.1684856099412; 
 Tue, 23 May 2023 08:34:59 -0700 (PDT)
Received: from x1n (bras-base-aurron9127w-grc-62-70-24-86-62.dsl.bell.ca.
 [70.24.86.62]) by smtp.gmail.com with ESMTPSA id
 mm19-20020a0562145e9300b00623927281c2sm2850887qvb.40.2023.05.23.08.34.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 23 May 2023 08:34:58 -0700 (PDT)
Date: Tue, 23 May 2023 11:34:57 -0400
From: Peter Xu <peterx@redhat.com>
To: David Hildenbrand <david@redhat.com>
Cc: qemu-devel@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Tiwei Bie <tiwei.bie@intel.com>
Subject: Re: [PATCH v3 1/3] vhost: Rework memslot filtering and fix
 "used_memslot" tracking
Message-ID: <ZGzdIfLy+7rSh6fW@x1n>
References: <20230503172121.733642-1-david@redhat.com>
 <20230503172121.733642-2-david@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230503172121.733642-2-david@redhat.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
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

On Wed, May 03, 2023 at 07:21:19PM +0200, David Hildenbrand wrote:
> Having multiple vhost devices, some filtering out fd-less memslots and
> some not, can mess up the "used_memslot" accounting. Consequently our
> "free memslot" checks become unreliable and we might run out of free
> memslots at runtime later.
> 
> An example sequence which can trigger a potential issue that involves
> different vhost backends (vhost-kernel and vhost-user) and hotplugged
> memory devices can be found at [1].
> 
> Let's make the filtering mechanism less generic and distinguish between
> backends that support private memslots (without a fd) and ones that only
> support shared memslots (with a fd). Track the used_memslots for both
> cases separately and use the corresponding value when required.
> 
> Note: Most probably we should filter out MAP_PRIVATE fd-based RAM regions
> (for example, via memory-backend-memfd,...,shared=off or as default with
>  memory-backend-file) as well. When not using MAP_SHARED, it might not work
> as expected. Add a TODO for now.
> 
> [1] https://lkml.kernel.org/r/fad9136f-08d3-3fd9-71a1-502069c000cf@redhat.com
> 
> Fixes: 988a27754bbb ("vhost: allow backends to filter memory sections")
> Cc: Tiwei Bie <tiwei.bie@intel.com>
> Acked-by: Igor Mammedov <imammedo@redhat.com>
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>  hw/virtio/vhost-user.c            |  7 ++--
>  hw/virtio/vhost.c                 | 56 ++++++++++++++++++++++++++-----
>  include/hw/virtio/vhost-backend.h |  5 ++-
>  3 files changed, 52 insertions(+), 16 deletions(-)
> 
> diff --git a/hw/virtio/vhost-user.c b/hw/virtio/vhost-user.c
> index e5285df4ba..0c3e2702b1 100644
> --- a/hw/virtio/vhost-user.c
> +++ b/hw/virtio/vhost-user.c
> @@ -2453,10 +2453,9 @@ vhost_user_crypto_close_session(struct vhost_dev *dev, uint64_t session_id)
>      return 0;
>  }
>  
> -static bool vhost_user_mem_section_filter(struct vhost_dev *dev,
> -                                          MemoryRegionSection *section)
> +static bool vhost_user_no_private_memslots(struct vhost_dev *dev)
>  {
> -    return memory_region_get_fd(section->mr) >= 0;
> +    return true;
>  }
>  
>  static int vhost_user_get_inflight_fd(struct vhost_dev *dev,
> @@ -2686,6 +2685,7 @@ const VhostOps user_ops = {
>          .vhost_backend_init = vhost_user_backend_init,
>          .vhost_backend_cleanup = vhost_user_backend_cleanup,
>          .vhost_backend_memslots_limit = vhost_user_memslots_limit,
> +        .vhost_backend_no_private_memslots = vhost_user_no_private_memslots,
>          .vhost_set_log_base = vhost_user_set_log_base,
>          .vhost_set_mem_table = vhost_user_set_mem_table,
>          .vhost_set_vring_addr = vhost_user_set_vring_addr,
> @@ -2712,7 +2712,6 @@ const VhostOps user_ops = {
>          .vhost_set_config = vhost_user_set_config,
>          .vhost_crypto_create_session = vhost_user_crypto_create_session,
>          .vhost_crypto_close_session = vhost_user_crypto_close_session,
> -        .vhost_backend_mem_section_filter = vhost_user_mem_section_filter,
>          .vhost_get_inflight_fd = vhost_user_get_inflight_fd,
>          .vhost_set_inflight_fd = vhost_user_set_inflight_fd,
>          .vhost_dev_start = vhost_user_dev_start,
> diff --git a/hw/virtio/vhost.c b/hw/virtio/vhost.c
> index 746d130c74..4fe08c809f 100644
> --- a/hw/virtio/vhost.c
> +++ b/hw/virtio/vhost.c
> @@ -46,20 +46,33 @@
>  static struct vhost_log *vhost_log;
>  static struct vhost_log *vhost_log_shm;
>  
> +/* Memslots used by backends that support private memslots (without an fd). */
>  static unsigned int used_memslots;
> +
> +/* Memslots used by backends that only support shared memslots (with an fd). */
> +static unsigned int used_shared_memslots;

It's just that these vars are updated multiple times when >1 vhost is
there, accessing these fields are still a bit confusing - I think it's
implicitly protected by BQL so looks always safe.

Since we already have the shared/private handling, maybe for the long term
it'll be nicer to just keep such info per-device e.g. in vhost_dev so we
can also drop vhost_backend_no_private_memslots().  Anyway the code is
internal so can be done on top even if worthwhile.

> +
>  static QLIST_HEAD(, vhost_dev) vhost_devices =
>      QLIST_HEAD_INITIALIZER(vhost_devices);
>  
>  bool vhost_has_free_slot(void)
>  {
> -    unsigned int slots_limit = ~0U;
> +    unsigned int free = UINT_MAX;
>      struct vhost_dev *hdev;
>  
>      QLIST_FOREACH(hdev, &vhost_devices, entry) {
>          unsigned int r = hdev->vhost_ops->vhost_backend_memslots_limit(hdev);
> -        slots_limit = MIN(slots_limit, r);
> +        unsigned int cur_free;
> +
> +        if (hdev->vhost_ops->vhost_backend_no_private_memslots &&
> +            hdev->vhost_ops->vhost_backend_no_private_memslots(hdev)) {
> +            cur_free = r - used_shared_memslots;
> +        } else {
> +            cur_free = r - used_memslots;
> +        }
> +        free = MIN(free, cur_free);
>      }
> -    return slots_limit > used_memslots;
> +    return free > 1;

Should here be "free > 0" instead?

Trivial but maybe still matter when some device used exactly the size of
all memslots of a device..

Other than this the patch looks all good here.

Thanks,

-- 
Peter Xu



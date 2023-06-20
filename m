Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A8DEC736CBC
	for <lists+qemu-devel@lfdr.de>; Tue, 20 Jun 2023 15:06:33 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qBb3x-00064T-HI; Tue, 20 Jun 2023 09:06:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qBb3v-00063k-70
 for qemu-devel@nongnu.org; Tue, 20 Jun 2023 09:06:23 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qBb3t-0007Qr-FL
 for qemu-devel@nongnu.org; Tue, 20 Jun 2023 09:06:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1687266380;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=+LgAA4HwM44ajhK2No53qMe4gJeg+VFIVqX9nAAAZ04=;
 b=QLToNb4tSeRvzSG90WE7sL6fcs/M0EvIMYAv4E4i7H1LixcJe3yAAQ498Igs90P3LFN4+u
 j7rOGHUwsDaorxir3WvT9K5vG5qHca/VnuKiSlGrGr79MK3zQMykD8Kwcv9dOx5VIHnA9Z
 Aw4muukGKJR3h5KisgoLKaSZMJGPJJ4=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-644-rVFvUgpsOrScpLtJyqbxAQ-1; Tue, 20 Jun 2023 09:06:13 -0400
X-MC-Unique: rVFvUgpsOrScpLtJyqbxAQ-1
Received: by mail-lf1-f70.google.com with SMTP id
 2adb3069b0e04-4f5847463baso3443610e87.3
 for <qemu-devel@nongnu.org>; Tue, 20 Jun 2023 06:06:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687266364; x=1689858364;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+LgAA4HwM44ajhK2No53qMe4gJeg+VFIVqX9nAAAZ04=;
 b=H5X5rJdatx565+RlTYGmqZW3WgyLljmLwmE0sMuhRaqWSO/b6/a1SXEhWMN1JzT4wA
 9F4ZNO6k2go1NS0/GA9TxiVrMXLggo8NQ8xBCmEEvWqNgZNYMbSA6D47LKMOgiNYZ+qm
 MAYTU3p0M6+OObQu+ozF34SHoQ3IvZ80gFEuE3XGlZ1ibxa9zuRymDF98xW9bE6XQGda
 9SArnknX2j8jYpGh+31sk/63zxJXFNZd+Ib8V/9eOpclaYd5rxFdDS61wVgYpVOosYYj
 eclWe2CWEECPaxF/qdkcfrzUSCjBGUDL+WA1SExuLc2yANyw4EmbQFzJ8dLLa3OXPHXU
 SaGQ==
X-Gm-Message-State: AC+VfDxb+kvgwRgWtaKMEm01+3y11e9Yvb+laxPtYwk55Z+nazI8QcpG
 ZbXj+3qxGIlIlsBRCHd4SCz555qK6OesWZsWhLkD+2Di06M83+CMoA1xcb+Jxql6RVKBU1/GOc+
 7ct8UoqWQMu3TkgM=
X-Received: by 2002:ac2:5f9a:0:b0:4f8:631b:bf74 with SMTP id
 r26-20020ac25f9a000000b004f8631bbf74mr4380587lfe.38.1687266364554; 
 Tue, 20 Jun 2023 06:06:04 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ5xFEoqwu/beOj6NCQR7ivIPHNE5tI2kg4lzyFPNkth2E04WkQh+oBr9/fCyHKNOPFHDX+sUA==
X-Received: by 2002:ac2:5f9a:0:b0:4f8:631b:bf74 with SMTP id
 r26-20020ac25f9a000000b004f8631bbf74mr4380578lfe.38.1687266364177; 
 Tue, 20 Jun 2023 06:06:04 -0700 (PDT)
Received: from redhat.com ([2.52.15.156]) by smtp.gmail.com with ESMTPSA id
 e17-20020a5d5011000000b002c70ce264bfsm1965439wrt.76.2023.06.20.06.06.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 20 Jun 2023 06:06:03 -0700 (PDT)
Date: Tue, 20 Jun 2023 09:06:00 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: David Hildenbrand <david@redhat.com>
Cc: qemu-devel@nongnu.org, Juan Quintela <quintela@redhat.com>,
 Peter Xu <peterx@redhat.com>, Leonardo Bras <leobras@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
 Peng Tao <tao.peng@linux.alibaba.com>
Subject: Re: [PATCH v1 4/4] virtio-mem: Support "x-ignore-shared" migration
Message-ID: <20230620090527-mutt-send-email-mst@kernel.org>
References: <20230620130354.322180-1-david@redhat.com>
 <20230620130354.322180-5-david@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230620130354.322180-5-david@redhat.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Tue, Jun 20, 2023 at 03:03:54PM +0200, David Hildenbrand wrote:
> To achieve desired "x-ignore-shared" functionality, we should not
> discard all RAM when realizing the device and not mess with
> preallocation/postcopy when loading device state. In essence, we should
> not touch RAM content.
> 
> As "x-ignore-shared" gets set after realizing the device, we cannot
> rely on that. Let's simply skip discarding of RAM on incoming migration.
> Note that virtio_mem_post_load() will call
> virtio_mem_restore_unplugged() -- unless "x-ignore-shared" is set. So
> once migration finished we'll have a consistent state.
> 
> The initial system reset will also not discard any RAM, because
> virtio_mem_unplug_all() will not call virtio_mem_unplug_all() when no
> memory is plugged (which is the case before loading the device state).
> 
> Note that something like VM templating -- see commit b17fbbe55cba
> ("migration: allow private destination ram with x-ignore-shared") -- is
> currently incompatible with virtio-mem and ram_block_discard_range() will
> warn in case a private file mapping is supplied by virtio-mem.
> 
> For VM templating with virtio-mem, it makes more sense to either
> (a) Create the template without the virtio-mem device and hotplug a
>     virtio-mem device to the new VM instances using proper own memory
>     backend.
> (b) Use a virtio-mem device that doesn't provide any memory in the
>     template (requested-size=0) and use private anonymous memory.
> 
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>  hw/virtio/virtio-mem.c | 47 ++++++++++++++++++++++++++++++++++--------
>  1 file changed, 38 insertions(+), 9 deletions(-)
> 
> diff --git a/hw/virtio/virtio-mem.c b/hw/virtio/virtio-mem.c
> index 9f6169af32..b013dfbaf0 100644
> --- a/hw/virtio/virtio-mem.c
> +++ b/hw/virtio/virtio-mem.c
> @@ -18,6 +18,7 @@
>  #include "sysemu/numa.h"
>  #include "sysemu/sysemu.h"
>  #include "sysemu/reset.h"
> +#include "sysemu/runstate.h"
>  #include "hw/virtio/virtio.h"
>  #include "hw/virtio/virtio-bus.h"
>  #include "hw/virtio/virtio-access.h"
> @@ -886,11 +887,23 @@ static void virtio_mem_device_realize(DeviceState *dev, Error **errp)
>          return;
>      }
>  
> -    ret = ram_block_discard_range(rb, 0, qemu_ram_get_used_length(rb));
> -    if (ret) {
> -        error_setg_errno(errp, -ret, "Unexpected error discarding RAM");
> -        ram_block_coordinated_discard_require(false);
> -        return;
> +    /*
> +     * We don't know at this point whether shared RAM is migrated using
> +     * QEMU or migrated using the file content. "x-ignore-shared" will be
> +     * configurated

configurated == configured?

> after realizing the device. So in case we have an
> +     * incoming migration, simply always skip the discard step.
> +     *
> +     * Otherwise, make sure that we start with a clean slate: either the
> +     * memory backend might get reused or the shared file might still have
> +     * memory allocated.
> +     */
> +    if (!runstate_check(RUN_STATE_INMIGRATE)) {
> +        ret = ram_block_discard_range(rb, 0, qemu_ram_get_used_length(rb));
> +        if (ret) {
> +            error_setg_errno(errp, -ret, "Unexpected error discarding RAM");
> +            ram_block_coordinated_discard_require(false);
> +            return;
> +        }
>      }
>  
>      virtio_mem_resize_usable_region(vmem, vmem->requested_size, true);
> @@ -962,10 +975,6 @@ static int virtio_mem_post_load(void *opaque, int version_id)
>      RamDiscardListener *rdl;
>      int ret;
>  
> -    if (vmem->prealloc && !vmem->early_migration) {
> -        warn_report("Proper preallocation with migration requires a newer QEMU machine");
> -    }
> -
>      /*
>       * We started out with all memory discarded and our memory region is mapped
>       * into an address space. Replay, now that we updated the bitmap.
> @@ -978,6 +987,18 @@ static int virtio_mem_post_load(void *opaque, int version_id)
>          }
>      }
>  
> +    /*
> +     * If shared RAM is migrated using the file content and not using QEMU,
> +     * don't mess with preallocation and postcopy.
> +     */
> +    if (migrate_ram_is_ignored(vmem->memdev->mr.ram_block)) {
> +        return 0;
> +    }
> +
> +    if (vmem->prealloc && !vmem->early_migration) {
> +        warn_report("Proper preallocation with migration requires a newer QEMU machine");
> +    }
> +
>      if (migration_in_incoming_postcopy()) {
>          return 0;
>      }
> @@ -1010,6 +1031,14 @@ static int virtio_mem_post_load_early(void *opaque, int version_id)
>          return 0;
>      }
>  
> +    /*
> +     * If shared RAM is migrated using the file content and not using QEMU,
> +     * don't mess with preallocation and postcopy.
> +     */
> +    if (migrate_ram_is_ignored(rb)) {
> +        return 0;
> +    }
> +
>      /*
>       * We restored the bitmap and verified that the basic properties
>       * match on source and destination, so we can go ahead and preallocate
> -- 
> 2.40.1



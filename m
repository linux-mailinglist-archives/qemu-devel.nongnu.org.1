Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 09E82749A39
	for <lists+qemu-devel@lfdr.de>; Thu,  6 Jul 2023 13:07:03 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qHMob-0006lI-7I; Thu, 06 Jul 2023 07:06:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qHMoY-0006km-TU
 for qemu-devel@nongnu.org; Thu, 06 Jul 2023 07:06:22 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qHMoX-0000V4-4m
 for qemu-devel@nongnu.org; Thu, 06 Jul 2023 07:06:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1688641580;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=e5gaoWVnLaH3kx09mUJC8Xl0wG2g6k6R9JkgiUnIBFg=;
 b=V2/4V8RL+ZVLx8PjxJLYIVr9zpsOlIhs+ixkletNPba2BFdMrfxdus5CMPhFXXHXprAb7f
 B86rMeuEok9KMf+95qvhbt4hwx2OfHivEEux8Eln638BZ6DencJgqtUv/LOgiPOIywpysP
 wCrE9PtY6V4L9wecVezL00w+X9SoEWw=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-280-4ncdeJJ7PaO8A1SVObp6eA-1; Thu, 06 Jul 2023 07:06:19 -0400
X-MC-Unique: 4ncdeJJ7PaO8A1SVObp6eA-1
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-3f5df65f9f4so3485375e9.2
 for <qemu-devel@nongnu.org>; Thu, 06 Jul 2023 04:06:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688641578; x=1691233578;
 h=mime-version:message-id:date:reply-to:user-agent:references
 :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=e5gaoWVnLaH3kx09mUJC8Xl0wG2g6k6R9JkgiUnIBFg=;
 b=HOwMipaThFCVJtjjmGqD8Lu1P3l/48V5Vh0FHSoomjggOUkaFwYgiK7NSig0AWbnZb
 i4CGmeUUvteT4qdFC3B5yS8anEOEkShFhouxItdnndydHg+X6/8LOzEZgdChlkzbspc9
 msltVrKV61FmhBa+Ww2iglYP5cfQDGVszpU+MuGxCW/DefBufQuq289ue7i1OVlgg78x
 POqjICmYirvhguXYfyxYEy0h0fHvyb4+ujmDTc3RiOyJYxdwb1a1afs+2W0n6cywTgUc
 GRZFwwf7X4CLC3WOqt0PtakXuGKkfSIJ9SyyMqxaKgccvOEZ6+MMDMtUFsfWprbPaVKL
 CSNw==
X-Gm-Message-State: ABy/qLbxNiwe+N8ztWR1901eVd4VMjGrS6k5hAzB/+4K9GNTpU5kONNC
 X4Dwb1xfbphhT/5alLVrOKRcSNP+It5ZxEqgWhU5r2YHeQo5oQiXG4m9GF7bF4dZxq7baca5ZST
 6IqJh/Kr7yk29WZY=
X-Received: by 2002:a1c:4b16:0:b0:3fb:db66:8332 with SMTP id
 y22-20020a1c4b16000000b003fbdb668332mr1001162wma.40.1688641577836; 
 Thu, 06 Jul 2023 04:06:17 -0700 (PDT)
X-Google-Smtp-Source: APBJJlEpzbaCaQMmb4WN48HZKepNZqjmw7XlnJWfv7Ml25Z0ogb3TkLv+zIeDdzFNoF+3Qf2q98b9A==
X-Received: by 2002:a1c:4b16:0:b0:3fb:db66:8332 with SMTP id
 y22-20020a1c4b16000000b003fbdb668332mr1001142wma.40.1688641577487; 
 Thu, 06 Jul 2023 04:06:17 -0700 (PDT)
Received: from redhat.com (static-92-120-85-188.ipcom.comunitel.net.
 [188.85.120.92]) by smtp.gmail.com with ESMTPSA id
 v20-20020a05600c215400b003fb41491670sm4834386wml.24.2023.07.06.04.06.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 06 Jul 2023 04:06:16 -0700 (PDT)
From: Juan Quintela <quintela@redhat.com>
To: David Hildenbrand <david@redhat.com>
Cc: qemu-devel@nongnu.org,  "Michael S. Tsirkin" <mst@redhat.com>,  Peter Xu
 <peterx@redhat.com>,  Leonardo Bras <leobras@redhat.com>,  Paolo Bonzini
 <pbonzini@redhat.com>,  Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>,  Peng
 Tao <tao.peng@linux.alibaba.com>,  Mario Casquero <mcasquer@redhat.com>
Subject: Re: [PATCH v2 4/4] virtio-mem: Support "x-ignore-shared" migration
In-Reply-To: <20230706075612.67404-5-david@redhat.com> (David Hildenbrand's
 message of "Thu, 6 Jul 2023 09:56:09 +0200")
References: <20230706075612.67404-1-david@redhat.com>
 <20230706075612.67404-5-david@redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Date: Thu, 06 Jul 2023 13:06:16 +0200
Message-ID: <875y6xb8pj.fsf@secure.mitica>
MIME-Version: 1.0
Content-Type: text/plain
Received-SPF: pass client-ip=170.10.133.124; envelope-from=quintela@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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
Reply-To: quintela@redhat.com
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

David Hildenbrand <david@redhat.com> wrote:
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
> ("migration: allow private destination ram with x-ignore-shared")

And here I am, I reviewed the patch, and 4 years later I don't remember
anything about it O:-)

> -- is
> currently incompatible with virtio-mem and ram_block_discard_range() will
> warn in case a private file mapping is supplied by virtio-mem.

If it is incompatible, only a warning is not enough.

>
> For VM templating with virtio-mem, it makes more sense to either
> (a) Create the template without the virtio-mem device and hotplug a
>     virtio-mem device to the new VM instances using proper own memory
>     backend.
> (b) Use a virtio-mem device that doesn't provide any memory in the
>     template (requested-size=0) and use private anonymous memory.
>
> Tested-by: Mario Casquero <mcasquer@redhat.com>
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>  hw/virtio/virtio-mem.c | 47 ++++++++++++++++++++++++++++++++++--------
>  1 file changed, 38 insertions(+), 9 deletions(-)
>
> diff --git a/hw/virtio/virtio-mem.c b/hw/virtio/virtio-mem.c
> index a922c21380..3f41e00e74 100644
> --- a/hw/virtio/virtio-mem.c
> +++ b/hw/virtio/virtio-mem.c
> @@ -18,6 +18,7 @@
>  #include "sysemu/numa.h"
>  #include "sysemu/sysemu.h"
>  #include "sysemu/reset.h"
> +#include "sysemu/runstate.h"
>  #include "hw/virtio/virtio.h"
>  #include "hw/virtio/virtio-bus.h"
>  #include "hw/virtio/virtio-mem.h"
> @@ -901,11 +902,23 @@ static void virtio_mem_device_realize(DeviceState *dev, Error **errp)
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
> +     * configured after realizing the device. So in case we have an
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

Makes sense.

>  
>      virtio_mem_resize_usable_region(vmem, vmem->requested_size, true);
> @@ -977,10 +990,6 @@ static int virtio_mem_post_load(void *opaque, int version_id)
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
> @@ -993,6 +1002,18 @@ static int virtio_mem_post_load(void *opaque, int version_id)
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

Could you explain why you are putting the check after calling
virtio_mem_notify_populate_cb()?

What is it expected to for file memory backed RAM?  I got lost when I
saw that it just calls:

static int virtio_mem_notify_populate_cb(MemoryRegionSection *s, void *arg)
{
    RamDiscardListener *rdl = arg;

    return rdl->notify_populate(rdl, s);
}


I end in vfio, and got completely confused about what is going on there.


>      if (migration_in_incoming_postcopy()) {
>          return 0;
>      }
> @@ -1025,6 +1046,14 @@ static int virtio_mem_post_load_early(void *opaque, int version_id)
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

OK.

Thanks, Juan.



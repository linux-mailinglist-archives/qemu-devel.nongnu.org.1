Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 602147E2787
	for <lists+qemu-devel@lfdr.de>; Mon,  6 Nov 2023 15:48:45 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r00mI-00033B-Ct; Mon, 06 Nov 2023 09:40:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1r00mE-0002wu-0u
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 09:40:30 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1r00ly-0001d3-96
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 09:40:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1699281613;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4DEQQanmv+KfsX/nCYCk+Ahv1t8iHzPcAuTU+SbBouk=;
 b=ON5jWPXuwwS7iKbdxrgk3iqVRezNUzitwerrqyBU3ALWIQH1U0ZOlahIHPUj/BQ+UzBuAF
 Tv0jmSJaqfSe7msCgLjm8QJ5TkQnN1yLz4pPJ23x6TDMpH2BGNOmZ5q0qOgYE+ijJ5FVrf
 46golPprmiL01OxbQrRo89r0Gwvn7AY=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-491-_glMat_bMzCvQr2d3QqjWg-1; Mon, 06 Nov 2023 09:40:11 -0500
X-MC-Unique: _glMat_bMzCvQr2d3QqjWg-1
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-4083c9b426fso28387285e9.2
 for <qemu-devel@nongnu.org>; Mon, 06 Nov 2023 06:40:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699281610; x=1699886410;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=4DEQQanmv+KfsX/nCYCk+Ahv1t8iHzPcAuTU+SbBouk=;
 b=wBEa2Btk4dEE1bXitvs5hE04M2z/irijf78lR0Rxo0L3UeE2jPG3Kqec15JAa5sMRs
 W8Zc6WWvOPn6ms+eUbraCQ1aMU2h1IlWNOGFGT7pEAPex8B3nBNiUJ86cUGnmrjnPGVc
 zRX2ejHVk6h98AdMJ4Lpp8OfByulz3ErPJllvHO/mInxALz/6y4FlCH92PQg9TUhJHBr
 fvQeBiL/gcOc7kENM+zIs17r7d/HyuugtrmtxjbcPOCev/sPKZsOIZLo7hSuxtU4uVz4
 y2TnuG6Gi+j8/OioVGrLfaNZD79tWDlYw1FLlgtUNNeh2quX/MUYt2hNS3LXnSegxwOQ
 UEuA==
X-Gm-Message-State: AOJu0Yy+XMw9gb7YhGhqYny7zUeJ9Z+qd6Ro7tKwL5V3yckUMqJhBURX
 /MdC6TEnTSj86zV7GgF7sRQTIY/sNDllLgSsEKeXOdTt4LpHem9trTMcL8SzjScX+61unpoqgnM
 xvF8cnNLo+LRC+nc=
X-Received: by 2002:a05:600c:45c7:b0:409:7900:f3ef with SMTP id
 s7-20020a05600c45c700b004097900f3efmr5742447wmo.38.1699281610451; 
 Mon, 06 Nov 2023 06:40:10 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFtpDaxeOiCALrT7DJwP547tOoisLq10D3GIH0nYhOkNaKH9nPNZwZqs64bLkWsGPGkG5ThJQ==
X-Received: by 2002:a05:600c:45c7:b0:409:7900:f3ef with SMTP id
 s7-20020a05600c45c700b004097900f3efmr5742431wmo.38.1699281610032; 
 Mon, 06 Nov 2023 06:40:10 -0800 (PST)
Received: from ?IPV6:2003:cf:d718:8590:77de:e1fd:a4df:d080?
 (p200300cfd718859077dee1fda4dfd080.dip0.t-ipconnect.de.
 [2003:cf:d718:8590:77de:e1fd:a4df:d080])
 by smtp.gmail.com with ESMTPSA id
 i17-20020a05600c481100b004063d8b43e7sm12178421wmo.48.2023.11.06.06.40.09
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 06 Nov 2023 06:40:09 -0800 (PST)
Message-ID: <733d73da-f151-4cbd-843c-5c83419cda6c@redhat.com>
Date: Mon, 6 Nov 2023 15:40:08 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 09/10] block: Convert qmp_query_block() to coroutine_fn
Content-Language: en-US
To: Fabiano Rosas <farosas@suse.de>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, =?UTF-8?Q?Jo=C3=A3o_Silva?=
 <jsilva@suse.de>, Lin Ma <lma@suse.com>, Claudio Fontana <cfontana@suse.de>,
 Dario Faggioli <dfaggioli@suse.com>, Eric Blake <eblake@redhat.com>,
 "Dr. David Alan Gilbert" <dave@treblig.org>
References: <20230609201910.12100-1-farosas@suse.de>
 <20230609201910.12100-10-farosas@suse.de>
From: Hanna Czenczek <hreitz@redhat.com>
In-Reply-To: <20230609201910.12100-10-farosas@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=hreitz@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

On 09.06.23 22:19, Fabiano Rosas wrote:
> This is another caller of bdrv_get_allocated_file_size() that needs to
> be converted to a coroutine because that function will be made
> asynchronous when called (indirectly) from the QMP dispatcher.
>
> This QMP command is a candidate because it calls bdrv_do_query_node_info(),
> which in turn calls bdrv_get_allocated_file_size().
>
> We've determined bdrv_do_query_node_info() to be coroutine-safe (see
> previous commits), so we can just put this QMP command in a coroutine.
>
> Since qmp_query_block() now expects to run in a coroutine, its callers
> need to be converted as well. Convert hmp_info_block(), which calls
> only coroutine-safe code, including qmp_query_named_block_nodes()
> which has been converted to coroutine in the previous patches.
>
> Now that all callers of bdrv_[co_]block_device_info() are using the
> coroutine version, a few things happen:
>
>   - we can return to using bdrv_block_device_info() without a wrapper;
>
>   - bdrv_get_allocated_file_size() can stop being mixed;
>
>   - bdrv_co_get_allocated_file_size() needs to be put under the graph
>     lock because it is being called wthout the wrapper;

But bdrv_do_query_node_info() is marked GRAPH_RDLOCK, so the whole 
function must not be called without holding the lock.  I don’t 
understand why we need to explicitly take it another time.

>   - bdrv_do_query_node_info() doesn't need to acquire the AioContext
>     because it doesn't call aio_poll anymore;

In the past (very likely outdated, but still mentioning it) you’d need 
to take the AioContext just in general when operating on a block device 
that might be processed in a different AioContext than the main one, and 
the current code runs in the main context, i.e. which is the situation 
we have here.

Speaking of contexts, I wonder how the threading is actually supposed to 
work.  I assume QMP coroutines run in the main thread, so now we run 
bdrv_co_get_allocated_file_size() in the main thread – is that correct, 
or do we need to use bdrv_co_enter() like qmp_block_resize() does?  And 
so, if we run it in the main thread, is it OK not to acquire the 
AioContext around it to prevent interference from a potential I/O thread?

> Signed-off-by: Fabiano Rosas <farosas@suse.de>
> ---
>   block.c                        |  2 +-
>   block/monitor/block-hmp-cmds.c |  2 +-
>   block/qapi.c                   | 18 +++++++++---------
>   hmp-commands-info.hx           |  1 +
>   include/block/block-hmp-cmds.h |  2 +-
>   include/block/block-io.h       |  2 +-
>   include/block/qapi.h           | 12 ++++--------
>   qapi/block-core.json           |  2 +-
>   8 files changed, 19 insertions(+), 22 deletions(-)

This patch implicitly assumes that quite a lot of functions (at least 
bdrv_query_info(), bdrv_query_image_info(), bdrv_do_query_node_info()) 
are now run in coroutine context.  This assumption must be formalized by 
annotating them all with coroutine_fn, and ideally adding a _co_ into 
their name.

Also, those functions should be checked whether they call coroutine 
wrappers, and made to use the native coroutine version now if so. (At 
least I’d find that nicer, FWIW.)  I’ve seen at least bdrv_getlength() 
in bdrv_do_query_node_info(), which could be a bdrv_co_getlength().

> diff --git a/block.c b/block.c
> index abed744b60..f94cee8930 100644
> --- a/block.c
> +++ b/block.c
> @@ -6148,7 +6148,7 @@ BlockDeviceInfoList *bdrv_named_nodes_list(bool flat,
>   
>       list = NULL;
>       QTAILQ_FOREACH(bs, &graph_bdrv_states, node_list) {
> -        BlockDeviceInfo *info = bdrv_co_block_device_info(NULL, bs, flat, errp);
> +        BlockDeviceInfo *info = bdrv_block_device_info(NULL, bs, flat, errp);
>           if (!info) {
>               qapi_free_BlockDeviceInfoList(list);
>               return NULL;
> diff --git a/block/monitor/block-hmp-cmds.c b/block/monitor/block-hmp-cmds.c
> index 26116fe831..1049f9b006 100644
> --- a/block/monitor/block-hmp-cmds.c
> +++ b/block/monitor/block-hmp-cmds.c
> @@ -742,7 +742,7 @@ static void print_block_info(Monitor *mon, BlockInfo *info,
>       }
>   }
>   
> -void hmp_info_block(Monitor *mon, const QDict *qdict)
> +void coroutine_fn hmp_info_block(Monitor *mon, const QDict *qdict)
>   {
>       BlockInfoList *block_list, *info;
>       BlockDeviceInfoList *blockdev_list, *blockdev;
> diff --git a/block/qapi.c b/block/qapi.c
> index 20660e15d6..3b4bc0b782 100644
> --- a/block/qapi.c
> +++ b/block/qapi.c
> @@ -41,10 +41,10 @@
>   #include "qemu/qemu-print.h"
>   #include "sysemu/block-backend.h"
>   
> -BlockDeviceInfo *coroutine_fn bdrv_co_block_device_info(BlockBackend *blk,
> -                                                        BlockDriverState *bs,
> -                                                        bool flat,
> -                                                        Error **errp)
> +BlockDeviceInfo *coroutine_fn bdrv_block_device_info(BlockBackend *blk,
> +                                                     BlockDriverState *bs,
> +                                                     bool flat,
> +                                                     Error **errp)
>   {
>       ImageInfo **p_image_info;
>       ImageInfo *backing_info;
> @@ -235,8 +235,6 @@ static void bdrv_do_query_node_info(BlockDriverState *bs,
>       int ret;
>       Error *err = NULL;
>   
> -    aio_context_acquire(bdrv_get_aio_context(bs));
> -
>       size = bdrv_getlength(bs);
>       if (size < 0) {
>           error_setg_errno(errp, -size, "Can't get image size '%s'",
> @@ -249,7 +247,9 @@ static void bdrv_do_query_node_info(BlockDriverState *bs,
>       info->filename        = g_strdup(bs->filename);
>       info->format          = g_strdup(bdrv_get_format_name(bs));
>       info->virtual_size    = size;
> -    info->actual_size     = bdrv_get_allocated_file_size(bs);
> +    bdrv_graph_co_rdlock();
> +    info->actual_size     = bdrv_co_get_allocated_file_size(bs);
> +    bdrv_graph_co_rdunlock();
>       info->has_actual_size = info->actual_size >= 0;
>       if (bs->encrypted) {
>           info->encrypted = true;
> @@ -305,7 +305,7 @@ static void bdrv_do_query_node_info(BlockDriverState *bs,
>       }
>   
>   out:
> -    aio_context_release(bdrv_get_aio_context(bs));
> +    return;
>   }
>   
>   /**
> @@ -668,7 +668,7 @@ bdrv_query_bds_stats(BlockDriverState *bs, bool blk_level)
>       return s;
>   }
>   
> -BlockInfoList *qmp_query_block(Error **errp)
> +BlockInfoList *coroutine_fn qmp_query_block(Error **errp)
>   {
>       BlockInfoList *head = NULL, **p_next = &head;
>       BlockBackend *blk;
> diff --git a/hmp-commands-info.hx b/hmp-commands-info.hx
> index 47d63d26db..996895f417 100644
> --- a/hmp-commands-info.hx
> +++ b/hmp-commands-info.hx
> @@ -65,6 +65,7 @@ ERST
>           .help       = "show info of one block device or all block devices "
>                         "(-n: show named nodes; -v: show details)",
>           .cmd        = hmp_info_block,
> +        .coroutine  = true,
>       },
>   
>   SRST
> diff --git a/include/block/block-hmp-cmds.h b/include/block/block-hmp-cmds.h
> index 71113cd7ef..6d9152318f 100644
> --- a/include/block/block-hmp-cmds.h
> +++ b/include/block/block-hmp-cmds.h
> @@ -48,7 +48,7 @@ void hmp_eject(Monitor *mon, const QDict *qdict);
>   
>   void hmp_qemu_io(Monitor *mon, const QDict *qdict);
>   
> -void hmp_info_block(Monitor *mon, const QDict *qdict);
> +void coroutine_fn hmp_info_block(Monitor *mon, const QDict *qdict);
>   void hmp_info_blockstats(Monitor *mon, const QDict *qdict);
>   void hmp_info_block_jobs(Monitor *mon, const QDict *qdict);
>   void hmp_info_snapshots(Monitor *mon, const QDict *qdict);
> diff --git a/include/block/block-io.h b/include/block/block-io.h
> index f31e25cf56..43af816d75 100644
> --- a/include/block/block-io.h
> +++ b/include/block/block-io.h
> @@ -87,7 +87,7 @@ int64_t co_wrapper_mixed_bdrv_rdlock bdrv_getlength(BlockDriverState *bs);
>   int64_t coroutine_fn GRAPH_RDLOCK
>   bdrv_co_get_allocated_file_size(BlockDriverState *bs);
>   
> -int64_t co_wrapper_mixed_bdrv_rdlock
> +int64_t co_wrapper_bdrv_rdlock
>   bdrv_get_allocated_file_size(BlockDriverState *bs);
>   
>   BlockMeasureInfo *bdrv_measure(BlockDriver *drv, QemuOpts *opts,
> diff --git a/include/block/qapi.h b/include/block/qapi.h
> index 5cb0202791..c37cba2a09 100644
> --- a/include/block/qapi.h
> +++ b/include/block/qapi.h
> @@ -30,14 +30,10 @@
>   #include "block/snapshot.h"
>   #include "qapi/qapi-types-block-core.h"
>   
> -BlockDeviceInfo *coroutine_fn bdrv_co_block_device_info(BlockBackend *blk,
> -                                                        BlockDriverState *bs,
> -                                                        bool flat,
> -                                                        Error **errp);
> -BlockDeviceInfo *co_wrapper bdrv_block_device_info(BlockBackend *blk,
> -                                                   BlockDriverState *bs,
> -                                                   bool flat,
> -                                                   Error **errp);
> +BlockDeviceInfo *coroutine_fn bdrv_block_device_info(BlockBackend *blk,
> +                                                     BlockDriverState *bs,
> +                                                     bool flat,
> +                                                     Error **errp);

As noted in general above, please continue to call it 
bdrv_co_block_device_info(), though.  (I think) coroutine_fn functions 
should have a _co_ in them, except when that’s really not possible (i.e. 
when they’re QMP handlers).

Hanna

>   int bdrv_query_snapshot_info_list(BlockDriverState *bs,
>                                     SnapshotInfoList **p_list,
>                                     Error **errp);
> diff --git a/qapi/block-core.json b/qapi/block-core.json
> index 9d4c92f2c9..a78dc92493 100644
> --- a/qapi/block-core.json
> +++ b/qapi/block-core.json
> @@ -838,7 +838,7 @@
>   #    }
>   ##
>   { 'command': 'query-block', 'returns': ['BlockInfo'],
> -  'allow-preconfig': true }
> +  'allow-preconfig': true, 'coroutine': true }
>   
>   ##
>   # @BlockDeviceTimedStats:



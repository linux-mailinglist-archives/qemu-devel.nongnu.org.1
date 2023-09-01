Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 83F9779010A
	for <lists+qemu-devel@lfdr.de>; Fri,  1 Sep 2023 19:03:17 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qc7Wv-0008Kd-F2; Fri, 01 Sep 2023 13:01:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1qc7Wt-0008K4-24
 for qemu-devel@nongnu.org; Fri, 01 Sep 2023 13:01:55 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1qc7Wk-0001jg-Tv
 for qemu-devel@nongnu.org; Fri, 01 Sep 2023 13:01:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1693587705;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=JxHEtYkT3GBxvRQxXoP0Vc6Ymh4t0iBJmh64oEadsmM=;
 b=ZNi9g/Erngj28SLx6isNJNuksuoLwekb1euA1kogHt/ESt0nQ3yVW3YJkb3uFAwzAmS/kL
 ba0TeVFrfXrOc/9ErOvGBlHCYqjCzqfpCgw6MTIexO86Ekbc3ILNsWaFwaxXShi6frLZAU
 3n//5eWPdYIC2urNum8QivqDjTEeEf0=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-611--jfb-kpdMAW2W7xu9Q8Qbw-1; Fri, 01 Sep 2023 13:01:42 -0400
X-MC-Unique: -jfb-kpdMAW2W7xu9Q8Qbw-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com
 [10.11.54.9])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id E02BC3C0EAA1;
 Fri,  1 Sep 2023 17:01:41 +0000 (UTC)
Received: from redhat.com (unknown [10.39.193.166])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id E593A493110;
 Fri,  1 Sep 2023 17:01:38 +0000 (UTC)
Date: Fri, 1 Sep 2023 19:01:37 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: qemu-devel@nongnu.org,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 Hanna Reitz <hreitz@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-block@nongnu.org,
 Klaus Jensen <its@irrelevant.dk>, John Snow <jsnow@redhat.com>,
 Cleber Rosa <crosa@redhat.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
 Keith Busch <kbusch@kernel.org>,
 David Hildenbrand <david@redhat.com>, Peter Xu <peterx@redhat.com>,
 Fam Zheng <fam@euphon.net>
Subject: Re: [PATCH v2 4/4] block-coroutine-wrapper: use
 qemu_get_current_aio_context()
Message-ID: <ZPIY8UzEeRrpM1rp@redhat.com>
References: <20230823235938.1398382-1-stefanha@redhat.com>
 <20230823235938.1398382-5-stefanha@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230823235938.1398382-5-stefanha@redhat.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.9
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kwolf@redhat.com;
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

Am 24.08.2023 um 01:59 hat Stefan Hajnoczi geschrieben:
> Use qemu_get_current_aio_context() in mixed wrappers and coroutine
> wrappers so that code runs in the caller's AioContext instead of moving
> to the BlockDriverState's AioContext. This change is necessary for the
> multi-queue block layer where any thread can call into the block layer.
> 
> Most wrappers are IO_CODE where it's safe to use the current AioContext
> nowadays. BlockDrivers and the core block layer use their own locks and
> no longer depend on the AioContext lock for thread-safety.
> 
> The bdrv_create() wrapper invokes GLOBAL_STATE code. Using the current
> AioContext is safe because this code is only called with the BQL held
> from the main loop thread.
> 
> The output of qemu-iotests 051 is sensitive to event loop activity.
> Update the output because the monitor BH runs at a different time,
> causing prompts to be printed differently in the output.
> 
> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>

The update for 051 is actually missing from this patch, and so the test
fails.

I missed the dependency on your qio_channel series, so 281 ran into an
abort() for me (see below for the stack trace). I expect that the other
series actually fixes this, but this kind of interaction wasn't really
obvious. How did you make sure that there aren't other places that don't
like this change?

Kevin

(gdb) bt
#0  0x00007f8ef0d2fe5c in __pthread_kill_implementation () at /lib64/libc.so.6
#1  0x00007f8ef0cdfa76 in raise () at /lib64/libc.so.6
#2  0x00007f8ef0cc97fc in abort () at /lib64/libc.so.6
#3  0x00007f8ef0cc971b in _nl_load_domain.cold () at /lib64/libc.so.6
#4  0x00007f8ef0cd8656 in  () at /lib64/libc.so.6
#5  0x000055fd19da6af3 in qio_channel_yield (ioc=0x7f8ee0000b70, condition=G_IO_IN) at ../io/channel.c:583
#6  0x000055fd19e0382f in nbd_read_eof (bs=0x55fd1b681350, ioc=0x7f8ee0000b70, buffer=0x55fd1b680da0, size=4, errp=0x0) at ../nbd/client.c:1454
#7  0x000055fd19e03612 in nbd_receive_reply (bs=0x55fd1b681350, ioc=0x7f8ee0000b70, reply=0x55fd1b680da0, errp=0x0) at ../nbd/client.c:1491
#8  0x000055fd19e40575 in nbd_receive_replies (s=0x55fd1b680b00, cookie=1) at ../block/nbd.c:461
#9  0x000055fd19e3fec4 in nbd_co_do_receive_one_chunk
    (s=0x55fd1b680b00, cookie=1, only_structured=true, request_ret=0x7f8ee8bff91c, qiov=0x7f8ee8bfff10, payload=0x7f8ee8bff9d0, errp=0x7f8ee8bff910) at ../block/nbd.c:844
#10 0x000055fd19e3fd55 in nbd_co_receive_one_chunk
    (s=0x55fd1b680b00, cookie=1, only_structured=true, request_ret=0x7f8ee8bff91c, qiov=0x7f8ee8bfff10, reply=0x7f8ee8bff9f0, payload=0x7f8ee8bff9d0, errp=0x7f8ee8bff910)
    at ../block/nbd.c:925
#11 0x000055fd19e3f7b5 in nbd_reply_chunk_iter_receive (s=0x55fd1b680b00, iter=0x7f8ee8bff9d8, cookie=1, qiov=0x7f8ee8bfff10, reply=0x7f8ee8bff9f0, payload=0x7f8ee8bff9d0)
    at ../block/nbd.c:1008
#12 0x000055fd19e3ecf7 in nbd_co_receive_cmdread_reply (s=0x55fd1b680b00, cookie=1, offset=0, qiov=0x7f8ee8bfff10, request_ret=0x7f8ee8bffad4, errp=0x7f8ee8bffac8) at ../block/nbd.c:1074
#13 0x000055fd19e3c804 in nbd_client_co_preadv (bs=0x55fd1b681350, offset=0, bytes=131072, qiov=0x7f8ee8bfff10, flags=0) at ../block/nbd.c:1258
#14 0x000055fd19e33547 in bdrv_driver_preadv (bs=0x55fd1b681350, offset=0, bytes=131072, qiov=0x7f8ee8bfff10, qiov_offset=0, flags=0) at ../block/io.c:1005
#15 0x000055fd19e2c8bb in bdrv_aligned_preadv (child=0x55fd1c282d90, req=0x7f8ee8bffd90, offset=0, bytes=131072, align=1, qiov=0x7f8ee8bfff10, qiov_offset=0, flags=0) at ../block/io.c:1398
#16 0x000055fd19e2bf7d in bdrv_co_preadv_part (child=0x55fd1c282d90, offset=0, bytes=131072, qiov=0x7f8ee8bfff10, qiov_offset=0, flags=0) at ../block/io.c:1815
#17 0x000055fd19e176bd in blk_co_do_preadv_part (blk=0x55fd1c269c00, offset=0, bytes=131072, qiov=0x7f8ee8bfff10, qiov_offset=0, flags=0) at ../block/block-backend.c:1344
#18 0x000055fd19e17588 in blk_co_preadv (blk=0x55fd1c269c00, offset=0, bytes=131072, qiov=0x7f8ee8bfff10, flags=0) at ../block/block-backend.c:1369
#19 0x000055fd19e17514 in blk_co_pread (blk=0x55fd1c269c00, offset=0, bytes=131072, buf=0x55fd1c16d000, flags=0) at ../block/block-backend.c:1358
#20 0x000055fd19ddcc91 in blk_co_pread_entry (opaque=0x7ffc4bbdd9a0) at block/block-gen.c:1519
#21 0x000055fd19feb2a1 in coroutine_trampoline (i0=460835072, i1=22013) at ../util/coroutine-ucontext.c:177
#22 0x00007f8ef0cf5c20 in __start_context () at /lib64/libc.so.6

io/channel.c:583 is this:

577 void coroutine_fn qio_channel_yield(QIOChannel *ioc,
578                                     GIOCondition condition)
579 {
580     AioContext *ioc_ctx = ioc->ctx ?: qemu_get_aio_context();
581
582     assert(qemu_in_coroutine());
583     assert(in_aio_context_home_thread(ioc_ctx));
584



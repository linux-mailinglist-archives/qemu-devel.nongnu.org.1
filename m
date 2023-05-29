Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 99F8E7146A9
	for <lists+qemu-devel@lfdr.de>; Mon, 29 May 2023 10:52:21 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q3Yal-0007fA-4o; Mon, 29 May 2023 04:51:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1q3Yac-0007bo-BC
 for qemu-devel@nongnu.org; Mon, 29 May 2023 04:50:55 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1q3YaY-0004jE-P1
 for qemu-devel@nongnu.org; Mon, 29 May 2023 04:50:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1685350249;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=lzKl+ULfTc+HsRslEfywwM+DpjvalmbzGtSUSdUPWng=;
 b=jVZ8PhYKvH698nV5TqP1ssPNohlGS95C2+/OIQIupA54uJWrjWQIHLypVG8qU0d59Fn2hE
 s2RvpDkoSjQgEddSOjnRiMQRsFREmGtaL0sqpK1H/Vqn+myFbKvYiTWHTUS/9C6Z80o9p2
 oxz3PCzbZd5H088u0r/TKyX06oanZK4=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-622-F8wWW9GCOmOBfZ_t44xvCw-1; Mon, 29 May 2023 04:50:47 -0400
X-MC-Unique: F8wWW9GCOmOBfZ_t44xvCw-1
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-3f60481749eso16155385e9.1
 for <qemu-devel@nongnu.org>; Mon, 29 May 2023 01:50:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685350246; x=1687942246;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lzKl+ULfTc+HsRslEfywwM+DpjvalmbzGtSUSdUPWng=;
 b=CjMBqxmWTm0Lv3axCtpzmaghN/IB5Mt7y6eiBGlCocciA/7r86gckJWP9igVWMCXte
 7r8HTNptv9wUhBkgv+bXBWmD9ejXpSX3jJwiX+UlEqKWR9SfWud4Eyn/qTy5zCjNC7O8
 slqmiMf5vS22omJbB67YpvkN5pYDzfrEMAAN3mwfqHvfsiCggNzAwZCR0DbXGFKqwoYD
 vD8jmie1WE7vIfL2QOENc3syLV9gDiFFDSJ12mdwumQiJul0NMef7hHhe5TAcjhtbaUm
 n6ZV/Y0Xn+35/Q1ESNj6JA3t3X1+emB1xqPjLQ2oWbz7f0oLS4707c450AgYdkGRCkLX
 cJdA==
X-Gm-Message-State: AC+VfDzZo+cqVWwR/GV91yaxSzIVXMsBX8z3bgELPio9gXVRokst4A+D
 dmcQL5P0SIzJkZmQqrjISkGUExKFKPJuuV+8Egdo2ffAAkonqWOvh9sQ+qblQcmMvXp15ghXjxi
 i4rh5L7Li0sM3KxE=
X-Received: by 2002:a05:600c:3d0d:b0:3f6:eae:7417 with SMTP id
 bh13-20020a05600c3d0d00b003f60eae7417mr6312384wmb.1.1685350246480; 
 Mon, 29 May 2023 01:50:46 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ7f6ydC3WQoJ5To9rb9W4gLmOML/1z0QINwg7VZr8e+1JLO+IwB0Gh6MUE4/gSFzctkGKbI+A==
X-Received: by 2002:a05:600c:3d0d:b0:3f6:eae:7417 with SMTP id
 bh13-20020a05600c3d0d00b003f60eae7417mr6312372wmb.1.1685350246121; 
 Mon, 29 May 2023 01:50:46 -0700 (PDT)
Received: from sgarzare-redhat (host-87-12-25-16.business.telecomitalia.it.
 [87.12.25.16]) by smtp.gmail.com with ESMTPSA id
 y8-20020a7bcd88000000b003f6038faa19sm16812744wmj.19.2023.05.29.01.50.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 29 May 2023 01:50:45 -0700 (PDT)
Date: Mon, 29 May 2023 10:50:34 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: qemu-devel@nongnu.org, Aarushi Mehta <mehta.aaru20@gmail.com>, 
 "Michael S. Tsirkin" <mst@redhat.com>, Julia Suvorova <jusual@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 Stefano Stabellini <sstabellini@kernel.org>, Paul Durrant <paul@xen.org>,
 Hanna Reitz <hreitz@redhat.com>, 
 Kevin Wolf <kwolf@redhat.com>, Fam Zheng <fam@euphon.net>,
 xen-devel@lists.xenproject.org, 
 eblake@redhat.com, Anthony Perard <anthony.perard@citrix.com>, 
 qemu-block@nongnu.org
Subject: Re: [PATCH v2 5/6] block/linux-aio: convert to blk_io_plug_call() API
Message-ID: <63lutuyufibun4jscbjjlshbqqw6otetzfi67rfnfrxacwutnj@igewwxh4uwys>
References: <20230523171300.132347-1-stefanha@redhat.com>
 <20230523171300.132347-6-stefanha@redhat.com>
 <n6hik7dbl26lomhxvfal2kjrq6jhdiknjepb372dvxavuwiw6q@3l3mo4eywoxq>
 <20230524193634.GB17357@fedora>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20230524193634.GB17357@fedora>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=sgarzare@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.164,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On Wed, May 24, 2023 at 03:36:34PM -0400, Stefan Hajnoczi wrote:
>On Wed, May 24, 2023 at 10:52:03AM +0200, Stefano Garzarella wrote:
>> On Tue, May 23, 2023 at 01:12:59PM -0400, Stefan Hajnoczi wrote:
>> > Stop using the .bdrv_co_io_plug() API because it is not multi-queue
>> > block layer friendly. Use the new blk_io_plug_call() API to batch I/O
>> > submission instead.
>> >
>> > Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
>> > Reviewed-by: Eric Blake <eblake@redhat.com>
>> > ---
>> > include/block/raw-aio.h |  7 -------
>> > block/file-posix.c      | 28 ----------------------------
>> > block/linux-aio.c       | 41 +++++++++++------------------------------
>> > 3 files changed, 11 insertions(+), 65 deletions(-)
>> >
>> > diff --git a/include/block/raw-aio.h b/include/block/raw-aio.h
>> > index da60ca13ef..0f63c2800c 100644
>> > --- a/include/block/raw-aio.h
>> > +++ b/include/block/raw-aio.h
>> > @@ -62,13 +62,6 @@ int coroutine_fn laio_co_submit(int fd, uint64_t offset, QEMUIOVector *qiov,
>> >
>> > void laio_detach_aio_context(LinuxAioState *s, AioContext *old_context);
>> > void laio_attach_aio_context(LinuxAioState *s, AioContext *new_context);
>> > -
>> > -/*
>> > - * laio_io_plug/unplug work in the thread's current AioContext, therefore the
>> > - * caller must ensure that they are paired in the same IOThread.
>> > - */
>> > -void laio_io_plug(void);
>> > -void laio_io_unplug(uint64_t dev_max_batch);
>> > #endif
>> > /* io_uring.c - Linux io_uring implementation */
>> > #ifdef CONFIG_LINUX_IO_URING
>> > diff --git a/block/file-posix.c b/block/file-posix.c
>> > index 7baa8491dd..ac1ed54811 100644
>> > --- a/block/file-posix.c
>> > +++ b/block/file-posix.c
>> > @@ -2550,26 +2550,6 @@ static int coroutine_fn raw_co_pwritev(BlockDriverState *bs, int64_t offset,
>> >     return raw_co_prw(bs, offset, bytes, qiov, QEMU_AIO_WRITE);
>> > }
>> >
>> > -static void coroutine_fn raw_co_io_plug(BlockDriverState *bs)
>> > -{
>> > -    BDRVRawState __attribute__((unused)) *s = bs->opaque;
>> > -#ifdef CONFIG_LINUX_AIO
>> > -    if (s->use_linux_aio) {
>> > -        laio_io_plug();
>> > -    }
>> > -#endif
>> > -}
>> > -
>> > -static void coroutine_fn raw_co_io_unplug(BlockDriverState *bs)
>> > -{
>> > -    BDRVRawState __attribute__((unused)) *s = bs->opaque;
>> > -#ifdef CONFIG_LINUX_AIO
>> > -    if (s->use_linux_aio) {
>> > -        laio_io_unplug(s->aio_max_batch);
>> > -    }
>> > -#endif
>> > -}
>> > -
>> > static int coroutine_fn raw_co_flush_to_disk(BlockDriverState *bs)
>> > {
>> >     BDRVRawState *s = bs->opaque;
>> > @@ -3914,8 +3894,6 @@ BlockDriver bdrv_file = {
>> >     .bdrv_co_copy_range_from = raw_co_copy_range_from,
>> >     .bdrv_co_copy_range_to  = raw_co_copy_range_to,
>> >     .bdrv_refresh_limits = raw_refresh_limits,
>> > -    .bdrv_co_io_plug        = raw_co_io_plug,
>> > -    .bdrv_co_io_unplug      = raw_co_io_unplug,
>> >     .bdrv_attach_aio_context = raw_aio_attach_aio_context,
>> >
>> >     .bdrv_co_truncate                   = raw_co_truncate,
>> > @@ -4286,8 +4264,6 @@ static BlockDriver bdrv_host_device = {
>> >     .bdrv_co_copy_range_from = raw_co_copy_range_from,
>> >     .bdrv_co_copy_range_to  = raw_co_copy_range_to,
>> >     .bdrv_refresh_limits = raw_refresh_limits,
>> > -    .bdrv_co_io_plug        = raw_co_io_plug,
>> > -    .bdrv_co_io_unplug      = raw_co_io_unplug,
>> >     .bdrv_attach_aio_context = raw_aio_attach_aio_context,
>> >
>> >     .bdrv_co_truncate                   = raw_co_truncate,
>> > @@ -4424,8 +4400,6 @@ static BlockDriver bdrv_host_cdrom = {
>> >     .bdrv_co_pwritev        = raw_co_pwritev,
>> >     .bdrv_co_flush_to_disk  = raw_co_flush_to_disk,
>> >     .bdrv_refresh_limits    = cdrom_refresh_limits,
>> > -    .bdrv_co_io_plug        = raw_co_io_plug,
>> > -    .bdrv_co_io_unplug      = raw_co_io_unplug,
>> >     .bdrv_attach_aio_context = raw_aio_attach_aio_context,
>> >
>> >     .bdrv_co_truncate                   = raw_co_truncate,
>> > @@ -4552,8 +4526,6 @@ static BlockDriver bdrv_host_cdrom = {
>> >     .bdrv_co_pwritev        = raw_co_pwritev,
>> >     .bdrv_co_flush_to_disk  = raw_co_flush_to_disk,
>> >     .bdrv_refresh_limits    = cdrom_refresh_limits,
>> > -    .bdrv_co_io_plug        = raw_co_io_plug,
>> > -    .bdrv_co_io_unplug      = raw_co_io_unplug,
>> >     .bdrv_attach_aio_context = raw_aio_attach_aio_context,
>> >
>> >     .bdrv_co_truncate                   = raw_co_truncate,
>> > diff --git a/block/linux-aio.c b/block/linux-aio.c
>> > index 442c86209b..5021aed68f 100644
>> > --- a/block/linux-aio.c
>> > +++ b/block/linux-aio.c
>> > @@ -15,6 +15,7 @@
>> > #include "qemu/event_notifier.h"
>> > #include "qemu/coroutine.h"
>> > #include "qapi/error.h"
>> > +#include "sysemu/block-backend.h"
>> >
>> > /* Only used for assertions.  */
>> > #include "qemu/coroutine_int.h"
>> > @@ -46,7 +47,6 @@ struct qemu_laiocb {
>> > };
>> >
>> > typedef struct {
>> > -    int plugged;
>> >     unsigned int in_queue;
>> >     unsigned int in_flight;
>> >     bool blocked;
>> > @@ -236,7 +236,7 @@ static void qemu_laio_process_completions_and_submit(LinuxAioState *s)
>> > {
>> >     qemu_laio_process_completions(s);
>> >
>> > -    if (!s->io_q.plugged && !QSIMPLEQ_EMPTY(&s->io_q.pending)) {
>> > +    if (!QSIMPLEQ_EMPTY(&s->io_q.pending)) {
>> >         ioq_submit(s);
>> >     }
>> > }
>> > @@ -277,7 +277,6 @@ static void qemu_laio_poll_ready(EventNotifier *opaque)
>> > static void ioq_init(LaioQueue *io_q)
>> > {
>> >     QSIMPLEQ_INIT(&io_q->pending);
>> > -    io_q->plugged = 0;
>> >     io_q->in_queue = 0;
>> >     io_q->in_flight = 0;
>> >     io_q->blocked = false;
>> > @@ -354,31 +353,11 @@ static uint64_t laio_max_batch(LinuxAioState *s, uint64_t dev_max_batch)
>> >     return max_batch;
>> > }
>> >
>> > -void laio_io_plug(void)
>> > +static void laio_unplug_fn(void *opaque)
>> > {
>> > -    AioContext *ctx = qemu_get_current_aio_context();
>> > -    LinuxAioState *s = aio_get_linux_aio(ctx);
>> > +    LinuxAioState *s = opaque;
>> >
>> > -    s->io_q.plugged++;
>> > -}
>> > -
>> > -void laio_io_unplug(uint64_t dev_max_batch)
>> > -{
>> > -    AioContext *ctx = qemu_get_current_aio_context();
>> > -    LinuxAioState *s = aio_get_linux_aio(ctx);
>> > -
>> > -    assert(s->io_q.plugged);
>> > -    s->io_q.plugged--;
>> > -
>> > -    /*
>> > -     * Why max batch checking is performed here:
>> > -     * Another BDS may have queued requests with a higher dev_max_batch and
>> > -     * therefore in_queue could now exceed our dev_max_batch. Re-check the max
>> > -     * batch so we can honor our device's dev_max_batch.
>> > -     */
>> > -    if (s->io_q.in_queue >= laio_max_batch(s, dev_max_batch) ||
>>
>> Why are we removing this condition?
>> Could the same situation occur with the new API?
>
>The semantics of unplug_fn() are different from .bdrv_co_unplug():
>1. unplug_fn() is only called when the last blk_io_unplug() call occurs,
>   not every time blk_io_unplug() is called.
>2. unplug_fn() is per-thread, not per-BlockDriverState, so there is no
>   way to get per-BlockDriverState fields like dev_max_batch.
>
>Therefore this condition cannot be moved to laio_unplug_fn().

I see now.

>
>How important is this condition? I believe that dropping it does not
>have much of an effect but maybe I missed something.

With Kevin we agreed to add it to avoid extra latency in some devices,
but we didn't do much testing on this.

IIRC what solved the performance degradation was the check in
laio_do_submit() that we still have after this changes.

So it may not have much effect, but maybe it's worth mentioning in
the commit description.

>
>Also, does it make sense to define per-BlockDriverState batching limits
>when the AIO engine (Linux AIO or io_uring) is thread-local and shared
>between all BlockDriverStates? I believe the fundamental reason (that we
>discovered later) why dev_max_batch is effective is because the Linux
>kernel processes 32 I/O request submissions at a time. Anything above 32
>adds latency without a batching benefit.

This is a good point, maybe we should confirm it with some tests though.

Thanks,
Stefano



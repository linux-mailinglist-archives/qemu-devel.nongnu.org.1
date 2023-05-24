Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 558CD70F029
	for <lists+qemu-devel@lfdr.de>; Wed, 24 May 2023 10:06:38 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q1jVP-0006II-U2; Wed, 24 May 2023 04:05:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1q1jVN-0006HO-1A
 for qemu-devel@nongnu.org; Wed, 24 May 2023 04:05:57 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1q1jVL-00013o-8C
 for qemu-devel@nongnu.org; Wed, 24 May 2023 04:05:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1684915554;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=4D41eFNvy0+kPQfc9V8H+rhjCzgj7odAxqq3xoeOmEs=;
 b=I2chZDsBHaFbKQfQczOovqRmEYsc+CSiwvSxA8EoEUDcAN0S89laA8v+qSK6IXKA8Gf9w8
 inqfNXKN35GISZwrbwO1FihETqsEnmyEMadyMqJjUz+0gNACym0ZQeIbYSBYXyO9hX/45L
 h2bSTOv8yq4bAfpIaMZmCQRnIQ9RKRY=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-287-dBziRzw9Oli_4UR19W51LQ-1; Wed, 24 May 2023 04:05:52 -0400
X-MC-Unique: dBziRzw9Oli_4UR19W51LQ-1
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-3f60481749eso3824575e9.1
 for <qemu-devel@nongnu.org>; Wed, 24 May 2023 01:05:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684915552; x=1687507552;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4D41eFNvy0+kPQfc9V8H+rhjCzgj7odAxqq3xoeOmEs=;
 b=EtaMROxh9V1/QiiTTBRselB4r/+/MfX+2K1b2mWyaRvQdOqeEAcuieRJIJtyzqzA5p
 dHDA6RkiSgJfRb8Y5Ujfy0iY+wxnDQYuzgn6NCNdRaFtTq069X9RWtLemxxuKsKCsJn1
 idIHQWFA0DKtuODcFbCqbW0WBJtxF15xlykzg38YffqXK3ycjJE4mcrlAh0VHofE6dQl
 43jsIA2LIFYtq4lOYeO/KHpgykywCuP8mUrWqOsxnZGxghWFRUVddyt5EL/t/yUhIckD
 XNkfBeVMm4NiKOTEyUHyDF6YDn2EdMSB79Bk5IdsxL327cDZLLBqoE6omJEAZdWMnfhC
 kATw==
X-Gm-Message-State: AC+VfDwDaei9US0eijMR9b0vPs69RQ1HECXXWlg3omF+ku3gy9zcYt/y
 cb/LVQVBtjyuLh7HYUIe9tXMDCLk+/1IYn07yljMGbweRrE2rXf5M3SDEwyuP138doB/4rPHQ5O
 a1qtaxZip6YV04IE=
X-Received: by 2002:a05:600c:1c0a:b0:3f6:335:d8f0 with SMTP id
 j10-20020a05600c1c0a00b003f60335d8f0mr7927346wms.13.1684915551657; 
 Wed, 24 May 2023 01:05:51 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ4Pa3Z/4cCdCc3y6y76Di99EDzxN9dw2x4Sv4Z+LSxzGUUIHRLjgxpENvXr/pbAwQBGrYrRFg==
X-Received: by 2002:a05:600c:1c0a:b0:3f6:335:d8f0 with SMTP id
 j10-20020a05600c1c0a00b003f60335d8f0mr7927316wms.13.1684915551306; 
 Wed, 24 May 2023 01:05:51 -0700 (PDT)
Received: from sgarzare-redhat ([134.0.5.107])
 by smtp.gmail.com with ESMTPSA id
 f8-20020a7bcd08000000b003f17848673fsm1401647wmj.27.2023.05.24.01.05.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 24 May 2023 01:05:50 -0700 (PDT)
Date: Wed, 24 May 2023 10:05:46 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: qemu-devel@nongnu.org, xen-devel@lists.xenproject.org, 
 Julia Suvorova <jusual@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, 
 Stefano Stabellini <sstabellini@kernel.org>, Kevin Wolf <kwolf@redhat.com>,
 Fam Zheng <fam@euphon.net>, 
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-block@nongnu.org, 
 Paul Durrant <paul@xen.org>, Anthony Perard <anthony.perard@citrix.com>, 
 Aarushi Mehta <mehta.aaru20@gmail.com>, Hanna Reitz <hreitz@redhat.com>
Subject: Re: [PATCH 1/6] block: add blk_io_plug_call() API
Message-ID: <cwgklwmov3evxbmty56vwgg2xzdpagcrguy66adrdiy43u35eb@jmamrxotsf45>
References: <20230517221022.325091-1-stefanha@redhat.com>
 <20230517221022.325091-2-stefanha@redhat.com>
 <mzxjz4d3ab3sq6grwsle6wlacysh2uffz42ojpdze3hmqimbr5@fxgkad47nnim>
 <20230523154708.GB96478@fedora>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20230523154708.GB96478@fedora>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=sgarzare@redhat.com;
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

On Tue, May 23, 2023 at 11:47:08AM -0400, Stefan Hajnoczi wrote:
>On Fri, May 19, 2023 at 10:45:57AM +0200, Stefano Garzarella wrote:
>> On Wed, May 17, 2023 at 06:10:17PM -0400, Stefan Hajnoczi wrote:
>> > Introduce a new API for thread-local blk_io_plug() that does not
>> > traverse the block graph. The goal is to make blk_io_plug() multi-queue
>> > friendly.
>> >
>> > Instead of having block drivers track whether or not we're in a plugged
>> > section, provide an API that allows them to defer a function call until
>> > we're unplugged: blk_io_plug_call(fn, opaque). If blk_io_plug_call() is
>> > called multiple times with the same fn/opaque pair, then fn() is only
>> > called once at the end of the function - resulting in batching.
>> >
>> > This patch introduces the API and changes blk_io_plug()/blk_io_unplug().
>> > blk_io_plug()/blk_io_unplug() no longer require a BlockBackend argument
>> > because the plug state is now thread-local.
>> >
>> > Later patches convert block drivers to blk_io_plug_call() and then we
>> > can finally remove .bdrv_co_io_plug() once all block drivers have been
>> > converted.
>> >
>> > Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
>> > ---
>> > MAINTAINERS                       |   1 +
>> > include/sysemu/block-backend-io.h |  13 +--
>> > block/block-backend.c             |  22 -----
>> > block/plug.c                      | 159 ++++++++++++++++++++++++++++++
>> > hw/block/dataplane/xen-block.c    |   8 +-
>> > hw/block/virtio-blk.c             |   4 +-
>> > hw/scsi/virtio-scsi.c             |   6 +-
>> > block/meson.build                 |   1 +
>> > 8 files changed, 173 insertions(+), 41 deletions(-)
>> > create mode 100644 block/plug.c
>> >
>> > diff --git a/MAINTAINERS b/MAINTAINERS
>> > index 50585117a0..574202295c 100644
>> > --- a/MAINTAINERS
>> > +++ b/MAINTAINERS
>> > @@ -2644,6 +2644,7 @@ F: util/aio-*.c
>> > F: util/aio-*.h
>> > F: util/fdmon-*.c
>> > F: block/io.c
>> > +F: block/plug.c
>> > F: migration/block*
>> > F: include/block/aio.h
>> > F: include/block/aio-wait.h
>> > diff --git a/include/sysemu/block-backend-io.h b/include/sysemu/block-backend-io.h
>> > index d62a7ee773..be4dcef59d 100644
>> > --- a/include/sysemu/block-backend-io.h
>> > +++ b/include/sysemu/block-backend-io.h
>> > @@ -100,16 +100,9 @@ void blk_iostatus_set_err(BlockBackend *blk, int error);
>> > int blk_get_max_iov(BlockBackend *blk);
>> > int blk_get_max_hw_iov(BlockBackend *blk);
>> >
>> > -/*
>> > - * blk_io_plug/unplug are thread-local operations. This means that multiple
>> > - * IOThreads can simultaneously call plug/unplug, but the caller must ensure
>> > - * that each unplug() is called in the same IOThread of the matching plug().
>> > - */
>> > -void coroutine_fn blk_co_io_plug(BlockBackend *blk);
>> > -void co_wrapper blk_io_plug(BlockBackend *blk);
>> > -
>> > -void coroutine_fn blk_co_io_unplug(BlockBackend *blk);
>> > -void co_wrapper blk_io_unplug(BlockBackend *blk);
>> > +void blk_io_plug(void);
>> > +void blk_io_unplug(void);
>> > +void blk_io_plug_call(void (*fn)(void *), void *opaque);
>> >
>> > AioContext *blk_get_aio_context(BlockBackend *blk);
>> > BlockAcctStats *blk_get_stats(BlockBackend *blk);
>> > diff --git a/block/block-backend.c b/block/block-backend.c
>> > index ca537cd0ad..1f1d226ba6 100644
>> > --- a/block/block-backend.c
>> > +++ b/block/block-backend.c
>> > @@ -2568,28 +2568,6 @@ void blk_add_insert_bs_notifier(BlockBackend *blk, Notifier *notify)
>> >     notifier_list_add(&blk->insert_bs_notifiers, notify);
>> > }
>> >
>> > -void coroutine_fn blk_co_io_plug(BlockBackend *blk)
>> > -{
>> > -    BlockDriverState *bs = blk_bs(blk);
>> > -    IO_CODE();
>> > -    GRAPH_RDLOCK_GUARD();
>> > -
>> > -    if (bs) {
>> > -        bdrv_co_io_plug(bs);
>> > -    }
>> > -}
>> > -
>> > -void coroutine_fn blk_co_io_unplug(BlockBackend *blk)
>> > -{
>> > -    BlockDriverState *bs = blk_bs(blk);
>> > -    IO_CODE();
>> > -    GRAPH_RDLOCK_GUARD();
>> > -
>> > -    if (bs) {
>> > -        bdrv_co_io_unplug(bs);
>> > -    }
>> > -}
>> > -
>> > BlockAcctStats *blk_get_stats(BlockBackend *blk)
>> > {
>> >     IO_CODE();
>> > diff --git a/block/plug.c b/block/plug.c
>> > new file mode 100644
>> > index 0000000000..6738a568ba
>> > --- /dev/null
>> > +++ b/block/plug.c
>> > @@ -0,0 +1,159 @@
>> > +/* SPDX-License-Identifier: GPL-2.0-or-later */
>> > +/*
>> > + * Block I/O plugging
>> > + *
>> > + * Copyright Red Hat.
>> > + *
>> > + * This API defers a function call within a blk_io_plug()/blk_io_unplug()
>> > + * section, allowing multiple calls to batch up. This is a performance
>> > + * optimization that is used in the block layer to submit several I/O requests
>> > + * at once instead of individually:
>> > + *
>> > + *   blk_io_plug(); <-- start of plugged region
>> > + *   ...
>> > + *   blk_io_plug_call(my_func, my_obj); <-- deferred my_func(my_obj) call
>> > + *   blk_io_plug_call(my_func, my_obj); <-- another
>> > + *   blk_io_plug_call(my_func, my_obj); <-- another
>> > + *   ...
>> > + *   blk_io_unplug(); <-- end of plugged region, my_func(my_obj) is called once
>> > + *
>> > + * This code is actually generic and not tied to the block layer. If another
>> > + * subsystem needs this functionality, it could be renamed.
>> > + */
>> > +
>> > +#include "qemu/osdep.h"
>> > +#include "qemu/coroutine-tls.h"
>> > +#include "qemu/notify.h"
>> > +#include "qemu/thread.h"
>> > +#include "sysemu/block-backend.h"
>> > +
>> > +/* A function call that has been deferred until unplug() */
>> > +typedef struct {
>> > +    void (*fn)(void *);
>> > +    void *opaque;
>> > +} UnplugFn;
>> > +
>> > +/* Per-thread state */
>> > +typedef struct {
>> > +    unsigned count;       /* how many times has plug() been called? */
>> > +    GArray *unplug_fns;   /* functions to call at unplug time */
>> > +} Plug;
>> > +
>> > +/* Use get_ptr_plug() to fetch this thread-local value */
>> > +QEMU_DEFINE_STATIC_CO_TLS(Plug, plug);
>> > +
>> > +/* Called at thread cleanup time */
>> > +static void blk_io_plug_atexit(Notifier *n, void *value)
>> > +{
>> > +    Plug *plug = get_ptr_plug();
>> > +    g_array_free(plug->unplug_fns, TRUE);
>> > +}
>> > +
>> > +/* This won't involve coroutines, so use __thread */
>> > +static __thread Notifier blk_io_plug_atexit_notifier;
>> > +
>> > +/**
>> > + * blk_io_plug_call:
>> > + * @fn: a function pointer to be invoked
>> > + * @opaque: a user-defined argument to @fn()
>> > + *
>> > + * Call @fn(@opaque) immediately if not within a blk_io_plug()/blk_io_unplug()
>> > + * section.
>>
>> Just to understand better, what if two BlockDrivers share the same
>> iothread but one calls blk_io_plug()/blk_io_unplug(), while the other
>> calls this function not in a blk_io_plug()/blk_io_unplug() section?
>>
>> If the call is in the middle of the other BlockDriver's section, it is
>> deferred, right?
>
>Yes, the call is deferred until blk_io_unplug().
>
>> Is this situation possible?
>
>One scenario I can think of is when aio_poll() is called between
>plug/unplug. In that case, some I/O associated with device B might
>happen while device A is with plug/unplug.
>
>> Or should we prevent blk_io_plug_call() from being called out of a
>> blk_io_plug()/blk_io_unplug() section?
>
>blk_io_plug_call() is called outside blk_io_plug()/blk_io_unplug() when
>device emulation doesn't use plug/unplug. For example, IDE doesn't use
>it but still calls down into the same Linux AIO or io_uring code that
>invokes blk_io_plug_call(). This is why blk_io_plug_call() calls fn()
>immediately when invoked outside plug/unplug.

Got it, so it seems that everything should work properly.

Thanks,
Stefano



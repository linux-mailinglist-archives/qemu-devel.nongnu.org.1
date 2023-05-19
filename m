Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A84347091F2
	for <lists+qemu-devel@lfdr.de>; Fri, 19 May 2023 10:47:48 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1pzvlc-0004N7-No; Fri, 19 May 2023 04:47:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1pzvlV-0004HG-Ov
 for qemu-devel@nongnu.org; Fri, 19 May 2023 04:47:09 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1pzvlT-0006hJ-Rl
 for qemu-devel@nongnu.org; Fri, 19 May 2023 04:47:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1684486027;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=f9I0g5xFt+Bq1aRK6HzDjwahYXoeZ0017I2Bg1auWyM=;
 b=WKJqRd9w6QlHLZI3MUnfiwExugpNMrbmW/lyJR7Ixe8Dp+dLboLIX8t2wDo2aqzQt5aXst
 0ANzoJGE2siviPwqOEzFguaLOv0EP7ri70mbBA4iHOEPd1cXd2VLpxFRkPGsWhgEx+3Krg
 l2qFz8nLp1WvCGwjCMqfabQ4JxtT6mQ=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-664-_oPxm5tJOb68c7H0TSZkJQ-1; Fri, 19 May 2023 04:47:05 -0400
X-MC-Unique: _oPxm5tJOb68c7H0TSZkJQ-1
Received: by mail-ej1-f70.google.com with SMTP id
 a640c23a62f3a-966329c872bso389381866b.1
 for <qemu-devel@nongnu.org>; Fri, 19 May 2023 01:47:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684486024; x=1687078024;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=f9I0g5xFt+Bq1aRK6HzDjwahYXoeZ0017I2Bg1auWyM=;
 b=YmRKOyMeavyspVBVH1zQOuZ3R6vMrf28zx9poeYYh6iFHdlSaCxJEk7gv0Myb5Iw01
 oSSOXEVVZOeQfKJOOjx3Ld+ji6NSLALNaSWBbuYtv82PuSlM47ELp8YNDeaTD3YQjZkd
 IzcsYyJKnbjFQqHQ/XQxnnlrAapZh0HB2fRWAibQnjIWq7TXR5rcxfs7KuZBqJgVDhQ5
 vOLXZRQUX4xdVRpi1/EDqC9ihMTvqunBJjb8nAvtqo7cDks0xX6nYAzuVi4WoSKZ9q1u
 sOD+xZvzpaJ+l2pMyjSx/VGZhoimI0ShsKRY7ScWsIPPNT/OCJqivQ+HTJaWPtSvG+zj
 PvXA==
X-Gm-Message-State: AC+VfDxhmYa+QpvOJOrfp0KGozAKyy8rcYnT26NkhkE4H5kl36AmHyDG
 6zLcJS6yoZYpRwBQoUXT3MB7dMaZJNP7LK+bexueBCQ7jpcUM0NZebO2mlYRA547YJd2+T+LG3R
 bBL0x3oieYz5tu9g=
X-Received: by 2002:a17:907:7f1d:b0:88a:1ea9:a5ea with SMTP id
 qf29-20020a1709077f1d00b0088a1ea9a5eamr1032500ejc.65.1684486024360; 
 Fri, 19 May 2023 01:47:04 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ6fY1cGrDo7A0FTNLr+0xW3nb/0HDfhIGyDb6BB5UI2BqcERvG/eCqnKv++kjeGQo4yNVO08Q==
X-Received: by 2002:a17:907:7f1d:b0:88a:1ea9:a5ea with SMTP id
 qf29-20020a1709077f1d00b0088a1ea9a5eamr1032472ejc.65.1684486023998; 
 Fri, 19 May 2023 01:47:03 -0700 (PDT)
Received: from sgarzare-redhat (c-115-213.cust-q.wadsl.it. [212.43.115.213])
 by smtp.gmail.com with ESMTPSA id
 v15-20020a170906380f00b0096165b2703asm1988689ejc.110.2023.05.19.01.47.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 19 May 2023 01:47:03 -0700 (PDT)
Date: Fri, 19 May 2023 10:47:00 +0200
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
Subject: Re: [PATCH 3/6] block/blkio: convert to blk_io_plug_call() API
Message-ID: <wtyut5kd4v5vapon7fzpvi3kghvpplokcas5ovcwnjhiwyuccb@rm6eb6jjhhp5>
References: <20230517221022.325091-1-stefanha@redhat.com>
 <20230517221022.325091-4-stefanha@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230517221022.325091-4-stefanha@redhat.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=sgarzare@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001,
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

On Wed, May 17, 2023 at 06:10:19PM -0400, Stefan Hajnoczi wrote:
>Stop using the .bdrv_co_io_plug() API because it is not multi-queue
>block layer friendly. Use the new blk_io_plug_call() API to batch I/O
>submission instead.
>
>Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
>---
> block/blkio.c | 40 +++++++++++++++++++++-------------------
> 1 file changed, 21 insertions(+), 19 deletions(-)

With this patch, the build fails in several places, maybe it's an old
version:

../block/blkio.c:347:5: error: implicit declaration of function 
‘blk_io_plug_call’ [-Werror=implicit-function-declaration]
   347 |     blk_io_plug_call(blkio_unplug_fn, bs);

../block/blkio.c:348:22: error: passing argument 1 of ‘blk_io_plug_call’ 
from incompatible pointer type [-Werror=incompatible-pointer-types]
   348 |     blk_io_plug_call(blkio_unplug_fn, bs);

Thanks,
Stefano

>
>diff --git a/block/blkio.c b/block/blkio.c
>index 0cdc99a729..f2a1dc1fb2 100644
>--- a/block/blkio.c
>+++ b/block/blkio.c
>@@ -325,16 +325,28 @@ static void blkio_detach_aio_context(BlockDriverState *bs)
>                        false, NULL, NULL, NULL, NULL, NULL);
> }
>
>-/* Call with s->blkio_lock held to submit I/O after enqueuing a new request */
>-static void blkio_submit_io(BlockDriverState *bs)
>+/*
>+ * Called by blk_io_unplug() or immediately if not plugged. Called without
>+ * blkio_lock.
>+ */
>+static void blkio_unplug_fn(BlockDriverState *bs)
> {
>-    if (qatomic_read(&bs->io_plugged) == 0) {
>-        BDRVBlkioState *s = bs->opaque;
>+    BDRVBlkioState *s = bs->opaque;
>
>+    WITH_QEMU_LOCK_GUARD(&s->blkio_lock) {
>         blkioq_do_io(s->blkioq, NULL, 0, 0, NULL);
>     }
> }
>
>+/*
>+ * Schedule I/O submission after enqueuing a new request. Called without
>+ * blkio_lock.
>+ */
>+static void blkio_submit_io(BlockDriverState *bs)
>+{
>+    blk_io_plug_call(blkio_unplug_fn, bs);
>+}
>+
> static int coroutine_fn
> blkio_co_pdiscard(BlockDriverState *bs, int64_t offset, int64_t bytes)
> {
>@@ -345,9 +357,9 @@ blkio_co_pdiscard(BlockDriverState *bs, int64_t offset, int64_t bytes)
>
>     WITH_QEMU_LOCK_GUARD(&s->blkio_lock) {
>         blkioq_discard(s->blkioq, offset, bytes, &cod, 0);
>-        blkio_submit_io(bs);
>     }
>
>+    blkio_submit_io(bs);
>     qemu_coroutine_yield();
>     return cod.ret;
> }
>@@ -378,9 +390,9 @@ blkio_co_preadv(BlockDriverState *bs, int64_t offset, int64_t bytes,
>
>     WITH_QEMU_LOCK_GUARD(&s->blkio_lock) {
>         blkioq_readv(s->blkioq, offset, iov, iovcnt, &cod, 0);
>-        blkio_submit_io(bs);
>     }
>
>+    blkio_submit_io(bs);
>     qemu_coroutine_yield();
>
>     if (use_bounce_buffer) {
>@@ -423,9 +435,9 @@ static int coroutine_fn blkio_co_pwritev(BlockDriverState *bs, int64_t offset,
>
>     WITH_QEMU_LOCK_GUARD(&s->blkio_lock) {
>         blkioq_writev(s->blkioq, offset, iov, iovcnt, &cod, blkio_flags);
>-        blkio_submit_io(bs);
>     }
>
>+    blkio_submit_io(bs);
>     qemu_coroutine_yield();
>
>     if (use_bounce_buffer) {
>@@ -444,9 +456,9 @@ static int coroutine_fn blkio_co_flush(BlockDriverState *bs)
>
>     WITH_QEMU_LOCK_GUARD(&s->blkio_lock) {
>         blkioq_flush(s->blkioq, &cod, 0);
>-        blkio_submit_io(bs);
>     }
>
>+    blkio_submit_io(bs);
>     qemu_coroutine_yield();
>     return cod.ret;
> }
>@@ -472,22 +484,13 @@ static int coroutine_fn blkio_co_pwrite_zeroes(BlockDriverState *bs,
>
>     WITH_QEMU_LOCK_GUARD(&s->blkio_lock) {
>         blkioq_write_zeroes(s->blkioq, offset, bytes, &cod, blkio_flags);
>-        blkio_submit_io(bs);
>     }
>
>+    blkio_submit_io(bs);
>     qemu_coroutine_yield();
>     return cod.ret;
> }
>
>-static void coroutine_fn blkio_co_io_unplug(BlockDriverState *bs)
>-{
>-    BDRVBlkioState *s = bs->opaque;
>-
>-    WITH_QEMU_LOCK_GUARD(&s->blkio_lock) {
>-        blkio_submit_io(bs);
>-    }
>-}
>-
> typedef enum {
>     BMRR_OK,
>     BMRR_SKIP,
>@@ -1009,7 +1012,6 @@ static void blkio_refresh_limits(BlockDriverState *bs, Error **errp)
>         .bdrv_co_pwritev         = blkio_co_pwritev, \
>         .bdrv_co_flush_to_disk   = blkio_co_flush, \
>         .bdrv_co_pwrite_zeroes   = blkio_co_pwrite_zeroes, \
>-        .bdrv_co_io_unplug       = blkio_co_io_unplug, \
>         .bdrv_refresh_limits     = blkio_refresh_limits, \
>         .bdrv_register_buf       = blkio_register_buf, \
>         .bdrv_unregister_buf     = blkio_unregister_buf, \
>-- 
>2.40.1
>



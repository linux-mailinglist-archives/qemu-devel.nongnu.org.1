Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B637A74717C
	for <lists+qemu-devel@lfdr.de>; Tue,  4 Jul 2023 14:36:45 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qGfGF-0004rf-RZ; Tue, 04 Jul 2023 08:36:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1qGfGB-0004rQ-NF; Tue, 04 Jul 2023 08:35:59 -0400
Received: from mail-ot1-x334.google.com ([2607:f8b0:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1qGfG3-0002kD-1U; Tue, 04 Jul 2023 08:35:52 -0400
Received: by mail-ot1-x334.google.com with SMTP id
 46e09a7af769-6b723aedd3dso3285765a34.3; 
 Tue, 04 Jul 2023 05:35:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1688474148; x=1691066148;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=8xdT/R+wtPW9/XQrGUvFXMC5ASDznrCwYn6rNfVblds=;
 b=UIGT2GMK0cSqLEjHQhW+7MDpgcxOKL7066+uiO7UVuEBG7VA+GTF+uSzcZQCdg602s
 x/okI0n44eg6ehW03y1wOyaWaHIJLEE0skLWCQIvh/KXGwbz1zbouyroDSNNuOvVuKX1
 dixdQbQTuG7RXjrL65j7XYzrc4/RxtAgpkf5h0ztmvKtvCuRfYaOJvmSFEDb89iwgQYg
 Xmhgg/CkqJ3JtCLfCFemvj+uWRSWkNjDYpQGBL9b1q2SoAmXCE971+SZmppJ/WZ+FDaK
 zYWSveKy/ycYPVCEfWkfpuGmY02/7KfWAuGnRv3sB5G25Ch73gIj9Ib2k1nZlAI5G1ic
 Qbkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688474148; x=1691066148;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=8xdT/R+wtPW9/XQrGUvFXMC5ASDznrCwYn6rNfVblds=;
 b=e7Js+Ck1dUsG1Abgjq2fi8QcVQ6fFDV/Ig/8Ey2RIWHmoLLijZn9SYQR1RCuvJF/EX
 6OsDP2FxuAq5O7UhclKHn41hGZokfmo2fta8osseOoyoeHMdDcc3Koz4xFZPijQj40uk
 IUZZVvEjvvFHt9hAip8k7Yuoo4YID48NXbVI78MGljj2AJGyf+H59FDXmHt4fb30rAMU
 ABXovBb5RAy9r0SkTVlzuKugvnuuRqUDr+s/kN1GSqYvxBe+goTNIo15nhcqih7MKeQw
 DGryS7NAgzAN5tamvXot5wXjc0rHSnd1QfppFLn3qOahGEo0U6b9BIsN836xaFGawk6B
 LoVg==
X-Gm-Message-State: AC+VfDyHZzVfrlVzRmLCQVmZhkK+1aVE0vIn5HCfj2BLK01o9Z7fxKS3
 0WwwBKsn4I8+7mMRTSgHOfCX5m0/OK7qr9A/Ncwkiyl/unk=
X-Google-Smtp-Source: ACHHUZ5oafqgXfw9iX2HiLHkjQew+s7FOzSBlB3K0PWMvzYz4SwkcNrU6b8P1w+o6IqsuqKonJu6UgLCfqCqwneazDw=
X-Received: by 2002:a05:6808:159f:b0:3a3:7745:bdd7 with SMTP id
 t31-20020a056808159f00b003a37745bdd7mr12568489oiw.17.1688474148636; Tue, 04
 Jul 2023 05:35:48 -0700 (PDT)
MIME-Version: 1.0
References: <20230703103524.162855-1-stefanha@redhat.com>
 <cigfftqvsymwwcv7dvfp3lydpymu2hzx7pmpb3tbnfgiqxlaj7@2xhwxfb6nasj>
In-Reply-To: <cigfftqvsymwwcv7dvfp3lydpymu2hzx7pmpb3tbnfgiqxlaj7@2xhwxfb6nasj>
From: Stefan Hajnoczi <stefanha@gmail.com>
Date: Tue, 4 Jul 2023 14:35:36 +0200
Message-ID: <CAJSP0QXq3KQsf0PfHZ3g8FnOfX0UT+z1gRptx1ihu5nfys2_Lg@mail.gmail.com>
Subject: Re: [PATCH] block/blkio: fix module_block.py parsing
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: Stefan Hajnoczi <stefanha@redhat.com>, qemu-devel@nongnu.org,
 qemu-block@nongnu.org, 
 Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 Qing Wang <qinwang@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::334;
 envelope-from=stefanha@gmail.com; helo=mail-ot1-x334.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On Mon, 3 Jul 2023 at 12:55, Stefano Garzarella <sgarzare@redhat.com> wrote:
>
> On Mon, Jul 03, 2023 at 12:35:24PM +0200, Stefan Hajnoczi wrote:
> >When QEMU is built with --enable-modules, the module_block.py script
> >parses block/*.c to find block drivers that are built as modules. The
> >script generates a table of block drivers called block_driver_modules[].
> >This table is used for block driver module loading.
> >
> >The blkio.c driver uses macros to define its BlockDriver structs. This
> >was done to avoid code duplication but the module_block.py script is
> >unable to parse the macro. The result is that libblkio-based block
> >drivers can be built as modules but will not be found at runtime.
> >
> >One fix is to make the module_block.py script or build system fancier so
> >it can parse C macros (e.g. by parsing the preprocessed source code). I
> >chose not to do this because it raises the complexity of the build,
> >making future issues harder to debug.
> >
> >Keep things simple: use the macro to avoid duplicating BlockDriver
> >function pointers but define .format_name and .protocol_name manually
> >for each BlockDriver. This way the module_block.py is able to parse the
> >code.
> >
> >Also get rid of the block driver name macros (e.g. DRIVER_IO_URING)
> >because module_block.py cannot parse them either.
> >
> >Fixes: fd66dbd424f5 ("blkio: add libblkio block driver")
> >Reported-by: Qing Wang <qinwang@redhat.com>
> >Cc: Stefano Garzarella <sgarzare@redhat.com>
> >Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> >---
> > block/blkio.c | 110 ++++++++++++++++++++++++++------------------------
> > 1 file changed, 57 insertions(+), 53 deletions(-)
> >
> >diff --git a/block/blkio.c b/block/blkio.c
> >index 527323d625..589f829a83 100644
> >--- a/block/blkio.c
> >+++ b/block/blkio.c
> >@@ -22,16 +22,6 @@
> >
> > #include "block/block-io.h"
> >
> >-/*
> >- * Keep the QEMU BlockDriver names identical to the libblkio driver names.
> >- * Using macros instead of typing out the string literals avoids typos.
> >- */
> >-#define DRIVER_IO_URING "io_uring"
> >-#define DRIVER_NVME_IO_URING "nvme-io_uring"
> >-#define DRIVER_VIRTIO_BLK_VFIO_PCI "virtio-blk-vfio-pci"
> >-#define DRIVER_VIRTIO_BLK_VHOST_USER "virtio-blk-vhost-user"
> >-#define DRIVER_VIRTIO_BLK_VHOST_VDPA "virtio-blk-vhost-vdpa"
> >-
> > /*
> >  * Allocated bounce buffers are kept in a list sorted by buffer address.
> >  */
> >@@ -744,15 +734,15 @@ static int blkio_file_open(BlockDriverState *bs, QDict *options, int flags,
> >         return ret;
> >     }
> >
> >-    if (strcmp(blkio_driver, DRIVER_IO_URING) == 0) {
> >+    if (strcmp(blkio_driver, "io_uring") == 0) {
> >         ret = blkio_io_uring_open(bs, options, flags, errp);
> >-    } else if (strcmp(blkio_driver, DRIVER_NVME_IO_URING) == 0) {
> >+    } else if (strcmp(blkio_driver, "nvme-io_uring") == 0) {
> >         ret = blkio_nvme_io_uring(bs, options, flags, errp);
> >-    } else if (strcmp(blkio_driver, DRIVER_VIRTIO_BLK_VFIO_PCI) == 0) {
> >+    } else if (strcmp(blkio_driver, "virtio-blk-vfio-pci") == 0) {
> >         ret = blkio_virtio_blk_common_open(bs, options, flags, errp);
> >-    } else if (strcmp(blkio_driver, DRIVER_VIRTIO_BLK_VHOST_USER) == 0) {
> >+    } else if (strcmp(blkio_driver, "virtio-blk-vhost-user") == 0) {
> >         ret = blkio_virtio_blk_common_open(bs, options, flags, errp);
> >-    } else if (strcmp(blkio_driver, DRIVER_VIRTIO_BLK_VHOST_VDPA) == 0) {
> >+    } else if (strcmp(blkio_driver, "virtio-blk-vhost-vdpa") == 0) {
> >         ret = blkio_virtio_blk_common_open(bs, options, flags, errp);
> >     } else {
> >         g_assert_not_reached();
> >@@ -1028,49 +1018,63 @@ static void blkio_refresh_limits(BlockDriverState *bs, Error **errp)
> >  * - truncate
> >  */
> >
> >-#define BLKIO_DRIVER(name, ...) \
> >-    { \
> >-        .format_name             = name, \
> >-        .protocol_name           = name, \
> >-        .instance_size           = sizeof(BDRVBlkioState), \
> >-        .bdrv_file_open          = blkio_file_open, \
> >-        .bdrv_close              = blkio_close, \
> >-        .bdrv_co_getlength       = blkio_co_getlength, \
> >-        .bdrv_co_truncate        = blkio_truncate, \
> >-        .bdrv_co_get_info        = blkio_co_get_info, \
> >-        .bdrv_attach_aio_context = blkio_attach_aio_context, \
> >-        .bdrv_detach_aio_context = blkio_detach_aio_context, \
> >-        .bdrv_co_pdiscard        = blkio_co_pdiscard, \
> >-        .bdrv_co_preadv          = blkio_co_preadv, \
> >-        .bdrv_co_pwritev         = blkio_co_pwritev, \
> >-        .bdrv_co_flush_to_disk   = blkio_co_flush, \
> >-        .bdrv_co_pwrite_zeroes   = blkio_co_pwrite_zeroes, \
> >-        .bdrv_refresh_limits     = blkio_refresh_limits, \
> >-        .bdrv_register_buf       = blkio_register_buf, \
> >-        .bdrv_unregister_buf     = blkio_unregister_buf, \
> >-        __VA_ARGS__ \
> >-    }
> >+/*
> >+ * Do not include .format_name and .protocol_name because module_block.py
> >+ * does not parse macros in the source code.
> >+ */
> >+#define BLKIO_DRIVER_COMMON \
> >+    .instance_size           = sizeof(BDRVBlkioState), \
> >+    .bdrv_file_open          = blkio_file_open, \
> >+    .bdrv_close              = blkio_close, \
> >+    .bdrv_co_getlength       = blkio_co_getlength, \
> >+    .bdrv_co_truncate        = blkio_truncate, \
> >+    .bdrv_co_get_info        = blkio_co_get_info, \
> >+    .bdrv_attach_aio_context = blkio_attach_aio_context, \
> >+    .bdrv_detach_aio_context = blkio_detach_aio_context, \
> >+    .bdrv_co_pdiscard        = blkio_co_pdiscard, \
> >+    .bdrv_co_preadv          = blkio_co_preadv, \
> >+    .bdrv_co_pwritev         = blkio_co_pwritev, \
> >+    .bdrv_co_flush_to_disk   = blkio_co_flush, \
> >+    .bdrv_co_pwrite_zeroes   = blkio_co_pwrite_zeroes, \
> >+    .bdrv_refresh_limits     = blkio_refresh_limits, \
> >+    .bdrv_register_buf       = blkio_register_buf, \
> >+    .bdrv_unregister_buf     = blkio_unregister_buf,
> >
> >-static BlockDriver bdrv_io_uring = BLKIO_DRIVER(
> >-    DRIVER_IO_URING,
> >-    .bdrv_needs_filename = true,
> >-);
> >+/*
> >+ * Use the same .format_name and .protocol_name as the libblkio driver name for
> >+ * consistency.
> >+ */
> >
> >-static BlockDriver bdrv_nvme_io_uring = BLKIO_DRIVER(
> >-    DRIVER_NVME_IO_URING,
> >-);
> >+static BlockDriver bdrv_io_uring = {
> >+    .format_name         = "io_uring", \
>
> Thanks for the fast fix :-)
>
> Minor thing: we can remove the backslash here and in the following
> `struct BlockDriver`s fields.
>
> With or without this:
>
> Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>

Oops, the slash is not necessary.

Thanks!

Stefan


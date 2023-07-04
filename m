Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 60569747179
	for <lists+qemu-devel@lfdr.de>; Tue,  4 Jul 2023 14:35:19 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qGfF7-00048B-2X; Tue, 04 Jul 2023 08:34:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1qGfF3-00047j-1z
 for qemu-devel@nongnu.org; Tue, 04 Jul 2023 08:34:49 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1qGfF0-0002Nc-VU
 for qemu-devel@nongnu.org; Tue, 04 Jul 2023 08:34:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1688474085;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=q3kHwej/2cgkUK1og5DS8/g9d5yTDpEs86cdHnj3zwc=;
 b=TIpmciHhCIcFR88wZ5bI7zBUtpkXS7MDRCL3AUfczk7TY7QP8doB1Nmt/ngFV9yuGH5IkG
 yA63rJ2eQjsW+D1VuQvvpaxB+205LlLSZRJuGUe54Iaw2leZ/rBBXZbwlwnACwXPuw7mmN
 AUh6GanhXS+LOXNqv199kSMydnuS+Ss=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-638-3aZuP82-OqGD_nTO_eLfEQ-1; Tue, 04 Jul 2023 08:34:44 -0400
X-MC-Unique: 3aZuP82-OqGD_nTO_eLfEQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com
 [10.11.54.8])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id A9CEC88CC49;
 Tue,  4 Jul 2023 12:34:43 +0000 (UTC)
Received: from localhost (unknown [10.39.194.217])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 2DFE0C478C7;
 Tue,  4 Jul 2023 12:34:42 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: qemu-devel@nongnu.org
Cc: <qemu-block@nongnu.org>, Kevin Wolf <kwolf@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 Qing Wang <qinwang@redhat.com>, Stefano Garzarella <sgarzare@redhat.com>
Subject: [PATCH v2] block/blkio: fix module_block.py parsing
Date: Tue,  4 Jul 2023 14:34:36 +0200
Message-Id: <20230704123436.187761-1-stefanha@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.8
Received-SPF: pass client-ip=170.10.133.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

When QEMU is built with --enable-modules, the module_block.py script
parses block/*.c to find block drivers that are built as modules. The
script generates a table of block drivers called block_driver_modules[].
This table is used for block driver module loading.

The blkio.c driver uses macros to define its BlockDriver structs. This
was done to avoid code duplication but the module_block.py script is
unable to parse the macro. The result is that libblkio-based block
drivers can be built as modules but will not be found at runtime.

One fix is to make the module_block.py script or build system fancier so
it can parse C macros (e.g. by parsing the preprocessed source code). I
chose not to do this because it raises the complexity of the build,
making future issues harder to debug.

Keep things simple: use the macro to avoid duplicating BlockDriver
function pointers but define .format_name and .protocol_name manually
for each BlockDriver. This way the module_block.py is able to parse the
code.

Also get rid of the block driver name macros (e.g. DRIVER_IO_URING)
because module_block.py cannot parse them either.

Fixes: fd66dbd424f5 ("blkio: add libblkio block driver")
Reported-by: Qing Wang <qinwang@redhat.com>
Cc: Stefano Garzarella <sgarzare@redhat.com>
Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
---
v2:
- Drop unnecessary backslashes [Stefano]
---
 block/blkio.c | 108 ++++++++++++++++++++++++++------------------------
 1 file changed, 56 insertions(+), 52 deletions(-)

diff --git a/block/blkio.c b/block/blkio.c
index 527323d625..1798648134 100644
--- a/block/blkio.c
+++ b/block/blkio.c
@@ -22,16 +22,6 @@
 
 #include "block/block-io.h"
 
-/*
- * Keep the QEMU BlockDriver names identical to the libblkio driver names.
- * Using macros instead of typing out the string literals avoids typos.
- */
-#define DRIVER_IO_URING "io_uring"
-#define DRIVER_NVME_IO_URING "nvme-io_uring"
-#define DRIVER_VIRTIO_BLK_VFIO_PCI "virtio-blk-vfio-pci"
-#define DRIVER_VIRTIO_BLK_VHOST_USER "virtio-blk-vhost-user"
-#define DRIVER_VIRTIO_BLK_VHOST_VDPA "virtio-blk-vhost-vdpa"
-
 /*
  * Allocated bounce buffers are kept in a list sorted by buffer address.
  */
@@ -744,15 +734,15 @@ static int blkio_file_open(BlockDriverState *bs, QDict *options, int flags,
         return ret;
     }
 
-    if (strcmp(blkio_driver, DRIVER_IO_URING) == 0) {
+    if (strcmp(blkio_driver, "io_uring") == 0) {
         ret = blkio_io_uring_open(bs, options, flags, errp);
-    } else if (strcmp(blkio_driver, DRIVER_NVME_IO_URING) == 0) {
+    } else if (strcmp(blkio_driver, "nvme-io_uring") == 0) {
         ret = blkio_nvme_io_uring(bs, options, flags, errp);
-    } else if (strcmp(blkio_driver, DRIVER_VIRTIO_BLK_VFIO_PCI) == 0) {
+    } else if (strcmp(blkio_driver, "virtio-blk-vfio-pci") == 0) {
         ret = blkio_virtio_blk_common_open(bs, options, flags, errp);
-    } else if (strcmp(blkio_driver, DRIVER_VIRTIO_BLK_VHOST_USER) == 0) {
+    } else if (strcmp(blkio_driver, "virtio-blk-vhost-user") == 0) {
         ret = blkio_virtio_blk_common_open(bs, options, flags, errp);
-    } else if (strcmp(blkio_driver, DRIVER_VIRTIO_BLK_VHOST_VDPA) == 0) {
+    } else if (strcmp(blkio_driver, "virtio-blk-vhost-vdpa") == 0) {
         ret = blkio_virtio_blk_common_open(bs, options, flags, errp);
     } else {
         g_assert_not_reached();
@@ -1028,49 +1018,63 @@ static void blkio_refresh_limits(BlockDriverState *bs, Error **errp)
  * - truncate
  */
 
-#define BLKIO_DRIVER(name, ...) \
-    { \
-        .format_name             = name, \
-        .protocol_name           = name, \
-        .instance_size           = sizeof(BDRVBlkioState), \
-        .bdrv_file_open          = blkio_file_open, \
-        .bdrv_close              = blkio_close, \
-        .bdrv_co_getlength       = blkio_co_getlength, \
-        .bdrv_co_truncate        = blkio_truncate, \
-        .bdrv_co_get_info        = blkio_co_get_info, \
-        .bdrv_attach_aio_context = blkio_attach_aio_context, \
-        .bdrv_detach_aio_context = blkio_detach_aio_context, \
-        .bdrv_co_pdiscard        = blkio_co_pdiscard, \
-        .bdrv_co_preadv          = blkio_co_preadv, \
-        .bdrv_co_pwritev         = blkio_co_pwritev, \
-        .bdrv_co_flush_to_disk   = blkio_co_flush, \
-        .bdrv_co_pwrite_zeroes   = blkio_co_pwrite_zeroes, \
-        .bdrv_refresh_limits     = blkio_refresh_limits, \
-        .bdrv_register_buf       = blkio_register_buf, \
-        .bdrv_unregister_buf     = blkio_unregister_buf, \
-        __VA_ARGS__ \
-    }
+/*
+ * Do not include .format_name and .protocol_name because module_block.py
+ * does not parse macros in the source code.
+ */
+#define BLKIO_DRIVER_COMMON \
+    .instance_size           = sizeof(BDRVBlkioState), \
+    .bdrv_file_open          = blkio_file_open, \
+    .bdrv_close              = blkio_close, \
+    .bdrv_co_getlength       = blkio_co_getlength, \
+    .bdrv_co_truncate        = blkio_truncate, \
+    .bdrv_co_get_info        = blkio_co_get_info, \
+    .bdrv_attach_aio_context = blkio_attach_aio_context, \
+    .bdrv_detach_aio_context = blkio_detach_aio_context, \
+    .bdrv_co_pdiscard        = blkio_co_pdiscard, \
+    .bdrv_co_preadv          = blkio_co_preadv, \
+    .bdrv_co_pwritev         = blkio_co_pwritev, \
+    .bdrv_co_flush_to_disk   = blkio_co_flush, \
+    .bdrv_co_pwrite_zeroes   = blkio_co_pwrite_zeroes, \
+    .bdrv_refresh_limits     = blkio_refresh_limits, \
+    .bdrv_register_buf       = blkio_register_buf, \
+    .bdrv_unregister_buf     = blkio_unregister_buf,
 
-static BlockDriver bdrv_io_uring = BLKIO_DRIVER(
-    DRIVER_IO_URING,
+/*
+ * Use the same .format_name and .protocol_name as the libblkio driver name for
+ * consistency.
+ */
+
+static BlockDriver bdrv_io_uring = {
+    .format_name         = "io_uring",
+    .protocol_name       = "io_uring",
     .bdrv_needs_filename = true,
-);
+    BLKIO_DRIVER_COMMON
+};
 
-static BlockDriver bdrv_nvme_io_uring = BLKIO_DRIVER(
-    DRIVER_NVME_IO_URING,
-);
+static BlockDriver bdrv_nvme_io_uring = {
+    .format_name         = "nvme-io_uring",
+    .protocol_name       = "nvme-io_uring",
+    BLKIO_DRIVER_COMMON
+};
 
-static BlockDriver bdrv_virtio_blk_vfio_pci = BLKIO_DRIVER(
-    DRIVER_VIRTIO_BLK_VFIO_PCI
-);
+static BlockDriver bdrv_virtio_blk_vfio_pci = {
+    .format_name         = "virtio-blk-vfio-pci",
+    .protocol_name       = "virtio-blk-vfio-pci",
+    BLKIO_DRIVER_COMMON
+};
 
-static BlockDriver bdrv_virtio_blk_vhost_user = BLKIO_DRIVER(
-    DRIVER_VIRTIO_BLK_VHOST_USER
-);
+static BlockDriver bdrv_virtio_blk_vhost_user = {
+    .format_name         = "virtio-blk-vhost-user",
+    .protocol_name       = "virtio-blk-vhost-user",
+    BLKIO_DRIVER_COMMON
+};
 
-static BlockDriver bdrv_virtio_blk_vhost_vdpa = BLKIO_DRIVER(
-    DRIVER_VIRTIO_BLK_VHOST_VDPA
-);
+static BlockDriver bdrv_virtio_blk_vhost_vdpa = {
+    .format_name         = "virtio-blk-vhost-vdpa",
+    .protocol_name       = "virtio-blk-vhost-vdpa",
+    BLKIO_DRIVER_COMMON
+};
 
 static void bdrv_blkio_init(void)
 {
-- 
2.40.1



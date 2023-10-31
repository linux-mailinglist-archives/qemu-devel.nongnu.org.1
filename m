Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 79A867DD676
	for <lists+qemu-devel@lfdr.de>; Tue, 31 Oct 2023 20:02:13 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qxtxy-0003zr-1r; Tue, 31 Oct 2023 14:59:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1qxtxt-0003yT-QW
 for qemu-devel@nongnu.org; Tue, 31 Oct 2023 14:59:49 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1qxtxa-00067F-LT
 for qemu-devel@nongnu.org; Tue, 31 Oct 2023 14:59:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1698778770;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=LP6rbococ/jN4XK6HE97njE5j8QTQ53+miS94Z+XqNY=;
 b=OiR6a2lZBIrf0dx7Kji525Mx6GgVYEZaML6vAUrTrXY85jx/LBY2E/cT88LKA+TyoEPSP7
 4uGioFUKBDBjXBSh4cUBXAdRU/Sl5Smpb9P1hXnWI4tETpZTfxJyGPQwmh3oK4vTcXdM/Z
 LBzGDGPL6CDLkl6wK+WFFNlxEEoLvHM=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-380-zl5Bgg61P4K1EepBenMQcg-1; Tue, 31 Oct 2023 14:59:26 -0400
X-MC-Unique: zl5Bgg61P4K1EepBenMQcg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com
 [10.11.54.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 578198678A0;
 Tue, 31 Oct 2023 18:59:26 +0000 (UTC)
Received: from merkur.fritz.box (unknown [10.39.194.218])
 by smtp.corp.redhat.com (Postfix) with ESMTP id BBE6B143;
 Tue, 31 Oct 2023 18:59:25 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com,
	qemu-devel@nongnu.org
Subject: [PULL 07/27] qemu-img: add compression option to rebase subcommand
Date: Tue, 31 Oct 2023 19:58:58 +0100
Message-ID: <20231031185918.346940-8-kwolf@redhat.com>
In-Reply-To: <20231031185918.346940-1-kwolf@redhat.com>
References: <20231031185918.346940-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.1
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.481,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

From: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>

If we rebase an image whose backing file has compressed clusters, we
might end up wasting disk space since the copied clusters are now
uncompressed.  In order to have better control over this, let's add
"--compress" option to the "qemu-img rebase" command.

Note that this option affects only the clusters which are actually being
copied from the original backing file.  The clusters which were
uncompressed in the target image will remain so.

Signed-off-by: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
Reviewed-by: Denis V. Lunev <den@openvz.org>
Reviewed-by: Hanna Czenczek <hreitz@redhat.com>
Message-ID: <20230919165804.439110-8-andrey.drobyshev@virtuozzo.com>
Reviewed-by: Kevin Wolf <kwolf@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 docs/tools/qemu-img.rst |  6 ++++--
 qemu-img.c              | 26 ++++++++++++++++++++------
 qemu-img-cmds.hx        |  4 ++--
 3 files changed, 26 insertions(+), 10 deletions(-)

diff --git a/docs/tools/qemu-img.rst b/docs/tools/qemu-img.rst
index ca5a2773cf..4459c065f1 100644
--- a/docs/tools/qemu-img.rst
+++ b/docs/tools/qemu-img.rst
@@ -667,7 +667,7 @@ Command description:
 
   List, apply, create or delete snapshots in image *FILENAME*.
 
-.. option:: rebase [--object OBJECTDEF] [--image-opts] [-U] [-q] [-f FMT] [-t CACHE] [-T SRC_CACHE] [-p] [-u] -b BACKING_FILE [-F BACKING_FMT] FILENAME
+.. option:: rebase [--object OBJECTDEF] [--image-opts] [-U] [-q] [-f FMT] [-t CACHE] [-T SRC_CACHE] [-p] [-u] [-c] -b BACKING_FILE [-F BACKING_FMT] FILENAME
 
   Changes the backing file of an image. Only the formats ``qcow2`` and
   ``qed`` support changing the backing file.
@@ -694,7 +694,9 @@ Command description:
 
     In order to achieve this, any clusters that differ between
     *BACKING_FILE* and the old backing file of *FILENAME* are merged
-    into *FILENAME* before actually changing the backing file.
+    into *FILENAME* before actually changing the backing file. With the
+    ``-c`` option specified, the clusters which are being merged (but not
+    the entire *FILENAME* image) are compressed when written.
 
     Note that the safe mode is an expensive operation, comparable to
     converting an image. It only works if the old backing file still
diff --git a/qemu-img.c b/qemu-img.c
index 01de77295e..369c2e8ddf 100644
--- a/qemu-img.c
+++ b/qemu-img.c
@@ -3534,11 +3534,13 @@ static int img_rebase(int argc, char **argv)
     char *filename;
     const char *fmt, *cache, *src_cache, *out_basefmt, *out_baseimg;
     int c, flags, src_flags, ret;
+    BdrvRequestFlags write_flags = 0;
     bool writethrough, src_writethrough;
     int unsafe = 0;
     bool force_share = false;
     int progress = 0;
     bool quiet = false;
+    bool compress = false;
     Error *local_err = NULL;
     bool image_opts = false;
     int64_t write_align;
@@ -3555,9 +3557,10 @@ static int img_rebase(int argc, char **argv)
             {"object", required_argument, 0, OPTION_OBJECT},
             {"image-opts", no_argument, 0, OPTION_IMAGE_OPTS},
             {"force-share", no_argument, 0, 'U'},
+            {"compress", no_argument, 0, 'c'},
             {0, 0, 0, 0}
         };
-        c = getopt_long(argc, argv, ":hf:F:b:upt:T:qU",
+        c = getopt_long(argc, argv, ":hf:F:b:upt:T:qUc",
                         long_options, NULL);
         if (c == -1) {
             break;
@@ -3605,6 +3608,9 @@ static int img_rebase(int argc, char **argv)
         case 'U':
             force_share = true;
             break;
+        case 'c':
+            compress = true;
+            break;
         }
     }
 
@@ -3657,6 +3663,14 @@ static int img_rebase(int argc, char **argv)
 
     unfiltered_bs = bdrv_skip_filters(bs);
 
+    if (compress && !block_driver_can_compress(unfiltered_bs->drv)) {
+        error_report("Compression not supported for this file format");
+        ret = -1;
+        goto out;
+    } else if (compress) {
+        write_flags |= BDRV_REQ_WRITE_COMPRESSED;
+    }
+
     if (out_basefmt != NULL) {
         if (bdrv_find_format(out_basefmt) == NULL) {
             error_report("Invalid format name: '%s'", out_basefmt);
@@ -3666,18 +3680,18 @@ static int img_rebase(int argc, char **argv)
     }
 
     /*
-     * We need overlay subcluster size to make sure write requests are
-     * aligned.
+     * We need overlay subcluster size (or cluster size in case writes are
+     * compressed) to make sure write requests are aligned.
      */
     ret = bdrv_get_info(unfiltered_bs, &bdi);
     if (ret < 0) {
         error_report("could not get block driver info");
         goto out;
     } else if (bdi.subcluster_size == 0) {
-        bdi.subcluster_size = 1;
+        bdi.cluster_size = bdi.subcluster_size = 1;
     }
 
-    write_align = bdi.subcluster_size;
+    write_align = compress ? bdi.cluster_size : bdi.subcluster_size;
 
     /* For safe rebasing we need to compare old and new backing file */
     if (!unsafe) {
@@ -3930,7 +3944,7 @@ static int img_rebase(int argc, char **argv)
                     } else {
                         assert(written + pnum <= IO_BUF_SIZE);
                         ret = blk_pwrite(blk, offset + written, pnum,
-                                         buf_old + written, 0);
+                                         buf_old + written, write_flags);
                     }
                     if (ret < 0) {
                         error_report("Error while writing to COW image: %s",
diff --git a/qemu-img-cmds.hx b/qemu-img-cmds.hx
index 1b1dab5b17..068692d13e 100644
--- a/qemu-img-cmds.hx
+++ b/qemu-img-cmds.hx
@@ -88,9 +88,9 @@ SRST
 ERST
 
 DEF("rebase", img_rebase,
-    "rebase [--object objectdef] [--image-opts] [-U] [-q] [-f fmt] [-t cache] [-T src_cache] [-p] [-u] -b backing_file [-F backing_fmt] filename")
+    "rebase [--object objectdef] [--image-opts] [-U] [-q] [-f fmt] [-t cache] [-T src_cache] [-p] [-u] [-c] -b backing_file [-F backing_fmt] filename")
 SRST
-.. option:: rebase [--object OBJECTDEF] [--image-opts] [-U] [-q] [-f FMT] [-t CACHE] [-T SRC_CACHE] [-p] [-u] -b BACKING_FILE [-F BACKING_FMT] FILENAME
+.. option:: rebase [--object OBJECTDEF] [--image-opts] [-U] [-q] [-f FMT] [-t CACHE] [-T SRC_CACHE] [-p] [-u] [-c] -b BACKING_FILE [-F BACKING_FMT] FILENAME
 ERST
 
 DEF("resize", img_resize,
-- 
2.41.0



Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E3B271F2E7
	for <lists+qemu-devel@lfdr.de>; Thu,  1 Jun 2023 21:30:16 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q4nym-0006nd-Mj; Thu, 01 Jun 2023 15:29:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1q4nyZ-0006jv-CQ; Thu, 01 Jun 2023 15:28:48 -0400
Received: from relay.virtuozzo.com ([130.117.225.111])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1q4nyV-0005m9-Uv; Thu, 01 Jun 2023 15:28:47 -0400
Received: from dev005.ch-qa.vzint.dev ([172.29.1.10])
 by relay.virtuozzo.com with esmtp (Exim 4.96)
 (envelope-from <andrey.drobyshev@virtuozzo.com>) id 1q4nyC-00DLDg-1D;
 Thu, 01 Jun 2023 21:28:36 +0200
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, kwolf@redhat.com, hreitz@redhat.com,
 andrey.drobyshev@virtuozzo.com, den@virtuozzo.com
Subject: [PATCH 5/6] qemu-img: add compression option to rebase subcommand
Date: Thu,  1 Jun 2023 22:28:35 +0300
Message-Id: <20230601192836.598602-6-andrey.drobyshev@virtuozzo.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20230601192836.598602-1-andrey.drobyshev@virtuozzo.com>
References: <20230601192836.598602-1-andrey.drobyshev@virtuozzo.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=130.117.225.111;
 envelope-from=andrey.drobyshev@virtuozzo.com; helo=relay.virtuozzo.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
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
Reply-to:  Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
From:  Andrey Drobyshev via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

If we rebase an image whose backing file has compressed clusters, we
might end up wasting disk space since the copied clusters are now
uncompressed.  In order to have better control over this, let's add
"--compress" option to the "qemu-img rebase" command.

Note that this option affects only the clusters which are actually being
copied from the original backing file.  The clusters which were
uncompressed in the target image will remain so.

Signed-off-by: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
---
 docs/tools/qemu-img.rst |  6 ++++--
 qemu-img-cmds.hx        |  4 ++--
 qemu-img.c              | 19 +++++++++++++++++--
 3 files changed, 23 insertions(+), 6 deletions(-)

diff --git a/docs/tools/qemu-img.rst b/docs/tools/qemu-img.rst
index 15aeddc6d8..973a912dec 100644
--- a/docs/tools/qemu-img.rst
+++ b/docs/tools/qemu-img.rst
@@ -663,7 +663,7 @@ Command description:
 
   List, apply, create or delete snapshots in image *FILENAME*.
 
-.. option:: rebase [--object OBJECTDEF] [--image-opts] [-U] [-q] [-f FMT] [-t CACHE] [-T SRC_CACHE] [-p] [-u] -b BACKING_FILE [-F BACKING_FMT] FILENAME
+.. option:: rebase [--object OBJECTDEF] [--image-opts] [-U] [-q] [-f FMT] [-t CACHE] [-T SRC_CACHE] [-p] [-u] [-c] -b BACKING_FILE [-F BACKING_FMT] FILENAME
 
   Changes the backing file of an image. Only the formats ``qcow2`` and
   ``qed`` support changing the backing file.
@@ -690,7 +690,9 @@ Command description:
 
     In order to achieve this, any clusters that differ between
     *BACKING_FILE* and the old backing file of *FILENAME* are merged
-    into *FILENAME* before actually changing the backing file.
+    into *FILENAME* before actually changing the backing file. With ``-c``
+    option specified, the clusters which are being merged (but not the
+    entire *FILENAME* image) are written in the compressed mode.
 
     Note that the safe mode is an expensive operation, comparable to
     converting an image. It only works if the old backing file still
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
diff --git a/qemu-img.c b/qemu-img.c
index 9a469cd609..108da27b23 100644
--- a/qemu-img.c
+++ b/qemu-img.c
@@ -3517,11 +3517,13 @@ static int img_rebase(int argc, char **argv)
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
 
@@ -3537,9 +3539,10 @@ static int img_rebase(int argc, char **argv)
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
@@ -3587,6 +3590,9 @@ static int img_rebase(int argc, char **argv)
         case 'U':
             force_share = true;
             break;
+        case 'c':
+            compress = true;
+            break;
         }
     }
 
@@ -3639,6 +3645,14 @@ static int img_rebase(int argc, char **argv)
 
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
@@ -3903,7 +3917,8 @@ static int img_rebase(int argc, char **argv)
                                             bdi.cluster_size);
                         end = end > size ? size : end;
                         ret = blk_pwrite(blk, start, end - start,
-                                         buf_old + (start - offset), 0);
+                                         buf_old + (start - offset),
+                                         write_flags);
                         pnum = end - (offset + written);
                     }
                     if (ret < 0) {
-- 
2.31.1



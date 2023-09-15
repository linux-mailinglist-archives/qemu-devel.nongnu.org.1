Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E0D7D7A237D
	for <lists+qemu-devel@lfdr.de>; Fri, 15 Sep 2023 18:22:26 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qhBYd-0005LW-M3; Fri, 15 Sep 2023 12:20:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1qhBYQ-0005Do-Od; Fri, 15 Sep 2023 12:20:27 -0400
Received: from relay.virtuozzo.com ([130.117.225.111])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1qhBYN-0000Rv-6K; Fri, 15 Sep 2023 12:20:26 -0400
Received: from [130.117.225.1] (helo=dev005.ch-qa.vzint.dev)
 by relay.virtuozzo.com with esmtp (Exim 4.96)
 (envelope-from <andrey.drobyshev@virtuozzo.com>) id 1qhBUx-00Ezdu-1k;
 Fri, 15 Sep 2023 18:20:15 +0200
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, hreitz@redhat.com, kwolf@redhat.com,
 eblake@redhat.com, andrey.drobyshev@virtuozzo.com, den@virtuozzo.com
Subject: [PATCH v2 7/8] qemu-img: add compression option to rebase subcommand
Date: Fri, 15 Sep 2023 19:20:15 +0300
Message-Id: <20230915162016.141771-8-andrey.drobyshev@virtuozzo.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20230915162016.141771-1-andrey.drobyshev@virtuozzo.com>
References: <20230915162016.141771-1-andrey.drobyshev@virtuozzo.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=130.117.225.111;
 envelope-from=andrey.drobyshev@virtuozzo.com; helo=relay.virtuozzo.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Reviewed-by: Denis V. Lunev <den@openvz.org>
Reviewed-by: Hanna Czenczek <hreitz@redhat.com>
---
 docs/tools/qemu-img.rst |  6 ++++--
 qemu-img-cmds.hx        |  4 ++--
 qemu-img.c              | 26 ++++++++++++++++++++------
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
index 83950af42b..8f39dae187 100644
--- a/qemu-img.c
+++ b/qemu-img.c
@@ -3527,11 +3527,13 @@ static int img_rebase(int argc, char **argv)
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
@@ -3548,9 +3550,10 @@ static int img_rebase(int argc, char **argv)
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
@@ -3598,6 +3601,9 @@ static int img_rebase(int argc, char **argv)
         case 'U':
             force_share = true;
             break;
+        case 'c':
+            compress = true;
+            break;
         }
     }
 
@@ -3650,6 +3656,14 @@ static int img_rebase(int argc, char **argv)
 
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
@@ -3659,18 +3673,18 @@ static int img_rebase(int argc, char **argv)
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
@@ -3923,7 +3937,7 @@ static int img_rebase(int argc, char **argv)
                     } else {
                         assert(written + pnum <= IO_BUF_SIZE);
                         ret = blk_pwrite(blk, offset + written, pnum,
-                                         buf_old + written, 0);
+                                         buf_old + written, write_flags);
                     }
                     if (ret < 0) {
                         error_report("Error while writing to COW image: %s",
-- 
2.39.3



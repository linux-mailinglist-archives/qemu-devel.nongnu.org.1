Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id AF64F7A237A
	for <lists+qemu-devel@lfdr.de>; Fri, 15 Sep 2023 18:22:06 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qhBYe-0005ND-8S; Fri, 15 Sep 2023 12:20:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1qhBYQ-0005Dj-KR; Fri, 15 Sep 2023 12:20:27 -0400
Received: from relay.virtuozzo.com ([130.117.225.111])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1qhBYN-0000Rw-3L; Fri, 15 Sep 2023 12:20:26 -0400
Received: from [130.117.225.1] (helo=dev005.ch-qa.vzint.dev)
 by relay.virtuozzo.com with esmtp (Exim 4.96)
 (envelope-from <andrey.drobyshev@virtuozzo.com>) id 1qhBUx-00Ezdu-1C;
 Fri, 15 Sep 2023 18:20:15 +0200
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, hreitz@redhat.com, kwolf@redhat.com,
 eblake@redhat.com, andrey.drobyshev@virtuozzo.com, den@virtuozzo.com
Subject: [PATCH v2 4/8] qemu-img: add chunk size parameter to compare_buffers()
Date: Fri, 15 Sep 2023 19:20:12 +0300
Message-Id: <20230915162016.141771-5-andrey.drobyshev@virtuozzo.com>
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

Add @chsize param to the function which, if non-zero, would represent
the chunk size to be used for comparison.  If it's zero, then
BDRV_SECTOR_SIZE is used as default chunk size, which is the previous
behaviour.

In particular, we're going to use this param in img_rebase() to make the
write requests aligned to a predefined alignment value.

Signed-off-by: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
---
 qemu-img.c | 22 ++++++++++++++--------
 1 file changed, 14 insertions(+), 8 deletions(-)

diff --git a/qemu-img.c b/qemu-img.c
index d12e4a4753..fcd31d7b5b 100644
--- a/qemu-img.c
+++ b/qemu-img.c
@@ -1274,23 +1274,29 @@ static int is_allocated_sectors_min(const uint8_t *buf, int n, int *pnum,
 }
 
 /*
- * Compares two buffers sector by sector. Returns 0 if the first
- * sector of each buffer matches, non-zero otherwise.
+ * Compares two buffers chunk by chunk, where @chsize is the chunk size.
+ * If @chsize is 0, default chunk size of BDRV_SECTOR_SIZE is used.
+ * Returns 0 if the first chunk of each buffer matches, non-zero otherwise.
  *
- * pnum is set to the sector-aligned size of the buffer prefix that
+ * @pnum is set to the size of the buffer prefix aligned to @chsize that
  * has the same matching status as the first sector.
  */
 static int compare_buffers(const uint8_t *buf1, const uint8_t *buf2,
-                           int64_t bytes, int64_t *pnum)
+                           int64_t bytes, uint64_t chsize, int64_t *pnum)
 {
     bool res;
-    int64_t i = MIN(bytes, BDRV_SECTOR_SIZE);
+    int64_t i;
 
     assert(bytes > 0);
 
+    if (!chsize) {
+        chsize = BDRV_SECTOR_SIZE;
+    }
+    i = MIN(bytes, chsize);
+
     res = !!memcmp(buf1, buf2, i);
     while (i < bytes) {
-        int64_t len = MIN(bytes - i, BDRV_SECTOR_SIZE);
+        int64_t len = MIN(bytes - i, chsize);
 
         if (!!memcmp(buf1 + i, buf2 + i, len) != res) {
             break;
@@ -1559,7 +1565,7 @@ static int img_compare(int argc, char **argv)
                     ret = 4;
                     goto out;
                 }
-                ret = compare_buffers(buf1, buf2, chunk, &pnum);
+                ret = compare_buffers(buf1, buf2, chunk, 0, &pnum);
                 if (ret || pnum != chunk) {
                     qprintf(quiet, "Content mismatch at offset %" PRId64 "!\n",
                             offset + (ret ? 0 : pnum));
@@ -3878,7 +3884,7 @@ static int img_rebase(int argc, char **argv)
                 int64_t pnum;
 
                 if (compare_buffers(buf_old + written, buf_new + written,
-                                    n - written, &pnum))
+                                    n - written, 0, &pnum))
                 {
                     if (buf_old_is_zero) {
                         ret = blk_pwrite_zeroes(blk, offset + written, pnum, 0);
-- 
2.39.3



Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 386AC7DD683
	for <lists+qemu-devel@lfdr.de>; Tue, 31 Oct 2023 20:04:57 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qxtxo-0003v1-4U; Tue, 31 Oct 2023 14:59:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1qxtxl-0003uO-40
 for qemu-devel@nongnu.org; Tue, 31 Oct 2023 14:59:41 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1qxtxW-00066J-7b
 for qemu-devel@nongnu.org; Tue, 31 Oct 2023 14:59:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1698778765;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ZpXHGww06P17Mql43X6r4f7SmpAtjADcgn6cLxrmB3Q=;
 b=bMOwZLZm4HIQ7K747fhXFaAzHBe6RElJ3bGi3LQ+TNMS/Y8Pg4oXCEJF9K6suPmyoP1sag
 MS4bAcRkXvZ1uwRoPeQnHugcPRmcPsaaRnyx9bE6m/di7OBIu6ZeYUoOv0mC+wY8ulEbuq
 gyTeYP4jL6FFlheevMkXD3ySNNbgIZM=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-632-wpPXeT6TOYmnNxRgp4FuGw-1; Tue,
 31 Oct 2023 14:59:24 -0400
X-MC-Unique: wpPXeT6TOYmnNxRgp4FuGw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com
 [10.11.54.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id E0BAB1C06E01;
 Tue, 31 Oct 2023 18:59:23 +0000 (UTC)
Received: from merkur.fritz.box (unknown [10.39.194.218])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 4D650143;
 Tue, 31 Oct 2023 18:59:23 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com,
	qemu-devel@nongnu.org
Subject: [PULL 04/27] qemu-img: add chunk size parameter to compare_buffers()
Date: Tue, 31 Oct 2023 19:58:55 +0100
Message-ID: <20231031185918.346940-5-kwolf@redhat.com>
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

Add @chsize param to the function which, if non-zero, would represent
the chunk size to be used for comparison.  If it's zero, then
BDRV_SECTOR_SIZE is used as default chunk size, which is the previous
behaviour.

In particular, we're going to use this param in img_rebase() to make the
write requests aligned to a predefined alignment value.

Signed-off-by: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Reviewed-by: Hanna Czenczek <hreitz@redhat.com>
Message-ID: <20230919165804.439110-5-andrey.drobyshev@virtuozzo.com>
Reviewed-by: Kevin Wolf <kwolf@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 qemu-img.c | 24 +++++++++++++++---------
 1 file changed, 15 insertions(+), 9 deletions(-)

diff --git a/qemu-img.c b/qemu-img.c
index e61d996e0f..a64a664a37 100644
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
- * has the same matching status as the first sector.
+ * @pnum is set to the size of the buffer prefix aligned to @chsize that
+ * has the same matching status as the first chunk.
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
@@ -3887,7 +3893,7 @@ static int img_rebase(int argc, char **argv)
                 int64_t pnum;
 
                 if (compare_buffers(buf_old + written, buf_new + written,
-                                    n - written, &pnum))
+                                    n - written, 0, &pnum))
                 {
                     if (buf_old_is_zero) {
                         ret = blk_pwrite_zeroes(blk, offset + written, pnum, 0);
-- 
2.41.0



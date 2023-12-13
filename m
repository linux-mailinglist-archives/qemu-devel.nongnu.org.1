Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C6CBA811270
	for <lists+qemu-devel@lfdr.de>; Wed, 13 Dec 2023 14:04:53 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rDOtu-0002Qh-2I; Wed, 13 Dec 2023 08:03:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1rDOs6-0008KX-Ez; Wed, 13 Dec 2023 08:01:54 -0500
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1rDOs3-000721-GE; Wed, 13 Dec 2023 08:01:54 -0500
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id B58EB3B441;
 Wed, 13 Dec 2023 16:01:01 +0300 (MSK)
Received: from tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with SMTP id 4DC523C8D2;
 Wed, 13 Dec 2023 16:00:42 +0300 (MSK)
Received: (nullmailer pid 1024736 invoked by uid 1000);
 Wed, 13 Dec 2023 13:00:41 -0000
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Fam Zheng <fam@euphon.net>,
 Kevin Wolf <kwolf@redhat.com>, Eric Blake <eblake@redhat.com>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-7.2.8 14/24] vmdk: Don't corrupt desc file in vmdk_write_cid
Date: Wed, 13 Dec 2023 16:00:23 +0300
Message-Id: <20231213130041.1024630-14-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <qemu-stable-7.2.8-20231213160018@cover.tls.msk.ru>
References: <qemu-stable-7.2.8-20231213160018@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=86.62.121.231; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -68
X-Spam_score: -6.9
X-Spam_bar: ------
X-Spam_report: (-6.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_HI=-5,
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

From: Fam Zheng <fam@euphon.net>

If the text description file is larger than DESC_SIZE, we force the last
byte in the buffer to be 0 and write it out.

This results in a corruption.

Try to allocate a big buffer in this case.

Resolves: https://gitlab.com/qemu-project/qemu/-/issues/1923

Signed-off-by: Fam Zheng <fam@euphon.net>
Message-ID: <20231124115654.3239137-1-fam@euphon.net>
Reviewed-by: Kevin Wolf <kwolf@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
(cherry picked from commit 9fb7b350ba9816ebca8a7614fec486fd4269ab2d)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>
(Mjt: fixups in block/vmdk.c due to missing-in-7.2 v8.0.0-2084-g28944f99c4
 "vmdk: mark more functions as coroutine_fns and GRAPH_RDLOCK")

diff --git a/block/vmdk.c b/block/vmdk.c
index 26376352b9..f8d3a13568 100644
--- a/block/vmdk.c
+++ b/block/vmdk.c
@@ -346,29 +346,41 @@ static int vmdk_write_cid(BlockDriverState *bs, uint32_t cid)
     BDRVVmdkState *s = bs->opaque;
     int ret = 0;
 
-    desc = g_malloc0(DESC_SIZE);
-    tmp_desc = g_malloc0(DESC_SIZE);
-    ret = bdrv_pread(bs->file, s->desc_offset, DESC_SIZE, desc, 0);
+    size_t desc_buf_size;
+
+    if (s->desc_offset == 0) {
+        desc_buf_size = bdrv_getlength(bs->file->bs);
+        if (desc_buf_size > 16ULL << 20) {
+            error_report("VMDK description file too big");
+            return -EFBIG;
+        }
+    } else {
+        desc_buf_size = DESC_SIZE;
+    }
+
+    desc = g_malloc0(desc_buf_size);
+    tmp_desc = g_malloc0(desc_buf_size);
+    ret = bdrv_pread(bs->file, s->desc_offset, desc_buf_size, desc, 0);
     if (ret < 0) {
         goto out;
     }
 
-    desc[DESC_SIZE - 1] = '\0';
+    desc[desc_buf_size - 1] = '\0';
     tmp_str = strstr(desc, "parentCID");
     if (tmp_str == NULL) {
         ret = -EINVAL;
         goto out;
     }
 
-    pstrcpy(tmp_desc, DESC_SIZE, tmp_str);
+    pstrcpy(tmp_desc, desc_buf_size, tmp_str);
     p_name = strstr(desc, "CID");
     if (p_name != NULL) {
         p_name += sizeof("CID");
-        snprintf(p_name, DESC_SIZE - (p_name - desc), "%" PRIx32 "\n", cid);
-        pstrcat(desc, DESC_SIZE, tmp_desc);
+        snprintf(p_name, desc_buf_size - (p_name - desc), "%" PRIx32 "\n", cid);
+        pstrcat(desc, desc_buf_size, tmp_desc);
     }
 
-    ret = bdrv_pwrite_sync(bs->file, s->desc_offset, DESC_SIZE, desc, 0);
+    ret = bdrv_pwrite_sync(bs->file, s->desc_offset, desc_buf_size, desc, 0);
 
 out:
     g_free(desc);
diff --git a/tests/qemu-iotests/059 b/tests/qemu-iotests/059
index e8be217e1f..9bcf1e7525 100755
--- a/tests/qemu-iotests/059
+++ b/tests/qemu-iotests/059
@@ -84,6 +84,8 @@ echo
 echo "=== Testing big twoGbMaxExtentFlat ==="
 _make_test_img -o "subformat=twoGbMaxExtentFlat" 1000G
 _img_info --format-specific | _filter_img_info --format-specific
+$QEMU_IO -c "write 990G 512 -P 89" "$TEST_IMG" | _filter_qemu_io
+$QEMU_IO -c "read 990G 512 -P 89" "$TEST_IMG" | _filter_qemu_io
 _cleanup_test_img
 
 echo
diff --git a/tests/qemu-iotests/059.out b/tests/qemu-iotests/059.out
index 2b83c0c8b6..275ee7c778 100644
--- a/tests/qemu-iotests/059.out
+++ b/tests/qemu-iotests/059.out
@@ -2032,6 +2032,10 @@ Format specific information:
             virtual size: 2147483648
             filename: TEST_DIR/t-f500.IMGFMT
             format: FLAT
+wrote 512/512 bytes at offset 1063004405760
+512 bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+read 512/512 bytes at offset 1063004405760
+512 bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 
 === Testing malformed VMFS extent description line ===
 qemu-img: Could not open 'TEST_DIR/t.IMGFMT': Invalid extent line: RW 12582912 VMFS "dummy.IMGFMT" 1
-- 
2.39.2



Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A8B257FBC4F
	for <lists+qemu-devel@lfdr.de>; Tue, 28 Nov 2023 15:10:51 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r7yma-0002O6-DQ; Tue, 28 Nov 2023 09:09:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1r7ymQ-0002JN-Vp
 for qemu-devel@nongnu.org; Tue, 28 Nov 2023 09:09:40 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1r7ymP-0006Tv-37
 for qemu-devel@nongnu.org; Tue, 28 Nov 2023 09:09:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1701180576;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=y0SLgqUXxE3nfzg7uic379C/SqDnqDo9ankBx/GZ7KI=;
 b=b8ZCimmd6HjGqw2lwTFJNHQr31IBRcvKmbO2cXb7Y4dAGOLSXdlDzL+h30uYpgMOtiHXCt
 Tp+IFhu+QjK2aXdztkl9kjSBF8YgjTPd3dIiBYlETabsg2CzuuqP9TXwi9St3VIw37xDhN
 JDGH5MfVLZtXZEDJa5ghpIxQsEet28c=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-616-5rYVZPMhPju11qbdzzdhmw-1; Tue,
 28 Nov 2023 09:09:33 -0500
X-MC-Unique: 5rYVZPMhPju11qbdzzdhmw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
 [10.11.54.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id BB0D33C100AD;
 Tue, 28 Nov 2023 14:09:32 +0000 (UTC)
Received: from merkur.redhat.com (unknown [10.39.195.36])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 0DEF7502A;
 Tue, 28 Nov 2023 14:09:31 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com,
	stefanha@redhat.com,
	qemu-devel@nongnu.org
Subject: [PULL 2/4] vmdk: Don't corrupt desc file in vmdk_write_cid
Date: Tue, 28 Nov 2023 15:09:24 +0100
Message-ID: <20231128140926.106077-3-kwolf@redhat.com>
In-Reply-To: <20231128140926.106077-1-kwolf@redhat.com>
References: <20231128140926.106077-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.5
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
---
 block/vmdk.c               | 28 ++++++++++++++++++++--------
 tests/qemu-iotests/059     |  2 ++
 tests/qemu-iotests/059.out |  4 ++++
 3 files changed, 26 insertions(+), 8 deletions(-)

diff --git a/block/vmdk.c b/block/vmdk.c
index d87f6d9aaa..d6971c7067 100644
--- a/block/vmdk.c
+++ b/block/vmdk.c
@@ -351,29 +351,41 @@ vmdk_write_cid(BlockDriverState *bs, uint32_t cid)
     BDRVVmdkState *s = bs->opaque;
     int ret = 0;
 
-    desc = g_malloc0(DESC_SIZE);
-    tmp_desc = g_malloc0(DESC_SIZE);
-    ret = bdrv_co_pread(bs->file, s->desc_offset, DESC_SIZE, desc, 0);
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
+    ret = bdrv_co_pread(bs->file, s->desc_offset, desc_buf_size, desc, 0);
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
 
-    ret = bdrv_co_pwrite_sync(bs->file, s->desc_offset, DESC_SIZE, desc, 0);
+    ret = bdrv_co_pwrite_sync(bs->file, s->desc_offset, desc_buf_size, desc, 0);
 
 out:
     g_free(desc);
diff --git a/tests/qemu-iotests/059 b/tests/qemu-iotests/059
index 2bcb1f7f9c..0634c7bd92 100755
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
2.43.0



Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 87A827F7338
	for <lists+qemu-devel@lfdr.de>; Fri, 24 Nov 2023 12:57:49 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r6Unx-0004U5-QI; Fri, 24 Nov 2023 06:57:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <famcool@gmail.com>)
 id 1r6Unu-0004TH-Dk; Fri, 24 Nov 2023 06:57:02 -0500
Received: from mail-ej1-f45.google.com ([209.85.218.45])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <famcool@gmail.com>)
 id 1r6Uns-00061U-01; Fri, 24 Nov 2023 06:57:02 -0500
Received: by mail-ej1-f45.google.com with SMTP id
 a640c23a62f3a-a0064353af8so562252166b.0; 
 Fri, 24 Nov 2023 03:56:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700827017; x=1701431817;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=CF/GV6Y1bZnHR/PVhRTV0AU+6j/bOINaie+6HJkVhN4=;
 b=LgLOkdGYLoMH85k+vEkx9yU0/Hydz3P6j0KJqR5Y2GUykHSPLLBUTlGMwobSvvYeDP
 n8zPDAoOk1Ziiw8qZ+YfjERuwtBod39vPOIHpy/ITaX7g744Dl1R0p2JHKZOuykEZ4qm
 JJQ4qPEeYJX/OAywDOCpWApiekvV9M1LZG58iyVQz4JUTY6ZGSng8nrax7eVije9IJ9E
 q/xkNBVDT997RR9nQ+6c1jUsVDvELTyDZOF1nzyKHZq+166Ggdmz8EJu26N3/CCQu7Os
 fq2lUArJf7Wap+Zx10xIlFTdHh7pFXJ8IvsTVmzrryJmHOnKjNRfaWskRtqedOH6E/Cu
 CGNw==
X-Gm-Message-State: AOJu0Yy0U2aeaFFZm5ztjJ/fSGTbakaTMCjPgKP9mqt7+trTQDoirFTV
 M5efkDoJOLviERHNI9dLhAKfQ8RehCo=
X-Google-Smtp-Source: AGHT+IFPfhizbcNi7G+9FHMHGKTrwvDL9RlacskrIGkvAvq5WxizVYbf3XVayAaGg9azpMixdeI+iA==
X-Received: by 2002:a17:906:15b:b0:a00:1c10:f94e with SMTP id
 27-20020a170906015b00b00a001c10f94emr4891977ejh.3.1700827016696; 
 Fri, 24 Nov 2023 03:56:56 -0800 (PST)
Received: from localhost ([91.110.29.210]) by smtp.gmail.com with ESMTPSA id
 my47-20020a1709065a6f00b009920a690cd9sm1993837ejc.59.2023.11.24.03.56.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 24 Nov 2023 03:56:55 -0800 (PST)
From: Fam <fam@euphon.net>
To: qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 qemu-block@nongnu.org, Fam Zheng <fam@euphon.net>
Subject: [PATCH] vmdk: Don't corrupt desc file in vmdk_write_cid
Date: Fri, 24 Nov 2023 11:56:54 +0000
Message-Id: <20231124115654.3239137-1-fam@euphon.net>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=209.85.218.45; envelope-from=famcool@gmail.com;
 helo=mail-ej1-f45.google.com
X-Spam_score_int: -13
X-Spam_score: -1.4
X-Spam_bar: -
X-Spam_report: (-1.4 / 5.0 requ) BAYES_00=-1.9, FREEMAIL_FORGED_FROMDOMAIN=0.25,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.25,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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
2.34.1



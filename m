Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C2B17A3F13
	for <lists+qemu-devel@lfdr.de>; Mon, 18 Sep 2023 03:03:42 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qi2fH-0000HP-0q; Sun, 17 Sep 2023 21:03:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jeuk20.kim@gmail.com>)
 id 1qi2f9-00008h-3z; Sun, 17 Sep 2023 21:02:55 -0400
Received: from mail-pl1-x62b.google.com ([2607:f8b0:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jeuk20.kim@gmail.com>)
 id 1qi2f3-0003w0-O8; Sun, 17 Sep 2023 21:02:51 -0400
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-1c0c6d4d650so36041595ad.0; 
 Sun, 17 Sep 2023 18:02:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1694998967; x=1695603767; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=qfZjrz+V+vXxmF969ZA46zPhPvZBIZf13lLxUH9oy8s=;
 b=FUukY/kc8uZRZ8Tps3dIaLLtfhkMOXjZmQUfQwPkcGIbOKl34cFlNOllNx6JwAx4cR
 zgP+CyvNKH1bPlkdj6bTrAZm5vYy07evpQKvxRD00a9dqDLDJhOrWljsI66ksg5G02pJ
 DBJmjk19hNNJpdiG6tSaco1GRgYnc89/zZmoXfGjw6NNZzUrGOvryngBeBPWjThpNY21
 HogtImTeT0twmVSehQcmf6R1jt3YtWN1tZaSj6YekvgzeGSOMFFYJaX+TBYOFUoeSRFK
 s5a4QDCykw4YRcjM4OL2EQ4DbX4VwJY6csJF2jOb55+4PV1ljyVYkUXCojf69koXqDwY
 c0CQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694998967; x=1695603767;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=qfZjrz+V+vXxmF969ZA46zPhPvZBIZf13lLxUH9oy8s=;
 b=AEjqAC5jLMYSgUuNWHGtMmBOXnx9hMrS+JM2j/0KBAHdquA9nHtlqgAYCydPQoj/4t
 /FzpTDloIj/MRsJthTQ5ltxKCJOWIjYY0g0mnkG9ZYj9p7K65/QVmqPh2C4/wjNPb3oD
 It5eZ357RzZ+urk0qo+AsTy/eaOMQAIhGpNN8MqdPbBdNWgjBquv0xJ842jFjwC5y86I
 c8HQdcgBIt2ixfgsNVBUBGp6ovVjJeQ6aGyxYq609EdkLHM8wiJ4ZIU2QZcMx/yrY1C2
 KitKY+/8SuBX3r2feuuoELZnTMA2lZSMrn8wbYRZh8sur+vL8U5tenWQdfr1/GNNTNPP
 7I9A==
X-Gm-Message-State: AOJu0YzDDuti37BvfB8w7qjwMdh6r85qClCCYqrAUrpO0WTULVj/ZKUO
 b8KieabFHiSpXHRJFUMGlpYexuGEdaqYZA==
X-Google-Smtp-Source: AGHT+IE/iHJW0I6nMxIHHYoIO4gQpMu6xrXuwfHpgbkUaORa4XY7ENjM+scYn/yMKpaDHwDnin0zRA==
X-Received: by 2002:a17:903:11c6:b0:1c3:9aaf:97be with SMTP id
 q6-20020a17090311c600b001c39aaf97bemr9324081plh.56.1694998967187; 
 Sun, 17 Sep 2023 18:02:47 -0700 (PDT)
Received: from jeuk-MS-7D42.. ([218.147.112.168])
 by smtp.gmail.com with ESMTPSA id
 h7-20020a170902b94700b001bc21222e34sm7120090pls.285.2023.09.17.18.02.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 17 Sep 2023 18:02:46 -0700 (PDT)
From: Jeuk Kim <jeuk20.kim@gmail.com>
To: qemu-devel@nongnu.org
Cc: jeuk20.kim@samsung.com, lvivier@redhat.com, pbonzini@redhat.com,
 qemu-block@nongnu.org, stefanha@redhat.com, thuth@redhat.com,
 peter.maydell@linaro.org
Subject: [PATCH] hw/ufs: Fix code coverity issues
Date: Mon, 18 Sep 2023 10:02:36 +0900
Message-Id: <16b78677529e4af207baaac3139aed50cc6aa7cf.1694998332.git.jeuk20.kim@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62b;
 envelope-from=jeuk20.kim@gmail.com; helo=mail-pl1-x62b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

From: Jeuk Kim <jeuk20.kim@samsung.com>

Fixed four ufs-related coverity issues.

The coverity issues and fixes are as follows

1. CID 1519042: Security issue with the rand() function
Changed to use a fixed value (0xab) instead of rand() as
the value for testing

2. CID 1519043: Dereference after null check
Removed useless (redundant) null checks

3. CID 1519050: Out-of-bounds access issue
Fix to pass an array type variable to find_first_bit and
find_next_bit using DECLARE_BITMAP()

4. CID 1519051: Out-of-bounds read issue
Fix incorrect range check for lun

Fix coverity CID: 1519042 1519043 1519050 1519051

Signed-off-by: Jeuk Kim <jeuk20.kim@samsung.com>
---
 hw/ufs/lu.c            | 16 +++++++---------
 hw/ufs/ufs.c           | 10 +++++-----
 tests/qtest/ufs-test.c |  2 +-
 3 files changed, 13 insertions(+), 15 deletions(-)

diff --git a/hw/ufs/lu.c b/hw/ufs/lu.c
index e1c46bddb1..13b5e37b53 100644
--- a/hw/ufs/lu.c
+++ b/hw/ufs/lu.c
@@ -1345,13 +1345,12 @@ static void ufs_lu_realize(SCSIDevice *dev, Error **errp)
         return;
     }
 
-    if (lu->qdev.conf.blk) {
-        ctx = blk_get_aio_context(lu->qdev.conf.blk);
-        aio_context_acquire(ctx);
-        if (!blkconf_blocksizes(&lu->qdev.conf, errp)) {
-            goto out;
-        }
+    ctx = blk_get_aio_context(lu->qdev.conf.blk);
+    aio_context_acquire(ctx);
+    if (!blkconf_blocksizes(&lu->qdev.conf, errp)) {
+        goto out;
     }
+
     lu->qdev.blocksize = UFS_BLOCK_SIZE;
     blk_get_geometry(lu->qdev.conf.blk, &nb_sectors);
     nb_blocks = nb_sectors / (lu->qdev.blocksize / BDRV_SECTOR_SIZE);
@@ -1367,10 +1366,9 @@ static void ufs_lu_realize(SCSIDevice *dev, Error **errp)
     }
 
     ufs_lu_brdv_init(lu, errp);
+
 out:
-    if (ctx) {
-        aio_context_release(ctx);
-    }
+    aio_context_release(ctx);
 }
 
 static void ufs_lu_unrealize(SCSIDevice *dev)
diff --git a/hw/ufs/ufs.c b/hw/ufs/ufs.c
index 0ecedb9aed..b73eb3deaf 100644
--- a/hw/ufs/ufs.c
+++ b/hw/ufs/ufs.c
@@ -258,7 +258,7 @@ static void ufs_irq_check(UfsHc *u)
 
 static void ufs_process_db(UfsHc *u, uint32_t val)
 {
-    unsigned long doorbell;
+    DECLARE_BITMAP(doorbell, UFS_MAX_NUTRS);
     uint32_t slot;
     uint32_t nutrs = u->params.nutrs;
     UfsRequest *req;
@@ -268,8 +268,8 @@ static void ufs_process_db(UfsHc *u, uint32_t val)
         return;
     }
 
-    doorbell = val;
-    slot = find_first_bit(&doorbell, nutrs);
+    memcpy(doorbell, &val, sizeof(val));
+    slot = find_first_bit(doorbell, nutrs);
 
     while (slot < nutrs) {
         req = &u->req_list[slot];
@@ -285,7 +285,7 @@ static void ufs_process_db(UfsHc *u, uint32_t val)
 
         trace_ufs_process_db(slot);
         req->state = UFS_REQUEST_READY;
-        slot = find_next_bit(&doorbell, nutrs, slot + 1);
+        slot = find_next_bit(doorbell, nutrs, slot + 1);
     }
 
     qemu_bh_schedule(u->doorbell_bh);
@@ -838,7 +838,7 @@ static QueryRespCode ufs_read_unit_desc(UfsRequest *req)
     uint8_t lun = req->req_upiu.qr.index;
 
     if (lun != UFS_UPIU_RPMB_WLUN &&
-        (lun > UFS_MAX_LUS || u->lus[lun] == NULL)) {
+        (lun >= UFS_MAX_LUS || u->lus[lun] == NULL)) {
         trace_ufs_err_query_invalid_index(req->req_upiu.qr.opcode, lun);
         return UFS_QUERY_RESULT_INVALID_INDEX;
     }
diff --git a/tests/qtest/ufs-test.c b/tests/qtest/ufs-test.c
index ed3dbca154..15d467630c 100644
--- a/tests/qtest/ufs-test.c
+++ b/tests/qtest/ufs-test.c
@@ -497,7 +497,7 @@ static void ufstest_read_write(void *obj, void *data, QGuestAllocator *alloc)
     g_assert_cmpuint(block_size, ==, 4096);
 
     /* Write data */
-    memset(write_buf, rand() % 255 + 1, block_size);
+    memset(write_buf, 0xab, block_size);
     ufs_send_scsi_command(ufs, 0, 1, write_cdb, write_buf, block_size, NULL, 0,
                           &utrd, &rsp_upiu);
     g_assert_cmpuint(le32_to_cpu(utrd.header.dword_2), ==, UFS_OCS_SUCCESS);
-- 
2.34.1



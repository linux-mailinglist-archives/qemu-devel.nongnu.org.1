Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DA8F47C7D5B
	for <lists+qemu-devel@lfdr.de>; Fri, 13 Oct 2023 08:00:11 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qrBCZ-0004vA-KG; Fri, 13 Oct 2023 01:59:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jeuk20.kim@gmail.com>)
 id 1qrBCX-0004uB-9Q; Fri, 13 Oct 2023 01:59:09 -0400
Received: from mail-pf1-x431.google.com ([2607:f8b0:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jeuk20.kim@gmail.com>)
 id 1qrBCV-0007zO-MP; Fri, 13 Oct 2023 01:59:09 -0400
Received: by mail-pf1-x431.google.com with SMTP id
 d2e1a72fcca58-68bed2c786eso1342703b3a.0; 
 Thu, 12 Oct 2023 22:59:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1697176746; x=1697781546; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Pq9KFy5cX6IpFnXTHJ31ht1wxLdp1w4ux3S7w4R6ajg=;
 b=BbxF8hzJGXeg1Rg/aEHAYrNqlu/mO4Nv5pyw9ku3/oVGEAxCUv9utM46EqpoJtNMbI
 efURQn+d47ptnnI+nRXPSL4yJgFHHh9R1PUMtIp0Zm+LcnySfnfZ5Tcmts2fYutPhWa3
 0tYKQzdQdcB7hMY8ZPjGUq/9t2uUmJiT5CEiRqb5uLNOLVUsA82EheAeS58Qb6kyifJy
 BD5BBw5dxbyq/XtJfxIn1jXkHdHyrAe4MjN9LOy0rTwuKiHHBC14DgWICByTgCHMeJ+I
 JWr9SCMzbTz1B5Zq1Unl5lp138B2ShbOvyYR85VKkBBFBmkf5Zdy7bconQNkEYGjBuAv
 TglA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697176746; x=1697781546;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Pq9KFy5cX6IpFnXTHJ31ht1wxLdp1w4ux3S7w4R6ajg=;
 b=pzT/PUPCjwEzimPLwMRP766aoxC23++vYabttIrXxYooCj9y8Mj3UZkQnpwdU43xUe
 xJET/TLNFOllb7PhhAIDjLka8hKsLchaP6YD0goHifaGqk5FiFeusgMm50hnkgeBtjaJ
 5QUCwxD0XFkNmRtm1X1JOeHe+tHikRVsIswT8j+y3d9U6yypz5qWgQrk5nYvO4pOOyqp
 AY7cWAZ36xcdYM8r17Q8NY2TM/NvPlMCZi/MOuI8l1KOA68QppoQX8iyMf/JYZINkYy9
 0UOCSiUDNdw591jhezelDe2XzEWGWey7/zuPb4g8b0DKPDtZOhTsqEBCiw0gEtyXeUkf
 Zlqg==
X-Gm-Message-State: AOJu0Yzeya3RETDjhA1DHTcrUcfFr6BU+YDehWuBwuPYviXyaURebgFx
 nEcz5iMxuxAwfzXoSurLu9eIA4CojRwHHw==
X-Google-Smtp-Source: AGHT+IHAGVEVgdJbQyK2cEYZaFcPdJCk6iKw9RuU77WAaswcopbtrdW70gOboWWsdffAz7J5UfVd/w==
X-Received: by 2002:a05:6a00:3a1e:b0:68a:52ec:3d36 with SMTP id
 fj30-20020a056a003a1e00b0068a52ec3d36mr25967255pfb.31.1697176745892; 
 Thu, 12 Oct 2023 22:59:05 -0700 (PDT)
Received: from jeuk-MS-7D42.. ([218.147.112.168])
 by smtp.gmail.com with ESMTPSA id
 6-20020a630806000000b0056c2f1a2f6bsm394071pgi.41.2023.10.12.22.59.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 12 Oct 2023 22:59:05 -0700 (PDT)
From: Jeuk Kim <jeuk20.kim@gmail.com>
To: stefanha@redhat.com,
	qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, qemu-block@nongnu.org, jeuk20.kim@samsung.com,
 bmeng.cn@gmail.com
Subject: [PULL v2 1/2] hw/ufs: Fix code coverity issues
Date: Fri, 13 Oct 2023 14:58:41 +0900
Message-Id: <97970dae534226f045ff08c77bdb8a25e19fa023.1697173209.git.jeuk20.kim@samsung.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1697173209.git.jeuk20.kim@samsung.com>
References: <cover.1697173209.git.jeuk20.kim@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::431;
 envelope-from=jeuk20.kim@gmail.com; helo=mail-pf1-x431.google.com
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
index 0ecedb9aed..2e6d582cc3 100644
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
+    doorbell[0] = val;
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



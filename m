Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1621279F52E
	for <lists+qemu-devel@lfdr.de>; Thu, 14 Sep 2023 00:48:36 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qgYdi-0007BN-3a; Wed, 13 Sep 2023 18:47:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <viktor@daynix.com>) id 1qgYdf-0007A1-1c
 for qemu-devel@nongnu.org; Wed, 13 Sep 2023 18:47:15 -0400
Received: from mail-lf1-x130.google.com ([2a00:1450:4864:20::130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <viktor@daynix.com>) id 1qgYdb-0007nj-Nx
 for qemu-devel@nongnu.org; Wed, 13 Sep 2023 18:47:14 -0400
Received: by mail-lf1-x130.google.com with SMTP id
 2adb3069b0e04-501eec0a373so485795e87.3
 for <qemu-devel@nongnu.org>; Wed, 13 Sep 2023 15:47:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1694645230; x=1695250030;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Z3tMwAfRExD0uT8VCFW97ojoDnYEYZidkv6sT6LS0Hg=;
 b=pz+Y7t0vr1/kOka8fChL97KkaRBEsa2YexkGBWsSYkct4hhOb+332YZIsSTRhE9HPh
 Wd/Xw+vQ2woo9lLDYbGqoz4stZIH7xfhB8K9gUWK4pPSKIIhnGrlrK+902rB5AQAq2QX
 bSc9RHJDjf0MeXhkM0zVguDUQNNhlcx9f9VLSEKli5l3VaKAiGUb7qJpDNvSaH71OWiv
 qztoCr90KUsSmZjUke8spFvvur6WzXOD+b2humusx9ZEHGGnZzA23XyBPdiqad8mE8BK
 jm/KRZAU39zEbbGVpNDYqYXA/m03hQTUTu7iJlQA7AjQ1BW7Ax5HvmEPYB6gzV1FKx/Y
 9qTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694645230; x=1695250030;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Z3tMwAfRExD0uT8VCFW97ojoDnYEYZidkv6sT6LS0Hg=;
 b=QF577DZ00l8EV464LNYCxjKofhd4L/qhZHJpGZ24loGaACJeOtvl8SVklW+rjQtBVa
 GRbfpeAlRdfzYqJ17wBCv3wr1KDyAQOb52dY3LRQJkfC09E+0ShDdMls385j6gw0IQE0
 nliCOTIuOnfh+PVGPNgJAk0U+lxGYrjf5TScjOnuFGlxKFszTse+da2j/0kF+8oFXgVi
 NMrmxEvWy9ZeT5Pfmscrq57EX3nhyUfZOGi7UMyAFJ0xYOLHHsinVDff9xQ7HHHalWiw
 EU+7tyrlK/bG4iKtdxYgUIp3qSwy+gfdnAjGmDfqJhpNvp5UnPNvFoGFXUVUY5E9/7Wd
 D1tw==
X-Gm-Message-State: AOJu0YyN4IKh1fc3zow3AjO328a8VccG4G4gWztxEwNaeo7pOIeX6anC
 7UhUgShAfTyeHasvg8AW75ZL4sFLJLssXxhFwO8=
X-Google-Smtp-Source: AGHT+IHvq4FkgLpMFan4wj1Zp0sMmS1IhixSclOMzcYGmA5zHJmJWah//iA9dV5mIEmcgMyKoa8nRw==
X-Received: by 2002:a05:6512:1151:b0:500:ac71:f26a with SMTP id
 m17-20020a056512115100b00500ac71f26amr3899311lfg.57.1694645230171; 
 Wed, 13 Sep 2023 15:47:10 -0700 (PDT)
Received: from localhost.localdomain ([109.252.90.8])
 by smtp.gmail.com with ESMTPSA id
 u28-20020a056512041c00b004fdba93b92asm25020lfk.252.2023.09.13.15.47.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 13 Sep 2023 15:47:09 -0700 (PDT)
From: Viktor Prutyanov <viktor@daynix.com>
To: annie.li@oracle.com,
	akihiko.odaki@daynix.com,
	kkostiuk@redhat.com
Cc: qemu-devel@nongnu.org, peter.maydell@linaro.org, yan@daynix.com,
 viktor@daynix.com, viktor.prutyanov@phystech.edu
Subject: [PATCH 3/5] elf2dmp: introduce merging of physical memory runs
Date: Thu, 14 Sep 2023 01:46:55 +0300
Message-Id: <20230913224657.11606-4-viktor@daynix.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20230913224657.11606-1-viktor@daynix.com>
References: <20230913224657.11606-1-viktor@daynix.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2a00:1450:4864:20::130;
 envelope-from=viktor@daynix.com; helo=mail-lf1-x130.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

DMP supports 42 physical memory runs at most. So, merge adjacent
physical memory ranges from QEMU ELF when possible to minimize total
number of runs.

Signed-off-by: Viktor Prutyanov <viktor@daynix.com>
---
 contrib/elf2dmp/main.c | 56 ++++++++++++++++++++++++++++++++++++------
 1 file changed, 48 insertions(+), 8 deletions(-)

diff --git a/contrib/elf2dmp/main.c b/contrib/elf2dmp/main.c
index b7e3930164..9ef5cfcd23 100644
--- a/contrib/elf2dmp/main.c
+++ b/contrib/elf2dmp/main.c
@@ -20,6 +20,7 @@
 #define PE_NAME     "ntoskrnl.exe"
 
 #define INITIAL_MXCSR   0x1f80
+#define MAX_NUMBER_OF_RUNS  42
 
 typedef struct idt_desc {
     uint16_t offset1;   /* offset bits 0..15 */
@@ -234,6 +235,42 @@ static int fix_dtb(struct va_space *vs, QEMU_Elf *qe)
     return 1;
 }
 
+static void try_merge_runs(struct pa_space *ps,
+        WinDumpPhyMemDesc64 *PhysicalMemoryBlock)
+{
+    unsigned int merge_cnt = 0, run_idx = 0;
+
+    PhysicalMemoryBlock->NumberOfRuns = 0;
+
+    for (unsigned int idx = 0; idx < ps->block_nr; idx++) {
+        struct pa_block *blk = ps->block + idx;
+        struct pa_block *next = blk + 1;
+
+        PhysicalMemoryBlock->NumberOfPages += blk->size / ELF2DMP_PAGE_SIZE;
+
+        if (idx + 1 != ps->block_nr && blk->paddr + blk->size == next->paddr) {
+            printf("Block #%u 0x%"PRIx64"+:0x%"PRIx64" and %u previous will be "
+                    "merged\n", idx, blk->paddr, blk->size, merge_cnt);
+            merge_cnt++;
+        } else {
+            struct pa_block *first_merged = blk - merge_cnt;
+
+            printf("Block #%u 0x%"PRIx64"+:0x%"PRIx64" and %u previous will be "
+                    "merged to 0x%"PRIx64"+:0x%"PRIx64" and saved as run #%u\n",
+                    idx, blk->paddr, blk->size, merge_cnt, first_merged->paddr,
+                    blk->paddr + blk->size - first_merged->paddr, run_idx);
+            PhysicalMemoryBlock->Run[run_idx] = (WinDumpPhyMemRun64) {
+                .BasePage = first_merged->paddr / ELF2DMP_PAGE_SIZE,
+                .PageCount = (blk->paddr + blk->size - first_merged->paddr) /
+                        ELF2DMP_PAGE_SIZE,
+            };
+            PhysicalMemoryBlock->NumberOfRuns++;
+            run_idx++;
+            merge_cnt = 0;
+        }
+    }
+}
+
 static int fill_header(WinDumpHeader64 *hdr, struct pa_space *ps,
         struct va_space *vs, uint64_t KdDebuggerDataBlock,
         KDDEBUGGER_DATA64 *kdbg, uint64_t KdVersionBlock, int nr_cpus)
@@ -244,7 +281,6 @@ static int fill_header(WinDumpHeader64 *hdr, struct pa_space *ps,
             KUSD_OFFSET_PRODUCT_TYPE);
     DBGKD_GET_VERSION64 kvb;
     WinDumpHeader64 h;
-    size_t i;
 
     QEMU_BUILD_BUG_ON(KUSD_OFFSET_SUITE_MASK >= ELF2DMP_PAGE_SIZE);
     QEMU_BUILD_BUG_ON(KUSD_OFFSET_PRODUCT_TYPE >= ELF2DMP_PAGE_SIZE);
@@ -282,13 +318,17 @@ static int fill_header(WinDumpHeader64 *hdr, struct pa_space *ps,
         .RequiredDumpSpace = sizeof(h),
     };
 
-    for (i = 0; i < ps->block_nr; i++) {
-        h.PhysicalMemoryBlock.NumberOfPages +=
-                ps->block[i].size / ELF2DMP_PAGE_SIZE;
-        h.PhysicalMemoryBlock.Run[i] = (WinDumpPhyMemRun64) {
-            .BasePage = ps->block[i].paddr / ELF2DMP_PAGE_SIZE,
-            .PageCount = ps->block[i].size / ELF2DMP_PAGE_SIZE,
-        };
+    if (h.PhysicalMemoryBlock.NumberOfRuns <= MAX_NUMBER_OF_RUNS) {
+        for (unsigned int idx = 0; idx < ps->block_nr; idx++) {
+            h.PhysicalMemoryBlock.NumberOfPages +=
+                    ps->block[idx].size / ELF2DMP_PAGE_SIZE;
+            h.PhysicalMemoryBlock.Run[idx] = (WinDumpPhyMemRun64) {
+                .BasePage = ps->block[idx].paddr / ELF2DMP_PAGE_SIZE,
+                .PageCount = ps->block[idx].size / ELF2DMP_PAGE_SIZE,
+            };
+        }
+    } else {
+        try_merge_runs(ps, &h.PhysicalMemoryBlock);
     }
 
     h.RequiredDumpSpace +=
-- 
2.21.0



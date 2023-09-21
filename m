Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 60EF97A984A
	for <lists+qemu-devel@lfdr.de>; Thu, 21 Sep 2023 19:39:06 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qjNca-00028w-58; Thu, 21 Sep 2023 13:37:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qjNcX-00027V-Bi
 for qemu-devel@nongnu.org; Thu, 21 Sep 2023 13:37:45 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qjNcO-0007iW-Jp
 for qemu-devel@nongnu.org; Thu, 21 Sep 2023 13:37:45 -0400
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-4051fea48a8so14402235e9.2
 for <qemu-devel@nongnu.org>; Thu, 21 Sep 2023 10:37:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1695317855; x=1695922655; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=hhll5MSt7inD7Gvy+K2LRa4bhUXToZUa0sCF87IjAjw=;
 b=fkzi59TXjCgC2g4vlEfg0AarpdcBxTo30RnCBiKybc4fAhfUM+gDEmu4RDvA979piJ
 HLj58faS8eT6MY1FVEgPVkTBhjA+L9kDHjz2M1Qi8VClq/xZL1xXklpNZp8ky4J5ica2
 kVNaURyKkmtkFy+EEPFsI7fQmv+cirO9W8nQZoh6A+EMv1NzhttzzBsxKQNtGV83oUZ2
 sKngUDUhuNne3iqhPGP8zji3QvggftWWFh9sR7ZsgwS9OhUJUuXJ8P3nmWE28Dv4nfub
 TPISiMXzB6zmm/Ctc1M7yI8FJ5UGR7/z7S7IrbgJLkIg9WsMMLYUiD1qXWfzhJFsbfXr
 AW+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695317855; x=1695922655;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=hhll5MSt7inD7Gvy+K2LRa4bhUXToZUa0sCF87IjAjw=;
 b=Utwcz4brG8cX2fyZxhNJYuG3VQ+qJUhMysABLZUUXoNcYkY5BavBuTuU3WHyCW7wlD
 0FV1+OYuk8+pNBCIwwtnPsXPpDsNWYyrffOIhChiL3PlIBxk4UGJoLA74byLdHJHJAjB
 VJWldHJnjex2XZ7iTnDhgOuLCLuJlZVjj3L8Rnj/Q1T0opX7gEkaOPYE8B1VVtCJffiU
 51KqFmJzjZ9n78QGR7pSCE7hS2eDVRfW8fDcS1cY4B10ualzopN10ApLlj9FrCY1xCd/
 Pjhh/y5Oq0p3DOvoLKoVFCYDkI0FJe01h9MgS6H1coZRmxImSfgYsa0KK7yPH1MW6G11
 b2jg==
X-Gm-Message-State: AOJu0Yyuk0UvOLhC3xrid8YVO9cGd2g2I9Ijo7QupSV+R4IeEBcnmigN
 1e+NJG7G2CHMOlWXzRNVY64UgqvvZYauB0ikXAw=
X-Google-Smtp-Source: AGHT+IFnYHgGyKgFIg662xzfX53i7vf3uGvxlcchKJug6mi57gD6A55LqmS7srmV98cEAcQAHHOILQ==
X-Received: by 2002:a05:600c:364a:b0:401:dc7c:2488 with SMTP id
 y10-20020a05600c364a00b00401dc7c2488mr5366494wmq.11.1695317855215; 
 Thu, 21 Sep 2023 10:37:35 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 m14-20020a7bce0e000000b003feff926fc5sm2464122wmc.17.2023.09.21.10.37.34
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 21 Sep 2023 10:37:35 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 28/30] elf2dmp: introduce merging of physical memory runs
Date: Thu, 21 Sep 2023 18:37:18 +0100
Message-Id: <20230921173720.3250581-29-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230921173720.3250581-1-peter.maydell@linaro.org>
References: <20230921173720.3250581-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

From: Viktor Prutyanov <viktor@daynix.com>

DMP supports 42 physical memory runs at most. So, merge adjacent
physical memory ranges from QEMU ELF when possible to minimize total
number of runs.

Signed-off-by: Viktor Prutyanov <viktor@daynix.com>
Reviewed-by: Akihiko Odaki <akihiko.odaki@daynix.com>
Message-id: 20230915170153.10959-4-viktor@daynix.com
[PMM: fixed format string for printing size_t values]
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 contrib/elf2dmp/main.c | 56 ++++++++++++++++++++++++++++++++++++------
 1 file changed, 48 insertions(+), 8 deletions(-)

diff --git a/contrib/elf2dmp/main.c b/contrib/elf2dmp/main.c
index b7e39301641..5db163bdbe8 100644
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
+    for (size_t idx = 0; idx < ps->block_nr; idx++) {
+        struct pa_block *blk = ps->block + idx;
+        struct pa_block *next = blk + 1;
+
+        PhysicalMemoryBlock->NumberOfPages += blk->size / ELF2DMP_PAGE_SIZE;
+
+        if (idx + 1 != ps->block_nr && blk->paddr + blk->size == next->paddr) {
+            printf("Block #%zu 0x%"PRIx64"+:0x%"PRIx64" and %u previous will be"
+                    " merged\n", idx, blk->paddr, blk->size, merge_cnt);
+            merge_cnt++;
+        } else {
+            struct pa_block *first_merged = blk - merge_cnt;
+
+            printf("Block #%zu 0x%"PRIx64"+:0x%"PRIx64" and %u previous will be"
+                    " merged to 0x%"PRIx64"+:0x%"PRIx64" (run #%u)\n",
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
+        for (size_t idx = 0; idx < ps->block_nr; idx++) {
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
2.34.1



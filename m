Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 10E78830960
	for <lists+qemu-devel@lfdr.de>; Wed, 17 Jan 2024 16:14:46 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rQ7b3-0004wN-KF; Wed, 17 Jan 2024 10:12:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1rQ7b2-0004w8-3A; Wed, 17 Jan 2024 10:12:52 -0500
Received: from mail-pf1-x429.google.com ([2607:f8b0:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1rQ7b0-0005af-G2; Wed, 17 Jan 2024 10:12:51 -0500
Received: by mail-pf1-x429.google.com with SMTP id
 d2e1a72fcca58-6daa89a6452so6840829b3a.2; 
 Wed, 17 Jan 2024 07:12:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1705504368; x=1706109168; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=HRDn1qhEWgftO4QOM/jxoR85tIURkjIxJtKKnF2w1Mk=;
 b=TOI8pAKB68DqAPMhWz8avbxj1rAUfIIbRm5J/dn96yZvb0ydZdCZZlZcfwpAtXSFL9
 jWet9Dpjs4mi4r2C0CcVcPNSlqAUGr87P31IhnpnhBOJLkcgIlH/XgN8f1Rqu5YsRvB9
 G20hmlY+gjXw3X57n0kpIh7mbmx2d9zYypbM5di5Gn+Zqf+hrYXceGVWLivwWsZvJGBw
 TRMyO6+fTyhB7WV1unv/O0nN3IVMHwo8S/snr/sc+MwMI7uRWIRx3PDUvriZTI7H5ook
 fNIEc4wiliW9ZrJVGBgggsvpQROXIiK5TbfT0NBn4T3VQO8LMW6ELKLm34oes9CIawCY
 0cxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705504368; x=1706109168;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=HRDn1qhEWgftO4QOM/jxoR85tIURkjIxJtKKnF2w1Mk=;
 b=Rqs5sIGpoigryawn44GK08+YHITXsZqGcY7Z8cIfqfLW1/UGjIp22S/2uRcLRwhMXw
 kJb4kTwMT6L9B54dk47VyRG9zvq1Y+E/wbO4SoTrMdvuyKI5Ci7tUg0cft6F+7samMLw
 bsv04m3yM4v72WGX9mAO5jFE+HU5uBCfwT+PvmJsSbe3KGZ88NmG1BLbc4VdCUNnnzVF
 jyU+tVw5OMzMqBRo4LxGG3BHlJZTbVrKXPCz/bqp2lkkv57AKGNQtNFnP0B0m7gqUpfd
 OCcaDfFhTM9ZthNZjWIQTFmRywwuBef9eKSXZAX6m95tDllf9v81NTn+McHgTwpUn8iM
 u9cQ==
X-Gm-Message-State: AOJu0YxsX3Cn41MWV+vr8mCiI6dvM5HXU0pFT6RbPUjZSrzqilAmi4w9
 NIeM/CB6U+8m+bvVAWEhkrgc1bqRoOk=
X-Google-Smtp-Source: AGHT+IF1e6ECa6T/O2CSo+0EGL1RlXPw70nwyZxsaOsLspS9SbscWBPGExf6BPhWwjMEFRHHEtExcA==
X-Received: by 2002:a62:ce4a:0:b0:6d9:f6a2:733 with SMTP id
 y71-20020a62ce4a000000b006d9f6a20733mr5697495pfg.5.1705504368131; 
 Wed, 17 Jan 2024 07:12:48 -0800 (PST)
Received: from wheely.local0.net (124-171-76-150.tpgi.com.au. [124.171.76.150])
 by smtp.gmail.com with ESMTPSA id
 fb42-20020a056a002daa00b006d9aa4b65fasm1586976pfb.98.2024.01.17.07.12.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 17 Jan 2024 07:12:47 -0800 (PST)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-ppc@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 BALATON Zoltan <balaton@eik.bme.hu>, qemu-devel@nongnu.org
Subject: [PATCH 1/6] target/ppc: Fix 440 tlbwe TLB invalidation gaps
Date: Thu, 18 Jan 2024 01:12:33 +1000
Message-ID: <20240117151238.93323-1-npiggin@gmail.com>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::429;
 envelope-from=npiggin@gmail.com; helo=mail-pf1-x429.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

The 440 software TLB write entry misses several cases that must flush
the TCG TLB:
- If the new size is smaller than the existing size, the EA no longer
  covered should be flushed. This looks like an inverted inequality test.
- If the TLB PID changes.
- If the TLB attr bit 0 (translation address space) changes.
- If low prot (access control) bits change.

Fix this by removing tricks to avoid TLB flushes, and just invalidate
the TLB if any valid entry is being changed, similarly to 4xx.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 target/ppc/mmu_helper.c | 35 ++++++++++-------------------------
 1 file changed, 10 insertions(+), 25 deletions(-)

diff --git a/target/ppc/mmu_helper.c b/target/ppc/mmu_helper.c
index f87d35379a..c140f3c96d 100644
--- a/target/ppc/mmu_helper.c
+++ b/target/ppc/mmu_helper.c
@@ -855,49 +855,34 @@ void helper_440_tlbwe(CPUPPCState *env, uint32_t word, target_ulong entry,
                       target_ulong value)
 {
     ppcemb_tlb_t *tlb;
-    target_ulong EPN, RPN, size;
-    int do_flush_tlbs;
 
     qemu_log_mask(CPU_LOG_MMU, "%s word %d entry %d value " TARGET_FMT_lx "\n",
                   __func__, word, (int)entry, value);
-    do_flush_tlbs = 0;
     entry &= 0x3F;
     tlb = &env->tlb.tlbe[entry];
+
+    /* Invalidate previous TLB (if it's valid) */
+    if (tlb->prot & PAGE_VALID) {
+        tlb_flush(env_cpu(env));
+    }
+
     switch (word) {
     default:
         /* Just here to please gcc */
     case 0:
-        EPN = value & 0xFFFFFC00;
-        if ((tlb->prot & PAGE_VALID) && EPN != tlb->EPN) {
-            do_flush_tlbs = 1;
-        }
-        tlb->EPN = EPN;
-        size = booke_tlb_to_page_size((value >> 4) & 0xF);
-        if ((tlb->prot & PAGE_VALID) && tlb->size < size) {
-            do_flush_tlbs = 1;
-        }
-        tlb->size = size;
+        tlb->EPN = value & 0xFFFFFC00;
+        tlb->size = booke_tlb_to_page_size((value >> 4) & 0xF);
         tlb->attr &= ~0x1;
         tlb->attr |= (value >> 8) & 1;
         if (value & 0x200) {
             tlb->prot |= PAGE_VALID;
         } else {
-            if (tlb->prot & PAGE_VALID) {
-                tlb->prot &= ~PAGE_VALID;
-                do_flush_tlbs = 1;
-            }
+            tlb->prot &= ~PAGE_VALID;
         }
         tlb->PID = env->spr[SPR_440_MMUCR] & 0x000000FF;
-        if (do_flush_tlbs) {
-            tlb_flush(env_cpu(env));
-        }
         break;
     case 1:
-        RPN = value & 0xFFFFFC0F;
-        if ((tlb->prot & PAGE_VALID) && tlb->RPN != RPN) {
-            tlb_flush(env_cpu(env));
-        }
-        tlb->RPN = RPN;
+        tlb->RPN = value & 0xFFFFFC0F;
         break;
     case 2:
         tlb->attr = (tlb->attr & 0x1) | (value & 0x0000FF00);
-- 
2.42.0



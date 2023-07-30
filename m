Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F1EA76851B
	for <lists+qemu-devel@lfdr.de>; Sun, 30 Jul 2023 13:41:28 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qQ4Rx-0001b4-Ot; Sun, 30 Jul 2023 07:19:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1qQ4Rr-0001aP-Ns; Sun, 30 Jul 2023 07:18:55 -0400
Received: from mail-pf1-x431.google.com ([2607:f8b0:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1qQ4Rq-00044y-21; Sun, 30 Jul 2023 07:18:55 -0400
Received: by mail-pf1-x431.google.com with SMTP id
 d2e1a72fcca58-686daaa5f1fso2494863b3a.3; 
 Sun, 30 Jul 2023 04:18:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1690715932; x=1691320732;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=SURs+ScrIjn9khViEWr6aLjSCMUqJ5Hwe3Wsaf1fdW0=;
 b=SZXNGUnZnOd9H9Ab5/YD7hrmRRpjdmhTt774Y0uyVpR44BruX7p2jam2iH5Qf/MkfK
 2fGveXNJjEQNYgJMMx80U+OLTWJte0MjvSAz/Km4/uW4CgY9gJP3iN9DG6g4rhmk56/0
 P8saXujFfz3xjq1TPaoOYs+a4JAWuNM0DD/ERkrevwrmOdrcMCFj7x+A6wzHQ6NHZz/6
 NvS8i8KNO8CqYd1OrqcJzlI3kzXVb1v0IrvIMY5jt2Ox/lb1cAm0M+F7ol2xH4+nk3H1
 2DHg2cCdZkW01uA8KFxX+EGRTYmr7h2SgsUJonKZW4mH72uyX+2Ean6d50tUgrhzMKkX
 okFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1690715932; x=1691320732;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=SURs+ScrIjn9khViEWr6aLjSCMUqJ5Hwe3Wsaf1fdW0=;
 b=gorMpeyGQu1U65xAhL/UH2z/LjSCQFtoQIMZPGxGOcZPKn9Vu0dq7KDqicdnpjbOLG
 EoU2NpIGayR8JuYmSnlc3Ws+tZ27reLoOHbOcMDEPVzsykw6K6H27nedDEV0ubfAB0dR
 SmJJyu/g9xM22LI3b96nKzw8S4Zv/7H6Pixkwz8bYeWSMUvG8sPtrTFPOgJJ38ISXM16
 f++ZwjnLmeC6AGi9k4uzHVKxZJPmuBgdBPsxr6h6X48wJu8RI0UxYk2uLk04w1Q6yqDP
 vPu+an8M7bHWShlP+TX0qXivm6btzRLeainCdbGV+kvMfvjc0+GXwMKZ63zReuDG+xYt
 UKgg==
X-Gm-Message-State: ABy/qLZxILa7aWwZefB0icYmD+EM8/NmH108urVvJytB/ESyvG5shfGj
 V5hkyVlcdAZmzuRIJDiNB9c=
X-Google-Smtp-Source: APBJJlFpagWPeA6SJOih2+UmKvRn0/G9utNOAzuLmsO33MUtfZ+GkTwOq+vbNIgS35tI2k2oRAn8fg==
X-Received: by 2002:a05:6a20:7f95:b0:130:835b:e6b7 with SMTP id
 d21-20020a056a207f9500b00130835be6b7mr7684494pzj.47.1690715931714; 
 Sun, 30 Jul 2023 04:18:51 -0700 (PDT)
Received: from wheely.local0.net (110-174-143-94.tpgi.com.au. [110.174.143.94])
 by smtp.gmail.com with ESMTPSA id
 w8-20020a170902e88800b001bb1f09189bsm6482441plg.221.2023.07.30.04.18.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 30 Jul 2023 04:18:51 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: Daniel Henrique Barboza <danielhb413@gmail.com>
Cc: Nicholas Piggin <npiggin@gmail.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 David Gibson <david@gibson.dropbear.id.au>, Greg Kurz <groug@kaod.org>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>, qemu-ppc@nongnu.org,
 qemu-devel@nongnu.org
Subject: [PATCH v2] target/ppc: Fix VRMA page size for ISA v3.0
Date: Sun, 30 Jul 2023 21:18:42 +1000
Message-Id: <20230730111842.39292-1-npiggin@gmail.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::431;
 envelope-from=npiggin@gmail.com; helo=mail-pf1-x431.google.com
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

Until v2.07s, the VRMA page size (L||LP) was encoded in LPCR[VRMASD].
In v3.0 that moved to the partition table PS field.

The powernv machine can now run KVM HPT guests on POWER9/10 CPUs with
this fix and the patch to add ASDR.

Fixes: 3367c62f522b ("target/ppc: Support for POWER9 native hash")
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
Since v1:
- Added llp variable to avoid calling get_vrma_llp twice [Cedric].
- Added some bit defines for architected fields and values [Cedric].

Patches 1,3 from the previously posted series, let's defer 4-6
decrementer fixes until after 8.1, so this is the last remaining
one from the series.

Thanks,
Nick

 target/ppc/mmu-hash64.c | 45 +++++++++++++++++++++++++++++++++++------
 target/ppc/mmu-hash64.h |  5 +++++
 2 files changed, 44 insertions(+), 6 deletions(-)

diff --git a/target/ppc/mmu-hash64.c b/target/ppc/mmu-hash64.c
index a0c90df3ce..d645c0bb94 100644
--- a/target/ppc/mmu-hash64.c
+++ b/target/ppc/mmu-hash64.c
@@ -874,12 +874,46 @@ static target_ulong rmls_limit(PowerPCCPU *cpu)
     return rma_sizes[rmls];
 }
 
-static int build_vrma_slbe(PowerPCCPU *cpu, ppc_slb_t *slb)
+/* Return the LLP in SLB_VSID format */
+static uint64_t get_vrma_llp(PowerPCCPU *cpu)
 {
     CPUPPCState *env = &cpu->env;
-    target_ulong lpcr = env->spr[SPR_LPCR];
-    uint32_t vrmasd = (lpcr & LPCR_VRMASD) >> LPCR_VRMASD_SHIFT;
-    target_ulong vsid = SLB_VSID_VRMA | ((vrmasd << 4) & SLB_VSID_LLP_MASK);
+    uint64_t llp;
+
+    if (env->mmu_model == POWERPC_MMU_3_00) {
+        ppc_v3_pate_t pate;
+        uint64_t ps, l, lp;
+
+        /*
+         * ISA v3.0 removes the LPCR[VRMASD] field and puts the VRMA base
+         * page size (L||LP equivalent) in the PS field in the HPT partition
+         * table entry.
+         */
+        if (!ppc64_v3_get_pate(cpu, cpu->env.spr[SPR_LPIDR], &pate)) {
+            error_report("Bad VRMA with no partition table entry");
+            return 0;
+        }
+        ps = PATE0_GET_PS(pate.dw0);
+        /* PS has L||LP in 3 consecutive bits, put them into SLB LLP format */
+        l = (ps >> 2) & 0x1;
+        lp = ps & 0x3;
+        llp = (l << SLB_VSID_L_SHIFT) | (lp << SLB_VSID_LP_SHIFT);
+
+    } else {
+        uint64_t lpcr = env->spr[SPR_LPCR];
+        target_ulong vrmasd = (lpcr & LPCR_VRMASD) >> LPCR_VRMASD_SHIFT;
+
+        /* VRMASD LLP matches SLB format, just shift and mask it */
+        llp = (vrmasd << SLB_VSID_LP_SHIFT) & SLB_VSID_LLP_MASK;
+    }
+
+    return llp;
+}
+
+static int build_vrma_slbe(PowerPCCPU *cpu, ppc_slb_t *slb)
+{
+    uint64_t llp = get_vrma_llp(cpu);
+    target_ulong vsid = SLB_VSID_VRMA | llp;
     int i;
 
     for (i = 0; i < PPC_PAGE_SIZES_MAX_SZ; i++) {
@@ -897,8 +931,7 @@ static int build_vrma_slbe(PowerPCCPU *cpu, ppc_slb_t *slb)
         }
     }
 
-    error_report("Bad page size encoding in LPCR[VRMASD]; LPCR=0x"
-                 TARGET_FMT_lx, lpcr);
+    error_report("Bad VRMA page size encoding 0x" TARGET_FMT_lx, llp);
 
     return -1;
 }
diff --git a/target/ppc/mmu-hash64.h b/target/ppc/mmu-hash64.h
index 1496955d38..de653fcae5 100644
--- a/target/ppc/mmu-hash64.h
+++ b/target/ppc/mmu-hash64.h
@@ -41,8 +41,10 @@ void ppc_hash64_finalize(PowerPCCPU *cpu);
 #define SLB_VSID_KP             0x0000000000000400ULL
 #define SLB_VSID_N              0x0000000000000200ULL /* no-execute */
 #define SLB_VSID_L              0x0000000000000100ULL
+#define SLB_VSID_L_SHIFT        PPC_BIT_NR(55)
 #define SLB_VSID_C              0x0000000000000080ULL /* class */
 #define SLB_VSID_LP             0x0000000000000030ULL
+#define SLB_VSID_LP_SHIFT       PPC_BIT_NR(59)
 #define SLB_VSID_ATTR           0x0000000000000FFFULL
 #define SLB_VSID_LLP_MASK       (SLB_VSID_L | SLB_VSID_LP)
 #define SLB_VSID_4K             0x0000000000000000ULL
@@ -58,6 +60,9 @@ void ppc_hash64_finalize(PowerPCCPU *cpu);
 #define SDR_64_HTABSIZE        0x000000000000001FULL
 
 #define PATE0_HTABORG           0x0FFFFFFFFFFC0000ULL
+#define PATE0_PS                PPC_BITMASK(56, 58)
+#define PATE0_GET_PS(dw0)       (((dw0) & PATE0_PS) >> PPC_BIT_NR(58))
+
 #define HPTES_PER_GROUP         8
 #define HASH_PTE_SIZE_64        16
 #define HASH_PTEG_SIZE_64       (HASH_PTE_SIZE_64 * HPTES_PER_GROUP)
-- 
2.40.1



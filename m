Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 51BF57704C7
	for <lists+qemu-devel@lfdr.de>; Fri,  4 Aug 2023 17:32:29 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qRwlR-0006uL-5r; Fri, 04 Aug 2023 11:30:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <danielhb413@gmail.com>)
 id 1qRwl9-0006Oj-7d; Fri, 04 Aug 2023 11:30:35 -0400
Received: from mail-oa1-x34.google.com ([2001:4860:4864:20::34])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <danielhb413@gmail.com>)
 id 1qRwl7-0004TJ-KK; Fri, 04 Aug 2023 11:30:34 -0400
Received: by mail-oa1-x34.google.com with SMTP id
 586e51a60fabf-1bb571ea965so1594639fac.0; 
 Fri, 04 Aug 2023 08:30:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1691163032; x=1691767832;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qJnKCGmP9kaedWrwkgycSEaXLaOS7eo0z/drQLy3XG4=;
 b=JByYRihgxxU5gWilylamf1mrHpEZAk/B/zY8M7a7aPJ64XsaEuN/wVw0D7bVQlah91
 6yUMzLICiEMiPQMqoS4teim4Eq/l4PB9d+PbaPWSzvFuZEdfveFGeOyR6C0zNqf1RPRD
 tp69SSsT5mCyb/Ob9nWpXoPijGiLEM3aCQa5vNCvk6AZHaGsAxRSy+YuxoSxz7G+1FgT
 qZhbUQjt2vo7BWxVlKmya7QbfljMji7XmdtYUAlpY9C9v4aHkHhcGcOY+P5zfmuVGTC7
 HyBVyX8GEC04/ir3II7BY3bQ1qgaAg0Bam+90mqOYHpT/1m7n+VKUKuJsr+Ag65hDyeD
 bnPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691163032; x=1691767832;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=qJnKCGmP9kaedWrwkgycSEaXLaOS7eo0z/drQLy3XG4=;
 b=RrhZe2bM4TAvB8aTe8kp2kPWDjWvcPdIocgEbo7peykxKczbEzZKW8sQENhU4cRgXt
 ykwhfmayTrr+W62tkGHYhlh0eBpx0MMmX7D2ALTD0wn+ok69vKjfocqpgb2QEXrQGQdU
 NYsDppLr6riZTKY6HqkEAM6gEQL+rLHIqIdHumlnQ6AXhLeLVY/hE1o7yCgGt3cfDVhM
 4qlZsviBiBCQABOvc1CdNd7UeopITKuy1JuULL5Z4n67+oYfTP9y+5l1m9BdbO1nvL/B
 2hXifyY05Ndon2Mq0J1kDek0/NkffCmjFEEkCpjfSuZb8CO0kB0VDHX9J31j2xRSy1qD
 JzMQ==
X-Gm-Message-State: AOJu0YybDmKN2oetb7qdJ0Fen0sswO4fuO1B4mITs2Y31P00+Wu8C1Oz
 6/I5mf48lZhJ+UcHdNz6XCSeg1MEDWQ=
X-Google-Smtp-Source: AGHT+IHPPCjDQBYlwIfKnJzJdMmyD0S+C1mCGJP6HNEp3yvGYk2VO0NtPlIZSuOiWGRzD0rnC48HKg==
X-Received: by 2002:a05:6870:9708:b0:1bb:6485:7988 with SMTP id
 n8-20020a056870970800b001bb64857988mr2357817oaq.35.1691163032131; 
 Fri, 04 Aug 2023 08:30:32 -0700 (PDT)
Received: from grind.. ([177.197.108.190]) by smtp.gmail.com with ESMTPSA id
 q4-20020a4a4b04000000b00560b1febfdfsm1115761ooa.10.2023.08.04.08.30.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 04 Aug 2023 08:30:31 -0700 (PDT)
From: Daniel Henrique Barboza <danielhb413@gmail.com>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, danielhb413@gmail.com, peter.maydell@linaro.org,
 richard.henderson@linaro.org, Nicholas Piggin <npiggin@gmail.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Subject: [PULL 7/7] target/ppc: Fix VRMA page size for ISA v3.0
Date: Fri,  4 Aug 2023 12:29:55 -0300
Message-ID: <20230804152955.22316-8-danielhb413@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230804152955.22316-1-danielhb413@gmail.com>
References: <20230804152955.22316-1-danielhb413@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2001:4860:4864:20::34;
 envelope-from=danielhb413@gmail.com; helo=mail-oa1-x34.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

From: Nicholas Piggin <npiggin@gmail.com>

Until v2.07s, the VRMA page size (L||LP) was encoded in LPCR[VRMASD].
In v3.0 that moved to the partition table PS field.

The powernv machine can now run KVM HPT guests on POWER9/10 CPUs with
this fix and the patch to add ASDR.

Fixes: 3367c62f522b ("target/ppc: Support for POWER9 native hash")
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
Reviewed-by: Cédric Le Goater <clg@kaod.org>
Message-ID: <20230730111842.39292-1-npiggin@gmail.com>
Signed-off-by: Daniel Henrique Barboza <danielhb413@gmail.com>
---
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
2.41.0



Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B3657704C5
	for <lists+qemu-devel@lfdr.de>; Fri,  4 Aug 2023 17:32:17 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qRwlP-0006Yo-QD; Fri, 04 Aug 2023 11:30:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <danielhb413@gmail.com>)
 id 1qRwl4-0006LF-Q2; Fri, 04 Aug 2023 11:30:30 -0400
Received: from mail-oo1-xc32.google.com ([2607:f8b0:4864:20::c32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <danielhb413@gmail.com>)
 id 1qRwl3-0004SX-2X; Fri, 04 Aug 2023 11:30:30 -0400
Received: by mail-oo1-xc32.google.com with SMTP id
 006d021491bc7-56ccdb2c7bbso1481126eaf.1; 
 Fri, 04 Aug 2023 08:30:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1691163027; x=1691767827;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=UCtpTXO6E/fFLMU1sjLPkFfWe5afgv3Y6x6eh4rRv5o=;
 b=RvuQZz8uE+o/fC8SHuuqIpjOS2NBx+TIf64nKRYsppRHkKqaXrWZVTfO2FJ/d4l99E
 7LsGlU6U5OWyIdiEnYZKQ3LnUzYzGS/TNzilUzAagmdCpgYmDTQlmaBpVVcWqHHvkbSu
 ULRBDrUiFnD49TG3wmbywTV5mdQlaxE+/QoLtKI5mRiUkgJKHBvokQv3CUeHhNaHwpVN
 H6VqwRqdysX0b+TuoIDxJN7fdcSqU2mdNQXldmB5os5TdxV00njSPtNLo5hGuu5NoGHH
 PVDqjbIxDhFkpG/W/fg08NhhTMHbFdTG76yAhPlv/WbrrkBCqUO0DEQhFP7ppw1cLvX4
 CJmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691163027; x=1691767827;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=UCtpTXO6E/fFLMU1sjLPkFfWe5afgv3Y6x6eh4rRv5o=;
 b=RF4E7JLp1cMuGKfSKk2dc7Az3EHzLK6itkrtkcWrZJXaPj1phIrB1zdNWbO+sE5X+Y
 BPklG1pM/o1JGkUMBwe2Cpdc1ZqBm2mIDbvfebdBrzApSWPJyGu6O/DuXgAW8eeBg3nl
 CqnaNDyEJ8n8G4KARKuHKw+52WtB/pSoPix6kkSfvyMnNBdohyWD1swgVp4hnQ8Bc+gy
 iI5seWgehdIDYtw6LehLr88KArcwcesUcVhz8mVqGufROrcwiMy1FIqkAgLlLHjO5kKn
 9/7UowCJR4eYbcRwvlxGaAUCP/+i1H2WAY2RMEeDXf3wWcSU90d2bfWzEoCAKnfYznf3
 HMtQ==
X-Gm-Message-State: AOJu0YyniBNiQgvQ+WJu3+fVyJ/QpIgUc8cSMtLeR8no5hOY3iJ47tqo
 vUQiiCeuXtJBGvHSI+vxc9jV0ZTScxc=
X-Google-Smtp-Source: AGHT+IFEMj8wJBb+k3eIVRxh7+sIRLOX8+7Pea3WVGKmxhRHo0l28nZynjvaGcqyEmLZT9QLE8FiWg==
X-Received: by 2002:a4a:6202:0:b0:56c:a841:610d with SMTP id
 x2-20020a4a6202000000b0056ca841610dmr2372921ooc.9.1691163027349; 
 Fri, 04 Aug 2023 08:30:27 -0700 (PDT)
Received: from grind.. ([177.197.108.190]) by smtp.gmail.com with ESMTPSA id
 q4-20020a4a4b04000000b00560b1febfdfsm1115761ooa.10.2023.08.04.08.30.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 04 Aug 2023 08:30:27 -0700 (PDT)
From: Daniel Henrique Barboza <danielhb413@gmail.com>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, danielhb413@gmail.com, peter.maydell@linaro.org,
 richard.henderson@linaro.org, Nicholas Piggin <npiggin@gmail.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Subject: [PULL 5/7] target/ppc: Implement ASDR register for ISA v3.0 for HPT
Date: Fri,  4 Aug 2023 12:29:53 -0300
Message-ID: <20230804152955.22316-6-danielhb413@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230804152955.22316-1-danielhb413@gmail.com>
References: <20230804152955.22316-1-danielhb413@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::c32;
 envelope-from=danielhb413@gmail.com; helo=mail-oo1-xc32.google.com
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

The ASDR register was introduced in ISA v3.0. It has not been
implemented for HPT. With HPT, ASDR is the format of the slbmte RS
operand (containing VSID), which matches the ppc_slb_t field.

Fixes: 3367c62f522b ("target/ppc: Support for POWER9 native hash")
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
Reviewed-by: Cédric Le Goater <clg@kaod.org>
Message-ID: <20230726182230.433945-2-npiggin@gmail.com>
Signed-off-by: Daniel Henrique Barboza <danielhb413@gmail.com>
---
 target/ppc/mmu-hash64.c | 27 ++++++++++++++++-----------
 1 file changed, 16 insertions(+), 11 deletions(-)

diff --git a/target/ppc/mmu-hash64.c b/target/ppc/mmu-hash64.c
index 900f906990..a0c90df3ce 100644
--- a/target/ppc/mmu-hash64.c
+++ b/target/ppc/mmu-hash64.c
@@ -770,7 +770,8 @@ static bool ppc_hash64_use_vrma(CPUPPCState *env)
     }
 }
 
-static void ppc_hash64_set_isi(CPUState *cs, int mmu_idx, uint64_t error_code)
+static void ppc_hash64_set_isi(CPUState *cs, int mmu_idx, uint64_t slb_vsid,
+                               uint64_t error_code)
 {
     CPUPPCState *env = &POWERPC_CPU(cs)->env;
     bool vpm;
@@ -782,13 +783,15 @@ static void ppc_hash64_set_isi(CPUState *cs, int mmu_idx, uint64_t error_code)
     }
     if (vpm && !mmuidx_hv(mmu_idx)) {
         cs->exception_index = POWERPC_EXCP_HISI;
+        env->spr[SPR_ASDR] = slb_vsid;
     } else {
         cs->exception_index = POWERPC_EXCP_ISI;
     }
     env->error_code = error_code;
 }
 
-static void ppc_hash64_set_dsi(CPUState *cs, int mmu_idx, uint64_t dar, uint64_t dsisr)
+static void ppc_hash64_set_dsi(CPUState *cs, int mmu_idx, uint64_t slb_vsid,
+                               uint64_t dar, uint64_t dsisr)
 {
     CPUPPCState *env = &POWERPC_CPU(cs)->env;
     bool vpm;
@@ -802,6 +805,7 @@ static void ppc_hash64_set_dsi(CPUState *cs, int mmu_idx, uint64_t dar, uint64_t
         cs->exception_index = POWERPC_EXCP_HDSI;
         env->spr[SPR_HDAR] = dar;
         env->spr[SPR_HDSISR] = dsisr;
+        env->spr[SPR_ASDR] = slb_vsid;
     } else {
         cs->exception_index = POWERPC_EXCP_DSI;
         env->spr[SPR_DAR] = dar;
@@ -963,13 +967,13 @@ bool ppc_hash64_xlate(PowerPCCPU *cpu, vaddr eaddr, MMUAccessType access_type,
                 }
                 switch (access_type) {
                 case MMU_INST_FETCH:
-                    ppc_hash64_set_isi(cs, mmu_idx, SRR1_PROTFAULT);
+                    ppc_hash64_set_isi(cs, mmu_idx, 0, SRR1_PROTFAULT);
                     break;
                 case MMU_DATA_LOAD:
-                    ppc_hash64_set_dsi(cs, mmu_idx, eaddr, DSISR_PROTFAULT);
+                    ppc_hash64_set_dsi(cs, mmu_idx, 0, eaddr, DSISR_PROTFAULT);
                     break;
                 case MMU_DATA_STORE:
-                    ppc_hash64_set_dsi(cs, mmu_idx, eaddr,
+                    ppc_hash64_set_dsi(cs, mmu_idx, 0, eaddr,
                                        DSISR_PROTFAULT | DSISR_ISSTORE);
                     break;
                 default:
@@ -1022,7 +1026,7 @@ bool ppc_hash64_xlate(PowerPCCPU *cpu, vaddr eaddr, MMUAccessType access_type,
     /* 3. Check for segment level no-execute violation */
     if (access_type == MMU_INST_FETCH && (slb->vsid & SLB_VSID_N)) {
         if (guest_visible) {
-            ppc_hash64_set_isi(cs, mmu_idx, SRR1_NOEXEC_GUARD);
+            ppc_hash64_set_isi(cs, mmu_idx, slb->vsid, SRR1_NOEXEC_GUARD);
         }
         return false;
     }
@@ -1035,13 +1039,14 @@ bool ppc_hash64_xlate(PowerPCCPU *cpu, vaddr eaddr, MMUAccessType access_type,
         }
         switch (access_type) {
         case MMU_INST_FETCH:
-            ppc_hash64_set_isi(cs, mmu_idx, SRR1_NOPTE);
+            ppc_hash64_set_isi(cs, mmu_idx, slb->vsid, SRR1_NOPTE);
             break;
         case MMU_DATA_LOAD:
-            ppc_hash64_set_dsi(cs, mmu_idx, eaddr, DSISR_NOPTE);
+            ppc_hash64_set_dsi(cs, mmu_idx, slb->vsid, eaddr, DSISR_NOPTE);
             break;
         case MMU_DATA_STORE:
-            ppc_hash64_set_dsi(cs, mmu_idx, eaddr, DSISR_NOPTE | DSISR_ISSTORE);
+            ppc_hash64_set_dsi(cs, mmu_idx, slb->vsid, eaddr,
+                               DSISR_NOPTE | DSISR_ISSTORE);
             break;
         default:
             g_assert_not_reached();
@@ -1075,7 +1080,7 @@ bool ppc_hash64_xlate(PowerPCCPU *cpu, vaddr eaddr, MMUAccessType access_type,
             if (PAGE_EXEC & ~amr_prot) {
                 srr1 |= SRR1_IAMR; /* Access violates virt pg class key prot */
             }
-            ppc_hash64_set_isi(cs, mmu_idx, srr1);
+            ppc_hash64_set_isi(cs, mmu_idx, slb->vsid, srr1);
         } else {
             int dsisr = 0;
             if (need_prot & ~pp_prot) {
@@ -1087,7 +1092,7 @@ bool ppc_hash64_xlate(PowerPCCPU *cpu, vaddr eaddr, MMUAccessType access_type,
             if (need_prot & ~amr_prot) {
                 dsisr |= DSISR_AMR;
             }
-            ppc_hash64_set_dsi(cs, mmu_idx, eaddr, dsisr);
+            ppc_hash64_set_dsi(cs, mmu_idx, slb->vsid, eaddr, dsisr);
         }
         return false;
     }
-- 
2.41.0



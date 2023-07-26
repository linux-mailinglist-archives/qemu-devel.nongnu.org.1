Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CBC66763E89
	for <lists+qemu-devel@lfdr.de>; Wed, 26 Jul 2023 20:31:33 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qOjAT-0003vq-PY; Wed, 26 Jul 2023 14:23:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1qOj9s-0003qs-Q8; Wed, 26 Jul 2023 14:22:48 -0400
Received: from mail-pj1-x1030.google.com ([2607:f8b0:4864:20::1030])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1qOj9r-0008RE-68; Wed, 26 Jul 2023 14:22:48 -0400
Received: by mail-pj1-x1030.google.com with SMTP id
 98e67ed59e1d1-2685bcd046eso89834a91.3; 
 Wed, 26 Jul 2023 11:22:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1690395765; x=1691000565;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Fu3SNX5pWMfAFlu2iRITWI/ZZuTkozaiKRck9Odx43Y=;
 b=qb2TeLzHRUXsFSEAwyANagQBOBm788fpl9ZiDfhGFgVeZYZDZ1i8NRo4PtEgF+EhzE
 yWHT5Tp4+OtdEqUo73L/gGrLliw7AyJlbAnLME2o927lVqFCrpqMJS6kWd5Av/kcQm9l
 9Cg1AHcwMuyN/9qadMZutSgZGO4by1RfBY3Z+52IXb4CjFanU0YHtl32ALYSJomnKNNl
 63XFVnNuGPkxKQw6Cf8LIaE40BzUZ/vFxyZG/bz/5LcUWXEpGnSojqZiV0nJdmjzMN+W
 cojXhRkenET41mXl/kfWYAoTEBngnwPY/KCnWJdqIPTy1KZUNA5qcoXLxYLlaGa926rN
 SuTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1690395765; x=1691000565;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Fu3SNX5pWMfAFlu2iRITWI/ZZuTkozaiKRck9Odx43Y=;
 b=ZeT22yra57VN/O77sH3hzQOCgcRpgCQZMyOwJdcfvPmpjm6S+MeBcW4bWYOBYTCLc/
 x5EHtsp7gvbCV2LpIkGc+QPdn1gXws+eyFeeT9bZY0jlhHRDaw8127kwVs7jqEb1pNmF
 M3CUDN3JOvL+DZjR/2xcvJcK8DJDy7PGV2DAxercNIGASkhOmAOK833BlVyFOCDMHnDG
 YB+NkzzT/mFS32IcBMbapr/qbH1QaAagu8WY73Utz+FgNrJ7H6Ag1HXVwJMwyMsH6dRZ
 kFHk92/bGg+WoV2sizALyMfHi6gGgW9osE4XMqFopKxuRjkGgu+k5G74rg+0Dz1BZ28F
 gEmg==
X-Gm-Message-State: ABy/qLZDwm5VfwdsZwKuIjpWAHaW3Cc7IuRu6p4f0Xr8YxcOdJ843wSE
 oAmxw4jOCx0F/KqhfGaziLhd+z2Fnos=
X-Google-Smtp-Source: APBJJlFKYA3Pdb9lw3igXuBfpChEYpcfFqq7NEzycQOnoFrp3djeFFGZKshn9+mDXdmw2JeXbalY3A==
X-Received: by 2002:a17:90b:2388:b0:25e:d013:c22c with SMTP id
 mr8-20020a17090b238800b0025ed013c22cmr2242675pjb.47.1690395765310; 
 Wed, 26 Jul 2023 11:22:45 -0700 (PDT)
Received: from wheely.local0.net ([118.102.104.45])
 by smtp.gmail.com with ESMTPSA id
 b25-20020a639319000000b0055adced9e13sm360185pge.0.2023.07.26.11.22.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 26 Jul 2023 11:22:45 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: Daniel Henrique Barboza <danielhb413@gmail.com>
Cc: Nicholas Piggin <npiggin@gmail.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 David Gibson <david@gibson.dropbear.id.au>, Greg Kurz <groug@kaod.org>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>, qemu-ppc@nongnu.org,
 qemu-devel@nongnu.org
Subject: [PATCH 1/6] target/ppc: Implement ASDR register for ISA v3.0 for HPT
Date: Thu, 27 Jul 2023 04:22:25 +1000
Message-Id: <20230726182230.433945-2-npiggin@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230726182230.433945-1-npiggin@gmail.com>
References: <20230726182230.433945-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1030;
 envelope-from=npiggin@gmail.com; helo=mail-pj1-x1030.google.com
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

The ASDR register was introduced in ISA v3.0. It has not been
implemented for HPT. With HPT, ASDR is the format of the slbmte RS
operand (containing VSID), which matches the ppc_slb_t field.

Fixes: 3367c62f522b ("target/ppc: Support for POWER9 native hash")
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
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
2.40.1



Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E3A175BD9C
	for <lists+qemu-devel@lfdr.de>; Fri, 21 Jul 2023 07:04:47 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qMiIY-0004S6-8X; Fri, 21 Jul 2023 01:03:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1qMiIQ-0004RR-67; Fri, 21 Jul 2023 01:03:18 -0400
Received: from mail-oa1-x2a.google.com ([2001:4860:4864:20::2a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1qMiIO-0004aJ-BG; Fri, 21 Jul 2023 01:03:17 -0400
Received: by mail-oa1-x2a.google.com with SMTP id
 586e51a60fabf-1b060bce5b0so1184396fac.3; 
 Thu, 20 Jul 2023 22:03:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1689915794; x=1690520594;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=IHU35yizKmO0HVITSaXSK8nTSP3OUIC8wQtIzsoRKiQ=;
 b=FW0Ucfy1fZKMo28y7T4n8HNif6ke8VSleS1qiqMgOcZ5QpnUteNl+xEfwmJv7HlDBT
 nNwoHN2mWj9UHeIjoeDn46Q8p+ECiIB7IecV1uWRpAvMpbJKfJMjUA+ti3i2stR9JPYj
 mjsX55U1VABhaQIxwHtZoTDQaJo2DZK9/AQlRGJfniCDPkn9N2d7kR8qWyVJpbPkM9dH
 P94X8Ur7K55+pAp3N6WJwQW+yekOK6l8VI8gV3bUTAsSXRc3ufojsqPLkZZEmZK1SYPx
 MCfHrqIGXhuZeOvlSM5rhQj7/z8IsE5iwmpaKGIn2lMDOWyzOofKosd3VcCgAqQacOYA
 uoZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689915794; x=1690520594;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=IHU35yizKmO0HVITSaXSK8nTSP3OUIC8wQtIzsoRKiQ=;
 b=FaAg8zeRDrBUoKVojWk7OA33m1UsezaabgTKrnlrRKR5wzJVIMWY/aCXFrg4wa2hZs
 QLPxUVusbkcFZ4r2e0wadwl9H+dpPprxutM0ga/vjF4KnfotEmePCukHwe9yzx/aOgBx
 zQ10Fe4VSGxnvVWIavPtNd2R1obv6adPMU0DVd/0D0hPuPATKoHbvsz1IqHKifyM+793
 /eBi/VkTc24+YiUVpJ5AIYKrrCSgGwlFtFFCSkwKmvpPIZAOLt/GYznEzNsC8Gg0WGiu
 IrJXGof6jrslsKVjBIis6GS1+GA9Zdk5RkuNaw1RI5sfaa/a88jKFEtJWbiUK1A2LiJ4
 2ZfQ==
X-Gm-Message-State: ABy/qLbttKgbahfmu+oYr1SO3nB+/5HFfDQ8LJhCmF2SEAfpimeKkJgk
 LBnt81Rm0xeHJ9+pGCrfns8=
X-Google-Smtp-Source: APBJJlGVhEBsCREJTPj6XkJpjn7b6TBsY8Dtoonp+yBCZEafbqVzvBnzrI7+xX+WM4vDQeEBNTT5iw==
X-Received: by 2002:a05:6870:c154:b0:192:ba3b:a18 with SMTP id
 g20-20020a056870c15400b00192ba3b0a18mr951159oad.51.1689915794086; 
 Thu, 20 Jul 2023 22:03:14 -0700 (PDT)
Received: from wheely.local0.net ([203.220.77.10])
 by smtp.gmail.com with ESMTPSA id
 z13-20020a63330d000000b0056001f43726sm2129444pgz.92.2023.07.20.22.03.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 20 Jul 2023 22:03:13 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: Daniel Henrique Barboza <danielhb413@gmail.com>
Cc: Nicholas Piggin <npiggin@gmail.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Barrat?= <fbarrat@linux.ibm.com>,
 David Gibson <david@gibson.dropbear.id.au>, Greg Kurz <groug@kaod.org>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>, qemu-ppc@nongnu.org,
 qemu-devel@nongnu.org, qemu-stable@nongnu.org
Subject: [PATCH 1/2] target/ppc: Implement ASDR register for ISA v3.0 for HPT
Date: Fri, 21 Jul 2023 15:02:54 +1000
Message-Id: <20230721050255.100090-2-npiggin@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230721050255.100090-1-npiggin@gmail.com>
References: <20230721050255.100090-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2001:4860:4864:20::2a;
 envelope-from=npiggin@gmail.com; helo=mail-oa1-x2a.google.com
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



Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E8EAE79E55F
	for <lists+qemu-devel@lfdr.de>; Wed, 13 Sep 2023 12:55:26 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qgNVl-0007hr-Fg; Wed, 13 Sep 2023 06:54:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kbastian@mail.uni-paderborn.de>)
 id 1qgNVX-0007hE-5k
 for qemu-devel@nongnu.org; Wed, 13 Sep 2023 06:54:07 -0400
Received: from doohan.uni-paderborn.de ([2001:638:502:c003::16])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kbastian@mail.uni-paderborn.de>)
 id 1qgNVK-0006SJ-RR
 for qemu-devel@nongnu.org; Wed, 13 Sep 2023 06:54:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=mail.uni-paderborn.de; s=20170601; h=Content-Transfer-Encoding:MIME-Version
 :References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
 Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=C1+6c7LzDjPEeppHOnmPuiVKip/6r8FcdGM1ap2zhik=; b=YxJk0qbPbnjTXsxIk7qdu44dBK
 E+nkJ4WD/3eckSo6rdHi9C2HsCT+mMDQZN6SxdZbadNUi0lM58mIfVzEV4mO52+V21uAaId5xNk8+
 +AMFXcjWck9QhSP8VJRwoFoWLoAmYzJNIMVbJOX1xPOZqo5stsrs+stH6BQ5R4e1b2yM=;
X-Envelope-From: <kbastian@mail.uni-paderborn.de>
From: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
To: qemu-devel@nongnu.org
Cc: kbastian@mail.uni-paderborn.de
Subject: [PATCH 09/10] target/tricore: Remove CSFRs from cpu.h
Date: Wed, 13 Sep 2023 12:53:25 +0200
Message-ID: <20230913105326.40832-10-kbastian@mail.uni-paderborn.de>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230913105326.40832-1-kbastian@mail.uni-paderborn.de>
References: <20230913105326.40832-1-kbastian@mail.uni-paderborn.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-IMT-spamd-action: no action
X-PMX-Version: 6.4.9.2830568, Antispam-Engine: 2.7.2.2107409,
 Antispam-Data: 2023.9.13.104216, AntiVirus-Engine: 6.0.2,
 AntiVirus-Data: 2023.9.13.602000
X-Sophos-SenderHistory: ip=84.184.54.91, fs=19, da=182211496, mc=18, sc=0,
 hc=18, sp=0, fso=19, re=0, sd=0, hd=0
X-IMT-Source: Intern
X-IMT-Spam-Score: 0.0 ()
X-IMT-Authenticated-Sender: uid=kbastian,ou=People,o=upb,c=de
Received-SPF: pass client-ip=2001:638:502:c003::16;
 envelope-from=kbastian@mail.uni-paderborn.de; helo=doohan.uni-paderborn.de
X-Spam_score_int: -42
X-Spam_score: -4.3
X-Spam_bar: ----
X-Spam_report: (-4.3 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, RCVD_IN_DNSWL_MED=-2.3,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

these are already defined in 'csfr.h.inc'. We don't need to duplicate
these registers.

Signed-off-by: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
---
 target/tricore/cpu.h | 143 +++----------------------------------------
 1 file changed, 9 insertions(+), 134 deletions(-)

diff --git a/target/tricore/cpu.h b/target/tricore/cpu.h
index 3708405be8..1cace96b01 100644
--- a/target/tricore/cpu.h
+++ b/target/tricore/cpu.h
@@ -30,150 +30,25 @@ typedef struct CPUArchState {
     /* GPR Register */
     uint32_t gpr_a[16];
     uint32_t gpr_d[16];
-    /* CSFR Register */
-    uint32_t PCXI;
 /* Frequently accessed PSW_USB bits are stored separately for efficiency.
        This contains all the other bits.  Use psw_{read,write} to access
        the whole PSW.  */
     uint32_t PSW;
-
-    /* PSW flag cache for faster execution
-    */
+    /* PSW flag cache for faster execution */
     uint32_t PSW_USB_C;
     uint32_t PSW_USB_V;   /* Only if bit 31 set, then flag is set  */
     uint32_t PSW_USB_SV;  /* Only if bit 31 set, then flag is set  */
     uint32_t PSW_USB_AV;  /* Only if bit 31 set, then flag is set. */
     uint32_t PSW_USB_SAV; /* Only if bit 31 set, then flag is set. */
 
-    uint32_t PC;
-    uint32_t SYSCON;
-    uint32_t CPU_ID;
-    uint32_t CORE_ID;
-    uint32_t BIV;
-    uint32_t BTV;
-    uint32_t ISP;
-    uint32_t ICR;
-    uint32_t FCX;
-    uint32_t LCX;
-    uint32_t COMPAT;
-
-    /* Mem Protection Register */
-    uint32_t DPR0_0L;
-    uint32_t DPR0_0U;
-    uint32_t DPR0_1L;
-    uint32_t DPR0_1U;
-    uint32_t DPR0_2L;
-    uint32_t DPR0_2U;
-    uint32_t DPR0_3L;
-    uint32_t DPR0_3U;
-
-    uint32_t DPR1_0L;
-    uint32_t DPR1_0U;
-    uint32_t DPR1_1L;
-    uint32_t DPR1_1U;
-    uint32_t DPR1_2L;
-    uint32_t DPR1_2U;
-    uint32_t DPR1_3L;
-    uint32_t DPR1_3U;
-
-    uint32_t DPR2_0L;
-    uint32_t DPR2_0U;
-    uint32_t DPR2_1L;
-    uint32_t DPR2_1U;
-    uint32_t DPR2_2L;
-    uint32_t DPR2_2U;
-    uint32_t DPR2_3L;
-    uint32_t DPR2_3U;
-
-    uint32_t DPR3_0L;
-    uint32_t DPR3_0U;
-    uint32_t DPR3_1L;
-    uint32_t DPR3_1U;
-    uint32_t DPR3_2L;
-    uint32_t DPR3_2U;
-    uint32_t DPR3_3L;
-    uint32_t DPR3_3U;
-
-    uint32_t CPR0_0L;
-    uint32_t CPR0_0U;
-    uint32_t CPR0_1L;
-    uint32_t CPR0_1U;
-    uint32_t CPR0_2L;
-    uint32_t CPR0_2U;
-    uint32_t CPR0_3L;
-    uint32_t CPR0_3U;
-
-    uint32_t CPR1_0L;
-    uint32_t CPR1_0U;
-    uint32_t CPR1_1L;
-    uint32_t CPR1_1U;
-    uint32_t CPR1_2L;
-    uint32_t CPR1_2U;
-    uint32_t CPR1_3L;
-    uint32_t CPR1_3U;
-
-    uint32_t CPR2_0L;
-    uint32_t CPR2_0U;
-    uint32_t CPR2_1L;
-    uint32_t CPR2_1U;
-    uint32_t CPR2_2L;
-    uint32_t CPR2_2U;
-    uint32_t CPR2_3L;
-    uint32_t CPR2_3U;
-
-    uint32_t CPR3_0L;
-    uint32_t CPR3_0U;
-    uint32_t CPR3_1L;
-    uint32_t CPR3_1U;
-    uint32_t CPR3_2L;
-    uint32_t CPR3_2U;
-    uint32_t CPR3_3L;
-    uint32_t CPR3_3U;
-
-    uint32_t DPM0;
-    uint32_t DPM1;
-    uint32_t DPM2;
-    uint32_t DPM3;
-
-    uint32_t CPM0;
-    uint32_t CPM1;
-    uint32_t CPM2;
-    uint32_t CPM3;
-
-    /* Memory Management Registers */
-    uint32_t MMU_CON;
-    uint32_t MMU_ASI;
-    uint32_t MMU_TVA;
-    uint32_t MMU_TPA;
-    uint32_t MMU_TPX;
-    uint32_t MMU_TFA;
-    /* {1.3.1 only */
-    uint32_t BMACON;
-    uint32_t SMACON;
-    uint32_t DIEAR;
-    uint32_t DIETR;
-    uint32_t CCDIER;
-    uint32_t MIECON;
-    uint32_t PIEAR;
-    uint32_t PIETR;
-    uint32_t CCPIER;
-    /*} */
-    /* Debug Registers */
-    uint32_t DBGSR;
-    uint32_t EXEVT;
-    uint32_t CREVT;
-    uint32_t SWEVT;
-    uint32_t TR0EVT;
-    uint32_t TR1EVT;
-    uint32_t DMS;
-    uint32_t DCX;
-    uint32_t DBGTCR;
-    uint32_t CCTRL;
-    uint32_t CCNT;
-    uint32_t ICNT;
-    uint32_t M1CNT;
-    uint32_t M2CNT;
-    uint32_t M3CNT;
+#define R(ADDR, NAME, FEATURE) uint32_t NAME;
+#define A(ADDR, NAME, FEATURE) uint32_t NAME;
+#define E(ADDR, NAME, FEATURE) uint32_t NAME;
+#include "csfr.h.inc"
+#undef R
+#undef A
+#undef E
+
     /* Floating Point Registers */
     float_status fp_status;
 
-- 
2.42.0



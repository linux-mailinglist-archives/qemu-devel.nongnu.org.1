Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E05874659B
	for <lists+qemu-devel@lfdr.de>; Tue,  4 Jul 2023 00:04:59 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qGRdK-0003YJ-1M; Mon, 03 Jul 2023 18:02:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1qGRdH-0003Vn-9X; Mon, 03 Jul 2023 18:02:55 -0400
Received: from zero.eik.bme.hu ([2001:738:2001:2001::2001])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1qGRdF-00049q-LQ; Mon, 03 Jul 2023 18:02:55 -0400
Received: from zero.eik.bme.hu (blah.eik.bme.hu [152.66.115.182])
 by localhost (Postfix) with SMTP id CDEDA748A59;
 Tue,  4 Jul 2023 00:02:36 +0200 (CEST)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id AEA92748A61; Tue,  4 Jul 2023 00:02:36 +0200 (CEST)
Message-Id: <b5f39dceb537dedabefdf65acc869bf8ae4d19ee.1688421085.git.balaton@eik.bme.hu>
In-Reply-To: <cover.1688421085.git.balaton@eik.bme.hu>
References: <cover.1688421085.git.balaton@eik.bme.hu>
From: BALATON Zoltan <balaton@eik.bme.hu>
Subject: [PATCH 04/13] ppc440: Rename local variable in dcr_read_pcie()
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
To: qemu-devel@nongnu.org,
    qemu-ppc@nongnu.org
Cc: Daniel Henrique Barboza <danielhb413@gmail.com>
Date: Tue,  4 Jul 2023 00:02:36 +0200 (CEST)
X-Spam-Probability: 8%
Received-SPF: pass client-ip=2001:738:2001:2001::2001;
 envelope-from=balaton@eik.bme.hu; helo=zero.eik.bme.hu
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Rename local variable storing state struct in dcr_read_pcie() for
brevity and consistency with other functions.

Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
---
 hw/ppc/ppc440_uc.c | 50 +++++++++++++++++++++++-----------------------
 1 file changed, 25 insertions(+), 25 deletions(-)

diff --git a/hw/ppc/ppc440_uc.c b/hw/ppc/ppc440_uc.c
index db83a0dec8..38ee27f437 100644
--- a/hw/ppc/ppc440_uc.c
+++ b/hw/ppc/ppc440_uc.c
@@ -828,78 +828,78 @@ enum {
 
 static uint32_t dcr_read_pcie(void *opaque, int dcrn)
 {
-    PPC460EXPCIEState *state = opaque;
+    PPC460EXPCIEState *s = opaque;
     uint32_t ret = 0;
 
-    switch (dcrn - state->dcrn_base) {
+    switch (dcrn - s->dcrn_base) {
     case PEGPL_CFGBAH:
-        ret = state->cfg_base >> 32;
+        ret = s->cfg_base >> 32;
         break;
     case PEGPL_CFGBAL:
-        ret = state->cfg_base;
+        ret = s->cfg_base;
         break;
     case PEGPL_CFGMSK:
-        ret = state->cfg_mask;
+        ret = s->cfg_mask;
         break;
     case PEGPL_MSGBAH:
-        ret = state->msg_base >> 32;
+        ret = s->msg_base >> 32;
         break;
     case PEGPL_MSGBAL:
-        ret = state->msg_base;
+        ret = s->msg_base;
         break;
     case PEGPL_MSGMSK:
-        ret = state->msg_mask;
+        ret = s->msg_mask;
         break;
     case PEGPL_OMR1BAH:
-        ret = state->omr1_base >> 32;
+        ret = s->omr1_base >> 32;
         break;
     case PEGPL_OMR1BAL:
-        ret = state->omr1_base;
+        ret = s->omr1_base;
         break;
     case PEGPL_OMR1MSKH:
-        ret = state->omr1_mask >> 32;
+        ret = s->omr1_mask >> 32;
         break;
     case PEGPL_OMR1MSKL:
-        ret = state->omr1_mask;
+        ret = s->omr1_mask;
         break;
     case PEGPL_OMR2BAH:
-        ret = state->omr2_base >> 32;
+        ret = s->omr2_base >> 32;
         break;
     case PEGPL_OMR2BAL:
-        ret = state->omr2_base;
+        ret = s->omr2_base;
         break;
     case PEGPL_OMR2MSKH:
-        ret = state->omr2_mask >> 32;
+        ret = s->omr2_mask >> 32;
         break;
     case PEGPL_OMR2MSKL:
-        ret = state->omr3_mask;
+        ret = s->omr3_mask;
         break;
     case PEGPL_OMR3BAH:
-        ret = state->omr3_base >> 32;
+        ret = s->omr3_base >> 32;
         break;
     case PEGPL_OMR3BAL:
-        ret = state->omr3_base;
+        ret = s->omr3_base;
         break;
     case PEGPL_OMR3MSKH:
-        ret = state->omr3_mask >> 32;
+        ret = s->omr3_mask >> 32;
         break;
     case PEGPL_OMR3MSKL:
-        ret = state->omr3_mask;
+        ret = s->omr3_mask;
         break;
     case PEGPL_REGBAH:
-        ret = state->reg_base >> 32;
+        ret = s->reg_base >> 32;
         break;
     case PEGPL_REGBAL:
-        ret = state->reg_base;
+        ret = s->reg_base;
         break;
     case PEGPL_REGMSK:
-        ret = state->reg_mask;
+        ret = s->reg_mask;
         break;
     case PEGPL_SPECIAL:
-        ret = state->special;
+        ret = s->special;
         break;
     case PEGPL_CFG:
-        ret = state->cfg;
+        ret = s->cfg;
         break;
     }
 
-- 
2.30.9



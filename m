Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 900887E1BC7
	for <lists+qemu-devel@lfdr.de>; Mon,  6 Nov 2023 09:17:34 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qzumJ-0000Xt-4X; Mon, 06 Nov 2023 03:16:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1qzulv-0000LW-DI
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 03:15:50 -0500
Received: from mout.kundenserver.de ([212.227.17.10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1qzult-0007xn-Gs
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 03:15:46 -0500
Received: from quad ([82.142.8.70]) by mrelayeu.kundenserver.de (mreue108
 [212.227.15.183]) with ESMTPSA (Nemesis) id 1MiakT-1rfK8G0e3z-00ffh8; Mon, 06
 Nov 2023 09:15:43 +0100
From: Laurent Vivier <laurent@vivier.eu>
To: qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Subject: [PULL 2/4] macfb: rename DAFB_RESET to DAFB_LUT_INDEX
Date: Mon,  6 Nov 2023 09:15:39 +0100
Message-ID: <20231106081541.53688-3-laurent@vivier.eu>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231106081541.53688-1-laurent@vivier.eu>
References: <20231106081541.53688-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:PvE5QVomysngCKTOBnZbfOErQIWga0TcaxlTh14Xe/fS2Bb8/Fg
 1PjDCmgf0r7Za2FevufypSJ6pthvNkyIQhN9+CRrgqBxAb8qf2gJCxoEBjpJz7mCekCS1R1
 NjgrtOMpT/Hqr/CkiFR22vjIxTKRApe6MoCBXDSKGYCvod7i1qHAeYaag7RxRgBQ70nkLtW
 Lhszlx4JgkfQG3hLMl40g==
UI-OutboundReport: notjunk:1;M01:P0:pxqB1KBBmbM=;VIbKYpUNca8rfujTBm8iz2SN3Nu
 yV8ebm3XqAI1/RLvKouvUzMdY6Hg7e0q8LDShRzIxbNBIfcuPwIcsUdN4yWXUkDt3wfYvujMT
 gxuS3q5zsm9pObWsqvQVC7x1060nNGui1N+09/pKq+BKNmnl0EI8rmlpYUnIv1aRPOhmgCcnr
 RVe9BwpynGfqAIeB2ungNAFp/lj6ehycOWP7WM3KVZjGbxS5kKfY88iHBBY7sP7oMFZfr73m7
 ue4wp9v05EuMaPuoLlRL1K03+fLJ2EeAYQQ+JthdeQMIAEltfIkxvDrofIbPnX+ZgLD+8zKOh
 PS9LEuIcKA/1JUT7bKeJoeiyLr+6zjsYPatYSouXoS5LmQxgG4Wla95KFTah5nXbfPnAkeMYZ
 d2fh2Z/h6S4ynZW/lJKRibgU147riiis7pE4cjcZfDV9yYQ56mTDHR/eWZcX5nM9aqdaqPPTB
 rTeALX17sJWia3EacbPDuppST3WcV9asqmwhw6YY69QcKch+gIkw2J7PM4I/K4aP9CX5mf5qH
 I+dZON2dfK2lrMLKTFh1VkbMNTtXVv/SmN14+y2xthbwZMEeTBr4RllfVYWOBo7TgZqqUIRGf
 fols0V7EQCl6mPLrqANWH55aXxsFx8Xs7Pvzk4vLggzoSdHp4KgWoNRQZz5nkkbdeRvuLG5+E
 65ej7YunhStwweCPdRYfGweaBnADVcHM3mPOY5P378H0ezeuCSZnjpGxX1FsPCkOZrfRczkh0
 wX/oAO+2FnKvPSl1DbcSA3T7zwOo6KpBFemCSLpDV0KoXQi/JWYSVWSd/EdsvmESkNF547Zaj
 tqVuXZys9ftTw7279rXQ3qhb2hX3+efWA7NB6b+M0Zdy3pgVx/SwTmSe/OFllHTjtTgXCv24Z
 0rQfXL4GTLCFL4w==
Received-SPF: none client-ip=212.227.17.10; envelope-from=laurent@vivier.eu;
 helo=mout.kundenserver.de
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001, SPF_NONE=0.001,
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

From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>

When A/UX uses the MacOS Device Manager Status (GetEntries) call to read the
contents of the CLUT, it is easy to see that the requested index is written to
the DAFB_RESET register. Update the palette_current index with the requested
value, and rename it to DAFB_LUT_INDEX to reflect its true purpose.

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Reviewed-by: Laurent Vivier <laurent@vivier.eu>
Message-ID: <20231026085650.917663-3-mark.cave-ayland@ilande.co.uk>
Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 hw/display/macfb.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/hw/display/macfb.c b/hw/display/macfb.c
index 28db2e9f246a..eb4ce6b824c4 100644
--- a/hw/display/macfb.c
+++ b/hw/display/macfb.c
@@ -36,7 +36,7 @@
 #define DAFB_INTR_MASK      0x104
 #define DAFB_INTR_STAT      0x108
 #define DAFB_INTR_CLEAR     0x10c
-#define DAFB_RESET          0x200
+#define DAFB_LUT_INDEX      0x200
 #define DAFB_LUT            0x213
 
 #define DAFB_INTR_VBL   0x4
@@ -583,8 +583,8 @@ static void macfb_ctrl_write(void *opaque,
         s->regs[DAFB_INTR_STAT >> 2] &= ~DAFB_INTR_VBL;
         macfb_update_irq(s);
         break;
-    case DAFB_RESET:
-        s->palette_current = 0;
+    case DAFB_LUT_INDEX:
+        s->palette_current = (val & 0xff) * 3;
         break;
     case DAFB_LUT:
         s->color_palette[s->palette_current] = val;
-- 
2.41.0



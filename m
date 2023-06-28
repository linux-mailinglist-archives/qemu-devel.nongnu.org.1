Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A655074104F
	for <lists+qemu-devel@lfdr.de>; Wed, 28 Jun 2023 13:47:10 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qETdI-0003X5-8O; Wed, 28 Jun 2023 07:46:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1qETcO-0002gE-6H
 for qemu-devel@nongnu.org; Wed, 28 Jun 2023 07:46:04 -0400
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1qETcK-0005AX-7J
 for qemu-devel@nongnu.org; Wed, 28 Jun 2023 07:45:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ilande.co.uk; s=20220518; h=Subject:Content-Transfer-Encoding:Content-Type:
 MIME-Version:References:In-Reply-To:Message-Id:Date:To:From:Sender:Reply-To:
 Cc:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=/bMeEkjfg3tpxVE70QjaEvS5dMR3vXSEfAF08boX70Q=; b=aAdkK7e4yMAOUVvTyK/0E8o0XC
 YFWR9RIOrZYVpn7ZuzB5VxVYFAAjlFDRLXQxwXX+lcbIe/cR3pX+pF5vj0w5SKdxXB7LEeeKralxC
 B1CG/dbVYb/oIPOyFAsYEj6Cw0k0+6AizNI6XFWK1sZatwvQpluHHRXCXUfKMg22ta3iJ1Ut2EX3X
 dPk178cFtoqAzVJS8U2ixWlsSWSaMZmAE+cPN9kcgAUcd9SIqT+Gr25PTtAJRk2nbJnnON0aeqctL
 L7A1j2QchLci1u/YAnv5U5KphGQR0X9MiiTn0yfQMuHa0Tg2dEA1I6jw2gEGxTUy6YL+kYA+fbN2i
 KSpw+tQEdL5X3666xAuJ/vT1nEh6KfF3je971JM+Gl2hPqWoRcWQbRmxqQKyefR+/jDYQn8ocynkc
 uvZBNlWBSeEqPdj9/D8C6YRC4gHoacNQ4fwVHaY439Np0rtwi8zEFYUdLr1soiqaBeUhhIV2UNjws
 ZHNjBX2qnw44lb3ff9cZ49cggzbZFoylkSEPDnVUpGkRngk+1yTEWBnsbqBXuB6p/K5ttEmfLi0Or
 WPyd/N3KLLac73gkgbgEjHhVTI7Im2uTKN7WhdWgrEKiXiyK0M1plZsfe/vN2SOUo7v9VCZkCYMpj
 waYFX/1o9/R/mtGK3ARZr1tBrDZzcs1WJKpdOkaRI=;
Received: from host86-130-37-216.range86-130.btcentralplus.com
 ([86.130.37.216] helo=kentang.home)
 by mail.ilande.co.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.92) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1qETbx-00007c-J6; Wed, 28 Jun 2023 12:45:29 +0100
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
To: richard.henderson@linaro.org,
	qemu-devel@nongnu.org
Date: Wed, 28 Jun 2023 12:45:00 +0100
Message-Id: <20230628114504.546265-7-mark.cave-ayland@ilande.co.uk>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230628114504.546265-1-mark.cave-ayland@ilande.co.uk>
References: <20230628114504.546265-1-mark.cave-ayland@ilande.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 86.130.37.216
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: [PULL 06/10] target/sparc: Use DYNAMIC_PC_LOOKUP for conditional
 branches
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on mail.ilande.co.uk)
Received-SPF: pass client-ip=2001:41c9:1:41f::167;
 envelope-from=mark.cave-ayland@ilande.co.uk; helo=mail.ilande.co.uk
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

From: Richard Henderson <richard.henderson@linaro.org>

When resolving JUMP_PC, we know this is for a plain branch
with no other side effects.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20230628071202.230991-6-richard.henderson@linaro.org>
Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
---
 target/sparc/translate.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/target/sparc/translate.c b/target/sparc/translate.c
index 75aa1a138e..d7b569d910 100644
--- a/target/sparc/translate.c
+++ b/target/sparc/translate.c
@@ -941,7 +941,7 @@ static void flush_cond(DisasContext *dc)
 {
     if (dc->npc == JUMP_PC) {
         gen_generic_branch(dc);
-        dc->npc = DYNAMIC_PC;
+        dc->npc = DYNAMIC_PC_LOOKUP;
     }
 }
 
@@ -951,7 +951,7 @@ static void save_npc(DisasContext *dc)
         switch (dc->npc) {
         case JUMP_PC:
             gen_generic_branch(dc);
-            dc->npc = DYNAMIC_PC;
+            dc->npc = DYNAMIC_PC_LOOKUP;
             break;
         case DYNAMIC_PC:
         case DYNAMIC_PC_LOOKUP:
@@ -997,7 +997,7 @@ static void gen_mov_pc_npc(DisasContext *dc)
         case JUMP_PC:
             gen_generic_branch(dc);
             tcg_gen_mov_tl(cpu_pc, cpu_npc);
-            dc->pc = DYNAMIC_PC;
+            dc->pc = DYNAMIC_PC_LOOKUP;
             break;
         case DYNAMIC_PC:
         case DYNAMIC_PC_LOOKUP:
-- 
2.30.2



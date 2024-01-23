Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A7A4838980
	for <lists+qemu-devel@lfdr.de>; Tue, 23 Jan 2024 09:50:23 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rSCSZ-0001LI-39; Tue, 23 Jan 2024 03:48:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1rSCSW-0001L1-JQ; Tue, 23 Jan 2024 03:48:40 -0500
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1rSCSU-0004to-Tv; Tue, 23 Jan 2024 03:48:40 -0500
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 90C8446670;
 Tue, 23 Jan 2024 11:49:11 +0300 (MSK)
Received: from tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with SMTP id 54E0D699EE;
 Tue, 23 Jan 2024 11:48:31 +0300 (MSK)
Received: (nullmailer pid 3828108 invoked by uid 1000);
 Tue, 23 Jan 2024 08:48:31 -0000
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Richard Henderson <richard.henderson@linaro.org>,
 Michael Tokarev <mjt@tls.msk.ru>, Paolo Bonzini <pbonzini@redhat.com>
Subject: [Stable-7.2.9 11/20] target/i386: Do not re-compute new pc with
 CF_PCREL
Date: Tue, 23 Jan 2024 11:48:21 +0300
Message-Id: <20240123084831.3828060-3-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <qemu-stable-7.2.9-20240123114733@cover.tls.msk.ru>
References: <qemu-stable-7.2.9-20240123114733@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=86.62.121.231; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -68
X-Spam_score: -6.9
X-Spam_bar: ------
X-Spam_report: (-6.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_HI=-5,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

From: Richard Henderson <richard.henderson@linaro.org>

With PCREL, we have a page-relative view of EIP, and an
approximation of PC = EIP+CSBASE that is good enough to
detect page crossings.  If we try to recompute PC after
masking EIP, we will mess up that approximation and write
a corrupt value to EIP.

We already handled masking properly for PCREL, so the
fix in b5e0d5d2 was only needed for the !PCREL path.

Cc: qemu-stable@nongnu.org
Fixes: b5e0d5d22fbf ("target/i386: Fix 32-bit wrapping of pc/eip computation")
Reported-by: Michael Tokarev <mjt@tls.msk.ru>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <20240101230617.129349-1-richard.henderson@linaro.org>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
(cherry picked from commit a58506b748b8988a95f4fa1a2420ac5c17038b30)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/target/i386/tcg/translate.c b/target/i386/tcg/translate.c
index 15b030d84b..fa2e1dc3b3 100644
--- a/target/i386/tcg/translate.c
+++ b/target/i386/tcg/translate.c
@@ -2883,10 +2883,6 @@ static void gen_jmp_rel(DisasContext *s, MemOp ot, int diff, int tb_num)
         }
     }
     new_eip &= mask;
-    new_pc = new_eip + s->cs_base;
-    if (!CODE64(s)) {
-        new_pc = (uint32_t)new_pc;
-    }
 
     gen_update_cc_op(s);
     set_cc_op(s, CC_OP_DYNAMIC);
@@ -2902,6 +2898,8 @@ static void gen_jmp_rel(DisasContext *s, MemOp ot, int diff, int tb_num)
             tcg_gen_andi_tl(cpu_eip, cpu_eip, mask);
             use_goto_tb = false;
         }
+    } else if (!CODE64(s)) {
+        new_pc = (uint32_t)(new_eip + s->cs_base);
     }
 
     if (use_goto_tb && translator_use_goto_tb(&s->base, new_pc)) {
-- 
2.39.2



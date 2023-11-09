Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CE717E6B64
	for <lists+qemu-devel@lfdr.de>; Thu,  9 Nov 2023 14:46:17 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r15LS-0002nH-8E; Thu, 09 Nov 2023 08:45:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1r15LA-0002au-Us; Thu, 09 Nov 2023 08:45:02 -0500
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1r15L7-0001MR-8I; Thu, 09 Nov 2023 08:44:59 -0500
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 6E34031B0A;
 Thu,  9 Nov 2023 16:43:12 +0300 (MSK)
Received: from tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with SMTP id 7DC0C344B1;
 Thu,  9 Nov 2023 16:43:04 +0300 (MSK)
Received: (nullmailer pid 1461818 invoked by uid 1000);
 Thu, 09 Nov 2023 13:43:02 -0000
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-8.1.3 19/55] target/arm: Fix syndrome for FGT traps on ERET
Date: Thu,  9 Nov 2023 16:42:23 +0300
Message-Id: <20231109134300.1461632-19-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <qemu-stable-8.1.3-20231109164030@cover.tls.msk.ru>
References: <qemu-stable-8.1.3-20231109164030@cover.tls.msk.ru>
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

From: Peter Maydell <peter.maydell@linaro.org>

In commit 442c9d682c94fc2 when we converted the ERET, ERETAA, ERETAB
instructions to decodetree, the conversion accidentally lost the
correct setting of the syndrome register when taking a trap because
of the FEAT_FGT HFGITR_EL1.ERET bit.  Instead of reporting a correct
full syndrome value with the EC and IL bits, we only reported the low
two bits of the syndrome, because the call to syn_erettrap() got
dropped.

Fix the syndrome values for these traps by reinstating the
syn_erettrap() calls.

Fixes: 442c9d682c94fc2 ("target/arm: Convert ERET, ERETAA, ERETAB to decodetree")
Cc: qemu-stable@nongnu.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20231024172438.2990945-1-peter.maydell@linaro.org
(cherry picked from commit 307521d6e29e559c89afa9dbd337ae75fe3c436d)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/target/arm/tcg/translate-a64.c b/target/arm/tcg/translate-a64.c
index 5fa1257d32..58787ee8a7 100644
--- a/target/arm/tcg/translate-a64.c
+++ b/target/arm/tcg/translate-a64.c
@@ -1627,7 +1627,7 @@ static bool trans_ERET(DisasContext *s, arg_ERET *a)
         return false;
     }
     if (s->fgt_eret) {
-        gen_exception_insn_el(s, 0, EXCP_UDEF, 0, 2);
+        gen_exception_insn_el(s, 0, EXCP_UDEF, syn_erettrap(0), 2);
         return true;
     }
     dst = tcg_temp_new_i64();
@@ -1654,7 +1654,7 @@ static bool trans_ERETA(DisasContext *s, arg_reta *a)
     }
     /* The FGT trap takes precedence over an auth trap. */
     if (s->fgt_eret) {
-        gen_exception_insn_el(s, 0, EXCP_UDEF, a->m ? 3 : 2, 2);
+        gen_exception_insn_el(s, 0, EXCP_UDEF, syn_erettrap(a->m ? 3 : 2), 2);
         return true;
     }
     dst = tcg_temp_new_i64();
-- 
2.39.2



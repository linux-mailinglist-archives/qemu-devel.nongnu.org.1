Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F8A47F0843
	for <lists+qemu-devel@lfdr.de>; Sun, 19 Nov 2023 19:21:52 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r4mPU-0005Lp-Dg; Sun, 19 Nov 2023 13:20:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1r4mPN-0005GP-NT; Sun, 19 Nov 2023 13:20:37 -0500
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1r4mPL-00087n-GB; Sun, 19 Nov 2023 13:20:37 -0500
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 278D634906;
 Sun, 19 Nov 2023 21:20:11 +0300 (MSK)
Received: from tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with SMTP id 7E2AB36245;
 Sun, 19 Nov 2023 21:20:07 +0300 (MSK)
Received: (nullmailer pid 3314153 invoked by uid 1000);
 Sun, 19 Nov 2023 18:20:06 -0000
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 "Edgar E . Iglesias" <edgar@zeroasic.com>, Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-8.1.3 58/59] target/arm: HVC at EL3 should go to EL3, not EL2
Date: Sun, 19 Nov 2023 21:19:54 +0300
Message-Id: <20231119182006.3314111-5-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <qemu-stable-8.1.3-20231119211540@cover.tls.msk.ru>
References: <qemu-stable-8.1.3-20231119211540@cover.tls.msk.ru>
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

AArch64 permits code at EL3 to use the HVC instruction; however the
exception we take should go to EL3, not down to EL2 (see the pseudocode
AArch64.CallHypervisor()). Fix the target EL.

Cc: qemu-stable@nongnu.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Edgar E. Iglesias <edgar@zeroasic.com>
Message-id: 20231109151917.1925107-1-peter.maydell@linaro.org
(cherry picked from commit fc58891d0422607d172a3d6b3158798f2556aef1)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/target/arm/tcg/translate-a64.c b/target/arm/tcg/translate-a64.c
index 58787ee8a7..7267f172d7 100644
--- a/target/arm/tcg/translate-a64.c
+++ b/target/arm/tcg/translate-a64.c
@@ -2355,6 +2355,8 @@ static bool trans_SVC(DisasContext *s, arg_i *a)
 
 static bool trans_HVC(DisasContext *s, arg_i *a)
 {
+    int target_el = s->current_el == 3 ? 3 : 2;
+
     if (s->current_el == 0) {
         unallocated_encoding(s);
         return true;
@@ -2367,7 +2369,7 @@ static bool trans_HVC(DisasContext *s, arg_i *a)
     gen_helper_pre_hvc(cpu_env);
     /* Architecture requires ss advance before we do the actual work */
     gen_ss_advance(s);
-    gen_exception_insn_el(s, 4, EXCP_HVC, syn_aa64_hvc(a->imm), 2);
+    gen_exception_insn_el(s, 4, EXCP_HVC, syn_aa64_hvc(a->imm), target_el);
     return true;
 }
 
-- 
2.39.2



Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C267BA2F06
	for <lists+qemu-devel@lfdr.de>; Fri, 26 Sep 2025 10:25:28 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v23g3-0001fI-PT; Fri, 26 Sep 2025 04:19:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1v23fT-0001d2-64; Fri, 26 Sep 2025 04:19:03 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1v23fK-0002CQ-9N; Fri, 26 Sep 2025 04:19:02 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 5A135157D80;
 Fri, 26 Sep 2025 11:10:35 +0300 (MSK)
Received: from think4mjt.origo (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by tsrv.corpit.ru (Postfix) with ESMTP id 6D2BD290C64;
 Fri, 26 Sep 2025 11:10:36 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, WANG Rui <wangrui@loongson.cn>,
 Richard Henderson <richard.henderson@linaro.org>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-10.1.1 56/60] tcg/optimize: Fix folding of vector bitsel
Date: Fri, 26 Sep 2025 11:10:24 +0300
Message-ID: <20250926081031.2214971-56-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-10.1.1-20250926101857@cover.tls.msk.ru>
References: <qemu-stable-10.1.1-20250926101857@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=212.248.84.144; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

From: WANG Rui <wangrui@loongson.cn>

It looks like a typo. When the false value (C) is the constant -1, the
correct fold should be: R = B | ~A

Reproducer (LoongArch64 assembly):

     .text
     .globl  _start
 _start:
     vldi    $vr1, 3073
     vldi    $vr2, 1023
     vbitsel.v       $vr0, $vr2, $vr1, $vr2
     vpickve2gr.d    $a1, $vr0, 1
     xori    $a0, $a1, 1
     li.w    $a7, 93
     syscall 0

Fixes: e58b977238e3 ("tcg/optimize: Optimize bitsel_vec")
Link: https://github.com/llvm/llvm-project/issues/159610
Signed-off-by: WANG Rui <wangrui@loongson.cn>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <20250919124901.2756538-1-wangrui@loongson.cn>
(cherry picked from commit a50347a4145faf6d409afd4b9b682c8b3e60854a)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/tcg/optimize.c b/tcg/optimize.c
index 3638ab9fea..f69702b26e 100644
--- a/tcg/optimize.c
+++ b/tcg/optimize.c
@@ -1568,9 +1568,10 @@ static bool fold_bitsel_vec(OptContext *ctx, TCGOp *op)
             return fold_and(ctx, op);
         }
         if (fv == -1 && TCG_TARGET_HAS_orc_vec) {
+            TCGArg ta = op->args[2];
             op->opc = INDEX_op_orc_vec;
             op->args[2] = op->args[1];
-            op->args[1] = op->args[3];
+            op->args[1] = ta;
             return fold_orc(ctx, op);
         }
     }
-- 
2.47.3



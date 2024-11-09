Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C85C59C2AE1
	for <lists+qemu-devel@lfdr.de>; Sat,  9 Nov 2024 07:47:42 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t9fBV-0007QX-17; Sat, 09 Nov 2024 01:43:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1t9fA9-00068O-K3; Sat, 09 Nov 2024 01:41:39 -0500
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1t9fA7-0002cx-Vj; Sat, 09 Nov 2024 01:41:37 -0500
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 69736A1307;
 Sat,  9 Nov 2024 09:38:11 +0300 (MSK)
Received: from tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with SMTP id D0A42167DE9;
 Sat,  9 Nov 2024 09:39:05 +0300 (MSK)
Received: (nullmailer pid 3272584 invoked by uid 1000);
 Sat, 09 Nov 2024 06:39:03 -0000
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Ilya Leoshkevich <iii@linux.ibm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Nicholas Piggin <npiggin@gmail.com>, Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-7.2.15 30/33] target/ppc: Set ctx->opcode for decode_insn32()
Date: Sat,  9 Nov 2024 09:38:56 +0300
Message-Id: <20241109063903.3272404-30-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <qemu-stable-7.2.15-20241109093832@cover.tls.msk.ru>
References: <qemu-stable-7.2.15-20241109093832@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=86.62.121.231; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -68
X-Spam_score: -6.9
X-Spam_bar: ------
X-Spam_report: (-6.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_HI=-5,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

From: Ilya Leoshkevich <iii@linux.ibm.com>

divdu (without a dot) sometimes updates cr0, even though it shouldn't.
The reason is that gen_op_arith_divd() checks Rc(ctx->opcode), which is
not initialized. This field is initialized only for instructions that
go through decode_legacy(), and not decodetree.

There already was a similar issue fixed in commit 86e6202a57b1
("target/ppc: Make divw[u] handler method decodetree compatible.").

It's not immediately clear what else may access the uninitialized
ctx->opcode, so instead of playing whack-a-mole and changing the check
to compute_rc0, simply initialize ctx->opcode.

Cc: qemu-stable@nongnu.org
Fixes: 99082815f17f ("target/ppc: Add infrastructure for prefixed insns")
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
(cherry picked from commit c9b8a13a8841e0e23901e57e24ea98eeef16cf91)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/target/ppc/translate.c b/target/ppc/translate.c
index 90f749a728..5ab6c5c861 100644
--- a/target/ppc/translate.c
+++ b/target/ppc/translate.c
@@ -7455,8 +7455,6 @@ static bool decode_legacy(PowerPCCPU *cpu, DisasContext *ctx, uint32_t insn)
     opc_handler_t **table, *handler;
     uint32_t inval;
 
-    ctx->opcode = insn;
-
     LOG_DISAS("translate opcode %08x (%02x %02x %02x %02x) (%s)\n",
               insn, opc1(insn), opc2(insn), opc3(insn), opc4(insn),
               ctx->le_mode ? "little" : "big");
@@ -7587,6 +7585,7 @@ static void ppc_tr_translate_insn(DisasContextBase *dcbase, CPUState *cs)
     ctx->base.pc_next = pc += 4;
 
     if (!is_prefix_insn(ctx, insn)) {
+        ctx->opcode = insn;
         ok = (decode_insn32(ctx, insn) ||
               decode_legacy(cpu, ctx, insn));
     } else if ((pc & 63) == 0) {
-- 
2.39.5



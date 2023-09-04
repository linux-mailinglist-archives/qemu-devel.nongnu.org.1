Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DED11791478
	for <lists+qemu-devel@lfdr.de>; Mon,  4 Sep 2023 11:11:35 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qd5Xx-0001MJ-Gd; Mon, 04 Sep 2023 05:07:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=kZzc=EU=kaod.org=clg@ozlabs.org>)
 id 1qd5Xt-0001Hw-Tm; Mon, 04 Sep 2023 05:06:58 -0400
Received: from gandalf.ozlabs.org ([150.107.74.76])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=kZzc=EU=kaod.org=clg@ozlabs.org>)
 id 1qd5Xr-0003da-Ef; Mon, 04 Sep 2023 05:06:57 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
 by gandalf.ozlabs.org (Postfix) with ESMTP id 4RfN6y6F2Bz4wy9;
 Mon,  4 Sep 2023 19:06:50 +1000 (AEST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4RfN6x0KsFz4wxN;
 Mon,  4 Sep 2023 19:06:48 +1000 (AEST)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
To: qemu-ppc@nongnu.org,
	qemu-devel@nongnu.org
Cc: Daniel Henrique Barboza <danielhb413@gmail.com>,
 Nicholas Piggin <npiggin@gmail.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Subject: [PULL 05/35] target/ppc: Suppress single step interrupts on rfi-type
 instructions
Date: Mon,  4 Sep 2023 11:06:00 +0200
Message-ID: <20230904090630.725952-6-clg@kaod.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230904090630.725952-1-clg@kaod.org>
References: <20230904090630.725952-1-clg@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=150.107.74.76;
 envelope-from=SRS0=kZzc=EU=kaod.org=clg@ozlabs.org; helo=gandalf.ozlabs.org
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9,
 HEADER_FROM_DIFFERENT_DOMAINS=0.249, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

From: Nicholas Piggin <npiggin@gmail.com>

BookS does not take single step interrupts on completion of rfi and
similar (rfid, hrfid, rfscv). This is not a completely clean way to
do it, but in general non-branch instructions that change NIP on
completion are excluded.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
Signed-off-by: Cédric Le Goater <clg@kaod.org>
---
 target/ppc/translate.c | 23 +++++++++++++++++------
 1 file changed, 17 insertions(+), 6 deletions(-)

diff --git a/target/ppc/translate.c b/target/ppc/translate.c
index 505159667083..6e8f1797ac95 100644
--- a/target/ppc/translate.c
+++ b/target/ppc/translate.c
@@ -338,7 +338,7 @@ static void gen_ppc_maybe_interrupt(DisasContext *ctx)
  * The exception can be either POWERPC_EXCP_TRACE (on most PowerPCs) or
  * POWERPC_EXCP_DEBUG (on BookE).
  */
-static void gen_debug_exception(DisasContext *ctx)
+static void gen_debug_exception(DisasContext *ctx, bool rfi_type)
 {
 #if !defined(CONFIG_USER_ONLY)
     if (ctx->flags & POWERPC_FLAG_DE) {
@@ -357,10 +357,12 @@ static void gen_debug_exception(DisasContext *ctx)
                                    tcg_constant_i32(POWERPC_EXCP_DEBUG));
         ctx->base.is_jmp = DISAS_NORETURN;
     } else {
-        TCGv t0 = tcg_temp_new();
-        tcg_gen_movi_tl(t0, ctx->cia);
-        gen_helper_book3s_trace(cpu_env, t0);
-        ctx->base.is_jmp = DISAS_NORETURN;
+        if (!rfi_type) { /* BookS does not single step rfi type instructions */
+            TCGv t0 = tcg_temp_new();
+            tcg_gen_movi_tl(t0, ctx->cia);
+            gen_helper_book3s_trace(cpu_env, t0);
+            ctx->base.is_jmp = DISAS_NORETURN;
+        }
     }
 #endif
 }
@@ -7412,6 +7414,8 @@ static void ppc_tr_tb_stop(DisasContextBase *dcbase, CPUState *cs)
 
     /* Honor single stepping. */
     if (unlikely(ctx->singlestep_enabled & CPU_SINGLE_STEP)) {
+        bool rfi_type = false;
+
         switch (is_jmp) {
         case DISAS_TOO_MANY:
         case DISAS_EXIT_UPDATE:
@@ -7420,12 +7424,19 @@ static void ppc_tr_tb_stop(DisasContextBase *dcbase, CPUState *cs)
             break;
         case DISAS_EXIT:
         case DISAS_CHAIN:
+            /*
+             * This is a heuristic, to put it kindly. The rfi class of
+             * instructions are among the few outside branches that change
+             * NIP without taking an interrupt. Single step trace interrupts
+             * do not fire on completion of these instructions.
+             */
+            rfi_type = true;
             break;
         default:
             g_assert_not_reached();
         }
 
-        gen_debug_exception(ctx);
+        gen_debug_exception(ctx, rfi_type);
         return;
     }
 
-- 
2.41.0



Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8997473059A
	for <lists+qemu-devel@lfdr.de>; Wed, 14 Jun 2023 19:01:16 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q9Tqv-0004Ro-HT; Wed, 14 Jun 2023 13:00:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kbastian@mail.uni-paderborn.de>)
 id 1q9Tqo-0004RS-U8
 for qemu-devel@nongnu.org; Wed, 14 Jun 2023 13:00:07 -0400
Received: from doohan.uni-paderborn.de ([2001:638:502:c003::16])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kbastian@mail.uni-paderborn.de>)
 id 1q9Tqn-0003e3-5o
 for qemu-devel@nongnu.org; Wed, 14 Jun 2023 13:00:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=mail.uni-paderborn.de; s=20170601; h=Content-Transfer-Encoding:MIME-Version
 :References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
 Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=8/gm1apLV8eHNtaiJvhOC41/i1no+XVp6/uvLHUrNeI=; b=i3zUu3oWXlZQxqXTMwBafLQtEE
 2cwDQyA9btcYFI71Pi/UmHCsJJG9417nFOHkgvwQk4x0BFBSF/TCBxDt81zjDTTcm2fwQh9Hv3BD3
 WDbtnVrrKIg8TrN+KDenYUKPXQuVum2sTvYIUipqhBxigZZpXq29NgHPV3r5/tYDvIOY=;
X-Envelope-From: <kbastian@mail.uni-paderborn.de>
From: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
To: qemu-devel@nongnu.org
Cc: kbastian@mail.uni-paderborn.de,
	richard.henderson@linaro.org
Subject: [PATCH 3/4] target/tricore: Honour privilege changes on PSW write
Date: Wed, 14 Jun 2023 18:59:33 +0200
Message-Id: <20230614165934.1370440-4-kbastian@mail.uni-paderborn.de>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230614165934.1370440-1-kbastian@mail.uni-paderborn.de>
References: <20230614165934.1370440-1-kbastian@mail.uni-paderborn.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-PMX-Version: 6.4.9.2830568, Antispam-Engine: 2.7.2.2107409,
 Antispam-Data: 2023.6.14.165116, AntiVirus-Engine: 6.0.0,
 AntiVirus-Data: 2023.6.6.600001
X-Sophos-SenderHistory: ip=79.202.219.6, fs=606892, da=174371065, mc=78, sc=0,
 hc=78, sp=0, fso=606892, re=0, sd=0, hd=0
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

the CPU can change the privilege level by writing the corresponding bits
in PSW. If this happens all instructions after this 'mtcr' in the TB are
translated with the wrong privilege level. So we have to exit to the
cpu_loop() and start translating again with the new privilege level.

Signed-off-by: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
---
 target/tricore/op_helper.c | 11 +++++++++++
 target/tricore/translate.c |  2 ++
 2 files changed, 13 insertions(+)

diff --git a/target/tricore/op_helper.c b/target/tricore/op_helper.c
index 026e15f3e0..17b78c501c 100644
--- a/target/tricore/op_helper.c
+++ b/target/tricore/op_helper.c
@@ -2839,7 +2839,18 @@ void helper_rslcx(CPUTriCoreState *env)
 
 void helper_psw_write(CPUTriCoreState *env, uint32_t arg)
 {
+    uint32_t old_priv, new_priv;
+    CPUState *cs;
+
+    old_priv = extract32(env->PSW, 10, 2);
     psw_write(env, arg);
+    new_priv = extract32(env->PSW, 10, 2);
+
+    if (old_priv != new_priv) {
+        cs = env_cpu(env);
+        env->PC = env->PC + 4;
+        cpu_loop_exit(cs);
+    }
 }
 
 uint32_t helper_psw_read(CPUTriCoreState *env)
diff --git a/target/tricore/translate.c b/target/tricore/translate.c
index edbc319fa1..baf13fc205 100644
--- a/target/tricore/translate.c
+++ b/target/tricore/translate.c
@@ -331,6 +331,7 @@ static void gen_swapmsk(DisasContext *ctx, int reg, TCGv ea)
     tcg_gen_mov_tl(cpu_gpr_d[reg], temp);
 }
 
+static inline void gen_save_pc(target_ulong pc);
 
 /* We generate loads and store to core special function register (csfr) through
    the function gen_mfcr and gen_mtcr. To handle access permissions, we use 3
@@ -378,6 +379,7 @@ static inline void gen_mtcr(DisasContext *ctx, TCGv r1,
     if (ctx->priv == TRICORE_PRIV_SM) {
         /* since we're caching PSW make this a special case */
         if (offset == 0xfe04) {
+            gen_save_pc(ctx->base.pc_next);
             gen_helper_psw_write(cpu_env, r1);
         } else {
             switch (offset) {
-- 
2.40.1



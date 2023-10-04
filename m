Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EE6F7B799C
	for <lists+qemu-devel@lfdr.de>; Wed,  4 Oct 2023 10:08:48 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qnwuP-0006gA-KB; Wed, 04 Oct 2023 04:07:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1qnwte-00062A-3i; Wed, 04 Oct 2023 04:06:27 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1qnwtZ-0003iQ-K4; Wed, 04 Oct 2023 04:06:16 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 29AD8275B5;
 Wed,  4 Oct 2023 11:02:31 +0300 (MSK)
Received: from tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with SMTP id 6EF6B2CBEE;
 Wed,  4 Oct 2023 11:02:30 +0300 (MSK)
Received: (nullmailer pid 2702871 invoked by uid 1000);
 Wed, 04 Oct 2023 08:02:22 -0000
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-8.1.2 40/45] accel/tcg: Always require can_do_io
Date: Wed,  4 Oct 2023 11:02:01 +0300
Message-Id: <20231004080221.2702636-40-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <qemu-stable-8.1.2-20231003193203@cover.tls.msk.ru>
References: <qemu-stable-8.1.2-20231003193203@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=86.62.121.231; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -68
X-Spam_score: -6.9
X-Spam_bar: ------
X-Spam_report: (-6.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_HI=-5,
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

From: Richard Henderson <richard.henderson@linaro.org>

Require i/o as the last insn of a TranslationBlock always,
not only with icount.  This is required for i/o that alters
the address space, such as a pci config space write.

Resolves: https://gitlab.com/qemu-project/qemu/-/issues/1866
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
(cherry picked from commit 18a536f1f8d6222e562f59179e837fdfd8b92718)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/accel/tcg/translator.c b/accel/tcg/translator.c
index dd507cd471..358214d526 100644
--- a/accel/tcg/translator.c
+++ b/accel/tcg/translator.c
@@ -28,12 +28,6 @@ static void set_can_do_io(DisasContextBase *db, bool val)
 
 bool translator_io_start(DisasContextBase *db)
 {
-    uint32_t cflags = tb_cflags(db->tb);
-
-    if (!(cflags & CF_USE_ICOUNT)) {
-        return false;
-    }
-
     set_can_do_io(db, true);
 
     /*
@@ -86,15 +80,15 @@ static TCGOp *gen_tb_start(DisasContextBase *db, uint32_t cflags)
         tcg_gen_st16_i32(count, cpu_env,
                          offsetof(ArchCPU, neg.icount_decr.u16.low) -
                          offsetof(ArchCPU, env));
-        /*
-         * cpu->can_do_io is set automatically here at the beginning of
-         * each translation block.  The cost is minimal and only paid for
-         * -icount, plus it would be very easy to forget doing it in the
-         * translator.
-         */
-        set_can_do_io(db, db->max_insns == 1 && (cflags & CF_LAST_IO));
     }
 
+    /*
+     * cpu->can_do_io is set automatically here at the beginning of
+     * each translation block.  The cost is minimal, plus it would be
+     * very easy to forget doing it in the translator.
+     */
+    set_can_do_io(db, db->max_insns == 1 && (cflags & CF_LAST_IO));
+
     return icount_start_insn;
 }
 
diff --git a/target/mips/tcg/translate.c b/target/mips/tcg/translate.c
index 9bb40f1849..593fc80458 100644
--- a/target/mips/tcg/translate.c
+++ b/target/mips/tcg/translate.c
@@ -11212,7 +11212,6 @@ static void gen_branch(DisasContext *ctx, int insn_bytes)
         /* Branches completion */
         clear_branch_hflags(ctx);
         ctx->base.is_jmp = DISAS_NORETURN;
-        /* FIXME: Need to clear can_do_io.  */
         switch (proc_hflags & MIPS_HFLAG_BMASK_BASE) {
         case MIPS_HFLAG_FBNSLOT:
             gen_goto_tb(ctx, 0, ctx->base.pc_next + insn_bytes);
-- 
2.39.2



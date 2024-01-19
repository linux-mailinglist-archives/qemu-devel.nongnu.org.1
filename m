Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CBE2832B9B
	for <lists+qemu-devel@lfdr.de>; Fri, 19 Jan 2024 15:49:35 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rQqB1-0002Hp-AG; Fri, 19 Jan 2024 09:48:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>) id 1rQqAx-0002HQ-N5
 for qemu-devel@nongnu.org; Fri, 19 Jan 2024 09:48:55 -0500
Received: from rev.ng ([5.9.113.41])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>) id 1rQqAw-00083G-Ba
 for qemu-devel@nongnu.org; Fri, 19 Jan 2024 09:48:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rev.ng;
 s=dkim; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
 Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=X7sNZ16xM/rGRC0Fl2PyYpAxqTIz8x8cc5VBtkT4zbA=; b=kE/YliNO7Clq+UOCIpcOyc7hFd
 XVoFqk6dFMbUabehokuVYbyGvzU3XhH4pa+Fu/xH51JoY1PbWn2nm7fa2rlwDbwZHt07MpHfXS85F
 1bxcFwFoyZjmoqfDgGgDDIxWC5khH4vAutG6zuLyR42k0iwoJE+qMVenAoNpJogjE24g=;
To: qemu-devel@nongnu.org
Cc: ale@rev.ng,
	richard.henderson@linaro.org,
	philmd@linaro.org
Subject: [RFC PATCH 33/34] accel/tcg: Make translator.c (partially) target
 independent
Date: Fri, 19 Jan 2024 15:40:23 +0100
Message-ID: <20240119144024.14289-34-anjo@rev.ng>
In-Reply-To: <20240119144024.14289-1-anjo@rev.ng>
References: <20240119144024.14289-1-anjo@rev.ng>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=5.9.113.41; envelope-from=anjo@rev.ng; helo=rev.ng
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_PASS=-0.001,
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
Reply-to:  Anton Johansson <anjo@rev.ng>
From:  Anton Johansson via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

Make CPUState offset calculations target independent by using that
CPUState and CPUArchState are statically guaranteed to lie next to each
other in memory.

Signed-off-by: Anton Johansson <anjo@rev.ng>
---
 accel/tcg/translator.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/accel/tcg/translator.c b/accel/tcg/translator.c
index 65219b52eb..43303577d7 100644
--- a/accel/tcg/translator.c
+++ b/accel/tcg/translator.c
@@ -19,8 +19,8 @@
 static void gen_io_start(void)
 {
     tcg_gen_st_i32(tcg_constant_i32(1), tcg_env,
-                   offsetof(ArchCPU, parent_obj.neg.can_do_io) -
-                   offsetof(ArchCPU, env));
+                   offsetof(CPUState, neg.can_do_io) -
+                   sizeof(CPUState));
 }
 
 bool translator_io_start(DisasContextBase *db)
@@ -53,8 +53,8 @@ static TCGOp *gen_tb_start(uint32_t cflags)
     TCGOp *icount_start_insn = NULL;
 
     tcg_gen_ld_i32(count, tcg_env,
-                   offsetof(ArchCPU, parent_obj.neg.icount_decr.u32)
-                   - offsetof(ArchCPU, env));
+                   offsetof(CPUState, neg.icount_decr.u32) -
+                   sizeof(CPUState));
 
     if (cflags & CF_USE_ICOUNT) {
         /*
@@ -82,8 +82,8 @@ static TCGOp *gen_tb_start(uint32_t cflags)
 
     if (cflags & CF_USE_ICOUNT) {
         tcg_gen_st16_i32(count, tcg_env,
-                         offsetof(ArchCPU, parent_obj.neg.icount_decr.u16.low)
-                         - offsetof(ArchCPU, env));
+                         offsetof(CPUState, neg.icount_decr.u16.low) -
+                         sizeof(CPUState));
         /*
          * cpu->can_do_io is cleared automatically here at the beginning of
          * each translation block.  The cost is minimal and only paid for
@@ -92,8 +92,8 @@ static TCGOp *gen_tb_start(uint32_t cflags)
          * go with gen_io_start().
          */
         tcg_gen_st_i32(tcg_constant_i32(0), tcg_env,
-                       offsetof(ArchCPU, parent_obj.neg.can_do_io) -
-                       offsetof(ArchCPU, env));
+                       offsetof(CPUState, neg.can_do_io) -
+                       sizeof(CPUState));
     }
 
     return icount_start_insn;
-- 
2.43.0



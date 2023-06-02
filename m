Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B48AC720983
	for <lists+qemu-devel@lfdr.de>; Fri,  2 Jun 2023 21:08:49 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q5A7F-0007C1-La; Fri, 02 Jun 2023 15:07:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>) id 1q5A7E-0007Bs-As
 for qemu-devel@nongnu.org; Fri, 02 Jun 2023 15:07:12 -0400
Received: from rev.ng ([5.9.113.41])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>) id 1q5A7C-00041g-C9
 for qemu-devel@nongnu.org; Fri, 02 Jun 2023 15:07:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rev.ng;
 s=dkim; h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject:Cc:
 To:From:Sender:Reply-To:Content-Type:Content-ID:Content-Description:
 Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
 In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=Klu2vW3GG+feAAFsHTWpiE7kQhYMy20Ae3yjlTjwMzQ=; b=adElwKbPUoiNV2kjnndG36BUWG
 ffey5BYnUMbXdPFvfRm/HNYtYCq5djCMb5QnflnJDV86UCZBo2y74pFY7OkZfWuIbO7gwxnNLCatm
 DKpsNZazOw/6NFPaAGc42JX7H8EDv0GyVJdd5gX44XDONQrR0HN3hLobDOnrIFtsR9+8=;
To: qemu-devel@nongnu.org
Cc: ale@rev.ng, bcain@quicinc.com, richard.henderson@linaro.org,
 pbonzini@redhat.com, peter.maydell@linaro.org
Subject: [PATCH] target/hexagon: Emit comments to silence coverity
Date: Fri,  2 Jun 2023 21:06:59 +0200
Message-Id: <20230602190659.6342-1-anjo@rev.ng>
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

idef-parser emits safety checks around shifts and extensions to deal
with shift amounts larger than the TCGv size and extensions of 0-bit
regions.  These safety checks sometimes result in dead branches, which
coverity detects and warns about.

This commits silences these dead code warnings in emitted code by using
markup comments.

Signed-off-by: Anton Johansson <anjo@rev.ng>
---
 target/hexagon/idef-parser/parser-helpers.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/target/hexagon/idef-parser/parser-helpers.c b/target/hexagon/idef-parser/parser-helpers.c
index 7b5ebafec2..59ef018d44 100644
--- a/target/hexagon/idef-parser/parser-helpers.c
+++ b/target/hexagon/idef-parser/parser-helpers.c
@@ -636,6 +636,7 @@ static void gen_asl_op(Context *c, YYLTYPE *locp, unsigned bit_width,
     } break;
     case REG_IMM: {
         OUT(c, locp, "if (", op2, " >= ", &bit_width, ") {\n");
+        OUT(c, locp, "/* coverity[dead_error_condition] */\n");
         OUT(c, locp, "tcg_gen_movi_", bit_suffix, "(", res, ", 0);\n");
         OUT(c, locp, "} else {\n");
         OUT(c, locp, "tcg_gen_shli_", bit_suffix,
@@ -691,7 +692,8 @@ static void gen_asr_op(Context *c, YYLTYPE *locp, unsigned bit_width,
         gen_c_int_type(c, locp, bit_width, signedness);
         OUT(c, locp, " shift = ", op2, ";\n");
         OUT(c, locp, "if (", op2, " >= ", &bit_width, ") {\n");
-        OUT(c, locp, "    shift = ", &bit_width, " - 1;\n");
+        OUT(c, locp, "/* coverity[dead_error_condition] */\n");
+        OUT(c, locp, "shift = ", &bit_width, " - 1;\n");
         OUT(c, locp, "}\n");
         OUT(c, locp, "tcg_gen_sari_", bit_suffix,
             "(", res, ", ", op1, ", shift);\n}\n");
@@ -1060,6 +1062,7 @@ static HexValue gen_extend_imm_width_op(Context *c,
             ");\n");
         if (need_guarding) {
             OUT(c, locp, "} else {\n");
+            OUT(c, locp, "/* coverity[dead_error_condition] */\n");
             OUT(c, locp, "tcg_gen_movi_i", &dst_width, "(", &res,
                 ", 0);\n");
             OUT(c, locp, "}\n");
-- 
2.39.1



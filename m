Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6238A8CD2EF
	for <lists+qemu-devel@lfdr.de>; Thu, 23 May 2024 14:59:18 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sA815-0005iS-KA; Thu, 23 May 2024 08:57:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>) id 1sA80x-0005fu-BD
 for qemu-devel@nongnu.org; Thu, 23 May 2024 08:57:48 -0400
Received: from rev.ng ([5.9.113.41])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>) id 1sA80t-0004L1-Sw
 for qemu-devel@nongnu.org; Thu, 23 May 2024 08:57:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rev.ng;
 s=dkim; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
 Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive:List-Unsubscribe:List-Unsubscribe-Post:
 List-Help; bh=BhGdJdl/2jounm6xKaCif8D5yPM70uCPtDdYjdncQog=; b=r1cdX4IUJ0FmUrN
 088shzs0rHE56VUy6lJjswg6HFbg2K1Uh4YEtvN3mE2Lv7qFlW3LYrsc0HfOvHw8/gxYSQf3STcIA
 mfTxNgEOjnivLhyjiZDeeWGy56Do/Jt5NUKkDne53EYgyjx8K2GhyYlpvx9qemu2kDN+ztDUdGDvL
 Ag=;
To: qemu-devel@nongnu.org
Cc: ale@rev.ng,
	ltaylorsimpson@gmail.com,
	bcain@quicinc.com
Subject: [PATCH v4 4/4] target/hexagon: idef-parser simplify predicate init
Date: Thu, 23 May 2024 14:59:01 +0200
Message-ID: <20240523125901.27797-5-anjo@rev.ng>
In-Reply-To: <20240523125901.27797-1-anjo@rev.ng>
References: <20240523125901.27797-1-anjo@rev.ng>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=5.9.113.41; envelope-from=anjo@rev.ng; helo=rev.ng
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Only predicate instruction arguments need to be initialized by
idef-parser. This commit removes registers from the init_list and
simplifies gen_inst_init_args() slightly.

Signed-off-by: Anton Johansson <anjo@rev.ng>
Reviewed-by: Taylor Simpson <ltaylorsimpson@gmail.com>
Reviewed-by: Brian Cain <bcain@quicinc.com>
---
 target/hexagon/idef-parser/idef-parser.y    |  2 --
 target/hexagon/idef-parser/parser-helpers.c | 26 +++++++++++----------
 2 files changed, 14 insertions(+), 14 deletions(-)

diff --git a/target/hexagon/idef-parser/idef-parser.y b/target/hexagon/idef-parser/idef-parser.y
index cd2612eb8c..9ffb9f9699 100644
--- a/target/hexagon/idef-parser/idef-parser.y
+++ b/target/hexagon/idef-parser/idef-parser.y
@@ -233,8 +233,6 @@ code : '{' statements '}'
 argument_decl : REG
                 {
                     emit_arg(c, &@1, &$1);
-                    /* Enqueue register into initialization list */
-                    g_array_append_val(c->inst.init_list, $1);
                 }
               | PRED
                 {
diff --git a/target/hexagon/idef-parser/parser-helpers.c b/target/hexagon/idef-parser/parser-helpers.c
index c150c308be..a7dcd85fe4 100644
--- a/target/hexagon/idef-parser/parser-helpers.c
+++ b/target/hexagon/idef-parser/parser-helpers.c
@@ -1652,26 +1652,28 @@ void gen_inst(Context *c, GString *iname)
 
 
 /*
- * Initialize declared but uninitialized registers, but only for
- * non-conditional instructions
+ * Initialize declared but uninitialized instruction arguments. Only needed for
+ * predicate arguments, initialization of registers is handled by the Hexagon
+ * frontend.
  */
 void gen_inst_init_args(Context *c, YYLTYPE *locp)
 {
+    HexValue *val = NULL;
+    char suffix;
+
+    /* If init_list is NULL arguments have already been initialized */
     if (!c->inst.init_list) {
         return;
     }
 
     for (unsigned i = 0; i < c->inst.init_list->len; i++) {
-        HexValue *val = &g_array_index(c->inst.init_list, HexValue, i);
-        if (val->type == REGISTER_ARG) {
-            /* Nothing to do here */
-        } else if (val->type == PREDICATE) {
-            char suffix = val->is_dotnew ? 'N' : 'V';
-            EMIT_HEAD(c, "tcg_gen_movi_i%u(P%c%c, 0);\n", val->bit_width,
-                      val->pred.id, suffix);
-        } else {
-            yyassert(c, locp, false, "Invalid arg type!");
-        }
+        val = &g_array_index(c->inst.init_list, HexValue, i);
+        suffix = val->is_dotnew ? 'N' : 'V';
+        yyassert(c, locp, val->type == PREDICATE,
+                 "Only predicates need to be initialized!");
+        yyassert(c, locp, val->bit_width == 32,
+                 "Predicates should always be 32 bits");
+        EMIT_HEAD(c, "tcg_gen_movi_i32(P%c%c, 0);\n", val->pred.id, suffix);
     }
 
     /* Free argument init list once we have initialized everything */
-- 
2.45.0



Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A95A8CD2ED
	for <lists+qemu-devel@lfdr.de>; Thu, 23 May 2024 14:59:14 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sA817-0005jn-4y; Thu, 23 May 2024 08:57:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>) id 1sA80x-0005ft-AJ
 for qemu-devel@nongnu.org; Thu, 23 May 2024 08:57:48 -0400
Received: from rev.ng ([5.9.113.41])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>) id 1sA80r-0004Ko-W5
 for qemu-devel@nongnu.org; Thu, 23 May 2024 08:57:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rev.ng;
 s=dkim; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
 Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive:List-Unsubscribe:List-Unsubscribe-Post:
 List-Help; bh=q8GFhwyj1wzUnTITHpuWLzFkE4XYpGj04PGduoH5mdA=; b=rshDQAMVS6zYLgf
 NfPD3+ANZS5rdyhsv2etoAiaBtuMZrQsh3T26FVffiBg5bkbcLVSwYiCQFzDSoFt7p/S8fy8heLqq
 SaRwTpfI2MUNrshbi3siOgmZk7CYUa+vZbA9w7cQRJr6JLkksLJl0KH0+mzuBPrYwNZVOykCIPix3
 ck=;
To: qemu-devel@nongnu.org
Cc: ale@rev.ng,
	ltaylorsimpson@gmail.com,
	bcain@quicinc.com
Subject: [PATCH v4 2/4] target/hexagon: idef-parser remove undefined functions
Date: Thu, 23 May 2024 14:58:59 +0200
Message-ID: <20240523125901.27797-3-anjo@rev.ng>
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

Signed-off-by: Anton Johansson <anjo@rev.ng>
Reviewed-by: Taylor Simpson <ltaylorsimpson@gmail.com>
Reviewed-by: Brian Cain <bcain@quicinc.com>
---
 target/hexagon/idef-parser/parser-helpers.h | 13 -------------
 1 file changed, 13 deletions(-)

diff --git a/target/hexagon/idef-parser/parser-helpers.h b/target/hexagon/idef-parser/parser-helpers.h
index 7c58087169..2087d534a9 100644
--- a/target/hexagon/idef-parser/parser-helpers.h
+++ b/target/hexagon/idef-parser/parser-helpers.h
@@ -143,8 +143,6 @@ void commit(Context *c);
 
 #define OUT(c, locp, ...) FOR_EACH((c), (locp), OUT_IMPL, __VA_ARGS__)
 
-const char *cmp_swap(Context *c, YYLTYPE *locp, const char *type);
-
 /**
  * Temporary values creation
  */
@@ -236,8 +234,6 @@ HexValue gen_extract_op(Context *c,
                         HexValue *index,
                         HexExtract *extract);
 
-HexValue gen_read_reg(Context *c, YYLTYPE *locp, HexValue *reg);
-
 void gen_write_reg(Context *c, YYLTYPE *locp, HexValue *reg, HexValue *value);
 
 void gen_assign(Context *c,
@@ -274,13 +270,6 @@ HexValue gen_ctpop_op(Context *c, YYLTYPE *locp, HexValue *src);
 
 HexValue gen_rotl(Context *c, YYLTYPE *locp, HexValue *src, HexValue *n);
 
-HexValue gen_deinterleave(Context *c, YYLTYPE *locp, HexValue *mixed);
-
-HexValue gen_interleave(Context *c,
-                        YYLTYPE *locp,
-                        HexValue *odd,
-                        HexValue *even);
-
 HexValue gen_carry_from_add(Context *c,
                             YYLTYPE *locp,
                             HexValue *op1,
@@ -349,8 +338,6 @@ HexValue gen_rvalue_ternary(Context *c, YYLTYPE *locp, HexValue *cond,
 
 const char *cond_to_str(TCGCond cond);
 
-void emit_header(Context *c);
-
 void emit_arg(Context *c, YYLTYPE *locp, HexValue *arg);
 
 void emit_footer(Context *c);
-- 
2.45.0



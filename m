Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 93F9E7C8039
	for <lists+qemu-devel@lfdr.de>; Fri, 13 Oct 2023 10:27:51 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qrD4n-0002dr-Jk; Fri, 13 Oct 2023 03:59:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1qrD4e-0001iE-83
 for qemu-devel@nongnu.org; Fri, 13 Oct 2023 03:59:08 -0400
Received: from mail-lf1-x12c.google.com ([2a00:1450:4864:20::12c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1qrD4Z-0006y1-Kq
 for qemu-devel@nongnu.org; Fri, 13 Oct 2023 03:59:07 -0400
Received: by mail-lf1-x12c.google.com with SMTP id
 2adb3069b0e04-50325ce89e9so2482970e87.0
 for <qemu-devel@nongnu.org>; Fri, 13 Oct 2023 00:59:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697183940; x=1697788740; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=b+anxPnJqiuUB0GlICjcfmVbR8l+rl+OV9Xrz2lyUIE=;
 b=tL2mfCgsQUcjGt+BKWCFwqlaN9c5X3yr6/yBnQgOrLND/J9kg1e6GkRjIHJoyinobh
 3TyvtoNoIjpfRqOHsrSbWYnJ02fBqSBKbW4HY5Q1wNBPxoWKPFTNdOG2PqEipNbZZtTT
 EWE6R9nwqa6HXrC1EO3uHNkfTrgkerEiapnOgo37A52N9lA2GuJFqEZ8JBqykrNs6aM2
 lp46qVB1sanRBV4bkmsunEX64DqFJ2zCZTou/HG64a+P/ZrWDOS05iuiWDqXdniniodD
 Ovp3nqOHz0G1B3l4f2tZ+Ect50DO7lHiZUfmAdmqdPRau8XX3btY6Jnap57Kd0hb0uds
 grVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697183940; x=1697788740;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=b+anxPnJqiuUB0GlICjcfmVbR8l+rl+OV9Xrz2lyUIE=;
 b=AjuAq0f2ji9SVBmCRRYLWv0Zim5gbZl09ikZu/Cdl53OCkWF0qbQ9g1dnbP4O4SE3I
 tebi3pUl9Axv1BbbZiCWoxC38EZZKg69ouG94oNY66oNBZpMtUH35IgJpseqD3Sxxe+D
 vgNVRrpPGIXXdLjsxIn0JbpiIrhHnfxd95j2GpF1vfSalpfdKvqUR8EWWLc6efP2WZ49
 nPylMXentCILQhe3yTb9MTWmxC+S6wllBk7PjGajSVBch6avZo8KqYqH6KWzMKLSFN4m
 R97lAyp0UHs19ILZEFfM5t/EfWaUjWsDSqyy24hfDTm7BZe59/lUPEYYJHkaMFRYin6G
 Nfuw==
X-Gm-Message-State: AOJu0YzoxmlQ5rFMex3Us/2O3HXeoWakyPCMTuexXfUD1ei07vbqmPoH
 eh+PWxd1vrPwyXU1rDwZj4jRE9wKrUhjV2+rH0s=
X-Google-Smtp-Source: AGHT+IG+X+Zriw/UWo4WYqT5IhoJYDeSpxWXoO3O3fI+A5hfBmcUk0d1Y7txB4ZqQ6KVtE7/NxeGKA==
X-Received: by 2002:a05:6512:308a:b0:502:e651:129b with SMTP id
 z10-20020a056512308a00b00502e651129bmr25671531lfd.19.1697183940453; 
 Fri, 13 Oct 2023 00:59:00 -0700 (PDT)
Received: from localhost.localdomain (adsl-26.37.6.0.tellas.gr. [37.6.0.26])
 by smtp.gmail.com with ESMTPSA id
 a10-20020a05600c224a00b003fe23b10fdfsm1798183wmm.36.2023.10.13.00.58.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Oct 2023 00:58:59 -0700 (PDT)
From: Emmanouil Pitsidianakis <manos.pitsidianakis@linaro.org>
To: qemu-devel@nongnu.org
Cc: Emmanouil Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Alessandro Di Federico <ale@rev.ng>, Anton Johansson <anjo@rev.ng>
Subject: [RFC PATCH v2 37/78] target/hexagon: add fallthrough pseudo-keyword
Date: Fri, 13 Oct 2023 10:57:04 +0300
Message-Id: <4b2624f946d0e16f0f424c1d2b109b11ced24d22.1697183699.git.manos.pitsidianakis@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1697183699.git.manos.pitsidianakis@linaro.org>
References: <cover.1697183699.git.manos.pitsidianakis@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::12c;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-lf1-x12c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

In preparation of raising -Wimplicit-fallthrough to 5, replace all
fall-through comments with the fallthrough attribute pseudo-keyword.

Signed-off-by: Emmanouil Pitsidianakis <manos.pitsidianakis@linaro.org>
---
 target/hexagon/idef-parser/parser-helpers.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/target/hexagon/idef-parser/parser-helpers.c b/target/hexagon/idef-parser/parser-helpers.c
index 4af020933a..0f1713ae4c 100644
--- a/target/hexagon/idef-parser/parser-helpers.c
+++ b/target/hexagon/idef-parser/parser-helpers.c
@@ -1,34 +1,35 @@
 /*
  *  Copyright(c) 2019-2023 rev.ng Labs Srl. All Rights Reserved.
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License as published by
  *  the Free Software Foundation; either version 2 of the License, or
  *  (at your option) any later version.
  *
  *  This program is distributed in the hope that it will be useful,
  *  but WITHOUT ANY WARRANTY; without even the implied warranty of
  *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
  *  GNU General Public License for more details.
  *
  *  You should have received a copy of the GNU General Public License
  *  along with this program; if not, see <http://www.gnu.org/licenses/>.
  */
 
 #include <assert.h>
 #include <inttypes.h>
 #include <stdarg.h>
 #include <stdbool.h>
 #include <stdint.h>
 #include <stdio.h>
 #include <stdlib.h>
 #include <string.h>
 #include <unistd.h>
 
 #include "idef-parser.h"
 #include "parser-helpers.h"
 #include "idef-parser.tab.h"
 #include "idef-parser.yy.h"
+#include "qemu/compiler.h"
 
 void yyerror(YYLTYPE *locp,
              yyscan_t scanner __attribute__((unused)),
@@ -621,51 +622,51 @@ static void gen_sub_op(Context *c, YYLTYPE *locp, unsigned bit_width,
 static void gen_asl_op(Context *c, YYLTYPE *locp, unsigned bit_width,
                        bool op_is64bit, const char *bit_suffix,
                        HexValue *res, enum OpTypes op_types,
                        HexValue *op1, HexValue *op2)
 {
     HexValue op1_m = *op1;
     HexValue op2_m = *op2;
     switch (op_types) {
     case IMM_IMM: {
         HexSignedness signedness = bin_op_signedness(c, locp,
                                                      op1->signedness,
                                                      op2->signedness);
         gen_c_int_type(c, locp, bit_width, signedness);
         OUT(c, locp, " ", res,
             " = ", op1, " << ", op2, ";\n");
     } break;
     case REG_IMM: {
         OUT(c, locp, "if (", op2, " >= ", &bit_width, ") {\n");
         OUT(c, locp, "tcg_gen_movi_", bit_suffix, "(", res, ", 0);\n");
         OUT(c, locp, "} else {\n");
         OUT(c, locp, "tcg_gen_shli_", bit_suffix,
                 "(", res, ", ", op1, ", ", op2, ");\n");
         OUT(c, locp, "}\n");
     } break;
     case IMM_REG:
         op1_m.bit_width = bit_width;
         op1_m = rvalue_materialize(c, locp, &op1_m);
-        /* fallthrough */
+        fallthrough;
     case REG_REG: {
         OUT(c, locp, "tcg_gen_shl_", bit_suffix,
             "(", res, ", ", &op1_m, ", ", op2, ");\n");
     } break;
     }
     if (op_types == IMM_REG || op_types == REG_REG) {
         /*
          * Handle left shift by 64/32 which hexagon-sim expects to clear out
          * register
          */
         HexValue zero = gen_constant(c, locp, "0", bit_width, UNSIGNED);
         HexValue edge = gen_imm_value(c, locp, bit_width, bit_width, UNSIGNED);
         edge = rvalue_materialize(c, locp, &edge);
         if (op_is64bit) {
             op2_m = gen_rvalue_extend(c, locp, &op2_m);
         }
         op1_m = rvalue_materialize(c, locp, &op1_m);
         op2_m = rvalue_materialize(c, locp, &op2_m);
         OUT(c, locp, "tcg_gen_movcond_i", &bit_width);
         OUT(c, locp, "(TCG_COND_GEU, ", res, ", ", &op2_m, ", ", &edge);
         OUT(c, locp, ", ", &zero, ", ", res, ");\n");
     }
 }
@@ -800,41 +801,41 @@ static void gen_andl_op(Context *c, YYLTYPE *locp, unsigned bit_width,
 static void gen_minmax_op(Context *c, YYLTYPE *locp, unsigned bit_width,
                           HexValue *res, enum OpTypes op_types,
                           HexValue *op1, HexValue *op2, bool minmax)
 {
     const char *mm;
     HexValue op1_m = *op1;
     HexValue op2_m = *op2;
     bool is_unsigned;
 
     assert_signedness(c, locp, res->signedness);
     is_unsigned = res->signedness == UNSIGNED;
 
     if (minmax) {
         /* Max */
         mm = is_unsigned ? "tcg_gen_umax" : "tcg_gen_smax";
     } else {
         /* Min */
         mm = is_unsigned ? "tcg_gen_umin" : "tcg_gen_smin";
     }
     switch (op_types) {
     case IMM_IMM:
         yyassert(c, locp, false, "MINMAX between IMM op IMM, not handled!");
         break;
     case IMM_REG:
         op1_m.bit_width = bit_width;
         op1_m = rvalue_materialize(c, locp, &op1_m);
         OUT(c, locp, mm, "_i", &bit_width, "(");
         OUT(c, locp, res, ", ", &op1_m, ", ", op2, ");\n");
         break;
     case REG_IMM:
         op2_m.bit_width = bit_width;
         op2_m = rvalue_materialize(c, locp, &op2_m);
-        /* Fallthrough */
+        fallthrough;
     case REG_REG:
         OUT(c, locp, mm, "_i", &bit_width, "(");
         OUT(c, locp, res, ", ", op1, ", ", &op2_m, ");\n");
         break;
     }
 }
 
 /* Code generation functions */
-- 
2.39.2



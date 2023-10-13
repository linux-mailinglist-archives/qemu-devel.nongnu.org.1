Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id F0ABE7C7FDA
	for <lists+qemu-devel@lfdr.de>; Fri, 13 Oct 2023 10:18:43 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qrCyI-0002O3-2g; Fri, 13 Oct 2023 03:52:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1qrCx0-0006Kx-UL
 for qemu-devel@nongnu.org; Fri, 13 Oct 2023 03:51:15 -0400
Received: from mail-wr1-x432.google.com ([2a00:1450:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1qrCwn-0004vX-Ge
 for qemu-devel@nongnu.org; Fri, 13 Oct 2023 03:51:14 -0400
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-323168869daso1723116f8f.2
 for <qemu-devel@nongnu.org>; Fri, 13 Oct 2023 00:51:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697183459; x=1697788259; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=b+anxPnJqiuUB0GlICjcfmVbR8l+rl+OV9Xrz2lyUIE=;
 b=FzxUtJSYpQvdJktu4/CLwabsCv6GhLLL7234x+0SSwwyN4qlQzotSSFIlgTYx6+rqp
 xX8Q5iYS0/FTXgO0MNeUubXctCsPZpYjZs215drzBR+RRBn0JuKzFlFTrnG6wcG8vH+t
 PLUXwYo57VJnaHvCVaTeIcFR2kx+KecH9O2794YfNctEwVDTAAf9yAarRr/zUqhgSEiA
 mN49PO91rhuvVE904ukCS950omavnkOiVD1siyw2sRhkW1XnbrGvjrhEGM9mD9qy8bCK
 MHbcSGt6H//yFSQpxuKWTTKW57CIKcGeWx7/xK8Z4C4LkoLn2SMyo21BIKGNj450y9Hm
 cGDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697183459; x=1697788259;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=b+anxPnJqiuUB0GlICjcfmVbR8l+rl+OV9Xrz2lyUIE=;
 b=gQomVVr5HBKxuWjSXd2ykIVWtDIId9LcIFO9U5xQ/R9uOeLp5EExy3yU9ejGIN8Zqi
 MZQPnB+I9FSP2dqveFmZtkz3tP8GQbzzfainx5NCngGEbzaYsy02VtfUJk6CLE9sC/aU
 f9sRUjxQaWDTm0WQnkd25UDHJjL0OX26qOs0CR8wcWxdDJdAomkkFgBbhYZO5PM974Mz
 NxFq54ckVzbIv8tcwCIVK0SsqH6zTTJ8vD2fbyEFL1it7DhzZDfze8MQ7hcMgHNUt3dk
 1fcf98xKNqI4iScwzZUchWHBcEZQV1F82fY6DxLXFqO/x+uiKBCniHh1t6b5Qco78M5V
 4PdQ==
X-Gm-Message-State: AOJu0YxqXPDBZyb6b8JDjUuh2bmO0kqw+dSJlor311PRxl3iiJCEHvE1
 iNrU+7bjjTyDmdtaFqlsJgLKINH7qbNVDNkZ5cc=
X-Google-Smtp-Source: AGHT+IEC0AznQqwtjMzsRYvVi2ff7uRPjWxczNUpC4YkTHKqBYwNsHMP4v5FzlXJ3+bvyrCUvA5mPA==
X-Received: by 2002:a5d:5a86:0:b0:32d:260b:5b7b with SMTP id
 bp6-20020a5d5a86000000b0032d260b5b7bmr9715611wrb.11.1697183459589; 
 Fri, 13 Oct 2023 00:50:59 -0700 (PDT)
Received: from localhost.localdomain (adsl-170.109.242.226.tellas.gr.
 [109.242.226.170]) by smtp.gmail.com with ESMTPSA id
 m8-20020adfa3c8000000b0032d7fde2d3csm7990663wrb.79.2023.10.13.00.50.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Oct 2023 00:50:59 -0700 (PDT)
From: Emmanouil Pitsidianakis <manos.pitsidianakis@linaro.org>
To: qemu-devel@nongnu.org,
	qemu-arm@nongnu.org,
	qemu-block@nongnu.org
Cc: Emmanouil Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Alessandro Di Federico <ale@rev.ng>, Anton Johansson <anjo@rev.ng>
Subject: [RFC PATCH 37/78] target/hexagon: add fallthrough pseudo-keyword
Date: Fri, 13 Oct 2023 10:47:42 +0300
Message-Id: <4b2624f946d0e16f0f424c1d2b109b11ced24d22.1697183082.git.manos.pitsidianakis@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1697183081.git.manos.pitsidianakis@linaro.org>
References: <cover.1697183081.git.manos.pitsidianakis@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::432;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-wr1-x432.google.com
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



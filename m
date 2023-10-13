Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id AFB8E7C80E1
	for <lists+qemu-devel@lfdr.de>; Fri, 13 Oct 2023 10:53:42 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qrDqY-0000ck-Cb; Fri, 13 Oct 2023 04:48:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1qrDqG-0008IM-Qd
 for qemu-devel@nongnu.org; Fri, 13 Oct 2023 04:48:20 -0400
Received: from mail-lf1-x12e.google.com ([2a00:1450:4864:20::12e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1qrDqD-000123-Lk
 for qemu-devel@nongnu.org; Fri, 13 Oct 2023 04:48:20 -0400
Received: by mail-lf1-x12e.google.com with SMTP id
 2adb3069b0e04-5046bf37ec1so2489572e87.1
 for <qemu-devel@nongnu.org>; Fri, 13 Oct 2023 01:48:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697186895; x=1697791695; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZyjpW11mVZhhIRVauwrjxQ+w/ECm7tx1xUmkZkTSkDE=;
 b=Ix9MF7swJUjahwR0lTacP2+R3DRQxgXq+Uapt5YU2koRY0K9mXRlzV1xOWgJtodO75
 +Isz4KKFSPvaWaRmGL4C95qn9PbrV6mr4XWq1Ym/09rk5Y6Dta4Cr+wFxq4iGGYJw8K3
 XqChfWIHuE84XMzWBsYl8T+kj4pJYlJAEhG1latq5KDKBY9s139DBJjFJqVg4afHpV5U
 lDTsv29tttrbZSzEV24Re44yEEDrjvF5j1F71F9qNEX4AFVE7uEfCwYJYfEcDt17/68k
 carogbUYWvrfvp1YwsKnSEEzVNbWpFLZlcVLjEYUJe89EIwyFtoMfwCHdBy8EKB+7saS
 WlZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697186895; x=1697791695;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ZyjpW11mVZhhIRVauwrjxQ+w/ECm7tx1xUmkZkTSkDE=;
 b=D5yH0z7doYrVU0OIZJavVLEkDE9q5jqPM95pCRnHvSvkEqcWxmK0aSNZLkKPmGdmjW
 qXZctO7Srs0r80WeMoyPFe+8C6Pxy/iXVz7IsmgMER3hUqRVxJqAJ05HDAALf1ZiicPP
 3NRqF4smXRsLBWjfDt+e1kOk7cL9TWcq3jV6z65WGrtoQlc7eEVvFDu2aeR8I9v0xF6r
 9si7z5gavGJ9z53AaSwvrFBtH9cSb396laFGPm2MIPtTrLHsfTAvHvwVbFeEEY0w7N5k
 7ABUdfMehsFCYnZrjICaPGVIxnQt1ApXlXcPBuFv2zWb+A+pN7Pcnm+g4vUlLNpUDGJX
 VqIw==
X-Gm-Message-State: AOJu0YzlJgDtwNqyJs6FOSH05Y8SLA3WZdY23RFrNmwN7c76UASXmVdK
 W9YJ/wfP9vxRHkfqQQTyDzloxkx7Pr86xN6dSII=
X-Google-Smtp-Source: AGHT+IG66Xx1uhvZJWDnR+97j9klk1cPgBi4/+QYRC+Gdh0luX+G4gX8+wwAc4DaQEET/7lsgg9PZg==
X-Received: by 2002:a05:6512:b01:b0:503:7dd:7ebd with SMTP id
 w1-20020a0565120b0100b0050307dd7ebdmr25589016lfu.24.1697186895673; 
 Fri, 13 Oct 2023 01:48:15 -0700 (PDT)
Received: from localhost.localdomain (adsl-170.109.242.226.tellas.gr.
 [109.242.226.170]) by smtp.gmail.com with ESMTPSA id
 v10-20020a5d678a000000b0032d9f32b96csm569185wru.62.2023.10.13.01.48.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Oct 2023 01:48:15 -0700 (PDT)
From: Emmanouil Pitsidianakis <manos.pitsidianakis@linaro.org>
To: qemu-devel@nongnu.org
Cc: Emmanouil Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Alessandro Di Federico <ale@rev.ng>, Anton Johansson <anjo@rev.ng>
Subject: [RFC PATCH v3 37/78] target/hexagon: add fallthrough pseudo-keyword
Date: Fri, 13 Oct 2023 11:46:05 +0300
Message-Id: <9025e87041505c2450f06e56f1fbb9b932f8b7ba.1697186560.git.manos.pitsidianakis@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1697186560.git.manos.pitsidianakis@linaro.org>
References: <cover.1697186560.git.manos.pitsidianakis@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::12e;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-lf1-x12e.google.com
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
@@ -29,6 +29,7 @@
 #include "parser-helpers.h"
 #include "idef-parser.tab.h"
 #include "idef-parser.yy.h"
+#include "qemu/compiler.h"
 
 void yyerror(YYLTYPE *locp,
              yyscan_t scanner __attribute__((unused)),
@@ -645,7 +646,7 @@ static void gen_asl_op(Context *c, YYLTYPE *locp, unsigned bit_width,
     case IMM_REG:
         op1_m.bit_width = bit_width;
         op1_m = rvalue_materialize(c, locp, &op1_m);
-        /* fallthrough */
+        fallthrough;
     case REG_REG: {
         OUT(c, locp, "tcg_gen_shl_", bit_suffix,
             "(", res, ", ", &op1_m, ", ", op2, ");\n");
@@ -829,7 +830,7 @@ static void gen_minmax_op(Context *c, YYLTYPE *locp, unsigned bit_width,
     case REG_IMM:
         op2_m.bit_width = bit_width;
         op2_m = rvalue_materialize(c, locp, &op2_m);
-        /* Fallthrough */
+        fallthrough;
     case REG_REG:
         OUT(c, locp, mm, "_i", &bit_width, "(");
         OUT(c, locp, res, ", ", op1, ", ", &op2_m, ");\n");
-- 
2.39.2



Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7634A791B2F
	for <lists+qemu-devel@lfdr.de>; Mon,  4 Sep 2023 18:14:10 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qdCCY-0002Zd-Ap; Mon, 04 Sep 2023 12:13:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qdCCU-0002Xe-NB
 for qemu-devel@nongnu.org; Mon, 04 Sep 2023 12:13:18 -0400
Received: from mail-ej1-x62f.google.com ([2a00:1450:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qdCCQ-0007Vm-Sq
 for qemu-devel@nongnu.org; Mon, 04 Sep 2023 12:13:18 -0400
Received: by mail-ej1-x62f.google.com with SMTP id
 a640c23a62f3a-98377c5d53eso235544866b.0
 for <qemu-devel@nongnu.org>; Mon, 04 Sep 2023 09:13:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1693843992; x=1694448792; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=x4jIrB8buoZ4kzwhFvV0xhUjYKmY274vhbfo/mB1lCg=;
 b=js5lkQL3cJNKZ3IsTjZb7hnuCT/Ea2PDHh7Gv3IevnDVVPJ3+IsbsceqGbagQgQK4g
 iNrUoZk+ulEP3GDeyTECKFG2Ka7M50tLBPWuJDWMG4KcdAdAa/tscs4ZIJtS7+HjGeFU
 w5u1V3ev984RlxkI7hkt30xIeI3yaIaC/xQpAx1+LX+sWPPy4BaWZdGQlao55Mu/Vk8f
 TyDCv7JsmoqaI0pjDmqGFhb22M3KqXlR3/uluzaPDuwakjXSKiqBB1c4rPWXgJT9Pr6e
 004BHCYVvoa+GK/j92UnBtgOiUr+J0e+TH+jOWHa30BL3j/i578Hs6J9XliGt7xikn3n
 ANew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693843992; x=1694448792;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=x4jIrB8buoZ4kzwhFvV0xhUjYKmY274vhbfo/mB1lCg=;
 b=C1aqBAKPEm8EGRj9MV7/ljx2p8vkCBwQBbFHRVD4fIA0p5bPwXxMR5uuJdA/DDupEh
 EMx07sI/rNsvaD3XJaqTpQlXf8vVBQOGGtUy0LN0Qj3P0tOtKysoyRiT71Evj2Od4bST
 7ghPzdTWztafPwnc9IMWZO4ruavD2AQZKM7K5RLxY0Aq4sQFu0TGJKjGIDt41TnkYRZ5
 wf2103MSy3x3lmdf3O0ANMbDGGCfOq/S6I0wrGkkqeDpFo0UIi36FfWurBa3+xgszfvL
 10e2jxh9ec0mDhus0nYhBnE3apon3XQhuptskz/HcTlbHfSBBaClC5F9LfjmGltZhyZd
 I5Ug==
X-Gm-Message-State: AOJu0YxMP1CSwKorsYSlyQRVj8QMECNEYFm6z6mDYw3+FW/GrelyXoe2
 IDGHgfV4zhEEDigvd5uNzk6lsXPYYGRKmPVnxZw=
X-Google-Smtp-Source: AGHT+IFuno0aEOAd/Qm4bAzBL04QnfUFnF8ufg0fd3HDzvACUSGMvCBQMCdpbgnBOJ6gTaOByOyJmg==
X-Received: by 2002:a17:906:cc0f:b0:99e:f3b:2f78 with SMTP id
 ml15-20020a170906cc0f00b0099e0f3b2f78mr6530005ejb.67.1693843992290; 
 Mon, 04 Sep 2023 09:13:12 -0700 (PDT)
Received: from m1x-phil.lan ([176.187.209.227])
 by smtp.gmail.com with ESMTPSA id
 e19-20020a1709067e1300b009a198078c53sm6305559ejr.214.2023.09.04.09.13.11
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 04 Sep 2023 09:13:11 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: Markus Armbruster <armbru@redhat.com>,
	qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, qemu-arm@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
Subject: [PATCH v2 06/22] target/tricore: Clean up local variable shadowing
Date: Mon,  4 Sep 2023 18:12:18 +0200
Message-ID: <20230904161235.84651-7-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230904161235.84651-1-philmd@linaro.org>
References: <20230904161235.84651-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62f;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x62f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Fix:

  target/tricore/translate.c:5016:18: warning: declaration of ‘temp’ shadows a previous local [-Wshadow=compatible-local]
   5016 |             TCGv temp = tcg_constant_i32(const9);
        |                  ^~~~
  target/tricore/translate.c:4958:10: note: shadowed declaration is here
   4958 |     TCGv temp;
        |          ^~~~

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/tricore/translate.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/target/tricore/translate.c b/target/tricore/translate.c
index 6ae5ccbf72..9ca211b2a8 100644
--- a/target/tricore/translate.c
+++ b/target/tricore/translate.c
@@ -4962,8 +4962,6 @@ static void decode_rc_logical_shift(DisasContext *ctx)
     const9 = MASK_OP_RC_CONST9(ctx->opcode);
     op2 = MASK_OP_RC_OP2(ctx->opcode);
 
-    temp = tcg_temp_new();
-
     switch (op2) {
     case OPC2_32_RC_AND:
         tcg_gen_andi_tl(cpu_gpr_d[r2], cpu_gpr_d[r1], const9);
@@ -4972,10 +4970,12 @@ static void decode_rc_logical_shift(DisasContext *ctx)
         tcg_gen_andi_tl(cpu_gpr_d[r2], cpu_gpr_d[r1], ~const9);
         break;
     case OPC2_32_RC_NAND:
+        temp = tcg_temp_new();
         tcg_gen_movi_tl(temp, const9);
         tcg_gen_nand_tl(cpu_gpr_d[r2], cpu_gpr_d[r1], temp);
         break;
     case OPC2_32_RC_NOR:
+        temp = tcg_temp_new();
         tcg_gen_movi_tl(temp, const9);
         tcg_gen_nor_tl(cpu_gpr_d[r2], cpu_gpr_d[r1], temp);
         break;
@@ -5013,7 +5013,7 @@ static void decode_rc_logical_shift(DisasContext *ctx)
         break;
     case OPC2_32_RC_SHUFFLE:
         if (has_feature(ctx, TRICORE_FEATURE_162)) {
-            TCGv temp = tcg_constant_i32(const9);
+            temp = tcg_constant_i32(const9);
             gen_helper_shuffle(cpu_gpr_d[r2], cpu_gpr_d[r1], temp);
         } else {
             generate_trap(ctx, TRAPC_INSN_ERR, TIN2_IOPC);
-- 
2.41.0



Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E35F578E4FA
	for <lists+qemu-devel@lfdr.de>; Thu, 31 Aug 2023 05:09:48 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qbY3d-0005MO-3o; Wed, 30 Aug 2023 23:09:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qbY3T-0005LB-G4
 for qemu-devel@nongnu.org; Wed, 30 Aug 2023 23:09:12 -0400
Received: from mail-pg1-x52b.google.com ([2607:f8b0:4864:20::52b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qbY3R-0001Fx-4m
 for qemu-devel@nongnu.org; Wed, 30 Aug 2023 23:09:11 -0400
Received: by mail-pg1-x52b.google.com with SMTP id
 41be03b00d2f7-563f8e8a53dso302431a12.3
 for <qemu-devel@nongnu.org>; Wed, 30 Aug 2023 20:09:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1693451347; x=1694056147; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=WCSUo8NxMzlfmw4OjKURT71L8T30vr4pb5Vh1ZtlO+I=;
 b=KNRDLbOV7CYBDTs+fL6rzy04S72S4/1wLcEI995T6nGhM2ATFHYiDEjuDTDm99yKV0
 EQSPQ5aCVr0GPHsmJ/2KcKKkBTS3XBmMTOIeRTecgoTls9DWnVG2iK1QGGREgZZcFQaC
 3/LNmh43+RMiZOKwSQyq2kMfAUVCF/dKzbWwXDmmQ7Xj6shEqv661t77YYmp9yxDGBED
 t1F1ZEuR429+pHu4Mzomettw+Em7N0bJ0u0Nd7bqa/1jjHXT7lTtxfxWgRgaN5VcXJcs
 JU46iHLD+W1fBt5IHvUPzRKOWAyx/I3w50/rqqNpGqkNauyJ0TXn3vabeXZMX6qDsLRg
 kuTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693451347; x=1694056147;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=WCSUo8NxMzlfmw4OjKURT71L8T30vr4pb5Vh1ZtlO+I=;
 b=GzOvqYQOPS8a9/VHctLniWbwkkr4eJDX8AjiLj599GS7uyCFo1secyIh/RuAzAs7fT
 MVj4j/W1PMfycztGYvC3/x6bt+jOZsid3udH6LIsBRzh/83T7SSa0a4kYwUF1+sLkcui
 EabmbfAgBrI3ajbX3IkmiRIr5Dz8yQF2KN4JzPqkWwmhVrY36Wpug+9RsWXaXLh9xSgL
 Q6mq5D32GpPZkJDxwhk8LZ9BrQwKyEvMTnbxUG5HNCgBn94ENDNtZ9vTNZkXNPzjRis9
 MHnKCTaW/PZa+/ANEvOzn7ha69D/ydmdclM+/cHTsWIGNuKKeqAg0EthKRCROWLgWYr7
 Fmvg==
X-Gm-Message-State: AOJu0YwfQYghGITkEo1/oSE0qo6OusMwKIg/ouoduhLelOZMRiBzcq1q
 qo3joAdf4szDJ2yYrJ7nCrjuOFKXPt7rw+iO0PQ=
X-Google-Smtp-Source: AGHT+IHAZPKsT5uVPZUJEMmH6sAncylqJ2BvKxovlUhgSe2+b06euhpDlF17zHqsqI3ZTKHUBnNqqQ==
X-Received: by 2002:a05:6a20:415:b0:148:9ba1:9f6f with SMTP id
 a21-20020a056a20041500b001489ba19f6fmr3821246pza.38.1693451347534; 
 Wed, 30 Aug 2023 20:09:07 -0700 (PDT)
Received: from stoup.. ([71.212.131.115]) by smtp.gmail.com with ESMTPSA id
 ix21-20020a170902f81500b001bba7aab826sm225123plb.163.2023.08.30.20.09.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 30 Aug 2023 20:09:07 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: gaosong@loongson.cn
Subject: [PATCH 2/2] target/arm: Use tcg_gen_gvec_cmpi for compare vs 0
Date: Wed, 30 Aug 2023 20:09:04 -0700
Message-Id: <20230831030904.1194667-3-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230831030904.1194667-1-richard.henderson@linaro.org>
References: <20230831030904.1194667-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52b;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x52b.google.com
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/tcg/translate.c | 56 ++++++--------------------------------
 1 file changed, 9 insertions(+), 47 deletions(-)

diff --git a/target/arm/tcg/translate.c b/target/arm/tcg/translate.c
index 38ad8dd4bd..89a7392ed3 100644
--- a/target/arm/tcg/translate.c
+++ b/target/arm/tcg/translate.c
@@ -2943,54 +2943,16 @@ void gen_gvec_sqrdmlsh_qc(unsigned vece, uint32_t rd_ofs, uint32_t rn_ofs,
     gen_gvec_fn3_qc(rd_ofs, rn_ofs, rm_ofs, opr_sz, max_sz, fns[vece - 1]);
 }
 
-#define GEN_CMP0(NAME, COND)                                            \
-    static void gen_##NAME##0_i32(TCGv_i32 d, TCGv_i32 a)               \
-    {                                                                   \
-        tcg_gen_negsetcond_i32(COND, d, a, tcg_constant_i32(0));        \
-    }                                                                   \
-    static void gen_##NAME##0_i64(TCGv_i64 d, TCGv_i64 a)               \
-    {                                                                   \
-        tcg_gen_negsetcond_i64(COND, d, a, tcg_constant_i64(0));        \
-    }                                                                   \
-    static void gen_##NAME##0_vec(unsigned vece, TCGv_vec d, TCGv_vec a) \
-    {                                                                   \
-        TCGv_vec zero = tcg_constant_vec_matching(d, vece, 0);          \
-        tcg_gen_cmp_vec(COND, vece, d, a, zero);                        \
-    }                                                                   \
-    void gen_gvec_##NAME##0(unsigned vece, uint32_t d, uint32_t m,      \
-                            uint32_t opr_sz, uint32_t max_sz)           \
-    {                                                                   \
-        const GVecGen2 op[4] = {                                        \
-            { .fno = gen_helper_gvec_##NAME##0_b,                       \
-              .fniv = gen_##NAME##0_vec,                                \
-              .opt_opc = vecop_list_cmp,                                \
-              .vece = MO_8 },                                           \
-            { .fno = gen_helper_gvec_##NAME##0_h,                       \
-              .fniv = gen_##NAME##0_vec,                                \
-              .opt_opc = vecop_list_cmp,                                \
-              .vece = MO_16 },                                          \
-            { .fni4 = gen_##NAME##0_i32,                                \
-              .fniv = gen_##NAME##0_vec,                                \
-              .opt_opc = vecop_list_cmp,                                \
-              .vece = MO_32 },                                          \
-            { .fni8 = gen_##NAME##0_i64,                                \
-              .fniv = gen_##NAME##0_vec,                                \
-              .opt_opc = vecop_list_cmp,                                \
-              .prefer_i64 = TCG_TARGET_REG_BITS == 64,                  \
-              .vece = MO_64 },                                          \
-        };                                                              \
-        tcg_gen_gvec_2(d, m, opr_sz, max_sz, &op[vece]);                \
-    }
+#define GEN_CMP0(NAME, COND)                              \
+    void NAME(unsigned vece, uint32_t d, uint32_t m,      \
+              uint32_t opr_sz, uint32_t max_sz)           \
+    { tcg_gen_gvec_cmpi(COND, vece, d, m, 0, opr_sz, max_sz); }
 
-static const TCGOpcode vecop_list_cmp[] = {
-    INDEX_op_cmp_vec, 0
-};
-
-GEN_CMP0(ceq, TCG_COND_EQ)
-GEN_CMP0(cle, TCG_COND_LE)
-GEN_CMP0(cge, TCG_COND_GE)
-GEN_CMP0(clt, TCG_COND_LT)
-GEN_CMP0(cgt, TCG_COND_GT)
+GEN_CMP0(gen_gvec_ceq0, TCG_COND_EQ)
+GEN_CMP0(gen_gvec_cle0, TCG_COND_LE)
+GEN_CMP0(gen_gvec_cge0, TCG_COND_GE)
+GEN_CMP0(gen_gvec_clt0, TCG_COND_LT)
+GEN_CMP0(gen_gvec_cgt0, TCG_COND_GT)
 
 #undef GEN_CMP0
 
-- 
2.34.1



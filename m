Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E7307A2DC2
	for <lists+qemu-devel@lfdr.de>; Sat, 16 Sep 2023 05:37:27 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qhM11-00062E-LB; Fri, 15 Sep 2023 23:30:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qhM0z-00061L-GB
 for qemu-devel@nongnu.org; Fri, 15 Sep 2023 23:30:37 -0400
Received: from mail-pf1-x42c.google.com ([2607:f8b0:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qhM0x-00083e-Rh
 for qemu-devel@nongnu.org; Fri, 15 Sep 2023 23:30:37 -0400
Received: by mail-pf1-x42c.google.com with SMTP id
 d2e1a72fcca58-68fe39555a0so2562552b3a.3
 for <qemu-devel@nongnu.org>; Fri, 15 Sep 2023 20:30:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1694835034; x=1695439834; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3KAt7fCMQ7OMfcBWigABgnv3QkMfxGeq/P8QvCD0lvI=;
 b=w9QgvkrX7VsyB2+YKDJOvTXwGVW/jmJeePN2Jf2OQsDnMhug4kXcJvlyE8Akk7RFs5
 3ZGsZa+op/hPBY7GjkHYcxCtCpnbaXdd4q7lFqbmOTtvyVfMmyvgcm81mBtMIsARmiO6
 /bhid6zRxDyAxElWKttC1QFF5A+50+y4riCbaj8zY03Z7S4Ls3RfPf56Dsghr3EGHmTC
 jzrGiYCv1UWAivJzkR5Mesbdn43De2wUxS6L9taJh4/PdEaiQsxhuvRNxOldScUGAXiy
 RB5aTu/YGmcgEYEXqGNzNExk5XNpYWMJIL+a7Mh+UVjCQ52nD5+80T4hO68xjYBvHWgG
 czAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694835034; x=1695439834;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=3KAt7fCMQ7OMfcBWigABgnv3QkMfxGeq/P8QvCD0lvI=;
 b=XjvDR2yIQl0K4CRQ0aL2zSeFLnzKuvgUyS11jG5pjPtOF8BUlfoYJHSzGD5TMp9w2x
 ry7mkqUHGpKvd7FSeYC+Njn49k+7upOMy2NRWZZpYizg+zVcrVHurxOLmpawVirfu/kT
 FBymQN86m36yRpZ5Cfv8H8qfqeF702wqknNSUEmcXzjGv6goCMXPC1Z2SvQDqjzvydPE
 OVicckFapa3EsT2UAhuZt/kwoo7Ur0IeykYN2FlJxjxfB7vTctej5IY+xHfDkdNvKYY1
 qohZef6qsW5bUG56hQErqZ9G9KUTQJq+cLwLScb0QMmx7ts3NadzuPHzrOGoDXhYsCOi
 KMzA==
X-Gm-Message-State: AOJu0Yzl9OPyMvMmUQSHu+1uU3MeRZxX9SKjCoboXWKpoysJBtIgz3CS
 tbPxU+jYHRcZiDlJ9hLKz5Jdva/TzlOnyMyC9TM=
X-Google-Smtp-Source: AGHT+IFtKr+vpE4Ub5gNzlPd6zX06XEVBxrJ9mhDI54SujOOlVvdyrzGtqOFebShzq2Q98oQMLFEug==
X-Received: by 2002:a05:6a21:a588:b0:140:6d68:ce07 with SMTP id
 gd8-20020a056a21a58800b001406d68ce07mr5124796pzc.52.1694835034555; 
 Fri, 15 Sep 2023 20:30:34 -0700 (PDT)
Received: from stoup.. ([71.212.131.115]) by smtp.gmail.com with ESMTPSA id
 j26-20020aa783da000000b00687a4b70d1esm3577320pfn.218.2023.09.15.20.30.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 15 Sep 2023 20:30:34 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Song Gao <gaosong@loongson.cn>
Subject: [PULL 23/39] target/arm: Use tcg_gen_gvec_cmpi for compare vs 0
Date: Fri, 15 Sep 2023 20:29:55 -0700
Message-Id: <20230916033011.479144-24-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230916033011.479144-1-richard.henderson@linaro.org>
References: <20230916033011.479144-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42c;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42c.google.com
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
Reviewed-by: Song Gao <gaosong@loongson.cn>
Message-Id: <20230831030904.1194667-3-richard.henderson@linaro.org>
---
 target/arm/tcg/translate.c | 56 ++++++--------------------------------
 1 file changed, 9 insertions(+), 47 deletions(-)

diff --git a/target/arm/tcg/translate.c b/target/arm/tcg/translate.c
index 976b704200..d83a0e772c 100644
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



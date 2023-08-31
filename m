Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 640E078E4DF
	for <lists+qemu-devel@lfdr.de>; Thu, 31 Aug 2023 04:58:48 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qbXsH-0004sP-8S; Wed, 30 Aug 2023 22:57:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qbXsG-0004s1-28
 for qemu-devel@nongnu.org; Wed, 30 Aug 2023 22:57:36 -0400
Received: from mail-pl1-x633.google.com ([2607:f8b0:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qbXsD-0007oI-LH
 for qemu-devel@nongnu.org; Wed, 30 Aug 2023 22:57:35 -0400
Received: by mail-pl1-x633.google.com with SMTP id
 d9443c01a7336-1bf11b1c7d0so10588475ad.0
 for <qemu-devel@nongnu.org>; Wed, 30 Aug 2023 19:57:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1693450652; x=1694055452; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=xmYRGdMxU32xHJwVCt1KMNjds4d5uoJumow+DOzr+1w=;
 b=EFWL/QcNs37Y7Fp1V5RavE1qTMXs37gNRePL4bxW6g2d9/ewsGeom+uv8Wlgz6RXBA
 j0gbHC6sng67RWB1pE43aXC9FYYU6v+opYKWrTxJBRtcOz0TOGRoupeRvED6tpPwcx+7
 nhEh53FWWCME+X520HCUoxTVyWVDlJqvz9PuAt7PNUjTykSjoCkKA6hRCAHGKTjjPIeJ
 uk5k1vPSPEccGsWb4hbLtgGvPyBmfeklBND2OuMgWYPU7LWbwybgWTFtKGVKgiHniK+p
 /8Yq7ZIMu1ejUBjQ/LtOwaSfpy89KmXeXHiVShCF8XbI/9CkApwKeX1IWXGPMsTyuLgo
 +CrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693450652; x=1694055452;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=xmYRGdMxU32xHJwVCt1KMNjds4d5uoJumow+DOzr+1w=;
 b=M2Q0XUgwGfpEogni4WNhoXvHnDungMC3B/Sz9DUzukKgiAiZfNpHv62WKoV1+nlurP
 mP8vz0h52ULE7Ri7YMD5FnVnQfu/Kbirt7uqEvR6/QPazI/nlObgiA/hVRh8MeO32VcX
 YHM86y2EkvJUGDQd336N6v9ycCtVPpC8j47fd0vZrwHRTxU5hUI8aBymrbLqwyQj8Sd5
 OmuT3Pgr2iP2J7W5zgx1X8ojtuVGTXQ2fDskfEcYe8yKeO3z/JTeV/cX0OVtuUqDpRRh
 YLlERyOeR6UltRc6xdNo5JcgvAci4eABhDNdkpEt54i86ipejXZRryOp40zOYyBkdBzg
 FZ4A==
X-Gm-Message-State: AOJu0YzOyAKZfbpRDx9l2xL44KYpnpOhK1cr3wllpJbZVGcwhDrF7vhK
 JjXN6kVh51+P2hqug+XxOTIcNxchu5CtNEoD88s=
X-Google-Smtp-Source: AGHT+IHQz6XQSBKHND0dPnel4xkOTTMnvFlTimkE25UuLnHiHgcPUBRHHxBiTbmzOGRnL/2BXV76Xg==
X-Received: by 2002:a17:90b:91:b0:26d:5c07:ae3e with SMTP id
 bb17-20020a17090b009100b0026d5c07ae3emr2079071pjb.4.1693450652232; 
 Wed, 30 Aug 2023 19:57:32 -0700 (PDT)
Received: from stoup.. ([71.212.131.115]) by smtp.gmail.com with ESMTPSA id
 dw24-20020a17090b095800b00265c742a262sm288142pjb.4.2023.08.30.19.57.31
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 30 Aug 2023 19:57:31 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 1/4] tcg: Don't free vector results
Date: Wed, 30 Aug 2023 19:57:26 -0700
Message-Id: <20230831025729.1194388-2-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230831025729.1194388-1-richard.henderson@linaro.org>
References: <20230831025729.1194388-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::633;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x633.google.com
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

Avoid reusing vector temporaries so that we may re-use them
when propagating stores to loads.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/tcg-op-gvec.c | 39 ++++++---------------------------------
 1 file changed, 6 insertions(+), 33 deletions(-)

diff --git a/tcg/tcg-op-gvec.c b/tcg/tcg-op-gvec.c
index e260a07c61..f5cfd9bf99 100644
--- a/tcg/tcg-op-gvec.c
+++ b/tcg/tcg-op-gvec.c
@@ -561,7 +561,6 @@ static void do_dup(unsigned vece, uint32_t dofs, uint32_t oprsz,
             tcg_gen_dupi_vec(vece, t_vec, in_c);
         }
         do_dup_store(type, dofs, oprsz, maxsz, t_vec);
-        tcg_temp_free_vec(t_vec);
         return;
     }
 
@@ -1036,8 +1035,6 @@ static void expand_2_vec(unsigned vece, uint32_t dofs, uint32_t aofs,
         fni(vece, t1, t0);
         tcg_gen_st_vec(t1, cpu_env, dofs + i);
     }
-    tcg_temp_free_vec(t0);
-    tcg_temp_free_vec(t1);
 }
 
 /* Expand OPSZ bytes worth of two-vector operands and an immediate operand
@@ -1059,8 +1056,6 @@ static void expand_2i_vec(unsigned vece, uint32_t dofs, uint32_t aofs,
         fni(vece, t1, t0, c);
         tcg_gen_st_vec(t1, cpu_env, dofs + i);
     }
-    tcg_temp_free_vec(t0);
-    tcg_temp_free_vec(t1);
 }
 
 static void expand_2s_vec(unsigned vece, uint32_t dofs, uint32_t aofs,
@@ -1081,8 +1076,6 @@ static void expand_2s_vec(unsigned vece, uint32_t dofs, uint32_t aofs,
         }
         tcg_gen_st_vec(t1, cpu_env, dofs + i);
     }
-    tcg_temp_free_vec(t0);
-    tcg_temp_free_vec(t1);
 }
 
 /* Expand OPSZ bytes worth of three-operand operations using host vectors.  */
@@ -1105,9 +1098,6 @@ static void expand_3_vec(unsigned vece, uint32_t dofs, uint32_t aofs,
         fni(vece, t2, t0, t1);
         tcg_gen_st_vec(t2, cpu_env, dofs + i);
     }
-    tcg_temp_free_vec(t2);
-    tcg_temp_free_vec(t1);
-    tcg_temp_free_vec(t0);
 }
 
 /*
@@ -1134,9 +1124,6 @@ static void expand_3i_vec(unsigned vece, uint32_t dofs, uint32_t aofs,
         fni(vece, t2, t0, t1, c);
         tcg_gen_st_vec(t2, cpu_env, dofs + i);
     }
-    tcg_temp_free_vec(t0);
-    tcg_temp_free_vec(t1);
-    tcg_temp_free_vec(t2);
 }
 
 /* Expand OPSZ bytes worth of four-operand operations using host vectors.  */
@@ -1162,10 +1149,6 @@ static void expand_4_vec(unsigned vece, uint32_t dofs, uint32_t aofs,
             tcg_gen_st_vec(t1, cpu_env, aofs + i);
         }
     }
-    tcg_temp_free_vec(t3);
-    tcg_temp_free_vec(t2);
-    tcg_temp_free_vec(t1);
-    tcg_temp_free_vec(t0);
 }
 
 /*
@@ -1191,10 +1174,6 @@ static void expand_4i_vec(unsigned vece, uint32_t dofs, uint32_t aofs,
         fni(vece, t0, t1, t2, t3, c);
         tcg_gen_st_vec(t0, cpu_env, dofs + i);
     }
-    tcg_temp_free_vec(t3);
-    tcg_temp_free_vec(t2);
-    tcg_temp_free_vec(t1);
-    tcg_temp_free_vec(t0);
 }
 
 /* Expand a vector two-operand operation.  */
@@ -1732,7 +1711,6 @@ void tcg_gen_gvec_dup_mem(unsigned vece, uint32_t dofs, uint32_t aofs,
             TCGv_vec t_vec = tcg_temp_new_vec(type);
             tcg_gen_dup_mem_vec(vece, t_vec, cpu_env, aofs);
             do_dup_store(type, dofs, oprsz, maxsz, t_vec);
-            tcg_temp_free_vec(t_vec);
         } else if (vece <= MO_32) {
             TCGv_i32 in = tcg_temp_ebb_new_i32();
             switch (vece) {
@@ -1766,7 +1744,6 @@ void tcg_gen_gvec_dup_mem(unsigned vece, uint32_t dofs, uint32_t aofs,
             for (i = (aofs == dofs) * 16; i < oprsz; i += 16) {
                 tcg_gen_st_vec(in, cpu_env, dofs + i);
             }
-            tcg_temp_free_vec(in);
         } else {
             TCGv_i64 in0 = tcg_temp_ebb_new_i64();
             TCGv_i64 in1 = tcg_temp_ebb_new_i64();
@@ -1796,7 +1773,6 @@ void tcg_gen_gvec_dup_mem(unsigned vece, uint32_t dofs, uint32_t aofs,
             for (i = (aofs == dofs) * 32; i < oprsz; i += 32) {
                 tcg_gen_st_vec(in, cpu_env, dofs + i);
             }
-            tcg_temp_free_vec(in);
         } else if (TCG_TARGET_HAS_v128) {
             TCGv_vec in0 = tcg_temp_new_vec(TCG_TYPE_V128);
             TCGv_vec in1 = tcg_temp_new_vec(TCG_TYPE_V128);
@@ -1807,8 +1783,6 @@ void tcg_gen_gvec_dup_mem(unsigned vece, uint32_t dofs, uint32_t aofs,
                 tcg_gen_st_vec(in0, cpu_env, dofs + i);
                 tcg_gen_st_vec(in1, cpu_env, dofs + i + 16);
             }
-            tcg_temp_free_vec(in0);
-            tcg_temp_free_vec(in1);
         } else {
             TCGv_i64 in[4];
             int j;
@@ -3137,14 +3111,14 @@ static void expand_2sh_vec(unsigned vece, uint32_t dofs, uint32_t aofs,
                            void (*fni)(unsigned, TCGv_vec, TCGv_vec, TCGv_i32))
 {
     TCGv_vec t0 = tcg_temp_new_vec(type);
+    TCGv_vec t1 = tcg_temp_new_vec(type);
     uint32_t i;
 
     for (i = 0; i < oprsz; i += tysz) {
         tcg_gen_ld_vec(t0, cpu_env, aofs + i);
-        fni(vece, t0, t0, shift);
-        tcg_gen_st_vec(t0, cpu_env, dofs + i);
+        fni(vece, t1, t0, shift);
+        tcg_gen_st_vec(t1, cpu_env, dofs + i);
     }
-    tcg_temp_free_vec(t0);
 }
 
 static void
@@ -3722,16 +3696,15 @@ static void expand_cmp_vec(unsigned vece, uint32_t dofs, uint32_t aofs,
 {
     TCGv_vec t0 = tcg_temp_new_vec(type);
     TCGv_vec t1 = tcg_temp_new_vec(type);
+    TCGv_vec t2 = tcg_temp_new_vec(type);
     uint32_t i;
 
     for (i = 0; i < oprsz; i += tysz) {
         tcg_gen_ld_vec(t0, cpu_env, aofs + i);
         tcg_gen_ld_vec(t1, cpu_env, bofs + i);
-        tcg_gen_cmp_vec(cond, vece, t0, t0, t1);
-        tcg_gen_st_vec(t0, cpu_env, dofs + i);
+        tcg_gen_cmp_vec(cond, vece, t2, t0, t1);
+        tcg_gen_st_vec(t2, cpu_env, dofs + i);
     }
-    tcg_temp_free_vec(t1);
-    tcg_temp_free_vec(t0);
 }
 
 void tcg_gen_gvec_cmp(TCGCond cond, unsigned vece, uint32_t dofs,
-- 
2.34.1



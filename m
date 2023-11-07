Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A65E27E334A
	for <lists+qemu-devel@lfdr.de>; Tue,  7 Nov 2023 03:54:23 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r0C9O-0008Pm-O0; Mon, 06 Nov 2023 21:49:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1r0C9L-0008OZ-Oq
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 21:49:07 -0500
Received: from mail-oi1-x22b.google.com ([2607:f8b0:4864:20::22b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1r0C9J-0005up-MS
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 21:49:07 -0500
Received: by mail-oi1-x22b.google.com with SMTP id
 5614622812f47-3b6ad461599so36758b6e.1
 for <qemu-devel@nongnu.org>; Mon, 06 Nov 2023 18:49:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1699325344; x=1699930144; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Z7hu7I1v6RDDh0TrF9ctysWl55drcBpviXkmgRNznnU=;
 b=aAoRsgtUVZix/q//BgWe56yIUb3NOBSuCL19ef7EwWI+ZpocK4SZlAUlmUumq7qnK7
 MRPNYY4uNnoM1U5BR+gdzru/VK8CkgPUJdtVj3y8eseUDFEdqHJqlelvEF1U6uB8STLl
 btrBACKqgbDt2dmEwgjqcG/ROfFQt+bk30l1KjMza7mQq3jLX67nBrLZcGA0DloaE+Zt
 pZDAoBA7jqsjwNH7zzMJGYIwcF+4LJiN1Eff8KiBriC4bA04CETmZuKI7q3SFhd3o2Pz
 1iHdngsX7HJ6Xbkc1G5g/n9Z3u6q2CWVEsy/EC0GBBTT3sCx0c7EKZa3hahE8Rd363Ce
 yuRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699325344; x=1699930144;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Z7hu7I1v6RDDh0TrF9ctysWl55drcBpviXkmgRNznnU=;
 b=S3JHDgi5rGClmMpUFzLOb+pZuhe22xO/N+ozQPXBglQTH9lmwZ7XEb/vQSFnIHr4qS
 /imKrUd8AE/yyCggHqSYt9ShJ0nAxCUHEbNihxAgLivANhBh90+0xCgsFvQ5tTYr2T6Z
 d0q9wFv+sMzy2vUBr5QFS++pSksEJ1bOTZLBj4k1stutMRLhf6xi0Ba2qOeUdD4HcIl2
 UFETbfpnHZ4NwJN9zTPJE5B5B4aeyFi9KhUVryUens3Y3laoVCITW9Ykuil/ChuxluIN
 VW2wMOVedjtEEiQ3+9+9HVRfaYcdZK7MKflqskGziNjyqSLLSGX/BdeyR/vzz++UD66t
 iTcg==
X-Gm-Message-State: AOJu0YzP7DORaQteLLCiUKlDZOq9D0a4MGdl+28Uwbxy6QK03bTe2Fbj
 XTV8mrvxCBhlyacbxMN5mJYMFBjzMYbvJj2FTfw=
X-Google-Smtp-Source: AGHT+IEtaRTwCRLuvdlfvvFLuhzxJERTRIWHS19B+sxy9IszObdVIb4a/vjSqzzuBFN9hvGHQZoiDQ==
X-Received: by 2002:a05:6808:9b5:b0:3b2:f15e:459f with SMTP id
 e21-20020a05680809b500b003b2f15e459fmr31203177oig.58.1699325344494; 
 Mon, 06 Nov 2023 18:49:04 -0800 (PST)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 fn11-20020a056a002fcb00b006bff7c36fb3sm6367478pfb.95.2023.11.06.18.49.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Nov 2023 18:49:04 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Song Gao <gaosong@loongson.cn>
Subject: [PATCH 26/35] tcg: Don't free vector results
Date: Mon,  6 Nov 2023 18:48:33 -0800
Message-Id: <20231107024842.7650-27-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231107024842.7650-1-richard.henderson@linaro.org>
References: <20231107024842.7650-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::22b;
 envelope-from=richard.henderson@linaro.org; helo=mail-oi1-x22b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Reviewed-by: Song Gao <gaosong@loongson.cn>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/tcg-op-gvec.c | 112 ++++++++++++++++------------------------------
 1 file changed, 38 insertions(+), 74 deletions(-)

diff --git a/tcg/tcg-op-gvec.c b/tcg/tcg-op-gvec.c
index feb2d3686b..bb88943f79 100644
--- a/tcg/tcg-op-gvec.c
+++ b/tcg/tcg-op-gvec.c
@@ -561,7 +561,6 @@ static void do_dup(unsigned vece, uint32_t dofs, uint32_t oprsz,
             tcg_gen_dupi_vec(vece, t_vec, in_c);
         }
         do_dup_store(type, dofs, oprsz, maxsz, t_vec);
-        tcg_temp_free_vec(t_vec);
         return;
     }
 
@@ -1024,11 +1023,10 @@ static void expand_2_vec(unsigned vece, uint32_t dofs, uint32_t aofs,
                          bool load_dest,
                          void (*fni)(unsigned, TCGv_vec, TCGv_vec))
 {
-    TCGv_vec t0 = tcg_temp_new_vec(type);
-    TCGv_vec t1 = tcg_temp_new_vec(type);
-    uint32_t i;
+    for (uint32_t i = 0; i < oprsz; i += tysz) {
+        TCGv_vec t0 = tcg_temp_new_vec(type);
+        TCGv_vec t1 = tcg_temp_new_vec(type);
 
-    for (i = 0; i < oprsz; i += tysz) {
         tcg_gen_ld_vec(t0, tcg_env, aofs + i);
         if (load_dest) {
             tcg_gen_ld_vec(t1, tcg_env, dofs + i);
@@ -1036,8 +1034,6 @@ static void expand_2_vec(unsigned vece, uint32_t dofs, uint32_t aofs,
         fni(vece, t1, t0);
         tcg_gen_st_vec(t1, tcg_env, dofs + i);
     }
-    tcg_temp_free_vec(t0);
-    tcg_temp_free_vec(t1);
 }
 
 /* Expand OPSZ bytes worth of two-vector operands and an immediate operand
@@ -1047,11 +1043,10 @@ static void expand_2i_vec(unsigned vece, uint32_t dofs, uint32_t aofs,
                           int64_t c, bool load_dest,
                           void (*fni)(unsigned, TCGv_vec, TCGv_vec, int64_t))
 {
-    TCGv_vec t0 = tcg_temp_new_vec(type);
-    TCGv_vec t1 = tcg_temp_new_vec(type);
-    uint32_t i;
+    for (uint32_t i = 0; i < oprsz; i += tysz) {
+        TCGv_vec t0 = tcg_temp_new_vec(type);
+        TCGv_vec t1 = tcg_temp_new_vec(type);
 
-    for (i = 0; i < oprsz; i += tysz) {
         tcg_gen_ld_vec(t0, tcg_env, aofs + i);
         if (load_dest) {
             tcg_gen_ld_vec(t1, tcg_env, dofs + i);
@@ -1059,8 +1054,6 @@ static void expand_2i_vec(unsigned vece, uint32_t dofs, uint32_t aofs,
         fni(vece, t1, t0, c);
         tcg_gen_st_vec(t1, tcg_env, dofs + i);
     }
-    tcg_temp_free_vec(t0);
-    tcg_temp_free_vec(t1);
 }
 
 static void expand_2s_vec(unsigned vece, uint32_t dofs, uint32_t aofs,
@@ -1068,11 +1061,10 @@ static void expand_2s_vec(unsigned vece, uint32_t dofs, uint32_t aofs,
                           TCGv_vec c, bool scalar_first,
                           void (*fni)(unsigned, TCGv_vec, TCGv_vec, TCGv_vec))
 {
-    TCGv_vec t0 = tcg_temp_new_vec(type);
-    TCGv_vec t1 = tcg_temp_new_vec(type);
-    uint32_t i;
+    for (uint32_t i = 0; i < oprsz; i += tysz) {
+        TCGv_vec t0 = tcg_temp_new_vec(type);
+        TCGv_vec t1 = tcg_temp_new_vec(type);
 
-    for (i = 0; i < oprsz; i += tysz) {
         tcg_gen_ld_vec(t0, tcg_env, aofs + i);
         if (scalar_first) {
             fni(vece, t1, c, t0);
@@ -1081,8 +1073,6 @@ static void expand_2s_vec(unsigned vece, uint32_t dofs, uint32_t aofs,
         }
         tcg_gen_st_vec(t1, tcg_env, dofs + i);
     }
-    tcg_temp_free_vec(t0);
-    tcg_temp_free_vec(t1);
 }
 
 /* Expand OPSZ bytes worth of three-operand operations using host vectors.  */
@@ -1091,12 +1081,11 @@ static void expand_3_vec(unsigned vece, uint32_t dofs, uint32_t aofs,
                          uint32_t tysz, TCGType type, bool load_dest,
                          void (*fni)(unsigned, TCGv_vec, TCGv_vec, TCGv_vec))
 {
-    TCGv_vec t0 = tcg_temp_new_vec(type);
-    TCGv_vec t1 = tcg_temp_new_vec(type);
-    TCGv_vec t2 = tcg_temp_new_vec(type);
-    uint32_t i;
+    for (uint32_t i = 0; i < oprsz; i += tysz) {
+        TCGv_vec t0 = tcg_temp_new_vec(type);
+        TCGv_vec t1 = tcg_temp_new_vec(type);
+        TCGv_vec t2 = tcg_temp_new_vec(type);
 
-    for (i = 0; i < oprsz; i += tysz) {
         tcg_gen_ld_vec(t0, tcg_env, aofs + i);
         tcg_gen_ld_vec(t1, tcg_env, bofs + i);
         if (load_dest) {
@@ -1105,9 +1094,6 @@ static void expand_3_vec(unsigned vece, uint32_t dofs, uint32_t aofs,
         fni(vece, t2, t0, t1);
         tcg_gen_st_vec(t2, tcg_env, dofs + i);
     }
-    tcg_temp_free_vec(t2);
-    tcg_temp_free_vec(t1);
-    tcg_temp_free_vec(t0);
 }
 
 /*
@@ -1120,12 +1106,11 @@ static void expand_3i_vec(unsigned vece, uint32_t dofs, uint32_t aofs,
                           void (*fni)(unsigned, TCGv_vec, TCGv_vec, TCGv_vec,
                                       int64_t))
 {
-    TCGv_vec t0 = tcg_temp_new_vec(type);
-    TCGv_vec t1 = tcg_temp_new_vec(type);
-    TCGv_vec t2 = tcg_temp_new_vec(type);
-    uint32_t i;
+    for (uint32_t i = 0; i < oprsz; i += tysz) {
+        TCGv_vec t0 = tcg_temp_new_vec(type);
+        TCGv_vec t1 = tcg_temp_new_vec(type);
+        TCGv_vec t2 = tcg_temp_new_vec(type);
 
-    for (i = 0; i < oprsz; i += tysz) {
         tcg_gen_ld_vec(t0, tcg_env, aofs + i);
         tcg_gen_ld_vec(t1, tcg_env, bofs + i);
         if (load_dest) {
@@ -1134,9 +1119,6 @@ static void expand_3i_vec(unsigned vece, uint32_t dofs, uint32_t aofs,
         fni(vece, t2, t0, t1, c);
         tcg_gen_st_vec(t2, tcg_env, dofs + i);
     }
-    tcg_temp_free_vec(t0);
-    tcg_temp_free_vec(t1);
-    tcg_temp_free_vec(t2);
 }
 
 /* Expand OPSZ bytes worth of four-operand operations using host vectors.  */
@@ -1146,13 +1128,12 @@ static void expand_4_vec(unsigned vece, uint32_t dofs, uint32_t aofs,
                          void (*fni)(unsigned, TCGv_vec, TCGv_vec,
                                      TCGv_vec, TCGv_vec))
 {
-    TCGv_vec t0 = tcg_temp_new_vec(type);
-    TCGv_vec t1 = tcg_temp_new_vec(type);
-    TCGv_vec t2 = tcg_temp_new_vec(type);
-    TCGv_vec t3 = tcg_temp_new_vec(type);
-    uint32_t i;
+    for (uint32_t i = 0; i < oprsz; i += tysz) {
+        TCGv_vec t0 = tcg_temp_new_vec(type);
+        TCGv_vec t1 = tcg_temp_new_vec(type);
+        TCGv_vec t2 = tcg_temp_new_vec(type);
+        TCGv_vec t3 = tcg_temp_new_vec(type);
 
-    for (i = 0; i < oprsz; i += tysz) {
         tcg_gen_ld_vec(t1, tcg_env, aofs + i);
         tcg_gen_ld_vec(t2, tcg_env, bofs + i);
         tcg_gen_ld_vec(t3, tcg_env, cofs + i);
@@ -1162,10 +1143,6 @@ static void expand_4_vec(unsigned vece, uint32_t dofs, uint32_t aofs,
             tcg_gen_st_vec(t1, tcg_env, aofs + i);
         }
     }
-    tcg_temp_free_vec(t3);
-    tcg_temp_free_vec(t2);
-    tcg_temp_free_vec(t1);
-    tcg_temp_free_vec(t0);
 }
 
 /*
@@ -1178,23 +1155,18 @@ static void expand_4i_vec(unsigned vece, uint32_t dofs, uint32_t aofs,
                           void (*fni)(unsigned, TCGv_vec, TCGv_vec,
                                      TCGv_vec, TCGv_vec, int64_t))
 {
-    TCGv_vec t0 = tcg_temp_new_vec(type);
-    TCGv_vec t1 = tcg_temp_new_vec(type);
-    TCGv_vec t2 = tcg_temp_new_vec(type);
-    TCGv_vec t3 = tcg_temp_new_vec(type);
-    uint32_t i;
+    for (uint32_t i = 0; i < oprsz; i += tysz) {
+        TCGv_vec t0 = tcg_temp_new_vec(type);
+        TCGv_vec t1 = tcg_temp_new_vec(type);
+        TCGv_vec t2 = tcg_temp_new_vec(type);
+        TCGv_vec t3 = tcg_temp_new_vec(type);
 
-    for (i = 0; i < oprsz; i += tysz) {
         tcg_gen_ld_vec(t1, tcg_env, aofs + i);
         tcg_gen_ld_vec(t2, tcg_env, bofs + i);
         tcg_gen_ld_vec(t3, tcg_env, cofs + i);
         fni(vece, t0, t1, t2, t3, c);
         tcg_gen_st_vec(t0, tcg_env, dofs + i);
     }
-    tcg_temp_free_vec(t3);
-    tcg_temp_free_vec(t2);
-    tcg_temp_free_vec(t1);
-    tcg_temp_free_vec(t0);
 }
 
 /* Expand a vector two-operand operation.  */
@@ -1732,7 +1704,6 @@ void tcg_gen_gvec_dup_mem(unsigned vece, uint32_t dofs, uint32_t aofs,
             TCGv_vec t_vec = tcg_temp_new_vec(type);
             tcg_gen_dup_mem_vec(vece, t_vec, tcg_env, aofs);
             do_dup_store(type, dofs, oprsz, maxsz, t_vec);
-            tcg_temp_free_vec(t_vec);
         } else if (vece <= MO_32) {
             TCGv_i32 in = tcg_temp_ebb_new_i32();
             switch (vece) {
@@ -1766,7 +1737,6 @@ void tcg_gen_gvec_dup_mem(unsigned vece, uint32_t dofs, uint32_t aofs,
             for (i = (aofs == dofs) * 16; i < oprsz; i += 16) {
                 tcg_gen_st_vec(in, tcg_env, dofs + i);
             }
-            tcg_temp_free_vec(in);
         } else {
             TCGv_i64 in0 = tcg_temp_ebb_new_i64();
             TCGv_i64 in1 = tcg_temp_ebb_new_i64();
@@ -1796,7 +1766,6 @@ void tcg_gen_gvec_dup_mem(unsigned vece, uint32_t dofs, uint32_t aofs,
             for (i = (aofs == dofs) * 32; i < oprsz; i += 32) {
                 tcg_gen_st_vec(in, tcg_env, dofs + i);
             }
-            tcg_temp_free_vec(in);
         } else if (TCG_TARGET_HAS_v128) {
             TCGv_vec in0 = tcg_temp_new_vec(TCG_TYPE_V128);
             TCGv_vec in1 = tcg_temp_new_vec(TCG_TYPE_V128);
@@ -1807,8 +1776,6 @@ void tcg_gen_gvec_dup_mem(unsigned vece, uint32_t dofs, uint32_t aofs,
                 tcg_gen_st_vec(in0, tcg_env, dofs + i);
                 tcg_gen_st_vec(in1, tcg_env, dofs + i + 16);
             }
-            tcg_temp_free_vec(in0);
-            tcg_temp_free_vec(in1);
         } else {
             TCGv_i64 in[4];
             int j;
@@ -3136,15 +3103,14 @@ static void expand_2sh_vec(unsigned vece, uint32_t dofs, uint32_t aofs,
                            TCGv_i32 shift,
                            void (*fni)(unsigned, TCGv_vec, TCGv_vec, TCGv_i32))
 {
-    TCGv_vec t0 = tcg_temp_new_vec(type);
-    uint32_t i;
+    for (uint32_t i = 0; i < oprsz; i += tysz) {
+        TCGv_vec t0 = tcg_temp_new_vec(type);
+        TCGv_vec t1 = tcg_temp_new_vec(type);
 
-    for (i = 0; i < oprsz; i += tysz) {
         tcg_gen_ld_vec(t0, tcg_env, aofs + i);
-        fni(vece, t0, t0, shift);
-        tcg_gen_st_vec(t0, tcg_env, dofs + i);
+        fni(vece, t1, t0, shift);
+        tcg_gen_st_vec(t1, tcg_env, dofs + i);
     }
-    tcg_temp_free_vec(t0);
 }
 
 static void
@@ -3720,18 +3686,16 @@ static void expand_cmp_vec(unsigned vece, uint32_t dofs, uint32_t aofs,
                            uint32_t bofs, uint32_t oprsz, uint32_t tysz,
                            TCGType type, TCGCond cond)
 {
-    TCGv_vec t0 = tcg_temp_new_vec(type);
-    TCGv_vec t1 = tcg_temp_new_vec(type);
-    uint32_t i;
+    for (uint32_t i = 0; i < oprsz; i += tysz) {
+        TCGv_vec t0 = tcg_temp_new_vec(type);
+        TCGv_vec t1 = tcg_temp_new_vec(type);
+        TCGv_vec t2 = tcg_temp_new_vec(type);
 
-    for (i = 0; i < oprsz; i += tysz) {
         tcg_gen_ld_vec(t0, tcg_env, aofs + i);
         tcg_gen_ld_vec(t1, tcg_env, bofs + i);
-        tcg_gen_cmp_vec(cond, vece, t0, t0, t1);
-        tcg_gen_st_vec(t0, tcg_env, dofs + i);
+        tcg_gen_cmp_vec(cond, vece, t2, t0, t1);
+        tcg_gen_st_vec(t2, tcg_env, dofs + i);
     }
-    tcg_temp_free_vec(t1);
-    tcg_temp_free_vec(t0);
 }
 
 void tcg_gen_gvec_cmp(TCGCond cond, unsigned vece, uint32_t dofs,
-- 
2.34.1



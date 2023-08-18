Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DB6E078154B
	for <lists+qemu-devel@lfdr.de>; Sat, 19 Aug 2023 00:15:39 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qX7iw-0004ys-PN; Fri, 18 Aug 2023 18:13:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qX7iu-0004xH-Aj
 for qemu-devel@nongnu.org; Fri, 18 Aug 2023 18:13:40 -0400
Received: from mail-pl1-x632.google.com ([2607:f8b0:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qX7is-0004Nl-4L
 for qemu-devel@nongnu.org; Fri, 18 Aug 2023 18:13:40 -0400
Received: by mail-pl1-x632.google.com with SMTP id
 d9443c01a7336-1bf0b24d925so10722495ad.3
 for <qemu-devel@nongnu.org>; Fri, 18 Aug 2023 15:13:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1692396817; x=1693001617;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pEJRBqcm/a/oZOTyU1G7jiSQvb9uC+VmTRMunIK2Qko=;
 b=P6T8hPryDhCTsg2jtsV98G8Pk0fkpoKceXlwWZzQlC93Kx6uuPDgJ2OcgKHNo13uxT
 rQjJDgux+KNrKzYdT0e9VQcSny8vg2ywK6+HCuncfculK0nak6MJVH7n7tVBDEBJBUAw
 awLiMmixZ+U97X6Lt/0uEZfUYIuuN9AxZ8dEtmJS4c81V+V6LtbVpXtxhqaFktvwQZd7
 g7bEtwTUdCQBCFp+Nk92xUwlEF9MvC617jvzEx0CwkQRU2uDZdTfGyTMxL9ck1iIvDEd
 2T1hTPpsm8XA+vIdY9naInegzupZ42rYElCKmt0zhYR7Mv2QOBLiJaiSUxK9+/+L2XUz
 f88Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692396817; x=1693001617;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=pEJRBqcm/a/oZOTyU1G7jiSQvb9uC+VmTRMunIK2Qko=;
 b=ks5eQl1QIE0nltJyHRnGCFkSK/ggl9JMPWB5e3ZfAjsri4kPOuz0JdJtaG7lEu8/Mx
 MQkVYKu0uYZdFYkOxSWFhVUrVQfqLF4xZJyJhM/a5qBvmi5RN90CEDTA2gNIx4LaA8w5
 MGM5u1AG4s7yDttTN5Y5E/00qNhEmqHmaCV9VoblHHWqUmn0p3ckSDWu0spr4oWn4mUJ
 EnXnKsopeLeOGEP6lD/YS4P+puBMVnjMM5IQZ49cYBLbPGomRuDF/p2ywoWUu8Mw37S1
 LXexA/WPd25J2jfotBU5e7U2CAOV80Cv223sGZQFXKXdw14FK325OMX7sdVHsA+nVD9U
 xKNQ==
X-Gm-Message-State: AOJu0YxEape21S27LoVlo+yoR5Q09NkzpBpJS1SUpIRc1FXkwf73Ko1U
 TlpLCpvSclRMkr/k5CqE7uHbx+gS37JM1xiMfgY=
X-Google-Smtp-Source: AGHT+IGDRZ9uWn0UG4seIt/obgJNLf+p4nSr6BWX0SqJhH8LIZ4hgYPnaNI+AorAkvgwS/bdmUkEYw==
X-Received: by 2002:a17:903:484:b0:1bf:525b:f96e with SMTP id
 jj4-20020a170903048400b001bf525bf96emr446610plb.16.1692396816885; 
 Fri, 18 Aug 2023 15:13:36 -0700 (PDT)
Received: from stoup.. ([2602:47:d483:7301:cf24:6daf:2b9e:7972])
 by smtp.gmail.com with ESMTPSA id
 y7-20020a17090322c700b001bdb85291casm2231417plg.208.2023.08.18.15.13.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 18 Aug 2023 15:13:36 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
Subject: [PATCH v2 09/23] target/tricore: Replace gen_cond_w with
 tcg_gen_negsetcond_tl
Date: Fri, 18 Aug 2023 15:13:13 -0700
Message-Id: <20230818221327.150194-10-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230818221327.150194-1-richard.henderson@linaro.org>
References: <20230818221327.150194-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::632;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x632.google.com
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

Reviewed-by: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/tricore/translate.c | 16 ++++++----------
 1 file changed, 6 insertions(+), 10 deletions(-)

diff --git a/target/tricore/translate.c b/target/tricore/translate.c
index 1947733870..6ae5ccbf72 100644
--- a/target/tricore/translate.c
+++ b/target/tricore/translate.c
@@ -2680,13 +2680,6 @@ gen_accumulating_condi(int cond, TCGv ret, TCGv r1, int32_t con,
     gen_accumulating_cond(cond, ret, r1, temp, op);
 }
 
-/* ret = (r1 cond r2) ? 0xFFFFFFFF ? 0x00000000;*/
-static inline void gen_cond_w(TCGCond cond, TCGv ret, TCGv r1, TCGv r2)
-{
-    tcg_gen_setcond_tl(cond, ret, r1, r2);
-    tcg_gen_neg_tl(ret, ret);
-}
-
 static inline void gen_eqany_bi(TCGv ret, TCGv r1, int32_t con)
 {
     TCGv b0 = tcg_temp_new();
@@ -5692,7 +5685,8 @@ static void decode_rr_accumulator(DisasContext *ctx)
         gen_helper_eq_h(cpu_gpr_d[r3], cpu_gpr_d[r1], cpu_gpr_d[r2]);
         break;
     case OPC2_32_RR_EQ_W:
-        gen_cond_w(TCG_COND_EQ, cpu_gpr_d[r3], cpu_gpr_d[r1], cpu_gpr_d[r2]);
+        tcg_gen_negsetcond_tl(TCG_COND_EQ, cpu_gpr_d[r3],
+                              cpu_gpr_d[r1], cpu_gpr_d[r2]);
         break;
     case OPC2_32_RR_EQANY_B:
         gen_helper_eqany_b(cpu_gpr_d[r3], cpu_gpr_d[r1], cpu_gpr_d[r2]);
@@ -5729,10 +5723,12 @@ static void decode_rr_accumulator(DisasContext *ctx)
         gen_helper_lt_hu(cpu_gpr_d[r3], cpu_gpr_d[r1], cpu_gpr_d[r2]);
         break;
     case OPC2_32_RR_LT_W:
-        gen_cond_w(TCG_COND_LT, cpu_gpr_d[r3], cpu_gpr_d[r1], cpu_gpr_d[r2]);
+        tcg_gen_negsetcond_tl(TCG_COND_LT, cpu_gpr_d[r3],
+                              cpu_gpr_d[r1], cpu_gpr_d[r2]);
         break;
     case OPC2_32_RR_LT_WU:
-        gen_cond_w(TCG_COND_LTU, cpu_gpr_d[r3], cpu_gpr_d[r1], cpu_gpr_d[r2]);
+        tcg_gen_negsetcond_tl(TCG_COND_LTU, cpu_gpr_d[r3],
+                              cpu_gpr_d[r1], cpu_gpr_d[r2]);
         break;
     case OPC2_32_RR_MAX:
         tcg_gen_movcond_tl(TCG_COND_GT, cpu_gpr_d[r3], cpu_gpr_d[r1],
-- 
2.34.1



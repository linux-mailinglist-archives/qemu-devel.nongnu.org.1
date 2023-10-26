Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B1597D7927
	for <lists+qemu-devel@lfdr.de>; Thu, 26 Oct 2023 02:17:26 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qvo2q-00073u-6G; Wed, 25 Oct 2023 20:16:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qvo2m-00071e-Rr
 for qemu-devel@nongnu.org; Wed, 25 Oct 2023 20:16:12 -0400
Received: from mail-pl1-x62d.google.com ([2607:f8b0:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qvo2h-0004rO-L1
 for qemu-devel@nongnu.org; Wed, 25 Oct 2023 20:16:12 -0400
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-1bf55a81eeaso2375955ad.0
 for <qemu-devel@nongnu.org>; Wed, 25 Oct 2023 17:16:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698279360; x=1698884160; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=mZENFqh4cY1cxr9SwQWDQ8KTGiGlTUEViewQDnyDP2A=;
 b=DD2gscnKqIkrx0u0LZ+eF69R0hdVdAsgKdLrvdafU2t69aAN1babDI3nLAkkCi3/Wu
 CJwY8o31v6lWdKBiBCcQDLL0UlORiHCOscQPQY8/G0i4L5Ptyq7aDV6aKh9e4zyYyuUg
 GZWuHk0O1NkNRKHCU2Lbyixb0EB9qDOyQWh2vIow6gWjwMPohSHhyxle+Bsc0cx78Z1Y
 5nfF7aIUvtPtRcFSZ3oxN3n366+6Qa6Ud38exCAQAjfMN34V6qorjzjxpbVEhJSlREUa
 z2CI19TqjiB5fkxtfFqGf2f+aKbQOwPhthqQd9z0dSfqzYk7EAPFVNRFZHQoEj8KcyrF
 eZtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698279360; x=1698884160;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=mZENFqh4cY1cxr9SwQWDQ8KTGiGlTUEViewQDnyDP2A=;
 b=S0e14iyPkpqLt4p5xAFKbcVR9rRIlLLN6I28/aza4zNU8TizW7fvxKA5NvXUk3fxqK
 QyFO88ro3/+f0Tv8Jl1MjTAMbbZRvMf1/FgzTGN2q9Pu9Y0Hn2W5EMoXuNAz9MSrIgNQ
 gCOcRBqEumkYd1wo9vE16OM8ZaWHZGf7DTMPa0wjIcVSO+hjJ1iliyvF6FcZ7B4OmswI
 3IXZ6KI8LUYhgLxXsHcPwufno5m9iu4hmLXLb2Y9VeypFEk0CUKgksyE/LYf7TeC3TJO
 X9rSflhqB/WkgsaGja813lJzw6FSBZ8eK+R/EshkDR360dTVF6i17S/uvBEAfjqTo5LX
 Qojg==
X-Gm-Message-State: AOJu0YyLB+D5lMk3sykUtlgGKs54L6ND5rOe0Qh+cQVL/UusHd3618hB
 246p/MsCgRZDIY4B4/hmo4M40rhBl1S2vnRUAj0=
X-Google-Smtp-Source: AGHT+IHIbT3TgC4K9UhSfQ6jJ7cOMoxLaJUvqiBOjjHihLLcKp0zLA0Fpoc5PIoEAW9Gv8+sc/xBow==
X-Received: by 2002:a17:903:32d2:b0:1c0:9d6f:9d28 with SMTP id
 i18-20020a17090332d200b001c09d6f9d28mr16203303plr.11.1698279360554; 
 Wed, 25 Oct 2023 17:16:00 -0700 (PDT)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 ij23-20020a170902ab5700b001c582de968dsm10038433plb.72.2023.10.25.17.15.59
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Oct 2023 17:16:00 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 10/29] tcg/i386: Pass x86 condition codes to tcg_out_cmov
Date: Wed, 25 Oct 2023 17:13:59 -0700
Message-Id: <20231026001542.1141412-21-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231026001542.1141412-1-richard.henderson@linaro.org>
References: <20231026001542.1141412-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62d;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62d.google.com
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

Hoist the tcg_cond_to_jcc index outside the function.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/i386/tcg-target.c.inc | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/tcg/i386/tcg-target.c.inc b/tcg/i386/tcg-target.c.inc
index a83f8aab30..0daffb0e70 100644
--- a/tcg/i386/tcg-target.c.inc
+++ b/tcg/i386/tcg-target.c.inc
@@ -1668,14 +1668,14 @@ static void tcg_out_setcond2(TCGContext *s, const TCGArg *args,
 }
 #endif
 
-static void tcg_out_cmov(TCGContext *s, TCGCond cond, int rexw,
+static void tcg_out_cmov(TCGContext *s, int jcc, int rexw,
                          TCGReg dest, TCGReg v1)
 {
     if (have_cmov) {
-        tcg_out_modrm(s, OPC_CMOVCC | tcg_cond_to_jcc[cond] | rexw, dest, v1);
+        tcg_out_modrm(s, OPC_CMOVCC | jcc | rexw, dest, v1);
     } else {
         TCGLabel *over = gen_new_label();
-        tcg_out_jxx(s, tcg_cond_to_jcc[tcg_invert_cond(cond)], over, 1);
+        tcg_out_jxx(s, jcc ^ 1, over, 1);
         tcg_out_mov(s, TCG_TYPE_I32, dest, v1);
         tcg_out_label(s, over);
     }
@@ -1686,7 +1686,7 @@ static void tcg_out_movcond(TCGContext *s, int rexw, TCGCond cond,
                             TCGReg v1)
 {
     tcg_out_cmp(s, c1, c2, const_c2, rexw);
-    tcg_out_cmov(s, cond, rexw, dest, v1);
+    tcg_out_cmov(s, tcg_cond_to_jcc[cond], rexw, dest, v1);
 }
 
 static void tcg_out_ctz(TCGContext *s, int rexw, TCGReg dest, TCGReg arg1,
@@ -1698,12 +1698,12 @@ static void tcg_out_ctz(TCGContext *s, int rexw, TCGReg dest, TCGReg arg1,
             tcg_debug_assert(arg2 == (rexw ? 64 : 32));
         } else {
             tcg_debug_assert(dest != arg2);
-            tcg_out_cmov(s, TCG_COND_LTU, rexw, dest, arg2);
+            tcg_out_cmov(s, JCC_JB, rexw, dest, arg2);
         }
     } else {
         tcg_debug_assert(dest != arg2);
         tcg_out_modrm(s, OPC_BSF + rexw, dest, arg1);
-        tcg_out_cmov(s, TCG_COND_EQ, rexw, dest, arg2);
+        tcg_out_cmov(s, JCC_JE, rexw, dest, arg2);
     }
 }
 
@@ -1716,7 +1716,7 @@ static void tcg_out_clz(TCGContext *s, int rexw, TCGReg dest, TCGReg arg1,
             tcg_debug_assert(arg2 == (rexw ? 64 : 32));
         } else {
             tcg_debug_assert(dest != arg2);
-            tcg_out_cmov(s, TCG_COND_LTU, rexw, dest, arg2);
+            tcg_out_cmov(s, JCC_JB, rexw, dest, arg2);
         }
     } else {
         tcg_debug_assert(!const_a2);
@@ -1729,7 +1729,7 @@ static void tcg_out_clz(TCGContext *s, int rexw, TCGReg dest, TCGReg arg1,
 
         /* Since we have destroyed the flags from BSR, we have to re-test.  */
         tcg_out_cmp(s, arg1, 0, 1, rexw);
-        tcg_out_cmov(s, TCG_COND_EQ, rexw, dest, arg2);
+        tcg_out_cmov(s, JCC_JE, rexw, dest, arg2);
     }
 }
 
-- 
2.34.1



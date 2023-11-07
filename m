Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D3C87E3348
	for <lists+qemu-devel@lfdr.de>; Tue,  7 Nov 2023 03:53:52 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r0C9C-0008GS-JS; Mon, 06 Nov 2023 21:48:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1r0C99-0008Ev-A5
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 21:48:55 -0500
Received: from mail-oi1-x22f.google.com ([2607:f8b0:4864:20::22f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1r0C96-0005qw-TJ
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 21:48:55 -0500
Received: by mail-oi1-x22f.google.com with SMTP id
 5614622812f47-3b2e72fe47fso3317636b6e.1
 for <qemu-devel@nongnu.org>; Mon, 06 Nov 2023 18:48:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1699325332; x=1699930132; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=WTj5n1MSXEgec5CmWkyLjNpfK+jR2v5ZweQGOMmio/I=;
 b=HAl7xLsH8BSMcdukg+XqzxOHW7z9nSlaj4kargUq1/HCMf5XFnd3yM1sG6wr08qLhQ
 DP5HvF6GUPUKOgESu0iA62OzZPsPodY+VAyQmJOUb9H3n+PPyA2LXpwIki1vZi3Fe7q1
 7eGwKGIm2yt2ylI3cdSXsOFirMN1VoYWJmucXv/JqzuSlCvXUxiu9sjd4Jsz0Fe9aKz0
 s7rqXBtSo2JQe8wDroKgYGmEIlZcaKqIpsqtYtRVKJdJwjK+Ags6ZnKkLs+Ys9pF2Qy7
 iC+RfCO1BWeEpqCSCAgx/P8zJsnp/CF8VV4/Cs9PgD6u5HDoGfZa8KVWN2qudz6aBAOq
 EBhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699325332; x=1699930132;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=WTj5n1MSXEgec5CmWkyLjNpfK+jR2v5ZweQGOMmio/I=;
 b=gC6/8k3/TtNJ25m3r80+DqyOhFiQ4tBisAXzO91pOaAijnqkIWUXBixu4W2RrkZ7KM
 5HUHzxM5HLlM/uFGSggAXf9il2r/fjrqdR9OJc6JfzxGTdG9FbF+2d17knDQF3bLN8FR
 FPBSiuM6qmjm2lGuEvm/10+1cXYV2IJronpbKIkXVtxVHN6r0ZuVpe0de5rkKCgCv1JH
 s80tQDfPvezPXZWN3iKR8ohB/scx9BLNE2z/QApEXS5nl7DKsWeaGQUAD5Xl5rZ7bmdR
 gD+9/mS6b1qCi8KMOtkdyFdr2HcD+k7/wjqnaxXT5NsW+z83D0TWKrzZpB1uXeiDjtmT
 YGpg==
X-Gm-Message-State: AOJu0YwIHRqOeSBbj+uawGK7sw/mwJIjbanzXxoWDcrh2ZQZzmluNwI3
 sclxcWH+SaBADRBC3iwQ4zuneU7C6kDKnRpPp+s=
X-Google-Smtp-Source: AGHT+IFy1BZeBKUqqVbiD6EBRAg6/dg6K/Wjuf46eyrtn4gPNWsjqg2ciQRw4icQx/TT4laQG691JA==
X-Received: by 2002:a05:6808:655:b0:3b2:db86:209 with SMTP id
 z21-20020a056808065500b003b2db860209mr27052160oih.38.1699325331737; 
 Mon, 06 Nov 2023 18:48:51 -0800 (PST)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 fn11-20020a056a002fcb00b006bff7c36fb3sm6367478pfb.95.2023.11.06.18.48.51
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Nov 2023 18:48:51 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 10/35] tcg: Move tcg_gen_op* out of line
Date: Mon,  6 Nov 2023 18:48:17 -0800
Message-Id: <20231107024842.7650-11-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231107024842.7650-1-richard.henderson@linaro.org>
References: <20231107024842.7650-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::22f;
 envelope-from=richard.henderson@linaro.org; helo=mail-oi1-x22f.google.com
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

In addition to moving out of line, with CONFIG_DEBUG_TCG
mark them all noinline.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20231029210848.78234-3-richard.henderson@linaro.org>
---
 include/tcg/tcg-op-common.h | 252 +++++++-----------------------------
 tcg/tcg-op.c                | 208 +++++++++++++++++++++++++++++
 2 files changed, 252 insertions(+), 208 deletions(-)

diff --git a/include/tcg/tcg-op-common.h b/include/tcg/tcg-op-common.h
index 677aea6dd1..e093f541a7 100644
--- a/include/tcg/tcg-op-common.h
+++ b/include/tcg/tcg-op-common.h
@@ -25,214 +25,50 @@ void vec_gen_2(TCGOpcode, TCGType, unsigned, TCGArg, TCGArg);
 void vec_gen_3(TCGOpcode, TCGType, unsigned, TCGArg, TCGArg, TCGArg);
 void vec_gen_4(TCGOpcode, TCGType, unsigned, TCGArg, TCGArg, TCGArg, TCGArg);
 
-static inline void tcg_gen_op1_i32(TCGOpcode opc, TCGv_i32 a1)
-{
-    tcg_gen_op1(opc, tcgv_i32_arg(a1));
-}
-
-static inline void tcg_gen_op1_i64(TCGOpcode opc, TCGv_i64 a1)
-{
-    tcg_gen_op1(opc, tcgv_i64_arg(a1));
-}
-
-static inline void tcg_gen_op1i(TCGOpcode opc, TCGArg a1)
-{
-    tcg_gen_op1(opc, a1);
-}
-
-static inline void tcg_gen_op2_i32(TCGOpcode opc, TCGv_i32 a1, TCGv_i32 a2)
-{
-    tcg_gen_op2(opc, tcgv_i32_arg(a1), tcgv_i32_arg(a2));
-}
-
-static inline void tcg_gen_op2_i64(TCGOpcode opc, TCGv_i64 a1, TCGv_i64 a2)
-{
-    tcg_gen_op2(opc, tcgv_i64_arg(a1), tcgv_i64_arg(a2));
-}
-
-static inline void tcg_gen_op2i_i32(TCGOpcode opc, TCGv_i32 a1, TCGArg a2)
-{
-    tcg_gen_op2(opc, tcgv_i32_arg(a1), a2);
-}
-
-static inline void tcg_gen_op2i_i64(TCGOpcode opc, TCGv_i64 a1, TCGArg a2)
-{
-    tcg_gen_op2(opc, tcgv_i64_arg(a1), a2);
-}
-
-static inline void tcg_gen_op2ii(TCGOpcode opc, TCGArg a1, TCGArg a2)
-{
-    tcg_gen_op2(opc, a1, a2);
-}
-
-static inline void tcg_gen_op3_i32(TCGOpcode opc, TCGv_i32 a1,
-                                   TCGv_i32 a2, TCGv_i32 a3)
-{
-    tcg_gen_op3(opc, tcgv_i32_arg(a1), tcgv_i32_arg(a2), tcgv_i32_arg(a3));
-}
-
-static inline void tcg_gen_op3_i64(TCGOpcode opc, TCGv_i64 a1,
-                                   TCGv_i64 a2, TCGv_i64 a3)
-{
-    tcg_gen_op3(opc, tcgv_i64_arg(a1), tcgv_i64_arg(a2), tcgv_i64_arg(a3));
-}
-
-static inline void tcg_gen_op3i_i32(TCGOpcode opc, TCGv_i32 a1,
-                                    TCGv_i32 a2, TCGArg a3)
-{
-    tcg_gen_op3(opc, tcgv_i32_arg(a1), tcgv_i32_arg(a2), a3);
-}
-
-static inline void tcg_gen_op3i_i64(TCGOpcode opc, TCGv_i64 a1,
-                                    TCGv_i64 a2, TCGArg a3)
-{
-    tcg_gen_op3(opc, tcgv_i64_arg(a1), tcgv_i64_arg(a2), a3);
-}
-
-static inline void tcg_gen_ldst_op_i32(TCGOpcode opc, TCGv_i32 val,
-                                       TCGv_ptr base, TCGArg offset)
-{
-    tcg_gen_op3(opc, tcgv_i32_arg(val), tcgv_ptr_arg(base), offset);
-}
-
-static inline void tcg_gen_ldst_op_i64(TCGOpcode opc, TCGv_i64 val,
-                                       TCGv_ptr base, TCGArg offset)
-{
-    tcg_gen_op3(opc, tcgv_i64_arg(val), tcgv_ptr_arg(base), offset);
-}
-
-static inline void tcg_gen_op4_i32(TCGOpcode opc, TCGv_i32 a1, TCGv_i32 a2,
-                                   TCGv_i32 a3, TCGv_i32 a4)
-{
-    tcg_gen_op4(opc, tcgv_i32_arg(a1), tcgv_i32_arg(a2),
-                tcgv_i32_arg(a3), tcgv_i32_arg(a4));
-}
-
-static inline void tcg_gen_op4_i64(TCGOpcode opc, TCGv_i64 a1, TCGv_i64 a2,
-                                   TCGv_i64 a3, TCGv_i64 a4)
-{
-    tcg_gen_op4(opc, tcgv_i64_arg(a1), tcgv_i64_arg(a2),
-                tcgv_i64_arg(a3), tcgv_i64_arg(a4));
-}
-
-static inline void tcg_gen_op4i_i32(TCGOpcode opc, TCGv_i32 a1, TCGv_i32 a2,
-                                    TCGv_i32 a3, TCGArg a4)
-{
-    tcg_gen_op4(opc, tcgv_i32_arg(a1), tcgv_i32_arg(a2),
-                tcgv_i32_arg(a3), a4);
-}
-
-static inline void tcg_gen_op4i_i64(TCGOpcode opc, TCGv_i64 a1, TCGv_i64 a2,
-                                    TCGv_i64 a3, TCGArg a4)
-{
-    tcg_gen_op4(opc, tcgv_i64_arg(a1), tcgv_i64_arg(a2),
-                tcgv_i64_arg(a3), a4);
-}
-
-static inline void tcg_gen_op4ii_i32(TCGOpcode opc, TCGv_i32 a1, TCGv_i32 a2,
-                                     TCGArg a3, TCGArg a4)
-{
-    tcg_gen_op4(opc, tcgv_i32_arg(a1), tcgv_i32_arg(a2), a3, a4);
-}
-
-static inline void tcg_gen_op4ii_i64(TCGOpcode opc, TCGv_i64 a1, TCGv_i64 a2,
-                                     TCGArg a3, TCGArg a4)
-{
-    tcg_gen_op4(opc, tcgv_i64_arg(a1), tcgv_i64_arg(a2), a3, a4);
-}
-
-static inline void tcg_gen_op5_i32(TCGOpcode opc, TCGv_i32 a1, TCGv_i32 a2,
-                                   TCGv_i32 a3, TCGv_i32 a4, TCGv_i32 a5)
-{
-    tcg_gen_op5(opc, tcgv_i32_arg(a1), tcgv_i32_arg(a2),
-                tcgv_i32_arg(a3), tcgv_i32_arg(a4), tcgv_i32_arg(a5));
-}
-
-static inline void tcg_gen_op5_i64(TCGOpcode opc, TCGv_i64 a1, TCGv_i64 a2,
-                                   TCGv_i64 a3, TCGv_i64 a4, TCGv_i64 a5)
-{
-    tcg_gen_op5(opc, tcgv_i64_arg(a1), tcgv_i64_arg(a2),
-                tcgv_i64_arg(a3), tcgv_i64_arg(a4), tcgv_i64_arg(a5));
-}
-
-static inline void tcg_gen_op5i_i32(TCGOpcode opc, TCGv_i32 a1, TCGv_i32 a2,
-                                    TCGv_i32 a3, TCGv_i32 a4, TCGArg a5)
-{
-    tcg_gen_op5(opc, tcgv_i32_arg(a1), tcgv_i32_arg(a2),
-                tcgv_i32_arg(a3), tcgv_i32_arg(a4), a5);
-}
-
-static inline void tcg_gen_op5i_i64(TCGOpcode opc, TCGv_i64 a1, TCGv_i64 a2,
-                                    TCGv_i64 a3, TCGv_i64 a4, TCGArg a5)
-{
-    tcg_gen_op5(opc, tcgv_i64_arg(a1), tcgv_i64_arg(a2),
-                tcgv_i64_arg(a3), tcgv_i64_arg(a4), a5);
-}
-
-static inline void tcg_gen_op5ii_i32(TCGOpcode opc, TCGv_i32 a1, TCGv_i32 a2,
-                                     TCGv_i32 a3, TCGArg a4, TCGArg a5)
-{
-    tcg_gen_op5(opc, tcgv_i32_arg(a1), tcgv_i32_arg(a2),
-                tcgv_i32_arg(a3), a4, a5);
-}
-
-static inline void tcg_gen_op5ii_i64(TCGOpcode opc, TCGv_i64 a1, TCGv_i64 a2,
-                                     TCGv_i64 a3, TCGArg a4, TCGArg a5)
-{
-    tcg_gen_op5(opc, tcgv_i64_arg(a1), tcgv_i64_arg(a2),
-                tcgv_i64_arg(a3), a4, a5);
-}
-
-static inline void tcg_gen_op6_i32(TCGOpcode opc, TCGv_i32 a1, TCGv_i32 a2,
-                                   TCGv_i32 a3, TCGv_i32 a4,
-                                   TCGv_i32 a5, TCGv_i32 a6)
-{
-    tcg_gen_op6(opc, tcgv_i32_arg(a1), tcgv_i32_arg(a2),
-                tcgv_i32_arg(a3), tcgv_i32_arg(a4), tcgv_i32_arg(a5),
-                tcgv_i32_arg(a6));
-}
-
-static inline void tcg_gen_op6_i64(TCGOpcode opc, TCGv_i64 a1, TCGv_i64 a2,
-                                   TCGv_i64 a3, TCGv_i64 a4,
-                                   TCGv_i64 a5, TCGv_i64 a6)
-{
-    tcg_gen_op6(opc, tcgv_i64_arg(a1), tcgv_i64_arg(a2),
-                tcgv_i64_arg(a3), tcgv_i64_arg(a4), tcgv_i64_arg(a5),
-                tcgv_i64_arg(a6));
-}
-
-static inline void tcg_gen_op6i_i32(TCGOpcode opc, TCGv_i32 a1, TCGv_i32 a2,
-                                    TCGv_i32 a3, TCGv_i32 a4,
-                                    TCGv_i32 a5, TCGArg a6)
-{
-    tcg_gen_op6(opc, tcgv_i32_arg(a1), tcgv_i32_arg(a2),
-                tcgv_i32_arg(a3), tcgv_i32_arg(a4), tcgv_i32_arg(a5), a6);
-}
-
-static inline void tcg_gen_op6i_i64(TCGOpcode opc, TCGv_i64 a1, TCGv_i64 a2,
-                                    TCGv_i64 a3, TCGv_i64 a4,
-                                    TCGv_i64 a5, TCGArg a6)
-{
-    tcg_gen_op6(opc, tcgv_i64_arg(a1), tcgv_i64_arg(a2),
-                tcgv_i64_arg(a3), tcgv_i64_arg(a4), tcgv_i64_arg(a5), a6);
-}
-
-static inline void tcg_gen_op6ii_i32(TCGOpcode opc, TCGv_i32 a1, TCGv_i32 a2,
-                                     TCGv_i32 a3, TCGv_i32 a4,
-                                     TCGArg a5, TCGArg a6)
-{
-    tcg_gen_op6(opc, tcgv_i32_arg(a1), tcgv_i32_arg(a2),
-                tcgv_i32_arg(a3), tcgv_i32_arg(a4), a5, a6);
-}
-
-static inline void tcg_gen_op6ii_i64(TCGOpcode opc, TCGv_i64 a1, TCGv_i64 a2,
-                                     TCGv_i64 a3, TCGv_i64 a4,
-                                     TCGArg a5, TCGArg a6)
-{
-    tcg_gen_op6(opc, tcgv_i64_arg(a1), tcgv_i64_arg(a2),
-                tcgv_i64_arg(a3), tcgv_i64_arg(a4), a5, a6);
-}
-
+void tcg_gen_op1_i32(TCGOpcode, TCGv_i32);
+void tcg_gen_op1_i64(TCGOpcode, TCGv_i64);
+void tcg_gen_op1i(TCGOpcode, TCGArg);
+void tcg_gen_op2_i32(TCGOpcode, TCGv_i32, TCGv_i32);
+void tcg_gen_op2_i64(TCGOpcode, TCGv_i64, TCGv_i64);
+void tcg_gen_op2i_i32(TCGOpcode, TCGv_i32, TCGArg);
+void tcg_gen_op2i_i64(TCGOpcode, TCGv_i64, TCGArg);
+void tcg_gen_op2ii(TCGOpcode, TCGArg, TCGArg);
+void tcg_gen_op3_i32(TCGOpcode, TCGv_i32, TCGv_i32, TCGv_i32);
+void tcg_gen_op3_i64(TCGOpcode, TCGv_i64, TCGv_i64, TCGv_i64);
+void tcg_gen_op3i_i32(TCGOpcode, TCGv_i32, TCGv_i32, TCGArg);
+void tcg_gen_op3i_i64(TCGOpcode, TCGv_i64, TCGv_i64, TCGArg);
+void tcg_gen_ldst_op_i32(TCGOpcode, TCGv_i32, TCGv_ptr, TCGArg);
+void tcg_gen_ldst_op_i64(TCGOpcode, TCGv_i64, TCGv_ptr, TCGArg);
+void tcg_gen_op4_i32(TCGOpcode, TCGv_i32, TCGv_i32, TCGv_i32, TCGv_i32);
+void tcg_gen_op4_i64(TCGOpcode, TCGv_i64, TCGv_i64, TCGv_i64, TCGv_i64);
+void tcg_gen_op4i_i32(TCGOpcode, TCGv_i32, TCGv_i32, TCGv_i32, TCGArg);
+void tcg_gen_op4i_i64(TCGOpcode, TCGv_i64, TCGv_i64, TCGv_i64, TCGArg);
+void tcg_gen_op4ii_i32(TCGOpcode, TCGv_i32, TCGv_i32, TCGArg, TCGArg);
+void tcg_gen_op4ii_i64(TCGOpcode, TCGv_i64, TCGv_i64, TCGArg, TCGArg);
+void tcg_gen_op5_i32(TCGOpcode, TCGv_i32, TCGv_i32, TCGv_i32,
+                     TCGv_i32, TCGv_i32);
+void tcg_gen_op5_i64(TCGOpcode, TCGv_i64, TCGv_i64, TCGv_i64,
+                     TCGv_i64, TCGv_i64);
+void tcg_gen_op5i_i32(TCGOpcode, TCGv_i32, TCGv_i32, TCGv_i32,
+                      TCGv_i32, TCGArg);
+void tcg_gen_op5i_i64(TCGOpcode, TCGv_i64, TCGv_i64, TCGv_i64,
+                      TCGv_i64, TCGArg);
+void tcg_gen_op5ii_i32(TCGOpcode, TCGv_i32, TCGv_i32, TCGv_i32,
+                       TCGArg, TCGArg);
+void tcg_gen_op5ii_i64(TCGOpcode, TCGv_i64, TCGv_i64, TCGv_i64,
+                       TCGArg, TCGArg);
+void tcg_gen_op6_i32(TCGOpcode, TCGv_i32, TCGv_i32, TCGv_i32,
+                     TCGv_i32, TCGv_i32, TCGv_i32);
+void tcg_gen_op6_i64(TCGOpcode, TCGv_i64, TCGv_i64, TCGv_i64,
+                     TCGv_i64, TCGv_i64, TCGv_i64);
+void tcg_gen_op6i_i32(TCGOpcode, TCGv_i32, TCGv_i32, TCGv_i32,
+                      TCGv_i32, TCGv_i32, TCGArg);
+void tcg_gen_op6i_i64(TCGOpcode, TCGv_i64, TCGv_i64, TCGv_i64,
+                      TCGv_i64, TCGv_i64, TCGArg);
+void tcg_gen_op6ii_i32(TCGOpcode, TCGv_i32, TCGv_i32, TCGv_i32,
+                       TCGv_i32, TCGArg, TCGArg);
+void tcg_gen_op6ii_i64(TCGOpcode, TCGv_i64, TCGv_i64, TCGv_i64,
+                       TCGv_i64, TCGArg, TCGArg);
 
 /* Generic ops.  */
 
diff --git a/tcg/tcg-op.c b/tcg/tcg-op.c
index 9aed19e957..6c826b46b0 100644
--- a/tcg/tcg-op.c
+++ b/tcg/tcg-op.c
@@ -90,6 +90,214 @@ void NI tcg_gen_op6(TCGOpcode opc, TCGArg a1, TCGArg a2, TCGArg a3,
     op->args[5] = a6;
 }
 
+/*
+ * With CONFIG_DEBUG_TCG, tcgv_*_tmp via tcgv_*_arg, is an out-of-line
+ * assertion check.  Force tail calls to avoid too much code expansion.
+ */
+#ifdef CONFIG_DEBUG_TCG
+# define DNI NI
+#else
+# define DNI
+#endif
+
+void DNI tcg_gen_op1_i32(TCGOpcode opc, TCGv_i32 a1)
+{
+    tcg_gen_op1(opc, tcgv_i32_arg(a1));
+}
+
+void DNI tcg_gen_op1_i64(TCGOpcode opc, TCGv_i64 a1)
+{
+    tcg_gen_op1(opc, tcgv_i64_arg(a1));
+}
+
+void DNI tcg_gen_op1i(TCGOpcode opc, TCGArg a1)
+{
+    tcg_gen_op1(opc, a1);
+}
+
+void DNI tcg_gen_op2_i32(TCGOpcode opc, TCGv_i32 a1, TCGv_i32 a2)
+{
+    tcg_gen_op2(opc, tcgv_i32_arg(a1), tcgv_i32_arg(a2));
+}
+
+void DNI tcg_gen_op2_i64(TCGOpcode opc, TCGv_i64 a1, TCGv_i64 a2)
+{
+    tcg_gen_op2(opc, tcgv_i64_arg(a1), tcgv_i64_arg(a2));
+}
+
+void DNI tcg_gen_op2i_i32(TCGOpcode opc, TCGv_i32 a1, TCGArg a2)
+{
+    tcg_gen_op2(opc, tcgv_i32_arg(a1), a2);
+}
+
+void DNI tcg_gen_op2i_i64(TCGOpcode opc, TCGv_i64 a1, TCGArg a2)
+{
+    tcg_gen_op2(opc, tcgv_i64_arg(a1), a2);
+}
+
+void DNI tcg_gen_op2ii(TCGOpcode opc, TCGArg a1, TCGArg a2)
+{
+    tcg_gen_op2(opc, a1, a2);
+}
+
+void DNI tcg_gen_op3_i32(TCGOpcode opc, TCGv_i32 a1, TCGv_i32 a2, TCGv_i32 a3)
+{
+    tcg_gen_op3(opc, tcgv_i32_arg(a1), tcgv_i32_arg(a2), tcgv_i32_arg(a3));
+}
+
+void DNI tcg_gen_op3_i64(TCGOpcode opc, TCGv_i64 a1, TCGv_i64 a2, TCGv_i64 a3)
+{
+    tcg_gen_op3(opc, tcgv_i64_arg(a1), tcgv_i64_arg(a2), tcgv_i64_arg(a3));
+}
+
+void DNI tcg_gen_op3i_i32(TCGOpcode opc, TCGv_i32 a1, TCGv_i32 a2, TCGArg a3)
+{
+    tcg_gen_op3(opc, tcgv_i32_arg(a1), tcgv_i32_arg(a2), a3);
+}
+
+void DNI tcg_gen_op3i_i64(TCGOpcode opc, TCGv_i64 a1, TCGv_i64 a2, TCGArg a3)
+{
+    tcg_gen_op3(opc, tcgv_i64_arg(a1), tcgv_i64_arg(a2), a3);
+}
+
+void DNI tcg_gen_ldst_op_i32(TCGOpcode opc, TCGv_i32 val,
+                             TCGv_ptr base, TCGArg offset)
+{
+    tcg_gen_op3(opc, tcgv_i32_arg(val), tcgv_ptr_arg(base), offset);
+}
+
+void DNI tcg_gen_ldst_op_i64(TCGOpcode opc, TCGv_i64 val,
+                             TCGv_ptr base, TCGArg offset)
+{
+    tcg_gen_op3(opc, tcgv_i64_arg(val), tcgv_ptr_arg(base), offset);
+}
+
+void DNI tcg_gen_op4_i32(TCGOpcode opc, TCGv_i32 a1, TCGv_i32 a2,
+                         TCGv_i32 a3, TCGv_i32 a4)
+{
+    tcg_gen_op4(opc, tcgv_i32_arg(a1), tcgv_i32_arg(a2),
+                tcgv_i32_arg(a3), tcgv_i32_arg(a4));
+}
+
+void DNI tcg_gen_op4_i64(TCGOpcode opc, TCGv_i64 a1, TCGv_i64 a2,
+                         TCGv_i64 a3, TCGv_i64 a4)
+{
+    tcg_gen_op4(opc, tcgv_i64_arg(a1), tcgv_i64_arg(a2),
+                tcgv_i64_arg(a3), tcgv_i64_arg(a4));
+}
+
+void DNI tcg_gen_op4i_i32(TCGOpcode opc, TCGv_i32 a1, TCGv_i32 a2,
+                          TCGv_i32 a3, TCGArg a4)
+{
+    tcg_gen_op4(opc, tcgv_i32_arg(a1), tcgv_i32_arg(a2),
+                tcgv_i32_arg(a3), a4);
+}
+
+void DNI tcg_gen_op4i_i64(TCGOpcode opc, TCGv_i64 a1, TCGv_i64 a2,
+                          TCGv_i64 a3, TCGArg a4)
+{
+    tcg_gen_op4(opc, tcgv_i64_arg(a1), tcgv_i64_arg(a2),
+                tcgv_i64_arg(a3), a4);
+}
+
+void DNI tcg_gen_op4ii_i32(TCGOpcode opc, TCGv_i32 a1, TCGv_i32 a2,
+                           TCGArg a3, TCGArg a4)
+{
+    tcg_gen_op4(opc, tcgv_i32_arg(a1), tcgv_i32_arg(a2), a3, a4);
+}
+
+void DNI tcg_gen_op4ii_i64(TCGOpcode opc, TCGv_i64 a1, TCGv_i64 a2,
+                           TCGArg a3, TCGArg a4)
+{
+    tcg_gen_op4(opc, tcgv_i64_arg(a1), tcgv_i64_arg(a2), a3, a4);
+}
+
+void DNI tcg_gen_op5_i32(TCGOpcode opc, TCGv_i32 a1, TCGv_i32 a2,
+                         TCGv_i32 a3, TCGv_i32 a4, TCGv_i32 a5)
+{
+    tcg_gen_op5(opc, tcgv_i32_arg(a1), tcgv_i32_arg(a2),
+                tcgv_i32_arg(a3), tcgv_i32_arg(a4), tcgv_i32_arg(a5));
+}
+
+void DNI tcg_gen_op5_i64(TCGOpcode opc, TCGv_i64 a1, TCGv_i64 a2,
+                         TCGv_i64 a3, TCGv_i64 a4, TCGv_i64 a5)
+{
+    tcg_gen_op5(opc, tcgv_i64_arg(a1), tcgv_i64_arg(a2),
+                tcgv_i64_arg(a3), tcgv_i64_arg(a4), tcgv_i64_arg(a5));
+}
+
+void DNI tcg_gen_op5i_i32(TCGOpcode opc, TCGv_i32 a1, TCGv_i32 a2,
+                          TCGv_i32 a3, TCGv_i32 a4, TCGArg a5)
+{
+    tcg_gen_op5(opc, tcgv_i32_arg(a1), tcgv_i32_arg(a2),
+                tcgv_i32_arg(a3), tcgv_i32_arg(a4), a5);
+}
+
+void DNI tcg_gen_op5i_i64(TCGOpcode opc, TCGv_i64 a1, TCGv_i64 a2,
+                          TCGv_i64 a3, TCGv_i64 a4, TCGArg a5)
+{
+    tcg_gen_op5(opc, tcgv_i64_arg(a1), tcgv_i64_arg(a2),
+                tcgv_i64_arg(a3), tcgv_i64_arg(a4), a5);
+}
+
+void DNI tcg_gen_op5ii_i32(TCGOpcode opc, TCGv_i32 a1, TCGv_i32 a2,
+                           TCGv_i32 a3, TCGArg a4, TCGArg a5)
+{
+    tcg_gen_op5(opc, tcgv_i32_arg(a1), tcgv_i32_arg(a2),
+                tcgv_i32_arg(a3), a4, a5);
+}
+
+void DNI tcg_gen_op5ii_i64(TCGOpcode opc, TCGv_i64 a1, TCGv_i64 a2,
+                           TCGv_i64 a3, TCGArg a4, TCGArg a5)
+{
+    tcg_gen_op5(opc, tcgv_i64_arg(a1), tcgv_i64_arg(a2),
+                tcgv_i64_arg(a3), a4, a5);
+}
+
+void DNI tcg_gen_op6_i32(TCGOpcode opc, TCGv_i32 a1, TCGv_i32 a2, TCGv_i32 a3,
+                         TCGv_i32 a4, TCGv_i32 a5, TCGv_i32 a6)
+{
+    tcg_gen_op6(opc, tcgv_i32_arg(a1), tcgv_i32_arg(a2),
+                tcgv_i32_arg(a3), tcgv_i32_arg(a4), tcgv_i32_arg(a5),
+                tcgv_i32_arg(a6));
+}
+
+void DNI tcg_gen_op6_i64(TCGOpcode opc, TCGv_i64 a1, TCGv_i64 a2, TCGv_i64 a3,
+                         TCGv_i64 a4, TCGv_i64 a5, TCGv_i64 a6)
+{
+    tcg_gen_op6(opc, tcgv_i64_arg(a1), tcgv_i64_arg(a2),
+                tcgv_i64_arg(a3), tcgv_i64_arg(a4), tcgv_i64_arg(a5),
+                tcgv_i64_arg(a6));
+}
+
+void DNI tcg_gen_op6i_i32(TCGOpcode opc, TCGv_i32 a1, TCGv_i32 a2, TCGv_i32 a3,
+                          TCGv_i32 a4, TCGv_i32 a5, TCGArg a6)
+{
+    tcg_gen_op6(opc, tcgv_i32_arg(a1), tcgv_i32_arg(a2),
+                tcgv_i32_arg(a3), tcgv_i32_arg(a4), tcgv_i32_arg(a5), a6);
+}
+
+void DNI tcg_gen_op6i_i64(TCGOpcode opc, TCGv_i64 a1, TCGv_i64 a2, TCGv_i64 a3,
+                          TCGv_i64 a4, TCGv_i64 a5, TCGArg a6)
+{
+    tcg_gen_op6(opc, tcgv_i64_arg(a1), tcgv_i64_arg(a2),
+                tcgv_i64_arg(a3), tcgv_i64_arg(a4), tcgv_i64_arg(a5), a6);
+}
+
+void DNI tcg_gen_op6ii_i32(TCGOpcode opc, TCGv_i32 a1, TCGv_i32 a2,
+                           TCGv_i32 a3, TCGv_i32 a4, TCGArg a5, TCGArg a6)
+{
+    tcg_gen_op6(opc, tcgv_i32_arg(a1), tcgv_i32_arg(a2),
+                tcgv_i32_arg(a3), tcgv_i32_arg(a4), a5, a6);
+}
+
+void DNI tcg_gen_op6ii_i64(TCGOpcode opc, TCGv_i64 a1, TCGv_i64 a2,
+                           TCGv_i64 a3, TCGv_i64 a4, TCGArg a5, TCGArg a6)
+{
+    tcg_gen_op6(opc, tcgv_i64_arg(a1), tcgv_i64_arg(a2),
+                tcgv_i64_arg(a3), tcgv_i64_arg(a4), a5, a6);
+}
+
 /* Generic ops.  */
 
 static void add_last_as_label_use(TCGLabel *l)
-- 
2.34.1



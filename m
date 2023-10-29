Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 361397DAE6B
	for <lists+qemu-devel@lfdr.de>; Sun, 29 Oct 2023 22:10:46 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qxD1o-0002fX-4u; Sun, 29 Oct 2023 17:09:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qxD1l-0002eR-D2
 for qemu-devel@nongnu.org; Sun, 29 Oct 2023 17:08:57 -0400
Received: from mail-pf1-x434.google.com ([2607:f8b0:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qxD1h-0005Da-OE
 for qemu-devel@nongnu.org; Sun, 29 Oct 2023 17:08:56 -0400
Received: by mail-pf1-x434.google.com with SMTP id
 d2e1a72fcca58-6be1bc5aa1cso3796210b3a.3
 for <qemu-devel@nongnu.org>; Sun, 29 Oct 2023 14:08:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698613732; x=1699218532; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=oVIbFyLpWxCmMjgoFisZSPckJtsGtfTXECPoTK2Q+a4=;
 b=RSKF5VmPDIEfSIEKSDm26Pqf7axdvBHdFp+qen128wJ1BxVR5SefsaNyumzBDeGHjF
 5SSuprmSPndMC+we1wrRKH1eIRhcTO8Ca224/yDb/xyimcFP6Tz5WxyGGJvMOmIcUXk4
 ANBkYe3HHNxTJAoylxZSK3Jl3qBLqLmI8ilGn6cvDLMG0h9lXa1dlk8kFabG89230pZM
 GIvoeFEqyYmiu2C0vZaoWdnNsJ+KbS+WmIUsb/sVzIE5zajJHi4R5Tuf+OV+zlTcoj5k
 uJfYROGfV9lMUtGSmowBPO/ONKmmpXNXX5d1WpCnJNlNPKqL8EmoXacuk2+mt3QTk788
 kgMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698613732; x=1699218532;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=oVIbFyLpWxCmMjgoFisZSPckJtsGtfTXECPoTK2Q+a4=;
 b=QRsGdY9niZPotp/qeOavvWQ/w7QPeKb0K1LyzlfTA2Z037FUZoGrfTjwkJqMIVx8r5
 9raHGmxVXkeCEdLguX4KY9WAKA3ZkHjBKHwX9F5N0HKCO3nzzP0lGlsnB8HXtFUhuCN0
 Pz8PlqbwjDGcrCzyJuNxRn72xMeR4+BQzkyiMzuIRic0WpMdk4YVyXUNfnFvkSCZll1a
 TSlbTI+5qMuyBFqpkter6rlx5+0T7V0BcWWE4m7Xokui3To8d1fCZ+Ue7b4162JtkAR8
 2ATRqlacevC/+T7E8AoLv0RA2lD1yNr7mPNksal3yalz0tejS+o5KbZ/QFGZpdjrTauc
 EXuQ==
X-Gm-Message-State: AOJu0YxD4x2kI1Ot0KN6xeisdYZTjl/VKs72tgsJN925mQq98Tf+dLIR
 HcyLWW+G99+08m20lRvf5aetx6L40eoE9hXZiqk=
X-Google-Smtp-Source: AGHT+IFkYRuyr59tyRAmV9S/WUCSHg5y+bEBl9rxMtWj9pvdExKaxf1JQYuhhRyayjeOgCd+yxppqg==
X-Received: by 2002:a05:6a00:10ca:b0:6bd:4ab7:5f69 with SMTP id
 d10-20020a056a0010ca00b006bd4ab75f69mr9613778pfu.12.1698613732310; 
 Sun, 29 Oct 2023 14:08:52 -0700 (PDT)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 z11-20020aa785cb000000b006c0685422e0sm4622847pfn.214.2023.10.29.14.08.51
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 29 Oct 2023 14:08:51 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 02/11] tcg: Move tcg_gen_op* out of line
Date: Sun, 29 Oct 2023 14:08:39 -0700
Message-Id: <20231029210848.78234-3-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231029210848.78234-1-richard.henderson@linaro.org>
References: <20231029210848.78234-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::434;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x434.google.com
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

In addition to moving out of line, with CONFIG_DEBUG_TCG
mark them all noinline.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
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



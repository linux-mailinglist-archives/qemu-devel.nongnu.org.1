Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B02E7DAE6D
	for <lists+qemu-devel@lfdr.de>; Sun, 29 Oct 2023 22:10:48 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qxD1v-0002iY-0y; Sun, 29 Oct 2023 17:09:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qxD1r-0002gg-6e
 for qemu-devel@nongnu.org; Sun, 29 Oct 2023 17:09:03 -0400
Received: from mail-pf1-x42a.google.com ([2607:f8b0:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qxD1m-0005Ew-Sy
 for qemu-devel@nongnu.org; Sun, 29 Oct 2023 17:09:02 -0400
Received: by mail-pf1-x42a.google.com with SMTP id
 d2e1a72fcca58-6b1e46ca282so3830030b3a.2
 for <qemu-devel@nongnu.org>; Sun, 29 Oct 2023 14:08:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698613737; x=1699218537; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=Bji9OxCCyBTSn/lKBqh6E2f72DMN/kQZqOnQddcdBLs=;
 b=oapf5rja0HfqwSGAL1eMwIJjfwP2nUl6t7rzlwbl8Nj2k+85p/c/JGCL2GO/ElN7zO
 4/OBbzPzNfE7rp4041W8HxjTd+qAGEAt3+Udqwy1N4VunNGcN781nFKltG+eDx5QfXoE
 FHJG41gf0UMPI3+hbdPQr7I3u3daaLq5wKHkQuYrzv7iwHAUvSQzAXe+UQHlVwFlvkDW
 zu27GwWoYZDrVwBA5mXs3EKwHOkKJlyrWNxuGRZ6xEq6Ic8biAWEfgIc9ORgjmvqJGni
 HimtPPCuJO6m4fqkg+81Ma+gT596xG4JsOSOqHUKv/BXsHS3rKow1XAXUCXLxgfxbqUs
 tZ2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698613737; x=1699218537;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Bji9OxCCyBTSn/lKBqh6E2f72DMN/kQZqOnQddcdBLs=;
 b=jod2MT/4iTaAcBnUwHrO14NzcGmw1jjPHs4Lpb3DkYjgpQvun7FEncKBL02Bb8mpON
 0DtKyeo6r5xFyZu0fOvXcdq2vKIxypqu1VUgg5qU8JjATz11Vj5LuNza2CdCs67YT20J
 coGcNFS4S4SK6VRN4KGSHmgrLhaqMpNmZdAjDxQVY2HFSZWaU/xYkSGXnlFTDlgN+1uR
 mBZAruJl8DHpp3hrVeh+N11fD44uSRBv5HvFApCFl9bB7aiEEJow9m0Q63N6HU69VtS7
 wIBbru9SuS19Y4sfhPlhHSTjkcDzoq838VPfV2aoC7tAiOF7DqrRr+wNEMI0rO3fD1fA
 qTJw==
X-Gm-Message-State: AOJu0Yy1/kDXZkz7XoYQkqO3BBJKEQMg2jfJ9cqqDZbt906vhiUVAeS6
 wB0mZp69h0CtrWlNnRyOVv8ryen2N/MHL/FDEnU=
X-Google-Smtp-Source: AGHT+IHtcLysilL5MRgUk1IAHTgAR4EjMd1YM9yX6TQ3Q/u3o3/R4Efq5BkpAHIkP7K2smJijHCwCQ==
X-Received: by 2002:a05:6a00:23c6:b0:68f:c7c5:a73a with SMTP id
 g6-20020a056a0023c600b0068fc7c5a73amr11063743pfc.16.1698613737405; 
 Sun, 29 Oct 2023 14:08:57 -0700 (PDT)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 z11-20020aa785cb000000b006c0685422e0sm4622847pfn.214.2023.10.29.14.08.56
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 29 Oct 2023 14:08:57 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 08/11] tcg: Unexport tcg_gen_op*_{i32,i64}
Date: Sun, 29 Oct 2023 14:08:45 -0700
Message-Id: <20231029210848.78234-9-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231029210848.78234-1-richard.henderson@linaro.org>
References: <20231029210848.78234-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42a;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42a.google.com
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

These functions are no longer used outside tcg-op.c.
There are several that are completely unused, so remove them.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/tcg/tcg-op-common.h |  47 -------------
 tcg/tcg-op.c                | 131 ++++++++++++++----------------------
 2 files changed, 52 insertions(+), 126 deletions(-)

diff --git a/include/tcg/tcg-op-common.h b/include/tcg/tcg-op-common.h
index b922545118..760c67683b 100644
--- a/include/tcg/tcg-op-common.h
+++ b/include/tcg/tcg-op-common.h
@@ -12,53 +12,6 @@
 #include "exec/helper-proto-common.h"
 #include "exec/helper-gen-common.h"
 
-/* Basic output routines.  Not for general consumption.  */
-
-void tcg_gen_op1_i32(TCGOpcode, TCGv_i32);
-void tcg_gen_op1_i64(TCGOpcode, TCGv_i64);
-void tcg_gen_op1i(TCGOpcode, TCGArg);
-void tcg_gen_op2_i32(TCGOpcode, TCGv_i32, TCGv_i32);
-void tcg_gen_op2_i64(TCGOpcode, TCGv_i64, TCGv_i64);
-void tcg_gen_op2i_i32(TCGOpcode, TCGv_i32, TCGArg);
-void tcg_gen_op2i_i64(TCGOpcode, TCGv_i64, TCGArg);
-void tcg_gen_op2ii(TCGOpcode, TCGArg, TCGArg);
-void tcg_gen_op3_i32(TCGOpcode, TCGv_i32, TCGv_i32, TCGv_i32);
-void tcg_gen_op3_i64(TCGOpcode, TCGv_i64, TCGv_i64, TCGv_i64);
-void tcg_gen_op3i_i32(TCGOpcode, TCGv_i32, TCGv_i32, TCGArg);
-void tcg_gen_op3i_i64(TCGOpcode, TCGv_i64, TCGv_i64, TCGArg);
-void tcg_gen_ldst_op_i32(TCGOpcode, TCGv_i32, TCGv_ptr, TCGArg);
-void tcg_gen_ldst_op_i64(TCGOpcode, TCGv_i64, TCGv_ptr, TCGArg);
-void tcg_gen_op4_i32(TCGOpcode, TCGv_i32, TCGv_i32, TCGv_i32, TCGv_i32);
-void tcg_gen_op4_i64(TCGOpcode, TCGv_i64, TCGv_i64, TCGv_i64, TCGv_i64);
-void tcg_gen_op4i_i32(TCGOpcode, TCGv_i32, TCGv_i32, TCGv_i32, TCGArg);
-void tcg_gen_op4i_i64(TCGOpcode, TCGv_i64, TCGv_i64, TCGv_i64, TCGArg);
-void tcg_gen_op4ii_i32(TCGOpcode, TCGv_i32, TCGv_i32, TCGArg, TCGArg);
-void tcg_gen_op4ii_i64(TCGOpcode, TCGv_i64, TCGv_i64, TCGArg, TCGArg);
-void tcg_gen_op5_i32(TCGOpcode, TCGv_i32, TCGv_i32, TCGv_i32,
-                     TCGv_i32, TCGv_i32);
-void tcg_gen_op5_i64(TCGOpcode, TCGv_i64, TCGv_i64, TCGv_i64,
-                     TCGv_i64, TCGv_i64);
-void tcg_gen_op5i_i32(TCGOpcode, TCGv_i32, TCGv_i32, TCGv_i32,
-                      TCGv_i32, TCGArg);
-void tcg_gen_op5i_i64(TCGOpcode, TCGv_i64, TCGv_i64, TCGv_i64,
-                      TCGv_i64, TCGArg);
-void tcg_gen_op5ii_i32(TCGOpcode, TCGv_i32, TCGv_i32, TCGv_i32,
-                       TCGArg, TCGArg);
-void tcg_gen_op5ii_i64(TCGOpcode, TCGv_i64, TCGv_i64, TCGv_i64,
-                       TCGArg, TCGArg);
-void tcg_gen_op6_i32(TCGOpcode, TCGv_i32, TCGv_i32, TCGv_i32,
-                     TCGv_i32, TCGv_i32, TCGv_i32);
-void tcg_gen_op6_i64(TCGOpcode, TCGv_i64, TCGv_i64, TCGv_i64,
-                     TCGv_i64, TCGv_i64, TCGv_i64);
-void tcg_gen_op6i_i32(TCGOpcode, TCGv_i32, TCGv_i32, TCGv_i32,
-                      TCGv_i32, TCGv_i32, TCGArg);
-void tcg_gen_op6i_i64(TCGOpcode, TCGv_i64, TCGv_i64, TCGv_i64,
-                      TCGv_i64, TCGv_i64, TCGArg);
-void tcg_gen_op6ii_i32(TCGOpcode, TCGv_i32, TCGv_i32, TCGv_i32,
-                       TCGv_i32, TCGArg, TCGArg);
-void tcg_gen_op6ii_i64(TCGOpcode, TCGv_i64, TCGv_i64, TCGv_i64,
-                       TCGv_i64, TCGArg, TCGArg);
-
 /* Generic ops.  */
 
 void gen_set_label(TCGLabel *l);
diff --git a/tcg/tcg-op.c b/tcg/tcg-op.c
index 579a2aab15..9aba103590 100644
--- a/tcg/tcg-op.c
+++ b/tcg/tcg-op.c
@@ -100,204 +100,177 @@ void NI tcg_gen_op6(TCGOpcode opc, TCGArg a1, TCGArg a2, TCGArg a3,
 # define DNI
 #endif
 
-void DNI tcg_gen_op1_i32(TCGOpcode opc, TCGv_i32 a1)
+static void DNI tcg_gen_op1_i32(TCGOpcode opc, TCGv_i32 a1)
 {
     tcg_gen_op1(opc, tcgv_i32_arg(a1));
 }
 
-void DNI tcg_gen_op1_i64(TCGOpcode opc, TCGv_i64 a1)
+static void DNI tcg_gen_op1_i64(TCGOpcode opc, TCGv_i64 a1)
 {
     tcg_gen_op1(opc, tcgv_i64_arg(a1));
 }
 
-void DNI tcg_gen_op1i(TCGOpcode opc, TCGArg a1)
+static void DNI tcg_gen_op1i(TCGOpcode opc, TCGArg a1)
 {
     tcg_gen_op1(opc, a1);
 }
 
-void DNI tcg_gen_op2_i32(TCGOpcode opc, TCGv_i32 a1, TCGv_i32 a2)
+static void DNI tcg_gen_op2_i32(TCGOpcode opc, TCGv_i32 a1, TCGv_i32 a2)
 {
     tcg_gen_op2(opc, tcgv_i32_arg(a1), tcgv_i32_arg(a2));
 }
 
-void DNI tcg_gen_op2_i64(TCGOpcode opc, TCGv_i64 a1, TCGv_i64 a2)
+static void DNI tcg_gen_op2_i64(TCGOpcode opc, TCGv_i64 a1, TCGv_i64 a2)
 {
     tcg_gen_op2(opc, tcgv_i64_arg(a1), tcgv_i64_arg(a2));
 }
 
-void DNI tcg_gen_op2i_i32(TCGOpcode opc, TCGv_i32 a1, TCGArg a2)
-{
-    tcg_gen_op2(opc, tcgv_i32_arg(a1), a2);
-}
-
-void DNI tcg_gen_op2i_i64(TCGOpcode opc, TCGv_i64 a1, TCGArg a2)
-{
-    tcg_gen_op2(opc, tcgv_i64_arg(a1), a2);
-}
-
-void DNI tcg_gen_op2ii(TCGOpcode opc, TCGArg a1, TCGArg a2)
-{
-    tcg_gen_op2(opc, a1, a2);
-}
-
-void DNI tcg_gen_op3_i32(TCGOpcode opc, TCGv_i32 a1, TCGv_i32 a2, TCGv_i32 a3)
+static void DNI tcg_gen_op3_i32(TCGOpcode opc, TCGv_i32 a1,
+                                TCGv_i32 a2, TCGv_i32 a3)
 {
     tcg_gen_op3(opc, tcgv_i32_arg(a1), tcgv_i32_arg(a2), tcgv_i32_arg(a3));
 }
 
-void DNI tcg_gen_op3_i64(TCGOpcode opc, TCGv_i64 a1, TCGv_i64 a2, TCGv_i64 a3)
+static void DNI tcg_gen_op3_i64(TCGOpcode opc, TCGv_i64 a1,
+                                TCGv_i64 a2, TCGv_i64 a3)
 {
     tcg_gen_op3(opc, tcgv_i64_arg(a1), tcgv_i64_arg(a2), tcgv_i64_arg(a3));
 }
 
-void DNI tcg_gen_op3i_i32(TCGOpcode opc, TCGv_i32 a1, TCGv_i32 a2, TCGArg a3)
+static void DNI tcg_gen_op3i_i32(TCGOpcode opc, TCGv_i32 a1,
+                                 TCGv_i32 a2, TCGArg a3)
 {
     tcg_gen_op3(opc, tcgv_i32_arg(a1), tcgv_i32_arg(a2), a3);
 }
 
-void DNI tcg_gen_op3i_i64(TCGOpcode opc, TCGv_i64 a1, TCGv_i64 a2, TCGArg a3)
+static void DNI tcg_gen_op3i_i64(TCGOpcode opc, TCGv_i64 a1,
+                                 TCGv_i64 a2, TCGArg a3)
 {
     tcg_gen_op3(opc, tcgv_i64_arg(a1), tcgv_i64_arg(a2), a3);
 }
 
-void DNI tcg_gen_ldst_op_i32(TCGOpcode opc, TCGv_i32 val,
-                             TCGv_ptr base, TCGArg offset)
+static void DNI tcg_gen_ldst_op_i32(TCGOpcode opc, TCGv_i32 val,
+                                    TCGv_ptr base, TCGArg offset)
 {
     tcg_gen_op3(opc, tcgv_i32_arg(val), tcgv_ptr_arg(base), offset);
 }
 
-void DNI tcg_gen_ldst_op_i64(TCGOpcode opc, TCGv_i64 val,
-                             TCGv_ptr base, TCGArg offset)
+static void DNI tcg_gen_ldst_op_i64(TCGOpcode opc, TCGv_i64 val,
+                                    TCGv_ptr base, TCGArg offset)
 {
     tcg_gen_op3(opc, tcgv_i64_arg(val), tcgv_ptr_arg(base), offset);
 }
 
-void DNI tcg_gen_op4_i32(TCGOpcode opc, TCGv_i32 a1, TCGv_i32 a2,
-                         TCGv_i32 a3, TCGv_i32 a4)
+static void DNI tcg_gen_op4_i32(TCGOpcode opc, TCGv_i32 a1, TCGv_i32 a2,
+                                TCGv_i32 a3, TCGv_i32 a4)
 {
     tcg_gen_op4(opc, tcgv_i32_arg(a1), tcgv_i32_arg(a2),
                 tcgv_i32_arg(a3), tcgv_i32_arg(a4));
 }
 
-void DNI tcg_gen_op4_i64(TCGOpcode opc, TCGv_i64 a1, TCGv_i64 a2,
-                         TCGv_i64 a3, TCGv_i64 a4)
+static void DNI tcg_gen_op4_i64(TCGOpcode opc, TCGv_i64 a1, TCGv_i64 a2,
+                                TCGv_i64 a3, TCGv_i64 a4)
 {
     tcg_gen_op4(opc, tcgv_i64_arg(a1), tcgv_i64_arg(a2),
                 tcgv_i64_arg(a3), tcgv_i64_arg(a4));
 }
 
-void DNI tcg_gen_op4i_i32(TCGOpcode opc, TCGv_i32 a1, TCGv_i32 a2,
-                          TCGv_i32 a3, TCGArg a4)
+static void DNI tcg_gen_op4i_i32(TCGOpcode opc, TCGv_i32 a1, TCGv_i32 a2,
+                                 TCGv_i32 a3, TCGArg a4)
 {
     tcg_gen_op4(opc, tcgv_i32_arg(a1), tcgv_i32_arg(a2),
                 tcgv_i32_arg(a3), a4);
 }
 
-void DNI tcg_gen_op4i_i64(TCGOpcode opc, TCGv_i64 a1, TCGv_i64 a2,
-                          TCGv_i64 a3, TCGArg a4)
+static void DNI tcg_gen_op4i_i64(TCGOpcode opc, TCGv_i64 a1, TCGv_i64 a2,
+                                 TCGv_i64 a3, TCGArg a4)
 {
     tcg_gen_op4(opc, tcgv_i64_arg(a1), tcgv_i64_arg(a2),
                 tcgv_i64_arg(a3), a4);
 }
 
-void DNI tcg_gen_op4ii_i32(TCGOpcode opc, TCGv_i32 a1, TCGv_i32 a2,
-                           TCGArg a3, TCGArg a4)
+static void DNI tcg_gen_op4ii_i32(TCGOpcode opc, TCGv_i32 a1, TCGv_i32 a2,
+                                  TCGArg a3, TCGArg a4)
 {
     tcg_gen_op4(opc, tcgv_i32_arg(a1), tcgv_i32_arg(a2), a3, a4);
 }
 
-void DNI tcg_gen_op4ii_i64(TCGOpcode opc, TCGv_i64 a1, TCGv_i64 a2,
-                           TCGArg a3, TCGArg a4)
+static void DNI tcg_gen_op4ii_i64(TCGOpcode opc, TCGv_i64 a1, TCGv_i64 a2,
+                                  TCGArg a3, TCGArg a4)
 {
     tcg_gen_op4(opc, tcgv_i64_arg(a1), tcgv_i64_arg(a2), a3, a4);
 }
 
-void DNI tcg_gen_op5_i32(TCGOpcode opc, TCGv_i32 a1, TCGv_i32 a2,
-                         TCGv_i32 a3, TCGv_i32 a4, TCGv_i32 a5)
+static void DNI tcg_gen_op5_i32(TCGOpcode opc, TCGv_i32 a1, TCGv_i32 a2,
+                                TCGv_i32 a3, TCGv_i32 a4, TCGv_i32 a5)
 {
     tcg_gen_op5(opc, tcgv_i32_arg(a1), tcgv_i32_arg(a2),
                 tcgv_i32_arg(a3), tcgv_i32_arg(a4), tcgv_i32_arg(a5));
 }
 
-void DNI tcg_gen_op5_i64(TCGOpcode opc, TCGv_i64 a1, TCGv_i64 a2,
-                         TCGv_i64 a3, TCGv_i64 a4, TCGv_i64 a5)
+static void DNI tcg_gen_op5_i64(TCGOpcode opc, TCGv_i64 a1, TCGv_i64 a2,
+                                TCGv_i64 a3, TCGv_i64 a4, TCGv_i64 a5)
 {
     tcg_gen_op5(opc, tcgv_i64_arg(a1), tcgv_i64_arg(a2),
                 tcgv_i64_arg(a3), tcgv_i64_arg(a4), tcgv_i64_arg(a5));
 }
 
-void DNI tcg_gen_op5i_i32(TCGOpcode opc, TCGv_i32 a1, TCGv_i32 a2,
-                          TCGv_i32 a3, TCGv_i32 a4, TCGArg a5)
-{
-    tcg_gen_op5(opc, tcgv_i32_arg(a1), tcgv_i32_arg(a2),
-                tcgv_i32_arg(a3), tcgv_i32_arg(a4), a5);
-}
-
-void DNI tcg_gen_op5i_i64(TCGOpcode opc, TCGv_i64 a1, TCGv_i64 a2,
-                          TCGv_i64 a3, TCGv_i64 a4, TCGArg a5)
-{
-    tcg_gen_op5(opc, tcgv_i64_arg(a1), tcgv_i64_arg(a2),
-                tcgv_i64_arg(a3), tcgv_i64_arg(a4), a5);
-}
-
-void DNI tcg_gen_op5ii_i32(TCGOpcode opc, TCGv_i32 a1, TCGv_i32 a2,
-                           TCGv_i32 a3, TCGArg a4, TCGArg a5)
+static void DNI tcg_gen_op5ii_i32(TCGOpcode opc, TCGv_i32 a1, TCGv_i32 a2,
+                                  TCGv_i32 a3, TCGArg a4, TCGArg a5)
 {
     tcg_gen_op5(opc, tcgv_i32_arg(a1), tcgv_i32_arg(a2),
                 tcgv_i32_arg(a3), a4, a5);
 }
 
-void DNI tcg_gen_op5ii_i64(TCGOpcode opc, TCGv_i64 a1, TCGv_i64 a2,
-                           TCGv_i64 a3, TCGArg a4, TCGArg a5)
+static void DNI tcg_gen_op5ii_i64(TCGOpcode opc, TCGv_i64 a1, TCGv_i64 a2,
+                                  TCGv_i64 a3, TCGArg a4, TCGArg a5)
 {
     tcg_gen_op5(opc, tcgv_i64_arg(a1), tcgv_i64_arg(a2),
                 tcgv_i64_arg(a3), a4, a5);
 }
 
-void DNI tcg_gen_op6_i32(TCGOpcode opc, TCGv_i32 a1, TCGv_i32 a2, TCGv_i32 a3,
-                         TCGv_i32 a4, TCGv_i32 a5, TCGv_i32 a6)
+static void DNI tcg_gen_op6_i32(TCGOpcode opc, TCGv_i32 a1, TCGv_i32 a2,
+                                TCGv_i32 a3, TCGv_i32 a4,
+                                TCGv_i32 a5, TCGv_i32 a6)
 {
     tcg_gen_op6(opc, tcgv_i32_arg(a1), tcgv_i32_arg(a2),
                 tcgv_i32_arg(a3), tcgv_i32_arg(a4), tcgv_i32_arg(a5),
                 tcgv_i32_arg(a6));
 }
 
-void DNI tcg_gen_op6_i64(TCGOpcode opc, TCGv_i64 a1, TCGv_i64 a2, TCGv_i64 a3,
-                         TCGv_i64 a4, TCGv_i64 a5, TCGv_i64 a6)
+static void DNI tcg_gen_op6_i64(TCGOpcode opc, TCGv_i64 a1, TCGv_i64 a2,
+                                TCGv_i64 a3, TCGv_i64 a4,
+                                TCGv_i64 a5, TCGv_i64 a6)
 {
     tcg_gen_op6(opc, tcgv_i64_arg(a1), tcgv_i64_arg(a2),
                 tcgv_i64_arg(a3), tcgv_i64_arg(a4), tcgv_i64_arg(a5),
                 tcgv_i64_arg(a6));
 }
 
-void DNI tcg_gen_op6i_i32(TCGOpcode opc, TCGv_i32 a1, TCGv_i32 a2, TCGv_i32 a3,
-                          TCGv_i32 a4, TCGv_i32 a5, TCGArg a6)
+static void DNI tcg_gen_op6i_i32(TCGOpcode opc, TCGv_i32 a1, TCGv_i32 a2,
+                                 TCGv_i32 a3, TCGv_i32 a4,
+                                 TCGv_i32 a5, TCGArg a6)
 {
     tcg_gen_op6(opc, tcgv_i32_arg(a1), tcgv_i32_arg(a2),
                 tcgv_i32_arg(a3), tcgv_i32_arg(a4), tcgv_i32_arg(a5), a6);
 }
 
-void DNI tcg_gen_op6i_i64(TCGOpcode opc, TCGv_i64 a1, TCGv_i64 a2, TCGv_i64 a3,
-                          TCGv_i64 a4, TCGv_i64 a5, TCGArg a6)
+static void DNI tcg_gen_op6i_i64(TCGOpcode opc, TCGv_i64 a1, TCGv_i64 a2,
+                                 TCGv_i64 a3, TCGv_i64 a4,
+                                 TCGv_i64 a5, TCGArg a6)
 {
     tcg_gen_op6(opc, tcgv_i64_arg(a1), tcgv_i64_arg(a2),
                 tcgv_i64_arg(a3), tcgv_i64_arg(a4), tcgv_i64_arg(a5), a6);
 }
 
-void DNI tcg_gen_op6ii_i32(TCGOpcode opc, TCGv_i32 a1, TCGv_i32 a2,
-                           TCGv_i32 a3, TCGv_i32 a4, TCGArg a5, TCGArg a6)
+static void DNI tcg_gen_op6ii_i32(TCGOpcode opc, TCGv_i32 a1, TCGv_i32 a2,
+                                  TCGv_i32 a3, TCGv_i32 a4,
+                                  TCGArg a5, TCGArg a6)
 {
     tcg_gen_op6(opc, tcgv_i32_arg(a1), tcgv_i32_arg(a2),
                 tcgv_i32_arg(a3), tcgv_i32_arg(a4), a5, a6);
 }
 
-void DNI tcg_gen_op6ii_i64(TCGOpcode opc, TCGv_i64 a1, TCGv_i64 a2,
-                           TCGv_i64 a3, TCGv_i64 a4, TCGArg a5, TCGArg a6)
-{
-    tcg_gen_op6(opc, tcgv_i64_arg(a1), tcgv_i64_arg(a2),
-                tcgv_i64_arg(a3), tcgv_i64_arg(a4), a5, a6);
-}
-
 /* Generic ops.  */
 
 void gen_set_label(TCGLabel *l)
-- 
2.34.1



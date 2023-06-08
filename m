Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DA61728113
	for <lists+qemu-devel@lfdr.de>; Thu,  8 Jun 2023 15:19:13 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q7FWt-0003bH-RK; Thu, 08 Jun 2023 09:18:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lis8215@gmail.com>) id 1q7D6i-0002VR-4o
 for qemu-devel@nongnu.org; Thu, 08 Jun 2023 06:43:08 -0400
Received: from mail-lf1-x129.google.com ([2a00:1450:4864:20::129])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <lis8215@gmail.com>) id 1q7D6e-0006gO-7e
 for qemu-devel@nongnu.org; Thu, 08 Jun 2023 06:43:07 -0400
Received: by mail-lf1-x129.google.com with SMTP id
 2adb3069b0e04-4f629ccb8ebso559095e87.1
 for <qemu-devel@nongnu.org>; Thu, 08 Jun 2023 03:43:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1686220980; x=1688812980;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cIjPf2GjJew6g+tPGECmJIjJsK9iEsbIjnw3YFF23EE=;
 b=TSCw1NSzBvd9nZzzFTAiW9lRLDE3rEL9Ao0QINLEhq0Qx11q5ND/ZYWCR/j9OceKhC
 DzR2KNdMmCUi9/0krSv1CWEWqgouFBhs8vk9Zl8t57slDqdZeBsbin+mzZ6R0MXHAUkl
 QSN2D81/WFAiqZpsqRVAqdPYCfMF25DqXwoExQuNle7jaRrZE0XxOyL1pFWfHjpIz+i4
 idPFfSjNBIpq1fDLwFOZsJAWTzdjpKgCvAhgbLAk1uwhbeRuXuaST5WaCOAYkWq26Q09
 0tgPC+O1FcfkFsPt3OLXMGQ2hoer8U2+j8dXPesdLLl7c1mJr8CjkP7F1j5lBLL/LOl0
 +kGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686220980; x=1688812980;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=cIjPf2GjJew6g+tPGECmJIjJsK9iEsbIjnw3YFF23EE=;
 b=C9FK0QS67vhb6E+/s6LqU6Oy7LQs7bkEUbhl33A1nv4EMq3cynOC0jeEgbizU0qiye
 f9+eqDFSfy+Ftc6BQef0IQ04+gV8enUwj+xMdIUl/ZMCcP9/hrWcQr6RDBZz1XLsHiC8
 XrZwohMPO+GaYLI7oVLNe/ebdnW25qzvhmOlH7kh6JmmYkUZVWvarIgFUG/SDLqrTqtu
 BnMmme2Z+IQC2hJ1K2l9V5jeEivdM+JsnvCDEE9I9yT+BHZGz2mpuI+geWxYw75ELOFq
 fqHXluq9L2KZuaaE0Dz8GLXltYwj93f1U159c7yiK5VZejx+oeQqnVhNvvV8ingOxijV
 sqBA==
X-Gm-Message-State: AC+VfDyafTFu5FVgrOHr0YV7zP1d/E9Z1c6E6spRIz297SZnvuuZavjW
 QTJc3n726qcJKcvYQ302Qlx0I/raEi0=
X-Google-Smtp-Source: ACHHUZ62fgZvbJMumnggT9QCtC5C7gRO9qY3nn7ox1+g2Oakr++A8B/Py6QslwQYBQrdWhtK1J9DEQ==
X-Received: by 2002:ac2:54ae:0:b0:4f2:40dd:e2cf with SMTP id
 w14-20020ac254ae000000b004f240dde2cfmr3112047lfk.55.1686220980517; 
 Thu, 08 Jun 2023 03:43:00 -0700 (PDT)
Received: from hp-power-15.localdomain (78-62-135-63.static.zebra.lt.
 [78.62.135.63]) by smtp.gmail.com with ESMTPSA id
 w7-20020ac24427000000b004f3945751b2sm142632lfl.43.2023.06.08.03.42.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 08 Jun 2023 03:43:00 -0700 (PDT)
From: Siarhei Volkau <lis8215@gmail.com>
To: qemu-devel@nongnu.org
Cc: Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Aurelien Jarno <aurelien@aurel32.net>,
 Stefan Markovic <smarkovic@wavecomp.com>,
 Aleksandar Markovic <amarkovic@wavecomp.com>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, Siarhei Volkau <lis8215@gmail.com>
Subject: [PATCH 33/33] target/mips: Add emulation of MXU Q8SAD instruction
Date: Thu,  8 Jun 2023 13:42:22 +0300
Message-Id: <20230608104222.1520143-34-lis8215@gmail.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230608104222.1520143-1-lis8215@gmail.com>
References: <20230608104222.1520143-1-lis8215@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::129;
 envelope-from=lis8215@gmail.com; helo=mail-lf1-x129.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Thu, 08 Jun 2023 09:17:53 -0400
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

The instruction implements SAD (sum-absolute-difference) operation which
is used in motion estimation algorithms. The instruction handles four
8-bit data in parallel.

Signed-off-by: Siarhei Volkau <lis8215@gmail.com>
---
 target/mips/tcg/mxu_translate.c | 45 +++++++++++++++++++++++++++++++++
 1 file changed, 45 insertions(+)

diff --git a/target/mips/tcg/mxu_translate.c b/target/mips/tcg/mxu_translate.c
index 1e043908db..67a19c7284 100644
--- a/target/mips/tcg/mxu_translate.c
+++ b/target/mips/tcg/mxu_translate.c
@@ -410,6 +410,7 @@ enum {
     OPC_MXU_Q16SCOP  = 0x3B,
     OPC_MXU_Q8MADL   = 0x3C,
     OPC_MXU_S32SFL   = 0x3D,
+    OPC_MXU_Q8SAD    = 0x3E,
 };
 
 
@@ -4041,6 +4042,47 @@ static void gen_mxu_s32sfl(DisasContext *ctx)
     gen_store_mxu_gpr(t3, XRd);
 }
 
+/*
+ *  Q8SAD XRa, XRd, XRb, XRc
+ *    Typical SAD opration for motion estimation.
+ */
+static void gen_mxu_q8sad(DisasContext *ctx)
+{
+    uint32_t XRd, XRc, XRb, XRa;
+
+    XRd = extract32(ctx->opcode, 18, 4);
+    XRc = extract32(ctx->opcode, 14, 4);
+    XRb = extract32(ctx->opcode, 10, 4);
+    XRa = extract32(ctx->opcode,  6, 4);
+
+    TCGv t0 = tcg_temp_new();
+    TCGv t1 = tcg_temp_new();
+    TCGv t2 = tcg_temp_new();
+    TCGv t3 = tcg_temp_new();
+    TCGv t4 = tcg_temp_new();
+    TCGv t5 = tcg_temp_new();
+
+    gen_load_mxu_gpr(t2, XRb);
+    gen_load_mxu_gpr(t3, XRc);
+    gen_load_mxu_gpr(t5, XRd);
+    tcg_gen_movi_tl(t4, 0);
+
+    for (int i = 0; i < 4; i++) {
+        tcg_gen_andi_tl(t0, t2, 0xff);
+        tcg_gen_andi_tl(t1, t3, 0xff);
+        tcg_gen_sub_tl(t0, t0, t1);
+        tcg_gen_abs_tl(t0, t0);
+        tcg_gen_add_tl(t4, t4, t0);
+        if (i < 3) {
+            tcg_gen_shri_tl(t2, t2, 8);
+            tcg_gen_shri_tl(t3, t3, 8);
+        }
+    }
+    tcg_gen_add_tl(t5, t5, t4);
+    gen_store_mxu_gpr(t4, XRa);
+    gen_store_mxu_gpr(t5, XRd);
+}
+
 /*
  *                 MXU instruction category: align
  *                 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
@@ -5042,6 +5084,9 @@ bool decode_ase_mxu(DisasContext *ctx, uint32_t insn)
         case OPC_MXU_S32SFL:
             gen_mxu_s32sfl(ctx);
             break;
+        case OPC_MXU_Q8SAD:
+            gen_mxu_q8sad(ctx);
+            break;
         default:
             return false;
         }
-- 
2.40.0



Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2975C74E104
	for <lists+qemu-devel@lfdr.de>; Tue, 11 Jul 2023 00:27:42 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qIzLT-0003Zd-98; Mon, 10 Jul 2023 18:27:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qIzLS-0003ZK-6z
 for qemu-devel@nongnu.org; Mon, 10 Jul 2023 18:27:02 -0400
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qIzLQ-0001l6-JI
 for qemu-devel@nongnu.org; Mon, 10 Jul 2023 18:27:01 -0400
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-3fb4146e8deso64039825e9.0
 for <qemu-devel@nongnu.org>; Mon, 10 Jul 2023 15:27:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1689028019; x=1691620019;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=agZFEaOSiD5GDKXw/f3lIVw/fpih6HqrjVN+YXK8gFk=;
 b=YS3Xr/LK00/qdvoDMhiWQg0JhkFH6XVoI3BBF0DTJ0dv0UgU8bDxytdIYtsFsBZqCd
 b3BlyLYLkP5MBe4DncKhEtPrls4qOk1rc8f/8cF5lUBcwvpaz3t059moxo4eUGuWwT/B
 zjKclJQUu5MdinSiABqxUp+UgYqopuXI6iNui4khNympHyFt24QCDzBgQ537W2MXE/fb
 KdKy0Cfui1cw2VukwNegF7fk26KBRFXDxFcxaRSkGnwDVFBkeAOiUmTzT8qkELxcriDT
 CzsW9JUHRVVJg2QsJJuP4E/tMj+e+8J3q9FDQvIy+76KNovn3/wYavX4DOKltWi7ntCM
 SUFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689028019; x=1691620019;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=agZFEaOSiD5GDKXw/f3lIVw/fpih6HqrjVN+YXK8gFk=;
 b=Ck68o6SFmiNzf5Lhoz/qweh/CLArFzhauiiUNLmdJtkNpeevo0BAIuPHBu1njdwJLp
 HVRQErxHFtPOuohKEqNd9xWJ8tN120lgEnTnhHQaS5FbfF8iHy1e93/jV0iFJALQwe8j
 Axyb+XHfYVaFq1cN/WBURVW1oQnfPS45UiJDNcp5aIJpKbKbh/X/5gxIAVBwdvnmCTO/
 Av4B6HbZVSQUsQAUQfsafu8SSjXEe0amz86hh06tWohkcWq2itswXcAsEfAjv7kelfRj
 lN6wGQikrrhEVQxvdHlSTjznEuiejkZ3ZPZvZR3npUBBREfjAaoXOBCl51waFcRN24Bj
 Y3OA==
X-Gm-Message-State: ABy/qLY/XPAVSg36RqpU0Tv3zKc7ZNEGDall5kMeK6T5ZEHxP2+S+ix1
 GGf7p5HMdGmpZixKEuW3yk/uY5ERmB5mvPgPMaNL9g==
X-Google-Smtp-Source: APBJJlF67WmbhXdiK5C2Bfv0hMUIHsKmyKVUcZn08ZYS8dHKxuDc3gdiiQ38rUIptXL2whtGT6Kaow==
X-Received: by 2002:a7b:c455:0:b0:3fa:85ad:6672 with SMTP id
 l21-20020a7bc455000000b003fa85ad6672mr16871394wmi.41.1689028019085; 
 Mon, 10 Jul 2023 15:26:59 -0700 (PDT)
Received: from m1x-phil.lan (mst45-h01-176-184-47-225.dsl.sta.abo.bbox.fr.
 [176.184.47.225]) by smtp.gmail.com with ESMTPSA id
 12-20020a05600c020c00b003f819faff24sm11440591wmi.40.2023.07.10.15.26.58
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 10 Jul 2023 15:26:58 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Siarhei Volkau <lis8215@gmail.com>, Huacai Chen <chenhuacai@kernel.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>
Subject: [PULL 08/44] target/mips/mxu: Add Q8SLT Q8SLTU instructions
Date: Tue, 11 Jul 2023 00:25:35 +0200
Message-Id: <20230710222611.50978-9-philmd@linaro.org>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230710222611.50978-1-philmd@linaro.org>
References: <20230710222611.50978-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32d.google.com
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

From: Siarhei Volkau <lis8215@gmail.com>

These instructions are used to set bits depending on
comparison result in each byte respectively.

Signed-off-by: Siarhei Volkau <lis8215@gmail.com>
Message-Id: <20230608104222.1520143-6-lis8215@gmail.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/mips/tcg/mxu_translate.c | 65 +++++++++++++++++++++++++++++++++
 1 file changed, 65 insertions(+)

diff --git a/target/mips/tcg/mxu_translate.c b/target/mips/tcg/mxu_translate.c
index 00a4d1da18..6d25562710 100644
--- a/target/mips/tcg/mxu_translate.c
+++ b/target/mips/tcg/mxu_translate.c
@@ -387,6 +387,8 @@ enum {
     OPC_MXU_D16MIN   = 0x03,
     OPC_MXU_Q8MAX    = 0x04,
     OPC_MXU_Q8MIN    = 0x05,
+    OPC_MXU_Q8SLT    = 0x06,
+    OPC_MXU_Q8SLTU   = 0x07,
 };
 
 /*
@@ -1397,6 +1399,63 @@ static void gen_mxu_Q8MAX_Q8MIN(DisasContext *ctx)
     }
 }
 
+/*
+ *  Q8SLT
+ *    Update XRa with the signed "set less than" comparison of XRb and XRc
+ *    on per-byte basis.
+ *    a.k.a. XRa[0..3] = XRb[0..3] < XRc[0..3] ? 1 : 0;
+ *
+ *  Q8SLTU
+ *    Update XRa with the unsigned "set less than" comparison of XRb and XRc
+ *    on per-byte basis.
+ *    a.k.a. XRa[0..3] = XRb[0..3] < XRc[0..3] ? 1 : 0;
+ */
+static void gen_mxu_q8slt(DisasContext *ctx, bool sltu)
+{
+    uint32_t pad, XRc, XRb, XRa;
+
+    pad = extract32(ctx->opcode, 21, 5);
+    XRc = extract32(ctx->opcode, 14, 4);
+    XRb = extract32(ctx->opcode, 10, 4);
+    XRa = extract32(ctx->opcode,  6, 4);
+
+    if (unlikely(pad != 0)) {
+        /* opcode padding incorrect -> do nothing */
+    } else if (unlikely(XRa == 0)) {
+        /* destination is zero register -> do nothing */
+    } else if (unlikely((XRb == 0) && (XRc == 0))) {
+        /* both operands zero registers -> just set destination to zero */
+        tcg_gen_movi_tl(mxu_gpr[XRa - 1], 0);
+    } else if (unlikely(XRb == XRc)) {
+        /* both operands same registers -> just set destination to zero */
+        tcg_gen_movi_tl(mxu_gpr[XRa - 1], 0);
+    } else {
+        /* the most general case */
+        TCGv t0 = tcg_temp_new();
+        TCGv t1 = tcg_temp_new();
+        TCGv t2 = tcg_temp_new();
+        TCGv t3 = tcg_temp_new();
+        TCGv t4 = tcg_temp_new();
+
+        gen_load_mxu_gpr(t3, XRb);
+        gen_load_mxu_gpr(t4, XRc);
+        tcg_gen_movi_tl(t2, 0);
+
+        for (int i = 0; i < 4; i++) {
+            if (sltu) {
+                tcg_gen_extract_tl(t0, t3, 8 * i, 8);
+                tcg_gen_extract_tl(t1, t4, 8 * i, 8);
+            } else {
+                tcg_gen_sextract_tl(t0, t3, 8 * i, 8);
+                tcg_gen_sextract_tl(t1, t4, 8 * i, 8);
+            }
+            tcg_gen_setcond_tl(TCG_COND_LT, t0, t0, t1);
+            tcg_gen_deposit_tl(t2, t2, t0, 8 * i, 8);
+        }
+        gen_store_mxu_gpr(t2, XRa);
+    }
+}
+
 
 /*
  *                 MXU instruction category: align
@@ -1662,6 +1721,12 @@ static void decode_opc_mxu__pool00(DisasContext *ctx)
     case OPC_MXU_Q8MIN:
         gen_mxu_Q8MAX_Q8MIN(ctx);
         break;
+    case OPC_MXU_Q8SLT:
+        gen_mxu_q8slt(ctx, false);
+        break;
+    case OPC_MXU_Q8SLTU:
+        gen_mxu_q8slt(ctx, true);
+        break;
     default:
         MIPS_INVAL("decode_opc_mxu");
         gen_reserved_instruction(ctx);
-- 
2.38.1



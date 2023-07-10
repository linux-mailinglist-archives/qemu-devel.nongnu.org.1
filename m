Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7821174E130
	for <lists+qemu-devel@lfdr.de>; Tue, 11 Jul 2023 00:33:20 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qIzNe-0003An-7F; Mon, 10 Jul 2023 18:29:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qIzNb-00031C-EP
 for qemu-devel@nongnu.org; Mon, 10 Jul 2023 18:29:15 -0400
Received: from mail-wr1-x42e.google.com ([2a00:1450:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qIzNZ-000284-Kc
 for qemu-devel@nongnu.org; Mon, 10 Jul 2023 18:29:15 -0400
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-314417861b9so5111076f8f.0
 for <qemu-devel@nongnu.org>; Mon, 10 Jul 2023 15:29:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1689028150; x=1691620150;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=aMSCVh+rYmfl+WvzT2g9sfMjvqMygJA4VscuqXPupYg=;
 b=xiiZ+RtadDtDMnF4Te7Qo0rUKmo6VV1HNRZFqeunAgCDa8iXy5lsfW+3tWoc1ICCxn
 TJw9R1MwGzOCuMZp/Z/xJYCLEhji6TO+9eyUarrqbKtHWO96SNZz7zKUhYEzWlf3OkhI
 YGiPWvGS819/jPprGxAzF/fagzf1qHviGpLx8LlbJYe/+2Y15rMbcyut1xZvXnHPt+L1
 yQ/nFq8Y6odVs8PVH1IXBAa3wkGnZ+4votIwUvpB1o5px3rAVzZ4YIcFNzomV6m0YXXG
 zKcXapXAO+sCxhZK/v3dwIqEVksW772WVNiVW/GhvmkMogVOobD3gT/60CLnh77o5mvl
 r6XA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689028150; x=1691620150;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=aMSCVh+rYmfl+WvzT2g9sfMjvqMygJA4VscuqXPupYg=;
 b=joFf+e5GSAWniw6Xh6w042Ma+uBqzH/g5naS6Mt9qJ7rM2ZDT9gjJqYwfkmvJALUBj
 Wid+t0VLcL2hOq8efwReX0eqoGst82xfYFjVzUaJ0B7uzqCIFfnLH2BOKom8DeXuZC5V
 hNXXFD/aPYfmXBgppzCwkFi1sfQqUiR6XWcYE7Q3oj6gYqabJphXaQighUsLdcyfXHya
 DT5Fpi0d0vB8zj+R+13NiV/KoxD7UnawNsrPpymfN1ZEUPU+dVOTGJeF0DwGRDalgriT
 aSnm4fDIBCUgDwecmQjmQ3jNttNRn7tOSiUaemD4vSmTnq574in29glw/EzakEJQROGk
 stdw==
X-Gm-Message-State: ABy/qLYqYVWvT/24bq9+JqaJx8xY3U96xRT8VVZ0m7dz54kGXWQEXKEn
 VugqJdAg+skeHKQy4fZWoxYIH2zyDfi3PoIb398HiQ==
X-Google-Smtp-Source: APBJJlF2byeFLl2ZOpP2F1hOSOk7qhG/FORQFWtlMjQuLWR4cYIc9L+A24ALSVo0RsTgKIT2c55c/g==
X-Received: by 2002:adf:f7d0:0:b0:314:4439:151a with SMTP id
 a16-20020adff7d0000000b003144439151amr7758881wrq.6.1689028150582; 
 Mon, 10 Jul 2023 15:29:10 -0700 (PDT)
Received: from m1x-phil.lan (mst45-h01-176-184-47-225.dsl.sta.abo.bbox.fr.
 [176.184.47.225]) by smtp.gmail.com with ESMTPSA id
 h3-20020a5d4fc3000000b0031272fced4dsm533312wrw.52.2023.07.10.15.29.09
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 10 Jul 2023 15:29:10 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Siarhei Volkau <lis8215@gmail.com>, Huacai Chen <chenhuacai@kernel.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>
Subject: [PULL 33/44] target/mips/mxu: Add Q16SCOP instruction
Date: Tue, 11 Jul 2023 00:26:00 +0200
Message-Id: <20230710222611.50978-34-philmd@linaro.org>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230710222611.50978-1-philmd@linaro.org>
References: <20230710222611.50978-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42e;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42e.google.com
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

The instruction is used to determine sign of four 16-bit
packed data in parallel.

Signed-off-by: Siarhei Volkau <lis8215@gmail.com>
Message-Id: <20230608104222.1520143-31-lis8215@gmail.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/mips/tcg/mxu_translate.c | 85 +++++++++++++++++++++++++++++++++
 1 file changed, 85 insertions(+)

diff --git a/target/mips/tcg/mxu_translate.c b/target/mips/tcg/mxu_translate.c
index 6a82849ef7..6945dcb440 100644
--- a/target/mips/tcg/mxu_translate.c
+++ b/target/mips/tcg/mxu_translate.c
@@ -405,6 +405,7 @@ enum {
     OPC_MXU__POOL19  = 0x38,
     OPC_MXU__POOL20  = 0x39,
     OPC_MXU__POOL21  = 0x3A,
+    OPC_MXU_Q16SCOP  = 0x3B,
 };
 
 
@@ -3539,6 +3540,7 @@ static void gen_mxu_d32asum(DisasContext *ctx)
  *               S32EXTR      S32LUI
  *               S32EXTRV
  *                            Q16SAT
+ *                            Q16SCOP
  */
 
 /*
@@ -3806,6 +3808,86 @@ static void gen_mxu_Q16SAT(DisasContext *ctx)
     }
 }
 
+/*
+ *  Q16SCOP XRa, XRd, XRb, XRc
+ *    Determine sign of quad packed 16-bit signed values
+ *    in XRb and XRc put result in XRa and XRd respectively.
+ */
+static void gen_mxu_q16scop(DisasContext *ctx)
+{
+    uint32_t XRd, XRc, XRb, XRa;
+
+    XRd  = extract32(ctx->opcode, 18, 4);
+    XRc  = extract32(ctx->opcode, 14, 4);
+    XRb  = extract32(ctx->opcode, 10, 4);
+    XRa  = extract32(ctx->opcode,  6, 4);
+
+    TCGv t0 = tcg_temp_new();
+    TCGv t1 = tcg_temp_new();
+    TCGv t2 = tcg_temp_new();
+    TCGv t3 = tcg_temp_new();
+    TCGv t4 = tcg_temp_new();
+
+    TCGLabel *l_b_hi_lt = gen_new_label();
+    TCGLabel *l_b_hi_gt = gen_new_label();
+    TCGLabel *l_b_lo = gen_new_label();
+    TCGLabel *l_b_lo_lt = gen_new_label();
+    TCGLabel *l_c_hi = gen_new_label();
+    TCGLabel *l_c_hi_lt = gen_new_label();
+    TCGLabel *l_c_hi_gt = gen_new_label();
+    TCGLabel *l_c_lo = gen_new_label();
+    TCGLabel *l_c_lo_lt = gen_new_label();
+    TCGLabel *l_done = gen_new_label();
+
+    gen_load_mxu_gpr(t0, XRb);
+    gen_load_mxu_gpr(t1, XRc);
+
+    tcg_gen_sextract_tl(t2, t0, 16, 16);
+    tcg_gen_brcondi_tl(TCG_COND_LT, t2, 0, l_b_hi_lt);
+    tcg_gen_brcondi_tl(TCG_COND_GT, t2, 0, l_b_hi_gt);
+    tcg_gen_movi_tl(t3, 0);
+    tcg_gen_br(l_b_lo);
+    gen_set_label(l_b_hi_lt);
+    tcg_gen_movi_tl(t3, 0xffff0000);
+    tcg_gen_br(l_b_lo);
+    gen_set_label(l_b_hi_gt);
+    tcg_gen_movi_tl(t3, 0x00010000);
+
+    gen_set_label(l_b_lo);
+    tcg_gen_sextract_tl(t2, t0, 0, 16);
+    tcg_gen_brcondi_tl(TCG_COND_EQ, t2, 0, l_c_hi);
+    tcg_gen_brcondi_tl(TCG_COND_LT, t2, 0, l_b_lo_lt);
+    tcg_gen_ori_tl(t3, t3, 0x00000001);
+    tcg_gen_br(l_c_hi);
+    gen_set_label(l_b_lo_lt);
+    tcg_gen_ori_tl(t3, t3, 0x0000ffff);
+    tcg_gen_br(l_c_hi);
+
+    gen_set_label(l_c_hi);
+    tcg_gen_sextract_tl(t2, t1, 16, 16);
+    tcg_gen_brcondi_tl(TCG_COND_LT, t2, 0, l_c_hi_lt);
+    tcg_gen_brcondi_tl(TCG_COND_GT, t2, 0, l_c_hi_gt);
+    tcg_gen_movi_tl(t4, 0);
+    tcg_gen_br(l_c_lo);
+    gen_set_label(l_c_hi_lt);
+    tcg_gen_movi_tl(t4, 0xffff0000);
+    tcg_gen_br(l_c_lo);
+    gen_set_label(l_c_hi_gt);
+    tcg_gen_movi_tl(t4, 0x00010000);
+
+    gen_set_label(l_c_lo);
+    tcg_gen_sextract_tl(t2, t1, 0, 16);
+    tcg_gen_brcondi_tl(TCG_COND_EQ, t2, 0, l_done);
+    tcg_gen_brcondi_tl(TCG_COND_LT, t2, 0, l_c_lo_lt);
+    tcg_gen_ori_tl(t4, t4, 0x00000001);
+    tcg_gen_br(l_done);
+    gen_set_label(l_c_lo_lt);
+    tcg_gen_ori_tl(t4, t4, 0x0000ffff);
+
+    gen_set_label(l_done);
+    gen_store_mxu_gpr(t3, XRa);
+    gen_store_mxu_gpr(t4, XRd);
+}
 
 /*
  *                 MXU instruction category: align
@@ -4799,6 +4881,9 @@ bool decode_ase_mxu(DisasContext *ctx, uint32_t insn)
         case OPC_MXU__POOL21:
             decode_opc_mxu__pool21(ctx);
             break;
+        case OPC_MXU_Q16SCOP:
+            gen_mxu_q16scop(ctx);
+            break;
         default:
             return false;
         }
-- 
2.38.1



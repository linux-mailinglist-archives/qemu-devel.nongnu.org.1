Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 44E4674E12E
	for <lists+qemu-devel@lfdr.de>; Tue, 11 Jul 2023 00:32:52 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qIzNr-0003o6-0V; Mon, 10 Jul 2023 18:29:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qIzNp-0003lL-Di
 for qemu-devel@nongnu.org; Mon, 10 Jul 2023 18:29:29 -0400
Received: from mail-wr1-x42e.google.com ([2a00:1450:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qIzNn-0002Bp-MD
 for qemu-devel@nongnu.org; Mon, 10 Jul 2023 18:29:29 -0400
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-3141fa31c2bso5110896f8f.2
 for <qemu-devel@nongnu.org>; Mon, 10 Jul 2023 15:29:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1689028166; x=1691620166;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=IrdP+GTxx+78k+evZZHpP7bnuC4vtcn0hNtOHyqG+DU=;
 b=Mdl4n0C527tiFyPWA+x6EWtNVgjj50oRQETsNTSDm7olCkLR25tz/ZWLXM8XOFTqFS
 0hmCtdt5kwcaYRMHK9DTE0NenRvJaJ+N+M5lzFfV1cL7TUgcQJBIZ2R522hQcETr0J6L
 JjPVk1XK24zyJHF2WcHagf5bUca19+KmobberaCCZ7BwDXY9cLdSf+xYocvsHrGFTrQF
 wgggA1ugMQ2jIfRasxiIB37RO/pQ9zI15YI5XJOEgl3biDWnbB+nufRvBSR8twKjcFxU
 /UZWwmYfg8vV8QtSXTGg+3xR5eYAwT/gRHcO8bs27fALZMzrdJlDea+Ck4NPnmD6DhC+
 TraQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689028166; x=1691620166;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=IrdP+GTxx+78k+evZZHpP7bnuC4vtcn0hNtOHyqG+DU=;
 b=ignQxScebWe6zX3wtB+hAxIyviD+XdcukLEYE8n0DNbQmgIyYSooBUQv9zc4aDbAfK
 bPImxrL6gS8tmv/GWN4DndUF4XGn+8VisHjaeSvv1zQx4F3ByKd7M3FeWkkWYEbvoZRe
 fO07keGm3Tt0h8BWbgP+dIQxUW1NWzCYtixZVMkNaYXyhcDudLEmKYJXOOSAbIbjK6Tq
 EamhWcJnxWoUhPowaoszz39b3+6SvRO7ZtwMM0J6BRN1Pd/2KGNOgBY7xRVjG2FsS/DO
 zS1VPJyBaMW2bpCnoi4HY9dDXkcvxY/ZBLRaqVWzjTmMMS/Cjk0uJGRnC68aFoDNyj+W
 g+mQ==
X-Gm-Message-State: ABy/qLbMHGXILt9aiuvP1ObaQEpLmTPtI/H1qgJPEep7FqPaPQ1J7/Qp
 Q41fWdpqwCfxjD6LZFPotDxmqnWw5oZQm9ZR4Ym5Sg==
X-Google-Smtp-Source: APBJJlGyAxFP43TWZa7lpzWxPMIbszYPEnjIH+E98L0rSn8/PxHE3nNABhfVB3IjMdRKJ7Sw7DlEWw==
X-Received: by 2002:adf:e30f:0:b0:314:2f96:a23a with SMTP id
 b15-20020adfe30f000000b003142f96a23amr14158145wrj.66.1689028166092; 
 Mon, 10 Jul 2023 15:29:26 -0700 (PDT)
Received: from m1x-phil.lan (mst45-h01-176-184-47-225.dsl.sta.abo.bbox.fr.
 [176.184.47.225]) by smtp.gmail.com with ESMTPSA id
 q10-20020adfdfca000000b003144b95e1ecsm509960wrn.93.2023.07.10.15.29.25
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 10 Jul 2023 15:29:25 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Siarhei Volkau <lis8215@gmail.com>, Huacai Chen <chenhuacai@kernel.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>
Subject: [PULL 36/44] target/mips/mxu: Add Q8SAD instruction
Date: Tue, 11 Jul 2023 00:26:03 +0200
Message-Id: <20230710222611.50978-37-philmd@linaro.org>
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

The instruction implements SAD (sum-absolute-difference) operation which
is used in motion estimation algorithms. The instruction handles four
8-bit data in parallel.

Signed-off-by: Siarhei Volkau <lis8215@gmail.com>
Message-Id: <20230608104222.1520143-34-lis8215@gmail.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/mips/tcg/mxu_translate.c | 45 +++++++++++++++++++++++++++++++++
 1 file changed, 45 insertions(+)

diff --git a/target/mips/tcg/mxu_translate.c b/target/mips/tcg/mxu_translate.c
index c60404f739..deb8060a17 100644
--- a/target/mips/tcg/mxu_translate.c
+++ b/target/mips/tcg/mxu_translate.c
@@ -408,6 +408,7 @@ enum {
     OPC_MXU_Q16SCOP  = 0x3B,
     OPC_MXU_Q8MADL   = 0x3C,
     OPC_MXU_S32SFL   = 0x3D,
+    OPC_MXU_Q8SAD    = 0x3E,
 };
 
 
@@ -4039,6 +4040,47 @@ static void gen_mxu_s32sfl(DisasContext *ctx)
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
@@ -5040,6 +5082,9 @@ bool decode_ase_mxu(DisasContext *ctx, uint32_t insn)
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
2.38.1



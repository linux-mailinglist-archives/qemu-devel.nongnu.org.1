Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 160F674E120
	for <lists+qemu-devel@lfdr.de>; Tue, 11 Jul 2023 00:31:10 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qIzNi-0003I9-HL; Mon, 10 Jul 2023 18:29:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qIzNf-0003GJ-Ck
 for qemu-devel@nongnu.org; Mon, 10 Jul 2023 18:29:19 -0400
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qIzNd-000298-By
 for qemu-devel@nongnu.org; Mon, 10 Jul 2023 18:29:18 -0400
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-3142ee41fd2so5092121f8f.3
 for <qemu-devel@nongnu.org>; Mon, 10 Jul 2023 15:29:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1689028155; x=1691620155;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LCln3jJ+7gG+jrosvGc4eMbbvwHvlD0VQ3ORBziIIBU=;
 b=y+YvRxeRpvmZOekGyTZH6r/9C5PzFF3kuKfu/268fuZTgoRbLalZwklNO7dGW4F8RC
 ZTEr+Yd/sysufTY3bdgunYkDFDMtoW1TVH273FFUB7fLvcT7nXQD9oVsJj/PJyEwFX6Q
 WSiXd9yPprN3MhVkFsQFrwntqSSrPrinXL3vTZ0u53sO6QPN+BYIkuyROKTDYbU+cRMh
 /dhtCUx2mSI9C0GYFYTawvUQl/mmaK5iD0X+CikKSaEOsFBS/nk9QCPvfK9aJxWCP5Dd
 u9DozI44iQGZEuP6mFCXR9ZutH0IBMR9dKlRc7ouxLP6UZzhGMk3LeHBRz1iIbf0LlPk
 yYSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689028155; x=1691620155;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=LCln3jJ+7gG+jrosvGc4eMbbvwHvlD0VQ3ORBziIIBU=;
 b=IQO5qUqL56EX8aulmCdXy6+R3aORQ5fTgIh0h4vdop0/Gh9OI2/WiA2xpqE/wzhRIl
 FnXWxsKkqwjKOnZwdXozUJHcFVKgyiJMawSLaRUfWw1uRTCKjRtwo3LMw9KKpI7nFZes
 I28ZbZYN5bAessJjgu9eIAouVCFE+EKGLDaKxqXwXfqb4F0exwQnO7Km89Nr9tCS//g/
 wHd/XKAZWCoRoxoDOlBuxd0NSX7Q4tLRJsh5CnbS7wwMmcKjyAKhmf/7kVXlQcVNYiNS
 Zp09bvzMsWEdJweZDYOJBTm+2Zpk6YKH1hwSlGqhl+2RliqsfLzvBgqIFbASHN6PJtcc
 MLjA==
X-Gm-Message-State: ABy/qLboJ6EOT9VQQ5SNXh7a42MJpo98+laxf3GVFeCBC9HXELfKCu9B
 eW4V/2MqRfotCe8D3qbZnnkHG9s/l8KbB0ZQVlzddw==
X-Google-Smtp-Source: APBJJlEp3FjWrLi62tzOyeW2mz5109AAHrQQUhaN5D3LEaHOX9k6YI9XDRTn+3vK6XGAhZE1ndcXkw==
X-Received: by 2002:a5d:6d4b:0:b0:313:f54a:a83b with SMTP id
 k11-20020a5d6d4b000000b00313f54aa83bmr11938671wri.59.1689028155793; 
 Mon, 10 Jul 2023 15:29:15 -0700 (PDT)
Received: from m1x-phil.lan (mst45-h01-176-184-47-225.dsl.sta.abo.bbox.fr.
 [176.184.47.225]) by smtp.gmail.com with ESMTPSA id
 g12-20020a5d46cc000000b0031455482d1fsm537070wrs.47.2023.07.10.15.29.14
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 10 Jul 2023 15:29:15 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Siarhei Volkau <lis8215@gmail.com>, Huacai Chen <chenhuacai@kernel.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>
Subject: [PULL 34/44] target/mips/mxu: Add Q8MADL instruction
Date: Tue, 11 Jul 2023 00:26:01 +0200
Message-Id: <20230710222611.50978-35-philmd@linaro.org>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230710222611.50978-1-philmd@linaro.org>
References: <20230710222611.50978-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::436;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x436.google.com
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

The instruction is used to parallel multiply and accumulate
four 8-bit data.

Signed-off-by: Siarhei Volkau <lis8215@gmail.com>
Message-Id: <20230608104222.1520143-32-lis8215@gmail.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/mips/tcg/mxu_translate.c | 75 +++++++++++++++++++++++++++++++++
 1 file changed, 75 insertions(+)

diff --git a/target/mips/tcg/mxu_translate.c b/target/mips/tcg/mxu_translate.c
index 6945dcb440..84c52c55d6 100644
--- a/target/mips/tcg/mxu_translate.c
+++ b/target/mips/tcg/mxu_translate.c
@@ -406,6 +406,7 @@ enum {
     OPC_MXU__POOL20  = 0x39,
     OPC_MXU__POOL21  = 0x3A,
     OPC_MXU_Q16SCOP  = 0x3B,
+    OPC_MXU_Q8MADL   = 0x3C,
 };
 
 
@@ -1423,6 +1424,77 @@ static void gen_mxu_q8mul_mac(DisasContext *ctx, bool su, bool mac)
     gen_store_mxu_gpr(t1, XRa);
 }
 
+/*
+ * Q8MADL  XRd, XRa, XRb, XRc
+ *   Parallel quad unsigned 8 bit multiply and accumulate.
+ *   e.g. XRd[0..3] = XRa[0..3] + XRb[0..3] * XRc[0..3]
+ */
+static void gen_mxu_q8madl(DisasContext *ctx)
+{
+    TCGv t0, t1, t2, t3, t4, t5, t6, t7;
+    uint32_t XRa, XRb, XRc, XRd, aptn2;
+
+    t0 = tcg_temp_new();
+    t1 = tcg_temp_new();
+    t2 = tcg_temp_new();
+    t3 = tcg_temp_new();
+    t4 = tcg_temp_new();
+    t5 = tcg_temp_new();
+    t6 = tcg_temp_new();
+    t7 = tcg_temp_new();
+
+    XRa = extract32(ctx->opcode, 6, 4);
+    XRb = extract32(ctx->opcode, 10, 4);
+    XRc = extract32(ctx->opcode, 14, 4);
+    XRd = extract32(ctx->opcode, 18, 4);
+    aptn2 = extract32(ctx->opcode, 24, 2);
+
+    gen_load_mxu_gpr(t3, XRb);
+    gen_load_mxu_gpr(t7, XRc);
+
+    tcg_gen_extract_tl(t0, t3,  0, 8);
+    tcg_gen_extract_tl(t1, t3,  8, 8);
+    tcg_gen_extract_tl(t2, t3, 16, 8);
+    tcg_gen_extract_tl(t3, t3, 24, 8);
+
+    tcg_gen_extract_tl(t4, t7,  0, 8);
+    tcg_gen_extract_tl(t5, t7,  8, 8);
+    tcg_gen_extract_tl(t6, t7, 16, 8);
+    tcg_gen_extract_tl(t7, t7, 24, 8);
+
+    tcg_gen_mul_tl(t0, t0, t4);
+    tcg_gen_mul_tl(t1, t1, t5);
+    tcg_gen_mul_tl(t2, t2, t6);
+    tcg_gen_mul_tl(t3, t3, t7);
+
+    gen_load_mxu_gpr(t4, XRa);
+    tcg_gen_extract_tl(t6, t4, 0, 8);
+    tcg_gen_extract_tl(t7, t4, 8, 8);
+    if (aptn2 & 1) {
+        tcg_gen_sub_tl(t0, t6, t0);
+        tcg_gen_sub_tl(t1, t7, t1);
+    } else {
+        tcg_gen_add_tl(t0, t6, t0);
+        tcg_gen_add_tl(t1, t7, t1);
+    }
+    tcg_gen_extract_tl(t6, t4, 16, 8);
+    tcg_gen_extract_tl(t7, t4, 24, 8);
+    if (aptn2 & 2) {
+        tcg_gen_sub_tl(t2, t6, t2);
+        tcg_gen_sub_tl(t3, t7, t3);
+    } else {
+        tcg_gen_add_tl(t2, t6, t2);
+        tcg_gen_add_tl(t3, t7, t3);
+    }
+
+    tcg_gen_andi_tl(t5, t0, 0xff);
+    tcg_gen_deposit_tl(t5, t5, t1,  8, 8);
+    tcg_gen_deposit_tl(t5, t5, t2, 16, 8);
+    tcg_gen_deposit_tl(t5, t5, t3, 24, 8);
+
+    gen_store_mxu_gpr(t5, XRd);
+}
+
 /*
  * S32LDD  XRa, Rb, S12 - Load a word from memory to XRF
  * S32LDDR XRa, Rb, S12 - Load a word from memory to XRF
@@ -4884,6 +4956,9 @@ bool decode_ase_mxu(DisasContext *ctx, uint32_t insn)
         case OPC_MXU_Q16SCOP:
             gen_mxu_q16scop(ctx);
             break;
+        case OPC_MXU_Q8MADL:
+            gen_mxu_q8madl(ctx);
+            break;
         default:
             return false;
         }
-- 
2.38.1



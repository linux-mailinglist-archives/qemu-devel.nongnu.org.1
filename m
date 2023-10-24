Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D2F257D594D
	for <lists+qemu-devel@lfdr.de>; Tue, 24 Oct 2023 19:03:00 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qvKkT-0008Sm-OO; Tue, 24 Oct 2023 12:59:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qvKkR-0008RY-QF
 for qemu-devel@nongnu.org; Tue, 24 Oct 2023 12:59:19 -0400
Received: from mail-lj1-x22c.google.com ([2a00:1450:4864:20::22c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qvKkM-0002g9-2y
 for qemu-devel@nongnu.org; Tue, 24 Oct 2023 12:59:19 -0400
Received: by mail-lj1-x22c.google.com with SMTP id
 38308e7fff4ca-2c504a5e1deso74787301fa.2
 for <qemu-devel@nongnu.org>; Tue, 24 Oct 2023 09:59:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698166752; x=1698771552; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qdvuDWpSySdhsrITUvPFHqkuopKlbbVaHkugvXE520g=;
 b=WScBoOW1t45wGOd9M5Z0ON44ekzg1lW2nLGQiER693xKNV6Df/EvTUnmB5M5TnBby7
 TIRsvsnFv/gU3DE8lkM+pVXrgwnVJwNk3pqY2O6SBikVncrXGfVH24qrQyKWOe3v8sAe
 nfKmhX2GH3gfXpbz2Iap62D2dk7Oo6O6qNDV0025M8HbQ1R6xIEvvUfxMN+MZBRLAs3E
 i/cR6v+nzs+gdirJ5jE3h9b0Mo6LWmlTl3jaGzp8rUF1g/4Ov+B58jWGTBph0SsC+9Fv
 EFZD8J4FxYUPvyHs9gXeGcQcB4RUSaLKa/3Utg+YuVvR2l6WdVtnXm1+stj9JmvILynA
 q8WA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698166752; x=1698771552;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=qdvuDWpSySdhsrITUvPFHqkuopKlbbVaHkugvXE520g=;
 b=eQJjYRnFZRWD9KAQpCL9BMFcszU/r+uzGxGfiFTbo7vCwTUDGXAQGqot9+RtWybw6S
 d0SfBqh1ZXxrIFHwg+hYOtHjUigvAXjhDThOVdym0P0CF1GQg8B3JXr31wzOVHBCc2IH
 k6qkoeEuVtUckNHDAVm4iwdfYn7bGxQw1omvmweanaicoUJNDU0wRTlUgsmaVjtQkFbk
 jJAraYxdkY1z5Y7UVlr6DTRKiq/Jd/+IUnEOCP7cikjoSsw8j+esXZ69kBOrj9egilk2
 78Y5wTzE3OfJJjvHQj0BJCsWmd9pUjfnhyZD9yCMDXlpCu8uucllshSozov5jVEyOpR7
 FDCw==
X-Gm-Message-State: AOJu0Yzd1He9EDzJylE30JpTesfi3UqIYutC8HteSLESp29xx470LXZB
 Px2/y46PUCtFFMI40cxcFsXLQo10fPTHUB/tyrA=
X-Google-Smtp-Source: AGHT+IFZHNeU6yDXBVuGSAoRBRZjU4YnkPrjiDFWn7tPiLA6Kqjt9/mCxCo/5dN6eUrpcn6PMUFtxw==
X-Received: by 2002:a2e:b6ca:0:b0:2bc:b9c7:7ba8 with SMTP id
 m10-20020a2eb6ca000000b002bcb9c77ba8mr9345284ljo.43.1698166751983; 
 Tue, 24 Oct 2023 09:59:11 -0700 (PDT)
Received: from m1x-phil.lan (sem44-h01-176-172-55-165.dsl.sta.abo.bbox.fr.
 [176.172.55.165]) by smtp.gmail.com with ESMTPSA id
 qk2-20020a170906d9c200b009b97aa5a3aesm8626399ejb.34.2023.10.24.09.59.10
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 24 Oct 2023 09:59:11 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Michael Rolnik <mrolnik@gmail.com>
Subject: [PATCH v2 1/9] target/avr: Use tcg_gen_extract_tl
Date: Tue, 24 Oct 2023 18:58:54 +0200
Message-ID: <20231024165903.40861-2-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231024165903.40861-1-philmd@linaro.org>
References: <20231024165903.40861-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::22c;
 envelope-from=philmd@linaro.org; helo=mail-lj1-x22c.google.com
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

Inspired-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Michael Rolnik <mrolnik@gmail.com>
---
 target/avr/translate.c | 18 ++++++------------
 1 file changed, 6 insertions(+), 12 deletions(-)

diff --git a/target/avr/translate.c b/target/avr/translate.c
index cdffa04519..52fa7cebf6 100644
--- a/target/avr/translate.c
+++ b/target/avr/translate.c
@@ -223,8 +223,7 @@ static void gen_add_CHf(TCGv R, TCGv Rd, TCGv Rr)
     tcg_gen_or_tl(t1, t1, t3);
 
     tcg_gen_shri_tl(cpu_Cf, t1, 7); /* Cf = t1(7) */
-    tcg_gen_shri_tl(cpu_Hf, t1, 3); /* Hf = t1(3) */
-    tcg_gen_andi_tl(cpu_Hf, cpu_Hf, 1);
+    tcg_gen_extract_tl(cpu_Hf, t1, 3, 1); /* Hf = t1(3) */
 }
 
 static void gen_add_Vf(TCGv R, TCGv Rd, TCGv Rr)
@@ -254,8 +253,7 @@ static void gen_sub_CHf(TCGv R, TCGv Rd, TCGv Rr)
     tcg_gen_or_tl(t2, t2, t3); /* t2 = ~Rd & Rr | ~Rd & R | R & Rr */
 
     tcg_gen_shri_tl(cpu_Cf, t2, 7); /* Cf = t2(7) */
-    tcg_gen_shri_tl(cpu_Hf, t2, 3); /* Hf = t2(3) */
-    tcg_gen_andi_tl(cpu_Hf, cpu_Hf, 1);
+    tcg_gen_extract_tl(cpu_Hf, t2, 3, 1); /* Hf = t2(3) */
 }
 
 static void gen_sub_Vf(TCGv R, TCGv Rd, TCGv Rr)
@@ -810,8 +808,7 @@ static bool trans_FMUL(DisasContext *ctx, arg_FMUL *a)
     /* update output registers */
     tcg_gen_shli_tl(R, R, 1);
     tcg_gen_andi_tl(R0, R, 0xff);
-    tcg_gen_shri_tl(R1, R, 8);
-    tcg_gen_andi_tl(R1, R1, 0xff);
+    tcg_gen_extract_tl(R1, R, 8, 8);
     return true;
 }
 
@@ -845,8 +842,7 @@ static bool trans_FMULS(DisasContext *ctx, arg_FMULS *a)
     /* update output registers */
     tcg_gen_shli_tl(R, R, 1);
     tcg_gen_andi_tl(R0, R, 0xff);
-    tcg_gen_shri_tl(R1, R, 8);
-    tcg_gen_andi_tl(R1, R1, 0xff);
+    tcg_gen_extract_tl(R1, R, 8, 8);
     return true;
 }
 
@@ -878,8 +874,7 @@ static bool trans_FMULSU(DisasContext *ctx, arg_FMULSU *a)
     /* update output registers */
     tcg_gen_shli_tl(R, R, 1);
     tcg_gen_andi_tl(R0, R, 0xff);
-    tcg_gen_shri_tl(R1, R, 8);
-    tcg_gen_andi_tl(R1, R1, 0xff);
+    tcg_gen_extract_tl(R1, R, 8, 8);
     return true;
 }
 
@@ -2020,8 +2015,7 @@ static bool trans_LPMX(DisasContext *ctx, arg_LPMX *a)
     tcg_gen_qemu_ld_tl(Rd, addr, MMU_CODE_IDX, MO_UB);
     tcg_gen_addi_tl(addr, addr, 1); /* addr = addr + 1 */
     tcg_gen_andi_tl(L, addr, 0xff);
-    tcg_gen_shri_tl(addr, addr, 8);
-    tcg_gen_andi_tl(H, addr, 0xff);
+    tcg_gen_extract_tl(H, addr, 8, 8);
     return true;
 }
 
-- 
2.41.0



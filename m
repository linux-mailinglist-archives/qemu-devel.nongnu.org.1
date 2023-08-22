Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D21978413E
	for <lists+qemu-devel@lfdr.de>; Tue, 22 Aug 2023 14:53:14 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qYQrF-0000uv-8z; Tue, 22 Aug 2023 08:51:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qYQrD-0000uj-9T
 for qemu-devel@nongnu.org; Tue, 22 Aug 2023 08:51:39 -0400
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qYQr9-0001cb-6L
 for qemu-devel@nongnu.org; Tue, 22 Aug 2023 08:51:39 -0400
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-31969580797so3990411f8f.3
 for <qemu-devel@nongnu.org>; Tue, 22 Aug 2023 05:51:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1692708693; x=1693313493;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=I2L/xuYIR23wVFda3pdpuHsob8xvGwoQ3f9U0j6VhpA=;
 b=eQHgsXn4UsdTo7sq5zoFj37UGH/8dagKt8G98lQFpIZs7yQZAuTUQT6VxUvghoMwPM
 JQiPF1gHx9xJRYZ+NaDUJZrO0JxKx21gRJAfPRBRnehYtsLMO/sqGU3ZFGjilwnZrTGu
 jL8wff9FGjXqbjsjyvC+nsHJnywPPsd27XYaLgdgneKlpEGbvfjAhloBPQuLmECrjzTy
 WDIBrTTtB+bxuj3VECnr5xyEWfzPQHhh48E7NQKuA42E1moURCBLLeUqrzXuUeO6SjIL
 BII9HjpISVeAiZy2pH8BokxmHwYcco38+hWu5tvG4FG5yzGaYX1+ov3x1EDvfwNlxUCC
 LvUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692708693; x=1693313493;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=I2L/xuYIR23wVFda3pdpuHsob8xvGwoQ3f9U0j6VhpA=;
 b=TGr6r9GI2EQhGkPehrol4N6aAPNeM4jJUs6l6+LcAPpBp++oXVlLl7yw9IZUvF2eUY
 rdhcN2qFU6YEkvx1ffI1E9t1o9BqR/SKEPpKrixhNZywYccTL0Ak+3Utc1TYOftKJSzV
 VcT7yRKXjsBarzLtEuKGgNsazRfjgTRojctp+FoA6OLnGwXxrB5X6lrhizrycNJ6q2pr
 O6X3V2NefN+bbksdspcpzfToxndnBbNxl7hXPw4I1iMt39RCbZ/GcFpOzzcQJyLVIlAJ
 /exrXgZhCz33JoGK4gNrrq/Wn5phN2bmn9ouauhAP2o6FO/j/8rifLr6NQ29GIfWDnXv
 Tpew==
X-Gm-Message-State: AOJu0Yy6TO5hWaS+qlTFzEp0e3pPz2UM5JgHAw6AaX1E1EclpZCXBycG
 HS0uGrfK6n4FkgFo1YiimJnpoy1LkDd7+rSGubDCrQ==
X-Google-Smtp-Source: AGHT+IGzeBPDTGvBADC5USM1Yrp4Ypfb40F6iF+BkxZJ8xWFJ5r4lbw4MCP8sbyD5SNeD9z+wobmrA==
X-Received: by 2002:adf:e6c9:0:b0:313:dee2:e052 with SMTP id
 y9-20020adfe6c9000000b00313dee2e052mr7242354wrm.26.1692708693255; 
 Tue, 22 Aug 2023 05:51:33 -0700 (PDT)
Received: from localhost.localdomain ([37.19.214.4])
 by smtp.gmail.com with ESMTPSA id
 y21-20020a05600c365500b003fef19bb55csm6331542wmq.34.2023.08.22.05.51.30
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 22 Aug 2023 05:51:32 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Song Gao <gaosong@loongson.cn>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Greg Kurz <groug@kaod.org>, Aurelien Jarno <aurelien@aurel32.net>,
 qemu-ppc@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 David Gibson <david@gibson.dropbear.id.au>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Yoshinori Sato <ysato@users.sourceforge.jp>,
 Nicholas Piggin <npiggin@gmail.com>,
 Xiaojuan Yang <yangxiaojuan@loongson.cn>, qemu-arm@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 08/12] target/loongarch: Use generic hrev64_i64() in REVB.4H
 opcode
Date: Tue, 22 Aug 2023 14:51:22 +0200
Message-ID: <20230822125122.54991-1-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230822124042.54739-1-philmd@linaro.org>
References: <20230822124042.54739-1-philmd@linaro.org>
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
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/loongarch/insn_trans/trans_bit.c.inc | 15 +--------------
 1 file changed, 1 insertion(+), 14 deletions(-)

diff --git a/target/loongarch/insn_trans/trans_bit.c.inc b/target/loongarch/insn_trans/trans_bit.c.inc
index 95b4ee5bc8..c04806dc21 100644
--- a/target/loongarch/insn_trans/trans_bit.c.inc
+++ b/target/loongarch/insn_trans/trans_bit.c.inc
@@ -124,19 +124,6 @@ static void gen_revb_2h(TCGv dest, TCGv src1)
     tcg_gen_or_tl(dest, t0, t1);
 }
 
-static void gen_revb_4h(TCGv dest, TCGv src1)
-{
-    TCGv mask = tcg_constant_tl(0x00FF00FF00FF00FFULL);
-    TCGv t0 = tcg_temp_new();
-    TCGv t1 = tcg_temp_new();
-
-    tcg_gen_shri_tl(t0, src1, 8);
-    tcg_gen_and_tl(t0, t0, mask);
-    tcg_gen_and_tl(t1, src1, mask);
-    tcg_gen_shli_tl(t1, t1, 8);
-    tcg_gen_or_tl(dest, t0, t1);
-}
-
 static void gen_revh_2w(TCGv dest, TCGv src1)
 {
     TCGv_i64 t0 = tcg_temp_new_i64();
@@ -175,7 +162,7 @@ TRANS(clz_d, gen_rr, EXT_NONE, EXT_NONE, gen_clz_d)
 TRANS(cto_d, gen_rr, EXT_NONE, EXT_NONE, gen_cto_d)
 TRANS(ctz_d, gen_rr, EXT_NONE, EXT_NONE, gen_ctz_d)
 TRANS(revb_2h, gen_rr, EXT_NONE, EXT_SIGN, gen_revb_2h)
-TRANS(revb_4h, gen_rr, EXT_NONE, EXT_NONE, gen_revb_4h)
+TRANS(revb_4h, gen_rr, EXT_NONE, EXT_NONE, tcg_gen_hrev64_i64)
 TRANS(revb_2w, gen_rr, EXT_NONE, EXT_NONE, gen_revb_2w)
 TRANS(revb_d, gen_rr, EXT_NONE, EXT_NONE, tcg_gen_bswap64_i64)
 TRANS(revh_2w, gen_rr, EXT_NONE, EXT_NONE, gen_revh_2w)
-- 
2.41.0



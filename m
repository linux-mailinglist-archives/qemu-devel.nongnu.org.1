Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E837736DC4
	for <lists+qemu-devel@lfdr.de>; Tue, 20 Jun 2023 15:48:34 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qBbhh-0004kv-F3; Tue, 20 Jun 2023 09:47:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qBbhL-0004iw-MP
 for qemu-devel@nongnu.org; Tue, 20 Jun 2023 09:47:09 -0400
Received: from mail-ej1-x62e.google.com ([2a00:1450:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qBbhH-0002Dj-OC
 for qemu-devel@nongnu.org; Tue, 20 Jun 2023 09:47:06 -0400
Received: by mail-ej1-x62e.google.com with SMTP id
 a640c23a62f3a-9883123260fso351101366b.0
 for <qemu-devel@nongnu.org>; Tue, 20 Jun 2023 06:47:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1687268822; x=1689860822;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=OwP43XlwUIRhrsR/2qColpGgw5TXdrc1w9pzp3fk9ac=;
 b=qqs6h7FUMyqmOMkKgvJCgoSMoAUh4HcQQSHSS7Q1BcFZvZ3mhUv223LizHoSE4ivST
 UajeIfrvWjDrkR+eeYzbEwMwtn2y0wrnWgoCsC7LcWqW5kyZY1+wVbxCaGEzwjgwQAiI
 nK9vjUx3A7Mz4ohiyp0cL3kAwvw0qhqLdBn0rT6PWPTTblrl9Q2t1E3wszdOIlH0nnNA
 E1FX/8kOrVvzp5zdWdMKigoZF40k9oOUrYBBaVmEURbFdEX9HSAsvkb+BnnHe8LvrmaP
 d5ZLkiiWFUlBfqCXubaLhuBTRgrqZgTjyvmeALXzEEEsWhlxTU6TUQiDJgn9Fn0yfyHz
 /Lgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687268822; x=1689860822;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=OwP43XlwUIRhrsR/2qColpGgw5TXdrc1w9pzp3fk9ac=;
 b=VR9JANPNWb7wpfJChzybzkP3zP6vVgl2MqpzbipBO2NaJ42rNbgxIafhjY/bx1BWXM
 VV3ljHJRnD6BlHlZSiQcUMnbjrWHBPidiZJ4oQCBFmbE68vGsxPhUZIrswQol+DXNxdN
 s0FAhj1LIiWiuWpnn9G6NT3eNgqxJJXLOg9i08l4Sap1r6Pe5eyONtkPj3XfvZ0QhaSy
 xzaHsepZmWUc8tBq9PqHub496TYp/uVW5UE1GNFP+Loe3ObfLL31ZhQNJEI5R7CBS0sd
 c+9LX9UPM3pv9+LEMPzG0/MxTXTEJ6NiASzvRLwdtK/Da4yD9lKmmZ7xgGZbIqjsmegV
 /0lg==
X-Gm-Message-State: AC+VfDzKhQysF7KIEjXB8i052jL5+1DJoyIqTZVKV3tLWgdImP+rYft1
 I81l+mGJcQx9TbXY0EoPt0SUX9BM+NoFF6W7sbfYd3Fm
X-Google-Smtp-Source: ACHHUZ6FnJtUg63/2YRbHRdJpjV6AJN3wQ814XajEzPHm7O9rewHeGY4rUpXQfJagDPv8yDsucBOIg==
X-Received: by 2002:a17:907:9623:b0:988:9a65:eae6 with SMTP id
 gb35-20020a170907962300b009889a65eae6mr5786550ejc.38.1687268821727; 
 Tue, 20 Jun 2023 06:47:01 -0700 (PDT)
Received: from stoup.lan ([176.176.183.29]) by smtp.gmail.com with ESMTPSA id
 gu1-20020a170906f28100b009829a5ae8b3sm1449187ejb.64.2023.06.20.06.47.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 20 Jun 2023 06:47:01 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, Mark Rutland <mark.rutland@arm.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PATCH] target/arm: Fix sve prediate store, 8 <= VQ <= 15
Date: Tue, 20 Jun 2023 15:46:59 +0200
Message-Id: <20230620134659.817559-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62e;
 envelope-from=richard.henderson@linaro.org; helo=mail-ej1-x62e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

Brown bag time: store instead of load results in uninitialized temp.

Reported-by: Mark Rutland <mark.rutland@arm.com>
Fixes: e6dd5e782be ("target/arm: Use tcg_gen_qemu_{ld, st}_i128 in gen_sve_{ld, st}r")
Tested-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/tcg/translate-sve.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/arm/tcg/translate-sve.c b/target/arm/tcg/translate-sve.c
index ff050626e6..225d358922 100644
--- a/target/arm/tcg/translate-sve.c
+++ b/target/arm/tcg/translate-sve.c
@@ -4329,7 +4329,7 @@ void gen_sve_str(DisasContext *s, TCGv_ptr base, int vofs,
     /* Predicate register stores can be any multiple of 2.  */
     if (len_remain >= 8) {
         t0 = tcg_temp_new_i64();
-        tcg_gen_st_i64(t0, base, vofs + len_align);
+        tcg_gen_ld_i64(t0, base, vofs + len_align);
         tcg_gen_qemu_st_i64(t0, clean_addr, midx, MO_LEUQ | MO_ATOM_NONE);
         len_remain -= 8;
         len_align += 8;
-- 
2.34.1



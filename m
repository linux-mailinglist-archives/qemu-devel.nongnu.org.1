Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E25977459D2
	for <lists+qemu-devel@lfdr.de>; Mon,  3 Jul 2023 12:12:48 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qGGRf-000352-Oi; Mon, 03 Jul 2023 06:06:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qGGRS-0002qd-Se
 for qemu-devel@nongnu.org; Mon, 03 Jul 2023 06:06:01 -0400
Received: from mail-wr1-x42f.google.com ([2a00:1450:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qGGRG-0005qa-HK
 for qemu-devel@nongnu.org; Mon, 03 Jul 2023 06:05:58 -0400
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-3141c8a6f30so4372589f8f.1
 for <qemu-devel@nongnu.org>; Mon, 03 Jul 2023 03:05:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1688378739; x=1690970739;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9eRhNGGsvyXPq3UhYSn/b3L2GTywYRMcqzsZGePD5qs=;
 b=VljriHMdSXC8EaXjnTswdR4Z6m54Sss3Ohv9fTzUVY+VL4HkQGU8itXQw+EuDSPerY
 Tg7RC9e/VmNuAmj1EH7NSNRCRecWfDXK0+JYm5vKANgcmcKXhOy9Xt4zsocJUmOioXhP
 cDk07FrApzFtGXDbAiFlXxvwY48iy83bq3CTDYD9LfWwHGMBR86JNQ7tQFTfFcxi28c8
 AtOE+5D7tlcEY8j8XeT2nSrLO3fHUvFhBd1fPdORTB1tMfbp4XWh0bGA0cep8kH4qLoz
 jp+aCAHJd+Jz7cVx2Q95fW7f88sFG3vHQU8nV8gpAqRfqrYt4/C6XojgRCYFFtyVaLvr
 Y3Sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688378739; x=1690970739;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=9eRhNGGsvyXPq3UhYSn/b3L2GTywYRMcqzsZGePD5qs=;
 b=iIU13xe22LNDn9e7fzRsDABvIG+bj69qTPmH+pY/puEMyLHpM7iP/9EVPDwTTgbU4i
 ThK1fr+/Xl8Pi7nLQIZqNBAWQwovqqyl46kG2Lg/jSu0XviQQmJkkXSwmOyN1JzDrqIu
 1yKS53sjeDRFkt88BzBQyDWDev0/qBKE6QLZN4Rfn1eVxsmiBdoMbgMnWuRU2wZtbJ3j
 mh8q4lVYLZRTb9p6zV44g0dTCFiyjOW8ab3ax+WmyNjyXJ1L3Ir/wtqvNtzlwk+33o/l
 UxqqvUX4Bgr2TIwcL8wjEySCBOrlCqAJUuphSy2m97q6aVZMpUNm0BTmwC42m1NuQ7Lp
 PvbA==
X-Gm-Message-State: ABy/qLZ5oqlRMSzAaU/GR2Zz0YYubx7yCHWfjlLogwDvqoWSgZNilHO4
 w4hkorX1z9gQ5BBqfUmPJxhUa6X6pwSQj9tUx722Ew==
X-Google-Smtp-Source: APBJJlFmmb5FjCgB3YLfeR6I5zEyICzQI0yAhyNz5zsT+34S23jihyhy+tlpORlon3OVeMMOUZETZA==
X-Received: by 2002:adf:f504:0:b0:313:ebbf:3696 with SMTP id
 q4-20020adff504000000b00313ebbf3696mr7337308wro.46.1688378738829; 
 Mon, 03 Jul 2023 03:05:38 -0700 (PDT)
Received: from stoup.home (91.232.79.188.dynamic.jazztel.es. [188.79.232.91])
 by smtp.gmail.com with ESMTPSA id
 t5-20020a05600001c500b00313f7b077fesm18446562wrx.59.2023.07.03.03.05.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 03 Jul 2023 03:05:38 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, qemu-riscv@nongnu.org, pbonzini@redhat.com,
 eduardo@habkost.net, alistair.francis@wdc.com, danielhb413@gmail.com,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v4 16/37] target/ppc: Use aesdec_ISB_ISR_AK
Date: Mon,  3 Jul 2023 12:04:59 +0200
Message-Id: <20230703100520.68224-17-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230703100520.68224-1-richard.henderson@linaro.org>
References: <20230703100520.68224-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42f;
 envelope-from=richard.henderson@linaro.org; helo=mail-wr1-x42f.google.com
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

This implements the VNCIPHERLAST instruction.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Daniel Henrique Barboza <danielhb413@gmail.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/ppc/int_helper.c | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/target/ppc/int_helper.c b/target/ppc/int_helper.c
index 34257e9d76..15f07fca2b 100644
--- a/target/ppc/int_helper.c
+++ b/target/ppc/int_helper.c
@@ -2973,13 +2973,7 @@ void helper_vncipher(ppc_avr_t *r, ppc_avr_t *a, ppc_avr_t *b)
 
 void helper_vncipherlast(ppc_avr_t *r, ppc_avr_t *a, ppc_avr_t *b)
 {
-    ppc_avr_t result;
-    int i;
-
-    VECTOR_FOR_INORDER_I(i, u8) {
-        result.VsrB(i) = b->VsrB(i) ^ (AES_isbox[a->VsrB(AES_ishifts[i])]);
-    }
-    *r = result;
+    aesdec_ISB_ISR_AK((AESState *)r, (AESState *)a, (AESState *)b, true);
 }
 
 void helper_vshasigmaw(ppc_avr_t *r,  ppc_avr_t *a, uint32_t st_six)
-- 
2.34.1



Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CB717459CA
	for <lists+qemu-devel@lfdr.de>; Mon,  3 Jul 2023 12:11:59 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qGGRY-0002pt-Cz; Mon, 03 Jul 2023 06:06:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qGGRL-0002gb-7k
 for qemu-devel@nongnu.org; Mon, 03 Jul 2023 06:05:51 -0400
Received: from mail-lf1-x134.google.com ([2a00:1450:4864:20::134])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qGGRF-0005pg-MB
 for qemu-devel@nongnu.org; Mon, 03 Jul 2023 06:05:50 -0400
Received: by mail-lf1-x134.google.com with SMTP id
 2adb3069b0e04-4fba1288bbdso5163452e87.1
 for <qemu-devel@nongnu.org>; Mon, 03 Jul 2023 03:05:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1688378738; x=1690970738;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CXOtR+skbBy3g0n+KA4k0jDRJwr6870/fEeTqXEf6Vk=;
 b=xrl3cKBGhkcU8TYDD3DWfaDWe7wEh8ettvQtJ5XM31Ict/oAX6jqvRW1g8ra+r9OEM
 VI+LpZ50jjMTXUGKh8xgvxt2kZEd+VoXFmBgBGLVe8gzFv7ZJGEQdQ2jMSYCdOn4//FF
 5JU1NqG32fR11IpbUlHZswa/SFOCYCDXdzqhzy7Pq1XztfEIT1AphtsT4+h0+zitj6eU
 Y80S2QKh9Xrr6HQh6gvj0+Q0HXCTtHXFQqxg3aCYm8y84ab9pUpdDl11kvP6aCSD+RnK
 ZFK7hjZPWL0uUDOxOISbI9XTw+5dBbmEBT1uFEBu1um3/cuZbctLZrKRBKP4LGla4zpj
 dJxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688378738; x=1690970738;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=CXOtR+skbBy3g0n+KA4k0jDRJwr6870/fEeTqXEf6Vk=;
 b=QtiD5gviiNhJQA/Bzb9f78/GDc/vU0WuqT1mkxPoVTFtM4Q1DJhfVCkwn2zwgQr7WK
 XUCcAlTGnEz+uqZ3TcRH1Qk4EHy4vNmzYkdCVFnhBEjKioF+leVrJQ47OZW2JW6qbH43
 5Ic1UvxuCI0Wwmd9/fORtxrE9weVbEp+9CI8MOwu0f8HWNk4A6T+Y47EV1FQ166gnf55
 v56BbXhPUnxiXZ7Fub0vji3T3oK4HNdcqosFx6Ec7VDBaSioOBZfwUQ7tQr8/XcNEV97
 DBi0XsK36J4OrYBOFF6E+pUSfeOUXWUR2NPPuV33urjPQ+fGFv9Bdbrg47Ti+n4xdsvG
 rUjw==
X-Gm-Message-State: ABy/qLbKCVrW7XLFGARaXmYmrBsgCz7M6f5rEGCe9kaNGXl3tMR5PK73
 IL1Lz8R/yqnPEWZZUDITvm+ceZa93kRQB/JNXro2gg==
X-Google-Smtp-Source: APBJJlHTWYFg56o5atNgPfJfgSF9w6MaczUFVkzyZXfs0HQ9FuXC2me4SBULnUbo9EAxRREajwmJnQ==
X-Received: by 2002:a05:6512:1116:b0:4fb:9d61:db44 with SMTP id
 l22-20020a056512111600b004fb9d61db44mr8572347lfg.12.1688378737834; 
 Mon, 03 Jul 2023 03:05:37 -0700 (PDT)
Received: from stoup.home (91.232.79.188.dynamic.jazztel.es. [188.79.232.91])
 by smtp.gmail.com with ESMTPSA id
 t5-20020a05600001c500b00313f7b077fesm18446562wrx.59.2023.07.03.03.05.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 03 Jul 2023 03:05:37 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, qemu-riscv@nongnu.org, pbonzini@redhat.com,
 eduardo@habkost.net, alistair.francis@wdc.com, danielhb413@gmail.com,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v4 15/37] target/ppc: Use aesenc_SB_SR_AK
Date: Mon,  3 Jul 2023 12:04:58 +0200
Message-Id: <20230703100520.68224-16-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230703100520.68224-1-richard.henderson@linaro.org>
References: <20230703100520.68224-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::134;
 envelope-from=richard.henderson@linaro.org; helo=mail-lf1-x134.google.com
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

This implements the VCIPHERLAST instruction.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Daniel Henrique Barboza <danielhb413@gmail.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/ppc/int_helper.c | 9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

diff --git a/target/ppc/int_helper.c b/target/ppc/int_helper.c
index d97a7f1f28..34257e9d76 100644
--- a/target/ppc/int_helper.c
+++ b/target/ppc/int_helper.c
@@ -25,6 +25,7 @@
 #include "qemu/log.h"
 #include "exec/helper-proto.h"
 #include "crypto/aes.h"
+#include "crypto/aes-round.h"
 #include "fpu/softfloat.h"
 #include "qapi/error.h"
 #include "qemu/guest-random.h"
@@ -2947,13 +2948,7 @@ void helper_vcipher(ppc_avr_t *r, ppc_avr_t *a, ppc_avr_t *b)
 
 void helper_vcipherlast(ppc_avr_t *r, ppc_avr_t *a, ppc_avr_t *b)
 {
-    ppc_avr_t result;
-    int i;
-
-    VECTOR_FOR_INORDER_I(i, u8) {
-        result.VsrB(i) = b->VsrB(i) ^ (AES_sbox[a->VsrB(AES_shifts[i])]);
-    }
-    *r = result;
+    aesenc_SB_SR_AK((AESState *)r, (AESState *)a, (AESState *)b, true);
 }
 
 void helper_vncipher(ppc_avr_t *r, ppc_avr_t *a, ppc_avr_t *b)
-- 
2.34.1



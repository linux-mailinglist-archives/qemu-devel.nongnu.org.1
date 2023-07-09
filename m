Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 692FE74C75D
	for <lists+qemu-devel@lfdr.de>; Sun,  9 Jul 2023 20:43:15 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qIZEQ-0005su-RW; Sun, 09 Jul 2023 14:34:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qIZDv-0003Wr-JD
 for qemu-devel@nongnu.org; Sun, 09 Jul 2023 14:33:33 -0400
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qIZDt-0004FT-6S
 for qemu-devel@nongnu.org; Sun, 09 Jul 2023 14:33:31 -0400
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-3fbfcc6daa9so26808355e9.3
 for <qemu-devel@nongnu.org>; Sun, 09 Jul 2023 11:33:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1688927606; x=1691519606;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5cwUPdSqiTi+cpvjs0+320/XSt6FYwReeMeUR4tviQI=;
 b=WnJbu1XoAQF1YeJpIUIepdedJ11UoER2gej/RuGURGu3QaLvKQZdbjZXPf6iJbo1Ia
 dlqXl6K5zcxIy2aIHIFpgDk1/AUl/0puBhnkBS3hG+CqbXarO59+U+tMk9EMGEaVvVYJ
 Kx6CLR3mw4bpmlmvqkTAUyZtuqweSdxzecMJ+sN82fes7m1jZwDEg+iKYcuHg3w8tWfa
 AoIcGLEb+Z+hz3ktF4iu3d59hPQpHNwtPN0cT6tWCQfCrTIEUeYY6WkRtthZG0SnrocI
 ZcJF7AxHQA7T5CEKe5IYQexhxyvPEe+QCgIyYFQ7Y0HVEGlvRAsMC4pedu6RliOLvRWd
 cgPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688927606; x=1691519606;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=5cwUPdSqiTi+cpvjs0+320/XSt6FYwReeMeUR4tviQI=;
 b=kmCcFaqBZeHQHkSXkM3JbWhF1fUcDzyDq0TCOnYHo+s1m5s9fjEWUtz0Uzi4hp3hqe
 3+MaU9ylWoz8HMbCSMQXNlOPgOwSfBDO77vz3uvWzjcVQ1UBtsp/SEj/JJ7WGO7Uuaa8
 S/er9hLhvYA8vaWT0ZB0sft04KoIRns37h+nKjK5s2f3zfYHejlOYEHC0pwyKlGcE0FO
 j8AWWgIdh6MT1+n1pGGuAUFnr3K6pibzAlfiwxFfbn3JDBjCghwBaMJ5STD7ri1z+1ZN
 j3u2MOyLEeWe0CQYo/tlyl8jn7wG/45N/TVMnUTiT7cPFOUt9FgcU1b6TxwlxNLEzRO0
 Q9zQ==
X-Gm-Message-State: ABy/qLaSJ3QONewuuD56ZTgGNqqHAKxvehz1wAmdcE956aXUdjj03ewH
 RA+M21/+/VNrHw0djDJX2ruggYdzqvjQb7rNVPisAg==
X-Google-Smtp-Source: APBJJlEt6Qqr7wr32KBE2J0S5BQlHqy8QTA5pQ+kfgv2zcSdigSuGJVav2vLY+IFFBQpbyMtODuOtA==
X-Received: by 2002:a5d:48d2:0:b0:30f:c42e:3299 with SMTP id
 p18-20020a5d48d2000000b0030fc42e3299mr7687003wrs.60.1688927606477; 
 Sun, 09 Jul 2023 11:33:26 -0700 (PDT)
Received: from stoup.. ([148.252.133.210]) by smtp.gmail.com with ESMTPSA id
 e17-20020a5d4e91000000b0031433760a92sm9635256wru.115.2023.07.09.11.33.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 09 Jul 2023 11:33:26 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: laurent@vivier.eu,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 29/37] target/riscv: Use aesenc_SB_SR_AK
Date: Sun,  9 Jul 2023 19:29:10 +0100
Message-Id: <20230709182934.309468-59-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230709182934.309468-1-richard.henderson@linaro.org>
References: <20230709182934.309468-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=richard.henderson@linaro.org; helo=mail-wm1-x32e.google.com
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

This implements the AES64ES instruction.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/riscv/crypto_helper.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/target/riscv/crypto_helper.c b/target/riscv/crypto_helper.c
index 2ef30281b1..b072fed3e2 100644
--- a/target/riscv/crypto_helper.c
+++ b/target/riscv/crypto_helper.c
@@ -22,6 +22,7 @@
 #include "exec/exec-all.h"
 #include "exec/helper-proto.h"
 #include "crypto/aes.h"
+#include "crypto/aes-round.h"
 #include "crypto/sm4.h"
 
 #define AES_XTIME(a) \
@@ -136,6 +137,8 @@ target_ulong HELPER(aes32dsi)(target_ulong rs1, target_ulong rs2,
     AES_INVMIXBYTE(COL, 1, 2, 3, 0) << 8 | \
     AES_INVMIXBYTE(COL, 0, 1, 2, 3) << 0)
 
+static const AESState aes_zero = { };
+
 static inline target_ulong aes64_operation(target_ulong rs1, target_ulong rs2,
                                            bool enc, bool mix)
 {
@@ -200,7 +203,12 @@ target_ulong HELPER(aes64esm)(target_ulong rs1, target_ulong rs2)
 
 target_ulong HELPER(aes64es)(target_ulong rs1, target_ulong rs2)
 {
-    return aes64_operation(rs1, rs2, true, false);
+    AESState t;
+
+    t.d[HOST_BIG_ENDIAN] = rs1;
+    t.d[!HOST_BIG_ENDIAN] = rs2;
+    aesenc_SB_SR_AK(&t, &t, &aes_zero, false);
+    return t.d[HOST_BIG_ENDIAN];
 }
 
 target_ulong HELPER(aes64ds)(target_ulong rs1, target_ulong rs2)
-- 
2.34.1



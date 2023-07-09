Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9321974C49B
	for <lists+qemu-devel@lfdr.de>; Sun,  9 Jul 2023 16:04:56 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qIUxg-0000Ut-95; Sun, 09 Jul 2023 10:00:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qIUxW-0000T3-DY
 for qemu-devel@nongnu.org; Sun, 09 Jul 2023 10:00:18 -0400
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qIUxQ-0000e0-QZ
 for qemu-devel@nongnu.org; Sun, 09 Jul 2023 10:00:15 -0400
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-3fbc12181b6so40119955e9.2
 for <qemu-devel@nongnu.org>; Sun, 09 Jul 2023 07:00:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1688911211; x=1691503211;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZNJt+xQSaKcqRS2slBC4RsFLFu+ocScsUgiRpjPIdes=;
 b=IsUday6OWCxs7DidWFVGxtSDTOtH3Sf75e5JPoG1b4XLLPWJefXo79qr/+Rjt17Hkz
 eFqh1+QpHoqqd/q2YuOZ9UNyVefufvaNTCUPe7YZ8UNYw9NDYPKsg1B6qAy8tY1RuPSW
 HXmdmluz13jyvHy3w9mq3KGKU+bQkrHPIKsujfSK1J6BC5KXoHb4uGyqIjuspDaHyoeR
 2/sJqbVJyjnei2V2O7tn9FhNGSxFZKxirUDbWJzYoyswAkiow95KxM3O1c6Fntlpjt+g
 EsL83HdWzflzk43oKhc6vwJGOeKT6bpeh2Fse2cH9NJ3jC56BTAnX7hjaqWMBj+3OsX2
 2A+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688911211; x=1691503211;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ZNJt+xQSaKcqRS2slBC4RsFLFu+ocScsUgiRpjPIdes=;
 b=g7huWxshQoxCt52x+0VrX3hfAJBvhQHABWHHTvaAZwBBHof40osFeV7cS/mMpfLP/O
 FHMgyMGYQBcwBVKsFDbppO3Q0xbSKxD+4IXaEFq82+uK4vLb9tZqbVSzSjCYW+eYOgoT
 3mzZX9haIp4SfYgDWlLMIa/2fbwOWk3MSXVbhpkXEQWajoLW9ZT0gcXXX0KG7Q4li622
 Vr/9ty/2yqoBkQrbnlaUUCS/HSN7SpQUb4aO+GJ9UOYF3+wFZPLDvSJtWMKVsntvxXCK
 5aQsMNYymMfk+fxgtnwkzZsUsfNrcVqRYJJqFS/e5XquTbNSsneaRmyMLXwN6qeCozYc
 eqqw==
X-Gm-Message-State: ABy/qLbOzmRGWg6xHeY3hoby5dfBOPckPrXoqSL6V57VEjp5z60EGmb6
 d5hRMi9pnQDC2mM6ao/RQ90tOb8Vu7J52xrCJtoR+A==
X-Google-Smtp-Source: APBJJlEXvsbmpYnGrRhvKpQmge9suhBYtLBUN91VaC5qwdbGM/S2fWzgYOTD70QlEUA9A+KWMOQrfA==
X-Received: by 2002:a05:600c:2251:b0:3f9:c82e:9d87 with SMTP id
 a17-20020a05600c225100b003f9c82e9d87mr8786805wmm.13.1688911211576; 
 Sun, 09 Jul 2023 07:00:11 -0700 (PDT)
Received: from stoup.. ([148.252.133.210]) by smtp.gmail.com with ESMTPSA id
 v18-20020a5d6792000000b003063a92bbf5sm9239422wru.70.2023.07.09.07.00.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 09 Jul 2023 07:00:11 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 28/37] target/arm: Use aesdec_IMC
Date: Sun,  9 Jul 2023 14:59:36 +0100
Message-Id: <20230709135945.250311-29-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230709135945.250311-1-richard.henderson@linaro.org>
References: <20230709135945.250311-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=richard.henderson@linaro.org; helo=mail-wm1-x334.google.com
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

This implements the AESIMC instruction.  We have converted everything
to crypto/aes-round.h; crypto/aes.h is no longer needed.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/tcg/crypto_helper.c | 33 ++++++++++++++-------------------
 1 file changed, 14 insertions(+), 19 deletions(-)

diff --git a/target/arm/tcg/crypto_helper.c b/target/arm/tcg/crypto_helper.c
index 1952aaac58..fdd70abbfd 100644
--- a/target/arm/tcg/crypto_helper.c
+++ b/target/arm/tcg/crypto_helper.c
@@ -14,7 +14,6 @@
 #include "cpu.h"
 #include "exec/helper-proto.h"
 #include "tcg/tcg-gvec-desc.h"
-#include "crypto/aes.h"
 #include "crypto/aes-round.h"
 #include "crypto/sm4.h"
 #include "vec_internal.h"
@@ -102,23 +101,6 @@ void HELPER(crypto_aesd)(void *vd, void *vn, void *vm, uint32_t desc)
     clear_tail(vd, opr_sz, simd_maxsz(desc));
 }
 
-static void do_crypto_aesmc(uint64_t *rd, uint64_t *rm, const uint32_t *mc)
-{
-    union CRYPTO_STATE st = { .l = { rm[0], rm[1] } };
-    int i;
-
-    for (i = 0; i < 16; i += 4) {
-        CR_ST_WORD(st, i >> 2) =
-            mc[CR_ST_BYTE(st, i)] ^
-            rol32(mc[CR_ST_BYTE(st, i + 1)], 8) ^
-            rol32(mc[CR_ST_BYTE(st, i + 2)], 16) ^
-            rol32(mc[CR_ST_BYTE(st, i + 3)], 24);
-    }
-
-    rd[0] = st.l[0];
-    rd[1] = st.l[1];
-}
-
 void HELPER(crypto_aesmc)(void *vd, void *vm, uint32_t desc)
 {
     intptr_t i, opr_sz = simd_oprsz(desc);
@@ -147,7 +129,20 @@ void HELPER(crypto_aesimc)(void *vd, void *vm, uint32_t desc)
     intptr_t i, opr_sz = simd_oprsz(desc);
 
     for (i = 0; i < opr_sz; i += 16) {
-        do_crypto_aesmc(vd + i, vm + i, AES_imc_rot);
+        AESState *ad = (AESState *)(vd + i);
+        AESState *st = (AESState *)(vm + i);
+        AESState t;
+
+        /* Our uint64_t are in the wrong order for big-endian. */
+        if (HOST_BIG_ENDIAN) {
+            t.d[0] = st->d[1];
+            t.d[1] = st->d[0];
+            aesdec_IMC(&t, &t, false);
+            ad->d[0] = t.d[1];
+            ad->d[1] = t.d[0];
+        } else {
+            aesdec_IMC(ad, st, false);
+        }
     }
     clear_tail(vd, opr_sz, simd_maxsz(desc));
 }
-- 
2.34.1



Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id AB1B47981D4
	for <lists+qemu-devel@lfdr.de>; Fri,  8 Sep 2023 08:07:31 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qeUcV-00006U-E7; Fri, 08 Sep 2023 02:05:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1qeUcP-00005i-M0
 for qemu-devel@nongnu.org; Fri, 08 Sep 2023 02:05:27 -0400
Received: from mail-pl1-x62c.google.com ([2607:f8b0:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1qeUcN-0005Hm-8D
 for qemu-devel@nongnu.org; Fri, 08 Sep 2023 02:05:25 -0400
Received: by mail-pl1-x62c.google.com with SMTP id
 d9443c01a7336-1bf7423ef3eso13572655ad.3
 for <qemu-devel@nongnu.org>; Thu, 07 Sep 2023 23:05:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1694153121; x=1694757921; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Uzpy+y6xrg4iHp+mbMOAUvxFawE2a4d7du1HjRHTWNg=;
 b=Xruglzsp9cahdsfRBb2pAi09ybD3cm4Em5r+UPRaE/fd/bZTFA8TUt1SK2InjyhZGD
 A1AJLMW/RusUp/FGyYkM+R1UOiA+0l+lxonbcwSDc8nEA8Rmv/9kZXHRefkzsiRrQuTv
 kXKztVR9+t2lnltZeGF6z25V4Bj3f65MZ3pS89NSTmtHoVUS8aduQeY58w2R8QhxZDsx
 iH0d5EBoiS6J0Y5dMbidPB22XR/H4LA4Z3IiKjx/IB3Vg77DGQJ7gDwWm5kbUSosP4d2
 GrxbTN5CUq1tdPE/O3M4gnqBMMS/WKom+d0LZS+WteNEMUyv8ZsIBisA7yQ35l3TJYt3
 DI2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694153121; x=1694757921;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Uzpy+y6xrg4iHp+mbMOAUvxFawE2a4d7du1HjRHTWNg=;
 b=GTWADRv0Ubha4l+hWD9tn6++7Kqjs38dKC56SfWL7T3yp5GQ+fm9orllIQkVoiHydn
 Kmq7r/rSEM+016fUu1qA/akaoTGXWThxT5/gLA7CyXK9/Acg7cgZJX3iibI/IuIaheYn
 rjIZfOtF7WQgN94+UMK5tAHU0uPHYbTTCrzY7EcW7h3GsPuHyCeMPsI3H8fxXd0FJxiE
 1udHGx8TYSdbluJ9sODq1nJ8xufea5r6gjVUiHpf8ltTPwcI2Foc1JVMYZEFxTTDCXd1
 +XvvSviIYG12jTH+Cdqxvi+lddPIfNyM35qjwvtL9tH4sUazjnPRhrOO/NYti0J1PeFu
 BRig==
X-Gm-Message-State: AOJu0YxHOXAnUHcUYH4aaBKQYTL6uYlOoMz5vW5MmmPt7hraxgdOTFbJ
 rLqKkm6UZoIUx8t4Pf/gHzxlI8061dnxnJ76
X-Google-Smtp-Source: AGHT+IF8IgjvONVUa08Zl2PBg63WLOypm6LU7zvoQvwITkD3BCGo4ISnjg0kEk6vP2a1oclz5PNBzg==
X-Received: by 2002:a17:902:d489:b0:1c0:aa07:1792 with SMTP id
 c9-20020a170902d48900b001c0aa071792mr1950933plg.36.1694153121561; 
 Thu, 07 Sep 2023 23:05:21 -0700 (PDT)
Received: from toolbox.alistair23.me
 (2403-580b-97e8-0-321-6fb2-58f1-a1b1.ip6.aussiebb.net.
 [2403:580b:97e8:0:321:6fb2:58f1:a1b1])
 by smtp.gmail.com with ESMTPSA id
 q1-20020a170902dac100b001c3267ae31bsm715231plx.301.2023.09.07.23.05.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 07 Sep 2023 23:05:20 -0700 (PDT)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Ard Biesheuvel <ardb@kernel.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Zewen Ye <lustrew@foxmail.com>, Weiwei Li <liweiwei@iscas.ac.cn>,
 Junqiang Wang <wangjunqiang@iscas.ac.cn>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 07/65] target/riscv: Use existing lookup tables for MixColumns
Date: Fri,  8 Sep 2023 16:03:33 +1000
Message-ID: <20230908060431.1903919-8-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230908060431.1903919-1-alistair.francis@wdc.com>
References: <20230908060431.1903919-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62c;
 envelope-from=alistair23@gmail.com; helo=mail-pl1-x62c.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

From: Ard Biesheuvel <ardb@kernel.org>

The AES MixColumns and InvMixColumns operations are relatively
expensive 4x4 matrix multiplications in GF(2^8), which is why C
implementations usually rely on precomputed lookup tables rather than
performing the calculations on demand.

Given that we already carry those tables in QEMU, we can just grab the
right value in the implementation of the RISC-V AES32 instructions. Note
that the tables in question are permuted according to the respective
Sbox, so we can omit the Sbox lookup as well in this case.

Cc: Richard Henderson <richard.henderson@linaro.org>
Cc: Philippe Mathieu-Daudé <philmd@linaro.org>
Cc: Zewen Ye <lustrew@foxmail.com>
Cc: Weiwei Li <liweiwei@iscas.ac.cn>
Cc: Junqiang Wang <wangjunqiang@iscas.ac.cn>
Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <20230731084043.1791984-1-ardb@kernel.org>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 include/crypto/aes.h         |  7 +++++++
 crypto/aes.c                 |  4 ++--
 target/riscv/crypto_helper.c | 34 ++++------------------------------
 3 files changed, 13 insertions(+), 32 deletions(-)

diff --git a/include/crypto/aes.h b/include/crypto/aes.h
index 709d4d226b..381f24c902 100644
--- a/include/crypto/aes.h
+++ b/include/crypto/aes.h
@@ -30,4 +30,11 @@ void AES_decrypt(const unsigned char *in, unsigned char *out,
 extern const uint8_t AES_sbox[256];
 extern const uint8_t AES_isbox[256];
 
+/*
+AES_Te0[x] = S [x].[02, 01, 01, 03];
+AES_Td0[x] = Si[x].[0e, 09, 0d, 0b];
+*/
+
+extern const uint32_t AES_Te0[256], AES_Td0[256];
+
 #endif
diff --git a/crypto/aes.c b/crypto/aes.c
index 836d7d5c0b..df4362ac60 100644
--- a/crypto/aes.c
+++ b/crypto/aes.c
@@ -272,7 +272,7 @@ AES_Td3[x] = Si[x].[09, 0d, 0b, 0e];
 AES_Td4[x] = Si[x].[01, 01, 01, 01];
 */
 
-static const uint32_t AES_Te0[256] = {
+const uint32_t AES_Te0[256] = {
     0xc66363a5U, 0xf87c7c84U, 0xee777799U, 0xf67b7b8dU,
     0xfff2f20dU, 0xd66b6bbdU, 0xde6f6fb1U, 0x91c5c554U,
     0x60303050U, 0x02010103U, 0xce6767a9U, 0x562b2b7dU,
@@ -607,7 +607,7 @@ static const uint32_t AES_Te4[256] = {
     0xb0b0b0b0U, 0x54545454U, 0xbbbbbbbbU, 0x16161616U,
 };
 
-static const uint32_t AES_Td0[256] = {
+const uint32_t AES_Td0[256] = {
     0x51f4a750U, 0x7e416553U, 0x1a17a4c3U, 0x3a275e96U,
     0x3bab6bcbU, 0x1f9d45f1U, 0xacfa58abU, 0x4be30393U,
     0x2030fa55U, 0xad766df6U, 0x88cc7691U, 0xf5024c25U,
diff --git a/target/riscv/crypto_helper.c b/target/riscv/crypto_helper.c
index 99d85a6188..4d65945429 100644
--- a/target/riscv/crypto_helper.c
+++ b/target/riscv/crypto_helper.c
@@ -25,29 +25,6 @@
 #include "crypto/aes-round.h"
 #include "crypto/sm4.h"
 
-#define AES_XTIME(a) \
-    ((a << 1) ^ ((a & 0x80) ? 0x1b : 0))
-
-#define AES_GFMUL(a, b) (( \
-    (((b) & 0x1) ? (a) : 0) ^ \
-    (((b) & 0x2) ? AES_XTIME(a) : 0) ^ \
-    (((b) & 0x4) ? AES_XTIME(AES_XTIME(a)) : 0) ^ \
-    (((b) & 0x8) ? AES_XTIME(AES_XTIME(AES_XTIME(a))) : 0)) & 0xFF)
-
-static inline uint32_t aes_mixcolumn_byte(uint8_t x, bool fwd)
-{
-    uint32_t u;
-
-    if (fwd) {
-        u = (AES_GFMUL(x, 3) << 24) | (x << 16) | (x << 8) |
-            (AES_GFMUL(x, 2) << 0);
-    } else {
-        u = (AES_GFMUL(x, 0xb) << 24) | (AES_GFMUL(x, 0xd) << 16) |
-            (AES_GFMUL(x, 0x9) << 8) | (AES_GFMUL(x, 0xe) << 0);
-    }
-    return u;
-}
-
 #define sext32_xlen(x) (target_ulong)(int32_t)(x)
 
 static inline target_ulong aes32_operation(target_ulong shamt,
@@ -55,23 +32,20 @@ static inline target_ulong aes32_operation(target_ulong shamt,
                                            bool enc, bool mix)
 {
     uint8_t si = rs2 >> shamt;
-    uint8_t so;
     uint32_t mixed;
     target_ulong res;
 
     if (enc) {
-        so = AES_sbox[si];
         if (mix) {
-            mixed = aes_mixcolumn_byte(so, true);
+            mixed = be32_to_cpu(AES_Te0[si]);
         } else {
-            mixed = so;
+            mixed = AES_sbox[si];
         }
     } else {
-        so = AES_isbox[si];
         if (mix) {
-            mixed = aes_mixcolumn_byte(so, false);
+            mixed = be32_to_cpu(AES_Td0[si]);
         } else {
-            mixed = so;
+            mixed = AES_isbox[si];
         }
     }
     mixed = rol32(mixed, shamt);
-- 
2.41.0



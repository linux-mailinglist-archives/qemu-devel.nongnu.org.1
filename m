Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6120A764D71
	for <lists+qemu-devel@lfdr.de>; Thu, 27 Jul 2023 10:33:31 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qOv1u-0000aj-TX; Thu, 27 Jul 2023 03:03:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ardb@kernel.org>) id 1qOv1s-0000aI-83
 for qemu-devel@nongnu.org; Thu, 27 Jul 2023 03:03:20 -0400
Received: from dfw.source.kernel.org ([139.178.84.217])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ardb@kernel.org>) id 1qOv1q-0002Ap-FN
 for qemu-devel@nongnu.org; Thu, 27 Jul 2023 03:03:20 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id 9705D61D60;
 Thu, 27 Jul 2023 07:03:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 69053C433C9;
 Thu, 27 Jul 2023 07:03:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1690441396;
 bh=EnwkjD7XZCmYzf4rw9ZPtvIKxQEOlV+/mmLROuC/t10=;
 h=From:To:Cc:Subject:Date:From;
 b=uefqACiqVAcWFwt90EBoazVdFZOacLw/by5PDHjuO8cOS0UPmQwmUJTfD2WtFSFiN
 Cu17eSgiMkoM+Px0lbnp16mazXtKQ3EcC3iOejrhrKe4FAkDK65XKwMaZlNu527ANj
 6AifWVklMcKI7wLWSxYF2pAzn8ycgdt9ce/x4FPUO+Euu3+Vp+LBcsFJZ5rYI6Nd0I
 5RsfzzFBZXGDKKo0Q3CCiqES00CE8zePQLZFjSaTliaQLqxRs6jrNNL/l5P2oHmrrq
 XSREoGV9ccJ81G8ejEuOCLC44MPAti7DmnsNT96vX8B4H853SJHT14KtQTjPdJYt1Z
 GaImui3eHmOYQ==
From: Ard Biesheuvel <ardb@kernel.org>
To: qemu-devel@nongnu.org
Cc: Ard Biesheuvel <ardb@kernel.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Zewen Ye <lustrew@foxmail.com>, Weiwei Li <liweiwei@iscas.ac.cn>,
 Junqiang Wang <wangjunqiang@iscas.ac.cn>
Subject: [PATCH] target/riscv: Use existing lookup tables for AES MixColumns
Date: Thu, 27 Jul 2023 09:03:03 +0200
Message-Id: <20230727070303.1220037-1-ardb@kernel.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4152; i=ardb@kernel.org;
 h=from:subject; bh=EnwkjD7XZCmYzf4rw9ZPtvIKxQEOlV+/mmLROuC/t10=;
 b=owGbwMvMwCFmkMcZplerG8N4Wi2JIeWQ2LImN9PP+249UvH8rf6hoEPP71KDJ+fGGSutdhSmH
 b3p1WjQUcrCIMbBICumyCIw+++7nacnStU6z5KFmcPKBDKEgYtTACYyWZbhf2V8dvka0eebl4gz
 tfoVfXr48bVg/TmBWZOYb37vj9bjfgtUIbSeNXzOrCN9Z1+7lx4JaJ2TwLxf6NjZuB2K5sb331t
 xAAA=
X-Developer-Key: i=ardb@kernel.org; a=openpgp;
 fpr=F43D03328115A198C90016883D200E9CA6329909
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=139.178.84.217; envelope-from=ardb@kernel.org;
 helo=dfw.source.kernel.org
X-Spam_score_int: -70
X-Spam_score: -7.1
X-Spam_bar: -------
X-Spam_report: (-7.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_HI=-5, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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
---
 crypto/aes.c                 |  5 ++--
 include/crypto/aes.h         |  7 +++++
 target/riscv/crypto_helper.c | 30 ++++----------------
 3 files changed, 14 insertions(+), 28 deletions(-)

diff --git a/crypto/aes.c b/crypto/aes.c
index 836d7d5c0bf1b392..27d7e1a22dfe8c74 100644
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
@@ -606,8 +606,7 @@ static const uint32_t AES_Te4[256] = {
     0x41414141U, 0x99999999U, 0x2d2d2d2dU, 0x0f0f0f0fU,
     0xb0b0b0b0U, 0x54545454U, 0xbbbbbbbbU, 0x16161616U,
 };
-
-static const uint32_t AES_Td0[256] = {
+const uint32_t AES_Td0[256] = {
     0x51f4a750U, 0x7e416553U, 0x1a17a4c3U, 0x3a275e96U,
     0x3bab6bcbU, 0x1f9d45f1U, 0xacfa58abU, 0x4be30393U,
     0x2030fa55U, 0xad766df6U, 0x88cc7691U, 0xf5024c25U,
diff --git a/include/crypto/aes.h b/include/crypto/aes.h
index 709d4d226bfe158b..381f24c9022d2aa8 100644
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
diff --git a/target/riscv/crypto_helper.c b/target/riscv/crypto_helper.c
index 99d85a618843e87e..40f95c71cef45877 100644
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
@@ -62,18 +39,21 @@ static inline target_ulong aes32_operation(target_ulong shamt,
     if (enc) {
         so = AES_sbox[si];
         if (mix) {
-            mixed = aes_mixcolumn_byte(so, true);
+            mixed = AES_Te0[si];
         } else {
             mixed = so;
         }
     } else {
         so = AES_isbox[si];
         if (mix) {
-            mixed = aes_mixcolumn_byte(so, false);
+            mixed = AES_Td0[si];
         } else {
             mixed = so;
         }
     }
+    if (!HOST_BIG_ENDIAN && mix) {
+        mixed = bswap32(mixed);
+    }
     mixed = rol32(mixed, shamt);
     res = rs1 ^ mixed;
 
-- 
2.39.2



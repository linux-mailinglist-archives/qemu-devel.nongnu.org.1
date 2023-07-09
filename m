Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0893574C759
	for <lists+qemu-devel@lfdr.de>; Sun,  9 Jul 2023 20:43:15 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qIZE3-0003nW-VP; Sun, 09 Jul 2023 14:33:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qIZDp-0003Rv-Bh
 for qemu-devel@nongnu.org; Sun, 09 Jul 2023 14:33:26 -0400
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qIZDk-0004Ax-RE
 for qemu-devel@nongnu.org; Sun, 09 Jul 2023 14:33:25 -0400
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-3fbc77e76abso39545075e9.1
 for <qemu-devel@nongnu.org>; Sun, 09 Jul 2023 11:33:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1688927598; x=1691519598;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=O7ydnBYQ5OsAEU6obJ0/WYba/6nStgh78o+Q1/ZISH0=;
 b=ilR0OBCRgobFIdqHfHCrUS2RI6j6aoO8jGoRxPPfKnfUWn+CywRuI3HySEMe3RodOE
 MKl3z5xcKqHNL7Mh38lczn0yoDR+4SJ01ujvHg9F4BSe8VgM7XKmPxch+iCjLQWUWqdg
 4Ph5CvtmBu+IvBCOGikKet5GXYs3+Ngov7MX6HOxChEvPAoau4ATGf71LrZBS6D2Xpoj
 24Kp5RePAR69lLmry1KUw4XE2QMPtGETYoXDcA6I1w2hPYbXZS5GEbrllqC2Pd5Stqlz
 xWYeyNrxgFM1AiYNeRIxdC5kEBXh5wcGWrWluw5XgS6NX28rzo8XrUoNF3PupB9LjEoS
 nKow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688927598; x=1691519598;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=O7ydnBYQ5OsAEU6obJ0/WYba/6nStgh78o+Q1/ZISH0=;
 b=gAZoahxzYq9whfatlUuMJhrUP+rSyCJCdjs56LoG0TTzRY4DkJ41W9Jkz5N479R3dA
 9WsvViN/qBu6NZRBzK7ypQQrz+HtXYy3W9MYXlnp1UJc7DFUzh+4XYu5G5R7pjsoUxWM
 beOtQ7cAX+hHE035IeX3YgIPjC9ojrLerQlt5NXW6+Fwkv3P0O+4vUARYcVnjysw6N46
 RwqPLJiUcvmyNIG4paMo+hPV/myq4w+iTXAUA58DBEFMr/60Wp/JblC+XPjkwgiAJGS+
 nTgVMKchoeunOT8jNHB3DE9iwxgAFI19kUvV5BrdqSXUHpneh+bckJsLTNup0RFd1syr
 /YKg==
X-Gm-Message-State: ABy/qLacxUKwo3LZHuzGpABLVq9I8VWTO5E5rjEJtBKvTb+gIMjteO2m
 cs/THcdsYtdqtZDr92pzDu0OAhi9fvbdmQkxR/uR1w==
X-Google-Smtp-Source: APBJJlHYLttwzUys8nSJte8+8IEggt4d7SsMAAw2Pyvh3Aph6ggSIPvng8XwHExRS/oi6jfw+fPUzA==
X-Received: by 2002:a7b:c457:0:b0:3fb:739d:27b2 with SMTP id
 l23-20020a7bc457000000b003fb739d27b2mr9172846wmi.8.1688927598319; 
 Sun, 09 Jul 2023 11:33:18 -0700 (PDT)
Received: from stoup.. ([148.252.133.210]) by smtp.gmail.com with ESMTPSA id
 e17-20020a5d4e91000000b0031433760a92sm9635256wru.115.2023.07.09.11.33.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 09 Jul 2023 11:33:18 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: laurent@vivier.eu,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 24/37] target/arm: Demultiplex AESE and AESMC
Date: Sun,  9 Jul 2023 19:29:00 +0100
Message-Id: <20230709182934.309468-49-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230709182934.309468-1-richard.henderson@linaro.org>
References: <20230709182934.309468-1-richard.henderson@linaro.org>
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

Split these helpers so that we are not passing 'decrypt'
within the simd descriptor.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/helper.h             |  2 ++
 target/arm/tcg/sve.decode       |  4 ++--
 target/arm/tcg/crypto_helper.c  | 37 +++++++++++++++++++++++----------
 target/arm/tcg/translate-a64.c  | 13 ++++--------
 target/arm/tcg/translate-neon.c |  4 ++--
 target/arm/tcg/translate-sve.c  |  8 ++++---
 6 files changed, 41 insertions(+), 27 deletions(-)

diff --git a/target/arm/helper.h b/target/arm/helper.h
index 3335c2b10b..95e32a697a 100644
--- a/target/arm/helper.h
+++ b/target/arm/helper.h
@@ -552,7 +552,9 @@ DEF_HELPER_FLAGS_2(neon_qzip16, TCG_CALL_NO_RWG, void, ptr, ptr)
 DEF_HELPER_FLAGS_2(neon_qzip32, TCG_CALL_NO_RWG, void, ptr, ptr)
 
 DEF_HELPER_FLAGS_4(crypto_aese, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(crypto_aesd, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
 DEF_HELPER_FLAGS_3(crypto_aesmc, TCG_CALL_NO_RWG, void, ptr, ptr, i32)
+DEF_HELPER_FLAGS_3(crypto_aesimc, TCG_CALL_NO_RWG, void, ptr, ptr, i32)
 
 DEF_HELPER_FLAGS_4(crypto_sha1su0, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
 DEF_HELPER_FLAGS_4(crypto_sha1c, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
diff --git a/target/arm/tcg/sve.decode b/target/arm/tcg/sve.decode
index 14b3a69c36..04b6fcc0cf 100644
--- a/target/arm/tcg/sve.decode
+++ b/target/arm/tcg/sve.decode
@@ -1629,8 +1629,8 @@ STNT1_zprz      1110010 .. 10 ..... 001 ... ..... ..... \
 ### SVE2 Crypto Extensions
 
 # SVE2 crypto unary operations
-# AESMC and AESIMC
-AESMC           01000101 00 10000011100 decrypt:1 00000 rd:5
+AESMC           01000101 00 10000011100 0 00000 rd:5
+AESIMC          01000101 00 10000011100 1 00000 rd:5
 
 # SVE2 crypto destructive binary operations
 AESE            01000101 00 10001 0 11100 0 ..... .....  @rdn_rm_e0
diff --git a/target/arm/tcg/crypto_helper.c b/target/arm/tcg/crypto_helper.c
index 06254939d2..75882d9ea3 100644
--- a/target/arm/tcg/crypto_helper.c
+++ b/target/arm/tcg/crypto_helper.c
@@ -45,11 +45,9 @@ static void clear_tail_16(void *vd, uint32_t desc)
     clear_tail(vd, opr_sz, max_sz);
 }
 
-static void do_crypto_aese(uint64_t *rd, uint64_t *rn,
-                           uint64_t *rm, bool decrypt)
+static void do_crypto_aese(uint64_t *rd, uint64_t *rn, uint64_t *rm,
+                           const uint8_t *sbox, const uint8_t *shift)
 {
-    static uint8_t const * const sbox[2] = { AES_sbox, AES_isbox };
-    static uint8_t const * const shift[2] = { AES_shifts, AES_ishifts };
     union CRYPTO_STATE rk = { .l = { rm[0], rm[1] } };
     union CRYPTO_STATE st = { .l = { rn[0], rn[1] } };
     int i;
@@ -60,7 +58,7 @@ static void do_crypto_aese(uint64_t *rd, uint64_t *rn,
 
     /* combine ShiftRows operation and sbox substitution */
     for (i = 0; i < 16; i++) {
-        CR_ST_BYTE(st, i) = sbox[decrypt][CR_ST_BYTE(rk, shift[decrypt][i])];
+        CR_ST_BYTE(st, i) = sbox[CR_ST_BYTE(rk, shift[i])];
     }
 
     rd[0] = st.l[0];
@@ -70,18 +68,26 @@ static void do_crypto_aese(uint64_t *rd, uint64_t *rn,
 void HELPER(crypto_aese)(void *vd, void *vn, void *vm, uint32_t desc)
 {
     intptr_t i, opr_sz = simd_oprsz(desc);
-    bool decrypt = simd_data(desc);
 
     for (i = 0; i < opr_sz; i += 16) {
-        do_crypto_aese(vd + i, vn + i, vm + i, decrypt);
+        do_crypto_aese(vd + i, vn + i, vm + i, AES_sbox, AES_shifts);
     }
     clear_tail(vd, opr_sz, simd_maxsz(desc));
 }
 
-static void do_crypto_aesmc(uint64_t *rd, uint64_t *rm, bool decrypt)
+void HELPER(crypto_aesd)(void *vd, void *vn, void *vm, uint32_t desc)
+{
+    intptr_t i, opr_sz = simd_oprsz(desc);
+
+    for (i = 0; i < opr_sz; i += 16) {
+        do_crypto_aese(vd + i, vn + i, vm + i, AES_isbox, AES_ishifts);
+    }
+    clear_tail(vd, opr_sz, simd_maxsz(desc));
+}
+
+static void do_crypto_aesmc(uint64_t *rd, uint64_t *rm, const uint32_t *mc)
 {
     union CRYPTO_STATE st = { .l = { rm[0], rm[1] } };
-    const uint32_t *mc = decrypt ? AES_imc_rot : AES_mc_rot;
     int i;
 
     for (i = 0; i < 16; i += 4) {
@@ -99,10 +105,19 @@ static void do_crypto_aesmc(uint64_t *rd, uint64_t *rm, bool decrypt)
 void HELPER(crypto_aesmc)(void *vd, void *vm, uint32_t desc)
 {
     intptr_t i, opr_sz = simd_oprsz(desc);
-    bool decrypt = simd_data(desc);
 
     for (i = 0; i < opr_sz; i += 16) {
-        do_crypto_aesmc(vd + i, vm + i, decrypt);
+        do_crypto_aesmc(vd + i, vm + i, AES_mc_rot);
+    }
+    clear_tail(vd, opr_sz, simd_maxsz(desc));
+}
+
+void HELPER(crypto_aesimc)(void *vd, void *vm, uint32_t desc)
+{
+    intptr_t i, opr_sz = simd_oprsz(desc);
+
+    for (i = 0; i < opr_sz; i += 16) {
+        do_crypto_aesmc(vd + i, vm + i, AES_imc_rot);
     }
     clear_tail(vd, opr_sz, simd_maxsz(desc));
 }
diff --git a/target/arm/tcg/translate-a64.c b/target/arm/tcg/translate-a64.c
index 3baab6aa60..7d0c8f79a7 100644
--- a/target/arm/tcg/translate-a64.c
+++ b/target/arm/tcg/translate-a64.c
@@ -13210,7 +13210,6 @@ static void disas_crypto_aes(DisasContext *s, uint32_t insn)
     int opcode = extract32(insn, 12, 5);
     int rn = extract32(insn, 5, 5);
     int rd = extract32(insn, 0, 5);
-    int decrypt;
     gen_helper_gvec_2 *genfn2 = NULL;
     gen_helper_gvec_3 *genfn3 = NULL;
 
@@ -13221,20 +13220,16 @@ static void disas_crypto_aes(DisasContext *s, uint32_t insn)
 
     switch (opcode) {
     case 0x4: /* AESE */
-        decrypt = 0;
         genfn3 = gen_helper_crypto_aese;
         break;
     case 0x6: /* AESMC */
-        decrypt = 0;
         genfn2 = gen_helper_crypto_aesmc;
         break;
     case 0x5: /* AESD */
-        decrypt = 1;
-        genfn3 = gen_helper_crypto_aese;
+        genfn3 = gen_helper_crypto_aesd;
         break;
     case 0x7: /* AESIMC */
-        decrypt = 1;
-        genfn2 = gen_helper_crypto_aesmc;
+        genfn2 = gen_helper_crypto_aesimc;
         break;
     default:
         unallocated_encoding(s);
@@ -13245,9 +13240,9 @@ static void disas_crypto_aes(DisasContext *s, uint32_t insn)
         return;
     }
     if (genfn2) {
-        gen_gvec_op2_ool(s, true, rd, rn, decrypt, genfn2);
+        gen_gvec_op2_ool(s, true, rd, rn, 0, genfn2);
     } else {
-        gen_gvec_op3_ool(s, true, rd, rd, rn, decrypt, genfn3);
+        gen_gvec_op3_ool(s, true, rd, rd, rn, 0, genfn3);
     }
 }
 
diff --git a/target/arm/tcg/translate-neon.c b/target/arm/tcg/translate-neon.c
index 03913de047..8de4ceb203 100644
--- a/target/arm/tcg/translate-neon.c
+++ b/target/arm/tcg/translate-neon.c
@@ -3451,9 +3451,9 @@ static bool trans_VMVN(DisasContext *s, arg_2misc *a)
     }
 
 WRAP_2M_3_OOL_FN(gen_AESE, gen_helper_crypto_aese, 0)
-WRAP_2M_3_OOL_FN(gen_AESD, gen_helper_crypto_aese, 1)
+WRAP_2M_3_OOL_FN(gen_AESD, gen_helper_crypto_aesd, 0)
 WRAP_2M_2_OOL_FN(gen_AESMC, gen_helper_crypto_aesmc, 0)
-WRAP_2M_2_OOL_FN(gen_AESIMC, gen_helper_crypto_aesmc, 1)
+WRAP_2M_2_OOL_FN(gen_AESIMC, gen_helper_crypto_aesimc, 0)
 WRAP_2M_2_OOL_FN(gen_SHA1H, gen_helper_crypto_sha1h, 0)
 WRAP_2M_2_OOL_FN(gen_SHA1SU1, gen_helper_crypto_sha1su1, 0)
 WRAP_2M_2_OOL_FN(gen_SHA256SU0, gen_helper_crypto_sha256su0, 0)
diff --git a/target/arm/tcg/translate-sve.c b/target/arm/tcg/translate-sve.c
index 225d358922..8350a65f31 100644
--- a/target/arm/tcg/translate-sve.c
+++ b/target/arm/tcg/translate-sve.c
@@ -7151,12 +7151,14 @@ TRANS_FEAT(USDOT_zzzz, aa64_sve_i8mm, gen_gvec_ool_arg_zzzz,
            a->esz == 2 ? gen_helper_gvec_usdot_b : NULL, a, 0)
 
 TRANS_FEAT_NONSTREAMING(AESMC, aa64_sve2_aes, gen_gvec_ool_zz,
-                        gen_helper_crypto_aesmc, a->rd, a->rd, a->decrypt)
+                        gen_helper_crypto_aesmc, a->rd, a->rd, 0)
+TRANS_FEAT_NONSTREAMING(AESIMC, aa64_sve2_aes, gen_gvec_ool_zz,
+                        gen_helper_crypto_aesimc, a->rd, a->rd, 0)
 
 TRANS_FEAT_NONSTREAMING(AESE, aa64_sve2_aes, gen_gvec_ool_arg_zzz,
-                        gen_helper_crypto_aese, a, false)
+                        gen_helper_crypto_aese, a, 0)
 TRANS_FEAT_NONSTREAMING(AESD, aa64_sve2_aes, gen_gvec_ool_arg_zzz,
-                        gen_helper_crypto_aese, a, true)
+                        gen_helper_crypto_aesd, a, 0)
 
 TRANS_FEAT_NONSTREAMING(SM4E, aa64_sve2_sm4, gen_gvec_ool_arg_zzz,
                         gen_helper_crypto_sm4e, a, 0)
-- 
2.34.1



Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D7EA5752BEF
	for <lists+qemu-devel@lfdr.de>; Thu, 13 Jul 2023 23:17:38 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qK3eZ-0000Ly-1M; Thu, 13 Jul 2023 17:15:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qK3eJ-0000J7-Vk
 for qemu-devel@nongnu.org; Thu, 13 Jul 2023 17:14:56 -0400
Received: from mail-wr1-x430.google.com ([2a00:1450:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qK3eI-00017x-CO
 for qemu-devel@nongnu.org; Thu, 13 Jul 2023 17:14:55 -0400
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-316eabffaa6so795136f8f.2
 for <qemu-devel@nongnu.org>; Thu, 13 Jul 2023 14:14:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1689282893; x=1691874893;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Af+EKJ8ZN4mASGCOe+AcfD/joyYUaDCEWZVqXWvkjKU=;
 b=Kgk868F9D3WQqXnTIH4bYiv9vobnCbu/5H+mHKO6g72pnhiIfww7SV590eCybpaKZu
 rcttQ34S1VHEwAtj5lHIU1i9oru3StKvmYFgTTgPqNFTMo9OC4NmOSRWfdYnEkP/MPfy
 hDBNkoyfLygNG3vXBZtSN2TNV1POJSYQykOjkFRDiDxnGtjQHyAv1jTK/BsHSxyiLSYK
 U/1Iv8Qs8j6VrLY3MjLpX+80VasyOFWC61hCWAxn6G1pVBvoUedK0E6LW1XDNegoNaJG
 ZaFTIrLnRYbO6ADkhn0MzKx+zoyvhgHwkVA8RnsJhOOvMmbPYHWszNxuxosnV5Ur6NKB
 8OkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689282893; x=1691874893;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Af+EKJ8ZN4mASGCOe+AcfD/joyYUaDCEWZVqXWvkjKU=;
 b=I9HRFNKNTdCx31Deh/1zyQFu6IY01gUm3o7ThInBfkax2kVHUqWcneUSoXOdQSiqbF
 oEz27ezbbsO61xsvV8RX0giLVZUce3KIDDKiJAetKTuCREY3XUK5DK9JfjD4w/jZnaTL
 mc+Um+AbufeGFolnegRtGkuI0XbGopo+E0yRWwVAk5UDTSxZEthfHZwXT4QIseb+gmbv
 W2p6n+7/uEYUvYzwx2ctVNdKRlikKGD/2xdH+5c5rdDgUCw6TRkRgV0BOaJUr+E5A9tN
 ikK2IW4MYSAtYREsE6i36LdoP9j+iGBoVg65uGG8p7CjLrFxCahGipByyPEX4Z8zNSU+
 JNrw==
X-Gm-Message-State: ABy/qLa+7/eXKSf0nu6cZ8Ue/NUrFMdorTD83kMDAgNu1I5RrBp1H0oU
 TlmmmPuRUt1Jc53JAI0W1QPcCEXigUAunKk/ZP9SKgop
X-Google-Smtp-Source: APBJJlGXSiK867eroY/G7cJ/GRZoBF16KqgZHvtcBqbfRYN/XdhiVn6jM9395BZU8RiWxn7gfB4DZQ==
X-Received: by 2002:a5d:4482:0:b0:314:2b0a:dabe with SMTP id
 j2-20020a5d4482000000b003142b0adabemr2268057wrq.30.1689282892950; 
 Thu, 13 Jul 2023 14:14:52 -0700 (PDT)
Received: from stoup.. ([85.193.156.66]) by smtp.gmail.com with ESMTPSA id
 n12-20020adff08c000000b0030ada01ca78sm8973747wro.10.2023.07.13.14.14.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 13 Jul 2023 14:14:52 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: berrange@redhat.com,
	ardb@kernel.org
Subject: [PATCH 11/18] target/s390x: Use clmul_32* routines
Date: Thu, 13 Jul 2023 22:14:28 +0100
Message-Id: <20230713211435.13505-12-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230713211435.13505-1-richard.henderson@linaro.org>
References: <20230713211435.13505-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::430;
 envelope-from=richard.henderson@linaro.org; helo=mail-wr1-x430.google.com
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

Use generic routines for 32-bit carry-less multiply.
Remove our local version of galois_multiply32.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/s390x/tcg/vec_int_helper.c | 70 ++++++++-----------------------
 1 file changed, 17 insertions(+), 53 deletions(-)

diff --git a/target/s390x/tcg/vec_int_helper.c b/target/s390x/tcg/vec_int_helper.c
index 523d6375bb..f5eea2330a 100644
--- a/target/s390x/tcg/vec_int_helper.c
+++ b/target/s390x/tcg/vec_int_helper.c
@@ -165,22 +165,6 @@ DEF_VCTZ(8)
 DEF_VCTZ(16)
 
 /* like binary multiplication, but XOR instead of addition */
-#define DEF_GALOIS_MULTIPLY(BITS, TBITS)                                       \
-static uint##TBITS##_t galois_multiply##BITS(uint##TBITS##_t a,                \
-                                             uint##TBITS##_t b)                \
-{                                                                              \
-    uint##TBITS##_t res = 0;                                                   \
-                                                                               \
-    while (b) {                                                                \
-        if (b & 0x1) {                                                         \
-            res = res ^ a;                                                     \
-        }                                                                      \
-        a = a << 1;                                                            \
-        b = b >> 1;                                                            \
-    }                                                                          \
-    return res;                                                                \
-}
-DEF_GALOIS_MULTIPLY(32, 64)
 
 static S390Vector galois_multiply64(uint64_t a, uint64_t b)
 {
@@ -244,24 +228,24 @@ void HELPER(gvec_vgfma16)(void *v1, const void *v2, const void *v3,
     *(Int128 *)v1 = int128_xor(r, *(Int128 *)v4);
 }
 
-#define DEF_VGFM(BITS, TBITS)                                                  \
-void HELPER(gvec_vgfm##BITS)(void *v1, const void *v2, const void *v3,         \
-                             uint32_t desc)                                    \
-{                                                                              \
-    int i;                                                                     \
-                                                                               \
-    for (i = 0; i < (128 / TBITS); i++) {                                      \
-        uint##BITS##_t a = s390_vec_read_element##BITS(v2, i * 2);             \
-        uint##BITS##_t b = s390_vec_read_element##BITS(v3, i * 2);             \
-        uint##TBITS##_t d = galois_multiply##BITS(a, b);                       \
-                                                                               \
-        a = s390_vec_read_element##BITS(v2, i * 2 + 1);                        \
-        b = s390_vec_read_element##BITS(v3, i * 2 + 1);                        \
-        d = d ^ galois_multiply32(a, b);                                       \
-        s390_vec_write_element##TBITS(v1, i, d);                               \
-    }                                                                          \
+static Int128 do_gfm32(Int128 n, Int128 m)
+{
+    Int128 e = clmul_32x2_even(n, m);
+    Int128 o = clmul_32x2_odd(n, m);
+    return int128_xor(e, o);
+}
+
+void HELPER(gvec_vgfm32)(void *v1, const void *v2, const void *v3, uint32_t d)
+{
+    *(Int128 *)v1 = do_gfm32(*(const Int128 *)v2, *(const Int128 *)v3);
+}
+
+void HELPER(gvec_vgfma32)(void *v1, const void *v2, const void *v3,
+                         const void *v4, uint32_t d)
+{
+    Int128 r = do_gfm32(*(const Int128 *)v2, *(const Int128 *)v3);
+    *(Int128 *)v1 = int128_xor(r, *(Int128 *)v4);
 }
-DEF_VGFM(32, 64)
 
 void HELPER(gvec_vgfm64)(void *v1, const void *v2, const void *v3,
                          uint32_t desc)
@@ -278,26 +262,6 @@ void HELPER(gvec_vgfm64)(void *v1, const void *v2, const void *v3,
     s390_vec_xor(v1, &tmp1, &tmp2);
 }
 
-#define DEF_VGFMA(BITS, TBITS)                                                 \
-void HELPER(gvec_vgfma##BITS)(void *v1, const void *v2, const void *v3,        \
-                              const void *v4, uint32_t desc)                   \
-{                                                                              \
-    int i;                                                                     \
-                                                                               \
-    for (i = 0; i < (128 / TBITS); i++) {                                      \
-        uint##BITS##_t a = s390_vec_read_element##BITS(v2, i * 2);             \
-        uint##BITS##_t b = s390_vec_read_element##BITS(v3, i * 2);             \
-        uint##TBITS##_t d = galois_multiply##BITS(a, b);                       \
-                                                                               \
-        a = s390_vec_read_element##BITS(v2, i * 2 + 1);                        \
-        b = s390_vec_read_element##BITS(v3, i * 2 + 1);                        \
-        d = d ^ galois_multiply32(a, b);                                       \
-        d = d ^ s390_vec_read_element##TBITS(v4, i);                           \
-        s390_vec_write_element##TBITS(v1, i, d);                               \
-    }                                                                          \
-}
-DEF_VGFMA(32, 64)
-
 void HELPER(gvec_vgfma64)(void *v1, const void *v2, const void *v3,
                           const void *v4, uint32_t desc)
 {
-- 
2.34.1



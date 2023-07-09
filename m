Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 78AEF74C72C
	for <lists+qemu-devel@lfdr.de>; Sun,  9 Jul 2023 20:35:51 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qIZEL-0005hX-94; Sun, 09 Jul 2023 14:33:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qIZDp-0003Rw-EY
 for qemu-devel@nongnu.org; Sun, 09 Jul 2023 14:33:26 -0400
Received: from mail-wr1-x42d.google.com ([2a00:1450:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qIZDm-0004D4-QF
 for qemu-devel@nongnu.org; Sun, 09 Jul 2023 14:33:25 -0400
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-313fb7f0f80so3705454f8f.2
 for <qemu-devel@nongnu.org>; Sun, 09 Jul 2023 11:33:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1688927601; x=1691519601;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cKGE3OvFNd5jAIbGE9ocD3KdoxUzDMvYMbDIoK+kebA=;
 b=vScQjbkPhMpo8WTzIasfj9G1DPhrTyZftcLRkAUP3To/+U3FCPZvwizKS8tBbSs5/9
 5U/3xZ91St20qOvWNaqkpAaog6yGfC7lylujnyAMPZUP12aM38w1i7nGooC7UcbJKq5n
 zlX3pWxxd4UUKf279DqlHZ0vPyMTCRXCnUabjecvA9eiX/uYRMbJdN4JdMhDVd4JfMNW
 0BR0fNxUr0GRYbS1xl+ZfUV8N2k4fNSJ//dMRiTZjWIzEkmUIOs9SJopf2CYovFUz+Nk
 LLYWdsRAdN7Ltaj7szvE83pn9/EtQBmQQkUMja4z8kpCpLsF4C/Tkba59X6HhwGnatlb
 AJoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688927601; x=1691519601;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=cKGE3OvFNd5jAIbGE9ocD3KdoxUzDMvYMbDIoK+kebA=;
 b=fPhwvFXsr1DzVc4r/V+hAxEQg9HvtTBzm/xrDOxpl0rKMNVdP3kJpKOBT4CZPZ04X8
 MfpvGiZ1Mr04FIt+n8oN0pP8m8aR8VB9EKJbW3QvXHQA/swmhjtxjS9p5KjorOWwPXR2
 27gVIzCJyX54k6lSru3ItBbxjGSMFcT44ZcZkOcaAYxe0IoCyj0TZRnYaY1p8wb/QRYB
 454K30o4pRUrI//im7xHSugHB9GqJ0NiXH+3JUytbblLTB1cvCj87JbAINBtounSeKno
 z49DaQNK0zN/2Rr2MNtwDymAkR3zty8f5OAmZTrJLRbh4z+MKO4xp8d7hxpoHpl37rTT
 kipQ==
X-Gm-Message-State: ABy/qLbmhmQauQ8SIOpBbFmSBKbYJrBSQDszajzQSVox3OMa0TdCLpPj
 SKq2pBu1D2DwU+9BXw+GXPTiULDhDKm58CMWuMzZuA==
X-Google-Smtp-Source: APBJJlEo05m4JsypabxrrthO3/V/Epi/YGrnKoEj+3XMd7DLq1aBoAuBslMjxQ0S5cVTsczgq8nxJA==
X-Received: by 2002:a5d:4109:0:b0:30f:c1ab:a039 with SMTP id
 l9-20020a5d4109000000b0030fc1aba039mr8156992wrp.40.1688927601477; 
 Sun, 09 Jul 2023 11:33:21 -0700 (PDT)
Received: from stoup.. ([148.252.133.210]) by smtp.gmail.com with ESMTPSA id
 e17-20020a5d4e91000000b0031433760a92sm9635256wru.115.2023.07.09.11.33.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 09 Jul 2023 11:33:21 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: laurent@vivier.eu,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 26/37] target/arm: Use aesdec_ISB_ISR_AK
Date: Sun,  9 Jul 2023 19:29:04 +0100
Message-Id: <20230709182934.309468-53-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230709182934.309468-1-richard.henderson@linaro.org>
References: <20230709182934.309468-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42d;
 envelope-from=richard.henderson@linaro.org; helo=mail-wr1-x42d.google.com
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

This implements the AESD instruction.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/tcg/crypto_helper.c | 37 +++++++++++++++-------------------
 1 file changed, 16 insertions(+), 21 deletions(-)

diff --git a/target/arm/tcg/crypto_helper.c b/target/arm/tcg/crypto_helper.c
index 00f3b21507..d2cb74e7fc 100644
--- a/target/arm/tcg/crypto_helper.c
+++ b/target/arm/tcg/crypto_helper.c
@@ -48,26 +48,6 @@ static void clear_tail_16(void *vd, uint32_t desc)
 
 static const AESState aes_zero = { };
 
-static void do_crypto_aese(uint64_t *rd, uint64_t *rn, uint64_t *rm,
-                           const uint8_t *sbox, const uint8_t *shift)
-{
-    union CRYPTO_STATE rk = { .l = { rm[0], rm[1] } };
-    union CRYPTO_STATE st = { .l = { rn[0], rn[1] } };
-    int i;
-
-    /* xor state vector with round key */
-    rk.l[0] ^= st.l[0];
-    rk.l[1] ^= st.l[1];
-
-    /* combine ShiftRows operation and sbox substitution */
-    for (i = 0; i < 16; i++) {
-        CR_ST_BYTE(st, i) = sbox[CR_ST_BYTE(rk, shift[i])];
-    }
-
-    rd[0] = st.l[0];
-    rd[1] = st.l[1];
-}
-
 void HELPER(crypto_aese)(void *vd, void *vn, void *vm, uint32_t desc)
 {
     intptr_t i, opr_sz = simd_oprsz(desc);
@@ -102,7 +82,22 @@ void HELPER(crypto_aesd)(void *vd, void *vn, void *vm, uint32_t desc)
     intptr_t i, opr_sz = simd_oprsz(desc);
 
     for (i = 0; i < opr_sz; i += 16) {
-        do_crypto_aese(vd + i, vn + i, vm + i, AES_isbox, AES_ishifts);
+        AESState *ad = (AESState *)(vd + i);
+        AESState *st = (AESState *)(vn + i);
+        AESState *rk = (AESState *)(vm + i);
+        AESState t;
+
+        /* Our uint64_t are in the wrong order for big-endian. */
+        if (HOST_BIG_ENDIAN) {
+            t.d[0] = st->d[1] ^ rk->d[1];
+            t.d[1] = st->d[0] ^ rk->d[0];
+            aesdec_ISB_ISR_AK(&t, &t, &aes_zero, false);
+            ad->d[0] = t.d[1];
+            ad->d[1] = t.d[0];
+        } else {
+            t.v = st->v ^ rk->v;
+            aesdec_ISB_ISR_AK(ad, &t, &aes_zero, false);
+        }
     }
     clear_tail(vd, opr_sz, simd_maxsz(desc));
 }
-- 
2.34.1



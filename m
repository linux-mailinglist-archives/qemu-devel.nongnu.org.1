Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 46B8A7459A9
	for <lists+qemu-devel@lfdr.de>; Mon,  3 Jul 2023 12:07:32 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qGGRo-00039m-Op; Mon, 03 Jul 2023 06:06:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qGGRc-00033M-U8
 for qemu-devel@nongnu.org; Mon, 03 Jul 2023 06:06:08 -0400
Received: from mail-wr1-x42e.google.com ([2a00:1450:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qGGRL-0005vf-Cj
 for qemu-devel@nongnu.org; Mon, 03 Jul 2023 06:06:08 -0400
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-3112f5ab0b1so4700798f8f.0
 for <qemu-devel@nongnu.org>; Mon, 03 Jul 2023 03:05:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1688378750; x=1690970750;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=UEsv77WByzgBc2oRedydI0QuEnu20ntgk1P70X2mStE=;
 b=uHiYfhKwnw1I57OcVIqitUWlypy7M1mJKy2Gi3bSQEDUl1aZsd5hUSfUazumXVLdgt
 GxOM3oU+yuEaOnay7X26f8fIa1Gckle9bn8FbdU8p1uwSb3bnKxO/rWVpQl29J15bXwy
 Wvs3pJ0ecXo9C8Qhci1ECN98iFuoBfALN+SmpN2Y7hAUj/lQm6mixz46+ohjWA43KrlO
 GELj/WyLv+IQ22rvqs6UhO1pcHZTCg6G9SuWSBeVD1rmdysI+eZkfbqlc8Uf0tM8nY6h
 JwMeYC4y8FuXC/wO6rG/ajeyioI703PZIRQ7pXN5G53zaD6ffNWd75TZoCzqZKA3TiPL
 FjuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688378750; x=1690970750;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=UEsv77WByzgBc2oRedydI0QuEnu20ntgk1P70X2mStE=;
 b=bkYxBYyv1lUtc6Zad9S7buTIhbDaRIHK/65rh8SRAgLCxsHT4lYTo+7EOvw6ObFtcN
 ek16nukioTQkZlbG3PShZoSvrztEulCCQNi4MWCIUdoHSMFYcN8r1lpQrQBeaLnxCDN/
 uakivEeHYfMM3ysK7lhI/M5QUBX/bwm5yTk6qdWTwG3IW9RQ/LnehcdYwyIhykjWvzRs
 fH8wAjbya8Bn8fgUolyuypFBqGKZdli93NoRikcu+gJBmNmpy8Tynob8QujsKJoU9ZcZ
 HNzLjp8Ydv+p3WTzPGvfIXA56tyioG9TFLxUZY/zs6LuFTCYVoEC8wbgEbHPY7QDX3aj
 bJSQ==
X-Gm-Message-State: ABy/qLYNxf9lRlVnSIoQdGmPcefGSHcCH782psguH8gRc3j6bQS/onBI
 hHqDNgnBGNnHDmmLxL221paxjKmGFPY31B89+diTPA==
X-Google-Smtp-Source: APBJJlHoOhbvt0onrFM6tbP+ySa5ZsNwjXCHli/C7yoaHHJcCnRTwx+GRrNqSEk+F89WZuKcuPfkEQ==
X-Received: by 2002:a5d:4a09:0:b0:30e:3f54:f8c9 with SMTP id
 m9-20020a5d4a09000000b0030e3f54f8c9mr7207560wrq.10.1688378749888; 
 Mon, 03 Jul 2023 03:05:49 -0700 (PDT)
Received: from stoup.home (91.232.79.188.dynamic.jazztel.es. [188.79.232.91])
 by smtp.gmail.com with ESMTPSA id
 t5-20020a05600001c500b00313f7b077fesm18446562wrx.59.2023.07.03.03.05.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 03 Jul 2023 03:05:49 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, qemu-riscv@nongnu.org, pbonzini@redhat.com,
 eduardo@habkost.net, alistair.francis@wdc.com, danielhb413@gmail.com
Subject: [PATCH v4 26/37] target/arm: Use aesdec_ISB_ISR_AK
Date: Mon,  3 Jul 2023 12:05:09 +0200
Message-Id: <20230703100520.68224-27-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230703100520.68224-1-richard.henderson@linaro.org>
References: <20230703100520.68224-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42e;
 envelope-from=richard.henderson@linaro.org; helo=mail-wr1-x42e.google.com
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



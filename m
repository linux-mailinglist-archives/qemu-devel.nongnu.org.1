Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A87874C498
	for <lists+qemu-devel@lfdr.de>; Sun,  9 Jul 2023 16:04:48 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qIUxl-0000gT-8T; Sun, 09 Jul 2023 10:00:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qIUxQ-0000PH-JQ
 for qemu-devel@nongnu.org; Sun, 09 Jul 2023 10:00:14 -0400
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qIUxO-0000dJ-E8
 for qemu-devel@nongnu.org; Sun, 09 Jul 2023 10:00:12 -0400
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-3fbea147034so35694255e9.0
 for <qemu-devel@nongnu.org>; Sun, 09 Jul 2023 07:00:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1688911209; x=1691503209;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=WbTpqwootsmsPZFIj0kNAknK91pBd8Tm6VoiJxSZmAw=;
 b=DLH8AVOB+Kbf2T9BvjL8HKP8Z4LuOpOXU8oxj3KLezrQOsU4Wft2YualdYKMPHYyuA
 7DcXmsh+QZ/sKV8En9BjcGi4EORWKtIO7vLObXSCgUSBccF8cSpLa/yLobektUWR8Oyv
 iqxfaBXkzDzQHpclimc8mPicXeXE6ei0w+kwuW9dKS8YEvFmbchLdaicdpdD+RQ+p3bw
 TgeV4eYUIT0jzMMki8T2AxWVeR32EXefo6qj3ShGu7pkjia1DAe6IPCAJn87VenxZqye
 0sbFmPbfQeDCmZUVpJ28jHYeb/EogNCvkcUHFeWAg2MLDGob04hHxtDGB/LhRc3kVy/h
 rOmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688911209; x=1691503209;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=WbTpqwootsmsPZFIj0kNAknK91pBd8Tm6VoiJxSZmAw=;
 b=Xxw4pZ+itXxX2txVJXtumtLMvGYEevurBmV4lP5McBiQsZYjd3Vjf//bM2AEGuEFxF
 AG1cYphtDlJSvynIJZPt5X46jH1mHKlEeQTDNbJkfz8WA+tXQ6VB0xacd/fXc/S9cAL5
 WRIQEM+yUbCrskMe8tXh9GHeHvE4CLgu+3iF28IE3REVw3sx1VcO608us5t13VSudj9R
 FSyy6ZpmlOoOwsg/YqH9OdUpIZYilZxMj2hgz5sff/GtiQaVE8gG9TmcU1gV1C5twyRZ
 ZkCOQg0tNBm7kBY2gJRUFNE6M/kx+uq/4j1drqai4rTV09sUvgvX0jvwGQ7034yVWwtY
 ACjg==
X-Gm-Message-State: ABy/qLYJGC+KJqobf0n/5MkEikzeeXyk7g3FgpuCH1xqaqP9qsLGiBTV
 wYhBcVs53kT4cjZUSXS0KVWU1taf9L3N7U013OByFw==
X-Google-Smtp-Source: APBJJlFXD5rvG82nXkgvNrqWTx5Jkh4Gg6tt/2vs6DhzzDHsU6X0t3QKw7+VmA8sIXY30JeHQVh3hA==
X-Received: by 2002:a1c:4b18:0:b0:3fb:ab76:164b with SMTP id
 y24-20020a1c4b18000000b003fbab76164bmr8136449wma.13.1688911209192; 
 Sun, 09 Jul 2023 07:00:09 -0700 (PDT)
Received: from stoup.. ([148.252.133.210]) by smtp.gmail.com with ESMTPSA id
 v18-20020a5d6792000000b003063a92bbf5sm9239422wru.70.2023.07.09.07.00.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 09 Jul 2023 07:00:08 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 25/37] target/arm: Use aesenc_SB_SR_AK
Date: Sun,  9 Jul 2023 14:59:33 +0100
Message-Id: <20230709135945.250311-26-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230709135945.250311-1-richard.henderson@linaro.org>
References: <20230709135945.250311-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=richard.henderson@linaro.org; helo=mail-wm1-x32f.google.com
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

This implements the AESE instruction.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/tcg/crypto_helper.c | 24 +++++++++++++++++++++++-
 1 file changed, 23 insertions(+), 1 deletion(-)

diff --git a/target/arm/tcg/crypto_helper.c b/target/arm/tcg/crypto_helper.c
index 75882d9ea3..00f3b21507 100644
--- a/target/arm/tcg/crypto_helper.c
+++ b/target/arm/tcg/crypto_helper.c
@@ -15,6 +15,7 @@
 #include "exec/helper-proto.h"
 #include "tcg/tcg-gvec-desc.h"
 #include "crypto/aes.h"
+#include "crypto/aes-round.h"
 #include "crypto/sm4.h"
 #include "vec_internal.h"
 
@@ -45,6 +46,8 @@ static void clear_tail_16(void *vd, uint32_t desc)
     clear_tail(vd, opr_sz, max_sz);
 }
 
+static const AESState aes_zero = { };
+
 static void do_crypto_aese(uint64_t *rd, uint64_t *rn, uint64_t *rm,
                            const uint8_t *sbox, const uint8_t *shift)
 {
@@ -70,7 +73,26 @@ void HELPER(crypto_aese)(void *vd, void *vn, void *vm, uint32_t desc)
     intptr_t i, opr_sz = simd_oprsz(desc);
 
     for (i = 0; i < opr_sz; i += 16) {
-        do_crypto_aese(vd + i, vn + i, vm + i, AES_sbox, AES_shifts);
+        AESState *ad = (AESState *)(vd + i);
+        AESState *st = (AESState *)(vn + i);
+        AESState *rk = (AESState *)(vm + i);
+        AESState t;
+
+        /*
+         * Our uint64_t are in the wrong order for big-endian.
+         * The Arm AddRoundKey comes first, while the API AddRoundKey
+         * comes last: perform the xor here, and provide zero to API.
+         */
+        if (HOST_BIG_ENDIAN) {
+            t.d[0] = st->d[1] ^ rk->d[1];
+            t.d[1] = st->d[0] ^ rk->d[0];
+            aesenc_SB_SR_AK(&t, &t, &aes_zero, false);
+            ad->d[0] = t.d[1];
+            ad->d[1] = t.d[0];
+        } else {
+            t.v = st->v ^ rk->v;
+            aesenc_SB_SR_AK(ad, &t, &aes_zero, false);
+        }
     }
     clear_tail(vd, opr_sz, simd_maxsz(desc));
 }
-- 
2.34.1



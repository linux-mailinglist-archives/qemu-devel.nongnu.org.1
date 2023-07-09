Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 03C8B74C492
	for <lists+qemu-devel@lfdr.de>; Sun,  9 Jul 2023 16:04:01 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qIUxh-0000Xx-FE; Sun, 09 Jul 2023 10:00:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qIUxW-0000T5-EJ
 for qemu-devel@nongnu.org; Sun, 09 Jul 2023 10:00:18 -0400
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qIUxQ-0000dl-Bz
 for qemu-devel@nongnu.org; Sun, 09 Jul 2023 10:00:18 -0400
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-3fbc77e76abso37949465e9.1
 for <qemu-devel@nongnu.org>; Sun, 09 Jul 2023 07:00:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1688911211; x=1691503211;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8HOx1ZLKzsBUTcaboEy/mBqeLFtnDXaBWlHTAqwIG7M=;
 b=q6pgoeLNe2MpDLDUL8FnIdFIT/TMSQlxkBLvAbt6dVm/abqqf5RwCKSpMl+k0vTRCO
 WkFzzp+Nn0BgtdL7peqfGiIE9ef8DSCVA/x9L53Fnq70kNP3SnrUqtpf/A/GtFMUp1v0
 T6ChgfLCRA2MsJ0wWYYXRu5jBgV9x/p0cmpydTmLZCEdLdKhvgzpyo3OUV/QZGQ972fE
 xrE/ivEMUUFIvk1tpvYK8e4zpX6UsuMciElemUIRZBNwRnhKwRn2ygx4JdR+vXuMa4an
 xWre+qsb8VynQrEBzkvOgkGg0LCj1THRCNdqiOCePXsL4xB98Jj4+Vubsb1S5LDTPgS5
 a1EQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688911211; x=1691503211;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=8HOx1ZLKzsBUTcaboEy/mBqeLFtnDXaBWlHTAqwIG7M=;
 b=ho/J80NVJPQsa7Db5Sl74z6JqgfkCR3DekI0d4caQCFRkkXzJtQjhdwNa17TS4UOf1
 ReReSAO658yt4ntF9LXWCpjdTFaGj1lSNFf0kupyG0Ycb1GgZOYI3u5Bjw1i4K72jPYu
 0upLG++/o4hyRJWFS9tZIf0r94ttiylPqfpr6PlHmF9E4gfrm0CVk7M56QmJlGxleBTc
 Fnd+quN6hC9cMm1oIR9uMI3GZjYFtUtRztb5v6cukBtKhjLIMY90/rBBT+8iSTnAhy7P
 ThavEhSILIv6KIHHJzMNFGebeVyC/p72SV4FZ9q7i7s5hibDTu9gvPS3VQeQE6jj7Tz6
 C+uw==
X-Gm-Message-State: ABy/qLY5kTuaaTXRJaDQJqQqVHbJahjLF+7Xxq9oWMNXK5/9/q1NOrr0
 V3fUPh7RvvKi0ya1ObxjOklJOW1ftUGsMTKKGleYyQ==
X-Google-Smtp-Source: APBJJlEvs2fu3xhicoX3gscVtwonucd0Bpp/KdrHmg0x40+LPPbQWuLdtK+4zsnYXYyPTgnyEKFaBw==
X-Received: by 2002:a05:600c:29a:b0:3fb:abd0:2b52 with SMTP id
 26-20020a05600c029a00b003fbabd02b52mr8285896wmk.13.1688911210816; 
 Sun, 09 Jul 2023 07:00:10 -0700 (PDT)
Received: from stoup.. ([148.252.133.210]) by smtp.gmail.com with ESMTPSA id
 v18-20020a5d6792000000b003063a92bbf5sm9239422wru.70.2023.07.09.07.00.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 09 Jul 2023 07:00:10 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 27/37] target/arm: Use aesenc_MC
Date: Sun,  9 Jul 2023 14:59:35 +0100
Message-Id: <20230709135945.250311-28-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230709135945.250311-1-richard.henderson@linaro.org>
References: <20230709135945.250311-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=richard.henderson@linaro.org; helo=mail-wm1-x333.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, T_SCC_BODY_TEXT_LINE=-0.01,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

This implements the AESMC instruction.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/tcg/crypto_helper.c | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/target/arm/tcg/crypto_helper.c b/target/arm/tcg/crypto_helper.c
index d2cb74e7fc..1952aaac58 100644
--- a/target/arm/tcg/crypto_helper.c
+++ b/target/arm/tcg/crypto_helper.c
@@ -124,7 +124,20 @@ void HELPER(crypto_aesmc)(void *vd, void *vm, uint32_t desc)
     intptr_t i, opr_sz = simd_oprsz(desc);
 
     for (i = 0; i < opr_sz; i += 16) {
-        do_crypto_aesmc(vd + i, vm + i, AES_mc_rot);
+        AESState *ad = (AESState *)(vd + i);
+        AESState *st = (AESState *)(vm + i);
+        AESState t;
+
+        /* Our uint64_t are in the wrong order for big-endian. */
+        if (HOST_BIG_ENDIAN) {
+            t.d[0] = st->d[1];
+            t.d[1] = st->d[0];
+            aesenc_MC(&t, &t, false);
+            ad->d[0] = t.d[1];
+            ad->d[1] = t.d[0];
+        } else {
+            aesenc_MC(ad, st, false);
+        }
     }
     clear_tail(vd, opr_sz, simd_maxsz(desc));
 }
-- 
2.34.1



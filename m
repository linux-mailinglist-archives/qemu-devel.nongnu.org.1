Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C34AE74C47E
	for <lists+qemu-devel@lfdr.de>; Sun,  9 Jul 2023 16:01:08 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qIUxd-0000TZ-9r; Sun, 09 Jul 2023 10:00:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qIUxB-0000LC-Ff
 for qemu-devel@nongnu.org; Sun, 09 Jul 2023 09:59:57 -0400
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qIUx9-0000N2-P3
 for qemu-devel@nongnu.org; Sun, 09 Jul 2023 09:59:57 -0400
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-31297125334so2719193f8f.0
 for <qemu-devel@nongnu.org>; Sun, 09 Jul 2023 06:59:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1688911194; x=1691503194;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1lNVmzIrZ20vaRM4z3bBKO9neuQ8i1reH4ftvygdvPI=;
 b=ylW6zMUZJDPODhE3mjOZt0HFrZeDCOvVVrSD+eWDuCSjVaFtg2uuEZvRG9q9cagbGz
 xrsRwHezE60v7YyPtaH31lzGPIReo0Jl5MkAM+9Nt43hFTtCkg8yYz5NofL+oiAkWwxN
 T6UbSfJ8d6ED4LCiEERZkt6PdEVCgdZt+HJeD5FI4FtNhQ1MnU9zhwD+HgCOIwNdsX+s
 Vq0cXvOHGWGHOp+c2512wuY0SU/jScX3EyXDC/4kaILGMGs7F+yDHXca+Y1Y2CoHrVoF
 9zE+wKvY8ISdwgEt5CfU1FCoEVwTYiUCMtInZpyNLl7htFuaVC1slp4XXiZfd2qnXUrV
 ZLgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688911194; x=1691503194;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=1lNVmzIrZ20vaRM4z3bBKO9neuQ8i1reH4ftvygdvPI=;
 b=df9P41OTDwZtcG6WLBy4wgQQiacj+AoYG2/pU+jB+MvtW742GSuGZKEDhgvKDiJR9m
 00zAvaAq+zdPbFiwNftFquEGfMl0QHPkJdAibpiQDdeNS0LJadmQ0XlqGAXx2T7dbd8K
 wWjuDT4BpOuPx+DLzEcD/GhMXiXPjp4CkYsZ3YHALtuMNQA2v4tv1oZXhnkVVs+xeO++
 7+b6g5jopgu4YzCgoDo78/eNa49lyb0Q6b8TMQOjTSgkPBiiRKvCFzL344RKxWWuAaEU
 fUVYH/itnqXox+QhjwTEhDaEAOj/tFfyTj3GcxKAmHW/r8KrcAUqiXRObczRrbI2jp+L
 g6bQ==
X-Gm-Message-State: ABy/qLYefEoat2pa/DbttpNdAyvw9bFEJ1Ml5AyAmBIzMnTzvKYZk0KX
 I5BOgczDUpdiZm3YxVdsj7p9/H2fV5RhtBWMI01qdg==
X-Google-Smtp-Source: APBJJlFCxdlLqc3UWo/fo0VgFZ9HnDiyuDOluyNFGgaj9M+qmxvjQc/En3P3gzMCqLTyf/M5COlB7A==
X-Received: by 2002:adf:fd44:0:b0:313:ebf3:850b with SMTP id
 h4-20020adffd44000000b00313ebf3850bmr11883810wrs.2.1688911194224; 
 Sun, 09 Jul 2023 06:59:54 -0700 (PDT)
Received: from stoup.. ([148.252.133.210]) by smtp.gmail.com with ESMTPSA id
 v18-20020a5d6792000000b003063a92bbf5sm9239422wru.70.2023.07.09.06.59.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 09 Jul 2023 06:59:53 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PULL 08/37] crypto: Add aesdec_IMC
Date: Sun,  9 Jul 2023 14:59:16 +0100
Message-Id: <20230709135945.250311-9-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230709135945.250311-1-richard.henderson@linaro.org>
References: <20230709135945.250311-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42b;
 envelope-from=richard.henderson@linaro.org; helo=mail-wr1-x42b.google.com
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

Add a primitive for InvMixColumns.

Acked-by: Daniel P. Berrangé <berrange@redhat.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 host/include/generic/host/crypto/aes-round.h |  2 +
 include/crypto/aes-round.h                   | 18 ++++++
 crypto/aes.c                                 | 59 ++++++++++++++++++++
 3 files changed, 79 insertions(+)

diff --git a/host/include/generic/host/crypto/aes-round.h b/host/include/generic/host/crypto/aes-round.h
index 1b82afc629..335ec3f11e 100644
--- a/host/include/generic/host/crypto/aes-round.h
+++ b/host/include/generic/host/crypto/aes-round.h
@@ -15,6 +15,8 @@ void aesenc_SB_SR_AK_accel(AESState *, const AESState *,
                            const AESState *, bool)
     QEMU_ERROR("unsupported accel");
 
+void aesdec_IMC_accel(AESState *, const AESState *, bool)
+    QEMU_ERROR("unsupported accel");
 void aesdec_ISB_ISR_AK_accel(AESState *, const AESState *,
                              const AESState *, bool)
     QEMU_ERROR("unsupported accel");
diff --git a/include/crypto/aes-round.h b/include/crypto/aes-round.h
index 7d2be40a67..7be2cc0d8e 100644
--- a/include/crypto/aes-round.h
+++ b/include/crypto/aes-round.h
@@ -59,6 +59,24 @@ static inline void aesenc_SB_SR_AK(AESState *r, const AESState *st,
     }
 }
 
+/*
+ * Perform InvMixColumns.
+ */
+
+void aesdec_IMC_gen(AESState *ret, const AESState *st);
+void aesdec_IMC_genrev(AESState *ret, const AESState *st);
+
+static inline void aesdec_IMC(AESState *r, const AESState *st, bool be)
+{
+    if (HAVE_AES_ACCEL) {
+        aesdec_IMC_accel(r, st, be);
+    } else if (HOST_BIG_ENDIAN == be) {
+        aesdec_IMC_gen(r, st);
+    } else {
+        aesdec_IMC_genrev(r, st);
+    }
+}
+
 /*
  * Perform InvSubBytes + InvShiftRows + AddRoundKey.
  */
diff --git a/crypto/aes.c b/crypto/aes.c
index ec300cda0c..6c05d731f4 100644
--- a/crypto/aes.c
+++ b/crypto/aes.c
@@ -1322,6 +1322,65 @@ void aesenc_SB_SR_AK_genrev(AESState *r, const AESState *s, const AESState *k)
     aesenc_SB_SR_AK_swap(r, s, k, true);
 }
 
+/*
+ * Perform InvMixColumns.
+ */
+static inline void
+aesdec_IMC_swap(AESState *r, const AESState *st, bool swap)
+{
+    int swap_b = swap * 0xf;
+    int swap_w = swap * 0x3;
+    bool be = HOST_BIG_ENDIAN ^ swap;
+    uint32_t t;
+
+    /* Note that AES_imc is encoded for big-endian. */
+    t = (AES_imc[st->b[swap_b ^ 0x0]][0] ^
+         AES_imc[st->b[swap_b ^ 0x1]][1] ^
+         AES_imc[st->b[swap_b ^ 0x2]][2] ^
+         AES_imc[st->b[swap_b ^ 0x3]][3]);
+    if (!be) {
+        t = bswap32(t);
+    }
+    r->w[swap_w ^ 0] = t;
+
+    t = (AES_imc[st->b[swap_b ^ 0x4]][0] ^
+         AES_imc[st->b[swap_b ^ 0x5]][1] ^
+         AES_imc[st->b[swap_b ^ 0x6]][2] ^
+         AES_imc[st->b[swap_b ^ 0x7]][3]);
+    if (!be) {
+        t = bswap32(t);
+    }
+    r->w[swap_w ^ 1] = t;
+
+    t = (AES_imc[st->b[swap_b ^ 0x8]][0] ^
+         AES_imc[st->b[swap_b ^ 0x9]][1] ^
+         AES_imc[st->b[swap_b ^ 0xA]][2] ^
+         AES_imc[st->b[swap_b ^ 0xB]][3]);
+    if (!be) {
+        t = bswap32(t);
+    }
+    r->w[swap_w ^ 2] = t;
+
+    t = (AES_imc[st->b[swap_b ^ 0xC]][0] ^
+         AES_imc[st->b[swap_b ^ 0xD]][1] ^
+         AES_imc[st->b[swap_b ^ 0xE]][2] ^
+         AES_imc[st->b[swap_b ^ 0xF]][3]);
+    if (!be) {
+        t = bswap32(t);
+    }
+    r->w[swap_w ^ 3] = t;
+}
+
+void aesdec_IMC_gen(AESState *r, const AESState *st)
+{
+    aesdec_IMC_swap(r, st, false);
+}
+
+void aesdec_IMC_genrev(AESState *r, const AESState *st)
+{
+    aesdec_IMC_swap(r, st, true);
+}
+
 /*
  * Perform InvSubBytes + InvShiftRows + AddRoundKey.
  */
-- 
2.34.1



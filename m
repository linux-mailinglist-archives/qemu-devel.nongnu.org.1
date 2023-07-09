Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D3AD974C710
	for <lists+qemu-devel@lfdr.de>; Sun,  9 Jul 2023 20:32:40 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qIZAV-0008JT-OD; Sun, 09 Jul 2023 14:29:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qIZAT-0008Iy-HH
 for qemu-devel@nongnu.org; Sun, 09 Jul 2023 14:29:57 -0400
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qIZAR-0000Hg-TP
 for qemu-devel@nongnu.org; Sun, 09 Jul 2023 14:29:57 -0400
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-3fbea14706eso37891745e9.2
 for <qemu-devel@nongnu.org>; Sun, 09 Jul 2023 11:29:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1688927394; x=1691519394;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/QBtvBQSI1Tt7HA/Hos/l3dVZOAq+hVRSg1lIqyT39k=;
 b=LPVTtHy8rS0l+ARnT9UwhpqFth+8dMEaFGITPAGTXV4iU/+GU903B+EplpYbjnpfMb
 pCNOpXlSVX3CKecuXOheldX1fxwIZl+91nR6enZjgkcpkX+OcrTx4oAPBmrcHJncJZdw
 k5565BT8poZE1j+4mJC8NpndqouedIAZ63Zo0KZtgMTkp6QzAdgwReCEw1Q57Y0GKuKM
 Y9HROJMr1godTBObRmKd4T4jwGikCm/i9C+6AUzsUHc+zaps11457Vlu2iJdlTvR/Wip
 Dqd1s4vsfpvNHxy98TiiPlnS2p+/SDc4PvHv5fG6zEnq30T5JZPzqxZYqsuJUJuHPbGf
 XJTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688927394; x=1691519394;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/QBtvBQSI1Tt7HA/Hos/l3dVZOAq+hVRSg1lIqyT39k=;
 b=LfEkOFwGIP+VwKnc8NrgG6cGfZ8l0a4BXcMYX+3biuZNSZH5gLw2PqS0kto9GYkKUV
 WIjolqwfbUeoSuW/9wZFBcc6K/r+YnAVYbX2o/OCWuXAM0w30fmNwOf7+zz/gbhTlbm6
 P/c7kWa1qQzyJY23mei6w454INgpMEPo3x6e/9tzECYedBd3KNPIoZZtu1KcvpMn0JAl
 1dty8ERU+ucJ4t8rZCTTeDNBsoAIhR3ZHdP9DlYVSovwA+Uo/ykZ6w469KP42XpR6mhx
 qkqzDUnJh3x0ZUMk0KbheRW8WNDlJ3FffbJbpMZKCgCoUShNbovZAsLxbZ3RLbcot3pF
 jFVQ==
X-Gm-Message-State: ABy/qLYMGB+SPPm2gMaHKvt6u/kmrWcC+KIZLrzzmS0ZrnWhce2YSQR3
 INaubJwoE597kEjV2GPANmdYu5jM8THRLhf5S/YVzA==
X-Google-Smtp-Source: APBJJlHGkO2QN5AyRqwxpMxuq8D49l/ev76BPn3MmtgW41BjPWfqjt2FDfH2Om82lRWBUV8d58SgKw==
X-Received: by 2002:a05:600c:234b:b0:3fc:dd9:91fd with SMTP id
 11-20020a05600c234b00b003fc0dd991fdmr1707665wmq.40.1688927394581; 
 Sun, 09 Jul 2023 11:29:54 -0700 (PDT)
Received: from stoup.. ([148.252.133.210]) by smtp.gmail.com with ESMTPSA id
 q15-20020a7bce8f000000b003fbe791a0e8sm8317108wmj.0.2023.07.09.11.29.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 09 Jul 2023 11:29:54 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: laurent@vivier.eu,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 11/37] crypto: Add aesdec_ISB_ISR_AK_IMC
Date: Sun,  9 Jul 2023 19:28:33 +0100
Message-Id: <20230709182934.309468-22-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230709182934.309468-1-richard.henderson@linaro.org>
References: <20230709182934.309468-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=richard.henderson@linaro.org; helo=mail-wm1-x336.google.com
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

Add a primitive for InvSubBytes + InvShiftRows +
AddRoundKey + InvMixColumns.

Acked-by: Daniel P. Berrangé <berrange@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 host/include/generic/host/crypto/aes-round.h |  3 +++
 include/crypto/aes-round.h                   | 21 ++++++++++++++++++++
 crypto/aes.c                                 | 14 +++++++++++++
 3 files changed, 38 insertions(+)

diff --git a/host/include/generic/host/crypto/aes-round.h b/host/include/generic/host/crypto/aes-round.h
index db8cfe17eb..1b9720f917 100644
--- a/host/include/generic/host/crypto/aes-round.h
+++ b/host/include/generic/host/crypto/aes-round.h
@@ -23,6 +23,9 @@ void aesdec_IMC_accel(AESState *, const AESState *, bool)
 void aesdec_ISB_ISR_AK_accel(AESState *, const AESState *,
                              const AESState *, bool)
     QEMU_ERROR("unsupported accel");
+void aesdec_ISB_ISR_AK_IMC_accel(AESState *, const AESState *,
+                                 const AESState *, bool)
+    QEMU_ERROR("unsupported accel");
 void aesdec_ISB_ISR_IMC_AK_accel(AESState *, const AESState *,
                                  const AESState *, bool)
     QEMU_ERROR("unsupported accel");
diff --git a/include/crypto/aes-round.h b/include/crypto/aes-round.h
index 9996f1c219..854fb0966a 100644
--- a/include/crypto/aes-round.h
+++ b/include/crypto/aes-round.h
@@ -119,6 +119,27 @@ static inline void aesdec_ISB_ISR_AK(AESState *r, const AESState *st,
     }
 }
 
+/*
+ * Perform InvSubBytes + InvShiftRows + AddRoundKey + InvMixColumns.
+ */
+
+void aesdec_ISB_ISR_AK_IMC_gen(AESState *ret, const AESState *st,
+                               const AESState *rk);
+void aesdec_ISB_ISR_AK_IMC_genrev(AESState *ret, const AESState *st,
+                                  const AESState *rk);
+
+static inline void aesdec_ISB_ISR_AK_IMC(AESState *r, const AESState *st,
+                                         const AESState *rk, bool be)
+{
+    if (HAVE_AES_ACCEL) {
+        aesdec_ISB_ISR_AK_IMC_accel(r, st, rk, be);
+    } else if (HOST_BIG_ENDIAN == be) {
+        aesdec_ISB_ISR_AK_IMC_gen(r, st, rk);
+    } else {
+        aesdec_ISB_ISR_AK_IMC_genrev(r, st, rk);
+    }
+}
+
 /*
  * Perform InvSubBytes + InvShiftRows + InvMixColumns + AddRoundKey.
  */
diff --git a/crypto/aes.c b/crypto/aes.c
index c2546ef12e..c765f11c1e 100644
--- a/crypto/aes.c
+++ b/crypto/aes.c
@@ -1542,6 +1542,20 @@ void aesdec_ISB_ISR_IMC_AK_genrev(AESState *r, const AESState *st,
     aesdec_ISB_ISR_IMC_AK_swap(r, st, rk, true);
 }
 
+void aesdec_ISB_ISR_AK_IMC_gen(AESState *ret, const AESState *st,
+                               const AESState *rk)
+{
+    aesdec_ISB_ISR_AK_gen(ret, st, rk);
+    aesdec_IMC_gen(ret, ret);
+}
+
+void aesdec_ISB_ISR_AK_IMC_genrev(AESState *ret, const AESState *st,
+                                  const AESState *rk)
+{
+    aesdec_ISB_ISR_AK_genrev(ret, st, rk);
+    aesdec_IMC_genrev(ret, ret);
+}
+
 /**
  * Expand the cipher key into the encryption key schedule.
  */
-- 
2.34.1



Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7529D740283
	for <lists+qemu-devel@lfdr.de>; Tue, 27 Jun 2023 19:47:35 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qECmV-0002Zo-0U; Tue, 27 Jun 2023 13:47:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <max.chou@sifive.com>)
 id 1qECmS-0002V2-Mx
 for qemu-devel@nongnu.org; Tue, 27 Jun 2023 13:47:08 -0400
Received: from mail-pg1-x52f.google.com ([2607:f8b0:4864:20::52f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <max.chou@sifive.com>)
 id 1qECmQ-00057Q-7n
 for qemu-devel@nongnu.org; Tue, 27 Jun 2023 13:47:08 -0400
Received: by mail-pg1-x52f.google.com with SMTP id
 41be03b00d2f7-557790487feso3334891a12.0
 for <qemu-devel@nongnu.org>; Tue, 27 Jun 2023 10:47:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1687888025; x=1690480025;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=b2i4C//+f+GUGaLVpvFtKlZSxEtNqEo8pMI1bJM7rlM=;
 b=J5sR0G4TYUF4RHc4V1R8rnIYxZlzAkse8OzwHwpF7tlVajYQkXWhTpyqiRqK35suLJ
 odfkdtvIe/2R6Iapq0Wf0MNMJvk/P2Z74cZHQJ1f5PtVcry39jz4h30ewR5dzgE3722y
 WUvh+o1V4w4oTiDsYo+AAmu46wIZZFtoNV7+u+jUbZIbNyQqJGj1lFL8CIj4NzSK4fLz
 OxpkSonArBYQktMl/P+LbwwiHMD/J0GNktDHiDTjd6durZhh3Ot9PNDyOZJ5YsZTmIbU
 Dtdf6Xo2F/rEStCdULY2RVNgOOpC3HRjcrbGUR2a+Ls+htJsUT8HSKKlH+k5E/YPUBj6
 Q/vA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687888025; x=1690480025;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=b2i4C//+f+GUGaLVpvFtKlZSxEtNqEo8pMI1bJM7rlM=;
 b=WMqVKV+HJfdPFo089c386FoR3LOwYfh4H5e/2rggFtLeJRei/+4xiMVPEoaqoo/USm
 hml1nbMja9O6L2vK1uPIv3ETe5EFGV8wsFkAhPWLLVBHuhNQeUB8FRTcH2Su00ZnAEQR
 WIJA929CmPMfdoP85VYHwnWDcXTTU/WJDQH5J+vFXMqMObIvfoebMBxYFJFjAR4W+r5Y
 YwY3tEz3BFRTXAbn2A0qYwzyh+ZqdzA1i5GMoxZZMPmG94g+wrCSoIpxRlm5C34RBI6n
 MhjhwBUSy3+dmF/q6AG0jTVk0qvh/eXx3K2ysXKWMITjMfCVogtBz/ur6dMcsdGqgpAc
 Ftlw==
X-Gm-Message-State: AC+VfDxI9bVHLBNFBJGx+W6R4sVFh7/biJGMv9lZjYSKP60MUCkVvdmL
 xThkV3kDTSot+W8/zKbijEmQHxm3wdR76uGQunX7+wRCTjEuZi8GFZBrLE02wE2NzJi4NOOjVl2
 y7BQRHBr4D1unVqRzy1GNRBDbSzatM9lLqORMmiO4pXJSauPJkkE11a0B3o/CaoS96LEE5YVv3p
 D3TK8=
X-Google-Smtp-Source: ACHHUZ4gyy3qxOAJ80P65YRSOF3OjLLQ9DijIiznyN/R5N9aSlcchQ/c2cuxkhNP3iev4nqxWhj5qA==
X-Received: by 2002:a05:6a20:430c:b0:11d:2b0c:7f32 with SMTP id
 h12-20020a056a20430c00b0011d2b0c7f32mr41607143pzk.13.1687888024602; 
 Tue, 27 Jun 2023 10:47:04 -0700 (PDT)
Received: from MaxdeMBP.localdomain (125-228-20-175.hinet-ip.hinet.net.
 [125.228.20.175]) by smtp.gmail.com with ESMTPSA id
 i9-20020aa78b49000000b00666e883757fsm5705144pfd.123.2023.06.27.10.47.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 Jun 2023 10:47:04 -0700 (PDT)
From: Max Chou <max.chou@sifive.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Cc: dbarboza@ventanamicro.com, Max Chou <max.chou@sifive.com>,
 Frank Chang <frank.chang@sifive.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org
Subject: [PATCH v6 13/15] crypto: Create sm4_subword
Date: Wed, 28 Jun 2023 01:45:47 +0800
Message-Id: <20230627174551.65498-14-max.chou@sifive.com>
X-Mailer: git-send-email 2.39.2 (Apple Git-143)
In-Reply-To: <20230627174551.65498-1-max.chou@sifive.com>
References: <20230627174551.65498-1-max.chou@sifive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52f;
 envelope-from=max.chou@sifive.com; helo=mail-pg1-x52f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

Allows sharing of sm4_subword between different targets.

Signed-off-by: Max Chou <max.chou@sifive.com>
Reviewed-by: Frank Chang <frank.chang@sifive.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Max Chou <max.chou@sifive.com>
---
 include/crypto/sm4.h           |  8 ++++++++
 target/arm/tcg/crypto_helper.c | 10 ++--------
 2 files changed, 10 insertions(+), 8 deletions(-)

diff --git a/include/crypto/sm4.h b/include/crypto/sm4.h
index 9bd3ebc62e..de8245d8a7 100644
--- a/include/crypto/sm4.h
+++ b/include/crypto/sm4.h
@@ -3,4 +3,12 @@
 
 extern const uint8_t sm4_sbox[256];
 
+static inline uint32_t sm4_subword(uint32_t word)
+{
+    return sm4_sbox[word & 0xff] |
+           sm4_sbox[(word >> 8) & 0xff] << 8 |
+           sm4_sbox[(word >> 16) & 0xff] << 16 |
+           sm4_sbox[(word >> 24) & 0xff] << 24;
+}
+
 #endif
diff --git a/target/arm/tcg/crypto_helper.c b/target/arm/tcg/crypto_helper.c
index fdd70abbfd..7cadd61e12 100644
--- a/target/arm/tcg/crypto_helper.c
+++ b/target/arm/tcg/crypto_helper.c
@@ -614,10 +614,7 @@ static void do_crypto_sm4e(uint64_t *rd, uint64_t *rn, uint64_t *rm)
             CR_ST_WORD(d, (i + 3) % 4) ^
             CR_ST_WORD(n, i);
 
-        t = sm4_sbox[t & 0xff] |
-            sm4_sbox[(t >> 8) & 0xff] << 8 |
-            sm4_sbox[(t >> 16) & 0xff] << 16 |
-            sm4_sbox[(t >> 24) & 0xff] << 24;
+        t = sm4_subword(t);
 
         CR_ST_WORD(d, i) ^= t ^ rol32(t, 2) ^ rol32(t, 10) ^ rol32(t, 18) ^
                             rol32(t, 24);
@@ -651,10 +648,7 @@ static void do_crypto_sm4ekey(uint64_t *rd, uint64_t *rn, uint64_t *rm)
             CR_ST_WORD(d, (i + 3) % 4) ^
             CR_ST_WORD(m, i);
 
-        t = sm4_sbox[t & 0xff] |
-            sm4_sbox[(t >> 8) & 0xff] << 8 |
-            sm4_sbox[(t >> 16) & 0xff] << 16 |
-            sm4_sbox[(t >> 24) & 0xff] << 24;
+        t = sm4_subword(t);
 
         CR_ST_WORD(d, i) ^= t ^ rol32(t, 13) ^ rol32(t, 23);
     }
-- 
2.31.1



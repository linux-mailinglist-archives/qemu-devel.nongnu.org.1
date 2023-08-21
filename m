Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CAE0782E3F
	for <lists+qemu-devel@lfdr.de>; Mon, 21 Aug 2023 18:20:08 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qY7co-0001hG-M7; Mon, 21 Aug 2023 12:19:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qY7cR-0001Uo-7N
 for qemu-devel@nongnu.org; Mon, 21 Aug 2023 12:19:07 -0400
Received: from mail-pl1-x62d.google.com ([2607:f8b0:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qY7cP-0005cf-4U
 for qemu-devel@nongnu.org; Mon, 21 Aug 2023 12:19:06 -0400
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-1bf3a2f4528so25023195ad.2
 for <qemu-devel@nongnu.org>; Mon, 21 Aug 2023 09:19:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1692634744; x=1693239544;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=OchzeURE1BgR8OyI+34sloHIxez963wM6RFcZPAc55w=;
 b=d1omPxXOeye7RcxrOdZL+G8JdUouonOh3dnmZqblNK337xdPX9R2FMrMh+PlLAkpxB
 KKmfGJ8D7cHVZyawOJhy1Y7JLufT3JmFHoFYVpiyy7ziGbMcA4+GJ+5ES2onv1pdTr5Z
 2kpbtQ2/7UynNhjuLgZYPLh3XoeiGgyAhhFtB8cUMvba/AhkMe9ml3gk/KNiVSO+hQih
 dkwHTQYkldkRIoVpRrdc33H2SdGX1z+5qt5jS87CjDl6/GpG7dgWw3frrmAZCxGZnHQt
 B6s9OaUJjDyJq/ePIBkLaat4pCZtl4cypW1Uo/BZlHDKK8C7I6wqsNoCzt88U7JoBypx
 JcaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692634744; x=1693239544;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=OchzeURE1BgR8OyI+34sloHIxez963wM6RFcZPAc55w=;
 b=NJ/EmyStH1QBrSEed6t+r+M2EgiiZPFxQmlphXFRgSuumIFIfLhCwg6tqZkV/jASUO
 j2S1D4W4UTNKYopjnoAcNmyyURuzRYnp0/C95Sfbsxa6tF1HtiX34cOD0AhnlmZRF/5+
 ZwAXMgz5Jba2cj3xlTp1eRlfvGOL1EAQ2g0J3FspR0JYvgLxAqOhkoIHpggQxW31Fasc
 wFQC+I2q26Ym60C76T0N0gcbfpdJtYLZj2O3RNZ6T7k6/vwejr8FW/Rzew2ya2+YZUlM
 KOUUOctS7MdkWSaAVaKegfiGAvQNjZQ1I8jZyxiSeRUP9h+1dOu5Nvc2aPi0FIQ2jo8J
 o1JQ==
X-Gm-Message-State: AOJu0Yz8xl9oYacfncMsZ7OQkRvozXEugeY32CHqt4XEbWHl8GAk6hmU
 f9wey/f5cl0S4T8vdLrXM4Ol3ukWie5N2QwUm3w=
X-Google-Smtp-Source: AGHT+IEFZU+dkpuC+CZBnbDD+p6yi+Ruu0SDQpMAypQHKCu9gljTF3SWyIlHN75ukraGB7KcdTWhMw==
X-Received: by 2002:a17:902:fe83:b0:1b8:76ce:9d91 with SMTP id
 x3-20020a170902fe8300b001b876ce9d91mr3236110plm.1.1692634743951; 
 Mon, 21 Aug 2023 09:19:03 -0700 (PDT)
Received: from stoup.. ([2602:47:d483:7301:2c08:e710:4459:46f1])
 by smtp.gmail.com with ESMTPSA id
 e16-20020a17090301d000b001ab2b4105ddsm7234549plh.60.2023.08.21.09.19.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 21 Aug 2023 09:19:03 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: berrange@redhat.com,
	ardb@kernel.org
Subject: [PATCH v3 09/19] crypto: Add generic 32-bit carry-less multiply
 routines
Date: Mon, 21 Aug 2023 09:18:43 -0700
Message-Id: <20230821161854.419893-10-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230821161854.419893-1-richard.henderson@linaro.org>
References: <20230821161854.419893-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62d;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/crypto/clmul.h |  7 +++++++
 crypto/clmul.c         | 13 +++++++++++++
 2 files changed, 20 insertions(+)

diff --git a/include/crypto/clmul.h b/include/crypto/clmul.h
index c7ad28aa85..0ea25a252c 100644
--- a/include/crypto/clmul.h
+++ b/include/crypto/clmul.h
@@ -54,4 +54,11 @@ uint64_t clmul_16x2_even(uint64_t, uint64_t);
  */
 uint64_t clmul_16x2_odd(uint64_t, uint64_t);
 
+/**
+ * clmul_32:
+ *
+ * Perform a 32x32->64 carry-less multiply.
+ */
+uint64_t clmul_32(uint32_t, uint32_t);
+
 #endif /* CRYPTO_CLMUL_H */
diff --git a/crypto/clmul.c b/crypto/clmul.c
index 2c87cfbf8a..36ada1be9d 100644
--- a/crypto/clmul.c
+++ b/crypto/clmul.c
@@ -79,3 +79,16 @@ uint64_t clmul_16x2_odd(uint64_t n, uint64_t m)
 {
     return clmul_16x2_even(n >> 16, m >> 16);
 }
+
+uint64_t clmul_32(uint32_t n, uint32_t m32)
+{
+    uint64_t r = 0;
+    uint64_t m = m32;
+
+    for (int i = 0; i < 32; ++i) {
+        r ^= n & 1 ? m : 0;
+        n >>= 1;
+        m <<= 1;
+    }
+    return r;
+}
-- 
2.34.1



Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 40BE2781630
	for <lists+qemu-devel@lfdr.de>; Sat, 19 Aug 2023 03:03:51 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qXAMJ-0008Qz-Aj; Fri, 18 Aug 2023 21:02:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qXAMG-0008QG-T2
 for qemu-devel@nongnu.org; Fri, 18 Aug 2023 21:02:28 -0400
Received: from mail-pl1-x634.google.com ([2607:f8b0:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qXAME-0007LJ-Nm
 for qemu-devel@nongnu.org; Fri, 18 Aug 2023 21:02:28 -0400
Received: by mail-pl1-x634.google.com with SMTP id
 d9443c01a7336-1bf3a2f44ffso9956005ad.1
 for <qemu-devel@nongnu.org>; Fri, 18 Aug 2023 18:02:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1692406945; x=1693011745;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=u46/76awb7qaVCGpS1Wp9lBTQhA5OFbmzjWjo/GEWhA=;
 b=kql0IMv2Yow40XiBFqkHQpHh0ydvj/vs9ypV8Z/oQY4Ivg9SgyQvoVxYNN4BpJnGn3
 1VZo/s8wB3fBVFZXAm8zXZaI17twWZ4cs2oHwDrwoSih59Gj3TK27SzLsk8/Q4rKBHCD
 rrtCzFSYL4XgFk/VUHSoKuu0MleW8/CAiMms0dI2n5M3Zj9rSnCZDqm9GgSLckzqW2J5
 nWrfiuRTuZGY3vGg0Nl8WGhpCt41OL+zLFTH6B13ZcCoCKAeaus5ixWwv+38wGYrtatp
 esXydpEWV6yRwuSGTNYDpLIlYrGcP8UXNC9OenivTpsbfIRpUZWfeb5DE3GLY+UknZYS
 fwsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692406945; x=1693011745;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=u46/76awb7qaVCGpS1Wp9lBTQhA5OFbmzjWjo/GEWhA=;
 b=ZuntxOqI4rxRMZyxmhd/vIFzycMnoEm4m+JSi5BiX1IRipj1bWHe/vZ6Bx6n4XaphH
 AaT7n5/DUehb1ti7fwdFO1mrD5aZLZXeqro5DLPnwESrC8lqs9U26bJ1TQik+7yufT4M
 v0WxFZuo/EZvKs/HI0S3eTKETBVlIdRT4CE9j5Py7xJi0l8LrKnTjsJgyX+/R8pT5lAU
 sfRw43ZJkivwmZ+CD/ay/dUJ1/g802e70CErmDXPJJOkF61zcyPEyZCqAhLx2MGbQ0dX
 0Lw9pbOwTEgqdcqbKd/XrVtTGUp7bvvjatwvJQpuJY6+scuda3SfRMy1vVT3D+AP/VHX
 ULVA==
X-Gm-Message-State: AOJu0YwCi1l8S4Si+N5v83IZKXfqQBTWPwAGZU6vXF4vaj3UZusiNqaL
 R2DYnhkcuxK9nPPzfzr5jbcp92slR5w15622lPk=
X-Google-Smtp-Source: AGHT+IFoRQPJOVUSNOFTpRedvWfaRZu9ZiGhMdXwUWr+GTXBP61RUAMfgKNgFZOqV3msFoPqO8bJOQ==
X-Received: by 2002:a17:903:22cd:b0:1bd:a50a:e2d0 with SMTP id
 y13-20020a17090322cd00b001bda50ae2d0mr946722plg.66.1692406944900; 
 Fri, 18 Aug 2023 18:02:24 -0700 (PDT)
Received: from stoup.. ([2602:47:d483:7301:cf24:6daf:2b9e:7972])
 by smtp.gmail.com with ESMTPSA id
 b13-20020a170902d50d00b001b87bedcc6fsm2372019plg.93.2023.08.18.18.02.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 18 Aug 2023 18:02:24 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: berrange@redhat.com,
	ardb@kernel.org
Subject: [PATCH v2 05/18] crypto: Add generic 16-bit carry-less multiply
 routines
Date: Fri, 18 Aug 2023 18:02:05 -0700
Message-Id: <20230819010218.192706-6-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230819010218.192706-1-richard.henderson@linaro.org>
References: <20230819010218.192706-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::634;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x634.google.com
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
 include/crypto/clmul.h | 16 ++++++++++++++++
 crypto/clmul.c         | 21 +++++++++++++++++++++
 2 files changed, 37 insertions(+)

diff --git a/include/crypto/clmul.h b/include/crypto/clmul.h
index 153b5e3057..c7ad28aa85 100644
--- a/include/crypto/clmul.h
+++ b/include/crypto/clmul.h
@@ -38,4 +38,20 @@ uint64_t clmul_8x4_odd(uint64_t, uint64_t);
  */
 uint64_t clmul_8x4_packed(uint32_t, uint32_t);
 
+/**
+ * clmul_16x2_even:
+ *
+ * Perform two 16x16->32 carry-less multiplies.
+ * The odd words of the inputs are ignored.
+ */
+uint64_t clmul_16x2_even(uint64_t, uint64_t);
+
+/**
+ * clmul_16x2_odd:
+ *
+ * Perform two 16x16->32 carry-less multiplies.
+ * The even bytes of the inputs are ignored.
+ */
+uint64_t clmul_16x2_odd(uint64_t, uint64_t);
+
 #endif /* CRYPTO_CLMUL_H */
diff --git a/crypto/clmul.c b/crypto/clmul.c
index 82d873fee5..2c87cfbf8a 100644
--- a/crypto/clmul.c
+++ b/crypto/clmul.c
@@ -58,3 +58,24 @@ uint64_t clmul_8x4_packed(uint32_t n, uint32_t m)
 {
     return clmul_8x4_even_int(unpack_8_to_16(n), unpack_8_to_16(m));
 }
+
+uint64_t clmul_16x2_even(uint64_t n, uint64_t m)
+{
+    uint64_t r = 0;
+
+    n &= 0x0000ffff0000ffffull;
+    m &= 0x0000ffff0000ffffull;
+
+    for (int i = 0; i < 16; ++i) {
+        uint64_t mask = (n & 0x0000000100000001ull) * 0xffffffffull;
+        r ^= m & mask;
+        n >>= 1;
+        m <<= 1;
+    }
+    return r;
+}
+
+uint64_t clmul_16x2_odd(uint64_t n, uint64_t m)
+{
+    return clmul_16x2_even(n >> 16, m >> 16);
+}
-- 
2.34.1



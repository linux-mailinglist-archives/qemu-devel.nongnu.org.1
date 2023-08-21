Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D8B51782E42
	for <lists+qemu-devel@lfdr.de>; Mon, 21 Aug 2023 18:20:26 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qY7co-0001gi-IX; Mon, 21 Aug 2023 12:19:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qY7cO-0001Tk-0Y
 for qemu-devel@nongnu.org; Mon, 21 Aug 2023 12:19:05 -0400
Received: from mail-pl1-x62b.google.com ([2607:f8b0:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qY7cL-0005bi-No
 for qemu-devel@nongnu.org; Mon, 21 Aug 2023 12:19:03 -0400
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-1bd9b4f8e0eso21234125ad.1
 for <qemu-devel@nongnu.org>; Mon, 21 Aug 2023 09:19:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1692634740; x=1693239540;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=u46/76awb7qaVCGpS1Wp9lBTQhA5OFbmzjWjo/GEWhA=;
 b=dkEsU7mrh/Aaf5+tRoyHr9crd4Tul2iahjevYFk1TwWQ7ZR8LCGoH4SCWkGWGTjnGH
 jmMLggHxSjg+EToygCn1SaP+FCpehfGneGD8NzcHRMZOAypOPBvTJELX3Tvolgw0hAAP
 7nCYMfPfrJwFhrA1I2mKxOKyJXNpIVjen9Ixj2p2oa3Uk79H4UkTjstLz7vmj1BNCARH
 Eo9Tst97QGOVipf5f8S02p7RzBDLKsT4gtcfrEGDFCwWDLwIKxoJ2yQFlNmpZhqgOvJX
 5rzoQu1Mms8tExFRzuZmjLuJBAakHV6P8ecOuT/6nytoj1I65UdQGnpUT5ELDHRApK4w
 3M9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692634740; x=1693239540;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=u46/76awb7qaVCGpS1Wp9lBTQhA5OFbmzjWjo/GEWhA=;
 b=aLMmC5KFgky51w23e/l82lZFcp5gP0MarsBKztVdCX5JVjgVx6zyrNlW/OLDXdM5Xy
 HV1/Du1TC4KJi7gvSA2suhZMIouaKz1jrendonXtGrOEwGIt/vDsxd57krgkcbozkVo2
 FKT12tg7jFuKwLNOu8Z0yUR85acCEGiN4ibhADE7OkCsMYvLvFdJ0tXk3oe/+ESL758T
 wJncWFBBfiPHpK62kIdVgzUNcpmW6CUyB5I8uOBLIT2hDi1VOS2O68aKRfYo/+TzV2cj
 NInZT14gENYfN9IoNB5Z+Jrm8L2SWVgCoqpPDXkIrdhBzFD2FFy/cIvtWB323wvhIRYJ
 1mgg==
X-Gm-Message-State: AOJu0YzAzmbsThkeUgw5jModwjRa336VKZ2qg2k/m2O4vv2rHc4BqZJZ
 44oahZToSI9RSPcOV3dRTdMqpoKConT/Sje2Ub0=
X-Google-Smtp-Source: AGHT+IEHNgJUVjcGY5y/+OM8mLR8nQ5q5AqWpWAuasElqB2e9j/kmmRq7vZVcIyjvfTCf89iLOZOmg==
X-Received: by 2002:a17:902:d705:b0:1bb:1523:b311 with SMTP id
 w5-20020a170902d70500b001bb1523b311mr4298283ply.41.1692634740262; 
 Mon, 21 Aug 2023 09:19:00 -0700 (PDT)
Received: from stoup.. ([2602:47:d483:7301:2c08:e710:4459:46f1])
 by smtp.gmail.com with ESMTPSA id
 e16-20020a17090301d000b001ab2b4105ddsm7234549plh.60.2023.08.21.09.18.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 21 Aug 2023 09:18:59 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: berrange@redhat.com,
	ardb@kernel.org
Subject: [PATCH v3 05/19] crypto: Add generic 16-bit carry-less multiply
 routines
Date: Mon, 21 Aug 2023 09:18:39 -0700
Message-Id: <20230821161854.419893-6-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230821161854.419893-1-richard.henderson@linaro.org>
References: <20230821161854.419893-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62b;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62b.google.com
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



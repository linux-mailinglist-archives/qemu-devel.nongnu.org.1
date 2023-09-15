Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 20EBE7A23CD
	for <lists+qemu-devel@lfdr.de>; Fri, 15 Sep 2023 18:44:51 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qhBu3-0004U0-PL; Fri, 15 Sep 2023 12:42:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qhBu0-0004TK-FR
 for qemu-devel@nongnu.org; Fri, 15 Sep 2023 12:42:44 -0400
Received: from mail-pf1-x42e.google.com ([2607:f8b0:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qhBty-0004ui-Su
 for qemu-devel@nongnu.org; Fri, 15 Sep 2023 12:42:44 -0400
Received: by mail-pf1-x42e.google.com with SMTP id
 d2e1a72fcca58-68fc292de9dso1741872b3a.0
 for <qemu-devel@nongnu.org>; Fri, 15 Sep 2023 09:42:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1694796161; x=1695400961; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5E1DttN1y2odVDPPAQFBLbvH/8uGREEL7i929ZC+pCE=;
 b=N9G/t3xKBEped5pkrYdIqSasnkwf5WmyIjE3E3Old1WaCB10uswQmDRGnMACvEMfbw
 zeYIYs4TjRpCFngTRrkZfpwbiG39/WuPyzGBRdSBdnrpKKnbP8dbTu1zfeNtKVHEm8dv
 i20op74KqiXebGko1xNgd4RXdIEM2/1exmeYKsCijeVxn3KCh66KdjRLhIEZ5XhhZfI6
 ipj7GDddwQlqbJTtnKuX7BJmqfkYw2/kriA0MfvoI4+CTYZytj7N/spPIJ8XA4csE+4Y
 NZjCPk0MXkECF6BrvTjTj5wXg0wUx6d3gGAOJbC8dGkxCcDeAI+xrJeb/emzvlp50JzU
 gKZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694796161; x=1695400961;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=5E1DttN1y2odVDPPAQFBLbvH/8uGREEL7i929ZC+pCE=;
 b=sn3DgC8Mg1HUUZJ0RLROnV2Hz/xe99mPeNls4K7dCwmjK8UNH7MFHyDuf+0QJXJH+P
 4RgJlWwSHaMKFwjCJKfchLfTJoLTkkl4Qm4bb3/j1nPDFfqju5dr4gGgQ4BpjQ6UXyIJ
 bYJ2qpwmsm2DJ9zuPu1hsMakRxfCr8xLdXOYJV8PgsmbESRMgaCOjiTzXOJvKeaomXaI
 Z3Jl6rAiNcVtLNINhxlQgkCjzPhfPpbcbJ3ZssV5V8I6D62WPf9yBeNK4t3D63276p0H
 KvcUA/Fh5wlAKPxdJGs85UrLuEauzGFNTN3SXJWfgk8cKxT8LGVR+Fdm2wlAqH1FW4u8
 IN/g==
X-Gm-Message-State: AOJu0YxRKI5x/VUy99irEuYnG5FMICu72jiQsmPVeC0G756mUpBEM1hR
 QBYAwbhGYMFYHqBfdkIKlwNPzRjtDOV1c0x/lTg=
X-Google-Smtp-Source: AGHT+IHixqDd8rx6hbpVdg4TgFMQE+WlNFbNlMd8qNm8w0dih1HNOLbi2hUPXPLaEE1Awg0603Ro6g==
X-Received: by 2002:a05:6a20:3d26:b0:140:d536:d434 with SMTP id
 y38-20020a056a203d2600b00140d536d434mr3029428pzi.10.1694796161016; 
 Fri, 15 Sep 2023 09:42:41 -0700 (PDT)
Received: from stoup.. ([71.212.131.115]) by smtp.gmail.com with ESMTPSA id
 s187-20020a6377c4000000b00577f55e4a4esm3010087pgc.20.2023.09.15.09.42.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 15 Sep 2023 09:42:40 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Ard Biesheuvel <ardb@kernel.org>
Subject: [PULL 09/19] crypto: Add generic 32-bit carry-less multiply routines
Date: Fri, 15 Sep 2023 09:42:21 -0700
Message-Id: <20230915164231.123580-10-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230915164231.123580-1-richard.henderson@linaro.org>
References: <20230915164231.123580-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42e;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42e.google.com
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

Reviewed-by: Ard Biesheuvel <ardb@kernel.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/crypto/clmul.h |  7 +++++++
 crypto/clmul.c         | 13 +++++++++++++
 2 files changed, 20 insertions(+)

diff --git a/include/crypto/clmul.h b/include/crypto/clmul.h
index 72672b237c..80de516464 100644
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



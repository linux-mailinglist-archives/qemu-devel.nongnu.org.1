Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CD017A23CA
	for <lists+qemu-devel@lfdr.de>; Fri, 15 Sep 2023 18:44:44 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qhBtx-0004SA-RO; Fri, 15 Sep 2023 12:42:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qhBtv-0004Rc-VE
 for qemu-devel@nongnu.org; Fri, 15 Sep 2023 12:42:39 -0400
Received: from mail-pf1-x42f.google.com ([2607:f8b0:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qhBtu-0004tY-FB
 for qemu-devel@nongnu.org; Fri, 15 Sep 2023 12:42:39 -0400
Received: by mail-pf1-x42f.google.com with SMTP id
 d2e1a72fcca58-68fb2e9ebbfso1947658b3a.2
 for <qemu-devel@nongnu.org>; Fri, 15 Sep 2023 09:42:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1694796157; x=1695400957; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=E2sTDZYIaL3GhBPyCh9S4Dw9cyt088qCUZyaRlZTVTE=;
 b=wVFzv+ax3s0/d6WnXWsYafhnibMfwMFeWc9A2JqVf5eZhr7osijrOSuch2a2Du/uMt
 QU9adusygMlJMmMVtItEfbRCyLA8/CsWb7EhUiU0kvezLn/Kqtjw88Lx1wuOcipQ3lGr
 PeyevTDicKHNTr9z2Rqxe0e/pe6S5KXPuMZmV9ZlHqlu2iTH9n0ur4klP4WKDmgFwYOn
 OX5V3QAr8ypabKLfoHNy18BQptHpmv7hamxhpw6SjEyhxHvmbyyM/2UXFmMz+7e5ddVC
 R+s5JpBVUrLBqt6s/FM1ANPy+AKmBbIwetQcFA7RCwBeBmDM6ltsO+FoCPQu3jgIyyFs
 opKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694796157; x=1695400957;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=E2sTDZYIaL3GhBPyCh9S4Dw9cyt088qCUZyaRlZTVTE=;
 b=TPpDVP4pjUxMKMsOFvUSv8amnBRyO5qAdA1/JEGPgfs5giJJUIkVIzFHujDvDiJMQ8
 VlZrgCd2nUnVOq7cZ51ODlf2q6tge73jw+e9JlN+WJi7cNEMZynMkAJhRXJFheVu2que
 cxz+/jwItEaoDg8NevljoCzSk+sCVCNzQQ09UfJqMXQipArQTDQZX7g1LXrnAjbr6wCm
 9ytoNaQLBOEtBdtIRAkfdZP16yGvyun+sxF1rr8+TjuPU3VXJRBbG1IzbL9+mDCkti+w
 xvzUXqagbNInEj9alQ5XPB11ij9GFtLH3Dp/i/D1lQnA9WhXZhEBzEy1ebAcJ7x0Feq5
 yJgA==
X-Gm-Message-State: AOJu0YyvvLZGFCshYLEB/LGuWC/Gfrk7Sugk8ASSSIs0Fv0XqrPNFgdj
 KBKxtCtkBg2TybjqsxfSoe4ozI+fg5EOM1Yvk2o=
X-Google-Smtp-Source: AGHT+IEw2J9+zcg36cIFEvDRv3I8G69EPMo1dclSBwsW13YuRMIEgqI2Hh5tMsDNASFGzIadUPbsPg==
X-Received: by 2002:a05:6a00:1acd:b0:68a:604f:420d with SMTP id
 f13-20020a056a001acd00b0068a604f420dmr2407297pfv.3.1694796157114; 
 Fri, 15 Sep 2023 09:42:37 -0700 (PDT)
Received: from stoup.. ([71.212.131.115]) by smtp.gmail.com with ESMTPSA id
 s187-20020a6377c4000000b00577f55e4a4esm3010087pgc.20.2023.09.15.09.42.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 15 Sep 2023 09:42:36 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Ard Biesheuvel <ardb@kernel.org>
Subject: [PULL 05/19] crypto: Add generic 16-bit carry-less multiply routines
Date: Fri, 15 Sep 2023 09:42:17 -0700
Message-Id: <20230915164231.123580-6-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230915164231.123580-1-richard.henderson@linaro.org>
References: <20230915164231.123580-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42f;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42f.google.com
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
 include/crypto/clmul.h | 16 ++++++++++++++++
 crypto/clmul.c         | 21 +++++++++++++++++++++
 2 files changed, 37 insertions(+)

diff --git a/include/crypto/clmul.h b/include/crypto/clmul.h
index 153b5e3057..72672b237c 100644
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
+ * The even words of the inputs are ignored.
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



Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 16E9878163F
	for <lists+qemu-devel@lfdr.de>; Sat, 19 Aug 2023 03:04:50 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qXAMM-0008Si-2s; Fri, 18 Aug 2023 21:02:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qXAMJ-0008Rj-OV
 for qemu-devel@nongnu.org; Fri, 18 Aug 2023 21:02:31 -0400
Received: from mail-pl1-x62d.google.com ([2607:f8b0:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qXAMH-0007MD-Hh
 for qemu-devel@nongnu.org; Fri, 18 Aug 2023 21:02:31 -0400
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-1bc3d94d40fso12489645ad.3
 for <qemu-devel@nongnu.org>; Fri, 18 Aug 2023 18:02:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1692406948; x=1693011748;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=OchzeURE1BgR8OyI+34sloHIxez963wM6RFcZPAc55w=;
 b=SzIYJkjoisy0WLLry0ywCtUCLnDiVrgW1pnm1NuMQSwe1ZDHuk8B7Wsk2XhgiGdpa1
 oiBQvm4ipIb/ZtYwXzgKfcWNpAsFxtysnknB0tmJdJbFWxyTe4b0Th1a/dHl3G4De9Ei
 nLYTCgHKF8UUGoP5kxkStMFdyusB112mRQMVVs9TJTXafS1EZesZptwqNLGleAoaDJT6
 benQoqmMXYJh8/R5rjJureg6wSsj66tJ6X8i/BF0FSULcfezgf5vd+COqzmNBLC6p0Rm
 fzQU/Q6LN68a7rBNvBDmXRdP+XsZOqUVG8BxnjDeMr463nWA5/NYjshj6IVjLCxwF/1w
 ZqLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692406948; x=1693011748;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=OchzeURE1BgR8OyI+34sloHIxez963wM6RFcZPAc55w=;
 b=h27oTEn99FlyR3aft3KuBauaxfGYJsh5duVahDuVg6P16M471JUJJxOxDgvooy9dsM
 /owCBdfY+KruYNNLXT0yRP0RSKTmSjHPTGlYeYKrHkrwK70m9jHpoUEIDmA0wdc9tait
 oJuQTqeL9alevtBUGY4WE1huupf4TLvEbW7JE+tvwFuNCkPyXcL5zgSFUpB9HLHJLJZL
 rbdw0rvBdyNf2fWo6xTkyQn13qA9Yv2YTgnEdJhtd7q665WJI9i91m8SwzeDU7KEyYi7
 nclMmBMXh3eogPJV45snYLqXRhY3B/P/T4SQDt2VTUutt7n/va6UlBkEzbsXN1eVW77F
 WStA==
X-Gm-Message-State: AOJu0YwyYf8iY+aTqPmQ6rURp4v6Zl7R7ibot/givHfGhhMQh2+rERLx
 I0eugrwYYT/5BlfQeGgFQuJZivS/B0tNu8Arnrg=
X-Google-Smtp-Source: AGHT+IFeHK7ylEBKo0hNiv81k02jnTawH7zFxxE2IaqLg0Z1WFIbGw2cNegMzKBMeToe8/aXZenY4w==
X-Received: by 2002:a17:902:a5c2:b0:1bf:41b6:938e with SMTP id
 t2-20020a170902a5c200b001bf41b6938emr822326plq.40.1692406948260; 
 Fri, 18 Aug 2023 18:02:28 -0700 (PDT)
Received: from stoup.. ([2602:47:d483:7301:cf24:6daf:2b9e:7972])
 by smtp.gmail.com with ESMTPSA id
 b13-20020a170902d50d00b001b87bedcc6fsm2372019plg.93.2023.08.18.18.02.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 18 Aug 2023 18:02:27 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: berrange@redhat.com,
	ardb@kernel.org
Subject: [PATCH v2 09/18] crypto: Add generic 32-bit carry-less multiply
 routines
Date: Fri, 18 Aug 2023 18:02:09 -0700
Message-Id: <20230819010218.192706-10-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230819010218.192706-1-richard.henderson@linaro.org>
References: <20230819010218.192706-1-richard.henderson@linaro.org>
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



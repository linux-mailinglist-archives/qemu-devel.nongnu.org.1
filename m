Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7943C70581A
	for <lists+qemu-devel@lfdr.de>; Tue, 16 May 2023 21:57:33 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1pz0Yc-0006ds-M2; Tue, 16 May 2023 15:42:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1pz0YZ-0006cZ-ML
 for qemu-devel@nongnu.org; Tue, 16 May 2023 15:41:59 -0400
Received: from mail-pf1-x42c.google.com ([2607:f8b0:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1pz0YX-0002lO-Nb
 for qemu-devel@nongnu.org; Tue, 16 May 2023 15:41:59 -0400
Received: by mail-pf1-x42c.google.com with SMTP id
 d2e1a72fcca58-643557840e4so15613710b3a.2
 for <qemu-devel@nongnu.org>; Tue, 16 May 2023 12:41:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1684266116; x=1686858116;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dcVdAagIvm7EA0iM5EE3QZ/b7E6C622n8vck9DZLSDI=;
 b=y+WXfnEWugejtCia7Yy+U2z9Dr5N/Tp+HHtMTxgbY0GZA6aN/cGw8nvpsjIYFim+SS
 jwmg+HulbmO+2+mJZlcJaBrsfEjaC9ddH36s6YZKv52wd2y8BXibLe78y1bfO2pKxAWO
 VCHDUTwahcgeRsITC10KH7Jq3sWm7KdGhpwZQtLIwDl27hPcDfqzXunfQh3mPVB9HMFk
 GCOJuDIyJCel0WswpKRT7nwk+60gWLyhUkFGn+5PTg2azbxQCzvN5T+H6Tv/P3OFkn7d
 LQASSFxfaTgsCX9pyZwGPn+NpBSwzrM9gmrl1UHMb/7LdmYmvukB6bHWQjL/uknRqGMT
 57+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684266116; x=1686858116;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=dcVdAagIvm7EA0iM5EE3QZ/b7E6C622n8vck9DZLSDI=;
 b=LNq7wOiXMCXK6VX5zAfDilgM2dOC0aX5a27nmK4SCInfir/33f3e5T7O+91HvnH2Jd
 wXpwxrukQPp6RZBgQLHrg7rMrKrZ0NU5+KFc9JE81vUJzgGEWj8SvnajCGcD1LAduJB5
 8miR3TYK/5Q4Vol8/J1Hokd8IbENlI0opt+V1yM7OARjfJ8vChSnpVT0km8FSng6/UOy
 GB3psV/vlehIgKs3tx8ePZazxZ7UtLh7m6K9LHDOhq0opqIqmONC3IbF8nlxVQIeic22
 jf3J938JgaOvdMEesDfAiL0rzALpwkE28zQD7jZwvIvU55sUhgMA+JQ8HgxPU2CjhwO1
 LQCg==
X-Gm-Message-State: AC+VfDyB4jQsfpzO9GkrpBNpA9ZWJwzuhi47ZYBXBbeJs5zgujcdp866
 hBnpwOgCrWjT4UPi5zOF6cnik9fWNyvbTiCLJDI=
X-Google-Smtp-Source: ACHHUZ6sLJoFWwkMYLFXlHUeoGM2HEkCCtdsdBHQofdchpDiz5Wrx0uPYqIvdGMMtHpTVzxhpVEflg==
X-Received: by 2002:a05:6a00:17a7:b0:645:454c:286d with SMTP id
 s39-20020a056a0017a700b00645454c286dmr45541830pfg.3.1684266116428; 
 Tue, 16 May 2023 12:41:56 -0700 (PDT)
Received: from stoup.. ([2602:ae:1598:4c01:ec81:440e:33a4:40b9])
 by smtp.gmail.com with ESMTPSA id
 z21-20020aa791d5000000b006260526cf0csm13771165pfa.116.2023.05.16.12.41.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 May 2023 12:41:56 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>
Subject: [PULL 10/80] tcg/i386: Add have_atomic16
Date: Tue, 16 May 2023 12:40:35 -0700
Message-Id: <20230516194145.1749305-11-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230516194145.1749305-1-richard.henderson@linaro.org>
References: <20230516194145.1749305-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42c;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42c.google.com
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

Notice when Intel or AMD have guaranteed that vmovdqa is atomic.
The new variable will also be used in generated code.

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/qemu/cpuid.h      | 18 ++++++++++++++++++
 tcg/i386/tcg-target.h     |  1 +
 tcg/i386/tcg-target.c.inc | 27 +++++++++++++++++++++++++++
 3 files changed, 46 insertions(+)

diff --git a/include/qemu/cpuid.h b/include/qemu/cpuid.h
index 1451e8ef2f..35325f1995 100644
--- a/include/qemu/cpuid.h
+++ b/include/qemu/cpuid.h
@@ -71,6 +71,24 @@
 #define bit_LZCNT       (1 << 5)
 #endif
 
+/*
+ * Signatures for different CPU implementations as returned from Leaf 0.
+ */
+
+#ifndef signature_INTEL_ecx
+/* "Genu" "ineI" "ntel" */
+#define signature_INTEL_ebx     0x756e6547
+#define signature_INTEL_edx     0x49656e69
+#define signature_INTEL_ecx     0x6c65746e
+#endif
+
+#ifndef signature_AMD_ecx
+/* "Auth" "enti" "cAMD" */
+#define signature_AMD_ebx       0x68747541
+#define signature_AMD_edx       0x69746e65
+#define signature_AMD_ecx       0x444d4163
+#endif
+
 static inline unsigned xgetbv_low(unsigned c)
 {
     unsigned a, d;
diff --git a/tcg/i386/tcg-target.h b/tcg/i386/tcg-target.h
index d4f2a6f8c2..0421776cb8 100644
--- a/tcg/i386/tcg-target.h
+++ b/tcg/i386/tcg-target.h
@@ -120,6 +120,7 @@ extern bool have_avx512dq;
 extern bool have_avx512vbmi2;
 extern bool have_avx512vl;
 extern bool have_movbe;
+extern bool have_atomic16;
 
 /* optional instructions */
 #define TCG_TARGET_HAS_div2_i32         1
diff --git a/tcg/i386/tcg-target.c.inc b/tcg/i386/tcg-target.c.inc
index 826f7764c9..911123cfa8 100644
--- a/tcg/i386/tcg-target.c.inc
+++ b/tcg/i386/tcg-target.c.inc
@@ -185,6 +185,7 @@ bool have_avx512dq;
 bool have_avx512vbmi2;
 bool have_avx512vl;
 bool have_movbe;
+bool have_atomic16;
 
 #ifdef CONFIG_CPUID_H
 static bool have_bmi2;
@@ -4026,6 +4027,32 @@ static void tcg_target_init(TCGContext *s)
                     have_avx512dq = (b7 & bit_AVX512DQ) != 0;
                     have_avx512vbmi2 = (c7 & bit_AVX512VBMI2) != 0;
                 }
+
+                /*
+                 * The Intel SDM has added:
+                 *   Processors that enumerate support for Intel® AVX
+                 *   (by setting the feature flag CPUID.01H:ECX.AVX[bit 28])
+                 *   guarantee that the 16-byte memory operations performed
+                 *   by the following instructions will always be carried
+                 *   out atomically:
+                 *   - MOVAPD, MOVAPS, and MOVDQA.
+                 *   - VMOVAPD, VMOVAPS, and VMOVDQA when encoded with VEX.128.
+                 *   - VMOVAPD, VMOVAPS, VMOVDQA32, and VMOVDQA64 when encoded
+                 *     with EVEX.128 and k0 (masking disabled).
+                 * Note that these instructions require the linear addresses
+                 * of their memory operands to be 16-byte aligned.
+                 *
+                 * AMD has provided an even stronger guarantee that processors
+                 * with AVX provide 16-byte atomicity for all cachable,
+                 * naturally aligned single loads and stores, e.g. MOVDQU.
+                 *
+                 * See https://gcc.gnu.org/bugzilla/show_bug.cgi?id=104688
+                 */
+                if (have_avx1) {
+                    __cpuid(0, a, b, c, d);
+                    have_atomic16 = (c == signature_INTEL_ecx ||
+                                     c == signature_AMD_ecx);
+                }
             }
         }
     }
-- 
2.34.1



Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DDC91782E56
	for <lists+qemu-devel@lfdr.de>; Mon, 21 Aug 2023 18:24:00 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qY7cv-00026F-S4; Mon, 21 Aug 2023 12:19:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qY7cf-0001Yu-5i
 for qemu-devel@nongnu.org; Mon, 21 Aug 2023 12:19:28 -0400
Received: from mail-pf1-x42f.google.com ([2607:f8b0:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qY7cZ-0005eG-3q
 for qemu-devel@nongnu.org; Mon, 21 Aug 2023 12:19:19 -0400
Received: by mail-pf1-x42f.google.com with SMTP id
 d2e1a72fcca58-68a3236a414so1561142b3a.0
 for <qemu-devel@nongnu.org>; Mon, 21 Aug 2023 09:19:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1692634752; x=1693239552;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fd0V1dVewg5WOTiDo3UWfFkJLmgfwo7yGoKXR6xz6U0=;
 b=xSyaOTclCysSBD/Cx6LQ6/SDXyFJDFEgBPdPxyv5DIV19z0fHqKklwjyXZzyUu3006
 C6R2qiRp0hsMdx3RGF6PwkplF5NWUm+psan0ics80ES1AsH+vbM150nQHIAy15uxxaIH
 GkPLMIFgbAKG1ielww7PNr2QVRqZ4lyRyRnGLThfM3afCS5H0L1HezaE2xv7BzA7JPB6
 8c2lyaqMwlaALBgGSx3X68QbVizsumluMoWcddGGdEPBPTaV9QML2Yu4kRLbvj6gdXEB
 satf7UWqDAU9MLa3GbGwIy7jAJMgrPN4AwEmQO/IJw+KBuK83wShqLBkow7n6poFPDdH
 eqJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692634752; x=1693239552;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=fd0V1dVewg5WOTiDo3UWfFkJLmgfwo7yGoKXR6xz6U0=;
 b=Lv5NLEsaOhoEQ1CTiKdyIcT2CFA6Egv451ZndlBHUFTbR8owuejOhSp0QU2ke1yS1k
 4n0BurL3E5IPr1HMiU65511el195j7IuGtM67x+voBdxTTk9PLcy7feYoh/xahaG0zz0
 SA3Z4Uzu/D5u4lDtCsGeDWometYLRCEiJYl/2W1lMGYBJ49go4//Xyvr0OY3Rc2/0t6H
 OETFHylECu2pKDHSBkjy/MhQ6X2rY+oyBFPdSoWGIISruWOHaRSxKKRld7QRoCTOH6TN
 3cFYPrSVLtFcPHXTMi8A30UjyFrTy/St/0cKIqr70OORUYkTQ3sJnMOtXbM+0K0mFnNm
 CWPg==
X-Gm-Message-State: AOJu0YyQKTwLOKHVaNqRh9VpB9Ztu/u+mqg9g3kcbFKRXp3v80cWmJDn
 V2yWlKOloWviwNAHP/YtCSzDJUWVQ6ssC2O4a4w=
X-Google-Smtp-Source: AGHT+IHbf5g37ijf5BsaAA6p6z5Wpo9HTHi05Ofi46J597h3oHWBnBboAf0UbFOCsmh0EU0PoOjlng==
X-Received: by 2002:a05:6a20:26a5:b0:142:952d:3e61 with SMTP id
 h37-20020a056a2026a500b00142952d3e61mr6203714pze.7.1692634752157; 
 Mon, 21 Aug 2023 09:19:12 -0700 (PDT)
Received: from stoup.. ([2602:47:d483:7301:2c08:e710:4459:46f1])
 by smtp.gmail.com with ESMTPSA id
 e16-20020a17090301d000b001ab2b4105ddsm7234549plh.60.2023.08.21.09.19.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 21 Aug 2023 09:19:11 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: berrange@redhat.com,
	ardb@kernel.org
Subject: [PATCH v3 18/19] host/include/i386: Implement clmul.h
Date: Mon, 21 Aug 2023 09:18:52 -0700
Message-Id: <20230821161854.419893-19-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230821161854.419893-1-richard.henderson@linaro.org>
References: <20230821161854.419893-1-richard.henderson@linaro.org>
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

Detect PCLMUL in cpuinfo; implement the accel hook.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 host/include/i386/host/cpuinfo.h        |  1 +
 host/include/i386/host/crypto/clmul.h   | 29 +++++++++++++++++++++++++
 host/include/x86_64/host/crypto/clmul.h |  1 +
 include/qemu/cpuid.h                    |  3 +++
 util/cpuinfo-i386.c                     |  1 +
 5 files changed, 35 insertions(+)
 create mode 100644 host/include/i386/host/crypto/clmul.h
 create mode 100644 host/include/x86_64/host/crypto/clmul.h

diff --git a/host/include/i386/host/cpuinfo.h b/host/include/i386/host/cpuinfo.h
index 073d0a426f..7ae21568f7 100644
--- a/host/include/i386/host/cpuinfo.h
+++ b/host/include/i386/host/cpuinfo.h
@@ -27,6 +27,7 @@
 #define CPUINFO_ATOMIC_VMOVDQA  (1u << 16)
 #define CPUINFO_ATOMIC_VMOVDQU  (1u << 17)
 #define CPUINFO_AES             (1u << 18)
+#define CPUINFO_PCLMUL          (1u << 19)
 
 /* Initialized with a constructor. */
 extern unsigned cpuinfo;
diff --git a/host/include/i386/host/crypto/clmul.h b/host/include/i386/host/crypto/clmul.h
new file mode 100644
index 0000000000..dc3c814797
--- /dev/null
+++ b/host/include/i386/host/crypto/clmul.h
@@ -0,0 +1,29 @@
+/*
+ * x86 specific clmul acceleration.
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#ifndef X86_HOST_CRYPTO_CLMUL_H
+#define X86_HOST_CRYPTO_CLMUL_H
+
+#include "host/cpuinfo.h"
+#include <immintrin.h>
+
+#if defined(__PCLMUL__)
+# define HAVE_CLMUL_ACCEL  true
+# define ATTR_CLMUL_ACCEL
+#else
+# define HAVE_CLMUL_ACCEL  likely(cpuinfo & CPUINFO_PCLMUL)
+# define ATTR_CLMUL_ACCEL  __attribute__((target("pclmul")))
+#endif
+
+static inline Int128 ATTR_CLMUL_ACCEL
+clmul_64_accel(uint64_t n, uint64_t m)
+{
+    union { __m128i v; Int128 s; } u;
+
+    u.v = _mm_clmulepi64_si128(_mm_set_epi64x(0, n), _mm_set_epi64x(0, m), 0);
+    return u.s;
+}
+
+#endif /* X86_HOST_CRYPTO_CLMUL_H */
diff --git a/host/include/x86_64/host/crypto/clmul.h b/host/include/x86_64/host/crypto/clmul.h
new file mode 100644
index 0000000000..f25eced416
--- /dev/null
+++ b/host/include/x86_64/host/crypto/clmul.h
@@ -0,0 +1 @@
+#include "host/include/i386/host/crypto/clmul.h"
diff --git a/include/qemu/cpuid.h b/include/qemu/cpuid.h
index 35325f1995..b11161555b 100644
--- a/include/qemu/cpuid.h
+++ b/include/qemu/cpuid.h
@@ -25,6 +25,9 @@
 #endif
 
 /* Leaf 1, %ecx */
+#ifndef bit_PCLMUL
+#define bit_PCLMUL      (1 << 1)
+#endif
 #ifndef bit_SSE4_1
 #define bit_SSE4_1      (1 << 19)
 #endif
diff --git a/util/cpuinfo-i386.c b/util/cpuinfo-i386.c
index 3a7b7e0ad1..36783fd199 100644
--- a/util/cpuinfo-i386.c
+++ b/util/cpuinfo-i386.c
@@ -39,6 +39,7 @@ unsigned __attribute__((constructor)) cpuinfo_init(void)
         info |= (c & bit_SSE4_1 ? CPUINFO_SSE4 : 0);
         info |= (c & bit_MOVBE ? CPUINFO_MOVBE : 0);
         info |= (c & bit_POPCNT ? CPUINFO_POPCNT : 0);
+        info |= (c & bit_PCLMUL ? CPUINFO_PCLMUL : 0);
 
         /* Our AES support requires PSHUFB as well. */
         info |= ((c & bit_AES) && (c & bit_SSSE3) ? CPUINFO_AES : 0);
-- 
2.34.1



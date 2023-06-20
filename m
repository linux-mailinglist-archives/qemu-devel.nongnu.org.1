Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BF26B736611
	for <lists+qemu-devel@lfdr.de>; Tue, 20 Jun 2023 10:27:11 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qBWh3-0003oJ-2C; Tue, 20 Jun 2023 04:26:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qBWgu-0003my-JV
 for qemu-devel@nongnu.org; Tue, 20 Jun 2023 04:26:20 -0400
Received: from mail-ej1-x629.google.com ([2a00:1450:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qBWgs-00065S-7j
 for qemu-devel@nongnu.org; Tue, 20 Jun 2023 04:26:19 -0400
Received: by mail-ej1-x629.google.com with SMTP id
 a640c23a62f3a-988a5383fd4so368417666b.0
 for <qemu-devel@nongnu.org>; Tue, 20 Jun 2023 01:26:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1687249576; x=1689841576;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vtpvnoCGXBYmDE1iTvy2apfZncVWql8zpzIm5cBPnKE=;
 b=TdzzK9LS1Dju1xZfKask8UrA4XH89+GMJA45YuTANRRyXRMOzKPAdU3IuabMkChRgD
 nSjniZDQflskPsdFko0daKijo/ssljsTDTvUFWOV8Mi1JquInE9pyOPEpw+AzRZYwrfe
 +uxxdUwSEtHM20yFCO06iYbUTY/eTAwky40dUdSJCxRfJcWcpCe2ebJNBbN1wTnSka1g
 KVU187RjP5dq1rrfmgV41By+RB7/fAvTTyhiWpqVQJVYWW1MDZF+n6cmaMnKN5r8EYCL
 4N1THm00nNEyjFQ7fHczFp7c9Z9+cF6U4Lo41ZIu7IqVcfaO4kRsR5ETTvUuT2P/YDiT
 vDxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687249576; x=1689841576;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=vtpvnoCGXBYmDE1iTvy2apfZncVWql8zpzIm5cBPnKE=;
 b=hk/jtHOFnXUkGke2AzYgNfNO1VwuqsOq1QRDPnTwuX7CKcXAkytNdtl4u9wehG6DJu
 b9FeQTTjA5Axl8+E99JkBX7at07sqlNaXxdId/ta46HsU93E+FjMxQeNFjrJOzRSmjAI
 t0lLAdIgbEPR+uP1JDEwipHnQpVneqROIU011EC2egXwSZB9d0r+d+FXxxk24Ph/5idX
 MY5Aprz9Pl9oxitDUATrDFxdl8whq+rVLV+yazJvQAjQMC1fWv9SaU03jDHn3s1NeoTt
 nznJcJZRkVCO6vLpCzYCRRKbe9cj2qWoPVenvOqiOSMGKSzZlnQbLtbv+TudcU7pkoi9
 BYrw==
X-Gm-Message-State: AC+VfDwS2+BahkMxc7KenjA2IOQJajNUVT+OUzPHTevrvv/MiWtMtt+m
 OMg8UzIn97M6MvfQlIBAweV+zWBrYwzq8lIagzr7Yz+D
X-Google-Smtp-Source: ACHHUZ7pJLpHRcPEpE6sh135TRkeNTL6TeK5eQucA4sGSlL8eU1pYxWHl23+E1EoPrU+Be5D7090uQ==
X-Received: by 2002:a17:907:8a1b:b0:988:bad4:e422 with SMTP id
 sc27-20020a1709078a1b00b00988bad4e422mr4123458ejc.13.1687249576520; 
 Tue, 20 Jun 2023 01:26:16 -0700 (PDT)
Received: from stoup.lan ([176.176.183.29]) by smtp.gmail.com with ESMTPSA id
 z19-20020a170906669300b00977c7566ccbsm935901ejo.164.2023.06.20.01.26.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 20 Jun 2023 01:26:16 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Daniel Henrique Barboza <danielhb413@gmail.com>
Subject: [PULL 03/16] tcg/ppc: Define _CALL_AIX for clang on ppc64(be)
Date: Tue, 20 Jun 2023 10:25:58 +0200
Message-Id: <20230620082611.770620-4-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230620082611.770620-1-richard.henderson@linaro.org>
References: <20230620082611.770620-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::629;
 envelope-from=richard.henderson@linaro.org; helo=mail-ej1-x629.google.com
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

Restructure the ifdef ladder, separating 64-bit from 32-bit,
and ensure _CALL_AIX is set for ELF v1.  Fixes the build for
ppc64 big-endian host with clang.

Reviewed-by: Daniel Henrique Barboza <danielhb413@gmail.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/ppc/tcg-target.c.inc | 23 ++++++++++++++++-------
 1 file changed, 16 insertions(+), 7 deletions(-)

diff --git a/tcg/ppc/tcg-target.c.inc b/tcg/ppc/tcg-target.c.inc
index 507fe6cda8..5c8378f8f6 100644
--- a/tcg/ppc/tcg-target.c.inc
+++ b/tcg/ppc/tcg-target.c.inc
@@ -29,15 +29,24 @@
 /*
  * Standardize on the _CALL_FOO symbols used by GCC:
  * Apple XCode does not define _CALL_DARWIN.
- * Clang defines _CALL_ELF (64-bit) but not _CALL_SYSV (32-bit).
+ * Clang defines _CALL_ELF (64-bit) but not _CALL_SYSV or _CALL_AIX.
  */
-#if !defined(_CALL_SYSV) && \
-    !defined(_CALL_DARWIN) && \
-    !defined(_CALL_AIX) && \
-    !defined(_CALL_ELF)
-# if defined(__APPLE__)
+#if TCG_TARGET_REG_BITS == 64
+# ifdef _CALL_AIX
+    /* ok */
+# elif defined(_CALL_ELF) && _CALL_ELF == 1
+#  define _CALL_AIX
+# elif defined(_CALL_ELF) && _CALL_ELF == 2
+    /* ok */
+# else
+#  error "Unknown ABI"
+# endif
+#else
+# if defined(_CALL_SYSV) || defined(_CALL_DARWIN)
+    /* ok */
+# elif defined(__APPLE__)
 #  define _CALL_DARWIN
-# elif defined(__ELF__) && TCG_TARGET_REG_BITS == 32
+# elif defined(__ELF__)
 #  define _CALL_SYSV
 # else
 #  error "Unknown ABI"
-- 
2.34.1



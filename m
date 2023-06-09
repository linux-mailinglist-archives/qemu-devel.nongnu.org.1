Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D2FF6728DEF
	for <lists+qemu-devel@lfdr.de>; Fri,  9 Jun 2023 04:29:01 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q7RnO-0002T3-EG; Thu, 08 Jun 2023 22:24:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q7RnM-0002Qv-JT
 for qemu-devel@nongnu.org; Thu, 08 Jun 2023 22:24:08 -0400
Received: from mail-pf1-x42c.google.com ([2607:f8b0:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q7RnJ-0005X0-HL
 for qemu-devel@nongnu.org; Thu, 08 Jun 2023 22:24:08 -0400
Received: by mail-pf1-x42c.google.com with SMTP id
 d2e1a72fcca58-65242634690so1012851b3a.0
 for <qemu-devel@nongnu.org>; Thu, 08 Jun 2023 19:24:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1686277444; x=1688869444;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qVOgPdpdn5OzaD8uC9gXnLe4O2qeMpIufQqKixCjiEQ=;
 b=A7lSk/DZ+ucqn9riSY07zqG8Qc/clWgKKmtYD0seiIlp7TETwVJBVBpahoEMDJSGSp
 j8RZll2jOeiceCrGQjaAnKwZ6BP8c/j0YZYip9oLMwPCCCmxjg3t0XH8Po7tYbcGy1Fe
 AYKZWTIzFU3Zo7CQF+AGN+orsDr9BJ3ZB3int1PzD7Nda4Yr0oIS3+PRN+MOCA8ehiXc
 b3phXKufK4iWb5IzbDFZaZj2bE7PLRu+HRzGQ93xjeGwgDQNhtWoMpKpY9fdu8Npw7bg
 yWA5+igEME+DuTSnYHOqRMIQzUFrast+73QyaLtg1zZ3Yi5r0pG3L80+FOh0OSj6QKGd
 qNEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686277444; x=1688869444;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=qVOgPdpdn5OzaD8uC9gXnLe4O2qeMpIufQqKixCjiEQ=;
 b=jqhsz7d4CD8Kd7XSOfE8hMqykKQ9DTv1EJY1Ie0kzdQI4LW6YIgYR6YddyxYH+7eJH
 egQ9vYx2m1obzbc3GDSA63Wvk81QPWrx1I25nC+gb/BGVXipbG+Svg/0NeH2hCr/QSWZ
 02WeRZr4aclsbT2H8/qLQpDDKd0csbY/GXZj99WkhVtkkwvxfng69lX+WlMOQzd85m/M
 znsL/9dHSsUJdj4HkzkHvbNEC/hGMSJR4rRoOSeos/zsIZGkTsSjuEu4XOZkCnxglzdS
 Y4ZV/VkimYZ6y6fCwO4Zw9+N2yaf8RvpsfrckJKlPQ8ZNVmWoQfZl64JZ6QmcNw39N9N
 4lPA==
X-Gm-Message-State: AC+VfDyt2h2zx/opmLJQyrqHw5nCWqDjyw6MiVx6cHNlzMSXpUfiut9i
 V/nfxEZCuPCC2QeOraAfVrNO0qkO8cK+4yNOf3E=
X-Google-Smtp-Source: ACHHUZ5jScUBm3MHlBsloC0k0hSPoxeZif5rC4Ahz/mxxKEuaZBPr1PwVSONEjyx6c4+Guse8Bs0OA==
X-Received: by 2002:a05:6a00:1a0f:b0:65a:1efc:13ca with SMTP id
 g15-20020a056a001a0f00b0065a1efc13camr13812pfv.15.1686277444032; 
 Thu, 08 Jun 2023 19:24:04 -0700 (PDT)
Received: from stoup.. ([2602:ae:1598:4c01:b071:df63:5761:f449])
 by smtp.gmail.com with ESMTPSA id
 x25-20020a62fb19000000b0063afb08afeesm1686458pfm.67.2023.06.08.19.24.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 08 Jun 2023 19:24:03 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: ardb@kernel.org, berrange@redhat.com, qemu-ppc@nongnu.org,
 qemu-arm@nongnu.org, qemu-riscv@nongnu.org, pbonzini@redhat.com
Subject: [PATCH v2 01/38] tcg/ppc: Define _CALL_AIX for clang on ppc64(be)
Date: Thu,  8 Jun 2023 19:23:24 -0700
Message-Id: <20230609022401.684157-2-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230609022401.684157-1-richard.henderson@linaro.org>
References: <20230609022401.684157-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42c;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42c.google.com
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

Restructure the ifdef ladder, separating 64-bit from 32-bit,
and ensure _CALL_AIX is set for ELF v1.  Fixes the build for
ppc64 big-endian host with clang.

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



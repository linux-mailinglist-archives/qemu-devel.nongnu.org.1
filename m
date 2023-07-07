Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 82FFE74B82E
	for <lists+qemu-devel@lfdr.de>; Fri,  7 Jul 2023 22:42:18 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qHsGJ-0004kr-Vp; Fri, 07 Jul 2023 16:41:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qHsGG-0004j4-9b
 for qemu-devel@nongnu.org; Fri, 07 Jul 2023 16:41:04 -0400
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qHsGE-0004dL-FG
 for qemu-devel@nongnu.org; Fri, 07 Jul 2023 16:41:03 -0400
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-3fbca8935bfso25736075e9.3
 for <qemu-devel@nongnu.org>; Fri, 07 Jul 2023 13:41:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1688762461; x=1691354461;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mY6tTuYQJnWBze2KXsMQEugLPFruzX0150L5BphLiXg=;
 b=gGKHZ8VmW2tSaGVmW6c99QAmNI24HmOYeTjAJDacfVqMLr5LtBR+yEegcqGOTv07Fb
 ZyqUQcc9EwKeBqg7q4MgelxJ14cju6WcGvl661hx0zq6fkYWhMWhp6aj5AtyNB7WssmZ
 eIz93QDUb6A30tQIDaz1g45AANR7AAia8cGwtQVOlY6v0nOW/suHPsV+bfbb0/JhCv/z
 3PDXKDIi7Ib4cZivuwwUbwG7EGEG7h+/lG55C+MBZ15nJ/26i4P6I2Wpl2ZKGy/AUzbR
 zgd2VXvq/Oh+aJ/eIMnSfHWxYneFerAJm6KcQuJWpqI4vJWY3Ogbuuw4kc09JD/KxbCm
 66fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688762461; x=1691354461;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=mY6tTuYQJnWBze2KXsMQEugLPFruzX0150L5BphLiXg=;
 b=a+FSQVcZ3mj7j7CnJQB/5hG7J4S4cVNQQeZxpW+aHnuRwMmgHd76l/Yc4Q3SJSe1qz
 5VjW6C+iNvVOtt7dXkCthknMq6f6jW2bmvaYncAMSlsPsQYjTix5zDnUoRGAIyzs+LoI
 pQVQRBzpMFonQu5W0EuiSaZeJ0JwWWUWeGGsRM/gDIemuVy5a357tEirJ3t7iDLHhUG5
 aqgkBQ2AGQC5r6kypyrzlTMSxKth2zjwQ6wQT/b5k3va/Zxhddaexm9ahTGO5rtSPJ/t
 /PwKsy3uTVbiYLO3yBXeLfEl4LLFhzODk/2pwqPvKhTFwZicy2rgYI/nWJf5LQiIViA2
 TNcw==
X-Gm-Message-State: ABy/qLariwm6mRlUvDEMlcvRiAntGm0Ypc36CHkHa+oemdkG9c8ufD+j
 0hkqz2F834dEiWbt9m90k2rMd5E40NHREDrbcMwqmw==
X-Google-Smtp-Source: APBJJlFW1Ce1U2jI2uO4Ssh5eV0WsiyG6P1Qrx9o/BiLNWXmO+KLyY+5jUx9b/bnXaDatC/T/gLNRQ==
X-Received: by 2002:a7b:c3d7:0:b0:3fb:a6ee:4cec with SMTP id
 t23-20020a7bc3d7000000b003fba6ee4cecmr4499416wmj.33.1688762460838; 
 Fri, 07 Jul 2023 13:41:00 -0700 (PDT)
Received: from localhost.localdomain (host-92-23-208-66.as13285.net.
 [92.23.208.66]) by smtp.gmail.com with ESMTPSA id
 q10-20020a1ce90a000000b003fbb25da65bsm3337736wmc.30.2023.07.07.13.41.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 07 Jul 2023 13:41:00 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: laurent@vivier.eu, mjt@tls.msk.ru,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2 05/24] linux-user: Split TARGET_PROT_* out of syscall_defs.h
Date: Fri,  7 Jul 2023 21:40:35 +0100
Message-Id: <20230707204054.8792-8-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230707204054.8792-1-richard.henderson@linaro.org>
References: <20230707204054.8792-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=richard.henderson@linaro.org; helo=mail-wm1-x335.google.com
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

Move the values into the per-target target_mman.h headers

Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/aarch64/target_mman.h |  3 +++
 linux-user/generic/target_mman.h |  4 ++++
 linux-user/mips/target_mman.h    |  2 ++
 linux-user/syscall_defs.h        | 11 -----------
 linux-user/xtensa/target_mman.h  |  2 ++
 5 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/linux-user/aarch64/target_mman.h b/linux-user/aarch64/target_mman.h
index e7ba6070fe..7f15cab25e 100644
--- a/linux-user/aarch64/target_mman.h
+++ b/linux-user/aarch64/target_mman.h
@@ -1 +1,4 @@
+#define TARGET_PROT_BTI         0x10
+#define TARGET_PROT_MTE         0x20
+
 #include "../generic/target_mman.h"
diff --git a/linux-user/generic/target_mman.h b/linux-user/generic/target_mman.h
index 7b888fb7f8..39a650e751 100644
--- a/linux-user/generic/target_mman.h
+++ b/linux-user/generic/target_mman.h
@@ -1,6 +1,10 @@
 #ifndef LINUX_USER_TARGET_MMAN_H
 #define LINUX_USER_TARGET_MMAN_H
 
+#ifndef TARGET_PROT_SEM
+#define TARGET_PROT_SEM                 0x08
+#endif
+
 /* These are defined in linux/mmap.h */
 #define TARGET_MAP_SHARED               0x01
 #define TARGET_MAP_PRIVATE              0x02
diff --git a/linux-user/mips/target_mman.h b/linux-user/mips/target_mman.h
index d1d96decf5..e9f3905a52 100644
--- a/linux-user/mips/target_mman.h
+++ b/linux-user/mips/target_mman.h
@@ -1,3 +1,5 @@
+#define TARGET_PROT_SEM                 0x10
+
 #define TARGET_MAP_NORESERVE            0x0400
 #define TARGET_MAP_ANONYMOUS            0x0800
 #define TARGET_MAP_GROWSDOWN            0x1000
diff --git a/linux-user/syscall_defs.h b/linux-user/syscall_defs.h
index 118a8ac7da..9387ed422d 100644
--- a/linux-user/syscall_defs.h
+++ b/linux-user/syscall_defs.h
@@ -1251,17 +1251,6 @@ struct target_winsize {
 
 #include "termbits.h"
 
-#if defined(TARGET_MIPS) || defined(TARGET_XTENSA)
-#define TARGET_PROT_SEM         0x10
-#else
-#define TARGET_PROT_SEM         0x08
-#endif
-
-#ifdef TARGET_AARCH64
-#define TARGET_PROT_BTI         0x10
-#define TARGET_PROT_MTE         0x20
-#endif
-
 #include "target_mman.h"
 
 #if (defined(TARGET_I386) && defined(TARGET_ABI32)) \
diff --git a/linux-user/xtensa/target_mman.h b/linux-user/xtensa/target_mman.h
index d1d96decf5..e9f3905a52 100644
--- a/linux-user/xtensa/target_mman.h
+++ b/linux-user/xtensa/target_mman.h
@@ -1,3 +1,5 @@
+#define TARGET_PROT_SEM                 0x10
+
 #define TARGET_MAP_NORESERVE            0x0400
 #define TARGET_MAP_ANONYMOUS            0x0800
 #define TARGET_MAP_GROWSDOWN            0x1000
-- 
2.34.1



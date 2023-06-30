Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 150E6743C9F
	for <lists+qemu-devel@lfdr.de>; Fri, 30 Jun 2023 15:23:01 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qFE4i-0007cv-LW; Fri, 30 Jun 2023 09:22:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qFE4f-0007ay-3A
 for qemu-devel@nongnu.org; Fri, 30 Jun 2023 09:22:09 -0400
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qFE4c-0003Md-6q
 for qemu-devel@nongnu.org; Fri, 30 Jun 2023 09:22:08 -0400
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-3fbc12181b6so16369065e9.2
 for <qemu-devel@nongnu.org>; Fri, 30 Jun 2023 06:22:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1688131324; x=1690723324;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jnC1m2Ccr4orbb1SmAUD1+fjjb4uAtVXL1WfDqQvv0g=;
 b=FDDxmgLROUkga4fGVhRr6AaKxQHZGsT7wX/vG58ujanEk0MpsTn+t5b53kiJnUdogY
 YIX2+r765G4DMAMQSnIs54BdRs6rmJwnf72dBA1RqzDtDXUharcaGgq1diaq0/AVF8Qu
 f7yT8xZ4NrBC5ZcRw/MACMOeO0WM0wlSKsx80D5xc2ol5Un/QhkUkrHZXwcMwsEvfscw
 98GFUECdHf5YZDsY7aJFgkWJw8ySszMuhsAfF5s6aWjMoH0Yuw/JA5PaHM6jT+GnezFy
 ZpVB5C6lY8SJB1U8Mn7/XwcAZjJ0NkWaWK9WgNShcL8CmWcawPLi6ClYiQRjLJ0SEpbu
 cOeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688131324; x=1690723324;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=jnC1m2Ccr4orbb1SmAUD1+fjjb4uAtVXL1WfDqQvv0g=;
 b=hNQhtIlO5c3kRIAhcJsM8kUGpcPQLabDApPlJgY3NZHW+FHeR3PZtDUVlJ51sOaao3
 SkCJ2BNpVoTlylcB4wOgNkOBOxa5a0qrjwMNh2a6W4jhdYhaYqu52FdElgxQU4gMjcQs
 HV2MLqNF3UJ0n6M/BYliJ+b7ZujhqaWDjiCmQaRIAfn5HZNuEuabdKTXSvWgCemI7Km9
 0UAi/+CE8fcCH0TPz+4m+D2xmj6ayHRaJ3ztnuJc+wtnHhkBsDlR/jqjzhpZoxScQkVR
 5g6wIKNcMl1prTMdQmj/n8fFxJ/r/iLsx7gwXb8E8C59JQmTqjnk9Ij1ncm1Sr+PHLuD
 xhtQ==
X-Gm-Message-State: ABy/qLb9crwdf0QJ9cr+6lG16RiovzAxpjOn/Hv7rn7AidAFLvqwHrYN
 uMs4DgDFIWz9Glw8A3f5Kn3VDeOB6C/HA5D+htnHpw==
X-Google-Smtp-Source: APBJJlEqU4egZvoebWbdeu4Rjs3T/qCEZq9iDkDJ9rYzWAYQopumSH+EMztYz9YoWq6z3AYq1tUUBA==
X-Received: by 2002:a5d:630a:0:b0:314:1021:cd43 with SMTP id
 i10-20020a5d630a000000b003141021cd43mr2158455wru.37.1688131324246; 
 Fri, 30 Jun 2023 06:22:04 -0700 (PDT)
Received: from localhost.localdomain ([139.47.41.96])
 by smtp.gmail.com with ESMTPSA id
 a16-20020adfdd10000000b00313ef2150dcsm14571092wrm.45.2023.06.30.06.22.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 30 Jun 2023 06:22:03 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: mjt@tls.msk.ru,
	laurent@vivier.eu
Subject: [PATCH 04/24] linux-user: Split TARGET_MAP_* out of syscall_defs.h
Date: Fri, 30 Jun 2023 15:21:39 +0200
Message-Id: <20230630132159.376995-5-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230630132159.376995-1-richard.henderson@linaro.org>
References: <20230630132159.376995-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=richard.henderson@linaro.org; helo=mail-wm1-x32f.google.com
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/alpha/target_mman.h   | 13 +++++
 linux-user/generic/target_mman.h | 54 ++++++++++++++++++++
 linux-user/hppa/target_mman.h    | 10 ++++
 linux-user/mips/target_mman.h    | 11 +++++
 linux-user/mips64/target_mman.h  |  2 +-
 linux-user/ppc/target_mman.h     |  3 ++
 linux-user/sparc/target_mman.h   |  4 ++
 linux-user/syscall_defs.h        | 85 +-------------------------------
 linux-user/xtensa/target_mman.h  | 11 +++++
 9 files changed, 108 insertions(+), 85 deletions(-)

diff --git a/linux-user/alpha/target_mman.h b/linux-user/alpha/target_mman.h
index 051544f5ab..6bb03e7336 100644
--- a/linux-user/alpha/target_mman.h
+++ b/linux-user/alpha/target_mman.h
@@ -1,6 +1,19 @@
 #ifndef ALPHA_TARGET_MMAN_H
 #define ALPHA_TARGET_MMAN_H
 
+#define TARGET_MAP_ANONYMOUS            0x10
+#define TARGET_MAP_FIXED                0x100
+#define TARGET_MAP_GROWSDOWN            0x01000
+#define TARGET_MAP_DENYWRITE            0x02000
+#define TARGET_MAP_EXECUTABLE           0x04000
+#define TARGET_MAP_LOCKED               0x08000
+#define TARGET_MAP_NORESERVE            0x10000
+#define TARGET_MAP_POPULATE             0x20000
+#define TARGET_MAP_NONBLOCK             0x40000
+#define TARGET_MAP_STACK                0x80000
+#define TARGET_MAP_HUGETLB              0x100000
+#define TARGET_MAP_FIXED_NOREPLACE      0x200000
+
 #define TARGET_MADV_DONTNEED 6
 
 #define TARGET_MS_ASYNC 1
diff --git a/linux-user/generic/target_mman.h b/linux-user/generic/target_mman.h
index 32bf1a52d0..7b888fb7f8 100644
--- a/linux-user/generic/target_mman.h
+++ b/linux-user/generic/target_mman.h
@@ -1,6 +1,60 @@
 #ifndef LINUX_USER_TARGET_MMAN_H
 #define LINUX_USER_TARGET_MMAN_H
 
+/* These are defined in linux/mmap.h */
+#define TARGET_MAP_SHARED               0x01
+#define TARGET_MAP_PRIVATE              0x02
+#define TARGET_MAP_SHARED_VALIDATE      0x03
+
+/* 0x0100 - 0x4000 flags are defined in asm-generic/mman.h */
+#ifndef TARGET_MAP_GROWSDOWN
+#define TARGET_MAP_GROWSDOWN            0x0100
+#endif
+#ifndef TARGET_MAP_DENYWRITE
+#define TARGET_MAP_DENYWRITE            0x0800
+#endif
+#ifndef TARGET_MAP_EXECUTABLE
+#define TARGET_MAP_EXECUTABLE           0x1000
+#endif
+#ifndef TARGET_MAP_LOCKED
+#define TARGET_MAP_LOCKED               0x2000
+#endif
+#ifndef TARGET_MAP_NORESERVE
+#define TARGET_MAP_NORESERVE            0x4000
+#endif
+
+/* Other MAP flags are defined in asm-generic/mman-common.h */
+#ifndef TARGET_MAP_TYPE
+#define TARGET_MAP_TYPE                 0x0f
+#endif
+#ifndef TARGET_MAP_FIXED
+#define TARGET_MAP_FIXED                0x10
+#endif
+#ifndef TARGET_MAP_ANONYMOUS
+#define TARGET_MAP_ANONYMOUS            0x20
+#endif
+#ifndef TARGET_MAP_POPULATE
+#define TARGET_MAP_POPULATE             0x008000
+#endif
+#ifndef TARGET_MAP_NONBLOCK
+#define TARGET_MAP_NONBLOCK             0x010000
+#endif
+#ifndef TARGET_MAP_STACK
+#define TARGET_MAP_STACK                0x020000
+#endif
+#ifndef TARGET_MAP_HUGETLB
+#define TARGET_MAP_HUGETLB              0x040000
+#endif
+#ifndef TARGET_MAP_SYNC
+#define TARGET_MAP_SYNC                 0x080000
+#endif
+#ifndef TARGET_MAP_FIXED_NOREPLACE
+#define TARGET_MAP_FIXED_NOREPLACE      0x100000
+#endif
+#ifndef TARGET_MAP_UNINITIALIZED
+#define TARGET_MAP_UNINITIALIZED        0x4000000
+#endif
+
 #ifndef TARGET_MADV_NORMAL
 #define TARGET_MADV_NORMAL 0
 #endif
diff --git a/linux-user/hppa/target_mman.h b/linux-user/hppa/target_mman.h
index f9b6b97032..97f87d042a 100644
--- a/linux-user/hppa/target_mman.h
+++ b/linux-user/hppa/target_mman.h
@@ -1,6 +1,16 @@
 #ifndef HPPA_TARGET_MMAN_H
 #define HPPA_TARGET_MMAN_H
 
+#define TARGET_MAP_TYPE                 0x2b
+#define TARGET_MAP_FIXED                0x04
+#define TARGET_MAP_ANONYMOUS            0x10
+#define TARGET_MAP_GROWSDOWN            0x8000
+#define TARGET_MAP_POPULATE             0x10000
+#define TARGET_MAP_NONBLOCK             0x20000
+#define TARGET_MAP_STACK                0x40000
+#define TARGET_MAP_HUGETLB              0x80000
+#define TARGET_MAP_UNINITIALIZED        0
+
 #define TARGET_MADV_MERGEABLE 65
 #define TARGET_MADV_UNMERGEABLE 66
 #define TARGET_MADV_HUGEPAGE 67
diff --git a/linux-user/mips/target_mman.h b/linux-user/mips/target_mman.h
index e7ba6070fe..d1d96decf5 100644
--- a/linux-user/mips/target_mman.h
+++ b/linux-user/mips/target_mman.h
@@ -1 +1,12 @@
+#define TARGET_MAP_NORESERVE            0x0400
+#define TARGET_MAP_ANONYMOUS            0x0800
+#define TARGET_MAP_GROWSDOWN            0x1000
+#define TARGET_MAP_DENYWRITE            0x2000
+#define TARGET_MAP_EXECUTABLE           0x4000
+#define TARGET_MAP_LOCKED               0x8000
+#define TARGET_MAP_POPULATE             0x10000
+#define TARGET_MAP_NONBLOCK             0x20000
+#define TARGET_MAP_STACK                0x40000
+#define TARGET_MAP_HUGETLB              0x80000
+
 #include "../generic/target_mman.h"
diff --git a/linux-user/mips64/target_mman.h b/linux-user/mips64/target_mman.h
index e7ba6070fe..7bdc47d902 100644
--- a/linux-user/mips64/target_mman.h
+++ b/linux-user/mips64/target_mman.h
@@ -1 +1 @@
-#include "../generic/target_mman.h"
+#include "../mips/target_mman.h"
diff --git a/linux-user/ppc/target_mman.h b/linux-user/ppc/target_mman.h
index e7ba6070fe..c90be347f6 100644
--- a/linux-user/ppc/target_mman.h
+++ b/linux-user/ppc/target_mman.h
@@ -1 +1,4 @@
+#define TARGET_MAP_NORESERVE            0x40
+#define TARGET_MAP_LOCKED               0x80
+
 #include "../generic/target_mman.h"
diff --git a/linux-user/sparc/target_mman.h b/linux-user/sparc/target_mman.h
index e7ba6070fe..3fdee19d8a 100644
--- a/linux-user/sparc/target_mman.h
+++ b/linux-user/sparc/target_mman.h
@@ -1 +1,5 @@
+#define TARGET_MAP_NORESERVE           0x40
+#define TARGET_MAP_LOCKED              0x100
+#define TARGET_MAP_GROWSDOWN           0x0200
+
 #include "../generic/target_mman.h"
diff --git a/linux-user/syscall_defs.h b/linux-user/syscall_defs.h
index cc37054cb5..118a8ac7da 100644
--- a/linux-user/syscall_defs.h
+++ b/linux-user/syscall_defs.h
@@ -1262,90 +1262,7 @@ struct target_winsize {
 #define TARGET_PROT_MTE         0x20
 #endif
 
-/* Common */
-#define TARGET_MAP_SHARED	0x01		/* Share changes */
-#define TARGET_MAP_PRIVATE	0x02		/* Changes are private */
-#if defined(TARGET_HPPA)
-#define TARGET_MAP_TYPE         0x03		/* Mask for type of mapping */
-#else
-#define TARGET_MAP_TYPE         0x0f		/* Mask for type of mapping */
-#endif
-
-/* Target specific */
-#if defined(TARGET_MIPS)
-#define TARGET_MAP_FIXED	0x10		/* Interpret addr exactly */
-#define TARGET_MAP_ANONYMOUS	0x0800		/* don't use a file */
-#define TARGET_MAP_GROWSDOWN	0x1000		/* stack-like segment */
-#define TARGET_MAP_DENYWRITE	0x2000		/* ETXTBSY */
-#define TARGET_MAP_EXECUTABLE	0x4000		/* mark it as an executable */
-#define TARGET_MAP_LOCKED	0x8000		/* pages are locked */
-#define TARGET_MAP_NORESERVE	0x0400		/* don't check for reservations */
-#define TARGET_MAP_POPULATE	0x10000		/* populate (prefault) pagetables */
-#define TARGET_MAP_NONBLOCK	0x20000		/* do not block on IO */
-#define TARGET_MAP_STACK        0x40000         /* ignored */
-#define TARGET_MAP_HUGETLB      0x80000         /* create a huge page mapping */
-#elif defined(TARGET_PPC)
-#define TARGET_MAP_FIXED	0x10		/* Interpret addr exactly */
-#define TARGET_MAP_ANONYMOUS	0x20		/* don't use a file */
-#define TARGET_MAP_GROWSDOWN	0x0100		/* stack-like segment */
-#define TARGET_MAP_DENYWRITE	0x0800		/* ETXTBSY */
-#define TARGET_MAP_EXECUTABLE	0x1000		/* mark it as an executable */
-#define TARGET_MAP_LOCKED	0x0080		/* pages are locked */
-#define TARGET_MAP_NORESERVE	0x0040		/* don't check for reservations */
-#define TARGET_MAP_POPULATE	0x8000		/* populate (prefault) pagetables */
-#define TARGET_MAP_NONBLOCK	0x10000		/* do not block on IO */
-#define TARGET_MAP_STACK        0x20000         /* ignored */
-#define TARGET_MAP_HUGETLB      0x40000         /* create a huge page mapping */
-#elif defined(TARGET_ALPHA)
-#define TARGET_MAP_ANONYMOUS	0x10		/* don't use a file */
-#define TARGET_MAP_FIXED	0x100		/* Interpret addr exactly */
-#define TARGET_MAP_GROWSDOWN	0x01000		/* stack-like segment */
-#define TARGET_MAP_DENYWRITE	0x02000		/* ETXTBSY */
-#define TARGET_MAP_EXECUTABLE	0x04000		/* mark it as an executable */
-#define TARGET_MAP_LOCKED	0x08000		/* lock the mapping */
-#define TARGET_MAP_NORESERVE	0x10000		/* no check for reservations */
-#define TARGET_MAP_POPULATE	0x20000		/* pop (prefault) pagetables */
-#define TARGET_MAP_NONBLOCK	0x40000		/* do not block on IO */
-#define TARGET_MAP_STACK        0x80000         /* ignored */
-#define TARGET_MAP_HUGETLB      0x100000        /* create a huge page mapping */
-#elif defined(TARGET_HPPA)
-#define TARGET_MAP_ANONYMOUS	0x10		/* don't use a file */
-#define TARGET_MAP_FIXED	0x04		/* Interpret addr exactly */
-#define TARGET_MAP_GROWSDOWN	0x08000		/* stack-like segment */
-#define TARGET_MAP_DENYWRITE	0x00800		/* ETXTBSY */
-#define TARGET_MAP_EXECUTABLE	0x01000		/* mark it as an executable */
-#define TARGET_MAP_LOCKED	0x02000		/* lock the mapping */
-#define TARGET_MAP_NORESERVE	0x04000		/* no check for reservations */
-#define TARGET_MAP_POPULATE	0x10000		/* pop (prefault) pagetables */
-#define TARGET_MAP_NONBLOCK	0x20000		/* do not block on IO */
-#define TARGET_MAP_STACK        0x40000         /* ignored */
-#define TARGET_MAP_HUGETLB      0x80000         /* create a huge page mapping */
-#elif defined(TARGET_XTENSA)
-#define TARGET_MAP_FIXED	0x10		/* Interpret addr exactly */
-#define TARGET_MAP_ANONYMOUS	0x0800		/* don't use a file */
-#define TARGET_MAP_GROWSDOWN	0x1000		/* stack-like segment */
-#define TARGET_MAP_DENYWRITE	0x2000		/* ETXTBSY */
-#define TARGET_MAP_EXECUTABLE	0x4000		/* mark it as an executable */
-#define TARGET_MAP_LOCKED	0x8000		/* pages are locked */
-#define TARGET_MAP_NORESERVE	0x0400		/* don't check for reservations */
-#define TARGET_MAP_POPULATE	0x10000		/* populate (prefault) pagetables */
-#define TARGET_MAP_NONBLOCK	0x20000		/* do not block on IO */
-#define TARGET_MAP_STACK	0x40000
-#define TARGET_MAP_HUGETLB  0x80000         /* create a huge page mapping */
-#else
-#define TARGET_MAP_FIXED	0x10		/* Interpret addr exactly */
-#define TARGET_MAP_ANONYMOUS	0x20		/* don't use a file */
-#define TARGET_MAP_GROWSDOWN	0x0100		/* stack-like segment */
-#define TARGET_MAP_DENYWRITE	0x0800		/* ETXTBSY */
-#define TARGET_MAP_EXECUTABLE	0x1000		/* mark it as an executable */
-#define TARGET_MAP_LOCKED	0x2000		/* pages are locked */
-#define TARGET_MAP_NORESERVE	0x4000		/* don't check for reservations */
-#define TARGET_MAP_POPULATE	0x8000		/* populate (prefault) pagetables */
-#define TARGET_MAP_NONBLOCK	0x10000		/* do not block on IO */
-#define TARGET_MAP_STACK        0x20000         /* ignored */
-#define TARGET_MAP_HUGETLB      0x40000         /* create a huge page mapping */
-#define TARGET_MAP_UNINITIALIZED 0x4000000	/* for anonymous mmap, memory could be uninitialized */
-#endif
+#include "target_mman.h"
 
 #if (defined(TARGET_I386) && defined(TARGET_ABI32)) \
     || (defined(TARGET_ARM) && defined(TARGET_ABI32)) \
diff --git a/linux-user/xtensa/target_mman.h b/linux-user/xtensa/target_mman.h
index e7ba6070fe..d1d96decf5 100644
--- a/linux-user/xtensa/target_mman.h
+++ b/linux-user/xtensa/target_mman.h
@@ -1 +1,12 @@
+#define TARGET_MAP_NORESERVE            0x0400
+#define TARGET_MAP_ANONYMOUS            0x0800
+#define TARGET_MAP_GROWSDOWN            0x1000
+#define TARGET_MAP_DENYWRITE            0x2000
+#define TARGET_MAP_EXECUTABLE           0x4000
+#define TARGET_MAP_LOCKED               0x8000
+#define TARGET_MAP_POPULATE             0x10000
+#define TARGET_MAP_NONBLOCK             0x20000
+#define TARGET_MAP_STACK                0x40000
+#define TARGET_MAP_HUGETLB              0x80000
+
 #include "../generic/target_mman.h"
-- 
2.34.1



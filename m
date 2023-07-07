Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C0C074B829
	for <lists+qemu-devel@lfdr.de>; Fri,  7 Jul 2023 22:41:41 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qHsGJ-0004km-Bh; Fri, 07 Jul 2023 16:41:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qHsGG-0004jV-W7
 for qemu-devel@nongnu.org; Fri, 07 Jul 2023 16:41:05 -0400
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qHsGD-0004cd-Oa
 for qemu-devel@nongnu.org; Fri, 07 Jul 2023 16:41:04 -0400
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-313f1085ac2so2334991f8f.1
 for <qemu-devel@nongnu.org>; Fri, 07 Jul 2023 13:41:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1688762460; x=1691354460;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Xm/88LESveI60RzcZ8mZWBsO4QkC6Ygg53ln6ZnSnG0=;
 b=oUn/K4G6KjOPfhLLuMyr5CvFbuEk9e3YTGFFPGaEzTiSKIW+LbOYWAd98USKNk5M9e
 MNvTYHZOOC2/coelMk5rwNFtPDSpLmccPNOgC7umF+h2DPNJXegY9JVkaQo3J7GPIYhC
 klkZo+lz/taJ9nhCUqCYpQXkuvYHPOnsU6SZ2BtDWos0VQuT0H7FBEzRYUS2jVxWukzC
 25ReBA3AFmJJlazob8k1YCns6+hqMLJNek6Nj9kWpVRZpW0l7LDclAIVz2dZUNcuayhy
 prjVyj24UtRN8+OeaK7oKwYMcBUi9ypWKRFgQ9nBx9wV0vMwoYVEyTIu8fuaeDTHB1h3
 4uEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688762460; x=1691354460;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Xm/88LESveI60RzcZ8mZWBsO4QkC6Ygg53ln6ZnSnG0=;
 b=jBuuLPZ7/TWDGFEL+I8jJFGPW4GPjNKaVOSOLYjyGHjVskjo92Z158LqDl03Hfgm3o
 y8/C6RaEHQfBmbqR3CJzLXCcjYBPJjjZ3yRF3+AfjAWMZUWY7IYhxyutjyv3LI22BS/u
 LUlx3VACtSUuDnHD3a1pDb9fILnDh56PseBD/vmSwOTVC/J674bt2EjlUGpPHHHmkQkl
 hzkrwPUXs7SqYHIzyTvN51S4WQxTPO0DAm0dH6RRiGd3g3/2LuFcdHG/YgcMh5YJ+YYo
 0O/aWsIo9Xv8yWZOJVFNKl8FFn21DqHpGOskKozsRVd8UGhPrIMdf9IBllLaeyPsOoze
 xLtw==
X-Gm-Message-State: ABy/qLYwZOKF5Hak5N1cZORP0Q9HbvEN5WIU6JnIzOgXtlnSOw25n9eE
 xqM/c/wGMZU+mILaBfgMZbehqyrB3X6mh71UI5QQOQ==
X-Google-Smtp-Source: APBJJlGiMZZhosoG2H2oA/tdNQfQXTo9/OPtXPCX1x0lxItgANdDLP+mJJbXxiNdOCjqngbhF5MLlg==
X-Received: by 2002:adf:e483:0:b0:314:1bb7:8a19 with SMTP id
 i3-20020adfe483000000b003141bb78a19mr4617443wrm.35.1688762460364; 
 Fri, 07 Jul 2023 13:41:00 -0700 (PDT)
Received: from localhost.localdomain (host-92-23-208-66.as13285.net.
 [92.23.208.66]) by smtp.gmail.com with ESMTPSA id
 q10-20020a1ce90a000000b003fbb25da65bsm3337736wmc.30.2023.07.07.13.40.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 07 Jul 2023 13:41:00 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: laurent@vivier.eu, mjt@tls.msk.ru,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PATCH v2 04/24] linux-user: Split TARGET_MAP_* out of syscall_defs.h
Date: Fri,  7 Jul 2023 21:40:34 +0100
Message-Id: <20230707204054.8792-7-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230707204054.8792-1-richard.henderson@linaro.org>
References: <20230707204054.8792-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::434;
 envelope-from=richard.henderson@linaro.org; helo=mail-wr1-x434.google.com
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



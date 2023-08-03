Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DCB376DDB4
	for <lists+qemu-devel@lfdr.de>; Thu,  3 Aug 2023 03:55:49 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qRNWe-0000hG-RL; Wed, 02 Aug 2023 21:53:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qRNWc-0000gE-ES
 for qemu-devel@nongnu.org; Wed, 02 Aug 2023 21:53:14 -0400
Received: from mail-oi1-x22a.google.com ([2607:f8b0:4864:20::22a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qRNWa-0000mf-Na
 for qemu-devel@nongnu.org; Wed, 02 Aug 2023 21:53:14 -0400
Received: by mail-oi1-x22a.google.com with SMTP id
 5614622812f47-3a5ad4477a7so316351b6e.1
 for <qemu-devel@nongnu.org>; Wed, 02 Aug 2023 18:53:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1691027591; x=1691632391;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=aEyLi7PRVP/zH4T2EImkSfY8Qlh6o6YBBN9cdFqzGtY=;
 b=h6AXkEcXy7q7Gfjm4SNKw3qfW/GGsR9sEiJZ+T5/0Xswp18ItRzQerWj6Nqh93quF+
 vfVm9jQm2XBmrOTarB35619JSQfot6YxNGNrMDhOrvX/fzDmE35+EIpC5/iAa9AJNbuT
 4nHC9T+RGEXZbOYcQOW2pYnc/uZB3nXEfyYryg6k3dFYB0d+ji94xkhGYni426WEWZXF
 9NxouIJttx+E1Uc2pqXZMDljCkQx1mgB+0bBygyUP+HM8Rqvyao6M/EWE6sVzE+prQX5
 G69F1z+Jq6VnKcJF2+vf++wDLAEkmXj8u+plTK7XVnDNWxvz3SE2FEmIIj8mL9QqlSs5
 xbcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691027591; x=1691632391;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=aEyLi7PRVP/zH4T2EImkSfY8Qlh6o6YBBN9cdFqzGtY=;
 b=Da4XLQbmvQKNP77nSUyAfa6dxvnTOCebcA8faef3dHFywkw5Zjqo16N8L1HMh5Yykw
 9mVvI48M0tybzT1wqYnos9JqNVbZxs9HF84brJxdF2gvtdkuOysAWanAsWXVSMda77ak
 abAVUVL40Pp4UOQ7o8lH8mSQXxMRwZTmHr6SbIa8/ayTweFSkVF0YCrtWH1mHGt1y+X3
 0eWJMYKi+2El93hIEJ80rTdgfbSpsI1VVfLT5ihMWz73veOsAf1g+IgSKKcDZqJp3eIo
 SAm1u33TvZ4Msn2X8fz92hGBJrpTFTh09TcLg0jeHdf1VrTyC+EQaSH77JCiCdMPK+F3
 kGfg==
X-Gm-Message-State: ABy/qLZKggRfaTasEjcJ+pL67kWCZTl54ztauU8GdX44o4GwUPpqM9iv
 GpwcXhd4mA+JLtuuW6Fd6Cy5CiHJM0am97JJs/g=
X-Google-Smtp-Source: APBJJlGedPsXXyNlzRgbJgDnBzNDDqeCqrUPk4wY4L6M5i79OxiL11wg2omhDK8/eVsTUCsqr3Ncyg==
X-Received: by 2002:a05:6808:93:b0:3a7:5075:b0b8 with SMTP id
 s19-20020a056808009300b003a75075b0b8mr5699447oic.4.1691027591680; 
 Wed, 02 Aug 2023 18:53:11 -0700 (PDT)
Received: from stoup.. ([2602:47:d490:6901:b659:bbad:1a22:7ef9])
 by smtp.gmail.com with ESMTPSA id
 s25-20020a63a319000000b005649cee408fsm157123pge.0.2023.08.02.18.53.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 02 Aug 2023 18:53:11 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: deller@gmx.de, laurent@vivier.eu, akihiko.odaki@daynix.com, joel@jms.id.au
Subject: [PATCH v7 09/14] linux-user: Adjust task_unmapped_base for reserved_va
Date: Wed,  2 Aug 2023 18:52:57 -0700
Message-Id: <20230803015302.407219-10-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230803015302.407219-1-richard.henderson@linaro.org>
References: <20230803015302.407219-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::22a;
 envelope-from=richard.henderson@linaro.org; helo=mail-oi1-x22a.google.com
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

Ensure that the chosen values for mmap_next_start and
task_unmapped_base are within the guest address space.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/user-mmap.h | 18 +++++++++++++++++-
 linux-user/main.c      | 26 ++++++++++++++++++++++++++
 linux-user/mmap.c      | 18 +++---------------
 3 files changed, 46 insertions(+), 16 deletions(-)

diff --git a/linux-user/user-mmap.h b/linux-user/user-mmap.h
index 7265c2c116..fd456e024e 100644
--- a/linux-user/user-mmap.h
+++ b/linux-user/user-mmap.h
@@ -18,6 +18,23 @@
 #ifndef LINUX_USER_USER_MMAP_H
 #define LINUX_USER_USER_MMAP_H
 
+#if HOST_LONG_BITS == 64 && TARGET_ABI_BITS == 64
+#ifdef TARGET_AARCH64
+# define TASK_UNMAPPED_BASE  0x5500000000
+#else
+# define TASK_UNMAPPED_BASE  (1ul << 38)
+#endif
+#else
+#ifdef TARGET_HPPA
+# define TASK_UNMAPPED_BASE  0xfa000000
+#else
+# define TASK_UNMAPPED_BASE  0x40000000
+#endif
+#endif
+
+extern abi_ulong task_unmapped_base;
+extern abi_ulong mmap_next_start;
+
 int target_mprotect(abi_ulong start, abi_ulong len, int prot);
 abi_long target_mmap(abi_ulong start, abi_ulong len, int prot,
                      int flags, int fd, off_t offset);
@@ -26,7 +43,6 @@ abi_long target_mremap(abi_ulong old_addr, abi_ulong old_size,
                        abi_ulong new_size, unsigned long flags,
                        abi_ulong new_addr);
 abi_long target_madvise(abi_ulong start, abi_ulong len_in, int advice);
-extern abi_ulong mmap_next_start;
 abi_ulong mmap_find_vma(abi_ulong, abi_ulong, abi_ulong);
 void mmap_fork_start(void);
 void mmap_fork_end(int child);
diff --git a/linux-user/main.c b/linux-user/main.c
index dba67ffa36..c207b783d5 100644
--- a/linux-user/main.c
+++ b/linux-user/main.c
@@ -821,6 +821,32 @@ int main(int argc, char **argv, char **envp)
         reserved_va = max_reserved_va;
     }
 
+    /*
+     * Promote X and Y to a common type and compare.
+     * ??? Perhaps better to locally disable -Werror=type-limits.
+     */
+#define LESS(X, Y) ((1 ? X : Y) < (1 ? Y : X))
+
+    /*
+     * Select an initial value for task_unmapped_base that is in range.
+     */
+    if (reserved_va) {
+        if (LESS(TASK_UNMAPPED_BASE, reserved_va)) {
+            task_unmapped_base = TASK_UNMAPPED_BASE;
+        } else {
+            /* The most common default formula is TASK_SIZE / 3. */
+            task_unmapped_base = TARGET_PAGE_ALIGN(reserved_va / 3);
+        }
+    } else if (LESS(TASK_UNMAPPED_BASE, UINTPTR_MAX)) {
+        task_unmapped_base = TASK_UNMAPPED_BASE;
+    } else {
+        /* 32-bit host: pick something medium size. */
+        task_unmapped_base = 0x10000000;
+    }
+    mmap_next_start = task_unmapped_base;
+
+#undef LESS
+
     {
         Error *err = NULL;
         if (seed_optarg != NULL) {
diff --git a/linux-user/mmap.c b/linux-user/mmap.c
index eb04fab8ab..84436d45c8 100644
--- a/linux-user/mmap.c
+++ b/linux-user/mmap.c
@@ -299,20 +299,8 @@ static bool mmap_frag(abi_ulong real_start, abi_ulong start, abi_ulong last,
     return true;
 }
 
-#if HOST_LONG_BITS == 64 && TARGET_ABI_BITS == 64
-#ifdef TARGET_AARCH64
-# define TASK_UNMAPPED_BASE  0x5500000000
-#else
-# define TASK_UNMAPPED_BASE  (1ul << 38)
-#endif
-#else
-#ifdef TARGET_HPPA
-# define TASK_UNMAPPED_BASE  0xfa000000
-#else
-# define TASK_UNMAPPED_BASE  0x40000000
-#endif
-#endif
-abi_ulong mmap_next_start = TASK_UNMAPPED_BASE;
+abi_ulong task_unmapped_base;
+abi_ulong mmap_next_start;
 
 /*
  * Subroutine of mmap_find_vma, used when we have pre-allocated
@@ -391,7 +379,7 @@ abi_ulong mmap_find_vma(abi_ulong start, abi_ulong size, abi_ulong align)
 
             if ((addr & (align - 1)) == 0) {
                 /* Success.  */
-                if (start == mmap_next_start && addr >= TASK_UNMAPPED_BASE) {
+                if (start == mmap_next_start && addr >= task_unmapped_base) {
                     mmap_next_start = addr + size;
                 }
                 return addr;
-- 
2.34.1



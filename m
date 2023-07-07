Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AC7E74B82D
	for <lists+qemu-devel@lfdr.de>; Fri,  7 Jul 2023 22:42:04 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qHsGM-0004o0-0q; Fri, 07 Jul 2023 16:41:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qHsGK-0004nb-Ry
 for qemu-devel@nongnu.org; Fri, 07 Jul 2023 16:41:08 -0400
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qHsGI-0004ib-3J
 for qemu-devel@nongnu.org; Fri, 07 Jul 2023 16:41:08 -0400
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-3fb4146e8deso29580165e9.0
 for <qemu-devel@nongnu.org>; Fri, 07 Jul 2023 13:41:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1688762464; x=1691354464;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rBQg9cfWnYMnQbgH1xQmPDp7YLGiDcpxqAFflb/oQe8=;
 b=Vih31CfPlYQYpzDeGEsYi6gSeBGx/jG6//rAOE0MxtRPSGBOJqNRWnBlTwy7MnICvd
 IsdELpwMFumR/d4m+ywNELOp9gzVZyydjqNfiAi9NNe49vA0SuXzbraFZ3UPwLj4vUs5
 gk2VEdRtaQ9ziTypQTWf2dB9vLfN/UiL9CsnxoBCLWGONBMEQvOtHjC+wZA9yep66hMQ
 /ylReFTSIMKSHglCjHtSodxBxksJpDCjs+EsNmaSHK03SDfaLidJLkzekXSzOGmD/2PG
 iXK/AsXNwSgNq7HXUy2mx9S+/uF30zMYM6iUPxrjKJmOShN9lNYl6evJDT5M8+O23Ddq
 TjWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688762464; x=1691354464;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=rBQg9cfWnYMnQbgH1xQmPDp7YLGiDcpxqAFflb/oQe8=;
 b=hRvwGrBo4CBdFBC43snqOBTibO6GVXp07OcpQQD0bv/Jbu+lhp7pECKt64eCih0EoR
 FSRpcsEVFNs0ttJam/El+Bib3eNEkQRXSE7BGuF/KgOVBUc/kYKHEvyFMdgdIQqERwqc
 D1nSyYrTCsMdOj1T9JukGLkQmm26bIkDoBp10ybOqmZlaer6SWgWEzMRpCqbgOTyq+wa
 c2IZBhVTU1waVh1t2LzwhbH3XjwlhESOh6GWDS6tQKIqvirbIJSV5U44TnzLF6UsgBlI
 zeNlOGUZsSdZnSv9DkbmdrkPODVNjXOTjU/Qu3XCFb8TdAEIZg46wiMkkTOO96XdYz3U
 a7OQ==
X-Gm-Message-State: ABy/qLbeKnGfeCrzXLH1fpxkIT6tfn3na3igbfFwivb/iq9DDZNryWIp
 HJ1jXbLrfnQLgEG5xBbSRL//+PD4qiOzPEUGGv4qAQ==
X-Google-Smtp-Source: APBJJlHK+F3npKWWUsNKcbGjTGZiBd9Ks3WswKLRKKGz/fi311x9WDudpg4XQT4fQfrIItbb3MlqEw==
X-Received: by 2002:a05:600c:2311:b0:3f9:b748:ff37 with SMTP id
 17-20020a05600c231100b003f9b748ff37mr6478315wmo.20.1688762464768; 
 Fri, 07 Jul 2023 13:41:04 -0700 (PDT)
Received: from localhost.localdomain (host-92-23-208-66.as13285.net.
 [92.23.208.66]) by smtp.gmail.com with ESMTPSA id
 q10-20020a1ce90a000000b003fbb25da65bsm3337736wmc.30.2023.07.07.13.41.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 07 Jul 2023 13:41:04 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: laurent@vivier.eu, mjt@tls.msk.ru,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PATCH v2 11/24] linux-user: Widen target_mmap offset argument to
 off_t
Date: Fri,  7 Jul 2023 21:40:41 +0100
Message-Id: <20230707204054.8792-14-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230707204054.8792-1-richard.henderson@linaro.org>
References: <20230707204054.8792-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=richard.henderson@linaro.org; helo=mail-wm1-x336.google.com
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

We build with _FILE_OFFSET_BITS=64, so off_t = off64_t = uint64_t.
With an extra cast, this fixes emulation of mmap2, which could
overflow the computation of the full value of offset.

Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/user-mmap.h |  2 +-
 linux-user/mmap.c      | 14 ++++++++------
 linux-user/syscall.c   |  2 +-
 3 files changed, 10 insertions(+), 8 deletions(-)

diff --git a/linux-user/user-mmap.h b/linux-user/user-mmap.h
index 480ce1c114..3fc986f92f 100644
--- a/linux-user/user-mmap.h
+++ b/linux-user/user-mmap.h
@@ -20,7 +20,7 @@
 
 int target_mprotect(abi_ulong start, abi_ulong len, int prot);
 abi_long target_mmap(abi_ulong start, abi_ulong len, int prot,
-                     int flags, int fd, abi_ulong offset);
+                     int flags, int fd, off_t offset);
 int target_munmap(abi_ulong start, abi_ulong len);
 abi_long target_mremap(abi_ulong old_addr, abi_ulong old_size,
                        abi_ulong new_size, unsigned long flags,
diff --git a/linux-user/mmap.c b/linux-user/mmap.c
index 422583ed4f..bba01804b3 100644
--- a/linux-user/mmap.c
+++ b/linux-user/mmap.c
@@ -195,7 +195,7 @@ error:
 /* map an incomplete host page */
 static int mmap_frag(abi_ulong real_start,
                      abi_ulong start, abi_ulong end,
-                     int prot, int flags, int fd, abi_ulong offset)
+                     int prot, int flags, int fd, off_t offset)
 {
     abi_ulong real_end, addr;
     void *host_start;
@@ -462,11 +462,12 @@ abi_ulong mmap_find_vma(abi_ulong start, abi_ulong size, abi_ulong align)
 
 /* NOTE: all the constants are the HOST ones */
 abi_long target_mmap(abi_ulong start, abi_ulong len, int target_prot,
-                     int flags, int fd, abi_ulong offset)
+                     int flags, int fd, off_t offset)
 {
-    abi_ulong ret, end, real_start, real_end, retaddr, host_offset, host_len,
+    abi_ulong ret, end, real_start, real_end, retaddr, host_len,
               passthrough_start = -1, passthrough_end = -1;
     int page_flags;
+    off_t host_offset;
 
     mmap_lock();
     trace_target_mmap(start, len, target_prot, flags, fd, offset);
@@ -558,7 +559,7 @@ abi_long target_mmap(abi_ulong start, abi_ulong len, int target_prot,
     }
 
     if (!(flags & (MAP_FIXED | MAP_FIXED_NOREPLACE))) {
-        unsigned long host_start;
+        uintptr_t host_start;
         int host_prot;
         void *p;
 
@@ -577,7 +578,7 @@ abi_long target_mmap(abi_ulong start, abi_ulong len, int target_prot,
             goto fail;
         }
         /* update start so that it points to the file position at 'offset' */
-        host_start = (unsigned long)p;
+        host_start = (uintptr_t)p;
         if (!(flags & MAP_ANONYMOUS)) {
             p = mmap(g2h_untagged(start), len, host_prot,
                      flags | MAP_FIXED, fd, host_offset);
@@ -681,7 +682,8 @@ abi_long target_mmap(abi_ulong start, abi_ulong len, int target_prot,
         /* map the middle (easier) */
         if (real_start < real_end) {
             void *p;
-            unsigned long offset1;
+            off_t offset1;
+
             if (flags & MAP_ANONYMOUS) {
                 offset1 = 0;
             } else {
diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index 2c0c6e745e..b9b5e37c5e 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -10430,7 +10430,7 @@ static abi_long do_syscall1(CPUArchState *cpu_env, int num, abi_long arg1,
 #endif
         ret = target_mmap(arg1, arg2, arg3,
                           target_to_host_bitmask(arg4, mmap_flags_tbl),
-                          arg5, arg6 << MMAP_SHIFT);
+                          arg5, (off_t)(abi_ulong)arg6 << MMAP_SHIFT);
         return get_errno(ret);
 #endif
     case TARGET_NR_munmap:
-- 
2.34.1



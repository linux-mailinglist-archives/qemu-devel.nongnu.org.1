Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E19917766B3
	for <lists+qemu-devel@lfdr.de>; Wed,  9 Aug 2023 19:51:10 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qTnK3-0000OA-7i; Wed, 09 Aug 2023 13:50:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qTnK1-0000No-La
 for qemu-devel@nongnu.org; Wed, 09 Aug 2023 13:50:13 -0400
Received: from mail-pg1-x533.google.com ([2607:f8b0:4864:20::533])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qTnJz-0005ee-RW
 for qemu-devel@nongnu.org; Wed, 09 Aug 2023 13:50:13 -0400
Received: by mail-pg1-x533.google.com with SMTP id
 41be03b00d2f7-565331f0736so113703a12.0
 for <qemu-devel@nongnu.org>; Wed, 09 Aug 2023 10:50:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1691603410; x=1692208210;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8ruCO9g4FxvWKS5aunRaaaf+G4BXGwigkv65s5BXgQ4=;
 b=Rg/DZA4mVQoJFeKsZ3+Ss9fh2orzrC1/kXVKSPgDplEos+gXYJ/Rm4WBYqcnITWGdp
 AN0sLx3knu6OtpwWx251K25Iz1uuEJuNKaP3KdPGzR0W6MFZ09aG4xhsqtRe2O5JU5S1
 sN+GbNMvnOHAXpzLiS+csXWDaOYXpBHKmD0q5N5y9N5UhEynKuUSdLJX69ZXXdGj63GH
 nm6pcoUKLcZDLRi169GcEZjPWKzA/wWD3nxIKNvS+F4YOmOuGIRVTOe/ipdHwH9egAni
 FBc8ebaV8P0DcHPOZ91b+Twd8l8hICtKUWbrevvI4YM90J71gSouBt37FxtqqGxXX5dR
 CKTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691603410; x=1692208210;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=8ruCO9g4FxvWKS5aunRaaaf+G4BXGwigkv65s5BXgQ4=;
 b=KubjUPaGVyFHydnMy/43HQAihiCPVtlnI+Fk6h7MqRfe8x3iSd/mP6UBoHufqPk4ng
 d2FxS94CNJAo6pIJdCkrAyHgSI9pjGQBvxo6WrJnk4GGzWutqx/tzB7/blt7iJrWFN0T
 K+evZ29afBLMHdtJMhFAKmNg2Y1PxMEWaiLSeV166gNmah8//cLHdpv43ln7ZDU76SXZ
 6ISZRun1JPw9d6sAslwIEBYMPT3buLXFxkrMXkgkxI9++aaqv8jvKZ8B/4JmL5epgYQx
 b+A+yiw4VdH1qqQLsjWQvH/WQDkmoFqvZh2JUs59GVtn93gbBGqYChjv9Wqw45m2qC6O
 norQ==
X-Gm-Message-State: AOJu0YxPjhMUIDYUkj7iu3+CqaD+1OJxvVDEaeMBUOgYzg5CrTJuGXlv
 DPYxw1WcTqzwTfN8B43vrTYXBpC78FKms8kj3Hg=
X-Google-Smtp-Source: AGHT+IHeFcraRmk93TPeB08hC+CwQI3DG6vf040qhLQpjv3JeApiq6nb4h6Iwn1ZblEZ+qf7Fp2ayw==
X-Received: by 2002:a17:90a:7e87:b0:263:72fe:3ef7 with SMTP id
 j7-20020a17090a7e8700b0026372fe3ef7mr2686808pjl.42.1691603410422; 
 Wed, 09 Aug 2023 10:50:10 -0700 (PDT)
Received: from stoup.. ([2602:47:d483:7301:6bf0:9674:6ac4:f74c])
 by smtp.gmail.com with ESMTPSA id
 y7-20020a17090a2b4700b0025dc5749b4csm1753710pjc.21.2023.08.09.10.50.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 09 Aug 2023 10:50:10 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PULL 3/6] linux-user: Use ARRAY_SIZE with bitmask_transtbl
Date: Wed,  9 Aug 2023 10:50:03 -0700
Message-Id: <20230809175006.242479-4-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230809175006.242479-1-richard.henderson@linaro.org>
References: <20230809175006.242479-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::533;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x533.google.com
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

Rather than using a zero tuple to end the table, use a macro
to apply ARRAY_SIZE and pass that on to the convert functions.

This fixes two bugs in which the conversion functions required
that both the target and host masks be non-zero in order to
continue, rather than require both target and host masks be
zero in order to terminate.

This affected mmap_flags_tbl when the host does not support
all of the flags we wish to convert (e.g. MAP_UNINITIALIZED).
Mapping these flags to zero is good enough, and matches how
the kernel ignores bits that are unknown.

Fixes: 4b840f96 ("linux-user: Populate more bits in mmap_flags_tbl")
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 bsd-user/syscall_defs.h   |  2 ++
 include/exec/user/thunk.h | 15 +++++++++++----
 linux-user/syscall.c      |  6 ------
 linux-user/thunk.c        | 24 ++++++++++++------------
 4 files changed, 25 insertions(+), 22 deletions(-)

diff --git a/bsd-user/syscall_defs.h b/bsd-user/syscall_defs.h
index b6d113d24a..aedfbf2d7d 100644
--- a/bsd-user/syscall_defs.h
+++ b/bsd-user/syscall_defs.h
@@ -227,7 +227,9 @@ type safe_##name(type1 arg1, type2 arg2, type3 arg3, type4 arg4, \
 }
 
 /* So far all target and host bitmasks are the same */
+#undef  target_to_host_bitmask
 #define target_to_host_bitmask(x, tbl) (x)
+#undef  host_to_target_bitmask
 #define host_to_target_bitmask(x, tbl) (x)
 
 #endif /* SYSCALL_DEFS_H */
diff --git a/include/exec/user/thunk.h b/include/exec/user/thunk.h
index 300a840d58..6eedef48d8 100644
--- a/include/exec/user/thunk.h
+++ b/include/exec/user/thunk.h
@@ -193,10 +193,17 @@ static inline int thunk_type_align(const argtype *type_ptr, int is_host)
     }
 }
 
-unsigned int target_to_host_bitmask(unsigned int target_mask,
-                                    const bitmask_transtbl * trans_tbl);
-unsigned int host_to_target_bitmask(unsigned int host_mask,
-                                    const bitmask_transtbl * trans_tbl);
+unsigned int target_to_host_bitmask_len(unsigned int target_mask,
+                                        const bitmask_transtbl *trans_tbl,
+                                        size_t trans_len);
+unsigned int host_to_target_bitmask_len(unsigned int host_mask,
+                                        const bitmask_transtbl * trans_tbl,
+                                        size_t trans_len);
+
+#define target_to_host_bitmask(M, T) \
+    target_to_host_bitmask_len(M, T, ARRAY_SIZE(T))
+#define host_to_target_bitmask(M, T) \
+    host_to_target_bitmask_len(M, T, ARRAY_SIZE(T))
 
 void thunk_init(unsigned int max_structs);
 
diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index 34deff0723..12ebc70df5 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -455,7 +455,6 @@ static const bitmask_transtbl fcntl_flags_tbl[] = {
 #if TARGET_O_LARGEFILE != 0 || O_LARGEFILE != 0
   { TARGET_O_LARGEFILE, TARGET_O_LARGEFILE, O_LARGEFILE, O_LARGEFILE, },
 #endif
-  { 0, 0, 0, 0 }
 };
 
 _syscall2(int, sys_getcwd1, char *, buf, size_t, size)
@@ -5813,7 +5812,6 @@ static const bitmask_transtbl iflag_tbl[] = {
         { TARGET_IXOFF, TARGET_IXOFF, IXOFF, IXOFF },
         { TARGET_IMAXBEL, TARGET_IMAXBEL, IMAXBEL, IMAXBEL },
         { TARGET_IUTF8, TARGET_IUTF8, IUTF8, IUTF8},
-        { 0, 0, 0, 0 }
 };
 
 static const bitmask_transtbl oflag_tbl[] = {
@@ -5841,7 +5839,6 @@ static const bitmask_transtbl oflag_tbl[] = {
 	{ TARGET_VTDLY, TARGET_VT1, VTDLY, VT1 },
 	{ TARGET_FFDLY, TARGET_FF0, FFDLY, FF0 },
 	{ TARGET_FFDLY, TARGET_FF1, FFDLY, FF1 },
-	{ 0, 0, 0, 0 }
 };
 
 static const bitmask_transtbl cflag_tbl[] = {
@@ -5876,7 +5873,6 @@ static const bitmask_transtbl cflag_tbl[] = {
 	{ TARGET_HUPCL, TARGET_HUPCL, HUPCL, HUPCL },
 	{ TARGET_CLOCAL, TARGET_CLOCAL, CLOCAL, CLOCAL },
 	{ TARGET_CRTSCTS, TARGET_CRTSCTS, CRTSCTS, CRTSCTS },
-	{ 0, 0, 0, 0 }
 };
 
 static const bitmask_transtbl lflag_tbl[] = {
@@ -5896,7 +5892,6 @@ static const bitmask_transtbl lflag_tbl[] = {
   { TARGET_PENDIN, TARGET_PENDIN, PENDIN, PENDIN },
   { TARGET_IEXTEN, TARGET_IEXTEN, IEXTEN, IEXTEN },
   { TARGET_EXTPROC, TARGET_EXTPROC, EXTPROC, EXTPROC},
-  { 0, 0, 0, 0 }
 };
 
 static void target_to_host_termios (void *dst, const void *src)
@@ -6008,7 +6003,6 @@ static const bitmask_transtbl mmap_flags_tbl[] = {
       MAP_FIXED_NOREPLACE, MAP_FIXED_NOREPLACE },
     { TARGET_MAP_UNINITIALIZED, TARGET_MAP_UNINITIALIZED,
       MAP_UNINITIALIZED, MAP_UNINITIALIZED },
-    { 0, 0, 0, 0 }
 };
 
 /*
diff --git a/linux-user/thunk.c b/linux-user/thunk.c
index dac4bf11c6..071aad4b5f 100644
--- a/linux-user/thunk.c
+++ b/linux-user/thunk.c
@@ -436,29 +436,29 @@ const argtype *thunk_print(void *arg, const argtype *type_ptr)
 /* Utility function: Table-driven functions to translate bitmasks
  * between host and target formats
  */
-unsigned int target_to_host_bitmask(unsigned int target_mask,
-                                    const bitmask_transtbl * trans_tbl)
+unsigned int target_to_host_bitmask_len(unsigned int target_mask,
+                                        const bitmask_transtbl *tbl,
+                                        size_t len)
 {
-    const bitmask_transtbl *btp;
     unsigned int host_mask = 0;
 
-    for (btp = trans_tbl; btp->target_mask && btp->host_mask; btp++) {
-        if ((target_mask & btp->target_mask) == btp->target_bits) {
-            host_mask |= btp->host_bits;
+    for (size_t i = 0; i < len; ++i) {
+        if ((target_mask & tbl[i].target_mask) == tbl[i].target_bits) {
+            host_mask |= tbl[i].host_bits;
         }
     }
     return host_mask;
 }
 
-unsigned int host_to_target_bitmask(unsigned int host_mask,
-                                    const bitmask_transtbl * trans_tbl)
+unsigned int host_to_target_bitmask_len(unsigned int host_mask,
+                                        const bitmask_transtbl *tbl,
+                                        size_t len)
 {
-    const bitmask_transtbl *btp;
     unsigned int target_mask = 0;
 
-    for (btp = trans_tbl; btp->target_mask && btp->host_mask; btp++) {
-        if ((host_mask & btp->host_mask) == btp->host_bits) {
-            target_mask |= btp->target_bits;
+    for (size_t i = 0; i < len; ++i) {
+        if ((host_mask & tbl[i].host_mask) == tbl[i].host_bits) {
+            target_mask |= tbl[i].target_bits;
         }
     }
     return target_mask;
-- 
2.34.1



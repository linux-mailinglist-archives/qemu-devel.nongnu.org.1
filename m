Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 172A077372B
	for <lists+qemu-devel@lfdr.de>; Tue,  8 Aug 2023 04:56:57 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qTCt1-000701-At; Mon, 07 Aug 2023 22:55:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qTCsz-0006zs-VV
 for qemu-devel@nongnu.org; Mon, 07 Aug 2023 22:55:53 -0400
Received: from mail-oi1-x22d.google.com ([2607:f8b0:4864:20::22d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qTCsx-0003Q4-PD
 for qemu-devel@nongnu.org; Mon, 07 Aug 2023 22:55:53 -0400
Received: by mail-oi1-x22d.google.com with SMTP id
 5614622812f47-3a5ad44dc5aso4173073b6e.3
 for <qemu-devel@nongnu.org>; Mon, 07 Aug 2023 19:55:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1691463345; x=1692068145;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+1DJOAxPds7+yY6YsheI/Fxfq8y5L8VMrlgusnx0OpQ=;
 b=KLo07AzsEr/62BbJmvIB1S9B4ChxQnmA8iJGQBO+u10O9JU8+etYoH0B+1pVIOADef
 qFxcVMFoRq0Yt9bJhzbo/Y4AnxELNCYqC2vRPGKKlWLo6f+8924REEX1ioJ0C4fkLzQY
 0pf14qStriIQpPDeNYYIqRFpysfDO4FIUc9tR/52r4g135GYsoi2qlprFcOPhcF0tjBP
 tVf6IHZfRqDCNrK8LJ0YAeazQNe5sHCGRhx9tKeNkUas+40tbnt0G40pMAyOcMQG3D4F
 EukUAK1c7H5ZeBS84xdOOA6KoJ+ka7FfaTHNqrh1aMXm40g0tKQ3fF7LGpICXiFiFJO8
 Ia2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691463345; x=1692068145;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+1DJOAxPds7+yY6YsheI/Fxfq8y5L8VMrlgusnx0OpQ=;
 b=FY5RL02YiESt0L1TPSR/RQODUcJYBbUWmGJ95CJVIC8DH5Kf+km67TfsUR0H/DcVUI
 pdBXDSagUxVtbyu9rvfeE9cZVF7ZvhNexSthlElmNM/4+zd5MK76+yl9he/WUxiAWB5F
 QnB6iBND+1b2DJxgchjanpEZUbhYcS7aVa5ptFJXnRW2F/GttboP1mWb/p1ViKO5uuu1
 WxeHEedmbRkNJUHupFqmySCSy+IWC49GgJakQ9SvZVXJJBAHE5MvXd+zVvxZWdLqpoAR
 f1xiDorDoaFXFPsZzV4dey75JUoZXOBsOyliJ8vgSp3Z+HEt7BMlrd/i9snfF21Ab1K4
 Nicw==
X-Gm-Message-State: AOJu0Yw0u5hdmpaDs/3e3ZJ4eAF1vH//SNWKsGrW5PItGo4fA1C13wcB
 zRYZXo4oChA2CfoGzms1icliE7fBilhHeL1wbJY=
X-Google-Smtp-Source: AGHT+IF+cy8mV0NKVsjOjldq2j3ay5xM60JnBR4q5ctLFnPwMyeiv4MwjCHBdKcq/0U5At2N4szkWg==
X-Received: by 2002:a05:6358:278c:b0:12f:158e:ed88 with SMTP id
 l12-20020a056358278c00b0012f158eed88mr9118053rwb.22.1691463345223; 
 Mon, 07 Aug 2023 19:55:45 -0700 (PDT)
Received: from stoup.. ([2602:47:d490:6901:e306:567a:e0a1:341])
 by smtp.gmail.com with ESMTPSA id
 t2-20020a656082000000b0056353c0a03esm4900037pgu.37.2023.08.07.19.55.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 07 Aug 2023 19:55:44 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: mjt@tls.msk.ru,
	laurent@vivier.eu
Subject: [PATCH 2/2] linux-user: Use ARRAY_SIZE with bitmask_transtbl
Date: Mon,  7 Aug 2023 19:55:42 -0700
Message-Id: <20230808025542.50392-3-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230808025542.50392-1-richard.henderson@linaro.org>
References: <20230808025542.50392-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::22d;
 envelope-from=richard.henderson@linaro.org; helo=mail-oi1-x22d.google.com
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



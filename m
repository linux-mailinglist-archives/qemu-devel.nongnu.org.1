Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DEFD77A6CF
	for <lists+qemu-devel@lfdr.de>; Sun, 13 Aug 2023 16:18:01 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qVBpK-00081s-1g; Sun, 13 Aug 2023 10:12:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kariem.taha2.7@gmail.com>)
 id 1qVBpH-00080v-Ue
 for qemu-devel@nongnu.org; Sun, 13 Aug 2023 10:12:15 -0400
Received: from mail-wr1-x42d.google.com ([2a00:1450:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <kariem.taha2.7@gmail.com>)
 id 1qVBpG-0000n6-7u
 for qemu-devel@nongnu.org; Sun, 13 Aug 2023 10:12:15 -0400
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-31768ce2e81so3219596f8f.1
 for <qemu-devel@nongnu.org>; Sun, 13 Aug 2023 07:12:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1691935932; x=1692540732;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DXpa9kEhKhFw0qGM/7h10TnGQSqD2YJSfz1ZM17XIl0=;
 b=JGldMO7OeovqvjN698hk25sq+SFEfXCVteVGtvO1THlZBxD4dUWMcNRwkKg5Q3esgB
 VuR2+eiy8bfIxNUBLumx2TWJf4Ih+jBT+fBwzJH0sajMwe3PGp+0xjWs69rvDxCcYwt2
 j4miOoU48u3jOmXbWzs+vUP2WfFBBTSSEL4uqYp5tYJ2NJjvp+rRY6eUKpzYqzt+/2hp
 /AVsKvaIQgL3LrdsA+fjlNOKEErxEOmkToOKvIa6630zISEa6JCFRdWHo4BFjehSSXzI
 zwSMI4bcV+nKwwnFa8gv86WXR5UOiRGso3tm2GGGNXVZKIRA8pTYSLZLE2UZ7oikVHNR
 H1cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691935932; x=1692540732;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=DXpa9kEhKhFw0qGM/7h10TnGQSqD2YJSfz1ZM17XIl0=;
 b=FDFIj3wLEmtDmFy1p7uLmqB7t3tDEOBckn2ymn9K9u1Gfx13q4g9gL+soWf3fJs7OA
 CvjLiQidf+auMVZKrBudjy5GURKIauHW64N0qVu8P70B7Hzil140erUIdneBPxDWAGK6
 Q2s+eODwMJWvZ02bY5SWs0atYNg6nhpCz4bK7x0P8M6IdagskpcKTZqEY45PWyn3EW4M
 wzrb/SfnatSusgobXNAiNTWNLbV3q4ET/7WDp9nFCXastX6nLp7ExTEk0jSMxLD3i0XV
 M2H6vl418pub5+HWcTbZbPtgi0DlklNrqmNFB7PFNlCxOHeCNfkO4fyxQbP7kAGze0x7
 ZClg==
X-Gm-Message-State: AOJu0YyaNE79SWy218Sd66c/l1Sjwk/DKhu4c22/05Me4sA34nOHJZjQ
 CJBrTYYpWeJEAqvepcZVt6aiZOcLrUQ=
X-Google-Smtp-Source: AGHT+IE+HRvG9AEj4Bhf0rPgfAgT9umkAP364R2C/++Yg+9ERmQTjLSTKGKyKoMPiH9xmFUBkMmLlg==
X-Received: by 2002:a5d:4e91:0:b0:317:6ea5:ab71 with SMTP id
 e17-20020a5d4e91000000b003176ea5ab71mr5733743wru.30.1691935932485; 
 Sun, 13 Aug 2023 07:12:12 -0700 (PDT)
Received: from karim.my.domain ([197.39.204.50])
 by smtp.gmail.com with ESMTPSA id
 l18-20020a5d4112000000b003144b95e1ecsm11409101wrp.93.2023.08.13.07.12.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 13 Aug 2023 07:12:12 -0700 (PDT)
From: Karim Taha <kariem.taha2.7@gmail.com>
To: qemu-devel@nongnu.org
Cc: imp@bsdimp.com, Karim Taha <kariem.taha2.7@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH v2 03/32] Update the definitions of __put_user and __get_user
 macros
Date: Sun, 13 Aug 2023 05:09:44 +0200
Message-Id: <20230813031013.1743-4-kariem.taha2.7@gmail.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230813031013.1743-1-kariem.taha2.7@gmail.com>
References: <20230813031013.1743-1-kariem.taha2.7@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42d;
 envelope-from=kariem.taha2.7@gmail.com; helo=mail-wr1-x42d.google.com
X-Spam_score_int: -2
X-Spam_score: -0.3
X-Spam_bar: /
X-Spam_report: (-0.3 / 5.0 requ) BAYES_00=-1.9, DATE_IN_PAST_06_12=1.543,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

From: Warner Losh <imp@bsdimp.com>

Use __builtin_choose_expr to avoid type promotion from ?:
in __put_user_e and __get_user_e macros.
Copied from linux-user/qemu.h, originally by Blue Swirl.

Signed-off-by: Warner Losh <imp@bsdimp.com>
Signed-off-by: Karim Taha <kariem.taha2.7@gmail.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 bsd-user/qemu.h   | 81 ++++++++++++++++++++---------------------------
 bsd-user/signal.c |  5 +--
 2 files changed, 35 insertions(+), 51 deletions(-)

diff --git a/bsd-user/qemu.h b/bsd-user/qemu.h
index edf9602f9b..656f38db56 100644
--- a/bsd-user/qemu.h
+++ b/bsd-user/qemu.h
@@ -276,50 +276,37 @@ static inline bool access_ok(int type, abi_ulong addr, abi_ulong size)
  * These are usually used to access struct data members once the struct has been
  * locked - usually with lock_user_struct().
  */
-#define __put_user(x, hptr)\
-({\
-    int size = sizeof(*hptr);\
-    switch (size) {\
-    case 1:\
-        *(uint8_t *)(hptr) = (uint8_t)(typeof(*hptr))(x);\
-        break;\
-    case 2:\
-        *(uint16_t *)(hptr) = tswap16((typeof(*hptr))(x));\
-        break;\
-    case 4:\
-        *(uint32_t *)(hptr) = tswap32((typeof(*hptr))(x));\
-        break;\
-    case 8:\
-        *(uint64_t *)(hptr) = tswap64((typeof(*hptr))(x));\
-        break;\
-    default:\
-        abort();\
-    } \
-    0;\
-})
+#define __put_user_e(x, hptr, e)                                            \
+    do {                                                                    \
+        PRAGMA_DISABLE_PACKED_WARNING;                                      \
+        (__builtin_choose_expr(sizeof(*(hptr)) == 1, stb_p,                 \
+        __builtin_choose_expr(sizeof(*(hptr)) == 2, stw_##e##_p,            \
+        __builtin_choose_expr(sizeof(*(hptr)) == 4, stl_##e##_p,            \
+        __builtin_choose_expr(sizeof(*(hptr)) == 8, stq_##e##_p, abort))))  \
+            ((hptr), (x)), (void)0);                                        \
+        PRAGMA_REENABLE_PACKED_WARNING;                                     \
+    } while (0)
+
+#define __get_user_e(x, hptr, e)                                            \
+    do {                                                                    \
+        PRAGMA_DISABLE_PACKED_WARNING;                                      \
+        ((x) = (typeof(*hptr))(                                             \
+        __builtin_choose_expr(sizeof(*(hptr)) == 1, ldub_p,                 \
+        __builtin_choose_expr(sizeof(*(hptr)) == 2, lduw_##e##_p,           \
+        __builtin_choose_expr(sizeof(*(hptr)) == 4, ldl_##e##_p,            \
+        __builtin_choose_expr(sizeof(*(hptr)) == 8, ldq_##e##_p, abort))))  \
+            (hptr)), (void)0);                                              \
+        PRAGMA_REENABLE_PACKED_WARNING;                                     \
+    } while (0)
 
-#define __get_user(x, hptr) \
-({\
-    int size = sizeof(*hptr);\
-    switch (size) {\
-    case 1:\
-        x = (typeof(*hptr))*(uint8_t *)(hptr);\
-        break;\
-    case 2:\
-        x = (typeof(*hptr))tswap16(*(uint16_t *)(hptr));\
-        break;\
-    case 4:\
-        x = (typeof(*hptr))tswap32(*(uint32_t *)(hptr));\
-        break;\
-    case 8:\
-        x = (typeof(*hptr))tswap64(*(uint64_t *)(hptr));\
-        break;\
-    default:\
-        x = 0;\
-        abort();\
-    } \
-    0;\
-})
+
+#if TARGET_BIG_ENDIAN
+# define __put_user(x, hptr)  __put_user_e(x, hptr, be)
+# define __get_user(x, hptr)  __get_user_e(x, hptr, be)
+#else
+# define __put_user(x, hptr)  __put_user_e(x, hptr, le)
+# define __get_user(x, hptr)  __get_user_e(x, hptr, le)
+#endif
 
 /*
  * put_user()/get_user() take a guest address and check access
@@ -332,10 +319,10 @@ static inline bool access_ok(int type, abi_ulong addr, abi_ulong size)
 ({                                                                      \
     abi_ulong __gaddr = (gaddr);                                        \
     target_type *__hptr;                                                \
-    abi_long __ret;                                                     \
+    abi_long __ret = 0;                                                 \
     __hptr = lock_user(VERIFY_WRITE, __gaddr, sizeof(target_type), 0);  \
     if (__hptr) {                                                       \
-        __ret = __put_user((x), __hptr);                                \
+        __put_user((x), __hptr);                                        \
         unlock_user(__hptr, __gaddr, sizeof(target_type));              \
     } else                                                              \
         __ret = -TARGET_EFAULT;                                         \
@@ -346,10 +333,10 @@ static inline bool access_ok(int type, abi_ulong addr, abi_ulong size)
 ({                                                                      \
     abi_ulong __gaddr = (gaddr);                                        \
     target_type *__hptr;                                                \
-    abi_long __ret;                                                     \
+    abi_long __ret = 0;                                                 \
     __hptr = lock_user(VERIFY_READ, __gaddr, sizeof(target_type), 1);   \
     if (__hptr) {                                                       \
-        __ret = __get_user((x), __hptr);                                \
+        __get_user((x), __hptr);                                        \
         unlock_user(__hptr, __gaddr, 0);                                \
     } else {                                                            \
         (x) = 0;                                                        \
diff --git a/bsd-user/signal.c b/bsd-user/signal.c
index f4e078ee1d..4db85a3485 100644
--- a/bsd-user/signal.c
+++ b/bsd-user/signal.c
@@ -787,10 +787,7 @@ static int reset_signal_mask(target_ucontext_t *ucontext)
     TaskState *ts = (TaskState *)thread_cpu->opaque;
 
     for (i = 0; i < TARGET_NSIG_WORDS; i++) {
-        if (__get_user(target_set.__bits[i],
-                    &ucontext->uc_sigmask.__bits[i])) {
-            return -TARGET_EFAULT;
-        }
+        __get_user(target_set.__bits[i], &ucontext->uc_sigmask.__bits[i]);
     }
     target_to_host_sigset_internal(&blocked, &target_set);
     ts->signal_mask = blocked;
-- 
2.40.0



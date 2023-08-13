Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C323777AAE6
	for <lists+qemu-devel@lfdr.de>; Sun, 13 Aug 2023 21:44:18 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qVGzU-0007kB-K2; Sun, 13 Aug 2023 15:43:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kariem.taha2.7@gmail.com>)
 id 1qVGzT-0007jm-Iq
 for qemu-devel@nongnu.org; Sun, 13 Aug 2023 15:43:07 -0400
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <kariem.taha2.7@gmail.com>)
 id 1qVGzR-0002MH-P7
 for qemu-devel@nongnu.org; Sun, 13 Aug 2023 15:43:07 -0400
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-3fe4a89e7efso32819335e9.3
 for <qemu-devel@nongnu.org>; Sun, 13 Aug 2023 12:43:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1691955784; x=1692560584;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DXpa9kEhKhFw0qGM/7h10TnGQSqD2YJSfz1ZM17XIl0=;
 b=P6bDIRf0TRRlpYX5vnV5BWGnKBKc44WNww2eRQXaRSgGQBKOobg6YHNum11c7Sv0A7
 Cm4brdWLYfANERvPd89xnngj5lbSF+9b2Wb6O7JTiiOF4BbFxDwy2lfkQoDXkCUQTjW4
 YmK4sUkBWyOU+O9A0lfuwVaVx8t3mxajn0z2MbTMeI40zQwTGxrmpNw48Rt0MEIBXMOG
 +rBiCBr/3bBSDNROhZmzFhicoS4gbE4MetxlrQsZD1VbysXwpHriPU9gooyOwskFAFJP
 kc4rJCsfywNh9aAEo+JaAv/G4zBQhHEr+MbQDgTFm7qr3ZfvJT+hYfuVukXbkHTJ9nfD
 PhGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691955784; x=1692560584;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=DXpa9kEhKhFw0qGM/7h10TnGQSqD2YJSfz1ZM17XIl0=;
 b=dlLpQno52TApb9nuOcL1c8+rkF9IZG3Kbl3+z1TzVkUJDCq3aS6XDFQxc0sXtxZJL3
 jLJdJur1thfdfy1TLORJc7sJP2J9W+l2mRtUoUOzJ6t6jopiFucCxfY/FhyBPtRgAX6R
 PfN4V9Nc/dPaDCtoc0q/6jdc2yr9TqIJj0NyYhD6TXS973ASGiI2hc9v3+lvwDw+9jla
 i4n0RGRhALga9y0Pwz2PmWOXimFcPwAMR+UaI/2GLebAt8ni1sDcu5Th7USIDTXuOrr5
 +n6zSaxUCXwT2L6DefXSjajvYFc+4+D5C+Ti/7LXXClYvvS8EGnz/leJ1+rTOELblkuE
 6uhQ==
X-Gm-Message-State: AOJu0YybjKJe3zoI95Q0gqLmOAFpg222QrICOW7ACIKcG8JbgejEmuxz
 4EjW/wsFlSBLRx3AoDtBplBHvBqNiDk=
X-Google-Smtp-Source: AGHT+IEwotdSrecsDYTf5c08bL4PXId3YALrC2Xvg3twxTfEcQsLD9/GV4Oxr7ndUnDwRdQSFGv6Jg==
X-Received: by 2002:a05:600c:22da:b0:3f7:e3dd:8a47 with SMTP id
 26-20020a05600c22da00b003f7e3dd8a47mr6098617wmg.11.1691955783901; 
 Sun, 13 Aug 2023 12:43:03 -0700 (PDT)
Received: from karim.my.domain ([197.39.204.50])
 by smtp.gmail.com with ESMTPSA id
 t20-20020a7bc3d4000000b003fe263dab33sm12234536wmj.9.2023.08.13.12.43.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 13 Aug 2023 12:43:03 -0700 (PDT)
From: Karim Taha <kariem.taha2.7@gmail.com>
To: qemu-devel@nongnu.org
Cc: imp@bsdimp.com, Karim Taha <kariem.taha2.7@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH v3 03/32] Update the definitions of __put_user and __get_user
 macros
Date: Sun, 13 Aug 2023 10:41:24 +0200
Message-Id: <20230813084153.6510-4-kariem.taha2.7@gmail.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230813084153.6510-1-kariem.taha2.7@gmail.com>
References: <20230813084153.6510-1-kariem.taha2.7@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=kariem.taha2.7@gmail.com; helo=mail-wm1-x32f.google.com
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



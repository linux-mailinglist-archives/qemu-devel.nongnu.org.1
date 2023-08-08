Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B8707740EA
	for <lists+qemu-devel@lfdr.de>; Tue,  8 Aug 2023 19:12:40 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qTQDU-0001pQ-Ct; Tue, 08 Aug 2023 13:09:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kariem.taha2.7@gmail.com>)
 id 1qTQDK-0001Ip-Cz
 for qemu-devel@nongnu.org; Tue, 08 Aug 2023 13:09:50 -0400
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <kariem.taha2.7@gmail.com>)
 id 1qTQDI-0003DK-8v
 for qemu-devel@nongnu.org; Tue, 08 Aug 2023 13:09:46 -0400
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-317c1845a07so4438533f8f.2
 for <qemu-devel@nongnu.org>; Tue, 08 Aug 2023 10:09:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1691514582; x=1692119382;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bOxU30OQoR5gvyMpClWPWHQIY25jis+H9qFBw5VwbPg=;
 b=OtSBoKL2dtPmLP5aei3/hLL9PflnHRdFxpG04rm1v8162CLheaEyN44zh9pe25iMKr
 WWhuh2mTLmdux92ilZ0sXsDgs0Z2daJnO5Fru4JGQlUImB8nDj/N85ElIxgvxfZ6tpz1
 bJVpsqIaowyxMd8tfLbJgZ9hshESZ/WVj7s3EVBKhEdVCqa9+5K/qvfnVfjq5NF/N2n7
 yaFSvhfJpk4IlR+4cGfzBa1Srpy5sYz8iSbLhD9wZNr3PXRIBU139ONO/caZLUfFWDz0
 r42tELxQxcHH7Pve2fpjIEpmZ8FZoghBiEuDaXEDw2s5QAXD+O+oy6OXQR0ZEbOOO5SQ
 6s6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691514582; x=1692119382;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=bOxU30OQoR5gvyMpClWPWHQIY25jis+H9qFBw5VwbPg=;
 b=KSuROwEs4hfopAieL5TtxeVx+38QRr1ad6yGuvOXiGD0o9h97Figox3wo2MFVJHdiM
 t80E6/OSrbFpO4YmazzY+XAo9Ui1JRszEdaMcFc6e0+tpzDnGBSJQPNwZUeIQYVuQxq1
 Scid4oH1wKrdWNibTBq0ReZOCTSRd/5VKSnXYJz2FomChdgxp6ZJ49/jgoL0GOe/btq+
 DE4AXefOgVp3AzZ6ykCWV+tPeSeyDqD1NSwIOjIZH3tiJN32iPf3enz4ILuHKzt5+ox3
 tyLzY+yAiljlO8S2n+BswjwCUeccE9KNSfLKHURYuPIPJq9Tckuk3jf2f5lNFomZvuVq
 pi4A==
X-Gm-Message-State: AOJu0YxcU0+Gb/Qp6Fh5w9s/qSPr4TSwqLWTIJGLo/gIDDRtDPp+A4zC
 G5UiYnwY8tsF0jvGIBtj1hT3I4Dc3CTs5g==
X-Google-Smtp-Source: AGHT+IFyEtlnenLyPVQbPZjtEdHyXJOgflI2kXSj4LAp+h+gglAaQ4gXk60idnF9j2xQqgb2jvRntQ==
X-Received: by 2002:a5d:4ec4:0:b0:316:f24b:597a with SMTP id
 s4-20020a5d4ec4000000b00316f24b597amr40942wrv.46.1691514581908; 
 Tue, 08 Aug 2023 10:09:41 -0700 (PDT)
Received: from karim.my.domain ([197.39.230.212])
 by smtp.gmail.com with ESMTPSA id
 j6-20020a5d6186000000b0031455482d1fsm14191663wru.47.2023.08.08.10.09.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 08 Aug 2023 10:09:41 -0700 (PDT)
From: Karim Taha <kariem.taha2.7@gmail.com>
To: qemu-devel@nongnu.org
Cc: imp@bsdimp.com,
	Karim Taha <kariem.taha2.7@gmail.com>
Subject: [PATCH 03/33] Update the definitions of __put_user and __get_user
 macros
Date: Tue,  8 Aug 2023 08:07:45 +0200
Message-Id: <20230808060815.9001-4-kariem.taha2.7@gmail.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230808060815.9001-1-kariem.taha2.7@gmail.com>
References: <20230808060815.9001-1-kariem.taha2.7@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::433;
 envelope-from=kariem.taha2.7@gmail.com; helo=mail-wr1-x433.google.com
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
---
 bsd-user/qemu.h   | 81 ++++++++++++++++++++---------------------------
 bsd-user/signal.c |  5 +--
 2 files changed, 35 insertions(+), 51 deletions(-)

diff --git a/bsd-user/qemu.h b/bsd-user/qemu.h
index dfdfa8dd67..c41ebfe937 100644
--- a/bsd-user/qemu.h
+++ b/bsd-user/qemu.h
@@ -307,50 +307,37 @@ static inline bool access_ok(int type, abi_ulong addr, abi_ulong size)
 #define PRAGMA_REENABLE_PACKED_WARNING
 #endif
 
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
@@ -363,10 +350,10 @@ static inline bool access_ok(int type, abi_ulong addr, abi_ulong size)
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
@@ -377,10 +364,10 @@ static inline bool access_ok(int type, abi_ulong addr, abi_ulong size)
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



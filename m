Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C7F878BBAD
	for <lists+qemu-devel@lfdr.de>; Tue, 29 Aug 2023 01:44:42 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qalrs-0003jc-DV; Mon, 28 Aug 2023 19:42:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1qalrh-0003fH-1O
 for qemu-devel@nongnu.org; Mon, 28 Aug 2023 19:41:50 -0400
Received: from mail-il1-x130.google.com ([2607:f8b0:4864:20::130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1qalrd-0006gW-OZ
 for qemu-devel@nongnu.org; Mon, 28 Aug 2023 19:41:47 -0400
Received: by mail-il1-x130.google.com with SMTP id
 e9e14a558f8ab-34dec9c77d4so41965ab.0
 for <qemu-devel@nongnu.org>; Mon, 28 Aug 2023 16:41:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20221208.gappssmtp.com; s=20221208; t=1693266104; x=1693870904;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/MXe0Iyo//h1yjS09UWr+6Zwt8J7dJYarzHsGGngDTo=;
 b=sUP81DMKiBJr/NgfNFdOrWyGlTi020p4kZgMx0GarefLBPt3/NXqUloJz8W3CpzyGz
 0ZvJwBLib9gNdcTaXwzYb2klfvzu/LoKFkhB1t9qc/BlynLL/CwxJChRLUmfANaBKkEM
 KfKv0PQzVQgPihzx3v/dDFnBVTsIMYZUXneTpZrAKfIN3th8r6493JHrGkaolkH8td82
 T0Svi8kCFxmq5AqS+8MGjnBh7kI/uifcAiIywV3Usf0HtiBV/wZwntmphPslOpvVl+QJ
 NEK5Fci9oanQJOs60aEDOq4NfEpDCJywqnASfUBEm6TL5A/UlBNSU1cBEA9AlTZy4K7G
 YD2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693266104; x=1693870904;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/MXe0Iyo//h1yjS09UWr+6Zwt8J7dJYarzHsGGngDTo=;
 b=WdxTN2eF0RC5tXRnUClnDPp380FjSL1/hRpuDiMBqDKdNJR9oFB+st8b2S6GAhmLkU
 +BGUnMPk7yYsHwQIxcv9M3DpGvQca8oTH8uS1/c7cB1acBl7J0cg9t4xeDE9UaW8S9gD
 1mKzXRajq9xUyQ6bfPtPfagnVrNLPP4TLws4fE4mOIDkJPajfGDwgsx6HaHDsYZGXG7s
 zz8ZdbCAZrk2UP4olDxcOCh+HqSjDOeaK6FwxIWaGPv9EGzeYCwSFWFxzU/OLqOhtHSG
 9cw2IbvMXLpaUA80wK+EVxcHLOkW1+KwAMaSPy8O/iMGf8KVts47yDmAn7jOVihshlDy
 9vHw==
X-Gm-Message-State: AOJu0YyPuatYKbbgtbBONgY0p+kUKoIKTgIC4GTgjsPx0x86dXxkau5J
 2sAjZD5TBJFfeSMAupdPXQDmU701QSknHT9Fx3M=
X-Google-Smtp-Source: AGHT+IHvhalmgzGkeG3gFagQY1T/HNYtX1OPOHUBE6BkxkYHsRKkxNWDFrPIZifk5Hr2+o/yNCIFdg==
X-Received: by 2002:a92:cda6:0:b0:34c:dbeb:a2a7 with SMTP id
 g6-20020a92cda6000000b0034cdbeba2a7mr14444986ild.23.1693266104411; 
 Mon, 28 Aug 2023 16:41:44 -0700 (PDT)
Received: from dune.bsdimp.com (50-253-99-174-static.hfc.comcastbusiness.net.
 [50.253.99.174]) by smtp.gmail.com with ESMTPSA id
 t9-20020a056e02060900b0034b58dd5694sm2805491ils.15.2023.08.28.16.41.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 28 Aug 2023 16:41:44 -0700 (PDT)
From: Warner Losh <imp@bsdimp.com>
To: qemu-devel@nongnu.org
Cc: Reinoud Zandijk <reinoud@netbsd.org>, Warner Losh <imp@bsdimp.com>,
 Ryo ONODERA <ryoon@netbsd.org>, Kyle Evans <kevans@freebsd.org>,
 Karim Taha <kariem.taha2.7@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 06/36] bsd-user;
 Update the definitions of __put_user and __get_user macros
Date: Mon, 28 Aug 2023 17:37:51 -0600
Message-ID: <20230828233821.43074-7-imp@bsdimp.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230828233821.43074-1-imp@bsdimp.com>
References: <20230828233821.43074-1-imp@bsdimp.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::130;
 envelope-from=imp@bsdimp.com; helo=mail-il1-x130.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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
index 61501c321b0..ca791e18b22 100644
--- a/bsd-user/qemu.h
+++ b/bsd-user/qemu.h
@@ -272,50 +272,37 @@ static inline bool access_ok(int type, abi_ulong addr, abi_ulong size)
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
@@ -328,10 +315,10 @@ static inline bool access_ok(int type, abi_ulong addr, abi_ulong size)
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
@@ -342,10 +329,10 @@ static inline bool access_ok(int type, abi_ulong addr, abi_ulong size)
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
index f4e078ee1da..4db85a3485e 100644
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
2.41.0



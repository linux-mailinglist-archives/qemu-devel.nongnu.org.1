Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B064372668B
	for <lists+qemu-devel@lfdr.de>; Wed,  7 Jun 2023 18:56:19 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q6wR4-0006w4-UY; Wed, 07 Jun 2023 12:55:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <fufuyqqqqqq@gmail.com>)
 id 1q6wR3-0006vr-0q
 for qemu-devel@nongnu.org; Wed, 07 Jun 2023 12:55:01 -0400
Received: from mail-ot1-x331.google.com ([2607:f8b0:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <fufuyqqqqqq@gmail.com>)
 id 1q6wR1-0001OC-4j
 for qemu-devel@nongnu.org; Wed, 07 Jun 2023 12:55:00 -0400
Received: by mail-ot1-x331.google.com with SMTP id
 46e09a7af769-6af8b25fc72so5647852a34.3
 for <qemu-devel@nongnu.org>; Wed, 07 Jun 2023 09:54:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1686156897; x=1688748897;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xE+1wkxPO08MY6y0xennEQUWQ0JmYys5Y9jfkJj6VU8=;
 b=FaNWxJrO7iiN6V49wyWo6nK7O0LNNDSCYQ6jPs9z6MGp1sHBIWwMyX0q3GggyDi3As
 hZ16bOrp5YL3iNj/YQ3etBiJGoiYdehbnod659twlVBJjnOmXitjnyjwbim691M2DzVe
 i0dVnCey2xitfuvO2o2shli+JbacEEFnNBwovpYlxYMGp5imuPzOCYtocTZDlrhrkx4J
 2nRtAhi5QupWQMimZkPU+SyMlX34gXZx2UZ//HfM/2G7kFBL5n0oaxKbdaw+No2CPnxc
 w0YQ3kfuiA5Z1OYYDIcGI8Z8ZWZPL4RN/exRnwtKKgYoUtLHwY3X99D9ksn1U28zrOzv
 vRBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686156897; x=1688748897;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=xE+1wkxPO08MY6y0xennEQUWQ0JmYys5Y9jfkJj6VU8=;
 b=HTuxFkmM0WMDlqx9/RvebSsuh4Ajy/FwT63vjj3lJaREI9eJ+3eI5AhOZsqTD182y6
 JEPRePP1bOOVJecU1BYehHG7cb91Vaoqxoyh8Cx+2dlElgumTYVi2q9T2LXmtn3WHr5h
 ALq8XWW7Suw5Xnb763ydTs2eYzKaXGv+V/F6ucGWdW1wkSsmi7LfjAjr+0kijYPCkWmQ
 acSTIbD9/iWEUu9pfDHdjxGJuuyzWqTPZigW4fmndYFkWJdNCAPBxA9tcTqlQnaY3usL
 YQtWL/asNQJlrsFSUvnn85WD6wXJHEsWqkq3sl95ujujLmxDESzY9dh4fMKYe5mFg1MZ
 +A7g==
X-Gm-Message-State: AC+VfDzfhPbyv7WVWqzr4wvKQHkYeQxUaBpOP1/ki4F4OZUsKvzWFwjI
 5VlANfhN2SFeeSOp7uwgofa/N1XS7kii0M5L/GM=
X-Google-Smtp-Source: ACHHUZ4W9OGYH729372BZmTgVN5gV/GKXoqeqJwJzA22NFViqYV2VzybDmyX6hu6Bm53Wo02an34Fg==
X-Received: by 2002:a92:cf4e:0:b0:331:105c:81f9 with SMTP id
 c14-20020a92cf4e000000b00331105c81f9mr9586543ilr.29.1686156559850; 
 Wed, 07 Jun 2023 09:49:19 -0700 (PDT)
Received: from localhost.localdomain ([223.104.40.226])
 by smtp.gmail.com with ESMTPSA id
 30-20020a17090a001e00b00250bf8495b3sm1671808pja.39.2023.06.07.09.49.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 07 Jun 2023 09:49:19 -0700 (PDT)
From: Yeqi Fu <fufuyqqqqqq@gmail.com>
To: alex.bennee@linaro.org
Cc: richard.henderson@linaro.org, qemu-devel@nongnu.org,
 Yeqi Fu <fufuyqqqqqq@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>
Subject: [RFC v2 3/6] target/i386: Add native library calls
Date: Thu,  8 Jun 2023 00:47:47 +0800
Message-Id: <20230607164750.829586-4-fufuyqqqqqq@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230607164750.829586-1-fufuyqqqqqq@gmail.com>
References: <20230607164750.829586-1-fufuyqqqqqq@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::331;
 envelope-from=fufuyqqqqqq@gmail.com; helo=mail-ot1-x331.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 HK_RANDOM_ENVFROM=0.001, HK_RANDOM_FROM=0.001, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

Signed-off-by: Yeqi Fu <fufuyqqqqqq@gmail.com>
---
 target/i386/helper.h                 |  6 +++
 target/i386/tcg/translate.c          | 20 +++++++++
 target/i386/tcg/user/meson.build     |  1 +
 target/i386/tcg/user/native_helper.c | 65 ++++++++++++++++++++++++++++
 4 files changed, 92 insertions(+)
 create mode 100644 target/i386/tcg/user/native_helper.c

diff --git a/target/i386/helper.h b/target/i386/helper.h
index e627a93107..6c91655887 100644
--- a/target/i386/helper.h
+++ b/target/i386/helper.h
@@ -221,3 +221,9 @@ DEF_HELPER_3(rcrq, tl, env, tl, tl)
 #endif
 
 DEF_HELPER_1(rdrand, tl, env)
+
+#if defined(CONFIG_USER_ONLY)  && defined(CONFIG_USER_NATIVE_CALL)
+DEF_HELPER_1(native_memcpy, void, env)
+DEF_HELPER_1(native_memcmp, void, env)
+DEF_HELPER_1(native_memset, void, env)
+#endif
diff --git a/target/i386/tcg/translate.c b/target/i386/tcg/translate.c
index 91c9c0c478..eb0c1e9566 100644
--- a/target/i386/tcg/translate.c
+++ b/target/i386/tcg/translate.c
@@ -33,6 +33,7 @@
 #include "helper-tcg.h"
 
 #include "exec/log.h"
+#include "native/native-func.h"
 
 #define PREFIX_REPZ   0x01
 #define PREFIX_REPNZ  0x02
@@ -6806,6 +6807,25 @@ static bool disas_insn(DisasContext *s, CPUState *cpu)
     case 0x1d0 ... 0x1fe:
         disas_insn_new(s, cpu, b);
         break;
+    /* One unknown opcode for native call */
+#if defined(CONFIG_USER_ONLY)  && defined(CONFIG_USER_NATIVE_CALL)
+    case 0x1ff:
+        uint16_t sig = x86_lduw_code(env, s);
+        switch (sig) {
+        case NATIVE_MEMCPY:
+            gen_helper_native_memcpy(cpu_env);
+            break;
+        case NATIVE_MEMSET:
+            gen_helper_native_memset(cpu_env);
+            break;
+        case NATIVE_MEMCMP:
+            gen_helper_native_memcmp(cpu_env);
+            break;
+        default:
+            goto unknown_op;
+        }
+        break;
+#endif
     default:
         goto unknown_op;
     }
diff --git a/target/i386/tcg/user/meson.build b/target/i386/tcg/user/meson.build
index 1df6bc4343..490808bd65 100644
--- a/target/i386/tcg/user/meson.build
+++ b/target/i386/tcg/user/meson.build
@@ -1,4 +1,5 @@
 i386_user_ss.add(when: ['CONFIG_TCG', 'CONFIG_USER_ONLY'], if_true: files(
   'excp_helper.c',
   'seg_helper.c',
+  'native_helper.c',
 ))
diff --git a/target/i386/tcg/user/native_helper.c b/target/i386/tcg/user/native_helper.c
new file mode 100644
index 0000000000..4a9b98eee2
--- /dev/null
+++ b/target/i386/tcg/user/native_helper.c
@@ -0,0 +1,65 @@
+/*
+ *  native function call helpers
+ */
+
+#include "qemu/osdep.h"
+#include "cpu.h"
+#include "exec/helper-proto.h"
+#include "exec/exec-all.h"
+#include "exec/cpu_ldst.h"
+#include "tcg/helper-tcg.h"
+#include "tcg/seg_helper.h"
+
+#ifdef TARGET_X86_64
+#define NATIVE_FN_W_3W()           \
+    target_ulong arg0, arg1, arg2; \
+    arg0 = env->regs[R_EDI];       \
+    arg1 = env->regs[R_ESI];       \
+    arg2 = env->regs[R_EDX];
+#else
+/*
+ *  linux x86 has several calling conventions. The following implementation
+ *  is for the most commonly used cdecl calling convention.
+ */
+#define NATIVE_FN_W_3W()                                   \
+    target_ulong arg0, arg1, arg2;                         \
+    arg0 = *(target_ulong *)g2h(cs, env->regs[R_ESP] + 4); \
+    arg1 = *(target_ulong *)g2h(cs, env->regs[R_ESP] + 8); \
+    arg2 = *(target_ulong *)g2h(cs, env->regs[R_ESP] + 12);
+#endif
+
+void helper_native_memcpy(CPUX86State *env)
+{
+    CPUState *cs = env_cpu(env);
+    NATIVE_FN_W_3W();
+    void *ret;
+    void *dest = g2h(cs, arg0);
+    void *src = g2h(cs, arg1);
+    size_t n = (size_t)arg2;
+    ret = memcpy(dest, src, n);
+    env->regs[R_EAX] = (target_ulong)h2g(ret);
+}
+
+void helper_native_memcmp(CPUX86State *env)
+{
+    CPUState *cs = env_cpu(env);
+    NATIVE_FN_W_3W();
+    int ret;
+    void *s1 = g2h(cs, arg0);
+    void *s2 = g2h(cs, arg1);
+    size_t n = (size_t)arg2;
+    ret = memcmp(s1, s2, n);
+    env->regs[R_EAX] = ret;
+}
+
+void helper_native_memset(CPUX86State *env)
+{
+    CPUState *cs = env_cpu(env);
+    NATIVE_FN_W_3W();
+    void *ret;
+    void *s = g2h(cs, arg0);
+    int c = (int)arg1;
+    size_t n = (size_t)arg2;
+    ret = memset(s, c, n);
+    env->regs[R_EAX] = (target_ulong)h2g(ret);
+}
-- 
2.34.1



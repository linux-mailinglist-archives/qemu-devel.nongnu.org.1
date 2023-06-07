Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A5A3572669E
	for <lists+qemu-devel@lfdr.de>; Wed,  7 Jun 2023 18:58:19 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q6wU0-0002Rt-Ur; Wed, 07 Jun 2023 12:58:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <fufuyqqqqqq@gmail.com>)
 id 1q6wTy-0002M4-R9
 for qemu-devel@nongnu.org; Wed, 07 Jun 2023 12:58:02 -0400
Received: from mail-pf1-x432.google.com ([2607:f8b0:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <fufuyqqqqqq@gmail.com>)
 id 1q6wTw-0001rl-Tf
 for qemu-devel@nongnu.org; Wed, 07 Jun 2023 12:58:02 -0400
Received: by mail-pf1-x432.google.com with SMTP id
 d2e1a72fcca58-6513e7e5d44so4459764b3a.0
 for <qemu-devel@nongnu.org>; Wed, 07 Jun 2023 09:58:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1686157079; x=1688749079;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fxJOHiP5GDTktQXf+aPVbhfyHKIATMyFdqs477VmHcY=;
 b=INcgMRvOHhwdyTC03bJcs7+wKs+WgKPCuwxd1JJyl4S4MhUc2v5J8wz1kOM7XwVQ/G
 gUmz0wjWm3fFBRahXJGCB0BUVcwUVoLAD+nAWazESwKUd6g8NsMVuuLdLtjvRbs9cvZT
 y1GJFwMcJkOArKcr8lLoJKCKB/oRQ78zBVyeERl141NpkVhDGqVcId14pBkWROO/QU5v
 q7sL/09zOTjqvg8ai8E7IXKV+u4Ic5V3Kb52asATCtiCHq6T3cMpU0dwGIZLKdWBm+q3
 t8VdnSWCYxtmNaR50Vh++FCr1U6U9HE8vTktHRPrTl9yOWuukMGOwt6lOE/Yla2modMu
 1vvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686157079; x=1688749079;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=fxJOHiP5GDTktQXf+aPVbhfyHKIATMyFdqs477VmHcY=;
 b=MgKoGDv9vSqiwh/M/1PQu5UF+79oX4LTG4/PDFfPMOpv889xzSi6XFpExCx/8Sz6Qt
 O0liPFV0haHRrlJhCAxbfIMG8YT1j3t4C0MQoIrEGXh0owUzVvR3w3/olHGMzbh+8tN1
 wtTRg5qCWB6bhGXRwWEzutivYQkzX1T4uoEalQJ4iwIZUl0W23r3AkQ/0yzWj8P4E0PM
 tGdf5WFzJKj8bxfOY4irI+VNdyZzMzr9ITladFhS+HCgt/3Ouw744aPl2qk/dczIDfkb
 I6gbQuWbp1RuCM2EHrObYBW3kBBLBMtFXuL5/L1hoRcVNba2uyRx98xjJwNgZzXvMd4F
 sgPA==
X-Gm-Message-State: AC+VfDxqesC01ripjJpBQKh0VcfCnag3MS+IfKhJN5nzh8ELn93S7GdH
 HK2zsbaA7x7de8KWbGjw98i5iDClwC8kTXhzmuY=
X-Google-Smtp-Source: ACHHUZ69ZuXes8fpHBsUFzWQz7XXTns2ApHVqrHlgpuYeeIe/ifr+Dkrqwi8MHUYsmH+SP4YePbRkg==
X-Received: by 2002:a17:90b:185:b0:259:9667:722d with SMTP id
 t5-20020a17090b018500b002599667722dmr2511306pjs.31.1686156564938; 
 Wed, 07 Jun 2023 09:49:24 -0700 (PDT)
Received: from localhost.localdomain ([223.104.40.226])
 by smtp.gmail.com with ESMTPSA id
 30-20020a17090a001e00b00250bf8495b3sm1671808pja.39.2023.06.07.09.49.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 07 Jun 2023 09:49:24 -0700 (PDT)
From: Yeqi Fu <fufuyqqqqqq@gmail.com>
To: alex.bennee@linaro.org
Cc: richard.henderson@linaro.org, qemu-devel@nongnu.org,
 Yeqi Fu <fufuyqqqqqq@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Aurelien Jarno <aurelien@aurel32.net>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>
Subject: [RFC v2 4/6] target/mips: Add native library calls
Date: Thu,  8 Jun 2023 00:47:48 +0800
Message-Id: <20230607164750.829586-5-fufuyqqqqqq@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230607164750.829586-1-fufuyqqqqqq@gmail.com>
References: <20230607164750.829586-1-fufuyqqqqqq@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::432;
 envelope-from=fufuyqqqqqq@gmail.com; helo=mail-pf1-x432.google.com
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
 target/mips/helper.h            |  6 ++++
 target/mips/tcg/meson.build     |  1 +
 target/mips/tcg/native_helper.c | 55 +++++++++++++++++++++++++++++++++
 target/mips/tcg/translate.c     | 20 +++++++++++-
 target/mips/tcg/translate.h     | 12 +++++++
 5 files changed, 93 insertions(+), 1 deletion(-)
 create mode 100644 target/mips/tcg/native_helper.c

diff --git a/target/mips/helper.h b/target/mips/helper.h
index de32d82e98..9fa949d78c 100644
--- a/target/mips/helper.h
+++ b/target/mips/helper.h
@@ -589,6 +589,12 @@ DEF_HELPER_FLAGS_3(dmthlip, 0, void, tl, tl, env)
 DEF_HELPER_FLAGS_3(wrdsp, 0, void, tl, tl, env)
 DEF_HELPER_FLAGS_2(rddsp, 0, tl, tl, env)
 
+#if defined(CONFIG_USER_ONLY)  && defined(CONFIG_USER_NATIVE_CALL)
+DEF_HELPER_1(native_memcpy, void, env)
+DEF_HELPER_1(native_memcmp, void, env)
+DEF_HELPER_1(native_memset, void, env)
+#endif
+
 #ifndef CONFIG_USER_ONLY
 #include "tcg/sysemu_helper.h.inc"
 #endif /* !CONFIG_USER_ONLY */
diff --git a/target/mips/tcg/meson.build b/target/mips/tcg/meson.build
index 7ee969ec8f..fb1ea64047 100644
--- a/target/mips/tcg/meson.build
+++ b/target/mips/tcg/meson.build
@@ -22,6 +22,7 @@ mips_ss.add(files(
   'txx9_translate.c',
   'vr54xx_helper.c',
   'vr54xx_translate.c',
+  'native_helper.c',
 ))
 mips_ss.add(when: 'TARGET_MIPS64', if_true: files(
   'tx79_translate.c',
diff --git a/target/mips/tcg/native_helper.c b/target/mips/tcg/native_helper.c
new file mode 100644
index 0000000000..bfd9c92e17
--- /dev/null
+++ b/target/mips/tcg/native_helper.c
@@ -0,0 +1,55 @@
+/*
+ *  native function call helpers
+ */
+
+#include "qemu/osdep.h"
+#include "cpu.h"
+#include "exec/helper-proto.h"
+#include "exec/exec-all.h"
+#include "exec/cpu_ldst.h"
+
+#if defined(CONFIG_USER_ONLY)  && defined(CONFIG_USER_NATIVE_CALL)
+
+#define NATIVE_FN_W_3W()                   \
+    target_ulong arg0, arg1, arg2;         \
+    arg0 = env->active_tc.gpr[4]; /*"a0"*/ \
+    arg1 = env->active_tc.gpr[5]; /*"a1"*/ \
+    arg2 = env->active_tc.gpr[6]; /*"a2"*/
+
+void helper_native_memcpy(CPUMIPSState *env)
+{
+    CPUState *cs = env_cpu(env);
+    NATIVE_FN_W_3W();
+    void *ret;
+    void *dest = g2h(cs, arg0);
+    void *src = g2h(cs, arg1);
+    size_t n = (size_t)arg2;
+    ret = memcpy(dest, src, n);
+    env->active_tc.gpr[2] = (target_ulong)h2g(ret);
+}
+
+void helper_native_memcmp(CPUMIPSState *env)
+{
+    CPUState *cs = env_cpu(env);
+    NATIVE_FN_W_3W();
+    int ret;
+    void *s1 = g2h(cs, arg0);
+    void *s2 = g2h(cs, arg1);
+    size_t n = (size_t)arg2;
+    ret = memcmp(s1, s2, n);
+    env->active_tc.gpr[2] = ret;
+}
+
+void helper_native_memset(CPUMIPSState *env)
+{
+    CPUState *cs = env_cpu(env);
+    NATIVE_FN_W_3W();
+    void *ret;
+    void *s = g2h(cs, arg0);
+    int c = (int)arg1;
+    size_t n = (size_t)arg2;
+    ret = memset(s, c, n);
+    env->active_tc.gpr[2] = (target_ulong)h2g(ret);
+}
+
+#endif
diff --git a/target/mips/tcg/translate.c b/target/mips/tcg/translate.c
index a6ca2e5a3b..d68ce6bc2f 100644
--- a/target/mips/tcg/translate.c
+++ b/target/mips/tcg/translate.c
@@ -36,6 +36,7 @@
 #include "qemu/qemu-print.h"
 #include "fpu_helper.h"
 #include "translate.h"
+#include "native/native-func.h"
 
 /*
  * Many sysemu-only helpers are not reachable for user-only.
@@ -13591,7 +13592,24 @@ static void decode_opc_special(CPUMIPSState *env, DisasContext *ctx)
         gen_helper_pmon(cpu_env, tcg_constant_i32(sa));
 #endif
         break;
-    case OPC_SYSCALL:
+    case OPC_SYSCALL:  /* 00 00 00 0C */
+        if (native_bypass() && ((((ctx->opcode) >> 24) & 0xff) == 0x1)) {
+            uint16_t sig =  (ctx->opcode) >> 8 & 0xffff;
+            switch (sig) {
+            case NATIVE_MEMCPY:
+                gen_helper_native_memcpy(cpu_env);
+                break;
+            case NATIVE_MEMSET:
+                gen_helper_native_memset(cpu_env);
+                break;
+            case NATIVE_MEMCMP:
+                gen_helper_native_memcmp(cpu_env);
+                break;
+            default:
+                gen_reserved_instruction(ctx);
+            }
+            break;
+        }
         generate_exception_end(ctx, EXCP_SYSCALL);
         break;
     case OPC_BREAK:
diff --git a/target/mips/tcg/translate.h b/target/mips/tcg/translate.h
index 69f85841d2..f0112d88aa 100644
--- a/target/mips/tcg/translate.h
+++ b/target/mips/tcg/translate.h
@@ -237,3 +237,15 @@ static inline bool cpu_is_bigendian(DisasContext *ctx)
 }
 
 #endif
+
+/*
+ * Check if the native bypass feature is enabled.
+ */
+static inline bool native_bypass(void)
+{
+#if defined(CONFIG_USER_ONLY) && defined(CONFIG_USER_NATIVE_CALL)
+    return true;
+#else
+    return false;
+#endif
+}
-- 
2.34.1



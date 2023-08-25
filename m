Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BB4A278853A
	for <lists+qemu-devel@lfdr.de>; Fri, 25 Aug 2023 12:49:05 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qZULs-00067h-LZ; Fri, 25 Aug 2023 06:47:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <fufuyqqqqqq@gmail.com>)
 id 1qZULc-00067H-N1
 for qemu-devel@nongnu.org; Fri, 25 Aug 2023 06:47:26 -0400
Received: from mail-pf1-x42b.google.com ([2607:f8b0:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <fufuyqqqqqq@gmail.com>)
 id 1qZULZ-0001ch-Tv
 for qemu-devel@nongnu.org; Fri, 25 Aug 2023 06:47:24 -0400
Received: by mail-pf1-x42b.google.com with SMTP id
 d2e1a72fcca58-68c0d262933so218443b3a.0
 for <qemu-devel@nongnu.org>; Fri, 25 Aug 2023 03:47:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1692960440; x=1693565240;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=yhPGnAHTEJz7+EVry2wHMw10T6Zg+wsudF7RVF3VaXk=;
 b=aVztgsOvCUsFxan/8Q3wRjT0wd33Hl3xKaNUtETisNyyW8KtTTWR/QtGiB9s9NLQqX
 uKdBbbUyiD/8MDoaxU4sUyMMgoc50KKGZPjI4EIZvoyfP8eHk1Ma4ix9B7Ku9V89wtvr
 snttphi/XjDoH2Qk8IUGJ5YtPFD+qxE+CzjxI8zpHConJYLmCz/HhT7RoQiivSBBTDu2
 FwFgu9pcYgVOXl1fLay47S7nrIYd3y/8MmGMyukw1zg/oXRL51nnpjzhhd0QLHVgaAUd
 ZD34+SLlrp8wp4t4tqZIry+tmTfz3oJi9xLvIRjfwjqXbFrJgEu3ApyTiTsTrVi9ofOR
 meag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692960440; x=1693565240;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=yhPGnAHTEJz7+EVry2wHMw10T6Zg+wsudF7RVF3VaXk=;
 b=E4dQ4pp75u5Zz7acXSPmP6Yz6h3tdNxRuGW2mwaj+S5dbvZCPSc0xRQCplemCga7vO
 +VUlEe/eQKghJbdP6Y639puT+7+RHsaONabEvdErU5lRd2NRY8+hn48M8bbztaMyh2Lf
 ROsVWzVe/gECYQ3Gw3EjoNKoVlm5eHM5m3kKiSGCltW79N0IiTaY9qq4sFDLf7QI2obU
 bLHVHtgyfp3Dib3u+SciaJx1EEC1s6RO1nq6jbjUDEWgwVZjDumbe47ZJPi3ydLWKLiH
 8Psev0E53wbRFoL5PsGU9qoTbtTT3h5k1GZry6rjXggKo7yImmwCva0H0x/qTR/9UFfX
 dN9w==
X-Gm-Message-State: AOJu0YyfgWcAzSSFVsCmd7r13J7V3V9R2ub8iXIi5lUuPRKCpINXrzdg
 4yK0aSl/CSySMKD/wMcG+pc=
X-Google-Smtp-Source: AGHT+IFe9rGaWm84H3snP2h5Ox1lnlr21jnQlg9kRxSME2T9Lw4V6U9oldhBb7DFVzn/YBpHAdzcEA==
X-Received: by 2002:a05:6a21:47c7:b0:148:48de:f6ae with SMTP id
 as7-20020a056a2147c700b0014848def6aemr14867562pzc.32.1692960440352; 
 Fri, 25 Aug 2023 03:47:20 -0700 (PDT)
Received: from localhost.localdomain ([223.104.40.15])
 by smtp.gmail.com with ESMTPSA id
 f5-20020a170902ce8500b001b89891bfc4sm1346985plg.199.2023.08.25.03.47.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 25 Aug 2023 03:47:19 -0700 (PDT)
From: Yeqi Fu <fufuyqqqqqq@gmail.com>
To: alex.bennee@linaro.org
Cc: richard.henderson@linaro.org, qemu-devel@nongnu.org,
 Yeqi Fu <fufuyqqqqqq@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>
Subject: [RFC v5 05/10] tcg: Add tcg opcodes and helpers for native library
 calls
Date: Fri, 25 Aug 2023 18:45:21 +0800
Message-Id: <20230825104526.1754950-6-fufuyqqqqqq@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42b;
 envelope-from=fufuyqqqqqq@gmail.com; helo=mail-pf1-x42b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 HK_RANDOM_ENVFROM=0.001, HK_RANDOM_FROM=0.001, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

This commit implements tcg opcodes and helpers for native library
calls. A table is used to store the parameter types and return value
types for each native library function. In terms of types, only three
types are of real concern: the two base sizes int and intptr_t, and
if the value is a pointer, tcg_gen_g2h and tcg_gen_h2g are used for
address conversion.

Signed-off-by: Yeqi Fu <fufuyqqqqqq@gmail.com>
---
 accel/tcg/tcg-runtime.h      |  22 ++++
 include/native/native-defs.h |  42 ++++++++
 include/tcg/tcg-op-common.h  |  11 ++
 include/tcg/tcg.h            |   9 ++
 tcg/tcg-op.c                 | 193 ++++++++++++++++++++++++++++++++++-
 5 files changed, 276 insertions(+), 1 deletion(-)
 create mode 100644 include/native/native-defs.h

diff --git a/accel/tcg/tcg-runtime.h b/accel/tcg/tcg-runtime.h
index 39e68007f9..bda78b4489 100644
--- a/accel/tcg/tcg-runtime.h
+++ b/accel/tcg/tcg-runtime.h
@@ -37,6 +37,28 @@ DEF_HELPER_FLAGS_1(exit_atomic, TCG_CALL_NO_WG, noreturn, env)
  */
 #define helper_memset memset
 DEF_HELPER_FLAGS_3(memset, TCG_CALL_NO_RWG, ptr, ptr, int, ptr)
+
+#define helper_memcpy memcpy
+DEF_HELPER_FLAGS_3(memcpy, TCG_CALL_NO_RWG, ptr, ptr, ptr, ptr)
+
+#define helper_strncpy strncpy
+DEF_HELPER_FLAGS_3(strncpy, TCG_CALL_NO_RWG, ptr, ptr, ptr, ptr)
+
+#define helper_memcmp memcmp
+DEF_HELPER_FLAGS_3(memcmp, TCG_CALL_NO_RWG, int, ptr, ptr, ptr)
+
+#define helper_strncmp strncmp
+DEF_HELPER_FLAGS_3(strncmp, TCG_CALL_NO_RWG, int, ptr, ptr, ptr)
+
+#define helper_strcpy strcpy
+DEF_HELPER_FLAGS_2(strcpy, TCG_CALL_NO_RWG, ptr, ptr, ptr)
+
+#define helper_strcat strcat
+DEF_HELPER_FLAGS_2(strcat, TCG_CALL_NO_RWG, ptr, ptr, ptr)
+
+#define helper_strcmp strcmp
+DEF_HELPER_FLAGS_2(strcmp, TCG_CALL_NO_RWG, int, ptr, ptr)
+
 #endif /* IN_HELPER_PROTO */
 
 DEF_HELPER_FLAGS_3(ld_i128, TCG_CALL_NO_WG, i128, env, i64, i32)
diff --git a/include/native/native-defs.h b/include/native/native-defs.h
new file mode 100644
index 0000000000..517bb86db0
--- /dev/null
+++ b/include/native/native-defs.h
@@ -0,0 +1,42 @@
+/*
+ * Argument encoding. We only really care about 3 types. The two base
+ * sizes (int and intptr_t) and if the value is a pointer (in which
+ * case we need to adjust it g2h before passing to the native
+ * function).
+ */
+#define TYPE_NO_ARG 0x0
+#define TYPE_INT_ARG 0x1
+#define TYPE_IPTR_ARG 0x2
+#define TYPE_PTR_ARG 0x3
+
+#define ENCODE_TYPE(ret_value, arg1, arg2, arg3) \
+    ((ret_value) | (arg1 << 4) | (arg2 << 8) | (arg3 << 12))
+
+#define TYPE_AAAP \
+    ENCODE_TYPE(TYPE_PTR_ARG, TYPE_PTR_ARG, TYPE_PTR_ARG, TYPE_IPTR_ARG)
+#define TYPE_IAAP \
+    ENCODE_TYPE(TYPE_INT_ARG, TYPE_PTR_ARG, TYPE_PTR_ARG, TYPE_IPTR_ARG)
+#define TYPE_AAIP \
+    ENCODE_TYPE(TYPE_PTR_ARG, TYPE_PTR_ARG, TYPE_INT_ARG, TYPE_IPTR_ARG)
+#define TYPE_AAA \
+    ENCODE_TYPE(TYPE_PTR_ARG, TYPE_PTR_ARG, TYPE_PTR_ARG, TYPE_NO_ARG)
+#define TYPE_IAA \
+    ENCODE_TYPE(TYPE_INT_ARG, TYPE_PTR_ARG, TYPE_PTR_ARG, TYPE_NO_ARG)
+
+typedef void (*helper_pppp)(struct TCGv_ptr_d *, struct TCGv_ptr_d *,
+                            struct TCGv_ptr_d *, struct TCGv_ptr_d *);
+typedef void (*helper_ippp)(struct TCGv_i32_d *, struct TCGv_ptr_d *,
+                            struct TCGv_ptr_d *, struct TCGv_ptr_d *);
+typedef void (*helper_ppip)(struct TCGv_ptr_d *, struct TCGv_ptr_d *,
+                            struct TCGv_i32_d *, struct TCGv_ptr_d *);
+typedef void (*helper_ppp)(struct TCGv_ptr_d *, struct TCGv_ptr_d *,
+                           struct TCGv_ptr_d *);
+typedef void (*helper_ipp)(struct TCGv_i32_d *, struct TCGv_ptr_d *,
+                           struct TCGv_ptr_d *);
+typedef void (*helper_func)(void *, ...);
+
+typedef struct {
+    const char *func;
+    helper_func helper;
+    uint32_t type;
+} FuncHelper;
diff --git a/include/tcg/tcg-op-common.h b/include/tcg/tcg-op-common.h
index be382bbf77..2e712f1573 100644
--- a/include/tcg/tcg-op-common.h
+++ b/include/tcg/tcg-op-common.h
@@ -903,6 +903,12 @@ void tcg_gen_ld_vec(TCGv_vec r, TCGv_ptr base, TCGArg offset);
 void tcg_gen_st_vec(TCGv_vec r, TCGv_ptr base, TCGArg offset);
 void tcg_gen_stl_vec(TCGv_vec r, TCGv_ptr base, TCGArg offset, TCGType t);
 
+/* Host <-> guest conversions */
+void tcg_gen_g2h_i32(TCGv_ptr ret, TCGv_i32 arg);
+void tcg_gen_g2h_i64(TCGv_ptr ret, TCGv_i64 arg);
+void tcg_gen_h2g_i32(TCGv_i32 ret, TCGv_ptr arg);
+void tcg_gen_h2g_i64(TCGv_i64 ret, TCGv_ptr arg);
+
 /* Host pointer ops */
 
 #if UINTPTR_MAX == UINT32_MAX
@@ -938,6 +944,11 @@ static inline void tcg_gen_addi_ptr(TCGv_ptr r, TCGv_ptr a, intptr_t b)
     glue(tcg_gen_addi_,PTR)((NAT)r, (NAT)a, b);
 }
 
+static inline void tcg_gen_subi_ptr(TCGv_ptr r, TCGv_ptr a, intptr_t b)
+{
+    glue(tcg_gen_subi_, PTR)((NAT)r, (NAT)a, b);
+}
+
 static inline void tcg_gen_mov_ptr(TCGv_ptr d, TCGv_ptr s)
 {
     glue(tcg_gen_mov_,PTR)((NAT)d, (NAT)s);
diff --git a/include/tcg/tcg.h b/include/tcg/tcg.h
index 0875971719..a4c0f26dc4 100644
--- a/include/tcg/tcg.h
+++ b/include/tcg/tcg.h
@@ -35,6 +35,9 @@
 #include "tcg-target.h"
 #include "tcg/tcg-cond.h"
 #include "tcg/debug-assert.h"
+#ifdef CONFIG_USER_ONLY
+#include "exec/user/guest-base.h"
+#endif
 
 /* XXX: make safe guess about sizes */
 #define MAX_OP_PER_INSTR 266
@@ -1148,4 +1151,10 @@ static inline const TCGOpcode *tcg_swap_vecop_list(const TCGOpcode *n)
 
 bool tcg_can_emit_vecop_list(const TCGOpcode *, TCGType, unsigned);
 
+/* native call */
+void gen_native_call_i32(const char *func_name, TCGv_i32 ret,
+                         TCGv_i32 arg1, TCGv_i32 arg2, TCGv_i32 arg3);
+void gen_native_call_i64(const char *func_name, TCGv_i64 ret,
+                         TCGv_i64 arg1, TCGv_i64 arg2, TCGv_i64 arg3);
+
 #endif /* TCG_H */
diff --git a/tcg/tcg-op.c b/tcg/tcg-op.c
index 7aadb37756..8cd39e4ab4 100644
--- a/tcg/tcg-op.c
+++ b/tcg/tcg-op.c
@@ -29,7 +29,7 @@
 #include "exec/translation-block.h"
 #include "exec/plugin-gen.h"
 #include "tcg-internal.h"
-
+#include "native/native-defs.h"
 
 void tcg_gen_op1(TCGOpcode opc, TCGArg a1)
 {
@@ -2852,3 +2852,194 @@ void tcg_gen_lookup_and_goto_ptr(void)
     tcg_gen_op1i(INDEX_op_goto_ptr, tcgv_ptr_arg(ptr));
     tcg_temp_free_ptr(ptr);
 }
+
+#ifdef CONFIG_USER_ONLY
+void tcg_gen_g2h_i32(TCGv_ptr ret, TCGv_i32 arg)
+{
+    TCGv_ptr temp = tcg_temp_new_ptr();
+    tcg_gen_ext_i32_ptr(temp, arg);
+    tcg_gen_addi_ptr(ret, temp, guest_base);
+    tcg_temp_free_ptr(temp);
+}
+
+void tcg_gen_g2h_i64(TCGv_ptr ret, TCGv_i64 arg)
+{
+    TCGv_ptr temp = tcg_temp_new_ptr();
+    tcg_gen_trunc_i64_ptr(temp, arg); /* Not sure */
+    tcg_gen_addi_ptr(ret, temp, guest_base);
+    tcg_temp_free_ptr(temp);
+}
+
+void tcg_gen_h2g_i32(TCGv_i32 ret, TCGv_ptr arg)
+{
+    TCGv_ptr temp = tcg_temp_new_ptr();
+    tcg_gen_subi_ptr(temp, arg, guest_base);
+    tcg_gen_trunc_ptr_i32(ret, temp);
+    tcg_temp_free_ptr(temp);
+}
+
+void tcg_gen_h2g_i64(TCGv_i64 ret, TCGv_ptr arg)
+{
+    TCGv_ptr temp = tcg_temp_new_ptr();
+    tcg_gen_subi_ptr(temp, arg, guest_base);
+    tcg_gen_extu_ptr_i64(ret, temp);
+    tcg_temp_free_ptr(temp);
+}
+
+#else
+void tcg_gen_g2h_i32(TCGv_ptr ret, TCGv_i32 arg)
+{
+}
+void tcg_gen_g2h_i64(TCGv_ptr ret, TCGv_i64 arg)
+{
+}
+void tcg_gen_h2g_i32(TCGv_i32 ret, TCGv_ptr arg)
+{
+}
+void tcg_gen_h2g_i64(TCGv_i64 ret, TCGv_ptr arg)
+{
+}
+#endif
+
+static const FuncHelper func_helper_table[] = {
+    { .func = "memset",
+      .helper = (helper_func)gen_helper_memset,
+      .type = TYPE_AAIP },
+    { .func = "memcpy",
+      .helper = (helper_func)gen_helper_memcpy,
+      .type = TYPE_AAAP },
+    { .func = "strncpy",
+      .helper = (helper_func)gen_helper_strncpy,
+      .type = TYPE_AAAP },
+    { .func = "memcmp",
+      .helper = (helper_func)gen_helper_memcmp,
+      .type = TYPE_IAAP },
+    { .func = "strncmp",
+      .helper = (helper_func)gen_helper_strncmp,
+      .type = TYPE_IAAP },
+    { .func = "strcpy",
+      .helper = (helper_func)gen_helper_strcpy,
+      .type = TYPE_AAA },
+    { .func = "strcat",
+      .helper = (helper_func)gen_helper_strcat,
+      .type = TYPE_AAA },
+    { .func = "strcmp",
+      .helper = (helper_func)gen_helper_strcmp,
+      .type = TYPE_IAA },
+};
+/* p: iptr ; i: i32 ; a: ptr(address) */
+void gen_native_call_i32(const char *func_name, TCGv_i32 ret, TCGv_i32 arg1,
+                         TCGv_i32 arg2, TCGv_i32 arg3)
+{
+    TCGv_ptr arg1_ptr = tcg_temp_new_ptr();
+    TCGv_ptr arg2_ptr = tcg_temp_new_ptr();
+    TCGv_ptr arg3_ptr = tcg_temp_new_ptr();
+    TCGv_ptr ret_ptr = tcg_temp_new_ptr();
+    unsigned int i;
+    for (i = 0; i < sizeof(func_helper_table) / sizeof(FuncHelper); i++) {
+        if (strcmp(func_name, func_helper_table[i].func) == 0) {
+            break;
+        }
+    }
+    g_assert(i < sizeof(func_helper_table) / sizeof(FuncHelper));
+    switch (func_helper_table[i].type) {
+    case TYPE_AAIP:
+        tcg_gen_g2h_i32(arg1_ptr, arg1);
+        tcg_gen_ext_i32_ptr(arg3_ptr, arg3);
+        ((helper_ppip)(func_helper_table[i].helper))(ret_ptr, arg1_ptr, arg2,
+                                                     arg3_ptr);
+        goto ret_ptr;
+    case TYPE_AAAP:
+        tcg_gen_g2h_i32(arg1_ptr, arg1);
+        tcg_gen_g2h_i32(arg2_ptr, arg2);
+        tcg_gen_ext_i32_ptr(arg3_ptr, arg3);
+        ((helper_pppp)(func_helper_table[i].helper))(ret_ptr, arg1_ptr,
+                                                     arg2_ptr, arg3_ptr);
+        goto ret_ptr;
+    case TYPE_IAAP:
+        tcg_gen_g2h_i32(arg1_ptr, arg1);
+        tcg_gen_g2h_i32(arg2_ptr, arg2);
+        tcg_gen_ext_i32_ptr(arg3_ptr, arg3);
+        ((helper_ippp)(func_helper_table[i].helper))(ret, arg1_ptr, arg2_ptr,
+                                                     arg3_ptr);
+        return;
+    case TYPE_AAA:
+        tcg_gen_g2h_i32(arg1_ptr, arg1);
+        tcg_gen_g2h_i32(arg2_ptr, arg2);
+        ((helper_ppp)(func_helper_table[i].helper))(ret_ptr, arg1_ptr,
+                                                    arg2_ptr);
+        goto ret_ptr;
+    case TYPE_IAA:
+        tcg_gen_g2h_i32(arg1_ptr, arg1);
+        tcg_gen_g2h_i32(arg2_ptr, arg2);
+        ((helper_ipp)(func_helper_table[i].helper))(ret, arg1_ptr, arg2_ptr);
+        return;
+    default:
+        g_assert_not_reached();
+    }
+ret_ptr:
+    tcg_gen_h2g_i32(ret, ret_ptr);
+    return;
+}
+
+void gen_native_call_i64(const char *func_name, TCGv_i64 ret, TCGv_i64 arg1,
+                         TCGv_i64 arg2, TCGv_i64 arg3)
+{
+    TCGv_ptr arg1_ptr = tcg_temp_new_ptr();
+    TCGv_ptr arg2_ptr = tcg_temp_new_ptr();
+    TCGv_ptr arg3_ptr = tcg_temp_new_ptr();
+    TCGv_ptr ret_ptr = tcg_temp_new_ptr();
+    TCGv_i32 arg2_i32, ret_i32 = tcg_temp_new_i32();
+    unsigned int i;
+    for (i = 0; i < sizeof(func_helper_table) / sizeof(FuncHelper); i++) {
+        if (strcmp(func_name, func_helper_table[i].func) == 0) {
+            break;
+        }
+    }
+    g_assert(i < sizeof(func_helper_table) / sizeof(FuncHelper));
+
+    switch (func_helper_table[i].type) {
+    case TYPE_AAIP:
+        tcg_gen_g2h_i64(arg1_ptr, arg1);
+        arg2_i32 = tcg_temp_new_i32();
+        tcg_gen_extrl_i64_i32(arg2_i32, arg2);
+        tcg_gen_trunc_i64_ptr(arg3_ptr, arg3);
+        ((helper_ppip)(func_helper_table[i].helper))(ret_ptr, arg1_ptr,
+                                                     arg2_i32, arg3_ptr);
+        goto ret_ptr;
+    case TYPE_AAAP:
+        tcg_gen_g2h_i64(arg1_ptr, arg1);
+        tcg_gen_g2h_i64(arg2_ptr, arg2);
+        tcg_gen_trunc_i64_ptr(arg3_ptr, arg3);
+        ((helper_pppp)(func_helper_table[i].helper))(ret_ptr, arg1_ptr,
+                                                     arg2_ptr, arg3_ptr);
+        goto ret_ptr;
+    case TYPE_IAAP:
+        tcg_gen_g2h_i64(arg1_ptr, arg1);
+        tcg_gen_g2h_i64(arg2_ptr, arg2);
+        tcg_gen_trunc_i64_ptr(arg3_ptr, arg3);
+        ((helper_ippp)(func_helper_table[i].helper))(ret_i32, arg1_ptr,
+                                                     arg2_ptr, arg3_ptr);
+        goto ret_i32;
+    case TYPE_AAA:
+        tcg_gen_g2h_i64(arg1_ptr, arg1);
+        tcg_gen_g2h_i64(arg2_ptr, arg2);
+        ((helper_ppp)(func_helper_table[i].helper))(ret_ptr, arg1_ptr,
+                                                    arg2_ptr);
+        goto ret_ptr;
+    case TYPE_IAA:
+        tcg_gen_g2h_i64(arg1_ptr, arg1);
+        tcg_gen_g2h_i64(arg2_ptr, arg2);
+        ((helper_ipp)(func_helper_table[i].helper))(ret_i32, arg1_ptr,
+                                                    arg2_ptr);
+        goto ret_i32;
+    default:
+        g_assert_not_reached();
+    }
+ret_ptr:
+    tcg_gen_h2g_i64(ret, ret_ptr);
+    return;
+ret_i32:
+    tcg_gen_extu_i32_i64(ret, ret_i32);
+    return;
+}
-- 
2.34.1



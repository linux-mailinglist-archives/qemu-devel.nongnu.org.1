Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6389A79DADF
	for <lists+qemu-devel@lfdr.de>; Tue, 12 Sep 2023 23:30:09 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qgAwp-0000Nv-7Y; Tue, 12 Sep 2023 17:29:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <fufuyqqqqqq@gmail.com>)
 id 1qgAwg-0000Kw-7G
 for qemu-devel@nongnu.org; Tue, 12 Sep 2023 17:29:18 -0400
Received: from mail-pf1-x431.google.com ([2607:f8b0:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <fufuyqqqqqq@gmail.com>)
 id 1qgAwd-0007W3-1J
 for qemu-devel@nongnu.org; Tue, 12 Sep 2023 17:29:17 -0400
Received: by mail-pf1-x431.google.com with SMTP id
 d2e1a72fcca58-68fb98745c1so2159539b3a.1
 for <qemu-devel@nongnu.org>; Tue, 12 Sep 2023 14:29:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1694554153; x=1695158953; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=S8/CaILzDlpI4gnj9PPg8ya6AqadQ5DfpDBACZN2fw4=;
 b=cPp5rMG/JI73c7tNDQClNv4buqhkxtnXvP6t548TFoDoDTJJThduQcFwHxIKq1UEbg
 I7hUaFH4GKDXby6ETyQ0c32uh4kQmH4ci1n/2PbDaI7CNTt3+wNGTasP6e+aC4KFTJq+
 rwah4GuJY63W+lOkY280iHymbwoOD8BXDhC/B1ngy3VOJtzs4k4CXEJS8taU576j3Bbh
 evQ9k4WvnF5yiRGFIl17WFlWmyhe8AaS6yfMzvxCRiAIOuFco5DcoCY+abHwUDGJcWat
 +54tWyJDtbCPz70bPN3P4TQHkzdQ2jiFFPvYROp30SM5QshiujCSKNuWlIVBpI03Ap7+
 lwVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694554153; x=1695158953;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=S8/CaILzDlpI4gnj9PPg8ya6AqadQ5DfpDBACZN2fw4=;
 b=kwhuJRP1rlFNKDq3vZ9QVxQKvYfTTD27D1qOJCF4qs/wxRJZ2HuhmGFD5z59yhGZen
 iwv7sv3mfjSQVIgv4B7LlqMBDkopyKV5GFX505MSRHty6jRSgiAAmWlVTJKBvGdLUs7m
 mWdKMGK+RKm0zHqqRejm1qucum6c/5espiddhkS3vM31SGc293BOlYqUAOMJlNc2SdGK
 p1fgE2k7Qj72aPN5TX4FH6rY5zBZf8EHoVdRUILJz4NPoIomgOkHqieHtLwIUOe50O2U
 ViFxTZy3LuSRsp2Kmx8FOnnG21qqvaKd1FBy1PZpkuMPJCJ3U4V5ISxHoP5F5pxICcWJ
 3CzQ==
X-Gm-Message-State: AOJu0Yw0DJxky/Qw5DDvKn+C36OU4wqxauihIGPIyJdb5dgqYnmJlD9n
 rt+K4roU//eEddHZpt+V0ssINyM4LDHHea3x
X-Google-Smtp-Source: AGHT+IHwqC3gFKAxtdYl4UgaDyD8RXzFyfBBeC05STnM1UOgaVxfKZIitUhaEDHH1l0XWnrnf8scLQ==
X-Received: by 2002:a05:6a20:841f:b0:157:dffb:fe1c with SMTP id
 c31-20020a056a20841f00b00157dffbfe1cmr808814pzd.22.1694554152774; 
 Tue, 12 Sep 2023 14:29:12 -0700 (PDT)
Received: from q1iq-virtual-machine.. ([114.249.236.97])
 by smtp.gmail.com with ESMTPSA id
 u20-20020aa78394000000b0068be4ce33easm7930436pfm.96.2023.09.12.14.29.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 12 Sep 2023 14:29:12 -0700 (PDT)
From: Yeqi Fu <fufuyqqqqqq@gmail.com>
To: alex.bennee@linaro.org
Cc: richard.henderson@linaro.org, qemu-devel@nongnu.org,
 Yeqi Fu <fufuyqqqqqq@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>
Subject: [RFC v6 4/9] tcg: Add tcg opcodes and helpers for native library calls
Date: Wed, 13 Sep 2023 05:28:37 +0800
Message-Id: <20230912212842.658374-5-fufuyqqqqqq@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230912212842.658374-1-fufuyqqqqqq@gmail.com>
References: <20230912212842.658374-1-fufuyqqqqqq@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::431;
 envelope-from=fufuyqqqqqq@gmail.com; helo=mail-pf1-x431.google.com
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
 accel/tcg/tcg-runtime.c      |  66 +++++++++++++++
 accel/tcg/tcg-runtime.h      |  12 +++
 include/exec/helper-head.h   |   1 +
 include/native/native-defs.h |  41 ++++++++++
 include/tcg/tcg-op-common.h  |  13 +++
 include/tcg/tcg-op.h         |   2 +
 include/tcg/tcg.h            |   8 ++
 tcg/tcg-op.c                 |  36 ++++++++
 tcg/tcg.c                    | 154 +++++++++++++++++++++++++++++++++++
 9 files changed, 333 insertions(+)
 create mode 100644 include/native/native-defs.h

diff --git a/accel/tcg/tcg-runtime.c b/accel/tcg/tcg-runtime.c
index 9fa539ad3d..764ca631d5 100644
--- a/accel/tcg/tcg-runtime.c
+++ b/accel/tcg/tcg-runtime.c
@@ -152,3 +152,69 @@ void HELPER(exit_atomic)(CPUArchState *env)
 {
     cpu_loop_exit_atomic(env_cpu(env), GETPC());
 }
+
+#ifdef CONFIG_USER_ONLY
+int HELPER(nc_memcmp)(void *s1, void *s2, void *len)
+{
+    set_helper_retaddr(GETPC());
+    int r = memcmp(s1, s2, (size_t)len);
+    clear_helper_retaddr();
+    return r;
+}
+
+void *HELPER(nc_memcpy)(void *dst, void *src, void *len)
+{
+    set_helper_retaddr(GETPC());
+    void *r = memcpy(dst, src, (size_t)len);
+    clear_helper_retaddr();
+    return r;
+}
+
+void *HELPER(nc_memset)(void *b, int c, void *len)
+{
+    set_helper_retaddr(GETPC());
+    void *r = memset(b, c, (size_t)len);
+    clear_helper_retaddr();
+    return r;
+}
+
+void *HELPER(nc_strcat)(void *dst, void *src)
+{
+    set_helper_retaddr(GETPC());
+    void *r = strcat(dst, src);
+    clear_helper_retaddr();
+    return r;
+}
+
+int HELPER(nc_strcmp)(void *s1, void *s2)
+{
+    set_helper_retaddr(GETPC());
+    int r = strcmp(s1, s2);
+    clear_helper_retaddr();
+    return r;
+}
+
+void *HELPER(nc_strcpy)(void *dst, void *src)
+{
+    set_helper_retaddr(GETPC());
+    void *r = strcpy(dst, src);
+    clear_helper_retaddr();
+    return r;
+}
+
+int HELPER(nc_strncmp)(void *s1, void *s2, void *len)
+{
+    set_helper_retaddr(GETPC());
+    int r = strncmp(s1, s2, (size_t)len);
+    clear_helper_retaddr();
+    return r;
+}
+
+void *HELPER(nc_strncpy)(void *dst, void *src, void *len)
+{
+    set_helper_retaddr(GETPC());
+    void *r = strncpy(dst, src, (size_t)len);
+    clear_helper_retaddr();
+    return r;
+}
+#endif
diff --git a/accel/tcg/tcg-runtime.h b/accel/tcg/tcg-runtime.h
index 39e68007f9..7330124c0b 100644
--- a/accel/tcg/tcg-runtime.h
+++ b/accel/tcg/tcg-runtime.h
@@ -298,3 +298,15 @@ DEF_HELPER_FLAGS_4(gvec_leu32, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
 DEF_HELPER_FLAGS_4(gvec_leu64, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
 
 DEF_HELPER_FLAGS_5(gvec_bitsel, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, ptr, i32)
+
+#ifdef CONFIG_USER_ONLY
+/* Helpers for native library calls */
+DEF_HELPER_FLAGS_3(nc_memcmp, TCG_CALL_NO_RWG, int, ptr, ptr, ptr)
+DEF_HELPER_FLAGS_3(nc_memcpy, TCG_CALL_NO_RWG, ptr, ptr, ptr, ptr)
+DEF_HELPER_FLAGS_3(nc_memset, TCG_CALL_NO_RWG, ptr, ptr, int, ptr)
+DEF_HELPER_FLAGS_2(nc_strcat, TCG_CALL_NO_RWG, ptr, ptr, ptr)
+DEF_HELPER_FLAGS_2(nc_strcmp, TCG_CALL_NO_RWG, int, ptr, ptr)
+DEF_HELPER_FLAGS_2(nc_strcpy, TCG_CALL_NO_RWG, ptr, ptr, ptr)
+DEF_HELPER_FLAGS_3(nc_strncmp, TCG_CALL_NO_RWG, int, ptr, ptr, ptr)
+DEF_HELPER_FLAGS_3(nc_strncpy, TCG_CALL_NO_RWG, ptr, ptr, ptr, ptr)
+#endif
diff --git a/include/exec/helper-head.h b/include/exec/helper-head.h
index 28ceab0a46..438c74e2ac 100644
--- a/include/exec/helper-head.h
+++ b/include/exec/helper-head.h
@@ -84,6 +84,7 @@
 
 #define dh_typecode_void 0
 #define dh_typecode_noreturn 0
+#define dh_typecode_iptr 1
 #define dh_typecode_i32 2
 #define dh_typecode_s32 3
 #define dh_typecode_i64 4
diff --git a/include/native/native-defs.h b/include/native/native-defs.h
new file mode 100644
index 0000000000..b193882698
--- /dev/null
+++ b/include/native/native-defs.h
@@ -0,0 +1,41 @@
+/*
+ * Argument encoding. We only really care about 3 types. The two base
+ * sizes (int and intptr_t) and if the value is a pointer (in which
+ * case we need to adjust it g2h before passing to the native
+ * function).
+ */
+#include "exec/helper-head.h"
+
+#define TYPE_AAAP                                                      \
+    (dh_typemask(ptr, 0) | dh_typemask(ptr, 1) | dh_typemask(ptr, 2) | \
+     dh_typemask(iptr, 3))
+#define TYPE_IAAP                                                      \
+    (dh_typemask(int, 0) | dh_typemask(ptr, 1) | dh_typemask(ptr, 2) | \
+     dh_typemask(iptr, 3))
+#define TYPE_AAIP                                                      \
+    (dh_typemask(ptr, 0) | dh_typemask(ptr, 1) | dh_typemask(int, 2) | \
+     dh_typemask(iptr, 3))
+#define TYPE_AAA                                                       \
+    (dh_typemask(ptr, 0) | dh_typemask(ptr, 1) | dh_typemask(ptr, 2) | \
+     dh_typemask(void, 3))
+#define TYPE_IAA                                                       \
+    (dh_typemask(int, 0) | dh_typemask(ptr, 1) | dh_typemask(ptr, 2) | \
+     dh_typemask(void, 3))
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
index be382bbf77..86e3dcaf43 100644
--- a/include/tcg/tcg-op-common.h
+++ b/include/tcg/tcg-op-common.h
@@ -903,6 +903,14 @@ void tcg_gen_ld_vec(TCGv_vec r, TCGv_ptr base, TCGArg offset);
 void tcg_gen_st_vec(TCGv_vec r, TCGv_ptr base, TCGArg offset);
 void tcg_gen_stl_vec(TCGv_vec r, TCGv_ptr base, TCGArg offset, TCGType t);
 
+#ifdef CONFIG_USER_ONLY
+/* Host <-> guest conversions */
+void tcg_gen_g2h_i32(TCGv_ptr ret, TCGv_i32 arg);
+void tcg_gen_g2h_i64(TCGv_ptr ret, TCGv_i64 arg);
+void tcg_gen_h2g_i32(TCGv_i32 ret, TCGv_ptr arg);
+void tcg_gen_h2g_i64(TCGv_i64 ret, TCGv_ptr arg);
+#endif
+
 /* Host pointer ops */
 
 #if UINTPTR_MAX == UINT32_MAX
@@ -938,6 +946,11 @@ static inline void tcg_gen_addi_ptr(TCGv_ptr r, TCGv_ptr a, intptr_t b)
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
diff --git a/include/tcg/tcg-op.h b/include/tcg/tcg-op.h
index d63683c47b..5accbbbf54 100644
--- a/include/tcg/tcg-op.h
+++ b/include/tcg/tcg-op.h
@@ -279,6 +279,7 @@ DEF_ATOMIC2(tcg_gen_atomic_umax_fetch, i64)
 #define tcg_gen_dup_tl_vec  tcg_gen_dup_i64_vec
 #define tcg_gen_dup_tl tcg_gen_dup_i64
 #define dup_const_tl dup_const
+#define gen_native_call_tl gen_native_call_i64
 #else
 #define tcg_gen_movi_tl tcg_gen_movi_i32
 #define tcg_gen_mov_tl tcg_gen_mov_i32
@@ -402,5 +403,6 @@ DEF_ATOMIC2(tcg_gen_atomic_umax_fetch, i64)
         : (qemu_build_not_reached_always(), 0))                    \
      :  (target_long)dup_const(VECE, C))
 
+#define gen_native_call_tl gen_native_call_i32
 #endif /* TARGET_LONG_BITS == 64 */
 #endif /* TCG_TCG_OP_H */
diff --git a/include/tcg/tcg.h b/include/tcg/tcg.h
index 0875971719..ff1b5e3ca3 100644
--- a/include/tcg/tcg.h
+++ b/include/tcg/tcg.h
@@ -1148,4 +1148,12 @@ static inline const TCGOpcode *tcg_swap_vecop_list(const TCGOpcode *n)
 
 bool tcg_can_emit_vecop_list(const TCGOpcode *, TCGType, unsigned);
 
+#ifdef CONFIG_USER_ONLY
+/* Native call support. */
+bool gen_native_call_i32(const char *func_name, TCGv_i32 ret,
+                         TCGv_i32 arg1, TCGv_i32 arg2, TCGv_i32 arg3);
+bool gen_native_call_i64(const char *func_name, TCGv_i64 ret,
+                         TCGv_i64 arg1, TCGv_i64 arg2, TCGv_i64 arg3);
+#endif
+
 #endif /* TCG_H */
diff --git a/tcg/tcg-op.c b/tcg/tcg-op.c
index 7aadb37756..21b4410fd0 100644
--- a/tcg/tcg-op.c
+++ b/tcg/tcg-op.c
@@ -29,6 +29,7 @@
 #include "exec/translation-block.h"
 #include "exec/plugin-gen.h"
 #include "tcg-internal.h"
+#include "exec/user/guest-base.h"
 
 
 void tcg_gen_op1(TCGOpcode opc, TCGArg a1)
@@ -2852,3 +2853,38 @@ void tcg_gen_lookup_and_goto_ptr(void)
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
+    tcg_gen_trunc_i64_ptr(temp, arg);
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
+#endif
diff --git a/tcg/tcg.c b/tcg/tcg.c
index a0628fe424..a4005ff5c2 100644
--- a/tcg/tcg.c
+++ b/tcg/tcg.c
@@ -57,6 +57,7 @@
 #include "accel/tcg/perf.h"
 #ifdef CONFIG_USER_ONLY
 #include "exec/user/guest-base.h"
+#include "native/native-defs.h"
 #endif
 
 /* Forward declarations for functions declared in tcg-target.c.inc and
@@ -6384,3 +6385,156 @@ void tcg_expand_vec_op(TCGOpcode o, TCGType t, unsigned e, TCGArg a0, ...)
     g_assert_not_reached();
 }
 #endif
+
+#ifdef CONFIG_USER_ONLY
+static const FuncHelper func_helper_table[] = {
+    { .func = "memcmp",
+      .helper = (helper_func)gen_helper_nc_memcmp,
+      .type = TYPE_IAAP },
+    { .func = "memcpy",
+      .helper = (helper_func)gen_helper_nc_memcpy,
+      .type = TYPE_AAAP },
+    { .func = "memset",
+      .helper = (helper_func)gen_helper_nc_memset,
+      .type = TYPE_AAIP },
+    { .func = "strcat",
+      .helper = (helper_func)gen_helper_nc_strcat,
+      .type = TYPE_AAA },
+    { .func = "strcmp",
+      .helper = (helper_func)gen_helper_nc_strcmp,
+      .type = TYPE_IAA },
+    { .func = "strcpy",
+      .helper = (helper_func)gen_helper_nc_strcpy,
+      .type = TYPE_AAA },
+    { .func = "strncmp",
+      .helper = (helper_func)gen_helper_nc_strncmp,
+      .type = TYPE_IAAP },
+    { .func = "strncpy",
+      .helper = (helper_func)gen_helper_nc_strncpy,
+      .type = TYPE_AAAP },
+};
+
+bool gen_native_call_i32(const char *func_name, TCGv_i32 ret, TCGv_i32 arg1,
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
+    if (i >= sizeof(func_helper_table) / sizeof(FuncHelper)) {
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "Unimplemented libnative call to \"%s\"\n", func_name);
+        return false;
+    }
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
+        return true;
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
+        return true;
+    default:
+        return false;
+    }
+ret_ptr:
+    tcg_gen_h2g_i32(ret, ret_ptr);
+    return true;
+}
+
+bool gen_native_call_i64(const char *func_name, TCGv_i64 ret, TCGv_i64 arg1,
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
+    if (i >= sizeof(func_helper_table) / sizeof(FuncHelper)) {
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "Unimplemented libnative call to \"%s\"\n", func_name);
+        return false;
+    }
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
+        return false;
+    }
+ret_ptr:
+    tcg_gen_h2g_i64(ret, ret_ptr);
+    return true;
+ret_i32:
+    tcg_gen_extu_i32_i64(ret, ret_i32);
+    return true;
+}
+#endif
-- 
2.34.1



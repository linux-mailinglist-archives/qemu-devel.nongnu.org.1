Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 79E44773AAD
	for <lists+qemu-devel@lfdr.de>; Tue,  8 Aug 2023 16:20:49 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qTNYZ-0001G5-JX; Tue, 08 Aug 2023 10:19:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <fufuyqqqqqq@gmail.com>)
 id 1qTNYX-0001FQ-5y
 for qemu-devel@nongnu.org; Tue, 08 Aug 2023 10:19:29 -0400
Received: from mail-pl1-x62d.google.com ([2607:f8b0:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <fufuyqqqqqq@gmail.com>)
 id 1qTNYV-0000Il-Ck
 for qemu-devel@nongnu.org; Tue, 08 Aug 2023 10:19:28 -0400
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-1bb9e6c2a90so49927395ad.1
 for <qemu-devel@nongnu.org>; Tue, 08 Aug 2023 07:19:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1691504366; x=1692109166;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=GrdwntijzI3EO9KK5le2/eCTA0TEbyfqQ9FwIk1g+vc=;
 b=CxYDgjC8e3Wv/ZduDoFXrFzgEk/uezmvxCjeN3SX5ym/0+T50w5q+tpdVQOG/yic9U
 2fUv1NptfF8Iii4lCLnZ7wkZ59VVuuv4VJOy36crBMgWzCeAgsI7PpQWmlVCIzg2pwN9
 l8e9YdePZ+WyUcY5GKmMTsh5WJIOF2jWQtbQCNkR0ErlBI+4s2kxOZ466HTepwuxQPw6
 0BIY2y1o8yzGNClaju7TZfRF7PFU8ey0Ok9OcTbCzJ6irDvJlMSlUaBpuyHpwbml+Min
 N5Wt5FFa189lc7g9aaZbtfBowbYgJNFBDNrQdgU0eyewAJQgncDwmGtjhNzfeevWml/7
 O7GQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691504366; x=1692109166;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=GrdwntijzI3EO9KK5le2/eCTA0TEbyfqQ9FwIk1g+vc=;
 b=QsWz121BMhZqDK9U4Fe61JccRde7OU60Dx4hDPZhT/ZnH8n6Sd5IPSy1f9IWJ91b36
 96kISGMH2OrLI6tVg++NyIp6lUi/sxMi/by9wlZMGZPGh0kH3VLYXQtbGz+NMXqmnuBP
 mcdk+2DRxz7mNe32/oLryMGyE1dRN+uhM5d+Zm1IyuzMA6hT75yWb9bsLPqMdjTL9Qoo
 6TSNw5theMOfa7TL3yhTfXGZYQAvYvqrHVXDnL/C+co3Sfev2mKMFwjpiSJARyJevRss
 IQPIT4BaMebqNxlB/CB+cS0C3dEzuLinDknb/bI8S82hozwpYApMauDk8cawHqUZARmB
 vXOg==
X-Gm-Message-State: AOJu0YxmCLjxZmjWZ7yUfsaEmaF2yfRfjIXsejhv0oF/ACFfGzLpYMmA
 /f7szTn5Y7mFnTqrmDBoheM=
X-Google-Smtp-Source: AGHT+IEtLwgWEEwuNcfxNNW8nYVUP5D+p8KeULxARhuF1It6xV4nGnIR+HdbaeRV3CSavqfc8Oc9yQ==
X-Received: by 2002:a17:902:eb42:b0:1b8:7e53:704 with SMTP id
 i2-20020a170902eb4200b001b87e530704mr13161408pli.27.1691504366113; 
 Tue, 08 Aug 2023 07:19:26 -0700 (PDT)
Received: from localhost.localdomain ([223.104.41.22])
 by smtp.gmail.com with ESMTPSA id
 c3-20020a170902b68300b001bb1f0605b2sm9043985pls.214.2023.08.08.07.19.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 08 Aug 2023 07:19:25 -0700 (PDT)
From: Yeqi Fu <fufuyqqqqqq@gmail.com>
To: alex.bennee@linaro.org
Cc: richard.henderson@linaro.org, qemu-devel@nongnu.org,
 Yeqi Fu <fufuyqqqqqq@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>
Subject: [RFC v4 06/11] tcg: Add tcg opcodes and helpers for native library
 calls
Date: Tue,  8 Aug 2023 22:17:34 +0800
Message-Id: <20230808141739.3110740-7-fufuyqqqqqq@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230808141739.3110740-1-fufuyqqqqqq@gmail.com>
References: <20230808141739.3110740-1-fufuyqqqqqq@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62d;
 envelope-from=fufuyqqqqqq@gmail.com; helo=mail-pl1-x62d.google.com
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

This commit implements tcg opcodes and helpers for extracting and
invoke native functions.

Signed-off-by: Yeqi Fu <fufuyqqqqqq@gmail.com>
---
 accel/tcg/tcg-runtime.h     |  22 ++++++
 include/tcg/tcg-op-common.h |  11 +++
 include/tcg/tcg.h           |   9 +++
 tcg/tcg-op.c                | 140 ++++++++++++++++++++++++++++++++++++
 4 files changed, 182 insertions(+)

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
index 0875971719..7c7fafb1cd 100644
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
+void gen_native_call_i32(const char *fun_name, TCGv_i32 ret,
+                         TCGv_i32 arg1, TCGv_i32 arg2, TCGv_i32 arg3);
+void gen_native_call_i64(const char *fun_name, TCGv_i64 ret,
+                         TCGv_i64 arg1, TCGv_i64 arg2, TCGv_i64 arg3);
+
 #endif /* TCG_H */
diff --git a/tcg/tcg-op.c b/tcg/tcg-op.c
index 7aadb37756..83e3a5682c 100644
--- a/tcg/tcg-op.c
+++ b/tcg/tcg-op.c
@@ -2852,3 +2852,143 @@ void tcg_gen_lookup_and_goto_ptr(void)
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
+/* p: iptr ; i: i32 ; a: ptr(address) */
+void gen_native_call_i32(const char *fun_name, TCGv_i32 ret,
+                         TCGv_i32 arg1, TCGv_i32 arg2, TCGv_i32 arg3)
+{
+    TCGv_ptr arg1_ptr = tcg_temp_new_ptr();
+    TCGv_ptr arg2_ptr = tcg_temp_new_ptr();
+    TCGv_ptr arg3_ptr = tcg_temp_new_ptr();
+    TCGv_ptr ret_ptr = tcg_temp_new_ptr();
+    tcg_gen_g2h_i32(arg1_ptr, arg1);
+    if (strcmp(fun_name, "memset") == 0) {/* a aip */
+        tcg_gen_ext_i32_ptr(arg3_ptr, arg3);
+        gen_helper_memset(ret_ptr, arg1_ptr, arg2, arg3_ptr);
+        goto ret_ptr;
+    }
+    tcg_gen_g2h_i32(arg2_ptr, arg2);
+    if (strcmp(fun_name, "strcpy") == 0) { /* a aa */
+        gen_helper_strcpy(ret_ptr, arg1_ptr, arg2_ptr);
+        goto ret_ptr;
+    } else if (strcmp(fun_name, "strcat") == 0) { /* a aa */
+        gen_helper_strcat(ret_ptr, arg1_ptr, arg2_ptr);
+        goto ret_ptr;
+    } else if (strcmp(fun_name, "strcmp") == 0) { /* i aa */
+        gen_helper_strcmp(ret, arg1_ptr, arg2_ptr);
+    }
+    tcg_gen_ext_i32_ptr(arg3_ptr, arg3);
+    if (strcmp(fun_name, "memcpy") == 0) { /* a aap */
+        gen_helper_memcpy(ret_ptr, arg1_ptr, arg2_ptr, arg3_ptr);
+        goto ret_ptr;
+    } else if (strcmp(fun_name, "strncpy") == 0) { /* a aap */
+        gen_helper_strncpy(ret_ptr, arg1_ptr, arg2_ptr, arg3_ptr);
+        goto ret_ptr;
+    } else if (strcmp(fun_name, "memcmp") == 0) { /* i aap */
+        gen_helper_memcmp(ret, arg1_ptr, arg2_ptr, arg3_ptr);
+    } else if (strcmp(fun_name, "strncmp") == 0) { /* i aap */
+        gen_helper_strncmp(ret, arg1_ptr, arg2_ptr, arg3_ptr);
+    }
+    return;
+ret_ptr:
+    tcg_gen_h2g_i32(ret, ret_ptr);
+    return;
+}
+
+void gen_native_call_i64(const char *fun_name, TCGv_i64 ret,
+                         TCGv_i64 arg1, TCGv_i64 arg2, TCGv_i64 arg3)
+{
+    TCGv_ptr arg1_ptr = tcg_temp_new_ptr();
+    TCGv_ptr arg2_ptr = tcg_temp_new_ptr();
+    TCGv_ptr arg3_ptr = tcg_temp_new_ptr();
+    TCGv_ptr ret_ptr = tcg_temp_new_ptr();
+    TCGv_i32 arg2_i32, ret_i32 = tcg_temp_new_i32();
+    tcg_gen_g2h_i64(arg1_ptr, arg1);
+    if (strcmp(fun_name, "memset") == 0) { /* a aip */
+        arg2_i32 = tcg_temp_new_i32();
+        tcg_gen_extrl_i64_i32(arg2_i32, arg2);
+        tcg_gen_trunc_i64_ptr(arg3_ptr, arg3);
+        gen_helper_memset(ret_ptr, arg1_ptr, arg2_i32, arg3_ptr);
+        goto ret_ptr;
+    }
+    tcg_gen_g2h_i64(arg2_ptr, arg2);
+    if (strcmp(fun_name, "strcpy") == 0) { /* a aa */
+        gen_helper_strcpy(ret_ptr, arg1_ptr, arg2_ptr);
+        goto ret_ptr;
+    } else if (strcmp(fun_name, "strcat") == 0) { /* a aa */
+        gen_helper_strcat(ret_ptr, arg1_ptr, arg2_ptr);
+        goto ret_ptr;
+    } else if (strcmp(fun_name, "strcmp") == 0) { /* i aa */
+        gen_helper_strcmp(ret_i32, arg1_ptr, arg2_ptr);
+        goto ret_i32;
+    }
+    tcg_gen_trunc_i64_ptr(arg3_ptr, arg3);
+    if (strcmp(fun_name, "memcpy") == 0) { /* a aap */
+        gen_helper_memcpy(ret_ptr, arg1_ptr, arg2_ptr, arg3_ptr);
+        goto ret_ptr;
+    } else if (strcmp(fun_name, "strncpy") == 0) { /* a aap */
+        gen_helper_strncpy(ret_ptr, arg1_ptr, arg2_ptr, arg3_ptr);
+        goto ret_ptr;
+    } else if (strcmp(fun_name, "memcmp") == 0) { /* i aap */
+        gen_helper_memcmp(ret_i32, arg1_ptr, arg2_ptr, arg3_ptr);
+        goto ret_i32;
+    } else if (strcmp(fun_name, "strncmp") == 0) { /* i aap */
+        gen_helper_strncmp(ret_i32, arg1_ptr, arg2_ptr, arg3_ptr);
+        goto ret_i32;
+    }
+    return;
+ret_ptr:
+    tcg_gen_h2g_i64(ret, ret_ptr);
+    return;
+ret_i32:
+    tcg_gen_extu_i32_i64(ret, ret_i32);
+    return;
+}
-- 
2.34.1



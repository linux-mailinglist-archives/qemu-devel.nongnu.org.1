Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 51DE673D482
	for <lists+qemu-devel@lfdr.de>; Sun, 25 Jun 2023 23:28:32 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qDXGl-0005YP-Oh; Sun, 25 Jun 2023 17:27:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <fufuyqqqqqq@gmail.com>)
 id 1qDXGi-0005Y0-DQ
 for qemu-devel@nongnu.org; Sun, 25 Jun 2023 17:27:36 -0400
Received: from mail-pg1-x534.google.com ([2607:f8b0:4864:20::534])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <fufuyqqqqqq@gmail.com>)
 id 1qDXGf-0003U4-TM
 for qemu-devel@nongnu.org; Sun, 25 Jun 2023 17:27:35 -0400
Received: by mail-pg1-x534.google.com with SMTP id
 41be03b00d2f7-544c0d768b9so2285847a12.0
 for <qemu-devel@nongnu.org>; Sun, 25 Jun 2023 14:27:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1687728452; x=1690320452;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rt6ZHxAj6+7mhUCms5O9p6L2Lf2FaYgxsL9F9giKDX4=;
 b=NylhQXo90AMxOR7Axwmel6Z3DbqRuBKHqLisVxQ3s/BpgPQFlEHYYtFRNxUV3uFHT0
 VAg80W9lNCm0ZkekvCvR/X8P5Rq9Z64xeesikwtG6+qBPVgrQlFUnd2QYivLxvdU6miL
 yu1Fye8VUm4QOJrnkfeno02vJHi+2vus10X1hX2DNaGfEEuJ/ru2cP8B0WPXUyJFuuGN
 8//GxLEBKBLs9wEnqA/Z/DWz+cNPlL4JFw4xIpdk/2BRb4XXUEx7GoKCmD7nivJD947E
 2gQHN5COl1NEQwbPH/gqx2WUyov8q2VkfjAM2kto0bWu9rL3lF5aGDoBL4mPMuj43vIP
 i2kA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687728452; x=1690320452;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=rt6ZHxAj6+7mhUCms5O9p6L2Lf2FaYgxsL9F9giKDX4=;
 b=BJLkkn51MoB+Pam5eIObtkOszANsmQawxo/bEgbXLPGABCg9SA9gYQ3hecrX5IwJix
 Glw4kvcTTjVSkLZjgvyZJY1L/rFP4CjeIbTPsBd9cAM66tFqALSp8Xk0j6ayU85m6mE2
 KAe87LCVsmeSfTMmZRH0SztsMYWhV2gGw88ouuLlLZIvth0xTqqPMdReWguYIJSL0dcb
 h0Z2dO7FLn+OMOWJk4WfP2rkATz/LFCYocCj3uCGSQgCQ0iC0V/kow72MuFG1/+EO+7W
 E6j0hBNlxZHiohOwHfNDccEKPzdffdPAaL+p55ry3enBbi1gxqS6CApJiE+LCn7PCnMM
 DBlA==
X-Gm-Message-State: AC+VfDyAHWmmkDkLgeot91bD2+4Gjc2xhdPvJsUIHcD+2lM6hmBmc3FT
 0WM9+tUKWF7fh8+u9C9etzg=
X-Google-Smtp-Source: ACHHUZ4f+Cu8d1RiLxGssLRG9R2vhuDsVe1PlncUIj00IkxQJd1yLb+BEOixG485KJ71kCDG79gzTA==
X-Received: by 2002:a17:902:c407:b0:1ac:8717:d436 with SMTP id
 k7-20020a170902c40700b001ac8717d436mr7152313plk.60.1687728452368; 
 Sun, 25 Jun 2023 14:27:32 -0700 (PDT)
Received: from q1iq-virtual-machine.localdomain ([111.201.135.80])
 by smtp.gmail.com with ESMTPSA id
 je5-20020a170903264500b001b8004ff609sm761343plb.270.2023.06.25.14.27.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 25 Jun 2023 14:27:32 -0700 (PDT)
From: Yeqi Fu <fufuyqqqqqq@gmail.com>
To: alex.bennee@linaro.org
Cc: richard.henderson@linaro.org, qemu-devel@nongnu.org,
 Yeqi Fu <fufuyqqqqqq@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>
Subject: [RFC v3 06/10] accel/tcg: Add support for native library calls
Date: Mon, 26 Jun 2023 05:27:03 +0800
Message-Id: <20230625212707.1078951-7-fufuyqqqqqq@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230625212707.1078951-1-fufuyqqqqqq@gmail.com>
References: <20230625212707.1078951-1-fufuyqqqqqq@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::534;
 envelope-from=fufuyqqqqqq@gmail.com; helo=mail-pg1-x534.google.com
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

This commit implements several helpers for extracting function id and
argument types, and then using this information to invoke native functions.

Signed-off-by: Yeqi Fu <fufuyqqqqqq@gmail.com>
---
 accel/tcg/tcg-runtime.c       | 37 +++++++++++++++++
 accel/tcg/tcg-runtime.h       |  4 ++
 include/native/native-calls.h | 75 +++++++++++++++++++++++++++++++++++
 3 files changed, 116 insertions(+)
 create mode 100644 include/native/native-calls.h

diff --git a/accel/tcg/tcg-runtime.c b/accel/tcg/tcg-runtime.c
index e4e030043f..3f173f2a53 100644
--- a/accel/tcg/tcg-runtime.c
+++ b/accel/tcg/tcg-runtime.c
@@ -148,3 +148,40 @@ void HELPER(exit_atomic)(CPUArchState *env)
 {
     cpu_loop_exit_atomic(env_cpu(env), GETPC());
 }
+
+target_ulong helper_native_call(CPUArchState *env, target_ulong arg1,
+                                target_ulong arg2, target_ulong arg3,
+                                uint32_t abi_map, uint32_t func_id, uint32_t mmu_idx)
+{
+    if (GET_ARG3(abi_map)) {
+        return do_native_3in1out(env, arg1, arg2, arg3, abi_map, func_id,
+                                 mmu_idx);
+    } else {
+        return do_native_2in1out(env, arg1, arg2, abi_map, func_id, mmu_idx);
+    }
+}
+
+
+uint32_t helper_native_call_i32(CPUArchState *env, uint32_t arg1, uint32_t arg2,
+                                uint32_t arg3, uint32_t abi_map,
+                                uint32_t func_id, uint32_t mmu_idx)
+{
+    if (GET_ARG3(abi_map)) {
+        return do_native_3in1out(env, arg1, arg2, arg3, abi_map, func_id,
+                                 mmu_idx);
+    } else {
+        return do_native_2in1out(env, arg1, arg2, abi_map, func_id, mmu_idx);
+    }
+}
+
+uint64_t helper_native_call_i64(CPUArchState *env, uint64_t arg1, uint64_t arg2,
+                                uint64_t arg3, uint32_t abi_map,
+                                uint32_t func_id, uint32_t mmu_idx)
+{
+    if (GET_ARG3(abi_map)) {
+        return do_native_3in1out(env, arg1, arg2, arg3, abi_map, func_id,
+                                 mmu_idx);
+    } else {
+        return do_native_2in1out(env, arg1, arg2, abi_map, func_id, mmu_idx);
+    }
+}
diff --git a/accel/tcg/tcg-runtime.h b/accel/tcg/tcg-runtime.h
index 6f8c2061d0..3b1fe606e5 100644
--- a/accel/tcg/tcg-runtime.h
+++ b/accel/tcg/tcg-runtime.h
@@ -300,3 +300,7 @@ DEF_HELPER_FLAGS_4(gvec_leu32, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
 DEF_HELPER_FLAGS_4(gvec_leu64, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
 
 DEF_HELPER_FLAGS_5(gvec_bitsel, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, ptr, i32)
+
+DEF_HELPER_7(native_call, tl, env, tl, tl, tl, i32, i32, i32)
+DEF_HELPER_7(native_call_i32, i32, env, i32, i32, i32, i32, i32, i32)
+DEF_HELPER_7(native_call_i64, i64, env, i64, i64, i64, i32, i32, i32)
diff --git a/include/native/native-calls.h b/include/native/native-calls.h
new file mode 100644
index 0000000000..5c99344a65
--- /dev/null
+++ b/include/native/native-calls.h
@@ -0,0 +1,75 @@
+#include "exec/cpu_ldst.h"
+#include "cpu.h"
+#include "native-defs.h"
+
+typedef uintptr_t (*nfunc_2in1out)(uintptr_t, uintptr_t);
+typedef uintptr_t (*nfunc_3in1out)(uintptr_t, uintptr_t, uintptr_t);
+
+static inline uintptr_t decode_arg(CPUArchState *env, abi_ptr arg,
+                                   uintptr_t size, uint8_t type,
+                                   uint32_t mmu_idx);
+abi_ptr do_native_2in1out(CPUArchState *env, abi_ptr arg1, abi_ptr arg2,
+                          uint32_t abi_map, uint32_t func_id, uint32_t mmu_idx);
+abi_ptr do_native_3in1out(CPUArchState *env, abi_ptr arg1, abi_ptr arg2,
+                          abi_ptr arg3, uint32_t abi_map, uint32_t func_id,
+                          uint32_t mmu_idx);
+
+nfunc_3in1out func3in1out_array[] = {
+    (nfunc_3in1out)NULL,   (nfunc_3in1out)memcpy,  (nfunc_3in1out)memcmp,
+    (nfunc_3in1out)memset, (nfunc_3in1out)strncpy, (nfunc_3in1out)strncmp,
+};
+
+nfunc_2in1out func2in1out_array[] = {
+    (nfunc_2in1out)NULL,
+    (nfunc_2in1out)strcpy,
+    (nfunc_2in1out)strcmp,
+};
+
+static inline uintptr_t decode_arg(CPUArchState *env, abi_ptr arg,
+                                   uintptr_t size, uint8_t type,
+                                   uint32_t mmu_idx)
+{
+    if (IS_ARG_PTR(type)) {
+        uintptr_t ra = GETPC();
+        void *host;
+        if (IS_ARG_WRITE(type)) {
+            host = probe_write(env, arg, size, mmu_idx, ra);
+            return (uintptr_t)host;
+        }
+        if (IS_ARG_READ(type)) {
+            host = probe_read(env, arg, size, mmu_idx, ra);
+            return (uintptr_t)host;
+        }
+        CPUState *cs = env_cpu(env);
+        return (uintptr_t)g2h(cs, arg);
+    }
+    return (uintptr_t)arg;
+}
+
+/* Currently, there is no distinction between int32, int64, and int. Their type
+ * conversions should be implemented. */
+abi_ptr do_native_3in1out(CPUArchState *env, abi_ptr arg1, abi_ptr arg2,
+                          abi_ptr arg3, uint32_t abi_map, uint32_t func_id,
+                          uint32_t mmu_idx)
+{
+    uintptr_t n = (uintptr_t)arg3;
+    uintptr_t n1 = decode_arg(env, arg1, n, GET_ARG1(abi_map), mmu_idx);
+    uintptr_t n2 = decode_arg(env, arg2, n, GET_ARG2(abi_map), mmu_idx);
+    nfunc_3in1out fn = func3in1out_array[func_id - 0x1000];
+    uintptr_t r = fn(n1, n2, n);
+    return IS_PTR_RVALUE(abi_map) ? h2g(r) : (target_ulong)r;
+}
+
+
+abi_ptr do_native_2in1out(CPUArchState *env, abi_ptr arg1, abi_ptr arg2,
+                          uint32_t abi_map, uint32_t func_id, uint32_t mmu_idx)
+{
+    CPUState *cs = env_cpu(env);
+    uintptr_t n1 =
+        IS_PTR_ARG1(abi_map) ? (uintptr_t)g2h(cs, arg1) : (uintptr_t)arg1;
+    uintptr_t n2 =
+        IS_PTR_ARG2(abi_map) ? (uintptr_t)g2h(cs, arg2) : (uintptr_t)arg2;
+    nfunc_2in1out fn = func2in1out_array[func_id - 0x2000];
+    uintptr_t r = fn(n1, n2);
+    return IS_PTR_RVALUE(abi_map) ? h2g(r) : (target_ulong)r;
+}
-- 
2.34.1



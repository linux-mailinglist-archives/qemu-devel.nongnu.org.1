Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C75DAB3E506
	for <lists+qemu-devel@lfdr.de>; Mon,  1 Sep 2025 15:31:33 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ut32M-0004CY-KS; Mon, 01 Sep 2025 07:49:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ktokunaga.mail@gmail.com>)
 id 1ut30n-0001hx-RI; Mon, 01 Sep 2025 07:47:51 -0400
Received: from mail-pf1-x42e.google.com ([2607:f8b0:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ktokunaga.mail@gmail.com>)
 id 1ut30c-0001gx-2w; Mon, 01 Sep 2025 07:47:46 -0400
Received: by mail-pf1-x42e.google.com with SMTP id
 d2e1a72fcca58-76e4fc419a9so4196665b3a.0; 
 Mon, 01 Sep 2025 04:47:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1756727249; x=1757332049; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qtzCpMZhgIt7AYckUzYbs844uv8hugjtHhfrUacfFXw=;
 b=nK1vkW2WLCnpTor2w7sjyeMMRL8oKuBby/VH8dqHaAbV80g/BoAOmxPUSRM7APtgaa
 3MN3HUIes4bmWRNvNZ7/xAvmGzzDaWBhZ4c8atlwgp4vsTJw+ho7PS6+wRQz19QSxzBT
 gqM/jyYZkFQKuJe+i/Hkbdz0XI10u1+GNH/5V8mFOoDV1hdu8UAeQ4AC+LkuQNaolANy
 zr0nNG2bg3gB7Qx7EkgY1vAAJWqnjPDfd8jI4AX5kz2b/zLrtN+nr+ncvyxTXw7hJ4yS
 YqwQIUnXiMT183K9ogDskulKR6WKiMGWgxDw+3vfPaT95nddfzPhBVbRxltd/ll7qN4P
 Kipg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756727249; x=1757332049;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=qtzCpMZhgIt7AYckUzYbs844uv8hugjtHhfrUacfFXw=;
 b=CGCqGGh0kFPf8fTxW+SfEDvf6mitOv8ynvi+CZZZnXCi7s5Yx/RJ3OW55VuWde3do+
 vq6KW3Lmfvhh5EMJHEQMGvn94EIQcFXBvXv5Gj8kcJ0Ue/w8hxysu4MkfW+k78hKCqY3
 TkcC+1AFBmIRlJ+4JCzqDB4w2FSIFk8WEpTjuyvmEDPHy7xUFFR4HH8HlUO2jP9xQjW/
 vpYqHTTMNmSALBPeidK4s7gn7FtyC36kB6tSiWQY/IYnVXmVZhBAIjLbVZAUwBfO7KTJ
 Ndy3bflluAgheXQ8t+oCwP7S5+0zXMu1W0lyQeqX8+G4ad1QEpJChfsikBn/4OmC2K1v
 hlbQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCV6KWNRdFtJ53AR864MJjlPkCr7VoBTqRmUWmyCwr2hK7HHcDFFppQqp+uS/iLiVyC4KCHMDkkBBw==@nongnu.org,
 AJvYcCVXcBMRRTCGax0dGiYRNFE9fIQcpPlEDEof3wlFOGDVE3sK8rfb1o7bc7taqw1WK7T2lB5hpa7aAHz0pg==@nongnu.org
X-Gm-Message-State: AOJu0Yz+HUAdaFRGmv0+WuAuGjDjymszkv6pZA+JNKMcI/kovUE+aQIJ
 enUUhsiVv2wn5ueEXK1Uly0bKEqHC1dVaKOfonJeWQ8qyn/XPrfQGWamkYrhbQ==
X-Gm-Gg: ASbGnctsfR392TEANMhUoNIfp2uI5+T4JLkHurv8IwJXMyjLUyBuvaLrLTHynUw/cYX
 BHQToL2/nRrV/9tqGfS5751bX/6NP4FzRZRrGB/0efFTkzObQiPAp5xT/XVXi2cK9Cx7dG+pu9T
 lQqBBLDVlbkrhiTcJLYKA58jNOnEPNdKok1VHwjdBXF3IMmwG96DUkO9ogsRD/3diObAzFRpsLN
 FZI/JdH00V2/SORKPi5dtpDedOPRgx6qA9JyCPLjMbnQKa/ZmrybuTA3uWrdRRI2ymHEXEZOt0B
 m+UGA7b33odQ/8ClnGafqOJ5BjML7aYNLWuBwvd1BzMnWAtJIUiw2QugIA3rsYm1LIlDy3o2wzu
 Fjwc398SEUILRAAbDrITwaA==
X-Google-Smtp-Source: AGHT+IHfcqIw9dgU1rEYY4zsbl/g9tBwWiy/Vs/kHJW7TUWu0W+KfSvXD/dCwLBmL2mFdtc/r6utQQ==
X-Received: by 2002:a17:902:c405:b0:244:6a96:6912 with SMTP id
 d9443c01a7336-24944a56332mr106636255ad.20.1756727248683; 
 Mon, 01 Sep 2025 04:47:28 -0700 (PDT)
Received: from ktock.. ([240d:1a:3b6:8b00:750a:cb0b:f0f9:68f4])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-249065a8036sm103038775ad.129.2025.09.01.04.47.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 01 Sep 2025 04:47:28 -0700 (PDT)
From: Kohei Tokunaga <ktokunaga.mail@gmail.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Thomas Huth <thuth@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 WANG Xuerui <git@xen0n.name>, Aurelien Jarno <aurelien@aurel32.net>,
 Huacai Chen <chenhuacai@kernel.org>, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Aleksandar Rikalo <arikalo@gmail.com>, Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <Alistair.Francis@wdc.com>, Stefan Weil <sw@weilnetz.de>,
 qemu-arm@nongnu.org, qemu-riscv@nongnu.org,
 Stefan Hajnoczi <stefanha@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, ktokunaga.mail@gmail.com
Subject: [PATCH v3 22/35] tcg/wasm: Add call instruction
Date: Mon,  1 Sep 2025 20:44:24 +0900
Message-ID: <942c6e41ff9418ae82537b2b8eb81af543997dcc.1756724464.git.ktokunaga.mail@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1756724464.git.ktokunaga.mail@gmail.com>
References: <cover.1756724464.git.ktokunaga.mail@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42e;
 envelope-from=ktokunaga.mail@gmail.com; helo=mail-pf1-x42e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

To call QEMU functions from a TB's Wasm module, the functions must be
imported into the module.

Wasm's call instruction can invoke an imported function using a locally
assigned function index. When a call TCG operation is generated, the Wasm
backend assigns the ID (starting from 0) to the target function. The mapping
between the function pointer and its assigned ID is recorded in a list of
HelperInfo.

Since Wasm's call instruction requires arguments to be pushed onto the Wasm
stack, the backend retrieves the function arguments from TCG's stack array
and pushes them to the Wasm stack before the call. After the function
returns, the result is retrieved from the Wasm stack and set in the
corresponding TCG variable.

In the Emscripten build configured with !has_int128_type, a 128bit value is
represented by the Int128 struct. Such values are passed to the function via
pointer parameters and returned via a prepended pointer argument, as
described in [1]. For this prepended buffer area, the module expects a
pre-allocated Int128 buffer from the caller via ctx.buf128.

Helper functions expect the target of the return instruction via the GETPC
macro (the tci_tb_ptr variable in TCI). However, unlike other architectures,
Wasm doesn't have a register pointing to the return target. To emulate this
behaviour, the Wasm module sets the instruction pointer to the corresponding
TCI instruction (s->code_ptr) in tci_tb_ptr passed via the WasmContext.

TCI instructions are also generated in the same way as the original TCI
backend.

[1] https://github.com/WebAssembly/tool-conventions/blob/060cf4073e46931160c2e9ecd43177ee1fe93866/BasicCABI.md#function-arguments-and-return-values

Signed-off-by: Kohei Tokunaga <ktokunaga.mail@gmail.com>
---
 tcg/wasm.c                |  63 +++++++++++++
 tcg/wasm.h                |  10 +++
 tcg/wasm/tcg-target.c.inc | 183 ++++++++++++++++++++++++++++++++++++++
 3 files changed, 256 insertions(+)

diff --git a/tcg/wasm.c b/tcg/wasm.c
index c54c5c5b2c..db0c213d92 100644
--- a/tcg/wasm.c
+++ b/tcg/wasm.c
@@ -21,6 +21,10 @@
 #include "qemu/osdep.h"
 #include "tcg/tcg.h"
 #include "tcg/tcg-ldst.h"
+#include "tcg/helper-info.h"
+#include <ffi.h>
+
+__thread uintptr_t tci_tb_ptr;
 
 static void tci_args_l(uint32_t insn, const void *tb_ptr, void **l0)
 {
@@ -33,6 +37,13 @@ static void tci_args_r(uint32_t insn, TCGReg *r0)
     *r0 = extract32(insn, 8, 4);
 }
 
+static void tci_args_nl(uint32_t insn, const void *tb_ptr,
+                        uint8_t *n0, void **l1)
+{
+    *n0 = extract32(insn, 8, 4);
+    *l1 = sextract32(insn, 12, 20) + (void *)tb_ptr;
+}
+
 static void tci_args_rl(uint32_t insn, const void *tb_ptr,
                         TCGReg *r0, void **l1)
 {
@@ -204,6 +215,58 @@ static uintptr_t tcg_qemu_tb_exec_tci(CPUArchState *env, const void *v_tb_ptr)
         opc = extract32(insn, 0, 8);
 
         switch (opc) {
+        case INDEX_op_call:
+            {
+                void *call_slots[MAX_CALL_IARGS];
+                ffi_cif *cif;
+                void *func;
+                unsigned i, s, n;
+
+                tci_args_nl(insn, tb_ptr, &len, &ptr);
+                func = ((void **)ptr)[0];
+                cif = ((void **)ptr)[1];
+
+                n = cif->nargs;
+                for (i = s = 0; i < n; ++i) {
+                    ffi_type *t = cif->arg_types[i];
+                    call_slots[i] = &stack[s];
+                    s += DIV_ROUND_UP(t->size, 8);
+                }
+
+                /* Helper functions may need to access the "return address" */
+                tci_tb_ptr = (uintptr_t)tb_ptr;
+                ffi_call(cif, func, stack, call_slots);
+            }
+
+            switch (len) {
+            case 0: /* void */
+                break;
+            case 1: /* uint32_t */
+                /*
+                 * The result winds up "left-aligned" in the stack[0] slot.
+                 * Note that libffi has an odd special case in that it will
+                 * always widen an integral result to ffi_arg.
+                 */
+                if (sizeof(ffi_arg) == 8) {
+                    regs[TCG_REG_R0] = (uint32_t)stack[0];
+                } else {
+                    regs[TCG_REG_R0] = *(uint32_t *)stack;
+                }
+                break;
+            case 2: /* uint64_t */
+                /*
+                 * For TCG_TARGET_REG_BITS == 32, the register pair
+                 * must stay in host memory order.
+                 */
+                memcpy(&regs[TCG_REG_R0], stack, 8);
+                break;
+            case 3: /* Int128 */
+                memcpy(&regs[TCG_REG_R0], stack, 16);
+                break;
+            default:
+                g_assert_not_reached();
+            }
+            break;
         case INDEX_op_and:
             tci_args_rrr(insn, &r0, &r1, &r2);
             regs[r0] = regs[r1] & regs[r2];
diff --git a/tcg/wasm.h b/tcg/wasm.h
index 9da38e4d0e..a3631b34a8 100644
--- a/tcg/wasm.h
+++ b/tcg/wasm.h
@@ -10,6 +10,16 @@ struct WasmContext {
      * Pointer to the TB to be executed.
      */
     void *tb_ptr;
+
+    /*
+     * Pointer to the tci_tb_ptr variable.
+     */
+    void *tci_tb_ptr;
+
+    /*
+     * Buffer to store 128bit return value on call.
+     */
+    void *buf128;
 };
 
 #endif
diff --git a/tcg/wasm/tcg-target.c.inc b/tcg/wasm/tcg-target.c.inc
index c077c8ad7c..0606b7de79 100644
--- a/tcg/wasm/tcg-target.c.inc
+++ b/tcg/wasm/tcg-target.c.inc
@@ -28,6 +28,14 @@
 #include "qemu/queue.h"
 #include "../wasm.h"
 
+/* Used for function call generation. */
+#define TCG_TARGET_CALL_STACK_OFFSET 0
+#define TCG_TARGET_STACK_ALIGN       8
+#define TCG_TARGET_CALL_ARG_I32      TCG_CALL_ARG_NORMAL
+#define TCG_TARGET_CALL_ARG_I64      TCG_CALL_ARG_NORMAL
+#define TCG_TARGET_CALL_ARG_I128     TCG_CALL_ARG_NORMAL
+#define TCG_TARGET_CALL_RET_I128     TCG_CALL_RET_NORMAL
+
 typedef uint32_t tcg_insn_unit_tci;
 
 static const int tcg_target_reg_alloc_order[] = {
@@ -143,6 +151,9 @@ static const uint8_t tcg_target_reg_index[TCG_TARGET_NB_REGS] = {
 /* Local variable pointing to WasmContext */
 #define CTX_IDX 0
 
+/* Function index */
+#define HELPER_IDX_START 0 /* The first index of helper functions */
+
 typedef enum {
     OPC_UNREACHABLE = 0x00,
     OPC_LOOP = 0x03,
@@ -151,6 +162,7 @@ typedef enum {
     OPC_END = 0x0b,
     OPC_BR = 0x0c,
     OPC_RETURN = 0x0f,
+    OPC_CALL = 0x10,
     OPC_LOCAL_GET = 0x20,
     OPC_GLOBAL_GET = 0x23,
     OPC_GLOBAL_SET = 0x24,
@@ -832,6 +844,147 @@ static void tcg_wasm_out_goto_tb(
     tcg_wasm_out_op(s, OPC_END);
 }
 
+static void push_arg_i64(TCGContext *s, int *stack_offset)
+{
+    intptr_t ofs;
+    tcg_wasm_out_op_idx(s, OPC_GLOBAL_GET, REG_IDX(TCG_REG_CALL_STACK));
+    ofs = tcg_wasm_out_norm_ptr(s, *stack_offset);
+    tcg_wasm_out_op_ldst(s, OPC_I64_LOAD, 0, ofs);
+    *stack_offset = *stack_offset + 8;
+}
+
+static void gen_call(TCGContext *s,
+                     const TCGHelperInfo *info, uint32_t func_idx)
+{
+    unsigned typemask = info->typemask;
+    int rettype = typemask & 7;
+    int stack_offset = 0;
+    intptr_t ofs;
+
+    if (rettype ==  dh_typecode_i128) {
+        /* receive 128bit return value via the buffer */
+        ofs = tcg_wasm_out_get_ctx(s, CTX_OFFSET(buf128));
+        tcg_wasm_out_op_ldst(s, OPC_I64_LOAD, 0, ofs);
+    }
+
+    for (typemask >>= 3; typemask; typemask >>= 3) {
+        switch (typemask & 7) {
+        case dh_typecode_void:
+            break;
+        case dh_typecode_i32:
+        case dh_typecode_s32:
+            push_arg_i64(s, &stack_offset);
+            tcg_wasm_out_op(s, OPC_I32_WRAP_I64);
+            break;
+        case dh_typecode_i64:
+        case dh_typecode_s64:
+            push_arg_i64(s, &stack_offset);
+            break;
+        case dh_typecode_i128:
+            tcg_wasm_out_op_idx(s, OPC_GLOBAL_GET, REG_IDX(TCG_REG_CALL_STACK));
+            tcg_wasm_out_op_const(s, OPC_I64_CONST, stack_offset);
+            tcg_wasm_out_op(s, OPC_I64_ADD);
+            stack_offset += 16;
+            break;
+        case dh_typecode_ptr:
+            push_arg_i64(s, &stack_offset);
+            break;
+        default:
+            g_assert_not_reached();
+        }
+    }
+
+    tcg_wasm_out_op_idx(s, OPC_CALL, func_idx);
+
+    switch (rettype) {
+    case dh_typecode_void:
+        break;
+    case dh_typecode_i32:
+    case dh_typecode_s32:
+        tcg_wasm_out_op(s, OPC_I64_EXTEND_I32_S);
+        tcg_wasm_out_op_idx(s, OPC_GLOBAL_SET, REG_IDX(TCG_REG_R0));
+        break;
+    case dh_typecode_i64:
+    case dh_typecode_s64:
+        tcg_wasm_out_op_idx(s, OPC_GLOBAL_SET, REG_IDX(TCG_REG_R0));
+        break;
+    case dh_typecode_i128:
+        ofs = tcg_wasm_out_get_ctx(s, CTX_OFFSET(buf128));
+        tcg_wasm_out_op_ldst(s, OPC_I64_LOAD, 0, ofs);
+        ofs = tcg_wasm_out_norm_ptr(s, 0);
+        tcg_wasm_out_op_ldst(s, OPC_I64_LOAD, 0, ofs);
+        tcg_wasm_out_op_idx(s, OPC_GLOBAL_SET, REG_IDX(TCG_REG_R0));
+        ofs = tcg_wasm_out_get_ctx(s, CTX_OFFSET(buf128));
+        tcg_wasm_out_op_ldst(s, OPC_I64_LOAD, 0, ofs);
+        ofs = tcg_wasm_out_norm_ptr(s, 8);
+        tcg_wasm_out_op_ldst(s, OPC_I64_LOAD, 0, ofs);
+        tcg_wasm_out_op_idx(s, OPC_GLOBAL_SET, REG_IDX(TCG_REG_R1));
+        break;
+    case dh_typecode_ptr:
+        tcg_wasm_out_op_idx(s, OPC_GLOBAL_SET, REG_IDX(TCG_REG_R0));
+        break;
+    default:
+        g_assert_not_reached();
+    }
+}
+
+typedef struct HelperInfo {
+    intptr_t idx_on_qemu;
+    QSIMPLEQ_ENTRY(HelperInfo) entry;
+} HelperInfo;
+
+static __thread QSIMPLEQ_HEAD(, HelperInfo) helpers;
+__thread uint32_t helper_idx;
+
+static void init_helpers(void)
+{
+    QSIMPLEQ_INIT(&helpers);
+    helper_idx = HELPER_IDX_START;
+}
+
+static uint32_t register_helper(TCGContext *s, intptr_t helper_idx_on_qemu)
+{
+    tcg_debug_assert(helper_idx_on_qemu >= 0);
+
+    HelperInfo *e = tcg_malloc(sizeof(HelperInfo));
+    e->idx_on_qemu = helper_idx_on_qemu;
+    QSIMPLEQ_INSERT_TAIL(&helpers, e, entry);
+
+    return helper_idx++;
+}
+
+static int64_t get_helper_idx(TCGContext *s, intptr_t helper_idx_on_qemu)
+{
+    uint32_t idx = HELPER_IDX_START;
+    HelperInfo *e;
+
+    QSIMPLEQ_FOREACH(e, &helpers, entry) {
+        if (e->idx_on_qemu == helper_idx_on_qemu) {
+            return idx;
+        }
+        idx++;
+    }
+    return -1;
+}
+
+static void tcg_wasm_out_call(TCGContext *s, intptr_t func,
+                              const TCGHelperInfo *info)
+{
+    intptr_t ofs;
+    int64_t func_idx = get_helper_idx(s, func);
+    if (func_idx < 0) {
+        func_idx = register_helper(s, func);
+    }
+
+    ofs = tcg_wasm_out_get_ctx(s, CTX_OFFSET(tci_tb_ptr));
+    tcg_wasm_out_op_ldst(s, OPC_I64_LOAD, 0, ofs);
+    ofs = tcg_wasm_out_norm_ptr(s, 0);
+    tcg_wasm_out_op_const(s, OPC_I64_CONST, (uint64_t)s->code_ptr);
+    tcg_wasm_out_op_ldst(s, OPC_I64_STORE, 0, ofs);
+
+    gen_call(s, info, func_idx);
+}
+
 static void tcg_out_op_l(TCGContext *s, TCGOpcode op, TCGLabel *l0)
 {
     tcg_insn_unit_tci insn = 0;
@@ -1604,11 +1757,41 @@ void tb_target_set_jmp_target(const TranslationBlock *tb, int n,
     /* Always indirect, nothing to do */
 }
 
+static void tcg_out_addi_ptr(TCGContext *s, TCGReg rd, TCGReg rs,
+                             tcg_target_long imm)
+{
+    /* This function is only used for passing structs by reference. */
+    g_assert_not_reached();
+}
+
+static void tcg_out_call(TCGContext *s, const tcg_insn_unit *func,
+                         const TCGHelperInfo *info)
+{
+    ffi_cif *cif = info->cif;
+    tcg_insn_unit_tci insn = 0;
+    uint8_t which;
+
+    if (cif->rtype == &ffi_type_void) {
+        which = 0;
+    } else {
+        tcg_debug_assert(cif->rtype->size == 4 ||
+                         cif->rtype->size == 8 ||
+                         cif->rtype->size == 16);
+        which = ctz32(cif->rtype->size) - 1;
+    }
+    new_pool_l2(s, 20, s->code_ptr, 0, (uintptr_t)func, (uintptr_t)cif);
+    insn = deposit32(insn, 0, 8, INDEX_op_call);
+    insn = deposit32(insn, 8, 4, which);
+    tcg_out32(s, insn);
+    tcg_wasm_out_call(s, (intptr_t)func, info);
+}
+
 static void tcg_out_tb_start(TCGContext *s)
 {
     init_sub_buf();
     init_blocks();
     init_label_info();
+    init_helpers();
 
     tcg_wasm_out_op_block(s, OPC_LOOP, BLOCK_NORET);
     tcg_wasm_out_op_idx(s, OPC_GLOBAL_GET, BLOCK_IDX);
-- 
2.43.0



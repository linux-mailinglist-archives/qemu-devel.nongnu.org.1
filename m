Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E98F6820A83
	for <lists+qemu-devel@lfdr.de>; Sun, 31 Dec 2023 09:49:54 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rJrTY-000516-Mv; Sun, 31 Dec 2023 03:47:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rJrSW-0004iU-Rc
 for qemu-devel@nongnu.org; Sun, 31 Dec 2023 03:46:12 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rJrSU-0000m2-Mg
 for qemu-devel@nongnu.org; Sun, 31 Dec 2023 03:46:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1704012370;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=xeSRyIZgIglXrO6l0PFpDPRgI4kfJCGpVc6DsV6vP/Y=;
 b=Y/zroxqQMRaq+z9b9/89mmwX34giXmEYxN87rM7WKf9EiHigMnLtI9jLRNIcRoyVImz3Wr
 1msuyhPFyPpJIacblHtSvn8hXLhgFF+sccMXAN2HBTdXu3h74YUtqWaMCb8urgx8E2nQL9
 es24Doba7lAfYT9T1x5fQt8wpGsQO2A=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-396-uoRNa6ndMMiPvtNPnajURw-1; Sun, 31 Dec 2023 03:46:07 -0500
X-MC-Unique: uoRNa6ndMMiPvtNPnajURw-1
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-40d62d3ae0cso24405305e9.2
 for <qemu-devel@nongnu.org>; Sun, 31 Dec 2023 00:46:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704012365; x=1704617165;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=xeSRyIZgIglXrO6l0PFpDPRgI4kfJCGpVc6DsV6vP/Y=;
 b=kKLIy4YQujVDV5xkUFDmyEJuVE+LRVuq76QchNjycleTe2Ko0bjuetehIcTOjlHbx5
 t3yap32BYqbRLAIdnH0jMEbGgfE+TI/v7jMzY4bBq2LaxzFy98H1BQy8jdcgr0PJsv8f
 ddguuQzWJfX+OF1E9VhHbMSA93uYbAac9PR56ltQpWrobrfGwcd7DMK042sqAuvgIVRv
 YrJReQjHDkOeWXQIecNFKtqbCjFgF/CHdkgFgbWEK9aOBLH6cLeMdgV3zfkUI3hixjXO
 rvG1+2SM3yZX2GIix0kzpAwh69BKpQrRE2Q2yhHyORtIrl/zUVDJuOoD4iQR+fBQqKjO
 Zb3g==
X-Gm-Message-State: AOJu0Yx6r3j8ECjqf9XXoYVsSoH8nv8G1/koe7k5aw1MPkMqMiFVQQNA
 +BtwtDQxalwB0MsNGmhSnTZHPiH9jAFEEuKg8LKGIMXFRMKiISo03WJeI7yIjybQ/1V6MJonocl
 2Haa4l7TZsh1lcz4HjpuReNR0mY0gEGrZ5T2QTaE4SHwE6pWkwfju2MY8/eWkp00cgc1LyrCgPa
 6vqHNFmq8=
X-Received: by 2002:a7b:cd94:0:b0:40d:85ba:9671 with SMTP id
 y20-20020a7bcd94000000b0040d85ba9671mr432566wmj.86.1704012365229; 
 Sun, 31 Dec 2023 00:46:05 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFMWCwk/b4PhZOvRHY0RgnNYyBDe01HR0aJUK1n0F0q/TUqJyUfeO6ZekGNAfYwHKDsL8hY9w==
X-Received: by 2002:a7b:cd94:0:b0:40d:85ba:9671 with SMTP id
 y20-20020a7bcd94000000b0040d85ba9671mr432557wmj.86.1704012364904; 
 Sun, 31 Dec 2023 00:46:04 -0800 (PST)
Received: from [192.168.10.118] ([2001:b07:6468:f312:1c09:f536:3de6:228c])
 by smtp.gmail.com with ESMTPSA id
 s21-20020a05600c45d500b0040c3953cda5sm44627067wmo.45.2023.12.31.00.46.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 31 Dec 2023 00:46:03 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 21/46] target/i386: introduce flags writeback mechanism
Date: Sun, 31 Dec 2023 09:44:37 +0100
Message-ID: <20231231084502.235366-22-pbonzini@redhat.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231231084502.235366-1-pbonzini@redhat.com>
References: <20231231084502.235366-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -47
X-Spam_score: -4.8
X-Spam_bar: ----
X-Spam_report: (-4.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.667,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

ALU instructions can write to both memory and flags.  If the CC_SRC*
and CC_DST locations have been written already when a memory access
causes a fault, the value in CC_SRC* and CC_DST might be interpreted
with the wrong CC_OP (the one that is in effect before the instruction.

Besides just using the wrong result for the flags, something like
subtracting -1 can have disastrous effects if the current CC_OP is
CC_OP_EFLAGS: this is because QEMU does not expect bits outside the ALU
flags to be set in CC_SRC, and env->eflags can end up set to all-ones.
In the case of the attached testcase, this sets IOPL to 3 and would
cause an assertion failure if SUB is moved to the new decoder.

This mechanism is not really needed for BMI instructions, which can
only write to a register, but put it to use anyway for cleanliness.
In the case of BZHI, the code has to be modified slightly to ensure
that decode->cc_src is written, otherwise the new assertions trigger.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/cpu.h                |  1 +
 target/i386/tcg/decode-new.c.inc | 34 +++++++++++++++++++++++++++++
 target/i386/tcg/decode-new.h     |  4 ++++
 target/i386/tcg/emit.c.inc       | 36 ++++++++++++++++++++-----------
 tests/tcg/i386/Makefile.target   |  2 +-
 tests/tcg/i386/test-flags.c      | 37 ++++++++++++++++++++++++++++++++
 6 files changed, 101 insertions(+), 13 deletions(-)
 create mode 100644 tests/tcg/i386/test-flags.c

diff --git a/target/i386/cpu.h b/target/i386/cpu.h
index ecdd4518c64..7f0786e8b98 100644
--- a/target/i386/cpu.h
+++ b/target/i386/cpu.h
@@ -1285,6 +1285,7 @@ typedef enum {
 
     CC_OP_NB,
 } CCOp;
+QEMU_BUILD_BUG_ON(CC_OP_NB >= 128);
 
 typedef struct SegmentCache {
     uint32_t selector;
diff --git a/target/i386/tcg/decode-new.c.inc b/target/i386/tcg/decode-new.c.inc
index f30889dbc0a..717d7307722 100644
--- a/target/i386/tcg/decode-new.c.inc
+++ b/target/i386/tcg/decode-new.c.inc
@@ -1662,6 +1662,7 @@ static void disas_insn_new(DisasContext *s, CPUState *cpu, int b)
     bool first = true;
     X86DecodedInsn decode;
     X86DecodeFunc decode_func = decode_root;
+    uint8_t cc_live;
 
     s->has_modrm = false;
 
@@ -1815,6 +1816,7 @@ static void disas_insn_new(DisasContext *s, CPUState *cpu, int b)
     }
 
     memset(&decode, 0, sizeof(decode));
+    decode.cc_op = -1;
     decode.b = b;
     if (!decode_insn(s, env, decode_func, &decode)) {
         goto illegal_op;
@@ -1953,6 +1955,38 @@ static void disas_insn_new(DisasContext *s, CPUState *cpu, int b)
         decode.e.gen(s, env, &decode);
         gen_writeback(s, &decode, 0, s->T0);
     }
+
+    /*
+     * Write back flags after last memory access.  Some newer ALU instructions, as
+     * well as SSE instructions, write flags in the gen_* function, but that can
+     * cause incorrect tracking of CC_OP for instructions that write to both memory
+     * and flags.
+     */
+    if (decode.cc_op != -1) {
+        if (decode.cc_dst) {
+            tcg_gen_mov_tl(cpu_cc_dst, decode.cc_dst);
+        }
+        if (decode.cc_src) {
+            tcg_gen_mov_tl(cpu_cc_src, decode.cc_src);
+        }
+        if (decode.cc_src2) {
+            tcg_gen_mov_tl(cpu_cc_src2, decode.cc_src2);
+        }
+        if (decode.cc_op == CC_OP_DYNAMIC) {
+            tcg_gen_mov_i32(cpu_cc_op, decode.cc_op_dynamic);
+        }
+        set_cc_op(s, decode.cc_op);
+        cc_live = cc_op_live[decode.cc_op];
+    } else {
+        cc_live = 0;
+    }
+    if (decode.cc_op != CC_OP_DYNAMIC) {
+        assert(!decode.cc_op_dynamic);
+        assert(!!decode.cc_dst == !!(cc_live & USES_CC_DST));
+        assert(!!decode.cc_src == !!(cc_live & USES_CC_SRC));
+        assert(!!decode.cc_src2 == !!(cc_live & USES_CC_SRC2));
+    }
+
     return;
  gp_fault:
     gen_exception_gpf(s);
diff --git a/target/i386/tcg/decode-new.h b/target/i386/tcg/decode-new.h
index 70b6717227f..25220fc4362 100644
--- a/target/i386/tcg/decode-new.h
+++ b/target/i386/tcg/decode-new.h
@@ -283,6 +283,10 @@ struct X86DecodedInsn {
     target_ulong immediate;
     AddressParts mem;
 
+    TCGv cc_dst, cc_src, cc_src2;
+    TCGv_i32 cc_op_dynamic;
+    int8_t cc_op;
+
     uint8_t b;
 };
 
diff --git a/target/i386/tcg/emit.c.inc b/target/i386/tcg/emit.c.inc
index 4c2006fdd09..fd120e7b9b4 100644
--- a/target/i386/tcg/emit.c.inc
+++ b/target/i386/tcg/emit.c.inc
@@ -339,6 +339,19 @@ static inline int vector_len(DisasContext *s, X86DecodedInsn *decode)
     return s->vex_l ? 32 : 16;
 }
 
+static void prepare_update1_cc(X86DecodedInsn *decode, DisasContext *s, CCOp op)
+{
+    decode->cc_dst = s->T0;
+    decode->cc_op = op;
+}
+
+static void prepare_update2_cc(X86DecodedInsn *decode, DisasContext *s, CCOp op)
+{
+    decode->cc_src = s->T1;
+    decode->cc_dst = s->T0;
+    decode->cc_op = op;
+}
+
 static void gen_store_sse(DisasContext *s, X86DecodedInsn *decode, int src_ofs)
 {
     MemOp ot = decode->op[0].ot;
@@ -1027,6 +1040,7 @@ static void gen_##uname(DisasContext *s, CPUX86State *env, X86DecodedInsn *decod
 VSIB_AVX(VPGATHERD, vpgatherd)
 VSIB_AVX(VPGATHERQ, vpgatherq)
 
+/* ADCX/ADOX do not have memory operands and can use set_cc_op.  */
 static void gen_ADCOX(DisasContext *s, CPUX86State *env, MemOp ot, int cc_op)
 {
     int opposite_cc_op;
@@ -1089,8 +1103,7 @@ static void gen_ANDN(DisasContext *s, CPUX86State *env, X86DecodedInsn *decode)
     MemOp ot = decode->op[0].ot;
 
     tcg_gen_andc_tl(s->T0, s->T1, s->T0);
-    gen_op_update1_cc(s);
-    set_cc_op(s, CC_OP_LOGICB + ot);
+    prepare_update1_cc(decode, s, CC_OP_LOGICB + ot);
 }
 
 static void gen_BEXTR(DisasContext *s, CPUX86State *env, X86DecodedInsn *decode)
@@ -1118,10 +1131,10 @@ static void gen_BEXTR(DisasContext *s, CPUX86State *env, X86DecodedInsn *decode)
     tcg_gen_movcond_tl(TCG_COND_LEU, s->T1, s->A0, bound, s->T1, zero);
     tcg_gen_andc_tl(s->T0, s->T0, s->T1);
 
-    gen_op_update1_cc(s);
-    set_cc_op(s, CC_OP_LOGICB + ot);
+    prepare_update1_cc(decode, s, CC_OP_LOGICB + ot);
 }
 
+/* BLSI do not have memory operands and can use set_cc_op.  */
 static void gen_BLSI(DisasContext *s, CPUX86State *env, X86DecodedInsn *decode)
 {
     MemOp ot = decode->op[0].ot;
@@ -1133,6 +1146,7 @@ static void gen_BLSI(DisasContext *s, CPUX86State *env, X86DecodedInsn *decode)
     set_cc_op(s, CC_OP_BMILGB + ot);
 }
 
+/* BLSMSK do not have memory operands and can use set_cc_op.  */
 static void gen_BLSMSK(DisasContext *s, CPUX86State *env, X86DecodedInsn *decode)
 {
     MemOp ot = decode->op[0].ot;
@@ -1144,6 +1158,7 @@ static void gen_BLSMSK(DisasContext *s, CPUX86State *env, X86DecodedInsn *decode
     set_cc_op(s, CC_OP_BMILGB + ot);
 }
 
+/* BLSR do not have memory operands and can use set_cc_op.  */
 static void gen_BLSR(DisasContext *s, CPUX86State *env, X86DecodedInsn *decode)
 {
     MemOp ot = decode->op[0].ot;
@@ -1164,18 +1179,15 @@ static void gen_BZHI(DisasContext *s, CPUX86State *env, X86DecodedInsn *decode)
 
     tcg_gen_ext8u_tl(s->T1, s->T1);
 
+    tcg_gen_shl_tl(s->A0, mone, s->T1);
+    tcg_gen_movcond_tl(TCG_COND_LEU, s->A0, s->T1, bound, s->A0, zero);
+    tcg_gen_andc_tl(s->T0, s->T0, s->A0);
     /*
      * Note that since we're using BMILG (in order to get O
      * cleared) we need to store the inverse into C.
      */
-    tcg_gen_setcond_tl(TCG_COND_LEU, cpu_cc_src, s->T1, bound);
-
-    tcg_gen_shl_tl(s->A0, mone, s->T1);
-    tcg_gen_movcond_tl(TCG_COND_LEU, s->A0, s->T1, bound, s->A0, zero);
-    tcg_gen_andc_tl(s->T0, s->T0, s->A0);
-
-    gen_op_update1_cc(s);
-    set_cc_op(s, CC_OP_BMILGB + ot);
+    tcg_gen_setcond_tl(TCG_COND_LEU, s->T1, s->T1, bound);
+    prepare_update2_cc(decode, s, CC_OP_BMILGB + ot);
 }
 
 static void gen_CRC32(DisasContext *s, CPUX86State *env, X86DecodedInsn *decode)
diff --git a/tests/tcg/i386/Makefile.target b/tests/tcg/i386/Makefile.target
index 3dec7c6c423..9906f9e116b 100644
--- a/tests/tcg/i386/Makefile.target
+++ b/tests/tcg/i386/Makefile.target
@@ -13,7 +13,7 @@ config-cc.mak: Makefile
 
 I386_SRCS=$(notdir $(wildcard $(I386_SRC)/*.c))
 ALL_X86_TESTS=$(I386_SRCS:.c=)
-SKIP_I386_TESTS=test-i386-ssse3 test-avx test-3dnow test-mmx
+SKIP_I386_TESTS=test-i386-ssse3 test-avx test-3dnow test-mmx test-flags
 X86_64_TESTS:=$(filter test-i386-adcox test-i386-bmi2 $(SKIP_I386_TESTS), $(ALL_X86_TESTS))
 
 test-i386-sse-exceptions: CFLAGS += -msse4.1 -mfpmath=sse
diff --git a/tests/tcg/i386/test-flags.c b/tests/tcg/i386/test-flags.c
new file mode 100644
index 00000000000..c379e296275
--- /dev/null
+++ b/tests/tcg/i386/test-flags.c
@@ -0,0 +1,37 @@
+#define _GNU_SOURCE
+#include <sys/mman.h>
+#include <signal.h>
+#include <stdio.h>
+#include <assert.h>
+
+volatile unsigned long flags;
+volatile unsigned long flags_after;
+int *addr;
+
+void sigsegv(int sig, siginfo_t *info, ucontext_t *uc)
+{
+    flags = uc->uc_mcontext.gregs[REG_EFL];
+    mprotect(addr, 4096, PROT_READ|PROT_WRITE);
+}
+
+int main()
+{
+    struct sigaction sa = { .sa_handler = (void *)sigsegv, .sa_flags = SA_SIGINFO };
+    sigaction(SIGSEGV, &sa, NULL);
+
+    /* fault in the page then protect it */
+    addr = mmap (NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANON, -1, 0);
+    *addr = 0x1234;
+    mprotect(addr, 4096, PROT_READ);
+
+    asm("# set flags to all ones    \n"
+        "mov $-1, %%eax             \n"
+        "movq addr, %%rdi           \n"
+        "sahf                       \n"
+        "sub %%eax, (%%rdi)         \n"
+        "pushf                      \n"
+        "pop  flags_after(%%rip)    \n" : : : "eax", "edi", "memory");
+
+    /* OF can have any value before the SUB instruction.  */
+    assert((flags & 0xff) == 0xd7 && (flags_after & 0x8ff) == 0x17);
+}
-- 
2.43.0



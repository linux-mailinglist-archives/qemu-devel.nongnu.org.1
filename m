Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 676597CF5A1
	for <lists+qemu-devel@lfdr.de>; Thu, 19 Oct 2023 12:48:25 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qtQZD-0006yw-76; Thu, 19 Oct 2023 06:47:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qtQYh-0006Za-17
 for qemu-devel@nongnu.org; Thu, 19 Oct 2023 06:47:20 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qtQYf-0006Eu-4W
 for qemu-devel@nongnu.org; Thu, 19 Oct 2023 06:47:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697712435;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=EOzbu/wjGWx2mr4yETlU7YsiT23Laltl4wFFEew5M0c=;
 b=Cyej6BQ9Lz5wzB4JIuq3L6rSsMZ59pfBmNAx3ilucXkTjPXm2f8ZErxmfq4mF+gRJS8jIt
 vBgxAOYx174Z+U9uGWJVMrmtfe69PDii/VwoiE8g7gtmKSjNWxTqqcDazF8WBePFniKvnD
 Me9g0qeb5DgBq9gTHQblUXMYoWYvpEo=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-621-T6Wg2kARO8mdTBSqFwUdQQ-1; Thu, 19 Oct 2023 06:47:04 -0400
X-MC-Unique: T6Wg2kARO8mdTBSqFwUdQQ-1
Received: by mail-ej1-f69.google.com with SMTP id
 a640c23a62f3a-9bea60bd1adso72935766b.0
 for <qemu-devel@nongnu.org>; Thu, 19 Oct 2023 03:47:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697712423; x=1698317223;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=EOzbu/wjGWx2mr4yETlU7YsiT23Laltl4wFFEew5M0c=;
 b=MIRUBurNnbjU5kJaL8hRKgdIV8oPRAZJ/nJcB2onxmqmRQxwgua9YnVAHNokTMpCe0
 CbOdWpiAv1qnppqr50uNY1pIbQevIyFvR5LD19XAcVYiM264mSfx7CL9zPt8jG91/3wB
 6P88tHWf4BeSBaTHsa0FNgmqNAQ6WNNPhJ70pST3PsiuSbVe7yi/NJ/7IbE7qCbqp3fR
 PnHlUjuQ9LYfA5wVjH2pXR4vXesgAMEzGxPSDun5/lUYuYY90PUItGjuIKfKAvRK8Uyo
 xi4jM54u5ObazWkCH7HWD2zG2m9318JjjFrAyuxbwi/d3PKod76o4xpdJTDFFCz1E2q5
 dPEQ==
X-Gm-Message-State: AOJu0YztEESry1CbrlTq8UFMvqKZuUhahc9u02KP4jRbeZ5paALSTp37
 1E+h5TGMmArFLGK3KXQapZj9mazMu82MrXyQdesV2xy5lbLNFNdvpM3CBx8heLK2LKe6oGBMwsx
 lbTj5imUj7xo8e/9Vp3uMy9yRu+PMiAGIep41ff3wr4r8ZqxI1lBEC5/L+rpEP8BtDY1sUGUfDZ
 c=
X-Received: by 2002:a17:907:7e91:b0:9ae:5df2:2291 with SMTP id
 qb17-20020a1709077e9100b009ae5df22291mr1644646ejc.1.1697712423072; 
 Thu, 19 Oct 2023 03:47:03 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFxXBr2mN+rekQr7nnh3RYGlV00Z0hxUVtS3ArzqvMPYU3YawtW0HULO8OAn3aEw6eY4Vy7rQ==
X-Received: by 2002:a17:907:7e91:b0:9ae:5df2:2291 with SMTP id
 qb17-20020a1709077e9100b009ae5df22291mr1644624ejc.1.1697712422634; 
 Thu, 19 Oct 2023 03:47:02 -0700 (PDT)
Received: from [192.168.10.118] ([2001:b07:6468:f312:5e2c:eb9a:a8b6:fd3e])
 by smtp.gmail.com with ESMTPSA id
 a13-20020a1709064a4d00b009930042510csm3338815ejv.222.2023.10.19.03.47.01
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Oct 2023 03:47:01 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 07/19] target/i386: introduce flags writeback mechanism
Date: Thu, 19 Oct 2023 12:46:36 +0200
Message-ID: <20231019104648.389942-8-pbonzini@redhat.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231019104648.389942-1-pbonzini@redhat.com>
References: <20231019104648.389942-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/cpu.h                |  1 +
 target/i386/tcg/decode-new.c.inc | 31 ++++++++++++++++++++++++++
 target/i386/tcg/decode-new.h     |  4 ++++
 target/i386/tcg/emit.c.inc       | 19 ++++++++++------
 tests/tcg/i386/Makefile.target   |  2 +-
 tests/tcg/i386/test-flags.c      | 37 ++++++++++++++++++++++++++++++++
 6 files changed, 87 insertions(+), 7 deletions(-)
 create mode 100644 tests/tcg/i386/test-flags.c

diff --git a/target/i386/cpu.h b/target/i386/cpu.h
index e1875466b9d..94a5137f068 100644
--- a/target/i386/cpu.h
+++ b/target/i386/cpu.h
@@ -1285,6 +1285,7 @@ typedef enum {
 
     CC_OP_NB,
 } CCOp;
+QEMU_BUILD_BUG_ON(CC_OP_NB >= 128);
 
 typedef struct SegmentCache {
     uint32_t selector;
diff --git a/target/i386/tcg/decode-new.c.inc b/target/i386/tcg/decode-new.c.inc
index eb2400095f8..0a2aebf2ebb 100644
--- a/target/i386/tcg/decode-new.c.inc
+++ b/target/i386/tcg/decode-new.c.inc
@@ -1823,6 +1823,7 @@ static void disas_insn_new(DisasContext *s, CPUState *cpu, int b)
     }
 
     memset(&decode, 0, sizeof(decode));
+    decode.cc_op = -1;
     decode.b = b;
     if (!decode_insn(s, env, decode_func, &decode)) {
         goto illegal_op;
@@ -1943,6 +1944,36 @@ static void disas_insn_new(DisasContext *s, CPUState *cpu, int b)
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
+        } else {
+            assert(!decode.cc_op_dynamic);
+        }
+        set_cc_op(s, decode.cc_op);
+    } else {
+        assert(!decode.cc_dst);
+        assert(!decode.cc_src);
+        assert(!decode.cc_src2);
+        assert(!decode.cc_op_dynamic);
+    }
+
     return;
  gp_fault:
     gen_exception_gpf(s);
diff --git a/target/i386/tcg/decode-new.h b/target/i386/tcg/decode-new.h
index ab21fa6db97..4258db19899 100644
--- a/target/i386/tcg/decode-new.h
+++ b/target/i386/tcg/decode-new.h
@@ -265,6 +265,10 @@ struct X86DecodedInsn {
     target_ulong immediate;
     AddressParts mem;
 
+    TCGv cc_dst, cc_src, cc_src2;
+    TCGv_i32 cc_op_dynamic;
+    int8_t cc_op;
+
     uint8_t b;
 };
 
diff --git a/target/i386/tcg/emit.c.inc b/target/i386/tcg/emit.c.inc
index 82da5488d47..90da1401745 100644
--- a/target/i386/tcg/emit.c.inc
+++ b/target/i386/tcg/emit.c.inc
@@ -323,6 +323,12 @@ static inline int vector_len(DisasContext *s, X86DecodedInsn *decode)
     return s->vex_l ? 32 : 16;
 }
 
+static void prepare_update1_cc(X86DecodedInsn *decode, DisasContext *s, CCOp op)
+{
+    decode->cc_dst = s->T0;
+    decode->cc_op = op;
+}
+
 static void gen_store_sse(DisasContext *s, X86DecodedInsn *decode, int src_ofs)
 {
     MemOp ot = decode->op[0].ot;
@@ -1011,6 +1017,7 @@ static void gen_##uname(DisasContext *s, CPUX86State *env, X86DecodedInsn *decod
 VSIB_AVX(VPGATHERD, vpgatherd)
 VSIB_AVX(VPGATHERQ, vpgatherq)
 
+/* ADCX/ADOX do not have memory operands and can use set_cc_op.  */
 static void gen_ADCOX(DisasContext *s, CPUX86State *env, MemOp ot, int cc_op)
 {
     int opposite_cc_op;
@@ -1073,8 +1080,7 @@ static void gen_ANDN(DisasContext *s, CPUX86State *env, X86DecodedInsn *decode)
     MemOp ot = decode->op[0].ot;
 
     tcg_gen_andc_tl(s->T0, s->T1, s->T0);
-    gen_op_update1_cc(s);
-    set_cc_op(s, CC_OP_LOGICB + ot);
+    prepare_update1_cc(decode, s, CC_OP_LOGICB + ot);
 }
 
 static void gen_BEXTR(DisasContext *s, CPUX86State *env, X86DecodedInsn *decode)
@@ -1105,10 +1111,10 @@ static void gen_BEXTR(DisasContext *s, CPUX86State *env, X86DecodedInsn *decode)
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
@@ -1120,6 +1126,7 @@ static void gen_BLSI(DisasContext *s, CPUX86State *env, X86DecodedInsn *decode)
     set_cc_op(s, CC_OP_BMILGB + ot);
 }
 
+/* BLSMSK do not have memory operands and can use set_cc_op.  */
 static void gen_BLSMSK(DisasContext *s, CPUX86State *env, X86DecodedInsn *decode)
 {
     MemOp ot = decode->op[0].ot;
@@ -1131,6 +1138,7 @@ static void gen_BLSMSK(DisasContext *s, CPUX86State *env, X86DecodedInsn *decode
     set_cc_op(s, CC_OP_BMILGB + ot);
 }
 
+/* BLSR do not have memory operands and can use set_cc_op.  */
 static void gen_BLSR(DisasContext *s, CPUX86State *env, X86DecodedInsn *decode)
 {
     MemOp ot = decode->op[0].ot;
@@ -1161,8 +1169,7 @@ static void gen_BZHI(DisasContext *s, CPUX86State *env, X86DecodedInsn *decode)
     tcg_gen_movcond_tl(TCG_COND_LEU, s->A0, s->T1, bound, s->A0, zero);
     tcg_gen_andc_tl(s->T0, s->T0, s->A0);
 
-    gen_op_update1_cc(s);
-    set_cc_op(s, CC_OP_BMILGB + ot);
+    prepare_update1_cc(decode, s, CC_OP_BMILGB + ot);
 }
 
 static void gen_CRC32(DisasContext *s, CPUX86State *env, X86DecodedInsn *decode)
diff --git a/tests/tcg/i386/Makefile.target b/tests/tcg/i386/Makefile.target
index fdf757c6ce4..ca0f543ef16 100644
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
2.41.0



Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8977281CE5A
	for <lists+qemu-devel@lfdr.de>; Fri, 22 Dec 2023 19:18:08 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rGk4t-0001DF-QU; Fri, 22 Dec 2023 13:16:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rGk4r-00018A-9J
 for qemu-devel@nongnu.org; Fri, 22 Dec 2023 13:16:53 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rGk4p-0006FC-AD
 for qemu-devel@nongnu.org; Fri, 22 Dec 2023 13:16:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1703269010;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=MJ0M6fhrf5bsr/kfBeBC+k3TBEZSJGaPg9IAXOelWDc=;
 b=EpXL6Ilf/3yl+eTNfCgU0ICmDQ4yHxFsu41+CP5xCgEJ3iBzk381sZPOnlRaUYbp0BLosw
 9rsDTIgKPtYqHbpxLmBOJ5ezbyk1QfAnN3XCLmnevb4ZQ16YgezyXPSkbdUxIpQXwbeJP1
 cpfmizTmcEErQdXqmDa7v6aQP5559cQ=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-215-r-mhGzSiNcyDmGr-K3X4bg-1; Fri, 22 Dec 2023 13:16:49 -0500
X-MC-Unique: r-mhGzSiNcyDmGr-K3X4bg-1
Received: by mail-ed1-f69.google.com with SMTP id
 4fb4d7f45d1cf-5544081d7d0so715641a12.0
 for <qemu-devel@nongnu.org>; Fri, 22 Dec 2023 10:16:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703269006; x=1703873806;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=MJ0M6fhrf5bsr/kfBeBC+k3TBEZSJGaPg9IAXOelWDc=;
 b=DmZswuysPe9p93aQ6FTdyoo9W5hGTaOQwDiSLRt1BtcM7yNUtWHLGbeXMSB+AFNrUg
 JJYGFUtKx3hh2TMyI2FMSv0zu0p9jnzFH2yBHuh6k0xXRIFiSyXd6WP/P+FFPujeiFTK
 uKweKgwEI4tEiFdyU5JpMnM60mNbzRYV2+CKPVWNVZaNSdDgN0L7opupQLj1rDwU4NNX
 NDtsGyqn3Z+99VWhow1AJ6wCE56Slp6EO/5V2aPcj+HC2/ZAbhCWXGNd2fyHTGOgBg0V
 cTWOF13KgSFkJ1q502yYBQrHyBN1ztTx6nPgrcCwPLlbPjLVEUvtq3esne7gQd7+dLee
 WLkg==
X-Gm-Message-State: AOJu0Yy4sZKfH4HRdqSNNk3mDKwJeQU48JogHRzE5uzjB49xgjU62iOM
 bqBdpUFMnbS6WmWdvzNYTynxkfBgydJetuOtFFhdlTAfY+NcZNWjhG3F0BhAHTPU/+jnPpgVTbV
 UNnBef3pKxCt6CgS6YhAIlu4eSJZYbhJf6zm/MAEnG7/94DS2a8Epr+nuLUvO2Yid0JTOXk8pT8
 kJK7eh1r8=
X-Received: by 2002:a05:6402:216:b0:552:e599:9906 with SMTP id
 t22-20020a056402021600b00552e5999906mr636859edv.44.1703269006347; 
 Fri, 22 Dec 2023 10:16:46 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHbODYhDcW6ycAEQUYGEhQlmB1nKm/zcbiRigcSvU4KSJN9xtjS4N/2smAQ2UJ/IWplHmpnYg==
X-Received: by 2002:a05:6402:216:b0:552:e599:9906 with SMTP id
 t22-20020a056402021600b00552e5999906mr636854edv.44.1703269005886; 
 Fri, 22 Dec 2023 10:16:45 -0800 (PST)
Received: from [192.168.10.118] ([2001:b07:6468:f312:9af8:e5f5:7516:fa89])
 by smtp.gmail.com with ESMTPSA id
 er18-20020a056402449200b005547a4083e5sm212934edb.58.2023.12.22.10.16.44
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 22 Dec 2023 10:16:44 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 21/22] target/i386: introduce flags writeback mechanism
Date: Fri, 22 Dec 2023 19:16:02 +0100
Message-ID: <20231222181603.174137-22-pbonzini@redhat.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231222181603.174137-1-pbonzini@redhat.com>
References: <20231222181603.174137-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.082,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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



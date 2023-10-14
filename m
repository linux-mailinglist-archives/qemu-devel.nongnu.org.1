Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D5BE47C9407
	for <lists+qemu-devel@lfdr.de>; Sat, 14 Oct 2023 12:04:11 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qrbTC-0002Zx-LM; Sat, 14 Oct 2023 06:02:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qrbSy-0002XT-IW
 for qemu-devel@nongnu.org; Sat, 14 Oct 2023 06:01:52 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qrbSw-00040b-NR
 for qemu-devel@nongnu.org; Sat, 14 Oct 2023 06:01:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697277710;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8hohIRvPlKdJT0/tu7GTJ1kx0e209rVbYCFaLzlLVq8=;
 b=Gd1qQCrsQV1q8BnJCDSPI3T8Zug/ljrzREdJ1JLxf3SkQuu42EaPONuAFE4DvZkCiYScvi
 zJk+51ef6u83IO+2nPR7JcPDGWxzLq6Sc1EZ1nqF986rl56S6xrJ7Py68pd+++LP6UJd5r
 jjnYeBJQtA9vuWX/wXKF24FG9FD4Y38=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-504-_gcjrJudPhmNoc4F7nmHgg-1; Sat, 14 Oct 2023 06:01:38 -0400
X-MC-Unique: _gcjrJudPhmNoc4F7nmHgg-1
Received: by mail-ed1-f70.google.com with SMTP id
 4fb4d7f45d1cf-53e26bbbc63so1701676a12.3
 for <qemu-devel@nongnu.org>; Sat, 14 Oct 2023 03:01:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697277696; x=1697882496;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=8hohIRvPlKdJT0/tu7GTJ1kx0e209rVbYCFaLzlLVq8=;
 b=rgcKIBGHibtMokyBimlKZePWYsWUuXke9Q/3vDj18jKdxJPhKV0YhXGtXATwnRW9qT
 O4BPVaDCQEW6k/UkdQggywzh6wm+DZT7P9NVv1PhdgNMbPtreYLMicjIAAohnJdWPcN8
 uoVYzn8GInh9ms1SuqPHUMF1d9hiNsi3bF7Rx5kuzcc1qbRPo2B1imO09IggkhwgSPp/
 rsl2ARjVdquC8nW/Qk4NzOIPNrHVAqgyeIiv+j5pTJ0UTSk0Yo6fUPoZmTWLQOPoqa6Q
 cM5q0BVDiOCb0B1g0MZfhIJ48iOkW+7uSdQ8yYoXjScCaQXAlbW/K02GSKZOqFPcnUs4
 g5Mw==
X-Gm-Message-State: AOJu0Yy/5Xcx55uywyi5qTSXpMAy13NA3nhLzIl87PIR1NiVuvLQuwcE
 pL3Y/pKi6v0JwMGq073nUqn+CM/D2WxTcD5LGH+X6EaiFbSn0dKYOQP51+Xd/BD0SuPn0jOc+9w
 sBKRFzLKecg69VuEPyzI5slZ+BFidq7zN0qm7EmMMe67uQOyVffMG0roM7+TG7NaQf9W6XL2L13
 Y=
X-Received: by 2002:aa7:c998:0:b0:527:ab3f:4350 with SMTP id
 c24-20020aa7c998000000b00527ab3f4350mr25290594edt.38.1697277696418; 
 Sat, 14 Oct 2023 03:01:36 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEGzkvGbUYp6PH4wRMV5+Eyk3GnLUZvCJYHCUdYFpOF33Y3bA0ErJ8G/uG3RRDGZyUVht2tZA==
X-Received: by 2002:aa7:c998:0:b0:527:ab3f:4350 with SMTP id
 c24-20020aa7c998000000b00527ab3f4350mr25290580edt.38.1697277695960; 
 Sat, 14 Oct 2023 03:01:35 -0700 (PDT)
Received: from [192.168.10.118] ([2001:b07:6468:f312:5e2c:eb9a:a8b6:fd3e])
 by smtp.gmail.com with ESMTPSA id
 f26-20020a50ee9a000000b0052e1783ab25sm12594946edr.70.2023.10.14.03.01.34
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 14 Oct 2023 03:01:35 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 07/18] target/i386: introduce flags writeback mechanism
Date: Sat, 14 Oct 2023 12:01:09 +0200
Message-ID: <20231014100121.109817-8-pbonzini@redhat.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231014100121.109817-1-pbonzini@redhat.com>
References: <20231014100121.109817-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
 target/i386/tcg/decode-new.c.inc | 20 +++++++++++++++++
 target/i386/tcg/decode-new.h     |  2 ++
 target/i386/tcg/emit.c.inc       | 15 +++++++------
 tests/tcg/i386/Makefile.target   |  2 +-
 tests/tcg/i386/test-flags.c      | 37 ++++++++++++++++++++++++++++++++
 5 files changed, 69 insertions(+), 7 deletions(-)
 create mode 100644 tests/tcg/i386/test-flags.c

diff --git a/target/i386/tcg/decode-new.c.inc b/target/i386/tcg/decode-new.c.inc
index eb2400095f8..bad561ff66d 100644
--- a/target/i386/tcg/decode-new.c.inc
+++ b/target/i386/tcg/decode-new.c.inc
@@ -1943,6 +1943,26 @@ static void disas_insn_new(DisasContext *s, CPUState *cpu, int b)
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
+    if (decode.cc_dst) {
+        tcg_gen_mov_tl(cpu_cc_dst, decode.cc_dst);
+    }
+    if (decode.cc_src) {
+        tcg_gen_mov_tl(cpu_cc_src, decode.cc_src);
+    }
+    if (decode.cc_src2) {
+        tcg_gen_mov_tl(cpu_cc_src, decode.cc_src2);
+    }
+    if (decode.cc_srcT) {
+        tcg_gen_mov_tl(s->cc_srcT, decode.cc_srcT);
+    }
+
     return;
  gp_fault:
     gen_exception_gpf(s);
diff --git a/target/i386/tcg/decode-new.h b/target/i386/tcg/decode-new.h
index ab21fa6db97..b2879136614 100644
--- a/target/i386/tcg/decode-new.h
+++ b/target/i386/tcg/decode-new.h
@@ -265,6 +265,8 @@ struct X86DecodedInsn {
     target_ulong immediate;
     AddressParts mem;
 
+    TCGv cc_dst, cc_src, cc_src2, cc_srcT;
+
     uint8_t b;
 };
 
diff --git a/target/i386/tcg/emit.c.inc b/target/i386/tcg/emit.c.inc
index 82da5488d47..b5dfdc409e5 100644
--- a/target/i386/tcg/emit.c.inc
+++ b/target/i386/tcg/emit.c.inc
@@ -323,6 +323,12 @@ static inline int vector_len(DisasContext *s, X86DecodedInsn *decode)
     return s->vex_l ? 32 : 16;
 }
 
+static void prepare_update1_cc(X86DecodedInsn *decode, DisasContext *s, CCOp op)
+{
+    decode->cc_dst = s->T0;
+    set_cc_op(s, op);
+}
+
 static void gen_store_sse(DisasContext *s, X86DecodedInsn *decode, int src_ofs)
 {
     MemOp ot = decode->op[0].ot;
@@ -1073,8 +1079,7 @@ static void gen_ANDN(DisasContext *s, CPUX86State *env, X86DecodedInsn *decode)
     MemOp ot = decode->op[0].ot;
 
     tcg_gen_andc_tl(s->T0, s->T1, s->T0);
-    gen_op_update1_cc(s);
-    set_cc_op(s, CC_OP_LOGICB + ot);
+    prepare_update1_cc(decode, s, CC_OP_LOGICB + ot);
 }
 
 static void gen_BEXTR(DisasContext *s, CPUX86State *env, X86DecodedInsn *decode)
@@ -1105,8 +1110,7 @@ static void gen_BEXTR(DisasContext *s, CPUX86State *env, X86DecodedInsn *decode)
     tcg_gen_movcond_tl(TCG_COND_LEU, s->T1, s->A0, bound, s->T1, zero);
     tcg_gen_andc_tl(s->T0, s->T0, s->T1);
 
-    gen_op_update1_cc(s);
-    set_cc_op(s, CC_OP_LOGICB + ot);
+    prepare_update1_cc(decode, s, CC_OP_LOGICB + ot);
 }
 
 static void gen_BLSI(DisasContext *s, CPUX86State *env, X86DecodedInsn *decode)
@@ -1161,8 +1165,7 @@ static void gen_BZHI(DisasContext *s, CPUX86State *env, X86DecodedInsn *decode)
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



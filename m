Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DA9247CF5AC
	for <lists+qemu-devel@lfdr.de>; Thu, 19 Oct 2023 12:49:37 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qtQZ7-0006aH-Ks; Thu, 19 Oct 2023 06:47:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qtQYe-0006ZK-9F
 for qemu-devel@nongnu.org; Thu, 19 Oct 2023 06:47:17 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qtQYb-0006Eb-Ut
 for qemu-devel@nongnu.org; Thu, 19 Oct 2023 06:47:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697712433;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Fs52DQNF+J/9BPIlJPJYQ1L0iEAJSlKjoPIFBlxq3fc=;
 b=Fd5cElitrZPBelL4I0kYvjfB5uNM7ZB8b9l78oqbIBw8ZnpWmoRHCxI/w/5KMCfCYr49rI
 QwSweCv3LCe+bO/sOaGoN9rWHddYZPTPAXo1MpYWm4psX05N/bkeIj/LmSYaEuUznJ3ICz
 P8uDZJgWQOzbi9EgHlxp2uJJ8zCW8iY=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-689-pd-I7VzeOnCgctvoo2GU8w-1; Thu, 19 Oct 2023 06:47:12 -0400
X-MC-Unique: pd-I7VzeOnCgctvoo2GU8w-1
Received: by mail-ej1-f69.google.com with SMTP id
 a640c23a62f3a-9b98d8f6bafso581872666b.1
 for <qemu-devel@nongnu.org>; Thu, 19 Oct 2023 03:47:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697712430; x=1698317230;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Fs52DQNF+J/9BPIlJPJYQ1L0iEAJSlKjoPIFBlxq3fc=;
 b=gm+YkoFC1wQrEhcQoYRYhlHCRmpdKrgsbRJFCHmp9XDLu2dmDigSXy49fYUv70sjDI
 og/PqvCHUKsz7QyF9XaIqrkMEHs6xpdJkVe+p6LUU90x7tStafDtpvI9PYUIOVgI5muN
 0XX3S7koao/385Y4UxSb242WfOj/ufq5JCc8vW7N864N3gX5LAO2C6j9WToGt/O5gg/K
 yXGJfABWaAKX9RS+2wGkwsRGAs6znfEYjUP5yQIw3ckC10+8OrQGxsgiCWxWUapKCzj5
 2WI+qBUcrKqSI1uCYbTYvpwkXj3/89RHSQw9sbaPPo/iHFVYWfm6LrtXKsevvf1ZFFCp
 +MIA==
X-Gm-Message-State: AOJu0Yxzz7VzP1zYCOzAVSnEeSeiPN+awxykLAWJsW3iSHF6VcApbEqb
 tNR0dXcbf2H6NZfTKmMFSfElJaNN9wpXbCWj/h5wOc2fTr5BiChumdzwdifpdgJ7DSiv73wQzRe
 Wh/lpLHO6sKQI6SccrY/odcWi5049unW1R+Dd57hAs/eKB2k6t0L69cwb8T0UsxLJMe7hIiiA25
 o=
X-Received: by 2002:a17:907:9705:b0:9c4:b8c9:1bf4 with SMTP id
 jg5-20020a170907970500b009c4b8c91bf4mr1217132ejc.19.1697712430262; 
 Thu, 19 Oct 2023 03:47:10 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEXMctjGLvY8RcFqetHIfJEqs9hfJYFI7VeDANlLj8akGiia9NBJ+q4bbUsTJAPHrCZAIT8Jw==
X-Received: by 2002:a17:907:9705:b0:9c4:b8c9:1bf4 with SMTP id
 jg5-20020a170907970500b009c4b8c91bf4mr1217108ejc.19.1697712429554; 
 Thu, 19 Oct 2023 03:47:09 -0700 (PDT)
Received: from [192.168.10.118] ([2001:b07:6468:f312:5e2c:eb9a:a8b6:fd3e])
 by smtp.gmail.com with ESMTPSA id
 bu23-20020a170906a15700b009b2c5363ebasm3339894ejb.26.2023.10.19.03.47.08
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Oct 2023 03:47:08 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 11/19] target/i386: move 00-5F opcodes to new decoder
Date: Thu, 19 Oct 2023 12:46:40 +0200
Message-ID: <20231019104648.389942-12-pbonzini@redhat.com>
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

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/tcg/decode-new.c.inc | 116 ++++++++++++++++++
 target/i386/tcg/decode-new.h     |   3 +
 target/i386/tcg/emit.c.inc       | 203 +++++++++++++++++++++++++++++++
 target/i386/tcg/translate.c      |   2 +-
 4 files changed, 323 insertions(+), 1 deletion(-)

diff --git a/target/i386/tcg/decode-new.c.inc b/target/i386/tcg/decode-new.c.inc
index 2f614e2a6f0..dc596ba9f7a 100644
--- a/target/i386/tcg/decode-new.c.inc
+++ b/target/i386/tcg/decode-new.c.inc
@@ -102,6 +102,8 @@
 
 #define X86_OP_GROUP2(op, op0, s0, op1, s1, ...)                  \
     X86_OP_GROUP3(op, op0, s0, 2op, s0, op1, s1, ## __VA_ARGS__)
+#define X86_OP_GROUPw(op, op0, s0, ...)                           \
+    X86_OP_GROUP3(op, op0, s0, None, None, None, None, ## __VA_ARGS__)
 #define X86_OP_GROUP0(op, ...)                                    \
     X86_OP_GROUP3(op, None, None, None, None, None, None, ## __VA_ARGS__)
 
@@ -127,10 +129,13 @@
     X86_OP_ENTRY3(op, op0, s0, None, None, None, None, ## __VA_ARGS__)
 #define X86_OP_ENTRYr(op, op0, s0, ...)                           \
     X86_OP_ENTRY3(op, None, None, None, None, op0, s0, ## __VA_ARGS__)
+#define X86_OP_ENTRY1(op, op0, s0, ...)                           \
+    X86_OP_ENTRY3(op, op0, s0, 2op, s0, None, None, ## __VA_ARGS__)
 #define X86_OP_ENTRY0(op, ...)                                    \
     X86_OP_ENTRY3(op, None, None, None, None, None, None, ## __VA_ARGS__)
 
 #define cpuid(feat) .cpuid = X86_FEAT_##feat,
+#define nowb .special = X86_SPECIAL_NoWriteback,
 #define xchg .special = X86_SPECIAL_Locked,
 #define mmx .special = X86_SPECIAL_MMX,
 #define zext0 .special = X86_SPECIAL_ZExtOp0,
@@ -1074,7 +1079,114 @@ static void decode_0F(DisasContext *s, CPUX86State *env, X86OpEntry *entry, uint
 }
 
 static const X86OpEntry opcodes_root[256] = {
+    [0x00] = X86_OP_ENTRY2(ADD, E,b, G,b),
+    [0x01] = X86_OP_ENTRY2(ADD, E,v, G,v),
+    [0x02] = X86_OP_ENTRY2(ADD, G,b, E,b),
+    [0x03] = X86_OP_ENTRY2(ADD, G,v, E,v),
+    [0x04] = X86_OP_ENTRY2(ADD, 0,b, I,b),   /* AL, Ib */
+    [0x05] = X86_OP_ENTRY2(ADD, 0,v, I,z),   /* rAX, Iz */
+    [0x06] = X86_OP_ENTRYr(PUSH, ES, w, chk(i64)),
+    [0x07] = X86_OP_ENTRYw(POP, ES, w, chk(i64)),
+
+    [0x10] = X86_OP_ENTRY2(ADC, E,b, G,b),
+    [0x11] = X86_OP_ENTRY2(ADC, E,v, G,v),
+    [0x12] = X86_OP_ENTRY2(ADC, G,b, E,b),
+    [0x13] = X86_OP_ENTRY2(ADC, G,v, E,v),
+    [0x14] = X86_OP_ENTRY2(ADC, 0,b, I,b),   /* AL, Ib */
+    [0x15] = X86_OP_ENTRY2(ADC, 0,v, I,z),   /* rAX, Iz */
+    [0x16] = X86_OP_ENTRYr(PUSH, SS, w, chk(i64)),
+    [0x17] = X86_OP_ENTRYw(POP, SS, w, chk(i64)),
+
+    [0x20] = X86_OP_ENTRY2(AND, E,b, G,b),
+    [0x21] = X86_OP_ENTRY2(AND, E,v, G,v),
+    [0x22] = X86_OP_ENTRY2(AND, G,b, E,b),
+    [0x23] = X86_OP_ENTRY2(AND, G,v, E,v),
+    [0x24] = X86_OP_ENTRY2(AND, 0,b, I,b),   /* AL, Ib */
+    [0x25] = X86_OP_ENTRY2(AND, 0,v, I,z),   /* rAX, Iz */
+    [0x26] = {},
+    [0x27] = X86_OP_ENTRY0(DAA, chk(i64)),
+
+    [0x30] = X86_OP_ENTRY2(XOR, E,b, G,b),
+    [0x31] = X86_OP_ENTRY2(XOR, E,v, G,v),
+    [0x32] = X86_OP_ENTRY2(XOR, G,b, E,b),
+    [0x33] = X86_OP_ENTRY2(XOR, G,v, E,v),
+    [0x34] = X86_OP_ENTRY2(XOR, 0,b, I,b),   /* AL, Ib */
+    [0x35] = X86_OP_ENTRY2(XOR, 0,v, I,z),   /* rAX, Iz */
+    [0x36] = {},
+    [0x37] = X86_OP_ENTRY0(AAA, chk(i64)),
+
+    [0x40] = X86_OP_ENTRY1(INC, 0,v, chk(i64)),
+    [0x41] = X86_OP_ENTRY1(INC, 1,v, chk(i64)),
+    [0x42] = X86_OP_ENTRY1(INC, 2,v, chk(i64)),
+    [0x43] = X86_OP_ENTRY1(INC, 3,v, chk(i64)),
+    [0x44] = X86_OP_ENTRY1(INC, 4,v, chk(i64)),
+    [0x45] = X86_OP_ENTRY1(INC, 5,v, chk(i64)),
+    [0x46] = X86_OP_ENTRY1(INC, 6,v, chk(i64)),
+    [0x47] = X86_OP_ENTRY1(INC, 7,v, chk(i64)),
+
+    [0x50] = X86_OP_ENTRYr(PUSH, LoBits,d64),
+    [0x51] = X86_OP_ENTRYr(PUSH, LoBits,d64),
+    [0x52] = X86_OP_ENTRYr(PUSH, LoBits,d64),
+    [0x53] = X86_OP_ENTRYr(PUSH, LoBits,d64),
+    [0x54] = X86_OP_ENTRYr(PUSH, LoBits,d64),
+    [0x55] = X86_OP_ENTRYr(PUSH, LoBits,d64),
+    [0x56] = X86_OP_ENTRYr(PUSH, LoBits,d64),
+    [0x57] = X86_OP_ENTRYr(PUSH, LoBits,d64),
+
+
+    [0x08] = X86_OP_ENTRY2(OR, E,b, G,b),
+    [0x09] = X86_OP_ENTRY2(OR, E,v, G,v),
+    [0x0A] = X86_OP_ENTRY2(OR, G,b, E,b),
+    [0x0B] = X86_OP_ENTRY2(OR, G,v, E,v),
+    [0x0C] = X86_OP_ENTRY2(OR, 0,b, I,b),   /* AL, Ib */
+    [0x0D] = X86_OP_ENTRY2(OR, 0,v, I,z),   /* rAX, Iz */
+    [0x0E] = X86_OP_ENTRYr(PUSH, CS, w, chk(i64)),
     [0x0F] = X86_OP_GROUP0(0F),
+
+    [0x18] = X86_OP_ENTRY2(SBB, E,b, G,b),
+    [0x19] = X86_OP_ENTRY2(SBB, E,v, G,v),
+    [0x1A] = X86_OP_ENTRY2(SBB, G,b, E,b),
+    [0x1B] = X86_OP_ENTRY2(SBB, G,v, E,v),
+    [0x1C] = X86_OP_ENTRY2(SBB, 0,b, I,b),   /* AL, Ib */
+    [0x1D] = X86_OP_ENTRY2(SBB, 0,v, I,z),   /* rAX, Iz */
+    [0x1E] = X86_OP_ENTRYr(PUSH, DS, w, chk(i64)),
+    [0x1F] = X86_OP_ENTRYw(POP, DS, w, chk(i64)),
+
+    [0x28] = X86_OP_ENTRY2(SUB, E,b, G,b),
+    [0x29] = X86_OP_ENTRY2(SUB, E,v, G,v),
+    [0x2A] = X86_OP_ENTRY2(SUB, G,b, E,b),
+    [0x2B] = X86_OP_ENTRY2(SUB, G,v, E,v),
+    [0x2C] = X86_OP_ENTRY2(SUB, 0,b, I,b),   /* AL, Ib */
+    [0x2D] = X86_OP_ENTRY2(SUB, 0,v, I,z),   /* rAX, Iz */
+    [0x2E] = {},
+    [0x2F] = X86_OP_ENTRY0(DAS, chk(i64)),
+
+    [0x38] = X86_OP_ENTRY2(SUB, E,b, G,b, nowb),
+    [0x39] = X86_OP_ENTRY2(SUB, E,v, G,v, nowb),
+    [0x3A] = X86_OP_ENTRY2(SUB, G,b, E,b, nowb),
+    [0x3B] = X86_OP_ENTRY2(SUB, G,v, E,v, nowb),
+    [0x3C] = X86_OP_ENTRY2(SUB, 0,b, I,b, nowb),   /* AL, Ib */
+    [0x3D] = X86_OP_ENTRY2(SUB, 0,v, I,z, nowb),   /* rAX, Iz */
+    [0x3E] = {},
+    [0x3F] = X86_OP_ENTRY0(AAS, chk(i64)),
+
+    [0x48] = X86_OP_ENTRY1(DEC, 0,v, chk(i64)),
+    [0x49] = X86_OP_ENTRY1(DEC, 1,v, chk(i64)),
+    [0x4A] = X86_OP_ENTRY1(DEC, 2,v, chk(i64)),
+    [0x4B] = X86_OP_ENTRY1(DEC, 3,v, chk(i64)),
+    [0x4C] = X86_OP_ENTRY1(DEC, 4,v, chk(i64)),
+    [0x4D] = X86_OP_ENTRY1(DEC, 5,v, chk(i64)),
+    [0x4E] = X86_OP_ENTRY1(DEC, 6,v, chk(i64)),
+    [0x4F] = X86_OP_ENTRY1(DEC, 7,v, chk(i64)),
+
+    [0x58] = X86_OP_ENTRYw(POP, LoBits,d64),
+    [0x59] = X86_OP_ENTRYw(POP, LoBits,d64),
+    [0x5A] = X86_OP_ENTRYw(POP, LoBits,d64),
+    [0x5B] = X86_OP_ENTRYw(POP, LoBits,d64),
+    [0x5C] = X86_OP_ENTRYw(POP, LoBits,d64),
+    [0x5D] = X86_OP_ENTRYw(POP, LoBits,d64),
+    [0x5E] = X86_OP_ENTRYw(POP, LoBits,d64),
+    [0x5F] = X86_OP_ENTRYw(POP, LoBits,d64),
 };
 
 #undef mmx
@@ -1898,6 +2010,10 @@ static void disas_insn_new(DisasContext *s, CPUState *cpu, int b)
         }
         break;
 
+    case X86_SPECIAL_NoWriteback:
+        decode.op[0].unit = X86_OP_SKIP;
+        break;
+
     case X86_SPECIAL_ZExtOp0:
         assert(decode.op[0].unit == X86_OP_INT);
         if (!decode.op[0].has_ea) {
diff --git a/target/i386/tcg/decode-new.h b/target/i386/tcg/decode-new.h
index 15233fad62f..a3983794ac5 100644
--- a/target/i386/tcg/decode-new.h
+++ b/target/i386/tcg/decode-new.h
@@ -161,6 +161,9 @@ typedef enum X86InsnSpecial {
     /* Always locked if it has a memory operand (XCHG) */
     X86_SPECIAL_Locked,
 
+    /* Writeback not needed or done manually in the callback */
+    X86_SPECIAL_NoWriteback,
+
     /*
      * Register operand 0/2 is zero extended to 32 bits.  Rd/Mb or Rd/Mw
      * in the manual.
diff --git a/target/i386/tcg/emit.c.inc b/target/i386/tcg/emit.c.inc
index dd77a8c5511..6b9f518cc94 100644
--- a/target/i386/tcg/emit.c.inc
+++ b/target/i386/tcg/emit.c.inc
@@ -329,6 +329,27 @@ static void prepare_update1_cc(X86DecodedInsn *decode, DisasContext *s, CCOp op)
     decode->cc_op = op;
 }
 
+static void prepare_update2_cc(X86DecodedInsn *decode, DisasContext *s, CCOp op)
+{
+    decode->cc_src = s->T1;
+    decode->cc_dst = s->T0;
+    decode->cc_op = op;
+}
+
+static void prepare_update_cc_incdec(X86DecodedInsn *decode, DisasContext *s, CCOp op)
+{
+    gen_compute_eflags_c(s, s->T1);
+    prepare_update2_cc(decode, s, op);
+}
+
+static void prepare_update3_cc(X86DecodedInsn *decode, DisasContext *s, CCOp op, TCGv reg)
+{
+    decode->cc_src2 = reg;
+    decode->cc_src = s->T1;
+    decode->cc_dst = s->T0;
+    decode->cc_op = op;
+}
+
 static void gen_store_sse(DisasContext *s, X86DecodedInsn *decode, int src_ofs)
 {
     MemOp ot = decode->op[0].ot;
@@ -1017,6 +1038,36 @@ static void gen_##uname(DisasContext *s, CPUX86State *env, X86DecodedInsn *decod
 VSIB_AVX(VPGATHERD, vpgatherd)
 VSIB_AVX(VPGATHERQ, vpgatherq)
 
+static void gen_AAA(DisasContext *s, CPUX86State *env, X86DecodedInsn *decode)
+{
+    gen_update_cc_op(s);
+    gen_helper_aaa(tcg_env);
+    set_cc_op(s, CC_OP_EFLAGS);
+}
+
+static void gen_AAS(DisasContext *s, CPUX86State *env, X86DecodedInsn *decode)
+{
+    gen_update_cc_op(s);
+    gen_helper_aas(tcg_env);
+    set_cc_op(s, CC_OP_EFLAGS);
+}
+
+static void gen_ADC(DisasContext *s, CPUX86State *env, X86DecodedInsn *decode)
+{
+    MemOp ot = decode->op[0].ot;
+
+    gen_compute_eflags_c(s, s->tmp4);
+    if (s->prefix & PREFIX_LOCK) {
+        tcg_gen_add_tl(s->T0, s->tmp4, s->T1);
+        tcg_gen_atomic_add_fetch_tl(s->T0, s->A0, s->T0,
+                                    s->mem_index, ot | MO_LE);
+    } else {
+        tcg_gen_add_tl(s->T0, s->T0, s->T1);
+        tcg_gen_add_tl(s->T0, s->T0, s->tmp4);
+    }
+    prepare_update3_cc(decode, s, CC_OP_ADCB + ot, s->tmp4);
+}
+
 /* ADCX/ADOX do not have memory operands and can use set_cc_op.  */
 static void gen_ADCOX(DisasContext *s, CPUX86State *env, MemOp ot, int cc_op)
 {
@@ -1070,11 +1121,37 @@ static void gen_ADCX(DisasContext *s, CPUX86State *env, X86DecodedInsn *decode)
     gen_ADCOX(s, env, decode->op[0].ot, CC_OP_ADCX);
 }
 
+static void gen_ADD(DisasContext *s, CPUX86State *env, X86DecodedInsn *decode)
+{
+    MemOp ot = decode->op[0].ot;
+
+    if (s->prefix & PREFIX_LOCK) {
+        tcg_gen_atomic_add_fetch_tl(s->T0, s->A0, s->T1,
+                                    s->mem_index, ot | MO_LE);
+    } else {
+        tcg_gen_add_tl(s->T0, s->T0, s->T1);
+    }
+    prepare_update2_cc(decode, s, CC_OP_ADDB + ot);
+}
+
 static void gen_ADOX(DisasContext *s, CPUX86State *env, X86DecodedInsn *decode)
 {
     gen_ADCOX(s, env, decode->op[0].ot, CC_OP_ADOX);
 }
 
+static void gen_AND(DisasContext *s, CPUX86State *env, X86DecodedInsn *decode)
+{
+    MemOp ot = decode->op[0].ot;
+
+    if (s->prefix & PREFIX_LOCK) {
+        tcg_gen_atomic_and_fetch_tl(s->T0, s->A0, s->T1,
+                                    s->mem_index, ot | MO_LE);
+    } else {
+        tcg_gen_and_tl(s->T0, s->T0, s->T1);
+    }
+    prepare_update1_cc(decode, s, CC_OP_LOGICB + ot);
+}
+
 static void gen_ANDN(DisasContext *s, CPUX86State *env, X86DecodedInsn *decode)
 {
     MemOp ot = decode->op[0].ot;
@@ -1308,6 +1385,34 @@ static void gen_CVTTPx2PI(DisasContext *s, CPUX86State *env, X86DecodedInsn *dec
     }
 }
 
+static void gen_DAA(DisasContext *s, CPUX86State *env, X86DecodedInsn *decode)
+{
+    gen_update_cc_op(s);
+    gen_helper_daa(tcg_env);
+    set_cc_op(s, CC_OP_EFLAGS);
+}
+
+static void gen_DAS(DisasContext *s, CPUX86State *env, X86DecodedInsn *decode)
+{
+    gen_update_cc_op(s);
+    gen_helper_das(tcg_env);
+    set_cc_op(s, CC_OP_EFLAGS);
+}
+
+static void gen_DEC(DisasContext *s, CPUX86State *env, X86DecodedInsn *decode)
+{
+    MemOp ot = decode->op[0].ot;
+
+    tcg_gen_movi_tl(s->T1, -1);
+    if (s->prefix & PREFIX_LOCK) {
+        tcg_gen_atomic_add_fetch_tl(s->T0, s->A0, s->T1,
+                                    s->mem_index, ot | MO_LE);
+    } else {
+        tcg_gen_add_tl(s->T0, s->T0, s->T1);
+    }
+    prepare_update_cc_incdec(decode, s, CC_OP_DECB + ot);
+}
+
 static void gen_EMMS(DisasContext *s, CPUX86State *env, X86DecodedInsn *decode)
 {
     gen_helper_emms(tcg_env);
@@ -1326,6 +1431,20 @@ static void gen_EXTRQ_r(DisasContext *s, CPUX86State *env, X86DecodedInsn *decod
     gen_helper_extrq_r(tcg_env, OP_PTR0, OP_PTR2);
 }
 
+static void gen_INC(DisasContext *s, CPUX86State *env, X86DecodedInsn *decode)
+{
+    MemOp ot = decode->op[0].ot;
+
+    tcg_gen_movi_tl(s->T1, 1);
+    if (s->prefix & PREFIX_LOCK) {
+        tcg_gen_atomic_add_fetch_tl(s->T0, s->A0, s->T1,
+                                    s->mem_index, ot | MO_LE);
+    } else {
+        tcg_gen_add_tl(s->T0, s->T0, s->T1);
+    }
+    prepare_update_cc_incdec(decode, s, CC_OP_INCB + ot);
+}
+
 static void gen_INSERTQ_i(DisasContext *s, CPUX86State *env, X86DecodedInsn *decode)
 {
     TCGv_i32 length = tcg_constant_i32(decode->immediate & 63);
@@ -1477,6 +1596,19 @@ static void gen_MULX(DisasContext *s, CPUX86State *env, X86DecodedInsn *decode)
 
 }
 
+static void gen_OR(DisasContext *s, CPUX86State *env, X86DecodedInsn *decode)
+{
+    MemOp ot = decode->op[0].ot;
+
+    if (s->prefix & PREFIX_LOCK) {
+        tcg_gen_atomic_or_fetch_tl(s->T0, s->A0, s->T1,
+                                   s->mem_index, ot | MO_LE);
+    } else {
+        tcg_gen_or_tl(s->T0, s->T0, s->T1);
+    }
+    prepare_update1_cc(decode, s, CC_OP_LOGICB + ot);
+}
+
 static void gen_PALIGNR(DisasContext *s, CPUX86State *env, X86DecodedInsn *decode)
 {
     TCGv_i32 imm = tcg_constant8u_i32(decode->immediate);
@@ -1728,6 +1860,18 @@ static void gen_PMOVMSKB(DisasContext *s, CPUX86State *env, X86DecodedInsn *deco
     }
 }
 
+static void gen_POP(DisasContext *s, CPUX86State *env, X86DecodedInsn *decode)
+{
+    MemOp ot = gen_pop_T0(s);
+    if (decode->op[0].has_ea) {
+        /* NOTE: order is important for MMU exceptions */
+        gen_op_st_v(s, ot, s->T0, s->A0);
+        decode->op[0].unit = X86_OP_SKIP;
+    }
+    /* NOTE: writing back registers after update is important for pop %sp */
+    gen_pop_update(s, ot);
+}
+
 static void gen_PSHUFW(DisasContext *s, CPUX86State *env, X86DecodedInsn *decode)
 {
     TCGv_i32 imm = tcg_constant8u_i32(decode->immediate);
@@ -1874,6 +2018,11 @@ static void gen_PSLLDQ_i(DisasContext *s, CPUX86State *env, X86DecodedInsn *deco
     }
 }
 
+static void gen_PUSH(DisasContext *s, CPUX86State *env, X86DecodedInsn *decode)
+{
+    gen_push_v(s, s->T1);
+}
+
 static void gen_RORX(DisasContext *s, CPUX86State *env, X86DecodedInsn *decode)
 {
     MemOp ot = decode->op[0].ot;
@@ -1901,6 +2050,23 @@ static void gen_SARX(DisasContext *s, CPUX86State *env, X86DecodedInsn *decode)
     tcg_gen_sar_tl(s->T0, s->T0, s->T1);
 }
 
+static void gen_SBB(DisasContext *s, CPUX86State *env, X86DecodedInsn *decode)
+{
+    MemOp ot = decode->op[0].ot;
+
+    gen_compute_eflags_c(s, s->tmp4);
+    if (s->prefix & PREFIX_LOCK) {
+        tcg_gen_add_tl(s->T0, s->T1, s->tmp4);
+        tcg_gen_neg_tl(s->T0, s->T0);
+        tcg_gen_atomic_add_fetch_tl(s->T0, s->A0, s->T0,
+                                    s->mem_index, ot | MO_LE);
+    } else {
+        tcg_gen_sub_tl(s->T0, s->T0, s->T1);
+        tcg_gen_sub_tl(s->T0, s->T0, s->tmp4);
+    }
+    prepare_update3_cc(decode, s, CC_OP_SBBB + ot, s->tmp4);
+}
+
 static void gen_SHA1NEXTE(DisasContext *s, CPUX86State *env, X86DecodedInsn *decode)
 {
     gen_helper_sha1nexte(OP_PTR0, OP_PTR1, OP_PTR2);
@@ -1991,6 +2157,22 @@ static void gen_STMXCSR(DisasContext *s, CPUX86State *env, X86DecodedInsn *decod
     tcg_gen_ld32u_tl(s->T0, tcg_env, offsetof(CPUX86State, mxcsr));
 }
 
+static void gen_SUB(DisasContext *s, CPUX86State *env, X86DecodedInsn *decode)
+{
+    MemOp ot = decode->op[0].ot;
+
+    if (s->prefix & PREFIX_LOCK) {
+        tcg_gen_neg_tl(s->T0, s->T1);
+        tcg_gen_atomic_fetch_add_tl(s->cc_srcT, s->A0, s->T0,
+                                    s->mem_index, ot | MO_LE);
+        tcg_gen_sub_tl(s->T0, s->cc_srcT, s->T1);
+    } else {
+        tcg_gen_mov_tl(s->cc_srcT, s->T0);
+        tcg_gen_sub_tl(s->T0, s->T0, s->T1);
+    }
+    prepare_update2_cc(decode, s, CC_OP_SUBB + ot);
+}
+
 static void gen_VAESIMC(DisasContext *s, CPUX86State *env, X86DecodedInsn *decode)
 {
     assert(!s->vex_l);
@@ -2470,3 +2652,24 @@ static void gen_VZEROUPPER(DisasContext *s, CPUX86State *env, X86DecodedInsn *de
         tcg_gen_gvec_dup_imm(MO_64, offset, 16, 16, 0);
     }
 }
+
+static void gen_XOR(DisasContext *s, CPUX86State *env, X86DecodedInsn *decode)
+{
+    /* special case XOR reg, reg */
+    if (decode->op[1].unit == X86_OP_INT &&
+        decode->op[2].unit == X86_OP_INT &&
+        decode->op[1].n == decode->op[2].n) {
+        tcg_gen_movi_tl(s->T0, 0);
+        set_cc_op(s, CC_OP_CLR);
+    } else {
+        MemOp ot = decode->op[0].ot;
+
+        if (s->prefix & PREFIX_LOCK) {
+            tcg_gen_atomic_xor_fetch_tl(s->T0, s->A0, s->T1,
+                                        s->mem_index, ot | MO_LE);
+        } else {
+            tcg_gen_xor_tl(s->T0, s->T0, s->T1);
+        }
+        prepare_update1_cc(decode, s, CC_OP_LOGICB + ot);
+    }
+}
diff --git a/target/i386/tcg/translate.c b/target/i386/tcg/translate.c
index 080b56840da..e13bf7df591 100644
--- a/target/i386/tcg/translate.c
+++ b/target/i386/tcg/translate.c
@@ -3156,7 +3156,7 @@ static bool disas_insn(DisasContext *s, CPUState *cpu)
 #ifndef CONFIG_USER_ONLY
         use_new &= b <= limit;
 #endif
-        if (use_new && 0) {
+        if (use_new && b <= 0x5f) {
             disas_insn_new(s, cpu, b);
             return true;
         }
-- 
2.41.0



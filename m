Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B5FC27CF5A4
	for <lists+qemu-devel@lfdr.de>; Thu, 19 Oct 2023 12:48:37 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qtQZg-00017Z-4r; Thu, 19 Oct 2023 06:48:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qtQZd-00016g-TI
 for qemu-devel@nongnu.org; Thu, 19 Oct 2023 06:48:17 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qtQZa-00074F-H5
 for qemu-devel@nongnu.org; Thu, 19 Oct 2023 06:48:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697712493;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=NQvy7syiiufOxfPqDD9L59bp8SqwN2e9iIHVz8xvPLQ=;
 b=Pi+ATD5L/FnVj4L/fyagj6zzGCayrlAjxOS/zqNnLgjIBDCuiAU/gpLadKfmjabV2B5lIR
 o935/ZgI6OS6dDs5Set4CswaCk4QMQSWmG0O+KDhb8zTjU5fglfnmXiQ/X1ZYP5cvQrdDq
 8IOr03fHZElWsC48Aiq56ZplQWC4Z5w=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-453-gQes3ku-PzaUoGuIhBmgOw-1; Thu, 19 Oct 2023 06:48:12 -0400
X-MC-Unique: gQes3ku-PzaUoGuIhBmgOw-1
Received: by mail-ej1-f70.google.com with SMTP id
 a640c23a62f3a-9b274cc9636so578027666b.0
 for <qemu-devel@nongnu.org>; Thu, 19 Oct 2023 03:48:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697712490; x=1698317290;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=NQvy7syiiufOxfPqDD9L59bp8SqwN2e9iIHVz8xvPLQ=;
 b=PR9slGdplqW7H/A1SYNc0ZagQB7HQKx6qidWW/fDzdA3HuXcL2hKYMDtVjBf6zqo4L
 8j7BLMOm3aCYmLJ6BReBQrUggz3/gWPGyqcDcdSS3jdiL/sUI3BxeFg/l52/mz+IZ3fD
 OvGJzts35WQXbXxYKQbxgA895bpMyqSESkkQFCyy8c5S1rNDAvCcM6onwlPWytVeEGLm
 agOW1UFOpWzIMmKoR/xXpBDUwGxd7+vnK5U2jx51omuqngA6asqTaz6ED73D5+r8FDKc
 FvlnZhiXf8SdcmJFmXLQyX8dUCUCBYCgMUZfl1ZusWg6TFicYPsqKhKGpsT2mxqiLtqq
 dJKg==
X-Gm-Message-State: AOJu0YxKJIDegKJfqzaLiZiglZO1WDlCayvN5kImw3CTCPf0JzIy2Hlc
 QLqtdhhm1itjX38HsDE/kvr72739Fyj3AFwHuIBpkRTdwgiuhFxAhu+au2+lhtpHB8pCe/TRBoc
 MnU8JFSAg7WdXWqa+oWMaGixoIXcXKtSxtrV47/o6SgGDMxlqgy91F53VpbIyucg8h31Wz54R4P
 I=
X-Received: by 2002:a17:907:783:b0:9b2:d554:da0e with SMTP id
 xd3-20020a170907078300b009b2d554da0emr1524700ejb.69.1697712490169; 
 Thu, 19 Oct 2023 03:48:10 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHyU/02DRMWqVZWxjKI0WmtveDhlo6H7mj0fXvqJEEi2yWmUE4IqMiCCoE2CeEowG46QUwh6g==
X-Received: by 2002:a17:907:783:b0:9b2:d554:da0e with SMTP id
 xd3-20020a170907078300b009b2d554da0emr1524673ejb.69.1697712489298; 
 Thu, 19 Oct 2023 03:48:09 -0700 (PDT)
Received: from [192.168.10.118] ([2001:b07:6468:f312:5e2c:eb9a:a8b6:fd3e])
 by smtp.gmail.com with ESMTPSA id
 p9-20020a17090635c900b009ad8796a6aesm3284055ejb.56.2023.10.19.03.48.08
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Oct 2023 03:48:08 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 15/19] target/i386: move 60-BF opcodes to new decoder
Date: Thu, 19 Oct 2023 12:48:03 +0200
Message-ID: <20231019104807.390468-1-pbonzini@redhat.com>
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
 target/i386/tcg/decode-new.c.inc | 157 ++++++++++++++
 target/i386/tcg/decode-new.h     |   3 +
 target/i386/tcg/emit.c.inc       | 355 ++++++++++++++++++++++++++++++-
 target/i386/tcg/translate.c      |  38 ++--
 4 files changed, 536 insertions(+), 17 deletions(-)

diff --git a/target/i386/tcg/decode-new.c.inc b/target/i386/tcg/decode-new.c.inc
index 1ae731459b7..d0baf972208 100644
--- a/target/i386/tcg/decode-new.c.inc
+++ b/target/i386/tcg/decode-new.c.inc
@@ -136,6 +136,7 @@
 
 #define cpuid(feat) .cpuid = X86_FEAT_##feat,
 #define nowb .special = X86_SPECIAL_NoWriteback,
+#define noseg .special = X86_SPECIAL_NoSeg,
 #define xchg .special = X86_SPECIAL_Locked,
 #define mmx .special = X86_SPECIAL_MMX,
 #define zext0 .special = X86_SPECIAL_ZExtOp0,
@@ -179,6 +180,9 @@
 #define p_66_f3_f2    .valid_prefix = P_66 | P_F3 | P_F2,
 #define p_00_66_f3_f2 .valid_prefix = P_00 | P_66 | P_F3 | P_F2,
 
+static X86OpEntry illegal_opcode =
+    X86_OP_ENTRY0(illegal);
+
 static uint8_t get_modrm(DisasContext *s, CPUX86State *env)
 {
     if (!s->has_modrm) {
@@ -1078,6 +1082,46 @@ static void decode_0F(DisasContext *s, CPUX86State *env, X86OpEntry *entry, uint
     do_decode_0F(s, env, entry, b);
 }
 
+static void decode_63(DisasContext *s, CPUX86State *env, X86OpEntry *entry, uint8_t *b)
+{
+    static const X86OpEntry arpl = X86_OP_ENTRY2(ARPL, E,w, G,w, chk(prot));
+    static const X86OpEntry mov = X86_OP_ENTRY3(MOV, G,v, E,v, None, None);
+    static const X86OpEntry movsxd = X86_OP_ENTRY3(MOVSXD, G,v, E,d, None, None);
+    if (!CODE64(s)) {
+        *entry = arpl;
+    } else if (REX_W(s)) {
+        *entry = movsxd;
+    } else {
+        *entry = mov;
+    }
+}
+
+static void decode_group1(DisasContext *s, CPUX86State *env, X86OpEntry *entry, uint8_t *b)
+{
+    static const X86GenFunc group1_gen[8] = {
+        gen_ADD, gen_OR, gen_ADC, gen_SBB, gen_AND, gen_SUB, gen_XOR, gen_SUB,
+    };
+    int op = (get_modrm(s, env) >> 3) & 7;
+    entry->gen = group1_gen[op];
+
+    if (op == 7) {
+        /* CMP */
+        entry->special = X86_SPECIAL_NoWriteback;
+    }
+}
+
+static void decode_group1A(DisasContext *s, CPUX86State *env, X86OpEntry *entry, uint8_t *b)
+{
+    int op = (get_modrm(s, env) >> 3) & 7;
+    if (op != 0) {
+        *entry = illegal_opcode;
+    } else {
+        entry->gen = gen_POP;
+        /* The address must use the value of ESP after the pop.  */
+        s->popl_esp_hack = 1 << mo_pushpop(s, s->dflag);
+    }
+}
+
 static const X86OpEntry opcodes_root[256] = {
     [0x00] = X86_OP_ENTRY2(ADD, E,b, G,b),
     [0x01] = X86_OP_ENTRY2(ADD, E,v, G,v),
@@ -1133,6 +1177,60 @@ static const X86OpEntry opcodes_root[256] = {
     [0x56] = X86_OP_ENTRYr(PUSH, LoBits,d64),
     [0x57] = X86_OP_ENTRYr(PUSH, LoBits,d64),
 
+    [0x60] = X86_OP_ENTRY0(PUSHA, chk(i64)),
+    [0x61] = X86_OP_ENTRY0(POPA, chk(i64)),
+    [0x62] = X86_OP_ENTRY2(BOUND, G,v, M,a, chk(i64)),
+    [0x63] = X86_OP_GROUP0(63),
+    [0x64] = {},
+    [0x65] = {},
+    [0x66] = {},
+    [0x67] = {},
+
+    [0x70] = X86_OP_ENTRYr(Jcc, J,b),
+    [0x71] = X86_OP_ENTRYr(Jcc, J,b),
+    [0x72] = X86_OP_ENTRYr(Jcc, J,b),
+    [0x73] = X86_OP_ENTRYr(Jcc, J,b),
+    [0x74] = X86_OP_ENTRYr(Jcc, J,b),
+    [0x75] = X86_OP_ENTRYr(Jcc, J,b),
+    [0x76] = X86_OP_ENTRYr(Jcc, J,b),
+    [0x77] = X86_OP_ENTRYr(Jcc, J,b),
+
+    [0x80] = X86_OP_GROUP2(group1, E,b, I,b),
+    [0x81] = X86_OP_GROUP2(group1, E,v, I,z),
+    [0x82] = X86_OP_GROUP2(group1, E,b, I,b, chk(i64)),
+    [0x83] = X86_OP_GROUP2(group1, E,v, I,b),
+    [0x84] = X86_OP_ENTRY2(AND, E,b, G,b, nowb),
+    [0x85] = X86_OP_ENTRY2(AND, E,v, G,v, nowb),
+    [0x86] = X86_OP_ENTRY2(XCHG, E,b, G,b, xchg),
+    [0x87] = X86_OP_ENTRY2(XCHG, E,v, G,v, xchg),
+
+    [0x90] = X86_OP_ENTRY2(XCHG, 0,v, LoBits,v),
+    [0x91] = X86_OP_ENTRY2(XCHG, 0,v, LoBits,v),
+    [0x92] = X86_OP_ENTRY2(XCHG, 0,v, LoBits,v),
+    [0x93] = X86_OP_ENTRY2(XCHG, 0,v, LoBits,v),
+    [0x94] = X86_OP_ENTRY2(XCHG, 0,v, LoBits,v),
+    [0x95] = X86_OP_ENTRY2(XCHG, 0,v, LoBits,v),
+    [0x96] = X86_OP_ENTRY2(XCHG, 0,v, LoBits,v),
+    [0x97] = X86_OP_ENTRY2(XCHG, 0,v, LoBits,v),
+
+    [0xA0] = X86_OP_ENTRY3(MOV, 0,b, O,b, None, None), /* AL, Ob */
+    [0xA1] = X86_OP_ENTRY3(MOV, 0,v, O,v, None, None), /* rAX, Ov */
+    [0xA2] = X86_OP_ENTRY3(MOV, O,b, 0,b, None, None), /* Ob, AL */
+    [0xA3] = X86_OP_ENTRY3(MOV, O,v, 0,v, None, None), /* Ov, rAX */
+    [0xA4] = X86_OP_ENTRY2(MOVS, Y,b, X,b, nowb),
+    [0xA5] = X86_OP_ENTRY2(MOVS, Y,v, X,v, nowb),
+    [0xA6] = X86_OP_ENTRY2(CMPS, Y,b, X,b, nowb),
+    [0xA7] = X86_OP_ENTRY2(CMPS, Y,v, X,v, nowb),
+
+    [0xB0] = X86_OP_ENTRY3(MOV, LoBits,b, I,b, None, None),
+    [0xB1] = X86_OP_ENTRY3(MOV, LoBits,b, I,b, None, None),
+    [0xB2] = X86_OP_ENTRY3(MOV, LoBits,b, I,b, None, None),
+    [0xB3] = X86_OP_ENTRY3(MOV, LoBits,b, I,b, None, None),
+    [0xB4] = X86_OP_ENTRY3(MOV, LoBits,b, I,b, None, None),
+    [0xB5] = X86_OP_ENTRY3(MOV, LoBits,b, I,b, None, None),
+    [0xB6] = X86_OP_ENTRY3(MOV, LoBits,b, I,b, None, None),
+    [0xB7] = X86_OP_ENTRY3(MOV, LoBits,b, I,b, None, None),
+
 
     [0x08] = X86_OP_ENTRY2(OR, E,b, G,b),
     [0x09] = X86_OP_ENTRY2(OR, E,v, G,v),
@@ -1187,6 +1285,60 @@ static const X86OpEntry opcodes_root[256] = {
     [0x5D] = X86_OP_ENTRYw(POP, LoBits,d64),
     [0x5E] = X86_OP_ENTRYw(POP, LoBits,d64),
     [0x5F] = X86_OP_ENTRYw(POP, LoBits,d64),
+
+    [0x68] = X86_OP_ENTRYr(PUSH, I,z),
+    [0x69] = X86_OP_ENTRY3(IMUL3, G,v, E,v, I,z),
+    [0x6A] = X86_OP_ENTRYr(PUSH, I,b),
+    [0x6B] = X86_OP_ENTRY3(IMUL3, G,v, E,v, I,b),
+    [0x6C] = X86_OP_ENTRY2(INS, Y,b, 2,w, nowb), /* DX */
+    [0x6D] = X86_OP_ENTRY2(INS, Y,z, 2,w, nowb), /* DX */
+    [0x6E] = X86_OP_ENTRY2(OUTS, 2,w, X,b, nowb), /* DX */
+    [0x6F] = X86_OP_ENTRY2(OUTS, 2,w, X,b, nowb), /* DX */
+
+    [0x78] = X86_OP_ENTRYr(Jcc, J,b),
+    [0x79] = X86_OP_ENTRYr(Jcc, J,b),
+    [0x7A] = X86_OP_ENTRYr(Jcc, J,b),
+    [0x7B] = X86_OP_ENTRYr(Jcc, J,b),
+    [0x7C] = X86_OP_ENTRYr(Jcc, J,b),
+    [0x7D] = X86_OP_ENTRYr(Jcc, J,b),
+    [0x7E] = X86_OP_ENTRYr(Jcc, J,b),
+    [0x7F] = X86_OP_ENTRYr(Jcc, J,b),
+
+    [0x88] = X86_OP_ENTRY3(MOV, E,b, G,b, None, None),
+    [0x89] = X86_OP_ENTRY3(MOV, E,v, G,v, None, None),
+    [0x8A] = X86_OP_ENTRY3(MOV, G,b, E,b, None, None),
+    [0x8B] = X86_OP_ENTRY3(MOV, G,v, E,v, None, None),
+    [0x8C] = X86_OP_ENTRY3(MOV, E,v, S,w, None, None),
+    [0x8D] = X86_OP_ENTRY3(LEA, G,v, M,v, None, None, noseg),
+    [0x8E] = X86_OP_ENTRY3(MOV, S,w, E,v, None, None),
+    [0x8F] = X86_OP_GROUPw(group1A, E,v),
+
+    [0x98] = X86_OP_ENTRY1(CBW, 0,v), /* rAX */
+    [0x99] = X86_OP_ENTRY3(CWD, 2,v, 0,v, None, None), /* rDX, rAX */
+    [0x9A] = X86_OP_ENTRYr(CALLF, A,p, chk(i64)),
+    [0x9B] = X86_OP_ENTRY0(WAIT),
+    [0x9C] = X86_OP_ENTRY0(PUSHF, chk(vm86_iopl) svm(PUSHF)),
+    [0x9D] = X86_OP_ENTRY0(POPF, chk(vm86_iopl) svm(POPF)),
+    [0x9E] = X86_OP_ENTRY0(SAHF),
+    [0x9F] = X86_OP_ENTRY0(LAHF),
+
+    [0xA8] = X86_OP_ENTRY2(AND, 0,b, I,b, nowb),   /* AL, Ib */
+    [0xA9] = X86_OP_ENTRY2(AND, 0,v, I,z, nowb),   /* rAX, Iz */
+    [0xAA] = X86_OP_ENTRY2(STOS, Y,b, 0,b, nowb),
+    [0xAB] = X86_OP_ENTRY2(STOS, Y,v, 0,v, nowb),
+    [0xAC] = X86_OP_ENTRY2(LODS, 0,b, X,b, nowb),
+    [0xAD] = X86_OP_ENTRY2(LODS, 0,v, X,v, nowb),
+    [0xAE] = X86_OP_ENTRY2(SCAS, 0,b, Y,b, nowb),
+    [0xAF] = X86_OP_ENTRY2(SCAS, 0,v, Y,v, nowb),
+
+    [0xB8] = X86_OP_ENTRY3(MOV, LoBits,v, I,v, None, None),
+    [0xB9] = X86_OP_ENTRY3(MOV, LoBits,v, I,v, None, None),
+    [0xBA] = X86_OP_ENTRY3(MOV, LoBits,v, I,v, None, None),
+    [0xBB] = X86_OP_ENTRY3(MOV, LoBits,v, I,v, None, None),
+    [0xBC] = X86_OP_ENTRY3(MOV, LoBits,v, I,v, None, None),
+    [0xBD] = X86_OP_ENTRY3(MOV, LoBits,v, I,v, None, None),
+    [0xBE] = X86_OP_ENTRY3(MOV, LoBits,v, I,v, None, None),
+    [0xBF] = X86_OP_ENTRY3(MOV, LoBits,v, I,v, None, None),
 };
 
 #undef mmx
@@ -2028,6 +2180,11 @@ static void disas_insn_new(DisasContext *s, CPUState *cpu, int b)
 
     default:
         break;
+
+    case X86_SPECIAL_NoSeg:
+        decode.mem.def_seg = -1;
+        s->override = -1;
+        break;
     }
 
     if (!validate_vex(s, &decode)) {
diff --git a/target/i386/tcg/decode-new.h b/target/i386/tcg/decode-new.h
index a3983794ac5..32396630865 100644
--- a/target/i386/tcg/decode-new.h
+++ b/target/i386/tcg/decode-new.h
@@ -164,6 +164,9 @@ typedef enum X86InsnSpecial {
     /* Writeback not needed or done manually in the callback */
     X86_SPECIAL_NoWriteback,
 
+    /* Do not apply segment base to effective address */
+    X86_SPECIAL_NoSeg,
+
     /*
      * Register operand 0/2 is zero extended to 32 bits.  Rd/Mb or Rd/Mw
      * in the manual.
diff --git a/target/i386/tcg/emit.c.inc b/target/i386/tcg/emit.c.inc
index 6b9f518cc94..267f4fe383a 100644
--- a/target/i386/tcg/emit.c.inc
+++ b/target/i386/tcg/emit.c.inc
@@ -1160,6 +1160,30 @@ static void gen_ANDN(DisasContext *s, CPUX86State *env, X86DecodedInsn *decode)
     prepare_update1_cc(decode, s, CC_OP_LOGICB + ot);
 }
 
+static void gen_ARPL(DisasContext *s, CPUX86State *env, X86DecodedInsn *decode)
+{
+    TCGLabel *label1 = gen_new_label();
+    TCGv rpl_adj = tcg_temp_new();
+
+    gen_mov_eflags(s, s->tmp4);
+    tcg_gen_andi_tl(s->tmp4, s->tmp4, ~CC_Z);
+
+    /* Compute dest[rpl] - src[rpl], adjust if result <0.  */
+    tcg_gen_andi_tl(rpl_adj, s->T0, 3);
+    tcg_gen_andi_tl(s->T1, s->T1, 3);
+    tcg_gen_sub_tl(rpl_adj, rpl_adj, s->T1);
+
+    tcg_gen_brcondi_tl(TCG_COND_LT, rpl_adj, 0, label1);
+
+    /* Subtract dest[rpl] - src[rpl] to set dest[rpl] = src[rpl].  */
+    tcg_gen_sub_tl(s->T0, s->T0, rpl_adj);
+    tcg_gen_ori_tl(s->tmp4, s->tmp4, CC_Z);
+    gen_set_label(label1);
+
+    decode->cc_src = s->tmp4;
+    decode->cc_op = CC_OP_EFLAGS;
+}
+
 static void gen_BEXTR(DisasContext *s, CPUX86State *env, X86DecodedInsn *decode)
 {
     MemOp ot = decode->op[0].ot;
@@ -1227,6 +1251,16 @@ static void gen_BLSR(DisasContext *s, CPUX86State *env, X86DecodedInsn *decode)
     set_cc_op(s, CC_OP_BMILGB + ot);
 }
 
+static void gen_BOUND(DisasContext *s, CPUX86State *env, X86DecodedInsn *decode)
+{
+    tcg_gen_trunc_tl_i32(s->tmp2_i32, s->T0);
+    if (decode->op[1].ot == MO_16) {
+        gen_helper_boundw(tcg_env, s->A0, s->tmp2_i32);
+    } else {
+        gen_helper_boundl(tcg_env, s->A0, s->tmp2_i32);
+    }
+}
+
 static void gen_BZHI(DisasContext *s, CPUX86State *env, X86DecodedInsn *decode)
 {
     MemOp ot = decode->op[0].ot;
@@ -1249,6 +1283,43 @@ static void gen_BZHI(DisasContext *s, CPUX86State *env, X86DecodedInsn *decode)
     prepare_update1_cc(decode, s, CC_OP_BMILGB + ot);
 }
 
+static void gen_CALLF(DisasContext *s, CPUX86State *env, X86DecodedInsn *decode)
+{
+    MemOp ot = decode->op[2].ot;
+    unsigned int selector, offset;
+
+    if (CODE64(s)) {
+        gen_illegal_opcode(s);
+        return;
+    }
+
+    assert(ot >= MO_16);
+    offset = insn_get(env, s, ot);
+    selector = insn_get(env, s, MO_16);
+    tcg_gen_movi_tl(s->T0, selector);
+    tcg_gen_movi_tl(s->T1, offset);
+    return gen_far_call(s);
+}
+
+static void gen_CBW(DisasContext *s, CPUX86State *env, X86DecodedInsn *decode)
+{
+    switch(decode->op[0].ot) {
+#ifdef TARGET_X86_64
+        case MO_64:
+            tcg_gen_ext32s_tl(s->T0, s->T0);
+            break;
+#endif
+        case MO_32:
+            tcg_gen_ext16s_tl(s->T0, s->T0);
+            break;
+        case MO_16:
+            tcg_gen_ext8s_tl(s->T0, s->T0);
+            break;
+        default:
+            g_assert_not_reached();
+    }
+}
+
 static void gen_CMPccXADD(DisasContext *s, CPUX86State *env, X86DecodedInsn *decode)
 {
     TCGv z_tl = tcg_constant_tl(0);
@@ -1347,6 +1418,18 @@ static void gen_CMPccXADD(DisasContext *s, CPUX86State *env, X86DecodedInsn *dec
     gen_writeback(s, decode, 1, s->cc_srcT);
 }
 
+static void gen_CMPS(DisasContext *s, CPUX86State *env, X86DecodedInsn *decode)
+{
+    MemOp ot = decode->op[0].ot;
+    if (s->prefix & PREFIX_REPNZ) {
+        gen_repz_cmps(s, ot, 1);
+    } else if (s->prefix & PREFIX_REPZ) {
+        gen_repz_cmps(s, ot, 0);
+    } else {
+        gen_cmps(s, ot);
+    }
+}
+
 static void gen_CRC32(DisasContext *s, CPUX86State *env, X86DecodedInsn *decode)
 {
     MemOp ot = decode->op[2].ot;
@@ -1385,6 +1468,24 @@ static void gen_CVTTPx2PI(DisasContext *s, CPUX86State *env, X86DecodedInsn *dec
     }
 }
 
+static void gen_CWD(DisasContext *s, CPUX86State *env, X86DecodedInsn *decode)
+{
+    int shift = 8 << decode->op[0].ot;
+    switch (shift) {
+    case 64:
+        break;
+    case 32:
+        tcg_gen_ext32s_tl(s->T0, s->T0);
+        break;
+    case 16:
+        tcg_gen_ext16s_tl(s->T0, s->T0);
+        break;
+    default:
+        g_assert_not_reached();
+    }
+    tcg_gen_sari_tl(s->T0, s->T0, shift - 1);
+}
+
 static void gen_DAA(DisasContext *s, CPUX86State *env, X86DecodedInsn *decode)
 {
     gen_update_cc_op(s);
@@ -1431,6 +1532,58 @@ static void gen_EXTRQ_r(DisasContext *s, CPUX86State *env, X86DecodedInsn *decod
     gen_helper_extrq_r(tcg_env, OP_PTR0, OP_PTR2);
 }
 
+static void gen_IMUL3(DisasContext *s, CPUX86State *env, X86DecodedInsn *decode)
+{
+    MemOp ot = decode->op[0].ot;
+    TCGv cc_src_rhs;
+
+    switch (ot) {
+    case MO_16:
+        tcg_gen_ext16s_tl(s->T0, s->T0);
+        tcg_gen_ext16s_tl(s->T1, s->T1);
+        /* XXX: use 32 bit mul which could be faster */
+        tcg_gen_mul_tl(s->T0, s->T0, s->T1);
+        /* Compare the full result to the extension of the truncated result.  */
+        tcg_gen_ext16s_tl(s->T1, s->T0);
+        cc_src_rhs = s->T0;
+        break;
+
+    case MO_32:
+#ifdef TARGET_X86_64
+        /*
+         * This could also use the same algorithm as MO_16.  It produces fewer
+         * TCG ops and better code if flags are needed, but it requires a 64-bit
+         * multiply even if they are not (and thus the high part of the multiply
+         * is dead).
+         */
+        tcg_gen_trunc_tl_i32(s->tmp2_i32, s->T0);
+        tcg_gen_trunc_tl_i32(s->tmp3_i32, s->T1);
+        tcg_gen_muls2_i32(s->tmp2_i32, s->tmp3_i32,
+                          s->tmp2_i32, s->tmp3_i32);
+        tcg_gen_extu_i32_tl(s->T0, s->tmp2_i32);
+        tcg_gen_extu_i32_tl(s->tmp0, s->tmp3_i32);
+        /* Compare the high part to the sign bit of the truncated result */
+        tcg_gen_negsetcondi_i32(TCG_COND_LT, s->tmp2_i32, s->tmp2_i32, 0);
+        tcg_gen_extu_i32_tl(s->T1, s->tmp2_i32);
+        cc_src_rhs = s->tmp0;
+        break;
+
+    case MO_64:
+#endif
+        tcg_gen_muls2_tl(s->T0, s->tmp0, s->T0, s->T1);
+        /* Compare the high part to the sign bit of the truncated result */
+        tcg_gen_negsetcondi_tl(TCG_COND_LT, s->T1, s->T0, 0);
+        cc_src_rhs = s->tmp0;
+        break;
+
+    default:
+        g_assert_not_reached();
+    }
+
+    tcg_gen_sub_tl(s->T1, s->T1, cc_src_rhs);
+    prepare_update2_cc(decode, s, CC_OP_MULB + ot);
+}
+
 static void gen_INC(DisasContext *s, CPUX86State *env, X86DecodedInsn *decode)
 {
     MemOp ot = decode->op[0].ot;
@@ -1445,6 +1598,25 @@ static void gen_INC(DisasContext *s, CPUX86State *env, X86DecodedInsn *decode)
     prepare_update_cc_incdec(decode, s, CC_OP_INCB + ot);
 }
 
+static void gen_INS(DisasContext *s, CPUX86State *env, X86DecodedInsn *decode)
+{
+    MemOp ot = decode->op[0].ot;
+
+    tcg_gen_trunc_tl_i32(s->tmp2_i32, s->T1);
+    tcg_gen_ext16u_i32(s->tmp2_i32, s->tmp2_i32);
+    if (!gen_check_io(s, ot, s->tmp2_i32,
+                      SVM_IOIO_TYPE_MASK | SVM_IOIO_STR_MASK)) {
+        return;
+    }
+
+    translator_io_start(&s->base);
+    if (s->prefix & (PREFIX_REPZ | PREFIX_REPNZ)) {
+        gen_repz_ins(s, ot);
+    } else {
+        gen_ins(s, ot);
+    }
+}
+
 static void gen_INSERTQ_i(DisasContext *s, CPUX86State *env, X86DecodedInsn *decode)
 {
     TCGv_i32 length = tcg_constant_i32(decode->immediate & 63);
@@ -1458,12 +1630,50 @@ static void gen_INSERTQ_r(DisasContext *s, CPUX86State *env, X86DecodedInsn *dec
     gen_helper_insertq_r(tcg_env, OP_PTR0, OP_PTR2);
 }
 
+static void gen_Jcc(DisasContext *s, CPUX86State *env, X86DecodedInsn *decode)
+{
+    gen_bnd_jmp(s);
+    gen_jcc(s, decode->b & 0xf, decode->immediate);
+}
+
+static void gen_LAHF(DisasContext *s, CPUX86State *env, X86DecodedInsn *decode)
+{
+    if (CODE64(s) && !(s->cpuid_ext3_features & CPUID_EXT3_LAHF_LM)) {
+        return gen_illegal_opcode(s);
+    }
+    gen_compute_eflags(s);
+    /* Note: gen_compute_eflags() only gives the condition codes */
+    tcg_gen_ori_tl(s->T0, cpu_cc_src, 0x02);
+    tcg_gen_deposit_tl(cpu_regs[R_EAX], cpu_regs[R_EAX], s->T0, 8, 8);
+}
+
 static void gen_LDMXCSR(DisasContext *s, CPUX86State *env, X86DecodedInsn *decode)
 {
     tcg_gen_trunc_tl_i32(s->tmp2_i32, s->T1);
     gen_helper_ldmxcsr(tcg_env, s->tmp2_i32);
 }
 
+static void gen_LEA(DisasContext *s, CPUX86State *env, X86DecodedInsn *decode)
+{
+    tcg_gen_mov_tl(s->T0, s->A0);
+}
+
+static void gen_LODS(DisasContext *s, CPUX86State *env, X86DecodedInsn *decode)
+{
+    MemOp ot = decode->op[0].ot;
+    if (s->prefix & (PREFIX_REPZ | PREFIX_REPNZ)) {
+        gen_repz_lods(s, ot);
+    } else {
+        gen_lods(s, ot);
+    }
+}
+
+static void gen_MOV(DisasContext *s, CPUX86State *env, X86DecodedInsn *decode)
+{
+    /* nothing to do! */
+}
+#define gen_NOP gen_MOV
+
 static void gen_MASKMOV(DisasContext *s, CPUX86State *env, X86DecodedInsn *decode)
 {
     tcg_gen_mov_tl(s->A0, cpu_regs[R_EDI]);
@@ -1573,6 +1783,21 @@ static void gen_MOVq_dq(DisasContext *s, CPUX86State *env, X86DecodedInsn *decod
     return gen_MOVQ(s, env, decode);
 }
 
+static void gen_MOVS(DisasContext *s, CPUX86State *env, X86DecodedInsn *decode)
+{
+    MemOp ot = decode->op[0].ot;
+    if (s->prefix & (PREFIX_REPZ | PREFIX_REPNZ)) {
+        gen_repz_movs(s, ot);
+    } else {
+        gen_movs(s, ot);
+    }
+}
+
+static void gen_MOVSXD(DisasContext *s, CPUX86State *env, X86DecodedInsn *decode)
+{
+    tcg_gen_ext32s_tl(s->T0, s->T0);
+}
+
 static void gen_MULX(DisasContext *s, CPUX86State *env, X86DecodedInsn *decode)
 {
     MemOp ot = decode->op[0].ot;
@@ -1609,6 +1834,24 @@ static void gen_OR(DisasContext *s, CPUX86State *env, X86DecodedInsn *decode)
     prepare_update1_cc(decode, s, CC_OP_LOGICB + ot);
 }
 
+static void gen_OUTS(DisasContext *s, CPUX86State *env, X86DecodedInsn *decode)
+{
+    MemOp ot = decode->op[1].ot;
+
+    tcg_gen_trunc_tl_i32(s->tmp2_i32, s->T0);
+    tcg_gen_ext16u_i32(s->tmp2_i32, s->tmp2_i32);
+    if (!gen_check_io(s, ot, s->tmp2_i32, SVM_IOIO_STR_MASK)) {
+        return;
+    }
+
+    translator_io_start(&s->base);
+    if (s->prefix & (PREFIX_REPZ | PREFIX_REPNZ)) {
+        gen_repz_outs(s, ot);
+    } else {
+        gen_outs(s, ot);
+    }
+}
+
 static void gen_PALIGNR(DisasContext *s, CPUX86State *env, X86DecodedInsn *decode)
 {
     TCGv_i32 imm = tcg_constant8u_i32(decode->immediate);
@@ -1872,6 +2115,33 @@ static void gen_POP(DisasContext *s, CPUX86State *env, X86DecodedInsn *decode)
     gen_pop_update(s, ot);
 }
 
+static void gen_POPA(DisasContext *s, CPUX86State *env, X86DecodedInsn *decode)
+{
+   gen_popa(s);
+}
+
+static void gen_POPF(DisasContext *s, CPUX86State *env, X86DecodedInsn *decode)
+{
+    MemOp ot;
+    int mask = TF_MASK | AC_MASK | ID_MASK | NT_MASK;
+
+    if (CPL(s) == 0) {
+        mask |= IF_MASK | IOPL_MASK;
+    } else if (CPL(s) <= IOPL(s)) {
+        mask |= IF_MASK;
+    }
+    if (s->dflag == MO_16) {
+        mask &= 0xffff;
+    }
+
+    ot = gen_pop_T0(s);
+    gen_helper_write_eflags(tcg_env, s->T0, tcg_constant_i32(mask));
+    gen_pop_update(s, ot);
+    set_cc_op(s, CC_OP_EFLAGS);
+    /* abort translation because TF/AC flag may change */
+    s->base.is_jmp = DISAS_EOB_NEXT;
+}
+
 static void gen_PSHUFW(DisasContext *s, CPUX86State *env, X86DecodedInsn *decode)
 {
     TCGv_i32 imm = tcg_constant8u_i32(decode->immediate);
@@ -2023,6 +2293,18 @@ static void gen_PUSH(DisasContext *s, CPUX86State *env, X86DecodedInsn *decode)
     gen_push_v(s, s->T1);
 }
 
+static void gen_PUSHA(DisasContext *s, CPUX86State *env, X86DecodedInsn *decode)
+{
+   gen_pusha(s);
+}
+
+static void gen_PUSHF(DisasContext *s, CPUX86State *env, X86DecodedInsn *decode)
+{
+    gen_update_cc_op(s);
+    gen_helper_read_eflags(s->T0, tcg_env);
+    gen_push_v(s, s->T0);
+}
+
 static void gen_RORX(DisasContext *s, CPUX86State *env, X86DecodedInsn *decode)
 {
     MemOp ot = decode->op[0].ot;
@@ -2037,6 +2319,18 @@ static void gen_RORX(DisasContext *s, CPUX86State *env, X86DecodedInsn *decode)
     }
 }
 
+static void gen_SAHF(DisasContext *s, CPUX86State *env, X86DecodedInsn *decode)
+{
+    if (CODE64(s) && !(s->cpuid_ext3_features & CPUID_EXT3_LAHF_LM)) {
+        return gen_illegal_opcode(s);
+    }
+    tcg_gen_shri_tl(s->T0, cpu_regs[R_EAX], 8);
+    gen_compute_eflags(s);
+    tcg_gen_andi_tl(cpu_cc_src, cpu_cc_src, CC_O);
+    tcg_gen_andi_tl(s->T0, s->T0, CC_S | CC_Z | CC_A | CC_P | CC_C);
+    tcg_gen_or_tl(cpu_cc_src, cpu_cc_src, s->T0);
+}
+
 static void gen_SARX(DisasContext *s, CPUX86State *env, X86DecodedInsn *decode)
 {
     MemOp ot = decode->op[0].ot;
@@ -2067,6 +2361,18 @@ static void gen_SBB(DisasContext *s, CPUX86State *env, X86DecodedInsn *decode)
     prepare_update3_cc(decode, s, CC_OP_SBBB + ot, s->tmp4);
 }
 
+static void gen_SCAS(DisasContext *s, CPUX86State *env, X86DecodedInsn *decode)
+{
+    MemOp ot = decode->op[0].ot;
+    if (s->prefix & PREFIX_REPNZ) {
+        gen_repz_scas(s, ot, 1);
+    } else if (s->prefix & PREFIX_REPZ) {
+        gen_repz_scas(s, ot, 0);
+    } else {
+        gen_scas(s, ot);
+    }
+}
+
 static void gen_SHA1NEXTE(DisasContext *s, CPUX86State *env, X86DecodedInsn *decode)
 {
     gen_helper_sha1nexte(OP_PTR0, OP_PTR1, OP_PTR2);
@@ -2157,6 +2463,16 @@ static void gen_STMXCSR(DisasContext *s, CPUX86State *env, X86DecodedInsn *decod
     tcg_gen_ld32u_tl(s->T0, tcg_env, offsetof(CPUX86State, mxcsr));
 }
 
+static void gen_STOS(DisasContext *s, CPUX86State *env, X86DecodedInsn *decode)
+{
+    MemOp ot = decode->op[0].ot;
+    if (s->prefix & (PREFIX_REPZ | PREFIX_REPNZ)) {
+        gen_repz_stos(s, ot);
+    } else {
+        gen_stos(s, ot);
+    }
+}
+
 static void gen_SUB(DisasContext *s, CPUX86State *env, X86DecodedInsn *decode)
 {
     MemOp ot = decode->op[0].ot;
@@ -2653,6 +2969,43 @@ static void gen_VZEROUPPER(DisasContext *s, CPUX86State *env, X86DecodedInsn *de
     }
 }
 
+static void gen_WAIT(DisasContext *s, CPUX86State *env, X86DecodedInsn *decode)
+{
+    if ((s->flags & (HF_MP_MASK | HF_TS_MASK)) == (HF_MP_MASK | HF_TS_MASK)) {
+        gen_NM_exception(s);
+    } else {
+        /* needs to be treated as I/O because of ferr_irq */
+        translator_io_start(&s->base);
+        gen_helper_fwait(tcg_env);
+    }
+}
+
+static void gen_XCHG(DisasContext *s, CPUX86State *env, X86DecodedInsn *decode)
+{
+    if (decode->b == 0x90 && !REX_B(s)) {
+        if (s->prefix & PREFIX_REPZ) {
+            gen_update_cc_op(s);
+            gen_update_eip_cur(s);
+            gen_helper_pause(tcg_env, cur_insn_len_i32(s));
+            s->base.is_jmp = DISAS_NORETURN;
+        }
+        /* No writeback.  */
+        decode->op[0].unit = X86_OP_SKIP;
+        return;
+    }
+
+    if (s->prefix & PREFIX_LOCK) {
+        tcg_gen_atomic_xchg_tl(s->T0, s->A0, s->T1,
+                               s->mem_index, decode->op[0].ot | MO_LE);
+        /* now store old value into register operand */
+        gen_op_mov_reg_v(s, decode->op[2].ot, decode->op[2].n, s->T0);
+    } else {
+        /* move destination value into source operand, source preserved in T1 */
+        gen_op_mov_reg_v(s, decode->op[2].ot, decode->op[2].n, s->T0);
+        tcg_gen_mov_tl(s->T0, s->T1);
+    }
+}
+
 static void gen_XOR(DisasContext *s, CPUX86State *env, X86DecodedInsn *decode)
 {
     /* special case XOR reg, reg */
@@ -2660,7 +3013,7 @@ static void gen_XOR(DisasContext *s, CPUX86State *env, X86DecodedInsn *decode)
         decode->op[2].unit == X86_OP_INT &&
         decode->op[1].n == decode->op[2].n) {
         tcg_gen_movi_tl(s->T0, 0);
-        set_cc_op(s, CC_OP_CLR);
+        decode->cc_op = CC_OP_CLR;
     } else {
         MemOp ot = decode->op[0].ot;
 
diff --git a/target/i386/tcg/translate.c b/target/i386/tcg/translate.c
index 2da7c357cdc..9c799b5a980 100644
--- a/target/i386/tcg/translate.c
+++ b/target/i386/tcg/translate.c
@@ -2563,6 +2563,23 @@ static void gen_movl_seg_T0(DisasContext *s, X86Seg seg_reg)
     }
 }
 
+static void gen_far_call(DisasContext *s)
+{
+    if (PE(s) && !VM86(s)) {
+        tcg_gen_trunc_tl_i32(s->tmp2_i32, s->T0);
+        gen_helper_lcall_protected(tcg_env, s->tmp2_i32, s->T1,
+                                   tcg_constant_i32(s->dflag - 1),
+                                   eip_next_tl(s));
+    } else {
+        tcg_gen_trunc_tl_i32(s->tmp2_i32, s->T0);
+        tcg_gen_trunc_tl_i32(s->tmp3_i32, s->T1);
+        gen_helper_lcall_real(tcg_env, s->tmp2_i32, s->tmp3_i32,
+                              tcg_constant_i32(s->dflag - 1),
+                              eip_next_i32(s));
+    }
+    s->base.is_jmp = DISAS_JUMP;
+}
+
 static void gen_svm_check_intercept(DisasContext *s, uint32_t type)
 {
     /* no SVM activated; fast case */
@@ -3108,6 +3125,7 @@ static bool disas_insn(DisasContext *s, CPUState *cpu)
 
     s->pc = s->base.pc_next;
     s->override = -1;
+    s->popl_esp_hack = 0;
 #ifdef TARGET_X86_64
     s->rex_r = 0;
     s->rex_x = 0;
@@ -3164,7 +3182,7 @@ static bool disas_insn(DisasContext *s, CPUState *cpu)
 #ifndef CONFIG_USER_ONLY
         use_new &= b <= limit;
 #endif
-        if (use_new && b <= 0x5f) {
+        if (use_new && b <= 0xbf) {
             disas_insn_new(s, cpu, b);
             return true;
         }
@@ -3675,20 +3693,7 @@ static bool disas_insn(DisasContext *s, CPUState *cpu)
             gen_op_ld_v(s, ot, s->T1, s->A0);
             gen_add_A0_im(s, 1 << ot);
             gen_op_ld_v(s, MO_16, s->T0, s->A0);
-        do_lcall:
-            if (PE(s) && !VM86(s)) {
-                tcg_gen_trunc_tl_i32(s->tmp2_i32, s->T0);
-                gen_helper_lcall_protected(tcg_env, s->tmp2_i32, s->T1,
-                                           tcg_constant_i32(dflag - 1),
-                                           eip_next_tl(s));
-            } else {
-                tcg_gen_trunc_tl_i32(s->tmp2_i32, s->T0);
-                tcg_gen_trunc_tl_i32(s->tmp3_i32, s->T1);
-                gen_helper_lcall_real(tcg_env, s->tmp2_i32, s->tmp3_i32,
-                                      tcg_constant_i32(dflag - 1),
-                                      eip_next_i32(s));
-            }
-            s->base.is_jmp = DISAS_JUMP;
+            gen_far_call(s);
             break;
         case 4: /* jmp Ev */
             if (dflag == MO_16) {
@@ -5200,7 +5205,8 @@ static bool disas_insn(DisasContext *s, CPUState *cpu)
             tcg_gen_movi_tl(s->T0, selector);
             tcg_gen_movi_tl(s->T1, offset);
         }
-        goto do_lcall;
+        gen_far_call(s);
+        break;
     case 0xe9: /* jmp im */
         {
             int diff = (dflag != MO_16
-- 
2.41.0



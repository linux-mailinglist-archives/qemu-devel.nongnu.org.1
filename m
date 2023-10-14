Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D81A37C9400
	for <lists+qemu-devel@lfdr.de>; Sat, 14 Oct 2023 12:02:40 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qrbTH-0002bk-3l; Sat, 14 Oct 2023 06:02:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qrbT3-0002Zw-Jl
 for qemu-devel@nongnu.org; Sat, 14 Oct 2023 06:01:58 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qrbT1-00041C-Ob
 for qemu-devel@nongnu.org; Sat, 14 Oct 2023 06:01:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697277715;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=L8PaFUtxsPMZphARHEnRIRh6cEJnhnFZ571/DAtAueU=;
 b=EIiapU+kgkpHg1OcIcOAROGzWA4qBwAo1LwHsF3dE0Nac/ItWPi/26giyAGJHA/VTILUvb
 c1kuXNa02lFTv0crWcj+Jg85LU3GyadrUVe19iJZYIbYvFD/Gpu8wNu2SBE3h933FoGvgW
 qjjD5GgZbCxu9ogwlAx3vDsEdnpB+uo=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-241-ehBEmfbhNNONytBL7BtlwQ-1; Sat, 14 Oct 2023 06:01:53 -0400
X-MC-Unique: ehBEmfbhNNONytBL7BtlwQ-1
Received: by mail-ej1-f70.google.com with SMTP id
 a640c23a62f3a-9ae0601d689so186121566b.0
 for <qemu-devel@nongnu.org>; Sat, 14 Oct 2023 03:01:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697277711; x=1697882511;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=L8PaFUtxsPMZphARHEnRIRh6cEJnhnFZ571/DAtAueU=;
 b=CDcmIppXxkWlAQX6k6DrdUW0asNm6TF4N68RQA/rYJfIDkPpDhLSmlo73A30wkZDl7
 adzvdonhoK/w8q5nAxeve5ANe2iwKooX1/uvRGghj5lEVRrxCoVTcOhlX7Ft4WtqK1Ur
 rud4ckgiVeH/Uw6qOnplpsSTVNl49drzSnn4drYn7Xy0YkLQAcIYR/DLm3sQ0jMLNk5n
 yh9C2vqD4MxkApz+Lm5F+G5jtzXmWDYmoWZenNVl+umjtz6thFRhMnWSM/BVs/eAonS6
 M3/Mxc/6Rts2sdyiZ2VL1+aqoK1N4FE9TQ23/yCLneuAYUaECfY0Yy/As6/GwsBIkj1s
 eGHw==
X-Gm-Message-State: AOJu0YyvmebpORKSpK+VOWI0fi2+Kj7LPSHxUVamvKmLxTPfKo/LDxZu
 +RaAv4EtxDIaBEtpGb1lw2Fg1YdcXCKXyz6mX4m5eqNM09kh/IF67mciT7nIflzAuBzZylXvGuW
 LPosaXdDdoh+QOj3k1CupLYKT2eLHTrFiJHFEewL6CQxDUQIPWnc3jjpjcjoGj0BUFV7opxj508
 I=
X-Received: by 2002:a17:907:6ea9:b0:9be:5d6f:2bc5 with SMTP id
 sh41-20020a1709076ea900b009be5d6f2bc5mr2152543ejc.73.1697277711414; 
 Sat, 14 Oct 2023 03:01:51 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHvXy2heyjk8CQMRHLrXSuhQVrJDv2hKYGVUtjB2aLmmHxcU14SGkU9DIlJcnPOREc1euRiVA==
X-Received: by 2002:a17:907:6ea9:b0:9be:5d6f:2bc5 with SMTP id
 sh41-20020a1709076ea900b009be5d6f2bc5mr2152513ejc.73.1697277710880; 
 Sat, 14 Oct 2023 03:01:50 -0700 (PDT)
Received: from [192.168.10.118] ([2001:b07:6468:f312:5e2c:eb9a:a8b6:fd3e])
 by smtp.gmail.com with ESMTPSA id
 mr8-20020a170907828800b009adc5802d08sm718204ejc.190.2023.10.14.03.01.49
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 14 Oct 2023 03:01:50 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 16/18] target/i386: move remaining conditional operations to
 new decoder
Date: Sat, 14 Oct 2023 12:01:18 +0200
Message-ID: <20231014100121.109817-17-pbonzini@redhat.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231014100121.109817-1-pbonzini@redhat.com>
References: <20231014100121.109817-1-pbonzini@redhat.com>
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

Move long-displacement Jcc, SETcc and CMOVcc to the new decoder.
While filling in the tables makes the code seem longer, the new
emitters are all just one line of code.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/tcg/decode-new.c.inc | 56 ++++++++++++++++++++++++++++++++
 target/i386/tcg/decode-new.h     |  1 +
 target/i386/tcg/emit.c.inc       | 10 ++++++
 target/i386/tcg/translate.c      |  4 ++-
 4 files changed, 70 insertions(+), 1 deletion(-)

diff --git a/target/i386/tcg/decode-new.c.inc b/target/i386/tcg/decode-new.c.inc
index d03bc5a9720..fdbe7bce968 100644
--- a/target/i386/tcg/decode-new.c.inc
+++ b/target/i386/tcg/decode-new.c.inc
@@ -944,6 +944,15 @@ static const X86OpEntry opcodes_0F[256] = {
     /* Incorrectly listed as Mq,Vq in the manual */
     [0x17] = X86_OP_ENTRY3(VMOVHPx_st,  M,q, None,None, V,dq, vex5 p_00_66),
 
+    [0x40] = X86_OP_ENTRY2(CMOVcc,     G,v, E,v, cpuid(CMOV)),
+    [0x41] = X86_OP_ENTRY2(CMOVcc,     G,v, E,v, cpuid(CMOV)),
+    [0x42] = X86_OP_ENTRY2(CMOVcc,     G,v, E,v, cpuid(CMOV)),
+    [0x43] = X86_OP_ENTRY2(CMOVcc,     G,v, E,v, cpuid(CMOV)),
+    [0x44] = X86_OP_ENTRY2(CMOVcc,     G,v, E,v, cpuid(CMOV)),
+    [0x45] = X86_OP_ENTRY2(CMOVcc,     G,v, E,v, cpuid(CMOV)),
+    [0x46] = X86_OP_ENTRY2(CMOVcc,     G,v, E,v, cpuid(CMOV)),
+    [0x47] = X86_OP_ENTRY2(CMOVcc,     G,v, E,v, cpuid(CMOV)),
+
     [0x50] = X86_OP_ENTRY3(MOVMSK,     G,y, None,None, U,x, vex7 p_00_66),
     [0x51] = X86_OP_GROUP3(sse_unary,  V,x, H,x, W,x, vex2_rep3 p_00_66_f3_f2), /* sqrtps */
     [0x52] = X86_OP_GROUP3(sse_unary,  V,x, H,x, W,x, vex4_rep5 p_00_f3), /* rsqrtps */
@@ -971,6 +980,24 @@ static const X86OpEntry opcodes_0F[256] = {
     [0x76] = X86_OP_ENTRY3(PCMPEQD,    V,x, H,x, W,x,  vex4 mmx avx2_256 p_00_66),
     [0x77] = X86_OP_GROUP0(0F77),
 
+    [0x80] = X86_OP_ENTRYr(Jcc, J,z),
+    [0x81] = X86_OP_ENTRYr(Jcc, J,z),
+    [0x82] = X86_OP_ENTRYr(Jcc, J,z),
+    [0x83] = X86_OP_ENTRYr(Jcc, J,z),
+    [0x84] = X86_OP_ENTRYr(Jcc, J,z),
+    [0x85] = X86_OP_ENTRYr(Jcc, J,z),
+    [0x86] = X86_OP_ENTRYr(Jcc, J,z),
+    [0x87] = X86_OP_ENTRYr(Jcc, J,z),
+
+    [0x90] = X86_OP_ENTRYw(SETcc, E,b),
+    [0x91] = X86_OP_ENTRYw(SETcc, E,b),
+    [0x92] = X86_OP_ENTRYw(SETcc, E,b),
+    [0x93] = X86_OP_ENTRYw(SETcc, E,b),
+    [0x94] = X86_OP_ENTRYw(SETcc, E,b),
+    [0x95] = X86_OP_ENTRYw(SETcc, E,b),
+    [0x96] = X86_OP_ENTRYw(SETcc, E,b),
+    [0x97] = X86_OP_ENTRYw(SETcc, E,b),
+
     [0x28] = X86_OP_ENTRY3(MOVDQ,      V,x,  None,None, W,x, vex1 p_00_66), /* MOVAPS */
     [0x29] = X86_OP_ENTRY3(MOVDQ,      W,x,  None,None, V,x, vex1 p_00_66), /* MOVAPS */
     [0x2A] = X86_OP_GROUP0(0F2A),
@@ -983,6 +1010,15 @@ static const X86OpEntry opcodes_0F[256] = {
     [0x38] = X86_OP_GROUP0(0F38),
     [0x3a] = X86_OP_GROUP0(0F3A),
 
+    [0x48] = X86_OP_ENTRY2(CMOVcc,     G,v, E,v, cpuid(CMOV)),
+    [0x49] = X86_OP_ENTRY2(CMOVcc,     G,v, E,v, cpuid(CMOV)),
+    [0x4a] = X86_OP_ENTRY2(CMOVcc,     G,v, E,v, cpuid(CMOV)),
+    [0x4b] = X86_OP_ENTRY2(CMOVcc,     G,v, E,v, cpuid(CMOV)),
+    [0x4c] = X86_OP_ENTRY2(CMOVcc,     G,v, E,v, cpuid(CMOV)),
+    [0x4d] = X86_OP_ENTRY2(CMOVcc,     G,v, E,v, cpuid(CMOV)),
+    [0x4e] = X86_OP_ENTRY2(CMOVcc,     G,v, E,v, cpuid(CMOV)),
+    [0x4f] = X86_OP_ENTRY2(CMOVcc,     G,v, E,v, cpuid(CMOV)),
+
     [0x58] = X86_OP_ENTRY3(VADD,       V,x, H,x, W,x, vex2_rep3 p_00_66_f3_f2),
     [0x59] = X86_OP_ENTRY3(VMUL,       V,x, H,x, W,x, vex2_rep3 p_00_66_f3_f2),
     [0x5a] = X86_OP_GROUP0(0F5A),
@@ -1008,6 +1044,24 @@ static const X86OpEntry opcodes_0F[256] = {
     [0x7e] = X86_OP_GROUP0(0F7E),
     [0x7f] = X86_OP_GROUP0(0F7F),
 
+    [0x88] = X86_OP_ENTRYr(Jcc, J,z),
+    [0x89] = X86_OP_ENTRYr(Jcc, J,z),
+    [0x8a] = X86_OP_ENTRYr(Jcc, J,z),
+    [0x8b] = X86_OP_ENTRYr(Jcc, J,z),
+    [0x8c] = X86_OP_ENTRYr(Jcc, J,z),
+    [0x8d] = X86_OP_ENTRYr(Jcc, J,z),
+    [0x8e] = X86_OP_ENTRYr(Jcc, J,z),
+    [0x8f] = X86_OP_ENTRYr(Jcc, J,z),
+
+    [0x98] = X86_OP_ENTRYw(SETcc, E,b),
+    [0x99] = X86_OP_ENTRYw(SETcc, E,b),
+    [0x9a] = X86_OP_ENTRYw(SETcc, E,b),
+    [0x9b] = X86_OP_ENTRYw(SETcc, E,b),
+    [0x9c] = X86_OP_ENTRYw(SETcc, E,b),
+    [0x9d] = X86_OP_ENTRYw(SETcc, E,b),
+    [0x9e] = X86_OP_ENTRYw(SETcc, E,b),
+    [0x9f] = X86_OP_ENTRYw(SETcc, E,b),
+
     [0xae] = X86_OP_GROUP0(group15),
 
     [0xc2] = X86_OP_ENTRY4(VCMP,       V,x, H,x, W,x,       vex2_rep3 p_00_66_f3_f2),
@@ -1743,6 +1797,8 @@ static bool has_cpuid_feature(DisasContext *s, X86CPUIDFeature cpuid)
     switch (cpuid) {
     case X86_FEAT_None:
         return true;
+    case X86_FEAT_CMOV:
+        return (s->cpuid_features & CPUID_CMOV);
     case X86_FEAT_F16C:
         return (s->cpuid_ext_features & CPUID_EXT_F16C);
     case X86_FEAT_FMA:
diff --git a/target/i386/tcg/decode-new.h b/target/i386/tcg/decode-new.h
index 98671579abe..663dce7384d 100644
--- a/target/i386/tcg/decode-new.h
+++ b/target/i386/tcg/decode-new.h
@@ -105,6 +105,7 @@ typedef enum X86CPUIDFeature {
     X86_FEAT_AVX2,
     X86_FEAT_BMI1,
     X86_FEAT_BMI2,
+    X86_FEAT_CMOV,
     X86_FEAT_CMPCCXADD,
     X86_FEAT_F16C,
     X86_FEAT_FMA,
diff --git a/target/i386/tcg/emit.c.inc b/target/i386/tcg/emit.c.inc
index bd5d74d81ed..edcc51e9446 100644
--- a/target/i386/tcg/emit.c.inc
+++ b/target/i386/tcg/emit.c.inc
@@ -1617,6 +1617,16 @@ static void gen_Jcc(DisasContext *s, CPUX86State *env, X86DecodedInsn *decode)
     gen_jcc(s, decode->b & 0xf, decode->immediate);
 }
 
+static void gen_SETcc(DisasContext *s, CPUX86State *env, X86DecodedInsn *decode)
+{
+    gen_setcc1(s, decode->b & 0xf, s->T0);
+}
+
+static void gen_CMOVcc(DisasContext *s, CPUX86State *env, X86DecodedInsn *decode)
+{
+    gen_cmovcc1(s, decode->b & 0xf, s->T0, s->T1);
+}
+
 static void gen_LAHF(DisasContext *s, CPUX86State *env, X86DecodedInsn *decode)
 {
     if (CODE64(s) && !(s->cpuid_ext3_features & CPUID_EXT3_LAHF_LM)) {
diff --git a/target/i386/tcg/translate.c b/target/i386/tcg/translate.c
index 2c4e680a69e..1f3cc6361c0 100644
--- a/target/i386/tcg/translate.c
+++ b/target/i386/tcg/translate.c
@@ -3186,7 +3186,9 @@ static bool disas_insn(DisasContext *s, CPUState *cpu)
 #ifndef CONFIG_USER_ONLY
         use_new &= b <= limit;
 #endif
-        if (use_new && 0) {
+        if (use_new &&
+	    ((b >= 0x140 && b <= 0x14f) ||
+	     (b >= 0x180 && b <= 0x19f))) {
             disas_insn_new(s, cpu, b);
             return true;
         }
-- 
2.41.0



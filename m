Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 88B627C9411
	for <lists+qemu-devel@lfdr.de>; Sat, 14 Oct 2023 12:08:13 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qrbTH-0002c6-BN; Sat, 14 Oct 2023 06:02:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qrbT7-0002aU-8X
 for qemu-devel@nongnu.org; Sat, 14 Oct 2023 06:02:02 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qrbT5-000426-12
 for qemu-devel@nongnu.org; Sat, 14 Oct 2023 06:02:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697277718;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=qsD5wtu/TdqXR+WQTdnduyQC76Rdt0pgpfqmcEbH0mI=;
 b=jD8faukkT0ZJaJzjO43AV37rzd3TI3GBKP/xv0uHvPSr1KR1bgp7CoWEhtKBuGa8iMz72M
 eRuK+xI45iPoRB3hoxq4O5BgxSAwHLmUFcU+0vWhHP8jXDEIh5iHoJuAp7Zt0hezEQtlM1
 4WIgL7sirpr+fSfG8z6llAugoMJKUc8=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-20-wa6-nR7DPjeT5WVVqsQPCg-1; Sat, 14 Oct 2023 06:01:51 -0400
X-MC-Unique: wa6-nR7DPjeT5WVVqsQPCg-1
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-326f05ed8f9so1832541f8f.0
 for <qemu-devel@nongnu.org>; Sat, 14 Oct 2023 03:01:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697277709; x=1697882509;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=qsD5wtu/TdqXR+WQTdnduyQC76Rdt0pgpfqmcEbH0mI=;
 b=sOmK8WFCiYxEZ1O+BvKJ7orzyX5w3e3h0YciC5PdXTauWTyLmN5LwU+I34AU99OrI0
 J081fAwEqpJX/cgq84at+xqpWsr6eIqecn3JKzfd1GiP+EXjzUa5mZTeo+jN/HxV+K+x
 MLqI6Io4ZXuZE5WJM/lTw+0asmb77T7VrOeGMPlXAlI6ehLHcYDf7UL4kuRegtOJKcN1
 FrCfXFj9g95Llb4JxblH8U7j2cMr6VSMXSi7EVERrOXJtl44Mh2xo2oNCYPSuK1d21Vh
 FgB1OMlCqoGnV7GYVzMLvLWlmvDCmQRATTRn+Ev+8LV9vs1iTbjxhQyaORuQhnKr+zzD
 wR4Q==
X-Gm-Message-State: AOJu0Ywmxmv086/dvRrDCnCBYMWD12r6gPyoMRILm7S7DAVpd9r3hFS2
 YkmVoqdf0+vRmwjlWcGmABJNNmFZcyP6EeFUmYoCUXdXRB6nNiVJIjIpwAjeqJavH8iasC87xoW
 N1wHVpPkY6/wykNnCPem/FV1fT/PknpzwxL1s01EeCGmKCJ+UblDObk7mlNVMQQsYMS64qGVIE7
 4=
X-Received: by 2002:adf:9bc8:0:b0:32d:850d:f9b1 with SMTP id
 e8-20020adf9bc8000000b0032d850df9b1mr8235123wrc.22.1697277709629; 
 Sat, 14 Oct 2023 03:01:49 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGEndRnj1MdMZhw4X74cLo21umPPJHH2dwB1XhuVZ/okCrcx6Uypk2PAZ8qzDtdqEI/ikV/xw==
X-Received: by 2002:adf:9bc8:0:b0:32d:850d:f9b1 with SMTP id
 e8-20020adf9bc8000000b0032d850df9b1mr8235109wrc.22.1697277709349; 
 Sat, 14 Oct 2023 03:01:49 -0700 (PDT)
Received: from [192.168.10.118] ([2001:b07:6468:f312:5e2c:eb9a:a8b6:fd3e])
 by smtp.gmail.com with ESMTPSA id
 r15-20020a170906c28f00b009932337747esm713746ejz.86.2023.10.14.03.01.48
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 14 Oct 2023 03:01:48 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 15/18] target/i386: move operand load and writeback out of
 gen_cmovcc1
Date: Sat, 14 Oct 2023 12:01:17 +0200
Message-ID: <20231014100121.109817-16-pbonzini@redhat.com>
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

Similar to gen_setcc1, make gen_cmovcc1 receive TCGv.  This is more friendly
to simultaneous implementation in the old and the new decoder.

A small wart is that s->T0 of CMOV is currently the *second* argument (which
would ordinarily be in T1).  Therefore, the condition as to be inverted in
order to overwrite s->T0 with cpu_regs[reg] if the MOV is not performed.

This only applies to the old decoder, and this code will go away soon.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/tcg/translate.c | 20 ++++++++------------
 1 file changed, 8 insertions(+), 12 deletions(-)

diff --git a/target/i386/tcg/translate.c b/target/i386/tcg/translate.c
index 9c799b5a980..2c4e680a69e 100644
--- a/target/i386/tcg/translate.c
+++ b/target/i386/tcg/translate.c
@@ -2503,26 +2503,20 @@ static void gen_jcc(DisasContext *s, int b, int diff)
     gen_jmp_rel(s, s->dflag, diff, 0);
 }
 
-static void gen_cmovcc1(CPUX86State *env, DisasContext *s, MemOp ot, int b,
-                        int modrm, int reg)
+static void gen_cmovcc1(DisasContext *s, int b, TCGv dest, TCGv src)
 {
     CCPrepare cc;
 
-    gen_ldst_modrm(env, s, modrm, ot, OR_TMP0, 0);
-
-    cc = gen_prepare_cc(s, b, s->T1);
+    cc = gen_prepare_cc(s, b, s->tmp4);
     if (cc.mask != -1) {
-        TCGv t0 = tcg_temp_new();
-        tcg_gen_andi_tl(t0, cc.reg, cc.mask);
-        cc.reg = t0;
+        tcg_gen_andi_tl(s->tmp4, cc.reg, cc.mask);
+        cc.reg = s->tmp4;
     }
     if (!cc.use_reg2) {
         cc.reg2 = tcg_constant_tl(cc.imm);
     }
 
-    tcg_gen_movcond_tl(cc.cond, s->T0, cc.reg, cc.reg2,
-                       s->T0, cpu_regs[reg]);
-    gen_op_mov_reg_v(s, ot, reg, s->T0);
+    tcg_gen_movcond_tl(cc.cond, dest, cc.reg, cc.reg2, src, dest);
 }
 
 static inline void gen_op_movl_T0_seg(DisasContext *s, X86Seg seg_reg)
@@ -5265,7 +5259,9 @@ static bool disas_insn(DisasContext *s, CPUState *cpu)
         ot = dflag;
         modrm = x86_ldub_code(env, s);
         reg = ((modrm >> 3) & 7) | REX_R(s);
-        gen_cmovcc1(env, s, ot, b, modrm, reg);
+        gen_ldst_modrm(env, s, modrm, ot, OR_TMP0, 0);
+        gen_cmovcc1(s, b ^ 1, s->T0, cpu_regs[reg]);
+        gen_op_mov_reg_v(s, ot, reg, s->T0);
         break;
 
         /************************/
-- 
2.41.0



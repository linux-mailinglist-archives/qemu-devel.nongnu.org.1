Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D08B7820A7F
	for <lists+qemu-devel@lfdr.de>; Sun, 31 Dec 2023 09:47:44 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rJrSY-0004ih-6r; Sun, 31 Dec 2023 03:46:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rJrSW-0004iF-C6
 for qemu-devel@nongnu.org; Sun, 31 Dec 2023 03:46:12 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rJrST-0000ly-Kg
 for qemu-devel@nongnu.org; Sun, 31 Dec 2023 03:46:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1704012369;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=sbo91zdXss9mJLjPtIADMeyGL+XIwvCY0Mp2YSHKqeY=;
 b=C1tAWCuHUpCP5CYaAba7N21g+uFnq4cfjvJ7ZmvEMUWImKK8DfVZoa6JkUb2U+9Ff+mtMC
 92WD/ByynviFgIQBnPmoVj+UISnwYUgrU4D+e1IMPwm/pCHmhQntl5STB8Ptp45MVPeBbM
 z3I1q1UpJY/bpj0rUXRIot3/oU4RQS8=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-344-DFed4cmBOCaKfdChjlkzPA-1; Sun, 31 Dec 2023 03:46:02 -0500
X-MC-Unique: DFed4cmBOCaKfdChjlkzPA-1
Received: by mail-ed1-f69.google.com with SMTP id
 4fb4d7f45d1cf-55551f775b9so1473643a12.2
 for <qemu-devel@nongnu.org>; Sun, 31 Dec 2023 00:46:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704012360; x=1704617160;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=sbo91zdXss9mJLjPtIADMeyGL+XIwvCY0Mp2YSHKqeY=;
 b=f3sbNkC4T2B1NTf9VsfrsEAPy9AuFBuqoqaDDxYkKXadiqIOK7wupklh67Sw3IV2S9
 S4iathRYKgUDOYHDsrNv/znGId3PhkAyBzbNSCsd7c76qHhF4FymrIQpZduW8iZkyfW2
 cuR2pFVSm5fVYwhP/0QSe7lRqs7+B4cQ7NjORUiVUhJp+q9aFT3ga64KU3uqoLF7hzKO
 PLWDAz6Xk2PlgPntT7W8HvTjtPqg4b9YOXyvKNzYKsm9HgQhIfak6PQdFGn48l+r/b0z
 7v5e1bYxjkzhXIu0CNGjwxrxknaqIll+YXx/Ynv4lw9xgbnaE6v5xMcN1XsRDUm9Ks6W
 zGpw==
X-Gm-Message-State: AOJu0YzyZLRj5DRVxTXK47UuPfdCptYyYGtiF+ktjczyMa649JYFX0S0
 8VpO17K2pzotPLbk58UY7yUwDRpDsizQv5xTHEVRYn7MmN85mS7ZSdwXmi8JqVGBdOqgli+Fh+X
 ugZigj1x/vEHbC/Ive7VCMSdIvxFv/0K5kNX2kwJ1VC3pc0Z3goUcQsLfzC234nn6VsStIp6nXj
 VbX5QzhjI=
X-Received: by 2002:a50:d61d:0:b0:553:56f9:a734 with SMTP id
 x29-20020a50d61d000000b0055356f9a734mr8564055edi.27.1704012360529; 
 Sun, 31 Dec 2023 00:46:00 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE4cmPJCCl9gA9EjWZfZdTAzxTEEuNBY/JDyP7tsv+pb5D32K9AUhvCVxBGSIXSFZAVQYjXiQ==
X-Received: by 2002:a50:d61d:0:b0:553:56f9:a734 with SMTP id
 x29-20020a50d61d000000b0055356f9a734mr8564048edi.27.1704012360296; 
 Sun, 31 Dec 2023 00:46:00 -0800 (PST)
Received: from [192.168.10.118] ([2001:b07:6468:f312:1c09:f536:3de6:228c])
 by smtp.gmail.com with ESMTPSA id
 fe1-20020a056402390100b0055515b40464sm2540460edb.81.2023.12.31.00.45.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 31 Dec 2023 00:45:59 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 19/46] target/i386: move operand load and writeback out of
 gen_cmovcc1
Date: Sun, 31 Dec 2023 09:44:35 +0100
Message-ID: <20231231084502.235366-20-pbonzini@redhat.com>
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

Similar to gen_setcc1, make gen_cmovcc1 receive TCGv.  This is more friendly
to simultaneous implementation in the old and the new decoder.

A small wart is that s->T0 of CMOV is currently the *second* argument (which
would ordinarily be in T1).  Therefore, the condition has to be inverted in
order to overwrite s->T0 with cpu_regs[reg] if the MOV is not performed.

This only applies to the old decoder, and this code will go away soon.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/tcg/translate.c | 16 ++++++----------
 1 file changed, 6 insertions(+), 10 deletions(-)

diff --git a/target/i386/tcg/translate.c b/target/i386/tcg/translate.c
index ecbd80a19ad..fe82d421576 100644
--- a/target/i386/tcg/translate.c
+++ b/target/i386/tcg/translate.c
@@ -2500,14 +2500,10 @@ static void gen_jcc(DisasContext *s, int b, int diff)
     gen_jmp_rel(s, s->dflag, diff, 0);
 }
 
-static void gen_cmovcc1(CPUX86State *env, DisasContext *s, MemOp ot, int b,
-                        int modrm, int reg)
+static void gen_cmovcc1(DisasContext *s, int b, TCGv dest, TCGv src)
 {
-    CCPrepare cc;
+    CCPrepare cc = gen_prepare_cc(s, b, s->T1);
 
-    gen_ldst_modrm(env, s, modrm, ot, OR_TMP0, 0);
-
-    cc = gen_prepare_cc(s, b, s->T1);
     if (cc.mask != -1) {
         TCGv t0 = tcg_temp_new();
         tcg_gen_andi_tl(t0, cc.reg, cc.mask);
@@ -2517,9 +2513,7 @@ static void gen_cmovcc1(CPUX86State *env, DisasContext *s, MemOp ot, int b,
         cc.reg2 = tcg_constant_tl(cc.imm);
     }
 
-    tcg_gen_movcond_tl(cc.cond, s->T0, cc.reg, cc.reg2,
-                       s->T0, cpu_regs[reg]);
-    gen_op_mov_reg_v(s, ot, reg, s->T0);
+    tcg_gen_movcond_tl(cc.cond, dest, cc.reg, cc.reg2, src, dest);
 }
 
 static inline void gen_op_movl_T0_seg(DisasContext *s, X86Seg seg_reg)
@@ -5228,7 +5222,9 @@ static bool disas_insn(DisasContext *s, CPUState *cpu)
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
2.43.0



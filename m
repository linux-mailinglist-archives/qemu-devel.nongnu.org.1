Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F6907CF5AF
	for <lists+qemu-devel@lfdr.de>; Thu, 19 Oct 2023 12:49:58 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qtQZf-00017A-5Q; Thu, 19 Oct 2023 06:48:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qtQZc-00010H-UA
 for qemu-devel@nongnu.org; Thu, 19 Oct 2023 06:48:16 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qtQZb-00074Q-BX
 for qemu-devel@nongnu.org; Thu, 19 Oct 2023 06:48:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697712494;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=qsD5wtu/TdqXR+WQTdnduyQC76Rdt0pgpfqmcEbH0mI=;
 b=HdI7qS/qCQfcvAEtD1Dbe6p2V9pYiEIAkK2hf0x/X3syz3fgFFvYKJYD34zJCLfWUPVh8h
 fvwgDlFHIHnZswKLc+MZLSukvD90qBcWkpMb3vKzfTzPQ5ol8y3Frc8RSCGcnkM6DsKdi+
 ZI6NQ58Tk1o37gZf3KTN0/cNaCNewIA=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-455-o7CZbpLmNV66WU90zsmCjA-1; Thu, 19 Oct 2023 06:48:12 -0400
X-MC-Unique: o7CZbpLmNV66WU90zsmCjA-1
Received: by mail-ej1-f72.google.com with SMTP id
 a640c23a62f3a-9c749c28651so124065466b.0
 for <qemu-devel@nongnu.org>; Thu, 19 Oct 2023 03:48:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697712491; x=1698317291;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=qsD5wtu/TdqXR+WQTdnduyQC76Rdt0pgpfqmcEbH0mI=;
 b=ql1yWALldcMs+72leS3qiP2Ba9OwhiKw5yUgNvJZIlwCpmCx90K34Nbe3JQ0Bd12n2
 FE4ayJZDRcdmgsXZXJ+UAhpXVXIAVxyvfMq9FAve2Xs/eixrpnX59ceJbGPLZNhWXJES
 W1X+AfSseDeTNnWHoQgq7YNoc4VAq9zG79zVmW2peaHSTtFyQHrlhHaqUsZpFaoTWr4o
 7pIpEaAAvpaXUqmZRxw43nG5hvG6GehZ2bJtV+Hxspfdu8Afi+QHsFD/1Bd7A0uMsgov
 wJRMg3I2nTuOOgzRgKJNwjpvH1D+P15MryF0xaDF1gAvvfgs06V6ZPCp0XRT6QtWwns7
 5VMA==
X-Gm-Message-State: AOJu0YwapFvQ6KVRjJv5BCHzUknS8yBO4gG6ZEcEVmHg4Y3W+clKs5/W
 exINijt3OrPlclQM/wonjN9DN1ZVyD8iBx897mLUZPQ6EPbfwu9EGuR+oPhxfpincO3N434LQCB
 nGtsQWLjnCXw1ND74kUAeIfFgATv8FqAgvOUUYv8CCADPqShkB5iXXXXamNJCH4xfJ9v3TuVmkh
 I=
X-Received: by 2002:a17:907:2cc4:b0:9a1:c991:a521 with SMTP id
 hg4-20020a1709072cc400b009a1c991a521mr1340954ejc.4.1697712490986; 
 Thu, 19 Oct 2023 03:48:10 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH56xMRwCPRo5trlv9K71mRSwMEkMwuTHovGdi4o0YkH5GZQetquo40Gg208Wzir9MlkAI9DQ==
X-Received: by 2002:a17:907:2cc4:b0:9a1:c991:a521 with SMTP id
 hg4-20020a1709072cc400b009a1c991a521mr1340944ejc.4.1697712490569; 
 Thu, 19 Oct 2023 03:48:10 -0700 (PDT)
Received: from [192.168.10.118] ([2001:b07:6468:f312:5e2c:eb9a:a8b6:fd3e])
 by smtp.gmail.com with ESMTPSA id
 a15-20020a170906684f00b00997d7aa59fasm3371501ejs.14.2023.10.19.03.48.09
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Oct 2023 03:48:10 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 16/19] target/i386: move operand load and writeback out of
 gen_cmovcc1
Date: Thu, 19 Oct 2023 12:48:04 +0200
Message-ID: <20231019104807.390468-2-pbonzini@redhat.com>
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



Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9084E820A7E
	for <lists+qemu-devel@lfdr.de>; Sun, 31 Dec 2023 09:47:29 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rJrSM-0004f5-I0; Sun, 31 Dec 2023 03:46:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rJrSK-0004XD-Gx
 for qemu-devel@nongnu.org; Sun, 31 Dec 2023 03:46:00 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rJrSI-0000lG-Qz
 for qemu-devel@nongnu.org; Sun, 31 Dec 2023 03:46:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1704012357;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=zribToKGeDZ5CRWNtBbfYDmQyIjUPcLOpYcWQvvi/4E=;
 b=JUHz3EJX8N6n/PEBqDOgk7OV5JgLA5IrXzfNqICX5akhdj6uG5Bu9tigRElI4Vf157cVKj
 eEFiN/UOhcrHov+ueXSuyAqnFjAVwMjFrONTJ03NsXfLC156EOSsi2HIMlKAeryBngnhuk
 qmx6sIq3FPmBdmV2ITtsk3hfeOTP8V4=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-85-fsHCVkXDM3C1yNHGdoLXsA-1; Sun, 31 Dec 2023 03:45:56 -0500
X-MC-Unique: fsHCVkXDM3C1yNHGdoLXsA-1
Received: by mail-lf1-f70.google.com with SMTP id
 2adb3069b0e04-50e7f717704so3688501e87.3
 for <qemu-devel@nongnu.org>; Sun, 31 Dec 2023 00:45:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704012354; x=1704617154;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=zribToKGeDZ5CRWNtBbfYDmQyIjUPcLOpYcWQvvi/4E=;
 b=Pb8bbI2iW+CZj78f/ktLxt45smFJl0AMydD9S6HgS0jnaqGApsPFeBtKTqYS7uK9xm
 dbQtZ2jtAyovGFZeY3Pb8zLUXwNJ3BAK22oTWzH+ACfag8sWju2gcEB9DTCUrE+uKmWy
 +9xTHZVBGvin5rWQBrOlP0rXjRaoYbwzFMc/ULRWV1lcgzezYHAPW/di4RmrLcNJYpiA
 y+BjJobf2M8vXGzJQ71BSlcsPQlAxA9OYGaKBpFj6eOa+6Brh0fp1ICESfkD0ag6cUvp
 BNTCStY6V0Iz5N+J4nLSzThvU0zrhwkP/EapcYXLeA8l0stWPMeTmlA8KfVmS4rLkmC2
 vlNQ==
X-Gm-Message-State: AOJu0YyXMecACHMo3QE+Aedv1MzZqdvG4B2bUZ2Za7HjUwrMpQmM7Gnq
 L1Zrth4cDG2EavJir4MDj45dNv4s5vNC0gJ5cPK75YDJCvzok6aOegSp2JdYS06WYJp9CfKDd+I
 9bkaoMjkK0yiQO7b6jSPp3Cy0r6Pjkn74KHwE2Rq1u5zegXJ26O+FALcEizyHAhkiSV0CnpvHLT
 Ijd7rh6nI=
X-Received: by 2002:a05:6512:3a93:b0:50e:7fe2:ab02 with SMTP id
 q19-20020a0565123a9300b0050e7fe2ab02mr4180645lfu.58.1704012354069; 
 Sun, 31 Dec 2023 00:45:54 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHAEdnU71ii/RjSS1QHIIUnc4jpZok1Hl3hw+vDy6E9D1MrnbbN3YkD3hs0lDujiHiTeTxV6Q==
X-Received: by 2002:a05:6512:3a93:b0:50e:7fe2:ab02 with SMTP id
 q19-20020a0565123a9300b0050e7fe2ab02mr4180640lfu.58.1704012353819; 
 Sun, 31 Dec 2023 00:45:53 -0800 (PST)
Received: from [192.168.10.118] ([2001:b07:6468:f312:1c09:f536:3de6:228c])
 by smtp.gmail.com with ESMTPSA id
 n4-20020a17090625c400b00a26ae76b165sm9118021ejb.115.2023.12.31.00.45.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 31 Dec 2023 00:45:52 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 18/46] target/i386: prepare for implementation of STOS/SCAS in
 new decoder
Date: Sun, 31 Dec 2023 09:44:34 +0100
Message-ID: <20231231084502.235366-19-pbonzini@redhat.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231231084502.235366-1-pbonzini@redhat.com>
References: <20231231084502.235366-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -47
X-Spam_score: -4.8
X-Spam_bar: ----
X-Spam_report: (-4.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.667,
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

Do not use gen_op, and pull the load from the accumulator into
disas_insn.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/tcg/translate.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/target/i386/tcg/translate.c b/target/i386/tcg/translate.c
index e5f71170967..ecbd80a19ad 100644
--- a/target/i386/tcg/translate.c
+++ b/target/i386/tcg/translate.c
@@ -1264,7 +1264,6 @@ static TCGLabel *gen_jz_ecx_string(DisasContext *s)
 
 static void gen_stos(DisasContext *s, MemOp ot)
 {
-    gen_op_mov_v_reg(s, MO_32, s->T0, R_EAX);
     gen_string_movl_A0_EDI(s);
     gen_op_st_v(s, ot, s->T0, s->A0);
     gen_op_add_reg(s, s->aflag, R_EDI, gen_compute_Dshift(s, ot));
@@ -1282,7 +1281,11 @@ static void gen_scas(DisasContext *s, MemOp ot)
 {
     gen_string_movl_A0_EDI(s);
     gen_op_ld_v(s, ot, s->T1, s->A0);
-    gen_op(s, OP_CMPL, ot, R_EAX);
+    tcg_gen_mov_tl(cpu_cc_src, s->T1);
+    tcg_gen_mov_tl(s->cc_srcT, s->T0);
+    tcg_gen_sub_tl(cpu_cc_dst, s->T0, s->T1);
+    set_cc_op(s, CC_OP_SUBB + ot);
+
     gen_op_add_reg(s, s->aflag, R_EDI, gen_compute_Dshift(s, ot));
 }
 
@@ -4952,6 +4955,7 @@ static bool disas_insn(DisasContext *s, CPUState *cpu)
     case 0xaa: /* stosS */
     case 0xab:
         ot = mo_b_d(b, dflag);
+        gen_op_mov_v_reg(s, MO_32, s->T0, R_EAX);
         if (prefixes & (PREFIX_REPZ | PREFIX_REPNZ)) {
             gen_repz_stos(s, ot);
         } else {
@@ -4970,6 +4974,7 @@ static bool disas_insn(DisasContext *s, CPUState *cpu)
     case 0xae: /* scasS */
     case 0xaf:
         ot = mo_b_d(b, dflag);
+        gen_op_mov_v_reg(s, MO_32, s->T0, R_EAX);
         if (prefixes & PREFIX_REPNZ) {
             gen_repz_scas(s, ot, 1);
         } else if (prefixes & PREFIX_REPZ) {
-- 
2.43.0



Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 71970820A76
	for <lists+qemu-devel@lfdr.de>; Sun, 31 Dec 2023 09:46:14 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rJrRo-0004AR-Db; Sun, 31 Dec 2023 03:45:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rJrRl-000496-8m
 for qemu-devel@nongnu.org; Sun, 31 Dec 2023 03:45:25 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rJrRj-0000fx-Fj
 for qemu-devel@nongnu.org; Sun, 31 Dec 2023 03:45:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1704012322;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=GjNgwwzVu730/bV1lM2ICBkruFVmlpplRy3eZQk5p9Q=;
 b=iU0skxCYhMrhqYAgABMAbFxmFEvyU3/WIBbv6p6Pvn1gc7hPjhOhgUyO1TyG6x1Fcey/c1
 ao+HM7aoZ0MEH7sZf9GEQT4B3bxMG1UX/7L/Gza3iyMcP88SZ9GEY6rgrF7zg2EjhLwQW/
 k3tnLWmWtaDN5ObDq4Wpgi9pt5E3ifE=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-180-VfY6OaLSOWyy2F_Rtk5CgQ-1; Sun, 31 Dec 2023 03:45:20 -0500
X-MC-Unique: VfY6OaLSOWyy2F_Rtk5CgQ-1
Received: by mail-ed1-f70.google.com with SMTP id
 4fb4d7f45d1cf-555799bcf96so1237234a12.2
 for <qemu-devel@nongnu.org>; Sun, 31 Dec 2023 00:45:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704012318; x=1704617118;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=GjNgwwzVu730/bV1lM2ICBkruFVmlpplRy3eZQk5p9Q=;
 b=AU5H2W/p1WXekfVI40ZbY5PWaQFfEfWxI9k6FKaeU4XPuR+tljrEVobIOTDKDAvFQI
 xFipdVfllJWgjE5rplheGAvus9vn59YycOzFRqOoEWeQO0T1eXjEguuA+pLCTeeYdzlK
 IoVlcCweNw8tyH72iWP7Gc+IB2PYest0bojfnRpWVaVz1Hp8Y+DBH/wELhxQLNavWakJ
 SCS6wn00to1rJZLMQqeCCWdrn7Hv6y82W2JKUsQGyh6UXYrITBO5miyKLOcHP5uAag5b
 4pKYE4eoA6OiO70wpz9tTuOsOcjTiwlqRB7ek4SffNUAynTFMUjRbHRdSNiDRC/RsANB
 eRrQ==
X-Gm-Message-State: AOJu0YyO4THmnXxSN0xblFwg/mHQY34OtnRKfZKC0wIMPfNwffwHwhU5
 os9O1Lk9R2YUCSgO88iFzNWcVzWhwjtTWQ93RUHZjNO9XmuJyVPjrxfSTTGmZtQvayevNsDKetv
 KCYM+RhD8TEC6MzVhkWEa4z+k/X17zWVOMDU6lmtlIEMD1S5OnETwjjWjWFkxH5MOgp3Q+HCSkW
 luVKaNU0w=
X-Received: by 2002:a50:aace:0:b0:553:ac74:f955 with SMTP id
 r14-20020a50aace000000b00553ac74f955mr3621777edc.4.1704012318506; 
 Sun, 31 Dec 2023 00:45:18 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFfb5t3R6aOe1lx9hurTjYJVJOog+F9fUlFcNQBzeigZ2KBT4sE1+6ktOn2JNp/JhFHuKNl8g==
X-Received: by 2002:a50:aace:0:b0:553:ac74:f955 with SMTP id
 r14-20020a50aace000000b00553ac74f955mr3621771edc.4.1704012318243; 
 Sun, 31 Dec 2023 00:45:18 -0800 (PST)
Received: from [192.168.10.118] ([2001:b07:6468:f312:1c09:f536:3de6:228c])
 by smtp.gmail.com with ESMTPSA id
 d3-20020a056402000300b00553772c2968sm13325770edu.82.2023.12.31.00.45.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 31 Dec 2023 00:45:17 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 05/46] target/i386: remove unnecessary truncations
Date: Sun, 31 Dec 2023 09:44:21 +0100
Message-ID: <20231231084502.235366-6-pbonzini@redhat.com>
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

gen_lea_v_seg (called by gen_add_A0_ds_seg) already zeroes any
bits of s->A0 beyond s->aflag.  It does so before summing the
segment base and, if not in 64-bit mode, also after summing it.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/tcg/emit.c.inc  | 4 +---
 target/i386/tcg/translate.c | 2 --
 2 files changed, 1 insertion(+), 5 deletions(-)

diff --git a/target/i386/tcg/emit.c.inc b/target/i386/tcg/emit.c.inc
index 82da5488d47..d444d83e534 100644
--- a/target/i386/tcg/emit.c.inc
+++ b/target/i386/tcg/emit.c.inc
@@ -1242,9 +1242,7 @@ static void gen_LDMXCSR(DisasContext *s, CPUX86State *env, X86DecodedInsn *decod
 
 static void gen_MASKMOV(DisasContext *s, CPUX86State *env, X86DecodedInsn *decode)
 {
-    tcg_gen_mov_tl(s->A0, cpu_regs[R_EDI]);
-    gen_extu(s->aflag, s->A0);
-    gen_add_A0_ds_seg(s);
+    gen_lea_v_seg(s, s->aflag, cpu_regs[R_EDI], R_DS, s->override);
 
     if (s->prefix & PREFIX_DATA) {
         gen_helper_maskmov_xmm(tcg_env, OP_PTR1, OP_PTR2, s->A0);
diff --git a/target/i386/tcg/translate.c b/target/i386/tcg/translate.c
index a16eb8d4008..73b83e07e23 100644
--- a/target/i386/tcg/translate.c
+++ b/target/i386/tcg/translate.c
@@ -4183,7 +4183,6 @@ static bool disas_insn(DisasContext *s, CPUState *cpu)
         tcg_gen_mov_tl(s->A0, cpu_regs[R_EBX]);
         tcg_gen_ext8u_tl(s->T0, cpu_regs[R_EAX]);
         tcg_gen_add_tl(s->A0, s->A0, s->T0);
-        gen_extu(s->aflag, s->A0);
         gen_add_A0_ds_seg(s);
         gen_op_ld_v(s, MO_8, s->T0, s->A0);
         gen_op_mov_reg_v(s, MO_8, R_EAX, s->T0);
@@ -5835,7 +5834,6 @@ static bool disas_insn(DisasContext *s, CPUState *cpu)
             gen_update_cc_op(s);
             gen_update_eip_cur(s);
             tcg_gen_mov_tl(s->A0, cpu_regs[R_EAX]);
-            gen_extu(s->aflag, s->A0);
             gen_add_A0_ds_seg(s);
             gen_helper_monitor(tcg_env, s->A0);
             break;
-- 
2.43.0



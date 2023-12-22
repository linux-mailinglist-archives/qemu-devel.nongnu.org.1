Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 180B381CE4E
	for <lists+qemu-devel@lfdr.de>; Fri, 22 Dec 2023 19:17:40 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rGk4q-00016t-8L; Fri, 22 Dec 2023 13:16:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rGk4S-0000yf-FC
 for qemu-devel@nongnu.org; Fri, 22 Dec 2023 13:16:33 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rGk4M-0006B9-GU
 for qemu-devel@nongnu.org; Fri, 22 Dec 2023 13:16:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1703268979;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Ilyjw031xwj+CmNudor3T5XwsD9EpzyKH5PL/uhck/4=;
 b=SBuQVHk7IB6DJ4cn85paYtJyLcr/AwXNAF/rWs9HaS64u+InDDu2Xfc7Dj2+B4esdPDUAp
 VAFqhZnW82XrZgRwDoEA8NI58eshJUKVqW0x6xUUQZf8qZpFMStS85s5gneMyxaAbVMK7O
 CtX/sYTCxNfxOGHWMOHyC10f76nmzZ0=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-196-lGP0W9G4MRiSWh0H_WDRUQ-1; Fri, 22 Dec 2023 13:16:17 -0500
X-MC-Unique: lGP0W9G4MRiSWh0H_WDRUQ-1
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-33689c90957so1250705f8f.2
 for <qemu-devel@nongnu.org>; Fri, 22 Dec 2023 10:16:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703268976; x=1703873776;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Ilyjw031xwj+CmNudor3T5XwsD9EpzyKH5PL/uhck/4=;
 b=hUhnXKavd8HeyWratG7yMWk8M2TSFR+HavdAskUgARJBrtr+rsGYe2GX5f68eO9ai3
 KJqtTOhXgCpHSf+yeMVFztfKPV+bwhuCichog16/DPeNoGjcKgGGqDgWDVzQxyVnJQmZ
 jGND8JTf/KY4qoes4Y1wPRm0d9rVTGX2mAHzVpiRM7y+qqiYV2jK1MxriQ5caIRpKQza
 RweSFtZ0n/gLma6h+xdUCvWpD3LtjQEbws9+WFqgQDWFLCUl6+JvX+pxWBGpEEyUpBs5
 NXiu6d/5cIIrB3Qjc8MpZ5XbctntEFIzDluDsOXHAJbAOrgMcgskBUOSkNBD97l8ZUmp
 JhkQ==
X-Gm-Message-State: AOJu0YxzJAwpGIzYqQpjCRId3Vyb7nO/akm1nI8TRHhqkZJFR+TETMq/
 TTiJBeFJZIaEkzMk4gI2GnG/U+F4Gd732UtBKt44A2eF6OY5AsRwrMNf+igucrZdZjxs+Ao+PA9
 Xwfg93YhD9Emqge/osHjMVyVRyRAtUgqV3x///OqnIjt6dh0HvNQn1km38Yzu7N40++A8x/pwxr
 gr6lwXeh8=
X-Received: by 2002:a05:600c:3d06:b0:40b:5e21:ec28 with SMTP id
 bh6-20020a05600c3d0600b0040b5e21ec28mr1057030wmb.90.1703268976253; 
 Fri, 22 Dec 2023 10:16:16 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHRRaUN8bptS55xuj8bBSmAfu//R+id/TgRAad6VlnzDsjUFYTEhIIRhJUZ+SN4xruT8JPlCw==
X-Received: by 2002:a05:600c:3d06:b0:40b:5e21:ec28 with SMTP id
 bh6-20020a05600c3d0600b0040b5e21ec28mr1057024wmb.90.1703268975903; 
 Fri, 22 Dec 2023 10:16:15 -0800 (PST)
Received: from [192.168.10.118] ([2001:b07:6468:f312:9af8:e5f5:7516:fa89])
 by smtp.gmail.com with ESMTPSA id
 fa18-20020a05600c519200b0040c4afa027csm7569810wmb.13.2023.12.22.10.16.14
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 22 Dec 2023 10:16:14 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 05/22] target/i386: clean up cpu_cc_compute_all
Date: Fri, 22 Dec 2023 19:15:46 +0100
Message-ID: <20231222181603.174137-6-pbonzini@redhat.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231222181603.174137-1-pbonzini@redhat.com>
References: <20231222181603.174137-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.082,
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

cpu_cc_compute_all() has an argument that is always equal to CC_OP for historical
reasons (dating back to commit a7812ae4123, "TCG variable type checking.", 2008-11-17,
which added the argument to helper_cc_compute_all).  It does not make sense for the
argumnt to have any other value, so remove it and clean up some lines that are not
too long anymore.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/cpu.h             |  4 ++--
 target/i386/tcg/cc_helper.c   |  6 +++---
 target/i386/tcg/fpu_helper.c  | 10 ++++------
 target/i386/tcg/int_helper.c  |  8 ++++----
 target/i386/tcg/misc_helper.c |  2 +-
 target/i386/tcg/seg_helper.c  |  8 ++++----
 6 files changed, 18 insertions(+), 20 deletions(-)

diff --git a/target/i386/cpu.h b/target/i386/cpu.h
index ef987f344cf..ecdd4518c64 100644
--- a/target/i386/cpu.h
+++ b/target/i386/cpu.h
@@ -2344,13 +2344,13 @@ void cpu_x86_inject_mce(Monitor *mon, X86CPU *cpu, int bank,
                         uint64_t status, uint64_t mcg_status, uint64_t addr,
                         uint64_t misc, int flags);
 
-uint32_t cpu_cc_compute_all(CPUX86State *env1, int op);
+uint32_t cpu_cc_compute_all(CPUX86State *env1);
 
 static inline uint32_t cpu_compute_eflags(CPUX86State *env)
 {
     uint32_t eflags = env->eflags;
     if (tcg_enabled()) {
-        eflags |= cpu_cc_compute_all(env, CC_OP) | (env->df & DF_MASK);
+        eflags |= cpu_cc_compute_all(env) | (env->df & DF_MASK);
     }
     return eflags;
 }
diff --git a/target/i386/tcg/cc_helper.c b/target/i386/tcg/cc_helper.c
index c310bd842f1..f76e9cb8cfb 100644
--- a/target/i386/tcg/cc_helper.c
+++ b/target/i386/tcg/cc_helper.c
@@ -220,9 +220,9 @@ target_ulong helper_cc_compute_all(target_ulong dst, target_ulong src1,
     }
 }
 
-uint32_t cpu_cc_compute_all(CPUX86State *env, int op)
+uint32_t cpu_cc_compute_all(CPUX86State *env)
 {
-    return helper_cc_compute_all(CC_DST, CC_SRC, CC_SRC2, op);
+    return helper_cc_compute_all(CC_DST, CC_SRC, CC_SRC2, CC_OP);
 }
 
 target_ulong helper_cc_compute_c(target_ulong dst, target_ulong src1,
@@ -335,7 +335,7 @@ target_ulong helper_read_eflags(CPUX86State *env)
 {
     uint32_t eflags;
 
-    eflags = cpu_cc_compute_all(env, CC_OP);
+    eflags = cpu_cc_compute_all(env);
     eflags |= (env->df & DF_MASK);
     eflags |= env->eflags & ~(VM_MASK | RF_MASK);
     return eflags;
diff --git a/target/i386/tcg/fpu_helper.c b/target/i386/tcg/fpu_helper.c
index 4430d3d380c..4b965a5d6c4 100644
--- a/target/i386/tcg/fpu_helper.c
+++ b/target/i386/tcg/fpu_helper.c
@@ -484,9 +484,8 @@ void helper_fcomi_ST0_FT0(CPUX86State *env)
     FloatRelation ret;
 
     ret = floatx80_compare(ST0, FT0, &env->fp_status);
-    eflags = cpu_cc_compute_all(env, CC_OP);
-    eflags = (eflags & ~(CC_Z | CC_P | CC_C)) | fcomi_ccval[ret + 1];
-    CC_SRC = eflags;
+    eflags = cpu_cc_compute_all(env) & ~(CC_Z | CC_P | CC_C);
+    CC_SRC = eflags | fcomi_ccval[ret + 1];
     merge_exception_flags(env, old_flags);
 }
 
@@ -497,9 +496,8 @@ void helper_fucomi_ST0_FT0(CPUX86State *env)
     FloatRelation ret;
 
     ret = floatx80_compare_quiet(ST0, FT0, &env->fp_status);
-    eflags = cpu_cc_compute_all(env, CC_OP);
-    eflags = (eflags & ~(CC_Z | CC_P | CC_C)) | fcomi_ccval[ret + 1];
-    CC_SRC = eflags;
+    eflags = cpu_cc_compute_all(env) & ~(CC_Z | CC_P | CC_C);
+    CC_SRC = eflags | fcomi_ccval[ret + 1];
     merge_exception_flags(env, old_flags);
 }
 
diff --git a/target/i386/tcg/int_helper.c b/target/i386/tcg/int_helper.c
index 05418f181f1..ab85dc55400 100644
--- a/target/i386/tcg/int_helper.c
+++ b/target/i386/tcg/int_helper.c
@@ -190,7 +190,7 @@ void helper_aaa(CPUX86State *env)
     int al, ah, af;
     int eflags;
 
-    eflags = cpu_cc_compute_all(env, CC_OP);
+    eflags = cpu_cc_compute_all(env);
     af = eflags & CC_A;
     al = env->regs[R_EAX] & 0xff;
     ah = (env->regs[R_EAX] >> 8) & 0xff;
@@ -214,7 +214,7 @@ void helper_aas(CPUX86State *env)
     int al, ah, af;
     int eflags;
 
-    eflags = cpu_cc_compute_all(env, CC_OP);
+    eflags = cpu_cc_compute_all(env);
     af = eflags & CC_A;
     al = env->regs[R_EAX] & 0xff;
     ah = (env->regs[R_EAX] >> 8) & 0xff;
@@ -237,7 +237,7 @@ void helper_daa(CPUX86State *env)
     int old_al, al, af, cf;
     int eflags;
 
-    eflags = cpu_cc_compute_all(env, CC_OP);
+    eflags = cpu_cc_compute_all(env);
     cf = eflags & CC_C;
     af = eflags & CC_A;
     old_al = al = env->regs[R_EAX] & 0xff;
@@ -264,7 +264,7 @@ void helper_das(CPUX86State *env)
     int al, al1, af, cf;
     int eflags;
 
-    eflags = cpu_cc_compute_all(env, CC_OP);
+    eflags = cpu_cc_compute_all(env);
     cf = eflags & CC_C;
     af = eflags & CC_A;
     al = env->regs[R_EAX] & 0xff;
diff --git a/target/i386/tcg/misc_helper.c b/target/i386/tcg/misc_helper.c
index 66b332a83c1..b0f0f7b893b 100644
--- a/target/i386/tcg/misc_helper.c
+++ b/target/i386/tcg/misc_helper.c
@@ -41,7 +41,7 @@ void helper_into(CPUX86State *env, int next_eip_addend)
 {
     int eflags;
 
-    eflags = cpu_cc_compute_all(env, CC_OP);
+    eflags = cpu_cc_compute_all(env);
     if (eflags & CC_O) {
         raise_interrupt(env, EXCP04_INTO, next_eip_addend);
     }
diff --git a/target/i386/tcg/seg_helper.c b/target/i386/tcg/seg_helper.c
index eb29a1fd4e7..34ccabd8ce3 100644
--- a/target/i386/tcg/seg_helper.c
+++ b/target/i386/tcg/seg_helper.c
@@ -2230,7 +2230,7 @@ target_ulong helper_lsl(CPUX86State *env, target_ulong selector1)
     int rpl, dpl, cpl, type;
 
     selector = selector1 & 0xffff;
-    eflags = cpu_cc_compute_all(env, CC_OP);
+    eflags = cpu_cc_compute_all(env);
     if ((selector & 0xfffc) == 0) {
         goto fail;
     }
@@ -2277,7 +2277,7 @@ target_ulong helper_lar(CPUX86State *env, target_ulong selector1)
     int rpl, dpl, cpl, type;
 
     selector = selector1 & 0xffff;
-    eflags = cpu_cc_compute_all(env, CC_OP);
+    eflags = cpu_cc_compute_all(env);
     if ((selector & 0xfffc) == 0) {
         goto fail;
     }
@@ -2326,7 +2326,7 @@ void helper_verr(CPUX86State *env, target_ulong selector1)
     int rpl, dpl, cpl;
 
     selector = selector1 & 0xffff;
-    eflags = cpu_cc_compute_all(env, CC_OP);
+    eflags = cpu_cc_compute_all(env);
     if ((selector & 0xfffc) == 0) {
         goto fail;
     }
@@ -2364,7 +2364,7 @@ void helper_verw(CPUX86State *env, target_ulong selector1)
     int rpl, dpl, cpl;
 
     selector = selector1 & 0xffff;
-    eflags = cpu_cc_compute_all(env, CC_OP);
+    eflags = cpu_cc_compute_all(env);
     if ((selector & 0xfffc) == 0) {
         goto fail;
     }
-- 
2.43.0



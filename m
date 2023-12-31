Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 188A9820A80
	for <lists+qemu-devel@lfdr.de>; Sun, 31 Dec 2023 09:48:27 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rJrRs-0004BO-Mk; Sun, 31 Dec 2023 03:45:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rJrRp-0004An-TT
 for qemu-devel@nongnu.org; Sun, 31 Dec 2023 03:45:29 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rJrRn-0000gj-Ua
 for qemu-devel@nongnu.org; Sun, 31 Dec 2023 03:45:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1704012325;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=UiJQw4h5qdgMkaU9Yz0qPWeB2jtObPoDMp0iHeFW3so=;
 b=ToINu3KTv0FYy637MVsZ1a5TW7T9Ua26RyZh4AtMSs6WEYcyvgK38g6VaQ7TH1XNZp+B9G
 nsb8Zp/SgWVqadF4fh4t8r/NfUNnstU2A5MHgdFigJKWTaynIn/583CjpkRVvcnlQYRW3N
 bUyp8kZSIS6gX0iU0rYCNravYslzfMc=
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com
 [209.85.167.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-218-MwMimh1SM-qOeR1sAUXJaw-1; Sun, 31 Dec 2023 03:45:22 -0500
X-MC-Unique: MwMimh1SM-qOeR1sAUXJaw-1
Received: by mail-lf1-f69.google.com with SMTP id
 2adb3069b0e04-50e86a0debcso3010455e87.1
 for <qemu-devel@nongnu.org>; Sun, 31 Dec 2023 00:45:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704012321; x=1704617121;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=UiJQw4h5qdgMkaU9Yz0qPWeB2jtObPoDMp0iHeFW3so=;
 b=TSVk+oKtSbjysIKMHTHTT7LkUAGK60kmwh7WeWRw9YLHh3Jyo6s8i+1qqwR3wD40J6
 9dlxSNiCn4AZSBvrIObpb5WeC3XJSQ99d91vIpJsGip+V43RSlTPNMDl4f49ICH22W4r
 sUX5OEoJcEgAVnZS0CiR8mUvqIgWo1P7b3Wpjf+YQOM+njlTRnr5lP+Bb7fF97dc8qau
 gmo28Yx1E+xrboSlXb0Y3M2NDmI+WDbH8pwvRcZ7jCna7PH1qUUYYu4kjror4NQ5do4H
 VAqpFJYj1Sy/DqFPfSXUD2B6XygD2r2rz6x4xHwxiiqiA6OYanQ0WCItU4L5FxkYVsDp
 epPA==
X-Gm-Message-State: AOJu0Yy8wKFbf3epXjUd/KoD9oLIT1LWFdp/96xqF0lTrzExADaMX8cN
 zzEDRuzPsWxcii+GAOG9vHy1daoT+qOS/OQTdRWSlAy4b1szBeHlb13stVmy4zdfD14xX9pIsWG
 Kn0X9MrHXUok8HBE124jMG98atWI+9z53S1n/eiX+uyCqoyYF8AJzW/aDuM5VrHjijhvQep30QA
 O8Adh8V8k=
X-Received: by 2002:a2e:9049:0:b0:2cc:7849:f4b with SMTP id
 n9-20020a2e9049000000b002cc78490f4bmr6842783ljg.97.1704012320965; 
 Sun, 31 Dec 2023 00:45:20 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHMG0FWJkuoun82FonpUv+QfHtBbrbj1obdr+eGQyRuwltuRRsFx+5LsnkN3kZ6uE1p8VWoRQ==
X-Received: by 2002:a2e:9049:0:b0:2cc:7849:f4b with SMTP id
 n9-20020a2e9049000000b002cc78490f4bmr6842778ljg.97.1704012320688; 
 Sun, 31 Dec 2023 00:45:20 -0800 (PST)
Received: from [192.168.10.118] ([2001:b07:6468:f312:1c09:f536:3de6:228c])
 by smtp.gmail.com with ESMTPSA id
 d33-20020a056402402100b0055422adeb00sm13027066eda.33.2023.12.31.00.45.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 31 Dec 2023 00:45:20 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 06/46] target/i386: clean up cpu_cc_compute_all
Date: Sun, 31 Dec 2023 09:44:22 +0100
Message-ID: <20231231084502.235366-7-pbonzini@redhat.com>
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

cpu_cc_compute_all() has an argument that is always equal to CC_OP for historical
reasons (dating back to commit a7812ae4123, "TCG variable type checking.", 2008-11-17,
which added the argument to helper_cc_compute_all).  It does not make sense for the
argument to have any other value, so remove it and clean up some lines that are not
too long anymore.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
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



Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D8546737039
	for <lists+qemu-devel@lfdr.de>; Tue, 20 Jun 2023 17:19:31 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qBd6R-0003V9-8w; Tue, 20 Jun 2023 11:17:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qBd6N-0003T4-Nl
 for qemu-devel@nongnu.org; Tue, 20 Jun 2023 11:17:03 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qBd6M-0007RI-3X
 for qemu-devel@nongnu.org; Tue, 20 Jun 2023 11:17:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1687274217;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1yQGJOJH5E0evmmsxwhXY7D8JxT5voX5YNPd1lrrQUk=;
 b=RNe8ReI4eMw/zzceZ/pkGaNHHRi0iU61gxiE9sAswGEs8tZL5XJm1VzTDWuubn3a1Ag5Ie
 G2liOUp3kJJIrkF5nNldpkn0fgB6PWSBJnydVkb8DR3mXgsQ2QoJhEV1LYdCYhCchUb57B
 Qajz8P7mF8E8gd7ctwR45UXGq2b6XRQ=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-205-orTh_j6qNfa2QYmOFVIy1w-1; Tue, 20 Jun 2023 11:16:53 -0400
X-MC-Unique: orTh_j6qNfa2QYmOFVIy1w-1
Received: by mail-ej1-f71.google.com with SMTP id
 a640c23a62f3a-977e6c94186so311835966b.1
 for <qemu-devel@nongnu.org>; Tue, 20 Jun 2023 08:16:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687274211; x=1689866211;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=1yQGJOJH5E0evmmsxwhXY7D8JxT5voX5YNPd1lrrQUk=;
 b=D3hUtRkVj8fVFRBfVTWgWD7wzYySnO3hX5DzaZ7Bl4UU+wjoa8JWoONp32/kkqmje6
 HoMV/GGdeSDwsdAFzzDmrYybrV57yftGLbQHh+SyIqtvC3Y75tMNKT6Ldm1YI/wZGZMG
 R7be+Qca2LyxfiTbYBPxy5i8dPkzvmJPPQmVRS48X78odKSzG5cVHcIyKKeCON0NBG9y
 M0vf/nxogxrLgj0CR5QeNR0wW6zGpDdaYXDRcASNQZOP0D5RvCH+U4dLHfF4KY3b6ICD
 3FlaUa1nqhQh1vSXUK2PvBHls6Ky5aRyr1KdbFZytqAbT7kZNQ9JWeX/zTebruG01MlY
 aIvg==
X-Gm-Message-State: AC+VfDzYaggRUk0E8RtGgjkR0cyEfzXTHo25v8UBBTeMprgm7+dFh7Np
 fU15lfE8QE0jOrIsW7VJZr08YMsLTJjO3/u745NjW5kONhok3AQxLI1kLmkkwa7aWG+wIuduzRh
 pZ1AFa25/6sgisfUl6fdizY1vDAp7AmugfXoXQOSfj/HG2pLSk73uU7yFYrUPafxNg2bJYqF9nv
 I=
X-Received: by 2002:a17:907:7248:b0:987:648b:5914 with SMTP id
 ds8-20020a170907724800b00987648b5914mr9121831ejc.29.1687274210778; 
 Tue, 20 Jun 2023 08:16:50 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ5okghmFoG550v1CvAAuTnq825eYpZIEo3rB5j8IbjfwXm/m4Tm0yUwCsUF2S1btRmS2M00Dg==
X-Received: by 2002:a17:907:7248:b0:987:648b:5914 with SMTP id
 ds8-20020a170907724800b00987648b5914mr9121820ejc.29.1687274210556; 
 Tue, 20 Jun 2023 08:16:50 -0700 (PDT)
Received: from [192.168.1.72] ([2001:b07:add:ec09:c399:bc87:7b6c:fb2a])
 by smtp.gmail.com with ESMTPSA id
 cf14-20020a170906b2ce00b00984822540c9sm1521273ejb.96.2023.06.20.08.16.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 20 Jun 2023 08:16:50 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org
Subject: [PATCH v2 08/10] target/i386: implement 32-bit SYSCALL for linux-user
Date: Tue, 20 Jun 2023 17:16:32 +0200
Message-Id: <20230620151634.21053-9-pbonzini@redhat.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230620151634.21053-1-pbonzini@redhat.com>
References: <20230620151634.21053-1-pbonzini@redhat.com>
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
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

TCG supports both 32-bit and 64-bit SYSCALL, but the linux-user
code only exposes it for 64-bit.  The ABI is the same as "int $80",
so expose it even for 32-bit emulators, where it can be used if the
vendor is specified as AMD.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 linux-user/i386/cpu_loop.c        | 3 +++
 target/i386/cpu.c                 | 8 +++++++-
 target/i386/helper.h              | 2 +-
 target/i386/tcg/translate.c       | 2 +-
 target/i386/tcg/user/seg_helper.c | 2 --
 5 files changed, 12 insertions(+), 5 deletions(-)

diff --git a/linux-user/i386/cpu_loop.c b/linux-user/i386/cpu_loop.c
index 2d0918a93ff..6908bad14aa 100644
--- a/linux-user/i386/cpu_loop.c
+++ b/linux-user/i386/cpu_loop.c
@@ -211,6 +211,9 @@ void cpu_loop(CPUX86State *env)
 
         switch(trapnr) {
         case 0x80:
+#ifdef TARGET_ABI32
+        case EXCP_SYSCALL:
+#endif
             /* linux syscall from int $0x80 */
             ret = do_syscall(env,
                              env->regs[R_EAX],
diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 978d24b5ec7..934360e4091 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -642,10 +642,16 @@ void x86_cpu_vendor_words2str(char *dst, uint32_t vendor1,
 #define TCG_EXT2_X86_64_FEATURES 0
 #endif
 
+#if defined CONFIG_SOFTMMU || defined CONFIG_LINUX_USER
+#define TCG_EXT2_NOBSD_FEATURES CPUID_EXT2_SYSCALL
+#else
+#define TCG_EXT2_NOBSD_FEATURES 0
+#endif
+
 #define TCG_EXT2_FEATURES ((TCG_FEATURES & CPUID_EXT2_AMD_ALIASES) | \
           CPUID_EXT2_NX | CPUID_EXT2_MMXEXT | CPUID_EXT2_RDTSCP | \
           CPUID_EXT2_3DNOW | CPUID_EXT2_3DNOWEXT | CPUID_EXT2_PDPE1GB | \
-          TCG_EXT2_X86_64_FEATURES)
+          TCG_EXT2_NOBSD_FEATURES | TCG_EXT2_X86_64_FEATURES)
 #define TCG_EXT3_FEATURES (CPUID_EXT3_LAHF_LM | CPUID_EXT3_SVM | \
           CPUID_EXT3_CR8LEG | CPUID_EXT3_ABM | CPUID_EXT3_SSE4A | \
           CPUID_EXT3_3DNOWPREFETCH)
diff --git a/target/i386/helper.h b/target/i386/helper.h
index e627a931073..c2e86c6119c 100644
--- a/target/i386/helper.h
+++ b/target/i386/helper.h
@@ -51,8 +51,8 @@ DEF_HELPER_FLAGS_2(get_dr, TCG_CALL_NO_WG, tl, env, int)
 
 DEF_HELPER_1(sysenter, void, env)
 DEF_HELPER_2(sysexit, void, env, int)
-#ifdef TARGET_X86_64
 DEF_HELPER_2(syscall, void, env, int)
+#ifdef TARGET_X86_64
 DEF_HELPER_2(sysret, void, env, int)
 #endif
 DEF_HELPER_FLAGS_2(pause, TCG_CALL_NO_WG, noreturn, env, int)
diff --git a/target/i386/tcg/translate.c b/target/i386/tcg/translate.c
index c58f5f24ab3..0ddb689444e 100644
--- a/target/i386/tcg/translate.c
+++ b/target/i386/tcg/translate.c
@@ -5682,7 +5682,6 @@ static bool disas_insn(DisasContext *s, CPUState *cpu)
             s->base.is_jmp = DISAS_EOB_ONLY;
         }
         break;
-#ifdef TARGET_X86_64
     case 0x105: /* syscall */
         /* For Intel SYSCALL is only valid in 64-bit */
         if (!LMA(s) && env->cpuid_vendor1 == CPUID_VENDOR_INTEL_1) {
@@ -5696,6 +5695,7 @@ static bool disas_insn(DisasContext *s, CPUState *cpu)
            generated after one has entered CPL0 if TF is set in FMASK.  */
         gen_eob_worker(s, false, true);
         break;
+#ifdef TARGET_X86_64
     case 0x107: /* sysret */
         if (!PE(s) || CPL(s) != 0) {
             gen_exception_gpf(s);
diff --git a/target/i386/tcg/user/seg_helper.c b/target/i386/tcg/user/seg_helper.c
index 67481b0aa8e..c45f2ac2ba6 100644
--- a/target/i386/tcg/user/seg_helper.c
+++ b/target/i386/tcg/user/seg_helper.c
@@ -26,7 +26,6 @@
 #include "tcg/helper-tcg.h"
 #include "tcg/seg_helper.h"
 
-#ifdef TARGET_X86_64
 void helper_syscall(CPUX86State *env, int next_eip_addend)
 {
     CPUState *cs = env_cpu(env);
@@ -36,7 +35,6 @@ void helper_syscall(CPUX86State *env, int next_eip_addend)
     env->exception_next_eip = env->eip + next_eip_addend;
     cpu_loop_exit(cs);
 }
-#endif /* TARGET_X86_64 */
 
 /*
  * fake user mode interrupt. is_int is TRUE if coming from the int
-- 
2.40.1



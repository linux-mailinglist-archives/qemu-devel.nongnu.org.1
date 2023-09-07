Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AB137972AE
	for <lists+qemu-devel@lfdr.de>; Thu,  7 Sep 2023 15:12:09 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qeEcg-0002fa-5w; Thu, 07 Sep 2023 09:00:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qeEcX-0002b0-Ny
 for qemu-devel@nongnu.org; Thu, 07 Sep 2023 09:00:31 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qeEcS-0006qP-4L
 for qemu-devel@nongnu.org; Thu, 07 Sep 2023 09:00:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1694091622;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version: content-type:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Xlr45G5C6xexMq0NTZNVR03eFmnGOKr/6t+s6N27Hqc=;
 b=JWsBsq1a9XhnCTyxlfmcnNP8VqucF0zEAm8fC3NqVbW2Enc7O/HtQb26ZQYa6ISP8KvZHL
 j3v7lUTPF4O0qWgG7NUFuaQeQoQIuerLUz93UbSdEagKeDPq/bnX5oV/IXeoFNgOZqmmOc
 4O4/JrMhzzWrukvBk8M2ZWf3bnSuQTg=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-379-3QJ_eUvYNF-0GEJDIIrChA-1; Thu, 07 Sep 2023 09:00:15 -0400
X-MC-Unique: 3QJ_eUvYNF-0GEJDIIrChA-1
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-31f5757f489so575279f8f.2
 for <qemu-devel@nongnu.org>; Thu, 07 Sep 2023 06:00:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1694091613; x=1694696413;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Xlr45G5C6xexMq0NTZNVR03eFmnGOKr/6t+s6N27Hqc=;
 b=Y4bcxepZpdhzQ1AAopvVaxg53CtWl4qevo2yxtN6NjhqluOEMhMAcHd7OgH7FuiDW6
 OdEwSYMQpX3hnPnPcbd1QYvx9h6L6YND3Qljh/j8USOCkOH8Oa8xmfBUjnlfmInsyeBk
 MDe9vxBv2uWSlEctiOOQg7BF7ij3iVm+E0lNYtYx2AcnARDIyqfR0vvb7GQgPkk68eqH
 r8dsFjTuuoEZGtEKlsTOaeua+OBvZg9LyMFmFiUI2Q5w+LP8m2603ba0x5VCUSR47Cuv
 mIZJvLYmFz64w+wbVwvJH1iwN4gwQBEjWneKOgjScOpJ3Ql40oT/WVpsjgwj/k0Vbdvl
 MUzA==
X-Gm-Message-State: AOJu0YytN9r49ErUzZKsZfQettmDjcMthFODTo9lNMyewSNiqdxXiU63
 LAHzygKIrcAi8xPW8GeKkY+EfNEQjR33ko+LM7KiYUa77y5Cx07wUMoKvHvHSMOcV6TGv1iGXKG
 Qu4hHDGAqkQtFtpz/2+rAQw87rdiTaXu2kIS54r7sftrH8jBUvMlNv8upFUYc7dV0G0GJ9aITx9
 E=
X-Received: by 2002:adf:db0f:0:b0:317:f702:70d8 with SMTP id
 s15-20020adfdb0f000000b00317f70270d8mr4493073wri.67.1694091613444; 
 Thu, 07 Sep 2023 06:00:13 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHaR8KoqTaBs4QMMVM27YTMz2ib1u+oBtbcxG28ys0ImMJXzgMHNt8rtKly2KrNBXWmBqKA+w==
X-Received: by 2002:adf:db0f:0:b0:317:f702:70d8 with SMTP id
 s15-20020adfdb0f000000b00317f70270d8mr4493047wri.67.1694091612936; 
 Thu, 07 Sep 2023 06:00:12 -0700 (PDT)
Received: from [192.168.1.174] ([151.48.237.81])
 by smtp.gmail.com with ESMTPSA id
 cc11-20020a5d5c0b000000b0031f34a395e7sm17004439wrb.45.2023.09.07.06.00.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 07 Sep 2023 06:00:12 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 02/51] target/i386: raise FERR interrupt with iothread locked
Date: Thu,  7 Sep 2023 14:59:11 +0200
Message-ID: <20230907130004.500601-3-pbonzini@redhat.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230907130004.500601-1-pbonzini@redhat.com>
References: <20230907130004.500601-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

Otherwise tcg_handle_interrupt() triggers an assertion failure:

  #5  0x0000555555c97369 in tcg_handle_interrupt (cpu=0x555557434cb0, mask=2) at ../accel/tcg/tcg-accel-ops.c:83
  #6  tcg_handle_interrupt (cpu=0x555557434cb0, mask=2) at ../accel/tcg/tcg-accel-ops.c:81
  #7  0x0000555555b4d58b in pic_irq_request (opaque=<optimized out>, irq=<optimized out>, level=1) at ../hw/i386/x86.c:555
  #8  0x0000555555b4f218 in gsi_handler (opaque=0x5555579423d0, n=13, level=1) at ../hw/i386/x86.c:611
  #9  0x00007fffa42bde14 in code_gen_buffer ()
  #10 0x0000555555c724bb in cpu_tb_exec (cpu=cpu@entry=0x555557434cb0, itb=<optimized out>, tb_exit=tb_exit@entry=0x7fffe9bfd658) at ../accel/tcg/cpu-exec.c:457

Cc: qemu-stable@nongnu.org
Resolves: https://gitlab.com/qemu-project/qemu/-/issues/1808
Reported-by: NyanCatTW1 <https://gitlab.com/a0939712328>
Co-developed-by: Richard Henderson <richard.henderson@linaro.org>'
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/tcg/sysemu/fpu_helper.c | 6 ++++++
 target/i386/tcg/translate.c         | 8 +++++++-
 2 files changed, 13 insertions(+), 1 deletion(-)

diff --git a/target/i386/tcg/sysemu/fpu_helper.c b/target/i386/tcg/sysemu/fpu_helper.c
index 1c3610da3b9..93506cdd94e 100644
--- a/target/i386/tcg/sysemu/fpu_helper.c
+++ b/target/i386/tcg/sysemu/fpu_helper.c
@@ -18,6 +18,7 @@
  */
 
 #include "qemu/osdep.h"
+#include "qemu/main-loop.h"
 #include "cpu.h"
 #include "hw/irq.h"
 
@@ -31,7 +32,9 @@ void x86_register_ferr_irq(qemu_irq irq)
 void fpu_check_raise_ferr_irq(CPUX86State *env)
 {
     if (ferr_irq && !(env->hflags2 & HF2_IGNNE_MASK)) {
+        qemu_mutex_lock_iothread();
         qemu_irq_raise(ferr_irq);
+        qemu_mutex_unlock_iothread();
         return;
     }
 }
@@ -45,6 +48,9 @@ void cpu_clear_ignne(void)
 void cpu_set_ignne(void)
 {
     CPUX86State *env = &X86_CPU(first_cpu)->env;
+
+    assert(qemu_mutex_iothread_locked());
+
     env->hflags2 |= HF2_IGNNE_MASK;
     /*
      * We get here in response to a write to port F0h.  The chipset should
diff --git a/target/i386/tcg/translate.c b/target/i386/tcg/translate.c
index 90c7b32f362..e0a622941cb 100644
--- a/target/i386/tcg/translate.c
+++ b/target/i386/tcg/translate.c
@@ -4619,7 +4619,11 @@ static bool disas_insn(DisasContext *s, CPUState *cpu)
                 case 0x0a: /* grp d9/2 */
                     switch (rm) {
                     case 0: /* fnop */
-                        /* check exceptions (FreeBSD FPU probe) */
+                        /*
+                         * check exceptions (FreeBSD FPU probe)
+                         * needs to be treated as I/O because of ferr_irq
+                         */
+                        translator_io_start(&s->base);
                         gen_helper_fwait(cpu_env);
                         update_fip = false;
                         break;
@@ -5548,6 +5552,8 @@ static bool disas_insn(DisasContext *s, CPUState *cpu)
             (HF_MP_MASK | HF_TS_MASK)) {
             gen_exception(s, EXCP07_PREX);
         } else {
+            /* needs to be treated as I/O because of ferr_irq */
+            translator_io_start(&s->base);
             gen_helper_fwait(cpu_env);
         }
         break;
-- 
2.41.0



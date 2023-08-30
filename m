Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BD2278D520
	for <lists+qemu-devel@lfdr.de>; Wed, 30 Aug 2023 12:33:29 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qbIUJ-0005lB-OI; Wed, 30 Aug 2023 06:31:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qbIUI-0005kp-2e
 for qemu-devel@nongnu.org; Wed, 30 Aug 2023 06:31:50 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qbIUF-0003YB-F2
 for qemu-devel@nongnu.org; Wed, 30 Aug 2023 06:31:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1693391506;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=R6wawHYIM+KFx5oLyJIBGiZqdaHuIbtBPTC9OT7PaZs=;
 b=Xefft+CSxXwWfR27xX6ii2bFUDHkBmN+GuKBtDhy4l5dLt/f2NzqvaHIejC3O9g0N9LYO8
 3PM5/c3W9Ok0A5kyxn3bCMQq+ZITi50PUzJW/y5ofOZEEac6j1b9tzoAtP70kl1UJnjr5A
 kOfwceJjQu7C2Kg7l2hX2FlYrSWLxf0=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-584-TcZouze4OHmN_CsBiz8CUg-1; Wed, 30 Aug 2023 06:31:45 -0400
X-MC-Unique: TcZouze4OHmN_CsBiz8CUg-1
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-31aecb86dacso3338926f8f.1
 for <qemu-devel@nongnu.org>; Wed, 30 Aug 2023 03:31:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693391504; x=1693996304;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=R6wawHYIM+KFx5oLyJIBGiZqdaHuIbtBPTC9OT7PaZs=;
 b=Fop8Ip0d2Y9HRdzeY2rdlkowR7/TH2HYlV65N/el90Aj39cGjjHT5D8zYlGm9efaGY
 YQHgy3RW5vIgxlRKK69s+A7QY81KeGMnGYjhzGvkHPoRY8or8xS5fQDtNkFy5z16FKZT
 lQ5Y4x8F+uwd0xCE7e6j/cb0OLvRpEhu/um2WnDbUT5KiJkPPI/IHhMxS+tXXYn6KyLM
 dPN15XMtjT1ZAfQ/zHSGegJV1v1j3xDcCG2P+uz7CYOMI17XHeOpoqV6vFjm9wO9oiij
 in7iWMFOrlyF/dEoVcQWvHpUr54bB1A/m7hMcvctFodUJ07mJ/Bmt9v2YzkrR19uyIgE
 xijQ==
X-Gm-Message-State: AOJu0Yy6b3IsNmCkk9S+pU3jGO1HEjQAHwwwDmFgMj8HAXLOSoc2lX1W
 cQR7FXREoQ9tqn9gWY/dVRiHHxV9A6tRTpEFzEWQ+cMSIxP7LrFCyWzBifiP1j9AqG5ZV5EZ/cW
 OyEAAw9aj2gHC/qCdoY+1HJRqMYPIX8oTZOmWf7iYoTpLM5tAl0aGOjbptezGtOR7+z7N7E4NOz
 k=
X-Received: by 2002:a05:6000:114e:b0:31c:804b:5ec3 with SMTP id
 d14-20020a056000114e00b0031c804b5ec3mr1259710wrx.67.1693391503685; 
 Wed, 30 Aug 2023 03:31:43 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGOiyjaRSkzWK+mtGjRrJAoq864DrY8fg8GQVFs8k6F2mrYSjunBR3avTIs/qrHCCpbaS6jYQ==
X-Received: by 2002:a05:6000:114e:b0:31c:804b:5ec3 with SMTP id
 d14-20020a056000114e00b0031c804b5ec3mr1259689wrx.67.1693391503232; 
 Wed, 30 Aug 2023 03:31:43 -0700 (PDT)
Received: from [192.168.10.118] ([2001:b07:6468:f312:63a7:c72e:ea0e:6045])
 by smtp.gmail.com with ESMTPSA id
 o12-20020adfcf0c000000b0031ad2663ed0sm16286770wrj.66.2023.08.30.03.31.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 30 Aug 2023 03:31:42 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: philmd@linaro.org, qemu-stable@nongnu.org,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH v2] target/i386: raise FERR interrupt with iothread locked
Date: Wed, 30 Aug 2023 12:31:38 +0200
Message-ID: <20230830103141.138775-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.41.0
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



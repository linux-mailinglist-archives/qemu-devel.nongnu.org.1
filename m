Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id AA0A57976BE
	for <lists+qemu-devel@lfdr.de>; Thu,  7 Sep 2023 18:15:47 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qeHeG-0007Ld-0n; Thu, 07 Sep 2023 12:14:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qeHeB-0007LE-LU
 for qemu-devel@nongnu.org; Thu, 07 Sep 2023 12:14:23 -0400
Received: from mail-lj1-x230.google.com ([2a00:1450:4864:20::230])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qeHe8-0006V9-On
 for qemu-devel@nongnu.org; Thu, 07 Sep 2023 12:14:23 -0400
Received: by mail-lj1-x230.google.com with SMTP id
 38308e7fff4ca-2bcc4347d2dso19432621fa.0
 for <qemu-devel@nongnu.org>; Thu, 07 Sep 2023 09:14:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1694103259; x=1694708059; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=nZtQiYFBoet8GeTNKrldfa5lNv35E4p88I3RORT4DCI=;
 b=gYmtNK37s0oCQFuDamOwGQRm7JmRGSGyVqwe0mN5zuQqpQFsTAww5NVMKMNJsHK8Fb
 9E2T8M8yyVTky0q1Zqtxf6kXYaejh24y0Z+kqMevI2yRGDlyYlnb0vu/UpHkY16YrtbX
 pkSPQpKDxlLDsCnB73TUC6/XWZf5BM4hZ67tz79+UPlwfkeSEUYcQKC62ogJPagDPQAe
 fUHcq3mLI4sI/t/gK9RfAICOyM89NCdJrUzHx99pSLyYRCzycfY6tgpEmY9Z01nlLJ8a
 0ivv7pFhagboRAn5Rn6RS56/uLWZQwG0l7mdrPIyZ9ga7EPEpwfvbbTxobtDvyU5u922
 0Lyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1694103259; x=1694708059;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=nZtQiYFBoet8GeTNKrldfa5lNv35E4p88I3RORT4DCI=;
 b=DCHAN4IcBKv2KIrDuZUbbYdapfudIHZF4IOg42BX/R8pWw++a8NWEZtMW46T9+Ohp3
 vRXCA7UhncbPpD3+yuI5T2ua8zwzYO6y+RjBMGslnWG/ikHYfRqpP268DqBUoG4Nwd+g
 +bgGBvWQH0imGLD+VI3mx+cUIp1EtDNiwaHv8BWqImDMg9yyh3JTPEhD9P9D02mcUFa3
 vsUL5lXKbWibD4LJlhHAsOa1yvg84TOrLZIasXTOPoVHTfvkh9sEcvm+bLJpG2T6Kyjl
 yo0ohB/u7mxbfVkHkTg+Vs4IUabwfkk3jazZnkAM6Jftevja+qERUbDDIq0Iqb1R/p26
 NCbg==
X-Gm-Message-State: AOJu0YyveRfZZhkTpnfLCjzPXR2fxcT34dwOgaAKu38F2jk9K02iBwSx
 yfgcYyLx1lBCC44bQDJFFqGI75SkwzNnVe+GcqU=
X-Google-Smtp-Source: AGHT+IHMkvaYmiJJ78akdF4LMGDmXoHIt6lx7YTOCy89LL8zfh/GU8tJlVltDFPp+tJfU4Xs1Yc+hQ==
X-Received: by 2002:a2e:9f04:0:b0:2b6:fa71:5bae with SMTP id
 u4-20020a2e9f04000000b002b6fa715baemr5137908ljk.12.1694103258707; 
 Thu, 07 Sep 2023 09:14:18 -0700 (PDT)
Received: from m1x-phil.lan (176-131-222-226.abo.bbox.fr. [176.131.222.226])
 by smtp.gmail.com with ESMTPSA id
 le18-20020a170906ae1200b0099bcbaa242asm10574220ejb.9.2023.09.07.09.14.16
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 07 Sep 2023 09:14:18 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org, Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>
Cc: WANG Xuerui <git@xen0n.name>, David Hildenbrand <david@redhat.com>,
 Sergey Fedorov <serge.fdrv@gmail.com>, Peter Xu <peterx@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 "Emilio G . Cota" <cota@braap.org>,
 Richard Purdie <richard.purdie@linuxfoundation.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Anton Johansson <anjo@rev.ng>, Peter Maydell <peter.maydell@linaro.org>,
 qemu-stable@nongnu.org
Subject: [RFC PATCH] softmmu: Fix async_run_on_cpu() use in tcg_commit_cpu()
Date: Thu,  7 Sep 2023 18:14:14 +0200
Message-ID: <20230907161415.6102-1-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::230;
 envelope-from=philmd@linaro.org; helo=mail-lj1-x230.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

CPUState::halt_cond is an accelerator specific pointer, used
in particular by TCG (which tcg_commit() is about).
The pointer is set by the AccelOpsClass::create_vcpu_thread()
handler.
AccelOpsClass::create_vcpu_thread() is called by the generic
qemu_init_vcpu(), which expect the accelerator handler to
eventually call cpu_thread_signal_created() which is protected
with a QemuCond. It is safer to check the vCPU is created with
this field rather than the 'halt_cond' pointer set in
create_vcpu_thread() before the vCPU thread is initialized.

This avoids calling tcg_commit() until all CPUs are realized.

Here we can see for a machine with N CPUs, tcg_commit()
is called N times before the 'machine_creation_done' event:

  (lldb) settings set -- target.run-args  "-M" "virt" "-smp" "512" "-display" "none"
  (lldb) breakpoint set --name qemu_machine_creation_done --one-shot true
  (lldb) breakpoint set --name tcg_commit_cpu --auto-continue true
  (lldb) run
  Process 84089 launched: 'qemu-system-aarch64' (arm64)
  Process 84089 stopped
  * thread #1, queue = 'com.apple.main-thread', stop reason = one-shot breakpoint 2
  (lldb) breakpoint list --brief
  Current breakpoints:
  2: name = 'tcg_commit_cpu', locations = 2, resolved = 2, hit count = 512 Options: enabled auto-continue
             ^^^^^^^^^^^^^^                                ^^^^^^^^^^^^^^^

Having the following backtrace:

  (lldb) bt
  * thread #1, queue = 'com.apple.main-thread', stop reason = breakpoint 2.1
    * frame #0: 0x1005d0fe0 qemu-system-aarch64`tcg_commit [inlined] tcg_commit_cpu(cpu=0x108460000, data=(host_ptr = 0x600003b05c00, target_ptr = 105553178156032)) at physmem.c:2493:63
      frame #1: 0x1005d0fe0 qemu-system-aarch64`tcg_commit(listener=<unavailable>) at physmem.c:2527:9
      frame #2: 0x1005cd220 qemu-system-aarch64`memory_listener_register [inlined] listener_add_address_space(listener=0x600003b05c18, as=<unavailable>) at memory.c:3014:9
      frame #3: 0x1005cd148 qemu-system-aarch64`memory_listener_register(listener=0x600003b05c18, as=0x16fdfe720) at memory.c:3077:5
      frame #4: 0x1005d0f40 qemu-system-aarch64`cpu_address_space_init(cpu=<unavailable>, asidx=<unavailable>, prefix=<unavailable>, mr=<unavailable>) at physmem.c:773:9 [artificial]
      frame #5: 0x100389a64 qemu-system-aarch64`arm_cpu_realizefn(dev=0x108460000, errp=0x16fdfe720) at cpu.c:2244:5
      frame #6: 0x10062af28 qemu-system-aarch64`device_set_realized(obj=<unavailable>, value=<unavailable>, errp=0x16fdfe7d8) at qdev.c:510:13
      frame #7: 0x100632518 qemu-system-aarch64`property_set_bool(obj=0x108460000, v=<unavailable>, name=<unavailable>, opaque=0x600000013e50, errp=0x16fdfe7d8) at object.c:2285:5
      frame #8: 0x100630808 qemu-system-aarch64`object_property_set(obj=0x108460000, name="realized", v=0x600003e02100, errp=0x16fdfe7d8) at object.c:1420:5
      frame #9: 0x1006345ac qemu-system-aarch64`object_property_set_qobject(obj=<unavailable>, name=<unavailable>, value=<unavailable>, errp=<unavailable>) at qom-qobject.c:28:10
      frame #10: 0x100630c80 qemu-system-aarch64`object_property_set_bool(obj=<unavailable>, name=<unavailable>, value=<unavailable>, errp=<unavailable>) at object.c:1489:15
      frame #11: 0x10062a188 qemu-system-aarch64`qdev_realize(dev=<unavailable>, bus=<unavailable>, errp=<unavailable>) at qdev.c:292:12 [artificial]
      frame #12: 0x100319c30 qemu-system-aarch64`machvirt_init(machine=0x103562480) at virt.c:2248:9
      frame #13: 0x100090edc qemu-system-aarch64`machine_run_board_init(machine=0x103562480, mem_path=<unavailable>, errp=<unavailable>) at machine.c:1469:5
      frame #14: 0x1002a2684 qemu-system-aarch64`qmp_x_exit_preconfig [inlined] qemu_init_board at vl.c:2543:5
      frame #15: 0x1002a2650 qemu-system-aarch64`qmp_x_exit_preconfig(errp=<unavailable>) at vl.c:2634:5
      frame #16: 0x1002a5dd4 qemu-system-aarch64`qemu_init(argc=<unavailable>, argv=<unavailable>) at vl.c:3642:9
      frame #17: 0x100627d64 qemu-system-aarch64`main(argc=<unavailable>, argv=<unavailable>) at main.c:47:5

When can then invert the if ladders for clarity:
in the unlikely case of the caller being executed on the vCPU
thread, directly dispatch, otherwise defer until quiescence.

Cc: qemu-stable@nongnu.org
Fixes: 0d58c66068 ("softmmu: Use async_run_on_cpu in tcg_commit")
Resolves: https://gitlab.com/qemu-project/qemu/-/issues/1866
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
RFC: I tried my best to understand and explain, but this is
     still black magic to me...
---
 softmmu/physmem.c | 35 ++++++++++++++++++++---------------
 1 file changed, 20 insertions(+), 15 deletions(-)

diff --git a/softmmu/physmem.c b/softmmu/physmem.c
index 18277ddd67..12ef9d7d27 100644
--- a/softmmu/physmem.c
+++ b/softmmu/physmem.c
@@ -2505,22 +2505,27 @@ static void tcg_commit(MemoryListener *listener)
     cpuas = container_of(listener, CPUAddressSpace, tcg_as_listener);
     cpu = cpuas->cpu;
 
-    /*
-     * Defer changes to as->memory_dispatch until the cpu is quiescent.
-     * Otherwise we race between (1) other cpu threads and (2) ongoing
-     * i/o for the current cpu thread, with data cached by mmu_lookup().
-     *
-     * In addition, queueing the work function will kick the cpu back to
-     * the main loop, which will end the RCU critical section and reclaim
-     * the memory data structures.
-     *
-     * That said, the listener is also called during realize, before
-     * all of the tcg machinery for run-on is initialized: thus halt_cond.
-     */
-    if (cpu->halt_cond) {
-        async_run_on_cpu(cpu, tcg_commit_cpu, RUN_ON_CPU_HOST_PTR(cpuas));
-    } else {
+    if (!cpu->created) {
+        /*
+         * The listener is also called during realize, before
+         * all of the tcg machinery for run-on is initialized.
+         */
+        return;
+    }
+
+    if (unlikely(qemu_cpu_is_self(cpu))) {
         tcg_commit_cpu(cpu, RUN_ON_CPU_HOST_PTR(cpuas));
+    } else {
+        /*
+         * Defer changes to as->memory_dispatch until the cpu is quiescent.
+         * Otherwise we race between (1) other cpu threads and (2) ongoing
+         * i/o for the current cpu thread, with data cached by mmu_lookup().
+         *
+         * In addition, queueing the work function will kick the cpu back to
+         * the main loop, which will end the RCU critical section and reclaim
+         * the memory data structures.
+         */
+        async_run_on_cpu(cpu, tcg_commit_cpu, RUN_ON_CPU_HOST_PTR(cpuas));
     }
 }
 
-- 
2.41.0



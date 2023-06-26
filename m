Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D61E73EAF0
	for <lists+qemu-devel@lfdr.de>; Mon, 26 Jun 2023 21:10:27 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qDrU4-0003DL-IX; Mon, 26 Jun 2023 15:02:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1qDrTg-0002FF-V1; Mon, 26 Jun 2023 15:02:22 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1qDrTf-0007ut-8q; Mon, 26 Jun 2023 15:02:20 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id D488AEFC7;
 Mon, 26 Jun 2023 21:59:14 +0300 (MSK)
Received: from tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with SMTP id 72978F802;
 Mon, 26 Jun 2023 21:59:13 +0300 (MSK)
Received: (nullmailer pid 1575388 invoked by uid 1000);
 Mon, 26 Jun 2023 18:59:05 -0000
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org, qemu-stable@nongnu.org
Cc: Helge Deller <deller@gmx.de>, Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-7.2.4 37/43] target/hppa: Fix OS reboot issues
Date: Mon, 26 Jun 2023 21:58:55 +0300
Message-Id: <20230626185902.1575177-37-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <qemu-stable-7.2.4-20230626215033@cover.tls.msk.ru>
References: <qemu-stable-7.2.4-20230626215033@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=86.62.121.231; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -68
X-Spam_score: -6.9
X-Spam_bar: ------
X-Spam_report: (-6.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_HI=-5,
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

From: Helge Deller <deller@gmx.de>

When the OS triggers a reboot, the reset helper function sends a
qemu_system_reset_request(SHUTDOWN_CAUSE_GUEST_RESET) together with an
EXCP_HLT exception to halt the CPUs.

So, at reboot when initializing the CPUs again, make sure to set all
instruction pointers to the firmware entry point, disable any interrupts,
disable data and instruction translations, enable PSW_Q bit  and tell qemu
to unhalt (halted=0) the CPUs again.

This fixes the various reboot issues which were seen when rebooting a
Linux VM, including the case where even the monarch CPU has been virtually
halted from the OS (e.g. via "chcpu -d 0" inside the Linux VM).

Signed-off-by: Helge Deller <deller@gmx.de>
(cherry picked from commit 50ba97e928b44ff5bc731c9ffe68d86acbe44639)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/hw/hppa/machine.c b/hw/hppa/machine.c
index de1cc7ab71..b54148e5fb 100644
--- a/hw/hppa/machine.c
+++ b/hw/hppa/machine.c
@@ -418,10 +418,16 @@ static void hppa_machine_reset(MachineState *ms, ShutdownCause reason)
 
     /* Start all CPUs at the firmware entry point.
      *  Monarch CPU will initialize firmware, secondary CPUs
-     *  will enter a small idle look and wait for rendevouz. */
+     *  will enter a small idle loop and wait for rendevouz. */
     for (i = 0; i < smp_cpus; i++) {
-        cpu_set_pc(CPU(cpu[i]), firmware_entry);
+        CPUState *cs = CPU(cpu[i]);
+
+        cpu_set_pc(cs, firmware_entry);
+        cpu[i]->env.psw = PSW_Q;
         cpu[i]->env.gr[5] = CPU_HPA + i * 0x1000;
+
+        cs->exception_index = -1;
+        cs->halted = 0;
     }
 
     /* already initialized by machine_hppa_init()? */
-- 
2.39.2



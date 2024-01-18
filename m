Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 97474831360
	for <lists+qemu-devel@lfdr.de>; Thu, 18 Jan 2024 08:55:34 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rQNEA-0000OE-I2; Thu, 18 Jan 2024 02:54:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1rQNE7-0000NA-SB; Thu, 18 Jan 2024 02:54:15 -0500
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1rQNE6-0007K5-9O; Thu, 18 Jan 2024 02:54:15 -0500
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 0E1CE4502E;
 Thu, 18 Jan 2024 10:54:35 +0300 (MSK)
Received: from tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with SMTP id 3827D66197;
 Thu, 18 Jan 2024 10:54:05 +0300 (MSK)
Received: (nullmailer pid 2381640 invoked by uid 1000);
 Thu, 18 Jan 2024 07:54:04 -0000
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Natanael Copa <ncopa@alpinelinux.org>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-8.2.1 04/38] target/riscv/kvm: do not use non-portable
 strerrorname_np()
Date: Thu, 18 Jan 2024 10:52:31 +0300
Message-Id: <20240118075404.2381519-4-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <qemu-stable-8.2.1-20240118102508@cover.tls.msk.ru>
References: <qemu-stable-8.2.1-20240118102508@cover.tls.msk.ru>
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

From: Natanael Copa <ncopa@alpinelinux.org>

strerrorname_np is non-portable and breaks building with musl libc.

Use strerror(errno) instead, like we do other places.

Cc: qemu-stable@nongnu.org
Fixes: commit 082e9e4a58ba (target/riscv/kvm: improve 'init_multiext_cfg' error msg)
Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2041
Buglink: https://gitlab.alpinelinux.org/alpine/aports/-/issues/15541
Signed-off-by: Natanael Copa <ncopa@alpinelinux.org>
Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>
(cherry picked from commit d424db235434b8356c6b2d9420b846c7ddcc83ea)

diff --git a/target/riscv/kvm/kvm-cpu.c b/target/riscv/kvm/kvm-cpu.c
index 45b6cf1cfa..117e33cf90 100644
--- a/target/riscv/kvm/kvm-cpu.c
+++ b/target/riscv/kvm/kvm-cpu.c
@@ -832,9 +832,8 @@ static void kvm_riscv_read_multiext_legacy(RISCVCPU *cpu,
                 multi_ext_cfg->supported = false;
                 val = false;
             } else {
-                error_report("Unable to read ISA_EXT KVM register %s, "
-                             "error code: %s", multi_ext_cfg->name,
-                             strerrorname_np(errno));
+                error_report("Unable to read ISA_EXT KVM register %s: %s",
+                             multi_ext_cfg->name, strerror(errno));
                 exit(EXIT_FAILURE);
             }
         } else {
@@ -895,8 +894,8 @@ static void kvm_riscv_init_multiext_cfg(RISCVCPU *cpu, KVMScratchCPU *kvmcpu)
          *
          * Error out if we get any other errno.
          */
-        error_report("Error when accessing get-reg-list, code: %s",
-                     strerrorname_np(errno));
+        error_report("Error when accessing get-reg-list: %s",
+                     strerror(errno));
         exit(EXIT_FAILURE);
     }
 
@@ -905,8 +904,8 @@ static void kvm_riscv_init_multiext_cfg(RISCVCPU *cpu, KVMScratchCPU *kvmcpu)
     reglist->n = rl_struct.n;
     ret = ioctl(kvmcpu->cpufd, KVM_GET_REG_LIST, reglist);
     if (ret) {
-        error_report("Error when reading KVM_GET_REG_LIST, code %s ",
-                     strerrorname_np(errno));
+        error_report("Error when reading KVM_GET_REG_LIST: %s",
+                     strerror(errno));
         exit(EXIT_FAILURE);
     }
 
@@ -927,9 +926,8 @@ static void kvm_riscv_init_multiext_cfg(RISCVCPU *cpu, KVMScratchCPU *kvmcpu)
         reg.addr = (uint64_t)&val;
         ret = ioctl(kvmcpu->cpufd, KVM_GET_ONE_REG, &reg);
         if (ret != 0) {
-            error_report("Unable to read ISA_EXT KVM register %s, "
-                         "error code: %s", multi_ext_cfg->name,
-                         strerrorname_np(errno));
+            error_report("Unable to read ISA_EXT KVM register %s: %s",
+                         multi_ext_cfg->name, strerror(errno));
             exit(EXIT_FAILURE);
         }
 
-- 
2.39.2



Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 577A970DA45
	for <lists+qemu-devel@lfdr.de>; Tue, 23 May 2023 12:20:19 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q1P3l-0006jD-30; Tue, 23 May 2023 06:16:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1q1P3Z-0006i8-50; Tue, 23 May 2023 06:15:54 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1q1P3X-0001o7-79; Tue, 23 May 2023 06:15:52 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id C84337CF4;
 Tue, 23 May 2023 13:15:49 +0300 (MSK)
Received: from tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with SMTP id 0D75D7284;
 Tue, 23 May 2023 13:15:49 +0300 (MSK)
Received: (nullmailer pid 85496 invoked by uid 1000);
 Tue, 23 May 2023 10:15:48 -0000
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Claudio Imbrenda <imbrenda@linux.ibm.com>,
 Marc Hartmayer <mhartmay@linux.ibm.com>, Thomas Huth <thuth@redhat.com>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-8.0.1 38/59] s390x/pv: Fix spurious warning with asynchronous
 teardown
Date: Tue, 23 May 2023 13:14:58 +0300
Message-Id: <20230523101536.85424-2-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <qemu-stable-8.0.1-20230523131351@cover.tls.msk.ru>
References: <qemu-stable-8.0.1-20230523131351@cover.tls.msk.ru>
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

From: Claudio Imbrenda <imbrenda@linux.ibm.com>

Kernel commit 292a7d6fca33 ("KVM: s390: pv: fix asynchronous teardown
for small VMs") causes the KVM_PV_ASYNC_CLEANUP_PREPARE ioctl to fail
if the VM is not larger than 2GiB. QEMU would attempt it and fail,
print an error message, and then proceed with a normal teardown.

Avoid attempting to use asynchronous teardown altogether when the VM is
not larger than 2 GiB. This will avoid triggering the error message and
also avoid pointless overhead; normal teardown is fast enough for small
VMs.

Reported-by: Marc Hartmayer <mhartmay@linux.ibm.com>
Fixes: c3a073c610 ("s390x/pv: Add support for asynchronous teardown for reboot")
Link: https://lore.kernel.org/all/20230421085036.52511-2-imbrenda@linux.ibm.com/
Signed-off-by: Claudio Imbrenda <imbrenda@linux.ibm.com>
Message-Id: <20230510105531.30623-2-imbrenda@linux.ibm.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
[thuth: Fix inline function parameter in pv.h]
Signed-off-by: Thomas Huth <thuth@redhat.com>
(cherry picked from commit 88693ab2a53f2f3d25cb39a7b5034ab391bc5a81)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/hw/s390x/pv.c b/hw/s390x/pv.c
index 49ea38236c..b63f3784c6 100644
--- a/hw/s390x/pv.c
+++ b/hw/s390x/pv.c
@@ -13,6 +13,7 @@
 
 #include <linux/kvm.h>
 
+#include "qemu/units.h"
 #include "qapi/error.h"
 #include "qemu/error-report.h"
 #include "sysemu/kvm.h"
@@ -115,7 +116,7 @@ static void *s390_pv_do_unprot_async_fn(void *p)
      return NULL;
 }
 
-bool s390_pv_vm_try_disable_async(void)
+bool s390_pv_vm_try_disable_async(S390CcwMachineState *ms)
 {
     /*
      * t is only needed to create the thread; once qemu_thread_create
@@ -123,7 +124,12 @@ bool s390_pv_vm_try_disable_async(void)
      */
     QemuThread t;
 
-    if (!kvm_check_extension(kvm_state, KVM_CAP_S390_PROTECTED_ASYNC_DISABLE)) {
+    /*
+     * If the feature is not present or if the VM is not larger than 2 GiB,
+     * KVM_PV_ASYNC_CLEANUP_PREPARE fill fail; no point in attempting it.
+     */
+    if ((MACHINE(ms)->maxram_size <= 2 * GiB) ||
+        !kvm_check_extension(kvm_state, KVM_CAP_S390_PROTECTED_ASYNC_DISABLE)) {
         return false;
     }
     if (s390_pv_cmd(KVM_PV_ASYNC_CLEANUP_PREPARE, NULL) != 0) {
diff --git a/hw/s390x/s390-virtio-ccw.c b/hw/s390x/s390-virtio-ccw.c
index 503f212a31..0daf445d60 100644
--- a/hw/s390x/s390-virtio-ccw.c
+++ b/hw/s390x/s390-virtio-ccw.c
@@ -330,7 +330,7 @@ static inline void s390_do_cpu_ipl(CPUState *cs, run_on_cpu_data arg)
 
 static void s390_machine_unprotect(S390CcwMachineState *ms)
 {
-    if (!s390_pv_vm_try_disable_async()) {
+    if (!s390_pv_vm_try_disable_async(ms)) {
         s390_pv_vm_disable();
     }
     ms->pv = false;
diff --git a/include/hw/s390x/pv.h b/include/hw/s390x/pv.h
index 966306a9db..7b935e2246 100644
--- a/include/hw/s390x/pv.h
+++ b/include/hw/s390x/pv.h
@@ -14,10 +14,10 @@
 
 #include "qapi/error.h"
 #include "sysemu/kvm.h"
+#include "hw/s390x/s390-virtio-ccw.h"
 
 #ifdef CONFIG_KVM
 #include "cpu.h"
-#include "hw/s390x/s390-virtio-ccw.h"
 
 static inline bool s390_is_pv(void)
 {
@@ -41,7 +41,7 @@ static inline bool s390_is_pv(void)
 int s390_pv_query_info(void);
 int s390_pv_vm_enable(void);
 void s390_pv_vm_disable(void);
-bool s390_pv_vm_try_disable_async(void);
+bool s390_pv_vm_try_disable_async(S390CcwMachineState *ms);
 int s390_pv_set_sec_parms(uint64_t origin, uint64_t length);
 int s390_pv_unpack(uint64_t addr, uint64_t size, uint64_t tweak);
 void s390_pv_prep_reset(void);
@@ -61,7 +61,7 @@ static inline bool s390_is_pv(void) { return false; }
 static inline int s390_pv_query_info(void) { return 0; }
 static inline int s390_pv_vm_enable(void) { return 0; }
 static inline void s390_pv_vm_disable(void) {}
-static inline bool s390_pv_vm_try_disable_async(void) { return false; }
+static inline bool s390_pv_vm_try_disable_async(S390CcwMachineState *ms) { return false; }
 static inline int s390_pv_set_sec_parms(uint64_t origin, uint64_t length) { return 0; }
 static inline int s390_pv_unpack(uint64_t addr, uint64_t size, uint64_t tweak) { return 0; }
 static inline void s390_pv_prep_reset(void) {}
-- 
2.39.2



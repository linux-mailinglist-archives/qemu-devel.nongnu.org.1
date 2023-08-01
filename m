Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 41D5C76AEDA
	for <lists+qemu-devel@lfdr.de>; Tue,  1 Aug 2023 11:42:35 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qQlsD-0003A6-CY; Tue, 01 Aug 2023 05:41:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=570bccec8=anthony.perard@citrix.com>)
 id 1qQls8-000390-KZ
 for qemu-devel@nongnu.org; Tue, 01 Aug 2023 05:40:56 -0400
Received: from esa3.hc3370-68.iphmx.com ([216.71.145.155])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=570bccec8=anthony.perard@citrix.com>)
 id 1qQls5-0005BW-T9
 for qemu-devel@nongnu.org; Tue, 01 Aug 2023 05:40:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=citrix.com; s=securemail; t=1690882853;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=RMnHk4oHNHgKLRqUgkxXuacyu+rVLju3q0tzvXy0Muc=;
 b=hsmKLbIOKMyDyT5taWAldeOcOpQXvufpg0Qd4jmzeRiDhcsQHXV2CBCW
 lIS9goneIXhgrSYde2Y60xNfPWrGk4BG+gYU/Bmk2ff/0kEKc1he9JJ51
 pN/QOLVDNI0vcEtuSOCNH8asDV++PHBoVHI7q9rxEt1cmw3U74LXQh/w2 g=;
Authentication-Results: esa3.hc3370-68.iphmx.com;
 dkim=none (message not signed) header.i=none
X-SBRS: 4.0
X-MesageID: 118110419
X-Ironport-Server: esa3.hc3370-68.iphmx.com
X-Remote-IP: 162.221.156.123
X-Policy: $RELAYED
IronPort-Data: A9a23:6SG836+6T+O9vLjVNAFhDrUD9H6TJUtcMsCJ2f8bNWPcYEJGY0x3n
 WAWXmHVPvyLa2OmeN4na9+x8hwD65XWnd9mQFdp/Ck8E34SpcT7XtnIdU2Y0wF+jCHgZBk+s
 5hBMImowOQcFCK0SsKFa+C5xZVE/fjUAOG6UKicYXoZqTZMEE8JkQhkl/MynrlmiN24BxLlk
 d7pqojUNUTNNwRcawr40Ird7ks21BjOkGlA5AdmOqsS5AS2e0Q9V/rzG4ngdxMUfaEMdgKKb
 76r5K20+Grf4yAsBruN+losWhRXKlJ6FVHmZkt+A8BOsDAbzsAB+v9T2M4nQVVWk120c+VZk
 72hg3ASpTABZcUgkMxFO/VR/roX0aduoNcrKlDn2SCfItGvn9IBDJyCAWlvVbD09NqbDklF8
 f8fODcIKSm8oN6q8JySG7Friv8KeZyD0IM34hmMzBncBPciB5vCX7/L9ZlT2zJYasJmRKiEI
 ZBDMHw2MUqGOkcUUrsUIMtWcOOAj3/jczpeuRSNqLA++WT7xw1tyrn9dtHSf7RmQO0MxxbB/
 zqapjWR7hcyBcG7kTCV1jGVt8DKtC/DZoIMJrGI6as/6LGU7jNKU0BHPbehmtGgh0ujHt5SN
 UEQ0iwpq6c06QqsVNaVdwW1vHOe+BsVStZdF+kS7ACLw7DTpQGDCQA5oiVpMYJ88pVsHHpzi
 wHPxomybdByjFGLYXmZ9bCEqjb1ABcyEXMySwZVFQwJ2PC29enfkSnzosZf/L+d14OkQWGvn
 GrT9EDSlJ1I05dVivzTEUTvxmv1+8OXFlNdChD/BDrN0+9vWGKyi2VEA3D/5O0IEouWR0LpU
 JMsy5nHt7Bm4X1geUWwrAQx8FKBvazt3MX02wIHInXY323FF4SfVY5R+ipiA0xiL9wJfzTkC
 GeK51IJtMUDYCT2MfUoC25UNyjN5fGxfekJq9iONoYeCnSPXFHvEN5Sib64gDm2zRlEfVAXM
 paHa8e8ZUv2+ow+pAdas9w1iOdxrghnnDO7eHwO50j/uVZoTCLPGOht3ZrnRrxR0Z5oVy2Po
 4oGbZbblE8GOAA8CwGOmbMuwZkxBSBTLfjLRwZ/KoZv/iIO9LkdNsLs
IronPort-HdrOrdr: A9a23:qhG0Ba0/+1g0AStBNjd1KwqjBLQkLtp133Aq2lEZdPRUGvb2qy
 nIpoV86faUskd3ZJhOo7G90cW7LE80sKQFg7X5Xo3SODUO2lHJEGgK1+KLqFfd8m/Fh4tgPM
 9bAtFD4bbLY2SS4/yX3ODBKadC/OW6
X-Talos-CUID: 9a23:bOs7p2H0N0dRsVSKqmJs8E0TCscgNUTi60vME2GRWD5uRIa8HAo=
X-Talos-MUID: 9a23:9/NO9QmOLsaXnjXzDpN+dnpTKeMw6bSKS3k8vpAvt/G6NTJCNweC2WE=
X-IronPort-AV: E=Sophos;i="6.01,246,1684814400"; d="scan'208";a="118110419"
To: <qemu-devel@nongnu.org>
CC: Peter Maydell <peter.maydell@linaro.org>, Anthony PERARD
 <anthony.perard@citrix.com>
Subject: [PULL 4/5] xen: Don't pass MemoryListener around by value
Date: Tue, 1 Aug 2023 10:40:37 +0100
Message-ID: <20230801094038.11026-5-anthony.perard@citrix.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230801094038.11026-1-anthony.perard@citrix.com>
References: <20230801094038.11026-1-anthony.perard@citrix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=216.71.145.155;
 envelope-from=prvs=570bccec8=anthony.perard@citrix.com;
 helo=esa3.hc3370-68.iphmx.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
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
Reply-to:  Anthony PERARD <anthony.perard@citrix.com>
From:  Anthony PERARD via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

From: Peter Maydell <peter.maydell@linaro.org>

Coverity points out (CID 1513106, 1513107) that MemoryListener is a
192 byte struct which we are passing around by value.  Switch to
passing a const pointer into xen_register_ioreq() and then to
xen_do_ioreq_register().  We can also make the file-scope
MemoryListener variables const, since nothing changes them.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Acked-by: Anthony PERARD <anthony.perard@citrix.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-Id: <20230718101057.1110979-1-peter.maydell@linaro.org>
Signed-off-by: Anthony PERARD <anthony.perard@citrix.com>
---
 hw/arm/xen_arm.c                | 4 ++--
 hw/i386/xen/xen-hvm.c           | 4 ++--
 hw/xen/xen-hvm-common.c         | 8 ++++----
 include/hw/xen/xen-hvm-common.h | 2 +-
 4 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/hw/arm/xen_arm.c b/hw/arm/xen_arm.c
index 044093fec7..1d3e6d481a 100644
--- a/hw/arm/xen_arm.c
+++ b/hw/arm/xen_arm.c
@@ -37,7 +37,7 @@
 #define TYPE_XEN_ARM  MACHINE_TYPE_NAME("xenpvh")
 OBJECT_DECLARE_SIMPLE_TYPE(XenArmState, XEN_ARM)
 
-static MemoryListener xen_memory_listener = {
+static const MemoryListener xen_memory_listener = {
     .region_add = xen_region_add,
     .region_del = xen_region_del,
     .log_start = NULL,
@@ -108,7 +108,7 @@ static void xen_arm_init(MachineState *machine)
 
     xam->state =  g_new0(XenIOState, 1);
 
-    xen_register_ioreq(xam->state, machine->smp.cpus, xen_memory_listener);
+    xen_register_ioreq(xam->state, machine->smp.cpus, &xen_memory_listener);
 
 #ifdef CONFIG_TPM
     if (xam->cfg.tpm_base_addr) {
diff --git a/hw/i386/xen/xen-hvm.c b/hw/i386/xen/xen-hvm.c
index 3da5a2b23f..f42621e674 100644
--- a/hw/i386/xen/xen-hvm.c
+++ b/hw/i386/xen/xen-hvm.c
@@ -458,7 +458,7 @@ static void xen_log_global_stop(MemoryListener *listener)
     xen_in_migration = false;
 }
 
-static MemoryListener xen_memory_listener = {
+static const MemoryListener xen_memory_listener = {
     .name = "xen-memory",
     .region_add = xen_region_add,
     .region_del = xen_region_del,
@@ -582,7 +582,7 @@ void xen_hvm_init_pc(PCMachineState *pcms, MemoryRegion **ram_memory)
 
     state = g_new0(XenIOState, 1);
 
-    xen_register_ioreq(state, max_cpus, xen_memory_listener);
+    xen_register_ioreq(state, max_cpus, &xen_memory_listener);
 
     QLIST_INIT(&xen_physmap);
     xen_read_physmap(state);
diff --git a/hw/xen/xen-hvm-common.c b/hw/xen/xen-hvm-common.c
index 886c3ee944..565dc39c8f 100644
--- a/hw/xen/xen-hvm-common.c
+++ b/hw/xen/xen-hvm-common.c
@@ -765,8 +765,8 @@ void xen_shutdown_fatal_error(const char *fmt, ...)
 }
 
 static void xen_do_ioreq_register(XenIOState *state,
-                                           unsigned int max_cpus,
-                                           MemoryListener xen_memory_listener)
+                                  unsigned int max_cpus,
+                                  const MemoryListener *xen_memory_listener)
 {
     int i, rc;
 
@@ -824,7 +824,7 @@ static void xen_do_ioreq_register(XenIOState *state,
 
     qemu_add_vm_change_state_handler(xen_hvm_change_state_handler, state);
 
-    state->memory_listener = xen_memory_listener;
+    state->memory_listener = *xen_memory_listener;
     memory_listener_register(&state->memory_listener, &address_space_memory);
 
     state->io_listener = xen_io_listener;
@@ -842,7 +842,7 @@ static void xen_do_ioreq_register(XenIOState *state,
 }
 
 void xen_register_ioreq(XenIOState *state, unsigned int max_cpus,
-                        MemoryListener xen_memory_listener)
+                        const MemoryListener *xen_memory_listener)
 {
     int rc;
 
diff --git a/include/hw/xen/xen-hvm-common.h b/include/hw/xen/xen-hvm-common.h
index f9559e2885..4e9904f1a6 100644
--- a/include/hw/xen/xen-hvm-common.h
+++ b/include/hw/xen/xen-hvm-common.h
@@ -93,7 +93,7 @@ void xen_device_unrealize(DeviceListener *listener, DeviceState *dev);
 
 void xen_hvm_change_state_handler(void *opaque, bool running, RunState rstate);
 void xen_register_ioreq(XenIOState *state, unsigned int max_cpus,
-                        MemoryListener xen_memory_listener);
+                        const MemoryListener *xen_memory_listener);
 
 void cpu_ioreq_pio(ioreq_t *req);
 #endif /* HW_XEN_HVM_COMMON_H */
-- 
Anthony PERARD



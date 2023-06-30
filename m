Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C2CFA743ADB
	for <lists+qemu-devel@lfdr.de>; Fri, 30 Jun 2023 13:31:37 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qFCL5-0000BV-0T; Fri, 30 Jun 2023 07:30:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gautam@linux.ibm.com>)
 id 1qF6j0-0005Yj-Sc; Fri, 30 Jun 2023 01:31:19 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gautam@linux.ibm.com>)
 id 1qF6iy-00023N-Fw; Fri, 30 Jun 2023 01:31:18 -0400
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 35U5HnBG022562; Fri, 30 Jun 2023 05:31:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=from : to : cc : subject
 : date : message-id : content-transfer-encoding : mime-version; s=pp1;
 bh=S7vmJprrJuMrBTYBHNlsQP+sn2x9kSuY9Z0VzLL0Kqs=;
 b=Uf0oYxAnnUs8eUGlrWqh1VQsMwe7ILasY1KZUT1hYXWPdjc+nfxdB2ssrRdXiqsJ0ej7
 RHjwjgVVN1460ziplM3JcPDKziX9rVeyBIbnWoawY3oOPDHhy/A59au4HkAl3AgnjCgG
 c/ox47P3dCBVQPx30fnnfa/+WgW05jrMfAnKav1tZMWooZOaLf6edanTxYhiA3HDkpN4
 LhVfL0AjRjbAekcqYsBhSp7/1HvR0qnU74iaqB4AvaWptNT6e2nkc5h/vVRlpafvoAIe
 8/d4ywmqKWObrDBog3zzH+jLcWIZyeH+uG3rQYjJrRyrgCc/2KpKVzSxN0MszlFzFZGV xA== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3rhrs5g99x-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 30 Jun 2023 05:31:06 +0000
Received: from m0360072.ppops.net (m0360072.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 35U5OQCs025398;
 Fri, 30 Jun 2023 05:31:06 GMT
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com
 [169.51.49.99])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3rhrs5g995-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 30 Jun 2023 05:31:06 +0000
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
 by ppma04ams.nl.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 35U4FHfP008362;
 Fri, 30 Jun 2023 05:31:04 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
 by ppma04ams.nl.ibm.com (PPS) with ESMTPS id 3rdr453y6p-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 30 Jun 2023 05:31:04 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com
 [10.20.54.106])
 by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 35U5V1a442205642
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 30 Jun 2023 05:31:01 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id DCDC620040;
 Fri, 30 Jun 2023 05:31:00 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 42F0220043;
 Fri, 30 Jun 2023 05:30:59 +0000 (GMT)
Received: from li-c6426e4c-27cf-11b2-a85c-95d65bc0de0e.in.ibm.com (unknown
 [9.204.206.66]) by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Fri, 30 Jun 2023 05:30:59 +0000 (GMT)
From: Gautam Menghani <gautam@linux.ibm.com>
To: danielhb413@gmail.com, harshpb@linux.ibm.com, clg@kaod.org,
 david@gibson.dropbear.id.au, groug@kaod.org
Cc: Gautam Menghani <gautam@linux.ibm.com>, qemu-ppc@nongnu.org,
 qemu-devel@nongnu.org, fbarrat@linux.ibm.com
Subject: [PATCH] ppc: spapr: Fix device tree entries in absence of XIVE native
 mode
Date: Fri, 30 Jun 2023 11:00:56 +0530
Message-Id: <20230630053056.14933-1-gautam@linux.ibm.com>
X-Mailer: git-send-email 2.39.3
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: udAhJjZZL2RHz8_vZwCDjlZYRYUpfFj3
X-Proofpoint-GUID: 6ph-a2avHxyoPIVU4rgaT_JHDpRxXuwT
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-06-30_02,2023-06-27_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 malwarescore=0
 bulkscore=0 phishscore=0 mlxscore=0 suspectscore=0 priorityscore=1501
 clxscore=1011 adultscore=0 impostorscore=0 lowpriorityscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2306300043
Received-SPF: pass client-ip=148.163.158.5; envelope-from=gautam@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_MSPIKE_H5=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Fri, 30 Jun 2023 07:30:47 -0400
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

Currently, XIVE native exploitation mode is not supported in nested
guests. When we boot up a nested guest on PowerNV platform, we observe 
the following entries in the device tree of nested guest:

```
device_type = "power-ivpe";
compatible = "ibm,power-ivpe";
```

But as per LoPAR section B.5.9[1], these entries should only be present
when XIVE native exploitation mode is being used. Presently, there is no 
support for nested virtualization in the context of XIVE, and hence, DT 
shouldn't advertise support for XIVE interrupt controller to a nested guest. 

Also, according to the present behaviour, when we boot a nested KVM
guest, the following QEMU warnings are reported	:
```
Calling ibm,client-architecture-support...qemu-system-ppc64: warning: 
kernel_irqchip allowed but unavailable: IRQ_XIVE capability must be present 
for KVM
Falling back to kernel-irqchip=off
.
.
.
[    0.000000][    T0] xive: Using IRQ range [0-0]
[    0.000000][    T0] xive: Interrupt handling initialized with spapr backend
[    0.000000][    T0] xive: Using priority 6 for all interrupts
[    0.000000][    T0] xive: Using 64kB queues
```

With this patch, the above warnings are no longer observed in nested guest's 
dmesg and also the device tree contains the following entries:
```
device_type = "PowerPC-External-Interrupt-Presentation";
compatible = "IBM,ppc-xicp";
```

Also add an additional check to handle the scenarios where
ic-mode=<mode> is explicitly specified by user - make the code error out
when XIVE native capability is not there and user specifies
ic-mode=xive.

Testing:
1. This patch has been tested on a P9 PowerNV machine by spinning up both a
KVM guest and nested KVM guest. The guest can use XIVE native mode just fine 
with correct DT entries and for nested guest, interrupt emulation is being used 
and the DT contains correct entries.

2. This patch also has been tested on KVM on PowerVM platform. In this
scenario, we can boot up a KVM guest on top of a Power Hypervisor guest.
Kernel patches - lore.kernel.org/linuxppc-dev/20230605064848.12319-1-jpn@linux.vnet.ibm.com
QEMU tree to test - github.com/mikey/qemu/tree/kvm-papr

[1] : https://files.openpower.foundation/s/ZmtZyCGiJ2oJHim

Signed-off-by: Gautam Menghani <gautam@linux.ibm.com>
---
 hw/ppc/spapr.c     |  2 +-
 hw/ppc/spapr_irq.c | 14 +++++++++++++-
 2 files changed, 14 insertions(+), 2 deletions(-)

diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index 54dbfd7fe9..6434742369 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -2840,7 +2840,7 @@ static void spapr_machine_init(MachineState *machine)
     spapr_ovec_set(spapr->ov5, OV5_DRMEM_V2);
 
     /* advertise XIVE on POWER9 machines */
-    if (spapr->irq->xive) {
+    if (kvmppc_has_cap_xive() && spapr->irq->xive) {
         spapr_ovec_set(spapr->ov5, OV5_XIVE_EXPLOIT);
     }
 
diff --git a/hw/ppc/spapr_irq.c b/hw/ppc/spapr_irq.c
index a0d1e1298e..856bba042a 100644
--- a/hw/ppc/spapr_irq.c
+++ b/hw/ppc/spapr_irq.c
@@ -20,6 +20,7 @@
 #include "hw/qdev-properties.h"
 #include "cpu-models.h"
 #include "sysemu/kvm.h"
+#include "kvm_ppc.h"
 
 #include "trace.h"
 
@@ -294,6 +295,7 @@ uint32_t spapr_irq_nr_msis(SpaprMachineState *spapr)
 void spapr_irq_init(SpaprMachineState *spapr, Error **errp)
 {
     SpaprMachineClass *smc = SPAPR_MACHINE_GET_CLASS(spapr);
+    bool cap_xive = kvmppc_has_cap_xive();
 
     if (kvm_enabled() && kvm_kernel_irqchip_split()) {
         error_setg(errp, "kernel_irqchip split mode not supported on pseries");
@@ -304,6 +306,16 @@ void spapr_irq_init(SpaprMachineState *spapr, Error **errp)
         return;
     }
 
+    /*
+     * Check for valid ic-mode - XIVE native won't work if hypervisor doesn't
+     * have support
+     */
+    if (!cap_xive && !spapr->irq->xics) {
+        error_setg(errp,
+            "XIVE native mode not available, don't use ic-mode=xive");
+        return;
+    }
+
     /* Initialize the MSI IRQ allocator. */
     spapr_irq_msi_init(spapr);
 
@@ -323,7 +335,7 @@ void spapr_irq_init(SpaprMachineState *spapr, Error **errp)
         spapr->ics = ICS_SPAPR(obj);
     }
 
-    if (spapr->irq->xive) {
+    if (cap_xive && spapr->irq->xive) {
         uint32_t nr_servers = spapr_max_server_number(spapr);
         DeviceState *dev;
         int i;
-- 
2.39.3



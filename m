Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A69A6C0113D
	for <lists+qemu-devel@lfdr.de>; Thu, 23 Oct 2025 14:20:48 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vBuIl-0002u7-5e; Thu, 23 Oct 2025 08:20:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1vBuG1-000195-Ri
 for qemu-devel@nongnu.org; Thu, 23 Oct 2025 08:17:36 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1vBuFw-0006PL-8j
 for qemu-devel@nongnu.org; Thu, 23 Oct 2025 08:17:29 -0400
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59NASVPa017019;
 Thu, 23 Oct 2025 12:17:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=e+B3LZ
 WYy/aGnQ6XEPNZ0HRwmzqSsvz6GPL3axN2Jgw=; b=oO5LUmrc5L87rpC5h/JB5D
 OADDcmxY6FRxbAOKngZy5uXdxJzKjWcdvnnJWpV7TqUb+Mh7v0BMd1IdoOGEFIT0
 NWUcR/1dS+GrKRd244vg+AX5Bs3EQiJw0HEigIv3mnEk2F/sZT0SQpmyqJtj4bN6
 WA5OqbLFB/WovAJN12GksB03p08y6bwJ/J1LDR8hOxwAaKlnNXwLl35hQqGVMqvF
 Tgv/q39jAY3HEVMbIx/V9xuOB9vjh1Pam07TlkVL75BLvrZnX2tUVVoz/7V4SeM2
 7IGLsJz2d+m5sgCY6LavOfq6ETPZTJbuRFBaFHx+s5lmlMV4IbuKyyFv2Ky0+nPw
 ==
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 49v32hrge6-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 23 Oct 2025 12:17:21 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 59NAxYsj002281;
 Thu, 23 Oct 2025 12:17:06 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 49vqejne2h-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 23 Oct 2025 12:17:06 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com
 [10.20.54.106])
 by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 59NCH4Hr29557172
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 23 Oct 2025 12:17:04 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 940A42004B;
 Thu, 23 Oct 2025 12:17:04 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id CF88120040;
 Thu, 23 Oct 2025 12:17:03 +0000 (GMT)
Received: from li-1901474c-32f3-11b2-a85c-fc5ff2c001f3.ibm.com.com (unknown
 [9.124.221.73]) by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Thu, 23 Oct 2025 12:17:03 +0000 (GMT)
From: Harsh Prateek Bora <harshpb@linux.ibm.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 02/32] hw/ppc/spapr: Remove SpaprMachineClass::nr_xirqs field
Date: Thu, 23 Oct 2025 17:46:21 +0530
Message-ID: <20251023121653.3686015-3-harshpb@linux.ibm.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20251023121653.3686015-1-harshpb@linux.ibm.com>
References: <20251023121653.3686015-1-harshpb@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDE4MDAyMiBTYWx0ZWRfXyiaPITOSCWsU
 DUGFx4/9nLJPWoY5wZf4L8H72B4wlzFrK0OVcIkWH3uBsO6mZaSmfauPiwxcI+Q0Kra4AHzH1Pw
 sO2qMeaUFTHvGh4HMwrQSIFym0uHgu5FyI0qAm6K9/xR6z2wwvbHSNIBKcK/DTn+3HrdSpWhExy
 57zm/iQt5VJvTbYiJG1Jpw4+iQBBut8lGxvDl43Q/9rRlC8q8ofJufAxyIt+LWrPOn8OnLAd0sQ
 iCUdRRTD9hBY41c4rcJmtdhYJq6YsiPCc4DPIIFdXQFrNx75liXktWFYaS+/3JdLszwFFcFvkt6
 Q5aY9GXb5jUAahJ32ZcZb6FNB1ERClOrpvoQl9Z/kcC5ehjV5cLZhicqsVdRLS4DsHn9Y8eecvD
 NvXelRKqYKhr36qk47TUnGs7Uec+DQ==
X-Authority-Analysis: v=2.4 cv=OrVCCi/t c=1 sm=1 tr=0 ts=68fa1cd1 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=f7IdgyKtn90A:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=KKAkSRfTAAAA:8 a=VnNF1IyMAAAA:8
 a=tlPyEYuBD3hQ0sVLCPoA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=cvBusfyB2V15izCimMoJ:22 a=oH34dK2VZjykjzsv8OSz:22 a=pHzHmUro8NiASowvMSCR:22
 a=n87TN5wuljxrRezIQYnT:22
X-Proofpoint-GUID: m6p2Pktj-_eAiP30_TsY82xbOxXKwwqE
X-Proofpoint-ORIG-GUID: m6p2Pktj-_eAiP30_TsY82xbOxXKwwqE
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-22_08,2025-10-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 adultscore=0 priorityscore=1501 spamscore=0 phishscore=0
 clxscore=1015 bulkscore=0 malwarescore=0 lowpriorityscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510180022
Received-SPF: pass client-ip=148.163.158.5; envelope-from=harshpb@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

From: Philippe Mathieu-Daudé <philmd@linaro.org>

The SpaprMachineClass::nr_xirqs field was only used by the
pseries-3.0 machine, which got removed. Remove it as now unused.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Link: https://lore.kernel.org/qemu-devel/20251021084346.73671-3-philmd@linaro.org
Signed-off-by: Harsh Prateek Bora <harshpb@linux.ibm.com>
---
 include/hw/ppc/spapr.h |  1 -
 hw/ppc/spapr.c         |  1 -
 hw/ppc/spapr_irq.c     | 22 +++++++---------------
 3 files changed, 7 insertions(+), 17 deletions(-)

diff --git a/include/hw/ppc/spapr.h b/include/hw/ppc/spapr.h
index 0c1e5132de..494367fb99 100644
--- a/include/hw/ppc/spapr.h
+++ b/include/hw/ppc/spapr.h
@@ -145,7 +145,6 @@ struct SpaprMachineClass {
     /*< public >*/
     bool dr_phb_enabled;       /* enable dynamic-reconfig/hotplug of PHBs */
     bool update_dt_enabled;    /* enable KVMPPC_H_UPDATE_DT */
-    uint32_t nr_xirqs;
     bool broken_host_serial_model; /* present real host info to the guest */
     bool pre_4_1_migration; /* don't migrate hpt-max-page-size */
     bool linux_pci_probe;
diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index 3728ae2a5e..7be7fdaed8 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -4691,7 +4691,6 @@ static void spapr_machine_class_init(ObjectClass *oc, const void *data)
     smc->dr_phb_enabled = true;
     smc->linux_pci_probe = true;
     smc->smp_threads_vsmt = true;
-    smc->nr_xirqs = SPAPR_NR_XIRQS;
     xfc->match_nvt = spapr_match_nvt;
     vmc->client_architecture_support = spapr_vof_client_architecture_support;
     vmc->quiesce = spapr_vof_quiesce;
diff --git a/hw/ppc/spapr_irq.c b/hw/ppc/spapr_irq.c
index 317d57a380..2ce323457b 100644
--- a/hw/ppc/spapr_irq.c
+++ b/hw/ppc/spapr_irq.c
@@ -279,15 +279,11 @@ void spapr_irq_dt(SpaprMachineState *spapr, uint32_t nr_servers,
 
 uint32_t spapr_irq_nr_msis(SpaprMachineState *spapr)
 {
-    SpaprMachineClass *smc = SPAPR_MACHINE_GET_CLASS(spapr);
-
-    return SPAPR_XIRQ_BASE + smc->nr_xirqs - SPAPR_IRQ_MSI;
+    return SPAPR_NR_XIRQS + SPAPR_XIRQ_BASE - SPAPR_IRQ_MSI;
 }
 
 void spapr_irq_init(SpaprMachineState *spapr, Error **errp)
 {
-    SpaprMachineClass *smc = SPAPR_MACHINE_GET_CLASS(spapr);
-
     if (kvm_enabled() && kvm_kernel_irqchip_split()) {
         error_setg(errp, "kernel_irqchip split mode not supported on pseries");
         return;
@@ -308,7 +304,7 @@ void spapr_irq_init(SpaprMachineState *spapr, Error **errp)
         object_property_add_child(OBJECT(spapr), "ics", obj);
         object_property_set_link(obj, ICS_PROP_XICS, OBJECT(spapr),
                                  &error_abort);
-        object_property_set_int(obj, "nr-irqs", smc->nr_xirqs, &error_abort);
+        object_property_set_int(obj, "nr-irqs", SPAPR_NR_XIRQS, &error_abort);
         if (!qdev_realize(DEVICE(obj), NULL, errp)) {
             return;
         }
@@ -322,7 +318,7 @@ void spapr_irq_init(SpaprMachineState *spapr, Error **errp)
         int i;
 
         dev = qdev_new(TYPE_SPAPR_XIVE);
-        qdev_prop_set_uint32(dev, "nr-irqs", smc->nr_xirqs + SPAPR_IRQ_NR_IPIS);
+        qdev_prop_set_uint32(dev, "nr-irqs", SPAPR_NR_XIRQS + SPAPR_IRQ_NR_IPIS);
         /*
          * 8 XIVE END structures per CPU. One for each available
          * priority
@@ -349,7 +345,7 @@ void spapr_irq_init(SpaprMachineState *spapr, Error **errp)
     }
 
     spapr->qirqs = qemu_allocate_irqs(spapr_set_irq, spapr,
-                                      smc->nr_xirqs + SPAPR_IRQ_NR_IPIS);
+                                      SPAPR_NR_XIRQS + SPAPR_IRQ_NR_IPIS);
 
     /*
      * Mostly we don't actually need this until reset, except that not
@@ -364,11 +360,10 @@ int spapr_irq_claim(SpaprMachineState *spapr, int irq, bool lsi, Error **errp)
 {
     SpaprInterruptController *intcs[] = ALL_INTCS(spapr);
     int i;
-    SpaprMachineClass *smc = SPAPR_MACHINE_GET_CLASS(spapr);
     int rc;
 
     assert(irq >= SPAPR_XIRQ_BASE);
-    assert(irq < (smc->nr_xirqs + SPAPR_XIRQ_BASE));
+    assert(irq < (SPAPR_NR_XIRQS + SPAPR_XIRQ_BASE));
 
     for (i = 0; i < ARRAY_SIZE(intcs); i++) {
         SpaprInterruptController *intc = intcs[i];
@@ -388,10 +383,9 @@ void spapr_irq_free(SpaprMachineState *spapr, int irq, int num)
 {
     SpaprInterruptController *intcs[] = ALL_INTCS(spapr);
     int i, j;
-    SpaprMachineClass *smc = SPAPR_MACHINE_GET_CLASS(spapr);
 
     assert(irq >= SPAPR_XIRQ_BASE);
-    assert((irq + num) <= (smc->nr_xirqs + SPAPR_XIRQ_BASE));
+    assert((irq + num) <= (SPAPR_NR_XIRQS + SPAPR_XIRQ_BASE));
 
     for (i = irq; i < (irq + num); i++) {
         for (j = 0; j < ARRAY_SIZE(intcs); j++) {
@@ -408,8 +402,6 @@ void spapr_irq_free(SpaprMachineState *spapr, int irq, int num)
 
 qemu_irq spapr_qirq(SpaprMachineState *spapr, int irq)
 {
-    SpaprMachineClass *smc = SPAPR_MACHINE_GET_CLASS(spapr);
-
     /*
      * This interface is basically for VIO and PHB devices to find the
      * right qemu_irq to manipulate, so we only allow access to the
@@ -418,7 +410,7 @@ qemu_irq spapr_qirq(SpaprMachineState *spapr, int irq)
      * interfaces, we can change this if we need to in future.
      */
     assert(irq >= SPAPR_XIRQ_BASE);
-    assert(irq < (smc->nr_xirqs + SPAPR_XIRQ_BASE));
+    assert(irq < (SPAPR_NR_XIRQS + SPAPR_XIRQ_BASE));
 
     if (spapr->ics) {
         assert(ics_valid_irq(spapr->ics, irq));
-- 
2.43.5



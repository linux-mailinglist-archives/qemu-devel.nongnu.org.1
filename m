Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A132B1E7D6
	for <lists+qemu-devel@lfdr.de>; Fri,  8 Aug 2025 14:01:14 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ukLlp-0005HS-Dz; Fri, 08 Aug 2025 08:00:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <adityag@linux.ibm.com>)
 id 1ukLlN-0003aj-5a; Fri, 08 Aug 2025 07:59:57 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <adityag@linux.ibm.com>)
 id 1ukLlL-0006gp-2S; Fri, 08 Aug 2025 07:59:56 -0400
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57844BuT019708;
 Fri, 8 Aug 2025 11:59:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=sT2A6/
 adnmBAWR+oaIanzMSz00TSFmMUGmeCvtrQnGM=; b=M/AWBDuQTeDZw4ho3tKnvW
 W21E8UXWndNK9Gr5zEyQWjx3OiKyXKkii61ZxTTSKiC+5Ee0+XX08OG0b3GnSLuh
 WLAK1XEMA+UkKM/B3m3zNmDBORVUA63Gu2B6mxNVuTBIl8tAVoxx7oeQYWonixap
 hMPvxU349l+tG3m+35AyYzfhXaPH+cRwSRrmrDKRYu+KkuqGxCIbnxgTNz20HYaU
 cEGajHc2wzR4V3LxkdEa9FVJE03ANSo78kgvFBtdIZJ8mFJqnwNggQnBiic5+wa7
 6TG0DkkkBcqHE7JECEyC13mZVSjUO2EMRWr66M7x5yqxQD42M2RovXMT4ZEewDPw
 ==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 48c26u5j00-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 08 Aug 2025 11:59:52 +0000 (GMT)
Received: from m0353729.ppops.net (m0353729.ppops.net [127.0.0.1])
 by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 578BkeTb031081;
 Fri, 8 Aug 2025 11:59:52 GMT
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 48c26u5hyw-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 08 Aug 2025 11:59:51 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 578AQUTP025878;
 Fri, 8 Aug 2025 11:59:51 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 48bpwndgcs-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 08 Aug 2025 11:59:50 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com
 [10.20.54.103])
 by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 578BxjjT31261270
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 8 Aug 2025 11:59:45 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 543A620040;
 Fri,  8 Aug 2025 11:59:45 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 5349520043;
 Fri,  8 Aug 2025 11:59:42 +0000 (GMT)
Received: from li-3c92a0cc-27cf-11b2-a85c-b804d9ca68fa.ibm.com.com (unknown
 [9.124.216.151])
 by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Fri,  8 Aug 2025 11:59:42 +0000 (GMT)
From: Aditya Gupta <adityag@linux.ibm.com>
To: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Nicholas Piggin <npiggin@gmail.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>
Cc: Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
 Madhavan Srinivasan <maddy@linux.ibm.com>, <qemu-devel@nongnu.org>,
 <qemu-ppc@nongnu.org>,
 =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Barrat?= <fbarrat@linux.ibm.com>
Subject: [PATCH v9 2/7] ppc/pnv: Introduce Power11 PowerNV machine
Date: Fri,  8 Aug 2025 17:29:24 +0530
Message-ID: <20250808115929.1073910-3-adityag@linux.ibm.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250808115929.1073910-1-adityag@linux.ibm.com>
References: <20250808115929.1073910-1-adityag@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: Gr7sq7duf_nXom-TAm1mMSoGlFBwA5VU
X-Authority-Analysis: v=2.4 cv=F/xXdrhN c=1 sm=1 tr=0 ts=6895e6b8 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=VnNF1IyMAAAA:8 a=pGLkceISAAAA:8
 a=20KFwNOVAAAA:8 a=KZwlIODd7Dk1aeIZX6cA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: VuC-NPidN_Yqqu7Ua5EIXuUKV4P9h2X7
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODA4MDA5NiBTYWx0ZWRfX+pu6HwPaOzYF
 gGZiMhfN4zTFxikXbbHPucSTOl9smR+Sqe9SPf1LWZ7yBrc5L0CeyXmXn0jttNv6tavr/lpIEon
 7Eqk4HHV5HmkeWZQhipRG0v/DbftwUh53lBjqR06aypd76D2Tvgx3PC6aLnGHFIg0PirclghRv2
 i9dFaNAZZ/PDvFstlukh7/zrkBzl8GDilqauWiNF3DqkUXzCjLVexN5slxg0CogmN2Q1zfex9xg
 zPKsDmQahkfCKfk5JGJXD7vjWPizepvhX4bQp97bjthLOnbj1BSYlEtUqxgApXqqzR0cC0AyrJs
 pfh/CtE7PV3u8HDj7n+6ooKHErsfKpYKS5mfsiM6zJwRn1nCibqZXExxzPOF/HnoHJ4SF5vu1rh
 aS+7C0HWBjPDoy0iVTkwiyS0QjVSRqZKANfimsr49W2otUpwExeH4yhrJgW1Wn2NZN3SG6Rz
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-08_03,2025-08-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxscore=0 lowpriorityscore=0 priorityscore=1501 impostorscore=0
 clxscore=1015 spamscore=0 bulkscore=0 adultscore=0 mlxlogscore=999
 malwarescore=0 phishscore=0 suspectscore=0 classifier=spam authscore=0
 authtc=n/a authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2508080096
Received-SPF: pass client-ip=148.163.156.1; envelope-from=adityag@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
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

The Powernv11 machine doesn't have XIVE & PHBs as of now

XIVE2 interface and PHB5 added in later patches to Powernv11 machine

Also add mention of Power11 to powernv documentation

Note: A difference from P10's and P11's machine_class_init is, in P11
different number of PHBs cannot be used on the command line, ie. the
following line does NOT exist in pnv_machine_power11_class_init, which
existed in case of Power10:

    machine_class_allow_dynamic_sysbus_dev(mc, TYPE_PNV_PHB);

Cc: Frédéric Barrat <fbarrat@linux.ibm.com>
Cc: Mahesh J Salgaonkar <mahesh@linux.ibm.com>
Cc: Madhavan Srinivasan <maddy@linux.ibm.com>
Cc: Nicholas Piggin <npiggin@gmail.com>
Reviewed-by: Cédric Le Goater <clg@redhat.com>
Signed-off-by: Aditya Gupta <adityag@linux.ibm.com>
---
 docs/system/ppc/powernv.rst |  9 +++++----
 hw/ppc/pnv.c                | 34 ++++++++++++++++++++++++++++++++++
 2 files changed, 39 insertions(+), 4 deletions(-)

diff --git a/docs/system/ppc/powernv.rst b/docs/system/ppc/powernv.rst
index f3ec2cc69c0d..5154794cc8cd 100644
--- a/docs/system/ppc/powernv.rst
+++ b/docs/system/ppc/powernv.rst
@@ -1,5 +1,5 @@
-PowerNV family boards (``powernv8``, ``powernv9``, ``powernv10``)
-==================================================================
+PowerNV family boards (``powernv8``, ``powernv9``, ``powernv10``, ``powernv11``)
+================================================================================
 
 PowerNV (as Non-Virtualized) is the "bare metal" platform using the
 OPAL firmware. It runs Linux on IBM and OpenPOWER systems and it can
@@ -15,11 +15,12 @@ beyond the scope of what QEMU addresses today.
 Supported devices
 -----------------
 
- * Multi processor support for POWER8, POWER8NVL and POWER9.
+ * Multi processor support for POWER8, POWER8NVL, POWER9, Power10 and Power11.
  * XSCOM, serial communication sideband bus to configure chiplets.
  * Simple LPC Controller.
  * Processor Service Interface (PSI) Controller.
- * Interrupt Controller, XICS (POWER8) and XIVE (POWER9) and XIVE2 (Power10).
+ * Interrupt Controller, XICS (POWER8) and XIVE (POWER9) and XIVE2 (Power10 &
+   Power11).
  * POWER8 PHB3 PCIe Host bridge and POWER9 PHB4 PCIe Host bridge.
  * Simple OCC is an on-chip micro-controller used for power management tasks.
  * iBT device to handle BMC communication, with the internal BMC simulator
diff --git a/hw/ppc/pnv.c b/hw/ppc/pnv.c
index 7422b9063358..b21c4aafaecb 100644
--- a/hw/ppc/pnv.c
+++ b/hw/ppc/pnv.c
@@ -3141,6 +3141,35 @@ static void pnv_machine_p10_rainier_class_init(ObjectClass *oc,
     pmc->i2c_init = pnv_rainier_i2c_init;
 }
 
+static void pnv_machine_power11_class_init(ObjectClass *oc, const void *data)
+{
+    MachineClass *mc = MACHINE_CLASS(oc);
+    PnvMachineClass *pmc = PNV_MACHINE_CLASS(oc);
+    static const char compat[] = "qemu,powernv11\0ibm,powernv";
+
+    pmc->compat = compat;
+    pmc->compat_size = sizeof(compat);
+    pmc->max_smt_threads = 4;
+    pmc->has_lpar_per_thread = true;
+    pmc->quirk_tb_big_core = true;
+    pmc->dt_power_mgt = pnv_dt_power_mgt;
+
+    mc->desc = "IBM PowerNV (Non-Virtualized) Power11";
+    mc->default_cpu_type = POWERPC_CPU_TYPE_NAME("power11_v2.0");
+
+    object_class_property_add_bool(oc, "big-core",
+                                   pnv_machine_get_big_core,
+                                   pnv_machine_set_big_core);
+    object_class_property_set_description(oc, "big-core",
+                              "Use big-core (aka fused-core) mode");
+
+    object_class_property_add_bool(oc, "lpar-per-core",
+                                   pnv_machine_get_lpar_per_core,
+                                   pnv_machine_set_lpar_per_core);
+    object_class_property_set_description(oc, "lpar-per-core",
+                              "Use 1 LPAR per core mode");
+}
+
 static void pnv_cpu_do_nmi_on_cpu(CPUState *cs, run_on_cpu_data arg)
 {
     CPUPPCState *env = cpu_env(cs);
@@ -3254,6 +3283,11 @@ static void pnv_machine_class_init(ObjectClass *oc, const void *data)
     }
 
 static const TypeInfo types[] = {
+    {
+        .name          = MACHINE_TYPE_NAME("powernv11"),
+        .parent        = TYPE_PNV_MACHINE,
+        .class_init    = pnv_machine_power11_class_init,
+    },
     {
         .name          = MACHINE_TYPE_NAME("powernv10-rainier"),
         .parent        = MACHINE_TYPE_NAME("powernv10"),
-- 
2.50.1



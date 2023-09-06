Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A76BA7934AF
	for <lists+qemu-devel@lfdr.de>; Wed,  6 Sep 2023 07:02:48 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qdkfK-0005MK-O9; Wed, 06 Sep 2023 01:01:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1qdkex-0005Gx-KF; Wed, 06 Sep 2023 01:00:59 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1qdket-00086a-OJ; Wed, 06 Sep 2023 01:00:58 -0400
Received: from pps.filterd (m0353724.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 3864uRYm019341; Wed, 6 Sep 2023 05:00:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=hrkXIVCRI9WX3USUt3gM3qss4R3z1ltA8zldhCiu/8A=;
 b=jy9bWO3mqQ1H1JdqjiPz/UReROuYE0R0sQyXz3ddQnt7jEEFcWH8ojpfbNZFGMupKgvI
 GlWtYHhKgJ4DLrRpoNStNQt+uB4vV+F1GfKqMykgW3RUa9lYtK1UFgMktJ73tn/RgqgN
 0E2UzisGQxIsnaEoK9F4iI2ntNt6pTNQteWFiYYCtbS/gCKuQCycEHAQ9b6XMZUrfqfZ
 fCrzZl8Ys9j+Xqftto6IKG9Mktl/x1+YKuVJSoXbhWwov2xdwZ+OppAT82JylOrTV7S2
 gt23hK7U9qp+uoCBm+BlOqoovc+sYn/SAFYO3S3Md6y7bS0jNmUwNy5znlP+W6gXx39a Yw== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3sxjud0295-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 06 Sep 2023 05:00:51 +0000
Received: from m0353724.ppops.net (m0353724.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 38650pw2032366;
 Wed, 6 Sep 2023 05:00:51 GMT
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3sxjud027h-3
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 06 Sep 2023 05:00:51 +0000
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 3864UJoS012212; Wed, 6 Sep 2023 04:34:16 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 3svhkjyu15-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 06 Sep 2023 04:34:16 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com
 [10.20.54.102])
 by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 3864YDCo19399362
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 6 Sep 2023 04:34:13 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 3A68C20043;
 Wed,  6 Sep 2023 04:34:13 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 62C9020040;
 Wed,  6 Sep 2023 04:34:11 +0000 (GMT)
Received: from li-1901474c-32f3-11b2-a85c-fc5ff2c001f3.in.ibm.com (unknown
 [9.109.242.129])
 by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Wed,  6 Sep 2023 04:34:11 +0000 (GMT)
From: Harsh Prateek Bora <harshpb@linux.ibm.com>
To: npiggin@gmail.com, danielhb413@gmail.com, qemu-ppc@nongnu.org
Cc: qemu-devel@nongnu.org, mikey@neuling.org, vaibhav@linux.ibm.com,
 jniethe5@gmail.com, sbhat@linux.ibm.com, kconsul@linux.vnet.ibm.com
Subject: [PATCH RESEND 12/15] ppc: spapr: Use correct source for parttbl info
 for nested PAPR API.
Date: Wed,  6 Sep 2023 10:03:30 +0530
Message-Id: <20230906043333.448244-13-harshpb@linux.ibm.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20230906043333.448244-1-harshpb@linux.ibm.com>
References: <20230906043333.448244-1-harshpb@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: xLRTWieZNUJb2Bzt6SujrdXLjQfIcT4x
X-Proofpoint-ORIG-GUID: EkiNpMF8miN5Z6lzjEgjZsp5rZ_NReEI
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-05_13,2023-09-05_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0
 lowpriorityscore=0 priorityscore=1501 impostorscore=0 bulkscore=0
 adultscore=0 mlxlogscore=902 clxscore=1015 mlxscore=0 suspectscore=0
 phishscore=0 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2308100000 definitions=main-2309060040
Received-SPF: pass client-ip=148.163.158.5; envelope-from=harshpb@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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

For nested PAPR API, we use SpaprMachineStateNestedGuest struct to store
partition table info. Therefore, use the same in spapr_get_pate() as
well.

Signed-off-by: Michael Neuling <mikey@neuling.org>
Signed-off-by: Harsh Prateek Bora <harshpb@linux.ibm.com>
---
 hw/ppc/spapr.c         | 14 ++++++++++++++
 hw/ppc/spapr_nested.c  |  1 -
 include/hw/ppc/spapr.h |  3 +++
 3 files changed, 17 insertions(+), 1 deletion(-)

diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index 7c6f6ee25d..ee4b073d19 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -1361,9 +1361,23 @@ static bool spapr_get_pate(PPCVirtualHypervisor *vhyp, PowerPCCPU *cpu,
         patb += 16 * lpid;
         entry->dw0 = ldq_phys(CPU(cpu)->as, patb);
         entry->dw1 = ldq_phys(CPU(cpu)->as, patb + 8);
+        return true;
     }
 
+#ifdef CONFIG_TCG
+    /* Nested PAPR API */
+    SpaprMachineStateNestedGuest *guest;
+    assert(lpid != 0);
+    guest = spapr_get_nested_guest(spapr, lpid);
+    assert(guest != NULL);
+
+    entry->dw0 = guest->parttbl[0];
+    entry->dw1 = guest->parttbl[1];
+
     return true;
+#else
+    return false;
+#endif
 }
 
 #define HPTE(_table, _i)   (void *)(((uint64_t *)(_table)) + ((_i) * 2))
diff --git a/hw/ppc/spapr_nested.c b/hw/ppc/spapr_nested.c
index 498e7286fa..67e389a762 100644
--- a/hw/ppc/spapr_nested.c
+++ b/hw/ppc/spapr_nested.c
@@ -377,7 +377,6 @@ void spapr_exit_nested(PowerPCCPU *cpu, int excp)
     address_space_unmap(CPU(cpu)->as, regs, len, len, true);
 }
 
-static
 SpaprMachineStateNestedGuest *spapr_get_nested_guest(SpaprMachineState *spapr,
                                                      target_ulong lpid)
 {
diff --git a/include/hw/ppc/spapr.h b/include/hw/ppc/spapr.h
index c9f9682a46..cdc256f057 100644
--- a/include/hw/ppc/spapr.h
+++ b/include/hw/ppc/spapr.h
@@ -1052,5 +1052,8 @@ void spapr_vof_client_dt_finalize(SpaprMachineState *spapr, void *fdt);
 
 /* H_WATCHDOG */
 void spapr_watchdog_init(SpaprMachineState *spapr);
+/* Nested PAPR */
+SpaprMachineStateNestedGuest *spapr_get_nested_guest(SpaprMachineState *spapr,
+                                                     target_ulong lpid);
 
 #endif /* HW_SPAPR_H */
-- 
2.39.3



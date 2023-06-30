Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 93DD5743950
	for <lists+qemu-devel@lfdr.de>; Fri, 30 Jun 2023 12:27:00 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qFBKk-0000wX-W1; Fri, 30 Jun 2023 06:26:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <fbarrat@linux.ibm.com>)
 id 1qFBKi-0000u0-JL; Fri, 30 Jun 2023 06:26:33 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <fbarrat@linux.ibm.com>)
 id 1qFBKg-0006z0-08; Fri, 30 Jun 2023 06:26:32 -0400
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 35UAHVTr031486; Fri, 30 Jun 2023 10:26:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=from : to : subject :
 date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=hCsXIEjYopLDdcblQ53iq6DMigDK/q+/WRdQvnNFBwA=;
 b=o3I610ACSIY0EUR7BoiC1zKvzoHh0rapKtK20vatv3Ll1/Hgj66gUSAhwMPTZ4B4ztr/
 n83UlDHOUhhxnJUA9meavDqDYRKphLdU3i8dogk49qYhAwqs9y7Cb+d7rY7q9UWfXNd+
 H0lI6XNoQ3A3yaF4Mc+kh+PJMgY9XsmmQFRmiPuSYFJ8SQNuCvAyMEbgh2r5wwyHt7/x
 SJjfIZVV2i2wxf11ZQ+4hFK/lUGYPa+0R3I40b82Yb5yXUTV0r3yF+fUo6n1CAKpA7pU
 xXDbXJenYaoSHv/1+lT8kSk4UUrOH5hDkLrdaHKoPeIOEQy1IgwhwRldheB8vcZPW4MG ZQ== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3rhw5n074k-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 30 Jun 2023 10:26:15 +0000
Received: from m0353729.ppops.net (m0353729.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 35UAJBqE005520;
 Fri, 30 Jun 2023 10:26:14 GMT
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com
 [169.51.49.102])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3rhw5n073m-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 30 Jun 2023 10:26:14 +0000
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
 by ppma06ams.nl.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 35U4U9SI011806;
 Fri, 30 Jun 2023 10:26:12 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
 by ppma06ams.nl.ibm.com (PPS) with ESMTPS id 3rdqre43pc-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 30 Jun 2023 10:26:12 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com
 [10.20.54.105])
 by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 35UAQ9dn21430896
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 30 Jun 2023 10:26:09 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id C477A20078;
 Fri, 30 Jun 2023 10:26:09 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 5E9F120040;
 Fri, 30 Jun 2023 10:26:09 +0000 (GMT)
Received: from borneo.ibmuc.com (unknown [9.171.74.60])
 by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Fri, 30 Jun 2023 10:26:09 +0000 (GMT)
From: Frederic Barrat <fbarrat@linux.ibm.com>
To: clg@kaod.org, danielhb413@gmail.com, joel@jms.id.au, qemu-ppc@nongnu.org, 
 qemu-devel@nongnu.org
Subject: [PATCH] pnv/psi: Allow access to PSI registers through xscom
Date: Fri, 30 Jun 2023 12:26:09 +0200
Message-ID: <20230630102609.193214-1-fbarrat@linux.ibm.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: aW4QVTbbHbdOfOitVX6WC97XghI7pZqk
X-Proofpoint-ORIG-GUID: ESErKIKKyOmuj1ZnVOq10sLJglZifhjK
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-06-30_05,2023-06-30_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 malwarescore=0
 priorityscore=1501 bulkscore=0 lowpriorityscore=0 phishscore=0 mlxscore=0
 clxscore=1015 impostorscore=0 adultscore=0 mlxlogscore=999 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2305260000
 definitions=main-2306300085
Received-SPF: pass client-ip=148.163.156.1; envelope-from=fbarrat@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_MSPIKE_H5=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

skiboot only uses mmio to access the PSI registers (once the BAR is
set) but we don't have any reason to block the accesses through
xscom. This patch enables xscom access to the PSI registers. It
converts the xscom addresses to mmio addresses, which requires a bit
of care for the PSIHB, then reuse the existing mmio ops.

Signed-off-by: Frederic Barrat <fbarrat@linux.ibm.com>
---
 hw/ppc/pnv_psi.c | 31 +++++++++++++++++++++----------
 1 file changed, 21 insertions(+), 10 deletions(-)

diff --git a/hw/ppc/pnv_psi.c b/hw/ppc/pnv_psi.c
index 8aa09ab26b..46da58dff8 100644
--- a/hw/ppc/pnv_psi.c
+++ b/hw/ppc/pnv_psi.c
@@ -121,8 +121,12 @@
 #define PSIHB9_BAR_MASK                 0x00fffffffff00000ull
 #define PSIHB9_FSPBAR_MASK              0x00ffffff00000000ull
 
+/* mmio address to xscom address */
 #define PSIHB_REG(addr) (((addr) >> 3) + PSIHB_XSCOM_BAR)
 
+/* xscom address to mmio address */
+#define PSIHB_MMIO(reg) ((reg - PSIHB_XSCOM_BAR) << 3)
+
 static void pnv_psi_set_bar(PnvPsi *psi, uint64_t bar)
 {
     PnvPsiClass *ppc = PNV_PSI_GET_CLASS(psi);
@@ -769,24 +773,31 @@ static const MemoryRegionOps pnv_psi_p9_mmio_ops = {
 
 static uint64_t pnv_psi_p9_xscom_read(void *opaque, hwaddr addr, unsigned size)
 {
-    /* No read are expected */
-    qemu_log_mask(LOG_GUEST_ERROR, "PSI: xscom read at 0x%" PRIx64 "\n", addr);
-    return -1;
+    uint32_t reg = addr >> 3;
+    uint64_t val = -1;
+
+    if (reg < PSIHB_XSCOM_BAR) {
+        /* FIR, not modeled */
+        qemu_log_mask(LOG_UNIMP, "PSI: xscom read at 0x%08x\n", reg);
+    } else {
+        val = pnv_psi_p9_mmio_read(opaque, PSIHB_MMIO(reg), size);
+    }
+    return val;
 }
 
 static void pnv_psi_p9_xscom_write(void *opaque, hwaddr addr,
                                 uint64_t val, unsigned size)
 {
     PnvPsi *psi = PNV_PSI(opaque);
+    uint32_t reg = addr >> 3;
 
-    /* XSCOM is only used to set the PSIHB MMIO region */
-    switch (addr >> 3) {
-    case PSIHB_XSCOM_BAR:
+    if (reg < PSIHB_XSCOM_BAR) {
+        /* FIR, not modeled */
+        qemu_log_mask(LOG_UNIMP, "PSI: xscom write at 0x%08x\n", reg);
+    } else if (reg == PSIHB_XSCOM_BAR) {
         pnv_psi_set_bar(psi, val);
-        break;
-    default:
-        qemu_log_mask(LOG_GUEST_ERROR, "PSI: xscom write at 0x%" PRIx64 "\n",
-                      addr);
+    } else {
+        pnv_psi_p9_mmio_write(opaque, PSIHB_MMIO(reg), val, size);
     }
 }
 
-- 
2.41.0



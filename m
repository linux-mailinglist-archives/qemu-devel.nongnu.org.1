Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 47F327168F2
	for <lists+qemu-devel@lfdr.de>; Tue, 30 May 2023 18:13:23 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q41x1-0004n1-P5; Tue, 30 May 2023 12:11:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <fbarrat@linux.ibm.com>)
 id 1q41wo-0004jP-Rr; Tue, 30 May 2023 12:11:46 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <fbarrat@linux.ibm.com>)
 id 1q41wm-00034m-MJ; Tue, 30 May 2023 12:11:46 -0400
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 34UG8lN2016708; Tue, 30 May 2023 16:11:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=from : to : subject :
 date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=nprdm7Y9yY0dNMUvaRmJmg7K+lfnY6B6un8ZVh3ztNQ=;
 b=BYgoTLDtL6ZANXaoj9i4Rz6SDSYHB+AldRb0dRW1ljh8GNPHLceaFS45VK0SNql3HRWY
 PuV4yNIfQU16vCrsb9bD+9LbFRUjPIB9t1GEXHMq3ZUL4m8WYQ8nThp+dY8lw4WrifYQ
 ySBbElyNjYunOgg2J8zkBJ5vykiFDOc1jK4RWnwpXOZUT6Qbis7vFVM9PcLgU38OUN+X
 iAs3MlRuEGqm5pNM4DV339EdnsbNSbB/NoYFlZu685K+A+ghEz2Vystj7sxTSLRCzyJH
 kCKY+AdIHhP7w0mLuJDgx/LR9dUqzvz2pJM5GzwJMlxH042Ab5uWytScrRHUxR4TV+Us ww== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3qwh1deryc-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 30 May 2023 16:11:35 +0000
Received: from m0360072.ppops.net (m0360072.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 34UG8uLT017655;
 Tue, 30 May 2023 16:11:35 GMT
Received: from ppma03fra.de.ibm.com (6b.4a.5195.ip4.static.sl-reverse.com
 [149.81.74.107])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3qwh1derxm-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 30 May 2023 16:11:35 +0000
Received: from pps.filterd (ppma03fra.de.ibm.com [127.0.0.1])
 by ppma03fra.de.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 34U7knAl001794;
 Tue, 30 May 2023 16:11:33 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
 by ppma03fra.de.ibm.com (PPS) with ESMTPS id 3qu9g59agw-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 30 May 2023 16:11:33 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com
 [10.20.54.106])
 by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 34UGBUFa43713248
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 30 May 2023 16:11:30 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id C72922004B;
 Tue, 30 May 2023 16:11:30 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 8371820043;
 Tue, 30 May 2023 16:11:30 +0000 (GMT)
Received: from borneo.ibmuc.com (unknown [9.171.3.249])
 by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Tue, 30 May 2023 16:11:30 +0000 (GMT)
From: Frederic Barrat <fbarrat@linux.ibm.com>
To: clg@kaod.org, danielhb413@gmail.com, qemu-ppc@nongnu.org,
 qemu-devel@nongnu.org
Subject: [PATCH 2/4] pnv/xive2: Add definition for the ESB cache configuration
 register
Date: Tue, 30 May 2023 18:11:27 +0200
Message-Id: <20230530161129.313258-3-fbarrat@linux.ibm.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230530161129.313258-1-fbarrat@linux.ibm.com>
References: <20230530161129.313258-1-fbarrat@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 5042lEgG91m-Q4LDKUIVN4P4QbUwGxsP
X-Proofpoint-ORIG-GUID: VaQ1Hn3hdcQE_iikH8R9-BFJHORgXBMV
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-05-30_12,2023-05-30_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 phishscore=0
 lowpriorityscore=0 malwarescore=0 mlxlogscore=881 priorityscore=1501
 adultscore=0 impostorscore=0 suspectscore=0 clxscore=1015 mlxscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2304280000 definitions=main-2305300127
Received-SPF: pass client-ip=148.163.158.5; envelope-from=fbarrat@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
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

Add basic read/write support for the ESB cache configuration register
on P10. We don't model the ESB cache in qemu so reading/writing the
register won't do anything, but it avoids logging a guest error when
skiboot configures it:

qemu-system-ppc64 -machine powernv10 ... -d guest_errors
      ...
XIVE[0] - VC: invalid read @240
XIVE[0] - VC: invalid write @240

Signed-off-by: Frederic Barrat <fbarrat@linux.ibm.com>
---
 hw/intc/pnv_xive2.c      | 7 +++++++
 hw/intc/pnv_xive2_regs.h | 4 ++++
 2 files changed, 11 insertions(+)

diff --git a/hw/intc/pnv_xive2.c b/hw/intc/pnv_xive2.c
index 889e409929..a75ff270ac 100644
--- a/hw/intc/pnv_xive2.c
+++ b/hw/intc/pnv_xive2.c
@@ -955,6 +955,10 @@ static uint64_t pnv_xive2_ic_vc_read(void *opaque, hwaddr offset,
         val = xive->vc_regs[reg];
         break;
 
+    case VC_ESBC_CFG:
+        val = xive->vc_regs[reg];
+        break;
+
     /*
      * EAS cache updates (not modeled)
      */
@@ -1046,6 +1050,9 @@ static void pnv_xive2_ic_vc_write(void *opaque, hwaddr offset,
         /* ESB update */
         break;
 
+    case VC_ESBC_CFG:
+        break;
+
     /*
      * EAS cache updates (not modeled)
      */
diff --git a/hw/intc/pnv_xive2_regs.h b/hw/intc/pnv_xive2_regs.h
index 8f1e0a1fde..7165dc8704 100644
--- a/hw/intc/pnv_xive2_regs.h
+++ b/hw/intc/pnv_xive2_regs.h
@@ -232,6 +232,10 @@
 #define  VC_ESBC_FLUSH_POLL_BLOCK_ID_MASK       PPC_BITMASK(32, 35)
 #define  VC_ESBC_FLUSH_POLL_OFFSET_MASK         PPC_BITMASK(36, 63) /* 28-bit */
 
+/* ESBC configuration */
+#define X_VC_ESBC_CFG                           0x148
+#define VC_ESBC_CFG                             0x240
+
 /* EASC flush control register */
 #define X_VC_EASC_FLUSH_CTRL                    0x160
 #define VC_EASC_FLUSH_CTRL                      0x300
-- 
2.40.1



Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CACE7168EF
	for <lists+qemu-devel@lfdr.de>; Tue, 30 May 2023 18:13:23 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q41ww-0004lY-Nj; Tue, 30 May 2023 12:11:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <fbarrat@linux.ibm.com>)
 id 1q41wr-0004kE-SS; Tue, 30 May 2023 12:11:50 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <fbarrat@linux.ibm.com>)
 id 1q41wk-00032c-1X; Tue, 30 May 2023 12:11:49 -0400
Received: from pps.filterd (m0353727.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 34UFtKQ3008005; Tue, 30 May 2023 16:11:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=from : to : subject :
 date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=YQmdFwqC04a+YZmzOgoxNczpbPnfHmYCKgaWKlCAsR0=;
 b=aU/hdk0MEi6vy2dkU0UVrI+Vr4RJd5Cc4tFIXwhVLX6J4BivZEDrQHVfMmPbvydXC4Dt
 wgMRCGnq16/V7W/ND0OHgY55FlAyvbUhvOBKo0rPOdfSLHGCpyIwxY/2qeFsOO8S2ENH
 0CSA8k6JX+fgux3XdmU89+j9BG7oUuTs0V91TF2l91NVFGK7o0eIVkEQNxxOOO4Vn93S
 Px7aGY3q/Mv+LQXEFjPtnQVbixtVpIGDo93rh+ANHr5vKZTPMMqEO25TxG+pQ3R3XnsS
 RPaI7rVTTOp2DR8SMSl+o2kF8d8xXKU9voX0WkC0Y9YMC96UTzTFeAtc6pDFCLFKBjSZ 1Q== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3qwm6x0qvd-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 30 May 2023 16:11:35 +0000
Received: from m0353727.ppops.net (m0353727.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 34UFuxlc011811;
 Tue, 30 May 2023 16:11:35 GMT
Received: from ppma05fra.de.ibm.com (6c.4a.5195.ip4.static.sl-reverse.com
 [149.81.74.108])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3qwm6x0qtm-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 30 May 2023 16:11:35 +0000
Received: from pps.filterd (ppma05fra.de.ibm.com [127.0.0.1])
 by ppma05fra.de.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 34UBLKde007004;
 Tue, 30 May 2023 16:11:33 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
 by ppma05fra.de.ibm.com (PPS) with ESMTPS id 3qu9g59axp-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 30 May 2023 16:11:32 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com
 [10.20.54.106])
 by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 34UGBUS343713246
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 30 May 2023 16:11:30 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 6FCCE20040;
 Tue, 30 May 2023 16:11:30 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 2C3F32004B;
 Tue, 30 May 2023 16:11:30 +0000 (GMT)
Received: from borneo.ibmuc.com (unknown [9.171.3.249])
 by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Tue, 30 May 2023 16:11:30 +0000 (GMT)
From: Frederic Barrat <fbarrat@linux.ibm.com>
To: clg@kaod.org, danielhb413@gmail.com, qemu-ppc@nongnu.org,
 qemu-devel@nongnu.org
Subject: [PATCH 1/4] pnv/xive2: Add definition for TCTXT Config register
Date: Tue, 30 May 2023 18:11:26 +0200
Message-Id: <20230530161129.313258-2-fbarrat@linux.ibm.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230530161129.313258-1-fbarrat@linux.ibm.com>
References: <20230530161129.313258-1-fbarrat@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: xBPAuJuobYAWv2kxrR2vH0krc73kWrHN
X-Proofpoint-GUID: 9mquZvIHkG35YiWNTJ2ezhrbPqR--uuc
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-05-30_12,2023-05-30_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxscore=0 spamscore=0
 impostorscore=0 suspectscore=0 bulkscore=0 phishscore=0 adultscore=0
 priorityscore=1501 malwarescore=0 mlxlogscore=999 lowpriorityscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2304280000 definitions=main-2305300127
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

Add basic read/write support for the TCTXT Config register on P10. qemu
doesn't do anything with it yet, but it avoids logging a guest error
when skiboot configures the fused-core state:

qemu-system-ppc64 -machine powernv10 ... -d guest_errors
  ...
[    0.131670000,5] XIVE: [ IC 00  ] Initializing XIVE block ID 0...
XIVE[0] - TCTXT: invalid read @140
XIVE[0] - TCTXT: invalid write @140

Signed-off-by: Frederic Barrat <fbarrat@linux.ibm.com>
---
 hw/intc/pnv_xive2.c      | 8 +++++++-
 hw/intc/pnv_xive2_regs.h | 4 ++++
 2 files changed, 11 insertions(+), 1 deletion(-)

diff --git a/hw/intc/pnv_xive2.c b/hw/intc/pnv_xive2.c
index 7176d70234..889e409929 100644
--- a/hw/intc/pnv_xive2.c
+++ b/hw/intc/pnv_xive2.c
@@ -1265,6 +1265,9 @@ static uint64_t pnv_xive2_ic_tctxt_read(void *opaque, hwaddr offset,
     case TCTXT_EN1_RESET:
         val = xive->tctxt_regs[TCTXT_EN1 >> 3];
         break;
+    case TCTXT_CFG:
+        val = xive->tctxt_regs[reg];
+        break;
     default:
         xive2_error(xive, "TCTXT: invalid read @%"HWADDR_PRIx, offset);
     }
@@ -1276,6 +1279,7 @@ static void pnv_xive2_ic_tctxt_write(void *opaque, hwaddr offset,
                                      uint64_t val, unsigned size)
 {
     PnvXive2 *xive = PNV_XIVE2(opaque);
+    uint32_t reg = offset >> 3;
 
     switch (offset) {
     /*
@@ -1297,7 +1301,9 @@ static void pnv_xive2_ic_tctxt_write(void *opaque, hwaddr offset,
     case TCTXT_EN1_RESET:
         xive->tctxt_regs[TCTXT_EN1 >> 3] &= ~val;
         break;
-
+    case TCTXT_CFG:
+        xive->tctxt_regs[reg] = val;
+        break;
     default:
         xive2_error(xive, "TCTXT: invalid write @%"HWADDR_PRIx, offset);
         return;
diff --git a/hw/intc/pnv_xive2_regs.h b/hw/intc/pnv_xive2_regs.h
index 0c096e4adb..8f1e0a1fde 100644
--- a/hw/intc/pnv_xive2_regs.h
+++ b/hw/intc/pnv_xive2_regs.h
@@ -405,6 +405,10 @@
 #define X_TCTXT_EN1_RESET                       0x307
 #define TCTXT_EN1_RESET                         0x038
 
+/* TCTXT Config register */
+#define X_TCTXT_CFG                             0x328
+#define TCTXT_CFG                               0x140
+
 /*
  * VSD Tables
  */
-- 
2.40.1



Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 973A5719BB3
	for <lists+qemu-devel@lfdr.de>; Thu,  1 Jun 2023 14:14:32 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q4hBk-0005mi-Fs; Thu, 01 Jun 2023 08:13:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <fbarrat@linux.ibm.com>)
 id 1q4hBf-0005eL-Oz; Thu, 01 Jun 2023 08:13:51 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <fbarrat@linux.ibm.com>)
 id 1q4hBc-0006Az-6f; Thu, 01 Jun 2023 08:13:51 -0400
Received: from pps.filterd (m0353724.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 351Bi9QV000869; Thu, 1 Jun 2023 12:13:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=from : to : subject :
 date : message-id : in-reply-to : references : mime-version : content-type
 : content-transfer-encoding; s=pp1;
 bh=VIhY2YzaJqik/wFFW6BlxjdwMK2YBRCCzK1b0MNLuc8=;
 b=kbUgkZ8t6BL8YTA44bBn/BQhPNPaL7FSlQLC51TH0ky7SMG059Xi5roQ04r21E6N+EQa
 e+rgy8HzYLYPdJjyeEa5Y4Si0lyXtiujVU/C8DDF3qoncgVPS8Rg4RuHzHh2CBzH9wQ2
 95hStWzudhzJuBq+JQ4bGNqSqwTE1gBq44Kq/eYydrw+18cx4hwZ3JdiblSsddTjoMz7
 xu3VGnfsoU1J0AAfV9C24OO9uyFxjFn+AesDgdQ4QhexA7bLL64JbEn8GsGF+rVK2nkS
 +5nc6DPhqhjHJkfdbAr6ozeU3O7G9+VfRF2BjX7954lLXldUSF/o7smr1m5sjOjBQNQ5 Yg== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3qxtqeruxd-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 01 Jun 2023 12:13:37 +0000
Received: from m0353724.ppops.net (m0353724.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 351C8J6r025252;
 Thu, 1 Jun 2023 12:13:37 GMT
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com
 [169.51.49.102])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3qxtqeruw1-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 01 Jun 2023 12:13:37 +0000
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
 by ppma06ams.nl.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 3514t48Y010933;
 Thu, 1 Jun 2023 12:13:35 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
 by ppma06ams.nl.ibm.com (PPS) with ESMTPS id 3qu94e2gw0-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 01 Jun 2023 12:13:35 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com
 [10.20.54.106])
 by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 351CDXHq37487326
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 1 Jun 2023 12:13:33 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 08FA22006A;
 Thu,  1 Jun 2023 12:13:32 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id C58AD2005A;
 Thu,  1 Jun 2023 12:13:31 +0000 (GMT)
Received: from borneo.tlslab.ibm.com (unknown [9.101.4.34])
 by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Thu,  1 Jun 2023 12:13:31 +0000 (GMT)
From: Frederic Barrat <fbarrat@linux.ibm.com>
To: clg@kaod.org, danielhb413@gmail.com, qemu-ppc@nongnu.org,
 qemu-devel@nongnu.org
Subject: [PATCH v2 1/5] pnv/xive2: Add definition for TCTXT Config register
Date: Thu,  1 Jun 2023 14:13:27 +0200
Message-Id: <20230601121331.487207-2-fbarrat@linux.ibm.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230601121331.487207-1-fbarrat@linux.ibm.com>
References: <20230601121331.487207-1-fbarrat@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: -CQ_yegQDlzlznB041pQC903sbvljzO5
X-Proofpoint-ORIG-GUID: W6sbWzzN4emHeaPDmp-_3n7FR9eW792I
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-06-01_08,2023-05-31_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 clxscore=1015
 malwarescore=0 suspectscore=0 bulkscore=0 mlxscore=0 adultscore=0
 priorityscore=1501 impostorscore=0 lowpriorityscore=0 mlxlogscore=999
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2304280000 definitions=main-2306010107
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

Add basic read/write support for the TCTXT Config register on P10. qemu
doesn't do anything with it yet, but it avoids logging a guest error
when skiboot configures the fused-core state:

qemu-system-ppc64 -machine powernv10 ... -d guest_errors
  ...
[    0.131670000,5] XIVE: [ IC 00  ] Initializing XIVE block ID 0...
XIVE[0] - TCTXT: invalid read @140
XIVE[0] - TCTXT: invalid write @140

Signed-off-by: Frederic Barrat <fbarrat@linux.ibm.com>
Reviewed-by: Cédric Le Goater <clg@kaod.org>
---
 hw/intc/pnv_xive2.c      | 8 +++++++-
 hw/intc/pnv_xive2_regs.h | 4 ++++
 2 files changed, 11 insertions(+), 1 deletion(-)

diff --git a/hw/intc/pnv_xive2.c b/hw/intc/pnv_xive2.c
index e688381536..f0817a124f 100644
--- a/hw/intc/pnv_xive2.c
+++ b/hw/intc/pnv_xive2.c
@@ -1269,6 +1269,9 @@ static uint64_t pnv_xive2_ic_tctxt_read(void *opaque, hwaddr offset,
     case TCTXT_EN1_RESET:
         val = xive->tctxt_regs[TCTXT_EN1 >> 3];
         break;
+    case TCTXT_CFG:
+        val = xive->tctxt_regs[reg];
+        break;
     default:
         xive2_error(xive, "TCTXT: invalid read @%"HWADDR_PRIx, offset);
     }
@@ -1280,6 +1283,7 @@ static void pnv_xive2_ic_tctxt_write(void *opaque, hwaddr offset,
                                      uint64_t val, unsigned size)
 {
     PnvXive2 *xive = PNV_XIVE2(opaque);
+    uint32_t reg = offset >> 3;
 
     switch (offset) {
     /*
@@ -1301,7 +1305,9 @@ static void pnv_xive2_ic_tctxt_write(void *opaque, hwaddr offset,
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



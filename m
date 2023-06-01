Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B7F0E719BB9
	for <lists+qemu-devel@lfdr.de>; Thu,  1 Jun 2023 14:14:51 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q4hBj-0005l8-Ol; Thu, 01 Jun 2023 08:13:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <fbarrat@linux.ibm.com>)
 id 1q4hBe-0005Yl-Rk; Thu, 01 Jun 2023 08:13:50 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <fbarrat@linux.ibm.com>)
 id 1q4hBc-0006Ax-6f; Thu, 01 Jun 2023 08:13:50 -0400
Received: from pps.filterd (m0353722.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 351Bi63G024464; Thu, 1 Jun 2023 12:13:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=from : to : subject :
 date : message-id : in-reply-to : references : mime-version : content-type
 : content-transfer-encoding; s=pp1;
 bh=Oboc4Z93T7V7Zawd6MSzuroFswZQPgqdUWimiJPWQ1M=;
 b=ob/RdRzzhWXBh0lW2qB615oUH7UEZtOhZENm6tD7RZFeSNyGsmuxIr3gHglAXkmRQ25+
 fXnKmGdH3Q6Lbl80xzkj+4hewAqd7sMM5PRbUpaNlp3iB+YoGixxoIphfi5x0NeLoq0l
 NiXzzoVddG9+Qr1qD0deTnyVyTM+XWMs/MtC9ogr1Jj9ad1GeW0j4h+im3l2/WZUTkx+
 LcsyK07JedD8QVRY3eMdHNeRCE6AGNrk/YdYi/reSTQJF2+tUvfKjBdT3ZqO40QcUPSw
 elaH4JLKI9NQxmYAgRGeuSwqLWC0lm79P09V3coKl7Ys/pxNozCBWPIgoJJaDRUAJMsk jw== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3qxtqds2yt-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 01 Jun 2023 12:13:37 +0000
Received: from m0353722.ppops.net (m0353722.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 351BjkYu030367;
 Thu, 1 Jun 2023 12:13:36 GMT
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com
 [169.51.49.99])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3qxtqds2xn-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 01 Jun 2023 12:13:36 +0000
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
 by ppma04ams.nl.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 3513PK4B017606;
 Thu, 1 Jun 2023 12:13:34 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
 by ppma04ams.nl.ibm.com (PPS) with ESMTPS id 3qu9g5ags5-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 01 Jun 2023 12:13:34 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com
 [10.20.54.106])
 by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 351CDW7532702806
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 1 Jun 2023 12:13:32 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 4708B2004B;
 Thu,  1 Jun 2023 12:13:32 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 189F02005A;
 Thu,  1 Jun 2023 12:13:32 +0000 (GMT)
Received: from borneo.tlslab.ibm.com (unknown [9.101.4.34])
 by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Thu,  1 Jun 2023 12:13:32 +0000 (GMT)
From: Frederic Barrat <fbarrat@linux.ibm.com>
To: clg@kaod.org, danielhb413@gmail.com, qemu-ppc@nongnu.org,
 qemu-devel@nongnu.org
Subject: [PATCH v2 2/5] pnv/xive2: Add definition for the ESB cache
 configuration register
Date: Thu,  1 Jun 2023 14:13:28 +0200
Message-Id: <20230601121331.487207-3-fbarrat@linux.ibm.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230601121331.487207-1-fbarrat@linux.ibm.com>
References: <20230601121331.487207-1-fbarrat@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: _3VOIIR4zYaeEIMskJ-bN4SJy5NeV5IO
X-Proofpoint-GUID: AcHZVastytFX3ZSGfPW0lr4ohTeQWdEp
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-06-01_08,2023-05-31_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxlogscore=929
 impostorscore=0 malwarescore=0 phishscore=0 adultscore=0
 priorityscore=1501 spamscore=0 suspectscore=0 clxscore=1015 mlxscore=0
 lowpriorityscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2304280000 definitions=main-2306010107
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
Reviewed-by: Cédric Le Goater <clg@kaod.org>
---
 hw/intc/pnv_xive2.c      | 7 +++++++
 hw/intc/pnv_xive2_regs.h | 4 ++++
 2 files changed, 11 insertions(+)

diff --git a/hw/intc/pnv_xive2.c b/hw/intc/pnv_xive2.c
index f0817a124f..9778c102ff 100644
--- a/hw/intc/pnv_xive2.c
+++ b/hw/intc/pnv_xive2.c
@@ -959,6 +959,10 @@ static uint64_t pnv_xive2_ic_vc_read(void *opaque, hwaddr offset,
         val = xive->vc_regs[reg];
         break;
 
+    case VC_ESBC_CFG:
+        val = xive->vc_regs[reg];
+        break;
+
     /*
      * EAS cache updates (not modeled)
      */
@@ -1050,6 +1054,9 @@ static void pnv_xive2_ic_vc_write(void *opaque, hwaddr offset,
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



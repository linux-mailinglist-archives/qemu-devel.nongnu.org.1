Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E4D79931A63
	for <lists+qemu-devel@lfdr.de>; Mon, 15 Jul 2024 20:35:34 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sTQXB-0007hu-KZ; Mon, 15 Jul 2024 14:34:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kowal@linux.vnet.ibm.com>)
 id 1sTQX9-0007dC-W2; Mon, 15 Jul 2024 14:34:48 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kowal@linux.vnet.ibm.com>)
 id 1sTQX8-0007IS-BX; Mon, 15 Jul 2024 14:34:47 -0400
Received: from pps.filterd (m0353728.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46FHSFmn013124;
 Mon, 15 Jul 2024 18:34:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from
 :to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding; s=pp1; bh=+TPxINnyUzx/P
 YcUT1yRLgp4+fLxdr68I6FETusS168=; b=AeO8l5AQY6OF6HnMC9OycFu17Iiyi
 dU/iTFw2gyI/c39Jfo8EiLVSmB3vj6HEL1Ca1orsJWQ4Tb52AJYp4kikYwizDdYY
 yILIkAtfpfUztK4eOLmCM4krVGT/bugJBCFh1RTQrGm/WUGKiTnTv+aKCkHMTqA6
 bU7oc+IJfQ2RrA8e2dF5znGWli4oEWn+sK5FGXtwKM0dlWvTfnD4gWW3hEfhZV5K
 8khOGouDDwLvVodRMH5P+jMj/PlA8s0aQGwFVIY9FB+P7vAbceRTWSxyi+5yXdOl
 Ts4nq4P3ub0Zak25L/fL98WUKy+Q/WbCIrnevh0yySs5fVrTRdzZF0sgA==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 40d86rr3jg-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 15 Jul 2024 18:34:36 +0000 (GMT)
Received: from m0353728.ppops.net (m0353728.ppops.net [127.0.0.1])
 by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 46FIYaRU011884;
 Mon, 15 Jul 2024 18:34:36 GMT
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 40d86rr3je-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 15 Jul 2024 18:34:36 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 46FGZk1Y030550; Mon, 15 Jul 2024 18:34:35 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 40c4a0gg70-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 15 Jul 2024 18:34:34 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com
 [10.20.54.104])
 by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 46FIYT8N13697488
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 15 Jul 2024 18:34:31 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 32B3C20043;
 Mon, 15 Jul 2024 18:34:29 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 11D9420040;
 Mon, 15 Jul 2024 18:34:28 +0000 (GMT)
Received: from gfwr518.rchland.ibm.com (unknown [9.10.239.106])
 by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Mon, 15 Jul 2024 18:34:27 +0000 (GMT)
From: Michael Kowal <kowal@linux.vnet.ibm.com>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, clg@kaod.org, fbarrat@linux.ibm.com,
 npiggin@gmail.com, milesg@linux.ibm.com
Subject: [PATCH v2 6/9] pnv/xive2: Enable VST NVG and NVC index compression
Date: Mon, 15 Jul 2024 13:33:29 -0500
Message-Id: <20240715183332.27287-7-kowal@linux.vnet.ibm.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20240715183332.27287-1-kowal@linux.vnet.ibm.com>
References: <20240715183332.27287-1-kowal@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: smAxrQR3gf-yWLHwPdvp8abzFroR0AxE
X-Proofpoint-ORIG-GUID: 9lc4SAP6NKPx9NsukjaReBatyxlRT0Br
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-15_12,2024-07-11_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxlogscore=896 bulkscore=0
 spamscore=0 malwarescore=0 adultscore=0 clxscore=1015 priorityscore=1501
 suspectscore=0 mlxscore=0 impostorscore=0 phishscore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2406140001
 definitions=main-2407150143
Received-SPF: none client-ip=148.163.156.1;
 envelope-from=kowal@linux.vnet.ibm.com; helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_MSPIKE_H3=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

From: Frederic Barrat <fbarrat@linux.ibm.com>

Enable NVG and NVC VST tables for index compression which indicates the number
of bits the address is shifted to the right for the table accesses.
The compression values are defined as:
   0000 - No compression
   0001 - 1 bit shift
   0010 - 2 bit shift
   ....
   1000 - 8 bit shift
   1001-1111 - No compression

Signed-off-by: Frederic Barrat <fbarrat@linux.ibm.com>
Signed-off-by: Michael Kowal <kowal@linux.vnet.ibm.com>
---
 hw/intc/pnv_xive2_regs.h |  2 ++
 hw/intc/pnv_xive2.c      | 20 ++++++++++++++++++++
 2 files changed, 22 insertions(+)

diff --git a/hw/intc/pnv_xive2_regs.h b/hw/intc/pnv_xive2_regs.h
index ca05255d20..e8b87b3d2c 100644
--- a/hw/intc/pnv_xive2_regs.h
+++ b/hw/intc/pnv_xive2_regs.h
@@ -427,6 +427,8 @@
 #define X_PC_NXC_PROC_CONFIG                    0x28A
 #define PC_NXC_PROC_CONFIG                      0x450
 #define   PC_NXC_PROC_CONFIG_WATCH_ASSIGN       PPC_BITMASK(0, 3)
+#define   PC_NXC_PROC_CONFIG_NVG_TABLE_COMPRESS PPC_BITMASK(32, 35)
+#define   PC_NXC_PROC_CONFIG_NVC_TABLE_COMPRESS PPC_BITMASK(36, 39)
 
 /* NxC Cache Watch 0 Specification */
 #define X_PC_NXC_WATCH0_SPEC                    0x2A0
diff --git a/hw/intc/pnv_xive2.c b/hw/intc/pnv_xive2.c
index 9e45161869..b14fad1b2e 100644
--- a/hw/intc/pnv_xive2.c
+++ b/hw/intc/pnv_xive2.c
@@ -217,6 +217,20 @@ static uint64_t pnv_xive2_vst_addr_indirect(PnvXive2 *xive, uint32_t type,
     return pnv_xive2_vst_addr_direct(xive, type, vsd, (idx % vst_per_page));
 }
 
+static uint8_t pnv_xive2_nvc_table_compress_shift(PnvXive2 *xive)
+{
+    uint8_t shift =  GETFIELD(PC_NXC_PROC_CONFIG_NVC_TABLE_COMPRESS,
+                              xive->pc_regs[PC_NXC_PROC_CONFIG >> 3]);
+    return shift > 8 ? 0 : shift;
+}
+
+static uint8_t pnv_xive2_nvg_table_compress_shift(PnvXive2 *xive)
+{
+    uint8_t shift = GETFIELD(PC_NXC_PROC_CONFIG_NVG_TABLE_COMPRESS,
+                             xive->pc_regs[PC_NXC_PROC_CONFIG >> 3]);
+    return shift > 8 ? 0 : shift;
+}
+
 static uint64_t pnv_xive2_vst_addr(PnvXive2 *xive, uint32_t type, uint8_t blk,
                                    uint32_t idx)
 {
@@ -238,6 +252,12 @@ static uint64_t pnv_xive2_vst_addr(PnvXive2 *xive, uint32_t type, uint8_t blk,
         return xive ? pnv_xive2_vst_addr(xive, type, blk, idx) : 0;
     }
 
+    if (type == VST_NVG) {
+        idx >>= pnv_xive2_nvg_table_compress_shift(xive);
+    } else if (type == VST_NVC) {
+        idx >>= pnv_xive2_nvc_table_compress_shift(xive);
+    }
+
     if (VSD_INDIRECT & vsd) {
         return pnv_xive2_vst_addr_indirect(xive, type, vsd, idx);
     }
-- 
2.43.0



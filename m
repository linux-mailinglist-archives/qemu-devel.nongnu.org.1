Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 926DC743C9B
	for <lists+qemu-devel@lfdr.de>; Fri, 30 Jun 2023 15:22:59 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qFE4E-0007Vi-9N; Fri, 30 Jun 2023 09:21:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <fbarrat@linux.ibm.com>)
 id 1qFE48-0007V9-Pw; Fri, 30 Jun 2023 09:21:37 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <fbarrat@linux.ibm.com>)
 id 1qFE45-000373-08; Fri, 30 Jun 2023 09:21:35 -0400
Received: from pps.filterd (m0353724.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 35UDFjRh009649; Fri, 30 Jun 2023 13:21:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=from : to : subject :
 date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=+1IHT0rw4VFaWlGosbyrYDrV60xddrBrVTGRBZKsW3E=;
 b=tNDzLlB1bJQf7a3dIAYGg10FD8/K8Bj63LAk4JR7yCeWeJgBH7HJHHR5FGi5epKyD/aD
 c8/Wrb+47X69I7MWMO8zN/O5lOTndMFkEsvR6coXpHf5g4vEg7gUC8ECSlWFNBb8Kklz
 /8RduInGKt7/TZwiAbXdWbOOlYA8l9fNcgMK9QIYRFwfdqgCR8N0vczATIQzRnHXppXp
 SK24vbGYwl1TXeawpEnCjFHIkmEzrEt+WXJ+axiNher2A+OFOnov0HVh1RSKWE2mTIjP
 XcRiPtftT8vwdxR7kjrbzHw8HuSiImhWmLimB4hmcatclA+fMHeVTALgJnLrq53ygO/L pg== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3rhysdr752-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 30 Jun 2023 13:21:21 +0000
Received: from m0353724.ppops.net (m0353724.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 35UDGSLb012766;
 Fri, 30 Jun 2023 13:21:20 GMT
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com
 [169.51.49.102])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3rhysdr71m-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 30 Jun 2023 13:21:20 +0000
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
 by ppma06ams.nl.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 35U2QPaI032436;
 Fri, 30 Jun 2023 13:20:18 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
 by ppma06ams.nl.ibm.com (PPS) with ESMTPS id 3rdqre45x8-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 30 Jun 2023 13:20:18 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com
 [10.20.54.104])
 by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 35UDKG5B58065244
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 30 Jun 2023 13:20:16 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 2DF7A20043;
 Fri, 30 Jun 2023 13:20:16 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id C762120040;
 Fri, 30 Jun 2023 13:20:15 +0000 (GMT)
Received: from borneo.ibmuc.com (unknown [9.171.74.60])
 by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Fri, 30 Jun 2023 13:20:15 +0000 (GMT)
From: Frederic Barrat <fbarrat@linux.ibm.com>
To: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Daniel Henrique Barboza <danielhb413@gmail.com>, qemu-ppc@nongnu.org,
 qemu-devel@nongnu.org
Subject: [PATCH] pnv/xive2: Fix TIMA offset for indirect access
Date: Fri, 30 Jun 2023 15:20:15 +0200
Message-ID: <20230630132015.204825-1-fbarrat@linux.ibm.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 29O2bXxHPhPqEeoTf9ON4kMJFnVGUzib
X-Proofpoint-ORIG-GUID: p3YaDEZwGb_LpluOdeOXWZ9IiHz4clQU
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-06-30_05,2023-06-30_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0
 impostorscore=0 lowpriorityscore=0 spamscore=0 clxscore=1015 mlxscore=0
 phishscore=0 adultscore=0 priorityscore=1501 bulkscore=0 mlxlogscore=999
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2306300111
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

Direct TIMA operations can be done through 4 pages, each with a
different privilege level dictating what fields can be accessed. On
the other hand, indirect TIMA accesses on P10 are done through a
single page, which is the equivalent of the most privileged page of
direct TIMA accesses.

The offset in the IC bar of an indirect access specifies what hw
thread is targeted (page shift bits) and the offset in the
TIMA being accessed (the page offset bits). When the indirect
access is calling the underlying direct access functions, it is
therefore important to clearly separate the 2, as the direct functions
assume any page shift bits define the privilege ring level. For
indirect accesses, those bits must be 0. This patch fixes the offset
passed to direct TIMA functions.

It didn't matter for SMT1, as the 2 least significant bits of the page
shift are part of the hw thread ID and always 0, so the direct TIMA
functions were accessing the privilege ring 0 page. With SMT4/8, it is
no longer true.

The fix is specific to P10, as indirect TIMA access on P9 was handled
differently.

Signed-off-by: Frederic Barrat <fbarrat@linux.ibm.com>
---
 hw/intc/pnv_xive2.c | 19 +++++++++++++++++--
 1 file changed, 17 insertions(+), 2 deletions(-)

diff --git a/hw/intc/pnv_xive2.c b/hw/intc/pnv_xive2.c
index ed438a20ed..0618e6b0da 100644
--- a/hw/intc/pnv_xive2.c
+++ b/hw/intc/pnv_xive2.c
@@ -1590,6 +1590,17 @@ static uint32_t pnv_xive2_ic_tm_get_pir(PnvXive2 *xive, hwaddr offset)
     return xive->chip->chip_id << 8 | offset >> xive->ic_shift;
 }
 
+static uint32_t pnv_xive2_ic_tm_get_offset(PnvXive2 *xive, hwaddr offset)
+{
+    /*
+     * Indirect TIMA accesses are similar to direct accesses for
+     * privilege ring 0. So remove any traces of the hw thread ID from
+     * the offset in the IC BAR as it could be interpreted as the ring
+     * privilege when calling the underlying direct access functions.
+     */
+    return offset & ((1 << xive->ic_shift) - 1);
+}
+
 static XiveTCTX *pnv_xive2_get_indirect_tctx(PnvXive2 *xive, uint32_t pir)
 {
     PnvChip *chip = xive->chip;
@@ -1612,14 +1623,16 @@ static uint64_t pnv_xive2_ic_tm_indirect_read(void *opaque, hwaddr offset,
                                               unsigned size)
 {
     PnvXive2 *xive = PNV_XIVE2(opaque);
+    hwaddr tima_offset;
     uint32_t pir;
     XiveTCTX *tctx;
     uint64_t val = -1;
 
     pir = pnv_xive2_ic_tm_get_pir(xive, offset);
+    tima_offset = pnv_xive2_ic_tm_get_offset(xive, offset);
     tctx = pnv_xive2_get_indirect_tctx(xive, pir);
     if (tctx) {
-        val = xive_tctx_tm_read(NULL, tctx, offset, size);
+        val = xive_tctx_tm_read(NULL, tctx, tima_offset, size);
     }
 
     return val;
@@ -1629,13 +1642,15 @@ static void pnv_xive2_ic_tm_indirect_write(void *opaque, hwaddr offset,
                                            uint64_t val, unsigned size)
 {
     PnvXive2 *xive = PNV_XIVE2(opaque);
+    hwaddr tima_offset;
     uint32_t pir;
     XiveTCTX *tctx;
 
     pir = pnv_xive2_ic_tm_get_pir(xive, offset);
+    tima_offset = pnv_xive2_ic_tm_get_offset(xive, offset);
     tctx = pnv_xive2_get_indirect_tctx(xive, pir);
     if (tctx) {
-        xive_tctx_tm_write(NULL, tctx, offset, val, size);
+        xive_tctx_tm_write(NULL, tctx, tima_offset, val, size);
     }
 }
 
-- 
2.41.0



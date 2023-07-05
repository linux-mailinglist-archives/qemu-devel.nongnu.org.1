Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 35673747F28
	for <lists+qemu-devel@lfdr.de>; Wed,  5 Jul 2023 10:14:45 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qGxeP-0003pf-7U; Wed, 05 Jul 2023 04:14:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <fbarrat@linux.ibm.com>)
 id 1qGxeN-0003pS-B2; Wed, 05 Jul 2023 04:14:11 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <fbarrat@linux.ibm.com>)
 id 1qGxeL-0006t4-2j; Wed, 05 Jul 2023 04:14:11 -0400
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 36582wSX026313; Wed, 5 Jul 2023 08:14:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=from : to : subject :
 date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=oXi7wfAuRaRSnxN+D38M/AhWjD/MUIMODoKZn7zn1J0=;
 b=UZk02LsdsFtKO+Gt9TzgnIqiPCF68fgCe4QSvNIS143FSAVK1PrvfxMLKR6/4I8ECrOX
 PmJ63gFwRacO2iqpgZn7GKOlPPugPSErN1989eOVqVjjXgih/Czy93WJ6oAnaq0BqcAR
 sI5gJpNG0FEnbgf2oJhLQcveni0Ch4Amga3N9vLA6NfGyh/QMxWpUA8yMOoduBIbK7I9
 HoY5wq6zW8oey/jk4zISC6mFvgfYsJDQa3vyeJCrDJ6pnh4eMSOI4OackLI6A7RODmIC
 Yuw3r0TOGHbAYqE16TwQos5+DHDV3fVV5r5b/bXJu085I9yBvru2qxS9OeoyTMTg/33Q yg== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3rn4nv88ky-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 05 Jul 2023 08:14:05 +0000
Received: from m0353725.ppops.net (m0353725.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 36586lAA012645;
 Wed, 5 Jul 2023 08:14:05 GMT
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com
 [169.51.49.102])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3rn4nv88kh-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 05 Jul 2023 08:14:05 +0000
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
 by ppma06ams.nl.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 3652OvjC026303;
 Wed, 5 Jul 2023 08:14:03 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
 by ppma06ams.nl.ibm.com (PPS) with ESMTPS id 3rjbde2f50-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 05 Jul 2023 08:14:03 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com
 [10.20.54.106])
 by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 3658E1dR21955258
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 5 Jul 2023 08:14:01 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id F1E9B2016D;
 Wed,  5 Jul 2023 08:14:00 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 98E0B20168;
 Wed,  5 Jul 2023 08:14:00 +0000 (GMT)
Received: from borneo.ibmuc.com (unknown [9.171.34.89])
 by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Wed,  5 Jul 2023 08:14:00 +0000 (GMT)
From: Frederic Barrat <fbarrat@linux.ibm.com>
To: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Daniel Henrique Barboza <danielhb413@gmail.com>, qemu-ppc@nongnu.org,
 qemu-devel@nongnu.org
Subject: [PATCH] pnv/xive2: Always pass a presenter object when accessing the
 TIMA
Date: Wed,  5 Jul 2023 10:14:00 +0200
Message-ID: <20230705081400.218408-1-fbarrat@linux.ibm.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: eUhwSEoM92IuIG2GnIkiif6Do-SYHIr7
X-Proofpoint-ORIG-GUID: 73hEBIHhtkvIfWbp5gxoMc8dXnDZqXf-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-04_16,2023-07-04_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 spamscore=0
 mlxscore=0 adultscore=0 malwarescore=0 phishscore=0 clxscore=1015
 lowpriorityscore=0 suspectscore=0 priorityscore=1501 mlxlogscore=999
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2307050073
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

The low-level functions to access the TIMA take a presenter object as
a first argument. When accessing the TIMA from the IC BAR,
i.e. indirect calls, we currently pass a NULL pointer for the
presenter argument. While it appears ok with the current usage, it's
dangerous. And it's pretty easy to figure out the presenter in that
context, so this patch fixes it.

Signed-off-by: Frederic Barrat <fbarrat@linux.ibm.com>
---
 hw/intc/pnv_xive2.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/hw/intc/pnv_xive2.c b/hw/intc/pnv_xive2.c
index 82fcd3ea22..bbb44a533c 100644
--- a/hw/intc/pnv_xive2.c
+++ b/hw/intc/pnv_xive2.c
@@ -1624,6 +1624,7 @@ static uint64_t pnv_xive2_ic_tm_indirect_read(void *opaque, hwaddr offset,
                                               unsigned size)
 {
     PnvXive2 *xive = PNV_XIVE2(opaque);
+    XivePresenter *xptr = XIVE_PRESENTER(xive);
     hwaddr hw_page_offset;
     uint32_t pir;
     XiveTCTX *tctx;
@@ -1633,7 +1634,7 @@ static uint64_t pnv_xive2_ic_tm_indirect_read(void *opaque, hwaddr offset,
     hw_page_offset = pnv_xive2_ic_tm_get_hw_page_offset(xive, offset);
     tctx = pnv_xive2_get_indirect_tctx(xive, pir);
     if (tctx) {
-        val = xive_tctx_tm_read(NULL, tctx, hw_page_offset, size);
+        val = xive_tctx_tm_read(xptr, tctx, hw_page_offset, size);
     }
 
     return val;
@@ -1643,6 +1644,7 @@ static void pnv_xive2_ic_tm_indirect_write(void *opaque, hwaddr offset,
                                            uint64_t val, unsigned size)
 {
     PnvXive2 *xive = PNV_XIVE2(opaque);
+    XivePresenter *xptr = XIVE_PRESENTER(xive);
     hwaddr hw_page_offset;
     uint32_t pir;
     XiveTCTX *tctx;
@@ -1651,7 +1653,7 @@ static void pnv_xive2_ic_tm_indirect_write(void *opaque, hwaddr offset,
     hw_page_offset = pnv_xive2_ic_tm_get_hw_page_offset(xive, offset);
     tctx = pnv_xive2_get_indirect_tctx(xive, pir);
     if (tctx) {
-        xive_tctx_tm_write(NULL, tctx, hw_page_offset, val, size);
+        xive_tctx_tm_write(xptr, tctx, hw_page_offset, val, size);
     }
 }
 
-- 
2.41.0



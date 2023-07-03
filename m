Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EC3B7456FC
	for <lists+qemu-devel@lfdr.de>; Mon,  3 Jul 2023 10:10:43 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qGEce-0007MN-DU; Mon, 03 Jul 2023 04:09:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <fbarrat@linux.ibm.com>)
 id 1qGEcY-0007LE-SS; Mon, 03 Jul 2023 04:09:19 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <fbarrat@linux.ibm.com>)
 id 1qGEcW-0003yy-R9; Mon, 03 Jul 2023 04:09:18 -0400
Received: from pps.filterd (m0353728.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 3637l44R024819; Mon, 3 Jul 2023 08:09:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=from : to : subject :
 date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=kLZZvVXJKCG0yKJnEgouD/GLfshDauFbCziODtUEkKQ=;
 b=eNADM1RHXCp0pB14qhEgQcgaIJzbg6LLr5UdOTwk98bGnkQUsPkC1LwCbmXjiKCCXFvK
 Uvrz3895NjyQeByb/kI7W7WNjHCDGI3JL9tLxdTw3O4D9rad7lwV33WG7vZfubXULV5K
 I3wh7SBqYrh0H6tNTvcVIeIxV1kXPvVw6OAVTJzkx4TaLbUafUrO63ppOrc8FSEkk6iX
 LGuw5lYBqw+c9K08i2Bx08Ad1bWejI/hBxZE5HmZ1qFmsMX9uqQ8JiajaxXMdRRArt3G
 53cH378fTu4pBoWhiBGwydeE19KhmzD+xwdDDzNqTc/LZT2xBDZuQ+cFRY2A6HhPGxY6 4A== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3rkt87gh85-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 03 Jul 2023 08:09:04 +0000
Received: from m0353728.ppops.net (m0353728.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 3637shtb024569;
 Mon, 3 Jul 2023 08:09:04 GMT
Received: from ppma01fra.de.ibm.com (46.49.7a9f.ip4.static.sl-reverse.com
 [159.122.73.70])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3rkt87gh7m-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 03 Jul 2023 08:09:04 +0000
Received: from pps.filterd (ppma01fra.de.ibm.com [127.0.0.1])
 by ppma01fra.de.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 3633KBK7008125;
 Mon, 3 Jul 2023 08:09:01 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
 by ppma01fra.de.ibm.com (PPS) with ESMTPS id 3rjbs4rvkm-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 03 Jul 2023 08:09:01 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com
 [10.20.54.105])
 by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 36388x8i52036032
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 3 Jul 2023 08:08:59 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 69F0B20043;
 Mon,  3 Jul 2023 08:08:59 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 1072D20040;
 Mon,  3 Jul 2023 08:08:59 +0000 (GMT)
Received: from borneo.ibmuc.com (unknown [9.171.4.254])
 by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Mon,  3 Jul 2023 08:08:58 +0000 (GMT)
From: Frederic Barrat <fbarrat@linux.ibm.com>
To: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Daniel Henrique Barboza <danielhb413@gmail.com>, qemu-ppc@nongnu.org,
 qemu-devel@nongnu.org
Subject: [PATCH v2] pnv/xive2: Fix TIMA offset for indirect access
Date: Mon,  3 Jul 2023 10:08:58 +0200
Message-ID: <20230703080858.54060-1-fbarrat@linux.ibm.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 6AX7G6ZcdfH-rc4N9BFUgydzAOPY2zSE
X-Proofpoint-ORIG-GUID: ae1gWf6hUIC8G-87rU4rSghgYRIpw6G8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-03_06,2023-06-30_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 adultscore=0 malwarescore=0 spamscore=0 mlxlogscore=999 mlxscore=0
 phishscore=0 impostorscore=0 bulkscore=0 suspectscore=0 lowpriorityscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2307030073
Received-SPF: pass client-ip=148.163.156.1; envelope-from=fbarrat@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -29
X-Spam_score: -3.0
X-Spam_bar: ---
X-Spam_report: (-3.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_MSPIKE_H5=-1,
 RCVD_IN_MSPIKE_WL=-0.01, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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
Changelog:
v2: rename function and variable
    rebase to Danel's ppc-next

hw/intc/pnv_xive2.c | 20 ++++++++++++++++++--
 1 file changed, 18 insertions(+), 2 deletions(-)

diff --git a/hw/intc/pnv_xive2.c b/hw/intc/pnv_xive2.c
index e8ab176de6..82fcd3ea22 100644
--- a/hw/intc/pnv_xive2.c
+++ b/hw/intc/pnv_xive2.c
@@ -1590,6 +1590,18 @@ static uint32_t pnv_xive2_ic_tm_get_pir(PnvXive2 *xive, hwaddr offset)
     return xive->chip->chip_id << 8 | offset >> xive->ic_shift;
 }
 
+static uint32_t pnv_xive2_ic_tm_get_hw_page_offset(PnvXive2 *xive,
+                                                   hwaddr offset)
+{
+    /*
+     * Indirect TIMA accesses are similar to direct accesses for
+     * privilege ring 0. So remove any traces of the hw thread ID from
+     * the offset in the IC BAR as it could be interpreted as the ring
+     * privilege when calling the underlying direct access functions.
+     */
+    return offset & ((1ull << xive->ic_shift) - 1);
+}
+
 static XiveTCTX *pnv_xive2_get_indirect_tctx(PnvXive2 *xive, uint32_t pir)
 {
     PnvChip *chip = xive->chip;
@@ -1612,14 +1624,16 @@ static uint64_t pnv_xive2_ic_tm_indirect_read(void *opaque, hwaddr offset,
                                               unsigned size)
 {
     PnvXive2 *xive = PNV_XIVE2(opaque);
+    hwaddr hw_page_offset;
     uint32_t pir;
     XiveTCTX *tctx;
     uint64_t val = -1;
 
     pir = pnv_xive2_ic_tm_get_pir(xive, offset);
+    hw_page_offset = pnv_xive2_ic_tm_get_hw_page_offset(xive, offset);
     tctx = pnv_xive2_get_indirect_tctx(xive, pir);
     if (tctx) {
-        val = xive_tctx_tm_read(NULL, tctx, offset, size);
+        val = xive_tctx_tm_read(NULL, tctx, hw_page_offset, size);
     }
 
     return val;
@@ -1629,13 +1643,15 @@ static void pnv_xive2_ic_tm_indirect_write(void *opaque, hwaddr offset,
                                            uint64_t val, unsigned size)
 {
     PnvXive2 *xive = PNV_XIVE2(opaque);
+    hwaddr hw_page_offset;
     uint32_t pir;
     XiveTCTX *tctx;
 
     pir = pnv_xive2_ic_tm_get_pir(xive, offset);
+    hw_page_offset = pnv_xive2_ic_tm_get_hw_page_offset(xive, offset);
     tctx = pnv_xive2_get_indirect_tctx(xive, pir);
     if (tctx) {
-        xive_tctx_tm_write(NULL, tctx, offset, val, size);
+        xive_tctx_tm_write(NULL, tctx, hw_page_offset, val, size);
     }
 }
 
-- 
2.41.0



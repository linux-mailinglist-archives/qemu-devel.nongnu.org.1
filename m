Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C3229719BBE
	for <lists+qemu-devel@lfdr.de>; Thu,  1 Jun 2023 14:14:56 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q4hBv-0005vz-5s; Thu, 01 Jun 2023 08:14:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <fbarrat@linux.ibm.com>)
 id 1q4hBs-0005v2-Ds; Thu, 01 Jun 2023 08:14:04 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <fbarrat@linux.ibm.com>)
 id 1q4hBd-0006BT-Gb; Thu, 01 Jun 2023 08:14:04 -0400
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 351C6Wcr027480; Thu, 1 Jun 2023 12:13:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=from : to : subject :
 date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=43K/NS77euRNwN8uAXX5rAiKbH6iwtPbAQNRraXIros=;
 b=GrMhM1VWxtmwAspzfU27Wjh07+xrKEz7SLXqKRF66hsp7nZnWJ/C8pcjgYwij4JfSZN9
 ID9b3g1RlOYAV7+Cg5/Wl42IEkUYBjyMFxJFj4fILbMsvSj+bYT1iu819GSJXNWLS6yv
 S01YshQX9pZ4jOwdaEnMZVlgf24TWR2YJ9xeKlOUx1zOqZ+v66qwnGHxEKnq1EfEua6D
 7zwtZ9Y/vUSHkTFIZebfW+BlNA20oz0a684SoIpaUx21VUBUifoZjKq+mzo0z28Izr8r
 qwzqIHPjrtMJ3NbaURxeQb7KHLh0MddXbldG9Xh+6t+2PosaEJCMpg2hl3zgpHLSY7Fe mw== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3qxtwk8e27-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 01 Jun 2023 12:13:38 +0000
Received: from m0356517.ppops.net (m0356517.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 351C6jKY028863;
 Thu, 1 Jun 2023 12:13:38 GMT
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com
 [169.51.49.102])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3qxtwk8e1g-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 01 Jun 2023 12:13:38 +0000
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
 by ppma06ams.nl.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 3511XpTn003021;
 Thu, 1 Jun 2023 12:13:35 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
 by ppma06ams.nl.ibm.com (PPS) with ESMTPS id 3qu94e2gvy-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 01 Jun 2023 12:13:35 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com
 [10.20.54.106])
 by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 351CDX3221561910
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 1 Jun 2023 12:13:33 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id E91AA2004B;
 Thu,  1 Jun 2023 12:13:32 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id B138720040;
 Thu,  1 Jun 2023 12:13:32 +0000 (GMT)
Received: from borneo.tlslab.ibm.com (unknown [9.101.4.34])
 by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Thu,  1 Jun 2023 12:13:32 +0000 (GMT)
From: Frederic Barrat <fbarrat@linux.ibm.com>
To: clg@kaod.org, danielhb413@gmail.com, qemu-ppc@nongnu.org,
 qemu-devel@nongnu.org
Subject: [PATCH v2 4/5] pnv/xive2: Introduce macros to manipulate TIMA
 addresses
Date: Thu,  1 Jun 2023 14:13:30 +0200
Message-Id: <20230601121331.487207-5-fbarrat@linux.ibm.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230601121331.487207-1-fbarrat@linux.ibm.com>
References: <20230601121331.487207-1-fbarrat@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 4pRKtbCIJ1-8_m4TD8wPMlVqElKFkQJT
X-Proofpoint-ORIG-GUID: i8e45toJ-8T7lZU26g2UvmPcubdu2lRh
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-06-01_08,2023-05-31_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 adultscore=0
 clxscore=1015 mlxscore=0 bulkscore=0 spamscore=0 malwarescore=0
 mlxlogscore=999 priorityscore=1501 impostorscore=0 phishscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2304280000 definitions=main-2306010107
Received-SPF: pass client-ip=148.163.156.1; envelope-from=fbarrat@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

TIMA addresses are somewhat special and are split in several bit
fields with different meanings. This patch describes it and introduce
macros to more easily access the various fields.

Signed-off-by: Frederic Barrat <fbarrat@linux.ibm.com>
---
 hw/intc/xive.c             | 14 +++++++-------
 include/hw/ppc/xive_regs.h | 16 ++++++++++++++++
 2 files changed, 23 insertions(+), 7 deletions(-)

diff --git a/hw/intc/xive.c b/hw/intc/xive.c
index a986b96843..ebe399bc09 100644
--- a/hw/intc/xive.c
+++ b/hw/intc/xive.c
@@ -249,7 +249,7 @@ static const uint8_t *xive_tm_views[] = {
 static uint64_t xive_tm_mask(hwaddr offset, unsigned size, bool write)
 {
     uint8_t page_offset = (offset >> TM_SHIFT) & 0x3;
-    uint8_t reg_offset = offset & 0x3F;
+    uint8_t reg_offset = offset & TM_REG_OFFSET;
     uint8_t reg_mask = write ? 0x1 : 0x2;
     uint64_t mask = 0x0;
     int i;
@@ -266,8 +266,8 @@ static uint64_t xive_tm_mask(hwaddr offset, unsigned size, bool write)
 static void xive_tm_raw_write(XiveTCTX *tctx, hwaddr offset, uint64_t value,
                               unsigned size)
 {
-    uint8_t ring_offset = offset & 0x30;
-    uint8_t reg_offset = offset & 0x3F;
+    uint8_t ring_offset = offset & TM_RING_OFFSET;
+    uint8_t reg_offset = offset & TM_REG_OFFSET;
     uint64_t mask = xive_tm_mask(offset, size, true);
     int i;
 
@@ -296,8 +296,8 @@ static void xive_tm_raw_write(XiveTCTX *tctx, hwaddr offset, uint64_t value,
 
 static uint64_t xive_tm_raw_read(XiveTCTX *tctx, hwaddr offset, unsigned size)
 {
-    uint8_t ring_offset = offset & 0x30;
-    uint8_t reg_offset = offset & 0x3F;
+    uint8_t ring_offset = offset & TM_RING_OFFSET;
+    uint8_t reg_offset = offset & TM_REG_OFFSET;
     uint64_t mask = xive_tm_mask(offset, size, false);
     uint64_t ret;
     int i;
@@ -534,7 +534,7 @@ void xive_tctx_tm_write(XivePresenter *xptr, XiveTCTX *tctx, hwaddr offset,
     /*
      * First, check for special operations in the 2K region
      */
-    if (offset & 0x800) {
+    if (offset & TM_SPECIAL_OP) {
         xto = xive_tm_find_op(offset, size, true);
         if (!xto) {
             qemu_log_mask(LOG_GUEST_ERROR, "XIVE: invalid write access at TIMA "
@@ -573,7 +573,7 @@ uint64_t xive_tctx_tm_read(XivePresenter *xptr, XiveTCTX *tctx, hwaddr offset,
     /*
      * First, check for special operations in the 2K region
      */
-    if (offset & 0x800) {
+    if (offset & TM_SPECIAL_OP) {
         xto = xive_tm_find_op(offset, size, false);
         if (!xto) {
             qemu_log_mask(LOG_GUEST_ERROR, "XIVE: invalid read access to TIMA"
diff --git a/include/hw/ppc/xive_regs.h b/include/hw/ppc/xive_regs.h
index b7fde2354e..4a3c9badd3 100644
--- a/include/hw/ppc/xive_regs.h
+++ b/include/hw/ppc/xive_regs.h
@@ -48,6 +48,22 @@
 
 #define TM_SHIFT                16
 
+/*
+ * TIMA addresses are 12-bits (4k page).
+ * The MSB indicates a special op with side effect, which can be
+ * refined with bit 10 (see below).
+ * The registers, logically grouped in 4 rings (a quad-word each), are
+ * defined on the 6 LSBs (offset below 0x40)
+ * In between, we can add a cache line index from 0...3 (ie, 0, 0x80,
+ * 0x100, 0x180) to select a specific snooper. Those 'snoop port
+ * address' bits should be dropped when processing the operations as
+ * they are all equivalent.
+ */
+#define TM_ADDRESS_MASK         0xC3F
+#define TM_SPECIAL_OP           0x800
+#define TM_RING_OFFSET          0x30
+#define TM_REG_OFFSET           0x3F
+
 /* TM register offsets */
 #define TM_QW0_USER             0x000 /* All rings */
 #define TM_QW1_OS               0x010 /* Ring 0..2 */
-- 
2.40.1



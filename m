Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E334719BBB
	for <lists+qemu-devel@lfdr.de>; Thu,  1 Jun 2023 14:14:55 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q4hBl-0005qV-Rz; Thu, 01 Jun 2023 08:13:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <fbarrat@linux.ibm.com>)
 id 1q4hBg-0005fn-2Z; Thu, 01 Jun 2023 08:13:52 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <fbarrat@linux.ibm.com>)
 id 1q4hBd-0006BI-Gi; Thu, 01 Jun 2023 08:13:51 -0400
Received: from pps.filterd (m0353724.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 351C8967023918; Thu, 1 Jun 2023 12:13:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=from : to : subject :
 date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=epjw7tIm1w2H+tjkyrmjil5RlzEj8mp136Kpy7A/0+8=;
 b=rRcreH/FF1zk7Pfa4jq+U7CQorRsZ0Re+BJyia/VoHkdVfnSSMfcdm9jxcKmtukAzzXX
 yXxD8sMVkiSIuKWLFUjnTxjEyMigFMom37+lIKJyWIGXWb42KEQN1eX+5tORM4mXAbMz
 dZ6GbG7yqjEeGp2SQ/pyNmIq7aiyOHeZlPL2utSAPS74pmpiYYuU2tXDooxJcs2h67F6
 WwhqQa7f7khiR4SXAgWQH907jJrkbtA5TiymRPA6E6aDmyeO1x9vDcGmcS2ha/mFZsWL
 9bOiPbhyXSF29epT3Tib1q8MOcAFtD2PwWqvp8hYeplD2ukC6gK1HJzcO6Jce5kRoCtk 9A== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3qxtqeruxq-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 01 Jun 2023 12:13:38 +0000
Received: from m0353724.ppops.net (m0353724.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 351C8SOt026663;
 Thu, 1 Jun 2023 12:13:37 GMT
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com
 [169.51.49.98])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3qxtqeruw4-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 01 Jun 2023 12:13:37 +0000
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
 by ppma03ams.nl.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 34VMnZHi023841;
 Thu, 1 Jun 2023 12:13:35 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
 by ppma03ams.nl.ibm.com (PPS) with ESMTPS id 3qu9g52h3m-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 01 Jun 2023 12:13:35 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com
 [10.20.54.106])
 by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 351CDXtL8651320
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 1 Jun 2023 12:13:33 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 3CF9E2004B;
 Thu,  1 Jun 2023 12:13:33 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 04E3B2004D;
 Thu,  1 Jun 2023 12:13:33 +0000 (GMT)
Received: from borneo.tlslab.ibm.com (unknown [9.101.4.34])
 by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Thu,  1 Jun 2023 12:13:32 +0000 (GMT)
From: Frederic Barrat <fbarrat@linux.ibm.com>
To: clg@kaod.org, danielhb413@gmail.com, qemu-ppc@nongnu.org,
 qemu-devel@nongnu.org
Subject: [PATCH v2 5/5] pnv/xive2: Handle TIMA access through all ports
Date: Thu,  1 Jun 2023 14:13:31 +0200
Message-Id: <20230601121331.487207-6-fbarrat@linux.ibm.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230601121331.487207-1-fbarrat@linux.ibm.com>
References: <20230601121331.487207-1-fbarrat@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: qWRv6SasNK-dujMPq-2duIdw9PPvozPx
X-Proofpoint-ORIG-GUID: _iutn7G9h48w6PU_oUGL-bZBDx_9Qb52
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

The Thread Interrupt Management Area (TIMA) can be accessed through 4
ports, targeted by the address. The base address of a TIMA
is using port 0 and the other ports are 0x80 apart. Using one port or
another can be useful to balance the load on the snoop buses. With
skiboot and linux, we currently use port 0, but as it tends to be
busy, another hypervisor is using port 1 for TIMA access.

The port address bits fall in between the special op indication
bits (the 2 MSBs) and the register offset bits (the 6 LSBs). They are
"don't care" for the hardware when processing a TIMA operation. This
patch filters out those port address bits so that a TIMA operation can
be triggered using any port.

It is also true for indirect access (through the IC BAR) and it's
actually nothing new, it was already the case on P9. Which helps here,
as the TIMA handling code is common between P9 (xive) and P10 (xive2).

Signed-off-by: Frederic Barrat <fbarrat@linux.ibm.com>
---
 hw/intc/pnv_xive2.c | 4 ++++
 hw/intc/xive.c      | 2 +-
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/hw/intc/pnv_xive2.c b/hw/intc/pnv_xive2.c
index 5fc4240216..ec1edeb385 100644
--- a/hw/intc/pnv_xive2.c
+++ b/hw/intc/pnv_xive2.c
@@ -1666,6 +1666,8 @@ static void pnv_xive2_tm_write(void *opaque, hwaddr offset,
     bool gen1_tima_os =
         xive->cq_regs[CQ_XIVE_CFG >> 3] & CQ_XIVE_CFG_GEN1_TIMA_OS;
 
+    offset &= TM_ADDRESS_MASK;
+
     /* TODO: should we switch the TM ops table instead ? */
     if (!gen1_tima_os && offset == HV_PUSH_OS_CTX_OFFSET) {
         xive2_tm_push_os_ctx(xptr, tctx, offset, value, size);
@@ -1685,6 +1687,8 @@ static uint64_t pnv_xive2_tm_read(void *opaque, hwaddr offset, unsigned size)
     bool gen1_tima_os =
         xive->cq_regs[CQ_XIVE_CFG >> 3] & CQ_XIVE_CFG_GEN1_TIMA_OS;
 
+    offset &= TM_ADDRESS_MASK;
+
     /* TODO: should we switch the TM ops table instead ? */
     if (!gen1_tima_os && offset == HV_PULL_OS_CTX_OFFSET) {
         return xive2_tm_pull_os_ctx(xptr, tctx, offset, size);
diff --git a/hw/intc/xive.c b/hw/intc/xive.c
index ebe399bc09..5204c14b87 100644
--- a/hw/intc/xive.c
+++ b/hw/intc/xive.c
@@ -500,7 +500,7 @@ static const XiveTmOp xive_tm_operations[] = {
 static const XiveTmOp *xive_tm_find_op(hwaddr offset, unsigned size, bool write)
 {
     uint8_t page_offset = (offset >> TM_SHIFT) & 0x3;
-    uint32_t op_offset = offset & 0xFFF;
+    uint32_t op_offset = offset & TM_ADDRESS_MASK;
     int i;
 
     for (i = 0; i < ARRAY_SIZE(xive_tm_operations); i++) {
-- 
2.40.1



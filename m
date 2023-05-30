Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 42D6A7168F1
	for <lists+qemu-devel@lfdr.de>; Tue, 30 May 2023 18:13:23 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q41wu-0004kj-5U; Tue, 30 May 2023 12:11:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <fbarrat@linux.ibm.com>)
 id 1q41wq-0004jg-BQ; Tue, 30 May 2023 12:11:48 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <fbarrat@linux.ibm.com>)
 id 1q41wn-00034s-Hh; Tue, 30 May 2023 12:11:48 -0400
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 34UG8quU017034; Tue, 30 May 2023 16:11:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=from : to : subject :
 date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=oxBeEXZK7INoSWrPy9vA/633LH4d6tUJusySr2JiwVc=;
 b=LTx1EuSIXBAJ9dbdjnlzfVQ/39LR4K7hm5zOCBqoDU0aTTukP/tgfWAx9cLRtGl58RRR
 yOq9GbXpC+XAPPEpa/hrw4rVFaH+elp91/5i79uKPjFbaqssHbGscmhYv8xSapbLo32D
 EThgsL/stPbm2pgzuIYOeSbKbCGh4ithqQw3t4DN9+EmosVRTPAkY5R0Ra6fTMh1rABD
 NH8ikICgbB085o7gHQysEQ5iuUhG24V1eDOel9oKq0QBwup2hnOzOPOFMT70vkLgz+X9
 bAXLFgnYKgX/fcbhj3V10JwmFCEhvcUIrsvIVc/94UXSYjwjQ7MaQYvtqOlgX0sUsz9T wA== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3qwh1des00-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 30 May 2023 16:11:36 +0000
Received: from m0360072.ppops.net (m0360072.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 34UG8ulx017587;
 Tue, 30 May 2023 16:11:36 GMT
Received: from ppma05fra.de.ibm.com (6c.4a.5195.ip4.static.sl-reverse.com
 [149.81.74.108])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3qwh1dery3-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 30 May 2023 16:11:36 +0000
Received: from pps.filterd (ppma05fra.de.ibm.com [127.0.0.1])
 by ppma05fra.de.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 34U5GNXj014529;
 Tue, 30 May 2023 16:11:34 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
 by ppma05fra.de.ibm.com (PPS) with ESMTPS id 3qu9g59axq-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 30 May 2023 16:11:33 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com
 [10.20.54.106])
 by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 34UGBVuW8848118
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 30 May 2023 16:11:31 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 89E032004D;
 Tue, 30 May 2023 16:11:31 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 456A420043;
 Tue, 30 May 2023 16:11:31 +0000 (GMT)
Received: from borneo.ibmuc.com (unknown [9.171.3.249])
 by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Tue, 30 May 2023 16:11:31 +0000 (GMT)
From: Frederic Barrat <fbarrat@linux.ibm.com>
To: clg@kaod.org, danielhb413@gmail.com, qemu-ppc@nongnu.org,
 qemu-devel@nongnu.org
Subject: [PATCH 4/4] pnv/xive2: Handle TIMA access through all ports
Date: Tue, 30 May 2023 18:11:29 +0200
Message-Id: <20230530161129.313258-5-fbarrat@linux.ibm.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230530161129.313258-1-fbarrat@linux.ibm.com>
References: <20230530161129.313258-1-fbarrat@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: T1HWBFeMG1yrgYuXsUF0pGQ2lNSQCdC8
X-Proofpoint-ORIG-GUID: rLwe3mfY8mSeJS9hSxCV1Pplyf69CR7F
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-05-30_12,2023-05-30_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 phishscore=0
 lowpriorityscore=0 malwarescore=0 mlxlogscore=939 priorityscore=1501
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

The Thread Interrupt Management Area (TIMA) can be accessed through 4
ports/snoop buses, targeted by the address. The base address of a TIMA
is using port 0 and the other ports are 0x80 apart. Using one port or
another can be useful to balance the load on the snoop buses.

The TIMA registers are in the 0x0 -> 0x3F range and there are 2
indication bits for special operations (bits 10 and 11; everything
fits on a 4k page). So the port address bits fall in between and are
"don't care" for the hardware when processing the TIMA operation. So
this patch filters out those port address bits so that a TIMA
operation can be triggered using any port.

It is also true for indirect access (through the IC BAR) and it's
actually nothing new, it was already the case on P9. Which helps here,
as the TIMA handling code is common between P9 (xive) and P10 (xive2).

Signed-off-by: Frederic Barrat <fbarrat@linux.ibm.com>
---
 hw/intc/pnv_xive2.c |  4 ++++
 hw/intc/xive.c      | 18 ++++++++++++++++++
 2 files changed, 22 insertions(+)

diff --git a/hw/intc/pnv_xive2.c b/hw/intc/pnv_xive2.c
index 132f82a035..c80316657a 100644
--- a/hw/intc/pnv_xive2.c
+++ b/hw/intc/pnv_xive2.c
@@ -1662,6 +1662,8 @@ static void pnv_xive2_tm_write(void *opaque, hwaddr offset,
     bool gen1_tima_os =
         xive->cq_regs[CQ_XIVE_CFG >> 3] & CQ_XIVE_CFG_GEN1_TIMA_OS;
 
+    offset &= 0xC3F; /* See comment in xive_tctx_tm_write() */
+
     /* TODO: should we switch the TM ops table instead ? */
     if (!gen1_tima_os && offset == HV_PUSH_OS_CTX_OFFSET) {
         xive2_tm_push_os_ctx(xptr, tctx, offset, value, size);
@@ -1681,6 +1683,8 @@ static uint64_t pnv_xive2_tm_read(void *opaque, hwaddr offset, unsigned size)
     bool gen1_tima_os =
         xive->cq_regs[CQ_XIVE_CFG >> 3] & CQ_XIVE_CFG_GEN1_TIMA_OS;
 
+    offset &= 0xC3F; /* See comment in xive_tctx_tm_read() */
+
     /* TODO: should we switch the TM ops table instead ? */
     if (!gen1_tima_os && offset == HV_PULL_OS_CTX_OFFSET) {
         return xive2_tm_pull_os_ctx(xptr, tctx, offset, size);
diff --git a/hw/intc/xive.c b/hw/intc/xive.c
index a986b96843..c1abfae31d 100644
--- a/hw/intc/xive.c
+++ b/hw/intc/xive.c
@@ -527,6 +527,15 @@ void xive_tctx_tm_write(XivePresenter *xptr, XiveTCTX *tctx, hwaddr offset,
 
     trace_xive_tctx_tm_write(offset, size, value);
 
+    /*
+     * The TIMA can be accessed through 4 ports/snoop buses, with
+     * addresses 0x80 apart.
+     * However, the offset bits between the "special op" bits and the
+     * MSB of the range used for the TIMA registers are "don't care"
+     * for the hardware, so we filter them out.
+     */
+    offset &= 0xC3F;
+
     /*
      * TODO: check V bit in Q[0-3]W2
      */
@@ -566,6 +575,15 @@ uint64_t xive_tctx_tm_read(XivePresenter *xptr, XiveTCTX *tctx, hwaddr offset,
     const XiveTmOp *xto;
     uint64_t ret;
 
+    /*
+     * The TIMA can be accessed through 4 ports/snoop buses, with
+     * addresses 0x80 apart.
+     * However, the offset bits between the "special op" bits and the
+     * MSB of the range used for the TIMA registers are "don't care"
+     * for the hardware, so we filter them out.
+     */
+    offset &= 0xC3F;
+
     /*
      * TODO: check V bit in Q[0-3]W2
      */
-- 
2.40.1



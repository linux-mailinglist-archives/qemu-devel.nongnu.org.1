Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C30C5977301
	for <lists+qemu-devel@lfdr.de>; Thu, 12 Sep 2024 22:52:48 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1soqmR-0003QV-6i; Thu, 12 Sep 2024 16:51:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kowal@linux.ibm.com>)
 id 1soqmN-0003Hc-Vj; Thu, 12 Sep 2024 16:51:04 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kowal@linux.ibm.com>)
 id 1soqmM-0007At-FU; Thu, 12 Sep 2024 16:51:03 -0400
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 48CDEvVV019795;
 Thu, 12 Sep 2024 20:51:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from
 :to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-type:content-transfer-encoding; s=pp1; bh=
 LCpUFz2WhQcGF3S623CXWT9p+5Tyy4XNgbtXbXmEwN8=; b=p59iW6giA3AA0GVb
 3RbjTlpT3jhRNuzyx751MHt18Hyq+GMWgdZvF96nrfqNDVESTjKvbhoZdLyKgQcD
 yipiPgRwzYVqQrT1k9Il8T15F/czxjIE7bmdQeZNpbdqE3RS2pBrLFvkC9jqb2Cc
 oFr5EoBvKyqdKQ5XqjXar1l5JhXRm2S7VreGNXTTFkIn5ATPvgMPmpt3NHaDmidv
 b9gMOf9sb56j5qU7NTzJvuW0o9LAo2QORWn8IKrGgm6/AW4+nqS9R7MNWUs+arNW
 KzQhoqW3gQrRZ7P9Edwaq2h5BWe9MpmgXomsErOBIlGFO59gyaOCkBR7WAIpk84S
 9/BpXg==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 41gd8kww4e-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 12 Sep 2024 20:50:59 +0000 (GMT)
Received: from m0353725.ppops.net (m0353725.ppops.net [127.0.0.1])
 by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 48CKo44Z007959;
 Thu, 12 Sep 2024 20:50:59 GMT
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 41gd8kww4c-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 12 Sep 2024 20:50:59 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 48CIL7DC010770;
 Thu, 12 Sep 2024 20:50:58 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 41kmb6wwkf-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 12 Sep 2024 20:50:58 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com
 [10.20.54.105])
 by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 48CKotsI22675910
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 12 Sep 2024 20:50:55 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 0EE3520049;
 Thu, 12 Sep 2024 20:50:55 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id D3A3D20040;
 Thu, 12 Sep 2024 20:50:53 +0000 (GMT)
Received: from gfwr518.rchland.ibm.com (unknown [9.10.239.106])
 by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Thu, 12 Sep 2024 20:50:53 +0000 (GMT)
From: Michael Kowal <kowal@linux.ibm.com>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, clg@kaod.org, fbarrat@linux.ibm.com,
 npiggin@gmail.com, milesg@linux.ibm.com
Subject: [PATCH v3 13/14] pnv/xive2: TIMA support for 8-byte OS context push
 for PHYP
Date: Thu, 12 Sep 2024 15:50:27 -0500
Message-Id: <20240912205028.15854-14-kowal@linux.ibm.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20240912205028.15854-1-kowal@linux.ibm.com>
References: <20240912205028.15854-1-kowal@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: GM0uReXALBL7FS5qhGmHtvEo9zUT9jEy
X-Proofpoint-ORIG-GUID: GHj2cFcmJM7O8pc8OdcAdULX5qs6OVqu
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-12_07,2024-09-12_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 impostorscore=0 suspectscore=0 clxscore=1015 phishscore=0 spamscore=0
 lowpriorityscore=0 adultscore=0 mlxscore=0 mlxlogscore=885 bulkscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2408220000 definitions=main-2409120149
Received-SPF: pass client-ip=148.163.158.5; envelope-from=kowal@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Glenn Miles <milesg@linux.vnet.ibm.com>

PHYP uses 8-byte writes to the 2nd doubleword of the OS context
line when dispatching an OS level virtual processor.  This
support was not used by OPAL/Linux and so was never added.

Without this support, the XIVE code doesn't notice that a new
context is being pushed and fails to check for unpresented
pending interrupts for that context.

Signed-off-by: Glenn Miles <milesg@linux.vnet.ibm.com>
Signed-off-by: Michael Kowal <kowal@linux.ibm.com>
Reviewed-by: Cédric Le Goater <clg@kaod.org>
---
 hw/intc/xive.c  |  2 ++
 hw/intc/xive2.c | 24 +++++++++++++++++++-----
 2 files changed, 21 insertions(+), 5 deletions(-)

diff --git a/hw/intc/xive.c b/hw/intc/xive.c
index 738eaf624d..3ce86b6895 100644
--- a/hw/intc/xive.c
+++ b/hw/intc/xive.c
@@ -596,6 +596,8 @@ static const XiveTmOp xive2_tm_operations[] = {
                                                      NULL },
     { XIVE_TM_HV_PAGE, TM_QW1_OS + TM_WORD2,      4, xive2_tm_push_os_ctx,
                                                      NULL },
+    { XIVE_TM_HV_PAGE, TM_QW1_OS + TM_WORD2,      8, xive2_tm_push_os_ctx,
+                                                     NULL },
     { XIVE_TM_OS_PAGE, TM_QW1_OS + TM_LGS,        1, xive_tm_set_os_lgs,
                                                      NULL },
     { XIVE_TM_HV_PAGE, TM_QW3_HV_PHYS + TM_CPPR,  1, xive_tm_set_hv_cppr,
diff --git a/hw/intc/xive2.c b/hw/intc/xive2.c
index 2e41bd9edb..d1df35e9b3 100644
--- a/hw/intc/xive2.c
+++ b/hw/intc/xive2.c
@@ -597,17 +597,31 @@ static void xive2_tctx_need_resend(Xive2Router *xrtr, XiveTCTX *tctx,
 void xive2_tm_push_os_ctx(XivePresenter *xptr, XiveTCTX *tctx,
                           hwaddr offset, uint64_t value, unsigned size)
 {
-    uint32_t cam = value;
-    uint32_t qw1w2 = cpu_to_be32(cam);
+    uint32_t cam;
+    uint32_t qw1w2;
+    uint64_t qw1dw1;
     uint8_t nvp_blk;
     uint32_t nvp_idx;
     bool vo;
     bool do_restore;
 
-    xive2_cam_decode(cam, &nvp_blk, &nvp_idx, &vo, &do_restore);
-
     /* First update the thead context */
-    memcpy(&tctx->regs[TM_QW1_OS + TM_WORD2], &qw1w2, 4);
+    switch (size) {
+    case 4:
+        cam = value;
+        qw1w2 = cpu_to_be32(cam);
+        memcpy(&tctx->regs[TM_QW1_OS + TM_WORD2], &qw1w2, 4);
+        break;
+    case 8:
+        cam = value >> 32;
+        qw1dw1 = cpu_to_be64(value);
+        memcpy(&tctx->regs[TM_QW1_OS + TM_WORD2], &qw1dw1, 8);
+        break;
+    default:
+        g_assert_not_reached();
+    }
+
+    xive2_cam_decode(cam, &nvp_blk, &nvp_idx, &vo, &do_restore);
 
     /* Check the interrupt pending bits */
     if (vo) {
-- 
2.43.0



Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 809B0972448
	for <lists+qemu-devel@lfdr.de>; Mon,  9 Sep 2024 23:12:14 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1snlfO-0001Gk-JB; Mon, 09 Sep 2024 17:11:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kowal@linux.ibm.com>)
 id 1snlf9-0000ko-L8; Mon, 09 Sep 2024 17:11:07 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kowal@linux.ibm.com>)
 id 1snlf6-00026o-QG; Mon, 09 Sep 2024 17:11:06 -0400
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 489FP2ps018207;
 Mon, 9 Sep 2024 21:11:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from
 :to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-type:content-transfer-encoding; s=pp1; bh=
 TU9MdjWCBZih9NcXCCnyYP8mWaZWPuY12UPGXKrNqmU=; b=jmigRX88ezwMdpS4
 bzIK0PRQ6AonNm5+Rq8m5AIcavCYJtTPqcwnGX5ANfZeJflrJiGjvcWFECi74nGZ
 eueEuI3eIQ+BwJMLbWVZK8+ognIDN6MJPgESOekZKb4uGXN3SHzc2bGxMSpJSO9w
 MqdGo41fr3tjhCzRW5FWpjrx0LFXS2w9PskCCFeRhYwo8AiwaC8l1Uwl2aHatWDJ
 iDied+RyF87KBqT6rmEjdWXXzW5H+8KObgP08ehCDp7DK//5+IOi6xRnjXRBSqfT
 IYxC7S3EVI+XQ7gCX81kC1boJQWFepe34WCRYLaGD5MtpoOvE36I89lKN4BGB1hD
 wLsSaw==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 41gc8q4c63-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 09 Sep 2024 21:11:01 +0000 (GMT)
Received: from m0356516.ppops.net (m0356516.ppops.net [127.0.0.1])
 by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 489LB1pr014550;
 Mon, 9 Sep 2024 21:11:01 GMT
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 41gc8q4c61-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 09 Sep 2024 21:11:01 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 489KWgg3014576;
 Mon, 9 Sep 2024 21:11:00 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 41h3cm00tx-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 09 Sep 2024 21:11:00 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com
 [10.20.54.105])
 by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 489LAvBn25690872
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 9 Sep 2024 21:10:57 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 2CAAE20049;
 Mon,  9 Sep 2024 21:10:57 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 0090420040;
 Mon,  9 Sep 2024 21:10:56 +0000 (GMT)
Received: from gfwr518.rchland.ibm.com (unknown [9.10.239.106])
 by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Mon,  9 Sep 2024 21:10:55 +0000 (GMT)
From: Michael Kowal <kowal@linux.ibm.com>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, clg@kaod.org, fbarrat@linux.ibm.com,
 npiggin@gmail.com, milesg@linux.ibm.com
Subject: [PATCH v2 07/14] ppc/xive2: Allow 1-byte write of Target field in TIMA
Date: Mon,  9 Sep 2024 16:10:31 -0500
Message-Id: <20240909211038.27440-8-kowal@linux.ibm.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20240909211038.27440-1-kowal@linux.ibm.com>
References: <20240909211038.27440-1-kowal@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 697WU8IluHJ5mxTepPwh_VqgRwnqZdwP
X-Proofpoint-ORIG-GUID: sEEU6qZItagTv7CJ_nDnl-qVf_-gN1Pu
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-09_10,2024-09-09_02,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 spamscore=0
 mlxscore=0 lowpriorityscore=0 impostorscore=0 priorityscore=1501
 malwarescore=0 adultscore=0 clxscore=1015 mlxlogscore=838 suspectscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2408220000 definitions=main-2409090162
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

When running PowerVM, the console is littered with XIVE traces regarding
invalid writes to TIMA address 0x100b6 due to a lack of support for writes
to the "TARGET" field which was added for XIVE GEN2.  To fix this, we add
special op support for 1-byte writes to this field.

Signed-off-by: Glenn Miles <milesg@linux.vnet.ibm.com>
Signed-off-by: Michael Kowal <kowal@linux.ibm.com>
Reviewed-by: Cédric Le Goater <clg@redhat.com>
---
 include/hw/ppc/xive2.h     |  2 ++
 include/hw/ppc/xive_regs.h |  1 +
 hw/intc/xive.c             |  2 ++
 hw/intc/xive2.c            | 13 +++++++++++++
 4 files changed, 18 insertions(+)

diff --git a/include/hw/ppc/xive2.h b/include/hw/ppc/xive2.h
index b7a7c33ddd..36bd0e747f 100644
--- a/include/hw/ppc/xive2.h
+++ b/include/hw/ppc/xive2.h
@@ -121,5 +121,7 @@ uint64_t xive2_tm_pull_os_ctx(XivePresenter *xptr, XiveTCTX *tctx,
                                hwaddr offset, unsigned size);
 void xive2_tm_pull_os_ctx_ol(XivePresenter *xptr, XiveTCTX *tctx,
                              hwaddr offset, uint64_t value, unsigned size);
+void xive2_tm_set_hv_target(XivePresenter *xptr, XiveTCTX *tctx,
+                            hwaddr offset, uint64_t value, unsigned size);
 
 #endif /* PPC_XIVE2_H */
diff --git a/include/hw/ppc/xive_regs.h b/include/hw/ppc/xive_regs.h
index 27a744d50d..f8f05deafd 100644
--- a/include/hw/ppc/xive_regs.h
+++ b/include/hw/ppc/xive_regs.h
@@ -79,6 +79,7 @@
 #define TM_INC                  0x5  /*  -   +   -   +  */
 #define TM_LGS                  0x5  /*  +   +   +   +  */ /* Rename P10 */
 #define TM_AGE                  0x6  /*  -   +   -   +  */
+#define TM_T                    0x6  /*  -   +   -   +  */ /* Rename P10 */
 #define TM_PIPR                 0x7  /*  -   +   -   +  */
 #define TM_OGEN                 0xF  /*  -   +   -   -  */ /* P10 only */
 
diff --git a/hw/intc/xive.c b/hw/intc/xive.c
index 8605dd618f..6229a6f870 100644
--- a/hw/intc/xive.c
+++ b/hw/intc/xive.c
@@ -546,6 +546,8 @@ static const XiveTmOp xive2_tm_operations[] = {
                                                      NULL },
     { XIVE_TM_HV_PAGE, TM_QW3_HV_PHYS + TM_WORD2, 1, NULL,
                                                      xive_tm_vt_poll },
+    { XIVE_TM_HV_PAGE, TM_QW3_HV_PHYS + TM_T,     1, xive2_tm_set_hv_target,
+                                                     NULL },
 
     /* MMIOs above 2K : special operations with side effects */
     { XIVE_TM_OS_PAGE, TM_SPC_ACK_OS_REG,         2, NULL,
diff --git a/hw/intc/xive2.c b/hw/intc/xive2.c
index 26b6e72129..8d3d69a0db 100644
--- a/hw/intc/xive2.c
+++ b/hw/intc/xive2.c
@@ -585,6 +585,19 @@ void xive2_tm_push_os_ctx(XivePresenter *xptr, XiveTCTX *tctx,
     }
 }
 
+static void xive2_tctx_set_target(XiveTCTX *tctx, uint8_t ring, uint8_t target)
+{
+    uint8_t *regs = &tctx->regs[ring];
+
+    regs[TM_T] = target;
+}
+
+void xive2_tm_set_hv_target(XivePresenter *xptr, XiveTCTX *tctx,
+                            hwaddr offset, uint64_t value, unsigned size)
+{
+    xive2_tctx_set_target(tctx, TM_QW3_HV_PHYS, value & 0xff);
+}
+
 /*
  * XIVE Router (aka. Virtualization Controller or IVRE)
  */
-- 
2.43.0



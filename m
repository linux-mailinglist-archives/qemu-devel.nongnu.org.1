Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A444997859E
	for <lists+qemu-devel@lfdr.de>; Fri, 13 Sep 2024 18:19:03 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sp8zJ-0006Yl-H9; Fri, 13 Sep 2024 12:17:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kowal@linux.ibm.com>)
 id 1sp8zA-00069U-NS; Fri, 13 Sep 2024 12:17:28 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kowal@linux.ibm.com>)
 id 1sp8z8-0006kb-4U; Fri, 13 Sep 2024 12:17:27 -0400
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 48DGBYnk030020;
 Fri, 13 Sep 2024 16:17:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from
 :to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-type:content-transfer-encoding; s=pp1; bh=
 TU9MdjWCBZih9NcXCCnyYP8mWaZWPuY12UPGXKrNqmU=; b=p2fjd0JivehsPUL3
 fLlPEfNggvHxM918EeLDHTwOLpZJ5njqhVuATOIURFYe+247/Xp7IKTSexAxQCAS
 1eNI6VXnJZPG4qJ1pn89oanPMWLaM9m76/LPuQVq5qZnfX6gocoNPubjZd6Vh4Og
 cU0gBTznL2x5sYEgEMer3JzHff1cfHPO51i+fxqnnAMKHDSRkwDX5hnEMDyRKpgI
 IWa9mQEuxn/fZkaXC5vQ9Gijp+7cuXFOIA4+5uM8Xw+lSYzNQRl+TW5dBC4tGstN
 5tturVxRSGcTbi+hM/95nRvA6fhPd5Ln2hEIv9ysA4bjA/f7QG9YuswLOFfTupYM
 XoeIcw==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 41gegxb9ks-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 13 Sep 2024 16:17:22 +0000 (GMT)
Received: from m0353729.ppops.net (m0353729.ppops.net [127.0.0.1])
 by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 48DGEm7b004211;
 Fri, 13 Sep 2024 16:17:21 GMT
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 41gegxb9kn-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 13 Sep 2024 16:17:21 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 48DFAMPe010793;
 Fri, 13 Sep 2024 16:17:20 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 41kmb72x69-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 13 Sep 2024 16:17:20 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com
 [10.20.54.105])
 by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 48DGHGr948300418
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 13 Sep 2024 16:17:16 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id A48A02004B;
 Fri, 13 Sep 2024 16:17:16 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 7166A20040;
 Fri, 13 Sep 2024 16:17:15 +0000 (GMT)
Received: from gfwr518.rchland.ibm.com (unknown [9.10.239.106])
 by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Fri, 13 Sep 2024 16:17:15 +0000 (GMT)
From: Michael Kowal <kowal@linux.ibm.com>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, clg@kaod.org, fbarrat@linux.ibm.com,
 npiggin@gmail.com, milesg@linux.ibm.com
Subject: [PATCH v4 07/14] ppc/xive2: Allow 1-byte write of Target field in TIMA
Date: Fri, 13 Sep 2024 11:16:52 -0500
Message-Id: <20240913161659.1981-8-kowal@linux.ibm.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20240913161659.1981-1-kowal@linux.ibm.com>
References: <20240913161659.1981-1-kowal@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: VUImiNKgyLr8uQh0Ti2Z0k3OI_x3vkpT
X-Proofpoint-ORIG-GUID: 5lW6lc7DNj0Q6A8DJV-eO-81L7mXTpm3
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-13_11,2024-09-13_02,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 mlxlogscore=848
 lowpriorityscore=0 suspectscore=0 priorityscore=1501 bulkscore=0
 adultscore=0 impostorscore=0 clxscore=1015 malwarescore=0 mlxscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2408220000 definitions=main-2409130113
Received-SPF: pass client-ip=148.163.156.1; envelope-from=kowal@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
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



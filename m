Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DE2E7738A61
	for <lists+qemu-devel@lfdr.de>; Wed, 21 Jun 2023 18:04:32 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qC0Is-0007hW-AA; Wed, 21 Jun 2023 12:03:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <fbarrat@linux.ibm.com>)
 id 1qC0Ip-0007gK-S1; Wed, 21 Jun 2023 12:03:27 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <fbarrat@linux.ibm.com>)
 id 1qC0Im-0001m7-Pu; Wed, 21 Jun 2023 12:03:27 -0400
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 35LG2Amk004373; Wed, 21 Jun 2023 16:03:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=from : to : subject :
 date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=rmPf08LFhVymbkkpIxlYhXz8a6joD0mpL4KPfoUyHUw=;
 b=DFYaeylmyiNOgPZrp6nhhDiPR24dmRK48kI+16VUVpMj9dfyxt5l37kLjslEHGzPZde7
 tt+bcF9AvEhW9wnoy2x97n/aC+RTH6+KrWk7edATIWIg0vzDlRAJsFiHxQndd0Xj/CU/
 RNmYuzhdn9m2pHIiB8yrYPgORMq+W09QF9yLEpfG511MG2Ipu5PMflm7rME/EFFk8kFK
 N6Dyurko5nujoq8FT7eAnko7vUmG54013DZ211o9X6ONJsmboatBGiUNYbvNpC57MOuL
 14Ughd3aGI3bNbS1yeDy4Ny94zhtdbUVRfgrAlFtVr3+S5whHGRcjr2gUAPQPEkduf/G Qw== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3rc4cdr2mw-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 21 Jun 2023 16:03:19 +0000
Received: from m0360083.ppops.net (m0360083.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 35LG2T9e007390;
 Wed, 21 Jun 2023 16:03:17 GMT
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com
 [169.51.49.99])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3rc4cdr24q-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 21 Jun 2023 16:03:17 +0000
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
 by ppma04ams.nl.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 35L3IF59011691;
 Wed, 21 Jun 2023 16:03:09 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
 by ppma04ams.nl.ibm.com (PPS) with ESMTPS id 3r94f5av3j-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 21 Jun 2023 16:03:09 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com
 [10.20.54.100])
 by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 35LG37l414549672
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 21 Jun 2023 16:03:07 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 810F820043;
 Wed, 21 Jun 2023 16:03:07 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 27C0920040;
 Wed, 21 Jun 2023 16:03:07 +0000 (GMT)
Received: from borneo.ibmuc.com (unknown [9.171.1.141])
 by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Wed, 21 Jun 2023 16:03:07 +0000 (GMT)
From: Frederic Barrat <fbarrat@linux.ibm.com>
To: clg@kaod.org, danielhb413@gmail.com, qemu-ppc@nongnu.org,
 qemu-devel@nongnu.org
Subject: [PATCH 1/2] pnv/xive2: Add a get_config() method on the presenter
 class
Date: Wed, 21 Jun 2023 18:03:05 +0200
Message-ID: <20230621160306.896045-2-fbarrat@linux.ibm.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230621160306.896045-1-fbarrat@linux.ibm.com>
References: <20230621160306.896045-1-fbarrat@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 23bdrv7bizZMs-R_A_2k-6cPJ6JJ3XfQ
X-Proofpoint-ORIG-GUID: OBjdggKK8qpZ7Be7gfIduYh-s3u5c9lV
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-06-21_09,2023-06-16_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 mlxscore=0
 malwarescore=0 adultscore=0 mlxlogscore=999 spamscore=0 lowpriorityscore=0
 suspectscore=0 bulkscore=0 priorityscore=1501 clxscore=1015 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2305260000
 definitions=main-2306210131
Received-SPF: pass client-ip=148.163.156.1; envelope-from=fbarrat@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
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

The presenters for xive on P9 and P10 are mostly similar but the
behavior can be tuned through a few CQ registers. This patch adds a
"get_config" method, which will allow to access that config from the
presenter in a later patch.
For now, just define the config for the TIMA version.

Signed-off-by: Frederic Barrat <fbarrat@linux.ibm.com>
---
 hw/intc/pnv_xive.c    | 11 +++++++++++
 hw/intc/pnv_xive2.c   | 12 ++++++++++++
 hw/intc/xive.c        |  7 +++++++
 include/hw/ppc/xive.h |  3 +++
 4 files changed, 33 insertions(+)

diff --git a/hw/intc/pnv_xive.c b/hw/intc/pnv_xive.c
index 622f9d28b7..e536b3ec26 100644
--- a/hw/intc/pnv_xive.c
+++ b/hw/intc/pnv_xive.c
@@ -479,6 +479,16 @@ static int pnv_xive_match_nvt(XivePresenter *xptr, uint8_t format,
     return count;
 }
 
+static uint32_t pnv_xive_presenter_get_config(XivePresenter *xptr)
+{
+    uint32_t cfg = 0;
+
+    /* TIMA GEN1 is all P9 knows */
+    cfg |= XIVE_PRESENTER_GEN1_TIMA_OS;
+
+    return cfg;
+}
+
 static uint8_t pnv_xive_get_block_id(XiveRouter *xrtr)
 {
     return pnv_xive_block_id(PNV_XIVE(xrtr));
@@ -1991,6 +2001,7 @@ static void pnv_xive_class_init(ObjectClass *klass, void *data)
 
     xnc->notify = pnv_xive_notify;
     xpc->match_nvt  = pnv_xive_match_nvt;
+    xpc->get_config = pnv_xive_presenter_get_config;
 };
 
 static const TypeInfo pnv_xive_info = {
diff --git a/hw/intc/pnv_xive2.c b/hw/intc/pnv_xive2.c
index ec1edeb385..59534f6843 100644
--- a/hw/intc/pnv_xive2.c
+++ b/hw/intc/pnv_xive2.c
@@ -501,6 +501,17 @@ static int pnv_xive2_match_nvt(XivePresenter *xptr, uint8_t format,
     return count;
 }
 
+static uint32_t pnv_xive2_presenter_get_config(XivePresenter *xptr)
+{
+    PnvXive2 *xive = PNV_XIVE2(xptr);
+    uint32_t cfg = 0;
+
+    if (xive->cq_regs[CQ_XIVE_CFG >> 3] & CQ_XIVE_CFG_GEN1_TIMA_OS) {
+        cfg |= XIVE_PRESENTER_GEN1_TIMA_OS;
+    }
+    return cfg;
+}
+
 static uint8_t pnv_xive2_get_block_id(Xive2Router *xrtr)
 {
     return pnv_xive2_block_id(PNV_XIVE2(xrtr));
@@ -1987,6 +1998,7 @@ static void pnv_xive2_class_init(ObjectClass *klass, void *data)
     xnc->notify    = pnv_xive2_notify;
 
     xpc->match_nvt  = pnv_xive2_match_nvt;
+    xpc->get_config = pnv_xive2_presenter_get_config;
 };
 
 static const TypeInfo pnv_xive2_info = {
diff --git a/hw/intc/xive.c b/hw/intc/xive.c
index 5204c14b87..34a868b185 100644
--- a/hw/intc/xive.c
+++ b/hw/intc/xive.c
@@ -461,6 +461,13 @@ static void xive_tm_push_os_ctx(XivePresenter *xptr, XiveTCTX *tctx,
     }
 }
 
+static __attribute__((unused)) uint32_t xive_presenter_get_config(XivePresenter *xptr)
+{
+    XivePresenterClass *xpc = XIVE_PRESENTER_GET_CLASS(xptr);
+
+    return xpc->get_config(xptr);
+}
+
 /*
  * Define a mapping of "special" operations depending on the TIMA page
  * offset and the size of the operation.
diff --git a/include/hw/ppc/xive.h b/include/hw/ppc/xive.h
index f7eea4ca81..3dfb06e002 100644
--- a/include/hw/ppc/xive.h
+++ b/include/hw/ppc/xive.h
@@ -430,6 +430,8 @@ typedef struct XivePresenterClass XivePresenterClass;
 DECLARE_CLASS_CHECKERS(XivePresenterClass, XIVE_PRESENTER,
                        TYPE_XIVE_PRESENTER)
 
+#define XIVE_PRESENTER_GEN1_TIMA_OS     0x1
+
 struct XivePresenterClass {
     InterfaceClass parent;
     int (*match_nvt)(XivePresenter *xptr, uint8_t format,
@@ -437,6 +439,7 @@ struct XivePresenterClass {
                      bool cam_ignore, uint8_t priority,
                      uint32_t logic_serv, XiveTCTXMatch *match);
     bool (*in_kernel)(const XivePresenter *xptr);
+    uint32_t (*get_config)(XivePresenter *xptr);
 };
 
 int xive_presenter_tctx_match(XivePresenter *xptr, XiveTCTX *tctx,
-- 
2.41.0



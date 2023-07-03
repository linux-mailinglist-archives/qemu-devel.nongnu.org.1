Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DD32174570E
	for <lists+qemu-devel@lfdr.de>; Mon,  3 Jul 2023 10:13:40 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qGEfn-0008Or-H0; Mon, 03 Jul 2023 04:12:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <fbarrat@linux.ibm.com>)
 id 1qGEfi-0008N9-GM; Mon, 03 Jul 2023 04:12:34 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <fbarrat@linux.ibm.com>)
 id 1qGEff-0004nb-DI; Mon, 03 Jul 2023 04:12:34 -0400
Received: from pps.filterd (m0353722.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 3637leeD032703; Mon, 3 Jul 2023 08:12:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=from : to : subject :
 date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=aBr7P76h+/vftbDIa5fCJfYvGZ3o/0jD+VpVat8oZso=;
 b=haDqvcFykHEBYVhSHGno7gQ66dvR366WJlNPnxkp+kBSuuTTxpegJMoj28A+EDvBwQ0w
 I02C9lZ6TLo0CdDX+zhPqDzjXzlirML+mmHSTbldpOHvjJDKGs9GUA7Fkr1n15LivROa
 HclLfVDo8GKhRB77W0jQ1uCm84HqE4iq57TqoY3wEeIo6zNKhe/cGtV/odvkDv/4+0Uo
 HjVBaezE8Oc96KROZcDQ/OcADENdAg7S9nuvnFRxMdWkWgz5t57ZHjvRKo+kSLNQflyI
 cPG5amBF8Z/GloNVD6qplPNfABA/xleZmSiJ2mGGXiSJ7bvgvOm73a1XiNxt+41QyDAq IA== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3rkt8nrhhc-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 03 Jul 2023 08:12:21 +0000
Received: from m0353722.ppops.net (m0353722.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 3637pEOJ010513;
 Mon, 3 Jul 2023 08:12:21 GMT
Received: from ppma01fra.de.ibm.com (46.49.7a9f.ip4.static.sl-reverse.com
 [159.122.73.70])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3rkt8nrhgr-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 03 Jul 2023 08:12:20 +0000
Received: from pps.filterd (ppma01fra.de.ibm.com [127.0.0.1])
 by ppma01fra.de.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 3634QOrN000970;
 Mon, 3 Jul 2023 08:12:19 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
 by ppma01fra.de.ibm.com (PPS) with ESMTPS id 3rjbs4rvnh-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 03 Jul 2023 08:12:19 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com
 [10.20.54.103])
 by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 3638CGfX16712380
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 3 Jul 2023 08:12:16 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 9F3C120040;
 Mon,  3 Jul 2023 08:12:16 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 526882004B;
 Mon,  3 Jul 2023 08:12:16 +0000 (GMT)
Received: from borneo.ibmuc.com (unknown [9.171.4.254])
 by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Mon,  3 Jul 2023 08:12:16 +0000 (GMT)
From: Frederic Barrat <fbarrat@linux.ibm.com>
To: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Daniel Henrique Barboza <danielhb413@gmail.com>, qemu-ppc@nongnu.org,
 qemu-devel@nongnu.org
Subject: [PATCH v2 1/2] pnv/xive: Add property on xive sources to define PQ
 state on reset
Date: Mon,  3 Jul 2023 10:12:14 +0200
Message-ID: <20230703081215.55252-2-fbarrat@linux.ibm.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230703081215.55252-1-fbarrat@linux.ibm.com>
References: <20230703081215.55252-1-fbarrat@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: t98qDQdQeDgj-Hq-YSsEthObpaIzDE3l
X-Proofpoint-ORIG-GUID: mgx4J_BeHBMA1-u2w-8IqjhLttZSpY0u
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-03_06,2023-06-30_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxscore=0 phishscore=0
 lowpriorityscore=0 suspectscore=0 bulkscore=0 spamscore=0 mlxlogscore=999
 priorityscore=1501 clxscore=1015 malwarescore=0 adultscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2307030073
Received-SPF: pass client-ip=148.163.158.5; envelope-from=fbarrat@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
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

The PQ state of a xive interrupt is always initialized to Q=1, which
means the interrupt is disabled. Since a xive source can be embedded
in many objects, this patch adds a property to allow that behavior to
be refined if needed.

Signed-off-by: Frederic Barrat <fbarrat@linux.ibm.com>
---
 hw/intc/xive.c        | 8 ++++++--
 include/hw/ppc/xive.h | 1 +
 2 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/hw/intc/xive.c b/hw/intc/xive.c
index 84c079b034..f60c878345 100644
--- a/hw/intc/xive.c
+++ b/hw/intc/xive.c
@@ -1232,8 +1232,7 @@ static void xive_source_reset(void *dev)
 
     /* Do not clear the LSI bitmap */
 
-    /* PQs are initialized to 0b01 (Q=1) which corresponds to "ints off" */
-    memset(xsrc->status, XIVE_ESB_OFF, xsrc->nr_irqs);
+    memset(xsrc->status, xsrc->reset_pq, xsrc->nr_irqs);
 }
 
 static void xive_source_realize(DeviceState *dev, Error **errp)
@@ -1287,6 +1286,11 @@ static Property xive_source_properties[] = {
     DEFINE_PROP_UINT64("flags", XiveSource, esb_flags, 0),
     DEFINE_PROP_UINT32("nr-irqs", XiveSource, nr_irqs, 0),
     DEFINE_PROP_UINT32("shift", XiveSource, esb_shift, XIVE_ESB_64K_2PAGE),
+    /*
+     * By default, PQs are initialized to 0b01 (Q=1) which corresponds
+     * to "ints off"
+     */
+    DEFINE_PROP_UINT8("reset-pq", XiveSource, reset_pq, XIVE_ESB_OFF),
     DEFINE_PROP_LINK("xive", XiveSource, xive, TYPE_XIVE_NOTIFIER,
                      XiveNotifier *),
     DEFINE_PROP_END_OF_LIST(),
diff --git a/include/hw/ppc/xive.h b/include/hw/ppc/xive.h
index 3dfb06e002..9f580a2699 100644
--- a/include/hw/ppc/xive.h
+++ b/include/hw/ppc/xive.h
@@ -187,6 +187,7 @@ struct XiveSource {
 
     /* PQ bits and LSI assertion bit */
     uint8_t         *status;
+    uint8_t         reset_pq; /* PQ state on reset */
 
     /* ESB memory region */
     uint64_t        esb_flags;
-- 
2.41.0



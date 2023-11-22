Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 00AF87F4196
	for <lists+qemu-devel@lfdr.de>; Wed, 22 Nov 2023 10:27:29 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r5jVJ-0001Rs-2d; Wed, 22 Nov 2023 04:26:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1r5jVH-0001Qu-Bp; Wed, 22 Nov 2023 04:26:39 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1r5jVF-00068M-PW; Wed, 22 Nov 2023 04:26:39 -0500
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 3AM93BF6014271; Wed, 22 Nov 2023 09:26:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=wjgUSvcRaCriSMW4avfB6Nuiw3vx/wbmf4lXIGy9pIg=;
 b=C3HSectSq3e0Kqhci3HEZZSKTD37POsJnOLa1KXakE1aF5Wx6vkS3V6HWmW+rWXk/6xy
 VdzV7kB2aALtvpcZkjbIHvrY+NSgqrLMtDiNAk4N7qVR6k43XEBz6qw/keHuvHhXN/n8
 TGjF6y8BsteaVju/Ceap2RFNg6CHLWspqq3qtl+bkEIpmyhOHK1kizxvYGZ/xtia1vgK
 nbccKo6KghmlsbnLag+znMVIrVj/Wjdej9Dz1igtgUAYKR2cIy6iP2QQCcQIByWtuukW
 Saq7mKnANI67tiTihDpcMaZ9dEao14Fsvssr5k/WRhnCVh3UN2/yq43ysfOd8rvYWFtt 4g== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3uhdg3bbag-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 22 Nov 2023 09:26:25 +0000
Received: from m0353729.ppops.net (m0353729.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 3AM8AigF028477;
 Wed, 22 Nov 2023 09:26:21 GMT
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3uhdg3bb7h-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 22 Nov 2023 09:26:21 +0000
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 3AM7D657002340; Wed, 22 Nov 2023 09:26:11 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 3uf9tkehe1-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 22 Nov 2023 09:26:11 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com
 [10.20.54.101])
 by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 3AM9QAIc19202646
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 22 Nov 2023 09:26:10 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 2315920040;
 Wed, 22 Nov 2023 09:26:10 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id C24F82004B;
 Wed, 22 Nov 2023 09:26:07 +0000 (GMT)
Received: from li-1901474c-32f3-11b2-a85c-fc5ff2c001f3.ibm.com.com (unknown
 [9.43.17.116]) by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Wed, 22 Nov 2023 09:26:07 +0000 (GMT)
From: Harsh Prateek Bora <harshpb@linux.ibm.com>
To: npiggin@gmail.com, qemu-ppc@nongnu.org
Cc: danielhb413@gmail.com, clg@kaod.org, david@gibson.dropbear.id.au,
 qemu-devel@nongnu.org, harshpb@linux.ibm.com
Subject: [PATCH v2 1/2] ppc/spapr: Introduce SPAPR_NR_IPIS to refer IRQ range
 for CPU IPIs.
Date: Wed, 22 Nov 2023 14:54:30 +0530
Message-Id: <20231122092431.973809-2-harshpb@linux.ibm.com>
X-Mailer: git-send-email 2.39.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: gfoQDyF9FSYsPhhElAjcSLTOWth_g9ey
X-Proofpoint-ORIG-GUID: TZhRiS5db0q64mATK3EDsN4X5Dk5dEof
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-22_06,2023-11-21_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0
 mlxlogscore=946 adultscore=0 bulkscore=0 priorityscore=1501 mlxscore=0
 suspectscore=0 phishscore=0 spamscore=0 clxscore=1015 impostorscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311060000 definitions=main-2311220066
Received-SPF: pass client-ip=148.163.156.1; envelope-from=harshpb@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_MSPIKE_H4=0.001,
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

spapr_irq_init currently uses existing macro SPAPR_XIRQ_BASE to refer to
the range of CPU IPIs during initialization of nr-irqs property.
It is more appropriate to have its own define which can be further
reused as appropriate for correct interpretation.

Signed-off-by: Harsh Prateek Bora <harshpb@linux.ibm.com>
Suggested-by: Cedric Le Goater <clg@kaod.org>
---
 hw/ppc/spapr_irq.c         | 4 ++--
 include/hw/ppc/spapr_irq.h | 1 +
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/hw/ppc/spapr_irq.c b/hw/ppc/spapr_irq.c
index a0d1e1298e..0c5db6b161 100644
--- a/hw/ppc/spapr_irq.c
+++ b/hw/ppc/spapr_irq.c
@@ -329,7 +329,7 @@ void spapr_irq_init(SpaprMachineState *spapr, Error **errp)
         int i;
 
         dev = qdev_new(TYPE_SPAPR_XIVE);
-        qdev_prop_set_uint32(dev, "nr-irqs", smc->nr_xirqs + SPAPR_XIRQ_BASE);
+        qdev_prop_set_uint32(dev, "nr-irqs", smc->nr_xirqs + SPAPR_NR_IPIS);
         /*
          * 8 XIVE END structures per CPU. One for each available
          * priority
@@ -356,7 +356,7 @@ void spapr_irq_init(SpaprMachineState *spapr, Error **errp)
     }
 
     spapr->qirqs = qemu_allocate_irqs(spapr_set_irq, spapr,
-                                      smc->nr_xirqs + SPAPR_XIRQ_BASE);
+                                      smc->nr_xirqs + SPAPR_NR_IPIS);
 
     /*
      * Mostly we don't actually need this until reset, except that not
diff --git a/include/hw/ppc/spapr_irq.h b/include/hw/ppc/spapr_irq.h
index c22a72c9e2..e7a80a8349 100644
--- a/include/hw/ppc/spapr_irq.h
+++ b/include/hw/ppc/spapr_irq.h
@@ -28,6 +28,7 @@
 #define SPAPR_IRQ_MSI        (SPAPR_XIRQ_BASE + 0x0300)
 
 #define SPAPR_NR_XIRQS       0x1000
+#define SPAPR_NR_IPIS        0x1000
 
 struct SpaprMachineState;
 
-- 
2.39.3



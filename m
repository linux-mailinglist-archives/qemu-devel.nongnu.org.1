Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BA73C74570B
	for <lists+qemu-devel@lfdr.de>; Mon,  3 Jul 2023 10:13:26 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qGEfv-0008RX-Ux; Mon, 03 Jul 2023 04:12:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <fbarrat@linux.ibm.com>)
 id 1qGEfi-0008NA-L0; Mon, 03 Jul 2023 04:12:34 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <fbarrat@linux.ibm.com>)
 id 1qGEfg-0004nk-Hj; Mon, 03 Jul 2023 04:12:34 -0400
Received: from pps.filterd (m0353728.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 3637l4CV024728; Mon, 3 Jul 2023 08:12:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=from : to : subject :
 date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=6odjac1rpl9AF3IjeSw2AAA5zCTgCZawsbncZeihvBY=;
 b=ojL4Vs9+pFC2HIs2Z2vfTMj8sGvCj4SO+2sJ8POrPfXMwZdaZMUHVpL8ZfTFVn2TOG3U
 kXXv7SupeS/M4f0edGly4BVGEGl4sA6A4wa29b0GUvQGC4SKW8ikSMrNEHp1477TW+eL
 qhCGN3k8SzSfYwt5vE3WzuyzBaVe6Yw8bRoo4XxWMvO8jFXiJlMxyYd29d1zmMgaFjIA
 5xLKObvfD59eWNEnQge0M/CK6ugGHGakvxpSzQxc88h/FjmJkYN/IIfLhPSQxOtMM/Hi
 6winwPPyAG5K9e3gv2U71pklXs0eY0xCinnqAeW+b3ORJU7KeTcAn3ehfyEWFZTQtLHG dA== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3rkt87gkjp-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 03 Jul 2023 08:12:22 +0000
Received: from m0353728.ppops.net (m0353728.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 3637lSE1028019;
 Mon, 3 Jul 2023 08:12:21 GMT
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com
 [169.51.49.102])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3rkt87gkj5-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 03 Jul 2023 08:12:21 +0000
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
 by ppma06ams.nl.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 3634SiXt022436;
 Mon, 3 Jul 2023 08:12:19 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
 by ppma06ams.nl.ibm.com (PPS) with ESMTPS id 3rjbde16wm-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 03 Jul 2023 08:12:19 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com
 [10.20.54.103])
 by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 3638CHFV38077164
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 3 Jul 2023 08:12:17 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 1876120040;
 Mon,  3 Jul 2023 08:12:17 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id B5DF520043;
 Mon,  3 Jul 2023 08:12:16 +0000 (GMT)
Received: from borneo.ibmuc.com (unknown [9.171.4.254])
 by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Mon,  3 Jul 2023 08:12:16 +0000 (GMT)
From: Frederic Barrat <fbarrat@linux.ibm.com>
To: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Daniel Henrique Barboza <danielhb413@gmail.com>, qemu-ppc@nongnu.org,
 qemu-devel@nongnu.org
Subject: [PATCH v2 2/2] pnv/psi: Initialize the PSIHB interrupts to match
 hardware
Date: Mon,  3 Jul 2023 10:12:15 +0200
Message-ID: <20230703081215.55252-3-fbarrat@linux.ibm.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230703081215.55252-1-fbarrat@linux.ibm.com>
References: <20230703081215.55252-1-fbarrat@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: IrKpi6gmTOZ_xFGH8MQT3i0sT37d8pLU
X-Proofpoint-ORIG-GUID: t2i4ZzrL3xYdDykhcmPBC5ZIHreq57zW
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-03_06,2023-06-30_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 adultscore=0 malwarescore=0 spamscore=0 mlxlogscore=663 mlxscore=0
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

On the powernv9 and powernv10 machines, the PSIHB interrupts are
currently initialized with a PQ state of 0b01, i.e. interrupts are
disabled. However real hardware initializes them to 0b00 for the
PSIHB. This patch updates it, in case an hypervisor is in the mood of
checking it.

Signed-off-by: Frederic Barrat <fbarrat@linux.ibm.com>
---
 hw/ppc/pnv_psi.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/hw/ppc/pnv_psi.c b/hw/ppc/pnv_psi.c
index 46da58dff8..daaa2f0575 100644
--- a/hw/ppc/pnv_psi.c
+++ b/hw/ppc/pnv_psi.c
@@ -863,6 +863,8 @@ static void pnv_psi_power9_realize(DeviceState *dev, Error **errp)
     object_property_set_int(OBJECT(xsrc), "nr-irqs", PSIHB9_NUM_IRQS,
                             &error_fatal);
     object_property_set_link(OBJECT(xsrc), "xive", OBJECT(psi), &error_abort);
+    object_property_set_int(OBJECT(xsrc), "reset-pq", XIVE_ESB_RESET,
+                            &error_abort);
     if (!qdev_realize(DEVICE(xsrc), NULL, errp)) {
         return;
     }
-- 
2.41.0



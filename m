Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8277C74570D
	for <lists+qemu-devel@lfdr.de>; Mon,  3 Jul 2023 10:13:39 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qGEfm-0008NH-24; Mon, 03 Jul 2023 04:12:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <fbarrat@linux.ibm.com>)
 id 1qGEfh-0008MU-0Q; Mon, 03 Jul 2023 04:12:33 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <fbarrat@linux.ibm.com>)
 id 1qGEff-0004na-Cv; Mon, 03 Jul 2023 04:12:32 -0400
Received: from pps.filterd (m0353724.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 3637lbnq023501; Mon, 3 Jul 2023 08:12:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=from : to : subject :
 date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=jnG+a5W8+3I+EldjYrly7TRtpmOaovVBWpdz86/17+Y=;
 b=fGrMHF0llTGXboJFk/U24CJm6YFOt8uL4bY5XEWJ+scg+KMdUnYYrZHCnb2sBQv2Eppr
 lyPcpltLaWVlFBZDZE+T/UX99afR8fbhQbx+cSGzeYSdQpqehRtZvlZ6bIu6eRBQrgOj
 6fYjPgIrcqguUHBvLyOzONOKvjXRvfDCPnD9Nh/dLK52RXmwYhk1FYmxgZv+lUBIWV/t
 +JgfkqbMHPRdZipw7roGq1gNhFN4L/XLS9AZlAPqJuPVfgFHnquAXA+oOEyEMP+RRvir
 zn3jyUoy98s6o/ECNxqfgnzUbRkNvFOe7hTWtiEOmtrAeYvKfCtVlQwURfgABovilWmF jg== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3rkt8hrjmb-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 03 Jul 2023 08:12:21 +0000
Received: from m0353724.ppops.net (m0353724.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 3637nvsU028891;
 Mon, 3 Jul 2023 08:12:20 GMT
Received: from ppma03fra.de.ibm.com (6b.4a.5195.ip4.static.sl-reverse.com
 [149.81.74.107])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3rkt8hrjkt-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 03 Jul 2023 08:12:20 +0000
Received: from pps.filterd (ppma03fra.de.ibm.com [127.0.0.1])
 by ppma03fra.de.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 3633tcrA016279;
 Mon, 3 Jul 2023 08:12:19 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
 by ppma03fra.de.ibm.com (PPS) with ESMTPS id 3rjbs4rvh2-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 03 Jul 2023 08:12:19 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com
 [10.20.54.103])
 by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 3638CGcW16712376
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 3 Jul 2023 08:12:16 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 3BA0420043;
 Mon,  3 Jul 2023 08:12:16 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id D9A482004B;
 Mon,  3 Jul 2023 08:12:15 +0000 (GMT)
Received: from borneo.ibmuc.com (unknown [9.171.4.254])
 by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Mon,  3 Jul 2023 08:12:15 +0000 (GMT)
From: Frederic Barrat <fbarrat@linux.ibm.com>
To: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Daniel Henrique Barboza <danielhb413@gmail.com>, qemu-ppc@nongnu.org,
 qemu-devel@nongnu.org
Subject: [PATCH v2 0/2] Fix PSIHB interrupts init PQ state
Date: Mon,  3 Jul 2023 10:12:13 +0200
Message-ID: <20230703081215.55252-1-fbarrat@linux.ibm.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 1_0zMk0TFPCjSMiGZxwW5JMz72q1a3Mj
X-Proofpoint-ORIG-GUID: Zw482Pn56AfBhlHBeZJCaI4lA8x9VIWt
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-03_06,2023-06-30_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0
 mlxlogscore=794 mlxscore=0 clxscore=1015 adultscore=0 suspectscore=0
 lowpriorityscore=0 malwarescore=0 spamscore=0 bulkscore=0 phishscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
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

On P9 and 10, the real hardware defines the PQ state of the PSIHB
interrupts to be 0b00. Qemu defaults to 0b01.

It doesn't matter to skiboot, which doesn't rely on it and explicitly
masks the interrupts during intialization. But this patch fixes it,
just in case some other hypervisor checks it.

Changelog:
v2: rename property/struct member
    rebase to Daniel's ppc-next branch


Frederic Barrat (2):
  pnv/xive: Add property on xive sources to define PQ state on reset
  pnv/psi: Initialize the PSIHB interrupts to match hardware

 hw/intc/xive.c        | 8 ++++++--
 hw/ppc/pnv_psi.c      | 2 ++
 include/hw/ppc/xive.h | 1 +
 3 files changed, 9 insertions(+), 2 deletions(-)

-- 
2.41.0



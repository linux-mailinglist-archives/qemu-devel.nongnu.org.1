Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id AA72973A612
	for <lists+qemu-devel@lfdr.de>; Thu, 22 Jun 2023 18:27:30 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qCN8f-0005dN-5H; Thu, 22 Jun 2023 12:26:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <fbarrat@linux.ibm.com>)
 id 1qCN82-0005Jz-4f; Thu, 22 Jun 2023 12:25:54 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <fbarrat@linux.ibm.com>)
 id 1qCN7x-0002HC-I5; Thu, 22 Jun 2023 12:25:48 -0400
Received: from pps.filterd (m0353726.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 35MG7ixQ026867; Thu, 22 Jun 2023 16:25:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=from : to : subject :
 date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=kOPnyLz0/0mfMQ4jT6qR4poi9b8xGD04eEEJmMVmYb4=;
 b=oPZB2llF3uGQJt+L77RwBXjhRNiTKazqrYK/5HrEs7QGpM0R4OSk19KsCBlxAvlHEYI5
 PbziycJgRQIW1UnVCbiJ0cNmSDkeq0V0DhqRra8Yw4/688d0u+DJumEQxF+JpJisIW21
 bPbEKkAHYrnVbost6cvsEeKOvE+DxQmJMdarAo6H6pnkSfx7Cln0rhSCxFypNMaN2CIR
 tbZ50xIceYUoARPZFXd9Cct1wdEVpJXLszFlyKPpdq/dldirLQCbvbi4aZr5De6ryYp1
 WCnNnXIQ2AB6eYj7xfEQ5wCn3ATqX6fA/iyt3ZAEWmIv/D5v9V9c+4UYBgjpLHu1uudy 5w== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3rcs8brx1b-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 22 Jun 2023 16:25:33 +0000
Received: from m0353726.ppops.net (m0353726.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 35MG84aq028536;
 Thu, 22 Jun 2023 16:25:33 GMT
Received: from ppma02fra.de.ibm.com (47.49.7a9f.ip4.static.sl-reverse.com
 [159.122.73.71])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3rcs8brx0h-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 22 Jun 2023 16:25:33 +0000
Received: from pps.filterd (ppma02fra.de.ibm.com [127.0.0.1])
 by ppma02fra.de.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 35M5iZJ3000888;
 Thu, 22 Jun 2023 16:25:30 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
 by ppma02fra.de.ibm.com (PPS) with ESMTPS id 3r94f5aqtx-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 22 Jun 2023 16:25:30 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com
 [10.20.54.102])
 by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 35MGPSM53736098
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 22 Jun 2023 16:25:28 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 1F28020043;
 Thu, 22 Jun 2023 16:25:28 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id B51972004E;
 Thu, 22 Jun 2023 16:25:27 +0000 (GMT)
Received: from borneo.ibmuc.com (unknown [9.171.58.93])
 by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Thu, 22 Jun 2023 16:25:27 +0000 (GMT)
From: Frederic Barrat <fbarrat@linux.ibm.com>
To: clg@kaod.org, danielhb413@gmail.com, qemu-ppc@nongnu.org,
 qemu-devel@nongnu.org
Subject: [PATCH v2 0/2] pnv/xive2: Fix TIMA special ops detection
Date: Thu, 22 Jun 2023 18:25:25 +0200
Message-ID: <20230622162527.1118350-1-fbarrat@linux.ibm.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: MyUW2hxY2sxIIr6n69lIcW2U5QuxTab-
X-Proofpoint-ORIG-GUID: RIFweTjSmD37OVdezgslAv1HJ5tOZxIH
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-06-22_11,2023-06-22_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0
 lowpriorityscore=0 impostorscore=0 mlxscore=0 adultscore=0 clxscore=1015
 spamscore=0 priorityscore=1501 malwarescore=0 phishscore=0 mlxlogscore=914
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2306220136
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

Fix the TIMA special ops detection regression, as spotted by Coverity.

Tested by running a pseries guest on top of a powernv9 and powernv10 host.

Changelog:
v2: define get_config for spapr


Frederic Barrat (2):
  pnv/xive2: Add a get_config() method on the presenter class
  pnv/xive2: Check TIMA special ops against a dedicated array for P10

 hw/intc/pnv_xive.c    | 11 +++++++++
 hw/intc/pnv_xive2.c   | 44 +++++++++------------------------
 hw/intc/spapr_xive.c  | 16 ++++++++++++
 hw/intc/xive.c        | 57 +++++++++++++++++++++++++++++++++++++------
 include/hw/ppc/xive.h |  3 +++
 5 files changed, 91 insertions(+), 40 deletions(-)

-- 
2.41.0



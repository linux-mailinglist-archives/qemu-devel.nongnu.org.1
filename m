Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 14F767C7210
	for <lists+qemu-devel@lfdr.de>; Thu, 12 Oct 2023 18:07:53 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qqyDl-0004bC-6C; Thu, 12 Oct 2023 12:07:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chalapathi.v@linux.ibm.com>)
 id 1qqyDh-0004RG-K0; Thu, 12 Oct 2023 12:07:29 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chalapathi.v@linux.ibm.com>)
 id 1qqyDe-0005hk-RV; Thu, 12 Oct 2023 12:07:28 -0400
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 39CFtANW025711; Thu, 12 Oct 2023 16:06:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=cNF171TPL8mXZ7GC6IWOWDao344AmzOjG72MKt8Je8Q=;
 b=Jz1h2H0BFLPdnP9bbuku30BmF5AUQULOjGScUPWjYks444GiACj8JMHycBMtWCTt+8Rw
 d8mIgQNh7PHECtZ+gBCyFvGvF9Xt2TfJtC3IfqbOzuq68zRFST/wHByEURAQS84mXI+v
 2EI5p012WNrdRXAPBj2Xt8G0Q0zvd8k36oWLk1MnbfvGtXyKewT+aExpVfmLEylV1aTy
 hnzSHd5v/167xAM1gnR91/eooJ7G5UEGroxNRZKplT87arVfkqQ6kYIAOY38ZiWGgoOf
 jWyw5NDoXXrYkUe5Bae978GQPGrrUHDtZx083cqUqAuF5rztKRFL3VNvKMuhUAyfxUu6 Kg== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3tpkv30j54-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 12 Oct 2023 16:06:21 +0000
Received: from m0360072.ppops.net (m0360072.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 39CG4nqi020257;
 Thu, 12 Oct 2023 16:06:19 GMT
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3tpkv30j4e-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 12 Oct 2023 16:06:19 +0000
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 39CFACkW028182; Thu, 12 Oct 2023 16:06:18 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3tkj1ygs88-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 12 Oct 2023 16:06:18 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com
 [10.20.54.104])
 by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 39CG6FcO46399852
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 12 Oct 2023 16:06:15 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 1927420043;
 Thu, 12 Oct 2023 16:06:15 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 8B81920040;
 Thu, 12 Oct 2023 16:06:13 +0000 (GMT)
Received: from gfwr515.rchland.ibm.com (unknown [9.10.239.103])
 by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Thu, 12 Oct 2023 16:06:13 +0000 (GMT)
From: Chalapathi V <chalapathi.v@linux.ibm.com>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, fbarrat@linux.ibm.com, npiggin@gmail.com,
 clg@kaod.org, calebs@us.ibm.com, chalapathi.v@linux.ibm.com,
 saif.abrar@linux.vnet.ibm.com
Subject: [PATCH v2 0/3] pnv nest1 chiplet model
Date: Thu, 12 Oct 2023 11:06:07 -0500
Message-Id: <20231012160610.2428-1-chalapathi.v@linux.ibm.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: VYFncmbkPe0fG7t4k4MBiy6SKttbOvhl
X-Proofpoint-GUID: ccKUWZXZiSyxpnYerWokAMkmhMadlkC2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-12_05,2023-10-12_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 impostorscore=0 malwarescore=0 suspectscore=0 mlxlogscore=646
 lowpriorityscore=0 clxscore=1015 mlxscore=0 bulkscore=0 phishscore=0
 adultscore=0 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2309180000 definitions=main-2310120133
Received-SPF: pass client-ip=148.163.158.5;
 envelope-from=chalapathi.v@linux.ibm.com; helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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

Hello,

For modularity reasons the P10 processor chip is split into multiple
chiplets individually controlled and managed by the pervasive logic.
The boundaries of these chiplets are defined based on physical design
parameters like clock grids, the nature of the functional units as well
as their pervasive requirements (e.g. clock domains). Examples of chiplet
in the P10 chip are processor cores and caches, memory controllers or IO
interfaces like PCIe. Partitioning the processor chip into these chiplets
allows the pervasive logic to test, initialize, control and manage these
chip partitions individually.

In this series, we create a nest1 chiplet model and implements the chiplet
control scom registers on nest1 chiplet. The chiplet control registers does
the initialization and configuration of a chiplet.

Thank You,
Chalapathi

Chalapathi V (3):
  hw/ppc: Add pnv pervasive common chiplet units
  hw/ppc: Add nest1 chiplet model
  hw/ppc: Nest1 chiplet wiring

 hw/ppc/meson.build                |   2 +
 hw/ppc/pnv.c                      |  11 +++
 hw/ppc/pnv_nest1_chiplet.c        | 153 ++++++++++++++++++++++++++++++
 hw/ppc/pnv_pervasive.c            | 151 +++++++++++++++++++++++++++++
 include/hw/ppc/pnv_chip.h         |   2 +
 include/hw/ppc/pnv_nest_chiplet.h |  39 ++++++++
 include/hw/ppc/pnv_pervasive.h    |  39 ++++++++
 include/hw/ppc/pnv_xscom.h        |   3 +
 8 files changed, 400 insertions(+)
 create mode 100644 hw/ppc/pnv_nest1_chiplet.c
 create mode 100644 hw/ppc/pnv_pervasive.c
 create mode 100644 include/hw/ppc/pnv_nest_chiplet.h
 create mode 100644 include/hw/ppc/pnv_pervasive.h

-- 
2.31.1



Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 85C427DA6BD
	for <lists+qemu-devel@lfdr.de>; Sat, 28 Oct 2023 13:32:29 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qwhWl-0000bM-Pj; Sat, 28 Oct 2023 07:30:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chalapathi.v@linux.ibm.com>)
 id 1qwhWj-0000b3-CK; Sat, 28 Oct 2023 07:30:49 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chalapathi.v@linux.ibm.com>)
 id 1qwhWg-0005Sa-Pq; Sat, 28 Oct 2023 07:30:49 -0400
Received: from pps.filterd (m0353727.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 39SBLJLe030244; Sat, 28 Oct 2023 11:30:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=T+GwO2d+sjIa5Hdi/z4yBgBO2rds7t7LFUsNhK9zM5w=;
 b=XoQTQOUKtPkLVxgLjyRsGx9oOH3nNsRdaqpGBdW5+d3fea9MJ/2O7GS8wSSG/2kRywaX
 VG5L9FJ6QylbmLYT3hemqy/sm45/4mhC/iPNY0tYSqetQS2cpD/ZdJZtpIAFyvkk/9it
 Gwc6ZhjqDLWjXbiKrbUprjI+jVmD9p7QtwInpB52gtI0Htv9fZgnyGJ6kSxeE02I+LPB
 dwwD1cYg6xv5KvUWZx1o9bL1pVbJ/0zDwRIQdGoECJJT3PB0+qZYkAQ7Dy8aznqpBACK
 vWrdGjyg4+qh7NTve15P06MKzboKFo4xPsR+MbGZXn5bV2ECVlycAnoicfXy12Jj1Mzz PQ== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3u10bbh1cr-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Sat, 28 Oct 2023 11:30:34 +0000
Received: from m0353727.ppops.net (m0353727.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 39SBUOaE017628;
 Sat, 28 Oct 2023 11:30:34 GMT
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3u10bbh1ce-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Sat, 28 Oct 2023 11:30:34 +0000
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 39SB4K1W021754; Sat, 28 Oct 2023 11:30:33 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3tywqskj1r-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Sat, 28 Oct 2023 11:30:33 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com
 [10.20.54.106])
 by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 39SBUVfw44892472
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Sat, 28 Oct 2023 11:30:31 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 24A3D20040;
 Sat, 28 Oct 2023 11:30:31 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 9C22B2004F;
 Sat, 28 Oct 2023 11:30:29 +0000 (GMT)
Received: from gfwr515.rchland.ibm.com (unknown [9.10.239.103])
 by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Sat, 28 Oct 2023 11:30:29 +0000 (GMT)
From: Chalapathi V <chalapathi.v@linux.ibm.com>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, fbarrat@linux.ibm.com, npiggin@gmail.com,
 clg@kaod.org, calebs@us.ibm.com, chalapathi.v@ibm.com,
 saif.abrar@linux.vnet.ibm.com
Subject: [PATCH v3 0/3] pnv nest1 chiplet model
Date: Sat, 28 Oct 2023 06:30:23 -0500
Message-Id: <20231028113026.23510-1-chalapathi.v@linux.ibm.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 2cK0m3JP-HFzOPqLpJHPUXlN8uqH2pT_
X-Proofpoint-ORIG-GUID: bQ9AqDuq-tIdozIQuMFpMivRHST1eKpy
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-28_09,2023-10-27_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 mlxlogscore=489
 priorityscore=1501 impostorscore=0 mlxscore=0 adultscore=0 bulkscore=0
 spamscore=0 suspectscore=0 clxscore=1011 malwarescore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2310240000
 definitions=main-2310280088
Received-SPF: pass client-ip=148.163.156.1;
 envelope-from=chalapathi.v@linux.ibm.com; helo=mx0a-001b2d01.pphosted.com
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

In this PATCH Cedric's review comments has been addressed to add a new QOM
model for pervasive chiplet and initialize and realize in nest1 chiplet model.

/nest1_chiplet (pnv-nest1-chiplet)
      /perv_chiplet (pnv-pervasive-chiplet)
        /xscom-chiplet-control-regs[0] (memory-region)

Chalapathi V (3):
  hw/ppc: Add pnv pervasive common chiplet units
  hw/ppc: Add nest1 chiplet model
  hw/ppc: Nest1 chiplet wiring

 hw/ppc/meson.build                |   2 +
 hw/ppc/pnv.c                      |  11 ++
 hw/ppc/pnv_nest1_chiplet.c        | 104 +++++++++++++
 hw/ppc/pnv_pervasive.c            | 237 ++++++++++++++++++++++++++++++
 include/hw/ppc/pnv_chip.h         |   2 +
 include/hw/ppc/pnv_nest_chiplet.h |  39 +++++
 include/hw/ppc/pnv_pervasive.h    |  47 ++++++
 include/hw/ppc/pnv_xscom.h        |   3 +
 8 files changed, 445 insertions(+)
 create mode 100644 hw/ppc/pnv_nest1_chiplet.c
 create mode 100644 hw/ppc/pnv_pervasive.c
 create mode 100644 include/hw/ppc/pnv_nest_chiplet.h
 create mode 100644 include/hw/ppc/pnv_pervasive.h

-- 
2.31.1



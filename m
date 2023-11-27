Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 10FD17FA7C5
	for <lists+qemu-devel@lfdr.de>; Mon, 27 Nov 2023 18:14:28 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r7fAp-0001Ix-5u; Mon, 27 Nov 2023 12:13:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chalapathi.v@linux.ibm.com>)
 id 1r7fAh-0001Hs-Jr; Mon, 27 Nov 2023 12:13:23 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chalapathi.v@linux.ibm.com>)
 id 1r7fAf-0005gW-Bu; Mon, 27 Nov 2023 12:13:23 -0500
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 3ARFf0Na032482; Mon, 27 Nov 2023 17:13:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=TSfuHWGm95ndidzZx7z8kAbE5GCbW+CE6SBZFltJa54=;
 b=Bv3HTxZDBOcJVBJEIyU72k/2XQqDr2WjSAtoHnRkSqNbpMZOmnX7/q0//XPk0GDAwrjS
 DNGFzABU6c+nfsU3iHKBLZpvo0muTSh/XKpWamhUApjIxGnN7+22pk43o2rAW84Y0EkY
 XMZegnlXSNVHuLR8jc+QIHW3+TfZJm13hsG/p2cs+cAOYG1GfSE3gLtZMg54k02ex9m7
 ccW0U+N6yrPt8rbS/zPzmLJ3+G7FMrCu4Xgq45m+98w9CB6jM1vDr0/ILQS13F3U8k8b
 MSSrc5RRYf8tCjxysxq9xdDMuSIsA4H40uC2mqxmVa+Yq9HI46F7nLQ9fCqxyAAk8fyQ ow== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3umwyfk5qq-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 27 Nov 2023 17:13:16 +0000
Received: from m0360072.ppops.net (m0360072.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 3ARHBnsw022116;
 Mon, 27 Nov 2023 17:13:16 GMT
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3umwyfk5qf-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 27 Nov 2023 17:13:16 +0000
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 3ARGqPP4018591; Mon, 27 Nov 2023 17:13:15 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 3ukwfjss20-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 27 Nov 2023 17:13:15 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com
 [10.20.54.100])
 by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 3ARHDCPk44237146
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 27 Nov 2023 17:13:12 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 648B42004B;
 Mon, 27 Nov 2023 17:13:12 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id B18AE20040;
 Mon, 27 Nov 2023 17:13:10 +0000 (GMT)
Received: from gfwr515.rchland.ibm.com (unknown [9.10.239.103])
 by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Mon, 27 Nov 2023 17:13:10 +0000 (GMT)
From: Chalapathi V <chalapathi.v@linux.ibm.com>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, fbarrat@linux.ibm.com, npiggin@gmail.com,
 clg@kaod.org, calebs@us.ibm.com, chalapathi.v@ibm.com,
 chalapathi.v@linux.ibm.com, saif.abrar@linux.vnet.ibm.com
Subject: [PATCH v6 0/3] pnv nest1 chiplet model
Date: Mon, 27 Nov 2023 11:13:04 -0600
Message-Id: <20231127171307.5237-1-chalapathi.v@linux.ibm.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: GGmMISMgo6XjYI1F3riv06DlNsO6mObW
X-Proofpoint-GUID: p0VVZQBiqlggkvojbFS4r3yLWig-f37m
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-27_15,2023-11-27_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 spamscore=0
 mlxscore=0 suspectscore=0 priorityscore=1501 bulkscore=0
 lowpriorityscore=0 mlxlogscore=638 phishscore=0 malwarescore=0
 clxscore=1015 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311060000 definitions=main-2311270119
Received-SPF: pass client-ip=148.163.158.5;
 envelope-from=chalapathi.v@linux.ibm.com; helo=mx0b-001b2d01.pphosted.com
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

Hello,

Thank you for the review and suggestions on V5.

The suggestions and changes requested from V5 are addressed in V6.

Updates in Version 6 of this series are: 
1. adding a device-tree node in QEMU is removed as skiboot defines the
   device-tree and QEMU should just follow it.
2. Renamed PnvPerv to PnvNestChipletPervasive in PATCH1 as the model provides
   the common pervasive registers of all nest chiplets.
3. Nest1_chiplet model in PATCH2 is renamed to N1_chiplet to avoid the
   confussions that may comeup later.

Hence the new qom-tree looks like below.
(qemu) info qom-tree 
/machine (powernv10-machine)
  /chip[0] (power10_v2.0-pnv-chip)
    /n1_chiplet (pnv-N1-chiplet)
      /nest_pervasive_common (pnv-nest-chiplet-pervasive)
        /xscom-n1_chiplet-control-regs[0] (memory-region)
      /xscom-n1_chiplet-pb-scom-eq-regs[0] (memory-region)
      /xscom-n1_chiplet-pb-scom-es-regs[0] (memory-region)

Patches overview in V6.
PATCH1: Create a common nest pervasive chiplet model with control chiplet scom
        registers.
PATCH2: Create a N1 chiplet model and implement powerbus scom registers.
        Connect common nest pervasive model to N1 chiplet model to define
        chiplet control scoms for N1 chiplet.
PATCH3: Connect N1 chiplet model to p10 chip.

Test covered:
These changes are tested on a single socket and 2 socket P10 machine.

Thank You,
Chalapathi

Chalapathi V (3):
  hw/ppc: Add pnv nest pervasive common chiplet model
  hw/ppc: Add N1 chiplet model
  hw/ppc: N1 chiplet wiring

 include/hw/ppc/pnv_chip.h           |   2 +
 include/hw/ppc/pnv_n1_chiplet.h     |  35 +++++
 include/hw/ppc/pnv_nest_pervasive.h |  36 +++++
 include/hw/ppc/pnv_xscom.h          |   9 ++
 hw/ppc/pnv.c                        |  15 ++
 hw/ppc/pnv_n1_chiplet.c             | 171 ++++++++++++++++++++++
 hw/ppc/pnv_nest_pervasive.c         | 219 ++++++++++++++++++++++++++++
 hw/ppc/meson.build                  |   2 +
 8 files changed, 489 insertions(+)
 create mode 100644 include/hw/ppc/pnv_n1_chiplet.h
 create mode 100644 include/hw/ppc/pnv_nest_pervasive.h
 create mode 100644 hw/ppc/pnv_n1_chiplet.c
 create mode 100644 hw/ppc/pnv_nest_pervasive.c

-- 
2.31.1



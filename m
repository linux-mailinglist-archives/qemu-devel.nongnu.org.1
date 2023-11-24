Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A3B67F712F
	for <lists+qemu-devel@lfdr.de>; Fri, 24 Nov 2023 11:17:06 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r6TET-0005Zt-1e; Fri, 24 Nov 2023 05:16:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chalapathi.v@linux.ibm.com>)
 id 1r6TEJ-0005Xg-Me; Fri, 24 Nov 2023 05:16:12 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chalapathi.v@linux.ibm.com>)
 id 1r6TED-0005Ul-UH; Fri, 24 Nov 2023 05:16:09 -0500
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 3AOAAldQ007333; Fri, 24 Nov 2023 10:15:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=huUo1IbUFKoMVDvlDCUWR7x8NrZvJuQn8E2Jfkp8FF0=;
 b=GbAalr/C5NJE0n2ns8HltB+UiE0bLTmgzO5gyGe9dLtJWu98r/MV2oiisvqOvZvlZ5LZ
 noJdSgIFxx73vgkPdakxi7weWxtj7E3BG39qkQSszIo7dfugUxsi5NEU/iFP0bxjHlsZ
 P2K+LCOH2zPvTDG+tR7jgJSDte0AvK/bybUNgwnyJBg3iVjyJuVj1oSBS1QIsMEI8lX3
 530gswSPolv6OHYpxLLxQV/5NLAoW+FOus14EJBfVGYOf09qRMe6rhyFYR+F+WPbjuZs
 HXz9XxJtbr+DHFp7vvqgW2nENvS3k52r+jTzWLZzkP7FFmUruTA89tDeLD3O0ipBYyE+ nA== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3ujqtvbab2-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 24 Nov 2023 10:15:54 +0000
Received: from m0356516.ppops.net (m0356516.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 3AOAAn9j007522;
 Fri, 24 Nov 2023 10:15:54 GMT
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3ujqtvbaau-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 24 Nov 2023 10:15:54 +0000
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 3AO9dOnM017476; Fri, 24 Nov 2023 10:15:53 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 3uf9tkvjvf-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 24 Nov 2023 10:15:53 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com
 [10.20.54.102])
 by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 3AOAFpbm17302144
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 24 Nov 2023 10:15:51 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 8F75320075;
 Fri, 24 Nov 2023 10:15:51 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 0DBF620074;
 Fri, 24 Nov 2023 10:15:50 +0000 (GMT)
Received: from gfwr515.rchland.ibm.com (unknown [9.10.239.103])
 by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Fri, 24 Nov 2023 10:15:49 +0000 (GMT)
From: Chalapathi V <chalapathi.v@linux.ibm.com>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, fbarrat@linux.ibm.com, npiggin@gmail.com,
 clg@kaod.org, calebs@us.ibm.com, chalapathi.v@ibm.com,
 saif.abrar@linux.vnet.ibm.com
Subject: [PATCH v5 0/3] pnv nest1 chiplet model
Date: Fri, 24 Nov 2023 04:15:31 -0600
Message-Id: <20231124101534.19454-1-chalapathi.v@linux.ibm.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: VzjQDMQdaQX0rtORcVynzl9botWA2zcW
X-Proofpoint-GUID: sJonzk60Y5w9Jy3kuWQ5ciVGBuXJ_5MN
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-23_15,2023-11-22_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 impostorscore=0 clxscore=1011 phishscore=0 spamscore=0 adultscore=0
 bulkscore=0 mlxscore=0 lowpriorityscore=0 suspectscore=0 malwarescore=0
 mlxlogscore=858 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311060000 definitions=main-2311240080
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

Thank you for the review and suggestions on V4.

The suggestions and changes requested in V4 are considered and incorporated in
V5.

In this version, couple of powerbus scom registers are modelled.
Hence the new qom-tree is as below.
(qemu) info qom-tree 
/machine (powernv10-machine)
  /chip[0] (power10_v2.0-pnv-chip)
    /nest1 (pnv-nest1-chiplet)
      /perv (pnv-pervasive-chiplet)
        /xscom-nest1-control-regs[0] (memory-region)
      /xscom-nest1-pb-scom-eq-regs[0] (memory-region)
      /xscom-nest1-pb-scom-es-regs[0] (memory-region)

Patches overview in V5.
PATCH1: Create a common perv chiplet model with control chiplet scom registers
PATCH2: Create a nest1 chiplet model, connect perv model to nest1 and implement
        powerbus scom registers.
PATCH3: Connect nest1 model to p10 chip.

Test covered:
These changes are tested on a single socket and 2 socket P10 machine.

Thank You,
Chalapathi

Chalapathi V (3):
  hw/ppc: Add pnv pervasive common chiplet units
  hw/ppc: Add nest1 chiplet model
  hw/ppc: Nest1 chiplet wiring

 include/hw/ppc/pnv_chip.h         |   2 +
 include/hw/ppc/pnv_nest_chiplet.h |  36 +++++
 include/hw/ppc/pnv_pervasive.h    |  37 +++++
 include/hw/ppc/pnv_xscom.h        |   9 ++
 hw/ppc/pnv.c                      |  14 ++
 hw/ppc/pnv_nest1_chiplet.c        | 197 +++++++++++++++++++++++++++
 hw/ppc/pnv_pervasive.c            | 217 ++++++++++++++++++++++++++++++
 hw/ppc/meson.build                |   2 +
 8 files changed, 514 insertions(+)
 create mode 100644 include/hw/ppc/pnv_nest_chiplet.h
 create mode 100644 include/hw/ppc/pnv_pervasive.h
 create mode 100644 hw/ppc/pnv_nest1_chiplet.c
 create mode 100644 hw/ppc/pnv_pervasive.c

-- 
2.31.1



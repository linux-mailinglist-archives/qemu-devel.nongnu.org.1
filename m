Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id AE2157E45B8
	for <lists+qemu-devel@lfdr.de>; Tue,  7 Nov 2023 17:17:50 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r0OkY-0007zc-41; Tue, 07 Nov 2023 11:16:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chalap1@us.ibm.com>)
 id 1r0Gip-0006A5-9j; Tue, 07 Nov 2023 02:42:05 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chalap1@us.ibm.com>)
 id 1r0Gil-0006aX-RG; Tue, 07 Nov 2023 02:42:03 -0500
Received: from pps.filterd (m0353723.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 3A77deeA016080; Tue, 7 Nov 2023 07:41:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=7AA9EZuoj+M4V3bfFCBNll4til4SsTa4SIGQGI6bocg=;
 b=P8NSGf5iMo1Dkyzf9/pKtXUD4rBVWfXvfQjzU9bxzAsKl9Dc0YYaxDZEI0jXhgJcVoPx
 AxX9yu8q56z+o7RfFJLcsABHWk7Br8JK5gZax+NO7cykKkQB8CCqNB1S4t5wcr3qCaR3
 vtEyyDoSYrPwJmbvfgnsaV61zAPvqLbXYLu33AxKL6s6hrfpKnXpZDIV4EZQ7wHFgfxg
 IIj+5qHqVo5RiTauU5AFVFyChsfX3tWilFBxhlPgk+zhl3zGCjisVQqU6Bsdo3yRrGg/
 9WXjSfAQNS/q+cWMobKqgCgqddjlEQrC8vEKWjijOiGdOVpthrmiGar3TB1LIamFWGiS Ow== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3u7h1tg2pj-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 07 Nov 2023 07:41:39 +0000
Received: from m0353723.ppops.net (m0353723.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 3A77fcfl023759;
 Tue, 7 Nov 2023 07:41:39 GMT
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3u7h1tg2p1-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 07 Nov 2023 07:41:39 +0000
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 3A765Xfd016958; Tue, 7 Nov 2023 07:41:38 GMT
Received: from smtprelay04.wdc07v.mail.ibm.com ([172.16.1.71])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 3u6301phwy-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 07 Nov 2023 07:41:38 +0000
Received: from smtpav05.dal12v.mail.ibm.com (smtpav05.dal12v.mail.ibm.com
 [10.241.53.104])
 by smtprelay04.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 3A77fWrZ33292946
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 7 Nov 2023 07:41:33 GMT
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id BBB3358067;
 Tue,  7 Nov 2023 07:41:32 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id A9F9A5805D;
 Tue,  7 Nov 2023 07:41:32 +0000 (GMT)
Received: from gfwr516.rchland.ibm.com (unknown [9.10.239.105])
 by smtpav05.dal12v.mail.ibm.com (Postfix) with ESMTPS;
 Tue,  7 Nov 2023 07:41:32 +0000 (GMT)
Received: by gfwr516.rchland.ibm.com (Postfix, from userid 607334)
 id 3BBB422003E; Tue,  7 Nov 2023 01:41:32 -0600 (CST)
From: Chalapathi V <chalap1@gfwr516.rchland.ibm.com>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, fbarrat@linux.ibm.com, npiggin@gmail.com,
 clg@kaod.org, calebs@us.ibm.com, chalapathi.v@ibm.com,
 saif.abrar@linux.vnet.ibm.com, Chalapathi V <chalapathi.v@linux.ibm.com>
Subject: [PATCH v4 0/3] pnv nest1 chiplet model
Date: Tue,  7 Nov 2023 01:41:24 -0600
Message-Id: <20231107074127.31821-1-chalap1@gfwr516.rchland.ibm.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: wMnuaalOZK0YixVh0kwDr90JQhJWLYTQ
X-Proofpoint-ORIG-GUID: qTfHBydMCbmrarIEBNeOzK_ZTPXiv8HG
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-06_15,2023-11-02_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 spamscore=0
 mlxlogscore=582 bulkscore=0 impostorscore=0 lowpriorityscore=0
 phishscore=0 mlxscore=0 priorityscore=1501 malwarescore=0 adultscore=0
 clxscore=1034 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2310240000 definitions=main-2311070062
Received-SPF: pass client-ip=148.163.158.5; envelope-from=chalap1@us.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Tue, 07 Nov 2023 11:16:20 -0500
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

From: Chalapathi V <chalapathi.v@linux.ibm.com>

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

PATCH4: The review comments of PATCH3 has been addressed.

/nest1_chiplet (pnv-nest1-chiplet)
      /perv_chiplet (pnv-pervasive-chiplet)
        /xscom-chiplet-control-regs[0] (memory-region)

Chalapathi V (3):
  hw/ppc: Add pnv pervasive common chiplet units
  hw/ppc: Add nest1 chiplet model
  hw/ppc: Nest1 chiplet wiring

 hw/ppc/meson.build                |   2 +
 hw/ppc/pnv.c                      |  14 +++
 hw/ppc/pnv_nest1_chiplet.c        |  94 +++++++++++++++++
 hw/ppc/pnv_pervasive.c            | 213 ++++++++++++++++++++++++++++++++++++++
 include/hw/ppc/pnv_chip.h         |   2 +
 include/hw/ppc/pnv_nest_chiplet.h |  41 ++++++++
 include/hw/ppc/pnv_pervasive.h    |  39 +++++++
 include/hw/ppc/pnv_xscom.h        |   3 +
 8 files changed, 408 insertions(+)
 create mode 100644 hw/ppc/pnv_nest1_chiplet.c
 create mode 100644 hw/ppc/pnv_pervasive.c
 create mode 100644 include/hw/ppc/pnv_nest_chiplet.h
 create mode 100644 include/hw/ppc/pnv_pervasive.h

-- 
1.8.3.1



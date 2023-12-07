Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B936807EE5
	for <lists+qemu-devel@lfdr.de>; Thu,  7 Dec 2023 03:45:37 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rB4Mm-00067g-1b; Wed, 06 Dec 2023 21:43:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chalapathi.v@linux.ibm.com>)
 id 1rB4Mf-000678-VO; Wed, 06 Dec 2023 21:43:50 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chalapathi.v@linux.ibm.com>)
 id 1rB4Md-00059t-Gv; Wed, 06 Dec 2023 21:43:49 -0500
Received: from pps.filterd (m0353723.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 3B72gVdc025175; Thu, 7 Dec 2023 02:43:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=fxOXqxfB6a35FuovK5PsHeYPWDIGhGcYWHwOBXMNufo=;
 b=s+2P+0e+AGPF2v5BorvZ+YZwOjowwPOm3+Eo36YboAEzTvkLxNfkjxSwoECmPeixVDok
 aVa3l6aHFrAq3v9xbWIzfrGd4QdpSvd2S+H57r91hgRtdP29WeLsKn2VcWwemAX8zFx3
 bDgFj9tU3Y2ea1yxyJ4Rc44vsWCneG5HplLSnIAOV3kbnBQhDUEmUSDzuI4RKMqm5BlU
 FzGyHiDL2tA2yAtg1B9+1qaqTO3s3o4I0jCI/vRhwQQKy9gEg6GbRw2gXqfP8PndSxYD
 lCHLT/b1SdA9Scv7Bbty4ntDMI7morpIQIZ4IY/M0rRn7gwCD6VB9zRFNGMgd51nOrxG qA== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3uu5geg0hk-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 07 Dec 2023 02:43:41 +0000
Received: from m0353723.ppops.net (m0353723.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 3B72hfid027274;
 Thu, 7 Dec 2023 02:43:41 GMT
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3uu5geg0he-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 07 Dec 2023 02:43:41 +0000
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 3B7154us001541; Thu, 7 Dec 2023 02:43:40 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3utav2ggj0-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 07 Dec 2023 02:43:40 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com
 [10.20.54.105])
 by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 3B72hbPr17236644
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 7 Dec 2023 02:43:37 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 731432004D;
 Thu,  7 Dec 2023 02:43:37 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id C7DA120040;
 Thu,  7 Dec 2023 02:43:35 +0000 (GMT)
Received: from gfwr515.rchland.ibm.com (unknown [9.10.239.103])
 by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Thu,  7 Dec 2023 02:43:35 +0000 (GMT)
From: Chalapathi V <chalapathi.v@linux.ibm.com>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, fbarrat@linux.ibm.com, npiggin@gmail.com,
 clg@kaod.org, calebs@us.ibm.com, chalapathi.v@ibm.com,
 chalapathi.v@linux.ibm.com, saif.abrar@linux.vnet.ibm.com
Subject: [PATCH v7 0/3] pnv N1 chiplet model
Date: Wed,  6 Dec 2023 20:43:28 -0600
Message-Id: <20231207024331.5237-1-chalapathi.v@linux.ibm.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: CMam-3bgxSODGdBPym064lxWGHcaxNOF
X-Proofpoint-GUID: cB5WrUiK0g_tQcWkPqvBWxV7lqQKXPhn
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-06_22,2023-12-06_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxscore=0 spamscore=0
 suspectscore=0 adultscore=0 mlxlogscore=709 malwarescore=0 impostorscore=0
 clxscore=1015 bulkscore=0 priorityscore=1501 lowpriorityscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2312070020
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

Thank you for the review and suggestions on V6.

The suggestions and changes requested from V6 are addressed in V7.

Updates in Version 7 of this series are: 
There are no major changes done in revision 7 from revision 6. 
1. The property "parent-obj-name" is removed from nest pervasive chiplet
   model as it is not required.
2. nest pervasive chiplet model is initialized from instance_init handler.

The new qom-tree looks like below.
(qemu) info qom-tree 
/machine (powernv10-machine)
  /chip[0] (power10_v2.0-pnv-chip)
    /n1-chiplet (pnv-N1-chiplet)
      /nest-pervasive-common (pnv-nest-chiplet-pervasive)
        /pervasive-control[0] (memory-region)
      /xscom-n1-chiplet-pb-scom-eq[0] (memory-region)
      /xscom-n1-chiplet-pb-scom-es[0] (memory-region)

Patches overview in V7.
PATCH1: Create a common nest pervasive chiplet model with control chiplet scom
        registers.
PATCH2: Create a N1 chiplet model and implement powerbus scom registers.
        Connect common nest pervasive model to N1 chiplet model to define
        chiplet control scoms for N1 chiplet.
PATCH3: Connect N1 chiplet model to p10 chip.

Test covered:
Ran make check && make check-avocado and found no obvious issues.

Thank You,
Chalapathi

Chalapathi V (3):
  hw/ppc: Add pnv nest pervasive common chiplet model
  hw/ppc: Add N1 chiplet model
  hw/ppc: N1 chiplet wiring

 include/hw/ppc/pnv_chip.h           |   2 +
 include/hw/ppc/pnv_n1_chiplet.h     |  33 +++++
 include/hw/ppc/pnv_nest_pervasive.h |  32 +++++
 include/hw/ppc/pnv_xscom.h          |   9 ++
 hw/ppc/pnv.c                        |  15 ++
 hw/ppc/pnv_n1_chiplet.c             | 173 +++++++++++++++++++++++
 hw/ppc/pnv_nest_pervasive.c         | 208 ++++++++++++++++++++++++++++
 hw/ppc/meson.build                  |   2 +
 8 files changed, 474 insertions(+)
 create mode 100644 include/hw/ppc/pnv_n1_chiplet.h
 create mode 100644 include/hw/ppc/pnv_nest_pervasive.h
 create mode 100644 hw/ppc/pnv_n1_chiplet.c
 create mode 100644 hw/ppc/pnv_nest_pervasive.c

-- 
2.31.1



Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A199980A738
	for <lists+qemu-devel@lfdr.de>; Fri,  8 Dec 2023 16:22:03 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rBcev-0003Fv-Da; Fri, 08 Dec 2023 10:20:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chalapathi.v@linux.ibm.com>)
 id 1rBce8-00037y-Qa; Fri, 08 Dec 2023 10:20:09 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chalapathi.v@linux.ibm.com>)
 id 1rBce6-0003jR-Dd; Fri, 08 Dec 2023 10:20:08 -0500
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 3B8ExgNW029149; Fri, 8 Dec 2023 15:19:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=ddFTU7iUoCwiDiW4zPMpLTqiR2aT55RxlaaXm2egB+g=;
 b=Sxz7lu/wMhkz49KxIdEAEsiZ138QMa/rrC78msR3wfCIgKWk5tDG8VVS4dMakv3i/nBn
 c++8hisYtHilsWQYOK/H8fJxyYbAzIREUnq3clp82g9SNwkhYxDBHM+EHjsYGSn8jKJO
 P3jJxc7Y0r5BMf4w/Qislm4uJLVeEDALwKs5iXaIXR4ENuXL8imACLZQqBAXDiAWbLwV
 zkRR2xOzOTWoaua+Vcn9cml+x4FnPwUovQyvbqWM5N9fYHpA5xRierWZe9nBuhPxb09z
 PuaoNZMu4Ex7hfVpC+5lPg0wJY01tTP1Y5h8BnnN/zBtjuGJwJ8aGNoRb8G740KFztQF lg== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3uv3194thu-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 08 Dec 2023 15:19:56 +0000
Received: from m0356516.ppops.net (m0356516.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 3B8FJLVc023893;
 Fri, 8 Dec 2023 15:19:55 GMT
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3uv3194the-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 08 Dec 2023 15:19:55 +0000
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 3B8DMsi9028450; Fri, 8 Dec 2023 15:19:55 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3utavk28ky-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 08 Dec 2023 15:19:55 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com
 [10.20.54.103])
 by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 3B8FJqI432702968
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 8 Dec 2023 15:19:52 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id E42942004F;
 Fri,  8 Dec 2023 15:19:51 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 4535C20040;
 Fri,  8 Dec 2023 15:19:50 +0000 (GMT)
Received: from gfwr516.rchland.ibm.com (unknown [9.10.239.105])
 by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Fri,  8 Dec 2023 15:19:50 +0000 (GMT)
From: Chalapathi V <chalapathi.v@linux.ibm.com>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, fbarrat@linux.ibm.com, npiggin@gmail.com,
 clg@kaod.org, calebs@us.ibm.com, chalapathi.v@ibm.com,
 chalapathi.v@linux.ibm.com, saif.abrar@linux.vnet.ibm.com
Subject: [PATCH v8 0/3] pnv N1 chiplet model
Date: Fri,  8 Dec 2023 09:19:44 -0600
Message-Id: <20231208151947.26951-1-chalapathi.v@linux.ibm.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 4ae30CiubUXvO6emVYrZECjq-0AP11j5
X-Proofpoint-ORIG-GUID: B7TRia1RA2fk2ptFK9z45GySGLITptkk
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-08_10,2023-12-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 mlxscore=0
 adultscore=0 bulkscore=0 clxscore=1015 lowpriorityscore=0 malwarescore=0
 spamscore=0 mlxlogscore=747 impostorscore=0 priorityscore=1501
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2312080125
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

Thank you for the review and suggestions on V7.

There are no major design/logic changes done in revision 8 from revision 7.
Addressed the minor comments.

The qom-tree looks like below.
(qemu) info qom-tree 
/machine (powernv10-machine)
  /chip[0] (power10_v2.0-pnv-chip)
    /n1-chiplet (pnv-N1-chiplet)
      /nest-pervasive-common (pnv-nest-chiplet-pervasive)
        /pervasive-control[0] (memory-region)
      /xscom-n1-chiplet-pb-scom-eq[0] (memory-region)
      /xscom-n1-chiplet-pb-scom-es[0] (memory-region)

Patches overview in V8.
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
 include/hw/ppc/pnv_n1_chiplet.h     |  32 +++++
 include/hw/ppc/pnv_nest_pervasive.h |  32 +++++
 include/hw/ppc/pnv_xscom.h          |   9 ++
 hw/ppc/pnv.c                        |  15 ++
 hw/ppc/pnv_n1_chiplet.c             | 173 +++++++++++++++++++++++
 hw/ppc/pnv_nest_pervasive.c         | 208 ++++++++++++++++++++++++++++
 hw/ppc/meson.build                  |   2 +
 8 files changed, 473 insertions(+)
 create mode 100644 include/hw/ppc/pnv_n1_chiplet.h
 create mode 100644 include/hw/ppc/pnv_nest_pervasive.h
 create mode 100644 hw/ppc/pnv_n1_chiplet.c
 create mode 100644 hw/ppc/pnv_nest_pervasive.c

-- 
2.31.1



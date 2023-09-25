Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 957F97ADDED
	for <lists+qemu-devel@lfdr.de>; Mon, 25 Sep 2023 19:46:10 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qkpdg-00034H-8I; Mon, 25 Sep 2023 13:44:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mglenn@mamboa4.aus.stglabs.ibm.com>)
 id 1qkpdZ-00033R-A6; Mon, 25 Sep 2023 13:44:50 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mglenn@mamboa4.aus.stglabs.ibm.com>)
 id 1qkpdX-0007zF-4L; Mon, 25 Sep 2023 13:44:49 -0400
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 38PFwZmf001189; Mon, 25 Sep 2023 17:44:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=vL58WR5n4SYbu4yv3d++Qo/xtoc57VBt4twz7u760Lo=;
 b=WGDT9Q4AbtJQ7PA9bmCW6MVo6SNiZLggP6bBSg29SjBoUrwlpHQmZEaWzidm2fpMWPKZ
 h5CPuLjB3p0LDKmP9VtopL3gUsl1UAvsVek6Ey5a/U8PIbhcEs8q+sQEUAkVCq58W3Hs
 7NgjXCHtSmjfEONrVTYZ7INghasFIwRrEEC+drGf0afQpxALGCdj1DWsZeNejkmwpJhg
 1cY2WELEcw11ggQakkyua8VoK5D3x/Ld/cWXf41Ed5SLho1v91LlTGv5fd5QruxsW3PX
 b0Ok9aclXo1KO9zzsk49CCqFGdWJ+57wfVtZ/xSXU7Gkcl+lmbfD5wrYxQ3PgMM/XaDN /w== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3tbbhexk9f-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 25 Sep 2023 17:44:23 +0000
Received: from m0353729.ppops.net (m0353729.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 38PHZH9k028458;
 Mon, 25 Sep 2023 17:44:22 GMT
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3tbbhexk98-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 25 Sep 2023 17:44:22 +0000
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 38PHO2up008185; Mon, 25 Sep 2023 17:44:21 GMT
Received: from smtprelay05.dal12v.mail.ibm.com ([172.16.1.7])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3taaqy4b2y-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 25 Sep 2023 17:44:21 +0000
Received: from smtpav02.wdc07v.mail.ibm.com (smtpav02.wdc07v.mail.ibm.com
 [10.39.53.229])
 by smtprelay05.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 38PHiKOP4981496
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 25 Sep 2023 17:44:20 GMT
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 6B82D5805B;
 Mon, 25 Sep 2023 17:44:20 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 5334858058;
 Mon, 25 Sep 2023 17:44:20 +0000 (GMT)
Received: from mamboa4.aus.stglabs.ibm.com (unknown [9.3.84.87])
 by smtpav02.wdc07v.mail.ibm.com (Postfix) with ESMTPS;
 Mon, 25 Sep 2023 17:44:20 +0000 (GMT)
Received: from mamboa4.aus.stglabs.ibm.com (localhost [127.0.0.1])
 by mamboa4.aus.stglabs.ibm.com (Postfix) with ESMTPS id 80CAD16A065F;
 Mon, 25 Sep 2023 12:44:19 -0500 (CDT)
Received: (from mglenn@localhost)
 by mamboa4.aus.stglabs.ibm.com (8.15.2/8.15.2/Submit) id 38PHiIQn618672;
 Mon, 25 Sep 2023 12:44:18 -0500
From: Glenn Miles <milesg@linux.vnet.ibm.com>
To: qemu-ppc@nongnu.org
Cc: Glenn Miles <milesg@linux.vnet.ibm.com>, qemu-devel@nongnu.org,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Nicholas Piggin <npiggin@gmail.com>,
 David Gibson <david@gibson.dropbear.id.au>
Subject: [PATCH v3 0/4] Add BHRB Facility Support
Date: Mon, 25 Sep 2023 12:43:47 -0500
Message-Id: <20230925174351.617891-1-milesg@linux.vnet.ibm.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: Y7it-zQN4oEGFtumU5SaR3thQZ-u6cq2
X-Proofpoint-ORIG-GUID: Mk_8TVbGH3N5sAkBwuumlOPqcSOPaG44
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-09-25_15,2023-09-25_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 malwarescore=0
 clxscore=1015 bulkscore=0 priorityscore=1501 adultscore=0 impostorscore=0
 mlxlogscore=321 spamscore=0 lowpriorityscore=0 mlxscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2309180000
 definitions=main-2309250137
Received-SPF: none client-ip=148.163.156.1;
 envelope-from=mglenn@mamboa4.aus.stglabs.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

This is a series of patches for adding support for the Branch History
Rolling Buffer (BHRB) facility.  This was added to the Power ISA
starting with version 2.07.  Changes were subsequently made in version
3.1 to limit BHRB recording to instructions run in problem state only
and to add a control bit to disable recording (MMCRA[BHRBRD]).

Version 3 of this series disables branch recording on P8 and P9 due
to a drop in performance caused by recording branches outside of
problem state.

Glenn Miles (4):
  target/ppc: Add new hflags to support BHRB
  target/ppc: Add recording of taken branches to BHRB
  target/ppc: Add clrbhrb and mfbhrbe instructions
  target/ppc: Add migration support for BHRB

 target/ppc/cpu.h                       |  24 ++++++
 target/ppc/cpu_init.c                  |  39 +++++++++-
 target/ppc/helper.h                    |   5 ++
 target/ppc/helper_regs.c               |  35 +++++++++
 target/ppc/insn32.decode               |   8 ++
 target/ppc/machine.c                   |  23 +++++-
 target/ppc/misc_helper.c               |  46 +++++++++++
 target/ppc/power8-pmu-regs.c.inc       |   5 ++
 target/ppc/power8-pmu.c                |  48 +++++++++++-
 target/ppc/power8-pmu.h                |  11 ++-
 target/ppc/spr_common.h                |   1 +
 target/ppc/translate.c                 | 101 +++++++++++++++++++++++--
 target/ppc/translate/bhrb-impl.c.inc   |  43 +++++++++++
 target/ppc/translate/branch-impl.c.inc |   2 +-
 14 files changed, 374 insertions(+), 17 deletions(-)
 create mode 100644 target/ppc/translate/bhrb-impl.c.inc

-- 
2.31.1



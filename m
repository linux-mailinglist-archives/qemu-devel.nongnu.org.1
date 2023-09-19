Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D46527A6F51
	for <lists+qemu-devel@lfdr.de>; Wed, 20 Sep 2023 01:16:47 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qijwM-0000Y5-Sg; Tue, 19 Sep 2023 19:15:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mglenn@mamboa4.aus.stglabs.ibm.com>)
 id 1qijwG-0000Qm-Vj; Tue, 19 Sep 2023 19:15:31 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mglenn@mamboa4.aus.stglabs.ibm.com>)
 id 1qijwE-0006HR-Dy; Tue, 19 Sep 2023 19:15:28 -0400
Received: from pps.filterd (m0353728.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 38JNCd0N029362; Tue, 19 Sep 2023 23:14:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=GbB8Bn13n5cjKkAAmb5n7iXuNlztbpEYuaxnzq9dF9E=;
 b=iB7IoLedLURCQm9tQC1Y1cuiF3rKmHOE/u3YBKgOkff2p2mLl/qrgD2wZXRYFI4xLTa6
 4tkh0FtchznvFcBTk+z+yDCiIihPmJogOdL2XFaS1DxxYPMb7AdElFghOJ+iWpQunrEK
 U2k5st//QtRcop4WRSwzGGZ9uV6tYFARR+wJ/mRr0vP7AJSrvSDe224sb2Zt+Dr1TBIp
 lEbJRDJJleSgCg/aLfiQSvhqLaaOX5hzpGCF6f7w7BOiXiwy9hemNccrONhYjS5kA901
 jd/susUbelneRWGxS+UaAluC90gbj7zm9MuaIkVvR9kRnV3evJt/ZiJJHZTG4KpkUKjU YA== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3t7n3vg18n-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 19 Sep 2023 23:14:56 +0000
Received: from m0353728.ppops.net (m0353728.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 38JNCZ74029258;
 Tue, 19 Sep 2023 23:14:55 GMT
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3t7n3vg18f-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 19 Sep 2023 23:14:55 +0000
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 38JLPkHG018144; Tue, 19 Sep 2023 23:14:54 GMT
Received: from smtprelay06.dal12v.mail.ibm.com ([172.16.1.8])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 3t5ppss86b-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 19 Sep 2023 23:14:54 +0000
Received: from smtpav02.wdc07v.mail.ibm.com (smtpav02.wdc07v.mail.ibm.com
 [10.39.53.229])
 by smtprelay06.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 38JMUYHa46465478
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 19 Sep 2023 22:30:37 GMT
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 4474E58098;
 Tue, 19 Sep 2023 22:30:34 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 2D84C58097;
 Tue, 19 Sep 2023 22:30:34 +0000 (GMT)
Received: from mamboa4.aus.stglabs.ibm.com (unknown [9.3.84.87])
 by smtpav02.wdc07v.mail.ibm.com (Postfix) with ESMTPS;
 Tue, 19 Sep 2023 22:30:34 +0000 (GMT)
Received: from mamboa4.aus.stglabs.ibm.com (localhost [127.0.0.1])
 by mamboa4.aus.stglabs.ibm.com (Postfix) with ESMTPS id 5761B16A05D9;
 Tue, 19 Sep 2023 17:30:33 -0500 (CDT)
Received: (from mglenn@localhost)
 by mamboa4.aus.stglabs.ibm.com (8.15.2/8.15.2/Submit) id 38JMUX9n3442570;
 Tue, 19 Sep 2023 17:30:33 -0500
From: Glenn Miles <milesg@linux.vnet.ibm.com>
To: qemu-ppc@nongnu.org
Cc: Glenn Miles <milesg@linux.vnet.ibm.com>, qemu-devel@nongnu.org,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Nicholas Piggin <npiggin@gmail.com>,
 David Gibson <david@gibson.dropbear.id.au>
Subject: [PATCH v2 0/4] Add BHRB Facility Support
Date: Tue, 19 Sep 2023 17:30:01 -0500
Message-Id: <20230919223005.3441713-1-milesg@linux.vnet.ibm.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: Pu7imP5jok4OprF97_eOf3WYzfAFtDd3
X-Proofpoint-GUID: N1dZ9kDc_xf6X3F0gLTpemEfU1ciIMeA
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-19_12,2023-09-19_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 clxscore=1015
 suspectscore=0 mlxlogscore=421 adultscore=0 phishscore=0 spamscore=0
 impostorscore=0 priorityscore=1501 mlxscore=0 bulkscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2308100000 definitions=main-2309190197
Received-SPF: none client-ip=148.163.156.1;
 envelope-from=mglenn@mamboa4.aus.stglabs.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=unavailable autolearn_force=no
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

Glenn Miles (4):
  target/ppc: Add new hflags to support BHRB
  target/ppc: Add recording of taken branches to BHRB
  target/ppc: Add clrbhrb and mfbhrbe instructions
  target/ppc: Add migration support for BHRB

 target/ppc/cpu.h                       |  24 ++++++
 target/ppc/cpu_init.c                  |  45 +++++++++--
 target/ppc/helper.h                    |   5 ++
 target/ppc/helper_regs.c               |  35 +++++++++
 target/ppc/insn32.decode               |   8 ++
 target/ppc/machine.c                   |  23 +++++-
 target/ppc/misc_helper.c               |  43 +++++++++++
 target/ppc/power8-pmu-regs.c.inc       |   5 ++
 target/ppc/power8-pmu.c                |  48 +++++++++++-
 target/ppc/power8-pmu.h                |  11 ++-
 target/ppc/spr_common.h                |   1 +
 target/ppc/translate.c                 | 101 +++++++++++++++++++++++--
 target/ppc/translate/bhrb-impl.c.inc   |  43 +++++++++++
 target/ppc/translate/branch-impl.c.inc |   2 +-
 14 files changed, 375 insertions(+), 19 deletions(-)
 create mode 100644 target/ppc/translate/bhrb-impl.c.inc

-- 
2.31.1



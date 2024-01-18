Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E34883125F
	for <lists+qemu-devel@lfdr.de>; Thu, 18 Jan 2024 06:27:21 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rQKth-0006HB-DH; Thu, 18 Jan 2024 00:25:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1rQKtf-0006GU-5o; Thu, 18 Jan 2024 00:24:59 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1rQKtc-00060p-ND; Thu, 18 Jan 2024 00:24:58 -0500
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 40I5FrdN011618; Thu, 18 Jan 2024 05:24:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=from : to : cc : subject
 : date : message-id : content-transfer-encoding : mime-version; s=pp1;
 bh=y/KReAbxxE7YqF2THy+Le9b0EVu4OOu/37T/iJribg0=;
 b=iCTzbxJm8B6QjaE+VO3w8wcrCgtmU2UxA9eMJv3Zdp8hpmgfs4cMjbKiIIfHIPgz2A0c
 ax/osxeOTh+pP2Um4O0sEw2gj1wGmm9TrrEOBtehbjOVUc2tioDDV0MHulDYXNJMEMkN
 QxYbvUz8qAZJ7wh6C/nX0sjfSut4ftBjCwAxzBXBHYVbuoCTIiYzSY2jQDOyh3+HT4ds
 JUjcbC9eAC3/jomesfkCYv81BERxHtPt8vuMnlG7BLQW/dMtmYLj3ndTYKNg5u5/VplC
 eCS+iMhv+Sn2eqrJRRaw3TMjhjHqLJQEBiBeUfNWzsjo5Vq7V1JLgf6lmoXqEQyasu89 7Q== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3vpwpbg8fk-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 18 Jan 2024 05:24:51 +0000
Received: from m0356516.ppops.net (m0356516.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 40I5GbX3013411;
 Thu, 18 Jan 2024 05:24:50 GMT
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3vpwpbg8ff-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 18 Jan 2024 05:24:50 +0000
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 40I3LTpB011004; Thu, 18 Jan 2024 05:24:50 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3vm57ysq7v-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 18 Jan 2024 05:24:50 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com
 [10.20.54.102])
 by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 40I5Ol7V27329108
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 18 Jan 2024 05:24:47 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 08F0120043;
 Thu, 18 Jan 2024 05:24:47 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 67BAB20040;
 Thu, 18 Jan 2024 05:24:45 +0000 (GMT)
Received: from li-1901474c-32f3-11b2-a85c-fc5ff2c001f3.in.ibm.com (unknown
 [9.109.243.35]) by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Thu, 18 Jan 2024 05:24:45 +0000 (GMT)
From: Harsh Prateek Bora <harshpb@linux.ibm.com>
To: npiggin@gmail.com, qemu-ppc@nongnu.org
Cc: qemu-devel@nongnu.org, clegoate@redhat.com, mikey@neuling.org,
 amachhiw@linux.vnet.ibm.com, vaibhav@linux.ibm.com,
 sbhat@linux.ibm.com, danielhb413@gmail.com
Subject: [PATCH v3 00/15] Nested PAPR API (KVM on PowerVM)
Date: Thu, 18 Jan 2024 10:54:23 +0530
Message-Id: <20240118052438.1475437-1-harshpb@linux.ibm.com>
X-Mailer: git-send-email 2.39.3
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: IehPCys-Jhj37NSd0gcGAnUelz_tSn90
X-Proofpoint-ORIG-GUID: EEZTG_QNJEZH3n3n5Hnhf2pebKmBCQ-2
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-18_02,2024-01-17_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0
 suspectscore=0 priorityscore=1501 malwarescore=0 phishscore=0 mlxscore=0
 spamscore=0 bulkscore=0 mlxlogscore=914 clxscore=1015 adultscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2401180035
Received-SPF: pass client-ip=148.163.158.5; envelope-from=harshpb@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
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

There is an existing Nested-HV API to enable nested guests on powernv
machines. However, that is not supported on pseries/PowerVM LPARs.
This patch series implements required hcall interfaces to enable nested
guests with KVM on PowerVM.
Unlike Nested-HV, with this API, entire L2 state is retained by L0
during guest entry/exit and uses pre-defined Guest State Buffer (GSB)
format to communicate guest state between L1 and L2 via L0.

L0 here refers to the phyp/PowerVM, or launching a Qemu TCG L0 with the
newly introduced option cap-nested-papr=true.
L1 refers to the LPAR host on PowerVM or Linux booted on Qemu TCG with
above mentioned option cap-nested-papr=true.
L2 refers to nested guest running on top of L1 using KVM.
No SW changes needed for Qemu running in L1 Linux as well as L2 Kernel.

Linux Kernel side support is already merged upstream:
---
commit 19d31c5f115754c369c0995df47479c384757f82
Author: Jordan Niethe <jniethe5@gmail.com>
Date:   Thu Sep 14 13:05:59 2023 +1000

    KVM: PPC: Add support for nestedv2 guests
---
For more details, documentation can be referred in either of patch
series.

There are scripts available to assist in setting up an environment for
testing nested guests at https://github.com/iamjpn/kvm-powervm-test

A tree with this series is available at:
https://github.com/planetharsh/qemu/tree/upstream-0118-v3

Thanks to Michael Neuling, Shivaprasad Bhat, Amit Machhiwal, Kautuk Consul,
Vaibhav Jain and Jordan Niethe.

Changelog:

v3: Addressed review comments from Nick on v2 series.
v2: https://lore.kernel.org/qemu-devel/20231012104951.194876-1-harshpb@linux.ibm.com/
v1: https://lore.kernel.org/qemu-devel/20230906043333.448244-1-harshpb@linux.ibm.com/

Amit Machhiwal (1):
  spapr: nested: Set the PCR when logical PVR is set

Harsh Prateek Bora (14):
  spapr: nested: register nested-hv api hcalls only for cap-nested-hv
  spapr: nested: move nested part of spapr_get_pate into spapr_nested.c
  spapr: nested: Introduce SpaprMachineStateNested to store related
    info.
  spapr: nested: keep nested-hv related code restricted to its API.
  spapr: nested: Document Nested PAPR API
  spapr: nested: Introduce H_GUEST_[GET|SET]_CAPABILITIES hcalls.
  spapr: nested: Introduce H_GUEST_[CREATE|DELETE] hcalls.
  spapr: nested: Introduce H_GUEST_CREATE_VCPU hcall.
  spapr: nested: Extend nested_ppc_state for nested PAPR API
  spapr: nested: Initialize the GSB elements lookup table.
  spapr: nested: Introduce H_GUEST_[GET|SET]_STATE hcalls.
  spapr: nested: Use correct source for parttbl info for nested PAPR
    API.
  spapr: nested: Introduce H_GUEST_RUN_VCPU hcall.
  spapr: nested: Introduce cap-nested-papr for Nested PAPR API

 docs/devel/nested-papr.txt    |  500 +++++++++++
 include/hw/ppc/spapr.h        |   22 +-
 include/hw/ppc/spapr_nested.h |  431 +++++++++-
 target/ppc/cpu.h              |    4 +
 hw/ppc/ppc.c                  |   10 +
 hw/ppc/spapr.c                |   35 +-
 hw/ppc/spapr_caps.c           |   57 ++
 hw/ppc/spapr_hcall.c          |    2 -
 hw/ppc/spapr_nested.c         | 1527 ++++++++++++++++++++++++++++++++-
 9 files changed, 2533 insertions(+), 55 deletions(-)
 create mode 100644 docs/devel/nested-papr.txt

-- 
2.39.3



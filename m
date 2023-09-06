Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id EDF107934E3
	for <lists+qemu-devel@lfdr.de>; Wed,  6 Sep 2023 07:32:23 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qdl8C-0002fJ-09; Wed, 06 Sep 2023 01:31:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1qdl88-0002eq-Pg; Wed, 06 Sep 2023 01:31:08 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1qdl84-0006B3-2c; Wed, 06 Sep 2023 01:31:08 -0400
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 3865QKAj008961; Wed, 6 Sep 2023 05:30:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=from : to : cc : subject
 : date : message-id : content-transfer-encoding : mime-version; s=pp1;
 bh=sRcEnPxr4v/9AaaBdiWUHpayxX77nn1+JtvnsbIonrc=;
 b=IvJnxIGihztxjkvMsDrVm4WAi6PRPLgxCdkbtOclFUumfEwqc1p69PMbDJDiZdvnV4IK
 F/dS/pt2mADGrz6hu+TBpg0RPuRR+kawyXYGOzt82mj3xnw8nhFQYme77KKxkjLk13nz
 kLBbiFqjbD7FjoJJdHsKxOnVyMHlqd5ttC+/9c2iLiWOX2/kwdzwf/BHKLzP29i7nZEq
 WasEgvFIvfeBc1TRi2YutNSGOScVHoGR4gdJ9QAA5hIWfvTRTWi8CXDjhzArozB1WopU
 7zzpJ5EbKakw0/tMIvD0EuL/VWX6anYhxWvo4/1W/LwFURH2CzB5604xu5ACwO4glzsp eg== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3sxk9a02we-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 06 Sep 2023 05:30:59 +0000
Received: from m0360072.ppops.net (m0360072.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 3865U7dO020753;
 Wed, 6 Sep 2023 05:30:58 GMT
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3sxk9a02tp-9
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 06 Sep 2023 05:30:58 +0000
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 3863N93R006651; Wed, 6 Sep 2023 04:33:47 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3svgvkg13t-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 06 Sep 2023 04:33:47 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com
 [10.20.54.102])
 by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 3864Xiwo18809408
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 6 Sep 2023 04:33:44 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 1069820040;
 Wed,  6 Sep 2023 04:33:44 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 2771D20043;
 Wed,  6 Sep 2023 04:33:42 +0000 (GMT)
Received: from li-1901474c-32f3-11b2-a85c-fc5ff2c001f3.in.ibm.com (unknown
 [9.109.242.129])
 by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Wed,  6 Sep 2023 04:33:41 +0000 (GMT)
From: Harsh Prateek Bora <harshpb@linux.ibm.com>
To: npiggin@gmail.com, danielhb413@gmail.com, qemu-ppc@nongnu.org
Cc: qemu-devel@nongnu.org, mikey@neuling.org, vaibhav@linux.ibm.com,
 jniethe5@gmail.com, sbhat@linux.ibm.com, kconsul@linux.vnet.ibm.com
Subject: [PATCH 00/15] Nested PAPR API (KVM on PowerVM)
Date: Wed,  6 Sep 2023 10:03:18 +0530
Message-Id: <20230906043333.448244-1-harshpb@linux.ibm.com>
X-Mailer: git-send-email 2.39.3
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: G717h7l2nxkTdJONzJKSkRA_xwVshLXZ
X-Proofpoint-GUID: 2e4-aBMDEDHQDRQTHdT4d_9j9tMX7l7W
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-05_13,2023-09-05_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 clxscore=1015
 priorityscore=1501 malwarescore=0 bulkscore=0 mlxlogscore=669 mlxscore=0
 phishscore=0 lowpriorityscore=0 spamscore=0 adultscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2308100000
 definitions=main-2309060045
Received-SPF: pass client-ip=148.163.158.5; envelope-from=harshpb@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
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

There is an existing Nested-HV API to enable nested guests on powernv
machines. However, that is not supported on pseries/PowerVM LPARs.
This patch series implements required hcall interfaces to enable nested
guests with KVM on PowerVM.
Unlike Nested-HV, with this API, entire L2 state is retained by L0
during guest entry/exit and uses pre-defined Guest State Buffer (GSB)
format to communicate guest state between L1 and L2 via L0.

L0 here refers to the phyp/PowerVM, or launching a Qemu TCG L0 with the
newly introduced option cap-nested-papr=true (refer patch 5/15).
L1 refers to the LPAR host on PowerVM or Linux booted on Qemu TCG with
above mentioned option cap-nested-papr=true.
L2 refers to nested guest running on top of L1 using KVM.
No SW changes needed for Qemu running in L1 Linux as well as L2 Kernel.

There is a Linux Kernel side patch series to enable support for Nested
PAPR in L1 and same can be found at below url:

Linux Kernel RFC PATCH v4:
- https://lore.kernel.org/linuxppc-dev/20230905034658.82835-1-jniethe5@gmail.com/

For more details, documentation can be referred in either of patch
series.

There are scripts available to assist in setting up an environment for
testing nested guests at https://github.com/mikey/kvm-powervm-test

Thanks to Michael Neuling, Shivaprasad Bhat, Kautuk Consul, Vaibhav Jain
and Jordan Niethe.

PS: This is a resend of patch series after rebasing to upstream master.

Harsh Prateek Bora (15):
  ppc: spapr: Introduce Nested PAPR API related macros
  ppc: spapr: Add new/extend structs to support Nested PAPR API
  ppc: spapr: Use SpaprMachineStateNested's ptcr instead of nested_ptcr
  ppc: spapr: Start using nested.api for nested kvm-hv api
  ppc: spapr: Introduce cap-nested-papr for nested PAPR API
  ppc: spapr: Implement nested PAPR hcall - H_GUEST_GET_CAPABILITIES
  ppc: spapr: Implement nested PAPR hcall - H_GUEST_SET_CAPABILITIES
  ppc: spapr: Implement nested PAPR hcall - H_GUEST_CREATE
  ppc: spapr: Implement nested PAPR hcall - H_GUEST_CREATE_VCPU
  ppc: spapr: Initialize the GSB Elements lookup table.
  ppc: spapr: Implement nested PAPR hcall - H_GUEST_[GET|SET]_STATE
  ppc: spapr: Use correct source for parttbl info for nested PAPR API.
  ppc: spapr: Implement nested PAPR hcall - H_GUEST_RUN_VCPU
  ppc: spapr: Implement nested PAPR hcall - H_GUEST_DELETE
  ppc: spapr: Document Nested PAPR API

 docs/devel/nested-papr.txt      |  500 ++++++++++
 hw/ppc/spapr.c                  |   28 +-
 hw/ppc/spapr_caps.c             |   50 +
 hw/ppc/spapr_hcall.c            |    1 +
 hw/ppc/spapr_nested.c           | 1504 +++++++++++++++++++++++++++++--
 include/hw/ppc/ppc.h            |    2 +
 include/hw/ppc/spapr.h          |   35 +-
 include/hw/ppc/spapr_cpu_core.h |    7 +-
 include/hw/ppc/spapr_nested.h   |  378 ++++++++
 target/ppc/cpu.h                |    2 +
 10 files changed, 2433 insertions(+), 74 deletions(-)
 create mode 100644 docs/devel/nested-papr.txt

-- 
2.39.3



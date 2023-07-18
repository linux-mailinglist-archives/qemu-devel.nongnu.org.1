Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B6977577D6
	for <lists+qemu-devel@lfdr.de>; Tue, 18 Jul 2023 11:24:47 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qLgur-000681-Sy; Tue, 18 Jul 2023 05:22:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1qLguo-00065R-Sw; Tue, 18 Jul 2023 05:22:42 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1qLgul-0000pw-AK; Tue, 18 Jul 2023 05:22:42 -0400
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 36I96dmd009958; Tue, 18 Jul 2023 09:22:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=from : to : cc : subject
 : date : message-id : content-transfer-encoding : mime-version; s=pp1;
 bh=Xa4ejTs5kL6w6G20JZkqXGuJARUaZk0EvMoL8O++QtI=;
 b=RV9wpCWaZfQxkzNC6rp1UPdR88jIKkZRJXOfGz9AK8lrJVdPbb34hsMkmf2etF/zCBkB
 vVx8GDBIyKuq58p94pbdpint8yUq4zdeRKpjOJ7AnIZjQfsHsDta/h5kLu6Br9yp+btf
 /tVKR9D6fycfNwhZHSGulExj0LtT3j6UIRDBNqnWRQeCfKeDY0rjBoGS78y9FU9lvpJh
 XDwqJgebE2Orz51xkbYrmHaNZ4zFQAtqGxY7pydD19wxJ8KmHIJIc8lO+O5TkN07Ae/X
 zeWRM69kzCdjUHAefEOs9BAER9K1x3QDkBbf6xenac0KnLuRwyNGO32kn83QsKD7zCr7 RA== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3rwqf4s45y-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 18 Jul 2023 09:22:31 +0000
Received: from m0356517.ppops.net (m0356517.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 36I97WSZ015948;
 Tue, 18 Jul 2023 09:22:31 GMT
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3rwqf4s45k-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 18 Jul 2023 09:22:31 +0000
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 36I4Ao75031282; Tue, 18 Jul 2023 09:22:30 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3rv79jjat3-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 18 Jul 2023 09:22:29 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com
 [10.20.54.103])
 by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 36I9MQRg25363146
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 18 Jul 2023 09:22:26 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id A76BA20040;
 Tue, 18 Jul 2023 09:22:26 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 7D5E120063;
 Tue, 18 Jul 2023 09:22:24 +0000 (GMT)
Received: from li-1901474c-32f3-11b2-a85c-fc5ff2c001f3.in.ibm.com (unknown
 [9.109.242.129])
 by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Tue, 18 Jul 2023 09:22:24 +0000 (GMT)
From: Harsh Prateek Bora <harshpb@linux.ibm.com>
To: qemu-ppc@nongnu.org, qemu-devel@nongnu.org
Cc: mikey@neuling.org, vaibhav@linux.ibm.com, jniethe5@gmail.com,
 sbhat@linux.ibm.com, kconsul@linux.vnet.ibm.com,
 dbarboza@ventanamicro.com, npiggin@gmail.com
Subject: [PATCH 00/15] Nested PAPR API (KVM on PowerVM)
Date: Tue, 18 Jul 2023 14:52:06 +0530
Message-Id: <20230718092221.1053686-1-harshpb@linux.ibm.com>
X-Mailer: git-send-email 2.39.3
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: k8QcZkUEmw2c40OgxejNFq7HmF1DN4SB
X-Proofpoint-ORIG-GUID: vqZ9haCZC2Q6YhILbuEQE5-X3fpRQBGE
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-17_15,2023-07-13_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 mlxlogscore=749
 lowpriorityscore=0 phishscore=0 mlxscore=0 suspectscore=0 bulkscore=0
 impostorscore=0 spamscore=0 priorityscore=1501 clxscore=1011
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2307180082
Received-SPF: pass client-ip=148.163.156.1; envelope-from=harshpb@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_MSPIKE_H5=0.001,
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
newly introduced option cap-nested-papr=true (refer patch 5/15).
L1 refers to the LPAR host on PowerVM or Linux booted on Qemu TCG with
above mentioned option cap-nested-papr=true.
L2 refers to nested guest running on top of L1 using KVM.
No SW changes needed for Qemu running in L1 Linux as well as L2 Kernel.

There is a Linux Kernel side patch series to enable support for Nested
PAPR in L1 and same can be found at below url:

Linux Kernel RFC PATCH v2:
- https://lore.kernel.org/linuxppc-dev/20230605064848.12319-1-jpn@linux.vnet.ibm.com/

For more details, documentation can be referred in either of patch series.

There are scripts available to assist in setting up an environment for
testing nested guests at https://github.com/mikey/kvm-powervm-test

Thanks to Michael Neuling, Shivaprasad Bhat, Kautuk Consul, Vaibhav Jain
and Jordan Niethe.

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



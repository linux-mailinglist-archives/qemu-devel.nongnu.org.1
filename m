Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F66C7C6B8F
	for <lists+qemu-devel@lfdr.de>; Thu, 12 Oct 2023 12:52:58 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qqtGn-0000wJ-SS; Thu, 12 Oct 2023 06:50:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1qqtGm-0000tP-0q; Thu, 12 Oct 2023 06:50:20 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1qqtGf-0004tF-JQ; Thu, 12 Oct 2023 06:50:19 -0400
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 39CAlPCA007453; Thu, 12 Oct 2023 10:50:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=from : to : cc : subject
 : date : message-id : content-transfer-encoding : mime-version; s=pp1;
 bh=i8zGGpREGRw1iF9MWRLll0W7YX2fowYkfQX/voF/hZI=;
 b=mhLNdvhUDapG30s6EiN89uaKTRUZsZWiO+HJsvyQLN11pzrF7q2w0VMvKPph6JAXptwD
 TNeHWH17LERnmqq0OSTrpzPg0ZfYqLuljR/Sfm2Rs8Y7K8ot+i3oxTNS0khd6IPoL/fx
 MUJs2Y+Tlc5a2/03e3Up1PZA7Y4Min5By3mTYZrtpvkMk/kv78M5W7VuInHf5cf59Y4x
 6U7Ls1/bucaSvLE9OwgBdliTPTSjNpO0y3uG5o3MHJPvfN6I3855CHQIvgMKR4y9Gnra
 JsN/7wIIkEz/MkklEjmqoWE1Qc4HABevpzrL5Ss9n49dYi0x/wO4ffRlzYAhJH973iPD Uw== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3tpfbr029x-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 12 Oct 2023 10:50:06 +0000
Received: from m0356517.ppops.net (m0356517.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 39CAlrPj008904;
 Thu, 12 Oct 2023 10:50:05 GMT
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3tpfbr029k-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 12 Oct 2023 10:50:05 +0000
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 39C8nUiD024465; Thu, 12 Oct 2023 10:50:04 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 3tkhnsy8wn-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 12 Oct 2023 10:50:04 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com
 [10.20.54.106])
 by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 39CAo1Ua53936520
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 12 Oct 2023 10:50:01 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id B20AD20040;
 Thu, 12 Oct 2023 10:50:01 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id CD35420043;
 Thu, 12 Oct 2023 10:49:59 +0000 (GMT)
Received: from li-1901474c-32f3-11b2-a85c-fc5ff2c001f3.in.ibm.com (unknown
 [9.109.242.129])
 by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Thu, 12 Oct 2023 10:49:59 +0000 (GMT)
From: Harsh Prateek Bora <harshpb@linux.ibm.com>
To: npiggin@gmail.com, qemu-ppc@nongnu.org
Cc: clegoate@redhat.com, qemu-devel@nongnu.org, mikey@neuling.org,
 vaibhav@linux.ibm.com, jniethe5@gmail.com, sbhat@linux.ibm.com,
 kconsul@linux.vnet.ibm.com, danielhb413@gmail.com
Subject: [PATCH v2 00/14] Nested PAPR API (KVM on PowerVM)
Date: Thu, 12 Oct 2023 16:19:37 +0530
Message-Id: <20231012104951.194876-1-harshpb@linux.ibm.com>
X-Mailer: git-send-email 2.39.3
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: VLqjuq0tdXn3qJRvCpEZg1wwL4hp0sW2
X-Proofpoint-GUID: SpEED1nMgOwlN9NMwCKxfHubdksD6oa9
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-12_05,2023-10-12_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 mlxlogscore=851
 malwarescore=0 priorityscore=1501 clxscore=1015 adultscore=0 mlxscore=0
 spamscore=0 impostorscore=0 phishscore=0 suspectscore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2309180000
 definitions=main-2310120088
Received-SPF: pass client-ip=148.163.156.1; envelope-from=harshpb@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_PASS=-0.001,
 T_SPF_HELO_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

There is a Linux Kernel side patch series to enable support for Nested
PAPR in L1 and same can be found at below url:

Linux Kernel patch series:
- https://lore.kernel.org/linuxppc-dev/20230914030600.16993-1-jniethe5@gmail.com/

For more details, documentation can be referred in either of patch
series.

There are scripts available to assist in setting up an environment for
testing nested guests at https://github.com/iamjpn/kvm-powervm-test

A tree with this series is available at:
https://github.com/planetharsh/qemu/tree/upstream-kop-1012

Thanks to Michael Neuling, Shivaprasad Bhat, Kautuk Consul, Vaibhav Jain
and Jordan Niethe.

Changelog:

v2:
    - Addressed review comments from Nick on v1 series.
v1:
    - https://lore.kernel.org/qemu-devel/20230906043333.448244-1-harshpb@linux.ibm.com/

Harsh Prateek Bora (14):
  spapr: nested:  move nested part of spapr_get_pate into spapr_nested.c
  spapr: nested: Introduce SpaprMachineStateNested to store related
    info.
  spapr: nested: Document Nested PAPR API
  spapr: nested: Introduce cap-nested-papr for Nested PAPR API
  spapr: nested: register nested-hv api hcalls only for cap-nested-hv
  spapr: nested: Introduce H_GUEST_[GET|SET]_CAPABILITIES hcalls.
  spapr: nested: Introduce H_GUEST_[CREATE|DELETE] hcalls.
  spapr: nested: Introduce H_GUEST_CREATE_VPCU hcall.
  spapr: nested: Initialize the GSB elements lookup table.
  spapr: nested: Introduce H_GUEST_[GET|SET]_STATE hcalls.
  spapr: nested: Use correct source for parttbl info for nested PAPR
    API.
  spapr: nested: rename nested_host_state to nested_hv_host
  spapr: nested: keep nested-hv exit code restricted to its API.
  spapr: nested: Introduce H_GUEST_RUN_VCPU hcall.

 docs/devel/nested-papr.txt      |  500 +++++++++++
 hw/ppc/spapr.c                  |   32 +-
 hw/ppc/spapr_caps.c             |   63 ++
 hw/ppc/spapr_hcall.c            |    2 -
 hw/ppc/spapr_nested.c           | 1439 ++++++++++++++++++++++++++++++-
 include/hw/ppc/spapr.h          |   21 +-
 include/hw/ppc/spapr_cpu_core.h |    7 +-
 include/hw/ppc/spapr_nested.h   |  361 ++++++++
 target/ppc/cpu.h                |    2 +
 9 files changed, 2368 insertions(+), 59 deletions(-)
 create mode 100644 docs/devel/nested-papr.txt

-- 
2.39.3



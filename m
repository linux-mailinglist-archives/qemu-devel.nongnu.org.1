Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3627F7778CA
	for <lists+qemu-devel@lfdr.de>; Thu, 10 Aug 2023 14:48:44 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qU54d-0006Du-Fp; Thu, 10 Aug 2023 08:47:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <seiden@linux.ibm.com>)
 id 1qU54b-0006DU-9Q; Thu, 10 Aug 2023 08:47:29 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <seiden@linux.ibm.com>)
 id 1qU54Z-0005uK-CM; Thu, 10 Aug 2023 08:47:29 -0400
Received: from pps.filterd (m0353722.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 37ACSRuY022501; Thu, 10 Aug 2023 12:47:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=from : to : cc : subject
 : date : message-id : content-transfer-encoding : mime-version; s=pp1;
 bh=Gn7euiBPRO/fUQJSo4F9xFQ66TL17TJw74LMMvkGj5o=;
 b=LvuACisKfysHjVEkkV/PDLkniEoR/Xon/NApfjuXZwVy/+Tfq7REBlOtLONpRv0+Z9BQ
 rbvwU/LVl9xCMNQfly6EAKXwwChIS6HUuh+lrEgREd42Pp+kIODGIH2Cp59J/PYawyrB
 Qt0COiY8gw6nitAUBIdF6ORu4qcUWggP+BXehP7Vb6JI/cqWBvhOrF2MhBGvKJ/KE1Cm
 uvsv+ZFzvU9bAD2KuxGSSojodSgihli10ob+Bz1fOjSehR334ykMC3dAVaJDNIXlvpma
 FMExr4B9vgRiLPlzYjnm4MwP1WTAbEXu+MVcqzH7g+ifgWJCBzFnjoISWqpIZE+/OFur nA== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3scyx10s8s-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 10 Aug 2023 12:47:24 +0000
Received: from m0353722.ppops.net (m0353722.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 37ACSi8I023095;
 Thu, 10 Aug 2023 12:47:24 GMT
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3scyx10s8g-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 10 Aug 2023 12:47:24 +0000
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 37ACRDsM000376; Thu, 10 Aug 2023 12:47:23 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3sa28m1d2g-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 10 Aug 2023 12:47:23 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com
 [10.20.54.104])
 by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 37AClJWl393908
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 10 Aug 2023 12:47:19 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 85D8F20043;
 Thu, 10 Aug 2023 12:47:19 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 556362004B;
 Thu, 10 Aug 2023 12:47:19 +0000 (GMT)
Received: from a46lp73.lnxne.boe (unknown [9.152.108.100])
 by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Thu, 10 Aug 2023 12:47:19 +0000 (GMT)
From: Steffen Eiden <seiden@linux.ibm.com>
To: qemu-s390x@nongnu.org, qemu-devel@nongnu.org
Cc: Janosch Frank <frankja@linux.ibm.com>, Thomas Huth <thuth@redhat.com>,
 David Hildenbrand <david@redhat.com>,
 Michael Mueller <mimu@linux.vnet.ibm.com>,
 Marc Hartmayer <mhartmay@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>
Subject: [PATCH v2 0/3] KVM: s390: Enable AP instructions for pv-guests
Date: Thu, 10 Aug 2023 14:47:16 +0200
Message-Id: <20230810124719.2167260-1-seiden@linux.ibm.com>
X-Mailer: git-send-email 2.40.1
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: c_BYkxLI89Hgk_ELrwGqJ9wH9opgb_nD
X-Proofpoint-ORIG-GUID: PRvXyiNIY2iXHnW7neL9S43FKjBQC_4r
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-08-10_10,2023-08-10_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0
 lowpriorityscore=0 bulkscore=0 clxscore=1015 spamscore=0 suspectscore=0
 mlxlogscore=517 adultscore=0 impostorscore=0 mlxscore=0 priorityscore=1501
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2308100106
Received-SPF: pass client-ip=148.163.158.5; envelope-from=seiden@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_MSPIKE_H5=0.001,
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

This series enables general QEMU support for AP pass-through for Secure
Execution guests (pv-guests).

To enable AP-PT on pv-guests QEMU has to turn on the corresponding bits
in the KVM CPU-model[1] if the CPU firmware supports it. However, it
only makes sense to turn on AP-PT if the QEMU user enabled (general) AP
for that guest.

The series consists of three patches:
 1) update kvm-s390 header for this series
 2) small cleanup for kvm_s390_set_attr()
    refactor code to add ap_available() and ap_enabled()
 3) Add UV_CALL CPU model enablement

since v1:

- removed the new features from the default gen16 model
- updated KVM-headers to match KVM series v3 [1]
- applied review comments from Thomas

[1]
https://lore.kernel.org/linux-s390/20230810113255.2163043-1-seiden@linux.ibm.com/#t


Steffen

Steffen Eiden (3):
  linux-headers: update asm-s390/kvm.h
  target/s390x/kvm: Refactor AP functionalities
  target/s390x: AP-passthrough for PV guests

 linux-headers/asm-s390/kvm.h        | 16 +++++
 target/s390x/cpu_features.h         |  1 +
 target/s390x/cpu_features_def.h.inc |  4 ++
 target/s390x/cpu_models.c           |  2 +
 target/s390x/gen-features.c         |  2 +
 target/s390x/kvm/kvm.c              | 97 ++++++++++++++++++++++++++---
 6 files changed, 115 insertions(+), 7 deletions(-)

-- 
2.40.1



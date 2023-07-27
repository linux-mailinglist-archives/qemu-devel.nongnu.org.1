Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4664D765537
	for <lists+qemu-devel@lfdr.de>; Thu, 27 Jul 2023 15:36:54 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qP03u-00012p-4t; Thu, 27 Jul 2023 08:25:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <seiden@linux.ibm.com>)
 id 1qP03P-0000yI-D6; Thu, 27 Jul 2023 08:25:16 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <seiden@linux.ibm.com>)
 id 1qP03M-0001A0-FY; Thu, 27 Jul 2023 08:25:15 -0400
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 36RCBfIG012610; Thu, 27 Jul 2023 12:25:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=3BojF4OgtnPEuk5NGxbVfyR9zUrycECobcnOyYe9Rc0=;
 b=PNYtTSTfWOJ5IRJrAgAhesl5JBpj4WyHA4MshlvsWycIDwzOjxFyoKiNxVthPK3cQ2HF
 865Tp7wysqcVm2Vd5W6QTuLLL8boT4sELffkETSPSl6S0a6N5mrT+57APiN14hkAbKz2
 wDqvKR5VNhuFdDdVGH1T1I1hanFHH4+Zxc2gKdII7NC/wXtJZ7XwrIADTcKNcYPSV8Qy
 4sC0gW9an1BuUEEv5qnZPvpP/IgbDOOTAcqDV+hQfkOqJOsIHVmSBieE2675R/eTDs5Z
 QqEnXYEeIOFgcKtWx+0f4XyAYhr9HxkjD8GSA+Rl7j6u+fivu5nJ4jMvIfgoAmWNFmV7 5g== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3s3rcd0d19-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 27 Jul 2023 12:25:08 +0000
Received: from m0353729.ppops.net (m0353729.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 36RCCXqC014211;
 Thu, 27 Jul 2023 12:25:08 GMT
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3s3rcd0d0r-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 27 Jul 2023 12:25:07 +0000
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 36RAAIcF016610; Thu, 27 Jul 2023 12:25:07 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 3s0v51mvy5-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 27 Jul 2023 12:25:06 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com
 [10.20.54.101])
 by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 36RCP4Oj16253612
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 27 Jul 2023 12:25:04 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 074FE20043;
 Thu, 27 Jul 2023 12:25:04 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id C319E20040;
 Thu, 27 Jul 2023 12:25:03 +0000 (GMT)
Received: from a46lp73.lnxne.boe (unknown [9.152.108.100])
 by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Thu, 27 Jul 2023 12:25:03 +0000 (GMT)
From: Steffen Eiden <seiden@linux.ibm.com>
To: qemu-s390x@nongnu.org, qemu-devel@nongnu.org
Cc: Janosch Frank <frankja@linux.ibm.com>, Thomas Huth <thuth@redhat.com>,
 David Hildenbrand <david@redhat.com>,
 Michael Mueller <mimu@linux.vnet.ibm.com>,
 Marc Hartmayer <mhartmay@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>
Subject: [PATCH 0/3] KVM: s390: Enable AP instructions for pv-guests
Date: Thu, 27 Jul 2023 14:25:00 +0200
Message-Id: <20230727122503.775084-1-seiden@linux.ibm.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: Zb0p4YpBeUahp9MP4ao_j3F1M6IMZbK1
X-Proofpoint-ORIG-GUID: aZMj-4LSfUzHoPMgUsWaCiYKWuqtjSgG
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-27_06,2023-07-26_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxlogscore=455 spamscore=0
 mlxscore=0 phishscore=0 clxscore=1011 malwarescore=0 bulkscore=0
 adultscore=0 suspectscore=0 priorityscore=1501 impostorscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2307270108
Received-SPF: pass client-ip=148.163.156.1; envelope-from=seiden@linux.ibm.com;
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

This series enables general QEMU support for AP pass-through for Secure
Execution guests (pv-guests).

To enable AP-PT on pv-guests QEMU has to turn on the corresponding bits
in the KVM CPU-model[1] if the CPU firmware supports it. However, it
only makes sense to turn on AP-PT if the QEMU user enabled (general) AP
for that guest. If AP is turned on (ap=on) QEMU also turns on AP-PT for
secure execution guests(appv=on) if the CPU supports it.

The series consists of three patches:
 1) update kvm-s390 header for this series
 2) small cleanup for kvm_s390_set_attr()
    refactor code to add ap_available()
 3) Add UV_CALL CPU model enablement

There is **one** problem with the current implementation:
If the user does not enable AP in the cpu model QEMU produces the
following warning:
```
qemu-system-s390x: warning: 'appv' requires 'ap'.
```

During `check_consistency()` the model has appv=on and ap=offi, hence
the warning. However, appv is not turned on during the model
realization, as the code checks for AP in beforehand.

appv is in the default z16 model so that it is automatically enabled if
ap=on was specified.

I did not find a concept of dynamic defaults to model this behavior
(ap=on -> appv=on -> appvi=on). So I hope someone on the list can help
me and give some pointers on how to implement that.


Steffen


Steffen Eiden (3):
  linux-headers: update asm-s390/kvm.h
  target/s390x: refractor AP functionalities
  target/s390x: AP-passthrough for PV guests

 linux-headers/asm-s390/kvm.h        | 21 +++++++
 target/s390x/cpu_features.h         |  1 +
 target/s390x/cpu_features_def.h.inc |  4 ++
 target/s390x/cpu_models.c           |  2 +
 target/s390x/gen-features.c         |  4 ++
 target/s390x/kvm/kvm.c              | 91 ++++++++++++++++++++++++++---
 6 files changed, 116 insertions(+), 7 deletions(-)

-- 
2.40.1



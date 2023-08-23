Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id EADE6785A54
	for <lists+qemu-devel@lfdr.de>; Wed, 23 Aug 2023 16:23:31 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qYokm-00078v-R1; Wed, 23 Aug 2023 10:22:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <seiden@linux.ibm.com>)
 id 1qYokg-00077N-ES; Wed, 23 Aug 2023 10:22:30 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <seiden@linux.ibm.com>)
 id 1qYoke-0001Ty-G6; Wed, 23 Aug 2023 10:22:30 -0400
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 37NE2Ah9007855; Wed, 23 Aug 2023 14:22:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=from : to : cc : subject
 : date : message-id : content-transfer-encoding : mime-version; s=pp1;
 bh=q3KGJ1KXBTXIwlIegJ1Fo3epuA2BBKWyAFOWRGDcV7c=;
 b=men1Ued3vX/gZXKStRwHYGdwtR8TAFy/4PqIoljLEPv6EoahoneVRj/DCq53Rw4t9wXi
 Fww0AEibc/8bKlmu9oDmTnw0VNd5zbrpkXZQeax6Q8iaPDxk6aLvkcKbVX2TGuT5pbnF
 U7AOgji8crw5F+Tif9VjAYNOGFJjNmmSJ4MD7oC5+p4C1u1XLa45XUi2Fan2SYwx27Ui
 6uRUovxmgCB4zyTMAR5MGGFfHYK+uUG2HTnTyd8ZvTzY7sVoHdR6SmByvjBzrhC1Pef7
 JGi1yuE/8orvidHYRjcuz9HvB//fcLDWg3e616gKp4DLAsnD+SD1CHq/a8afpiouOlOz lg== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3snkh5gs6e-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 23 Aug 2023 14:22:24 +0000
Received: from m0360083.ppops.net (m0360083.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 37NEM17H026403;
 Wed, 23 Aug 2023 14:22:23 GMT
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3snkh5gs5c-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 23 Aug 2023 14:22:23 +0000
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 37NC974I018278; Wed, 23 Aug 2023 14:22:22 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 3sn21sexum-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 23 Aug 2023 14:22:22 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com
 [10.20.54.105])
 by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 37NEMJlc16974390
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 23 Aug 2023 14:22:20 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id D50DF2006C;
 Wed, 23 Aug 2023 14:22:19 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 7B11920065;
 Wed, 23 Aug 2023 14:22:19 +0000 (GMT)
Received: from a46lp73.lnxne.boe (unknown [9.152.108.100])
 by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Wed, 23 Aug 2023 14:22:19 +0000 (GMT)
From: Steffen Eiden <seiden@linux.ibm.com>
To: qemu-s390x@nongnu.org, qemu-devel@nongnu.org
Cc: Janosch Frank <frankja@linux.ibm.com>, Thomas Huth <thuth@redhat.com>,
 David Hildenbrand <david@redhat.com>, Michael Mueller <mimu@linux.ibm.com>,
 Marc Hartmayer <mhartmay@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>
Subject: [PATCH v4 0/5] s390: Enable AP instructions for pv-guests
Date: Wed, 23 Aug 2023 16:22:14 +0200
Message-ID: <20230823142219.1046522-1-seiden@linux.ibm.com>
X-Mailer: git-send-email 2.41.0
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: mX7P5V3DefELnpHspkMlrJ4uzLzOf2pc
X-Proofpoint-GUID: y8oYNDfh4D9k-caACJAQvZNyfXuJftNV
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-08-23_09,2023-08-22_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0
 lowpriorityscore=0 malwarescore=0 suspectscore=0 phishscore=0
 priorityscore=1501 mlxscore=0 impostorscore=0 spamscore=0 clxscore=1015
 mlxlogscore=632 bulkscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2308100000 definitions=main-2308230128
Received-SPF: pass client-ip=148.163.156.1; envelope-from=seiden@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
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

See: https://lore.kernel.org/linux-s390/c29750cc-fc64-2805-f583-c7be247de02e@linux.ibm.com/T/#t

The series consists of five patches:
 1/2) fixes from Janosch for AP handling
 3) update kvm-s390 header for this series (NOTFORMERGE)
 4) small cleanup for kvm_s390_set_attr()
    refactor code to add ap_available() and ap_enabled()
 5) Add UV_CALL CPU model enablement

since v3:
  - nitfixes (Thomas)
  - r-b from Michael&Thomas

since v2:
  - add fixes for AP from Janosch
  - rename *UV_CALL* to UV_FEAT_GUEST (Janosch)
  - early return on some functions (Janosch)
  - add r-b from Michael (Patch 4)
  - mark linux header update as NOTFORMERGE

since v1:

- removed the new features from the default gen16 model
- updated KVM-headers to match KVM series v3 [1]
- applied review comments from Thomas


Steffen

Janosch Frank (2):
  s390x/ap: fix missing subsystem reset registration
  s390x: switch pv and subsystem reset ordering on reboot

Steffen Eiden (3):
  NOTFORMERGE update linux-headers/asm-s390/kvm.h
  target/s390x/kvm: Refactor AP functionalities
  target/s390x: AP-passthrough for PV guests

 hw/s390x/s390-virtio-ccw.c          |  7 ++-
 linux-headers/asm-s390/kvm.h        | 16 +++++
 target/s390x/cpu_features.h         |  1 +
 target/s390x/cpu_features_def.h.inc |  4 ++
 target/s390x/cpu_models.c           |  2 +
 target/s390x/gen-features.c         |  2 +
 target/s390x/kvm/kvm.c              | 94 ++++++++++++++++++++++++++---
 7 files changed, 116 insertions(+), 10 deletions(-)

-- 
2.41.0



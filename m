Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E0F69780D9F
	for <lists+qemu-devel@lfdr.de>; Fri, 18 Aug 2023 16:12:12 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qX05c-0004p8-Df; Fri, 18 Aug 2023 10:04:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <seiden@linux.ibm.com>)
 id 1qWxS3-0001WB-DI; Fri, 18 Aug 2023 07:15:36 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <seiden@linux.ibm.com>)
 id 1qWxRx-0000Lk-Iz; Fri, 18 Aug 2023 07:15:33 -0400
Received: from pps.filterd (m0353724.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 37IBB20r024906; Fri, 18 Aug 2023 11:15:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=from : to : cc : subject
 : date : message-id : content-transfer-encoding : mime-version; s=pp1;
 bh=5/y2DTCdhEqYkkJimxkIaDFybDy5Ctj0jPa4DUMTkzw=;
 b=Fl21bCFWHYM5A50ACdy5e35HAZZBfbP0RhX5visDEUlz6RYgnwO2O5VjyytWp/OM+BZo
 dtUlnoBvnMqyujN4XRpa2GPDCSgqN9cuYLTaCPPxEE8+jj6RzHDMzEK/zJnWtlM3VUeQ
 FJEbTGem+/wibwUunP/8isg7xC9rDBrtE/Ag7eoDtVxrnwyKbuYmyNO1V4h0DXmVaxD8
 weTBCe3eIX4J33jBqT+l5q5+/SItxUzvnL23WPTksdxdt/Q8SOzKVzc+xCe+YDgCx0aY
 jU6xVf3RrLPEsq3b0ckFyw25lyH13JckDB7oJEkKeXrA52FZpiAn7HaHEYAs4L21+DX2 Qw== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3sj79r0a3w-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 18 Aug 2023 11:15:25 +0000
Received: from m0353724.ppops.net (m0353724.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 37IBDFxZ029495;
 Fri, 18 Aug 2023 11:15:24 GMT
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3sj79r0a3n-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 18 Aug 2023 11:15:24 +0000
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 37IB53oj002409; Fri, 18 Aug 2023 11:15:24 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3sendnxg3q-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 18 Aug 2023 11:15:24 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com
 [10.20.54.100])
 by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 37IBFKhU3932842
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 18 Aug 2023 11:15:21 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id DF8652006E;
 Fri, 18 Aug 2023 11:15:20 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id B00732006A;
 Fri, 18 Aug 2023 11:15:20 +0000 (GMT)
Received: from a46lp73.lnxne.boe (unknown [9.152.108.100])
 by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Fri, 18 Aug 2023 11:15:20 +0000 (GMT)
From: Steffen Eiden <seiden@linux.ibm.com>
To: qemu-s390x@nongnu.org, qemu-devel@nongnu.org
Cc: Janosch Frank <frankja@linux.ibm.com>, Thomas Huth <thuth@redhat.com>,
 David Hildenbrand <david@redhat.com>,
 Michael Mueller <mimu@linux.vnet.ibm.com>,
 Marc Hartmayer <mhartmay@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>
Subject: [PATCH v3 0/5] s390: Enable AP instructions for pv-guests
Date: Fri, 18 Aug 2023 13:15:15 +0200
Message-ID: <20230818111520.698615-1-seiden@linux.ibm.com>
X-Mailer: git-send-email 2.41.0
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: Pu0xNXEnu02jM2MrfWzsKiRzXUZDoQj-
X-Proofpoint-GUID: nm8j7l8_rEsAAKvTMGv1iy69hmUaDZWy
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-08-18_13,2023-08-18_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 mlxscore=0
 phishscore=0 spamscore=0 malwarescore=0 mlxlogscore=628 clxscore=1011
 lowpriorityscore=0 impostorscore=0 adultscore=0 suspectscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2306200000
 definitions=main-2308180102
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

See: https://lore.kernel.org/linux-s390/c29750cc-fc64-2805-f583-c7be247de02e@linux.ibm.com/T/#t

The series consists of five patches:
 1/2) fixes from Janosch for AP handling
 3) update kvm-s390 header for this series (NOTFORMERGE)
 4) small cleanup for kvm_s390_set_attr()
    refactor code to add ap_available() and ap_enabled()
 5) Add UV_CALL CPU model enablement

since v2:
  - add fixes for AP from Janosch
  - rename *UV_CALL* to UV_FEAT_GUEST (Janosch)
  - early return on some functions (Janosch)
  - add r-p from Michael (Patch 4)
  - mark linux header update as NOTFORMERGE

since v1:

- removed the new features from the default gen16 model
- updated KVM-headers to match KVM series v3 [1]
- applied review comments from Thomas


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
 target/s390x/kvm/kvm.c              | 95 ++++++++++++++++++++++++++---
 7 files changed, 117 insertions(+), 10 deletions(-)

-- 
2.41.0



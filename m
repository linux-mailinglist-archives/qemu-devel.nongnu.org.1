Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 92FBD720411
	for <lists+qemu-devel@lfdr.de>; Fri,  2 Jun 2023 16:12:59 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q55VT-0003zx-BH; Fri, 02 Jun 2023 10:11:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akrowiak@linux.ibm.com>)
 id 1q55VQ-0003zC-Kx; Fri, 02 Jun 2023 10:11:52 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akrowiak@linux.ibm.com>)
 id 1q55VB-0006V1-3E; Fri, 02 Jun 2023 10:11:52 -0400
Received: from pps.filterd (m0353722.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 352EAXLM027870; Fri, 2 Jun 2023 14:11:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=from : to : cc : subject
 : date : message-id : content-transfer-encoding : mime-version; s=pp1;
 bh=TsujauogsLgmMU/SXFwIe2yRDuyNUEOO7jB2MMGbyXA=;
 b=SIU0oP4EcntWzjuKRyJtyfjlLc2gZD+EjfYRg3nx0qz8K1nYy0GbAdicVkRKsSKHrmOv
 CsZ+gFCMP38HUZSs3UuHPP5QdCSi/6XgSZffUZGLXZdMR1JUVZr9jy+ICvXBx7x1seTT
 9Ct36xQKSYiDcTXnJhD1yF5YR0//ENKn8NyUYuv3SDXogR1Cs6dhptlOKqZ3v/WkkplF
 DF3i8YdGeQCWUV+Lj5FHmKjHDnPqp2dZrverWosAzLXMRSPBbx/Ri3zE6v5ljOvaiTeI
 IQl/BqqIJY35rnIfLQHfNQj6IyG/L9qd2vKfnogwSKNFBlCuIxnEPr6YIvX/UxO3dzSF QA== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3qygq5j9a2-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 02 Jun 2023 14:11:33 +0000
Received: from m0353722.ppops.net (m0353722.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 352EBEmH030164;
 Fri, 2 Jun 2023 14:11:33 GMT
Received: from ppma01dal.us.ibm.com (83.d6.3fa9.ip4.static.sl-reverse.com
 [169.63.214.131])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3qygq5j99t-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 02 Jun 2023 14:11:33 +0000
Received: from pps.filterd (ppma01dal.us.ibm.com [127.0.0.1])
 by ppma01dal.us.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 352Blq8b019382;
 Fri, 2 Jun 2023 14:11:32 GMT
Received: from smtprelay06.dal12v.mail.ibm.com ([9.208.130.100])
 by ppma01dal.us.ibm.com (PPS) with ESMTPS id 3qu9g78f5x-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 02 Jun 2023 14:11:32 +0000
Received: from smtpav04.dal12v.mail.ibm.com (smtpav04.dal12v.mail.ibm.com
 [10.241.53.103])
 by smtprelay06.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 352EBVN41114854
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 2 Jun 2023 14:11:31 GMT
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 41E9258065;
 Fri,  2 Jun 2023 14:11:31 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 5E1C058052;
 Fri,  2 Jun 2023 14:11:30 +0000 (GMT)
Received: from li-2c1e724c-2c76-11b2-a85c-ae42eaf3cb3d.ibm.com.com (unknown
 [9.61.88.233]) by smtpav04.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Fri,  2 Jun 2023 14:11:30 +0000 (GMT)
From: Tony Krowiak <akrowiak@linux.ibm.com>
To: qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, mjrosato@linux.ibm.com, jjherne@linux.ibm.com,
 pasic@linux.ibm.com, fiuczy@linux.ibm.com, thuth@redhat.com,
 farman@linux.ibm.com, borntraeger@linux.ibm.com, clg@redhat.com,
 cohuck@redhat.com, Tony Krowiak <akrowiak@linux.ibm.com>
Subject: [PATCH v2 0/2] s390x/ap: fix hang when mdev attached to guest is
 removed
Date: Fri,  2 Jun 2023 10:11:23 -0400
Message-Id: <20230602141125.448833-1-akrowiak@linux.ibm.com>
X-Mailer: git-send-email 2.31.1
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: _jbYaQ9_mq0I8PYqTM0x0O-o_YXNPjNT
X-Proofpoint-ORIG-GUID: 4oBTGQAYVsHOL8YxKa376OBGpo-mlXF0
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-06-02_10,2023-06-02_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxscore=0 lowpriorityscore=0
 adultscore=0 spamscore=0 clxscore=1015 bulkscore=0 phishscore=0
 priorityscore=1501 malwarescore=0 suspectscore=0 impostorscore=0
 mlxlogscore=835 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2304280000 definitions=main-2306020106
Received-SPF: pass client-ip=148.163.158.5;
 envelope-from=akrowiak@linux.ibm.com; helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

When a user attempts to remove a vfio-ap mediated device attached to a
guest, the operation hangs until the mdev's fd is closed by the guest
(i.e., the guest is shut down). This patch series provides userspace 
(i.e., qemu) code to handle device unplug requests for AP. When notified
that the mdev is being removed, the handler will unplug the device, thus
avoiding the hang condition.

Link: https://lore.kernel.org/r/20230530223538.279198-4-akrowiak@linux.ibm.com

Tony Krowiak (2):
  linux-headers: Update with vfio_ap IRQ index mapping
  s390x/ap: Wire up the device request notifier interface

 hw/vfio/ap.c                                  | 113 ++++++++++++++++++
 include/standard-headers/linux/const.h        |   2 +-
 include/standard-headers/linux/virtio_blk.h   |  18 +--
 .../standard-headers/linux/virtio_config.h    |   6 +
 include/standard-headers/linux/virtio_net.h   |   1 +
 linux-headers/asm-arm64/kvm.h                 |  33 +++++
 linux-headers/asm-riscv/kvm.h                 |  53 +++++++-
 linux-headers/asm-riscv/unistd.h              |   9 ++
 linux-headers/asm-s390/unistd_32.h            |   1 +
 linux-headers/asm-s390/unistd_64.h            |   1 +
 linux-headers/asm-x86/kvm.h                   |   3 +
 linux-headers/linux/const.h                   |   2 +-
 linux-headers/linux/kvm.h                     |  12 +-
 linux-headers/linux/psp-sev.h                 |   7 ++
 linux-headers/linux/userfaultfd.h             |  17 ++-
 linux-headers/linux/vfio.h                    |   9 ++
 16 files changed, 271 insertions(+), 16 deletions(-)

-- 
2.31.1



Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DC06831F56
	for <lists+qemu-devel@lfdr.de>; Thu, 18 Jan 2024 19:53:24 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rQXUj-0005I3-MV; Thu, 18 Jan 2024 13:52:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjrosato@linux.ibm.com>)
 id 1rQXUh-0005HV-3R; Thu, 18 Jan 2024 13:52:03 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjrosato@linux.ibm.com>)
 id 1rQXUf-0004wg-27; Thu, 18 Jan 2024 13:52:02 -0500
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 40II2QXN008106; Thu, 18 Jan 2024 18:51:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=EBbi5kbiU1NjnP/oDSRj/3z2n3jBpbXaTvrydVwXnuo=;
 b=opP6ncP9tg5fQtR3LyXTmZ8Nr8V6+Gkh9odvgeRghXjtcnw1vxVfR9Q1s1SK4MJQp2/r
 sz59+9h6jeOFLnJ0cwh4Tzi/OGYSsnI3/lVOXjYQGICp7DrqrI3Z+I7oWIYHWKcBIYPa
 36UfhwRG060X9Qft2wtr8MglLZDJdNS9DdK3t4OPCDvxfbbB3KshoGl2K9kEtmJLMyh+
 WBHoLRj9Ql2Hy4l/rk23zsCBeIWVwiuNPYIkp+uHP4w1MMtXD39UWYfZhbuZse29kfvW
 MUpGYn9ElEQb7xffkqeRZudZB+uF4yLRbuJ2wO1a7+paTwVcaNzI1BwdtR/EIYK8VGjt kw== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3vq8wk19wv-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 18 Jan 2024 18:51:56 +0000
Received: from m0360083.ppops.net (m0360083.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 40IIA5Mq011836;
 Thu, 18 Jan 2024 18:51:55 GMT
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3vq8wk19wj-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 18 Jan 2024 18:51:55 +0000
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 40IHDSur005797; Thu, 18 Jan 2024 18:51:54 GMT
Received: from smtprelay04.dal12v.mail.ibm.com ([172.16.1.6])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3vm6bkw05x-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 18 Jan 2024 18:51:54 +0000
Received: from smtpav04.wdc07v.mail.ibm.com (smtpav04.wdc07v.mail.ibm.com
 [10.39.53.231])
 by smtprelay04.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 40IIpr6g20447972
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 18 Jan 2024 18:51:53 GMT
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 3489958045;
 Thu, 18 Jan 2024 18:51:53 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id CF71B58052;
 Thu, 18 Jan 2024 18:51:51 +0000 (GMT)
Received: from li-2311da4c-2e09-11b2-a85c-c003041e9174.ibm.com.com (unknown
 [9.61.163.245]) by smtpav04.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Thu, 18 Jan 2024 18:51:51 +0000 (GMT)
From: Matthew Rosato <mjrosato@linux.ibm.com>
To: qemu-s390x@nongnu.org
Cc: farman@linux.ibm.com, thuth@redhat.com, clg@redhat.com,
 frankja@linux.ibm.com, pasic@linux.ibm.com, borntraeger@linux.ibm.com,
 richard.henderson@linaro.org, david@redhat.com, iii@linux.ibm.com,
 qemu-devel@nongnu.org, qemu-stable@nongnu.org
Subject: [PATCH v2 0/3] s390x/pci: fix ISM reset
Date: Thu, 18 Jan 2024 13:51:48 -0500
Message-ID: <20240118185151.265329-1-mjrosato@linux.ibm.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: -Vx1utIR6MrjEzF2AolMAKccipreLQtZ
X-Proofpoint-ORIG-GUID: 69vKTSQPep1AWCilXgZXvsOFY_Emrh3M
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-18_08,2024-01-17_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 adultscore=0
 spamscore=0 clxscore=1011 priorityscore=1501 mlxlogscore=983 bulkscore=0
 mlxscore=0 lowpriorityscore=0 impostorscore=0 suspectscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2401180137
Received-SPF: pass client-ip=148.163.156.1;
 envelope-from=mjrosato@linux.ibm.com; helo=mx0a-001b2d01.pphosted.com
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

Commit ef1535901a0 (re-)introduced an issue where passthrough ISM devices
on s390x would enter an error state after reboot.  This was previously fixed
by 03451953c79e, using device reset callbacks, however the change in
ef1535901a0 effectively triggers a cold reset of the pci bus before the
device reset callbacks are triggered.

To resolve this, this series proposes to remove the use of the reset callback
for ISM cleanup and instead trigger ISM reset from subsystem_reset before 
triggering bus resets.  This has to happen before the bus resets because the
reset of s390-pcihost will trigger reset of the PCI bus followed by the
s390-pci bus, and the former will trigger vfio-pci reset / the aperture-wide
unmap that ISM gets upset about.
 
  /s390-pcihost (s390-pcihost)
    /pci.0 (PCI)
    /s390-pcibus.0 (s390-pcibus)
    
While fixing this, it was also noted that kernel warnings could be seen that
indicate a guest ISC reference count error.  That's because in some reset
cases we were not bothering to disable AIF, but would again re-enable it after
the reset (causing the reference count to grow erroneously).  This was a base
issue that went unnoticed because the kernel previously did not detect and
issue a warning for this scenario.


Changes for v2:
- Fold a typo fix from patch 2 into patch 1 where it belongs
- Add block comment re: timing of ISM reset
- Add review tags


Matthew Rosato (3):
  s390x/pci: avoid double enable/disable of aif
  s390x/pci: refresh fh before disabling aif
  s390x/pci: drive ISM reset from subsystem reset

 hw/s390x/s390-pci-bus.c         | 26 ++++++++++++++++---------
 hw/s390x/s390-pci-kvm.c         | 34 +++++++++++++++++++++++++++++++--
 hw/s390x/s390-virtio-ccw.c      |  8 ++++++++
 include/hw/s390x/s390-pci-bus.h |  2 ++
 4 files changed, 59 insertions(+), 11 deletions(-)

-- 
2.43.0



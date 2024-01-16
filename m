Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6ED3B82FCE8
	for <lists+qemu-devel@lfdr.de>; Tue, 16 Jan 2024 23:33:05 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rPryd-0005Q2-Sd; Tue, 16 Jan 2024 17:32:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjrosato@linux.ibm.com>)
 id 1rPryb-0005P3-85; Tue, 16 Jan 2024 17:32:09 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjrosato@linux.ibm.com>)
 id 1rPryZ-0007RA-80; Tue, 16 Jan 2024 17:32:08 -0500
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 40GMVQaG028915; Tue, 16 Jan 2024 22:32:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=7hP32Pya0PL3s5zSXfzM93wsmE0Ryo7Ob4FT4PUMXog=;
 b=E46Wd186knrhWAYZBZNqTwXaUytyhjGtVneN///sPesV2zKT1uync9eg49CPoFyUMQLg
 bhf4eHpTDSYurGFyMhvaRr6YEpraTbG/GVTFoDDyAaNHdsO/kfJnMdjnoy2H4emhS3uk
 4+y/B5rdi+ynyykfA9GVPOURFYBupAf048jkqPGbYZuGex1AdkWoSmRssoCQ7hSWoPKz
 +Hbp1uaPxCLChGFCLCobW3DhpbVVHwa8TEV1MV8OxoMtZFV5iB/MR8wvGyRx1aMgEDwJ
 p8/Xd5WepHYEuh56Bx6/PZCCTdwwXAoGdwJd7f02mCXh+j67DNcizx3ssR1TAsqBQEWz RA== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3vp2hhr453-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 16 Jan 2024 22:32:02 +0000
Received: from m0356517.ppops.net (m0356517.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 40GMVSO2029257;
 Tue, 16 Jan 2024 22:32:01 GMT
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3vp2hhr44q-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 16 Jan 2024 22:32:01 +0000
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 40GM7UtA019687; Tue, 16 Jan 2024 22:32:00 GMT
Received: from smtprelay02.wdc07v.mail.ibm.com ([172.16.1.69])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 3vm72k1674-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 16 Jan 2024 22:32:00 +0000
Received: from smtpav01.wdc07v.mail.ibm.com (smtpav01.wdc07v.mail.ibm.com
 [10.39.53.228])
 by smtprelay02.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 40GMVxgO6488770
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 16 Jan 2024 22:31:59 GMT
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 83DE958072;
 Tue, 16 Jan 2024 22:31:59 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 3A17D58068;
 Tue, 16 Jan 2024 22:31:58 +0000 (GMT)
Received: from li-2311da4c-2e09-11b2-a85c-c003041e9174.ibm.com.com (unknown
 [9.61.163.245]) by smtpav01.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Tue, 16 Jan 2024 22:31:58 +0000 (GMT)
From: Matthew Rosato <mjrosato@linux.ibm.com>
To: qemu-s390x@nongnu.org
Cc: farman@linux.ibm.com, thuth@redhat.com, clg@redhat.com,
 frankja@linux.ibm.com, pasic@linux.ibm.com, borntraeger@linux.ibm.com,
 richard.henderson@linaro.org, david@redhat.com, iii@linux.ibm.com,
 qemu-devel@nongnu.org
Subject: [PATCH 0/3] s390x/pci: fix ISM reset
Date: Tue, 16 Jan 2024 17:31:54 -0500
Message-ID: <20240116223157.73752-1-mjrosato@linux.ibm.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: Rk9WffdGWK6yK8-BcuElDOtEE1OZB3G_
X-Proofpoint-GUID: fWper-P5Yx3jhBpWsFoToIp69pCprhgc
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-16_14,2024-01-16_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0
 lowpriorityscore=0 mlxlogscore=964 malwarescore=0 clxscore=1011
 spamscore=0 phishscore=0 priorityscore=1501 impostorscore=0 mlxscore=0
 adultscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2401160178
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

Matthew Rosato (3):
  s390x/pci: avoid double enable/disable of aif
  s390x/pci: refresh fh before disabling aif
  s390x/pci: drive ISM reset from subsystem reset

 hw/s390x/s390-pci-bus.c         | 26 ++++++++++++++++---------
 hw/s390x/s390-pci-kvm.c         | 34 +++++++++++++++++++++++++++++++--
 hw/s390x/s390-virtio-ccw.c      |  2 ++
 include/hw/s390x/s390-pci-bus.h |  2 ++
 4 files changed, 53 insertions(+), 11 deletions(-)

-- 
2.43.0



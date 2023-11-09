Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0000E7E7495
	for <lists+qemu-devel@lfdr.de>; Thu,  9 Nov 2023 23:54:36 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r1Dtn-00023W-4Q; Thu, 09 Nov 2023 17:53:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjrosato@linux.ibm.com>)
 id 1r1Dtk-00022t-Ue; Thu, 09 Nov 2023 17:53:17 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjrosato@linux.ibm.com>)
 id 1r1Dtg-0001fU-8K; Thu, 09 Nov 2023 17:53:16 -0500
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 3A9MewpY027923; Thu, 9 Nov 2023 22:53:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=VwxadFzgesvI/PBE6LkEV5HkAXuTBDSGDuSwOq3V4DA=;
 b=N5huaQyruFv0lQC/pkuHQ7vs/Z5MZkV1D0q1HuV00lWbD+tcYGwyaBIgTYx1kc3PkCAV
 2KW7MUGEfPBkcdDcG0GRcphpLOSaXDVsuMhGHCk9wVvIJTDV+TUhfQCAl1fBPNrZr/fL
 ZQ0hRUW8UeuOPmXn9FM8Z/Y+nrni/P1axOL63sB7aZm4u11P9j927dLtXjh7516WD5jB
 EAP9+8yi4rcdVrWctlhLj8feTYuM+zOf68PweXvmMhSs3RbdVgDyzXJANiua/8th1P4o
 5IZf69Ww3I177ssjmQN0GFJEReBwnb1qnRCwTdF6sVp75Vht4r5p91uJDhOnOD/rhcAU gw== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3u987x8egv-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 09 Nov 2023 22:53:07 +0000
Received: from m0360083.ppops.net (m0360083.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 3A9Mr7xi031112;
 Thu, 9 Nov 2023 22:53:07 GMT
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3u987x8egd-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 09 Nov 2023 22:53:07 +0000
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 3A9Ljaan014340; Thu, 9 Nov 2023 22:53:05 GMT
Received: from smtprelay07.dal12v.mail.ibm.com ([172.16.1.9])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3u7w2271hy-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 09 Nov 2023 22:53:05 +0000
Received: from smtpav02.wdc07v.mail.ibm.com (smtpav02.wdc07v.mail.ibm.com
 [10.39.53.229])
 by smtprelay07.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 3A9Mr4eV43778752
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 9 Nov 2023 22:53:05 GMT
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 9DD965805C;
 Thu,  9 Nov 2023 22:53:04 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 50F4E58059;
 Thu,  9 Nov 2023 22:53:03 +0000 (GMT)
Received: from li-2311da4c-2e09-11b2-a85c-c003041e9174.ibm.com.com (unknown
 [9.61.66.47]) by smtpav02.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Thu,  9 Nov 2023 22:53:03 +0000 (GMT)
From: Matthew Rosato <mjrosato@linux.ibm.com>
To: qemu-s390x@nongnu.org
Cc: farman@linux.ibm.com, thuth@redhat.com, clg@redhat.com,
 pasic@linux.ibm.com, borntraeger@linux.ibm.com,
 richard.henderson@linaro.org, david@redhat.com, iii@linux.ibm.com,
 qemu-devel@nongnu.org
Subject: [PATCH 0/2] s390x/pci: small set of fixes
Date: Thu,  9 Nov 2023 17:53:00 -0500
Message-ID: <20231109225302.401344-1-mjrosato@linux.ibm.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: wM-EM9RkvKui8GvUmQGRVK2T6Dk8tAR8
X-Proofpoint-GUID: JsfAPvoRxmZD8nOX6pZnOyUclaUTv8MM
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-09_16,2023-11-09_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0
 mlxlogscore=519 mlxscore=0 priorityscore=1501 clxscore=1011 adultscore=0
 spamscore=0 suspectscore=0 lowpriorityscore=0 malwarescore=0 bulkscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311060000 definitions=main-2311090167
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

The following set of changes are associated with issues exposed by testing
of the 'vfio: Adopt iommufd' series.

The first patch fixes an existing assumption that a vfio device will always
have a group fd (which is no longer true if cdev is used, which can only
happen once the iommufd backend is used).  This patch really only needs to
go into 8.2 if the 'vfio: Adopt iommufd' series does (but would be fine to 
go into 8.2 without it too).

The second patch fixes an issue where we do not detect that a vfio DMA limit
was never read from vfio.  This is actually an existing bug as it's possible
for an older host kernel to be missing this support today; so ideally this one
should be targeted for 8.2 regardless. 

Matthew Rosato (2):
  s390x/pci: bypass vfio DMA counting when using cdev
  s390x/pci: only limit DMA aperture if vfio DMA limit reported

 hw/s390x/s390-pci-vfio.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

-- 
2.41.0



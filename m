Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 35634717154
	for <lists+qemu-devel@lfdr.de>; Wed, 31 May 2023 01:09:08 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q48RM-0005oE-Tk; Tue, 30 May 2023 19:07:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akrowiak@linux.ibm.com>)
 id 1q48RK-0005np-IY; Tue, 30 May 2023 19:07:42 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akrowiak@linux.ibm.com>)
 id 1q48RI-0000am-Eo; Tue, 30 May 2023 19:07:42 -0400
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 34ULbtSj026640; Tue, 30 May 2023 23:07:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=j5FCUu6sn5+VM4k3fRhWMhw1/dKRueEkqTlgRyiEx8I=;
 b=VQZXuZXLYABRGXHUNubxKtd9iyFde2ckqRU2E/k6WCQ5dIxxbuRDSGd5+fDbQVBau16/
 cRs6cbYFE3cYObE9LVsSfPydh+Os6FNnf+qY87OCvv/unORS/8hiJvInV2lsGGKFiX7u
 BxJgGEfUPjA4cuZsKo+Sf+E6+GN+EBh7+l1q/1IdHRCb3c1Gm4okYWihBF2XGVvlETLJ
 7Y05eVBeZuwX7QgQcsmiQFBkduXRsdyYKJwraKn0Wmc+2Ji6x9xTh2TciqvtMGWTBNAM
 pgWwPxHPfjYH2JsyOsTl1f64PTZ7GMCO5OMB7v/77IpJXoS2DwrRCn+UV6XuseVR9gAY 9w== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3qwqttbguv-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 30 May 2023 23:07:36 +0000
Received: from m0353725.ppops.net (m0353725.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 34UN0YnU008203;
 Tue, 30 May 2023 23:07:36 GMT
Received: from ppma04dal.us.ibm.com (7a.29.35a9.ip4.static.sl-reverse.com
 [169.53.41.122])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3qwqttbgun-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 30 May 2023 23:07:36 +0000
Received: from pps.filterd (ppma04dal.us.ibm.com [127.0.0.1])
 by ppma04dal.us.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 34UKEo1O016849;
 Tue, 30 May 2023 23:07:35 GMT
Received: from smtprelay01.wdc07v.mail.ibm.com ([9.208.129.119])
 by ppma04dal.us.ibm.com (PPS) with ESMTPS id 3qu9g6ja5x-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 30 May 2023 23:07:35 +0000
Received: from smtpav04.dal12v.mail.ibm.com (smtpav04.dal12v.mail.ibm.com
 [10.241.53.103])
 by smtprelay01.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 34UN7XfT32899732
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 30 May 2023 23:07:33 GMT
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 4BFF458076;
 Tue, 30 May 2023 23:07:33 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 7057B58075;
 Tue, 30 May 2023 23:07:32 +0000 (GMT)
Received: from li-2c1e724c-2c76-11b2-a85c-ae42eaf3cb3d.ibm.com.com (unknown
 [9.61.88.233]) by smtpav04.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Tue, 30 May 2023 23:07:32 +0000 (GMT)
From: Tony Krowiak <akrowiak@linux.ibm.com>
To: qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, mjrosato@linux.ibm.com, jjherne@linux.ibm.com,
 pasic@linux.ibm.com, fiuczy@linux.ibm.com, thuth@redhat.com,
 farman@linux.ibm.com, borntraeger@linux.ibm.com,
 Tony Krowiak <akrowiak@linux.ibm.com>
Subject: [PATCH 0/2] s390x/ap: fix hang when mdev attached to guest is removed
Date: Tue, 30 May 2023 18:55:42 -0400
Message-Id: <20230530225544.280031-1-akrowiak@linux.ibm.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: IHj08gNVV7lVkSzDtxAktUtUWzBz5sSn
X-Proofpoint-GUID: n7X1FH5jTTfxvmpCoG3rfie1p2TQhiwP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-05-30_16,2023-05-30_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1011 malwarescore=0
 adultscore=0 suspectscore=0 lowpriorityscore=0 bulkscore=0 mlxlogscore=527
 impostorscore=0 phishscore=0 priorityscore=1501 mlxscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2304280000
 definitions=main-2305300188
Received-SPF: pass client-ip=148.163.158.5;
 envelope-from=akrowiak@linux.ibm.com; helo=mx0b-001b2d01.pphosted.com
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

When a user attempts to remove a vfio-ap mediated device attached to a
guest, the operation hangs until the mdev's fd is closed by the guest
(i.e., the guest is shut down). This patch series provides userspace 
(i.e., qemu) code to handle device unplug requests for AP. When notified
that the mdev is being removed, the handler will unplug the device, thus
avoiding the hang condition.

Tony Krowiak (2):
  linux-headers: Update with vfio_ap IRQ index mapping
  s390x/ap: Wire up the device request notifier interface

 hw/vfio/ap.c               | 113 +++++++++++++++++++++++++++++++++++++
 linux-headers/linux/vfio.h |   9 +++
 2 files changed, 122 insertions(+)

-- 
2.31.1



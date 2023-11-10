Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 30EE37E7F4D
	for <lists+qemu-devel@lfdr.de>; Fri, 10 Nov 2023 18:52:47 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r1Vfd-0000TE-Tc; Fri, 10 Nov 2023 12:51:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjrosato@linux.ibm.com>)
 id 1r1Vfc-0000Qj-2X; Fri, 10 Nov 2023 12:51:52 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjrosato@linux.ibm.com>)
 id 1r1VfP-0007B8-OJ; Fri, 10 Nov 2023 12:51:51 -0500
Received: from pps.filterd (m0353728.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 3AAHlSgl016836; Fri, 10 Nov 2023 17:51:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=yvIbF5rUjMTGi171xcG7GwtZ5GDmMr+5A1HYy1TyWgU=;
 b=DIZZhXx0xtTjUFbo2w4qewmJPg+AGUT3DQKB39OS/TjrJ2USzj8MwknRKSIGBIOmKyZv
 d0gotXHkpQuRwnf5wB7SORyp+odGzgvk0f14Nckx7b52vl3lP17cvY2q9gtgWGIVaQW8
 srM6UACcOHqjwWPkMo5tDyjnw5lo0dQmcdDL6HOUA0e4LnpKOX7d+w0IDBTrR/2BsN9M
 SxgJSXJVoaalVCoSqrEudHEyyN2Jg+JStrYFIJPd+NC+gQYW7UwRcV2zKhERY7M7FCg5
 +5i25y0wq9JZUJczUScsHZ9TPItzIdXFc8mHRg9kPsoTli5YQ56Kjl8N8uAkhhSkrSbi 3w== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3u9s7pg340-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 10 Nov 2023 17:51:36 +0000
Received: from m0353728.ppops.net (m0353728.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 3AAHmdBk022303;
 Fri, 10 Nov 2023 17:51:35 GMT
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3u9s7pg2vm-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 10 Nov 2023 17:51:35 +0000
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 3AAGOh3o028310; Fri, 10 Nov 2023 17:51:12 GMT
Received: from smtprelay04.dal12v.mail.ibm.com ([172.16.1.6])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3u7w22vghb-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 10 Nov 2023 17:51:12 +0000
Received: from smtpav01.wdc07v.mail.ibm.com (smtpav01.wdc07v.mail.ibm.com
 [10.39.53.228])
 by smtprelay04.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 3AAHpAWW19661542
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 10 Nov 2023 17:51:11 GMT
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id CC57258059;
 Fri, 10 Nov 2023 17:51:10 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 949125804B;
 Fri, 10 Nov 2023 17:51:09 +0000 (GMT)
Received: from li-2311da4c-2e09-11b2-a85c-c003041e9174.ibm.com.com (unknown
 [9.61.66.47]) by smtpav01.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Fri, 10 Nov 2023 17:51:09 +0000 (GMT)
From: Matthew Rosato <mjrosato@linux.ibm.com>
To: qemu-s390x@nongnu.org
Cc: farman@linux.ibm.com, thuth@redhat.com, clg@redhat.com,
 pasic@linux.ibm.com, borntraeger@linux.ibm.com,
 richard.henderson@linaro.org, david@redhat.com, iii@linux.ibm.com,
 qemu-devel@nongnu.org
Subject: [PATCH v2 0/2] s390x/pci: small set of fixes
Date: Fri, 10 Nov 2023 12:51:06 -0500
Message-ID: <20231110175108.465851-1-mjrosato@linux.ibm.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: RAVgWWNz-l6QqFyYzSI7yhY8tEsLU6QH
X-Proofpoint-ORIG-GUID: 9Tht2AysnTT4C3Rz5RHu9rJW6q27MG0_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-10_15,2023-11-09_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 phishscore=0
 suspectscore=0 priorityscore=1501 mlxlogscore=524 adultscore=0 spamscore=0
 impostorscore=0 bulkscore=0 lowpriorityscore=0 clxscore=1015 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311060000
 definitions=main-2311100149
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

Changes for v2:
- minor style changes (Phil, Thomas)

Matthew Rosato (2):
  s390x/pci: bypass vfio DMA counting when using cdev
  s390x/pci: only limit DMA aperture if vfio DMA limit reported

 hw/s390x/s390-pci-vfio.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

-- 
2.41.0



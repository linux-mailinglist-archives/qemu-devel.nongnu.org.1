Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 85B9D70E7B4
	for <lists+qemu-devel@lfdr.de>; Tue, 23 May 2023 23:46:37 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q1Zpi-0000I4-4O; Tue, 23 May 2023 17:46:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ninad@us.ibm.com>)
 id 1q1Zpf-0000Fv-HZ; Tue, 23 May 2023 17:46:15 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ninad@us.ibm.com>)
 id 1q1ZpQ-00067q-0G; Tue, 23 May 2023 17:46:15 -0400
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 34NLg2Wd021330; Tue, 23 May 2023 21:45:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=IJB/NOf4EClsVbTZyPed7w/fpYiy7G5XJG/Om7KcgVg=;
 b=eAStBgNmqCjadNidlywQyIXFJTZ+vjJhBIIHWUnMw6ishslsmMA/nXl2EwhMRQogn+Wt
 1N9UtmkINzKko89KtvvzVBl0NiG3OAE1JqN3cDpish2BzGV1bn3vYMoCKFqozZj/49lx
 G6ui7YiNw5IsEyd02i2HQ2/3dYLLQTcKAYUqCU9C/zEhwIekuTmEXkrTZXbTlF1Edwr4
 wU6iDq7ES/32QF6/4l1CdhsyIvGjdoHcMHzOugrmlFdTtRE4Wqko8MeciHclHbTjhl1T
 fF2dN2oPtra1ncykMQBpFeAyx8rRsqaAKS8C3ujuuQI7Ka6XCJsni8g5thGUchj1gXBX vg== 
Received: from ppma02dal.us.ibm.com (a.bd.3ea9.ip4.static.sl-reverse.com
 [169.62.189.10])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3qs4xth9yn-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 23 May 2023 21:45:37 +0000
Received: from pps.filterd (ppma02dal.us.ibm.com [127.0.0.1])
 by ppma02dal.us.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 34NLAYPW031319;
 Tue, 23 May 2023 21:45:36 GMT
Received: from smtprelay05.wdc07v.mail.ibm.com ([9.208.129.117])
 by ppma02dal.us.ibm.com (PPS) with ESMTPS id 3qppdpn7xc-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 23 May 2023 21:45:36 +0000
Received: from smtpav02.wdc07v.mail.ibm.com (smtpav02.wdc07v.mail.ibm.com
 [10.39.53.229])
 by smtprelay05.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 34NLjZNW1245738
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 23 May 2023 21:45:35 GMT
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 6ACF15805F;
 Tue, 23 May 2023 21:45:35 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 5654B58058;
 Tue, 23 May 2023 21:45:35 +0000 (GMT)
Received: from gfwa601.aus.stglabs.ibm.com (unknown [9.3.62.226])
 by smtpav02.wdc07v.mail.ibm.com (Postfix) with ESMTPS;
 Tue, 23 May 2023 21:45:35 +0000 (GMT)
Received: by gfwa601.aus.stglabs.ibm.com (Postfix, from userid 155676)
 id 988242ED7E5; Tue, 23 May 2023 16:45:34 -0500 (CDT)
From: Ninad Palsule <ninad@linux.ibm.com>
To: qemu-devel@nongnu.org, clg@kaod.org, peter.maydell@linaro.org,
 andrew@aj.id.au, joel@jms.id.au
Cc: Ninad Palsule <ninad@linux.ibm.com>, qemu-arm@nongnu.org
Subject: [PATCH v3 0/1] Add vpd data for Rainier machine
Date: Tue, 23 May 2023 16:45:18 -0500
Message-Id: <20230523214520.2102894-1-ninad@linux.ibm.com>
X-Mailer: git-send-email 2.37.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: edC2nZFDGVX96tK37lhwuIV1m8wVKGBa
X-Proofpoint-GUID: edC2nZFDGVX96tK37lhwuIV1m8wVKGBa
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-05-23_14,2023-05-23_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0
 mlxlogscore=560 clxscore=1011 bulkscore=0 adultscore=0 lowpriorityscore=0
 priorityscore=1501 impostorscore=0 phishscore=0 spamscore=0 mlxscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2304280000 definitions=main-2305230173
Received-SPF: pass client-ip=148.163.156.1; envelope-from=ninad@us.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

Please review the change.
  - This drops adds VPD data for rainier machine.
  - The VPD data is added for system VPD and BMC FRU.

Ninad Palsule (1):
  hw/arm/aspeed:Add vpd data for Rainier machine

 hw/arm/aspeed.c        |  6 ++++--
 hw/arm/aspeed_eeprom.c | 45 +++++++++++++++++++++++++++++++++++++++++-
 hw/arm/aspeed_eeprom.h |  5 +++++
 3 files changed, 53 insertions(+), 3 deletions(-)

-- 
2.37.2



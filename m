Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BD8D87D15C4
	for <lists+qemu-devel@lfdr.de>; Fri, 20 Oct 2023 20:25:48 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qtuAT-0004Fb-Mh; Fri, 20 Oct 2023 14:24:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <milesg@linux.vnet.ibm.com>)
 id 1qtuAR-0004FF-9j; Fri, 20 Oct 2023 14:24:15 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <milesg@linux.vnet.ibm.com>)
 id 1qtuAP-00064n-JO; Fri, 20 Oct 2023 14:24:15 -0400
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 39KICGT2013620; Fri, 20 Oct 2023 18:23:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=FGpBSLiDh0G95YsLFw7VXZ643zHThN06uzYIMozy9Yg=;
 b=D3vLS+K+WX5H4xGW44ST25h/eQttXikAKDjh0VRrocB1C3yi7aaan3Mgoa/kqQY7+iEn
 jFHgnxgb/bNHd2dA1Vjs5uOX8yMky9QssSbzFeVEav7SIbs5OX6TUGHzMDDX7J+3EgZi
 j+5xYxNT7zUPtcudqPASvIz5fINCDkeF2x/x8XOox2qDisHPu0o7lX5vx7iYeKizjNcy
 zU8gu+4aZ8Hi5411SqKlbIO+i327xYSk0n73EkBYggdZOmXIJrxizhrRcG7r7ZAhA5GZ
 eKN7HcuCPevxcZp0ROL58TnXb4y8Rzlp1lvBi4f0jr/8EQZ7ECE/hsT4Sd5r8dR7sMZ8 SA== 
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3tuxme0hkx-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 20 Oct 2023 18:23:57 +0000
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 39KHcKVc019377; Fri, 20 Oct 2023 18:23:56 GMT
Received: from smtprelay03.dal12v.mail.ibm.com ([172.16.1.5])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 3tuc456dye-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 20 Oct 2023 18:23:56 +0000
Received: from smtpav04.wdc07v.mail.ibm.com (smtpav04.wdc07v.mail.ibm.com
 [10.39.53.231])
 by smtprelay03.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 39KINtiw10617472
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 20 Oct 2023 18:23:55 GMT
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 7697A58050;
 Fri, 20 Oct 2023 18:23:55 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id E0FB558045;
 Fri, 20 Oct 2023 18:23:54 +0000 (GMT)
Received: from mamboa4.aus.stglabs.ibm.com (unknown [9.3.84.87])
 by smtpav04.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Fri, 20 Oct 2023 18:23:54 +0000 (GMT)
From: Glenn Miles <milesg@linux.vnet.ibm.com>
To: qemu-devel@nongnu.org
Cc: Glenn Miles <milesg@linux.vnet.ibm.com>, qemu-arm@nongnu.org,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 andrew@codeconstruct.com.au, Joel Stanley <joel@jms.id.au>,
 philmd@linaro.org
Subject: [PATCH v2 0/3] misc/pca9552: Changes to support powernv10
Date: Fri, 20 Oct 2023 13:23:18 -0500
Message-Id: <20231020182321.163109-1-milesg@linux.vnet.ibm.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: LlisD8eEXKI0lIPuoe4xIV2mnvTzg5aj
X-Proofpoint-ORIG-GUID: LlisD8eEXKI0lIPuoe4xIV2mnvTzg5aj
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-20_10,2023-10-19_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 bulkscore=0
 mlxscore=0 lowpriorityscore=0 priorityscore=1501 spamscore=0 phishscore=0
 adultscore=0 malwarescore=0 suspectscore=0 clxscore=1015 mlxlogscore=747
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2310170001
 definitions=main-2310200154
Received-SPF: none client-ip=148.163.156.1;
 envelope-from=milesg@linux.vnet.ibm.com; helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

This is a series of patches targeted at getting the pca9552
model ready for use by the powernv10 machine.

Changes from v1:
 - Added check to only update output GPIO if state changed

Glenn Miles (3):
  misc/pca9552: Fix inverted input status
  misc/pca9552: Let external devices set pca9552 inputs
  misc/pca9552: Only update output GPIOs if state changed

 hw/misc/pca9552.c          | 64 +++++++++++++++++++++++++++++++++-----
 include/hw/misc/pca9552.h  |  3 +-
 tests/qtest/pca9552-test.c |  6 ++--
 3 files changed, 62 insertions(+), 11 deletions(-)

-- 
2.31.1



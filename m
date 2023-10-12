Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5456C7C77AA
	for <lists+qemu-devel@lfdr.de>; Thu, 12 Oct 2023 22:10:46 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qr200-00074X-TL; Thu, 12 Oct 2023 16:09:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <milesg@linux.vnet.ibm.com>)
 id 1qr1zw-000724-Pa; Thu, 12 Oct 2023 16:09:32 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <milesg@linux.vnet.ibm.com>)
 id 1qr1zu-0006wy-OA; Thu, 12 Oct 2023 16:09:32 -0400
Received: from pps.filterd (m0353727.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 39CK2RKK018896; Thu, 12 Oct 2023 20:09:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=from : to : cc : subject
 : date : message-id : mime-version : content-type :
 content-transfer-encoding; s=pp1;
 bh=in7G8kmdmyRBZk4Sm4emHzPs1uEsaztzMEQCCw614zI=;
 b=cMx6zFUZ5Z4B22V3XFl2oXNJazlQ+oVrRNd2vhn+VLiDzoX4bnLHDGCnBIpDBUnY8Stn
 P4AwQ4ELnwiC1AWaxBzHYzvbQA9XueDpefwnovoDVVuAYkTSPJ9HiS9ZBYPG+0Z9bts7
 Tu36Hgg/riHu6JqIUwGYD84ChgcOG6/eUQ3B+kEEjzs6E4Q5teczBDaGGLi9+hxcJT1b
 5XYHHLDvZDqKmWFQjYX5tamrzQt+0t3m9lN5qA1PloZjJtwOukxdckV7rRCuJT9gSkDN
 SYiInmNFvb9/Z0OK/UAsmWOgnE4MXLnDogMsakQrQ0jifeDNAPZPaQDZIs+XyoAgsPsA YA== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3tpqfxr84f-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 12 Oct 2023 20:09:25 +0000
Received: from m0353727.ppops.net (m0353727.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 39CK6dwI002211;
 Thu, 12 Oct 2023 20:09:24 GMT
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3tpqfxr83q-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 12 Oct 2023 20:09:24 +0000
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 39CJiPWD000685; Thu, 12 Oct 2023 20:09:23 GMT
Received: from smtprelay03.wdc07v.mail.ibm.com ([172.16.1.70])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3tkk5m1x0s-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 12 Oct 2023 20:09:23 +0000
Received: from smtpav04.wdc07v.mail.ibm.com (smtpav04.wdc07v.mail.ibm.com
 [10.39.53.231])
 by smtprelay03.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 39CK9NDa16646764
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 12 Oct 2023 20:09:23 GMT
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 018725805E;
 Thu, 12 Oct 2023 20:09:23 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 7CB2058050;
 Thu, 12 Oct 2023 20:09:22 +0000 (GMT)
Received: from mamboa4.aus.stglabs.ibm.com (unknown [9.3.84.87])
 by smtpav04.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Thu, 12 Oct 2023 20:09:22 +0000 (GMT)
From: Glenn Miles <milesg@linux.vnet.ibm.com>
To: qemu-ppc@nongnu.org
Cc: Glenn Miles <milesg@linux.vnet.ibm.com>, qemu-devel@nongnu.org,
 clg@kaod.org, npiggin@gmail.com, fbarrat@linux.ibm.com
Subject: [PATCH v2 0/2] Add PowerNV I2C Controller Model
Date: Thu, 12 Oct 2023 15:08:49 -0500
Message-Id: <20231012200851.3020858-1-milesg@linux.vnet.ibm.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: nfduTxWMBrjp6ja--oTfkod81YSNkCT1
X-Proofpoint-ORIG-GUID: CFVJB5H-n3C0tNrI5C2RdfNMj5trNpEW
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-12_12,2023-10-12_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 suspectscore=0 lowpriorityscore=0 malwarescore=0 mlxlogscore=482
 adultscore=0 spamscore=0 bulkscore=0 impostorscore=0 phishscore=0
 clxscore=1015 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2309180000 definitions=main-2310120168
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

Upstreams the PowerNV I2C controller model originally
authored by Cédric Le Goater with minor changes by
myself to split the actual addition of the model from
wiring it up to a power processor model.

This series only attaches the controller to the powernv9
chip model, but is expected to eventually also be attached
to the powernv10 chip model.

Cédric Le Goater (2):
  ppc/pnv: Add an I2C controller model
  ppc/pnv: Connect I2C controller model to powernv9 chip

 hw/ppc/meson.build         |   1 +
 hw/ppc/pnv.c               |  29 ++
 hw/ppc/pnv_i2c.c           | 673 +++++++++++++++++++++++++++++++++++++
 include/hw/ppc/pnv_chip.h  |   8 +
 include/hw/ppc/pnv_i2c.h   |  38 +++
 include/hw/ppc/pnv_xscom.h |   3 +
 6 files changed, 752 insertions(+)
 create mode 100644 hw/ppc/pnv_i2c.c
 create mode 100644 include/hw/ppc/pnv_i2c.h

-- 
2.31.1



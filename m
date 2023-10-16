Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DB4927CB68B
	for <lists+qemu-devel@lfdr.de>; Tue, 17 Oct 2023 00:23:56 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qsVzf-00063g-Aq; Mon, 16 Oct 2023 18:23:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <milesg@linux.vnet.ibm.com>)
 id 1qsVzd-00063R-N1; Mon, 16 Oct 2023 18:23:21 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <milesg@linux.vnet.ibm.com>)
 id 1qsVzc-00032F-8d; Mon, 16 Oct 2023 18:23:21 -0400
Received: from pps.filterd (m0353723.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 39GMNCQe005349; Mon, 16 Oct 2023 22:23:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=from : to : cc : subject
 : date : message-id : mime-version : content-type :
 content-transfer-encoding; s=pp1;
 bh=cc/lMyPcQONrYGKHurcvVpQ/N0r/KUFYp66CKnWvROk=;
 b=aATxeJw5FsD9Rgb66on2xWYW6kLbKh2Ae3NqeQojdUlDhlY986Ew+9XImcAe0PzmhvIH
 U+Joku2X4Q220BsL8UsuaU5kd+aggd9PZbcpdz6BSltEU9YefpWo1a2RAOmb/y7ZdVBp
 QdAGl9wz7eLfbvDe6Np6zEdDxHHKqpFw/uYPzL6+S7XIq5rM29mWMQEd/k/ulJXen6oR
 Gulq7rEcFhQJnXPbyvd6Sl4aiH/jznzwr44rZ/FQgUh9FRIWx7FYBgb2rW58pVcBqOGD
 +NGJUhK5TDaqVuEK3/sawoQPEVGu2D7Z/uLQ+3bSonKQxmKVDYHfvYMQoqpT6Vu7ZWr2 wQ== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3tsdqu87q9-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 16 Oct 2023 22:23:16 +0000
Received: from m0353723.ppops.net (m0353723.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 39GMNGLC005542;
 Mon, 16 Oct 2023 22:23:16 GMT
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3tsdqu87f8-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 16 Oct 2023 22:23:16 +0000
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 39GJp08E026885; Mon, 16 Oct 2023 22:20:31 GMT
Received: from smtprelay04.dal12v.mail.ibm.com ([172.16.1.6])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 3tr5as45t3-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 16 Oct 2023 22:20:31 +0000
Received: from smtpav03.wdc07v.mail.ibm.com (smtpav03.wdc07v.mail.ibm.com
 [10.39.53.230])
 by smtprelay04.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 39GMKVjj21824112
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 16 Oct 2023 22:20:31 GMT
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 0FA7458054;
 Mon, 16 Oct 2023 22:20:31 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 8B04C5805A;
 Mon, 16 Oct 2023 22:20:30 +0000 (GMT)
Received: from mamboa4.aus.stglabs.ibm.com (unknown [9.3.84.87])
 by smtpav03.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Mon, 16 Oct 2023 22:20:30 +0000 (GMT)
From: Glenn Miles <milesg@linux.vnet.ibm.com>
To: qemu-ppc@nongnu.org
Cc: Glenn Miles <milesg@linux.vnet.ibm.com>, qemu-devel@nongnu.org,
 clg@kaod.org, npiggin@gmail.com, fbarrat@linux.ibm.com, philmd@linaro.org
Subject: [PATCH v3 0/2] Add PowerNV I2C Controller Model
Date: Mon, 16 Oct 2023 17:20:11 -0500
Message-Id: <20231016222013.3739530-1-milesg@linux.vnet.ibm.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: gorz_OBASVzchY954wxFqjyW-ElyAwE0
X-Proofpoint-ORIG-GUID: pKnQYV8u4ulD5JWCt9PhqgNWoDiWYc1e
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-16_11,2023-10-12_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxscore=0 malwarescore=0
 adultscore=0 priorityscore=1501 bulkscore=0 spamscore=0 mlxlogscore=480
 impostorscore=0 lowpriorityscore=0 clxscore=1015 phishscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2309180000 definitions=main-2310160194
Received-SPF: none client-ip=148.163.158.5;
 envelope-from=milesg@linux.vnet.ibm.com; helo=mx0b-001b2d01.pphosted.com
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
 hw/ppc/pnv.c               |  28 ++
 hw/ppc/pnv_i2c.c           | 697 +++++++++++++++++++++++++++++++++++++
 include/hw/ppc/pnv_chip.h  |   8 +
 include/hw/ppc/pnv_i2c.h   |  38 ++
 include/hw/ppc/pnv_xscom.h |   3 +
 6 files changed, 775 insertions(+)
 create mode 100644 hw/ppc/pnv_i2c.c
 create mode 100644 include/hw/ppc/pnv_i2c.h

-- 
2.31.1



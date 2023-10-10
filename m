Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D142B7C049C
	for <lists+qemu-devel@lfdr.de>; Tue, 10 Oct 2023 21:28:28 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qqIOW-0005p5-97; Tue, 10 Oct 2023 15:27:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mglenn@mamboa4.aus.stglabs.ibm.com>)
 id 1qqIOQ-0005ol-Kd; Tue, 10 Oct 2023 15:27:47 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mglenn@mamboa4.aus.stglabs.ibm.com>)
 id 1qqIOA-00070o-FR; Tue, 10 Oct 2023 15:27:45 -0400
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 39AJA4i4007490; Tue, 10 Oct 2023 19:27:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=from : to : cc : subject
 : date : message-id : mime-version : content-type :
 content-transfer-encoding; s=pp1;
 bh=fZ5TkPdnMfTvKi9oVnsNH+UL8bqKTik9qMhHkesFW44=;
 b=NCoHPNSwTaglE7HSUu05Y+5Lw3ESOc4l5X8rErXqolHj8S1096KcLduAWC2Txcibklza
 PMnFN1ST+KvA8Xhyd8X4h43kV/7VCDtfE6LkNvrZ3LaAARGaTigz6Z4XR005JRuiX3yo
 rqZMBnUUSCIpJ88a6wf+rfH0Xn7JREU6gbx0IbX8p6vW/iYdlFIwGgzrsqxC56Wv3/MD
 mkuvbL6JKfR4URVpB1EAH516CqNjAKYdky27Pr6G0c+3uv1a5Ws1t8xCce+8WuHtqrZP
 x4DQA+SzNZ/xpcgjIwmsmivrl9H5HS+TdFkXG5b87xKi5DBgH78uXeT7wGw9vgcX42jt KQ== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3tnchgghe8-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 10 Oct 2023 19:27:20 +0000
Received: from m0356517.ppops.net (m0356517.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 39AJQMkq006371;
 Tue, 10 Oct 2023 19:27:20 GMT
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3tnchgghd1-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 10 Oct 2023 19:27:20 +0000
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 39AH2KIg025901; Tue, 10 Oct 2023 19:27:18 GMT
Received: from smtprelay05.dal12v.mail.ibm.com ([172.16.1.7])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3tkjnna9yh-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 10 Oct 2023 19:27:18 +0000
Received: from smtpav02.dal12v.mail.ibm.com (smtpav02.dal12v.mail.ibm.com
 [10.241.53.101])
 by smtprelay05.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 39AJRI6M10879596
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 10 Oct 2023 19:27:18 GMT
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id F3F5C58062;
 Tue, 10 Oct 2023 19:27:17 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id E3DD05805C;
 Tue, 10 Oct 2023 19:27:17 +0000 (GMT)
Received: from mamboa4.aus.stglabs.ibm.com (unknown [9.3.84.87])
 by smtpav02.dal12v.mail.ibm.com (Postfix) with ESMTPS;
 Tue, 10 Oct 2023 19:27:17 +0000 (GMT)
Received: from mamboa4.aus.stglabs.ibm.com (localhost [127.0.0.1])
 by mamboa4.aus.stglabs.ibm.com (Postfix) with ESMTPS id 8490416A07F2;
 Tue, 10 Oct 2023 12:20:19 -0500 (CDT)
Received: (from mglenn@localhost)
 by mamboa4.aus.stglabs.ibm.com (8.15.2/8.15.2/Submit) id 39AHKJfO4166055;
 Tue, 10 Oct 2023 12:20:19 -0500
From: Glenn Miles <milesg@linux.vnet.ibm.com>
To: qemu-ppc@nongnu.org
Cc: Glenn Miles <milesg@linux.vnet.ibm.com>, qemu-devel@nongnu.org,
 clg@kaod.org, clegoate@redhat.com, npiggin@gmail.com, fbarrat@linux.ibm.com
Subject: [PATCH 0/2] Add PowerNV I2C Controller Model
Date: Tue, 10 Oct 2023 12:19:49 -0500
Message-Id: <20231010171951.4165180-1-milesg@linux.vnet.ibm.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 7uJ1VnQ_jAmHvkKYe3SDPnA38pFQaCoj
X-Proofpoint-ORIG-GUID: J7KdigfU5sZ5hnKfpb5pO0guNeI06Rf2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-10_15,2023-10-10_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 mlxscore=0
 adultscore=0 bulkscore=0 phishscore=0 suspectscore=0 impostorscore=0
 malwarescore=0 spamscore=0 clxscore=1015 lowpriorityscore=0
 mlxlogscore=482 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2309180000 definitions=main-2310100150
Received-SPF: none client-ip=148.163.156.1;
 envelope-from=mglenn@mamboa4.aus.stglabs.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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
 hw/ppc/pnv.c               |  26 ++
 hw/ppc/pnv_i2c.c           | 680 +++++++++++++++++++++++++++++++++++++
 include/hw/ppc/pnv_chip.h  |   4 +
 include/hw/ppc/pnv_i2c.h   |  41 +++
 include/hw/ppc/pnv_xscom.h |   3 +
 6 files changed, 755 insertions(+)
 create mode 100644 hw/ppc/pnv_i2c.c
 create mode 100644 include/hw/ppc/pnv_i2c.h

-- 
2.31.1



Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3162F78D213
	for <lists+qemu-devel@lfdr.de>; Wed, 30 Aug 2023 04:28:47 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qbAvP-0002tA-AQ; Tue, 29 Aug 2023 22:27:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ninad@linux.ibm.com>)
 id 1qbAvE-0002dV-PH; Tue, 29 Aug 2023 22:27:09 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ninad@linux.ibm.com>)
 id 1qbAv5-0002Cn-78; Tue, 29 Aug 2023 22:27:05 -0400
Received: from pps.filterd (m0353724.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 37U29Ebu020848; Wed, 30 Aug 2023 02:26:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=from : to : cc : subject
 : date : message-id : mime-version : content-type :
 content-transfer-encoding; s=pp1;
 bh=pQ1ExT2MIgXAtQr1Brbid/phfFpCNvFP/j5LDM0Gmxc=;
 b=W1Uv8Gf6RKBYYhvoyalSCGkWOGIW6wU39GQ0RdVKXB0MFBka7sqhCEhiud/lBYesTGgo
 i1/a+u7XUKu4hiojqdKQM0sLryrd0/C/d1v1DXiXrQwpq2fvtkRoa1kNdg+4AxlXHsta
 f/ZDh0RZZz3asD2GGJDEX4ResPZmrcgDdqd5HRMon0fXM+FbqWgmJCaHxUFJgopxAUdw
 5SEp9lIy2ubCxcHVtVr+Q+OLcIK6GNBYwwIELWj8SKR8iwYJmytCOqr1p1DWeNzFdIxt
 zIWAV3JyKTQfMnlBbSUmWpwdbrbXeAX2ggYF1gwl129bTa3JeZbhNQVeoudrgUpERMT+ wg== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3ssu57sxhc-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 30 Aug 2023 02:26:45 +0000
Received: from m0353724.ppops.net (m0353724.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 37U2BMHL026908;
 Wed, 30 Aug 2023 02:26:44 GMT
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3ssu57sxh2-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 30 Aug 2023 02:26:44 +0000
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 37U2NFQL020180; Wed, 30 Aug 2023 02:26:43 GMT
Received: from smtprelay07.dal12v.mail.ibm.com ([172.16.1.9])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3sqv3ygm72-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 30 Aug 2023 02:26:43 +0000
Received: from smtpav04.wdc07v.mail.ibm.com (smtpav04.wdc07v.mail.ibm.com
 [10.39.53.231])
 by smtprelay07.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 37U2QgVP39649958
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 30 Aug 2023 02:26:43 GMT
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id C4B3C58050;
 Wed, 30 Aug 2023 02:26:42 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 22B2A5805F;
 Wed, 30 Aug 2023 02:26:42 +0000 (GMT)
Received: from gfwa153.aus.stglabs.ibm.com (unknown [9.3.84.127])
 by smtpav04.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Wed, 30 Aug 2023 02:26:42 +0000 (GMT)
From: Ninad Palsule <ninad@linux.ibm.com>
To: qemu-devel@nongnu.org, clg@kaod.org, peter.maydell@linaro.org,
 andrew@aj.id.au, joel@jms.id.au, pbonzini@redhat.com,
 marcandre.lureau@redhat.com, berrange@redhat.com, thuth@redhat.com,
 philmd@linaro.org, lvivier@redhat.com
Cc: Ninad Palsule <ninad@linux.ibm.com>, qemu-arm@nongnu.org
Subject: [PATCH v3 0/8] Introduce model for IBM's FSI
Date: Tue, 29 Aug 2023 21:26:30 -0500
Message-Id: <20230830022638.4183766-1-ninad@linux.ibm.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: ngVdKeyyBXiYMDREBrqndc7_yvmqz-_7
X-Proofpoint-ORIG-GUID: J2FYX4oB9OMp0ZOW8PDIlCVaQuS_DyhA
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-08-29_16,2023-08-29_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 mlxscore=0
 adultscore=0 malwarescore=0 spamscore=0 mlxlogscore=328 bulkscore=0
 lowpriorityscore=0 clxscore=1015 suspectscore=0 impostorscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2308100000 definitions=main-2308300017
Received-SPF: pass client-ip=148.163.158.5; envelope-from=ninad@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Hello,

Please review the patch-set version 3.
I have incorporated review comments from Cedric and Thomas.

Ninad Palsule (8):
  hw/fsi: Introduce IBM's Local bus
  hw/fsi: Introduce IBM's scratchpad
  hw/fsi: Introduce IBM's cfam,fsi-slave
  hw/fsi: Introduce IBM's FSI
  hw/fsi: IBM's On-chip Peripheral Bus
  hw/fsi: Aspeed APB2OPB interface
  hw/arm: Hook up FSI module in AST2600
  hw/fsi: Documentation and testing

 MAINTAINERS                        |  20 ++
 docs/specs/fsi.rst                 | 141 ++++++++++++
 hw/Kconfig                         |   1 +
 hw/arm/Kconfig                     |   1 +
 hw/arm/aspeed_ast2600.c            |  19 ++
 hw/fsi/Kconfig                     |  23 ++
 hw/fsi/aspeed-apb2opb.c            | 352 +++++++++++++++++++++++++++++
 hw/fsi/cfam.c                      | 239 ++++++++++++++++++++
 hw/fsi/engine-scratchpad.c         | 100 ++++++++
 hw/fsi/fsi-master.c                | 201 ++++++++++++++++
 hw/fsi/fsi-slave.c                 | 109 +++++++++
 hw/fsi/fsi.c                       |  54 +++++
 hw/fsi/lbus.c                      |  94 ++++++++
 hw/fsi/meson.build                 |   6 +
 hw/fsi/opb.c                       | 194 ++++++++++++++++
 hw/fsi/trace-events                |   8 +
 hw/fsi/trace.h                     |   1 +
 hw/meson.build                     |   1 +
 include/hw/arm/aspeed_soc.h        |   4 +
 include/hw/fsi/aspeed-apb2opb.h    |  33 +++
 include/hw/fsi/cfam.h              |  61 +++++
 include/hw/fsi/engine-scratchpad.h |  33 +++
 include/hw/fsi/fsi-master.h        |  30 +++
 include/hw/fsi/fsi-slave.h         |  29 +++
 include/hw/fsi/fsi.h               |  31 +++
 include/hw/fsi/lbus.h              |  48 ++++
 include/hw/fsi/opb.h               |  43 ++++
 include/qemu/bitops.h              |   6 +
 meson.build                        |   1 +
 tests/qtest/fsi-test.c             | 210 +++++++++++++++++
 tests/qtest/meson.build            |   2 +
 31 files changed, 2095 insertions(+)
 create mode 100644 docs/specs/fsi.rst
 create mode 100644 hw/fsi/Kconfig
 create mode 100644 hw/fsi/aspeed-apb2opb.c
 create mode 100644 hw/fsi/cfam.c
 create mode 100644 hw/fsi/engine-scratchpad.c
 create mode 100644 hw/fsi/fsi-master.c
 create mode 100644 hw/fsi/fsi-slave.c
 create mode 100644 hw/fsi/fsi.c
 create mode 100644 hw/fsi/lbus.c
 create mode 100644 hw/fsi/meson.build
 create mode 100644 hw/fsi/opb.c
 create mode 100644 hw/fsi/trace-events
 create mode 100644 hw/fsi/trace.h
 create mode 100644 include/hw/fsi/aspeed-apb2opb.h
 create mode 100644 include/hw/fsi/cfam.h
 create mode 100644 include/hw/fsi/engine-scratchpad.h
 create mode 100644 include/hw/fsi/fsi-master.h
 create mode 100644 include/hw/fsi/fsi-slave.h
 create mode 100644 include/hw/fsi/fsi.h
 create mode 100644 include/hw/fsi/lbus.h
 create mode 100644 include/hw/fsi/opb.h
 create mode 100644 tests/qtest/fsi-test.c

-- 
2.39.2



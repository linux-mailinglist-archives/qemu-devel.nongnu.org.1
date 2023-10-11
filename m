Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C83AC7C57DE
	for <lists+qemu-devel@lfdr.de>; Wed, 11 Oct 2023 17:15:28 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qqauk-00074t-RU; Wed, 11 Oct 2023 11:14:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ninad@linux.ibm.com>)
 id 1qqauP-00072q-Iv; Wed, 11 Oct 2023 11:14:01 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ninad@linux.ibm.com>)
 id 1qqauN-0004xn-V7; Wed, 11 Oct 2023 11:14:01 -0400
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 39BF0GvB022111; Wed, 11 Oct 2023 15:13:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=from : to : cc : subject
 : date : message-id : mime-version : content-type :
 content-transfer-encoding; s=pp1;
 bh=I6AD8+6vCWMJ9VTvGvEfhtie7JLOc0gfFmzg51A8AQI=;
 b=CVynT605RmhUENXkH/GjlGOEARXGYUVZg5UbQmqQ13fbYUOQB/FTMvdmSx9sc5U/VNGT
 Wi5P0p7oepdl0G64q9/00CeG5OyBcdohUmCSQ2hMpeQOalcyYb2xudXMd0oqgaMHu09I
 3nIJqbCFGFukD3q3aK8BM4mUXUjbyaHg8Q3ABU4O9j/ICWC8xDwjkTxk4NjV7sKw0Dbz
 jnm0azQThc6t7zfOFxf+xI42wZq08obve5RWDiqjejt/kgchHPiaVtpUsdgBBpIkY3Cf
 yXtDt1TNxwCzKqBoh9YRWtBH10O37jr5Y0MS25oIT9UV3q1oWVftQPVnTZscjE6iv5Ir GQ== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3tnwyc8rs7-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 11 Oct 2023 15:13:45 +0000
Received: from m0353725.ppops.net (m0353725.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 39BF0dRA024535;
 Wed, 11 Oct 2023 15:13:45 GMT
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3tnwyc8rr2-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 11 Oct 2023 15:13:44 +0000
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 39BDGA1o024445; Wed, 11 Oct 2023 15:13:43 GMT
Received: from smtprelay05.wdc07v.mail.ibm.com ([172.16.1.72])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 3tkhnss7ya-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 11 Oct 2023 15:13:43 +0000
Received: from smtpav05.dal12v.mail.ibm.com (smtpav05.dal12v.mail.ibm.com
 [10.241.53.104])
 by smtprelay05.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 39BFDgxH27263534
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 11 Oct 2023 15:13:42 GMT
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 77DB758069;
 Wed, 11 Oct 2023 15:13:42 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 1FD5B58068;
 Wed, 11 Oct 2023 15:13:42 +0000 (GMT)
Received: from gfwa153.aus.stglabs.ibm.com (unknown [9.3.84.127])
 by smtpav05.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Wed, 11 Oct 2023 15:13:42 +0000 (GMT)
From: Ninad Palsule <ninad@linux.ibm.com>
To: qemu-devel@nongnu.org, clg@kaod.org, peter.maydell@linaro.org,
 andrew@aj.id.au, joel@jms.id.au, pbonzini@redhat.com,
 marcandre.lureau@redhat.com, berrange@redhat.com, thuth@redhat.com,
 philmd@linaro.org, lvivier@redhat.com
Cc: Ninad Palsule <ninad@linux.ibm.com>, qemu-arm@nongnu.org
Subject: [PATCH v5 00/10] Introduce model for IBM's FSI
Date: Wed, 11 Oct 2023 10:13:29 -0500
Message-Id: <20231011151339.2782132-1-ninad@linux.ibm.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: veXaHa2N5eWO97JIkja1AQwyVD4jm_gt
X-Proofpoint-GUID: u0UD-UZfHxX8dErC2WZDbmHXqROJDM5v
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-11_09,2023-10-11_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=2
 mlxscore=2 clxscore=1015
 impostorscore=0 mlxlogscore=170 bulkscore=0 adultscore=0
 priorityscore=1501 suspectscore=0 lowpriorityscore=0 malwarescore=0
 phishscore=0 spamscore=2 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2309180000 definitions=main-2310110133
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

Please review the patch-set version 5.
I have incorporated review comments from Cedric.

Ninad Palsule (10):
  hw/fsi: Introduce IBM's Local bus
  hw/fsi: Introduce IBM's scratchpad
  hw/fsi: Introduce IBM's cfam,fsi-slave
  hw/fsi: Introduce IBM's FSI
  hw/fsi: IBM's On-chip Peripheral Bus
  hw/fsi: Aspeed APB2OPB interface
  hw/arm: Hook up FSI module in AST2600
  hw/fsi: Added qtest
  hw/fsi: Added FSI documentation
  hw/fsi: Update MAINTAINER list

 MAINTAINERS                        |   8 +
 docs/specs/fsi.rst                 | 141 ++++++++++++
 meson.build                        |   1 +
 hw/fsi/trace.h                     |   1 +
 include/hw/arm/aspeed_soc.h        |   4 +
 include/hw/fsi/aspeed-apb2opb.h    |  33 +++
 include/hw/fsi/cfam.h              |  58 +++++
 include/hw/fsi/engine-scratchpad.h |  33 +++
 include/hw/fsi/fsi-master.h        |  30 +++
 include/hw/fsi/fsi-slave.h         |  29 +++
 include/hw/fsi/fsi.h               |  37 +++
 include/hw/fsi/lbus.h              |  51 +++++
 include/hw/fsi/opb.h               |  43 ++++
 include/qemu/bitops.h              |   6 +
 hw/arm/aspeed_ast2600.c            |  19 ++
 hw/fsi/aspeed-apb2opb.c            | 350 +++++++++++++++++++++++++++++
 hw/fsi/cfam.c                      | 220 ++++++++++++++++++
 hw/fsi/engine-scratchpad.c         |  99 ++++++++
 hw/fsi/fsi-master.c                | 198 ++++++++++++++++
 hw/fsi/fsi-slave.c                 |  96 ++++++++
 hw/fsi/fsi.c                       |  54 +++++
 hw/fsi/lbus.c                      |  87 +++++++
 hw/fsi/opb.c                       | 185 +++++++++++++++
 tests/qtest/fsi-test.c             | 210 +++++++++++++++++
 hw/Kconfig                         |   1 +
 hw/arm/Kconfig                     |   1 +
 hw/fsi/Kconfig                     |  23 ++
 hw/fsi/meson.build                 |   6 +
 hw/fsi/trace-events                |  15 ++
 hw/meson.build                     |   1 +
 tests/qtest/meson.build            |   2 +
 31 files changed, 2042 insertions(+)
 create mode 100644 docs/specs/fsi.rst
 create mode 100644 hw/fsi/trace.h
 create mode 100644 include/hw/fsi/aspeed-apb2opb.h
 create mode 100644 include/hw/fsi/cfam.h
 create mode 100644 include/hw/fsi/engine-scratchpad.h
 create mode 100644 include/hw/fsi/fsi-master.h
 create mode 100644 include/hw/fsi/fsi-slave.h
 create mode 100644 include/hw/fsi/fsi.h
 create mode 100644 include/hw/fsi/lbus.h
 create mode 100644 include/hw/fsi/opb.h
 create mode 100644 hw/fsi/aspeed-apb2opb.c
 create mode 100644 hw/fsi/cfam.c
 create mode 100644 hw/fsi/engine-scratchpad.c
 create mode 100644 hw/fsi/fsi-master.c
 create mode 100644 hw/fsi/fsi-slave.c
 create mode 100644 hw/fsi/fsi.c
 create mode 100644 hw/fsi/lbus.c
 create mode 100644 hw/fsi/opb.c
 create mode 100644 tests/qtest/fsi-test.c
 create mode 100644 hw/fsi/Kconfig
 create mode 100644 hw/fsi/meson.build
 create mode 100644 hw/fsi/trace-events

-- 
2.39.2



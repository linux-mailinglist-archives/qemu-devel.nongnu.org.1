Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F29B7D1FD2
	for <lists+qemu-devel@lfdr.de>; Sat, 21 Oct 2023 23:23:44 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1quJR1-0007wL-47; Sat, 21 Oct 2023 17:23:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ninad@linux.ibm.com>)
 id 1quJQy-0007uK-Ta; Sat, 21 Oct 2023 17:23:00 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ninad@linux.ibm.com>)
 id 1quJQt-0006Om-G9; Sat, 21 Oct 2023 17:23:00 -0400
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 39LL9xAf005301; Sat, 21 Oct 2023 21:17:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=ibFKsK6fv6tw1i66Pmc2TVaCO/dIW0R8LkK7kZwDT0w=;
 b=Akr2nU/CrQDftx5ZkJwdWYCFO/lxSEwSTTdlRFKgSxvRCi1ANyCleW4IoJGHZ7GFbpW2
 /sAvInLpQ/T969v9zpBbjlEQKlZhT3OP60AXjHB+HSqkU93JMqJeWN8fHjJZbYM49icV
 8FneWmltQC8Gh05gtBYvQPdNemg4YyyzCRjgYK885HM8McxqHn+QzUxO2/DOgPyQpTAX
 B99tmbZVtUbH460gzuwq+9AQBafhGrE5ASf/NcaQalNSdqABNxVchy5cI0DndYhT2GGu
 uQuI6yajaw0QKrCBSNBQl5jNTdNktvEHUOEgfmVvxvvvdtG9Vo43vr6HU/nlXi4Z3dq0 jg== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3tvpadg5q8-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Sat, 21 Oct 2023 21:17:25 +0000
Received: from m0353725.ppops.net (m0353725.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 39LLBoj4008536;
 Sat, 21 Oct 2023 21:17:25 GMT
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3tvpadg5pw-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Sat, 21 Oct 2023 21:17:24 +0000
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 39LKaU71007090; Sat, 21 Oct 2023 21:17:24 GMT
Received: from smtprelay06.wdc07v.mail.ibm.com ([172.16.1.73])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 3tuc27wcag-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Sat, 21 Oct 2023 21:17:24 +0000
Received: from smtpav05.dal12v.mail.ibm.com (smtpav05.dal12v.mail.ibm.com
 [10.241.53.104])
 by smtprelay06.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 39LLHNKN65470894
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Sat, 21 Oct 2023 21:17:23 GMT
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id F2DD958052;
 Sat, 21 Oct 2023 21:17:22 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 9C32258056;
 Sat, 21 Oct 2023 21:17:22 +0000 (GMT)
Received: from gfwa153.aus.stglabs.ibm.com (unknown [9.3.84.127])
 by smtpav05.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Sat, 21 Oct 2023 21:17:22 +0000 (GMT)
From: Ninad Palsule <ninad@linux.ibm.com>
To: qemu-devel@nongnu.org, clg@kaod.org, peter.maydell@linaro.org,
 andrew@codeconstruct.com.au, joel@jms.id.au, pbonzini@redhat.com,
 marcandre.lureau@redhat.com, berrange@redhat.com, thuth@redhat.com,
 philmd@linaro.org, lvivier@redhat.com
Cc: Ninad Palsule <ninad@linux.ibm.com>, qemu-arm@nongnu.org
Subject: [PATCH v6 00/10] Introduce model for IBM's FSI
Date: Sat, 21 Oct 2023 16:17:09 -0500
Message-Id: <20231021211720.3571082-1-ninad@linux.ibm.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: USGtHlZC56hICitKYwgk_i8fnjeA0EXl
X-Proofpoint-GUID: uVFi5TxYHTdj8Gphz6ytK3D0VPRJp7hz
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-21_13,2023-10-19_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=1
 lowpriorityscore=0
 malwarescore=0 phishscore=0 priorityscore=1501 spamscore=1 mlxscore=1
 impostorscore=0 bulkscore=0 suspectscore=0 mlxlogscore=213 adultscore=0
 clxscore=1011 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2310170001 definitions=main-2310210195
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

Please review the patch-set version 6.
I have incorporated review comments from Cedric, Daniel and Thomas.

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
 docs/specs/fsi.rst                 | 141 +++++++++++++++
 meson.build                        |   1 +
 hw/fsi/trace.h                     |   1 +
 include/hw/arm/aspeed_soc.h        |   4 +
 include/hw/fsi/aspeed-apb2opb.h    |  33 ++++
 include/hw/fsi/cfam.h              |  34 ++++
 include/hw/fsi/engine-scratchpad.h |  32 ++++
 include/hw/fsi/fsi-master.h        |  30 ++++
 include/hw/fsi/fsi-slave.h         |  29 +++
 include/hw/fsi/fsi.h               |  37 ++++
 include/hw/fsi/lbus.h              |  43 +++++
 include/hw/fsi/opb.h               |  43 +++++
 hw/arm/aspeed_ast2600.c            |  19 ++
 hw/fsi/aspeed-apb2opb.c            | 280 +++++++++++++++++++++++++++++
 hw/fsi/cfam.c                      | 173 ++++++++++++++++++
 hw/fsi/engine-scratchpad.c         |  93 ++++++++++
 hw/fsi/fsi-master.c                | 201 +++++++++++++++++++++
 hw/fsi/fsi-slave.c                 |  96 ++++++++++
 hw/fsi/fsi.c                       |  25 +++
 hw/fsi/lbus.c                      |  76 ++++++++
 hw/fsi/opb.c                       | 164 +++++++++++++++++
 tests/qtest/fsi-test.c             | 207 +++++++++++++++++++++
 hw/Kconfig                         |   1 +
 hw/arm/Kconfig                     |   1 +
 hw/fsi/Kconfig                     |  23 +++
 hw/fsi/meson.build                 |   6 +
 hw/fsi/trace-events                |  21 +++
 hw/meson.build                     |   1 +
 tests/qtest/meson.build            |   1 +
 30 files changed, 1824 insertions(+)
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



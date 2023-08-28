Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 96EF878BB4C
	for <lists+qemu-devel@lfdr.de>; Tue, 29 Aug 2023 01:00:03 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qalCZ-0006Fn-6Z; Mon, 28 Aug 2023 18:59:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ninad@linux.ibm.com>)
 id 1qalCH-0005kk-Us; Mon, 28 Aug 2023 18:59:04 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ninad@linux.ibm.com>)
 id 1qalCF-0004nV-JG; Mon, 28 Aug 2023 18:59:01 -0400
Received: from pps.filterd (m0353727.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 37SM43aL002159; Mon, 28 Aug 2023 22:58:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=from : to : cc : subject
 : date : message-id : mime-version : content-type :
 content-transfer-encoding; s=pp1;
 bh=hrSKeEX52iQ1kog2soTHMnxXSiZHkFzUi5c9QTlcN2Q=;
 b=N1Qg6bn0KNpPlHKAx0NX/XCASjCTWtbmCbJHnCv/UYz3zmh/eZUqfFElKF9rjV967Zdl
 RmT/Smmzzs2abS1/9W7WghxpZqSyVyHmgwbmL18FpIeW6DHXFa+wZnXR6C5RGWb59Ffj
 lqcTdxteFU6jr+0mj8wjqET1jFciAdfUr347AmA4SceCDXIo2MEs1oTTl2QaGEttO4PG
 ZmF5KrP0juLtgDAYqOKP23TqgcDp8hMEsUOPpWbp38zpi6TaU/3tNsQ8qncHoWf8XiTd
 tT6KaImlCdRvQ/matH9P5E6vPXOx1eP9+ZbutYObKQwkW82QhoSVCII8rDlZlVep6Yty 5Q== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3sra09aqek-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 28 Aug 2023 22:58:47 +0000
Received: from m0353727.ppops.net (m0353727.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 37SMP8g5009962;
 Mon, 28 Aug 2023 22:58:46 GMT
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3sra09aqe6-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 28 Aug 2023 22:58:46 +0000
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 37SLhEqj014100; Mon, 28 Aug 2023 22:58:45 GMT
Received: from smtprelay02.wdc07v.mail.ibm.com ([172.16.1.69])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 3sqwxjpehk-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 28 Aug 2023 22:58:45 +0000
Received: from smtpav01.dal12v.mail.ibm.com (smtpav01.dal12v.mail.ibm.com
 [10.241.53.100])
 by smtprelay02.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 37SMwi3s3474054
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 28 Aug 2023 22:58:44 GMT
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 61A9058057;
 Mon, 28 Aug 2023 22:58:44 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 1BFCF58058;
 Mon, 28 Aug 2023 22:58:44 +0000 (GMT)
Received: from gfwa153.aus.stglabs.ibm.com (unknown [9.3.84.127])
 by smtpav01.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Mon, 28 Aug 2023 22:58:44 +0000 (GMT)
From: Ninad Palsule <ninad@linux.ibm.com>
To: qemu-devel@nongnu.org, clg@kaod.org, peter.maydell@linaro.org,
 andrew@aj.id.au, joel@jms.id.au, pbonzini@redhat.com,
 marcandre.lureau@redhat.com, berrange@redhat.com, thuth@redhat.com,
 philmd@linaro.org
Cc: Ninad Palsule <ninad@linux.ibm.com>, qemu-arm@nongnu.org
Subject: [PATCH v2 0/7] Introduce model for IBM's FSI
Date: Mon, 28 Aug 2023 17:58:35 -0500
Message-Id: <20230828225842.4045510-1-ninad@linux.ibm.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: uv1cbvXdTTmg2nijiNKSkjfQFzRQqukR
X-Proofpoint-GUID: g8_PcbLMtiFULC2S5TSmyzXzCt3u4F83
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-08-28_18,2023-08-28_04,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=2
 clxscore=1015
 lowpriorityscore=0 suspectscore=0 spamscore=2 bulkscore=0 mlxscore=2
 priorityscore=1501 adultscore=0 mlxlogscore=167 impostorscore=0
 malwarescore=0 phishscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2308100000 definitions=main-2308280194
Received-SPF: pass client-ip=148.163.156.1; envelope-from=ninad@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
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

Please review the patch-set version 2.
I have incorporated review comments from Joel.

Ninad Palsule (7):
  hw/fsi: Introduce IBM's Local bus
  hw/fsi: Introduce IBM's scratchpad
  hw/fsi: Introduce IBM's cfam,fsi-slave
  hw/fsi: Introduce IBM's FSI
  hw/fsi: IBM's On-chip Peripheral Bus
  hw/fsi: Aspeed APB2OPB interface
  hw/arm: Hook up FSI module in AST2600

 hw/Kconfig                         |   1 +
 hw/arm/Kconfig                     |   1 +
 hw/arm/aspeed_ast2600.c            |  19 ++
 hw/fsi/Kconfig                     |  23 ++
 hw/fsi/aspeed-apb2opb.c            | 352 +++++++++++++++++++++++++++++
 hw/fsi/cfam.c                      | 236 +++++++++++++++++++
 hw/fsi/engine-scratchpad.c         | 100 ++++++++
 hw/fsi/fsi-master.c                | 201 ++++++++++++++++
 hw/fsi/fsi-slave.c                 | 109 +++++++++
 hw/fsi/fsi.c                       |  54 +++++
 hw/fsi/lbus.c                      |  94 ++++++++
 hw/fsi/meson.build                 |   6 +
 hw/fsi/opb.c                       | 194 ++++++++++++++++
 hw/fsi/trace-events                |   2 +
 hw/fsi/trace.h                     |   1 +
 hw/meson.build                     |   1 +
 include/hw/arm/aspeed_soc.h        |   4 +
 include/hw/fsi/aspeed-apb2opb.h    |  33 +++
 include/hw/fsi/bits.h              |  15 ++
 include/hw/fsi/cfam.h              |  61 +++++
 include/hw/fsi/engine-scratchpad.h |  33 +++
 include/hw/fsi/fsi-master.h        |  30 +++
 include/hw/fsi/fsi-slave.h         |  29 +++
 include/hw/fsi/fsi.h               |  31 +++
 include/hw/fsi/lbus.h              |  48 ++++
 include/hw/fsi/opb.h               |  43 ++++
 include/qemu/bitops.h              |   6 +
 meson.build                        |   1 +
 28 files changed, 1728 insertions(+)
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
 create mode 100644 include/hw/fsi/bits.h
 create mode 100644 include/hw/fsi/cfam.h
 create mode 100644 include/hw/fsi/engine-scratchpad.h
 create mode 100644 include/hw/fsi/fsi-master.h
 create mode 100644 include/hw/fsi/fsi-slave.h
 create mode 100644 include/hw/fsi/fsi.h
 create mode 100644 include/hw/fsi/lbus.h
 create mode 100644 include/hw/fsi/opb.h

-- 
2.39.2



Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id AC8799B56B4
	for <lists+qemu-devel@lfdr.de>; Wed, 30 Oct 2024 00:23:38 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t5vXf-0004Da-JH; Tue, 29 Oct 2024 19:22:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>) id 1t5vXb-0004Cz-IS
 for qemu-devel@nongnu.org; Tue, 29 Oct 2024 19:22:23 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>) id 1t5vXa-00045j-1S
 for qemu-devel@nongnu.org; Tue, 29 Oct 2024 19:22:23 -0400
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49TLKLKj012566;
 Tue, 29 Oct 2024 23:22:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=pp1; bh=6APVo9fDg4j77qN67kGc2dJLQM0pKjRWMwYonPDvl
 iU=; b=ZC9Vp8s7xYFca6mUrRPmVgmR9JiVpiNAElPrCWrSB2HzlKgl/VpFbhDZ1
 4IRHhonz2EOgFeQmRN9lWSVehZ+X8epx7pCLH9ycewd1DLGxSlKKOQmBQWeGtcoC
 Kx8dU13Ajn0g+Pd7PEiqmRMv1FcnJIiiRwxI0PSrcwvNxZIbVBYe/R/yHFPNL0sW
 FLXwpvTCUnTFvnzwmnP62x0CNTrR8EioHlP1giNE4lD0ApP2zLsah4tU5YMiO8mx
 N8jKUWkZT2RFZsvS8K6C6DiBJXuC6gsvjomtmR1B0o9Kn6k2pS3eSW2YoeALRtod
 XC0WRkmhycvRgeUO75w6T99Qovkbg==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 42k6gt0jx0-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 29 Oct 2024 23:22:17 +0000 (GMT)
Received: from m0360072.ppops.net (m0360072.ppops.net [127.0.0.1])
 by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 49TNMG0m010549;
 Tue, 29 Oct 2024 23:22:16 GMT
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 42k6gt0jwy-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 29 Oct 2024 23:22:16 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 49TJKCbR024726;
 Tue, 29 Oct 2024 23:22:16 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 42hcyjd51f-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 29 Oct 2024 23:22:15 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com
 [10.20.54.103])
 by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 49TNMEOe54853928
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 29 Oct 2024 23:22:14 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 4445720043;
 Tue, 29 Oct 2024 23:22:14 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id D719020040;
 Tue, 29 Oct 2024 23:22:13 +0000 (GMT)
Received: from heavy.ibm.com (unknown [9.171.12.2])
 by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Tue, 29 Oct 2024 23:22:13 +0000 (GMT)
From: Ilya Leoshkevich <iii@linux.ibm.com>
To: Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>
Cc: qemu-devel@nongnu.org, Michael Tokarev <mjt@tls.msk.ru>,
 Brian Cain <bcain@quicinc.com>,
 "ltaylorsimpson @ gmail . com" <ltaylorsimpson@gmail.com>,
 Ilya Leoshkevich <iii@linux.ibm.com>
Subject: [PATCH v3 0/2] linux-user: Allow mapping low priority rt signals
Date: Wed, 30 Oct 2024 00:17:46 +0100
Message-ID: <20241029232211.206766-1-iii@linux.ibm.com>
X-Mailer: git-send-email 2.47.0
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: Qblx9x__HW5l8SgX7SC32xWJw3oOwXnB
X-Proofpoint-ORIG-GUID: moZtEYMz2InOSE-sUAibupGqciTH7Y4t
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0
 priorityscore=1501 impostorscore=0 suspectscore=0 lowpriorityscore=0
 mlxscore=0 clxscore=1015 phishscore=0 adultscore=0 spamscore=0 bulkscore=0
 mlxlogscore=862 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2410290175
Received-SPF: pass client-ip=148.163.158.5; envelope-from=iii@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

v1: Unfortunately lost.

v2: https://lore.kernel.org/qemu-devel/20240212205022.242968-1-iii@linux.ibm.com/
v2 -> v3: Make the mapping configurable (Richard).

Hi,

There are apps out there that want to use SIGRTMAX, which linux-user
currently does not map to a host signal. The reason is that with the
current approach it's not possible to map all target signals, so it
was decided to sacrifice the end of the range.

This series improves the situation by making the mapping configurable.
Patch 1 is the implementation, patch 2 is a test.

Best regards,
Ilya

Ilya Leoshkevich (2):
  linux-user: Allow custom rt signal mappings
  tests/tcg: Add SIGRTMIN/SIGRTMAX test

 linux-user/main.c                             |  12 +-
 linux-user/signal-common.h                    |   2 +-
 linux-user/signal.c                           | 108 ++++++++++++++----
 meson.build                                   |   3 +-
 meson_options.txt                             |   2 +
 scripts/meson-buildoptions.sh                 |   2 +
 tests/tcg/Makefile.target                     |   4 +-
 tests/tcg/multiarch/linux/linux-sigrtminmax.c |  74 ++++++++++++
 8 files changed, 182 insertions(+), 25 deletions(-)
 create mode 100644 tests/tcg/multiarch/linux/linux-sigrtminmax.c

-- 
2.47.0



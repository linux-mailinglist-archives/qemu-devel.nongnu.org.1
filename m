Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DB26F75A197
	for <lists+qemu-devel@lfdr.de>; Thu, 20 Jul 2023 00:16:12 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qMFQO-00075g-Ks; Wed, 19 Jul 2023 18:13:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>)
 id 1qMFQH-0006yE-7M; Wed, 19 Jul 2023 18:13:30 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>)
 id 1qMFQB-0002BV-Ir; Wed, 19 Jul 2023 18:13:28 -0400
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 36JM7iAF031496; Wed, 19 Jul 2023 22:13:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=from : to : cc : subject
 : date : message-id : content-transfer-encoding : mime-version; s=pp1;
 bh=wHh3H6emH8WxW3O1tpyBKo+r7Tu9dTCcI8847oTnD5s=;
 b=qTCd0RtIxdFkZqwmG5FbcsNS1i5qe+PyZKVz7/DwONXTlWl7ZLcRxdMlOCV5F92ozQ7p
 Ok+MCJS47nMKgIYlUd/OQ1XUPxGQUJ0NVLcWtqR072dwXsNz2cwOzDoIMM8SnXvkzRw8
 eH1gK0rUesgeG4xtbuHYmUJV4QUV8BGl12n1AMqJkLv/WO00ShEe2ZV/74/ZeKV8HQva
 bNinRVNdb6toY8kRiDHhXOqxFBhC6jjQv+U5vcRHw+99A4B983NDVCWaM5oKsIps6lVf
 aNpDaZLBZKapkGYccebwG9tZGx8Ji7TfelIPExzo+kwhpd1VVm4S5G7WeEhLrCrYicuz 2Q== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3rxnbn4fn2-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 19 Jul 2023 22:13:17 +0000
Received: from m0360083.ppops.net (m0360083.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 36JM8r8Q004145;
 Wed, 19 Jul 2023 22:13:17 GMT
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3rxnbn4fms-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 19 Jul 2023 22:13:17 +0000
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 36JK0Yjh029098; Wed, 19 Jul 2023 22:13:15 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3rv6smktjw-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 19 Jul 2023 22:13:15 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com
 [10.20.54.105])
 by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 36JMDD3d32112976
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 19 Jul 2023 22:13:13 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id C3F9520065;
 Wed, 19 Jul 2023 22:13:13 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 49C822005A;
 Wed, 19 Jul 2023 22:13:13 +0000 (GMT)
Received: from heavy.boeblingen.de.ibm.com (unknown [9.171.5.152])
 by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Wed, 19 Jul 2023 22:13:13 +0000 (GMT)
From: Ilya Leoshkevich <iii@linux.ibm.com>
To: Richard Henderson <richard.henderson@linaro.org>,
 David Hildenbrand <david@redhat.com>, Thomas Huth <thuth@redhat.com>
Cc: qemu-s390x@nongnu.org, qemu-devel@nongnu.org,
 Ilya Leoshkevich <iii@linux.ibm.com>
Subject: [PATCH v3 00/14] target/s390x: Miscellaneous TCG fixes, part 2
Date: Thu, 20 Jul 2023 00:11:12 +0200
Message-ID: <20230719221310.1968845-1-iii@linux.ibm.com>
X-Mailer: git-send-email 2.41.0
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 3KR0gCk9623QTKLZDxIdY7VtfzdDig-v
X-Proofpoint-ORIG-GUID: u9Kixow_Ozq38vxq9Dg8fJceyVk5iaf7
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-19_16,2023-07-19_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 impostorscore=0
 spamscore=0 lowpriorityscore=0 bulkscore=0 mlxlogscore=971 phishscore=0
 priorityscore=1501 mlxscore=0 suspectscore=0 adultscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2306200000
 definitions=main-2307190199
Received-SPF: pass client-ip=148.163.156.1; envelope-from=iii@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_MSPIKE_H5=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

v2: https://lists.gnu.org/archive/html/qemu-devel/2023-07/msg03762.html
v2 -> v3: Document the new constraint set (Philippe).
          Fix clang build (Thomas).
          Add T-bs.

v1: https://lists.gnu.org/archive/html/qemu-devel/2023-07/msg03648.html
v1 -> v2: Move the case in 04/14 (David).
          Simplify the reserved type checking in 07/14 (David).
          Add R-bs.

Hi,

Here is another set of fixes for issues found by randomized testing.

Most of them have to do with simple insufficient error handling or
corner cases, but 3/14 and 6/14 took a while to figure out, and
hopefully I got the fixes right. 13/14 is a test for an issue that
Richard has already fixed, but I thought it would be helpful to have it
anyway.

Best regards,
Ilya

Ilya Leoshkevich (14):
  target/s390x: Make CKSM raise an exception if R2 is odd
  target/s390x: Fix CLM with M3=0
  target/s390x: Fix CONVERT TO LOGICAL/FIXED with out-of-range inputs
  target/s390x: Fix ICM with M3=0
  target/s390x: Make MC raise specification exception when class >= 16
  tcg/{i386,s390x}: Add earlyclobber to the op_add2's first output
  target/s390x: Fix assertion failure in VFMIN/VFMAX with type 13
  tests/tcg/s390x: Test CKSM
  tests/tcg/s390x: Test CLGEBR and CGEBRA
  tests/tcg/s390x: Test CLM
  tests/tcg/s390x: Test ICM
  tests/tcg/s390x: Test MC
  tests/tcg/s390x: Test STPQ
  tests/tcg/s390x: Test VCKSM

 target/s390x/tcg/excp_helper.c          |  2 +-
 target/s390x/tcg/fpu_helper.c           |  3 +-
 target/s390x/tcg/mem_helper.c           |  5 +++
 target/s390x/tcg/translate.c            | 21 ++++++++--
 target/s390x/tcg/translate_vx.c.inc     |  2 +-
 tcg/i386/tcg-target-con-set.h           |  5 ++-
 tcg/i386/tcg-target.c.inc               |  2 +-
 tcg/s390x/tcg-target-con-set.h          |  8 ++--
 tcg/s390x/tcg-target.c.inc              |  4 +-
 tcg/tcg.c                               |  8 +++-
 tests/tcg/s390x/Makefile.softmmu-target |  5 +++
 tests/tcg/s390x/Makefile.target         |  6 +++
 tests/tcg/s390x/cgebra.c                | 32 ++++++++++++++
 tests/tcg/s390x/cksm.S                  | 29 +++++++++++++
 tests/tcg/s390x/clgebr.c                | 32 ++++++++++++++
 tests/tcg/s390x/clm.S                   | 29 +++++++++++++
 tests/tcg/s390x/icm.S                   | 32 ++++++++++++++
 tests/tcg/s390x/mc.S                    | 56 +++++++++++++++++++++++++
 tests/tcg/s390x/stpq.S                  | 20 +++++++++
 tests/tcg/s390x/vcksm.c                 | 31 ++++++++++++++
 tests/tcg/s390x/vx.h                    |  2 +
 21 files changed, 319 insertions(+), 15 deletions(-)
 create mode 100644 tests/tcg/s390x/cgebra.c
 create mode 100644 tests/tcg/s390x/cksm.S
 create mode 100644 tests/tcg/s390x/clgebr.c
 create mode 100644 tests/tcg/s390x/clm.S
 create mode 100644 tests/tcg/s390x/icm.S
 create mode 100644 tests/tcg/s390x/mc.S
 create mode 100644 tests/tcg/s390x/stpq.S
 create mode 100644 tests/tcg/s390x/vcksm.c

-- 
2.41.0



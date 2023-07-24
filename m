Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EB8075ED61
	for <lists+qemu-devel@lfdr.de>; Mon, 24 Jul 2023 10:24:05 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qNqod-00019N-0V; Mon, 24 Jul 2023 04:21:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>)
 id 1qNqoA-00017o-Fz; Mon, 24 Jul 2023 04:20:49 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>)
 id 1qNqo8-0001Lz-BO; Mon, 24 Jul 2023 04:20:46 -0400
Received: from pps.filterd (m0353723.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 36O7WchI004844; Mon, 24 Jul 2023 08:20:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=from : to : cc : subject
 : date : message-id : content-transfer-encoding : mime-version; s=pp1;
 bh=1yT1Vqp/eGOafM4+GVtTpWVCV3t5bTA7uTt0LLwwlkc=;
 b=IDJWs7QRZ4NK931Zm882T17wpQUY5NXEqsbclvGJTokT9KkUMvAUpdLKEULTq5V6uxQG
 BLThGf6fAiGag96OZPjr5r1f/kdgJ2Y4ZUxU3mezbsoucIWF+wOrZmr2t75xqIEmdXaR
 yVoNvwBPuSVCyzrirUpbrgHMoCeNMDtPeLSJb68/zMHWqsZ4jjuUOMsl8M7nwKADxKF3
 elD6FQlHU/B96yclE3DrzMZ+11u+/RmqzfqYPs/qm3SuxgfU6wU37Ynr6ELBHAbX0dDy
 wtSN0VaPL+BR26HSgV1ow1V4CPCUDc3aNK8ZOCb3oHVQfcKWuhse7fChoJ320VthpG0s 7Q== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3s1muwhmms-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 24 Jul 2023 08:20:39 +0000
Received: from m0353723.ppops.net (m0353723.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 36O7p3cZ028109;
 Mon, 24 Jul 2023 08:20:38 GMT
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3s1muwhmmd-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 24 Jul 2023 08:20:38 +0000
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 36O6GRNp001981; Mon, 24 Jul 2023 08:20:38 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3s0temhgk6-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 24 Jul 2023 08:20:38 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com
 [10.20.54.106])
 by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 36O8KarJ30671344
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 24 Jul 2023 08:20:36 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id F167C2004D;
 Mon, 24 Jul 2023 08:20:35 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 7C4BB20040;
 Mon, 24 Jul 2023 08:20:35 +0000 (GMT)
Received: from heavy.boeblingen.de.ibm.com (unknown [9.171.11.212])
 by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Mon, 24 Jul 2023 08:20:35 +0000 (GMT)
From: Ilya Leoshkevich <iii@linux.ibm.com>
To: Richard Henderson <richard.henderson@linaro.org>,
 David Hildenbrand <david@redhat.com>, Thomas Huth <thuth@redhat.com>
Cc: qemu-s390x@nongnu.org, qemu-devel@nongnu.org,
 Ilya Leoshkevich <iii@linux.ibm.com>
Subject: [PATCH v4 00/14] target/s390x: Miscellaneous TCG fixes, part 2
Date: Mon, 24 Jul 2023 10:15:53 +0200
Message-ID: <20230724082032.66864-1-iii@linux.ibm.com>
X-Mailer: git-send-email 2.41.0
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: epLervdVm3wSSOeZ49ZYEwuPqcvbC7pg
X-Proofpoint-GUID: cNq0YH5By_nIbaFfbGY-VS1OuxQgfKTa
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-24_06,2023-07-20_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 impostorscore=0
 mlxlogscore=999 phishscore=0 bulkscore=0 priorityscore=1501 malwarescore=0
 adultscore=0 suspectscore=0 clxscore=1015 mlxscore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2306200000
 definitions=main-2307240071
Received-SPF: pass client-ip=148.163.158.5; envelope-from=iii@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -29
X-Spam_score: -3.0
X-Spam_bar: ---
X-Spam_report: (-3.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_MSPIKE_H5=-1,
 RCVD_IN_MSPIKE_WL=-0.01, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

v3: https://lists.gnu.org/archive/html/qemu-devel/2023-07/msg03902.html
v3 -> v4: Introduce in2_ra2_E (Richard).
          Use probe_read (Richard).
          Add R-bs.
          Patches needing review: [01/14], [08/14]-[14/14].

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
 target/s390x/tcg/insn-data.h.inc        |  2 +-
 target/s390x/tcg/mem_helper.c           |  5 +++
 target/s390x/tcg/translate.c            | 16 ++++++-
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
 22 files changed, 317 insertions(+), 14 deletions(-)
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



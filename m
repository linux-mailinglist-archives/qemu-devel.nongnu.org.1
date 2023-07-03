Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 42F05746041
	for <lists+qemu-devel@lfdr.de>; Mon,  3 Jul 2023 18:00:27 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qGLwW-0002YL-Qx; Mon, 03 Jul 2023 11:58:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>)
 id 1qGLwT-0002Md-8l; Mon, 03 Jul 2023 11:58:21 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>)
 id 1qGLwQ-0004fb-Pi; Mon, 03 Jul 2023 11:58:21 -0400
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 363Fkt4O007873; Mon, 3 Jul 2023 15:58:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=5HuMpvKKMcZAdA4WPLtUYxSHaraoH0U4uyrdFjzJJIo=;
 b=FqFwEINleI6mEmwRtIhCfhLY2TZawWYLqQBIzy9WlizizhemgoZ9nCalIk/tg3G5JyEm
 63GJ+wDbxXC8W2XZx7zm6/Us3PK5zpI/myOC8xbj1HwxceGTzJe5hszbJJJO7xyIrD4f
 UNj2l6WWn38tWsmU2ktw8lDYRu0PR3aG0ujVXeB+o2GiKn4zhs48s/Pv+UWzAEHtoeQj
 H8zLEkTP/koojaZJynMTM2aUNQ6Us97h/XRJ0EjdgUP/Sirq3AkCU1hJNeMxCnbglite
 U+G2fSA5YsgGuOqdGoYcgq529j8qI7GOb9nBl8tC0GN4A9mrtt1lskRtnTGjwrNWZusO KA== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3rm19b8873-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 03 Jul 2023 15:58:13 +0000
Received: from m0360083.ppops.net (m0360083.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 363Fl4Ev008368;
 Mon, 3 Jul 2023 15:58:13 GMT
Received: from ppma06fra.de.ibm.com (48.49.7a9f.ip4.static.sl-reverse.com
 [159.122.73.72])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3rm19b886f-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 03 Jul 2023 15:58:12 +0000
Received: from pps.filterd (ppma06fra.de.ibm.com [127.0.0.1])
 by ppma06fra.de.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 3632peea030302;
 Mon, 3 Jul 2023 15:58:10 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
 by ppma06fra.de.ibm.com (PPS) with ESMTPS id 3rjbdds1qc-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 03 Jul 2023 15:58:10 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com
 [10.20.54.102])
 by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 363Fw8tF21758516
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 3 Jul 2023 15:58:08 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 0E72120043;
 Mon,  3 Jul 2023 15:58:08 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id D943720040;
 Mon,  3 Jul 2023 15:58:07 +0000 (GMT)
Received: from heavy.boeblingen.de.ibm.com (unknown [9.155.200.166])
 by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Mon,  3 Jul 2023 15:58:07 +0000 (GMT)
From: Ilya Leoshkevich <iii@linux.ibm.com>
To: Laurent Vivier <laurent@vivier.eu>,
 Richard Henderson <richard.henderson@linaro.org>,
 David Hildenbrand <david@redhat.com>
Cc: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org,
 qemu-s390x@nongnu.org, Ilya Leoshkevich <iii@linux.ibm.com>
Subject: [PATCH 00/12] target/s390x: Miscellaneous TCG fixes
Date: Mon,  3 Jul 2023 17:50:26 +0200
Message-ID: <20230703155801.179167-1-iii@linux.ibm.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: XV_r34_rkzRBcdXglWtjX6C6BcFSnQJs
X-Proofpoint-ORIG-GUID: XEfVfOREIrV1KPvLUHFm6gVA_3Fqtt92
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-03_11,2023-06-30_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 impostorscore=0
 spamscore=0 bulkscore=0 lowpriorityscore=0 suspectscore=0 adultscore=0
 mlxscore=0 mlxlogscore=910 malwarescore=0 priorityscore=1501 clxscore=1015
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2305260000
 definitions=main-2307030141
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

Hi,

Randomized testing found a number of issues in the s390x emulation.
This series fixes 6 of them (patches 2-7) and adds tests (patches
8-12); patch 1 is a cosmetic improvement needed for the EPSW test.

There are more issues, but I thought it would be better to send this
batch now.

Best regards,
Ilya

Ilya Leoshkevich (12):
  linux-user: elfload: Add more initial s390x PSW bits
  target/s390x: Fix EPSW CC reporting
  target/s390x: Fix MDEB and MDEBR
  target/s390x: Fix MVCRL with a large value in R0
  target/s390x: Fix LRA overwriting the top 32 bits on DAT error
  target/s390x: Fix LRA when DAT is off
  target/s390x: Fix relative long instructions with large offsets
  tests/tcg/s390x: Test EPSW
  tests/tcg/s390x: Test LARL with a large offset
  tests/tcg/s390x: Test LRA
  tests/tcg/s390x: Test MDEB and MDEBR
  tests/tcg/s390x: Test MVCRL with a large value in R0

 linux-user/elfload.c                    |  4 ++-
 target/s390x/helper.h                   |  2 +-
 target/s390x/mmu_helper.c               |  2 +-
 target/s390x/tcg/fpu_helper.c           |  3 +-
 target/s390x/tcg/insn-data.h.inc        |  4 +--
 target/s390x/tcg/mem_helper.c           |  5 +--
 target/s390x/tcg/translate.c            |  8 +++--
 tests/tcg/s390x/Makefile.softmmu-target |  1 +
 tests/tcg/s390x/Makefile.target         |  3 ++
 tests/tcg/s390x/epsw.c                  | 23 +++++++++++++
 tests/tcg/s390x/larl.c                  | 17 +++++++++
 tests/tcg/s390x/lra.S                   | 19 ++++++++++
 tests/tcg/s390x/mdeb.c                  | 30 ++++++++++++++++
 tests/tcg/s390x/mie3-mvcrl.c            | 46 +++++++++++++++++++------
 14 files changed, 147 insertions(+), 20 deletions(-)
 create mode 100644 tests/tcg/s390x/epsw.c
 create mode 100644 tests/tcg/s390x/larl.c
 create mode 100644 tests/tcg/s390x/lra.S
 create mode 100644 tests/tcg/s390x/mdeb.c

-- 
2.41.0



Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DCFAA746BA3
	for <lists+qemu-devel@lfdr.de>; Tue,  4 Jul 2023 10:16:06 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qGbBz-0003KI-79; Tue, 04 Jul 2023 04:15:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>)
 id 1qGbBv-0003Gv-LW; Tue, 04 Jul 2023 04:15:19 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>)
 id 1qGbBt-0002VW-Mq; Tue, 04 Jul 2023 04:15:19 -0400
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 3647pYLW018110; Tue, 4 Jul 2023 08:15:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=from : to : cc : subject
 : date : message-id : content-transfer-encoding : mime-version; s=pp1;
 bh=orxdWGWLZE08rUq4EKAoZG4nu9fUZZxdziCCKzvVvgo=;
 b=Q8crJ/LXMGW/YLx34gY8mfWq2SWNVRfcw3qYYsUhREX81YLOYnJgKdrxO7fgcNUdgmyZ
 j6GkzkYxo/XzOBArZ0/EbbYlEhC8D3Mg1fj6ysRBfwuZ/I/9/Hpz/Di5acl8iMSDNnTZ
 WBeJaVQ2z0xG/HCDN+QuyEVnJgATQncRPasyFVM/uPyWi2+rhXlNkxDhOTkG2rVwFmWm
 TKHoPI7ZAfGYbIk8SeYAn/Bd20N5upPlC8jDvtOJA6AADy/7etBxzD2f1vAXrQnhvkjn
 qtbuXN80L6l+L/uugae0AWuIh4iS/N1Js1sgzEtSK2vTjcHDy1n8RMRbufca6ltVYok1 jw== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3rmfdg8ju7-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 04 Jul 2023 08:15:15 +0000
Received: from m0353725.ppops.net (m0353725.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 3648FEkm009755;
 Tue, 4 Jul 2023 08:15:14 GMT
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com
 [169.51.49.98])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3rmfdg8jt2-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 04 Jul 2023 08:15:14 +0000
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
 by ppma03ams.nl.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 3645s7Bf032565;
 Tue, 4 Jul 2023 08:15:12 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
 by ppma03ams.nl.ibm.com (PPS) with ESMTPS id 3rjbs4swc9-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 04 Jul 2023 08:15:12 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com
 [10.20.54.104])
 by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 3648FANr42992200
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 4 Jul 2023 08:15:10 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 33D8120043;
 Tue,  4 Jul 2023 08:15:10 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 995E52004B;
 Tue,  4 Jul 2023 08:15:09 +0000 (GMT)
Received: from heavy.boeblingen.de.ibm.com (unknown [9.179.30.217])
 by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Tue,  4 Jul 2023 08:15:09 +0000 (GMT)
From: Ilya Leoshkevich <iii@linux.ibm.com>
To: Laurent Vivier <laurent@vivier.eu>,
 Richard Henderson <richard.henderson@linaro.org>,
 David Hildenbrand <david@redhat.com>
Cc: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org,
 qemu-s390x@nongnu.org, Ilya Leoshkevich <iii@linux.ibm.com>
Subject: [PATCH v2 00/12] target/s390x: Miscellaneous TCG fixes
Date: Tue,  4 Jul 2023 10:12:24 +0200
Message-ID: <20230704081506.276055-1-iii@linux.ibm.com>
X-Mailer: git-send-email 2.41.0
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: DpgPAG-1ltDYVdWmeDIKpFNc-bVjyiqA
X-Proofpoint-GUID: ZW7BWTDuhE1_D2wVGlbC6hNCqmYKuEE4
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-04_04,2023-06-30_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0
 lowpriorityscore=0 bulkscore=0 mlxscore=0 mlxlogscore=975 malwarescore=0
 suspectscore=0 spamscore=0 phishscore=0 impostorscore=0 clxscore=1015
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2307040065
Received-SPF: pass client-ip=148.163.158.5; envelope-from=iii@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
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

v1: https://lists.gnu.org/archive/html/qemu-devel/2023-07/msg00454.html
v1 -> v2: Add ULL for a large constant (David).
          Add a comment explaining the usage of ALGFI in the LARL test.

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
 tests/tcg/s390x/larl.c                  | 21 +++++++++++
 tests/tcg/s390x/lra.S                   | 19 ++++++++++
 tests/tcg/s390x/mdeb.c                  | 30 ++++++++++++++++
 tests/tcg/s390x/mie3-mvcrl.c            | 46 +++++++++++++++++++------
 14 files changed, 151 insertions(+), 20 deletions(-)
 create mode 100644 tests/tcg/s390x/epsw.c
 create mode 100644 tests/tcg/s390x/larl.c
 create mode 100644 tests/tcg/s390x/lra.S
 create mode 100644 tests/tcg/s390x/mdeb.c

-- 
2.41.0



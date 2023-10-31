Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CFB437DC5FD
	for <lists+qemu-devel@lfdr.de>; Tue, 31 Oct 2023 06:38:49 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qxhRl-0003dC-73; Tue, 31 Oct 2023 01:37:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>)
 id 1qxhRf-0003br-2D; Tue, 31 Oct 2023 01:37:43 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>)
 id 1qxhRb-00047V-Qw; Tue, 31 Oct 2023 01:37:42 -0400
Received: from pps.filterd (m0353724.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 39V5EhFt024348; Tue, 31 Oct 2023 05:37:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=from : to : cc : subject
 : date : message-id : content-transfer-encoding : mime-version; s=pp1;
 bh=ne9riZN3XOR9GoBVo5Md/Nvn0McIv3jhGoa0bR7B5lk=;
 b=c2M8NIqb4H3fZ0UHXtJ2RZhF6cMa/CCvPpNhi3Ek2FS7RYhhGj2fK/DxHMt2eZET2vR1
 HR/VISYzdG7btJ2flRpB2otTxcKn+eSstB5lWUY3weH6pCR87qEItAgSQrYqQmYA3/v8
 PEot3IsWIf8aVq+0rf1QuMM0L7n6Sv/PJXEHDvDY6CIlcVcxIJ1oyBmWQXnqBlGNuh7J
 AkGySTBVOwhZrPg/472C2PNbYpJsWPeRB8aFua9ncUfNnZ5G/mIKZrv7Qu9DGO7ilFPw
 EZbW2boRbEqdpO9HJtyRQUqUYh0oPYaEDMD9dVnVz2ZY9On5nLgoSg9ZsnVO09Z7+Pqy Mw== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3u2u8sgwx2-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 31 Oct 2023 05:37:37 +0000
Received: from m0353724.ppops.net (m0353724.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 39V5UgZ6015822;
 Tue, 31 Oct 2023 05:37:28 GMT
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3u2u8sgwng-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 31 Oct 2023 05:37:28 +0000
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 39V5CBNw007726; Tue, 31 Oct 2023 05:37:24 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3u1dmne7y4-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 31 Oct 2023 05:37:23 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com
 [10.20.54.104])
 by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 39V5bLZu6292118
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 31 Oct 2023 05:37:22 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id DDA7C20043;
 Tue, 31 Oct 2023 05:37:21 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 6D3352004B;
 Tue, 31 Oct 2023 05:37:21 +0000 (GMT)
Received: from heavy.boeblingen.de.ibm.com (unknown [9.171.47.192])
 by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Tue, 31 Oct 2023 05:37:21 +0000 (GMT)
From: Ilya Leoshkevich <iii@linux.ibm.com>
To: Richard Henderson <richard.henderson@linaro.org>,
 David Hildenbrand <david@redhat.com>
Cc: Thomas Huth <thuth@redhat.com>, qemu-s390x@nongnu.org,
 qemu-devel@nongnu.org, Michael Tokarev <mjt@tls.msk.ru>,
 Ilya Leoshkevich <iii@linux.ibm.com>
Subject: [PATCH 0/4] target/s390x: CC fixes
Date: Tue, 31 Oct 2023 06:32:26 +0100
Message-ID: <20231031053718.347100-1-iii@linux.ibm.com>
X-Mailer: git-send-email 2.41.0
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 6g9dEht2UbYLT-FI1ry7D_1q3rkIdb07
X-Proofpoint-ORIG-GUID: wsXepmlZvxbO6kErs1B1OV7AvMYSp39e
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-30_13,2023-10-31_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxlogscore=999
 lowpriorityscore=0 suspectscore=0 spamscore=0 impostorscore=0 adultscore=0
 priorityscore=1501 malwarescore=0 mlxscore=0 bulkscore=0 clxscore=1015
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2310240000 definitions=main-2310310042
Received-SPF: pass client-ip=148.163.158.5; envelope-from=iii@linux.ibm.com;
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

Hi,

This series fixes two issues with updating CC. David was suggesting a
bigger rewrite [1], but I did not dare do this (yet). Instead, these
are targeted fixes: patch 1 helps with installing Fedora, and patch 3
addresses something I noticed when reviewing the code. Patches 2 and 4
are tests.

Best regards,
Ilya

[1] https://gitlab.com/qemu-project/qemu/-/issues/1865#note_1545060658

Ilya Leoshkevich (4):
  target/s390x: Fix CLC corrupting cc_src
  tests/tcg/s390x: Test CLC with inaccessible second operand
  target/s390x: Fix LAALG not updating cc_src
  tests/tcg/s390x: Test LAALG with negative cc_src

 target/s390x/tcg/translate.c    | 10 ++++---
 tests/tcg/s390x/Makefile.target |  2 ++
 tests/tcg/s390x/clc.c           | 48 +++++++++++++++++++++++++++++++++
 tests/tcg/s390x/laalg.c         | 27 +++++++++++++++++++
 4 files changed, 84 insertions(+), 3 deletions(-)
 create mode 100644 tests/tcg/s390x/clc.c
 create mode 100644 tests/tcg/s390x/laalg.c

-- 
2.41.0



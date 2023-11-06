Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C1137E1D55
	for <lists+qemu-devel@lfdr.de>; Mon,  6 Nov 2023 10:38:16 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qzw1t-0005QL-RT; Mon, 06 Nov 2023 04:36:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>)
 id 1qzw1p-0005OT-U1; Mon, 06 Nov 2023 04:36:17 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>)
 id 1qzw1n-0004o3-6M; Mon, 06 Nov 2023 04:36:17 -0500
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 3A68dDt7027660; Mon, 6 Nov 2023 09:36:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=from : to : cc : subject
 : date : message-id : content-transfer-encoding : mime-version; s=pp1;
 bh=FwnAyrqBuC6AVTsF9rwbsR2WiIvzYOuf75jjE5O1zc4=;
 b=OuH6Xb53HuyDVxCTZqkIvDFBfZse8DoNsHWb2Nf/lhwgTh2uJSucDhL7oRw15R8yHO/o
 Vy+XMlk0IGP/cNWq/ZAP0iXEaxu+4CwOtis7xCX75cBrbEWO1DVLUR1IszOcFLEoVG9m
 HRTEQ8zr7m0KUM0CdEtUZOq5o6WpLJilgxJSyNJEsaBWwAHVoOnacXHwdITw8/nArVcD
 ajwKk9zqYqkCr5Rc1NIdJODTSitLY49DlZSFTb3I4UNW2KAcO/QR4v16oYrfgKoYy3rc
 G7Sk4ahQn5Q6y98ccPT9AqbS1IzYg9EEYoISoIkOu1MLK14bwxFTEBuGhol8Y8eMqrHz Zw== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3u6vts9m12-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 06 Nov 2023 09:36:12 +0000
Received: from m0356516.ppops.net (m0356516.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 3A69BFq9011562;
 Mon, 6 Nov 2023 09:36:12 GMT
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3u6vts9m0j-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 06 Nov 2023 09:36:12 +0000
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 3A690GJm007971; Mon, 6 Nov 2023 09:36:11 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3u61sk853k-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 06 Nov 2023 09:36:11 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com
 [10.20.54.101])
 by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 3A69a93341681270
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 6 Nov 2023 09:36:09 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 76F8C2004E;
 Mon,  6 Nov 2023 09:36:09 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id EB21020043;
 Mon,  6 Nov 2023 09:36:08 +0000 (GMT)
Received: from heavy.boeblingen.de.ibm.com (unknown [9.171.47.192])
 by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Mon,  6 Nov 2023 09:36:08 +0000 (GMT)
From: Ilya Leoshkevich <iii@linux.ibm.com>
To: Richard Henderson <richard.henderson@linaro.org>,
 David Hildenbrand <david@redhat.com>
Cc: Thomas Huth <thuth@redhat.com>, qemu-s390x@nongnu.org,
 qemu-devel@nongnu.org, Michael Tokarev <mjt@tls.msk.ru>,
 Ilya Leoshkevich <iii@linux.ibm.com>
Subject: [PATCH v2 0/5] target/s390x: CC fixes
Date: Mon,  6 Nov 2023 10:31:21 +0100
Message-ID: <20231106093605.1349201-1-iii@linux.ibm.com>
X-Mailer: git-send-email 2.41.0
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: Ar71zhDJO7VvJ5p8fJ6Xb4FUrm_u_54B
X-Proofpoint-ORIG-GUID: XrQmu8J8cuDD56aadg_qFUYaNm-j41eH
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-06_07,2023-11-02_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 spamscore=0
 suspectscore=0 mlxscore=0 bulkscore=0 mlxlogscore=999 malwarescore=0
 impostorscore=0 clxscore=1015 lowpriorityscore=0 priorityscore=1501
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2310240000 definitions=main-2311060081
Received-SPF: pass client-ip=148.163.158.5; envelope-from=iii@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_MSPIKE_H4=0.001,
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

v1: https://lists.gnu.org/archive/html/qemu-devel/2023-10/msg10251.html
v1 -> v2: Introduce op_laa_addu64() (Richard).
          Add the ADD LOGICAL WITH CARRY test. This was intended to
          catch the issue mentioned by David, but did not succeed. I
          thought it would still be worthwile to include it as a
          regression test.

Hi,

This series fixes two issues with updating CC. David was suggesting a
bigger rewrite [1], but I did not dare do this (yet). Instead, these
are targeted fixes: patch 1 helps with installing Fedora, and patch 3
addresses something I noticed when reviewing the code. Patches 2, 4 and
5 are tests.

Best regards,
Ilya

[1] https://gitlab.com/qemu-project/qemu/-/issues/1865#note_1545060658

Ilya Leoshkevich (5):
  target/s390x: Fix CLC corrupting cc_src
  tests/tcg/s390x: Test CLC with inaccessible second operand
  target/s390x: Fix LAALG not updating cc_src
  tests/tcg/s390x: Test LAALG with negative cc_src
  tests/tcg/s390x: Test ADD LOGICAL WITH CARRY

 target/s390x/tcg/insn-data.h.inc         |   2 +-
 target/s390x/tcg/translate.c             |  26 +++-
 tests/tcg/s390x/Makefile.target          |   3 +
 tests/tcg/s390x/add-logical-with-carry.c | 156 +++++++++++++++++++++++
 tests/tcg/s390x/clc.c                    |  48 +++++++
 tests/tcg/s390x/laalg.c                  |  27 ++++
 6 files changed, 257 insertions(+), 5 deletions(-)
 create mode 100644 tests/tcg/s390x/add-logical-with-carry.c
 create mode 100644 tests/tcg/s390x/clc.c
 create mode 100644 tests/tcg/s390x/laalg.c

-- 
2.41.0



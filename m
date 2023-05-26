Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C1AD712C45
	for <lists+qemu-devel@lfdr.de>; Fri, 26 May 2023 20:14:22 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q2bvs-0005dP-Bl; Fri, 26 May 2023 14:12:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>)
 id 1q2bvq-0005cu-7Z; Fri, 26 May 2023 14:12:54 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>)
 id 1q2bvo-0007Rr-7r; Fri, 26 May 2023 14:12:54 -0400
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 34QHsxOl019461; Fri, 26 May 2023 18:12:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=from : to : cc : subject
 : date : message-id : content-transfer-encoding : mime-version; s=pp1;
 bh=0Fh9Nm21UoR3iGt0Cp7ZnzqUHYlUGeTKz3LrOBpDiPg=;
 b=cRoYnDbj2slZAbVtfDNjlk7JtlaAqGHrcktObAyQkYrGAUjo/HuaGHJiBF8iHCGPI+IW
 HXqFZcDrHT2YIEkWLajfyHLHyAuFkpIhvxRvdynT4W4yWolBbvM75fkUk1Rlu8veWafC
 jcJP7rZ9fnRIIf9ZYBRLr4VaP8ixlrHNtBs9T9smyzmhJTQ4LTxG3DflEyw1lVSZwnl4
 EdX5g2rxvXPl5vEdcfNKU1cPtWRGoLTvXlXaTG7cf/hmNGI3MjJmFel/G3N4OyKB/SLm
 rHKAnS9tL0EXcq8LoEulm+ULLaaKvQ+YkYyx2nUhdKAjEvGxV7xR458KHuNbfcZdvQYZ Ww== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3qtxgh54gd-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 26 May 2023 18:12:49 +0000
Received: from m0356516.ppops.net (m0356516.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 34QHeU13004544;
 Fri, 26 May 2023 18:12:49 GMT
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com
 [169.51.49.99])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3qtxgh54g5-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 26 May 2023 18:12:48 +0000
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
 by ppma04ams.nl.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 34QAjLQb026911;
 Fri, 26 May 2023 18:12:47 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
 by ppma04ams.nl.ibm.com (PPS) with ESMTPS id 3qppdk32ny-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 26 May 2023 18:12:46 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com
 [10.20.54.105])
 by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 34QICiGO43385366
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 26 May 2023 18:12:44 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id A340420043;
 Fri, 26 May 2023 18:12:44 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 2F20F20040;
 Fri, 26 May 2023 18:12:44 +0000 (GMT)
Received: from heavy.boeblingen.de.ibm.com (unknown [9.179.7.205])
 by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Fri, 26 May 2023 18:12:44 +0000 (GMT)
From: Ilya Leoshkevich <iii@linux.ibm.com>
To: Richard Henderson <richard.henderson@linaro.org>,
 David Hildenbrand <david@redhat.com>, Thomas Huth <thuth@redhat.com>
Cc: qemu-s390x@nongnu.org, qemu-devel@nongnu.org,
 Ilya Leoshkevich <iii@linux.ibm.com>
Subject: [PATCH 0/4] Fix Fedora 38 Clang on s390x
Date: Fri, 26 May 2023 20:12:36 +0200
Message-Id: <20230526181240.1425579-1-iii@linux.ibm.com>
X-Mailer: git-send-email 2.40.1
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: jxcY59W002-gQdPGQ7czvoZfHlWU0zNs
X-Proofpoint-GUID: RDTa25mfuTzubgwuRXh-vWKJJQek-F-z
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-05-26_08,2023-05-25_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 lowpriorityscore=0 suspectscore=0 impostorscore=0 mlxlogscore=882
 bulkscore=0 adultscore=0 phishscore=0 clxscore=1015 spamscore=0 mlxscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2304280000 definitions=main-2305260154
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

Hi,

It was reported that Fedora 38 Clang does not run correctly under
qemu-s390x [1]. Comparing qemu and real s390x instruction traces has
shown that the implementations of LCBB and LOCFHR were not fully
correct.

This series fixes the issues and adds tests. I can now run Fedora 38
Clang under s390x emulation and compile "hello world" with it.

Best regards,
Ilya

[1] https://bugzilla.redhat.com/show_bug.cgi?id=2209635

Ilya Leoshkevich (4):
  target/s390x: Fix LCBB overwriting the top 32 bits
  tests/tcg/s390x: Test LCBB
  target/s390x: Fix LOCFHR taking the wrong half of R2
  tests/tcg/s390x: Test LOCFHR

 target/s390x/tcg/insn-data.h.inc |  4 +--
 tests/tcg/s390x/Makefile.target  |  2 ++
 tests/tcg/s390x/lcbb.c           | 51 ++++++++++++++++++++++++++++++++
 tests/tcg/s390x/locfhr.c         | 29 ++++++++++++++++++
 4 files changed, 84 insertions(+), 2 deletions(-)
 create mode 100644 tests/tcg/s390x/lcbb.c
 create mode 100644 tests/tcg/s390x/locfhr.c

-- 
2.40.1



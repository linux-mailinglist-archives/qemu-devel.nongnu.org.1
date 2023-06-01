Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 376EE71F5F2
	for <lists+qemu-devel@lfdr.de>; Fri,  2 Jun 2023 00:31:36 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q4qos-0004Us-Hq; Thu, 01 Jun 2023 18:30:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>)
 id 1q4qoe-00041y-MR; Thu, 01 Jun 2023 18:30:46 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>)
 id 1q4qob-0005Rv-2r; Thu, 01 Jun 2023 18:30:42 -0400
Received: from pps.filterd (m0353726.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 351MB1L5014482; Thu, 1 Jun 2023 22:30:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=from : to : cc : subject
 : date : message-id : content-transfer-encoding : mime-version; s=pp1;
 bh=waFuu1Y151Pj7M4zmGdUPjEXMoNckk6m+k6shwUF/Gc=;
 b=snb+t9t3ZHzKwsw10VCRc+kcAI7OE0/uL3nSdIfDBbbgEzYWInZJg1Du+OnplEe3hTY0
 xedgWEzefsFGyxa1sQcxaigLMHf2y0b92204TZMc46HU2Yi5aol8ITdegRla4gUkq5jC
 bf0sUpm983+6xwGaZGE9i12WvmVUzhvDNxxbRU//LTRof/7VuKLJLpDlhU2pFUP+JZt0
 /HZBXCTMQkprM2X7mkvXaXpDg4Fdh8PHgKb1zjnRgqVUgXmgQv4HK3jK1IbABJVfs4F9
 Moicy/GBu1QSFBGc62LmiI7H00/Mu1mJBmBk+dispDx8Frfy16G+15CrEPR/nsf3ltNl 2Q== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3qy3kxrh69-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 01 Jun 2023 22:30:36 +0000
Received: from m0353726.ppops.net (m0353726.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 351MF8WC026734;
 Thu, 1 Jun 2023 22:30:35 GMT
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com
 [169.51.49.99])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3qy3kxrh5p-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 01 Jun 2023 22:30:35 +0000
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
 by ppma04ams.nl.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 351Ld6Iu026387;
 Thu, 1 Jun 2023 22:30:33 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
 by ppma04ams.nl.ibm.com (PPS) with ESMTPS id 3qu9g5arg2-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 01 Jun 2023 22:30:33 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com
 [10.20.54.106])
 by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 351MUUf228180990
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 1 Jun 2023 22:30:31 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id E346320040;
 Thu,  1 Jun 2023 22:30:30 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 6E88D20043;
 Thu,  1 Jun 2023 22:30:30 +0000 (GMT)
Received: from heavy.boeblingen.de.ibm.com (unknown [9.171.86.130])
 by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Thu,  1 Jun 2023 22:30:30 +0000 (GMT)
From: Ilya Leoshkevich <iii@linux.ibm.com>
To: Richard Henderson <richard.henderson@linaro.org>,
 David Hildenbrand <david@redhat.com>, Thomas Huth <thuth@redhat.com>
Cc: qemu-s390x@nongnu.org, qemu-devel@nongnu.org,
 Ilya Leoshkevich <iii@linux.ibm.com>
Subject: [PATCH 0/2] target/s390x: Fix MXDB and MXDBR
Date: Fri,  2 Jun 2023 00:30:25 +0200
Message-Id: <20230601223027.795501-1-iii@linux.ibm.com>
X-Mailer: git-send-email 2.40.1
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: eCfRmJCvhalWtyNO2Xj5dzxsoOv7Sgf5
X-Proofpoint-ORIG-GUID: hIN0wxpe5na2Xe62xFgNnImEvoicEbWN
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-06-01_08,2023-05-31_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 lowpriorityscore=0 spamscore=0 clxscore=1015 mlxlogscore=852
 malwarescore=0 phishscore=0 mlxscore=0 suspectscore=0 impostorscore=0
 bulkscore=0 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2304280000 definitions=main-2306010190
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

This is the last finding from [1].
With this fix, llvm-project testcases run without issues.

Best regards,
Ilya

[1] https://bugzilla.redhat.com/show_bug.cgi?id=2211472

Ilya Leoshkevich (2):
  target/s390x: Fix MXDB and MXDBR
  tests/tcg/s390x: Test MXDB and MXDBR

 target/s390x/helper.h            |  2 +-
 target/s390x/tcg/fpu_helper.c    |  5 +++--
 target/s390x/tcg/insn-data.h.inc |  4 ++--
 target/s390x/tcg/translate.c     |  8 +-------
 tests/tcg/s390x/Makefile.target  |  1 +
 tests/tcg/s390x/mxdb.c           | 30 ++++++++++++++++++++++++++++++
 6 files changed, 38 insertions(+), 12 deletions(-)
 create mode 100644 tests/tcg/s390x/mxdb.c

-- 
2.40.1



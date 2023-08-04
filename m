Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9174E770CBB
	for <lists+qemu-devel@lfdr.de>; Sat,  5 Aug 2023 02:35:53 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qS5Ff-0004ES-Hl; Fri, 04 Aug 2023 20:34:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>)
 id 1qS5FY-0004E3-IS; Fri, 04 Aug 2023 20:34:33 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>)
 id 1qS5FW-00054o-5z; Fri, 04 Aug 2023 20:34:31 -0400
Received: from pps.filterd (m0353726.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 3750UVfc013114; Sat, 5 Aug 2023 00:34:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=from : to : cc : subject
 : date : message-id : content-transfer-encoding : mime-version; s=pp1;
 bh=KjB8PB39N86h+0/TH1ME6MvxfSlrzYrmo3ncNPo5dQM=;
 b=rEFuTqbx1GsjXlYGSmjZRyKosz1bsw1vhEhdoOA2tPoSzI8CbiGy9B7QF5kY55IT3wAr
 VBMoWe/vJDMIlyPQ8go2c28rDl/EJyu+fL1dLtidlaZx3eXNHixgrFrj5mkpzSWsYvLX
 K7nsCav7I9x4s6jR3xlfiZyBQxbjfCOoCXc5t0ygCD0fEyDaRtdSVxYA9sPLCMzqn+U+
 uD7HlyOE8YM9Wk0W3+klMn7paDqF4fWL/LgeBX1+1Za0wCH5S5SFQVHtFC/TJXWEv0Wr
 99Wb9GVemPeeHapSPwTGVNF4ugPGFX5VJTu0Po+s61MHn0RXgdKe/nxzdoLKzE60aFGZ aQ== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3s9bxjr1mx-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Sat, 05 Aug 2023 00:34:25 +0000
Received: from m0353726.ppops.net (m0353726.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 3750YOd9022687;
 Sat, 5 Aug 2023 00:34:24 GMT
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3s9bxjr1mb-2
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Sat, 05 Aug 2023 00:34:24 +0000
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 374MgIjw027825; Fri, 4 Aug 2023 23:37:54 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3s8kp31x8d-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 04 Aug 2023 23:37:54 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com
 [10.20.54.101])
 by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 374NbqOc23265844
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 4 Aug 2023 23:37:52 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id CB13D2004B;
 Fri,  4 Aug 2023 23:37:52 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 3ECD020040;
 Fri,  4 Aug 2023 23:37:52 +0000 (GMT)
Received: from heavy.boeblingen.de.ibm.com (unknown [9.179.4.122])
 by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Fri,  4 Aug 2023 23:37:52 +0000 (GMT)
From: Ilya Leoshkevich <iii@linux.ibm.com>
To: Laurent Vivier <laurent@vivier.eu>,
 Richard Henderson <richard.henderson@linaro.org>,
 David Hildenbrand <david@redhat.com>, Thomas Huth <thuth@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-s390x@nongnu.org,
 Claudio Fontana <cfontana@suse.de>, Ilya Leoshkevich <iii@linux.ibm.com>
Subject: [PATCH 0/3] target/s390x: Fix the "ignored match" case in VSTRS
Date: Sat,  5 Aug 2023 01:03:16 +0200
Message-ID: <20230804233748.218935-1-iii@linux.ibm.com>
X-Mailer: git-send-email 2.41.0
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 9dCc_A2XTOGWjxPKc14TbSUJ1fk9vgro
X-Proofpoint-GUID: Ug0VQWs9TTBJcnVmQCIGOFW_szzfjEcq
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-08-04_23,2023-08-03_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 mlxlogscore=999
 impostorscore=0 mlxscore=0 lowpriorityscore=0 adultscore=0 clxscore=1015
 suspectscore=0 bulkscore=0 priorityscore=1501 spamscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2306200000
 definitions=main-2308050003
Received-SPF: pass client-ip=148.163.156.1; envelope-from=iii@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_MSPIKE_H5=0.001,
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

this series should hopefully fix the issue with __strstr_arch13(),
which Claudio reported. I have to admit I did not manage to fully
reproduce it, but at least with this change the traces of a simple test
from TCG and real hardware match.

I've also fuzzed the changed helper and strstr() itself; not sure
whether anything generic may come out of it, but here are the links
anyway [1] [2].

Patch 1 makes glibc pick __strstr_arch13() in qemu-user, patch 2 is the
fix and patch 3 is the test (generated from Claudio's strings and
further fuzzer's findings).

[1] https://gist.github.com/iii-i/5adad06d911c46079d4388001b22ab61
[2] https://gist.github.com/iii-i/c425800e75796eae65660491ac511356

Ilya Leoshkevich (3):
  linux-user/elfload: Enable vxe2 on s390x
  target/s390x: Fix the "ignored match" case in VSTRS
  tests/tcg/s390x: Test VSTRS

 linux-user/elfload.c                 |  1 +
 target/s390x/tcg/vec_string_helper.c | 54 ++++++-----------
 tests/tcg/s390x/Makefile.target      |  1 +
 tests/tcg/s390x/vxeh2_vstrs.c        | 88 ++++++++++++++++++++++++++++
 4 files changed, 107 insertions(+), 37 deletions(-)
 create mode 100644 tests/tcg/s390x/vxeh2_vstrs.c

-- 
2.41.0



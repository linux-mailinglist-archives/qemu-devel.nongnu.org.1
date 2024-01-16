Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 115ED82E56F
	for <lists+qemu-devel@lfdr.de>; Tue, 16 Jan 2024 01:42:23 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rPXWh-0001Ls-JA; Mon, 15 Jan 2024 19:41:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>) id 1rPXWf-0001Lj-WF
 for qemu-devel@nongnu.org; Mon, 15 Jan 2024 19:41:58 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>) id 1rPXWe-0000xD-E8
 for qemu-devel@nongnu.org; Mon, 15 Jan 2024 19:41:57 -0500
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 40FLSbv7005577; Tue, 16 Jan 2024 00:41:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=OjJ976z0/PC1HqewMwvxjHE95E4BYy99kbpxM2BODOA=;
 b=Vmp/1Rc4pI/juyX30zhmz5cTgWEAxzMUXrcGbJzn2epadT/6oFbnFS9GU/OpRoVs0vFC
 3/Uruts/7Ij69dDgGvfxI0sCJXDPaS+Cm0p+mNFINDwyt5gFvh4pnY72DUkM8nD7uySe
 Xa6jzEWWHqu0gKujktXf65W0EH7vYkFZLV1CiH3QskGgmflSM548Uoj57K78EnoAH8tZ
 3JvxPL1u0N8GQIsnLI+x02m7mVMPQH044tEhi4kMojpzIg1WAm1xd1k/J5lPiKyFV+Eh
 HmtpAz3OSCdlPzA6V77v9Vo5o7LkffVbn6cPUzO60Kn1wuBOaY0YqAL8NsHiwSOpR/zB sg== 
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3vncnekeba-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 16 Jan 2024 00:41:48 +0000
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 40FM55M0026494; Tue, 16 Jan 2024 00:41:47 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 3vm72ju55a-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 16 Jan 2024 00:41:47 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com
 [10.20.54.101])
 by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 40G0fjb513894200
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 16 Jan 2024 00:41:45 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id A9D7F20043;
 Tue, 16 Jan 2024 00:41:45 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 4276F20040;
 Tue, 16 Jan 2024 00:41:45 +0000 (GMT)
Received: from heavy.boeblingen.de.ibm.com (unknown [9.179.4.64])
 by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Tue, 16 Jan 2024 00:41:45 +0000 (GMT)
From: Ilya Leoshkevich <iii@linux.ibm.com>
To: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Riku Voipio <riku.voipio@iki.fi>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org, Ilya Leoshkevich <iii@linux.ibm.com>
Subject: [PATCH 0/2] gdbstub: Implement catching syscalls
Date: Tue, 16 Jan 2024 01:40:10 +0100
Message-ID: <20240116004141.78626-1-iii@linux.ibm.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: PkltrsZ6np5TXhQxLLzOVlsvelAA_t6_
X-Proofpoint-GUID: PkltrsZ6np5TXhQxLLzOVlsvelAA_t6_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-15_17,2024-01-15_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxscore=0 clxscore=1011
 phishscore=0 spamscore=0 lowpriorityscore=0 suspectscore=0 mlxlogscore=419
 impostorscore=0 adultscore=0 malwarescore=0 priorityscore=1501 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2401160002
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

Based-on: <20240116003551.75168-1-iii@linux.ibm.com>
([PATCH v3 0/3] linux-user: Allow gdbstub to ignore page protection)

Hi,

I noticed that GDB's "catch syscall" does not work with qemu-user.
This series adds the missing bits in [1/2] and a test in [2/2].
I'm basing this on my other series, since it contains useful gdbstub
test refactorings.

Best regards,
Ilya

Ilya Leoshkevich (2):
  gdbstub: Implement catching syscalls
  tests/tcg: Add the syscall catchpoint gdbstub test

 gdbstub/gdbstub.c                             | 11 +++-
 gdbstub/internals.h                           | 16 ++++++
 gdbstub/system.c                              |  1 +
 gdbstub/user-target.c                         | 39 ++++++++++++++
 gdbstub/user.c                                | 51 +++++++++++++++++-
 include/gdbstub/user.h                        | 29 ++++++++++-
 include/user/syscall-trace.h                  |  7 ++-
 tests/tcg/multiarch/Makefile.target           | 10 +++-
 tests/tcg/multiarch/catch-syscalls.c          | 51 ++++++++++++++++++
 tests/tcg/multiarch/gdbstub/catch-syscalls.py | 52 +++++++++++++++++++
 10 files changed, 260 insertions(+), 7 deletions(-)
 create mode 100644 tests/tcg/multiarch/catch-syscalls.c
 create mode 100644 tests/tcg/multiarch/gdbstub/catch-syscalls.py

-- 
2.43.0



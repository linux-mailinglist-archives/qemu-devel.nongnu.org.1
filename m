Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A51982EBF3
	for <lists+qemu-devel@lfdr.de>; Tue, 16 Jan 2024 10:45:33 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rPfzi-0008SF-RS; Tue, 16 Jan 2024 04:44:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>) id 1rPfzf-0008S4-Md
 for qemu-devel@nongnu.org; Tue, 16 Jan 2024 04:44:28 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>) id 1rPfzd-00035W-0m
 for qemu-devel@nongnu.org; Tue, 16 Jan 2024 04:44:26 -0500
Received: from pps.filterd (m0353728.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 40G8RGSd030939; Tue, 16 Jan 2024 09:44:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=from : to : cc : subject
 : date : message-id : content-transfer-encoding : mime-version; s=pp1;
 bh=ckw+lsiAy2SdvGccVA2iFVpz5TW9KVzUFAZmrLaT0eU=;
 b=b3s0OBFmYRo2kYuub8wftsHQbh7daCUYMKU0wvFdVvwlkAK/wFVZTQn4ETjyPpY0Ae/N
 OUrr2Ecu7ARiy3d5iCXmCePUQdpPOxaUFg9yYfKhRmqsNqdh6qqUiULekPI6MNXxcEb6
 hYj7/OU6Oz+qPCZjgf/m4KWqtIBEK8k4/LpPmozskav+yQJpFFSRxgCjt6MC6uWSOiOE
 Ql5bqPiMXoTH8eoL7MVosANi7oDg198r903p06F2IqENUwBWWOWoSK6TvLGfyD15d73k
 Nfw2Nwqldx8S/9i9DDZUK/B79qdniiZhqnnIdcubNJP1Qe5CDiT1ckytJYLNMumxUllP Rg== 
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3vnpa2su5e-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 16 Jan 2024 09:44:16 +0000
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 40G8gYuh026494; Tue, 16 Jan 2024 09:44:15 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 3vm72jwe3f-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 16 Jan 2024 09:44:15 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com
 [10.20.54.103])
 by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 40G9iET810355424
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 16 Jan 2024 09:44:14 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 18EC720043;
 Tue, 16 Jan 2024 09:44:14 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id BCD0120040;
 Tue, 16 Jan 2024 09:44:13 +0000 (GMT)
Received: from heavy.boeblingen.de.ibm.com (unknown [9.179.4.64])
 by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Tue, 16 Jan 2024 09:44:13 +0000 (GMT)
From: Ilya Leoshkevich <iii@linux.ibm.com>
To: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Riku Voipio <riku.voipio@iki.fi>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org, Ilya Leoshkevich <iii@linux.ibm.com>
Subject: [PATCH v2 0/2] gdbstub: Implement catching syscalls
Date: Tue, 16 Jan 2024 10:41:52 +0100
Message-ID: <20240116094411.216665-1-iii@linux.ibm.com>
X-Mailer: git-send-email 2.43.0
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: bNXGXMAjitF1jg0dsm2g7FY75C-VCQLp
X-Proofpoint-GUID: bNXGXMAjitF1jg0dsm2g7FY75C-VCQLp
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-16_04,2024-01-15_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 clxscore=1015
 malwarescore=0 priorityscore=1501 spamscore=0 mlxscore=0 bulkscore=0
 lowpriorityscore=0 suspectscore=0 mlxlogscore=510 impostorscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2401160077
Received-SPF: pass client-ip=148.163.156.1; envelope-from=iii@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
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

v1: https://lists.gnu.org/archive/html/qemu-devel/2024-01/msg02911.html
v1 -> v2: Avoid touching the system gdbstub.
          Advertise QCatchSyscalls+ only on Linux.

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

 gdbstub/gdbstub.c                             |   9 ++
 gdbstub/internals.h                           |   2 +
 gdbstub/user-target.c                         |   5 +
 gdbstub/user.c                                | 104 +++++++++++++++++-
 include/gdbstub/user.h                        |  29 ++++-
 include/user/syscall-trace.h                  |   7 +-
 tests/tcg/multiarch/Makefile.target           |  10 +-
 tests/tcg/multiarch/catch-syscalls.c          |  51 +++++++++
 tests/tcg/multiarch/gdbstub/catch-syscalls.py |  52 +++++++++
 9 files changed, 263 insertions(+), 6 deletions(-)
 create mode 100644 tests/tcg/multiarch/catch-syscalls.c
 create mode 100644 tests/tcg/multiarch/gdbstub/catch-syscalls.py

-- 
2.43.0



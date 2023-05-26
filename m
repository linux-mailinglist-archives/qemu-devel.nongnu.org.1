Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 400F8712602
	for <lists+qemu-devel@lfdr.de>; Fri, 26 May 2023 13:52:36 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q2VyM-000219-Sy; Fri, 26 May 2023 07:51:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>) id 1q2VyF-0001zx-7w
 for qemu-devel@nongnu.org; Fri, 26 May 2023 07:51:00 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>) id 1q2VyC-00088C-SK
 for qemu-devel@nongnu.org; Fri, 26 May 2023 07:50:58 -0400
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 34QBeM3q015319; Fri, 26 May 2023 11:50:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=from : to : cc : subject
 : date : message-id : content-type : content-transfer-encoding :
 mime-version; s=pp1; bh=JDGgJd6pmxdbBPdiN15G9Js0s1Ui4Ty+6ZI+QO+FrVg=;
 b=U8DlRb8o6qCYKRazV059A07kfVxBdarQZ1PomLdkgNNbdHmRrJy7hNtZfU9u35kqOeAM
 5Ht9gAND+y8+x9VyVvYzI+6u40zm7Z6uxu9ILI+MEzsdrmDJ1vxZNAM7OO+cQIuwiag4
 XkA7A8+17MRgrSXzNjNq8hZkxKiLzATC+qLN3G3/VYcQgwEUNuLwtZcL1ScfqBthurcg
 GV1mdiRxHZtls23Eb6RF2gvpwkiTm7wfV33EJ7z0Lwlvto7d1LVKWoc89bA2Fg42rAgQ
 9QnZIkJtLHBKw6xFWG94wiqHfwdZCt0HFMoZ0gfjqmhRJYxM4UHzwabKgjliOhiEvSkK Cg== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3qtsngbpv8-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 26 May 2023 11:50:52 +0000
Received: from m0353725.ppops.net (m0353725.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 34QBeYsM016688;
 Fri, 26 May 2023 11:50:52 GMT
Received: from ppma01fra.de.ibm.com (46.49.7a9f.ip4.static.sl-reverse.com
 [159.122.73.70])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3qtsngbpun-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 26 May 2023 11:50:52 +0000
Received: from pps.filterd (ppma01fra.de.ibm.com [127.0.0.1])
 by ppma01fra.de.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 34Q8RL1j021050;
 Fri, 26 May 2023 11:50:50 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
 by ppma01fra.de.ibm.com (PPS) with ESMTPS id 3qppc12cyj-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 26 May 2023 11:50:50 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com
 [10.20.54.104])
 by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 34QBok9q17564330
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 26 May 2023 11:50:46 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id B064820040;
 Fri, 26 May 2023 11:50:46 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 08F9920043;
 Fri, 26 May 2023 11:50:46 +0000 (GMT)
Received: from heavy.boeblingen.de.ibm.com (unknown [9.171.55.92])
 by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Fri, 26 May 2023 11:50:45 +0000 (GMT)
From: Ilya Leoshkevich <iii@linux.ibm.com>
To: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>
Cc: "Dominik 'Disconnect3d' Czarnota" <dominik.b.czarnota@gmail.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Andreas Arnez <arnez@linux.ibm.com>, qemu-devel@nongnu.org,
 Ilya Leoshkevich <iii@linux.ibm.com>
Subject: [PATCH v2 0/6] gdbstub: Add support for info proc mappings
Date: Fri, 26 May 2023 13:50:35 +0200
Message-Id: <20230526115041.1362009-1-iii@linux.ibm.com>
X-Mailer: git-send-email 2.40.1
Content-Type: text/plain; charset=UTF-8
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: OQQl1CZV9eZBfrlE7vwZo2Q_Ag-ByaVA
X-Proofpoint-GUID: PpYyQOwLXPnZ-crMeLfB23hdPvwoeQGR
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-05-26_01,2023-05-25_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 impostorscore=0
 spamscore=0 lowpriorityscore=0 mlxscore=0 phishscore=0 priorityscore=1501
 suspectscore=0 mlxlogscore=999 bulkscore=0 adultscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2304280000
 definitions=main-2305260099
Received-SPF: pass client-ip=148.163.158.5; envelope-from=iii@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

v1: https://lists.gnu.org/archive/html/qemu-devel/2023-05/msg02614.html
v1 -> v2: Reword the 5/6 commit message (Dominik).
          Add R-bs.
          Patches that need review:
          4/6 gdbstub: Add support for info proc mappings
          6/6 tests/tcg: Add a test for info proc mappings

Hi,

this series partially implements the Host I/O feature of the GDB Remote
Serial Protocol in order to make generate-core-file work with qemu-user.
It borrows heavily from the abandoned patch by Dominik [1], hence 4/6
carries the respective Co-developed-by: tag. I hope that's okay. I also
peeked at gdbserver/hostio.cc quite a few times.

The changes compared to Dominik's patch are:

- Implement readlink.
- Move the main functionality to user-target.c.
- Allocate buffers on heap.
- Add a test.
- Update gdb.rst.
- Split refactorings to the existing code into separate patches.
- Rename do_openat() to do_guest_openat().
- Do not retry pread(), since GDB is capable of doing it itself.
- Add an extra sanity check to gdb_handle_query_xfer_exec_file().
- Replace citations of the spec by a single link.

Best regards,
Ilya

Ilya Leoshkevich (6):
  linux-user: Expose do_guest_openat() and do_guest_readlink()
  gdbstub: Expose gdb_get_process() and gdb_get_first_cpu_in_process()
  gdbstub: Report the actual qemu-user pid
  gdbstub: Add support for info proc mappings
  docs: Document security implications of debugging
  tests/tcg: Add a test for info proc mappings

 docs/system/gdb.rst                           |  15 ++
 gdbstub/gdbstub.c                             |  86 ++++++++---
 gdbstub/internals.h                           |   7 +
 gdbstub/user-target.c                         | 139 ++++++++++++++++++
 linux-user/qemu.h                             |   3 +
 linux-user/syscall.c                          |  54 ++++---
 tests/tcg/aarch64/Makefile.target             |   3 +-
 tests/tcg/multiarch/Makefile.target           |   7 +
 .../multiarch/gdbstub/test-proc-mappings.py   |  55 +++++++
 tests/tcg/s390x/Makefile.target               |   2 +-
 10 files changed, 332 insertions(+), 39 deletions(-)
 create mode 100644 tests/tcg/multiarch/gdbstub/test-proc-mappings.py

-- 
2.40.1



Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A046A72446D
	for <lists+qemu-devel@lfdr.de>; Tue,  6 Jun 2023 15:29:48 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q6WjO-0008LB-4p; Tue, 06 Jun 2023 09:28:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>)
 id 1q6WjB-00089M-VF; Tue, 06 Jun 2023 09:28:02 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>)
 id 1q6Wj9-0003rm-EC; Tue, 06 Jun 2023 09:28:01 -0400
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 356DMhkG008271; Tue, 6 Jun 2023 13:27:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=from : to : cc : subject
 : date : message-id : content-type : content-transfer-encoding :
 mime-version; s=pp1; bh=QTGpwJL5/IxqRuXEPXYASiORA9jMahfLX60pnlAl6iE=;
 b=HIB87hbA0Vxv4Qq6IiOMofGcvPaYpj/+fOqvghRbXfQYjGplDvt8kUZJLMpObPd+kN+b
 QJjFhkwwX5LYczRMw4U335V5fftkzw4xS/Mr2S8wkWxAfm/y1f413OisMj/t2+doflG6
 grSuYg+m6udPh04QDf7DeP5iIcLnbrNgWjKAZi9xyjij+wcrETpl0bVY7SbmjufYGYWT
 VkgJv8BmP1NOZyxcBGeP7paTKgLNweImk060yNUdg/TYkTvg4EdK6SLFRRYz3cXzgyVz
 Cif22VdTJBfkEgbUEqdko2lh642CrNFfD5THK8at99BtUR8XfCyz0GRnkwChWY7Q2F2P LA== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3r25mgr3qh-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 06 Jun 2023 13:27:54 +0000
Received: from m0360072.ppops.net (m0360072.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 356DRCWk021288;
 Tue, 6 Jun 2023 13:27:54 GMT
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com
 [169.51.49.102])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3r25mgr3ph-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 06 Jun 2023 13:27:54 +0000
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
 by ppma06ams.nl.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 3564w4UR016877;
 Tue, 6 Jun 2023 13:27:52 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
 by ppma06ams.nl.ibm.com (PPS) with ESMTPS id 3qyxmyhyw7-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 06 Jun 2023 13:27:51 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com
 [10.20.54.101])
 by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 356DRnOh18940562
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 6 Jun 2023 13:27:49 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 7672620043;
 Tue,  6 Jun 2023 13:27:49 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 332C220040;
 Tue,  6 Jun 2023 13:27:49 +0000 (GMT)
Received: from heavy.boeblingen.de.ibm.com (unknown [9.155.209.184])
 by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Tue,  6 Jun 2023 13:27:49 +0000 (GMT)
From: Ilya Leoshkevich <iii@linux.ibm.com>
To: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>,
 Peter Maydell <peter.maydell@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 David Hildenbrand <david@redhat.com>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org, qemu-arm@nongnu.org, qemu-s390x@nongnu.org,
 Ilya Leoshkevich <iii@linux.ibm.com>
Subject: [PATCH v3 0/8] gdbstub: Add support for info proc mappings
Date: Tue,  6 Jun 2023 15:27:35 +0200
Message-Id: <20230606132743.1386003-1-iii@linux.ibm.com>
X-Mailer: git-send-email 2.40.1
Content-Type: text/plain; charset=UTF-8
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: HoQGhV-5y3Edv4qcMZFrHXg-d0znw-Aa
X-Proofpoint-ORIG-GUID: hSCUX2S37K1RvdsBHfN8dfrgdGWp111o
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-06-06_08,2023-06-06_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 clxscore=1011
 lowpriorityscore=0 priorityscore=1501 phishscore=0 suspectscore=0
 spamscore=0 malwarescore=0 adultscore=0 mlxscore=0 bulkscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2304280000 definitions=main-2306060106
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

v2: https://lists.gnu.org/archive/html/qemu-devel/2023-05/msg06837.html
v2 -> v3: Use openat() instead of safe_openat() (new patch: 2/8).
          Add /proc/self/smaps emulation (new patch: 3/8).
          With these 2 changes, the minor issues previously mentioned in
          the patch 6/8 are gone.

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

Ilya Leoshkevich (8):
  linux-user: Expose do_guest_openat() and do_guest_readlink()
  linux-user: Add "safe" parameter to do_guest_openat()
  linux-user: Emulate /proc/self/smaps
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
 linux-user/syscall.c                          | 128 +++++++++++++---
 tests/tcg/aarch64/Makefile.target             |   3 +-
 tests/tcg/multiarch/Makefile.target           |   7 +
 .../multiarch/gdbstub/test-proc-mappings.py   |  55 +++++++
 tests/tcg/s390x/Makefile.target               |   2 +-
 10 files changed, 401 insertions(+), 44 deletions(-)
 create mode 100644 tests/tcg/multiarch/gdbstub/test-proc-mappings.py

-- 
2.40.1



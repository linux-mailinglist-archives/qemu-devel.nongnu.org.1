Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DEA9BBF5E9B
	for <lists+qemu-devel@lfdr.de>; Tue, 21 Oct 2025 12:56:13 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vBA1P-00053g-7m; Tue, 21 Oct 2025 06:55:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vishalc@linux.ibm.com>)
 id 1vBA1K-00052T-A5; Tue, 21 Oct 2025 06:55:14 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vishalc@linux.ibm.com>)
 id 1vBA1H-0001Lh-8K; Tue, 21 Oct 2025 06:55:13 -0400
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59L63tCw023364;
 Tue, 21 Oct 2025 10:55:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=pp1; bh=lhRdA36Lgh7gA6F/ogk8Zu0KQa9R
 KIHQrPdRjf3aSQE=; b=cXbIkx0MidumXe2EA0IYFF5mCdOYwUOo7l+AUtCGThMZ
 gyBDnzA01luEYkKON0P2slXIbpeceFkdkWgSggVVUzdQBMNXniZoVk3KAxKuPkHq
 VkWHCLNmWQ73puYUwqB6qqEiQ2L/GgqG/Ek7r3icn1dPRvhO1nO8KZGi8OAd1CoZ
 3P+uhQNhzoTpNmkTA2O9A5yZrsGT0bh+8D+R2PPIDUG1j7MvUwIAWAcgAC6Q4/f0
 WWLCH3aHFFEAHauTU1MDeqrvdQeeuI+hCgF7x086MvrXeebMuUXApA7MSnazpB41
 aadxOR7tqrKsKhF2swhPqcsafje8IFRnfWP8EUDs3A==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 49v30vn79s-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 21 Oct 2025 10:55:06 +0000 (GMT)
Received: from m0356516.ppops.net (m0356516.ppops.net [127.0.0.1])
 by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 59LAt6Tt015422;
 Tue, 21 Oct 2025 10:55:06 GMT
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 49v30vn79p-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 21 Oct 2025 10:55:06 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 59L8nrFt011015;
 Tue, 21 Oct 2025 10:55:05 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 49vqx121t9-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 21 Oct 2025 10:55:05 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com
 [10.20.54.104])
 by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 59LAt1QI49283574
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 21 Oct 2025 10:55:01 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id B74EE20043;
 Tue, 21 Oct 2025 10:55:01 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 38FBC20040;
 Tue, 21 Oct 2025 10:54:59 +0000 (GMT)
Received: from vishalc-ibm.ibm.com (unknown [9.39.24.196])
 by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Tue, 21 Oct 2025 10:54:58 +0000 (GMT)
From: Vishal Chourasia <vishalc@linux.ibm.com>
To: adityag@linux.ibm.com, harshpb@linux.ibm.com, milesg@linux.ibm.com,
 npiggin@gmail.com, peter.maydell@linaro.org, alistair23@gmail.com,
 balaton@eik.bme.hu, qemu-devel@nongnu.org, qemu-ppc@nongnu.org,
 berrange@redhat.com
Cc: Vishal Chourasia <vishalc@linux.ibm.com>
Subject: [Patch v5 0/6] hw/core/loader: capture Error from load_image_targphys
Date: Tue, 21 Oct 2025 16:24:37 +0530
Message-ID: <20251021105442.1474602-2-vishalc@linux.ibm.com>
X-Mailer: git-send-email 2.51.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: gkXDEoYI6NZ3j9FSO8LvOqBc9w9-98L3
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDE4MDAyMiBTYWx0ZWRfX7V9GscCrDHvr
 N64OOGAt32R4ZMTmz1ktBQVLysHQiWbM0OX5Cd9sY4Madz0rrnL7kMrcFJJHsv8s/uWm6oxL67j
 MiyzHisxb7hiFgPG0MMlBle2Tl1K/39uBtS3/hDdgFUZodAEuHiVeUNLuYTyGG0miUQ+Tle392J
 iYORNMIDbdSYOy3XQHXgLAbJnoWVyS3AP8yaQsJ4tqwwfmSpT7F1xTiJWLmInnR8mDCg73ALVQt
 UxEWUYNBf8d9MB1mtEV8jU9WtA9oA0PDD+kmEifv3Wb/Ndn2jCFMKWAxEKaYX+D+S0tly0iJ+hE
 6AHkoSxzVZ/gOfG+xDYqjiL3VHamb7jYSIs9nIX3q/XQsjFU2zmzorWU1T3tvhM+DDb8wQEuCIo
 o7pWSUCO2y8tOwJbpAjDgaJDnVmxyQ==
X-Authority-Analysis: v=2.4 cv=MIJtWcZl c=1 sm=1 tr=0 ts=68f7668a cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=-7clNU1bOBsGld0-t7AA:9 a=QEXdDO2ut3YA:10 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-ORIG-GUID: 9gYmfxH-9FgL8gpnXytgp_TO22jbfT1d
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-21_01,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 spamscore=0 phishscore=0 lowpriorityscore=0 adultscore=0
 clxscore=1015 impostorscore=0 bulkscore=0 priorityscore=1501 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510180022
Received-SPF: pass client-ip=148.163.158.5; envelope-from=vishalc@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Currently, when QEMU fails to load images (kernel, BIOS, initrd) via
load_image_targphys(), the error messages are not descriptive enough
for users to understand why the loading failed. This series adds the
ability to pass Error information through the loader functions to
provide more detailed error reporting.

v5:
- Moved the patch which replaces open() with qemu_open() earlier in the
  series
- Incorporated minor changes in the error messages requested by Balaton
- Moved check for size zero in load_image_targphys_as() into it's
  separate patch 

v4:
- Reject empty files (`size == 0`) with an appropriate error. [1/5]
- Populate error when `rom_add_file_fixed_as()` fails. [1/5]
- Add missing check in hw/ppc/virtex_ml507.c [5/5]
- Fixed checkpatch warnings [5/5]
- Check errp for failures from load_image_targphys/load_image_targphys_as [3,5/5]
- Remove unused variables [5/5]

v3:
- Use qemu_open() instead of open() in get_image_size() (danpb)
- Remove redundant error_setg_file_open() call (danpb)
- Use error_prepend()/error_reportf_err() to preserve underlying
  error details (danpb)

Vishal Chourasia (6):
  hw/core/loader: Use qemu_open() instead of open() in get_image_size()
  hw/core/loader: capture Error from load_image_targphys
  hw/core/loader: add check for zero size in load_image_targphys_as
  hw/core: Pass errp to load_image_targphys_as()
  hw/ppc/spapr: Rename resize_hpt_err to errp
  hw/ppc: Pass errp to load_image_targphys() and report errors

 hw/alpha/dp264.c         |  4 ++--
 hw/arm/armv7m.c          |  2 +-
 hw/arm/boot.c            |  5 +++--
 hw/arm/digic_boards.c    |  2 +-
 hw/arm/highbank.c        |  3 ++-
 hw/arm/raspi.c           |  2 +-
 hw/arm/vexpress.c        |  2 +-
 hw/core/generic-loader.c |  8 +++++---
 hw/core/guest-loader.c   |  7 ++++---
 hw/core/loader.c         | 36 ++++++++++++++++++++++++++++--------
 hw/hppa/machine.c        |  5 +++--
 hw/i386/multiboot.c      |  2 +-
 hw/i386/x86-common.c     |  4 ++--
 hw/ipmi/ipmi_bmc_sim.c   |  2 +-
 hw/loongarch/boot.c      |  5 ++---
 hw/m68k/an5206.c         |  2 +-
 hw/m68k/mcf5208.c        |  4 ++--
 hw/m68k/next-cube.c      |  2 +-
 hw/m68k/q800.c           |  7 ++++---
 hw/m68k/virt.c           |  4 ++--
 hw/microblaze/boot.c     |  5 +++--
 hw/mips/boston.c         |  2 +-
 hw/mips/fuloong2e.c      |  9 +++++----
 hw/mips/jazz.c           |  2 +-
 hw/mips/loongson3_virt.c | 10 ++++++----
 hw/mips/malta.c          |  9 +++++----
 hw/nubus/nubus-device.c  |  2 +-
 hw/openrisc/boot.c       |  5 +++--
 hw/pci/pci.c             |  2 +-
 hw/ppc/amigaone.c        | 15 ++++++++-------
 hw/ppc/e500.c            | 18 ++++++++++--------
 hw/ppc/mac_newworld.c    | 28 ++++++++++++++++++----------
 hw/ppc/mac_oldworld.c    | 28 ++++++++++++++++++----------
 hw/ppc/pegasos2.c        | 18 ++++++++++++------
 hw/ppc/pnv.c             | 30 +++++++++++++++---------------
 hw/ppc/ppc440_bamboo.c   | 10 ++++++----
 hw/ppc/prep.c            | 27 +++++++++++++++++----------
 hw/ppc/sam460ex.c        | 10 ++++++----
 hw/ppc/spapr.c           | 35 ++++++++++++++++++-----------------
 hw/ppc/virtex_ml507.c    | 18 ++++++++++++------
 hw/riscv/boot.c          |  7 ++++---
 hw/rx/rx-gdbsim.c        |  2 +-
 hw/s390x/ipl.c           |  8 +++++---
 hw/sh4/r2d.c             |  8 +++++---
 hw/smbios/smbios.c       |  2 +-
 hw/sparc/leon3.c         |  4 ++--
 hw/sparc/sun4m.c         |  8 +++++---
 hw/sparc64/sun4u.c       |  7 ++++---
 hw/xtensa/xtfpga.c       |  3 ++-
 include/hw/loader.h      |  8 +++++---
 system/device_tree.c     |  2 +-
 51 files changed, 268 insertions(+), 182 deletions(-)

-- 
2.51.0



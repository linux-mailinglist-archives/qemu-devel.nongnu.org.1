Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 608DCC0665D
	for <lists+qemu-devel@lfdr.de>; Fri, 24 Oct 2025 15:07:59 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vCHUz-0007Lx-Pn; Fri, 24 Oct 2025 09:06:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vishalc@linux.ibm.com>)
 id 1vCHUu-0007KV-Kh; Fri, 24 Oct 2025 09:06:25 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vishalc@linux.ibm.com>)
 id 1vCHUr-0002sl-OL; Fri, 24 Oct 2025 09:06:24 -0400
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59O0lXIj003122;
 Fri, 24 Oct 2025 13:06:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=pp1; bh=Qi+44Pl85M8veq1X76X2hjNjgOhg
 kxR+wVkzU7IFmxo=; b=eOGd3p6iOBVYr+obiuVXGBjnWUCfMJjzN9iAdGCQG5DE
 H8zQpZKigpUaNDl8Loy3tB6Y4FzjZrwMhTz1G3pI3Mx5I7Y3GOrdsK9dIRoTarhm
 GJ/8FdsOgaan0xGXOxnfCniPd9Wb+K/Xnlw/wI+jhEalrTyi5GgwwIS+T0QZFjky
 KNtE2rTrRb4q2W3PsyEoPExJFeGv9hsORd4pOE4Qh25JxIa4fvE5JCzWUTioOk0D
 XiXhB2XTs1ISCPd0UqsGXyFBbDg83j02TQtxxD5Tp9qb5O4QGgS8asGDUPs6trN9
 Za2DWXFVGCt7uPoA9Aq8sCNRFGhxTzwL2XjZeBBX8A==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 49v33fqdh0-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 24 Oct 2025 13:06:15 +0000 (GMT)
Received: from m0353729.ppops.net (m0353729.ppops.net [127.0.0.1])
 by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 59OCd2eP023916;
 Fri, 24 Oct 2025 13:06:15 GMT
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 49v33fqdgv-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 24 Oct 2025 13:06:15 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 59OA0uu9002320;
 Fri, 24 Oct 2025 13:06:14 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 49vqejtyrd-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 24 Oct 2025 13:06:14 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com
 [10.20.54.103])
 by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 59OD6AnF24641896
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 24 Oct 2025 13:06:10 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id ACD292004D;
 Fri, 24 Oct 2025 13:06:10 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 0C03020040;
 Fri, 24 Oct 2025 13:06:08 +0000 (GMT)
Received: from vishalc-ibm.ibm.com (unknown [9.39.24.189])
 by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Fri, 24 Oct 2025 13:06:07 +0000 (GMT)
From: Vishal Chourasia <vishalc@linux.ibm.com>
To: adityag@linux.ibm.com, harshpb@linux.ibm.com, milesg@linux.ibm.com,
 npiggin@gmail.com, peter.maydell@linaro.org, alistair23@gmail.com,
 balaton@eik.bme.hu, qemu-devel@nongnu.org, qemu-ppc@nongnu.org,
 berrange@redhat.com
Cc: Vishal Chourasia <vishalc@linux.ibm.com>
Subject: [Patch v10 0/6] core/loader: capture Error from load_image_targphys
Date: Fri, 24 Oct 2025 18:35:51 +0530
Message-ID: <20251024130556.1942835-2-vishalc@linux.ibm.com>
X-Mailer: git-send-email 2.51.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=FMYWBuos c=1 sm=1 tr=0 ts=68fb79c7 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8 a=eNy0KRMLFTeRC40QrVoA:9 a=QEXdDO2ut3YA:10
 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-GUID: 75vjhDztq9tQGDtfHB0XZrHs2AZBMsxi
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDE4MDAyMiBTYWx0ZWRfX/bf+2SzCh70H
 Rdful9Sj82olaW0nH0O4V5e72aVp2ubBBvK3D5gTh0LvfzYtUMlRjX927nWv3XnNB1/GPqS9Imn
 gFOHU9SdjyCYWDCCePjzjFSEZp4u2dZBCqsKnej8+fWCdZljmM9XsVpNBCzL8pA26c8QMLUGWG/
 NkKiwo5HlhDTMQP5AHzdHEB3lIIfqafA43ruziS4S64+ZO38iJgZiXVAtelQE6aPmGSXLY8tPHy
 QFISMJqZAwnsZlmFgN1IA/Jo7XhX1mXoU+ARY4sV9AuA2tcg6SNF10bB4ej1A9b7TXl/djTmBdT
 ZZiHoaQ6L4PuomQ9durAyLMln0NzycEVg6dA6J8PxiJNDF4sN0WaJqcbpVZ13jyiaYqjYYvcJPT
 JDWUE5N96kZPqUqcpRLmv5lZZJlWcA==
X-Proofpoint-ORIG-GUID: PNZABzs6G60oEH2_S6ifTqAsRFMW2Mly
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-24_02,2025-10-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 impostorscore=0 priorityscore=1501 adultscore=0 bulkscore=0
 lowpriorityscore=0 suspectscore=0 phishscore=0 spamscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510180022
Received-SPF: pass client-ip=148.163.156.1; envelope-from=vishalc@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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
ability to add Error information through the loader functions to
provide more detailed error reporting.

v10:
- Use size_to_str() to pretty print the maximum size allowed
  information.
- Use size < 0 check instead of *errp

v9:
- Split Patch 2 from v8 into two patches.
- Included RB from Aditya Gupta.

v8:
- Rebased on latest master.
- Modified commit message for Patch 5.

v7:
- Dropped the patch [hw/ppc/spapr: Rename resize_hpt_err to errp].
  already merged. Rebased on latest master.

v6:
- Pass error_fatal instead of errp where caller exits right after
  load_image_targphys() fails.
- Include filename in error messages.

v5:
- Moved the patch which replaces open() with qemu_open() earlier in the
  series.
- Incorporated minor changes in the error messages requested by Balaton.
- Moved check for size zero in load_image_targphys_as() into it's
  separate patch.

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

[v9]: https://lore.kernel.org/all/20251024092616.1893092-2-vishalc@linux.ibm.com
[v8]: https://lore.kernel.org/all/20251024052707.1852358-1-vishalc@linux.ibm.com
[v7]: https://lore.kernel.org/all/20251022192717.1644251-1-vishalc@linux.ibm.com
[v6]: https://lore.kernel.org/qemu-devel/20251022132507.1597232-2-vishalc@linux.ibm.com
[v5]: https://lore.kernel.org/all/20251021105442.1474602-2-vishalc@linux.ibm.com
[v4]: https://lore.kernel.org/all/20251017181250.1421446-2-vishalc@linux.ibm.com
[v3]: https://lore.kernel.org/all/20251016173502.1261674-1-vishalc@linux.ibm.com
[v2]: https://lore.kernel.org/all/20251015134716.1099351-2-vishalc@linux.ibm.com
[v1]: https://lore.kernel.org/all/20251007091214.403430-2-vishalc@linux.ibm.com

Vishal Chourasia (6):
  core/loader: Use qemu_open() instead of open() in get_image_size()
  core/loader: capture Error from load_image_targphys
  core/loader: improve error handling in image loading functions
  core/loader: add check for zero size in load_image_targphys_as
  core: Pass errp to load_image_targphys_as()
  ppc: Pass error_fatal to load_image_targphys()

 hw/alpha/dp264.c         |  4 ++--
 hw/arm/armv7m.c          |  2 +-
 hw/arm/boot.c            |  5 +++--
 hw/arm/digic_boards.c    |  2 +-
 hw/arm/highbank.c        |  3 ++-
 hw/arm/raspi.c           |  2 +-
 hw/arm/vexpress.c        |  2 +-
 hw/core/generic-loader.c |  5 +++--
 hw/core/guest-loader.c   |  4 ++--
 hw/core/loader.c         | 42 ++++++++++++++++++++++++++++------------
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
 hw/ppc/amigaone.c        | 13 ++-----------
 hw/ppc/e500.c            | 20 ++++---------------
 hw/ppc/mac_newworld.c    | 19 ++++++------------
 hw/ppc/mac_oldworld.c    | 19 ++++++------------
 hw/ppc/pegasos2.c        | 10 +++-------
 hw/ppc/pnv.c             | 27 ++++++--------------------
 hw/ppc/ppc440_bamboo.c   |  9 ++-------
 hw/ppc/prep.c            | 19 ++++++------------
 hw/ppc/sam460ex.c        |  8 ++------
 hw/ppc/spapr.c           | 17 ++++------------
 hw/ppc/virtex_ml507.c    | 11 +++--------
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
 51 files changed, 170 insertions(+), 215 deletions(-)

-- 
2.51.0



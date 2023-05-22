Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C46F70C2F9
	for <lists+qemu-devel@lfdr.de>; Mon, 22 May 2023 18:06:37 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q1831-00045h-51; Mon, 22 May 2023 12:06:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nnmlinux@linux.ibm.com>)
 id 1q182x-00043k-Ia; Mon, 22 May 2023 12:06:07 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nnmlinux@linux.ibm.com>)
 id 1q182t-000197-KC; Mon, 22 May 2023 12:06:07 -0400
Received: from pps.filterd (m0353727.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 34MG0pmD018482; Mon, 22 May 2023 16:05:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=from : to : cc : subject
 : date : message-id : content-transfer-encoding : mime-version; s=pp1;
 bh=fsEgROLTAS+NIKkoI+pm0VujtH0QtXt80RJThpm+zU0=;
 b=DRsYnZ7ylKErqt6qXuseUsZXVHRKWVugOsbsUjwXVbbCAE6ACC1z7vkrobbZGrfhGPnk
 8t7D019uoCtMui1BZeHhukfXGxhVO8Rsq7CaQ6tKZu8VP5z1SqyA68VAuyD1w/LwlvaS
 swpIIRgjCYpURhLwVEYlWYepYbRgkZNpZeODxAzmT6+U8NCcBf2qRJWTonwVsT+WDW67
 dfWfJ/n7f3Bcn3ZZUhlzXWn1QwiL/SKc3kTKIlVkVe+YumJwRgTEeYmOrK0Ol7bAd2uW
 GsnvHVJjLl9mQADwZWYKhhCj4/AcSQWgYzR5u/LZlPwN6478K8W1lwZEx3zE4+FB3Kt0 qg== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3qrbhv04hg-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 22 May 2023 16:05:45 +0000
Received: from m0353727.ppops.net (m0353727.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 34MG1iSL021710;
 Mon, 22 May 2023 16:05:40 GMT
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com
 [169.51.49.102])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3qrbhv030c-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 22 May 2023 16:05:40 +0000
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
 by ppma06ams.nl.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 34MEbjhr023274;
 Mon, 22 May 2023 16:03:15 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
 by ppma06ams.nl.ibm.com (PPS) with ESMTPS id 3qppc3h1n5-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 22 May 2023 16:03:15 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com
 [10.20.54.105])
 by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 34MG3BpG45744524
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 22 May 2023 16:03:12 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id D4D7C20049;
 Mon, 22 May 2023 16:03:11 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id B42F520040;
 Mon, 22 May 2023 16:03:09 +0000 (GMT)
Received: from ltc-wspoon17.aus.stglabs.ibm.com (unknown [9.3.101.49])
 by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Mon, 22 May 2023 16:03:09 +0000 (GMT)
From: Narayana Murty N <nnmlinux@linux.ibm.com>
To: danielhb413@gmail.com, clg@kaod.org, david@gibson.dropbear.id.au,
 groug@kaod.org, npiggin@gmail.com
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, farosas@suse.de,
 npiggin@linux.ibm.com, vaibhav@linux.ibm.com, harshpb@linux.ibm.com,
 sbhat@linux.ibm.com, nnmlinux@linux.ibm.com
Subject: [PATCH v3] target: ppc: Use MSR_HVB bit to get the target endianness
 for memory dump
Date: Mon, 22 May 2023 12:02:42 -0400
Message-Id: <20230522160242.37261-1-nnmlinux@linux.ibm.com>
X-Mailer: git-send-email 2.39.2
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 6Mfx2D-bLyPHmFRgzLi9BRf8UiTpkQMv
X-Proofpoint-GUID: YUGBUpQCx9nhSeYpxiqLvlaGLy6EHGWU
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-05-22_11,2023-05-22_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 adultscore=0
 suspectscore=0 phishscore=0 spamscore=0 mlxscore=0 malwarescore=0
 lowpriorityscore=0 bulkscore=0 priorityscore=1501 mlxlogscore=999
 clxscore=1011 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2304280000 definitions=main-2305220134
Received-SPF: pass client-ip=148.163.156.1;
 envelope-from=nnmlinux@linux.ibm.com; helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_MSPIKE_H2=-0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

Currently on PPC64 qemu always dumps the guest memory in
Big Endian (BE) format even though the guest running in Little Endian
(LE) mode. So crash tool fails to load the dump as illustrated below:

Log :
$ virsh dump DOMAIN --memory-only dump.file

Domain 'DOMAIN' dumped to dump.file

$ crash vmlinux dump.file

<snip>
crash 8.0.2-1.el9

WARNING: endian mismatch:
          crash utility: little-endian
          dump.file: big-endian

WARNING: machine type mismatch:
          crash utility: PPC64
          dump.file: (unknown)

crash: dump.file: not a supported file format
<snip>

This happens because cpu_get_dump_info() passes cpu->env->has_hv_mode
to function ppc_interrupts_little_endian(), the cpu->env->has_hv_mode
always set for powerNV even though the guest is not running in hv mode.
The hv mode should be taken from msr_mask MSR_HVB bit
(cpu->env.msr_mask & MSR_HVB). This patch fixes the issue by passing
MSR_HVB value to ppc_interrupts_little_endian() in order to determine
the guest endianness.

The crash tool also expects guest kernel endianness should match the
endianness of the dump.

The patch was tested on POWER9 box booted with Linux as host in
following cases:

Host-Endianess Qemu-Target-Machine Qemu-Guest-Endianess  Qemu-Generated-Guest
                                                          Memory-Dump-Format
BE             powernv             LE KVM guest                 LE
BE             powernv             BE KVM guest                 BE
LE             powernv             LE KVM guest                 LE
LE             powernv             BE KVM guest                 BE
LE             pseries KVM         LE KVM guest                 LE
LE             pseries TCG         LE guest                     LE

Signed-off-by: Narayana Murty N <nnmlinux@linux.ibm.com>
---
Changes since V2:
commit message modified as per feedbak from Nicholas Piggin.
Changes since V1:
https://lore.kernel.org/qemu-devel/20230420145055.10196-1-nnmlinux@linux.ibm.com/
The approach to solve the issue was changed based on feedback from
Fabiano Rosas on patch V1.
---
 target/ppc/arch_dump.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/ppc/arch_dump.c b/target/ppc/arch_dump.c
index f58e6359d5..a8315659d9 100644
--- a/target/ppc/arch_dump.c
+++ b/target/ppc/arch_dump.c
@@ -237,7 +237,7 @@ int cpu_get_dump_info(ArchDumpInfo *info,
     info->d_machine = PPC_ELF_MACHINE;
     info->d_class = ELFCLASS;
 
-    if (ppc_interrupts_little_endian(cpu, cpu->env.has_hv_mode)) {
+    if (ppc_interrupts_little_endian(cpu, !!(cpu->env.msr_mask & MSR_HVB))) {
         info->d_endian = ELFDATA2LSB;
     } else {
         info->d_endian = ELFDATA2MSB;
-- 
2.39.2



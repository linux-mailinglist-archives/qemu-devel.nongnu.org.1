Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 702D373B14C
	for <lists+qemu-devel@lfdr.de>; Fri, 23 Jun 2023 09:26:58 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qCbB6-0001D6-H0; Fri, 23 Jun 2023 03:25:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nnmlinux@linux.ibm.com>)
 id 1qCbAw-00019W-Bs; Fri, 23 Jun 2023 03:25:46 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nnmlinux@linux.ibm.com>)
 id 1qCbAt-0008Hn-8l; Fri, 23 Jun 2023 03:25:46 -0400
Received: from pps.filterd (m0353728.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 35N7BGJw028897; Fri, 23 Jun 2023 07:25:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=from : to : cc : subject
 : date : message-id : content-type : content-transfer-encoding :
 mime-version; s=pp1; bh=hwiXXQAss40KG5coDIr7vD9U0ZI3d3oksjAepgiYwWA=;
 b=gF9Q83xptEiE2tdl+M85q1yqnmoFlzHNbXq10zgolDf0TZTxA9KlM065KCvsNV/J+JpI
 PDyKx4MYmR7y1nY5JLyFeT1yNQwH9fcJ1bO1GmNdHpHK+pAm4bYApEcGiwc1p66762DH
 zhAB52vPPTf1pTnmNYZYTcgWmzmItt9iRgVyfko7HhhjFj0ecFZp1LX24HznURvOMouT
 GhrkYBraq8sw/nLhL2X0WXe43oGY4Ov7RmupZuC2e9jZxIN//b3P3OCfvocE+924kWoN
 VLZEiL6gpHlri+/+TwPxoP/MqR9WpKAP/D8y1HLDUrvCGE7nHnf/usEX8+ZpqNZlEF5l dQ== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3rd6c28qnm-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 23 Jun 2023 07:25:19 +0000
Received: from m0353728.ppops.net (m0353728.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 35N7Cc6e032323;
 Fri, 23 Jun 2023 07:25:18 GMT
Received: from ppma01fra.de.ibm.com (46.49.7a9f.ip4.static.sl-reverse.com
 [159.122.73.70])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3rd6c28qmn-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 23 Jun 2023 07:25:18 +0000
Received: from pps.filterd (ppma01fra.de.ibm.com [127.0.0.1])
 by ppma01fra.de.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 35N6IHTm030150;
 Fri, 23 Jun 2023 07:25:16 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
 by ppma01fra.de.ibm.com (PPS) with ESMTPS id 3r94f531ds-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 23 Jun 2023 07:25:15 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com
 [10.20.54.102])
 by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 35N7PCuw66584974
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 23 Jun 2023 07:25:12 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 6B1A52004D;
 Fri, 23 Jun 2023 07:25:12 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 646D92007F;
 Fri, 23 Jun 2023 07:25:10 +0000 (GMT)
Received: from ltc-wspoon17.aus.stglabs.ibm.com (unknown [9.3.101.49])
 by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Fri, 23 Jun 2023 07:25:10 +0000 (GMT)
From: Narayana Murty N <nnmlinux@linux.ibm.com>
To: danielhb413@gmail.com, clg@kaod.org, david@gibson.dropbear.id.au,
 groug@kaod.org, npiggin@gmail.com
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, farosas@suse.de,
 npiggin@linux.ibm.com, vaibhav@linux.ibm.com, harshpb@linux.ibm.com,
 sbhat@linux.ibm.com, nnmlinux@linux.ibm.com
Subject: [PATCH v4] target: ppc: Use MSR_HVB bit to get the target endianness
 for memory dump
Date: Fri, 23 Jun 2023 03:25:06 -0400
Message-Id: <20230623072506.34713-1-nnmlinux@linux.ibm.com>
X-Mailer: git-send-email 2.39.2
Content-Type: text/plain; charset=UTF-8
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 9lujUYMLmvOrHddMyrBhhhsjOv0VJULj
X-Proofpoint-GUID: D5ua7KS5CxSpt8_fS0Yskzixtj9ZpVu7
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-06-23_02,2023-06-22_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 mlxlogscore=999 adultscore=0 lowpriorityscore=0 bulkscore=0 suspectscore=0
 phishscore=0 impostorscore=0 malwarescore=0 mlxscore=0 clxscore=1011
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2306230063
Received-SPF: pass client-ip=148.163.156.1;
 envelope-from=nnmlinux@linux.ibm.com; helo=mx0a-001b2d01.pphosted.com
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

Host-Endianess Qemu-Target-Machine                Qemu-Generated-Guest
                                                  Memory-Dump-Format
BE             powernv(OPAL/PowerNV)                   LE
BE             powernv(OPAL/PowerNV)                   BE
LE             powernv(OPAL/PowerNV)                   LE
LE             powernv(OPAL/PowerNV)                   BE
LE             pseries(OPAL/PowerNV/pSeries) KVMHV     LE
LE             pseries TCG                             LE

Fixes: 5609400a4228 ("target/ppc: Set the correct endianness for powernv memory
dumps")
Signed-off-by: Narayana Murty N <nnmlinux@linux.ibm.com>
---
Changes since V3:
commit message modified as per feedback from Greg Kurz, Cédric Le
Goater and Nicholas Piggin.
Changes since V2:
commit message modified as per feedback from Nicholas Piggin.
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



Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 851257E41BC
	for <lists+qemu-devel@lfdr.de>; Tue,  7 Nov 2023 15:22:22 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r0My9-0001nl-A9; Tue, 07 Nov 2023 09:22:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <frankja@linux.ibm.com>)
 id 1r0My6-0001im-F9; Tue, 07 Nov 2023 09:22:14 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <frankja@linux.ibm.com>)
 id 1r0My4-000714-PQ; Tue, 07 Nov 2023 09:22:14 -0500
Received: from pps.filterd (m0353724.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 3A7EKhCa011654; Tue, 7 Nov 2023 14:21:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=aTOoqObabkwshdB7T57iUfMajOxfUEVNE+s04F7UV6o=;
 b=GJuMfjigNM+3miYkUOvTOR0DXzQFavVdfKC8eRwTHUWb0uxQLr+tK1JjmU556LfBYuSM
 dK5ZEq/J4GtqOSVTnfbH+1csMppm2g4ISufOuzdCt1gEPGSIHarXpkWsbuw5ak+2Dy9T
 6+iR8QzX9jZ5fSmD1EchwmEvaWx2wW7svfFih8f2QZVsfPUbzix5/jGCsxKUofrWnMao
 NypGlqjSJUN0QdEX7B6PYfmDrsea5IoSlrm9PVi7T/5kjCVfKdUHoCJCWE+4Y+Xha95H
 Z1jpYaIroueLhKIAPzkh2+/7cflJeTHmgoqmjeMDMdXtm6TETd8n/h0p/JKo+G6yLeKt sw== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3u7pwtr0aw-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 07 Nov 2023 14:21:09 +0000
Received: from m0353724.ppops.net (m0353724.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 3A7EL94Y012468;
 Tue, 7 Nov 2023 14:21:09 GMT
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3u7pwtr0aa-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 07 Nov 2023 14:21:09 +0000
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 3A7CxLXM025600; Tue, 7 Nov 2023 14:21:08 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3u619nh3v5-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 07 Nov 2023 14:21:08 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com
 [10.20.54.105])
 by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 3A7EL6cK20906636
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 7 Nov 2023 14:21:06 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id BFB4C2004D;
 Tue,  7 Nov 2023 14:21:06 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 9B2D220049;
 Tue,  7 Nov 2023 14:21:06 +0000 (GMT)
Received: from a46lp67.. (unknown [9.152.108.100])
 by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Tue,  7 Nov 2023 14:21:06 +0000 (GMT)
From: Janosch Frank <frankja@linux.ibm.com>
To: qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, marcandre.lureau@redhat.com, thuth@redhat.com,
 imbrenda@linux.ibm.com
Subject: [PATCH 0/4] dump: Arch info function pointer addition and cleanup
Date: Tue,  7 Nov 2023 14:20:44 +0000
Message-Id: <20231107142048.22422-1-frankja@linux.ibm.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: I6XBWE0tVtTh4qxZr5WPHmXJHVvwIYU0
X-Proofpoint-GUID: QSHu7hNf_vGY--yZuG2v1Ao_CUQxcd5p
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-07_05,2023-11-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxscore=0 spamscore=0
 phishscore=0 mlxlogscore=360 lowpriorityscore=0 suspectscore=0
 clxscore=1011 impostorscore=0 adultscore=0 bulkscore=0 malwarescore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2310240000 definitions=main-2311070118
Received-SPF: pass client-ip=148.163.158.5; envelope-from=frankja@linux.ibm.com;
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

Small cleanups/fixes to the dump info function pointer assignments as
well as a new function pointer for cleanup of residual state.

This has come up because test managed to dump a s390 PV vm onto a disk
that was too small for the dump. After the dump failed, the vm wasn't
able to resume running since KVM was still in dump mode which blocks
vcpu entry.

The new function pointer allows cleanup of such a situation.

Janosch Frank (4):
  dump: Set dump info function pointers to NULL
  target/s390x/dump: Remove unneeded dump info function pointer init
  dump: Add arch cleanup function
  target/s390x/arch_dump: Add arch cleanup function for PV dumps

 dump/dump.c                |  8 ++++++++
 include/sysemu/dump-arch.h |  1 +
 target/s390x/arch_dump.c   | 21 +++++++++++++++++----
 3 files changed, 26 insertions(+), 4 deletions(-)

-- 
2.34.1



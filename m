Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id F12D67224CC
	for <lists+qemu-devel@lfdr.de>; Mon,  5 Jun 2023 13:41:23 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q68ZX-0008Nj-Mv; Mon, 05 Jun 2023 07:40:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>)
 id 1q68ZB-0008Mx-Kk; Mon, 05 Jun 2023 07:40:05 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>)
 id 1q68Z9-0001LQ-C8; Mon, 05 Jun 2023 07:40:05 -0400
Received: from pps.filterd (m0353728.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 355BHWk8007020; Mon, 5 Jun 2023 11:39:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=from : to : cc : subject
 : date : message-id : content-transfer-encoding : mime-version; s=pp1;
 bh=oYb3CeonA7tG1tk6tseyMgK5cHULC0DpYs7B6pMKxfc=;
 b=PVrD4D2c/5vZnf/7LPwWweo5BGbeXQfX2UL3rGI+bmdZ6oCDMnQMlmlBcVxvfyCr7Xew
 6jFM9ZHu37FERnxo7EHLpZQNgZgsVGUSbhSvSblZvOYjSp1R7RaZil2A23YY/feIzfLX
 1qlFC5d0pdBzEGcFJv+Z0IS00WxyGY+ndtNXOY5PeasChXRnNW5wwvYnUKYul9dxkIlr
 H/jh5LNayx+E0Cndyh6w80n8Csd5G5GsJl5GQ0zqIQzQ17vSwAK9J0pPbzncPBYPplE6
 9kIHJQZLde2oVivzYIiz1O8Oy/clttGig1p26WZbubrLQ/1VilbL5QD8tukjBJihxUoR Tw== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3r1epugfv0-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 05 Jun 2023 11:39:58 +0000
Received: from m0353728.ppops.net (m0353728.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 355BVh7q027400;
 Mon, 5 Jun 2023 11:39:57 GMT
Received: from ppma02fra.de.ibm.com (47.49.7a9f.ip4.static.sl-reverse.com
 [159.122.73.71])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3r1epugfu1-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 05 Jun 2023 11:39:57 +0000
Received: from pps.filterd (ppma02fra.de.ibm.com [127.0.0.1])
 by ppma02fra.de.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 3553rdVA027199;
 Mon, 5 Jun 2023 11:39:55 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
 by ppma02fra.de.ibm.com (PPS) with ESMTPS id 3qyxdf91hs-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 05 Jun 2023 11:39:55 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com
 [10.20.54.105])
 by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 355BdqZm15663774
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 5 Jun 2023 11:39:52 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id C189F20043;
 Mon,  5 Jun 2023 11:39:52 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 886CD20040;
 Mon,  5 Jun 2023 11:39:52 +0000 (GMT)
Received: from heavy.boeblingen.de.ibm.com (unknown [9.155.209.184])
 by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Mon,  5 Jun 2023 11:39:52 +0000 (GMT)
From: Ilya Leoshkevich <iii@linux.ibm.com>
To: Laurent Vivier <laurent@vivier.eu>, David Hildenbrand <david@redhat.com>, 
 Thomas Huth <thuth@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-s390x@nongnu.org,
 Ilya Leoshkevich <iii@linux.ibm.com>
Subject: [PATCH v2 0/4] linux-user: Emulate /proc/cpuinfo on s390x
Date: Mon,  5 Jun 2023 13:39:46 +0200
Message-Id: <20230605113950.1169228-1-iii@linux.ibm.com>
X-Mailer: git-send-email 2.40.1
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: hnzf6bJ5HCSphB5u1oPeYntVcQMM1iIF
X-Proofpoint-GUID: uS0UBeVnvNotBsL6lX1n59knSxKirKAd
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-06-03_08,2023-06-02_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0
 priorityscore=1501 lowpriorityscore=0 phishscore=0 bulkscore=0 mlxscore=0
 mlxlogscore=999 suspectscore=0 adultscore=0 clxscore=1015 malwarescore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2304280000 definitions=main-2306050103
Received-SPF: pass client-ip=148.163.156.1; envelope-from=iii@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
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

v1: https://lists.gnu.org/archive/html/qemu-devel/2023-06/msg00299.html
v1 -> v2: Add output examples (David).
          Simplify the CPU 0 special case (David).
          Fix building on s390x hosts.

Hi,

This series introduces /proc/cpuinfo linux-user emulation for s390x.
/proc/cpuinfo emulation already exists for sparc, hppa and riscv; this
series follows the pattern established for these platforms.

Patch 1 is a fix for an issue that I noticed while looking for ways to
get to the "identification" field.

Patches 2 and 3 introduce the necessary helpers.

Patch 4 is the actual implementation.

The trigger for this work is a bug report filed by Tulio [1], which has
to do with the llvm-project testcases failing under qemu-user.

[1] https://bugzilla.redhat.com/show_bug.cgi?id=2211472

Best regards,
Ilya

Ilya Leoshkevich (4):
  s390x/tcg: Fix CPU address returned by STIDP
  linux-user/elfload: Expose get_elf_hwcap() on s390x
  linux-user/elfload: Introduce elf_hwcap_str() on s390x
  linux-user: Emulate /proc/cpuinfo on s390x

 linux-user/elfload.c      |  29 ++++++++++-
 linux-user/loader.h       |   5 ++
 linux-user/syscall.c      | 106 +++++++++++++++++++++++++++++++++++++-
 target/s390x/cpu_models.c |   4 +-
 target/s390x/cpu_models.h |  10 +++-
 5 files changed, 148 insertions(+), 6 deletions(-)

-- 
2.40.1



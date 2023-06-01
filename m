Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BCA171EED8
	for <lists+qemu-devel@lfdr.de>; Thu,  1 Jun 2023 18:26:48 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q4l7j-0003XQ-Vx; Thu, 01 Jun 2023 12:26:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>)
 id 1q4l7e-0003Tk-77; Thu, 01 Jun 2023 12:26:01 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>)
 id 1q4l7b-00061E-Re; Thu, 01 Jun 2023 12:25:57 -0400
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 351GEHC5030488; Thu, 1 Jun 2023 16:25:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=from : to : cc : subject
 : date : message-id : content-transfer-encoding : mime-version; s=pp1;
 bh=YlY1/41wc3olGOSP9Y8dv6dWOJuiVKYI2r++96bTURY=;
 b=juHOnfz9gVR8CDvnHCQ6CkfM5HobfsZNW/KVjES0Ces9KhUQ7Q5d5AiOMKByp4dqYcw1
 wJcSeGBPpkNZDS8+AAp4CvYgJ4uVUblo3tb3elHMm4I7Du2mHgIw1TV2ov/hpf7NS5wt
 o6xq8Gm/jW8UfznKWoJsMNaxxQl9Ic9TL8aSs5ILORWiZnFMUvxIjQ5pVO0qyhflPuQE
 XvAdeMHn0b90HgR3o+VrfVy8mh3EhoFRFDGBNhzX21w9W4p5AkzX3I/D+j3KNfVc+5RL
 PkHUT4Zd8ucDlKO0+oiWruLAP0FlxBeo45rQiGzb2Rk3ltjck3LlJ8iN0OpGSOWR2oYt zQ== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3qxxp10ak2-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 01 Jun 2023 16:25:52 +0000
Received: from m0353725.ppops.net (m0353725.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 351GFE6w000500;
 Thu, 1 Jun 2023 16:25:52 GMT
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com
 [169.51.49.102])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3qxxp10aj3-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 01 Jun 2023 16:25:52 +0000
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
 by ppma06ams.nl.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 3513grdx013792;
 Thu, 1 Jun 2023 16:25:50 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
 by ppma06ams.nl.ibm.com (PPS) with ESMTPS id 3qu94e2mjt-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 01 Jun 2023 16:25:50 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com
 [10.20.54.106])
 by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 351GPkkM31982134
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 1 Jun 2023 16:25:47 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id A63CC20043;
 Thu,  1 Jun 2023 16:25:46 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 2B3DB20040;
 Thu,  1 Jun 2023 16:25:46 +0000 (GMT)
Received: from heavy.boeblingen.de.ibm.com (unknown [9.171.86.130])
 by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Thu,  1 Jun 2023 16:25:46 +0000 (GMT)
From: Ilya Leoshkevich <iii@linux.ibm.com>
To: Laurent Vivier <laurent@vivier.eu>, David Hildenbrand <david@redhat.com>, 
 Thomas Huth <thuth@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-s390x@nongnu.org,
 Ilya Leoshkevich <iii@linux.ibm.com>
Subject: [PATCH 0/4] linux-user: Emulate /proc/cpuinfo on s390x
Date: Thu,  1 Jun 2023 18:25:37 +0200
Message-Id: <20230601162541.689621-1-iii@linux.ibm.com>
X-Mailer: git-send-email 2.40.1
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: b-M7PK-99RULSYubFH-g94G2bexARNS1
X-Proofpoint-ORIG-GUID: rm_vrGF9PYFhdzGnyozQIEfnsyS61w_9
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-06-01_08,2023-05-31_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 mlxscore=0
 bulkscore=0 suspectscore=0 adultscore=0 mlxlogscore=999 phishscore=0
 lowpriorityscore=0 impostorscore=0 clxscore=1015 malwarescore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2304280000 definitions=main-2306010139
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
 5 files changed, 149 insertions(+), 5 deletions(-)

-- 
2.40.1



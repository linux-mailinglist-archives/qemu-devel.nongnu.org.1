Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 552FD809759
	for <lists+qemu-devel@lfdr.de>; Fri,  8 Dec 2023 01:39:32 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rBOsc-0003dE-Et; Thu, 07 Dec 2023 19:38:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>) id 1rBOsZ-0003d6-HD
 for qemu-devel@nongnu.org; Thu, 07 Dec 2023 19:38:07 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>) id 1rBOsX-0000Nc-9m
 for qemu-devel@nongnu.org; Thu, 07 Dec 2023 19:38:07 -0500
Received: from pps.filterd (m0353722.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 3B80BOgn027736; Fri, 8 Dec 2023 00:38:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=from : to : cc : subject
 : date : message-id : content-transfer-encoding : mime-version; s=pp1;
 bh=BBAnBmcnmJhP2tJQZwJGdOhAF6+yVpQ8Lu8VspLLBOk=;
 b=q+zFzlzOEzhPg0V/zHy6+IylGX2FApZu7IRVbe2e+2LE6QTq/Zlhyaxxq12/FK/9POZU
 KUeB5c9DGpy2zcK+BIq0hXqXVSGoZwj3vbFdpUWPkFy9CJNqQ6V7InVrVBqMypoBiRF3
 NCMAaVr2qs0RMByRfWaU3xRUqI+YJEP6OH6l7pNk36TMRcQMs0XhlH9N3wtpvuUv8W9x
 80RGYLiVVmn+jdPsczBAfPq80idZOxF0h99AMgjH0LqcNGrWPNYLIfd5tyg3qP36walg
 ha8d0dT+iSm5SpLyX+/N1JeG1btlWjpW4i+2Z/EEAmjNSwdBP4KGJIexEFUfMQcd438T KA== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3uurcggkp7-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 08 Dec 2023 00:38:01 +0000
Received: from m0353722.ppops.net (m0353722.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 3B80Oheg001360;
 Fri, 8 Dec 2023 00:38:00 GMT
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3uurcggknu-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 08 Dec 2023 00:38:00 +0000
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 3B7Mjm9c013775; Fri, 8 Dec 2023 00:38:00 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3utau4ekbx-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 08 Dec 2023 00:37:59 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com
 [10.20.54.100])
 by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 3B80bvET32244188
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 8 Dec 2023 00:37:58 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id DBA9520043;
 Fri,  8 Dec 2023 00:37:57 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 125B420040;
 Fri,  8 Dec 2023 00:37:57 +0000 (GMT)
Received: from heavy.boeblingen.de.ibm.com (unknown [9.171.70.26])
 by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Fri,  8 Dec 2023 00:37:56 +0000 (GMT)
From: Ilya Leoshkevich <iii@linux.ibm.com>
To: Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Laurent Vivier <laurent@vivier.eu>, Peter Xu <peterx@redhat.com>,
 David Hildenbrand <david@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, Ilya Leoshkevich <iii@linux.ibm.com>
Subject: [PATCH v3 0/4] accel/tcg: Move perf and debuginfo support to tcg
Date: Fri,  8 Dec 2023 01:35:32 +0100
Message-ID: <20231208003754.3688038-1-iii@linux.ibm.com>
X-Mailer: git-send-email 2.43.0
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: KbVTNdcdZDtJKAvgM1z80GoEmjY3lhzv
X-Proofpoint-ORIG-GUID: 9oniGelA845tiHuDjluzcWebSzAaVy3L
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-07_19,2023-12-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 bulkscore=0
 mlxlogscore=739 priorityscore=1501 suspectscore=0 phishscore=0
 malwarescore=0 clxscore=1011 lowpriorityscore=0 adultscore=0 mlxscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2312080003
Received-SPF: pass client-ip=148.163.158.5; envelope-from=iii@linux.ibm.com;
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

v2: https://patchew.org/QEMU/20230630234230.596193-1-iii@linux.ibm.com/
v2 -> v3: Rebased.
          This series was lost and forgotten until Philippe reminded me
          about it.

v1: https://lists.gnu.org/archive/html/qemu-devel/2023-06/msg07037.html
v1 -> v2: Move qemu_target_page_mask() hunk to patch 1.
          Fix typos.

Hi,

This series is a follow-up to discussion in [1]; the goal is to build
perf and debuginfo support only one time.

Best regards,
Ilya

[1] https://lists.gnu.org/archive/html/qemu-devel/2023-06/msg06510.html

Ilya Leoshkevich (4):
  target: Make qemu_target_page_mask() available for *-user
  tcg: Make tb_cflags() usable from target-agnostic code
  accel/tcg: Remove #ifdef TARGET_I386 from perf.c
  accel/tcg: Move perf and debuginfo support to tcg

 accel/tcg/meson.build            |  2 --
 accel/tcg/translate-all.c        |  2 +-
 hw/core/loader.c                 |  2 +-
 include/exec/exec-all.h          |  6 ------
 include/exec/translation-block.h |  6 ++++++
 linux-user/elfload.c             |  2 +-
 linux-user/exit.c                |  2 +-
 linux-user/main.c                |  2 +-
 system/physmem.c                 |  5 -----
 system/vl.c                      |  2 +-
 target/meson.build               |  2 ++
 target/target-common.c           | 10 ++++++++++
 {accel/tcg => tcg}/debuginfo.c   |  0
 {accel/tcg => tcg}/debuginfo.h   |  4 ++--
 tcg/meson.build                  |  3 +++
 {accel/tcg => tcg}/perf.c        |  9 +++------
 {accel/tcg => tcg}/perf.h        |  4 ++--
 tcg/tcg.c                        |  2 +-
 18 files changed, 35 insertions(+), 30 deletions(-)
 create mode 100644 target/target-common.c
 rename {accel/tcg => tcg}/debuginfo.c (100%)
 rename {accel/tcg => tcg}/debuginfo.h (96%)
 rename {accel/tcg => tcg}/perf.c (98%)
 rename {accel/tcg => tcg}/perf.h (95%)

-- 
2.43.0



Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 59A8074455E
	for <lists+qemu-devel@lfdr.de>; Sat,  1 Jul 2023 01:44:16 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qFNlH-0008E6-Vg; Fri, 30 Jun 2023 19:42:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>) id 1qFNlF-0008Dq-4E
 for qemu-devel@nongnu.org; Fri, 30 Jun 2023 19:42:45 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>) id 1qFNlC-0006h8-Iq
 for qemu-devel@nongnu.org; Fri, 30 Jun 2023 19:42:44 -0400
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 35UNSDAH031333; Fri, 30 Jun 2023 23:42:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=from : to : cc : subject
 : date : message-id : content-type : content-transfer-encoding :
 mime-version; s=pp1; bh=KKD9OH0zWTdDzKFhTuC2dA4haHeAPjaY03Z7Dz7FCZ4=;
 b=SOyGAX6bKSR7eejXRGATfgIIH8LqEsRsweNfWRixyM5hrUYU9HGA3bYCXloG6Es6aSpa
 8CWCYbqrsr9RxkI9JIwB8zLKkYHk5+7QI6rfWyxNqc6lJKGvAaazZ/7+lCJw5H6WKyW+
 0uXfoJPgPf/XWdlkJ8yJdQgdOMZ37sugMn9mIN1e9UDVYkkue/8+752YkUbJiHGJiLh6
 +8dUIJ3PVCPQ7r1to7WfOS9czjkLxadIhmIr7cqOrJEI6SWOEptMSU0XuRbrtRIzIUJT
 m6jS+QAKpAo+16yhVMcPdPm3JxJzZSCSmd6fessyB0h10vja3s66Fkj3xzzrwZgqE7Cp sw== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3rj8rarb6s-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 30 Jun 2023 23:42:38 +0000
Received: from m0356517.ppops.net (m0356517.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 35UNU7Oi004315;
 Fri, 30 Jun 2023 23:42:37 GMT
Received: from ppma01fra.de.ibm.com (46.49.7a9f.ip4.static.sl-reverse.com
 [159.122.73.70])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3rj8rarb6c-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 30 Jun 2023 23:42:37 +0000
Received: from pps.filterd (ppma01fra.de.ibm.com [127.0.0.1])
 by ppma01fra.de.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 35UMnIhK005943;
 Fri, 30 Jun 2023 23:42:35 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
 by ppma01fra.de.ibm.com (PPS) with ESMTPS id 3rdr453a0d-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 30 Jun 2023 23:42:35 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com
 [10.20.54.100])
 by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 35UNgWlZ18874938
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 30 Jun 2023 23:42:32 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id BC98620040;
 Fri, 30 Jun 2023 23:42:32 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 260F320043;
 Fri, 30 Jun 2023 23:42:32 +0000 (GMT)
Received: from heavy.boeblingen.de.ibm.com (unknown [9.179.8.31])
 by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Fri, 30 Jun 2023 23:42:32 +0000 (GMT)
From: Ilya Leoshkevich <iii@linux.ibm.com>
To: Richard Henderson <richard.henderson@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Peter Xu <peterx@redhat.com>,
 David Hildenbrand <david@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org, Ilya Leoshkevich <iii@linux.ibm.com>
Subject: [PATCH v2 0/4] accel/tcg: Move perf and debuginfo support to tcg
Date: Sat,  1 Jul 2023 01:40:53 +0200
Message-ID: <20230630234230.596193-1-iii@linux.ibm.com>
X-Mailer: git-send-email 2.41.0
Content-Type: text/plain; charset=UTF-8
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: Y2dRdk1__T9QFBhJtQZk-lV0BwIfHxjY
X-Proofpoint-ORIG-GUID: lR8GX6m3gBLx0mpCZF0OBBizQ9Ud012T
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 4 URL's were un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-06-30_13,2023-06-30_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 mlxscore=0
 suspectscore=0 clxscore=1015 malwarescore=0 phishscore=0 impostorscore=0
 spamscore=0 lowpriorityscore=0 mlxlogscore=824 priorityscore=1501
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2306300206
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

v1: https://lists.gnu.org/archive/html/qemu-devel/2023-06/msg07037.html
v1 -> v2: Move qemu_target_page_mask() hunk to patch 1.
          Fix typos.

Hi,

This series is a follow-up to discussion in [1]; the goal is to build
perf and debuginfo support only one time.

I had to move tb_cflags() and qemu_target_page_mask(), and I'm not sure
if my choices there are perfect. Please let me know if there are better
locations for them.

Best regards,
Ilya

[1] https://lists.gnu.org/archive/html/qemu-devel/2023-06/msg06510.html

Ilya Leoshkevich (4):
  target: Make qemu_target_page_mask() available for *-user
  tcg: Make tb_cflags() usable from target-agnostic code
  accel/tcg: Remove #ifdef TARGET_I386 from perf.c
  accel/tcg: Move perf and debuginfo support to tcg

 accel/tcg/meson.build            | 2 --
 accel/tcg/translate-all.c        | 2 +-
 hw/core/loader.c                 | 2 +-
 include/exec/exec-all.h          | 6 ------
 include/exec/translation-block.h | 6 ++++++
 linux-user/elfload.c             | 2 +-
 linux-user/exit.c                | 2 +-
 linux-user/main.c                | 2 +-
 softmmu/physmem.c                | 5 -----
 softmmu/vl.c                     | 2 +-
 target/meson.build               | 2 ++
 target/target-common.c           | 9 +++++++++
 {accel/tcg => tcg}/debuginfo.c   | 0
 {accel/tcg => tcg}/debuginfo.h   | 4 ++--
 tcg/meson.build                  | 3 +++
 {accel/tcg => tcg}/perf.c        | 8 ++------
 {accel/tcg => tcg}/perf.h        | 4 ++--
 tcg/tcg.c                        | 2 +-
 18 files changed, 33 insertions(+), 30 deletions(-)
 create mode 100644 target/target-common.c
 rename {accel/tcg => tcg}/debuginfo.c (100%)
 rename {accel/tcg => tcg}/debuginfo.h (96%)
 rename {accel/tcg => tcg}/perf.c (98%)
 rename {accel/tcg => tcg}/perf.h (95%)

-- 
2.41.0



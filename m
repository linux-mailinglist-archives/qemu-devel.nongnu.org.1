Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 189C280E061
	for <lists+qemu-devel@lfdr.de>; Tue, 12 Dec 2023 01:42:54 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rCqq7-0004TX-5K; Mon, 11 Dec 2023 19:41:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>) id 1rCqq3-0004Q3-Ks
 for qemu-devel@nongnu.org; Mon, 11 Dec 2023 19:41:31 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>) id 1rCqq1-0004nw-Ec
 for qemu-devel@nongnu.org; Mon, 11 Dec 2023 19:41:31 -0500
Received: from pps.filterd (m0353724.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 3BC0CtK7012762; Tue, 12 Dec 2023 00:41:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=from : to : cc : subject
 : date : message-id : content-type : content-transfer-encoding :
 mime-version; s=pp1; bh=+AYoWs9d7yxUYlGEUNKNRvC5Fm1ogav81XcM0YPYyMk=;
 b=CZ3K9jiMC1gly42REede9GYvStFtONMvmohWZ9SgiTWYmK2gwPpFQQASxcCiowB4uSqb
 6wRNCO4JoCVbNjVsSrGvvPQRW0sgI3phR7x3D9S1E7lGMsdAf/CO/FMZR7WCoJR4gCr7
 XtxIV/SGlxAnPT4Uw211Xq5VWyOX59jSJqv6y7AbTvwhSnM6CZ5N1r1pj/xZkES9LuOt
 yosLf5TCck4GTYyVr+g22PT0pIjgwjRQe0J1gQQ86ZYCptZ6wNBcto84fPz2T9nZk6sC
 WiLUKrSgIrypNnFBT5gBzO9n7nprf2UO4YPRAfCQrN/Zq/wD6MvSFe0AcMkp6e5J3NF4 WA== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3uxcs98gd6-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 12 Dec 2023 00:41:26 +0000
Received: from m0353724.ppops.net (m0353724.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 3BC0DQbq013730;
 Tue, 12 Dec 2023 00:41:25 GMT
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3uxcs98gcy-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 12 Dec 2023 00:41:25 +0000
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 3BBGPVHR014813; Tue, 12 Dec 2023 00:41:25 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3uw42kbj9r-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 12 Dec 2023 00:41:25 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com
 [10.20.54.101])
 by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 3BC0fNJM43057722
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 12 Dec 2023 00:41:23 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 1237020043;
 Tue, 12 Dec 2023 00:41:23 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 8CAE720040;
 Tue, 12 Dec 2023 00:41:22 +0000 (GMT)
Received: from heavy.boeblingen.de.ibm.com (unknown [9.171.76.38])
 by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Tue, 12 Dec 2023 00:41:22 +0000 (GMT)
From: Ilya Leoshkevich <iii@linux.ibm.com>
To: Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Laurent Vivier <laurent@vivier.eu>, Peter Xu <peterx@redhat.com>,
 David Hildenbrand <david@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, Ilya Leoshkevich <iii@linux.ibm.com>
Subject: [PATCH v4 0/4] accel/tcg: Move perf and debuginfo support to tcg
Date: Tue, 12 Dec 2023 01:34:46 +0100
Message-ID: <20231212003837.64090-1-iii@linux.ibm.com>
X-Mailer: git-send-email 2.43.0
Content-Type: text/plain; charset=UTF-8
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: bnh5DLzky5U-_5vpJLu93H8i1h88Gvs4
X-Proofpoint-ORIG-GUID: bZ06WPf9FQkNOBEJY4p0a49KknVI0B7M
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-11_11,2023-12-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 bulkscore=0 mlxscore=0 suspectscore=0 clxscore=1015 impostorscore=0
 malwarescore=0 lowpriorityscore=0 phishscore=0 mlxlogscore=921 spamscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2312120003
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

Based-on: 20231211212003.21686-1-philmd@linaro.org

v3 -> v4: Rebase on top of Philippe's series.
          Move perf.h and debuginfo.h (Richard).

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
  accel/tcg: Make use of qemu_target_page_mask() in perf.c
  tcg: Make tb_cflags() usable from target-agnostic code
  accel/tcg: Remove #ifdef TARGET_I386 from perf.c
  accel/tcg: Move perf and debuginfo support to tcg

 accel/tcg/meson.build              |  2 --
 accel/tcg/translate-all.c          |  2 +-
 hw/core/loader.c                   |  2 +-
 include/exec/exec-all.h            |  6 ------
 include/exec/translation-block.h   |  6 ++++++
 {accel => include}/tcg/debuginfo.h |  4 ++--
 {accel => include}/tcg/perf.h      |  4 ++--
 linux-user/elfload.c               |  2 +-
 linux-user/exit.c                  |  2 +-
 linux-user/main.c                  |  2 +-
 system/vl.c                        |  2 +-
 {accel/tcg => tcg}/debuginfo.c     |  3 +--
 tcg/meson.build                    |  3 +++
 {accel/tcg => tcg}/perf.c          | 14 +++++---------
 tcg/tcg.c                          |  2 +-
 15 files changed, 26 insertions(+), 30 deletions(-)
 rename {accel => include}/tcg/debuginfo.h (96%)
 rename {accel => include}/tcg/perf.h (95%)
 rename {accel/tcg => tcg}/debuginfo.c (98%)
 rename {accel/tcg => tcg}/perf.c (97%)

-- 
2.43.0



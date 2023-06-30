Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E37374434D
	for <lists+qemu-devel@lfdr.de>; Fri, 30 Jun 2023 22:38:52 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qFKs8-0008QY-Cw; Fri, 30 Jun 2023 16:37:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>) id 1qFKs1-0008Q1-QR
 for qemu-devel@nongnu.org; Fri, 30 Jun 2023 16:37:33 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>) id 1qFKry-0006Ic-WF
 for qemu-devel@nongnu.org; Fri, 30 Jun 2023 16:37:33 -0400
Received: from pps.filterd (m0353723.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 35UKWnRa022961; Fri, 30 Jun 2023 20:37:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=from : to : cc : subject
 : date : message-id : content-type : content-transfer-encoding :
 mime-version; s=pp1; bh=wSPDq/twQE2m0MatPmsZ213haO3+C3O5HznHq5PHxL8=;
 b=Tu/nQHFVp9W8FMuOptU5s0OXdznXAB5RF1S/lhyrgtA+6BhojGSgTqX32FmdEX544kwk
 YddhLY/WE0cq5l665lVxGxovy+ITLJHJVIuWOa3YXN7d/ir8MRQh1H/wpteam6NMnlOq
 8mA04Yo9B2oOl6X6cc3U7XVz5sTNuO2hQGPl6KMIiWyNQCJlgO1LHmd9IXwxYzvfBMcs
 zZ4IpLtfME5kW6nwaMCcV6y5d/qfD3cJ8VA+WY1WTovi3rJByH/j9mEtP2cSZ/GmseEY
 DE+Ge9EFGWhFaV4t9Hy0DU2j/41L/l/pGOed8822+69lq01siNQ63WuF7HZ7ITdP1jvZ Uw== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3rj66b83hf-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 30 Jun 2023 20:37:28 +0000
Received: from m0353723.ppops.net (m0353723.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 35UKXT3o023678;
 Fri, 30 Jun 2023 20:37:27 GMT
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com
 [169.51.49.99])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3rj66b83h0-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 30 Jun 2023 20:37:27 +0000
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
 by ppma04ams.nl.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 35UJmob5017280;
 Fri, 30 Jun 2023 20:37:25 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
 by ppma04ams.nl.ibm.com (PPS) with ESMTPS id 3rdr454dke-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 30 Jun 2023 20:37:25 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com
 [10.20.54.103])
 by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 35UKbNas45744682
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 30 Jun 2023 20:37:23 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 0A10F20043;
 Fri, 30 Jun 2023 20:37:23 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 6A57220040;
 Fri, 30 Jun 2023 20:37:22 +0000 (GMT)
Received: from heavy.boeblingen.de.ibm.com (unknown [9.179.8.31])
 by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Fri, 30 Jun 2023 20:37:22 +0000 (GMT)
From: Ilya Leoshkevich <iii@linux.ibm.com>
To: Richard Henderson <richard.henderson@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Peter Xu <peterx@redhat.com>,
 David Hildenbrand <david@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org, Ilya Leoshkevich <iii@linux.ibm.com>
Subject: [PATCH 0/4] accel/tcg: Move perf and debuginfo support to tcg
Date: Fri, 30 Jun 2023 22:36:37 +0200
Message-ID: <20230630203720.528552-1-iii@linux.ibm.com>
X-Mailer: git-send-email 2.41.0
Content-Type: text/plain; charset=UTF-8
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: suF8P3cvxcz4YylXyif8FroU_D2NqhIC
X-Proofpoint-ORIG-GUID: B0b50yPBAN5B7JNAHH-8NUQuJWgCX-pw
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-06-30_12,2023-06-30_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 clxscore=1015
 priorityscore=1501 mlxlogscore=959 malwarescore=0 spamscore=0
 suspectscore=0 mlxscore=0 bulkscore=0 lowpriorityscore=0 impostorscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2306300179
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

This series is a follow-up to discussion in [1]; the goal is to build
perf and debuginfo support only one time.

I had to move tb_cflags() and qemu_target_page_mask(), and I'm not sure
if my choices there are perfect. Please let me know if there are better
locations for them.

Best regards,
Ilya

[1] https://lists.gnu.org/archive/html/qemu-devel/2023-06/msg06510.html

Ilya Leoshkevich (4):
  target: Make qemu_softmmu_page_mask() available for *-user
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



Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B9BCC74746B
	for <lists+qemu-devel@lfdr.de>; Tue,  4 Jul 2023 16:49:35 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qGhL9-0002m3-6q; Tue, 04 Jul 2023 10:49:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <fbarrat@linux.ibm.com>)
 id 1qGhKw-0002ld-Hg; Tue, 04 Jul 2023 10:49:04 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <fbarrat@linux.ibm.com>)
 id 1qGhKt-0002P3-7g; Tue, 04 Jul 2023 10:49:02 -0400
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 364EgYYn004716; Tue, 4 Jul 2023 14:48:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=from : to : subject :
 date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=VpjXH2Qz2t859Jzvapfo4hG5ZOtyqvRZSb7zF2K1Uhw=;
 b=iWsxU2wjhbjCOvVWUnnDtBP1JfR5EVGf6Ih5aconLqdwPJYnFa6UbgWlr9camQVCI7Zd
 cnfyl7UCaeV2pG9fY8TpjxOJyULoS2mUfmZJAOnlpb16MSyhZwYn8G7Z45WVXVCnqs/j
 J0nrz3pu3WgKuO+TY52r4GdUvVcpTT+i80vYb4CoVG41K7MJzJ3ZP4s4iKAAnzyngZGm
 UbINP7XYMy7InaUEhmHq25DO99Q47TdVq2oOC0hmWe2Fh9gV14OCcfBGMzEwS0nOyKJ6
 NR0dYjXgRzhGMapxwR2V8YXCZu1BWXEbbqFQEWR7mLHx53Gy0rC3UZYjlHmDNFbliccs Jw== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3rmndw08gy-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 04 Jul 2023 14:48:54 +0000
Received: from m0356517.ppops.net (m0356517.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 364EgrsZ006542;
 Tue, 4 Jul 2023 14:48:53 GMT
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com
 [169.51.49.102])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3rmndw08g8-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 04 Jul 2023 14:48:53 +0000
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
 by ppma06ams.nl.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 3642I8vx011852;
 Tue, 4 Jul 2023 14:48:51 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
 by ppma06ams.nl.ibm.com (PPS) with ESMTPS id 3rjbde22fq-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 04 Jul 2023 14:48:51 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com
 [10.20.54.105])
 by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 364Emns234275792
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 4 Jul 2023 14:48:49 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id E6DFD20049;
 Tue,  4 Jul 2023 14:48:48 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 88BF420043;
 Tue,  4 Jul 2023 14:48:48 +0000 (GMT)
Received: from borneo.ibmuc.com (unknown [9.171.14.192])
 by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Tue,  4 Jul 2023 14:48:48 +0000 (GMT)
From: Frederic Barrat <fbarrat@linux.ibm.com>
To: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Daniel Henrique Barboza <danielhb413@gmail.com>, qemu-ppc@nongnu.org,
 qemu-devel@nongnu.org
Subject: [PATCH] pnv/xive: Allow mmio operations of any size on the ESB CI
 pages
Date: Tue,  4 Jul 2023 16:48:48 +0200
Message-ID: <20230704144848.164287-1-fbarrat@linux.ibm.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: AGLm2r6w793yT4wd4BwTVQLST4Kx6gng
X-Proofpoint-GUID: gQktIsSharNFgkNA_970UO1zIY4dWHqF
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-04_09,2023-07-04_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 spamscore=0
 mlxscore=0 suspectscore=0 phishscore=0 impostorscore=0 adultscore=0
 lowpriorityscore=0 bulkscore=0 priorityscore=1501 mlxlogscore=887
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2307040125
Received-SPF: pass client-ip=148.163.156.1; envelope-from=fbarrat@linux.ibm.com;
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

We currently only allow 64-bit operations on the ESB CI pages. There's
no real reason for that limitation, skiboot/linux didn't need
more. However the hardware supports any size, so this patch relaxes
that restriction. It impacts both the ESB pages for "normal"
interrupts as well as the ESB pages for escalation interrupts defined
for the ENDs.

Signed-off-by: Frederic Barrat <fbarrat@linux.ibm.com>
---

This should wrap-up the cleanup about mmio size for the xive BARs. The
NVPG and NVC BAR accesses should also be relaxed but we don't really
implement them, any load/store currently fails. Something to address
when/if we implement them.

 hw/intc/xive.c  | 8 ++++----
 hw/intc/xive2.c | 4 ++--
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/hw/intc/xive.c b/hw/intc/xive.c
index f60c878345..c014e961a4 100644
--- a/hw/intc/xive.c
+++ b/hw/intc/xive.c
@@ -1175,11 +1175,11 @@ static const MemoryRegionOps xive_source_esb_ops = {
     .write = xive_source_esb_write,
     .endianness = DEVICE_BIG_ENDIAN,
     .valid = {
-        .min_access_size = 8,
+        .min_access_size = 1,
         .max_access_size = 8,
     },
     .impl = {
-        .min_access_size = 8,
+        .min_access_size = 1,
         .max_access_size = 8,
     },
 };
@@ -2006,11 +2006,11 @@ static const MemoryRegionOps xive_end_source_ops = {
     .write = xive_end_source_write,
     .endianness = DEVICE_BIG_ENDIAN,
     .valid = {
-        .min_access_size = 8,
+        .min_access_size = 1,
         .max_access_size = 8,
     },
     .impl = {
-        .min_access_size = 8,
+        .min_access_size = 1,
         .max_access_size = 8,
     },
 };
diff --git a/hw/intc/xive2.c b/hw/intc/xive2.c
index 4d9ff41956..c37ef25d44 100644
--- a/hw/intc/xive2.c
+++ b/hw/intc/xive2.c
@@ -954,11 +954,11 @@ static const MemoryRegionOps xive2_end_source_ops = {
     .write = xive2_end_source_write,
     .endianness = DEVICE_BIG_ENDIAN,
     .valid = {
-        .min_access_size = 8,
+        .min_access_size = 1,
         .max_access_size = 8,
     },
     .impl = {
-        .min_access_size = 8,
+        .min_access_size = 1,
         .max_access_size = 8,
     },
 };
-- 
2.41.0



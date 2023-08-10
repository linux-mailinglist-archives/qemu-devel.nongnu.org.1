Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 69D4D778306
	for <lists+qemu-devel@lfdr.de>; Thu, 10 Aug 2023 23:58:51 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qUDeq-0001Jo-JG; Thu, 10 Aug 2023 17:57:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>) id 1qUDen-0001J9-FW
 for qemu-devel@nongnu.org; Thu, 10 Aug 2023 17:57:25 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>) id 1qUDel-0005H9-EH
 for qemu-devel@nongnu.org; Thu, 10 Aug 2023 17:57:25 -0400
Received: from pps.filterd (m0353727.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 37ALrAkH029780; Thu, 10 Aug 2023 21:57:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=lEf5aXRYlrUeaQzNLYIn8LD6GG6Lo/XAR+xI/eH/bhw=;
 b=ah1RrDFxaayFAomUKI2T2ddz8yp60UhcQpkW5FHO5RkURff6Vl+X9KaYdsDTh7yId29z
 o+inWU650igrCfSeIyl//l4jqJy92nXN0ZEjsn2br5LCQaopx1Pv2cxBFF6O2kAevRRP
 W3Es6EC5Q2fvPyLSgb0VbQXBQN99+h2CXyCmVLqMPamsK2ku7+/5/j3gmmi1QbHMt43k
 7wpzRO9HR04eE65YEbozKRVvufJ9a7+9qY5O9mK3t6NpG2whC+Hj3UtMXjitH5kKJOJj
 VKQBmilCgQSl5jjZU84DDc6gd3A+PFGqZmrQ//OcXmuzWb6mrJ2mJy5xBlWOOKmvcA1U QQ== 
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3sd86u82f2-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 10 Aug 2023 21:57:17 +0000
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 37AJYKmU006408; Thu, 10 Aug 2023 21:57:16 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3sd2evamrj-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 10 Aug 2023 21:57:15 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com
 [10.20.54.106])
 by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 37ALvDZQ43516168
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 10 Aug 2023 21:57:14 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id E390820043;
 Thu, 10 Aug 2023 21:57:13 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 9842C20040;
 Thu, 10 Aug 2023 21:57:13 +0000 (GMT)
Received: from heavy.boeblingen.de.ibm.com (unknown [9.171.63.20])
 by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Thu, 10 Aug 2023 21:57:13 +0000 (GMT)
From: Ilya Leoshkevich <iii@linux.ibm.com>
To: Laurent Vivier <laurent@vivier.eu>,
 Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, Ilya Leoshkevich <iii@linux.ibm.com>
Subject: [PATCH 2/3] linux-user: Fix the build on systems without
 MAP_SHARED_VALIDATE
Date: Thu, 10 Aug 2023 23:51:32 +0200
Message-ID: <20230810215706.1394220-3-iii@linux.ibm.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230810215706.1394220-1-iii@linux.ibm.com>
References: <20230810215706.1394220-1-iii@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: kVuNNvRaw3zfQx1DT4LwfCbbPrlRqIOG
X-Proofpoint-ORIG-GUID: kVuNNvRaw3zfQx1DT4LwfCbbPrlRqIOG
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-08-10_16,2023-08-10_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0
 mlxlogscore=878 priorityscore=1501 suspectscore=0 bulkscore=0 adultscore=0
 spamscore=0 phishscore=0 clxscore=1015 mlxscore=0 lowpriorityscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2308100185
Received-SPF: pass client-ip=148.163.156.1; envelope-from=iii@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_MSPIKE_H5=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

CentOS 7 does not define MAP_SHARED_VALIDATE. Use a definition provided
by the QEMU's copy of linux/mman.h.

Fixes: 4b840f96096d ("linux-user: Populate more bits in mmap_flags_tbl")
Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
---
 linux-user/syscall.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index 42f4aed8e84..256f38cdd5d 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -121,6 +121,7 @@
 #ifdef HAVE_BTRFS_H
 #include <linux/btrfs.h>
 #endif
+#include <linux/mman.h>
 #ifdef HAVE_DRM_H
 #include <libdrm/drm.h>
 #include <libdrm/i915_drm.h>
-- 
2.41.0



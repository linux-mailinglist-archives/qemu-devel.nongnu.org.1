Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 56DA777277A
	for <lists+qemu-devel@lfdr.de>; Mon,  7 Aug 2023 16:19:18 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qT14W-0002wi-81; Mon, 07 Aug 2023 10:19:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>) id 1qT14T-0002wL-RO
 for qemu-devel@nongnu.org; Mon, 07 Aug 2023 10:18:57 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>) id 1qT14R-0006B2-RH
 for qemu-devel@nongnu.org; Mon, 07 Aug 2023 10:18:57 -0400
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 377E8YpK001771; Mon, 7 Aug 2023 14:18:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=+jZR0/RhcPlYCA89HpjQmGjv96x5KEruSJ8ewuy7SY4=;
 b=CHVvSt9I/kvuDAOF5ZUbXaTXbOgmKzHqIyYDoph4dTerBU9OFSu1bVYQRd4QgT0R/gj0
 Cx18JeT8+F9au59t95BiPcIudDCnbquyI5GgxrwU6M7+2cvSCobZXzDeE7XVEFDdXONd
 0YISi+0kPlxn7yVfw0OUiM41zhCeQy38/e0tURqp5ucQJuszIsunmEZ57RwlzqOfN5aA
 ZOn7Lr41e/eWT40m8ipQYCpApRhUMAtIYVrIv/z/cugSawlkumGnu+/7idc9mlULph1b
 wNWydBSyEe4SoxF/6wXR2TLld9yWdi3bZs01q4SORnJK9sGUm35OmOPQ9Uxauyoo00Me gg== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3sb1ys8m04-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 07 Aug 2023 14:18:53 +0000
Received: from m0353725.ppops.net (m0353725.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 377E97x5006992;
 Mon, 7 Aug 2023 14:18:53 GMT
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3sb1ys8kyr-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 07 Aug 2023 14:18:53 +0000
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 377E5FIX006654; Mon, 7 Aug 2023 14:18:52 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 3sa0rsp5ct-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 07 Aug 2023 14:18:52 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com
 [10.20.54.106])
 by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 377EIpmd39322278
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 7 Aug 2023 14:18:51 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 1213C20043;
 Mon,  7 Aug 2023 14:18:51 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id D7DD820040;
 Mon,  7 Aug 2023 14:18:50 +0000 (GMT)
Received: from heavy.boeblingen.de.ibm.com (unknown [9.155.200.166])
 by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Mon,  7 Aug 2023 14:18:50 +0000 (GMT)
From: Ilya Leoshkevich <iii@linux.ibm.com>
To: Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Ilya Leoshkevich <iii@linux.ibm.com>
Subject: [PATCH RFC 1/1] tcg: Always pass the full write size to
 notdirty_write()
Date: Mon,  7 Aug 2023 15:56:37 +0200
Message-ID: <20230807141846.786530-2-iii@linux.ibm.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230807141846.786530-1-iii@linux.ibm.com>
References: <20230807141846.786530-1-iii@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: WbY8BqD5_YqxRZ6VAHIuA_enfgLSa3Tr
X-Proofpoint-ORIG-GUID: 66OFGYmKCgdWbUGvO4mZ995YUuDJ0Lm5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-08-07_14,2023-08-03_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 malwarescore=0
 mlxlogscore=609 mlxscore=0 adultscore=0 impostorscore=0 spamscore=0
 clxscore=1015 priorityscore=1501 bulkscore=0 suspectscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2308070130
Received-SPF: pass client-ip=148.163.158.5; envelope-from=iii@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
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

One of notdirty_write()'s responsibilities is detecting self-modifying
code. Some functions pass the full size of a write to it, some pass 1.
When a write to a code section begins before a TB start, but then
overlaps the TB, the paths that pass 1 don't flush a TB and don't
return to the translator loop.

This may be masked, one example being HELPER(vstl). There,
probe_write_access() ultimately calls notdirty_write() with a size of
1 and misses self-modifying code. However, cpu_stq_be_data_ra()
ultimately calls mmu_watch_or_dirty(), which in turn calls
notdirty_write() with the full size.

It's still worth improving this, because there may still be
user-visible adverse effects in other helpers.

Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
---
 accel/tcg/cputlb.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/accel/tcg/cputlb.c b/accel/tcg/cputlb.c
index d68fa6867ce..aa3cffbc11a 100644
--- a/accel/tcg/cputlb.c
+++ b/accel/tcg/cputlb.c
@@ -1582,7 +1582,7 @@ int probe_access_full(CPUArchState *env, vaddr addr, int size,
 
     /* Handle clean RAM pages.  */
     if (unlikely(flags & TLB_NOTDIRTY)) {
-        notdirty_write(env_cpu(env), addr, 1, *pfull, retaddr);
+        notdirty_write(env_cpu(env), addr, size, *pfull, retaddr);
         flags &= ~TLB_NOTDIRTY;
     }
 
@@ -1605,7 +1605,7 @@ int probe_access_full_mmu(CPUArchState *env, vaddr addr, int size,
 
     /* Handle clean RAM pages.  */
     if (unlikely(flags & TLB_NOTDIRTY)) {
-        notdirty_write(env_cpu(env), addr, 1, *pfull, 0);
+        notdirty_write(env_cpu(env), addr, size, *pfull, 0);
         flags &= ~TLB_NOTDIRTY;
     }
 
@@ -1626,7 +1626,7 @@ int probe_access_flags(CPUArchState *env, vaddr addr, int size,
 
     /* Handle clean RAM pages. */
     if (unlikely(flags & TLB_NOTDIRTY)) {
-        notdirty_write(env_cpu(env), addr, 1, full, retaddr);
+        notdirty_write(env_cpu(env), addr, size, full, retaddr);
         flags &= ~TLB_NOTDIRTY;
     }
 
@@ -1661,7 +1661,7 @@ void *probe_access(CPUArchState *env, vaddr addr, int size,
 
         /* Handle clean RAM pages.  */
         if (flags & TLB_NOTDIRTY) {
-            notdirty_write(env_cpu(env), addr, 1, full, retaddr);
+            notdirty_write(env_cpu(env), addr, size, full, retaddr);
         }
     }
 
-- 
2.41.0



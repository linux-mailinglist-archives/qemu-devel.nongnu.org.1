Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 467D17168F3
	for <lists+qemu-devel@lfdr.de>; Tue, 30 May 2023 18:13:24 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q41ww-0004ku-9P; Tue, 30 May 2023 12:11:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <fbarrat@linux.ibm.com>)
 id 1q41wq-0004jh-Bi; Tue, 30 May 2023 12:11:48 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <fbarrat@linux.ibm.com>)
 id 1q41wo-000350-RL; Tue, 30 May 2023 12:11:48 -0400
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 34UG6SGJ021060; Tue, 30 May 2023 16:11:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=from : to : subject :
 date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=A5GknR4Y9CemSz0i4kEhP6YzBXFuyd+SKir2doOUTcA=;
 b=I07QXfTh8R5WF9amVy7GtGCOpQThgGR+Jff6PLQhSfCQDyOyYgV9BvPO7mr7BenTPnBs
 2z1HaSoL9crCNxOzUA5ebhyq5QWuew4po9Wk+Yq3EYgJHh9RS/l9xRhNZeQG5IfSt1yP
 gXrEhTcJX5+ir5LhepJfRUIk9mJv46Fydj4QWOuFhIhh88R3bb/BT7v6S6GDwPMKatM1
 E++Vw3l6vY25JEXpQYfZwH03rhfRpg+ANPmp56p0vVPkQhYXa7+mXbifGAJtBigI5bQs
 qO1FMD4H19K/uH9vP1qFQl20sfaC4Ju5rWvycp3hPFnk5fdnOlUZXX/FYlJZqAmSdgcy Tg== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3qwjej3m45-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 30 May 2023 16:11:36 +0000
Received: from m0356517.ppops.net (m0356517.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 34UG7RNH026762;
 Tue, 30 May 2023 16:11:36 GMT
Received: from ppma01fra.de.ibm.com (46.49.7a9f.ip4.static.sl-reverse.com
 [159.122.73.70])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3qwjej3m2f-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 30 May 2023 16:11:36 +0000
Received: from pps.filterd (ppma01fra.de.ibm.com [127.0.0.1])
 by ppma01fra.de.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 34U3Gwvg004348;
 Tue, 30 May 2023 16:11:33 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
 by ppma01fra.de.ibm.com (PPS) with ESMTPS id 3qu9g51b27-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 30 May 2023 16:11:33 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com
 [10.20.54.106])
 by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 34UGBVFX8848116
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 30 May 2023 16:11:31 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 321A02004B;
 Tue, 30 May 2023 16:11:31 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id D9D3120043;
 Tue, 30 May 2023 16:11:30 +0000 (GMT)
Received: from borneo.ibmuc.com (unknown [9.171.3.249])
 by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Tue, 30 May 2023 16:11:30 +0000 (GMT)
From: Frederic Barrat <fbarrat@linux.ibm.com>
To: clg@kaod.org, danielhb413@gmail.com, qemu-ppc@nongnu.org,
 qemu-devel@nongnu.org
Subject: [PATCH 3/4] pnv/xive2: Allow writes to the Physical Thread Enable
 registers
Date: Tue, 30 May 2023 18:11:28 +0200
Message-Id: <20230530161129.313258-4-fbarrat@linux.ibm.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230530161129.313258-1-fbarrat@linux.ibm.com>
References: <20230530161129.313258-1-fbarrat@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: HBclzGt1vKJGf7nu8FYIPScejFfe3DEr
X-Proofpoint-GUID: 2fb6E93BXKmAlv9rhOKBVDlpVflyFLHS
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-05-30_12,2023-05-30_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 suspectscore=0
 adultscore=0 lowpriorityscore=0 clxscore=1015 spamscore=0 phishscore=0
 impostorscore=0 mlxscore=0 priorityscore=1501 mlxlogscore=812
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2304280000 definitions=main-2305300127
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

Fix what was probably a silly mistake and allow to write the Physical
Thread enable registers 0 and 1. Skiboot prefers to use the ENx_SET
variant so it went unnoticed, but there's no reason to discard a write
to the full register, it is Read-Write.

Signed-off-by: Frederic Barrat <fbarrat@linux.ibm.com>
---
 hw/intc/pnv_xive2.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/hw/intc/pnv_xive2.c b/hw/intc/pnv_xive2.c
index a75ff270ac..132f82a035 100644
--- a/hw/intc/pnv_xive2.c
+++ b/hw/intc/pnv_xive2.c
@@ -1294,6 +1294,7 @@ static void pnv_xive2_ic_tctxt_write(void *opaque, hwaddr offset,
      */
     case TCTXT_EN0: /* Physical Thread Enable */
     case TCTXT_EN1: /* Physical Thread Enable (fused core) */
+        xive->tctxt_regs[reg] = val;
         break;
 
     case TCTXT_EN0_SET:
-- 
2.40.1



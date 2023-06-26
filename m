Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0246873DBA0
	for <lists+qemu-devel@lfdr.de>; Mon, 26 Jun 2023 11:42:04 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qDiiu-0005vU-Rl; Mon, 26 Jun 2023 05:41:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <fbarrat@linux.ibm.com>)
 id 1qDiig-0005tI-Il; Mon, 26 Jun 2023 05:41:14 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <fbarrat@linux.ibm.com>)
 id 1qDiia-0003cC-Kb; Mon, 26 Jun 2023 05:41:14 -0400
Received: from pps.filterd (m0353722.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 35Q9Ht6P032361; Mon, 26 Jun 2023 09:41:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=TiY0DQVP5dH+DDqsZnBCOk5f5mMCCoYxSu+mLoNBWwY=;
 b=iechHMCKvnE96Rcf2c/YkCB/+C9Pbz0G6lpZFBS17HKGPJca9TxUE1eg8wpafOZuSjRc
 Q3ZsFvmtLnCfeDscDesciaDOQB2MCfnRi5Xs+AtsuTWwqoOji3ySHI+8tHojjRjDpROa
 2MXSKXfXiYkZUYobN5wBc34YgS1gBerVQeBSDBSrmXPps8vak0xSsuYEGwRfArxZHaLZ
 oqblxOsOBjiiW7szMXo/KGRIqPm8e78AI0sd0Cnf4G/Ake1vZx09IcQ5nMMFJr5jvmac
 oGz2vrChV8Pfsua2NBCg++q7WuVpHll57xJndx3j12TFDC4H0ytW2ZiEuzqoEFq1Wxam 1g== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3rf7wu0k5x-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 26 Jun 2023 09:41:03 +0000
Received: from m0353722.ppops.net (m0353722.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 35Q9IB4J002218;
 Mon, 26 Jun 2023 09:41:02 GMT
Received: from ppma05fra.de.ibm.com (6c.4a.5195.ip4.static.sl-reverse.com
 [149.81.74.108])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3rf7wu0k55-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 26 Jun 2023 09:41:02 +0000
Received: from pps.filterd (ppma05fra.de.ibm.com [127.0.0.1])
 by ppma05fra.de.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 35Q3KfZf005065;
 Mon, 26 Jun 2023 09:41:01 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
 by ppma05fra.de.ibm.com (PPS) with ESMTPS id 3rdr458ueq-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 26 Jun 2023 09:41:00 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com
 [10.20.54.104])
 by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 35Q9ewWX42992354
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 26 Jun 2023 09:40:58 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 7D1C820049;
 Mon, 26 Jun 2023 09:40:58 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 0FD4F20040;
 Mon, 26 Jun 2023 09:40:58 +0000 (GMT)
Received: from borneo.ibmuc.com (unknown [9.171.45.146])
 by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Mon, 26 Jun 2023 09:40:57 +0000 (GMT)
From: Frederic Barrat <fbarrat@linux.ibm.com>
To: clg@kaod.org, danielhb413@gmail.com, qemu-ppc@nongnu.org,
 qemu-devel@nongnu.org
Cc: npiggin@gmail.com
Subject: [PATCH] pnv/xive2: Allow indirect TIMA accesses of all sizes
Date: Mon, 26 Jun 2023 11:40:57 +0200
Message-ID: <20230626094057.1192473-1-fbarrat@linux.ibm.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: StUKvFVBztvzlWniGWrLSKseOEGtf9fH
X-Proofpoint-GUID: LAEMRryoBFtbunqLBhHjapPuCcP5imAq
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-06-26_06,2023-06-22_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 impostorscore=0 bulkscore=0 mlxscore=0 adultscore=0 clxscore=1015
 malwarescore=0 phishscore=0 spamscore=0 suspectscore=0 lowpriorityscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2306260086
Received-SPF: pass client-ip=148.163.158.5; envelope-from=fbarrat@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -29
X-Spam_score: -3.0
X-Spam_bar: ---
X-Spam_report: (-3.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_MSPIKE_H5=-1,
 RCVD_IN_MSPIKE_WL=-0.01, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

Booting linux on the powernv10 machine logs a few errors like:

Invalid read at addr 0x38, size 1, region 'xive-ic-tm-indirect', reason: invalid size (min:8 max:8)
Invalid write at addr 0x38, size 1, region 'xive-ic-tm-indirect', reason: invalid size (min:8 max:8)
Invalid read at addr 0x38, size 1, region 'xive-ic-tm-indirect', reason: invalid size (min:8 max:8)

Those errors happen when linux is resetting XIVE. We're trying to
read/write the enablement bit for the hardware context and qemu
doesn't allow indirect TIMA accesses of less than 8 bytes. Direct TIMA
access can go through though, as well as indirect TIMA accesses on P9.
So even though there are some restrictions regarding the address/size
combinations for TIMA access, the example above is perfectly valid.

This patch lets indirect TIMA accesses of all sizes go through. The
special operations will be intercepted and the default "raw" handlers
will pick up all other requests and complain about invalid sizes as
appropriate.

Tested-by: Nicholas Piggin <npiggin@gmail.com>
Signed-off-by: Frederic Barrat <fbarrat@linux.ibm.com>
---
 hw/intc/pnv_xive2.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/intc/pnv_xive2.c b/hw/intc/pnv_xive2.c
index ed438a20ed..e8ab176de6 100644
--- a/hw/intc/pnv_xive2.c
+++ b/hw/intc/pnv_xive2.c
@@ -1644,11 +1644,11 @@ static const MemoryRegionOps pnv_xive2_ic_tm_indirect_ops = {
     .write = pnv_xive2_ic_tm_indirect_write,
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



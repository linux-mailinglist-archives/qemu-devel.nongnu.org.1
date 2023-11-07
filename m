Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E2CA37E41BB
	for <lists+qemu-devel@lfdr.de>; Tue,  7 Nov 2023 15:22:14 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r0MxA-0000sl-Ra; Tue, 07 Nov 2023 09:21:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <frankja@linux.ibm.com>)
 id 1r0Mx9-0000sL-B3; Tue, 07 Nov 2023 09:21:15 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <frankja@linux.ibm.com>)
 id 1r0Mx7-000719-Ln; Tue, 07 Nov 2023 09:21:15 -0500
Received: from pps.filterd (m0353722.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 3A7EJZMA024595; Tue, 7 Nov 2023 14:21:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=L8eMsSC272LOxGADKNqHNvwqRKhWq/daxb4+R4VbC/k=;
 b=bYVhO/phJk8IMqvbqLMziNQMjvUcHPkpvEytlal1zMkcNv0d3ardgMtpCUSw1s4DBaSi
 JVrYVehO/U3imbCEn2WU1WXRghHtk7cyjjUrgB/lVmazCbe13xiF+fmZyHiQHbZrnZw/
 wDb5TFBQl2aY3EA8AJhnwnMeZyB/4E9RLcKOAKRLR18QcLLR4Qk9uLsKgPTP6WaiIKNn
 38BxDxSKFS4B6Va4Jqqo4ZmLO7l17hhi6lfNK1yXNhlsFp4mXFUqnaQivy9EQFSYPooa
 /BphZEOdCNTpAmMCNuw02kOB4ddCRRt/kNDwjYbDJTImC1+Wki2ZsQlSvpZ/Co863tpK Lw== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3u7pwag28w-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 07 Nov 2023 14:21:10 +0000
Received: from m0353722.ppops.net (m0353722.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 3A7EKQcJ028769;
 Tue, 7 Nov 2023 14:21:09 GMT
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3u7pwag27g-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 07 Nov 2023 14:21:09 +0000
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 3A7EI248028253; Tue, 7 Nov 2023 14:21:08 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 3u62gk0qyj-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 07 Nov 2023 14:21:08 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com
 [10.20.54.105])
 by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 3A7EL7Wi45351176
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 7 Nov 2023 14:21:07 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id E7FCC20049;
 Tue,  7 Nov 2023 14:21:06 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id C422B2004E;
 Tue,  7 Nov 2023 14:21:06 +0000 (GMT)
Received: from a46lp67.. (unknown [9.152.108.100])
 by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Tue,  7 Nov 2023 14:21:06 +0000 (GMT)
From: Janosch Frank <frankja@linux.ibm.com>
To: qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, marcandre.lureau@redhat.com, thuth@redhat.com,
 imbrenda@linux.ibm.com
Subject: [PATCH 1/4] dump: Set dump info function pointers to NULL
Date: Tue,  7 Nov 2023 14:20:45 +0000
Message-Id: <20231107142048.22422-2-frankja@linux.ibm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231107142048.22422-1-frankja@linux.ibm.com>
References: <20231107142048.22422-1-frankja@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 9s9gKleLJCoIAWGdJb-yP5L8NQH87UoL
X-Proofpoint-GUID: nJKwWZlRAe1wZKvP3Qh5RAgyw8zaePYM
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-07_05,2023-11-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 impostorscore=0
 malwarescore=0 suspectscore=0 priorityscore=1501 adultscore=0 bulkscore=0
 mlxscore=0 spamscore=0 mlxlogscore=803 phishscore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2310240000
 definitions=main-2311070118
Received-SPF: pass client-ip=148.163.158.5; envelope-from=frankja@linux.ibm.com;
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

Better to not rely on the struct zeroing since NULL is not necessarily
0.

Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
---
 dump/dump.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/dump/dump.c b/dump/dump.c
index d355ada62e..1d38274925 100644
--- a/dump/dump.c
+++ b/dump/dump.c
@@ -1706,6 +1706,9 @@ static void dump_state_prepare(DumpState *s)
 {
     /* zero the struct, setting status to active */
     *s = (DumpState) { .status = DUMP_STATUS_ACTIVE };
+    s->dump_info.arch_sections_add_fn = NULL;
+    s->dump_info.arch_sections_write_hdr_fn = NULL;
+    s->dump_info.arch_sections_write_fn = NULL;
 }
 
 bool qemu_system_dump_in_progress(void)
-- 
2.34.1



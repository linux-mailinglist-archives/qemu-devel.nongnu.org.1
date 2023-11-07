Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 560AB7E41BA
	for <lists+qemu-devel@lfdr.de>; Tue,  7 Nov 2023 15:22:00 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r0MxC-0000u2-OT; Tue, 07 Nov 2023 09:21:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <frankja@linux.ibm.com>)
 id 1r0MxA-0000st-Kf; Tue, 07 Nov 2023 09:21:16 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <frankja@linux.ibm.com>)
 id 1r0Mx8-00071L-6K; Tue, 07 Nov 2023 09:21:16 -0500
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 3A7EFpWd032705; Tue, 7 Nov 2023 14:21:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=4JPR7W3IJVqy4P6UnrpwkJpRzrjwi3WayfURjaC/bwY=;
 b=YbimfsBRfM10UZLXRMnOWvR++qgG2lyhoz61Rp/ELaVvQE+cVzjERZm2vHWMwdh5gemO
 wtyvgzKVaIBnLij1GZwta5Gdgqy8IcDaQ3cEB62VSQkXd5MlkxWW4ORi05VmOG9Ei94c
 ZQUQzJaiUUhLI5zPt2oTx1JgGvH1j+T/tiSTgQuSkmpCeDx/CDk+/zCrKr18QdUiMPZZ
 BDRN51x2Il+/lyCO9sqrenrGoMvn29VtC7dEJBnjyjSPFzk8U8TCsqHRjabF9ItF9kaH
 yeZuoSMc9ggM6ToSPDJ0/uBeC2gQvI3dVIKgvprlElhMIqUoyNEw9HWNN/fO/Y0fUb+f Bg== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3u7pungdtn-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 07 Nov 2023 14:21:11 +0000
Received: from m0360072.ppops.net (m0360072.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 3A7EGVR2003103;
 Tue, 7 Nov 2023 14:21:11 GMT
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3u7pungds3-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 07 Nov 2023 14:21:10 +0000
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 3A7CXnxq007958; Tue, 7 Nov 2023 14:21:09 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3u60nyh7px-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 07 Nov 2023 14:21:09 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com
 [10.20.54.105])
 by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 3A7EL72c37880328
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 7 Nov 2023 14:21:07 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 1D33520049;
 Tue,  7 Nov 2023 14:21:07 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id EC77E2004D;
 Tue,  7 Nov 2023 14:21:06 +0000 (GMT)
Received: from a46lp67.. (unknown [9.152.108.100])
 by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Tue,  7 Nov 2023 14:21:06 +0000 (GMT)
From: Janosch Frank <frankja@linux.ibm.com>
To: qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, marcandre.lureau@redhat.com, thuth@redhat.com,
 imbrenda@linux.ibm.com
Subject: [PATCH 2/4] target/s390x/dump: Remove unneeded dump info function
 pointer init
Date: Tue,  7 Nov 2023 14:20:46 +0000
Message-Id: <20231107142048.22422-3-frankja@linux.ibm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231107142048.22422-1-frankja@linux.ibm.com>
References: <20231107142048.22422-1-frankja@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: c6069JV4iwnpPBtyMnbP3ZJltPiXk-y6
X-Proofpoint-ORIG-GUID: UvYJ3pGjdtnxEtdEHAseOsLBaNP58o87
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-07_05,2023-11-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 impostorscore=0 bulkscore=0 adultscore=0 lowpriorityscore=0 clxscore=1015
 mlxlogscore=537 phishscore=0 mlxscore=0 suspectscore=0 spamscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2310240000 definitions=main-2311070118
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

dump_state_prepare() now sets the fucntion pointers to NULL so we only
need to touch them if we're going to use them.

Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
---
 target/s390x/arch_dump.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/target/s390x/arch_dump.c b/target/s390x/arch_dump.c
index 51a2116515..bdb0bfa0e7 100644
--- a/target/s390x/arch_dump.c
+++ b/target/s390x/arch_dump.c
@@ -448,10 +448,6 @@ int cpu_get_dump_info(ArchDumpInfo *info,
         info->arch_sections_add_fn = *arch_sections_add;
         info->arch_sections_write_hdr_fn = *arch_sections_write_hdr;
         info->arch_sections_write_fn = *arch_sections_write;
-    } else {
-        info->arch_sections_add_fn = NULL;
-        info->arch_sections_write_hdr_fn = NULL;
-        info->arch_sections_write_fn = NULL;
     }
     return 0;
 }
-- 
2.34.1



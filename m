Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 542E97E6A4E
	for <lists+qemu-devel@lfdr.de>; Thu,  9 Nov 2023 13:05:47 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r13mh-00055Q-Ny; Thu, 09 Nov 2023 07:05:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <frankja@linux.ibm.com>)
 id 1r13mT-0004ZB-VB; Thu, 09 Nov 2023 07:05:09 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <frankja@linux.ibm.com>)
 id 1r13mM-0002WH-5y; Thu, 09 Nov 2023 07:05:02 -0500
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 3A9Bwtf9030822; Thu, 9 Nov 2023 12:04:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=pp1;
 bh=RPIFRsyhinFNvqnbr2d6wZNBquqGfrU0XeHbSZix9NQ=;
 b=kIXANLK7qeJ3ywTGuJo/tslbn4uoPXwBa2eiT02J8r07cnLOOphxuAgV73xBI2L1sOm8
 ZDchEENNiWnpF4n+kv5UuMvA0QAMz5gkpTrzRt2yuz4J6FhdcUgsXwcbXY6MhFxBZZJI
 XJkLRpiXSNeGAT2Iua3DtoaZiZtiSydD5qvw0C5PLQtDrjglYzNuZsEtiedQcN3Ewwwc
 4/LeclNrCIWv/we2t8m6MfHuC7hhWbAL6iyej78hYhD/q75UXZgCYmC5BLIX0hHsm9Aj
 mCHfynuTj/POM8jdmmgrG/Y04CFAT0t59w9dT5wKW4CC4QgRWS4kA8TjKGNStPtURVnN ZQ== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3u8xr6rxxs-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 09 Nov 2023 12:04:53 +0000
Received: from m0353725.ppops.net (m0353725.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 3A9C1H0B012143;
 Thu, 9 Nov 2023 12:04:53 GMT
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3u8xr6rxxg-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 09 Nov 2023 12:04:53 +0000
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 3A9B4FxS019248; Thu, 9 Nov 2023 12:04:52 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 3u7w243htn-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 09 Nov 2023 12:04:52 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com
 [10.20.54.105])
 by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 3A9C4oax46400168
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 9 Nov 2023 12:04:50 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id BD06220049;
 Thu,  9 Nov 2023 12:04:50 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 8E2DF2004D;
 Thu,  9 Nov 2023 12:04:50 +0000 (GMT)
Received: from a46lp67.. (unknown [9.152.108.100])
 by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Thu,  9 Nov 2023 12:04:50 +0000 (GMT)
From: Janosch Frank <frankja@linux.ibm.com>
To: qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, marcandre.lureau@redhat.com, thuth@redhat.com,
 imbrenda@linux.ibm.com
Subject: [PATCH v2 1/3] target/s390x/dump: Remove unneeded dump info function
 pointer init
Date: Thu,  9 Nov 2023 12:04:41 +0000
Message-Id: <20231109120443.185979-2-frankja@linux.ibm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231109120443.185979-1-frankja@linux.ibm.com>
References: <20231109120443.185979-1-frankja@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: B5JyoDSr4S2lDWubvXrKhuHhNtf0YqLu
X-Proofpoint-GUID: Cs3gKGF0K3EqrvYju2vj4UHXwCrUAeVc
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-09_10,2023-11-09_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 phishscore=0
 suspectscore=0 mlxscore=0 lowpriorityscore=0 priorityscore=1501
 malwarescore=0 impostorscore=0 bulkscore=0 clxscore=1015 mlxlogscore=542
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311060000 definitions=main-2311090089
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

dump_state_prepare() now sets the function pointers to NULL so we only
need to touch them if we're going to use them.

Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
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



Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 300877E6A51
	for <lists+qemu-devel@lfdr.de>; Thu,  9 Nov 2023 13:06:00 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r13mj-0005Si-W0; Thu, 09 Nov 2023 07:05:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <frankja@linux.ibm.com>)
 id 1r13mO-0004WS-FK; Thu, 09 Nov 2023 07:05:07 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <frankja@linux.ibm.com>)
 id 1r13mM-0002WN-5u; Thu, 09 Nov 2023 07:05:00 -0500
Received: from pps.filterd (m0353723.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 3A9BsprU018309; Thu, 9 Nov 2023 12:04:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=Pm6zNoxgAtph0avcGykXQsEHPA+dJ2pIBItVsC+q7fc=;
 b=FBr/mwS7/96VUSk+0UNyr4DPqcLH9LNodgk0SAJ2Ri/+5AVelOWePCFOefdDOhvKNAkm
 TvgxL4UBFYhOyv3W/Ki8HtE1wxr0DKRjWJOlvJury0TTnf7k5B3eAdeg2Za6ulWq/vuB
 AkPRgJk8ABuP/eoSMT+HgXpTK20L72poD0nVMh/px+sjEGRKA53jeUD4uMT7tdQ/ssXR
 W4taeNqKdsCvzBXI42B76B/0fFz7crHCQA6vvVoJH9EejM+H+RgeuoQYvV+SIPOqM8Pj
 nhztKqT7jjvPYJHMuUj8DgLl21nUFaSPZPmU+kPuHxnGfqrAxNjPssp0B/c0CqWEMgLV VQ== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3u8xyd0cqg-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 09 Nov 2023 12:04:54 +0000
Received: from m0353723.ppops.net (m0353723.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 3A9BtEMm019926;
 Thu, 9 Nov 2023 12:04:53 GMT
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3u8xyd0cq8-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 09 Nov 2023 12:04:53 +0000
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 3A9B12pd028310; Thu, 9 Nov 2023 12:04:53 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3u7w22kk7g-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 09 Nov 2023 12:04:52 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com
 [10.20.54.105])
 by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 3A9C4pUl13501168
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 9 Nov 2023 12:04:51 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id F3E7D20040;
 Thu,  9 Nov 2023 12:04:50 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id C499A2004B;
 Thu,  9 Nov 2023 12:04:50 +0000 (GMT)
Received: from a46lp67.. (unknown [9.152.108.100])
 by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Thu,  9 Nov 2023 12:04:50 +0000 (GMT)
From: Janosch Frank <frankja@linux.ibm.com>
To: qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, marcandre.lureau@redhat.com, thuth@redhat.com,
 imbrenda@linux.ibm.com
Subject: [PATCH v2 2/3] dump: Add arch cleanup function
Date: Thu,  9 Nov 2023 12:04:42 +0000
Message-Id: <20231109120443.185979-3-frankja@linux.ibm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231109120443.185979-1-frankja@linux.ibm.com>
References: <20231109120443.185979-1-frankja@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: nO6g0Sx6On8ED3Js7PDM8g8QS5jDaDO0
X-Proofpoint-ORIG-GUID: XmTniXYMAhcV2XJ4pxyZjnzzjZkyxp9N
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-09_10,2023-11-09_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 bulkscore=0
 mlxlogscore=572 adultscore=0 lowpriorityscore=0 phishscore=0
 priorityscore=1501 impostorscore=0 malwarescore=0 mlxscore=0
 suspectscore=0 clxscore=1015 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2311060000 definitions=main-2311090089
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

Some architectures (s390x) need to cleanup after a failed dump to be
able to continue to run the vm. Add a cleanup function pointer and
call it if it's set.

Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
---
 dump/dump.c                | 4 ++++
 include/sysemu/dump-arch.h | 1 +
 2 files changed, 5 insertions(+)

diff --git a/dump/dump.c b/dump/dump.c
index d355ada62e..9eeb7ab453 100644
--- a/dump/dump.c
+++ b/dump/dump.c
@@ -96,6 +96,10 @@ uint64_t cpu_to_dump64(DumpState *s, uint64_t val)
 
 static int dump_cleanup(DumpState *s)
 {
+    if (s->dump_info.arch_cleanup_fn) {
+        s->dump_info.arch_cleanup_fn(s);
+    }
+
     guest_phys_blocks_free(&s->guest_phys_blocks);
     memory_mapping_list_free(&s->list);
     close(s->fd);
diff --git a/include/sysemu/dump-arch.h b/include/sysemu/dump-arch.h
index 59bbc9be38..743916e46c 100644
--- a/include/sysemu/dump-arch.h
+++ b/include/sysemu/dump-arch.h
@@ -24,6 +24,7 @@ typedef struct ArchDumpInfo {
     void (*arch_sections_add_fn)(DumpState *s);
     uint64_t (*arch_sections_write_hdr_fn)(DumpState *s, uint8_t *buff);
     int (*arch_sections_write_fn)(DumpState *s, uint8_t *buff);
+    void (*arch_cleanup_fn)(DumpState *s);
 } ArchDumpInfo;
 
 struct GuestPhysBlockList; /* memory_mapping.h */
-- 
2.34.1



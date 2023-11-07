Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 60F917E41B9
	for <lists+qemu-devel@lfdr.de>; Tue,  7 Nov 2023 15:21:56 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r0MxB-0000sn-8j; Tue, 07 Nov 2023 09:21:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <frankja@linux.ibm.com>)
 id 1r0Mx9-0000sS-IC; Tue, 07 Nov 2023 09:21:15 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <frankja@linux.ibm.com>)
 id 1r0Mx7-00071A-Jk; Tue, 07 Nov 2023 09:21:15 -0500
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 3A7EK1Z5018422; Tue, 7 Nov 2023 14:21:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=at7fwd4i5wuk4G9X3L4wCGqhlwkM4JHbQIKrDTw7Rjk=;
 b=rOABPsUuDhRNjPXGNKMdlUKB6HdF0DHajor8Dn2rxGIOfsOn3LCxfCSW4k6v/GR9zKdj
 yzLTHRb8oWohvs+yuGgiQH9lwSkwqNPMKXxEBfn3exI7FS7gq3fShDVALoMpv7JvX0pW
 OHb3/hD2HW3yl1wGceWCIKlAaYDjSXDSp3MC8M1O8zG7jnqfQUS7giXLHdvQ1zMvTXgG
 k4U2/LZwHotFOCTa1uSeI3ovrJPvkTC5wAVQzVt56dzHJo3O0xSB818eHigiToP0USbC
 PiWnVmYFBgd3oYXkfwvaD8S5TR75un+AWWB/rYfIm76OSGb8VguFi5lghVgT5ncSwrW5 3w== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3u7pwj00ym-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 07 Nov 2023 14:21:10 +0000
Received: from m0356516.ppops.net (m0356516.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 3A7EL5MJ021634;
 Tue, 7 Nov 2023 14:21:10 GMT
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3u7pwj00x5-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 07 Nov 2023 14:21:10 +0000
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 3A7DQOxH007938; Tue, 7 Nov 2023 14:21:09 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3u61skgxbp-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 07 Nov 2023 14:21:09 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com
 [10.20.54.105])
 by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 3A7EL7Uj37880330
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 7 Nov 2023 14:21:07 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 3A64C2004D;
 Tue,  7 Nov 2023 14:21:07 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 2025F20040;
 Tue,  7 Nov 2023 14:21:07 +0000 (GMT)
Received: from a46lp67.. (unknown [9.152.108.100])
 by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Tue,  7 Nov 2023 14:21:07 +0000 (GMT)
From: Janosch Frank <frankja@linux.ibm.com>
To: qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, marcandre.lureau@redhat.com, thuth@redhat.com,
 imbrenda@linux.ibm.com
Subject: [PATCH 3/4] dump: Add arch cleanup function
Date: Tue,  7 Nov 2023 14:20:47 +0000
Message-Id: <20231107142048.22422-4-frankja@linux.ibm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231107142048.22422-1-frankja@linux.ibm.com>
References: <20231107142048.22422-1-frankja@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: H9oLxpY4-xwjhiUm-3mElocxIJvSBTV6
X-Proofpoint-GUID: P1Xk5hTVFQnruQgc7KpO_vu_PmCneWhb
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-07_05,2023-11-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxscore=0 priorityscore=1501
 adultscore=0 impostorscore=0 spamscore=0 clxscore=1015 lowpriorityscore=0
 mlxlogscore=676 phishscore=0 malwarescore=0 bulkscore=0 suspectscore=0
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

Some architectures (s390x) need to cleanup after a failed dump to be
able to continue to run the vm. Add a cleanup function pointer and
call it if it's set.

Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
---
 dump/dump.c                | 5 +++++
 include/sysemu/dump-arch.h | 1 +
 2 files changed, 6 insertions(+)

diff --git a/dump/dump.c b/dump/dump.c
index 1d38274925..5c4e405ad2 100644
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
@@ -1709,6 +1713,7 @@ static void dump_state_prepare(DumpState *s)
     s->dump_info.arch_sections_add_fn = NULL;
     s->dump_info.arch_sections_write_hdr_fn = NULL;
     s->dump_info.arch_sections_write_fn = NULL;
+    s->dump_info.arch_cleanup_fn = NULL;
 }
 
 bool qemu_system_dump_in_progress(void)
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



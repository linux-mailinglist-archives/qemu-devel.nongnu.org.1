Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AB7A7125FA
	for <lists+qemu-devel@lfdr.de>; Fri, 26 May 2023 13:52:03 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q2VyW-000236-KQ; Fri, 26 May 2023 07:51:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>) id 1q2VyT-00022j-RK
 for qemu-devel@nongnu.org; Fri, 26 May 2023 07:51:13 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>) id 1q2VyH-00089J-N7
 for qemu-devel@nongnu.org; Fri, 26 May 2023 07:51:13 -0400
Received: from pps.filterd (m0353726.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 34QB70Ox008720; Fri, 26 May 2023 11:50:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=pp1;
 bh=ttuqpbzwhJ4Wl/jaHNKltf3RIbjvKG8zKbpGiPou+Cc=;
 b=DgbyJY0R6ctWR1b7wIVbEvgLxIHKPpHpHrR7gHP1I0DH6xiCFfe5ZrLGnje7lbLqgIgx
 cm4zK67WJGRbhOFqvmYpyNyrkdY/gTYaT6FrjFVyAn4EH+xnEAJd68/XYPyU//Jabnc2
 7m7n+ug815x+ca5M0fhrkO0DfoMmSNcF2Nr44fQKESPGmAMCQapI5IHa+sI89jDyYilH
 5dWA7GIREBsKWdf/UfHwNzWwuW6VjA1iz9QhzbzbOOO/8PvsQy3GSf4MK1bNvS0PIcmR
 Tesf7MvF41B48oUuZroV7tY5LtlHTwLrLQ+wNUFfw1L8qM+U8J3rn66tynJ3gGSxZyc9 eQ== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3qtsnqm4wc-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 26 May 2023 11:50:58 +0000
Received: from m0353726.ppops.net (m0353726.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 34QBRPQv005813;
 Fri, 26 May 2023 11:50:58 GMT
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com
 [169.51.49.98])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3qtsnqm4v3-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 26 May 2023 11:50:58 +0000
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
 by ppma03ams.nl.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 34Q4FqlQ008542;
 Fri, 26 May 2023 11:50:56 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
 by ppma03ams.nl.ibm.com (PPS) with ESMTPS id 3qppcuawtm-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 26 May 2023 11:50:56 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com
 [10.20.54.104])
 by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 34QBoqsT23724578
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 26 May 2023 11:50:52 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 9116B20049;
 Fri, 26 May 2023 11:50:52 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id EAC4420040;
 Fri, 26 May 2023 11:50:51 +0000 (GMT)
Received: from heavy.boeblingen.de.ibm.com (unknown [9.171.55.92])
 by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Fri, 26 May 2023 11:50:51 +0000 (GMT)
From: Ilya Leoshkevich <iii@linux.ibm.com>
To: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>
Cc: "Dominik 'Disconnect3d' Czarnota" <dominik.b.czarnota@gmail.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Andreas Arnez <arnez@linux.ibm.com>, qemu-devel@nongnu.org,
 Ilya Leoshkevich <iii@linux.ibm.com>
Subject: [PATCH v2 3/6] gdbstub: Report the actual qemu-user pid
Date: Fri, 26 May 2023 13:50:38 +0200
Message-Id: <20230526115041.1362009-4-iii@linux.ibm.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230526115041.1362009-1-iii@linux.ibm.com>
References: <20230526115041.1362009-1-iii@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: jcpc4W6xr7IGJ9Zs7W71AMvlRqx6Aj8c
X-Proofpoint-ORIG-GUID: Ln1yt6o1xEX-N6LnARDFBw3PBuTBS-sQ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-05-26_01,2023-05-25_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxlogscore=999 adultscore=0
 clxscore=1015 mlxscore=0 suspectscore=0 priorityscore=1501 phishscore=0
 impostorscore=0 spamscore=0 bulkscore=0 malwarescore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2304280000
 definitions=main-2305260099
Received-SPF: pass client-ip=148.163.156.1; envelope-from=iii@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

Currently qemu-user reports pid 1 to GDB. Resolve the TODO and report
the actual PID. Using getpid() relies on the assumption that there is
only one GDBProcess. Add an assertion to make sure that future changes
don't break it.

Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
---
 gdbstub/gdbstub.c | 25 +++++++++++++++++--------
 1 file changed, 17 insertions(+), 8 deletions(-)

diff --git a/gdbstub/gdbstub.c b/gdbstub/gdbstub.c
index 9139fec92af..c7e3ee71f2f 100644
--- a/gdbstub/gdbstub.c
+++ b/gdbstub/gdbstub.c
@@ -202,13 +202,16 @@ void gdb_memtox(GString *buf, const char *mem, int len)
 
 static uint32_t gdb_get_cpu_pid(CPUState *cpu)
 {
-    /* TODO: In user mode, we should use the task state PID */
+#ifdef CONFIG_USER_ONLY
+    return getpid();
+#else
     if (cpu->cluster_index == UNASSIGNED_CLUSTER_INDEX) {
         /* Return the default process' PID */
         int index = gdbserver_state.process_num - 1;
         return gdbserver_state.processes[index].pid;
     }
     return cpu->cluster_index + 1;
+#endif
 }
 
 GDBProcess *gdb_get_process(uint32_t pid)
@@ -2146,19 +2149,25 @@ void gdb_read_byte(uint8_t ch)
 void gdb_create_default_process(GDBState *s)
 {
     GDBProcess *process;
-    int max_pid = 0;
+    int pid;
 
+#ifdef CONFIG_USER_ONLY
+    assert(gdbserver_state.process_num == 0);
+    pid = getpid();
+#else
     if (gdbserver_state.process_num) {
-        max_pid = s->processes[s->process_num - 1].pid;
+        pid = s->processes[s->process_num - 1].pid;
+    } else {
+        pid = 0;
     }
+    /* We need an available PID slot for this process */
+    assert(pid < UINT32_MAX);
+    pid++;
+#endif
 
     s->processes = g_renew(GDBProcess, s->processes, ++s->process_num);
     process = &s->processes[s->process_num - 1];
-
-    /* We need an available PID slot for this process */
-    assert(max_pid < UINT32_MAX);
-
-    process->pid = max_pid + 1;
+    process->pid = pid;
     process->attached = false;
     process->target_xml[0] = '\0';
 }
-- 
2.40.1



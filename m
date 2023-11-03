Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id EEA9D7E061A
	for <lists+qemu-devel@lfdr.de>; Fri,  3 Nov 2023 17:03:15 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qywcW-00041h-Pw; Fri, 03 Nov 2023 12:02:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1qywcU-00040q-Nc
 for qemu-devel@nongnu.org; Fri, 03 Nov 2023 12:02:02 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1qywcR-0004Mf-Gv
 for qemu-devel@nongnu.org; Fri, 03 Nov 2023 12:02:02 -0400
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 3A3FERAD027268; Fri, 3 Nov 2023 16:01:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id; s=corp-2023-03-30;
 bh=blw1igxzn88xL1apWnJzyKWnO5zYL5R0WWASLE48pmw=;
 b=XPAmZj37ZGZP98iNBwPaMHmWpl12SuIg/6eV0EYpU7FnHNc/1H4E8Ss2kN/rDpD4Dy+t
 dFTQHDqiC9m1OJkhXT9SJG1x7EyjiFYeGRQM4zmpJMWDAaDe955xp1FzpjnIZGBmuap6
 KNDurcBFDWPWYj2GUrGkHAXpeaaANQ7Kd4jBs7aqtFzhKrDqhWgCd+gdPyng2oyF7uoO
 V0k7DiBIiZjZCv24K5bgYvp3vUaRsAHOVsLH5pzGLlX5/d4HrwXEW6/NpKJpL2c2h9W7
 n+WBvQSWl/m1hnVyWSev6t84lTZtT+pSLlVcJbA4wZ2QwDx2esltULQbowPQlf9EDbJd sg== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3u0t6bc5mh-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 03 Nov 2023 16:01:32 +0000
Received: from pps.filterd
 (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 3A3EYQJo022427; Fri, 3 Nov 2023 16:01:31 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 3u0rraa6fh-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 03 Nov 2023 16:01:31 +0000
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 3A3G1VJY020774;
 Fri, 3 Nov 2023 16:01:31 GMT
Received: from ca-dev63.us.oracle.com (ca-dev63.us.oracle.com [10.211.8.221])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with
 ESMTP id 3u0rraa6en-1; Fri, 03 Nov 2023 16:01:31 +0000
From: Steve Sistare <steven.sistare@oracle.com>
To: qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>, Michael Roth <michael.roth@amd.com>,
 "Dr. David Alan Gilbert" <dave@treblig.org>,
 Steve Sistare <steven.sistare@oracle.com>
Subject: [PATCH] monitor: flush messages on abort
Date: Fri,  3 Nov 2023 09:01:29 -0700
Message-Id: <1699027289-213995-1-git-send-email-steven.sistare@oracle.com>
X-Mailer: git-send-email 1.8.3.1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-03_15,2023-11-02_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 suspectscore=0
 malwarescore=0 mlxscore=0 mlxlogscore=999 adultscore=0 phishscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2310240000 definitions=main-2311030135
X-Proofpoint-GUID: WVo7Eqdcb0xCuku98gbyVCpoYkw0ttHw
X-Proofpoint-ORIG-GUID: WVo7Eqdcb0xCuku98gbyVCpoYkw0ttHw
Received-SPF: pass client-ip=205.220.165.32;
 envelope-from=steven.sistare@oracle.com; helo=mx0a-00069f02.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

Buffered monitor output is lost when abort() is called.  The pattern
error_report() followed by abort() occurs about 60 times, so valuable
information is being lost when the abort is called in the context of a
monitor command.

To fix, install a SIGABRT handler to flush the monitor buffer to stderr.

Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
---
 monitor/monitor.c | 38 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 38 insertions(+)

diff --git a/monitor/monitor.c b/monitor/monitor.c
index dc352f9..65dace0 100644
--- a/monitor/monitor.c
+++ b/monitor/monitor.c
@@ -701,6 +701,43 @@ void monitor_cleanup(void)
     }
 }
 
+#ifdef CONFIG_LINUX
+
+static void monitor_abort(int signal, siginfo_t *info, void *c)
+{
+    Monitor *mon = monitor_cur();
+
+    if (!mon || qemu_mutex_trylock(&mon->mon_lock)) {
+        return;
+    }
+
+    if (mon->outbuf && mon->outbuf->len) {
+        fputs("SIGABRT received: ", stderr);
+        fputs(mon->outbuf->str, stderr);
+        if (mon->outbuf->str[mon->outbuf->len - 1] != '\n') {
+            fputc('\n', stderr);
+        }
+    }
+
+    qemu_mutex_unlock(&mon->mon_lock);
+}
+
+static void monitor_add_abort_handler(void)
+{
+    struct sigaction act;
+
+    memset(&act, 0, sizeof(act));
+    act.sa_sigaction = monitor_abort;
+    act.sa_flags = SA_SIGINFO;
+    sigaction(SIGABRT,  &act, NULL);
+}
+
+#else
+
+static void monitor_add_abort_handler(void) {}
+
+#endif
+
 static void monitor_qapi_event_init(void)
 {
     monitor_qapi_event_state = g_hash_table_new(qapi_event_throttle_hash,
@@ -712,6 +749,7 @@ void monitor_init_globals(void)
     monitor_qapi_event_init();
     qemu_mutex_init(&monitor_lock);
     coroutine_mon = g_hash_table_new(NULL, NULL);
+    monitor_add_abort_handler();
 
     /*
      * The dispatcher BH must run in the main loop thread, since we
-- 
1.8.3.1



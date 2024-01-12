Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E0CB82C771
	for <lists+qemu-devel@lfdr.de>; Fri, 12 Jan 2024 23:52:09 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rOQNa-0004hc-7Z; Fri, 12 Jan 2024 17:51:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1rOQNX-0004Zi-ER
 for qemu-devel@nongnu.org; Fri, 12 Jan 2024 17:51:55 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1rOQNV-0007tv-K6
 for qemu-devel@nongnu.org; Fri, 12 Jan 2024 17:51:55 -0500
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 40CMiS5I026083; Fri, 12 Jan 2024 22:51:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2023-11-20;
 bh=zhlm3xbwk6+9RTk8Ht5QhaZEMBY+ZoM6kBLk3kGlEoc=;
 b=iDgp9ZDO/LToqGKuFJGavmPamUtMJnnqMhrh3sAUALx7as/4LsIyJSAS5mBt48hbxBg+
 9MqcihYRH0ZN/wGvSsWe4x8f3YmRUtSEev46LE7A/t09WUFGqWfviZLDycz+3wEBDIRw
 12eBa7/pzq9rt5DGsupEUn50AsC45CromUiUk7YBq8SdmzQeTs5z3BSxF42kq60ssG1n
 CctQoYhrS8TB3pdh0zoFxsp+p5Q6O17jAWiRRB/zRbj+jC/qaxK11HoFjc49IpfAjsmH
 xBKzVLOgR+ct5r/sHmBlRkx3UJmNun4yc/welTd4d/L4IuGqFn6DqVTEtXO3ovVEJ1h8 wA== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3vk9acrh75-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 12 Jan 2024 22:51:47 +0000
Received: from pps.filterd
 (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 40CKoqsm008831; Fri, 12 Jan 2024 22:49:22 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 3vfuuqay7j-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 12 Jan 2024 22:49:22 +0000
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 40CMnIs2004223;
 Fri, 12 Jan 2024 22:49:21 GMT
Received: from ca-dev63.us.oracle.com (ca-dev63.us.oracle.com [10.211.8.221])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with
 ESMTP id 3vfuuqay5t-6; Fri, 12 Jan 2024 22:49:21 +0000
From: Steve Sistare <steven.sistare@oracle.com>
To: qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>, Michael Roth <michael.roth@amd.com>,
 Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Steve Sistare <steven.sistare@oracle.com>
Subject: [PATCH V4 5/5] migration: simplify exec migration functions
Date: Fri, 12 Jan 2024 14:49:18 -0800
Message-Id: <1705099758-211963-6-git-send-email-steven.sistare@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1705099758-211963-1-git-send-email-steven.sistare@oracle.com>
References: <1705099758-211963-1-git-send-email-steven.sistare@oracle.com>
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-12_12,2024-01-12_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999
 phishscore=0 mlxscore=0
 spamscore=0 adultscore=0 malwarescore=0 suspectscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2401120178
X-Proofpoint-GUID: A-rfq1uSakktmsSnqfpN6H-DptTXkugR
X-Proofpoint-ORIG-GUID: A-rfq1uSakktmsSnqfpN6H-DptTXkugR
Received-SPF: pass client-ip=205.220.177.32;
 envelope-from=steven.sistare@oracle.com; helo=mx0b-00069f02.pphosted.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Simplify the exec migration code by using list utility functions.

As a side effect, this also fixes a minor memory leak.  On function return,
"g_auto(GStrv) argv" frees argv and each element, which is wrong, because
the function does not own the individual elements.  To compensate, the code
uses g_steal_pointer which NULLs argv and prevents the destructor from
running, but argv is leaked.

Fixes: cbab4face57b ("migration: convert exec backend ...")
Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
---
 migration/exec.c | 58 ++++++++------------------------------------------------
 1 file changed, 8 insertions(+), 50 deletions(-)

diff --git a/migration/exec.c b/migration/exec.c
index 47d2f3b..1312ca7 100644
--- a/migration/exec.c
+++ b/migration/exec.c
@@ -19,12 +19,12 @@
 
 #include "qemu/osdep.h"
 #include "qemu/error-report.h"
+#include "qemu/strList.h"
 #include "channel.h"
 #include "exec.h"
 #include "migration.h"
 #include "io/channel-command.h"
 #include "trace.h"
-#include "qemu/cutils.h"
 
 #ifdef WIN32
 const char *exec_get_cmd_path(void)
@@ -39,51 +39,16 @@ const char *exec_get_cmd_path(void)
 }
 #endif
 
-/* provides the length of strList */
-static int
-str_list_length(strList *list)
-{
-    int len = 0;
-    strList *elem;
-
-    for (elem = list; elem != NULL; elem = elem->next) {
-        len++;
-    }
-
-    return len;
-}
-
-static void
-init_exec_array(strList *command, char **argv, Error **errp)
-{
-    int i = 0;
-    strList *lst;
-
-    for (lst = command; lst; lst = lst->next) {
-        argv[i++] = lst->value;
-    }
-
-    argv[i] = NULL;
-    return;
-}
-
 void exec_start_outgoing_migration(MigrationState *s, strList *command,
                                    Error **errp)
 {
-    QIOChannel *ioc;
-
-    int length = str_list_length(command);
-    g_auto(GStrv) argv = (char **) g_new0(const char *, length + 1);
-
-    init_exec_array(command, argv, errp);
+    QIOChannel *ioc = NULL;
+    g_auto(GStrv) argv = strv_from_strList(command);
+    const char * const *args = (const char * const *) argv;
     g_autofree char *new_command = g_strjoinv(" ", (char **)argv);
 
     trace_migration_exec_outgoing(new_command);
-    ioc = QIO_CHANNEL(
-        qio_channel_command_new_spawn(
-                            (const char * const *) g_steal_pointer(&argv),
-                            O_RDWR,
-                            errp));
+    ioc = QIO_CHANNEL(qio_channel_command_new_spawn(args, O_RDWR, errp));
     if (!ioc) {
         return;
     }
@@ -105,19 +70,12 @@ static gboolean exec_accept_incoming_migration(QIOChannel *ioc,
 void exec_start_incoming_migration(strList *command, Error **errp)
 {
     QIOChannel *ioc;
-
-    int length = str_list_length(command);
-    g_auto(GStrv) argv = (char **) g_new0(const char *, length + 1);
-
-    init_exec_array(command, argv, errp);
+    g_auto(GStrv) argv = strv_from_strList(command);
+    const char * const *args = (const char * const *) argv;
     g_autofree char *new_command = g_strjoinv(" ", (char **)argv);
 
     trace_migration_exec_incoming(new_command);
-    ioc = QIO_CHANNEL(
-        qio_channel_command_new_spawn(
-                            (const char * const *) g_steal_pointer(&argv),
-                            O_RDWR,
-                            errp));
+    ioc = QIO_CHANNEL(qio_channel_command_new_spawn(args, O_RDWR, errp));
     if (!ioc) {
         return;
     }
-- 
1.8.3.1



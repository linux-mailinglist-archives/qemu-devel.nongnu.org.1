Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 951C57D6DE8
	for <lists+qemu-devel@lfdr.de>; Wed, 25 Oct 2023 16:02:23 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qveRm-0003y0-KK; Wed, 25 Oct 2023 10:01:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alexander.ivanov@virtuozzo.com>)
 id 1qveRk-0003xR-8K
 for qemu-devel@nongnu.org; Wed, 25 Oct 2023 10:01:20 -0400
Received: from mail-vi1eur04on070f.outbound.protection.outlook.com
 ([2a01:111:f400:fe0e::70f]
 helo=EUR04-VI1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alexander.ivanov@virtuozzo.com>)
 id 1qveRh-0005dH-2o
 for qemu-devel@nongnu.org; Wed, 25 Oct 2023 10:01:20 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jNhall0swdBQVMZ20kij1T1dlc+FIWzpBpLcZ27pwa1m2/TNvqVLDzBw9eTwCnWoWai2gBNYYw9PzGpVx3MZx5g2mpBluZXeu805TzGVIqWNGEMzUeSRDzS7MYtwXwaWlUUt87pspLynohF/RuS8tWOrOTxFFFnuBDxZ7k97RQ3ZzDUKx4+Z5V0M63tFCkg6g0XJpoGX2plJ3PU3hb0A4DFDgUulys02vzeXXIN4Q3RFS3+lADNN5WEmAhyy5cQIhN6cLUVDkRB7vjHrGKO4XQX8NkV3Y8FualnhNNldddFEgyDuHpVdjZFZLpp3cW5p7FKEuIhIdZfXu353gTJIKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QiKEJZAMreISJPc0Piy0EJbV//TtR7aZLs63Xu4O4bw=;
 b=kcPVdlPt/X5aPPyE4NoBR3Bf/qNy3aBW5TQSEaailP6Mph8VbES0hOYAm9FL7C7qkoHeGM2esY3ikZ0HkgINkp3TOvLrGKaQHgg1+DGHWeVt99/+vPnOH5zHHO+LZCBxxwWZkebeV08X13KGCl3J4ubTji/UXHzEgXPJeElqYNLZcdQxm15YbOqPctzFdz2VWSu5nVuux6bqAGNJGq/WftUqIqQSec+FaNDYOpyPF+dNGuBHxmwNQFLdgRFfhboVc1OcTPrNZo1twviHEbLamsRkC/dTiuGx+mBHjBjfMMEHmPiQ2U1OBEmUtktXApbyUIq49JJaK7XKdgLFpNsXQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QiKEJZAMreISJPc0Piy0EJbV//TtR7aZLs63Xu4O4bw=;
 b=o0kQ5iUBhUAxRo1bpJpBR4gRQaHo2Q5hE4UvLd66r45Fa5lM/vXCDAg5twkKu5SN1g15C06vvs1A1qy9U6kwzu+s2aGxIZ8q2Lh9/LQJ9IfuURIIefdrqePGxOHgr98luXf6q2yAWRXtNN+mT91bP7TDfZsat8Fg+LwBe8VWKjMHgxBBOcRDcHW1rjtKubRz+DFIXqQKkHSQ9jCVKDKqq6VEr3NhbbwuJptpKIXqKCpcHx32ZfXzvxYdpb7UHQJkgBGk7maqto2+Fzp9t6MhWD6dKu/iVB7jlBtaHPMJXA0bA9G5N6GhwRqBJPwcBf+QCpvt2eB7egesINOVgiZcRw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from VI0PR08MB10743.eurprd08.prod.outlook.com
 (2603:10a6:800:205::19) by AS8PR08MB10363.eurprd08.prod.outlook.com
 (2603:10a6:20b:56b::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.31; Wed, 25 Oct
 2023 14:01:09 +0000
Received: from VI0PR08MB10743.eurprd08.prod.outlook.com
 ([fe80::22f7:6498:de53:5371]) by VI0PR08MB10743.eurprd08.prod.outlook.com
 ([fe80::22f7:6498:de53:5371%4]) with mapi id 15.20.6863.043; Wed, 25 Oct 2023
 14:01:09 +0000
From: Alexander Ivanov <alexander.ivanov@virtuozzo.com>
To: qemu-devel@nongnu.org
Cc: den@virtuozzo.com, michael.roth@amd.com, kkostiuk@redhat.com,
 marcandre.lureau@gmail.com
Subject: [PATCH 1/6] qga: Add process termination functionality
Date: Wed, 25 Oct 2023 16:00:53 +0200
Message-Id: <20231025140058.113376-2-alexander.ivanov@virtuozzo.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231025140058.113376-1-alexander.ivanov@virtuozzo.com>
References: <20231025140058.113376-1-alexander.ivanov@virtuozzo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: VI1PR06CA0167.eurprd06.prod.outlook.com
 (2603:10a6:803:c8::24) To VI0PR08MB10743.eurprd08.prod.outlook.com
 (2603:10a6:800:205::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI0PR08MB10743:EE_|AS8PR08MB10363:EE_
X-MS-Office365-Filtering-Correlation-Id: d315f134-865d-4f3f-734e-08dbd562d6be
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nZ93+tp9ytY7xVLrLB3Ob8IdEtl4GZ1EBGtjLev1e7Z0EtttR2lOf9WEGmRJBZRiDSyk9o7KLS111j8K/9CWRDgAUD/pgavwKz4St9JJl16nAQigkMtPy3kiam0icSUOPxBcNMM2qUyamk5+omjjMoA9d4BxbteIEIVcesuOd/caDDdeTzMW342353FGzK6nn/A8o04R2lSuhv/Uxs0pTVXG8PIBCsWm8lZJdbG0MmZmzGHOeLmjplPnW5sq6oBsv89k6Vj+PSfHREUp4H5fyoexdPiKpAyoblklZ+8sIZ/1a4GSmU4/QlQWmcZva0awIUWl3UG6bLbBhb/WFGITETF3g9kFElKT5oXUD0Yt47LSAlPL2gqMj2fJk2OBF5HB2ZMk8XkJFWrjKrmlIKGwzqnmu+pVH7v1pJnP+SreSTOr//dHYC8lMKoWsZsAtHVfWRG3/HnKqbWwBo66KpkjmCIK34+ofZIY1QitPIu6XovAomgLoj1/CE0NKyzEt3W2i+uF44bk7P6vyiDi6/kLre4qK0HvRGZQlCEGyqFWY4HDvTa3wjJ/I8Ud4qQjtI9psh/PfWVzjLvYE1EKnlGtzepwy/LYUvgSfCpOIGDrP3nAms0d2K8bLos7c2y9okzn
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VI0PR08MB10743.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(396003)(136003)(346002)(39850400004)(366004)(376002)(230922051799003)(64100799003)(1800799009)(451199024)(186009)(2906002)(38100700002)(66946007)(2616005)(66476007)(316002)(66556008)(6916009)(6666004)(6506007)(478600001)(1076003)(6486002)(6512007)(52116002)(83380400001)(36756003)(44832011)(5660300002)(86362001)(4326008)(8676002)(41300700001)(8936002)(26005)(38350700005);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?3EXRMjJ5eDRzqDOuRvshh1ZYsYLLFEr8zXdM9+9bMuZza4pTbr3VBtZ3YdTN?=
 =?us-ascii?Q?sGPfz/2D0OZNrxLiTUVAPcKHgx2CF1OitbPbCzGl/h7cEYrYeEaqixjBsHf6?=
 =?us-ascii?Q?ITfHimRmI72H+wyuhc78VCDBhh13EZ0OrvElzBqP9KuTRdp0m4L6KD0vsnI7?=
 =?us-ascii?Q?mECvn2dasSEDBClpEmCyZm61o5waQ0pZ1R/mnjr20RYJ+HBaRKqEF73RWYxX?=
 =?us-ascii?Q?Qcoiu4WFpR8YGJzDuTnOjb1aX/3/eybPPIXsC8qjFEJH/Vum5VFlS0+2wAro?=
 =?us-ascii?Q?SJI/I3+KP9NU3ov23ZnOXnFbNvnORt0SBn4PDxU1sp2Od8zhntUGb+HnkUDA?=
 =?us-ascii?Q?HN/IYY3iEmB2JtS+E4XwItJmYFyNpIPlDp7ZTbmvad6qy63MAGNlmp1EJCpP?=
 =?us-ascii?Q?n8bj/Hg95kvKLU92/yXhEjboPkIk8wdVl3ulGYkIcy7ylpjf4W77X3dcUi5v?=
 =?us-ascii?Q?4zUsK2CHxvmAEIe+bItyyKc6aGy25Ufb12VgoW31gVMQVTcksBBQfIYplcht?=
 =?us-ascii?Q?opBdLCrHkBnkI0Gj2eCWzppTEpD83gNyBOjtEgiiZhDBat/tPOdQDcKNcPsM?=
 =?us-ascii?Q?dcd09RuHDtNODI6b9FUQBmAceIOI/iwmZKmL7J0Wa1gafM4IWbwoYqqXoRT5?=
 =?us-ascii?Q?Kz6Bplouzb4kq81oErzUZcBrmtCGEiC1U4nmzHRQOtSkbmdFaKza6v5IZJZN?=
 =?us-ascii?Q?b8mWa3FDxMZOsurdwcb7c2S6OzaPium/ikH9++FhFVq5Knkh2KDWq0H3lnn8?=
 =?us-ascii?Q?LKYIBrYOh5GNRB0oGODKr32fEtEa495I24JVp2PTL2dft08I4BnIhKo87Cdd?=
 =?us-ascii?Q?ya0plhU4JJqLyPu7Xs6O6at4wDOEAXGUgWzvHbiUQxx7hr8gUCRp4B6AG/c+?=
 =?us-ascii?Q?/EmlTfKuZ4sZW66fh1JvmqpUEB6cAFmUmTXEpYru85KR16JqgKnRIMp4TWXr?=
 =?us-ascii?Q?hbMpkSbNRrMHM/8m+pjmTE4guHCNkiu6ccaVzyvKUpLFmNOi549nCdZCl/xk?=
 =?us-ascii?Q?h5QOeBxgqttUBay6mV94uJiXRGupFC9r760rpMx12tawBqS4xVrCZMn9kguY?=
 =?us-ascii?Q?dkFfLrYnjP6d6O+tCtSepp8rNT3Uezqg3UJ7/QW4d0KTau6e5ybwdZA2QwFN?=
 =?us-ascii?Q?D5bOZbtMgzVrrDI+XJp4hw3OnvSPBvGShRRvy9cTUhdxBrghec9SHdwqJwj4?=
 =?us-ascii?Q?p4y+ll4oRbwUDSCad3Rt6cZ+3qVqYfb939ytzNDWWrL81gBsIqdVOVrOy6d1?=
 =?us-ascii?Q?Gx58EB4n77ihfvbtUKj78WuZIYBTltTa95sh2UmP2gOeT+C31WH/O2xkusI5?=
 =?us-ascii?Q?5GUMVmhKi6zegMxKqmUgaC42lzos9d7AzyPwIyCQYQzQ7sNl9LLxa+aCns+d?=
 =?us-ascii?Q?v/+t7X63GfwtbwEZZWK7MirqTQtRxOk4/drtI7Gg5rH4H9NGUYV9sbUhAcxP?=
 =?us-ascii?Q?tf0mqfkbP06VLwhNUEYJod4RTEc8WsLMEmnmcMDHSJ4jBwqgPDos1kbVurJC?=
 =?us-ascii?Q?DJxP4xsk50+PNZDnOQ2u9KIXQD4pNRPalQaJ4nVUVr4XSQFLHJdALmYmhZIE?=
 =?us-ascii?Q?dpDr7jEo0/eL0Wjnsdy8mW//BK4XeTZxYpBXeqfkDT12ns8SksYwnAIhb41j?=
 =?us-ascii?Q?1B9p8zcpARRxU9nPeEGVkLM=3D?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d315f134-865d-4f3f-734e-08dbd562d6be
X-MS-Exchange-CrossTenant-AuthSource: VI0PR08MB10743.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Oct 2023 14:01:09.0646 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LHNtP73bD3YZlvs+D9FUL+372SxxFPKPpaYQP47IqUuTDogbDzHw3Q/AoM9EscECGhm0VctI4bwKCp5a4c9Hey9m3lkY3Vej0vXbooKKBeE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR08MB10363
Received-SPF: pass client-ip=2a01:111:f400:fe0e::70f;
 envelope-from=alexander.ivanov@virtuozzo.com;
 helo=EUR04-VI1-obe.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

We need to terminate processes executed with guest-exec command. Add
guest-exec-terminate command for process termination by PID.

Signed-off-by: Alexander Ivanov <alexander.ivanov@virtuozzo.com>
---
 qga/commands-common.h |  2 ++
 qga/commands-win32.c  | 64 +++++++++++++++++++++++++++++++++++++++++++
 qga/commands.c        | 34 +++++++++++++++++++++++
 qga/qapi-schema.json  | 13 +++++++++
 4 files changed, 113 insertions(+)

diff --git a/qga/commands-common.h b/qga/commands-common.h
index 8c1c56aac9..34b9a22578 100644
--- a/qga/commands-common.h
+++ b/qga/commands-common.h
@@ -80,4 +80,6 @@ GuestFileRead *guest_file_read_unsafe(GuestFileHandle *gfh,
  */
 char *qga_get_host_name(Error **errp);
 
+int kill_process_tree(int64_t pid);
+
 #endif
diff --git a/qga/commands-win32.c b/qga/commands-win32.c
index 697c65507c..5aa43a9ed7 100644
--- a/qga/commands-win32.c
+++ b/qga/commands-win32.c
@@ -27,6 +27,7 @@
 #include <lm.h>
 #include <wtsapi32.h>
 #include <wininet.h>
+#include <tlhelp32.h>
 
 #include "guest-agent-core.h"
 #include "vss-win32.h"
@@ -2522,3 +2523,66 @@ GuestCpuStatsList *qmp_guest_get_cpustats(Error **errp)
     error_setg(errp, QERR_UNSUPPORTED);
     return NULL;
 }
+
+int kill_process_tree(int64_t pid)
+{
+    PROCESSENTRY32 proc_entry;
+    HANDLE snapshot, process;
+    GList *pid_entry, *pid_list = NULL;
+    bool added, success;
+    int res = 0;
+
+    snapshot = CreateToolhelp32Snapshot(TH32CS_SNAPPROCESS, 0);
+    if (snapshot == INVALID_HANDLE_VALUE) {
+        return GetLastError();
+    }
+
+    pid_list = g_list_append(pid_list, GUINT_TO_POINTER(pid));
+
+    proc_entry.dwSize = sizeof(PROCESSENTRY32);
+    do {
+        added = false;
+        for (success = Process32First(snapshot, &proc_entry);
+             success; success = Process32Next(snapshot, &proc_entry)) {
+            gpointer ppid_p, pid_p;
+            ppid_p = GUINT_TO_POINTER(proc_entry.th32ParentProcessID);
+            pid_p = GUINT_TO_POINTER(proc_entry.th32ProcessID);
+            if (g_list_find(pid_list, ppid_p) && !g_list_find(pid_list, pid_p)) {
+                pid_list = g_list_append(pid_list, pid_p);
+                added = true;
+            }
+        }
+    } while (added);
+
+    for (success = Process32First(snapshot, &proc_entry);
+         success; success = Process32Next(snapshot, &proc_entry)) {
+        if (g_list_find(pid_list, GUINT_TO_POINTER(proc_entry.th32ProcessID))) {
+            g_debug("killing pid=%u ppid=%u name=%s",
+                (guint)proc_entry.th32ProcessID,
+                (guint)proc_entry.th32ParentProcessID,
+                proc_entry.szExeFile);
+        }
+    }
+
+    CloseHandle(snapshot);
+
+    for (pid_entry = pid_list; pid_entry; pid_entry = pid_entry->next) {
+        pid = GPOINTER_TO_UINT(pid_entry->data);
+        process = OpenProcess(PROCESS_TERMINATE, FALSE, pid);
+        if (process == INVALID_HANDLE_VALUE) {
+            if (!res) {
+                res = GetLastError();
+                if (res == ERROR_FILE_NOT_FOUND) {
+                    res = 0;
+                }
+            }
+            continue;
+        }
+        TerminateProcess(process, 255);
+        CloseHandle(process);
+    }
+
+    g_list_free(pid_list);
+
+    return res;
+}
diff --git a/qga/commands.c b/qga/commands.c
index ce172edd2d..af8459c587 100644
--- a/qga/commands.c
+++ b/qga/commands.c
@@ -529,6 +529,40 @@ done:
     return ge;
 }
 
+void qmp_guest_exec_terminate(int64_t pid, Error **errp)
+{
+    GuestExecInfo *gei;
+
+    slog("guest-exec-terminate called, pid: %u", (uint32_t)pid);
+
+    gei = guest_exec_info_find(pid);
+    if (gei == NULL) {
+        error_setg(errp, QERR_INVALID_PARAMETER, "pid");
+        return;
+    }
+
+    if (gei->finished) {
+        return;
+    }
+
+#ifdef G_OS_WIN32
+    char buf[32];
+    int res;
+
+    res = kill_process_tree(pid);
+    if (res != 0) {
+        snprintf(buf, sizeof(buf), "win32 err %d", res);
+        error_setg(errp, QERR_QGA_COMMAND_FAILED, buf);
+    }
+#else
+    if (kill(pid, SIGKILL) < 0) {
+        if (errno != ESRCH) {
+            error_setg(errp, QERR_QGA_COMMAND_FAILED, strerror(errno));
+        }
+    }
+#endif
+}
+
 /* Convert GuestFileWhence (either a raw integer or an enum value) into
  * the guest's SEEK_ constants.  */
 int ga_parse_whence(GuestFileWhence *whence, Error **errp)
diff --git a/qga/qapi-schema.json b/qga/qapi-schema.json
index 876e2a8ea8..b39be4cdc2 100644
--- a/qga/qapi-schema.json
+++ b/qga/qapi-schema.json
@@ -1326,6 +1326,19 @@
                '*input-data': 'str', '*capture-output': 'GuestExecCaptureOutput' },
   'returns': 'GuestExec' }
 
+##
+# @guest-exec-terminate:
+#
+# Terminate process associated with PID retrieved via guest-exec.
+#
+# @pid: pid returned from guest-exec
+#
+# Returns: Nothing on success.
+#
+# Since: 8.2
+##
+{ 'command': 'guest-exec-terminate',
+  'data':    { 'pid': 'int' } }
 
 ##
 # @GuestHostName:
-- 
2.34.1



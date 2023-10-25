Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A957D7D6DEB
	for <lists+qemu-devel@lfdr.de>; Wed, 25 Oct 2023 16:02:26 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qveRr-0003yl-BX; Wed, 25 Oct 2023 10:01:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alexander.ivanov@virtuozzo.com>)
 id 1qveRp-0003ya-9T
 for qemu-devel@nongnu.org; Wed, 25 Oct 2023 10:01:25 -0400
Received: from mail-vi1eur04on070f.outbound.protection.outlook.com
 ([2a01:111:f400:fe0e::70f]
 helo=EUR04-VI1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alexander.ivanov@virtuozzo.com>)
 id 1qveRk-0005dH-L6
 for qemu-devel@nongnu.org; Wed, 25 Oct 2023 10:01:25 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jBqgWxtk6wMbQKZXyTyl2OskNcGyaWvxDJrNZXnwSG7vBt2Uvf3Nyj8zkQyEjCl2QlOeWAvMgHhlWbiQKvpj0QUVPSgChxzLL64FZqvlh2lGTC6ed338yJawYB1xQKZWlw0HZ4elKHEpovtGwYIK/OEME03c87Uv1vZPS44JSJufIQ0nbCdWpCIUFV3Y3jkCKhBkM7OWmh+D1UOBrLZaR2bMlEkQAYY+ABdZte3RzI/80DJokej37G4TUXutK7nZbzYMAUtBogIU2IWMmsSE5WG9bbxuZ/wrj3FwBP7lqxkzXbHII4Ou/fXyLsbBHwBVAqvOf72cFS1gStxijU1RPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gIS1iMBgN5PYmhLo4ft1oZBzpwvYIL4FppP3JuHN5VA=;
 b=N4VYvETkqrXE0y6ELFaGs4SXH8o+WaUKYs+5CLiaHIM07HJpHLl1uetLAi7hUCqFw0NNE655sWIUyIO2NV0GpDoiL5x9aSzbefnCkVKo6JveVPKzmtytOwyJK77Cl854IXoeCtC2Tk1SQtgWDw/7qDV3KwNPFZC94fd1QxsXqwEBJAixJa6W9ouAANAbJWROVZ6vumhEc8pPCJjK1Doax+fJf2rPAYxILGanrV7OQMYxGNvIRBq8Gw3ZW6evuoRQOv2p4k/O/FUBA9ogjCbk7IH7hx5FBnJURDRo6oD6htdYq3vhz8ToIEkPKtwvhMrFodnuc9GThf5IVuMknx8lgQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gIS1iMBgN5PYmhLo4ft1oZBzpwvYIL4FppP3JuHN5VA=;
 b=pIQrtt6kWQu34ZbXSKAZ1YftpoyJWg1JWN25YNvQUmG77yidUgJ29jx1o9LlL+nHPRMw2mYRyeEfPFX41b/aWpg2UrHu60G4SzxcHdDOm0uQObgYf8gVZ7RdTfaRU1wkfyjj47eqCldJ+HHqNAxMazqJw5A83HaT5HoEip4scbkVu+DDL8qe28howzM0v7BE3nLZ9HMgn2T8HpyJCHap+pYiG2gC53aopHNnxL9hxCt3UvNFomVgJ29sGDmnJg8paE/WCq6AeC97aPgKyiNHNPi5HlmSu/muti55g8Py5Qm+74f+skXBTSJsIMW0mE7rIGbGitKW/YDF58l9m49zhw==
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
Subject: [PATCH 2/6] qga: Move command execution code to a separate function
Date: Wed, 25 Oct 2023 16:00:54 +0200
Message-Id: <20231025140058.113376-3-alexander.ivanov@virtuozzo.com>
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
X-MS-Office365-Filtering-Correlation-Id: c419e42b-4f95-4308-4b25-08dbd562d6f5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 17KxugMFTzMVca1b05Th4q7M5gPtBPZwW35mknUO7ZbhUQxJUdPdt5iXNPTjZXPysqqy4gNB3q7U6apNive1GYD8WiYJqplKXQ2boe8Pq1sQnEM6hMViyMENw4VJqx6kCOgCmt7gbbpwPcAlFhEqdVTZjVCVr4krbuYbguPErld3Hsg0QLeyxiNsa8vYX0Ixtz/qYZa4YBzFjtFmZoZXFVNMNgiHvlEO84QZScAh2xIKgOWE3eiA6PYzvRtTyRC/BM5PbkDcIP/oVzVp0653mvvUFMJ/GypJ3QA9jOGvboSv6zWAoXVlXx5MY4Cc819k2w9UQW1AJ4u2/480b3fWoseYSKNOoJ7ta0D3qiRMKhKqTTLWPk6tLItQO2RghUlk3eaGRbxt7WerkBooRxlNg0MrLtU2gkJ3edx5AiCPs2BKrgnTfxDijjTzWakXvIR+AQy1Q+deCv/2JYjrLBxqf59GTgsjPK8HiL+DVK5PdwALETBRsBU/QMI+Y6/GsfgOPwwrJbs80BXyVkKYH55u7drwTk8FWuYGBHVCWM+uHhYqUFAxA/OUq7kU+BjRCTJyXK9eP6wiHVfA1Oqu0FvVAulRyr74geSdWcp5qitwHLcBvZWS3GwUZTtbZg5VqAD2
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VI0PR08MB10743.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(396003)(136003)(346002)(39850400004)(366004)(376002)(230922051799003)(64100799003)(1800799009)(451199024)(186009)(2906002)(38100700002)(66946007)(2616005)(66476007)(316002)(66556008)(6916009)(6666004)(6506007)(478600001)(1076003)(6486002)(6512007)(52116002)(83380400001)(36756003)(44832011)(5660300002)(86362001)(4326008)(8676002)(41300700001)(8936002)(26005)(38350700005);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?yWq0Xd0THeXnK6nj+jjtjFwMazsRtquS4W+AL/2FnuT4rzv6IUYTniSNerTC?=
 =?us-ascii?Q?7OPrr6Amnw00yjRw3sRvCf9Sfy08J6ZeVlEJz5WYIXydISUhH4mRQTLkQgyV?=
 =?us-ascii?Q?CQbV1wUtnVlEIV0eX5vhQnoPo4zTc9hB85V6icAXqMWBdW4LuTBv8qiOVP10?=
 =?us-ascii?Q?NxBbADoca7VSCLUOJntAQQOR5dBT6yd1Z52EA6JGEqmj2PcKte4X2XuRyTCO?=
 =?us-ascii?Q?85yeynO+eLQTOtVv+0r9Ve2bcTIDou6YG5b0ns34/I/tkqBvk6i1+XBDm5qA?=
 =?us-ascii?Q?WwUGOjfBI+aomPi6fH+BmC3Yjson38/2g1H7rOn3BdaZUNjoxuBoLbUWi+95?=
 =?us-ascii?Q?v5Oa/bBc3jqfS8/kFRZ9GGmOt4MjZ/fwCWHm1axGklEXFfEq0q6cT9V87+0h?=
 =?us-ascii?Q?ecXWQ2+ESRTMESCjdVsPlfHnaxZxXVnxzYU1Cit7HuVlyGDpcKR1Gbe2SUXh?=
 =?us-ascii?Q?v+iNHJPkpKzN4HQxQCeStDlZloQ9BEX2bwZrTzAmnpkycmsS4xq1ZL8qusFt?=
 =?us-ascii?Q?cJ5oci/bOcrqCf+cAYf7I5BDC7eKj4lw0kMlkRNp+0GttuIFI23mT+p0+Ujy?=
 =?us-ascii?Q?adPVRqSZBfLvb69aQivTUnoN4/C7DdHcXtxqBCc3iC6pNwwSxa4LMzX5IYTv?=
 =?us-ascii?Q?EYLxCrdlGfcuMn0DR2zcwnncYyMEDcUiu7CvGSXcHJ/YxJmJXWRtC5neNAu7?=
 =?us-ascii?Q?spd+U6yO4pVB4EQL9VEhLO4/wHL9q2T/Zs3T/ZMMOjo8Zl5Ci6Nvf004FKyK?=
 =?us-ascii?Q?izrgzy8b9yLdLduO7F8qUJZ8CsW7nrjNjYU1qgZl54bccoLMwalGYK3U+RH7?=
 =?us-ascii?Q?t+kNn2jEuWRrcu7QJiDboj1N0lBXMcXmMYVIFnqkFXe1DjnTcPb9wajj02Yz?=
 =?us-ascii?Q?8Yp07wi1+R3tqa+VNmCMtnBfju0uAuHG4LtxpxUHfIUlLhH9ZpIIfd9eOmFL?=
 =?us-ascii?Q?eqw+MyyxS0P5mm1s/QJ01lsqZuk9qVZUQzTMxWXITRJw5IrXxxW8Q/o7482o?=
 =?us-ascii?Q?+nhaqdkPj/OmaCgC0jg6FPkN2V4oKBpA0F/C7H5ZNRyfPt0WjL/BnYjFXdEy?=
 =?us-ascii?Q?X10p2V5X14in9Mv/VroaImy70uPXrxkRu6o8bSkvkphCROxjDZ/4ktXqZiB/?=
 =?us-ascii?Q?QzWk3j2rMrZ5S4DXKB4TOmXxmli1xlfXQXZ0VlxobVFc6swgcBf3HFmDZNUw?=
 =?us-ascii?Q?AHE2Yb7GUNYlxJZ4SUjcGlWOpNTy2DkOUlDpsy+400ezOLppoelaOEqwH+6w?=
 =?us-ascii?Q?YBwPCyqyVGO5/AaFhIwV+tBazURWsORKv4HtRs4oACi0zocTQOqkd+GQzvYM?=
 =?us-ascii?Q?RnphLLlPZpsLd5TTAaJrHEI7W0vpALeAmccc95/MnhgvI8oUiC0ROKsPOaPe?=
 =?us-ascii?Q?6ui7Z6McKXC1FihOX811MSKAlTOCV0LavR9mWZLYXU2s815tRSTftm9L3GQ4?=
 =?us-ascii?Q?U/abFyljYZuKU5yCUaCLqWBIRrlr0dDIf1TLyAUB1L7OrfObAlUW+/oneZgF?=
 =?us-ascii?Q?vN7QWYqzuGVl5WjaNP74cQG5QnHzqu5sbMPtLlV+WQbFdOIfVUbyWVEVg+18?=
 =?us-ascii?Q?B384+1NikxJRWfOiWsSbaOQ+N8OMFK/lF6vX/myumb15Kigiie0PVl9ALm52?=
 =?us-ascii?Q?M6UToKYLKX5eK+vjvW/AM/4=3D?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c419e42b-4f95-4308-4b25-08dbd562d6f5
X-MS-Exchange-CrossTenant-AuthSource: VI0PR08MB10743.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Oct 2023 14:01:09.4390 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hh/b/Zo54BQneKhM3qyGLbGASb2x4lZaXDF9RlyzdPTphfo/rku7PmC+NCcFuPX7KUCccmoJhKZigZob0yJNE6VHmhjl/z3Yz/R6LMWrAw0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR08MB10363
Received-SPF: pass client-ip=2a01:111:f400:fe0e::70f;
 envelope-from=alexander.ivanov@virtuozzo.com;
 helo=EUR04-VI1-obe.outbound.protection.outlook.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FORGED_SPF_HELO=1,
 SPF_HELO_PASS=-0.001, T_SPF_TEMPERROR=0.01 autolearn=no autolearn_force=no
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

In qmp_guest_set_user_password() we have a part of code that we can reuse
in the future commits. Move this code to a separate function.

Signed-off-by: Alexander Ivanov <alexander.ivanov@virtuozzo.com>
---
 qga/commands-posix.c | 139 ++++++++++++++++++++++---------------------
 1 file changed, 72 insertions(+), 67 deletions(-)

diff --git a/qga/commands-posix.c b/qga/commands-posix.c
index 6169bbf7a0..e7b82aaf37 100644
--- a/qga/commands-posix.c
+++ b/qga/commands-posix.c
@@ -2114,20 +2114,78 @@ int64_t qmp_guest_set_vcpus(GuestLogicalProcessorList *vcpus, Error **errp)
 #endif /* __linux__ */
 
 #if defined(__linux__) || defined(__FreeBSD__)
-void qmp_guest_set_user_password(const char *username,
-                                 const char *password,
-                                 bool crypted,
-                                 Error **errp)
+
+static void run_command(const char *argv[], const char *in_str, Error **errp)
 {
     Error *local_err = NULL;
-    char *passwd_path = NULL;
     pid_t pid;
-    int status;
+    int in_len, status;
     int datafd[2] = { -1, -1 };
+
+    if (!g_unix_open_pipe(datafd, FD_CLOEXEC, NULL)) {
+        error_setg(errp, "cannot create pipe FDs");
+        goto out;
+    }
+
+    pid = fork();
+    if (pid == 0) {
+        close(datafd[1]);
+        setsid();
+        dup2(datafd[0], 0);
+        reopen_fd_to_null(1);
+        reopen_fd_to_null(2);
+
+        execve(argv[0], (char *const *)argv, environ);
+        _exit(EXIT_FAILURE);
+    } else if (pid < 0) {
+        error_setg_errno(errp, errno, "failed to create child process");
+        goto out;
+    }
+    close(datafd[0]);
+    datafd[0] = -1;
+
+    in_len = strlen(in_str);
+
+    if (qemu_write_full(datafd[1], in_str, in_len) != in_len) {
+        error_setg_errno(errp, errno, "cannot write new account password");
+        goto out;
+    }
+    close(datafd[1]);
+    datafd[1] = -1;
+
+    ga_wait_child(pid, &status, &local_err);
+    if (local_err) {
+        error_propagate(errp, local_err);
+        goto out;
+    }
+
+    if (!WIFEXITED(status)) {
+        error_setg(errp, "child process has terminated abnormally");
+        goto out;
+    }
+
+    if (WEXITSTATUS(status)) {
+        error_setg(errp, "child process has failed: %s", argv[0]);
+    }
+
+out:
+    if (datafd[0] != -1) {
+        close(datafd[0]);
+    }
+    if (datafd[1] != -1) {
+        close(datafd[1]);
+    }
+}
+
+void qmp_guest_set_user_password(const char *username,
+                                 const char *password,
+                                 bool crypted,
+                                 Error **errp)
+{
+    char *passwd_path = NULL;
     char *rawpasswddata = NULL;
-    size_t rawpasswdlen;
     char *chpasswddata = NULL;
-    size_t chpasswdlen;
+    size_t rawpasswdlen;
 
     rawpasswddata = (char *)qbase64_decode(password, -1, &rawpasswdlen, errp);
     if (!rawpasswddata) {
@@ -2155,79 +2213,26 @@ void qmp_guest_set_user_password(const char *username,
     passwd_path = g_find_program_in_path("chpasswd");
 #endif
 
-    chpasswdlen = strlen(chpasswddata);
-
     if (!passwd_path) {
         error_setg(errp, "cannot find 'passwd' program in PATH");
         goto out;
     }
 
-    if (!g_unix_open_pipe(datafd, FD_CLOEXEC, NULL)) {
-        error_setg(errp, "cannot create pipe FDs");
-        goto out;
-    }
-
-    pid = fork();
-    if (pid == 0) {
-        close(datafd[1]);
-        /* child */
-        setsid();
-        dup2(datafd[0], 0);
-        reopen_fd_to_null(1);
-        reopen_fd_to_null(2);
-
+    const char *argv[] = {
 #ifdef __FreeBSD__
-        const char *h_arg;
-        h_arg = (crypted) ? "-H" : "-h";
-        execl(passwd_path, "pw", "usermod", "-n", username, h_arg, "0", NULL);
+        passwd_path, "pw", "usermod", "-n", username,
+        (crypted) ? "-H" : "-h", "0", NULL};
 #else
-        if (crypted) {
-            execl(passwd_path, "chpasswd", "-e", NULL);
-        } else {
-            execl(passwd_path, "chpasswd", NULL);
-        }
+        passwd_path, "chpasswd", (crypted) ? "-e" : NULL, NULL
 #endif
-        _exit(EXIT_FAILURE);
-    } else if (pid < 0) {
-        error_setg_errno(errp, errno, "failed to create child process");
-        goto out;
-    }
-    close(datafd[0]);
-    datafd[0] = -1;
+    };
 
-    if (qemu_write_full(datafd[1], chpasswddata, chpasswdlen) != chpasswdlen) {
-        error_setg_errno(errp, errno, "cannot write new account password");
-        goto out;
-    }
-    close(datafd[1]);
-    datafd[1] = -1;
-
-    ga_wait_child(pid, &status, &local_err);
-    if (local_err) {
-        error_propagate(errp, local_err);
-        goto out;
-    }
-
-    if (!WIFEXITED(status)) {
-        error_setg(errp, "child process has terminated abnormally");
-        goto out;
-    }
-
-    if (WEXITSTATUS(status)) {
-        error_setg(errp, "child process has failed to set user password");
-        goto out;
-    }
+    run_command(argv, chpasswddata, errp);
 
 out:
     g_free(chpasswddata);
     g_free(rawpasswddata);
     g_free(passwd_path);
-    if (datafd[0] != -1) {
-        close(datafd[0]);
-    }
-    if (datafd[1] != -1) {
-        close(datafd[1]);
-    }
 }
 #else /* __linux__ || __FreeBSD__ */
 void qmp_guest_set_user_password(const char *username,
-- 
2.34.1



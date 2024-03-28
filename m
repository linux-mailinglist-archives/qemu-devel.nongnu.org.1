Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 23B7E881563
	for <lists+qemu-devel@lfdr.de>; Wed, 20 Mar 2024 17:17:49 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rmydJ-000838-0H; Wed, 20 Mar 2024 12:17:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1rmyce-0007Tj-MW
 for qemu-devel@nongnu.org; Wed, 20 Mar 2024 12:17:01 -0400
Received: from relay.virtuozzo.com ([130.117.225.111])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1rmyca-0003ss-Ga
 for qemu-devel@nongnu.org; Wed, 20 Mar 2024 12:17:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=virtuozzo.com; s=relay; h=Content-Type:MIME-Version:Message-Id:Date:Subject
 :From; bh=g1L3K5RZwrk4E61zfl//L6cqUbhJNBwq9TJTO8pP1iQ=; b=u6pomiDLuI3uk68P59H
 d3HLabb9lQAXofdRdioTItlKWSUcgB18QGkWdoEQaPA23D/uhuxon/PjlTyd0p0IR/xmRH5iFXElO
 aCvIl+DKG49V5aHLIFvw5ZbR1VP7FwHRIoaWcIpKufzbYDTVvt4IP+keM8U2qyiKMI+GseCy9Au5n
 O8VyL2mysaHnb+9sbOCo1GbbZiU9/7oLb0s13kbONb+CBqto29KnLflbAZefJUv0IhabF2guoERmJ
 cRzzl+jFCpS3vW+anXPl3UdfLNVi2lc2PxSfqA5BuU0JsmaL4WEVHOJCbY1aOJbTgobmzSTzGTyez
 Q4exuToPOETDz2A==;
Received: from [130.117.225.1] (helo=dev005.ch-qa.vzint.dev)
 by relay.virtuozzo.com with esmtp (Exim 4.96)
 (envelope-from <andrey.drobyshev@virtuozzo.com>) id 1rmyaM-006TNN-25;
 Wed, 20 Mar 2024 17:16:37 +0100
From: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
To: qemu-devel@nongnu.org
Cc: berrange@redhat.com, michael.roth@amd.com, kkostiuk@redhat.com,
 marcandre.lureau@redhat.com, philmd@linaro.org,
 andrey.drobyshev@virtuozzo.com, den@virtuozzo.com
Subject: [PATCH v4 4/7] qga/commands-posix: qmp_guest_set_time: use
 ga_run_command helper
Date: Wed, 20 Mar 2024 18:16:45 +0200
Message-Id: <20240320161648.158226-5-andrey.drobyshev@virtuozzo.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20240320161648.158226-1-andrey.drobyshev@virtuozzo.com>
References: <20240320161648.158226-1-andrey.drobyshev@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=130.117.225.111;
 envelope-from=andrey.drobyshev@virtuozzo.com; helo=relay.virtuozzo.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

There's no need to check for the existence of "/sbin/hwclock", the
exec() call will do that for us.

Signed-off-by: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
---
 qga/commands-posix.c | 43 +++----------------------------------------
 1 file changed, 3 insertions(+), 40 deletions(-)

diff --git a/qga/commands-posix.c b/qga/commands-posix.c
index cb9eed9a0b..545f3c99dc 100644
--- a/qga/commands-posix.c
+++ b/qga/commands-posix.c
@@ -279,21 +279,9 @@ void qmp_guest_shutdown(const char *mode, Error **errp)
 void qmp_guest_set_time(bool has_time, int64_t time_ns, Error **errp)
 {
     int ret;
-    int status;
-    pid_t pid;
     Error *local_err = NULL;
     struct timeval tv;
-    static const char hwclock_path[] = "/sbin/hwclock";
-    static int hwclock_available = -1;
-
-    if (hwclock_available < 0) {
-        hwclock_available = (access(hwclock_path, X_OK) == 0);
-    }
-
-    if (!hwclock_available) {
-        error_setg(errp, QERR_UNSUPPORTED);
-        return;
-    }
+    const char *argv[] = {"/sbin/hwclock", has_time ? "-w" : "-s", NULL};
 
     /* If user has passed a time, validate and set it. */
     if (has_time) {
@@ -324,37 +312,12 @@ void qmp_guest_set_time(bool has_time, int64_t time_ns, Error **errp)
      * just need to synchronize the hardware clock. However, if no time was
      * passed, user is requesting the opposite: set the system time from the
      * hardware clock (RTC). */
-    pid = fork();
-    if (pid == 0) {
-        setsid();
-        reopen_fd_to_null(0);
-        reopen_fd_to_null(1);
-        reopen_fd_to_null(2);
-
-        /* Use '/sbin/hwclock -w' to set RTC from the system time,
-         * or '/sbin/hwclock -s' to set the system time from RTC. */
-        execl(hwclock_path, "hwclock", has_time ? "-w" : "-s", NULL);
-        _exit(EXIT_FAILURE);
-    } else if (pid < 0) {
-        error_setg_errno(errp, errno, "failed to create child process");
-        return;
-    }
-
-    ga_wait_child(pid, &status, &local_err);
+    ga_run_command(argv, NULL, "set hardware clock to system time",
+                   &local_err);
     if (local_err) {
         error_propagate(errp, local_err);
         return;
     }
-
-    if (!WIFEXITED(status)) {
-        error_setg(errp, "child process has terminated abnormally");
-        return;
-    }
-
-    if (WEXITSTATUS(status)) {
-        error_setg(errp, "hwclock failed to set hardware clock to system time");
-        return;
-    }
 }
 
 typedef enum {
-- 
2.39.3



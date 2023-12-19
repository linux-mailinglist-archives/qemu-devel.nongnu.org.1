Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DEB28186D1
	for <lists+qemu-devel@lfdr.de>; Tue, 19 Dec 2023 13:00:36 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rFYkp-0007kF-77; Tue, 19 Dec 2023 06:59:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1rFYkn-0007k3-CL
 for qemu-devel@nongnu.org; Tue, 19 Dec 2023 06:59:17 -0500
Received: from mail-pg1-x52c.google.com ([2607:f8b0:4864:20::52c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1rFYkl-000414-Qb
 for qemu-devel@nongnu.org; Tue, 19 Dec 2023 06:59:17 -0500
Received: by mail-pg1-x52c.google.com with SMTP id
 41be03b00d2f7-5c21e185df5so3430061a12.1
 for <qemu-devel@nongnu.org>; Tue, 19 Dec 2023 03:59:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1702987154; x=1703591954;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=wnvoaJ05iUVI4cxPBT0lgJ+VNNp+z7LyrvWY81Ab8HQ=;
 b=vq4dr7OiGWJBvAiut6/AaF20YnAYsWU/BE9u2vw4ZyRVG2seKb/uTX96YCLLONpv1D
 bbe2ViXdWrkA8zRGzKywaHV6czTywu4IM5W/7Mb9t13MV/ZXr8IZM4AjOKeqPHaP8k1A
 TNGqdfMbhVu7GPnFFG4Iwntrv86djXt3c5RMNrTgj0IuzCggbmK0S4ran5aUpuf3Z2C4
 UmvD5nvGb9GLtMj04XVO7RzeBlsfECeYerU3O56qrBeCO7/hXw/XvNkZ8nK3ETsSm7Dr
 mw/bOPqiMvyPqGZkscZBvkkfAlVcIfs1esg7XVDuWunJQDyKh16SMq45tSsmcmCVXJC9
 an/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702987154; x=1703591954;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=wnvoaJ05iUVI4cxPBT0lgJ+VNNp+z7LyrvWY81Ab8HQ=;
 b=GpbWKHnlwMfvn9GYeXcG8JAJHzV+R5TX5hy9CV2QIiFZ+0Y+GxbiHBQaXLz07d/B8A
 RbhKvjfrqvZJmDUE4qvnLOJ9cxv6aIcQyl+c0JYGpiW2D3A67XBYA/F/eKCUnnmD2Bm1
 4Fc1AhoklB2TdlXeUJrqVOpFiXY9O5d6QaB1GvNUc8wMDzXx8z3s5Yxyjivd3VcXLRQv
 veMmUybL+glUaTDtJeCtexL0Ack+ETSrv8RZd6WGih/OiTzS9yVhoQBGf+3yJuB8vNTU
 1xgDeEdavvqvKG+oGQfaHZeSoiz1LQ+VRcDnL+3NCu5SmGJ6pEFg9EsKAPmWyHW4EAKB
 Y0Og==
X-Gm-Message-State: AOJu0YxLrVihFJ1mIywI7E9wnVKSGnJZigjb+jwg7WhxxAMW3bLRhawA
 eskXb1tGrD4Xg5OY7Q4ouDg1VA1PdGQUT+t0M/tJqg==
X-Google-Smtp-Source: AGHT+IGggdKzxpbiWnsV82alJP9/yEtY6fTSq1sGA8Wxxvga3sx4xLKDeHBCbknrNsxSvUf1O1jsVQ==
X-Received: by 2002:a05:6a20:158b:b0:190:3295:e1a2 with SMTP id
 h11-20020a056a20158b00b001903295e1a2mr24691439pzj.90.1702987154324; 
 Tue, 19 Dec 2023 03:59:14 -0800 (PST)
Received: from localhost ([157.82.205.15]) by smtp.gmail.com with UTF8SMTPSA id
 gw24-20020a17090b0a5800b00286ed94466dsm1346791pjb.32.2023.12.19.03.59.13
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 19 Dec 2023 03:59:14 -0800 (PST)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Tue, 19 Dec 2023 20:58:58 +0900
Subject: [PATCH 2/2] tap: Use g_spawn_sync() and
 g_spawn_check_wait_status()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231219-glib-v1-2-1b040d286b91@daynix.com>
References: <20231219-glib-v1-0-1b040d286b91@daynix.com>
In-Reply-To: <20231219-glib-v1-0-1b040d286b91@daynix.com>
To: Jason Wang <jasowang@redhat.com>
Cc: qemu-devel@nongnu.org, Akihiko Odaki <akihiko.odaki@daynix.com>
X-Mailer: b4 0.12.4
Received-SPF: none client-ip=2607:f8b0:4864:20::52c;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pg1-x52c.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

g_spawn_sync() gives an informative message if it fails to execute
the script instead of reporting exiting status 1.

g_spawn_check_wait_status() also gives an message easier to understand
than the raw value returned by waitpid().

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
---
 net/tap.c | 52 ++++++++++++++++++++++------------------------------
 1 file changed, 22 insertions(+), 30 deletions(-)

diff --git a/net/tap.c b/net/tap.c
index c23d0323c2ae..74f718613009 100644
--- a/net/tap.c
+++ b/net/tap.c
@@ -444,44 +444,36 @@ static TAPState *net_tap_fd_init(NetClientState *peer,
     return s;
 }
 
+static void close_fds_except(gpointer data)
+{
+    int open_max = sysconf(_SC_OPEN_MAX), i;
+
+    for (i = 3; i < open_max; i++) {
+        if (i != (intptr_t)data) {
+            close(i);
+        }
+    }
+}
+
 static void launch_script(const char *setup_script, const char *ifname,
                           int fd, Error **errp)
 {
-    int pid, status;
-    char *args[3];
-    char **parg;
+    gint status;
+    gchar *argv[] = { (gchar *)setup_script, (gchar *)ifname, NULL };
+    g_autoptr(GError) error = NULL;
 
     /* try to launch network script */
-    pid = fork();
-    if (pid < 0) {
-        error_setg_errno(errp, errno, "could not launch network script %s",
-                         setup_script);
+    if (!g_spawn_sync(NULL, argv, NULL, G_SPAWN_LEAVE_DESCRIPTORS_OPEN,
+                      close_fds_except, (gpointer)(intptr_t)fd, NULL, NULL,
+                      &status, &error)) {
+        error_setg(errp, "could not launch network script %s: %s",
+                   setup_script, error->message);
         return;
     }
-    if (pid == 0) {
-        int open_max = sysconf(_SC_OPEN_MAX), i;
 
-        for (i = 3; i < open_max; i++) {
-            if (i != fd) {
-                close(i);
-            }
-        }
-        parg = args;
-        *parg++ = (char *)setup_script;
-        *parg++ = (char *)ifname;
-        *parg = NULL;
-        execv(setup_script, args);
-        _exit(1);
-    } else {
-        while (waitpid(pid, &status, 0) != pid) {
-            /* loop */
-        }
-
-        if (WIFEXITED(status) && WEXITSTATUS(status) == 0) {
-            return;
-        }
-        error_setg(errp, "network script %s failed with status %d",
-                   setup_script, status);
+    if (!g_spawn_check_wait_status(status, &error)) {
+        error_setg(errp, "network script %s failed: %s",
+                   setup_script, error->message);
     }
 }
 

-- 
2.43.0



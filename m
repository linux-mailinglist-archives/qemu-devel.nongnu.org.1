Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id F385D7A9259
	for <lists+qemu-devel@lfdr.de>; Thu, 21 Sep 2023 09:56:42 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qjEWU-0004Vz-9L; Thu, 21 Sep 2023 03:54:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1qjEWR-0004Vg-Ky
 for qemu-devel@nongnu.org; Thu, 21 Sep 2023 03:54:51 -0400
Received: from mail-pl1-x630.google.com ([2607:f8b0:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1qjEWQ-0001Ni-1K
 for qemu-devel@nongnu.org; Thu, 21 Sep 2023 03:54:51 -0400
Received: by mail-pl1-x630.google.com with SMTP id
 d9443c01a7336-1c39f2b4f5aso5045935ad.0
 for <qemu-devel@nongnu.org>; Thu, 21 Sep 2023 00:54:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1695282888; x=1695887688;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6ELYyiOadw0MQ3+N22lCN+444YhBa1c0nKVoGiIJnpU=;
 b=tJy3f2f+HwgSv3pYpZh/716lNAcGevCYI1kj7IcVIVnmPNFBwlSYBgF4eOpwR6EhDM
 6zgX/d89IFrkAf1mLQbVehbfJ7bBOa1IHAmx4intNnSukEz2sLkPiB4YlwFxmK04ryik
 20kisWmWXbr17EfpSwupjcFr73s418vr8BlZ0Hh2z0YqRMHqfZB3ON8Tfpay6SXtEeaZ
 uT9C1bDhI4Ve3mvi2hR5v6hvWrkc3feghSe8/EGQEJz5U3VbbwcO4F4hoUWtYRtHPyBg
 RVxe7B7F+3FE5iThgD6AHMamKJ9YyylnA8Wr1sXLwFtNKZRMA/CLGw1qUcNnurxacedj
 V1Lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695282888; x=1695887688;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=6ELYyiOadw0MQ3+N22lCN+444YhBa1c0nKVoGiIJnpU=;
 b=B0mLi4jN7UrxgvsvMmpt/H1X89NB6aZ+MTqIXAP38ez8KLD0Mrf6P8iITMtDNnsVSq
 KkcdSkLKVxVzDvSZkfTH6uWqrsLI73X3ZF3KZdvyE+0M869g+hKV8FoS6+weFtwcjfzu
 nim/C9mdegZrti8ON/V/5hoshD9OL2wk6XOlf+CfXGLGsuLqo3Ho2vzlqpJMoM27qoqE
 wn+MG34jjWK0EoensHFxv4tVI+NkXxVHBUjnCPS6Qk+OHTbm8bQaclLip8ZSBsGSkpkR
 LTfRD0M9/zMn6G4tZ44hW9+1sIKcjBtGiBhHwEcxgkdstmMFwXc085DjH3BXJ61MuM2o
 5ifA==
X-Gm-Message-State: AOJu0YzVqjdjZRlhcUjl0Xm6liMyo4T8K6wUMlAI/Tm3TPOCmTa7BT/C
 WA5gr23oYEvXwztcSp5I5PW8J6Z2vUw/UNWlXpY=
X-Google-Smtp-Source: AGHT+IGUTIlFvWmMSLFsSDmuu01IkvmY+u8LNnGxK5z2/qiip8tHgDkKnj5nChA9qxXbsLo34s6GxQ==
X-Received: by 2002:a17:902:c40a:b0:1c5:ad14:9095 with SMTP id
 k10-20020a170902c40a00b001c5ad149095mr5394853plk.64.1695282888558; 
 Thu, 21 Sep 2023 00:54:48 -0700 (PDT)
Received: from fedora.flets-east.jp ([2400:4050:a840:1e00:d54:e521:8bac:7bed])
 by smtp.gmail.com with ESMTPSA id
 p22-20020a170902a41600b001ae0152d280sm761928plq.193.2023.09.21.00.54.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 21 Sep 2023 00:54:48 -0700 (PDT)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
To: 
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, virtio-fs@redhat.com,
 Yuval Shaia <yuval.shaia.ml@gmail.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Konstantin Kostiuk <kkostiuk@redhat.com>,
 Michael Roth <michael.roth@amd.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Fam Zheng <fam@euphon.net>,
 "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Stefan Weil <sw@weilnetz.de>, Yan Vugenfirer <yan@daynix.com>,
 Akihiko Odaki <akihiko.odaki@daynix.com>
Subject: [PATCH v3 2/8] ivshmem-server: Use qemu_get_runtime_dir()
Date: Thu, 21 Sep 2023 16:54:16 +0900
Message-ID: <20230921075425.16738-3-akihiko.odaki@daynix.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230921075425.16738-1-akihiko.odaki@daynix.com>
References: <20230921075425.16738-1-akihiko.odaki@daynix.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::630;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pl1-x630.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=unavailable autolearn_force=no
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

qemu_get_runtime_dir() is used to construct the default PID file path.

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
---
 contrib/ivshmem-server/main.c | 20 ++++++++++++++++----
 1 file changed, 16 insertions(+), 4 deletions(-)

diff --git a/contrib/ivshmem-server/main.c b/contrib/ivshmem-server/main.c
index 5901f17707..313124dd45 100644
--- a/contrib/ivshmem-server/main.c
+++ b/contrib/ivshmem-server/main.c
@@ -14,7 +14,6 @@
 
 #define IVSHMEM_SERVER_DEFAULT_VERBOSE        0
 #define IVSHMEM_SERVER_DEFAULT_FOREGROUND     0
-#define IVSHMEM_SERVER_DEFAULT_PID_FILE       "/var/run/ivshmem-server.pid"
 #define IVSHMEM_SERVER_DEFAULT_UNIX_SOCK_PATH "/tmp/ivshmem_socket"
 #define IVSHMEM_SERVER_DEFAULT_SHM_PATH       "ivshmem"
 #define IVSHMEM_SERVER_DEFAULT_SHM_SIZE       (4 * 1024 * 1024)
@@ -35,15 +34,23 @@ typedef struct IvshmemServerArgs {
     unsigned n_vectors;
 } IvshmemServerArgs;
 
+static char *ivshmem_server_get_default_pid_file(void)
+{
+    g_autofree char *run = qemu_get_runtime_dir();
+    return g_build_filename(run, "ivshmem-server.pid", NULL);
+}
+
 static void
 ivshmem_server_usage(const char *progname)
 {
+    g_autofree char *pid_file = ivshmem_server_get_default_pid_file();
+
     printf("Usage: %s [OPTION]...\n"
            "  -h: show this help\n"
            "  -v: verbose mode\n"
            "  -F: foreground mode (default is to daemonize)\n"
            "  -p <pid-file>: path to the PID file (used in daemon mode only)\n"
-           "     default " IVSHMEM_SERVER_DEFAULT_PID_FILE "\n"
+           "     default %s\n"
            "  -S <unix-socket-path>: path to the unix socket to listen to\n"
            "     default " IVSHMEM_SERVER_DEFAULT_UNIX_SOCK_PATH "\n"
            "  -M <shm-name>: POSIX shared memory object to use\n"
@@ -54,7 +61,7 @@ ivshmem_server_usage(const char *progname)
            "     default %u\n"
            "  -n <nvectors>: number of vectors\n"
            "     default %u\n",
-           progname, IVSHMEM_SERVER_DEFAULT_SHM_SIZE,
+           progname, pid_file, IVSHMEM_SERVER_DEFAULT_SHM_SIZE,
            IVSHMEM_SERVER_DEFAULT_N_VECTORS);
 }
 
@@ -189,10 +196,10 @@ main(int argc, char *argv[])
 {
     IvshmemServer server;
     struct sigaction sa, sa_quit;
+    g_autofree char *default_pid_file = NULL;
     IvshmemServerArgs args = {
         .verbose = IVSHMEM_SERVER_DEFAULT_VERBOSE,
         .foreground = IVSHMEM_SERVER_DEFAULT_FOREGROUND,
-        .pid_file = IVSHMEM_SERVER_DEFAULT_PID_FILE,
         .unix_socket_path = IVSHMEM_SERVER_DEFAULT_UNIX_SOCK_PATH,
         .shm_path = IVSHMEM_SERVER_DEFAULT_SHM_PATH,
         .use_shm_open = true,
@@ -207,6 +214,11 @@ main(int argc, char *argv[])
      */
     printf("*** Example code, do not use in production ***\n");
 
+    qemu_init_exec_dir(argv[0]);
+
+    default_pid_file = ivshmem_server_get_default_pid_file();
+    args.pid_file = default_pid_file;
+
     /* parse arguments, will exit on error */
     ivshmem_server_parse_args(&args, argc, argv);
 
-- 
2.41.0



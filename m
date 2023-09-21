Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DD77C7A925A
	for <lists+qemu-devel@lfdr.de>; Thu, 21 Sep 2023 09:57:04 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qjEWZ-0004XF-QX; Thu, 21 Sep 2023 03:54:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1qjEWY-0004Ws-7B
 for qemu-devel@nongnu.org; Thu, 21 Sep 2023 03:54:58 -0400
Received: from mail-pl1-x62b.google.com ([2607:f8b0:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1qjEWW-0001Pb-NF
 for qemu-devel@nongnu.org; Thu, 21 Sep 2023 03:54:57 -0400
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-1c4194f769fso5025735ad.3
 for <qemu-devel@nongnu.org>; Thu, 21 Sep 2023 00:54:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1695282895; x=1695887695;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jlU7vc1UjVKlw3Dv2jSmgf2SIHJeXqpTwAZU3tpQIrQ=;
 b=cZm/hPQgdO1OIaOcaXzj9wX8oxv6WfIo1vhIIzcbU7oveF8c1VPCO5C50TjHwBf5cP
 p9Nb9/r3F7sOBDlPGvkHnUDBKvbGlm+g8wosAHzd4Z92m6V14gJlf1aR/5ADAqP1tHdI
 aISpF3n0o0B04VK0KjsagGc3W6Sg5/RbivNrF+PYzeinw8aAz40OkG+2ajCPKSBLER25
 3iefgGI8M8taREMddwUmPi9aTlWblDOqTOcPcTALRCsHIkV2Toindbr7DX72S7UXJT3p
 Fv8iH9gwhDhg9/cNnazGGML9iRvS2ariq/Rgc90CynsZx/eVZMeifWT4lzVw1ZzHN5p6
 sySA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695282895; x=1695887695;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=jlU7vc1UjVKlw3Dv2jSmgf2SIHJeXqpTwAZU3tpQIrQ=;
 b=WgvKI01fEo0VpDfbERyewpzzaNTdHPsQfaNjhBlnhIEwhVhBs3YdOZyF44IPQzMZqi
 /ZMZw5bQ8Eyzs84eWFP+rhUe6ZfZSvzIK8MMwa3/M+x6pMaIZu8LHGDbwmvPu/lhWUjJ
 LsYLcU32YGCDEBy46v1Z39AWaj71ME0JrvY4Gxb52G/1DUIQsZbCSWE1soifOsXOPVSk
 Y+CohUrqphlxQDdaZC+eeQ/sX1uZXdZSKoDjeuwt0QrnHuIn75H9Q4Sem3Hbme1JfyJn
 fJ8sgHhHz3JIUTOeFgrWeA7I+lXsBY9ujFHtO3gaJdpATS5IqMouggOEP3j4lIGPwuNN
 4wRA==
X-Gm-Message-State: AOJu0Yz1YIUqKuuaqmmewoY3mC/S57NaYbIuFGljekxhcM+lSHVNgrgU
 Dsgyhk1FgZ+cD4/gXTK9C6O3FFSPyRglx9EQWOs=
X-Google-Smtp-Source: AGHT+IG2h8BG2Z51cqBiO+32XQNTcrt8y2Ij0FCZ1sFQfZyO86MeyubAKt+3Hm5xn+8l6fwhjdyg1w==
X-Received: by 2002:a17:902:b901:b0:1bf:c59:c944 with SMTP id
 bf1-20020a170902b90100b001bf0c59c944mr4039169plb.22.1695282895097; 
 Thu, 21 Sep 2023 00:54:55 -0700 (PDT)
Received: from fedora.flets-east.jp ([2400:4050:a840:1e00:d54:e521:8bac:7bed])
 by smtp.gmail.com with ESMTPSA id
 p22-20020a170902a41600b001ae0152d280sm761928plq.193.2023.09.21.00.54.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 21 Sep 2023 00:54:54 -0700 (PDT)
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
Subject: [PATCH v3 3/8] contrib/rdmacm-mux: Use qemu_get_runtime_dir()
Date: Thu, 21 Sep 2023 16:54:17 +0900
Message-ID: <20230921075425.16738-4-akihiko.odaki@daynix.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230921075425.16738-1-akihiko.odaki@daynix.com>
References: <20230921075425.16738-1-akihiko.odaki@daynix.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::62b;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pl1-x62b.google.com
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

qemu_get_runtime_dir() is used to construct the default Unix socket
path.

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
---
 contrib/rdmacm-mux/main.c      | 22 ++++++++++++++--------
 contrib/rdmacm-mux/meson.build |  2 +-
 2 files changed, 15 insertions(+), 9 deletions(-)

diff --git a/contrib/rdmacm-mux/main.c b/contrib/rdmacm-mux/main.c
index 771ca01e03..00c14031ca 100644
--- a/contrib/rdmacm-mux/main.c
+++ b/contrib/rdmacm-mux/main.c
@@ -14,6 +14,7 @@
  */
 
 #include "qemu/osdep.h"
+#include "qemu/cutils.h"
 #include <sys/poll.h>
 #include <sys/ioctl.h>
 #include <pthread.h>
@@ -40,8 +41,6 @@
 #define CM_REQ_DGID_POS      80
 #define CM_SIDR_REQ_DGID_POS 44
 
-/* The below can be override by command line parameter */
-#define UNIX_SOCKET_PATH "/var/run/rdmacm-mux"
 /* Has format %s-%s-%d" <path>-<rdma-dev--name>-<port> */
 #define SOCKET_PATH_MAX (PATH_MAX - NAME_MAX - sizeof(int) - 2)
 #define RDMA_PORT_NUM 1
@@ -77,7 +76,13 @@ typedef struct RdmaCmServer {
 
 static RdmaCMServer server = {0};
 
-static void usage(const char *progname)
+static char *get_default_unix_socket_path(void)
+{
+    g_autofree char *run = qemu_get_runtime_dir();
+    return g_build_filename(run, "rdmacm-mux", NULL);
+}
+
+static void usage(const char *progname, const char *default_unix_socket_path)
 {
     printf("Usage: %s [OPTION]...\n"
            "Start a RDMA-CM multiplexer\n"
@@ -86,7 +91,7 @@ static void usage(const char *progname)
            "\t-d rdma-device-name   Name of RDMA device to register with\n"
            "\t-s unix-socket-path   Path to unix socket to listen on (default %s)\n"
            "\t-p rdma-device-port   Port number of RDMA device to register with (default %d)\n",
-           progname, UNIX_SOCKET_PATH, RDMA_PORT_NUM);
+           progname, default_unix_socket_path, RDMA_PORT_NUM);
 }
 
 static void help(const char *progname)
@@ -97,16 +102,16 @@ static void help(const char *progname)
 static void parse_args(int argc, char *argv[])
 {
     int c;
-    char unix_socket_path[SOCKET_PATH_MAX];
+    g_autofree char *default_unix_socket_path = get_default_unix_socket_path();
+    char *unix_socket_path = default_unix_socket_path;
 
     strcpy(server.args.rdma_dev_name, "");
-    strcpy(unix_socket_path, UNIX_SOCKET_PATH);
     server.args.rdma_port_num = RDMA_PORT_NUM;
 
     while ((c = getopt(argc, argv, "hs:d:p:")) != -1) {
         switch (c) {
         case 'h':
-            usage(argv[0]);
+            usage(argv[0], default_unix_socket_path);
             exit(0);
 
         case 'd':
@@ -115,7 +120,7 @@ static void parse_args(int argc, char *argv[])
 
         case 's':
             /* This is temporary, final name will build below */
-            strncpy(unix_socket_path, optarg, SOCKET_PATH_MAX - 1);
+            unix_socket_path = optarg;
             break;
 
         case 'p':
@@ -811,6 +816,7 @@ int main(int argc, char *argv[])
 {
     int rc;
 
+    qemu_init_exec_dir(argv[0]);
     memset(&server, 0, sizeof(server));
 
     parse_args(argc, argv);
diff --git a/contrib/rdmacm-mux/meson.build b/contrib/rdmacm-mux/meson.build
index 36c9c89630..59f60f9cac 100644
--- a/contrib/rdmacm-mux/meson.build
+++ b/contrib/rdmacm-mux/meson.build
@@ -1,7 +1,7 @@
 if have_pvrdma
   # FIXME: broken on big endian architectures
   executable('rdmacm-mux', files('main.c'), genh,
-             dependencies: [glib, libumad],
+             dependencies: [glib, libumad, qemuutil],
              build_by_default: false,
              install: false)
 endif
-- 
2.41.0



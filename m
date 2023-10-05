Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F0707B9AD3
	for <lists+qemu-devel@lfdr.de>; Thu,  5 Oct 2023 07:03:06 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qoGMN-0000IK-H9; Thu, 05 Oct 2023 00:53:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qoGLk-0007kV-9E
 for qemu-devel@nongnu.org; Thu, 05 Oct 2023 00:52:36 -0400
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qoGLg-0007E7-VD
 for qemu-devel@nongnu.org; Thu, 05 Oct 2023 00:52:36 -0400
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-32336a30d18so508421f8f.2
 for <qemu-devel@nongnu.org>; Wed, 04 Oct 2023 21:52:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1696481551; x=1697086351; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YZajAk/2I9ikw2/rt53JYOwTH2I6pFeiAjPgvz+uD7Y=;
 b=lXZBEOIzlC6ur7js7yHjgPMSbO91uFv2tSjI7NMxq2+oeBx6J9egwY59DgNrCz/ofb
 oG+kUDMwDGnMjlfrLNTS7DxoacX6ouhDmyGOkw/O6K63Ugj8PDE9Xmgp9miDU+dSfJVF
 8BIZffeAWZ9UAg9cvXN2tf6/NrGnnxVLqtkGens6e8fzmN6/grO5WeUV5tS/zviyiiuL
 fyaU4uDkKTVE5mPVU5JUwqFoWsf8Im9NGXG26saAtkTT4VYCWzXLxhlNUb+XT+GmMcxG
 uaNNZQ1MX0UiLKv7Fb4Meh46YtSrOGXKh5kyAIpozSgq0qAgFKuQ28/JM7x3n+0vAKqO
 TA6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696481551; x=1697086351;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=YZajAk/2I9ikw2/rt53JYOwTH2I6pFeiAjPgvz+uD7Y=;
 b=FtlY72vfr7giahgyXVe4N2hg0xNzlK8XrxxF13Jiqj/vENim9uDmQxsMNB5TOdzjoP
 nP3y3NHwPtBSxrJCuMuPY6EEi8/+JoAbvAPp+mqY7z8OFDa0pX/Hh9Vfu7fy/HlRBqwt
 ZenXO0v5hZPY97AkN5ktrIOJFFc3gGZFbAwvn5CvT7PwrsBaMWvsHlCcGDAfDVuuViyl
 A8bMd2Mds95Np29w8le8Ot9LKstNmdmanZ8EriuIkGUJw+vF6QsZZi1EQIsSZ2bo0AXm
 p4VpA1X9hqvhFdB39TYLhHMZoNl2wbhvAB9LyehWUVf0Gp8rlAn/M+hFNZPXXhKrUSnl
 MmEA==
X-Gm-Message-State: AOJu0Ywoqmt0d39gFu5WMucMLW2tpAd8dD0gZPUXdkhHgDDuEuEayl9m
 mAnSA12Or/A7o6YGEq4hSZWFkxlUvmy2/i/YiG8=
X-Google-Smtp-Source: AGHT+IHpfWA9S/SWJiGbjTp2uWuwuzgpqtv+VwuPXuVeLNM6ZraGtkaN7GYLenolTU/p34MrH7i2pg==
X-Received: by 2002:adf:e406:0:b0:31a:e6c2:7705 with SMTP id
 g6-20020adfe406000000b0031ae6c27705mr3486721wrm.50.1696481551363; 
 Wed, 04 Oct 2023 21:52:31 -0700 (PDT)
Received: from m1x-phil.lan (tbo33-h01-176-171-211-120.dsl.sta.abo.bbox.fr.
 [176.171.211.120]) by smtp.gmail.com with ESMTPSA id
 x4-20020a5d54c4000000b00327bf4f2f16sm748742wrv.30.2023.10.04.21.52.28
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 04 Oct 2023 21:52:31 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org,
	Markus Armbruster <armbru@redhat.com>
Cc: qemu-arm@nongnu.org, qemu-ppc@nongnu.org, qemu-block@nongnu.org,
 qemu-s390x@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Stefan Berger <stefanb@linux.ibm.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Stefan Berger <stefanb@linux.vnet.ibm.com>, integration@gluster.org
Subject: [PATCH v2 16/22] qapi: Inline QERR_MISSING_PARAMETER definition
 (constant parameter)
Date: Thu,  5 Oct 2023 06:50:33 +0200
Message-ID: <20231005045041.52649-17-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231005045041.52649-1-philmd@linaro.org>
References: <20231005045041.52649-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::436;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x436.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

Address the comment added in commit 4629ed1e98
("qerror: Finally unused, clean up"), from 2015:

  /*
   * These macros will go away, please don't use
   * in new code, and do not add new ones!
   */

Mechanical transformation using the following
coccinelle semantic patches:

    @match@
    expression errp;
    constant param;
    @@
         error_setg(errp, QERR_MISSING_PARAMETER, param);

    @script:python strformat depends on match@
    param << match.param;
    fixedfmt; // new var
    @@
    if param[0] == '"': # Format skipping '"',
        fixedfmt = f'"Parameter \'{param[1:-1]}\' is missing"'
    else: # or use definition.
        fixedfmt = f'"Parameter " {param} " is missing"'
    coccinelle.fixedfmt = cocci.make_ident(fixedfmt)

    @replace@
    expression match.errp;
    constant match.param;
    identifier strformat.fixedfmt;
    @@
    -    error_setg(errp, QERR_MISSING_PARAMETER, param);
    +    error_setg(errp, fixedfmt);

and:

    @match@
    constant param;
    @@
         error_report(QERR_MISSING_PARAMETER, param);

    @script:python strformat depends on match@
    param << match.param;
    fixedfmt; // new var
    @@
    fixedfmt = f'"Parameter \'{param[1:-1]}\' is missing"'
    coccinelle.fixedfmt = cocci.make_ident(fixedfmt)

    @replace@
    constant match.param;
    identifier strformat.fixedfmt;
    @@
    -    error_report(QERR_MISSING_PARAMETER, param);
    +    error_report(fixedfmt);

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Stefan Berger <stefanb@linux.ibm.com>
---
 backends/dbus-vmstate.c        |  2 +-
 block/gluster.c                | 21 +++++++++++----------
 block/monitor/block-hmp-cmds.c |  6 +++---
 dump/dump.c                    |  4 ++--
 hw/usb/redirect.c              |  2 +-
 softmmu/qdev-monitor.c         |  2 +-
 softmmu/tpm.c                  |  4 ++--
 softmmu/vl.c                   |  4 ++--
 ui/input-barrier.c             |  2 +-
 ui/ui-qmp-cmds.c               |  2 +-
 10 files changed, 25 insertions(+), 24 deletions(-)

diff --git a/backends/dbus-vmstate.c b/backends/dbus-vmstate.c
index 57369ec0f2..e781ded17c 100644
--- a/backends/dbus-vmstate.c
+++ b/backends/dbus-vmstate.c
@@ -413,7 +413,7 @@ dbus_vmstate_complete(UserCreatable *uc, Error **errp)
     }
 
     if (!self->dbus_addr) {
-        error_setg(errp, QERR_MISSING_PARAMETER, "addr");
+        error_setg(errp, "Parameter 'addr' is missing");
         return;
     }
 
diff --git a/block/gluster.c b/block/gluster.c
index ad5fadbe79..8d97d698c3 100644
--- a/block/gluster.c
+++ b/block/gluster.c
@@ -530,20 +530,20 @@ static int qemu_gluster_parse_json(BlockdevOptionsGluster *gconf,
 
     num_servers = qdict_array_entries(options, GLUSTER_OPT_SERVER_PATTERN);
     if (num_servers < 1) {
-        error_setg(&local_err, QERR_MISSING_PARAMETER, "server");
+        error_setg(&local_err, "Parameter 'server' is missing");
         goto out;
     }
 
     ptr = qemu_opt_get(opts, GLUSTER_OPT_VOLUME);
     if (!ptr) {
-        error_setg(&local_err, QERR_MISSING_PARAMETER, GLUSTER_OPT_VOLUME);
+        error_setg(&local_err, "Parameter " GLUSTER_OPT_VOLUME " is missing");
         goto out;
     }
     gconf->volume = g_strdup(ptr);
 
     ptr = qemu_opt_get(opts, GLUSTER_OPT_PATH);
     if (!ptr) {
-        error_setg(&local_err, QERR_MISSING_PARAMETER, GLUSTER_OPT_PATH);
+        error_setg(&local_err, "Parameter " GLUSTER_OPT_PATH " is missing");
         goto out;
     }
     gconf->path = g_strdup(ptr);
@@ -562,7 +562,8 @@ static int qemu_gluster_parse_json(BlockdevOptionsGluster *gconf,
 
         ptr = qemu_opt_get(opts, GLUSTER_OPT_TYPE);
         if (!ptr) {
-            error_setg(&local_err, QERR_MISSING_PARAMETER, GLUSTER_OPT_TYPE);
+            error_setg(&local_err,
+                       "Parameter " GLUSTER_OPT_TYPE " is missing");
             error_append_hint(&local_err, GERR_INDEX_HINT, i);
             goto out;
 
@@ -592,16 +593,16 @@ static int qemu_gluster_parse_json(BlockdevOptionsGluster *gconf,
 
             ptr = qemu_opt_get(opts, GLUSTER_OPT_HOST);
             if (!ptr) {
-                error_setg(&local_err, QERR_MISSING_PARAMETER,
-                           GLUSTER_OPT_HOST);
+                error_setg(&local_err,
+                           "Parameter " GLUSTER_OPT_HOST " is missing");
                 error_append_hint(&local_err, GERR_INDEX_HINT, i);
                 goto out;
             }
             gsconf->u.inet.host = g_strdup(ptr);
             ptr = qemu_opt_get(opts, GLUSTER_OPT_PORT);
             if (!ptr) {
-                error_setg(&local_err, QERR_MISSING_PARAMETER,
-                           GLUSTER_OPT_PORT);
+                error_setg(&local_err,
+                           "Parameter " GLUSTER_OPT_PORT " is missing");
                 error_append_hint(&local_err, GERR_INDEX_HINT, i);
                 goto out;
             }
@@ -648,8 +649,8 @@ static int qemu_gluster_parse_json(BlockdevOptionsGluster *gconf,
                 goto out;
             }
             if (!ptr) {
-                error_setg(&local_err, QERR_MISSING_PARAMETER,
-                           GLUSTER_OPT_PATH);
+                error_setg(&local_err,
+                           "Parameter " GLUSTER_OPT_PATH " is missing");
                 error_append_hint(&local_err, GERR_INDEX_HINT, i);
                 goto out;
             }
diff --git a/block/monitor/block-hmp-cmds.c b/block/monitor/block-hmp-cmds.c
index ca2599de44..90e593ed38 100644
--- a/block/monitor/block-hmp-cmds.c
+++ b/block/monitor/block-hmp-cmds.c
@@ -252,7 +252,7 @@ void hmp_drive_mirror(Monitor *mon, const QDict *qdict)
     };
 
     if (!filename) {
-        error_setg(&err, QERR_MISSING_PARAMETER, "target");
+        error_setg(&err, "Parameter 'target' is missing");
         goto end;
     }
     qmp_drive_mirror(&mirror, &err);
@@ -281,7 +281,7 @@ void hmp_drive_backup(Monitor *mon, const QDict *qdict)
     };
 
     if (!filename) {
-        error_setg(&err, QERR_MISSING_PARAMETER, "target");
+        error_setg(&err, "Parameter 'target' is missing");
         goto end;
     }
 
@@ -356,7 +356,7 @@ void hmp_snapshot_blkdev(Monitor *mon, const QDict *qdict)
          * In the future, if 'snapshot-file' is not specified, the snapshot
          * will be taken internally. Today it's actually required.
          */
-        error_setg(&err, QERR_MISSING_PARAMETER, "snapshot-file");
+        error_setg(&err, "Parameter 'snapshot-file' is missing");
         goto end;
     }
 
diff --git a/dump/dump.c b/dump/dump.c
index e173f1f14c..642b952985 100644
--- a/dump/dump.c
+++ b/dump/dump.c
@@ -2096,11 +2096,11 @@ void qmp_dump_guest_memory(bool paging, const char *file,
         return;
     }
     if (has_begin && !has_length) {
-        error_setg(errp, QERR_MISSING_PARAMETER, "length");
+        error_setg(errp, "Parameter 'length' is missing");
         return;
     }
     if (!has_begin && has_length) {
-        error_setg(errp, QERR_MISSING_PARAMETER, "begin");
+        error_setg(errp, "Parameter 'begin' is missing");
         return;
     }
     if (has_detach) {
diff --git a/hw/usb/redirect.c b/hw/usb/redirect.c
index ac6fa34ad1..83bfc9dc19 100644
--- a/hw/usb/redirect.c
+++ b/hw/usb/redirect.c
@@ -1426,7 +1426,7 @@ static void usbredir_realize(USBDevice *udev, Error **errp)
     int i;
 
     if (!qemu_chr_fe_backend_connected(&dev->cs)) {
-        error_setg(errp, QERR_MISSING_PARAMETER, "chardev");
+        error_setg(errp, "Parameter 'chardev' is missing");
         return;
     }
 
diff --git a/softmmu/qdev-monitor.c b/softmmu/qdev-monitor.c
index b17aec4357..b7b2bf18d4 100644
--- a/softmmu/qdev-monitor.c
+++ b/softmmu/qdev-monitor.c
@@ -622,7 +622,7 @@ DeviceState *qdev_device_add_from_qdict(const QDict *opts,
 
     driver = qdict_get_try_str(opts, "driver");
     if (!driver) {
-        error_setg(errp, QERR_MISSING_PARAMETER, "driver");
+        error_setg(errp, "Parameter 'driver' is missing");
         return NULL;
     }
 
diff --git a/softmmu/tpm.c b/softmmu/tpm.c
index 8437c4efc3..3a7d4b5c67 100644
--- a/softmmu/tpm.c
+++ b/softmmu/tpm.c
@@ -106,13 +106,13 @@ static int tpm_init_tpmdev(void *dummy, QemuOpts *opts, Error **errp)
 
     id = qemu_opts_id(opts);
     if (id == NULL) {
-        error_report(QERR_MISSING_PARAMETER, "id");
+        error_report("Parameter 'id' is missing");
         return 1;
     }
 
     value = qemu_opt_get(opts, "type");
     if (!value) {
-        error_report(QERR_MISSING_PARAMETER, "type");
+        error_report("Parameter 'type' is missing");
         tpm_display_backend_drivers();
         return 1;
     }
diff --git a/softmmu/vl.c b/softmmu/vl.c
index 98e071e63b..840ac84069 100644
--- a/softmmu/vl.c
+++ b/softmmu/vl.c
@@ -1801,7 +1801,7 @@ static void object_option_parse(const char *optarg)
 
         type = qemu_opt_get(opts, "qom-type");
         if (!type) {
-            error_setg(&error_fatal, QERR_MISSING_PARAMETER, "qom-type");
+            error_setg(&error_fatal, "Parameter 'qom-type' is missing");
         }
         if (user_creatable_print_help(type, opts)) {
             exit(0);
@@ -2266,7 +2266,7 @@ static int do_configure_accelerator(void *opaque, QemuOpts *opts, Error **errp)
     bool qtest_with_kvm;
 
     if (!acc) {
-        error_setg(errp, QERR_MISSING_PARAMETER, "accel");
+        error_setg(errp, "Parameter 'accel' is missing");
         goto bad;
     }
 
diff --git a/ui/input-barrier.c b/ui/input-barrier.c
index 2d57ca7079..ecbba4adc2 100644
--- a/ui/input-barrier.c
+++ b/ui/input-barrier.c
@@ -493,7 +493,7 @@ static void input_barrier_complete(UserCreatable *uc, Error **errp)
     Error *local_err = NULL;
 
     if (!ib->name) {
-        error_setg(errp, QERR_MISSING_PARAMETER, "name");
+        error_setg(errp, "Parameter 'name' is missing");
         return;
     }
 
diff --git a/ui/ui-qmp-cmds.c b/ui/ui-qmp-cmds.c
index a95fd35948..0e350fc333 100644
--- a/ui/ui-qmp-cmds.c
+++ b/ui/ui-qmp-cmds.c
@@ -195,7 +195,7 @@ void qmp_client_migrate_info(const char *protocol, const char *hostname,
         }
 
         if (!has_port && !has_tls_port) {
-            error_setg(errp, QERR_MISSING_PARAMETER, "port/tls-port");
+            error_setg(errp, "Parameter 'port/tls-port' is missing");
             return;
         }
 
-- 
2.41.0



Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A79C7EE6A7
	for <lists+qemu-devel@lfdr.de>; Thu, 16 Nov 2023 19:23:57 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r3h0j-0007nb-S3; Thu, 16 Nov 2023 13:22:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1r3h0h-0007gB-4I
 for qemu-devel@nongnu.org; Thu, 16 Nov 2023 13:22:39 -0500
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1r3h0b-0003sv-6z
 for qemu-devel@nongnu.org; Thu, 16 Nov 2023 13:22:35 -0500
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-32f7bd27c2aso876209f8f.2
 for <qemu-devel@nongnu.org>; Thu, 16 Nov 2023 10:22:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1700158950; x=1700763750; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=XujmckOuorT9tgRmqDDi9Vy4DzacPMlIY64xiIiuhls=;
 b=Wwgn0ayrRZ4B5Q5b0f0xxCZoxbEqKb1bOtJV4bvwdFraqm4pZ28WBInIuxNWWKOeXJ
 SM5/fkwzAtQSxTWoAS2wDXr7RUSB+ce91oPil3q4WqQ65Kxmyjgu5KnzwLE41i6XJktR
 ETvSCguihH1yhvubXH9kqeqAaJzXSXoMgrxPGpiJF6MJNV5vFPGne/q6CII6Edev8QHJ
 zzhIPyjgf/uYRJidhHqQX/QjLV+MXe2tlS+a1HguvukcKk2yP8RQC1yV+xDwbUBk94Vn
 Igp7T52OdeBGOHdjdX7reVaLPQYDXnTk/4wnCDUTS9hv/Fa9k6QRGeyuorD6kEG3oz1X
 uyMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700158950; x=1700763750;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=XujmckOuorT9tgRmqDDi9Vy4DzacPMlIY64xiIiuhls=;
 b=BMb5XeoWJPt6L6C9uIOAO4iwV1T6i4TsyEFqgljXysUTefD/WCSi7LMkQK5ADm2Ow8
 GMT9vUPtPxIWcKyKFIrUIP0P9ZxdVWCnM65OE/LmqDEHcG1Pegr9jdli/TgJsg13Pkpd
 fPNk91tQXWYPKY+3QsVtOBaPWTjgq26Dsv1Sigrm3z2PELMzVVCl1eziP69ixZQu86SU
 NBjphehhwfcjf1QSDCQCph1at0H2tKv7t0QXwgHEZUoOIU6vHWQ6WxK6zzl9B+K8ppwT
 BGcKF7QEeI5kNngkqhu6GVq0Li+ELcn7yZbt6pnThpsHy2mMMx01jfozglE4RJfN2Lc6
 zBGg==
X-Gm-Message-State: AOJu0YyXDP6JET6b6TNwkq5aZd68E5E4ukZ5VJVgEM/zYJh7J4iH2FrC
 Ocig0K1KkzQhuMGgEaG0o9279FdH30LbKhCW0qs=
X-Google-Smtp-Source: AGHT+IFeFRFqwi40/9iUslNevxbdL31IbVPx43hcgUL8VEm/qV2PWKqOBcKzI+8sU03Ho7Vof+XRDg==
X-Received: by 2002:a5d:5889:0:b0:32f:7734:a0fa with SMTP id
 n9-20020a5d5889000000b0032f7734a0famr16649245wrf.2.1700158950190; 
 Thu, 16 Nov 2023 10:22:30 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 f10-20020adfdb4a000000b0032da35baf7bsm61943wrj.113.2023.11.16.10.22.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 16 Nov 2023 10:22:29 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 David Woodhouse <dwmw2@infradead.org>
Subject: [PATCH for-8.2] Revert "ui/console: allow to override the default VC"
Date: Thu, 16 Nov 2023 18:22:28 +0000
Message-Id: <20231116182228.3062796-1-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42b;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x42b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

This reverts commit 1bec1cc0da497e55c16e2a7b50f94cdb2a02197f.  This
commit changed the behaviour of the "-display none" option, so that
it now creates a QEMU monitor on the terminal.  "-display none"
should not be tangled up with whether we create a monitor or a serial
terminal; it should purely and only disable the graphical window.
Changing its behaviour like this breaks command lines which, for
example, use semihosting for their output and don't want a graphical
window, as they now get a monitor they never asked for.

It also breaks the command line we document for Xen in
docs/system/i386/xen.html:

 $ ./qemu-system-x86_64 --accel kvm,xen-version=0x40011,kernel-irqchip=split \
    -display none -chardev stdio,mux=on,id=char0,signal=off -mon char0 \
    -device xen-console,chardev=char0  -drive file=${GUEST_IMAGE},if=xen

qemu-system-x86_64: cannot use stdio by multiple character devices
qemu-system-x86_64: could not connect serial device to character backend 'stdio'

Revert the commit to restore the previous handling of "-display
none".

Resolves: https://gitlab.com/qemu-project/qemu/-/issues/1974
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 include/ui/console.h |  2 --
 system/vl.c          | 27 ++++++++++-----------------
 ui/console.c         | 17 -----------------
 3 files changed, 10 insertions(+), 36 deletions(-)

diff --git a/include/ui/console.h b/include/ui/console.h
index a4a49ffc640..acb61a7f152 100644
--- a/include/ui/console.h
+++ b/include/ui/console.h
@@ -462,14 +462,12 @@ struct QemuDisplay {
     DisplayType type;
     void (*early_init)(DisplayOptions *opts);
     void (*init)(DisplayState *ds, DisplayOptions *opts);
-    const char *vc;
 };
 
 void qemu_display_register(QemuDisplay *ui);
 bool qemu_display_find_default(DisplayOptions *opts);
 void qemu_display_early_init(DisplayOptions *opts);
 void qemu_display_init(DisplayState *ds, DisplayOptions *opts);
-const char *qemu_display_get_vc(DisplayOptions *opts);
 void qemu_display_help(void);
 
 /* vnc.c */
diff --git a/system/vl.c b/system/vl.c
index 5af7ced2a16..3d64a90f253 100644
--- a/system/vl.c
+++ b/system/vl.c
@@ -1372,7 +1372,6 @@ static void qemu_setup_display(void)
 static void qemu_create_default_devices(void)
 {
     MachineClass *machine_class = MACHINE_GET_CLASS(current_machine);
-    const char *vc = qemu_display_get_vc(&dpy);
 
     if (is_daemonized()) {
         /* According to documentation and historically, -nographic redirects
@@ -1391,30 +1390,24 @@ static void qemu_create_default_devices(void)
         }
     }
 
-    if (nographic || (!vc && !is_daemonized() && isatty(STDOUT_FILENO))) {
-        if (default_parallel) {
+    if (nographic) {
+        if (default_parallel)
             add_device_config(DEV_PARALLEL, "null");
-        }
         if (default_serial && default_monitor) {
             add_device_config(DEV_SERIAL, "mon:stdio");
         } else {
-            if (default_serial) {
+            if (default_serial)
                 add_device_config(DEV_SERIAL, "stdio");
-            }
-            if (default_monitor) {
+            if (default_monitor)
                 monitor_parse("stdio", "readline", false);
-            }
         }
     } else {
-        if (default_serial) {
-            add_device_config(DEV_SERIAL, vc ?: "null");
-        }
-        if (default_parallel) {
-            add_device_config(DEV_PARALLEL, vc ?: "null");
-        }
-        if (default_monitor && vc) {
-            monitor_parse(vc, "readline", false);
-        }
+        if (default_serial)
+            add_device_config(DEV_SERIAL, "vc:80Cx24C");
+        if (default_parallel)
+            add_device_config(DEV_PARALLEL, "vc:80Cx24C");
+        if (default_monitor)
+            monitor_parse("vc:80Cx24C", "readline", false);
     }
 
     if (default_net) {
diff --git a/ui/console.c b/ui/console.c
index 8e688d35695..676d0cbaba2 100644
--- a/ui/console.c
+++ b/ui/console.c
@@ -1677,23 +1677,6 @@ void qemu_display_init(DisplayState *ds, DisplayOptions *opts)
     dpys[opts->type]->init(ds, opts);
 }
 
-const char *qemu_display_get_vc(DisplayOptions *opts)
-{
-    assert(opts->type < DISPLAY_TYPE__MAX);
-    if (opts->type == DISPLAY_TYPE_NONE) {
-        return NULL;
-    }
-    assert(dpys[opts->type] != NULL);
-    if (dpys[opts->type]->vc) {
-        return dpys[opts->type]->vc;
-    } else {
-#ifdef CONFIG_PIXMAN
-        return "vc:80Cx24C";
-#endif
-    }
-    return NULL;
-}
-
 void qemu_display_help(void)
 {
     int idx;
-- 
2.34.1



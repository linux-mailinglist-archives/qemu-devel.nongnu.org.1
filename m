Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DCE98146DB
	for <lists+qemu-devel@lfdr.de>; Fri, 15 Dec 2023 12:27:43 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rE6Km-0001LX-65; Fri, 15 Dec 2023 06:26:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1rE6Jv-00017I-Fi
 for qemu-devel@nongnu.org; Fri, 15 Dec 2023 06:25:39 -0500
Received: from mail-oi1-x22c.google.com ([2607:f8b0:4864:20::22c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1rE6Jm-0005Pw-TZ
 for qemu-devel@nongnu.org; Fri, 15 Dec 2023 06:25:25 -0500
Received: by mail-oi1-x22c.google.com with SMTP id
 5614622812f47-3b9f111c114so454778b6e.1
 for <qemu-devel@nongnu.org>; Fri, 15 Dec 2023 03:25:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1702639512; x=1703244312;
 darn=nongnu.org; 
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:from:to:cc:subject:date:message-id:reply-to;
 bh=Qoea+tnDyf+aU2FaGJue3niUJANslzwcF0rozYDJiu8=;
 b=18cZwxqe+5l06lpR/wGdVWB9CHg8v0bvzt4elAHzKUJO5Us9rkh6M3/XnE342pCIHn
 /ILT3D+nVxAMZo7dEeTmfusqXD8mskUzdUGX/4NOUp/fgQddcFdzhxGMoEigS3sHCVLt
 /tg6y3EYEMo5Zv3CDyOn3oH60U1KwaX4RcGpeje+1DMG9JmYJ60o68qKJYkb0/qAyjya
 ucoEgQWMnZ2eM7UpybWylfCYD2PfTdcarTpskugNc7hriK0ZVMtG9dxralWO91mpzwhE
 8EirWJL8oSJr+xzV35LBMHnwGn/mAk1FYHid53lDrZgQnP4gxh16lwrW9iKZq6BECT9Y
 2xIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702639512; x=1703244312;
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Qoea+tnDyf+aU2FaGJue3niUJANslzwcF0rozYDJiu8=;
 b=l2o3sq9cBVt+26kkkdDK3L1sUmAk4IpuyW+d1XuWgcIDUTV9Snjo8n/Pv7/ex2+3lc
 BW7/BFqaqA2+6/na/dFVFK8suY/fsdzi5pOAeyubmRZ3UW1mgcZqxZ1Wz1dpbXmrZMqY
 wYkRtONCyYxgtvyZbotISpHDs//vW4RkrFsA1y7C3VaOfWXPyAKWNLYYalWeZb7j0gNb
 5KEAgypQ7X8BVeFT80GPrllE1UJ8IW2Vjqg24KqYgx+TuyRn2Hua9Pb3m7I0l5fSaI2M
 nj5Ps5eV/Xu7xWY8ASANS+5FqSF3See9C3KZj/a7DcYyqzc/XEzEZUAcTnSdhi34leji
 npnQ==
X-Gm-Message-State: AOJu0YxgNHfeG7WtsLDdokxIyJtTOwnSIpVCgY+9JorlfTeXpu5J6a79
 XBY37OW0N+4JhhugliTHH3cw6qhX6RiegOnRkqrq/g==
X-Google-Smtp-Source: AGHT+IEGtpAC04XxBo0RSvUwe/jteACnnQuNv6k6R2z0rMwp04FZbz4UwHWLAgZR8dUEuURtPQjVOQ==
X-Received: by 2002:a05:6808:2e85:b0:3ba:8d5:4009 with SMTP id
 gt5-20020a0568082e8500b003ba08d54009mr15259599oib.110.1702639512611; 
 Fri, 15 Dec 2023 03:25:12 -0800 (PST)
Received: from localhost ([157.82.205.15]) by smtp.gmail.com with UTF8SMTPSA id
 s9-20020a056a00178900b006ce789d8022sm13213694pfg.59.2023.12.15.03.25.10
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 15 Dec 2023 03:25:12 -0800 (PST)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Fri, 15 Dec 2023 20:25:09 +0900
Subject: [PATCH v2] vl: Print display options for -display help
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20231215-help-v2-1-3d39b58af520@daynix.com>
X-B4-Tracking: v=1; b=H4sIAJQ3fGUC/12MQQ6CMBBFr0JmbY0zBSKuvIdh0ZSpnUQLaU0DI
 b27laXL9//L2yFxFE5wa3aInCXJHCrQqQHrTXiykqky0IU0ErbK82tRgzPY9s72PHRQ1SWyk/X
 IPMbKXtJnjttRzfhb/wIZFSrSV9LGdqZe98lsQdaznd8wllK+hW+4LZkAAAA=
To: Gerd Hoffmann <kraxel@redhat.com>, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, BALATON Zoltan <balaton@eik.bme.hu>
Cc: qemu-devel@nongnu.org, Akihiko Odaki <akihiko.odaki@daynix.com>
X-Mailer: b4 0.12.4
Received-SPF: none client-ip=2607:f8b0:4864:20::22c;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-oi1-x22c.google.com
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

-display lists display backends, but does not tell their options.
Use the help messages from qemu-options.def, which include the list of
options.

Note that this change also has an unfortunate side effect that it will
no longer tell what UI modules are actually available.

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
---
Changes in v2:
- Noted that it no longer tells the availability of UI modules.
  (Marc-André Lureau)
- Link to v1: https://lore.kernel.org/r/20231214-help-v1-1-23823ac5a023@daynix.com
---
 include/ui/console.h |  1 -
 system/vl.c          | 11 ++++++-----
 ui/console.c         | 20 --------------------
 3 files changed, 6 insertions(+), 26 deletions(-)

diff --git a/include/ui/console.h b/include/ui/console.h
index a4a49ffc640c..58f757350647 100644
--- a/include/ui/console.h
+++ b/include/ui/console.h
@@ -470,7 +470,6 @@ bool qemu_display_find_default(DisplayOptions *opts);
 void qemu_display_early_init(DisplayOptions *opts);
 void qemu_display_init(DisplayState *ds, DisplayOptions *opts);
 const char *qemu_display_get_vc(DisplayOptions *opts);
-void qemu_display_help(void);
 
 /* vnc.c */
 void vnc_display_init(const char *id, Error **errp);
diff --git a/system/vl.c b/system/vl.c
index 2bcd9efb9a64..f9656667ee54 100644
--- a/system/vl.c
+++ b/system/vl.c
@@ -915,16 +915,17 @@ enum {
 
 typedef struct QEMUOption {
     const char *name;
+    const char *help;
     int flags;
     int index;
     uint32_t arch_mask;
 } QEMUOption;
 
 static const QEMUOption qemu_options[] = {
-    { "h", 0, QEMU_OPTION_h, QEMU_ARCH_ALL },
+    { "h", NULL, 0, QEMU_OPTION_h, QEMU_ARCH_ALL },
 
 #define DEF(option, opt_arg, opt_enum, opt_help, arch_mask)     \
-    { option, opt_arg, opt_enum, arch_mask },
+    { option, opt_help, opt_arg, opt_enum, arch_mask },
 #define DEFHEADING(text)
 #define ARCHHEADING(text, arch_mask)
 
@@ -1094,10 +1095,10 @@ DisplayOptions *qmp_query_display_options(Error **errp)
     return QAPI_CLONE(DisplayOptions, &dpy);
 }
 
-static void parse_display(const char *p)
+static void parse_display(const char *p, const char *help)
 {
     if (is_help_option(p)) {
-        qemu_display_help();
+        fputs(help, stdout);
         exit(0);
     }
 
@@ -2880,7 +2881,7 @@ void qemu_init(int argc, char **argv)
                 }
                 break;
             case QEMU_OPTION_display:
-                parse_display(optarg);
+                parse_display(optarg, popt->help);
                 break;
             case QEMU_OPTION_nographic:
                 qdict_put_str(machine_opts_dict, "graphics", "off");
diff --git a/ui/console.c b/ui/console.c
index 7db921e3b7d6..6aee5e9a7ffb 100644
--- a/ui/console.c
+++ b/ui/console.c
@@ -1691,23 +1691,3 @@ const char *qemu_display_get_vc(DisplayOptions *opts)
     }
     return vc;
 }
-
-void qemu_display_help(void)
-{
-    int idx;
-
-    printf("Available display backend types:\n");
-    printf("none\n");
-    for (idx = DISPLAY_TYPE_NONE; idx < DISPLAY_TYPE__MAX; idx++) {
-        if (!dpys[idx]) {
-            Error *local_err = NULL;
-            int rv = ui_module_load(DisplayType_str(idx), &local_err);
-            if (rv < 0) {
-                error_report_err(local_err);
-            }
-        }
-        if (dpys[idx]) {
-            printf("%s\n",  DisplayType_str(dpys[idx]->type));
-        }
-    }
-}

---
base-commit: 4705fc0c8511d073bee4751c3c974aab2b10a970
change-id: 20231214-help-9fa146fc6e95

Best regards,
-- 
Akihiko Odaki <akihiko.odaki@daynix.com>



Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C28C181585A
	for <lists+qemu-devel@lfdr.de>; Sat, 16 Dec 2023 09:05:14 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rEPeN-0008A2-4S; Sat, 16 Dec 2023 03:03:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1rEPeK-00089Y-T0
 for qemu-devel@nongnu.org; Sat, 16 Dec 2023 03:03:53 -0500
Received: from mail-pj1-x102b.google.com ([2607:f8b0:4864:20::102b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1rEPeI-0000pI-4E
 for qemu-devel@nongnu.org; Sat, 16 Dec 2023 03:03:52 -0500
Received: by mail-pj1-x102b.google.com with SMTP id
 98e67ed59e1d1-28b06be7cf6so765098a91.2
 for <qemu-devel@nongnu.org>; Sat, 16 Dec 2023 00:03:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1702713829; x=1703318629;
 darn=nongnu.org; 
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:from:to:cc:subject:date:message-id:reply-to;
 bh=sn+kb/y+STJUbDhyDJJjt3vMzB1TVKcW+iHadDi07J8=;
 b=1NYEeVxByvC0je1Hdp6HhBg/fLwDQ1qlkMIluD4gr/jRfbJY4/mQ7msOVapGAPFuyc
 UlG8BCernn5JCNOMSTsp9RBk7Lq4pgABKksPw6FsHYrP9zVA+U4IOCbmJkINzxLkWf0M
 CnPhR2OAL816NC6v+Pg6B24411X/v9cQYqsnytY412YCI4lSYxSs/R/t0UGoYLSzfsYe
 bVrHhPerLrFgMEWHCUdkmld2aBRVfYgvo9pHEq6vcgS1ErUJPei0BM14V/+1cBBf7mLU
 9BLJ+LaUDakmYJvlVVZyeKdwFkRjbTYhff50bKrrx6DH7Yd0w3oQLggyT9FDM8kS8VOP
 HdtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702713829; x=1703318629;
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=sn+kb/y+STJUbDhyDJJjt3vMzB1TVKcW+iHadDi07J8=;
 b=ELb4qaEsmKEz0hGFJ7HtlJXWnmcajtxe+Nk6cyLFCr78bfFrHNFrbOOM/qw1x5tm/x
 tneEQIM/xA7EQVhFhFHUlPvlTZVbTz7pLkW7ye5UhH3GZB2PWsNmN7u580dPNDxT8fYl
 3X6ttMSLsDHGx+F5F0zX+c8zvcbvR5M/kjcA484f0hhNQMySbK7Mg9QGhPCcHHieWa+b
 hlU3e/DIfSpvRiRWjukHmrG79jMjzvLCrvzOQLudeztNpZyI7ri1cS+lYuPuM0P7OGY9
 rpOWbostUroh5/iqOpkE/myhHipPBA970AQCyZtwxVrqvIspgQplqUwBg6BNr70j4QMv
 ZPKg==
X-Gm-Message-State: AOJu0Yy3IL2A1q38CvbU8k55hynWU2+4nI6You+A14MCl7po93bSxZ/Q
 IZ1qcovBNOZH4Xqev55mv8JjZdGsIbD+d5OBjpmjqg==
X-Google-Smtp-Source: AGHT+IHP3RiOHS8qefvPMWRzGg0pQw8AIE0ARaM0PaXEBylXCfPSA/8inyJcQUJwyQ6/mkBFEW3rlg==
X-Received: by 2002:a05:6a20:7fa6:b0:18c:382e:48f1 with SMTP id
 d38-20020a056a207fa600b0018c382e48f1mr7707208pzj.7.1702713828730; 
 Sat, 16 Dec 2023 00:03:48 -0800 (PST)
Received: from localhost ([157.82.205.15]) by smtp.gmail.com with UTF8SMTPSA id
 i8-20020a17090332c800b001cfb41589ddsm15374845plr.293.2023.12.16.00.03.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 16 Dec 2023 00:03:48 -0800 (PST)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Sat, 16 Dec 2023 17:03:45 +0900
Subject: [PATCH v3] vl: Print display options for -display help
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20231216-help-v3-1-d51db92740d0@daynix.com>
X-B4-Tracking: v=1; b=H4sIAOBZfWUC/12MQQ6CMBBFr0JmbQ2dUgKuvIdxUdupTKJAWtNAC
 He3EBfq8s389xaIFJginIoFAiWOPPQZ1KEA25n+ToJdZsASlURZiY4eo2i9kVXtbU2thjwdA3m
 e9szlmrnj+BrCvFeT3K5/gSSFFKgaVMZqk19nZ+aep6MdnrAVEn5b+mNhtpRT7U03xmssf6x1X
 d85HR5BzwAAAA==
To: Gerd Hoffmann <kraxel@redhat.com>, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, BALATON Zoltan <balaton@eik.bme.hu>
Cc: qemu-devel@nongnu.org, Akihiko Odaki <akihiko.odaki@daynix.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
X-Mailer: b4 0.12.4
Received-SPF: none client-ip=2607:f8b0:4864:20::102b;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pj1-x102b.google.com
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
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Tested-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
Changes in v3:
- Dropped qapi/qapi-commands-ui.h inclusion. (Philippe Mathieu-Daudé)
- Link to v2: https://lore.kernel.org/r/20231215-help-v2-1-3d39b58af520@daynix.com

Changes in v2:
- Noted that it no longer tells the availability of UI modules.
  (Marc-André Lureau)
- Link to v1: https://lore.kernel.org/r/20231214-help-v1-1-23823ac5a023@daynix.com
---
 include/ui/console.h |  1 -
 system/vl.c          | 11 ++++++-----
 ui/console.c         | 21 ---------------------
 3 files changed, 6 insertions(+), 27 deletions(-)

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
index 7db921e3b7d6..c230951dce62 100644
--- a/ui/console.c
+++ b/ui/console.c
@@ -26,7 +26,6 @@
 #include "ui/console.h"
 #include "hw/qdev-core.h"
 #include "qapi/error.h"
-#include "qapi/qapi-commands-ui.h"
 #include "qapi/visitor.h"
 #include "qemu/coroutine.h"
 #include "qemu/error-report.h"
@@ -1691,23 +1690,3 @@ const char *qemu_display_get_vc(DisplayOptions *opts)
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



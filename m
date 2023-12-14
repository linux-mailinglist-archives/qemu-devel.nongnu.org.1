Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FA1381287A
	for <lists+qemu-devel@lfdr.de>; Thu, 14 Dec 2023 07:49:33 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rDfVp-0005eG-KT; Thu, 14 Dec 2023 01:48:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1rDfVg-0005di-At
 for qemu-devel@nongnu.org; Thu, 14 Dec 2023 01:47:53 -0500
Received: from mail-pl1-x633.google.com ([2607:f8b0:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1rDfVc-0002bz-AS
 for qemu-devel@nongnu.org; Thu, 14 Dec 2023 01:47:50 -0500
Received: by mail-pl1-x633.google.com with SMTP id
 d9443c01a7336-1d336760e72so25643905ad.3
 for <qemu-devel@nongnu.org>; Wed, 13 Dec 2023 22:47:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1702536467; x=1703141267;
 darn=nongnu.org; 
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:from:to:cc:subject:date:message-id:reply-to;
 bh=9bDQc0KTgvY+3jAvVAZbMMC2jaMlug6yySTAmoxw/dY=;
 b=vbF484gmASM0IanMoNZWlL81xCZDTL/J7jgeb0ngzAgfdrOoFsdxCb/vg8kiO797Z2
 7pJ8SHqim0rLaqLL5p1g+JsV+r60hYFK0NzzLiMKUXTtk9/JQjhPcnPv4okumBC+m/yb
 TD19Ao5bZTmYhZTh6oBZih03sEdqKaE0iSzndsZ5j02tuUx91avK96/xbxb1v6iigEJq
 bqVMmjLrYFBB1RLb/fheTkgbTgABkJ+JNvAVc3d4fyV8uHSuMtg6ieT9WSf+7W5odTIF
 A/YTnsftqxJ/H0kiImFEsgHfH15ZRIYtOmTwNfmD004mylLtl98a4BeH5VWAeJ/a/A0w
 rrQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702536467; x=1703141267;
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=9bDQc0KTgvY+3jAvVAZbMMC2jaMlug6yySTAmoxw/dY=;
 b=E4Opap/Yr8PnJweY2VVebz82k1YSPppDCJjRH3h6QQXXJoxR0z+B/fvRiDOnT5O3wP
 P4Ur7JtlMOSxn4RYVzUrQnXGIu5BdhhOI9N//CwYKg/Kx1RknQk4CjQ3gqfDYRTqBCh6
 UHKh7QFyxjF/+XVWlUytCBYJMvGxAw9RM+Oe2j+Cj9RYclLqxO5G3SkphQ6hhRDRwhfU
 cq85W/1WEz0d8hwbXwyZ0aITW++8zE79lzUd8CRYO4sH4R7r9FQ/QxGgC6o/zOnwLzxH
 gf7pgo9jD8YznfYvAu4puLbb+urTHGvF3jjgvCoEUpaRIYzF5aJGouM67aG1i59EU6Iv
 qlJg==
X-Gm-Message-State: AOJu0Yw5UKcedCfzIPUwpY1fwjenMef2S57mpso+Ocn+E9fs0DRS7z3y
 uqDgLfKBwqOm8hKeuh12c/+/6g==
X-Google-Smtp-Source: AGHT+IEA9/M1Q96OT7gJo4VYiYwvHaO3QcJCh/ESfhMn9L2MN3Y+KG3qevxvgndImIy67S1trW1XXw==
X-Received: by 2002:a17:902:a38d:b0:1d3:6c43:b4b0 with SMTP id
 x13-20020a170902a38d00b001d36c43b4b0mr251821pla.23.1702536466856; 
 Wed, 13 Dec 2023 22:47:46 -0800 (PST)
Received: from localhost ([157.82.200.183])
 by smtp.gmail.com with UTF8SMTPSA id
 g24-20020a170902869800b001cfdf290e82sm11544436plo.35.2023.12.13.22.47.45
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 13 Dec 2023 22:47:46 -0800 (PST)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Thu, 14 Dec 2023 15:47:30 +0900
Subject: [PATCH] vl: Print display options for -display help
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231214-help-v1-1-23823ac5a023@daynix.com>
X-B4-Tracking: v=1; b=H4sIAAGlemUC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI2NDI0MT3YzUnAJdy7REQxOztGSzVEtTJaDSgqLUtMwKsDHRsbW1AIO2OcF
 WAAAA
To: Gerd Hoffmann <kraxel@redhat.com>, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, BALATON Zoltan <balaton@eik.bme.hu>
Cc: qemu-devel@nongnu.org, Akihiko Odaki <akihiko.odaki@daynix.com>
X-Mailer: b4 0.12.4
Received-SPF: none client-ip=2607:f8b0:4864:20::633;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pl1-x633.google.com
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

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
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



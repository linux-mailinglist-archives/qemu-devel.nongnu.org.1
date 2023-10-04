Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D7F5C7B7EB2
	for <lists+qemu-devel@lfdr.de>; Wed,  4 Oct 2023 14:07:24 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qo0bc-0003nl-HY; Wed, 04 Oct 2023 08:03:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qo0Ze-0000WB-Jz
 for qemu-devel@nongnu.org; Wed, 04 Oct 2023 08:02:02 -0400
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qo0ZZ-0001CB-HK
 for qemu-devel@nongnu.org; Wed, 04 Oct 2023 08:01:53 -0400
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-3231df68584so1912410f8f.1
 for <qemu-devel@nongnu.org>; Wed, 04 Oct 2023 05:01:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1696420907; x=1697025707; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=VbE/h6HUxHm1fKUuktISJWotuykVg/wSDPAOtZyCrGc=;
 b=hdDcmOioNI1LwLw1KWdoNWmvMAdoxQ5O3opOQmCc2efN0ryEmuV3wIJPTjJQEGHtwr
 rvt7M+wXW7pb6dwH8UqG9zfuak4cmMdzUK0NFGhP9eccAwPQuL0yPRrHnSbCRnyqZ30c
 OZdGcW6WQJYkIYNpnC/YCKLhtvuaWT8bzXYF35uNNBzJvpeesnWdC7YA2/MyJHgxHR3m
 Fy5ueucVPXHDgz50r31kgo4jVEqeyHe6rsPiw6pxcmVnvIAymyzQzSK6QbmBfnJFGH2X
 LhXCBNZ/bjKuKdjQTZCLDn/AssShD90taR3i6WrkyAzx+7c6u6GABR0Qwb46xWmm7j6V
 y0vA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696420907; x=1697025707;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=VbE/h6HUxHm1fKUuktISJWotuykVg/wSDPAOtZyCrGc=;
 b=LFm4gzsh+rD4ILzc1fAH1sTKSk8HrCI5ejbp2hyuf8kY57s51f6cB2y854hAXztTA7
 n+LJwMVGJaz1jBnPoxuAJqPYBHBqqper2S7OanYGvstSRZG6gnbwO9jDS2af6sXM3Rhk
 lV/c9GAPK0sLn6cERjznCdfqS3W5JhIwKdEHVgIYhriQokVk4fmfB3vK6BLwu9gRizYR
 ey45Im7ei9p05sa1i+JBlxo2ttp7I0nEePgaESsVvRELdmx4804Uvg3XchXrDuN9Cxbr
 PWeVJFU0w5OEk6VXvk2ihB87C0+Ild3sKWsav1YHyOPx0P8nic+yKCxsuUCoVgEHrAX5
 l/gA==
X-Gm-Message-State: AOJu0YzvSkykVa/oovUyM0xObD34U7ev6MZ0LcPMtUi6cq90xr7cSiUJ
 Jbc5dOdkh8a2AT66h/Ry9gZPqPo07CcdhK9SH9o=
X-Google-Smtp-Source: AGHT+IGm4UV2ii+97ouFej/zuni8IHRqZGQ/5lAmriv3wImpdvXXr8pYR67CVUHmV/igjzSa5G5fFw==
X-Received: by 2002:adf:d4cb:0:b0:31a:ed75:75e9 with SMTP id
 w11-20020adfd4cb000000b0031aed7575e9mr2097115wrk.13.1696420906827; 
 Wed, 04 Oct 2023 05:01:46 -0700 (PDT)
Received: from m1x-phil.lan (5ep85-h01-176-173-163-52.dslam.bbox.fr.
 [176.173.163.52]) by smtp.gmail.com with ESMTPSA id
 w10-20020adfd4ca000000b0031ad5470f89sm3894894wrk.18.2023.10.04.05.01.45
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 04 Oct 2023 05:01:46 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Markus Armbruster <armbru@redhat.com>,
 Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH v3 14/16] softmmu/vl: Clean up global variable shadowing
Date: Wed,  4 Oct 2023 14:00:17 +0200
Message-ID: <20231004120019.93101-15-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231004120019.93101-1-philmd@linaro.org>
References: <20231004120019.93101-1-philmd@linaro.org>
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

Fix:

  softmmu/vl.c:1069:44: error: declaration shadows a variable in the global scope [-Werror,-Wshadow]
  static void parse_display_qapi(const char *optarg)
                                             ^
  softmmu/vl.c:1224:39: error: declaration shadows a variable in the global scope [-Werror,-Wshadow]
  static void monitor_parse(const char *optarg, const char *mode, bool pretty)
                                        ^
  softmmu/vl.c:1634:17: error: declaration shadows a variable in the global scope [-Werror,-Wshadow]
      const char *optarg = qdict_get_try_str(qdict, "type");
                  ^
  softmmu/vl.c:1784:45: error: declaration shadows a variable in the global scope [-Werror,-Wshadow]
  static void object_option_parse(const char *optarg)
                                              ^
  /Library/Developer/CommandLineTools/SDKs/MacOSX.sdk/usr/include/getopt.h:77:14: note: previous declaration is here
  extern char *optarg;                    /* getopt(3) external variables */
               ^

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 softmmu/vl.c | 26 +++++++++++++-------------
 1 file changed, 13 insertions(+), 13 deletions(-)

diff --git a/softmmu/vl.c b/softmmu/vl.c
index 98e071e63b..ae1ff9887d 100644
--- a/softmmu/vl.c
+++ b/softmmu/vl.c
@@ -1066,12 +1066,12 @@ static void select_vgahw(const MachineClass *machine_class, const char *p)
     }
 }
 
-static void parse_display_qapi(const char *optarg)
+static void parse_display_qapi(const char *optstr)
 {
     DisplayOptions *opts;
     Visitor *v;
 
-    v = qobject_input_visitor_new_str(optarg, "type", &error_fatal);
+    v = qobject_input_visitor_new_str(optstr, "type", &error_fatal);
 
     visit_type_DisplayOptions(v, NULL, &opts, &error_fatal);
     QAPI_CLONE_MEMBERS(DisplayOptions, &dpy, opts);
@@ -1221,21 +1221,21 @@ static int mon_init_func(void *opaque, QemuOpts *opts, Error **errp)
     return monitor_init_opts(opts, errp);
 }
 
-static void monitor_parse(const char *optarg, const char *mode, bool pretty)
+static void monitor_parse(const char *str, const char *mode, bool pretty)
 {
     static int monitor_device_index = 0;
     QemuOpts *opts;
     const char *p;
     char label[32];
 
-    if (strstart(optarg, "chardev:", &p)) {
+    if (strstart(str, "chardev:", &p)) {
         snprintf(label, sizeof(label), "%s", p);
     } else {
         snprintf(label, sizeof(label), "compat_monitor%d",
                  monitor_device_index);
-        opts = qemu_chr_parse_compat(label, optarg, true);
+        opts = qemu_chr_parse_compat(label, str, true);
         if (!opts) {
-            error_report("parse error: %s", optarg);
+            error_report("parse error: %s", str);
             exit(1);
         }
     }
@@ -1631,13 +1631,13 @@ static const QEMUOption *lookup_opt(int argc, char **argv,
 
 static MachineClass *select_machine(QDict *qdict, Error **errp)
 {
-    const char *optarg = qdict_get_try_str(qdict, "type");
+    const char *machine_type = qdict_get_try_str(qdict, "type");
     GSList *machines = object_class_get_list(TYPE_MACHINE, false);
     MachineClass *machine_class;
     Error *local_err = NULL;
 
-    if (optarg) {
-        machine_class = find_machine(optarg, machines);
+    if (machine_type) {
+        machine_class = find_machine(machine_type, machines);
         qdict_del(qdict, "type");
         if (!machine_class) {
             error_setg(&local_err, "unsupported machine type");
@@ -1781,20 +1781,20 @@ static void object_option_add_visitor(Visitor *v)
     QTAILQ_INSERT_TAIL(&object_opts, opt, next);
 }
 
-static void object_option_parse(const char *optarg)
+static void object_option_parse(const char *optstr)
 {
     QemuOpts *opts;
     const char *type;
     Visitor *v;
 
-    if (optarg[0] == '{') {
-        QObject *obj = qobject_from_json(optarg, &error_fatal);
+    if (optstr[0] == '{') {
+        QObject *obj = qobject_from_json(optstr, &error_fatal);
 
         v = qobject_input_visitor_new(obj);
         qobject_unref(obj);
     } else {
         opts = qemu_opts_parse_noisily(qemu_find_opts("object"),
-                                       optarg, true);
+                                       optstr, true);
         if (!opts) {
             exit(1);
         }
-- 
2.41.0



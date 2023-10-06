Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 01E8D7BB691
	for <lists+qemu-devel@lfdr.de>; Fri,  6 Oct 2023 13:39:10 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qoj9T-0005D8-W8; Fri, 06 Oct 2023 07:37:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1qoj93-00053B-0O
 for qemu-devel@nongnu.org; Fri, 06 Oct 2023 07:37:26 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1qoj8u-00008g-0Q
 for qemu-devel@nongnu.org; Fri, 06 Oct 2023 07:37:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1696592227;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Dp18yDfa0xSGbMJbUgqL8hFOVcmn22n/M/o33Bq6pZ0=;
 b=hihujg3d4DHhLlA+F13p3bAIWAqtv/4LaC0mb0zjipbhbqBRKSMVBZPmg6lpnBI6J3Weae
 3K2ScDJT4RhNahry79ILO4yqnHUE7ciftqjTq4oKgGVUzRkPP5AoybZCmvC8umQZfDVi/p
 ozD9Bs9w/Jh0QhgTvW5qre02ZeBDj5Y=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-571-QtCohzAOPA6tYsfsq0Ty-Q-1; Fri, 06 Oct 2023 07:37:01 -0400
X-MC-Unique: QtCohzAOPA6tYsfsq0Ty-Q-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com
 [10.11.54.7])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id DC039858F1C;
 Fri,  6 Oct 2023 11:37:00 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.25])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 9FC8A140E963;
 Fri,  6 Oct 2023 11:37:00 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 9766821E6887; Fri,  6 Oct 2023 13:36:57 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: stefanha@redhat.com,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 23/32] softmmu/vl: Clean up global variable shadowing
Date: Fri,  6 Oct 2023 13:36:48 +0200
Message-ID: <20231006113657.3803180-24-armbru@redhat.com>
In-Reply-To: <20231006113657.3803180-1-armbru@redhat.com>
References: <20231006113657.3803180-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.7
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Philippe Mathieu-Daudé <philmd@linaro.org>

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
Message-ID: <20231004120019.93101-15-philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Markus Armbruster <armbru@redhat.com>
[Tweak two parameter names]
Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 softmmu/vl.c | 26 +++++++++++++-------------
 1 file changed, 13 insertions(+), 13 deletions(-)

diff --git a/softmmu/vl.c b/softmmu/vl.c
index 98e071e63b..13c1b24706 100644
--- a/softmmu/vl.c
+++ b/softmmu/vl.c
@@ -1066,12 +1066,12 @@ static void select_vgahw(const MachineClass *machine_class, const char *p)
     }
 }
 
-static void parse_display_qapi(const char *optarg)
+static void parse_display_qapi(const char *str)
 {
     DisplayOptions *opts;
     Visitor *v;
 
-    v = qobject_input_visitor_new_str(optarg, "type", &error_fatal);
+    v = qobject_input_visitor_new_str(str, "type", &error_fatal);
 
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
+static void object_option_parse(const char *str)
 {
     QemuOpts *opts;
     const char *type;
     Visitor *v;
 
-    if (optarg[0] == '{') {
-        QObject *obj = qobject_from_json(optarg, &error_fatal);
+    if (str[0] == '{') {
+        QObject *obj = qobject_from_json(str, &error_fatal);
 
         v = qobject_input_visitor_new(obj);
         qobject_unref(obj);
     } else {
         opts = qemu_opts_parse_noisily(qemu_find_opts("object"),
-                                       optarg, true);
+                                       str, true);
         if (!opts) {
             exit(1);
         }
-- 
2.41.0



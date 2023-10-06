Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3318D7BB6AE
	for <lists+qemu-devel@lfdr.de>; Fri,  6 Oct 2023 13:41:58 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qoj9M-0005A9-AS; Fri, 06 Oct 2023 07:37:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1qoj96-00054E-Vi
 for qemu-devel@nongnu.org; Fri, 06 Oct 2023 07:37:29 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1qoj92-0000EK-Of
 for qemu-devel@nongnu.org; Fri, 06 Oct 2023 07:37:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1696592239;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=kQ+pT3ow6c+WuoVGzJFiDX22KI3j54JHlCbDNYJLjwE=;
 b=OwaMSJV1Iwybc4yhdPGG8V0+qPCj1pOZps1VbmbcFvr5prR4xbTVP4X1LVXzC84sgi9uTp
 0QENm4AZkPo3AM6529Cx8brpCmCYxDRf28NF/0D4OlWhMj/0bGkBClFS/pLMIqkfVL6leK
 Eg1jB+ZcQdNjwfRboIkOM6VcDQhkrt0=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-418-UuB_B-BbNG25SXr0P506Yg-1; Fri, 06 Oct 2023 07:37:01 -0400
X-MC-Unique: UuB_B-BbNG25SXr0P506Yg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
 [10.11.54.6])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id D3C35101A58B;
 Fri,  6 Oct 2023 11:37:00 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.25])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 956A72156711;
 Fri,  6 Oct 2023 11:37:00 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 8644C21E6880; Fri,  6 Oct 2023 13:36:57 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: stefanha@redhat.com,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 17/32] qom/object_interfaces: Clean up global variable shadowing
Date: Fri,  6 Oct 2023 13:36:42 +0200
Message-ID: <20231006113657.3803180-18-armbru@redhat.com>
In-Reply-To: <20231006113657.3803180-1-armbru@redhat.com>
References: <20231006113657.3803180-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.6
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

  qom/object_interfaces.c:262:53: error: declaration shadows a variable in the global scope [-Werror,-Wshadow]
  ObjectOptions *user_creatable_parse_str(const char *optarg, Error **errp)
                                                      ^
  qom/object_interfaces.c:298:46: error: declaration shadows a variable in the global scope [-Werror,-Wshadow]
  bool user_creatable_add_from_str(const char *optarg, Error **errp)
                                               ^
  qom/object_interfaces.c:313:49: error: declaration shadows a variable in the global scope [-Werror,-Wshadow]
  void user_creatable_process_cmdline(const char *optarg)
                                                  ^
  /Library/Developer/CommandLineTools/SDKs/MacOSX.sdk/usr/include/getopt.h:77:14: note: previous declaration is here
  extern char *optarg;                    /* getopt(3) external variables */
               ^

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-ID: <20231004120019.93101-9-philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 include/qom/object_interfaces.h | 16 ++++++++--------
 qom/object_interfaces.c         | 16 ++++++++--------
 2 files changed, 16 insertions(+), 16 deletions(-)

diff --git a/include/qom/object_interfaces.h b/include/qom/object_interfaces.h
index 81541e2080..02b11a7ef0 100644
--- a/include/qom/object_interfaces.h
+++ b/include/qom/object_interfaces.h
@@ -99,7 +99,7 @@ void user_creatable_add_qapi(ObjectOptions *options, Error **errp);
 
 /**
  * user_creatable_parse_str:
- * @optarg: the object definition string as passed on the command line
+ * @str: the object definition string as passed on the command line
  * @errp: if an error occurs, a pointer to an area to store the error
  *
  * Parses the option for the user creatable object with a keyval parser and
@@ -110,14 +110,14 @@ void user_creatable_add_qapi(ObjectOptions *options, Error **errp);
  * Returns: ObjectOptions on success, NULL when an error occurred (*errp is set
  * then) or help was printed (*errp is not set).
  */
-ObjectOptions *user_creatable_parse_str(const char *optarg, Error **errp);
+ObjectOptions *user_creatable_parse_str(const char *str, Error **errp);
 
 /**
  * user_creatable_add_from_str:
- * @optarg: the object definition string as passed on the command line
+ * @str: the object definition string as passed on the command line
  * @errp: if an error occurs, a pointer to an area to store the error
  *
- * Create an instance of the user creatable object by parsing optarg
+ * Create an instance of the user creatable object by parsing @str
  * with a keyval parser and implicit key 'qom-type', converting the
  * result to ObjectOptions and calling into qmp_object_add().
  *
@@ -126,13 +126,13 @@ ObjectOptions *user_creatable_parse_str(const char *optarg, Error **errp);
  * Returns: true when an object was successfully created, false when an error
  * occurred (*errp is set then) or help was printed (*errp is not set).
  */
-bool user_creatable_add_from_str(const char *optarg, Error **errp);
+bool user_creatable_add_from_str(const char *str, Error **errp);
 
 /**
  * user_creatable_process_cmdline:
- * @optarg: the object definition string as passed on the command line
+ * @cmdline: the object definition string as passed on the command line
  *
- * Create an instance of the user creatable object by parsing optarg
+ * Create an instance of the user creatable object by parsing @cmdline
  * with a keyval parser and implicit key 'qom-type', converting the
  * result to ObjectOptions and calling into qmp_object_add().
  *
@@ -141,7 +141,7 @@ bool user_creatable_add_from_str(const char *optarg, Error **errp);
  * This function is only meant to be called during command line parsing.
  * It exits the process on failure or after printing help.
  */
-void user_creatable_process_cmdline(const char *optarg);
+void user_creatable_process_cmdline(const char *cmdline);
 
 /**
  * user_creatable_print_help:
diff --git a/qom/object_interfaces.c b/qom/object_interfaces.c
index 7d31589b04..e0833c8bfe 100644
--- a/qom/object_interfaces.c
+++ b/qom/object_interfaces.c
@@ -259,7 +259,7 @@ static void user_creatable_print_help_from_qdict(QDict *args)
     }
 }
 
-ObjectOptions *user_creatable_parse_str(const char *optarg, Error **errp)
+ObjectOptions *user_creatable_parse_str(const char *str, Error **errp)
 {
     ERRP_GUARD();
     QObject *obj;
@@ -267,14 +267,14 @@ ObjectOptions *user_creatable_parse_str(const char *optarg, Error **errp)
     Visitor *v;
     ObjectOptions *options;
 
-    if (optarg[0] == '{') {
-        obj = qobject_from_json(optarg, errp);
+    if (str[0] == '{') {
+        obj = qobject_from_json(str, errp);
         if (!obj) {
             return NULL;
         }
         v = qobject_input_visitor_new(obj);
     } else {
-        QDict *args = keyval_parse(optarg, "qom-type", &help, errp);
+        QDict *args = keyval_parse(str, "qom-type", &help, errp);
         if (*errp) {
             return NULL;
         }
@@ -295,12 +295,12 @@ ObjectOptions *user_creatable_parse_str(const char *optarg, Error **errp)
     return options;
 }
 
-bool user_creatable_add_from_str(const char *optarg, Error **errp)
+bool user_creatable_add_from_str(const char *str, Error **errp)
 {
     ERRP_GUARD();
     ObjectOptions *options;
 
-    options = user_creatable_parse_str(optarg, errp);
+    options = user_creatable_parse_str(str, errp);
     if (!options) {
         return false;
     }
@@ -310,9 +310,9 @@ bool user_creatable_add_from_str(const char *optarg, Error **errp)
     return !*errp;
 }
 
-void user_creatable_process_cmdline(const char *optarg)
+void user_creatable_process_cmdline(const char *cmdline)
 {
-    if (!user_creatable_add_from_str(optarg, &error_fatal)) {
+    if (!user_creatable_add_from_str(cmdline, &error_fatal)) {
         /* Help was printed */
         exit(EXIT_SUCCESS);
     }
-- 
2.41.0



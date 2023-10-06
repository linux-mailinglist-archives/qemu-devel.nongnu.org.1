Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 751577BB6BB
	for <lists+qemu-devel@lfdr.de>; Fri,  6 Oct 2023 13:42:51 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qoj9V-0005Eu-Uc; Fri, 06 Oct 2023 07:37:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1qoj96-00054D-Qj
 for qemu-devel@nongnu.org; Fri, 06 Oct 2023 07:37:29 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1qoj90-0000EB-Iw
 for qemu-devel@nongnu.org; Fri, 06 Oct 2023 07:37:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1696592239;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=n4zK6KjuMtQLVDggv3EgqW/6JdP/Ds6q2/MlLzdYfIo=;
 b=DQRlTDMkRIAhFz8x9k15kOVtRjkQeJM7qX+v+EaurPWii1WqLi/fVurwvomrxGVPFfPmWN
 bJ7YmMqlezyRK/00AWWhJ/Gz+1z5T44p/GyCNfBire6pmHNNjxluBSEiBZdk7oF/vMs4Bj
 qUokaaguM8dF0ibvMlSaUtrNaFY8+Pk=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-610-_gTK8oOBPE653dfOeH2B0g-1; Fri, 06 Oct 2023 07:37:01 -0400
X-MC-Unique: _gTK8oOBPE653dfOeH2B0g-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
 [10.11.54.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id D797E3827DE8;
 Fri,  6 Oct 2023 11:37:00 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.25])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 952055CC01;
 Fri,  6 Oct 2023 11:37:00 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 8076E21E691B; Fri,  6 Oct 2023 13:36:57 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: stefanha@redhat.com,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Eric Blake <eblake@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 15/32] qemu-img: Clean up global variable shadowing
Date: Fri,  6 Oct 2023 13:36:40 +0200
Message-ID: <20231006113657.3803180-16-armbru@redhat.com>
In-Reply-To: <20231006113657.3803180-1-armbru@redhat.com>
References: <20231006113657.3803180-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.5
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

  qemu-img.c:247:46: error: declaration shadows a variable in the global scope [-Werror,-Wshadow]
  static bool is_valid_option_list(const char *optarg)
                                               ^
  qemu-img.c:265:53: error: declaration shadows a variable in the global scope [-Werror,-Wshadow]
  static int accumulate_options(char **options, char *optarg)
                                                      ^
  /Library/Developer/CommandLineTools/SDKs/MacOSX.sdk/usr/include/getopt.h:77:14: note: previous declaration is here
  extern char *optarg;                    /* getopt(3) external variables */
               ^

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-ID: <20231004120019.93101-7-philmd@linaro.org>
Reviewed-by: Eric Blake <eblake@redhat.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 qemu-img.c | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/qemu-img.c b/qemu-img.c
index a48edb7101..6068ab0d27 100644
--- a/qemu-img.c
+++ b/qemu-img.c
@@ -235,25 +235,25 @@ void help(void)
 }
 
 /*
- * Is @optarg safe for accumulate_options()?
+ * Is @list safe for accumulate_options()?
  * It is when multiple of them can be joined together separated by ','.
- * To make that work, @optarg must not start with ',' (or else a
+ * To make that work, @list must not start with ',' (or else a
  * separating ',' preceding it gets escaped), and it must not end with
  * an odd number of ',' (or else a separating ',' following it gets
  * escaped), or be empty (or else a separating ',' preceding it can
  * escape a separating ',' following it).
  * 
  */
-static bool is_valid_option_list(const char *optarg)
+static bool is_valid_option_list(const char *list)
 {
-    size_t len = strlen(optarg);
+    size_t len = strlen(list);
     size_t i;
 
-    if (!optarg[0] || optarg[0] == ',') {
+    if (!list[0] || list[0] == ',') {
         return false;
     }
 
-    for (i = len; i > 0 && optarg[i - 1] == ','; i--) {
+    for (i = len; i > 0 && list[i - 1] == ','; i--) {
     }
     if ((len - i) % 2) {
         return false;
@@ -262,19 +262,19 @@ static bool is_valid_option_list(const char *optarg)
     return true;
 }
 
-static int accumulate_options(char **options, char *optarg)
+static int accumulate_options(char **options, char *list)
 {
     char *new_options;
 
-    if (!is_valid_option_list(optarg)) {
-        error_report("Invalid option list: %s", optarg);
+    if (!is_valid_option_list(list)) {
+        error_report("Invalid option list: %s", list);
         return -1;
     }
 
     if (!*options) {
-        *options = g_strdup(optarg);
+        *options = g_strdup(list);
     } else {
-        new_options = g_strdup_printf("%s,%s", *options, optarg);
+        new_options = g_strdup_printf("%s,%s", *options, list);
         g_free(*options);
         *options = new_options;
     }
-- 
2.41.0



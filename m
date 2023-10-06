Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CEA5A7BB6AD
	for <lists+qemu-devel@lfdr.de>; Fri,  6 Oct 2023 13:41:57 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qoj9I-00057T-Lv; Fri, 06 Oct 2023 07:37:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1qoj8u-00050s-8z
 for qemu-devel@nongnu.org; Fri, 06 Oct 2023 07:37:16 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1qoj8o-00008K-Ll
 for qemu-devel@nongnu.org; Fri, 06 Oct 2023 07:37:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1696592225;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=yyqNIrAV89ZLDcW0VZ3dmJJQ7bbyUqitHtkl6WYqbIg=;
 b=FkIcl8ZJDH7UoWoKjmTZvxyzHolsHMA8lB6mHOF1Ow73tWVQ+qfd3jsGc5liFWy52Qen6C
 TQKH77+LN0oHZy42BD0/qnoX6Ftwv0zS2aIceY4qPXZxfAS/auvu+llB8Tq8YY/HFEqokq
 4E7Bwc0p019tLf2x2AQ1sXdI6zAKMbk=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-122-V48I8PrHNNiT-_s67WZmYA-1; Fri, 06 Oct 2023 07:37:00 -0400
X-MC-Unique: V48I8PrHNNiT-_s67WZmYA-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com
 [10.11.54.9])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id DB36F18175A4;
 Fri,  6 Oct 2023 11:36:59 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.25])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id BAABD47AD4A;
 Fri,  6 Oct 2023 11:36:59 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 7D5C821E691A; Fri,  6 Oct 2023 13:36:57 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: stefanha@redhat.com,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 14/32] plugins/loader: Clean up global variable shadowing
Date: Fri,  6 Oct 2023 13:36:39 +0200
Message-ID: <20231006113657.3803180-15-armbru@redhat.com>
In-Reply-To: <20231006113657.3803180-1-armbru@redhat.com>
References: <20231006113657.3803180-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.9
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

  include/qemu/plugin.h:245:54: error: declaration shadows a variable in the global scope [-Werror,-Wshadow]
  static inline void qemu_plugin_opt_parse(const char *optarg,
                                                       ^
  /Library/Developer/CommandLineTools/SDKs/MacOSX.sdk/usr/include/getopt.h:77:14: note: previous declaration is here
  extern char *optarg;                    /* getopt(3) external variables */
               ^

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-ID: <20231004120019.93101-6-philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 include/qemu/plugin.h | 4 ++--
 plugins/loader.c      | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/include/qemu/plugin.h b/include/qemu/plugin.h
index bc0781cab8..7fdc3a4849 100644
--- a/include/qemu/plugin.h
+++ b/include/qemu/plugin.h
@@ -50,7 +50,7 @@ static inline void qemu_plugin_add_opts(void)
     qemu_add_opts(&qemu_plugin_opts);
 }
 
-void qemu_plugin_opt_parse(const char *optarg, QemuPluginList *head);
+void qemu_plugin_opt_parse(const char *optstr, QemuPluginList *head);
 int qemu_plugin_load_list(QemuPluginList *head, Error **errp);
 
 union qemu_plugin_cb_sig {
@@ -242,7 +242,7 @@ void qemu_plugin_user_postfork(bool is_child);
 static inline void qemu_plugin_add_opts(void)
 { }
 
-static inline void qemu_plugin_opt_parse(const char *optarg,
+static inline void qemu_plugin_opt_parse(const char *optstr,
                                          QemuPluginList *head)
 {
     error_report("plugin interface not enabled in this build");
diff --git a/plugins/loader.c b/plugins/loader.c
index 809f3f9b13..734c11cae0 100644
--- a/plugins/loader.c
+++ b/plugins/loader.c
@@ -140,12 +140,12 @@ static int plugin_add(void *opaque, const char *name, const char *value,
     return 0;
 }
 
-void qemu_plugin_opt_parse(const char *optarg, QemuPluginList *head)
+void qemu_plugin_opt_parse(const char *optstr, QemuPluginList *head)
 {
     struct qemu_plugin_parse_arg arg;
     QemuOpts *opts;
 
-    opts = qemu_opts_parse_noisily(qemu_find_opts("plugin"), optarg, true);
+    opts = qemu_opts_parse_noisily(qemu_find_opts("plugin"), optstr, true);
     if (opts == NULL) {
         exit(1);
     }
-- 
2.41.0



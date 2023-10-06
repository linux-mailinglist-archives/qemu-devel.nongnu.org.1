Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 79BD97BB69C
	for <lists+qemu-devel@lfdr.de>; Fri,  6 Oct 2023 13:40:04 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qoj9H-000557-BJ; Fri, 06 Oct 2023 07:37:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1qoj8t-00050l-Lr
 for qemu-devel@nongnu.org; Fri, 06 Oct 2023 07:37:16 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1qoj8n-00007B-UC
 for qemu-devel@nongnu.org; Fri, 06 Oct 2023 07:37:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1696592222;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=E0/SmeVkKQwC85Yi9z735skKKvyYk8aaSrlBFMMKON8=;
 b=cGcp62DKW/hNGMXMM4WlkPkwL5d4ZErAW0KWOH1oFMnOXGBJvA2QRY/A7CppF9VR2BZeuh
 /Spttx/p8kPRNHyApM1ztcEghKHCTsVlEU6+uPcpeKN29CjIyPco6y0BIpuQ/73hVIMgyQ
 D7g5CXOhHQfD/IKsLEEkYFe0OqDselI=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-57-GUgSinHLNO6mKmG-zgCWcQ-1; Fri, 06 Oct 2023 07:37:01 -0400
X-MC-Unique: GUgSinHLNO6mKmG-zgCWcQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com
 [10.11.54.2])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id B8A191C06367;
 Fri,  6 Oct 2023 11:37:00 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.25])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 95DC440C6EA8;
 Fri,  6 Oct 2023 11:37:00 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 8934E21E6882; Fri,  6 Oct 2023 13:36:57 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: stefanha@redhat.com,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 18/32] semihosting: Clean up global variable shadowing
Date: Fri,  6 Oct 2023 13:36:43 +0200
Message-ID: <20231006113657.3803180-19-armbru@redhat.com>
In-Reply-To: <20231006113657.3803180-1-armbru@redhat.com>
References: <20231006113657.3803180-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.2
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

  semihosting/config.c:134:49: error: declaration shadows a variable in the global scope [-Werror,-Wshadow]
  int qemu_semihosting_config_options(const char *optarg)
                                                  ^
  /Library/Developer/CommandLineTools/SDKs/MacOSX.sdk/usr/include/getopt.h:77:14: note: previous declaration is here
  extern char *optarg;                    /* getopt(3) external variables */
               ^

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-ID: <20231004120019.93101-10-philmd@linaro.org>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 include/semihosting/semihost.h | 2 +-
 semihosting/config.c           | 8 ++++----
 stubs/semihost.c               | 2 +-
 3 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/include/semihosting/semihost.h b/include/semihosting/semihost.h
index efd2efa25a..97d2a2ba99 100644
--- a/include/semihosting/semihost.h
+++ b/include/semihosting/semihost.h
@@ -66,7 +66,7 @@ const char *semihosting_get_cmdline(void);
 void semihosting_arg_fallback(const char *file, const char *cmd);
 /* for vl.c hooks */
 void qemu_semihosting_enable(void);
-int qemu_semihosting_config_options(const char *opt);
+int qemu_semihosting_config_options(const char *optstr);
 void qemu_semihosting_chardev_init(void);
 void qemu_semihosting_console_init(Chardev *);
 #endif /* CONFIG_USER_ONLY */
diff --git a/semihosting/config.c b/semihosting/config.c
index 8ca569735d..e826457733 100644
--- a/semihosting/config.c
+++ b/semihosting/config.c
@@ -131,10 +131,10 @@ void qemu_semihosting_enable(void)
     semihosting.target = SEMIHOSTING_TARGET_AUTO;
 }
 
-int qemu_semihosting_config_options(const char *optarg)
+int qemu_semihosting_config_options(const char *optstr)
 {
     QemuOptsList *opt_list = qemu_find_opts("semihosting-config");
-    QemuOpts *opts = qemu_opts_parse_noisily(opt_list, optarg, false);
+    QemuOpts *opts = qemu_opts_parse_noisily(opt_list, optstr, false);
 
     semihosting.enabled = true;
 
@@ -155,7 +155,7 @@ int qemu_semihosting_config_options(const char *optarg)
                 semihosting.target = SEMIHOSTING_TARGET_AUTO;
             } else {
                 error_report("unsupported semihosting-config %s",
-                             optarg);
+                             optstr);
                 return 1;
             }
         } else {
@@ -165,7 +165,7 @@ int qemu_semihosting_config_options(const char *optarg)
         qemu_opt_foreach(opts, add_semihosting_arg,
                          &semihosting, NULL);
     } else {
-        error_report("unsupported semihosting-config %s", optarg);
+        error_report("unsupported semihosting-config %s", optstr);
         return 1;
     }
 
diff --git a/stubs/semihost.c b/stubs/semihost.c
index aad7a70353..b3c61935b3 100644
--- a/stubs/semihost.c
+++ b/stubs/semihost.c
@@ -36,7 +36,7 @@ void qemu_semihosting_enable(void)
 {
 }
 
-int qemu_semihosting_config_options(const char *optarg)
+int qemu_semihosting_config_options(const char *optstr)
 {
     return 1;
 }
-- 
2.41.0



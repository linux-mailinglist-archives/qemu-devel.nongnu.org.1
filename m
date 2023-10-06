Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 03C1E7BB6BC
	for <lists+qemu-devel@lfdr.de>; Fri,  6 Oct 2023 13:42:54 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qoj9V-0005E0-6S; Fri, 06 Oct 2023 07:37:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1qoj8x-00051v-1D
 for qemu-devel@nongnu.org; Fri, 06 Oct 2023 07:37:19 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1qoj8t-00007q-9K
 for qemu-devel@nongnu.org; Fri, 06 Oct 2023 07:37:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1696592224;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=GGCzqdXxW4X7LjlOPUJQlBqL1VydtpWMZvfIPJEozd4=;
 b=IO6v/3w8tYnhGekNJRXt9j/+l5BjF0rU2pfHkZFUIKpx5n4GXJe+/qZ3fhcYx68BHx+WcW
 Q0ISAwcjaWrtieL/X+j49kbx+a9Mciddph7jtA+EoqZ4ty7R8b3XN+xaR1llDoFloh6HN8
 IMx+2juLjwFSEC7fv4PIoxpqnfSfbMc=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-65-xYxz1MWhNaiNUzSPpw65Pg-1; Fri, 06 Oct 2023 07:37:01 -0400
X-MC-Unique: xYxz1MWhNaiNUzSPpw65Pg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com
 [10.11.54.8])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id C53C529A9D43;
 Fri,  6 Oct 2023 11:37:00 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.25])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id A1367C15BB8;
 Fri,  6 Oct 2023 11:37:00 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 9A54421E6888; Fri,  6 Oct 2023 13:36:57 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: stefanha@redhat.com,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Stefan Berger <stefanb@linux.ibm.com>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 24/32] sysemu/tpm: Clean up global variable shadowing
Date: Fri,  6 Oct 2023 13:36:49 +0200
Message-ID: <20231006113657.3803180-25-armbru@redhat.com>
In-Reply-To: <20231006113657.3803180-1-armbru@redhat.com>
References: <20231006113657.3803180-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.8
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

  softmmu/tpm.c:178:59: error: declaration shadows a variable in the global scope [-Werror,-Wshadow]
  int tpm_config_parse(QemuOptsList *opts_list, const char *optarg)
                                                            ^
  /Library/Developer/CommandLineTools/SDKs/MacOSX.sdk/usr/include/getopt.h:77:14: note: previous declaration is here
  extern char *optarg;                    /* getopt(3) external variables */
               ^

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-ID: <20231004120019.93101-16-philmd@linaro.org>
Reviewed-by: Stefan Berger <stefanb@linux.ibm.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 include/sysemu/tpm.h | 2 +-
 softmmu/tpm.c        | 6 +++---
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/include/sysemu/tpm.h b/include/sysemu/tpm.h
index 66e3b45f30..1ee568b3b6 100644
--- a/include/sysemu/tpm.h
+++ b/include/sysemu/tpm.h
@@ -17,7 +17,7 @@
 
 #ifdef CONFIG_TPM
 
-int tpm_config_parse(QemuOptsList *opts_list, const char *optarg);
+int tpm_config_parse(QemuOptsList *opts_list, const char *optstr);
 int tpm_init(void);
 void tpm_cleanup(void);
 
diff --git a/softmmu/tpm.c b/softmmu/tpm.c
index 578563f05a..7164ea7ff1 100644
--- a/softmmu/tpm.c
+++ b/softmmu/tpm.c
@@ -175,15 +175,15 @@ int tpm_init(void)
  * Parse the TPM configuration options.
  * To display all available TPM backends the user may use '-tpmdev help'
  */
-int tpm_config_parse(QemuOptsList *opts_list, const char *optarg)
+int tpm_config_parse(QemuOptsList *opts_list, const char *optstr)
 {
     QemuOpts *opts;
 
-    if (!strcmp(optarg, "help")) {
+    if (!strcmp(optstr, "help")) {
         tpm_display_backend_drivers();
         return -1;
     }
-    opts = qemu_opts_parse_noisily(opts_list, optarg, true);
+    opts = qemu_opts_parse_noisily(opts_list, optstr, true);
     if (!opts) {
         return -1;
     }
-- 
2.41.0



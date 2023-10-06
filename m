Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D4CE67BB6C1
	for <lists+qemu-devel@lfdr.de>; Fri,  6 Oct 2023 13:43:04 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qoj9K-00058t-34; Fri, 06 Oct 2023 07:37:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1qoj8t-00050m-L4
 for qemu-devel@nongnu.org; Fri, 06 Oct 2023 07:37:16 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1qoj8n-00006c-Qe
 for qemu-devel@nongnu.org; Fri, 06 Oct 2023 07:37:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1696592221;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=vTFZ5zkFumeXfVmSRYWZ6swj3UJExKk1gLMUiBKRj5c=;
 b=CWqHrtiBKg3BH7U3PMaVymAfxhJiWTQSOZAuQkkbuNX4fDLnTkyIVtgM0tka8joOZM0qCf
 D0YJ1lZdXXN/EJKT9dlEYerZpoXx+CKEXcv5MRH5jpj26wRRck69HzRbgPK14EWcsNm4Jp
 q2paNixAP6ZS3ppmQBZnqzh/DpECHSU=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-112-7y0ZQEt4PTCO7y5uW97s0Q-1; Fri, 06 Oct 2023 07:37:00 -0400
X-MC-Unique: 7y0ZQEt4PTCO7y5uW97s0Q-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
 [10.11.54.3])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id C63C281D781;
 Fri,  6 Oct 2023 11:36:59 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.25])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id A54EC1054FC1;
 Fri,  6 Oct 2023 11:36:59 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 77A6121E6915; Fri,  6 Oct 2023 13:36:57 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: stefanha@redhat.com,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Thomas Huth <thuth@redhat.com>
Subject: [PULL 12/32] net/net: Clean up global variable shadowing
Date: Fri,  6 Oct 2023 13:36:37 +0200
Message-ID: <20231006113657.3803180-13-armbru@redhat.com>
In-Reply-To: <20231006113657.3803180-1-armbru@redhat.com>
References: <20231006113657.3803180-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.3
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

  net/net.c:1680:35: error: declaration shadows a variable in the global scope [-Werror,-Wshadow]
  bool netdev_is_modern(const char *optarg)
                                    ^
  net/net.c:1714:38: error: declaration shadows a variable in the global scope [-Werror,-Wshadow]
  void netdev_parse_modern(const char *optarg)
                                       ^
  net/net.c:1728:60: error: declaration shadows a variable in the global scope [-Werror,-Wshadow]
  void net_client_parse(QemuOptsList *opts_list, const char *optarg)
                                                             ^
  /Library/Developer/CommandLineTools/SDKs/MacOSX.sdk/usr/include/getopt.h:77:14: note: previous declaration is here
  extern char *optarg;                    /* getopt(3) external variables */
               ^

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-ID: <20231004120019.93101-4-philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 include/net/net.h |  6 +++---
 net/net.c         | 14 +++++++-------
 2 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/include/net/net.h b/include/net/net.h
index 330d285930..2fb1c9181c 100644
--- a/include/net/net.h
+++ b/include/net/net.h
@@ -247,9 +247,9 @@ extern const char *host_net_devices[];
 
 /* from net.c */
 extern NetClientStateList net_clients;
-bool netdev_is_modern(const char *optarg);
-void netdev_parse_modern(const char *optarg);
-void net_client_parse(QemuOptsList *opts_list, const char *str);
+bool netdev_is_modern(const char *optstr);
+void netdev_parse_modern(const char *optstr);
+void net_client_parse(QemuOptsList *opts_list, const char *optstr);
 void show_netdevs(void);
 void net_init_clients(void);
 void net_check_clients(void);
diff --git a/net/net.c b/net/net.c
index 1c0bfdaa6c..c0c0cbe99e 100644
--- a/net/net.c
+++ b/net/net.c
@@ -1677,7 +1677,7 @@ void net_init_clients(void)
  * Modern syntax is to be parsed with netdev_parse_modern().
  * Traditional syntax is to be parsed with net_client_parse().
  */
-bool netdev_is_modern(const char *optarg)
+bool netdev_is_modern(const char *optstr)
 {
     QemuOpts *opts;
     bool is_modern;
@@ -1689,13 +1689,13 @@ bool netdev_is_modern(const char *optarg)
         .desc = { { } },
     };
 
-    if (optarg[0] == '{') {
+    if (optstr[0] == '{') {
         /* This is JSON, which means it's modern syntax */
         return true;
     }
 
     opts = qemu_opts_create(&dummy_opts, NULL, false, &error_abort);
-    qemu_opts_do_parse(opts, optarg, dummy_opts.implied_opt_name,
+    qemu_opts_do_parse(opts, optstr, dummy_opts.implied_opt_name,
                        &error_abort);
     type = qemu_opt_get(opts, "type");
     is_modern = !g_strcmp0(type, "stream") || !g_strcmp0(type, "dgram");
@@ -1711,12 +1711,12 @@ bool netdev_is_modern(const char *optarg)
  * netdev_parse_modern() appends to @nd_queue, whereas net_client_parse()
  * appends to @qemu_netdev_opts.
  */
-void netdev_parse_modern(const char *optarg)
+void netdev_parse_modern(const char *optstr)
 {
     Visitor *v;
     NetdevQueueEntry *nd;
 
-    v = qobject_input_visitor_new_str(optarg, "type", &error_fatal);
+    v = qobject_input_visitor_new_str(optstr, "type", &error_fatal);
     nd = g_new(NetdevQueueEntry, 1);
     visit_type_Netdev(v, NULL, &nd->nd, &error_fatal);
     visit_free(v);
@@ -1725,9 +1725,9 @@ void netdev_parse_modern(const char *optarg)
     QSIMPLEQ_INSERT_TAIL(&nd_queue, nd, entry);
 }
 
-void net_client_parse(QemuOptsList *opts_list, const char *optarg)
+void net_client_parse(QemuOptsList *opts_list, const char *optstr)
 {
-    if (!qemu_opts_parse_noisily(opts_list, optarg, true)) {
+    if (!qemu_opts_parse_noisily(opts_list, optstr, true)) {
         exit(1);
     }
 }
-- 
2.41.0



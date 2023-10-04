Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A6C67B7EA9
	for <lists+qemu-devel@lfdr.de>; Wed,  4 Oct 2023 14:06:49 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qo0b4-0002RF-U6; Wed, 04 Oct 2023 08:03:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qo0YY-0008UT-Bp
 for qemu-devel@nongnu.org; Wed, 04 Oct 2023 08:00:51 -0400
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qo0YU-0000yE-Rc
 for qemu-devel@nongnu.org; Wed, 04 Oct 2023 08:00:44 -0400
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-406618d0991so19638665e9.2
 for <qemu-devel@nongnu.org>; Wed, 04 Oct 2023 05:00:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1696420841; x=1697025641; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KXIlmQvg0u+x76lQsbY8y6+C0hwUwSmaUkTgJ1Odfb4=;
 b=AF7y+p99+WGEvLf8n4F/yA3Zlbuyy7lkmnV/AhzHjNlaNXncO7Kx1nV88DnsynhAU3
 Z/2KroKdd7DqqRjOYOJowRyzlnT9pmFqcJ2832QKaI0iWWASh5tV4sJmczGOwKPJErSd
 V7LaHbsWMu+XaXxjGflppYjFjRQt5i7zvWqGIikZ315LNF+87h020cFqe4lI9fOnM+K/
 vQC3LJYB3XW46ijrg5LhBaslD4uxOAh9Mx45KDhmJwLBgzRzO9WzQ2Fi8bJWyUvNQsk6
 t7/VvSYuyuteY51luE+8f4e8u27oo+rhQocKP7hMCgHPQCUoXSIxIIqOvYbFWHd4NCAy
 2phA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696420841; x=1697025641;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=KXIlmQvg0u+x76lQsbY8y6+C0hwUwSmaUkTgJ1Odfb4=;
 b=RPxe9Zw3H2ivHwctvWOYHy1GcM3/IddpN6yrDLlJDh9Wp2CYTxK4NWyHYT7rgF0kKw
 rjl0zytVWXUkJ/adeyd7iMzdGqL2VSTyp++alSZN5m07aR+XSTi/aPpYoIVvvvzyDZ5Y
 ptjJFJoSJtRvXJ/HWJeOV+33T31hDcGM1k6WwHQTu0M3puMH8aT7bqDAVU2dGi2WjMWC
 EM0/7vIChaGoz93ZPw/F9zqRJwtYjJpAMJkwHontIveSXBFlTdHIKrx9iu/bq83SHXpL
 ik3x+TaJb10zS+Rlb7nwpahN82He9zSsgO7JSO2GegzIPYWpxzZu9lJXsZ7bIvrQdkMQ
 SOQw==
X-Gm-Message-State: AOJu0YzpZfeHGoj9cQjAdV89NlqvReu0FQruW9Y24FKjhTzDAc17Kxl5
 uJCgjnHs3FWdXOjI9UgwkcWc1/2bW8r4UqFOZxU=
X-Google-Smtp-Source: AGHT+IFNsc7RsFs0TW5sl9wYMTIux5+BkB0+d+QXbZoiiJaxpx7mFfddqeIAAfoCI2gQIbzuvMpbsw==
X-Received: by 2002:a7b:ce89:0:b0:402:f07c:4b48 with SMTP id
 q9-20020a7bce89000000b00402f07c4b48mr2067131wmj.28.1696420841055; 
 Wed, 04 Oct 2023 05:00:41 -0700 (PDT)
Received: from m1x-phil.lan (5ep85-h01-176-173-163-52.dslam.bbox.fr.
 [176.173.163.52]) by smtp.gmail.com with ESMTPSA id
 12-20020a05600c020c00b004063ea92492sm1347676wmi.22.2023.10.04.05.00.39
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 04 Oct 2023 05:00:40 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Markus Armbruster <armbru@redhat.com>,
 Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Jason Wang <jasowang@redhat.com>
Subject: [PATCH v3 03/16] net/net: Clean up global variable shadowing
Date: Wed,  4 Oct 2023 14:00:06 +0200
Message-ID: <20231004120019.93101-4-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231004120019.93101-1-philmd@linaro.org>
References: <20231004120019.93101-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x332.google.com
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



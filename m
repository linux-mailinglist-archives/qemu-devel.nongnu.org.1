Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E339374D785
	for <lists+qemu-devel@lfdr.de>; Mon, 10 Jul 2023 15:29:36 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qIqwF-0005ML-MO; Mon, 10 Jul 2023 09:28:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kkostiuk@redhat.com>)
 id 1qIqwD-0005Ll-91
 for qemu-devel@nongnu.org; Mon, 10 Jul 2023 09:28:25 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kkostiuk@redhat.com>)
 id 1qIqw8-00076G-1F
 for qemu-devel@nongnu.org; Mon, 10 Jul 2023 09:28:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1688995699;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/veKKiVwssPNKBIeGpDmzoDrfhcWbdraUClADXTMPL4=;
 b=Jw8GUB3hqRE4zMNHNtieARQgxx6ShQuJBqbhMDIycP5X9QDg4O/cjtHF5jfAIzd/6yc4c3
 lLyxUIOdDEuibecdFYEG+H9nLSkTazN82knbqIr3xXQzDbGCAnwsW2AuGHcwkEVgU9lbGO
 vRVa6oEk/XlqEP9XMoIq8pZbguXuwzA=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-55-I8M3env6N665norTbusmwg-1; Mon, 10 Jul 2023 09:28:15 -0400
X-MC-Unique: I8M3env6N665norTbusmwg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
 [10.11.54.3])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 6DD4F8F80E8;
 Mon, 10 Jul 2023 13:28:15 +0000 (UTC)
Received: from kostyanf14nb.redhat.com (unknown [10.45.225.233])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 6A63E111E3E4;
 Mon, 10 Jul 2023 13:28:14 +0000 (UTC)
From: Konstantin Kostiuk <kkostiuk@redhat.com>
To: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 1/7] qga: Rename ga_disable_not_allowed ->
 ga_disable_not_allowed_freeze
Date: Mon, 10 Jul 2023 16:28:04 +0300
Message-Id: <20230710132810.1049912-2-kkostiuk@redhat.com>
In-Reply-To: <20230710132810.1049912-1-kkostiuk@redhat.com>
References: <20230710132810.1049912-1-kkostiuk@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.3
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kkostiuk@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, T_SCC_BODY_TEXT_LINE=-0.01,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Signed-off-by: Konstantin Kostiuk <kkostiuk@redhat.com>
---
 qga/main.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/qga/main.c b/qga/main.c
index 2b992a55b3..121ff7a748 100644
--- a/qga/main.c
+++ b/qga/main.c
@@ -395,7 +395,7 @@ static gint ga_strcmp(gconstpointer str1, gconstpointer str2)
 }
 
 /* disable commands that aren't safe for fsfreeze */
-static void ga_disable_not_allowed(const QmpCommand *cmd, void *opaque)
+static void ga_disable_not_allowed_freeze(const QmpCommand *cmd, void *opaque)
 {
     bool allowed = false;
     int i = 0;
@@ -459,7 +459,7 @@ void ga_set_frozen(GAState *s)
         return;
     }
     /* disable all forbidden (for frozen state) commands */
-    qmp_for_each_command(&ga_commands, ga_disable_not_allowed, NULL);
+    qmp_for_each_command(&ga_commands, ga_disable_not_allowed_freeze, NULL);
     g_warning("disabling logging due to filesystem freeze");
     ga_disable_logging(s);
     s->frozen = true;
@@ -1350,7 +1350,7 @@ static GAState *initialize_agent(GAConfig *config, int socket_activation)
             s->deferred_options.log_filepath = config->log_filepath;
         }
         ga_disable_logging(s);
-        qmp_for_each_command(&ga_commands, ga_disable_not_allowed, NULL);
+        qmp_for_each_command(&ga_commands, ga_disable_not_allowed_freeze, NULL);
     } else {
         if (config->daemonize) {
             become_daemon(config->pid_filepath);
-- 
2.34.1



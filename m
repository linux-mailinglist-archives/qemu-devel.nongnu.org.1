Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 970A7939B52
	for <lists+qemu-devel@lfdr.de>; Tue, 23 Jul 2024 09:04:40 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sW9Yq-0007fq-R0; Tue, 23 Jul 2024 03:03:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kkostiuk@redhat.com>)
 id 1sW9Yk-0007DO-Tj
 for qemu-devel@nongnu.org; Tue, 23 Jul 2024 03:03:42 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kkostiuk@redhat.com>)
 id 1sW9Yj-0000ua-5L
 for qemu-devel@nongnu.org; Tue, 23 Jul 2024 03:03:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1721718220;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=9dy1ZmMlwU9LUuKQB553ig1xA979EJ9zAJ4Cv30rbKY=;
 b=E2+GSQKUQxkGoWY17XF/Cbs09XwD9pNbVXuCuhkFNFtuPU58nfcEE1y1e3ySTPDyiAdlP5
 y7TeSwNfviV/UTYsd8pbYSr5v4PIRsLpm40LqsgaIu1wP31Cc6wAvyeysNaHnJ/YElSR50
 2XbqaaM06P0mqMuQouK2ELM0lqD6cbs=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-690-Lb-sjQAwMZ-QwlXPb0m5qA-1; Tue,
 23 Jul 2024 03:03:36 -0400
X-MC-Unique: Lb-sjQAwMZ-QwlXPb0m5qA-1
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 698D91956064; Tue, 23 Jul 2024 07:03:35 +0000 (UTC)
Received: from srv1.redhat.com (unknown [10.45.224.211])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 0D17B3000192; Tue, 23 Jul 2024 07:03:33 +0000 (UTC)
From: Konstantin Kostiuk <kkostiuk@redhat.com>
To: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Stefan Hajnoczi <stefanha@redhat.com>
Subject: [PULL v2 20/25] qga: remove pointless 'blockrpcs_key' variable
Date: Tue, 23 Jul 2024 10:02:46 +0300
Message-ID: <20240723070251.25575-21-kkostiuk@redhat.com>
In-Reply-To: <20240723070251.25575-1-kkostiuk@redhat.com>
References: <20240723070251.25575-1-kkostiuk@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kkostiuk@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.133,
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

From: Daniel P. Berrangé <berrange@redhat.com>

This variable was used to support back compat for the old config
file key name, and became redundant after the following change:

  commit a7a2d636ae4549ef0551134d4bf8e084a14431c4
  Author: Philippe Mathieu-Daudé <philmd@linaro.org>
  Date:   Thu May 30 08:36:43 2024 +0200

    qga: Remove deprecated 'blacklist' argument / config key

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Konstantin Kostiuk <kkostiuk@redhat.com>
Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
Message-ID: <20240712132459.3974109-21-berrange@redhat.com>
Signed-off-by: Konstantin Kostiuk <kkostiuk@redhat.com>
---
 qga/main.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/qga/main.c b/qga/main.c
index 647d27037c..6ff022a85d 100644
--- a/qga/main.c
+++ b/qga/main.c
@@ -1023,7 +1023,6 @@ static void config_load(GAConfig *config)
     GError *gerr = NULL;
     GKeyFile *keyfile;
     g_autofree char *conf = g_strdup(g_getenv("QGA_CONF")) ?: get_relocated_path(QGA_CONF_DEFAULT);
-    const gchar *blockrpcs_key = "block-rpcs";
 
     /* read system config */
     keyfile = g_key_file_new();
@@ -1071,9 +1070,9 @@ static void config_load(GAConfig *config)
             g_key_file_get_boolean(keyfile, "general", "retry-path", &gerr);
     }
 
-    if (g_key_file_has_key(keyfile, "general", blockrpcs_key, NULL)) {
+    if (g_key_file_has_key(keyfile, "general", "block-rpcs", NULL)) {
         config->bliststr =
-            g_key_file_get_string(keyfile, "general", blockrpcs_key, &gerr);
+            g_key_file_get_string(keyfile, "general", "block-rpcs", &gerr);
         config->blockedrpcs = g_list_concat(config->blockedrpcs,
                                           split_list(config->bliststr, ","));
     }
@@ -1084,7 +1083,7 @@ static void config_load(GAConfig *config)
                                           split_list(config->aliststr, ","));
     }
 
-    if (g_key_file_has_key(keyfile, "general", blockrpcs_key, NULL) &&
+    if (g_key_file_has_key(keyfile, "general", "block-rpcs", NULL) &&
         g_key_file_has_key(keyfile, "general", "allow-rpcs", NULL)) {
         g_critical("wrong config, using 'block-rpcs' and 'allow-rpcs' keys at"
                    " the same time is not allowed");
-- 
2.45.2



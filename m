Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D544907759
	for <lists+qemu-devel@lfdr.de>; Thu, 13 Jun 2024 17:47:11 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sHmeN-000764-5v; Thu, 13 Jun 2024 11:46:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1sHmdR-00066x-3O
 for qemu-devel@nongnu.org; Thu, 13 Jun 2024 11:45:10 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1sHmdN-0003rz-J7
 for qemu-devel@nongnu.org; Thu, 13 Jun 2024 11:45:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1718293504;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Q3do3U9CQbBYDTQGdhkUGaiRep+ZnUVo7X6CZ7OAb8s=;
 b=UrCGzev9guVAfvkJb0hzHODPLJ3fIQ/Ygc/3AQUFzKkEvtBRvvELVmPf3Ns1TUuJDPyTNT
 ky1pb6NHz5mO4UkZhfwMYzxOmxglNESEdN7C/mVkS7jUkY9ORStfPuTRg4Q+jF7rTfe0FJ
 Rsj4L1O1q8Z/7wGgrqUCrYPAExzyLtY=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-619-2HE3Rdr2PIqJW8-8DgSdDw-1; Thu,
 13 Jun 2024 11:45:00 -0400
X-MC-Unique: 2HE3Rdr2PIqJW8-8DgSdDw-1
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id BEC7D19560B1; Thu, 13 Jun 2024 15:44:59 +0000 (UTC)
Received: from toolbox.redhat.com (unknown [10.42.28.52])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id C167F3000220; Thu, 13 Jun 2024 15:44:56 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Konstantin Kostiuk <kkostiuk@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Michael Roth <michael.roth@amd.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH v2 20/22] qga: remove pointless 'blockrpcs_key' variable
Date: Thu, 13 Jun 2024 16:44:04 +0100
Message-ID: <20240613154406.1365469-15-berrange@redhat.com>
In-Reply-To: <20240613154406.1365469-1-berrange@redhat.com>
References: <20240613150127.1361931-1-berrange@redhat.com>
 <20240613154406.1365469-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 11
X-Spam_score: 1.1
X-Spam_bar: +
X-Spam_report: (1.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.145,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

This variable was used to support back compat for the old config
file key name, and became redundant after the following change:

  commit a7a2d636ae4549ef0551134d4bf8e084a14431c4
  Author: Philippe Mathieu-Daudé <philmd@linaro.org>
  Date:   Thu May 30 08:36:43 2024 +0200

    qga: Remove deprecated 'blacklist' argument / config key

Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
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
2.45.1



Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8723590774C
	for <lists+qemu-devel@lfdr.de>; Thu, 13 Jun 2024 17:46:22 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sHmds-00069b-Bz; Thu, 13 Jun 2024 11:45:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1sHmd6-0005do-Jq
 for qemu-devel@nongnu.org; Thu, 13 Jun 2024 11:44:49 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1sHmd4-0003dA-2f
 for qemu-devel@nongnu.org; Thu, 13 Jun 2024 11:44:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1718293484;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1dZjJ0743d+ZQnxLx1gmRHStqGaLqnM/Ir57dgMT7RY=;
 b=QytLVwHaJjZVG0eIprtmeF4TxtIC0kl+AS9gajmowh5MiTFsK0bvPOUdgRGlH4Mg/l4BXm
 x8j7LLnW2buviGJAznfwIwDd+vtOKnrh4HT8WR1apP9XMi8ppUiCT2ccsjkMHtYUEf4rIC
 iDQEXAEVyMmFwzvittdjsumcA3RDjHY=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-395-b6DEXLUQMX2qqP9XhhCOQA-1; Thu,
 13 Jun 2024 11:44:41 -0400
X-MC-Unique: b6DEXLUQMX2qqP9XhhCOQA-1
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 6143319560B5; Thu, 13 Jun 2024 15:44:40 +0000 (UTC)
Received: from toolbox.redhat.com (unknown [10.42.28.52])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id D211C3000225; Thu, 13 Jun 2024 15:44:37 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Konstantin Kostiuk <kkostiuk@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Michael Roth <michael.roth@amd.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH v2 14/22] qga: conditionalize schema for commands requiring
 fstrim
Date: Thu, 13 Jun 2024 16:43:58 +0100
Message-ID: <20240613154406.1365469-9-berrange@redhat.com>
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

Rather than creating stubs for every command that just return
QERR_UNSUPPORTED, use 'if' conditions in the QAPI schema to
fully exclude generation of the filesystem trimming commands
on POSIX platforms lacking required APIs.

The command will be rejected at QMP dispatch time instead,
avoiding reimplementing rejection by blocking the stub commands.
This changes the error message for affected commands from

    {"class": "CommandNotFound", "desc": "Command FOO has been disabled"}

to

    {"class": "CommandNotFound", "desc": "The command FOO has not been found"}

This has the additional benefit that the QGA protocol reference
now documents what conditions enable use of the command.

Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
---
 qga/commands-posix.c | 13 -------------
 qga/qapi-schema.json |  9 ++++++---
 2 files changed, 6 insertions(+), 16 deletions(-)

diff --git a/qga/commands-posix.c b/qga/commands-posix.c
index 9207cb7a8f..d92fa0ec87 100644
--- a/qga/commands-posix.c
+++ b/qga/commands-posix.c
@@ -1144,22 +1144,9 @@ error:
 
 #endif /* HAVE_GETIFADDRS */
 
-#if !defined(CONFIG_FSTRIM)
-GuestFilesystemTrimResponse *
-qmp_guest_fstrim(bool has_minimum, int64_t minimum, Error **errp)
-{
-    error_setg(errp, QERR_UNSUPPORTED);
-    return NULL;
-}
-#endif
-
 /* add unsupported commands to the list of blocked RPCs */
 GList *ga_command_init_blockedrpcs(GList *blockedrpcs)
 {
-#if !defined(CONFIG_FSTRIM)
-    blockedrpcs = g_list_append(blockedrpcs, g_strdup("guest-fstrim"));
-#endif
-
     return blockedrpcs;
 }
 
diff --git a/qga/qapi-schema.json b/qga/qapi-schema.json
index 098fa7a08b..0f27375ea0 100644
--- a/qga/qapi-schema.json
+++ b/qga/qapi-schema.json
@@ -509,7 +509,8 @@
 ##
 { 'struct': 'GuestFilesystemTrimResult',
   'data': {'path': 'str',
-           '*trimmed': 'int', '*minimum': 'int', '*error': 'str'} }
+           '*trimmed': 'int', '*minimum': 'int', '*error': 'str'},
+  'if': { 'any': ['CONFIG_WIN32', 'CONFIG_FSTRIM'] } }
 
 ##
 # @GuestFilesystemTrimResponse:
@@ -519,7 +520,8 @@
 # Since: 2.4
 ##
 { 'struct': 'GuestFilesystemTrimResponse',
-  'data': {'paths': ['GuestFilesystemTrimResult']} }
+  'data': {'paths': ['GuestFilesystemTrimResult']},
+  'if': { 'any': ['CONFIG_WIN32', 'CONFIG_FSTRIM'] } }
 
 ##
 # @guest-fstrim:
@@ -541,7 +543,8 @@
 ##
 { 'command': 'guest-fstrim',
   'data': { '*minimum': 'int' },
-  'returns': 'GuestFilesystemTrimResponse' }
+  'returns': 'GuestFilesystemTrimResponse',
+  'if': { 'any': ['CONFIG_WIN32', 'CONFIG_FSTRIM'] } }
 
 ##
 # @guest-suspend-disk:
-- 
2.45.1



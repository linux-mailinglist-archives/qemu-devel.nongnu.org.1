Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CB3092FB53
	for <lists+qemu-devel@lfdr.de>; Fri, 12 Jul 2024 15:27:27 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sSGIA-0006vT-DP; Fri, 12 Jul 2024 09:26:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1sSGI0-0005uR-Jh
 for qemu-devel@nongnu.org; Fri, 12 Jul 2024 09:26:20 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1sSGHr-00047s-GV
 for qemu-devel@nongnu.org; Fri, 12 Jul 2024 09:26:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1720790769;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ir30cxELunmhB1gW2KAFyOCiF5YHCy37RVASmkAT6Ak=;
 b=XVZNZZjN+SUAAOczc3fLZwy3gtEVIhi5NkWD6+YjCNEn54vWZO6IPtAA7lueJBa4dcQSb/
 vd+aXRKJ/9LL3eIRWnYrRDe/tDT15YWo8Icmc7M4D1XYeNMYJpRCe76AKGG7SQa+vylCXf
 aJbbjGRud/08UNyVVzc1bnDz0SEOCl4=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-651-XSVsMQnwOsKufKxbbs74Mw-1; Fri,
 12 Jul 2024 09:26:04 -0400
X-MC-Unique: XSVsMQnwOsKufKxbbs74Mw-1
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 058A81955E9C; Fri, 12 Jul 2024 13:26:04 +0000 (UTC)
Received: from toolbox.redhat.com (unknown [10.42.28.56])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 2EFD01955E70; Fri, 12 Jul 2024 13:26:00 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Michael Roth <michael.roth@amd.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Konstantin Kostiuk <kkostiuk@redhat.com>
Subject: [PATCH v3 17/22] qga: conditionalize schema for commands not
 supported on other UNIX
Date: Fri, 12 Jul 2024 14:24:54 +0100
Message-ID: <20240712132459.3974109-18-berrange@redhat.com>
In-Reply-To: <20240712132459.3974109-1-berrange@redhat.com>
References: <20240712132459.3974109-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.138,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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
QERR_UNSUPPORTED, use 'if' conditions in the QAPI schema  to
fully exclude generation of the commands on other UNIX.

The command will be rejected at QMP dispatch time instead,
avoiding reimplementing rejection by blocking the stub commands.
This changes the error message for affected commands from

    {"class": "CommandNotFound", "desc": "Command FOO has been disabled"}

to

    {"class": "CommandNotFound", "desc": "The command FOO has not been found"}

This has the additional benefit that the QGA protocol reference
now documents what conditions enable use of the command.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Konstantin Kostiuk <kkostiuk@redhat.com>
Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
---
 meson.build          | 1 +
 qga/commands-posix.c | 8 --------
 qga/qapi-schema.json | 3 ++-
 3 files changed, 3 insertions(+), 9 deletions(-)

diff --git a/meson.build b/meson.build
index 3f125d1b02..efc47612a3 100644
--- a/meson.build
+++ b/meson.build
@@ -2275,6 +2275,7 @@ config_host_data.set('CONFIG_ATTR', libattr.found())
 config_host_data.set('CONFIG_BDRV_WHITELIST_TOOLS', get_option('block_drv_whitelist_in_tools'))
 config_host_data.set('CONFIG_BRLAPI', brlapi.found())
 config_host_data.set('CONFIG_BSD', host_os in bsd_oses)
+config_host_data.set('CONFIG_FREEBSD', host_os == 'freebsd')
 config_host_data.set('CONFIG_CAPSTONE', capstone.found())
 config_host_data.set('CONFIG_COCOA', cocoa.found())
 config_host_data.set('CONFIG_DARWIN', host_os == 'darwin')
diff --git a/qga/commands-posix.c b/qga/commands-posix.c
index a353f64ae6..f4104f2760 100644
--- a/qga/commands-posix.c
+++ b/qga/commands-posix.c
@@ -877,14 +877,6 @@ void qmp_guest_set_user_password(const char *username,
         return;
     }
 }
-#else /* __linux__ || __FreeBSD__ */
-void qmp_guest_set_user_password(const char *username,
-                                 const char *password,
-                                 bool crypted,
-                                 Error **errp)
-{
-    error_setg(errp, QERR_UNSUPPORTED);
-}
 #endif /* __linux__ || __FreeBSD__ */
 
 #ifdef HAVE_GETIFADDRS
diff --git a/qga/qapi-schema.json b/qga/qapi-schema.json
index 0662a68c43..c763163fcd 100644
--- a/qga/qapi-schema.json
+++ b/qga/qapi-schema.json
@@ -1109,7 +1109,8 @@
 # Since: 2.3
 ##
 { 'command': 'guest-set-user-password',
-  'data': { 'username': 'str', 'password': 'str', 'crypted': 'bool' } }
+  'data': { 'username': 'str', 'password': 'str', 'crypted': 'bool' },
+  'if': { 'any': [ 'CONFIG_WIN32', 'CONFIG_LINUX', 'CONFIG_FREEBSD'] } }
 
 ##
 # @GuestMemoryBlock:
-- 
2.45.1



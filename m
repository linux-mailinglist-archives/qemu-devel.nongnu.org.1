Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 48AC58FB76D
	for <lists+qemu-devel@lfdr.de>; Tue,  4 Jun 2024 17:33:58 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sEWA1-0006pl-IJ; Tue, 04 Jun 2024 11:33:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1sEW9q-0006mP-Lk
 for qemu-devel@nongnu.org; Tue, 04 Jun 2024 11:33:06 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1sEW9p-0001KH-73
 for qemu-devel@nongnu.org; Tue, 04 Jun 2024 11:33:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1717515184;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=S2ZZ7ZPJISnpZt1cwBtV7RhIp0sWJo7jom/X++Viyag=;
 b=DOvLRWOqX6wfneygX0pQDDLVqI4UxNUztbLNoOcxHin9eQoxAgdhx1xEGnizdkpR6oiL/9
 dbENVG8PV2oA8RxVa/QKZQqTg0tHxafUYtUDWuyvKNTCtk3k1EUpgkucZDe0BslZFDKxq+
 Hu3Gy3Q+wmojKn1EBYh4us1z9wxVCHU=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-282-rBMWqbGVNFGQKktsmt72QQ-1; Tue, 04 Jun 2024 11:33:00 -0400
X-MC-Unique: rBMWqbGVNFGQKktsmt72QQ-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com
 [10.11.54.9])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 049AD185B920;
 Tue,  4 Jun 2024 15:33:00 +0000 (UTC)
Received: from toolbox.redhat.com (unknown [10.39.194.137])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 30A18492BD6;
 Tue,  4 Jun 2024 15:32:59 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>, Michael Roth <michael.roth@amd.com>,
 Konstantin Kostiuk <kkostiuk@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH 14/14] qga: mark guest-ssh-* / guest-*-password commands with
 'unrestricted' flag
Date: Tue,  4 Jun 2024 16:32:42 +0100
Message-ID: <20240604153242.251334-15-berrange@redhat.com>
In-Reply-To: <20240604153242.251334-1-berrange@redhat.com>
References: <20240604153242.251334-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.9
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

This blocks use of all the 'guest-ssh-*' / 'guest-password' commands
unless the QGA is runwith the --unrestricted command line argument.

These commands allow the host admin to takeover user accounts and so
directly compromise the guest OS.

Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
---
 qga/qapi-schema.json | 26 +++++++++++++++++++++++---
 1 file changed, 23 insertions(+), 3 deletions(-)

diff --git a/qga/qapi-schema.json b/qga/qapi-schema.json
index 25068b8110..e7ce80a479 100644
--- a/qga/qapi-schema.json
+++ b/qga/qapi-schema.json
@@ -1251,10 +1251,15 @@
 # transmission, even if already crypt()d, to ensure it is 8-bit safe
 # when passed as JSON.
 #
+# Features:
+#
+# @user-auth: not permitted if agent is limiting user auth
+#
 # Since: 2.3
 ##
 { 'command': 'guest-set-user-password',
   'data': { 'username': 'str', 'password': 'str', 'crypted': 'bool' },
+  'features': [ 'user-auth' ],
   'if': { 'any': [ 'CONFIG_WIN32', 'CONFIG_LINUX', 'CONFIG_FREEBSD'] } }
 
 ##
@@ -1810,11 +1815,16 @@
 #
 # Returns: @GuestAuthorizedKeys
 #
+# Features:
+#
+# @user-auth: not permitted if agent is limiting user auth
+#
 # Since: 5.2
 ##
 { 'command': 'guest-ssh-get-authorized-keys',
   'data': { 'username': 'str' },
-  'returns': 'GuestAuthorizedKeys'
+  'returns': 'GuestAuthorizedKeys',
+  'features': [ 'user-auth' ]
 }
 
 ##
@@ -1830,10 +1840,15 @@
 #
 # @reset: ignore the existing content, set it with the given keys only
 #
+# Features:
+#
+# @user-auth: not permitted if agent is limiting user auth
+#
 # Since: 5.2
 ##
 { 'command': 'guest-ssh-add-authorized-keys',
-  'data': { 'username': 'str', 'keys': ['str'], '*reset': 'bool' }
+  'data': { 'username': 'str', 'keys': ['str'], '*reset': 'bool' },
+  'features': [ 'user-auth' ]
 }
 
 ##
@@ -1848,10 +1863,15 @@
 # @keys: the public keys to remove (in OpenSSH/sshd(8) authorized_keys
 #     format)
 #
+# Features:
+#
+# @user-auth: not permitted if agent is limiting user auth
+#
 # Since: 5.2
 ##
 { 'command': 'guest-ssh-remove-authorized-keys',
-  'data': { 'username': 'str', 'keys': ['str'] }
+  'data': { 'username': 'str', 'keys': ['str'] },
+  'features': [ 'user-auth' ]
 }
 
 ##
-- 
2.45.1



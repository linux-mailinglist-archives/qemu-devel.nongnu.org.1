Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5510488BB54
	for <lists+qemu-devel@lfdr.de>; Tue, 26 Mar 2024 08:35:37 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rp1KO-0004dj-DB; Tue, 26 Mar 2024 03:34:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1rp1KN-0004dF-5i
 for qemu-devel@nongnu.org; Tue, 26 Mar 2024 03:34:35 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1rp1KL-0005M4-Mp
 for qemu-devel@nongnu.org; Tue, 26 Mar 2024 03:34:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1711438472;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=iuGkQGkyFj2QDIch/2My5hoMmnwzhahHNG8vINpesiM=;
 b=dxBEGFeZ+mBTLCsnMjpVFJRG+cIm5E9dg5HDTTiqgoOGbXzNFiNA0Vbkz9K4vqkQ8LhWL3
 ZWp4gAb/0dxm5CfGdC3HHpz0AhrsHnSU3NhrXmG8DzoF5cWk4acaYq8ElB4oXCcXxNOFD6
 i3UHEHlGDKS8oMT62FzgKLeMLfk7cAQ=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-583-S91UnQ-kOEaURnw48Dkzsw-1; Tue,
 26 Mar 2024 03:34:31 -0400
X-MC-Unique: S91UnQ-kOEaURnw48Dkzsw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
 [10.11.54.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id B59AF1C02CA4;
 Tue, 26 Mar 2024 07:34:30 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.81])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 955E82166B31;
 Tue, 26 Mar 2024 07:34:30 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id A695821E5D31; Tue, 26 Mar 2024 08:34:20 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org
Subject: [PULL 11/20] qapi: Start sentences with a capital letter,
 end them with a period
Date: Tue, 26 Mar 2024 08:34:11 +0100
Message-ID: <20240326073420.738016-12-armbru@redhat.com>
In-Reply-To: <20240326073420.738016-1-armbru@redhat.com>
References: <20240326073420.738016-1-armbru@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.6
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.065,
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

Signed-off-by: Markus Armbruster <armbru@redhat.com>
Message-ID: <20240322140910.328840-9-armbru@redhat.com>
---
 qapi/migration.json | 16 ++++++++--------
 qapi/ui.json        |  2 +-
 2 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/qapi/migration.json b/qapi/migration.json
index a4319f87bf..8fa1b7f8ed 100644
--- a/qapi/migration.json
+++ b/qapi/migration.json
@@ -829,8 +829,8 @@
 #     and recreated on the fly while the migration server is active.
 #     If missing, it will default to denying access (Since 4.0)
 #
-# @max-bandwidth: to set maximum speed for migration.  maximum speed
-#     in bytes per second.  (Since 2.8)
+# @max-bandwidth: maximum speed for migration, in bytes per second.
+#     (Since 2.8)
 #
 # @avail-switchover-bandwidth: to set the available bandwidth that
 #     migration can use during switchover phase.  NOTE!  This does not
@@ -1036,8 +1036,8 @@
 #     and recreated on the fly while the migration server is active.
 #     If missing, it will default to denying access (Since 4.0)
 #
-# @max-bandwidth: to set maximum speed for migration.  maximum speed
-#     in bytes per second.  (Since 2.8)
+# @max-bandwidth: maximum speed for migration, in bytes per second.
+#     (Since 2.8)
 #
 # @avail-switchover-bandwidth: to set the available bandwidth that
 #     migration can use during switchover phase.  NOTE!  This does not
@@ -1267,8 +1267,8 @@
 #     control checking of the TLS x509 certificate distinguished name.
 #     (Since 4.0)
 #
-# @max-bandwidth: to set maximum speed for migration.  maximum speed
-#     in bytes per second.  (Since 2.8)
+# @max-bandwidth: maximum speed for migration, in bytes per second.
+#     (Since 2.8)
 #
 # @avail-switchover-bandwidth: to set the available bandwidth that
 #     migration can use during switchover phase.  NOTE!  This does not
@@ -1960,8 +1960,8 @@
 #
 # @primary: true for primary or false for secondary.
 #
-# @failover: true to do failover, false to stop.  but cannot be
-#     specified if 'enable' is true.  default value is false.
+# @failover: true to do failover, false to stop.  Cannot be specified
+#     if 'enable' is true.  Default value is false.
 #
 # Example:
 #
diff --git a/qapi/ui.json b/qapi/ui.json
index 5744c24e3c..e71cd2f50b 100644
--- a/qapi/ui.json
+++ b/qapi/ui.json
@@ -290,7 +290,7 @@
 # @enabled: true if the SPICE server is enabled, false otherwise
 #
 # @migrated: true if the last guest migration completed and spice
-#     migration had completed as well.  false otherwise.  (since 1.4)
+#     migration had completed as well, false otherwise (since 1.4)
 #
 # @host: The hostname the SPICE server is bound to.  This depends on
 #     the name resolution on the host and may be an IP address.
-- 
2.44.0



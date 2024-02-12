Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 56C7C850F87
	for <lists+qemu-devel@lfdr.de>; Mon, 12 Feb 2024 10:15:54 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rZSP9-0006Rf-17; Mon, 12 Feb 2024 04:15:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1rZSOl-0006MU-G0
 for qemu-devel@nongnu.org; Mon, 12 Feb 2024 04:14:47 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1rZSOh-0003dE-J3
 for qemu-devel@nongnu.org; Mon, 12 Feb 2024 04:14:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1707729283;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=nA662FSlwJ8MMJtEUYa6cafVAqng+dVMZ1XETRVtwiU=;
 b=JdgXftHgfAcS0q/jhy2rOyw4jzXK5CWjwbt+1d4DU7XBAsVcQ3nv64aiTRtC4o9pQK1pGv
 9WOGbJk7tHHEdBwxcyxWE/C+Zs87gJAYOVAa9MJViCNpZ1+mQSMk+Z0LXgdcNzjRBjYoz/
 qkjcU6OXNlVQ1jetykf7DwrgJzY34o0=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-418-QpqOXDd_OsKRrhljsammUg-1; Mon, 12 Feb 2024 04:14:39 -0500
X-MC-Unique: QpqOXDd_OsKRrhljsammUg-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com
 [10.11.54.9])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 15842831017;
 Mon, 12 Feb 2024 09:14:39 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.55])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id E674458EA82;
 Mon, 12 Feb 2024 09:14:38 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 9621C21E5A41; Mon, 12 Feb 2024 10:14:36 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PULL 11/18] qapi/dump: Clean up documentation of
 DumpGuestMemoryCapability
Date: Mon, 12 Feb 2024 10:14:29 +0100
Message-ID: <20240212091436.688598-12-armbru@redhat.com>
In-Reply-To: <20240212091436.688598-1-armbru@redhat.com>
References: <20240212091436.688598-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.9
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.677,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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

The type's doc comment describes its member, but it's not marked up as
such.  Easy enough to fix.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
Message-ID: <20240205074709.3613229-12-armbru@redhat.com>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
---
 qapi/dump.json   | 2 +-
 qapi/pragma.json | 1 -
 2 files changed, 1 insertion(+), 2 deletions(-)

diff --git a/qapi/dump.json b/qapi/dump.json
index 5cbc237ad9..1997c1d1d4 100644
--- a/qapi/dump.json
+++ b/qapi/dump.json
@@ -186,7 +186,7 @@
 ##
 # @DumpGuestMemoryCapability:
 #
-# A list of the available formats for dump-guest-memory
+# @formats: the available formats for dump-guest-memory
 #
 # Since: 2.0
 ##
diff --git a/qapi/pragma.json b/qapi/pragma.json
index 544f138afa..aea6384255 100644
--- a/qapi/pragma.json
+++ b/qapi/pragma.json
@@ -74,7 +74,6 @@
         'DummyBlockCoreForceArrays',
         'DummyForceArrays',
         'DummyVirtioForceArrays',
-        'DumpGuestMemoryCapability',
         'GrabToggleKeys',
         'GuestPanicInformationHyperV',
         'HotKeyMod',
-- 
2.43.0



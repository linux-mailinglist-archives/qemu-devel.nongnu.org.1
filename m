Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CF75988BB51
	for <lists+qemu-devel@lfdr.de>; Tue, 26 Mar 2024 08:35:36 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rp1KM-0004d3-3A; Tue, 26 Mar 2024 03:34:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1rp1KJ-0004c8-Ud
 for qemu-devel@nongnu.org; Tue, 26 Mar 2024 03:34:31 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1rp1KH-0005LA-W9
 for qemu-devel@nongnu.org; Tue, 26 Mar 2024 03:34:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1711438467;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=fvltjtMXvy1r9lw5NqzV87nAyBFhXNHyMyQgQezIens=;
 b=GSJ+8LjF4ez3ArzVXMl9v5DG3nAUqb/YsyrLuuLDA6YVHvGLFORz+QMZndl0mUrHawgpqp
 hmodOnOXa9tbWZBB5cllF8HA35y6dREH3unEBwvoYaVHlMX7LrGkHREV2ZO57VaSuuAgpA
 WAeIwGyAvQRPnR74tVQSSjnmTuvQKCY=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-213-HpZkEhnTNvO2U9YyPkhXfw-1; Tue, 26 Mar 2024 03:34:25 -0400
X-MC-Unique: HpZkEhnTNvO2U9YyPkhXfw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
 [10.11.54.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 9CE25185A786;
 Tue, 26 Mar 2024 07:34:25 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.81])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 7D1C92166B36;
 Tue, 26 Mar 2024 07:34:25 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 907AB21E64D0; Tue, 26 Mar 2024 08:34:20 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, John Snow <jsnow@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Peter Xu <peterx@redhat.com>
Subject: [PULL 03/20] qapi: Fix bogus documentation of query-migrationthreads
Date: Tue, 26 Mar 2024 08:34:03 +0100
Message-ID: <20240326073420.738016-4-armbru@redhat.com>
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

The doc comment documents an argument that doesn't exist.  Would
fail compilation if it was marked up correctly.  Delete.

The Returns: section fails to refer to the data type, leaving the user
to guess.  Fix that.

The command name violates QAPI naming rules: it should be
query-migration-threads.  Too late to fix.

Reported-by: John Snow <jsnow@redhat.com>
Fixes: 671326201dac (migration: Introduce interface query-migrationthreads)
Signed-off-by: Markus Armbruster <armbru@redhat.com>
Message-ID: <20240322135117.195489-4-armbru@redhat.com>
Reviewed-by: Fabiano Rosas <farosas@suse.de>
Reviewed-by: Peter Xu <peterx@redhat.com>
Reviewed-by: John Snow <jsnow@redhat.com>
---
 qapi/migration.json | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/qapi/migration.json b/qapi/migration.json
index 744d05f364..c865ab00c8 100644
--- a/qapi/migration.json
+++ b/qapi/migration.json
@@ -2419,9 +2419,7 @@
 #
 # Returns information of migration threads
 #
-# data: migration thread name
-#
-# Returns: information about migration threads
+# Returns: @MigrationThreadInfo
 #
 # Since: 7.2
 ##
-- 
2.44.0



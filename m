Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1227C7C4F02
	for <lists+qemu-devel@lfdr.de>; Wed, 11 Oct 2023 11:31:43 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qqVSH-0005ge-8D; Wed, 11 Oct 2023 05:24:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qqVSB-0005RI-JN
 for qemu-devel@nongnu.org; Wed, 11 Oct 2023 05:24:33 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qqVSA-0005Fc-2y
 for qemu-devel@nongnu.org; Wed, 11 Oct 2023 05:24:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697016267;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=wZBjqZkvFN/Xf9OdLer1TyrAyrSPUxIv0gmKNb+fn6g=;
 b=at8upPu95PNKo9QAikjtT+oFnNBfzsMzu/fEGZoeTYD19sGutsG93AWi8EgMNR0uPpuHdl
 Ngi4ZCKmnpovKuhYM62kHia1lKsMgz/ER6E9TAv6WDXHQlE3TOnnsB1skOs6k0VXbicFLd
 CCxnwD0z/GHs5FsiPAX17n+zShOqNqw=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-158-TNUcFpnpM-Kll8CwbWPS8A-1; Wed, 11 Oct 2023 05:24:14 -0400
X-MC-Unique: TNUcFpnpM-Kll8CwbWPS8A-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com
 [10.11.54.7])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 3CDEB185A7B2;
 Wed, 11 Oct 2023 09:24:14 +0000 (UTC)
Received: from secure.mitica (unknown [10.39.195.75])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 7EA441C060AE;
 Wed, 11 Oct 2023 09:24:12 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
To: qemu-devel@nongnu.org
Cc: Laurent Vivier <lvivier@redhat.com>, Peter Xu <peterx@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Juan Quintela <quintela@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Li Zhijian <lizhijian@fujitsu.com>, Leonardo Bras <leobras@redhat.com>,
 Eric Blake <eblake@redhat.com>, Fabiano Rosas <farosas@suse.de>
Subject: [PULL 63/65] qemufile: Always return a verbose error
Date: Wed, 11 Oct 2023 11:22:01 +0200
Message-ID: <20231011092203.1266-64-quintela@redhat.com>
In-Reply-To: <20231011092203.1266-1-quintela@redhat.com>
References: <20231011092203.1266-1-quintela@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.7
Received-SPF: pass client-ip=170.10.133.124; envelope-from=quintela@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

From: Peter Xu <peterx@redhat.com>

There're a lot of cases where we only have an errno set in last_error but
without a detailed error description.  When this happens, try to generate
an error contains the errno as a descriptive error.

This will be helpful in cases where one relies on the Error*.  E.g.,
migration state only caches Error* in MigrationState.error.  With this,
we'll display correct error messages in e.g. query-migrate when the error
was only set by qemu_file_set_error().

Reviewed-by: Fabiano Rosas <farosas@suse.de>
Reviewed-by: Juan Quintela <quintela@redhat.com>
Signed-off-by: Peter Xu <peterx@redhat.com>
Signed-off-by: Juan Quintela <quintela@redhat.com>
Message-ID: <20231004220240.167175-6-peterx@redhat.com>
---
 migration/qemu-file.c | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/migration/qemu-file.c b/migration/qemu-file.c
index 5e8207dae4..7fb659296f 100644
--- a/migration/qemu-file.c
+++ b/migration/qemu-file.c
@@ -142,15 +142,24 @@ void qemu_file_set_hooks(QEMUFile *f, const QEMUFileHooks *hooks)
  *
  * Return negative error value if there has been an error on previous
  * operations, return 0 if no error happened.
- * Optional, it returns Error* in errp, but it may be NULL even if return value
- * is not 0.
  *
+ * If errp is specified, a verbose error message will be copied over.
  */
 static int qemu_file_get_error_obj(QEMUFile *f, Error **errp)
 {
+    if (!f->last_error) {
+        return 0;
+    }
+
+    /* There is an error */
     if (errp) {
-        *errp = f->last_error_obj ? error_copy(f->last_error_obj) : NULL;
+        if (f->last_error_obj) {
+            *errp = error_copy(f->last_error_obj);
+        } else {
+            error_setg_errno(errp, -f->last_error, "Channel error");
+        }
     }
+
     return f->last_error;
 }
 
-- 
2.41.0



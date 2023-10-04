Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 21E497B7F70
	for <lists+qemu-devel@lfdr.de>; Wed,  4 Oct 2023 14:42:18 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qo1BO-0006a4-KT; Wed, 04 Oct 2023 08:40:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qo1BM-0006ZC-Rs
 for qemu-devel@nongnu.org; Wed, 04 Oct 2023 08:40:52 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qo1BK-0003Xb-4z
 for qemu-devel@nongnu.org; Wed, 04 Oct 2023 08:40:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1696423248;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=tbm2LVUduehuMKftMC588BmRqL19dP7PkBiD+arSgQs=;
 b=iGMEimm8enr1DTD5F0bi7fGTtiEHjfEM9V+LODYh3JvLPG/6ymwf+QfFQpuFVuaduVvaIp
 rdR1OAums7WE1X5VBZVfNKjmQdgiaY32kHXcD0UZE3A/Dnp980+t2JXq5UtZTGZtYcv0SC
 qGI4OyxsA/7Z4sY7islE4NTyK/YwRG4=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-57-Ud1u3PrqP--TUKGduExnxw-1; Wed, 04 Oct 2023 08:40:43 -0400
X-MC-Unique: Ud1u3PrqP--TUKGduExnxw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
 [10.11.54.4])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id C535C3C23FC3;
 Wed,  4 Oct 2023 12:40:42 +0000 (UTC)
Received: from secure.mitica (unknown [10.39.194.90])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 3384A2026D4B;
 Wed,  4 Oct 2023 12:40:41 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
To: qemu-devel@nongnu.org
Cc: Leonardo Bras <leobras@redhat.com>, Peter Xu <peterx@redhat.com>,
 Juan Quintela <quintela@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Li Zhijian <lizhijian@fujitsu.com>, Fabiano Rosas <farosas@suse.de>,
 qemu-s390x@nongnu.org, Tejus GK <tejus.gk@nutanix.com>
Subject: [PULL 01/11] migration/vmstate: Introduce vmstate_save_state_with_err
Date: Wed,  4 Oct 2023 14:40:28 +0200
Message-ID: <20231004124038.16002-2-quintela@redhat.com>
In-Reply-To: <20231004124038.16002-1-quintela@redhat.com>
References: <20231004124038.16002-1-quintela@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=quintela@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

From: Tejus GK <tejus.gk@nutanix.com>

Currently, a few code paths exist in the function vmstate_save_state_v,
which ultimately leads to a migration failure. However, an update in the
current MigrationState for the error description is never done.

vmstate.c somehow doesn't seem to allow	the use	of migrate_set_error due
to some	dependencies for unit tests. Hence, this patch introduces a new
function vmstate_save_state_with_err, which will eventually propagate
the error message to savevm.c where a migrate_set_error	call can be
eventually done.

Acked-by: Peter Xu <peterx@redhat.com>
Reviewed-by: Juan Quintela <quintela@redhat.com>
Signed-off-by: Tejus GK <tejus.gk@nutanix.com>
Signed-off-by: Juan Quintela <quintela@redhat.com>
Message-ID: <20231003065538.244752-2-tejus.gk@nutanix.com>
---
 include/migration/vmstate.h |  4 +++-
 migration/savevm.c          |  2 +-
 migration/vmstate.c         | 12 +++++++++---
 3 files changed, 13 insertions(+), 5 deletions(-)

diff --git a/include/migration/vmstate.h b/include/migration/vmstate.h
index e4db910339..1a31fb7293 100644
--- a/include/migration/vmstate.h
+++ b/include/migration/vmstate.h
@@ -1196,9 +1196,11 @@ int vmstate_load_state(QEMUFile *f, const VMStateDescription *vmsd,
                        void *opaque, int version_id);
 int vmstate_save_state(QEMUFile *f, const VMStateDescription *vmsd,
                        void *opaque, JSONWriter *vmdesc);
+int vmstate_save_state_with_err(QEMUFile *f, const VMStateDescription *vmsd,
+                       void *opaque, JSONWriter *vmdesc, Error **errp);
 int vmstate_save_state_v(QEMUFile *f, const VMStateDescription *vmsd,
                          void *opaque, JSONWriter *vmdesc,
-                         int version_id);
+                         int version_id, Error **errp);
 
 bool vmstate_save_needed(const VMStateDescription *vmsd, void *opaque);
 
diff --git a/migration/savevm.c b/migration/savevm.c
index bb3e99194c..1f65294bf4 100644
--- a/migration/savevm.c
+++ b/migration/savevm.c
@@ -1000,7 +1000,7 @@ static int vmstate_save(QEMUFile *f, SaveStateEntry *se, JSONWriter *vmdesc)
     if (!se->vmsd) {
         vmstate_save_old_style(f, se, vmdesc);
     } else {
-        ret = vmstate_save_state(f, se->vmsd, se->opaque, vmdesc);
+        ret = vmstate_save_state_with_err(f, se->vmsd, se->opaque, vmdesc, &local_err);
         if (ret) {
             return ret;
         }
diff --git a/migration/vmstate.c b/migration/vmstate.c
index 438ea77cfa..dd9c76dbeb 100644
--- a/migration/vmstate.c
+++ b/migration/vmstate.c
@@ -315,11 +315,17 @@ bool vmstate_save_needed(const VMStateDescription *vmsd, void *opaque)
 int vmstate_save_state(QEMUFile *f, const VMStateDescription *vmsd,
                        void *opaque, JSONWriter *vmdesc_id)
 {
-    return vmstate_save_state_v(f, vmsd, opaque, vmdesc_id, vmsd->version_id);
+    return vmstate_save_state_v(f, vmsd, opaque, vmdesc_id, vmsd->version_id, NULL);
+}
+
+int vmstate_save_state_with_err(QEMUFile *f, const VMStateDescription *vmsd,
+                       void *opaque, JSONWriter *vmdesc_id, Error **errp)
+{
+    return vmstate_save_state_v(f, vmsd, opaque, vmdesc_id, vmsd->version_id, errp);
 }
 
 int vmstate_save_state_v(QEMUFile *f, const VMStateDescription *vmsd,
-                         void *opaque, JSONWriter *vmdesc, int version_id)
+                         void *opaque, JSONWriter *vmdesc, int version_id, Error **errp)
 {
     int ret = 0;
     const VMStateField *field = vmsd->fields;
@@ -377,7 +383,7 @@ int vmstate_save_state_v(QEMUFile *f, const VMStateDescription *vmsd,
                 } else if (field->flags & VMS_VSTRUCT) {
                     ret = vmstate_save_state_v(f, field->vmsd, curr_elem,
                                                vmdesc_loop,
-                                               field->struct_version_id);
+                                               field->struct_version_id, errp);
                 } else {
                     ret = field->info->put(f, curr_elem, size, field,
                                      vmdesc_loop);
-- 
2.41.0



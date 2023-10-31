Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 950B27DC8EE
	for <lists+qemu-devel@lfdr.de>; Tue, 31 Oct 2023 10:03:51 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qxkeF-0001FD-8B; Tue, 31 Oct 2023 05:02:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qxkeA-00016r-V1
 for qemu-devel@nongnu.org; Tue, 31 Oct 2023 05:02:50 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qxke8-0006yW-Fb
 for qemu-devel@nongnu.org; Tue, 31 Oct 2023 05:02:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1698742967;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/NRSpUIijsQTQV6/Ab+Fo4l/3wg2rU3H4n9wtIAj/fI=;
 b=g1+WPvkNLnMSKyX+UMCV7C9WDltifAAlJKhmQEcYiG/qafU6Da2o3j/U4mUFjRkaYG49EF
 HOEuzLdzFe2rD6hFwXzfeA3jiNY76lWibzgYkFetjpCcV1Y6zCCbYHtXO546Ot4JKo/6PO
 7Yly64IC0uFlyJ5Semkb36ca6HFKSd4=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-696-H24PkZb7O5qhnhgxTm9hFA-1; Tue, 31 Oct 2023 05:02:40 -0400
X-MC-Unique: H24PkZb7O5qhnhgxTm9hFA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com
 [10.11.54.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 8F90685A5B5;
 Tue, 31 Oct 2023 09:02:39 +0000 (UTC)
Received: from secure.mitica (unknown [10.39.195.26])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 099CA1C060AE;
 Tue, 31 Oct 2023 09:02:36 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
To: qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, libvir-list@redhat.com,
 Stefan Hajnoczi <stefanha@redhat.com>, Fam Zheng <fam@euphon.net>,
 Hanna Reitz <hreitz@redhat.com>, Li Zhijian <lizhijian@fujitsu.com>,
 Peter Xu <peterx@redhat.com>, Leonardo Bras <leobras@redhat.com>,
 Juan Quintela <quintela@redhat.com>, Eric Blake <eblake@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 Hailiang Zhang <zhanghailiang@xfusion.com>, qemu-block@nongnu.org,
 Fabiano Rosas <farosas@suse.de>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Subject: [PULL 19/38] migration: rename
 vmstate_save_needed->vmstate_section_needed
Date: Tue, 31 Oct 2023 10:01:23 +0100
Message-ID: <20231031090142.13122-20-quintela@redhat.com>
In-Reply-To: <20231031090142.13122-1-quintela@redhat.com>
References: <20231031090142.13122-1-quintela@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.7
Received-SPF: pass client-ip=170.10.133.124; envelope-from=quintela@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.483,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

From: Marc-André Lureau <marcandre.lureau@redhat.com>

The function is used on save at this point. The following commits will
use it on load.

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Juan Quintela <quintela@redhat.com>
Signed-off-by: Juan Quintela <quintela@redhat.com>
Message-ID: <20231024084043.2926316-5-marcandre.lureau@redhat.com>
---
 include/migration/vmstate.h | 2 +-
 migration/savevm.c          | 2 +-
 migration/vmstate.c         | 4 ++--
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/include/migration/vmstate.h b/include/migration/vmstate.h
index 1a31fb7293..1af181877c 100644
--- a/include/migration/vmstate.h
+++ b/include/migration/vmstate.h
@@ -1202,7 +1202,7 @@ int vmstate_save_state_v(QEMUFile *f, const VMStateDescription *vmsd,
                          void *opaque, JSONWriter *vmdesc,
                          int version_id, Error **errp);
 
-bool vmstate_save_needed(const VMStateDescription *vmsd, void *opaque);
+bool vmstate_section_needed(const VMStateDescription *vmsd, void *opaque);
 
 #define  VMSTATE_INSTANCE_ID_ANY  -1
 
diff --git a/migration/savevm.c b/migration/savevm.c
index 8622f229e5..ca5c7cebe0 100644
--- a/migration/savevm.c
+++ b/migration/savevm.c
@@ -985,7 +985,7 @@ static int vmstate_save(QEMUFile *f, SaveStateEntry *se, JSONWriter *vmdesc)
     if ((!se->ops || !se->ops->save_state) && !se->vmsd) {
         return 0;
     }
-    if (se->vmsd && !vmstate_save_needed(se->vmsd, se->opaque)) {
+    if (se->vmsd && !vmstate_section_needed(se->vmsd, se->opaque)) {
         trace_savevm_section_skip(se->idstr, se->section_id);
         return 0;
     }
diff --git a/migration/vmstate.c b/migration/vmstate.c
index 1cf9e45b85..16e33a5d34 100644
--- a/migration/vmstate.c
+++ b/migration/vmstate.c
@@ -324,7 +324,7 @@ static void vmsd_desc_field_end(const VMStateDescription *vmsd,
 }
 
 
-bool vmstate_save_needed(const VMStateDescription *vmsd, void *opaque)
+bool vmstate_section_needed(const VMStateDescription *vmsd, void *opaque)
 {
     if (vmsd->needed && !vmsd->needed(opaque)) {
         /* optional section not needed */
@@ -522,7 +522,7 @@ static int vmstate_subsection_save(QEMUFile *f, const VMStateDescription *vmsd,
 
     trace_vmstate_subsection_save_top(vmsd->name);
     while (sub && *sub) {
-        if (vmstate_save_needed(*sub, opaque)) {
+        if (vmstate_section_needed(*sub, opaque)) {
             const VMStateDescription *vmsdsub = *sub;
             uint8_t len;
 
-- 
2.41.0



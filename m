Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E8CB27B7F7A
	for <lists+qemu-devel@lfdr.de>; Wed,  4 Oct 2023 14:42:42 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qo1Cd-0000ZY-VZ; Wed, 04 Oct 2023 08:42:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qo1Br-0007AG-4C
 for qemu-devel@nongnu.org; Wed, 04 Oct 2023 08:41:24 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qo1Ba-0003wN-J7
 for qemu-devel@nongnu.org; Wed, 04 Oct 2023 08:41:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1696423265;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=YlVdyH8B1brWgH+NjyMFft4/UrelxrGbAQ6Z+0hJi4Y=;
 b=frpg5tq44iSD0zyDu77iXJgrETOaZdGBzHWy8zuYzHXdvi2IRizBwn0fdDJvTAlJBAVMNR
 TKvjADgbmEpfDrVAkDMH/+sIA5L2uZ2rAB8FTXq6oS551KR8+sZDEaWFiT32mPMZS587jP
 WYT2W8CiGszPc0Mpb8EB5dJlSBSU0DA=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-685-eden6neBPOugikx_Z2wKeg-1; Wed, 04 Oct 2023 08:41:02 -0400
X-MC-Unique: eden6neBPOugikx_Z2wKeg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
 [10.11.54.4])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 68E8A3806739;
 Wed,  4 Oct 2023 12:41:02 +0000 (UTC)
Received: from secure.mitica (unknown [10.39.194.90])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 1C13D2026D4B;
 Wed,  4 Oct 2023 12:41:00 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
To: qemu-devel@nongnu.org
Cc: Leonardo Bras <leobras@redhat.com>, Peter Xu <peterx@redhat.com>,
 Juan Quintela <quintela@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Li Zhijian <lizhijian@fujitsu.com>, Fabiano Rosas <farosas@suse.de>,
 qemu-s390x@nongnu.org
Subject: [PULL 11/11] migration: Unify and trace vmstate field_exists() checks
Date: Wed,  4 Oct 2023 14:40:38 +0200
Message-ID: <20231004124038.16002-12-quintela@redhat.com>
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
 SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=unavailable autolearn_force=no
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

For both save/load we actually share the logic on deciding whether a field
should exist.  Merge the checks into a helper and use it for both save and
load.  When doing so, add documentations and reformat the code to make it
much easier to read.

The real benefit here (besides code cleanups) is we add a trace-point for
this; this is a known spot where we can easily break migration
compatibilities between binaries, and this trace point will be critical for
us to identify such issues.

For example, this will be handy when debugging things like:

https://gitlab.com/qemu-project/qemu/-/issues/932

Reviewed-by: Fabiano Rosas <farosas@suse.de>
Reviewed-by: Juan Quintela <quintela@redhat.com>
Signed-off-by: Peter Xu <peterx@redhat.com>
Signed-off-by: Juan Quintela <quintela@redhat.com>
Message-ID: <20230906204722.514474-1-peterx@redhat.com>
---
 migration/vmstate.c    | 34 ++++++++++++++++++++++++++--------
 migration/trace-events |  1 +
 2 files changed, 27 insertions(+), 8 deletions(-)

diff --git a/migration/vmstate.c b/migration/vmstate.c
index 4cde30bf2d..1cf9e45b85 100644
--- a/migration/vmstate.c
+++ b/migration/vmstate.c
@@ -26,6 +26,30 @@ static int vmstate_subsection_save(QEMUFile *f, const VMStateDescription *vmsd,
 static int vmstate_subsection_load(QEMUFile *f, const VMStateDescription *vmsd,
                                    void *opaque);
 
+/* Whether this field should exist for either save or load the VM? */
+static bool
+vmstate_field_exists(const VMStateDescription *vmsd, const VMStateField *field,
+                     void *opaque, int version_id)
+{
+    bool result;
+
+    if (field->field_exists) {
+        /* If there's the function checker, that's the solo truth */
+        result = field->field_exists(opaque, version_id);
+        trace_vmstate_field_exists(vmsd->name, field->name, field->version_id,
+                                   version_id, result);
+    } else {
+        /*
+         * Otherwise, we only save/load if field version is same or older.
+         * For example, when loading from an old binary with old version,
+         * we ignore new fields with newer version_ids.
+         */
+        result = field->version_id <= version_id;
+    }
+
+    return result;
+}
+
 static int vmstate_n_elems(void *opaque, const VMStateField *field)
 {
     int n_elems = 1;
@@ -105,10 +129,7 @@ int vmstate_load_state(QEMUFile *f, const VMStateDescription *vmsd,
     }
     while (field->name) {
         trace_vmstate_load_state_field(vmsd->name, field->name);
-        if ((field->field_exists &&
-             field->field_exists(opaque, version_id)) ||
-            (!field->field_exists &&
-             field->version_id <= version_id)) {
+        if (vmstate_field_exists(vmsd, field, opaque, version_id)) {
             void *first_elem = opaque + field->offset;
             int i, n_elems = vmstate_n_elems(opaque, field);
             int size = vmstate_size(opaque, field);
@@ -349,10 +370,7 @@ int vmstate_save_state_v(QEMUFile *f, const VMStateDescription *vmsd,
     }
 
     while (field->name) {
-        if ((field->field_exists &&
-             field->field_exists(opaque, version_id)) ||
-            (!field->field_exists &&
-             field->version_id <= version_id)) {
+        if (vmstate_field_exists(vmsd, field, opaque, version_id)) {
             void *first_elem = opaque + field->offset;
             int i, n_elems = vmstate_n_elems(opaque, field);
             int size = vmstate_size(opaque, field);
diff --git a/migration/trace-events b/migration/trace-events
index 3e9649ab2a..002abe3a4e 100644
--- a/migration/trace-events
+++ b/migration/trace-events
@@ -66,6 +66,7 @@ vmstate_save_state_loop(const char *name, const char *field, int n_elems) "%s/%s
 vmstate_save_state_top(const char *idstr) "%s"
 vmstate_subsection_save_loop(const char *name, const char *sub) "%s/%s"
 vmstate_subsection_save_top(const char *idstr) "%s"
+vmstate_field_exists(const char *vmsd, const char *name, int field_version, int version, int result) "%s:%s field_version %d version %d result %d"
 
 # vmstate-types.c
 get_qtailq(const char *name, int version_id) "%s v%d"
-- 
2.41.0



Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 815F77944BB
	for <lists+qemu-devel@lfdr.de>; Wed,  6 Sep 2023 22:49:12 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qdzR8-0006TH-LH; Wed, 06 Sep 2023 16:47:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1qdzQw-0006Sy-CG
 for qemu-devel@nongnu.org; Wed, 06 Sep 2023 16:47:30 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1qdzQt-0003e9-MK
 for qemu-devel@nongnu.org; Wed, 06 Sep 2023 16:47:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1694033246;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=IwFMv21/nxVgEUsuqIWGDIm1BDNEGQrw0h9JZmvZgDc=;
 b=Ve4xq5El4V/LoIcOczzhErsO3Arc/TT5rmdM8O3VXYD5SF6oXzWNrhVPiyJ4nz8V1HhqQf
 C/1tjP6FR9h4LLb2TaWWd7Dhmf0V19cTMbOM/bzNxb7ZzwMLbihjJAFVKsfDO6CoL/k9j/
 Lhd3D7zljb7vhzBVwW37FS1VRSyRsTI=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-599-5DRlddxwOl6B7TYhGrtZBA-1; Wed, 06 Sep 2023 16:47:25 -0400
X-MC-Unique: 5DRlddxwOl6B7TYhGrtZBA-1
Received: by mail-qv1-f71.google.com with SMTP id
 6a1803df08f44-637948b24bdso559836d6.1
 for <qemu-devel@nongnu.org>; Wed, 06 Sep 2023 13:47:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1694033244; x=1694638044;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=IwFMv21/nxVgEUsuqIWGDIm1BDNEGQrw0h9JZmvZgDc=;
 b=ltrp029xHv1uWK9k5gHcsi6mX9CS9vpU63IUgD9nD3nUZYsx3AVzcZkh/xhDBZGsvo
 UqJ12Z2xgFkFEGC0EhjYw9om++ffoweOd9OIAWYptkXCihWewDXt371ART3DNSoVtmuR
 8ETLFIGprPb91fsKnY0eUM1yH7jbP1lmaa9th+/v7HSSn/ojljKRXtvl1Q7WP5NkgwZC
 /gLx0YMasird1gNQE6nKZ5FurTaTVRRpCASf/4juH/0VvguvqyZ3+ENDE5ofJDK0mrMs
 Exww7gmcm+9+b8R3wRU7kQh/EXhbuxM1m1Bz3C4HVxPBsFx07LUEuVwGSVImeexz/WmE
 NMLA==
X-Gm-Message-State: AOJu0Ywl64UXJg6iBs0dap8EKNyeY1Y3foQobLpnwrxLT8ajijBkca3Z
 qStwz7NqkU5sJbOL74NlqX70G8Bd22zaRaa8hVTedPa6HgHJqDfI31IjdC0MT/2EhGsfarzIYql
 UqXsmdPZwKfW5SwaWMZreDjStpqRygmQy2QUVUfzG/ea5nMhgiYjVKJ2UJjtr5DhHqR8AivJP
X-Received: by 2002:a05:6214:23cc:b0:649:5f43:245c with SMTP id
 hr12-20020a05621423cc00b006495f43245cmr19557134qvb.4.1694033244542; 
 Wed, 06 Sep 2023 13:47:24 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFNnxmq+2/PTwzYpvRffwyBvl+uUSDwhIqVBSqgUNwwolKwazMPBDwMI9JZFCDoYXmIqqXLsg==
X-Received: by 2002:a05:6214:23cc:b0:649:5f43:245c with SMTP id
 hr12-20020a05621423cc00b006495f43245cmr19557112qvb.4.1694033244084; 
 Wed, 06 Sep 2023 13:47:24 -0700 (PDT)
Received: from x1n.redhat.com
 (cpe5c7695f3aee0-cm5c7695f3aede.cpe.net.cable.rogers.com. [99.254.144.39])
 by smtp.gmail.com with ESMTPSA id
 t19-20020a0cde13000000b0064f5aeda9ddsm5704542qvk.29.2023.09.06.13.47.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 06 Sep 2023 13:47:23 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: Fabiano Rosas <farosas@suse.de>, peterx@redhat.com,
 Juan Quintela <quintela@redhat.com>
Subject: [PATCH] migration: Unify and trace vmstate field_exists() checks
Date: Wed,  6 Sep 2023 16:47:22 -0400
Message-ID: <20230906204722.514474-1-peterx@redhat.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
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

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 migration/vmstate.c    | 34 ++++++++++++++++++++++++++--------
 migration/trace-events |  1 +
 2 files changed, 27 insertions(+), 8 deletions(-)

diff --git a/migration/vmstate.c b/migration/vmstate.c
index 31842c3afb..73e74ddea0 100644
--- a/migration/vmstate.c
+++ b/migration/vmstate.c
@@ -25,6 +25,30 @@ static int vmstate_subsection_save(QEMUFile *f, const VMStateDescription *vmsd,
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
@@ -104,10 +128,7 @@ int vmstate_load_state(QEMUFile *f, const VMStateDescription *vmsd,
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
@@ -342,10 +363,7 @@ int vmstate_save_state_v(QEMUFile *f, const VMStateDescription *vmsd,
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
index 4666f19325..446db0b7ce 100644
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



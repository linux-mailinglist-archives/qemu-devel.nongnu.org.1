Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FA6EAA0E22
	for <lists+qemu-devel@lfdr.de>; Tue, 29 Apr 2025 16:05:41 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u9la9-0001ld-23; Tue, 29 Apr 2025 10:05:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1u9lZw-0001Wv-Qz
 for qemu-devel@nongnu.org; Tue, 29 Apr 2025 10:04:57 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1u9lZv-0005dS-0b
 for qemu-devel@nongnu.org; Tue, 29 Apr 2025 10:04:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1745935494;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=uLtoowsYeTkKZJ4mHa9vOQu041jpGafZweYxc7y8CFU=;
 b=TdI0Y1eUAt1TCI3JH6g+So1iJNMLNyIfmc8apPWEbUZEbUPbEbEHXiQksgGtsGvPT5cl5X
 lxsoJW/CVMZcT+bMWnQHjs++QbbKINZlVCZv1vaapChRq8a5nTuoNh+3tNX/CzZIgrlte0
 OqCtElzPkg+Ci1OhomCKj6Uz9grQvOw=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-550-jOtU4fwLNYqqlQn8xf-nLA-1; Tue,
 29 Apr 2025 10:03:47 -0400
X-MC-Unique: jOtU4fwLNYqqlQn8xf-nLA-1
X-Mimecast-MFC-AGG-ID: jOtU4fwLNYqqlQn8xf-nLA_1745935427
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id C26ED1800986; Tue, 29 Apr 2025 14:03:46 +0000 (UTC)
Received: from localhost (unknown [10.45.242.19])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 6738018001DA; Tue, 29 Apr 2025 14:03:44 +0000 (UTC)
From: marcandre.lureau@redhat.com
To: qemu-devel@nongnu.org
Cc: Stefan Berger <stefanb@linux.vnet.ibm.com>,
 Eduardo Habkost <eduardo@habkost.net>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Subject: [PATCH 6/6] RFC: qom/object: simplify object_property_del_all()
Date: Tue, 29 Apr 2025 18:03:06 +0400
Message-ID: <20250429140306.190384-7-marcandre.lureau@redhat.com>
In-Reply-To: <20250429140306.190384-1-marcandre.lureau@redhat.com>
References: <20250429140306.190384-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.489,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

From: Marc-André Lureau <marcandre.lureau@redhat.com>

Since commit 9859fac ("object: release all props"), the code was changed
to tracks the already released properties in a hash table. I am not sure
why this was done, perhaps to prevent from potential crashes if
properties are being added dynamically during release. I am not sure if
it's a valid concern though.

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 qom/object.c | 18 +++++-------------
 1 file changed, 5 insertions(+), 13 deletions(-)

diff --git a/qom/object.c b/qom/object.c
index 664f0f24ae..a2ccebca6d 100644
--- a/qom/object.c
+++ b/qom/object.c
@@ -656,21 +656,13 @@ static void object_property_del_all(Object *obj)
     g_autoptr(GHashTable) done = g_hash_table_new(NULL, NULL);
     ObjectProperty *prop;
     ObjectPropertyIterator iter;
-    bool released;
 
-    do {
-        released = false;
-        object_property_iter_init(&iter, obj);
-        while ((prop = object_property_iter_next(&iter)) != NULL) {
-            if (g_hash_table_add(done, prop)) {
-                if (prop->release) {
-                    prop->release(obj, prop->name, prop->opaque);
-                    released = true;
-                    break;
-                }
-            }
+    object_property_iter_init(&iter, obj);
+    while ((prop = object_property_iter_next(&iter)) != NULL) {
+        if (prop->release) {
+            prop->release(obj, prop->name, prop->opaque);
         }
-    } while (released);
+    }
 
     g_hash_table_unref(obj->properties);
 }
-- 
2.49.0



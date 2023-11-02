Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 84AF57DF1A6
	for <lists+qemu-devel@lfdr.de>; Thu,  2 Nov 2023 12:50:40 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qyW54-0002JB-Dt; Thu, 02 Nov 2023 07:41:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qyW52-0002Hf-Gr
 for qemu-devel@nongnu.org; Thu, 02 Nov 2023 07:41:44 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qyW50-0004Fb-7C
 for qemu-devel@nongnu.org; Thu, 02 Nov 2023 07:41:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1698925301;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=dTJsFVzWMxcTx8RaEnOML6rvjwsf9n7SjqNHr3G+kgQ=;
 b=S0ESznTgO3FjZW9//bnYoqjcn/M8y5F8DQz8tkYSXVAM7PmUlz1mEJRpK/BbefN4lrL/6w
 TWZcXnaE0Dd5Wly13JYYc/+ZZj2M22CyiVZ2k850rW4SeGbPliZe0XUj+E/rHmDW7pHAkL
 Y3RVJbZ9V8bOV29t0iCFQ3EdYwMifjY=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-492-ckeaTPGOO-eCpusz1XqLIg-1; Thu, 02 Nov 2023 07:41:36 -0400
X-MC-Unique: ckeaTPGOO-eCpusz1XqLIg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
 [10.11.54.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 48DEB185A782;
 Thu,  2 Nov 2023 11:41:34 +0000 (UTC)
Received: from secure.mitica (unknown [10.39.195.26])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 171132026D4C;
 Thu,  2 Nov 2023 11:41:26 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
To: qemu-devel@nongnu.org
Cc: Eric Farman <farman@linux.ibm.com>, Laurent Vivier <lvivier@redhat.com>,
 David Gibson <david@gibson.dropbear.id.au>, qemu-block@nongnu.org,
 Stefan Hajnoczi <stefanha@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Kevin Wolf <kwolf@redhat.com>, David Hildenbrand <david@redhat.com>,
 Samuel Thibault <samuel.thibault@ens-lyon.org>, qemu-s390x@nongnu.org,
 Richard Henderson <richard.henderson@linaro.org>,
 Leonardo Bras <leobras@redhat.com>, Corey Minyard <cminyard@mvista.com>,
 Ilya Leoshkevich <iii@linux.ibm.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Eduardo Habkost <eduardo@habkost.net>, Paolo Bonzini <pbonzini@redhat.com>,
 qemu-ppc@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Halil Pasic <pasic@linux.ibm.com>, Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Li Zhijian <lizhijian@fujitsu.com>, Eric Blake <eblake@redhat.com>,
 "Denis V. Lunev" <den@openvz.org>, Hanna Reitz <hreitz@redhat.com>,
 Fabiano Rosas <farosas@suse.de>,
 Stefan Berger <stefanb@linux.vnet.ibm.com>, qemu-arm@nongnu.org,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Thomas Huth <thuth@redhat.com>, Corey Minyard <minyard@acm.org>,
 John Snow <jsnow@redhat.com>, Jeff Cody <codyprime@gmail.com>,
 Peter Xu <peterx@redhat.com>, Nicholas Piggin <npiggin@gmail.com>,
 Juan Quintela <quintela@redhat.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Jason Wang <jasowang@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Stefan Weil <sw@weilnetz.de>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Fam Zheng <fam@euphon.net>
Subject: [PULL 04/40] hw/s390x/s390-stattrib: Don't call
 register_savevm_live() during instance_init()
Date: Thu,  2 Nov 2023 12:40:18 +0100
Message-ID: <20231102114054.44360-5-quintela@redhat.com>
In-Reply-To: <20231102114054.44360-1-quintela@redhat.com>
References: <20231102114054.44360-1-quintela@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=quintela@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.393,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

From: Thomas Huth <thuth@redhat.com>

We must not call register_savevm_live() from an instance_init() function
(since this could be called multiple times during device introspection).
Move this to the realize() function instead.

Acked-by: David Hildenbrand <david@redhat.com>
Reviewed-by: Eric Farman <farman@linux.ibm.com>
Signed-off-by: Juan Quintela <quintela@redhat.com>
Signed-off-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: Juan Quintela <quintela@redhat.com>
Message-ID: <20231020150554.664422-4-thuth@redhat.com>
---
 hw/s390x/s390-stattrib.c | 29 +++++++++++++++--------------
 1 file changed, 15 insertions(+), 14 deletions(-)

diff --git a/hw/s390x/s390-stattrib.c b/hw/s390x/s390-stattrib.c
index 4f1ab57437..c483b62a9b 100644
--- a/hw/s390x/s390-stattrib.c
+++ b/hw/s390x/s390-stattrib.c
@@ -331,6 +331,17 @@ static const TypeInfo qemu_s390_stattrib_info = {
 
 /* Generic abstract object: */
 
+static SaveVMHandlers savevm_s390_stattrib_handlers = {
+    .save_setup = cmma_save_setup,
+    .save_live_iterate = cmma_save_iterate,
+    .save_live_complete_precopy = cmma_save_complete,
+    .state_pending_exact = cmma_state_pending,
+    .state_pending_estimate = cmma_state_pending,
+    .save_cleanup = cmma_save_cleanup,
+    .load_state = cmma_load,
+    .is_active = cmma_active,
+};
+
 static void s390_stattrib_realize(DeviceState *dev, Error **errp)
 {
     bool ambiguous = false;
@@ -338,7 +349,11 @@ static void s390_stattrib_realize(DeviceState *dev, Error **errp)
     object_resolve_path_type("", TYPE_S390_STATTRIB, &ambiguous);
     if (ambiguous) {
         error_setg(errp, "storage_attributes device already exists");
+        return;
     }
+
+    register_savevm_live(TYPE_S390_STATTRIB, 0, 0,
+                         &savevm_s390_stattrib_handlers, dev);
 }
 
 static Property s390_stattrib_props[] = {
@@ -356,24 +371,10 @@ static void s390_stattrib_class_init(ObjectClass *oc, void *data)
     device_class_set_props(dc, s390_stattrib_props);
 }
 
-static SaveVMHandlers savevm_s390_stattrib_handlers = {
-    .save_setup = cmma_save_setup,
-    .save_live_iterate = cmma_save_iterate,
-    .save_live_complete_precopy = cmma_save_complete,
-    .state_pending_exact = cmma_state_pending,
-    .state_pending_estimate = cmma_state_pending,
-    .save_cleanup = cmma_save_cleanup,
-    .load_state = cmma_load,
-    .is_active = cmma_active,
-};
-
 static void s390_stattrib_instance_init(Object *obj)
 {
     S390StAttribState *sas = S390_STATTRIB(obj);
 
-    register_savevm_live(TYPE_S390_STATTRIB, 0, 0,
-                         &savevm_s390_stattrib_handlers, sas);
-
     sas->migration_cur_gfn = 0;
 }
 
-- 
2.41.0



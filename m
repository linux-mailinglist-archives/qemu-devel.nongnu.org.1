Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BA307D0B22
	for <lists+qemu-devel@lfdr.de>; Fri, 20 Oct 2023 11:09:33 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qtlUi-0003m6-Nz; Fri, 20 Oct 2023 05:08:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qtlUU-0003Ta-6o
 for qemu-devel@nongnu.org; Fri, 20 Oct 2023 05:08:23 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qtlUQ-0005IY-2O
 for qemu-devel@nongnu.org; Fri, 20 Oct 2023 05:08:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697792895;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Kgz7p6yDeHNJMfBQZRC1/7r8AHjBikV0rY5ziFkuiRo=;
 b=BQ1YsFUBiUk4Tg3/dcNh29wf4WAhium3T0XvRXxI5pukH9cB1ppOkS5JWYIw9zee7G6zAO
 IwYD6vo3W9ipQqETiiGSWuZNsDTQrA5q01cWqyRDAQzjJ4Xbu/x2D9UOvUmh/uHVBj33Zn
 xqU6JAerp/ROxpPtFXvQxKL0AN7AC5A=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-150-9BhV5DbuOCmfZteR575eGA-1; Fri, 20 Oct 2023 05:08:11 -0400
X-MC-Unique: 9BhV5DbuOCmfZteR575eGA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
 [10.11.54.6])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 3643088B777;
 Fri, 20 Oct 2023 09:08:10 +0000 (UTC)
Received: from secure.mitica (unknown [10.39.194.127])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 0A86C2166B26;
 Fri, 20 Oct 2023 09:08:04 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 David Hildenbrand <david@redhat.com>,
 Samuel Thibault <samuel.thibault@ens-lyon.org>,
 Eric Farman <farman@linux.ibm.com>, qemu-arm@nongnu.org,
 qemu-ppc@nongnu.org, Thomas Huth <thuth@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 David Gibson <david@gibson.dropbear.id.au>,
 Corey Minyard <cminyard@mvista.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Peter Xu <peterx@redhat.com>, Corey Minyard <minyard@acm.org>,
 Stefan Berger <stefanb@linux.vnet.ibm.com>,
 Juan Quintela <quintela@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Halil Pasic <pasic@linux.ibm.com>, Leonardo Bras <leobras@redhat.com>,
 John Snow <jsnow@redhat.com>, Nicholas Piggin <npiggin@gmail.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Ilya Leoshkevich <iii@linux.ibm.com>, Jason Wang <jasowang@redhat.com>,
 qemu-block@nongnu.org, qemu-s390x@nongnu.org,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Stefan Weil <sw@weilnetz.de>, Stefan Berger <stefanb@linux.ibm.com>
Subject: [PATCH v2 06/13] migration: Use VMSTATE_INSTANCE_ID_ANY for s390
 devices
Date: Fri, 20 Oct 2023 11:07:24 +0200
Message-ID: <20231020090731.28701-7-quintela@redhat.com>
In-Reply-To: <20231020090731.28701-1-quintela@redhat.com>
References: <20231020090731.28701-1-quintela@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.6
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

Just with make check I can see that we can have more than one of this
devices, so use ANY.

ok 5 /s390x/device/introspect/abstract-interfaces
...
Broken pipe
../../../../../mnt/code/qemu/full/tests/qtest/libqtest.c:195: kill_qemu() tried to terminate QEMU process but encountered exit status 1 (expected 0)
Aborted (core dumped)

Reviewed-by: Stefan Berger <stefanb@linux.ibm.com>
Signed-off-by: Juan Quintela <quintela@redhat.com>
---
 hw/s390x/s390-skeys.c    | 3 ++-
 hw/s390x/s390-stattrib.c | 3 ++-
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/hw/s390x/s390-skeys.c b/hw/s390x/s390-skeys.c
index 5024faf411..ef089e1967 100644
--- a/hw/s390x/s390-skeys.c
+++ b/hw/s390x/s390-skeys.c
@@ -22,6 +22,7 @@
 #include "sysemu/kvm.h"
 #include "migration/qemu-file-types.h"
 #include "migration/register.h"
+#include "migration/vmstate.h"
 
 #define S390_SKEYS_BUFFER_SIZE (128 * KiB)  /* Room for 128k storage keys */
 #define S390_SKEYS_SAVE_FLAG_EOS 0x01
@@ -457,7 +458,7 @@ static inline void s390_skeys_set_migration_enabled(Object *obj, bool value,
     ss->migration_enabled = value;
 
     if (ss->migration_enabled) {
-        register_savevm_live(TYPE_S390_SKEYS, 0, 1,
+        register_savevm_live(TYPE_S390_SKEYS, VMSTATE_INSTANCE_ID_ANY, 1,
                              &savevm_s390_storage_keys, ss);
     } else {
         unregister_savevm(VMSTATE_IF(ss), TYPE_S390_SKEYS, ss);
diff --git a/hw/s390x/s390-stattrib.c b/hw/s390x/s390-stattrib.c
index 220e845d12..055d382c3c 100644
--- a/hw/s390x/s390-stattrib.c
+++ b/hw/s390x/s390-stattrib.c
@@ -13,6 +13,7 @@
 #include "qemu/units.h"
 #include "migration/qemu-file.h"
 #include "migration/register.h"
+#include "migration/vmstate.h"
 #include "hw/s390x/storage-attributes.h"
 #include "qemu/error-report.h"
 #include "exec/ram_addr.h"
@@ -380,7 +381,7 @@ static void s390_stattrib_instance_init(Object *obj)
 {
     S390StAttribState *sas = S390_STATTRIB(obj);
 
-    register_savevm_live(TYPE_S390_STATTRIB, 0, 0,
+    register_savevm_live(TYPE_S390_STATTRIB, VMSTATE_INSTANCE_ID_ANY, 0,
                          &savevm_s390_stattrib_handlers, sas);
 
     object_property_add_bool(obj, "migration-enabled",
-- 
2.41.0



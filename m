Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A43682776D
	for <lists+qemu-devel@lfdr.de>; Mon,  8 Jan 2024 19:26:59 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rMuIX-0002v3-MZ; Mon, 08 Jan 2024 13:24:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1rMuIS-0002uG-5m
 for qemu-devel@nongnu.org; Mon, 08 Jan 2024 13:24:24 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1rMuIO-0002kp-L3
 for qemu-devel@nongnu.org; Mon, 08 Jan 2024 13:24:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1704738257;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=PsuJf5T/Jk1TWANNpVteueiNOuncbBoCOHnc9AFl1x8=;
 b=ULhEeNWsBspj8u2w6I5F5BFM1CL//ynNteN2IgG3Cq7npAk8wEsDfBPvG2rt9fpQIO2YoW
 9ex8wIgSWa+DAufmpyWwnmzuCirPtLTKqaPmixS/vg9vuSW43UKexPhHe9TuyGhd/RLu/S
 /7iRAOzLyn5pOh0YeX2Q1VuHP9f2x70=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-683-bphTPd0NOfOSuQ5qQSvWUg-1; Mon,
 08 Jan 2024 13:24:14 -0500
X-MC-Unique: bphTPd0NOfOSuQ5qQSvWUg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com
 [10.11.54.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 5C3171C06502;
 Mon,  8 Jan 2024 18:24:14 +0000 (UTC)
Received: from toolbox.redhat.com (unknown [10.42.28.90])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 0EEC23C2E;
 Mon,  8 Jan 2024 18:24:12 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>, Michael Roth <michael.roth@amd.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH 05/29] backends: adapt to new import path for qobject data
 type headers
Date: Mon,  8 Jan 2024 18:23:41 +0000
Message-ID: <20240108182405.1135436-6-berrange@redhat.com>
In-Reply-To: <20240108182405.1135436-1-berrange@redhat.com>
References: <20240108182405.1135436-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.1
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.243,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

The qobject data type headers have moved from qapi/qmp/ to
qobject/.

Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
---
 backends/cryptodev-hmp-cmds.c   | 2 +-
 backends/cryptodev-vhost-user.c | 2 +-
 backends/dbus-vmstate.c         | 2 +-
 backends/iommufd.c              | 2 +-
 backends/rng-egd.c              | 2 +-
 backends/rng-random.c           | 2 +-
 6 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/backends/cryptodev-hmp-cmds.c b/backends/cryptodev-hmp-cmds.c
index 4f7220bb13..01396d227c 100644
--- a/backends/cryptodev-hmp-cmds.c
+++ b/backends/cryptodev-hmp-cmds.c
@@ -14,7 +14,7 @@
 #include "monitor/hmp.h"
 #include "monitor/monitor.h"
 #include "qapi/qapi-commands-cryptodev.h"
-#include "qapi/qmp/qdict.h"
+#include "qobject/qdict.h"
 
 
 void hmp_info_cryptodev(Monitor *mon, const QDict *qdict)
diff --git a/backends/cryptodev-vhost-user.c b/backends/cryptodev-vhost-user.c
index c3283ba84a..eae00bdc14 100644
--- a/backends/cryptodev-vhost-user.c
+++ b/backends/cryptodev-vhost-user.c
@@ -23,7 +23,7 @@
 
 #include "qemu/osdep.h"
 #include "qapi/error.h"
-#include "qapi/qmp/qerror.h"
+#include "qobject/qerror.h"
 #include "qemu/error-report.h"
 #include "hw/virtio/vhost-user.h"
 #include "standard-headers/linux/virtio_crypto.h"
diff --git a/backends/dbus-vmstate.c b/backends/dbus-vmstate.c
index be6c4d8e0a..19f1e1060c 100644
--- a/backends/dbus-vmstate.c
+++ b/backends/dbus-vmstate.c
@@ -16,7 +16,7 @@
 #include "qemu/error-report.h"
 #include "qapi/error.h"
 #include "qom/object_interfaces.h"
-#include "qapi/qmp/qerror.h"
+#include "qobject/qerror.h"
 #include "migration/vmstate.h"
 #include "trace.h"
 #include "qom/object.h"
diff --git a/backends/iommufd.c b/backends/iommufd.c
index ba58a0eb0d..6d75dbe14a 100644
--- a/backends/iommufd.c
+++ b/backends/iommufd.c
@@ -13,7 +13,7 @@
 #include "qemu/osdep.h"
 #include "sysemu/iommufd.h"
 #include "qapi/error.h"
-#include "qapi/qmp/qerror.h"
+#include "qobject/qerror.h"
 #include "qemu/module.h"
 #include "qom/object_interfaces.h"
 #include "qemu/error-report.h"
diff --git a/backends/rng-egd.c b/backends/rng-egd.c
index 684c3cf3d6..c4a17cabb1 100644
--- a/backends/rng-egd.c
+++ b/backends/rng-egd.c
@@ -14,7 +14,7 @@
 #include "sysemu/rng.h"
 #include "chardev/char-fe.h"
 #include "qapi/error.h"
-#include "qapi/qmp/qerror.h"
+#include "qobject/qerror.h"
 #include "qemu/module.h"
 #include "qom/object.h"
 
diff --git a/backends/rng-random.c b/backends/rng-random.c
index 80eb5be138..aea79dcb86 100644
--- a/backends/rng-random.c
+++ b/backends/rng-random.c
@@ -14,7 +14,7 @@
 #include "sysemu/rng-random.h"
 #include "sysemu/rng.h"
 #include "qapi/error.h"
-#include "qapi/qmp/qerror.h"
+#include "qobject/qerror.h"
 #include "qemu/main-loop.h"
 #include "qemu/module.h"
 
-- 
2.43.0



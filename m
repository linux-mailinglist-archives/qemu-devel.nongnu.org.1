Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 43ECEBF571E
	for <lists+qemu-devel@lfdr.de>; Tue, 21 Oct 2025 11:12:08 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vB8IO-0001VW-Gn; Tue, 21 Oct 2025 05:04:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1vB8IL-0001VE-Ou
 for qemu-devel@nongnu.org; Tue, 21 Oct 2025 05:04:42 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1vB8IK-0003y2-0E
 for qemu-devel@nongnu.org; Tue, 21 Oct 2025 05:04:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1761037479;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=rwpnWD9iw8bqt6SJCbIjLvqQbhMiOwHt9uoQCFJISgc=;
 b=dmzCi77Y1f/mXlUg9FjprNCpQBxZBlgKpkl+qSbEbaoInxI0YRScXBNH4NFYxzzLfXbZ6V
 HlvyO8gxfvRm5Wbp3gFCOHD0jietK8PNDjQhZOKdF5viqUB2vGR8agtmGWTzHQSmz4+J7l
 UVl3wwTh9yA7kBjVPgia998hrvF9bjo=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-437-o4LayQD1OJWH26o8GdIWDQ-1; Tue,
 21 Oct 2025 05:04:36 -0400
X-MC-Unique: o4LayQD1OJWH26o8GdIWDQ-1
X-Mimecast-MFC-AGG-ID: o4LayQD1OJWH26o8GdIWDQ_1761037475
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id D578219560A1; Tue, 21 Oct 2025 09:04:35 +0000 (UTC)
Received: from localhost (unknown [10.44.22.9])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 61B5819560A2; Tue, 21 Oct 2025 09:04:33 +0000 (UTC)
From: marcandre.lureau@redhat.com
To: qemu-devel@nongnu.org
Cc: BALATON Zoltan <balaton@eik.bme.hu>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Volker=20R=C3=BCmelin?= <vr_qemu@t-online.de>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>
Subject: [PATCH 13/43] hw/audio: simplify 'hda' audio init code
Date: Tue, 21 Oct 2025 13:02:44 +0400
Message-ID: <20251021090317.425409-14-marcandre.lureau@redhat.com>
In-Reply-To: <20251021090317.425409-1-marcandre.lureau@redhat.com>
References: <20251021090317.425409-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

For consistency, use only qdev_device_add() to instantiate the devices.
We can't rely on automatic bus lookup for the "hda-duplex" device though
as it may end up on a different "intel-hda" bus...

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 hw/audio/intel-hda.c | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/hw/audio/intel-hda.c b/hw/audio/intel-hda.c
index 6a0db0dd9e..14bcf1257d 100644
--- a/hw/audio/intel-hda.c
+++ b/hw/audio/intel-hda.c
@@ -21,6 +21,7 @@
 #include "hw/pci/pci.h"
 #include "hw/qdev-properties.h"
 #include "hw/pci/msi.h"
+#include "monitor/qdev.h"
 #include "qemu/timer.h"
 #include "qemu/bitops.h"
 #include "qemu/log.h"
@@ -30,6 +31,7 @@
 #include "intel-hda.h"
 #include "migration/vmstate.h"
 #include "intel-hda-defs.h"
+#include "qobject/qdict.h"
 #include "system/dma.h"
 #include "qapi/error.h"
 #include "qom/object.h"
@@ -1305,15 +1307,19 @@ static const TypeInfo hda_codec_device_type_info = {
  */
 static int intel_hda_and_codec_init(PCIBus *bus, const char *audiodev)
 {
-    DeviceState *controller;
+    g_autoptr(QDict) props = qdict_new();
+    DeviceState *intel_hda, *codec;
     BusState *hdabus;
-    DeviceState *codec;
 
-    controller = DEVICE(pci_create_simple(bus, -1, "intel-hda"));
-    hdabus = QLIST_FIRST(&controller->child_bus);
+    qdict_put_str(props, "driver", "intel-hda");
+    intel_hda = qdev_device_add_from_qdict(props, false, &error_fatal);
+    hdabus = QLIST_FIRST(&intel_hda->child_bus);
+
     codec = qdev_new("hda-duplex");
     qdev_prop_set_string(codec, "audiodev", audiodev);
     qdev_realize_and_unref(codec, hdabus, &error_fatal);
+    object_unref(intel_hda);
+
     return 0;
 }
 
-- 
2.51.0



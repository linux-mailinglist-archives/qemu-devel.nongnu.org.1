Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 87327BF567D
	for <lists+qemu-devel@lfdr.de>; Tue, 21 Oct 2025 11:05:23 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vB8I2-0001LL-8C; Tue, 21 Oct 2025 05:04:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1vB8I0-0001Ky-NX
 for qemu-devel@nongnu.org; Tue, 21 Oct 2025 05:04:20 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1vB8Hz-0003wv-3i
 for qemu-devel@nongnu.org; Tue, 21 Oct 2025 05:04:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1761037458;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=XM5XiiB9fJ9Ksj/BZ6DFiO9dUHFsPS364V1lxa/i93E=;
 b=Go7EBTz8iVyll/4SSbdi/LGn2imFZhvloXz5bUdv3h91GA4IHm3lPzZVEwNE1CDx2gqc9Z
 BSDNYeZ+BlaLqE8bT5olARTar8/1w8hklJ+wuzfv0OcKpMiTdLax7iFhoZlgxRPsBqWbW7
 HEdXyo+RFlXMd+We2zl5WJEHBzY0RnM=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-694-Euv3RbEqOwuE8Zi1m7F0IQ-1; Tue,
 21 Oct 2025 05:04:14 -0400
X-MC-Unique: Euv3RbEqOwuE8Zi1m7F0IQ-1
X-Mimecast-MFC-AGG-ID: Euv3RbEqOwuE8Zi1m7F0IQ_1761037453
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 97471195606D; Tue, 21 Oct 2025 09:04:13 +0000 (UTC)
Received: from localhost (unknown [10.44.22.9])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 4328B1800451; Tue, 21 Oct 2025 09:04:11 +0000 (UTC)
From: marcandre.lureau@redhat.com
To: qemu-devel@nongnu.org
Cc: BALATON Zoltan <balaton@eik.bme.hu>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Volker=20R=C3=BCmelin?= <vr_qemu@t-online.de>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>
Subject: [PATCH 09/43] hw/audio: look up the default bus from the device class
Date: Tue, 21 Oct 2025 13:02:40 +0400
Message-ID: <20251021090317.425409-10-marcandre.lureau@redhat.com>
In-Reply-To: <20251021090317.425409-1-marcandre.lureau@redhat.com>
References: <20251021090317.425409-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124;
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

Generalize and simplify the device model creation.

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 hw/audio/soundhw.c | 20 ++++----------------
 1 file changed, 4 insertions(+), 16 deletions(-)

diff --git a/hw/audio/soundhw.c b/hw/audio/soundhw.c
index aca077f5ae..b4a87ff709 100644
--- a/hw/audio/soundhw.c
+++ b/hw/audio/soundhw.c
@@ -22,6 +22,8 @@
  * THE SOFTWARE.
  */
 #include "qemu/osdep.h"
+#include "hw/qdev-core.h"
+#include "monitor/qdev.h"
 #include "qemu/option.h"
 #include "qemu/help_option.h"
 #include "qemu/error-report.h"
@@ -110,33 +112,19 @@ void select_soundhw(const char *name, const char *audiodev)
 void soundhw_init(void)
 {
     struct soundhw *c = selected;
-    ISABus *isa_bus = (ISABus *) object_resolve_path_type("", TYPE_ISA_BUS, NULL);
-    PCIBus *pci_bus = (PCIBus *) object_resolve_path_type("", TYPE_PCI_BUS, NULL);
-    BusState *bus;
 
     if (!c) {
         return;
     }
-    if (c->isa) {
-        if (!isa_bus) {
-            error_report("ISA bus not available for %s", c->name);
-            exit(1);
-        }
-        bus = BUS(isa_bus);
-    } else {
-        if (!pci_bus) {
-            error_report("PCI bus not available for %s", c->name);
-            exit(1);
-        }
-        bus = BUS(pci_bus);
-    }
 
     if (c->typename) {
         DeviceState *dev = qdev_new(c->typename);
+        BusState *bus = qdev_find_default_bus(DEVICE_GET_CLASS(dev), &error_fatal);
         qdev_prop_set_string(dev, "audiodev", audiodev_id);
         qdev_realize_and_unref(dev, bus, &error_fatal);
     } else {
         assert(!c->isa);
+        PCIBus *pci_bus = (PCIBus *) object_resolve_path_type("", TYPE_PCI_BUS, NULL);
         c->init_pci(pci_bus, audiodev_id);
     }
 }
-- 
2.51.0



Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C64D1C0EDBD
	for <lists+qemu-devel@lfdr.de>; Mon, 27 Oct 2025 16:14:50 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vDOsx-0001W7-UV; Mon, 27 Oct 2025 11:11:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1vDOsc-0001Pu-EA
 for qemu-devel@nongnu.org; Mon, 27 Oct 2025 11:11:30 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1vDOsQ-0003W4-8m
 for qemu-devel@nongnu.org; Mon, 27 Oct 2025 11:11:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1761577876;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0MyfB1XYiYAAsL7J3ZTAzkl74UqZnQ2uBGx52qq1kb4=;
 b=INUNoEQ55EchLc+DW2s9Ezhklfs8H8rqskQE3gqFxDuMZYXK3RhnP9VN4IrwyAFjKetmQ5
 MesRx7swuajQ9UJYkH9mWf2aAcgxu9CG+nwuYVzxCVhZ1DoqrUsBryiqpTFDtaHZkvCoIs
 RADdlVKQ9nRXRaoVW8dtZeW8pbxxar4=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-662-NUa0pAyoNFeFcV2lYNKnZg-1; Mon,
 27 Oct 2025 11:11:11 -0400
X-MC-Unique: NUa0pAyoNFeFcV2lYNKnZg-1
X-Mimecast-MFC-AGG-ID: NUa0pAyoNFeFcV2lYNKnZg_1761577868
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id E31DF1800451; Mon, 27 Oct 2025 15:11:06 +0000 (UTC)
Received: from localhost (unknown [10.45.242.5])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id AD6191800579; Mon, 27 Oct 2025 15:11:04 +0000 (UTC)
From: marcandre.lureau@redhat.com
To: qemu-devel@nongnu.org
Cc: Alexandre Ratchov <alex@caoua.org>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Jan Kiszka <jan.kiszka@web.de>, "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Yanan Wang <wangyanan55@huawei.com>, Thomas Huth <huth@tuxfamily.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Gerd Hoffmann <kraxel@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>, qemu-ppc@nongnu.org,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 =?UTF-8?q?Herv=C3=A9=20Poussineau?= <hpoussin@reactos.org>,
 qemu-arm@nongnu.org, Alistair Francis <alistair@alistair23.me>,
 Zhao Liu <zhao1.liu@intel.com>,
 =?UTF-8?q?Volker=20R=C3=BCmelin?= <vr_qemu@t-online.de>,
 Christian Schoenebeck <qemu_oss@crudebyte.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 BALATON Zoltan <balaton@eik.bme.hu>, Laurent Vivier <laurent@vivier.eu>
Subject: [PATCH v3 02/35] hw/audio: look up the default bus from the device
 class
Date: Mon, 27 Oct 2025 19:10:09 +0400
Message-ID: <20251027151045.2863176-3-marcandre.lureau@redhat.com>
In-Reply-To: <20251027151045.2863176-1-marcandre.lureau@redhat.com>
References: <20251027151045.2863176-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001,
 RCVD_IN_MSPIKE_WL=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
index 63a6855635..29158c115c 100644
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



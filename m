Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 06F1E7EC6F2
	for <lists+qemu-devel@lfdr.de>; Wed, 15 Nov 2023 16:15:10 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r3HaS-0004DC-O3; Wed, 15 Nov 2023 10:13:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1r3HZl-0003ue-3L
 for qemu-devel@nongnu.org; Wed, 15 Nov 2023 10:13:12 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1r3HZe-0003Fz-Rz
 for qemu-devel@nongnu.org; Wed, 15 Nov 2023 10:13:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1700061173;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ufPmoErkPOcsfutWdcjiUmWq22i+A4yQqAPSFLyrQtY=;
 b=QF561aZBaWsgw+q4aQ9NvEqhk1V2YQCcXJHvYQgYTqrqKuQo5t0pIHYpRF17lsbkZ/GpyV
 6f1eCJwFZrjiMr3SFFkUDKBXjpuJWXRGnpWuDuuNn4H1rgNcdDBNV3PjUuxsiFAUWMPlvl
 0yNnbXVwurpgOCreo7LHGxOHX04SA60=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-141-e_tT9oE_NMCmevnKCfsAqg-1; Wed, 15 Nov 2023 10:12:47 -0500
X-MC-Unique: e_tT9oE_NMCmevnKCfsAqg-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com
 [10.11.54.9])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id F3FAD85A58C;
 Wed, 15 Nov 2023 15:12:46 +0000 (UTC)
Received: from sirius.home.kraxel.org (unknown [10.39.192.56])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id AB5F6492BE0;
 Wed, 15 Nov 2023 15:12:46 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id 98399180AC0C; Wed, 15 Nov 2023 16:12:42 +0100 (CET)
From: Gerd Hoffmann <kraxel@redhat.com>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, Eric Blake <eblake@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Michael Roth <michael.roth@amd.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?L=C3=A1szl=C3=B3=20=C3=89rsek?= <lersek@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 graf@amazon.com,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Markus Armbruster <armbru@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>
Subject: [PATCH 04/16] hw/uefi: add var-service-guid.c
Date: Wed, 15 Nov 2023 16:12:26 +0100
Message-ID: <20231115151242.184645-5-kraxel@redhat.com>
In-Reply-To: <20231115151242.184645-1-kraxel@redhat.com>
References: <20231115151242.184645-1-kraxel@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.9
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kraxel@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.099,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Add variables for a bunch of GUIDs we will need.

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 hw/uefi/var-service-guid.c | 61 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 61 insertions(+)
 create mode 100644 hw/uefi/var-service-guid.c

diff --git a/hw/uefi/var-service-guid.c b/hw/uefi/var-service-guid.c
new file mode 100644
index 000000000000..afdc15c4e7e6
--- /dev/null
+++ b/hw/uefi/var-service-guid.c
@@ -0,0 +1,61 @@
+/*
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ *
+ * uefi vars device - GUIDs
+ */
+
+#include "qemu/osdep.h"
+#include "sysemu/dma.h"
+
+#include "hw/uefi/var-service.h"
+
+/* variable namespaces */
+
+QemuUUID EfiGlobalVariable = {
+    .data = UUID_LE(0x8be4df61, 0x93ca, 0x11d2, 0xaa, 0x0d,
+                    0x00, 0xe0, 0x98, 0x03, 0x2b, 0x8c)
+};
+
+QemuUUID EfiImageSecurityDatabase = {
+    .data = UUID_LE(0xd719b2cb, 0x3d3a, 0x4596, 0xa3, 0xbc,
+                    0xda, 0xd0, 0x0e, 0x67, 0x65, 0x6f)
+};
+
+QemuUUID EfiCustomModeEnable = {
+    .data = UUID_LE(0xc076ec0c, 0x7028, 0x4399, 0xa0, 0x72,
+                    0x71, 0xee, 0x5c, 0x44, 0x8b, 0x9f)
+};
+
+QemuUUID EfiSecureBootEnableDisable = {
+    .data = UUID_LE(0xf0a30bc7, 0xaf08, 0x4556, 0x99, 0xc4,
+                    0x0, 0x10, 0x9, 0xc9, 0x3a, 0x44)
+};
+
+/* protocols */
+
+QemuUUID EfiSmmVariableProtocolGuid = {
+    .data = UUID_LE(0xed32d533, 0x99e6, 0x4209, 0x9c, 0xc0,
+                    0x2d, 0x72, 0xcd, 0xd9, 0x98, 0xa7)
+};
+
+QemuUUID VarCheckPolicyLibMmiHandlerGuid = {
+    .data = UUID_LE(0xda1b0d11, 0xd1a7, 0x46c4, 0x9d, 0xc9,
+                    0xf3, 0x71, 0x48, 0x75, 0xc6, 0xeb)
+};
+
+/* events */
+
+QemuUUID EfiEndOfDxeEventGroupGuid = {
+    .data = UUID_LE(0x02CE967A, 0xDD7E, 0x4FFC, 0x9E, 0xE7,
+                    0x81, 0x0C, 0xF0, 0x47, 0x08, 0x80)
+};
+
+QemuUUID EfiEventReadyToBootGuid = {
+    .data = UUID_LE(0x7CE88FB3, 0x4BD7, 0x4679, 0x87, 0xA8,
+                    0xA8, 0xD8, 0xDE, 0xE5, 0x0D, 0x2B)
+};
+
+QemuUUID EfiEventExitBootServicesGuid = {
+    .data = UUID_LE(0x27ABF055, 0xB1B8, 0x4C26, 0x80, 0x48,
+                    0x74, 0x8F, 0x37, 0xBA, 0xA2, 0xDF)
+};
-- 
2.41.0



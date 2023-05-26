Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E0F22712571
	for <lists+qemu-devel@lfdr.de>; Fri, 26 May 2023 13:29:28 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q2VcE-0004XJ-V1; Fri, 26 May 2023 07:28:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <slp@redhat.com>) id 1q2VcB-0004Qs-OM
 for qemu-devel@nongnu.org; Fri, 26 May 2023 07:28:11 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <slp@redhat.com>) id 1q2VcA-0003Su-5l
 for qemu-devel@nongnu.org; Fri, 26 May 2023 07:28:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1685100489;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=YmJGY41XqyCGRPeTDO3+MBEiUMQeBjAmMfYNNBfiDjs=;
 b=SLGngGVmt+X0NEdr0HvQLk5oJQ79ybSgD5YQqxpn1UpMfRorEOG1ihW77S76hMJwQZd4K1
 4IWzCION4Kg+ZL7lx6ygwa3g3FE7r7YAReM0YCZTeQ13IrGsEvYyEw4Q/COroF891zd0j/
 E/Zoud/MBs8HxKhtVmkhJFj541tIcKg=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-96-eOU4Hxu7NAyD80VmRcI4xA-1; Fri, 26 May 2023 07:28:07 -0400
X-MC-Unique: eOU4Hxu7NAyD80VmRcI4xA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com
 [10.11.54.7])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 77CA3800159;
 Fri, 26 May 2023 11:28:07 +0000 (UTC)
Received: from toolbox.redhat.com (unknown [10.39.194.90])
 by smtp.corp.redhat.com (Postfix) with ESMTP id C4EDB140E95D;
 Fri, 26 May 2023 11:28:05 +0000 (UTC)
From: Sergio Lopez <slp@redhat.com>
To: qemu-devel@nongnu.org
Cc: Eric Blake <eblake@redhat.com>, Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Sergio Lopez <slp@redhat.com>
Subject: [PATCH v5 1/6] virtio-input: generalize virtio_input_key_config()
Date: Fri, 26 May 2023 13:29:20 +0200
Message-Id: <20230526112925.38794-2-slp@redhat.com>
In-Reply-To: <20230526112925.38794-1-slp@redhat.com>
References: <20230526112925.38794-1-slp@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.7
Received-SPF: pass client-ip=170.10.133.124; envelope-from=slp@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

As there are other bitmap-based config properties that need to be dealt in a
similar fashion as VIRTIO_INPUT_CFG_EV_BITS, generalize the function to
receive select and subsel as arguments, and rename it to
virtio_input_extend_config()

Signed-off-by: Sergio Lopez <slp@redhat.com>
Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 hw/input/virtio-input-hid.c | 38 ++++++++++++++++++++-----------------
 1 file changed, 21 insertions(+), 17 deletions(-)

diff --git a/hw/input/virtio-input-hid.c b/hw/input/virtio-input-hid.c
index a7a244a95d..d28dab69ba 100644
--- a/hw/input/virtio-input-hid.c
+++ b/hw/input/virtio-input-hid.c
@@ -44,30 +44,31 @@ static const unsigned short axismap_abs[INPUT_AXIS__MAX] = {
 
 /* ----------------------------------------------------------------- */
 
-static void virtio_input_key_config(VirtIOInput *vinput,
-                                    const unsigned short *keymap,
-                                    size_t mapsize)
+static void virtio_input_extend_config(VirtIOInput *vinput,
+                                       const unsigned short *map,
+                                       size_t mapsize,
+                                       uint8_t select, uint8_t subsel)
 {
-    virtio_input_config keys;
+    virtio_input_config ext;
     int i, bit, byte, bmax = 0;
 
-    memset(&keys, 0, sizeof(keys));
+    memset(&ext, 0, sizeof(ext));
     for (i = 0; i < mapsize; i++) {
-        bit = keymap[i];
+        bit = map[i];
         if (!bit) {
             continue;
         }
         byte = bit / 8;
         bit  = bit % 8;
-        keys.u.bitmap[byte] |= (1 << bit);
+        ext.u.bitmap[byte] |= (1 << bit);
         if (bmax < byte+1) {
             bmax = byte+1;
         }
     }
-    keys.select = VIRTIO_INPUT_CFG_EV_BITS;
-    keys.subsel = EV_KEY;
-    keys.size   = bmax;
-    virtio_input_add_config(vinput, &keys);
+    ext.select = select;
+    ext.subsel = subsel;
+    ext.size   = bmax;
+    virtio_input_add_config(vinput, &ext);
 }
 
 static void virtio_input_handle_event(DeviceState *dev, QemuConsole *src,
@@ -281,8 +282,9 @@ static void virtio_keyboard_init(Object *obj)
 
     vhid->handler = &virtio_keyboard_handler;
     virtio_input_init_config(vinput, virtio_keyboard_config);
-    virtio_input_key_config(vinput, qemu_input_map_qcode_to_linux,
-                            qemu_input_map_qcode_to_linux_len);
+    virtio_input_extend_config(vinput, qemu_input_map_qcode_to_linux,
+                               qemu_input_map_qcode_to_linux_len,
+                               VIRTIO_INPUT_CFG_EV_BITS, EV_KEY);
 }
 
 static const TypeInfo virtio_keyboard_info = {
@@ -373,8 +375,9 @@ static void virtio_mouse_init(Object *obj)
     virtio_input_init_config(vinput, vhid->wheel_axis
                              ? virtio_mouse_config_v2
                              : virtio_mouse_config_v1);
-    virtio_input_key_config(vinput, keymap_button,
-                            ARRAY_SIZE(keymap_button));
+    virtio_input_extend_config(vinput, keymap_button,
+                               ARRAY_SIZE(keymap_button),
+                               VIRTIO_INPUT_CFG_EV_BITS, EV_KEY);
 }
 
 static const TypeInfo virtio_mouse_info = {
@@ -497,8 +500,9 @@ static void virtio_tablet_init(Object *obj)
     virtio_input_init_config(vinput, vhid->wheel_axis
                              ? virtio_tablet_config_v2
                              : virtio_tablet_config_v1);
-    virtio_input_key_config(vinput, keymap_button,
-                            ARRAY_SIZE(keymap_button));
+    virtio_input_extend_config(vinput, keymap_button,
+                               ARRAY_SIZE(keymap_button),
+                               VIRTIO_INPUT_CFG_EV_BITS, EV_KEY);
 }
 
 static const TypeInfo virtio_tablet_info = {
-- 
2.38.1



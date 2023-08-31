Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5132E78F4DA
	for <lists+qemu-devel@lfdr.de>; Thu, 31 Aug 2023 23:52:12 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qbpZU-0008CB-Nv; Thu, 31 Aug 2023 17:51:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Wilhelm.Golz@secunet.com>)
 id 1qbjJb-0003m8-Hi
 for qemu-devel@nongnu.org; Thu, 31 Aug 2023 11:10:36 -0400
Received: from a.mx.secunet.com ([62.96.220.36])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Wilhelm.Golz@secunet.com>)
 id 1qbjJX-0005re-FC
 for qemu-devel@nongnu.org; Thu, 31 Aug 2023 11:10:35 -0400
Received: from localhost (localhost [127.0.0.1])
 by a.mx.secunet.com (Postfix) with ESMTP id CE4602087B
 for <qemu-devel@nongnu.org>; Thu, 31 Aug 2023 17:10:26 +0200 (CEST)
X-Virus-Scanned: by secunet
Received: from a.mx.secunet.com ([127.0.0.1])
 by localhost (a.mx.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id f292osK9X9uL for <qemu-devel@nongnu.org>;
 Thu, 31 Aug 2023 17:10:26 +0200 (CEST)
Received: from mailout1.secunet.com (mailout1.secunet.com [62.96.220.44])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by a.mx.secunet.com (Postfix) with ESMTPS id 0BD6A20748
 for <qemu-devel@nongnu.org>; Thu, 31 Aug 2023 17:10:26 +0200 (CEST)
Received: from cas-essen-02.secunet.de (unknown [10.53.40.202])
 by mailout1.secunet.com (Postfix) with ESMTP id F167280004A
 for <qemu-devel@nongnu.org>; Thu, 31 Aug 2023 17:10:25 +0200 (CEST)
Received: from mbx-essen-02.secunet.de (10.53.40.198) by
 cas-essen-02.secunet.de (10.53.40.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Thu, 31 Aug 2023 17:10:25 +0200
Received: from mbx-essen-02.secunet.de (10.53.40.198) by
 mbx-essen-02.secunet.de (10.53.40.198) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Thu, 31 Aug 2023 17:10:25 +0200
Received: from mbx-essen-02.secunet.de ([fe80::fcaf:ee74:71ad:4eff]) by
 mbx-essen-02.secunet.de ([fe80::fcaf:ee74:71ad:4eff%8]) with mapi id
 15.01.2507.027; Thu, 31 Aug 2023 17:10:25 +0200
From: "Golz, Wilhelm" <Wilhelm.Golz@secunet.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Subject: [PATCH] add option for a multislot usb ccid device
Thread-Topic: [PATCH] add option for a multislot usb ccid device
Thread-Index: AdncHNvamnKWG/MCSqOMCx2qCEwU0Q==
Date: Thu, 31 Aug 2023 15:10:25 +0000
Message-ID: <2685e8e4bc6f41bf80010c33cdb5c7bc@secunet.com>
Accept-Language: de-DE, en-US
Content-Language: de-DE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-EXCLAIMER-MD-CONFIG: 2c86f778-e09b-4440-8b15-867914633a10
Received-SPF: pass client-ip=62.96.220.36;
 envelope-from=Wilhelm.Golz@secunet.com; helo=a.mx.secunet.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Thu, 31 Aug 2023 17:51:21 -0400
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

Signed-off-by: Wilhelm Golz <wilhelm.golz@secunet.com>

hw/usb/dev-smartcard-reader.c:
add option for a multislot usb ccid device, similar to audio multi.

---
 hw/usb/dev-smartcard-reader.c | 106 +++++++++++++++++++++++++++++++++-
 1 file changed, 103 insertions(+), 3 deletions(-)

diff --git a/hw/usb/dev-smartcard-reader.c b/hw/usb/dev-smartcard-
reader.c
index be0a4fc3bc..30d8892b4e 100644
--- a/hw/usb/dev-smartcard-reader.c
+++ b/hw/usb/dev-smartcard-reader.c
@@ -90,10 +90,13 @@ OBJECT_DECLARE_SIMPLE_TYPE(USBCCIDState,
USB_CCID_DEV)
  *  usbccid.sys (winxp, others untested) is a class driver so it
doesn't care.
  *  linux has a number of class drivers, but openct filters based on
  *   vendor/product (/etc/openct.conf under fedora), hence Gemplus.
+ * Use a Omnikey/HID 3121 with multislot for distinction.
  */
 #define CCID_VENDOR_ID                  0x08e6
 #define CCID_PRODUCT_ID                 0x4433
 #define CCID_DEVICE_VERSION             0x0000
+#define CCID_VENDOR_ID_MULTI            0x076b
+#define CCID_PRODUCT_ID_MULTI           0x3021
=20
 /*
  * BULK_OUT messages from PC to Reader
@@ -312,7 +315,9 @@ struct USBCCIDState {
     uint8_t  bmSlotICCState;
     uint8_t  powered;
     uint8_t  notify_slot_change;
+    /* properties */
     uint8_t  debug;
+    bool     multi;
 };
=20
 /*
@@ -411,6 +416,34 @@ static const uint8_t qemu_ccid_descriptor[] =3D {
         0x01,       /* u8  bMaxCCIDBusySlots; */
 };
=20
+static const uint8_t qemu_ccid_descriptor_multi[] =3D {
+        /* Smart Card Device Class Descriptor */
+        0x36,       /* u8  bLength; */
+        0x21,       /* u8  bDescriptorType; Functional */
+        0x10, 0x01, /* u16 bcdCCID; CCID Specification Release Number.
*/
+        0x0e,       /* u8  bMaxSlotIndex; 14, as 16 slots can cause
trouble. */
+        0x07,       /* u8  bVoltageSupport; 01h - 5.0v, 02h - 3.0, 03
- 1.8 */
+
+        0x01, 0x00, /* u32 dwProtocols; RRRR PPPP. RRRR =3D 0000h.*/
+        0x00, 0x00, /* PPPP: see above */
+        0xa0, 0x0f, 0x00, 0x00, /* u32 dwMaximumClock; */
+        0x00, 0x00, 0x01, 0x00,
+        0x00, /* u8 bNumClockSupported; see above */
+        0x80, 0x25, 0x00, 0x00, /* u32 dwMaxDataRate ; see above */
+        0x00, 0xC2, 0x01, 0x00,
+        0x00,       /* u8  bNumDataRatesSupported; see above */
+        0xfe, 0x00, 0x00, 0x00, /* u32 dwMaxIFSD; see above */
+        0x00, 0x00, 0x00, 0x00, /* u32 dwSyncProtocols; see above */
+        0x00, 0x00, 0x00, 0x00, /* u32 dwMechanical; see above */
+        0xfe, 0x04, 0x04, 0x00, /* u32 dwFeatures; 400 for better
compat. */
+        0x12, 0x00, 0x01, 0x00, /* u32 dwMaxCCIDMessageLength; see
above */
+        0xFF,       /* u8  bClassGetResponse; see above */
+        0xFF,       /* u8  bClassEnvelope; see above */
+        0x00, 0x00, /* u16 wLcdLayout; see above */
+        0x01,       /* u8  bPINSupport; see above */
+        0x0f,       /* u8  bMaxCCIDBusySlots; modified from 1 */
+};
+
 enum {
     STR_MANUFACTURER =3D 1,
     STR_PRODUCT,
@@ -457,6 +490,38 @@ static const USBDescIface desc_iface0 =3D {
     }
 };
=20
+static const USBDescIface desc_iface0_multi =3D {
+    .bInterfaceNumber              =3D 0,
+    .bNumEndpoints                 =3D 3,
+    .bInterfaceClass               =3D USB_CLASS_CSCID,
+    .bInterfaceSubClass            =3D USB_SUBCLASS_UNDEFINED,
+    .bInterfaceProtocol            =3D 0x00,
+    .iInterface                    =3D STR_INTERFACE,
+    .ndesc                         =3D 1,
+    .descs =3D (USBDescOther[]) {
+        {
+            /* smartcard descriptor */
+            .data =3D qemu_ccid_descriptor_multi,
+        },
+    },
+    .eps =3D (USBDescEndpoint[]) {
+        {
+            .bEndpointAddress      =3D USB_DIR_IN | CCID_INT_IN_EP,
+            .bmAttributes          =3D USB_ENDPOINT_XFER_INT,
+            .bInterval             =3D 255,
+            .wMaxPacketSize        =3D 64,
+        },{
+            .bEndpointAddress      =3D USB_DIR_IN | CCID_BULK_IN_EP,
+            .bmAttributes          =3D USB_ENDPOINT_XFER_BULK,
+            .wMaxPacketSize        =3D 64,
+        },{
+            .bEndpointAddress      =3D USB_DIR_OUT | CCID_BULK_OUT_EP,
+            .bmAttributes          =3D USB_ENDPOINT_XFER_BULK,
+            .wMaxPacketSize        =3D 64,
+        },
+    }
+};
+
 static const USBDescDevice desc_device =3D {
     .bcdUSB                        =3D 0x0110,
     .bMaxPacketSize0               =3D 64,
@@ -474,6 +539,23 @@ static const USBDescDevice desc_device =3D {
     },
 };
=20
+static const USBDescDevice desc_device_multi =3D {
+    .bcdUSB                        =3D 0x0110,
+    .bMaxPacketSize0               =3D 64,
+    .bNumConfigurations            =3D 1,
+    .confs =3D (USBDescConfig[]) {
+        {
+            .bNumInterfaces        =3D 1,
+            .bConfigurationValue   =3D 1,
+            .bmAttributes          =3D USB_CFG_ATT_ONE |
USB_CFG_ATT_SELFPOWER |
+                                     USB_CFG_ATT_WAKEUP,
+            .bMaxPower             =3D 50,
+            .nif =3D 1,
+            .ifs =3D &desc_iface0_multi,
+        },
+    },
+};
+
 static const USBDesc desc_ccid =3D {
     .id =3D {
         .idVendor          =3D CCID_VENDOR_ID,
@@ -487,6 +569,19 @@ static const USBDesc desc_ccid =3D {
     .str  =3D desc_strings,
 };
=20
+static const USBDesc desc_ccid_multi =3D {
+    .id =3D {
+        .idVendor          =3D CCID_VENDOR_ID_MULTI,
+        .idProduct         =3D CCID_PRODUCT_ID_MULTI,
+        .bcdDevice         =3D CCID_DEVICE_VERSION,
+        .iManufacturer     =3D STR_MANUFACTURER,
+        .iProduct          =3D STR_PRODUCT,
+        .iSerialNumber     =3D STR_SERIALNUMBER,
+    },
+    .full =3D &desc_device_multi,
+    .str  =3D desc_strings,
+};
+
 static const uint8_t *ccid_card_get_atr(CCIDCardState *card, uint32_t
*len)
 {
     CCIDCardClass *cc =3D CCID_CARD_GET_CLASS(card);
@@ -1293,10 +1388,12 @@ static void ccid_card_realize(DeviceState
*qdev, Error **errp)
     USBDevice *dev =3D USB_DEVICE(qdev->parent_bus->parent);
     USBCCIDState *s =3D USB_CCID_DEV(dev);
     Error *local_err =3D NULL;
+    const USBDesc *desc =3D usb_device_get_usb_desc(dev);
+    uint8_t bMaxSlotIndex =3D desc->full->confs[0].ifs-
>descs[0].data[4];
=20
-    if (card->slot !=3D 0) {
-        error_setg(errp, "usb-ccid supports one slot, can't add %d",
-                   card->slot);
+    if (card->slot > bMaxSlotIndex) {
+        error_setg(errp, "usb-ccid supports %d slots, can't add %d",
+                   bMaxSlotIndex + 1, card->slot);
         return;
     }
     if (s->card !=3D NULL) {
@@ -1317,6 +1414,8 @@ static void ccid_realize(USBDevice *dev, Error
**errp)
 {
     USBCCIDState *s =3D USB_CCID_DEV(dev);
=20
+    dev->usb_desc =3D s->multi ? &desc_ccid_multi : &desc_ccid;
+
     usb_desc_create_serial(dev);
     usb_desc_init(dev);
     qbus_init(&s->bus, sizeof(s->bus), TYPE_CCID_BUS, DEVICE(dev),
NULL);
@@ -1433,6 +1532,7 @@ static const VMStateDescription ccid_vmstate =3D {
=20
 static Property ccid_properties[] =3D {
     DEFINE_PROP_UINT8("debug", USBCCIDState, debug, 0),
+    DEFINE_PROP_BOOL("multi", USBCCIDState, multi, false),
     DEFINE_PROP_END_OF_LIST(),
 };
=20
--=20
2.34.1

--
Wilhelm Golz
Lead Expert Smartcard
Public Authorities Division
secunet Security Networks AG

Fon +49 201 5454-3513
Fax +49 201 5454-1321
Mobil +49 160 90164415
E-Mail: wilhelm.golz@secunet.com


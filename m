Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 417CC710E3E
	for <lists+qemu-devel@lfdr.de>; Thu, 25 May 2023 16:24:26 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q2BlE-0004gM-2X; Thu, 25 May 2023 10:16:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1q2Bkw-0004ZU-4F
 for qemu-devel@nongnu.org; Thu, 25 May 2023 10:15:54 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1q2Bku-0007bn-JV
 for qemu-devel@nongnu.org; Thu, 25 May 2023 10:15:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1685024152;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version: content-type:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ABroPFbR5EhQZSTugO8OF0oPNv+TrnzjottPKbyENqs=;
 b=YAVfjH+Zw/pc5tfn+Kacv7JY/j+jBg0NWiIAfW/TFSHn/e1tktYrm9jOksb0w90Cezl5Ki
 sdFKFz8KI6qz9KBS3EZDGZADDS2rN6lxkS7AJU+akl5nnKseBXzG+kVyed7LF3CKb/JzQJ
 Q1Mqs4bzwF5fuB3qXFF/fwzBz5uLWkA=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-582-VWng_5o6MV2ItsqP7onA5w-1; Thu, 25 May 2023 10:15:50 -0400
X-MC-Unique: VWng_5o6MV2ItsqP7onA5w-1
Received: by mail-ej1-f70.google.com with SMTP id
 a640c23a62f3a-9737cde2ce8so77678966b.1
 for <qemu-devel@nongnu.org>; Thu, 25 May 2023 07:15:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685024149; x=1687616149;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ABroPFbR5EhQZSTugO8OF0oPNv+TrnzjottPKbyENqs=;
 b=Az92Ke4PoCavlhGAR4tHr51uYCVv7CMnCUYyVFy9pg3UoEUpjcw4ojwntMbn+2Bo5j
 xtOQwdakuHe1ZrJV7GP0hO25iknctNCSCHWQnIT+MZzXx+2bo+7eITNBtmM5VemX4iNh
 choVVGLUTVIzQTjJ7FpnNdFXk8xVdnGp2uaxmwRVTrssswP7lVHLaVR+lgpJZgU90zfX
 H2aN+bOFzP/+pe0+X2z6MSD7Egf8l1ugaWZFNBPI/Vy6ZVos6+5cvpLzK14ZZ/UB92V2
 ALfNLPr7jv/9lxq/WS7k/JpJAnmS3lAk05YIwRuRJ54c/EmSK6EyxUGbbT+mroZ0AdO8
 Jy3Q==
X-Gm-Message-State: AC+VfDy2GvRDx47PA6ug8kRr06aG2ojrlJo0h88DXSXwQ/iUfiR+Uk8z
 9Znu8M/Fp5rCrzYrx7TVcAT4wml2KcMGnZPhp8yOXfK1TeU1NVVTlKq94XVr1voDiBcHGShablN
 s/4AtvojF0fpgKF1RfuKwLDQmOZl7wUcueE402TuPJQBf7meyU0kL0TPGY6H2LzUVbZRIiWktfE
 E=
X-Received: by 2002:a17:906:730f:b0:971:fa86:28b with SMTP id
 di15-20020a170906730f00b00971fa86028bmr1989571ejc.23.1685024149119; 
 Thu, 25 May 2023 07:15:49 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ4MJrR+KYXq3Z0wu4wXCm86UZbozCQIy7JSmZzR3+IzTxar8q76UKsqI5Tc5k3/i3k7PBvkiw==
X-Received: by 2002:a17:906:730f:b0:971:fa86:28b with SMTP id
 di15-20020a170906730f00b00971fa86028bmr1989548ejc.23.1685024148775; 
 Thu, 25 May 2023 07:15:48 -0700 (PDT)
Received: from [192.168.10.117] ([2001:b07:6468:f312:48f9:bea:a04c:3dfe])
 by smtp.gmail.com with ESMTPSA id
 n11-20020a170906378b00b0096b4ec45e10sm891325ejc.139.2023.05.25.07.15.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 25 May 2023 07:15:48 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 10/20] softmmu/ioport.c: QOMify MemoryRegionPortioList
Date: Thu, 25 May 2023 16:15:22 +0200
Message-Id: <20230525141532.295817-11-pbonzini@redhat.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230525141532.295817-1-pbonzini@redhat.com>
References: <20230525141532.295817-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
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

From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>

The aim of QOMification is so that the lifetime of the MemoryRegionPortioList
structure can be managed using QOM's in-built refcounting instead of having to
handle this manually.

Due to the use of an opaque pointer it isn't possible to model the new
TYPE_MEMORY_REGION_PORTIO_LIST directly using QOM properties, however since
use of the new object is restricted to the portio API we can simply set the
opaque pointer (and the heap-allocated port list) internally.

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-Id: <20230419151652.362717-3-mark.cave-ayland@ilande.co.uk>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 softmmu/ioport.c | 36 +++++++++++++++++++++++++++++++-----
 1 file changed, 31 insertions(+), 5 deletions(-)

diff --git a/softmmu/ioport.c b/softmmu/ioport.c
index d0d5b0bcaa2d..33720fe5664a 100644
--- a/softmmu/ioport.c
+++ b/softmmu/ioport.c
@@ -32,11 +32,16 @@
 #include "exec/address-spaces.h"
 #include "trace.h"
 
-typedef struct MemoryRegionPortioList {
+struct MemoryRegionPortioList {
+    Object obj;
+
     MemoryRegion mr;
     void *portio_opaque;
     MemoryRegionPortio *ports;
-} MemoryRegionPortioList;
+};
+
+#define TYPE_MEMORY_REGION_PORTIO_LIST "memory-region-portio-list"
+OBJECT_DECLARE_SIMPLE_TYPE(MemoryRegionPortioList, MEMORY_REGION_PORTIO_LIST)
 
 static uint64_t unassigned_io_read(void *opaque, hwaddr addr, unsigned size)
 {
@@ -147,8 +152,7 @@ void portio_list_destroy(PortioList *piolist)
     for (i = 0; i < piolist->nr; ++i) {
         mrpio = container_of(piolist->regions[i], MemoryRegionPortioList, mr);
         object_unparent(OBJECT(&mrpio->mr));
-        g_free(mrpio->ports);
-        g_free(mrpio);
+        object_unref(mrpio);
     }
     g_free(piolist->regions);
 }
@@ -228,7 +232,8 @@ static void portio_list_add_1(PortioList *piolist,
     unsigned i;
 
     /* Copy the sub-list and null-terminate it.  */
-    mrpio = g_malloc0(sizeof(MemoryRegionPortioList));
+    mrpio = MEMORY_REGION_PORTIO_LIST(
+                object_new(TYPE_MEMORY_REGION_PORTIO_LIST));
     mrpio->portio_opaque = piolist->opaque;
     mrpio->ports = g_malloc0(sizeof(MemoryRegionPortio) * (count + 1));
     memcpy(mrpio->ports, pio_init, sizeof(MemoryRegionPortio) * count);
@@ -298,3 +303,24 @@ void portio_list_del(PortioList *piolist)
         memory_region_del_subregion(piolist->address_space, &mrpio->mr);
     }
 }
+
+static void memory_region_portio_list_finalize(Object *obj)
+{
+    MemoryRegionPortioList *mrpio = MEMORY_REGION_PORTIO_LIST(obj);
+
+    g_free(mrpio->ports);
+}
+
+static const TypeInfo memory_region_portio_list_info = {
+    .parent             = TYPE_OBJECT,
+    .name               = TYPE_MEMORY_REGION_PORTIO_LIST,
+    .instance_size      = sizeof(MemoryRegionPortioList),
+    .instance_finalize  = memory_region_portio_list_finalize,
+};
+
+static void ioport_register_types(void)
+{
+    type_register_static(&memory_region_portio_list_info);
+}
+
+type_init(ioport_register_types)
-- 
2.40.1



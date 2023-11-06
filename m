Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C1C77E25C0
	for <lists+qemu-devel@lfdr.de>; Mon,  6 Nov 2023 14:34:46 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qzziX-0005cQ-FI; Mon, 06 Nov 2023 08:32:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1qzziT-0005ab-Sn
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 08:32:33 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1qzziS-0003ig-Ca
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 08:32:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1699277551;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cYuUp10LJDHg0e5GrrLE1lgcNt3x8CO/RHbp1MrnHA0=;
 b=CJBsLCNWwmbuloB0WDWtRO4+/TC3e+cF28QZ7Uz416IuQyGinbywhMyY0CCCqPViGyxt8p
 +mgvFdIOiBvSkgXITuc5USLGR9QbSNMiSyWxQ/TcwoGWwalf3onKxjV95gKNIAvGTyPIaZ
 BkumD9ISBVUYbh+OYJSAL3K5VF37pgc=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-164-oOnRr4exN8aAsHuGayqvrQ-1; Mon,
 06 Nov 2023 08:32:28 -0500
X-MC-Unique: oOnRr4exN8aAsHuGayqvrQ-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com
 [10.11.54.9])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id B1F193C0FC8E;
 Mon,  6 Nov 2023 13:32:27 +0000 (UTC)
Received: from localhost (unknown [10.39.208.31])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 2D4D6492BE0;
 Mon,  6 Nov 2023 13:32:25 +0000 (UTC)
From: marcandre.lureau@redhat.com
To: qemu-devel@nongnu.org
Cc: stefanha@redhat.com, Cong Liu <liucong2@kylinos.cn>,
 "Michael S. Tsirkin" <mst@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>
Subject: [PULL 01/10] virtio-gpu-rutabaga: Add empty interface to fix arm64
 crash
Date: Mon,  6 Nov 2023 17:32:10 +0400
Message-ID: <20231106133219.2173660-2-marcandre.lureau@redhat.com>
In-Reply-To: <20231106133219.2173660-1-marcandre.lureau@redhat.com>
References: <20231106133219.2173660-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.9
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

From: Cong Liu <liucong2@kylinos.cn>

Add an empty element to the interfaces array, which is consistent with
the behavior of other devices in qemu and fixes the crash on arm64.

0  0x0000fffff5c18550 in  () at /usr/lib64/libc.so.6
1  0x0000fffff6c9cd6c in g_strdup () at /usr/lib64/libglib-2.0.so.0
2  0x0000aaaaab4945d8 in g_strdup_inline (str=<optimized out>) at /usr/include/glib-2.0/glib/gstrfuncs.h:321
3  type_new (info=info@entry=0xaaaaabc1b2c8 <virtio_gpu_rutabaga_pci_info>) at ../qom/object.c:133
4  0x0000aaaaab494f14 in type_register_internal (info=0xaaaaabc1b2c8 <virtio_gpu_rutabaga_pci_info>) at ../qom/object.c:143
5  type_register (info=0xaaaaabc1b2c8 <virtio_gpu_rutabaga_pci_info>) at ../qom/object.c:152
6  type_register_static (info=0xaaaaabc1b2c8 <virtio_gpu_rutabaga_pci_info>) at ../qom/object.c:157
7  type_register_static_array (infos=<optimized out>, nr_infos=<optimized out>) at ../qom/object.c:165
8  0x0000aaaaab6147e8 in module_call_init (type=type@entry=MODULE_INIT_QOM) at ../util/module.c:109
9  0x0000aaaaab10a0ec in qemu_init_subsystems () at ../system/runstate.c:817
10 0x0000aaaaab10d334 in qemu_init (argc=13, argv=0xfffffffff198) at ../system/vl.c:2760
11 0x0000aaaaaae4da6c in main (argc=<optimized out>, argv=<optimized out>) at ../system/main.c:47

Signed-off-by: Cong Liu <liucong2@kylinos.cn>
Reviewed-by: Gurchetan Singh <gurchetansingh@chromium.org>
Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Message-Id: <20231031012515.15504-1-liucong2@kylinos.cn>
---
 hw/display/virtio-gpu-pci-rutabaga.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/hw/display/virtio-gpu-pci-rutabaga.c b/hw/display/virtio-gpu-pci-rutabaga.c
index c96729e198..abbb898c65 100644
--- a/hw/display/virtio-gpu-pci-rutabaga.c
+++ b/hw/display/virtio-gpu-pci-rutabaga.c
@@ -36,6 +36,7 @@ static const TypeInfo virtio_gpu_rutabaga_pci_info[] = {
         .instance_init = virtio_gpu_rutabaga_initfn,
         .interfaces = (InterfaceInfo[]) {
             { INTERFACE_CONVENTIONAL_PCI_DEVICE },
+            { },
         }
     },
 };
-- 
2.41.0



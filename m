Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DFEF710E3D
	for <lists+qemu-devel@lfdr.de>; Thu, 25 May 2023 16:24:11 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q2BlE-0004hj-P8; Thu, 25 May 2023 10:16:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1q2Bkx-0004a8-8C
 for qemu-devel@nongnu.org; Thu, 25 May 2023 10:15:55 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1q2Bkv-0007c7-Ok
 for qemu-devel@nongnu.org; Thu, 25 May 2023 10:15:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1685024153;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version: content-type:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=BjeS6iLp4UjvPt5HAgjITA24epCPtONvMeAdxiTAED0=;
 b=MBvuDXb5qp2DGtlI6lGOYT+O66uj+1RDsxszT1zLoIpgbx10QDT3SajM0TooqFsD2YRYhO
 U848sgu407uJC83+XX9oHqdtHwkqQEziakSqQUelQSGFv3un45N+0VSo9HBEzVgNqLcSWT
 6pC5X0Zq4xy0/L8tjZ9SYHVe2vgAHwI=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-79-vQfWdsUVM3Cy1I2r2EOvIg-1; Thu, 25 May 2023 10:15:49 -0400
X-MC-Unique: vQfWdsUVM3Cy1I2r2EOvIg-1
Received: by mail-ej1-f72.google.com with SMTP id
 a640c23a62f3a-96fae2a13a5so68292166b.2
 for <qemu-devel@nongnu.org>; Thu, 25 May 2023 07:15:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685024147; x=1687616147;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=BjeS6iLp4UjvPt5HAgjITA24epCPtONvMeAdxiTAED0=;
 b=PyTBlSdQdAjYiPnT7UI3ajHTQOQRJn0BXjpo0UasOthztVzc4jg0xk+WG2lG/cxRR4
 /ugyoLsjfK3hD+0g5Va7EH7upCHNn0DG3LSVOtV3hihNUSQURfON0ph8pLdxIXzRYj7m
 2zVFFpY+M6Ozn8OXT5SBUmCxfTqhJ8rp/NYyDCViilu9WhCNh3Ys1g7zuWChHmPlzPtz
 N6ql0fFPY9tEn0dADHVyyZpy/YRj8UYG1mShaZIB4qPrFLgPoz23w3hHyvNW/Phslao4
 FbBxM30QcbHHYnUWA7LKeq4pcAYfiwAI5wUUirQij9e+tTwp3nA5nJ+1Tq9gsuIGW5Nf
 p1rw==
X-Gm-Message-State: AC+VfDyLQZNjxEx2qMAI7o0bbjo23YoQ+r1NBNMELXd4i4s1SSwIUZ86
 eJ5kvAmJcc0RyEe/LTZfE4bqL/eFUNq9LvvUc4U2zcNw49PIZQFcqSLpF7vtQNZlInuLE/raBwc
 JUlyyVOkaq9pnVGQkKVWi5kDsSuWsnTm6xn/KrKmChdr972snjvzRxtdkmn+o3ugIAZi/S7JMYC
 U=
X-Received: by 2002:a17:906:5d13:b0:96f:893:7f5 with SMTP id
 g19-20020a1709065d1300b0096f089307f5mr2250108ejt.26.1685024147466; 
 Thu, 25 May 2023 07:15:47 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ6AK+5gyTRpTPeWlhzpdkqH9OmzN4PYtoo3ek4IfgmaAdw1Tr3HTXnU5RYMy6TIF/0bkesNcQ==
X-Received: by 2002:a17:906:5d13:b0:96f:893:7f5 with SMTP id
 g19-20020a1709065d1300b0096f089307f5mr2250078ejt.26.1685024147083; 
 Thu, 25 May 2023 07:15:47 -0700 (PDT)
Received: from [192.168.10.117] ([2001:b07:6468:f312:48f9:bea:a04c:3dfe])
 by smtp.gmail.com with ESMTPSA id
 h17-20020a170906111100b0096f782f727esm902735eja.140.2023.05.25.07.15.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 25 May 2023 07:15:46 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 09/20] softmmu/ioport.c: allocate MemoryRegionPortioList ports
 on the heap
Date: Thu, 25 May 2023 16:15:21 +0200
Message-Id: <20230525141532.295817-10-pbonzini@redhat.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230525141532.295817-1-pbonzini@redhat.com>
References: <20230525141532.295817-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
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

In order to facilitate a conversion of MemoryRegionPortioList to a QOM object
move the allocation of MemoryRegionPortioList ports to the heap instead of
using a variable-length member at the end of the MemoryRegionPortioList
structure.

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-Id: <20230419151652.362717-2-mark.cave-ayland@ilande.co.uk>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 softmmu/ioport.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/softmmu/ioport.c b/softmmu/ioport.c
index cb8adb0b9363..d0d5b0bcaa2d 100644
--- a/softmmu/ioport.c
+++ b/softmmu/ioport.c
@@ -35,7 +35,7 @@
 typedef struct MemoryRegionPortioList {
     MemoryRegion mr;
     void *portio_opaque;
-    MemoryRegionPortio ports[];
+    MemoryRegionPortio *ports;
 } MemoryRegionPortioList;
 
 static uint64_t unassigned_io_read(void *opaque, hwaddr addr, unsigned size)
@@ -147,6 +147,7 @@ void portio_list_destroy(PortioList *piolist)
     for (i = 0; i < piolist->nr; ++i) {
         mrpio = container_of(piolist->regions[i], MemoryRegionPortioList, mr);
         object_unparent(OBJECT(&mrpio->mr));
+        g_free(mrpio->ports);
         g_free(mrpio);
     }
     g_free(piolist->regions);
@@ -227,9 +228,9 @@ static void portio_list_add_1(PortioList *piolist,
     unsigned i;
 
     /* Copy the sub-list and null-terminate it.  */
-    mrpio = g_malloc0(sizeof(MemoryRegionPortioList) +
-                      sizeof(MemoryRegionPortio) * (count + 1));
+    mrpio = g_malloc0(sizeof(MemoryRegionPortioList));
     mrpio->portio_opaque = piolist->opaque;
+    mrpio->ports = g_malloc0(sizeof(MemoryRegionPortio) * (count + 1));
     memcpy(mrpio->ports, pio_init, sizeof(MemoryRegionPortio) * count);
     memset(mrpio->ports + count, 0, sizeof(MemoryRegionPortio));
 
-- 
2.40.1



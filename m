Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id F3B5F7BD798
	for <lists+qemu-devel@lfdr.de>; Mon,  9 Oct 2023 11:49:36 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qpmsz-0002Mq-E0; Mon, 09 Oct 2023 05:49:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qpms7-0001wL-Hf
 for qemu-devel@nongnu.org; Mon, 09 Oct 2023 05:48:24 -0400
Received: from mail-ej1-x636.google.com ([2a00:1450:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qpms1-0005yI-1m
 for qemu-devel@nongnu.org; Mon, 09 Oct 2023 05:48:19 -0400
Received: by mail-ej1-x636.google.com with SMTP id
 a640c23a62f3a-99c1c66876aso784349466b.2
 for <qemu-devel@nongnu.org>; Mon, 09 Oct 2023 02:48:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1696844890; x=1697449690; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kTqd6Z2Np7lV/f6CqV3RTrP/+37x/Q8ZcMxW6GyXvyM=;
 b=GodJik7ZZUXsEGY82lt+oEYSiFVxFNOKCvV4q8tJwod13q/JMdvOPc12nalxNN4Fyx
 nL0keWEOobRHBvnpphfMjLztwsNS83Ku5izhet30jvAuzMsR4Xg7Qs1FrbA9ijL2AeVa
 Le1a0eesXyF4Ysdrc4Fxf93D4EDc1kJWgiU8WDyC/QHObY3ekwAx2VQBVXjeadHadznY
 VhHtdH4iUdNqO9QKFKciV0W1uaO2HGPSTw6AxITWLHYqizQmoVyzfhMyYf7VpUaLphXR
 Stn4UJOfK/Ax8yZ5+2ur6vXP/r2ulMiYOMld0KqgSjYWU/ex+jblQU8mxipgHXnda2ud
 E57Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696844890; x=1697449690;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=kTqd6Z2Np7lV/f6CqV3RTrP/+37x/Q8ZcMxW6GyXvyM=;
 b=XnbgFPMvb3MqCXv1nIwlJMnrQ6/KvDmie7Sc/2BfEjUgq5VkRw4MoELwPe8mcpwKDe
 lJRSCcn1aXgjFWBkhq60hWQ3XruCUoW9O3Fi5A5fWJSTvJNZ7KiFX6whLljuUrcjCidT
 T5MqvXdrWZT5VzhCh7rEQX9DcZwn8TMuBVDOTR1umkHhCaYvLNUAw1AkOLE7Z1OFQw0B
 25ildHPbZPbKkqYjZ9CDeBpNolENMewoFMgjl6+A1uyuwMwqssCroVl7zb7FzIN1shOS
 yCFsO79ULSu5hosGCh/wX/YCmQqSDndabuMTCoS3fGw2Q9mRAtnb0g5cFcAGFZTI6IQM
 jqBQ==
X-Gm-Message-State: AOJu0YxyL0Bh0Az+SCLW8A1+Fc0XnAUmOPkdnEgnc1BWG8Euv4YcF4HR
 yD7/GxEH33QYAlN+RW0CgSDpyHGU8J4DQpu4MgY=
X-Google-Smtp-Source: AGHT+IHe2hQdtHDW+3OHr0mq9HxFD2PTUlIdCyT5n6qN7VgZUjNNcJuaHxVuxq9UBBhrs9kLUgOZLQ==
X-Received: by 2002:a17:906:8467:b0:9ae:62ec:f4a1 with SMTP id
 hx7-20020a170906846700b009ae62ecf4a1mr12693439ejc.33.1696844889715; 
 Mon, 09 Oct 2023 02:48:09 -0700 (PDT)
Received: from m1x-phil.lan (thr44-h01-176-170-217-185.dsl.sta.abo.bbox.fr.
 [176.170.217.185]) by smtp.gmail.com with ESMTPSA id
 t27-20020a1709063e5b00b009a168ab6ee2sm6516527eji.164.2023.10.09.02.48.07
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 09 Oct 2023 02:48:09 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Eduardo Habkost <eduardo@habkost.net>,
 Christian Borntraeger <borntraeger@linux.ibm.com>, qemu-s390x@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>, Ani Sinha <anisinha@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Yanan Wang <wangyanan55@huawei.com>, David Hildenbrand <david@redhat.com>,
 Eric Farman <farman@linux.ibm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Thomas Huth <thuth@redhat.com>, Halil Pasic <pasic@linux.ibm.com>,
 Gerd Hoffmann <kraxel@redhat.com>, Ilya Leoshkevich <iii@linux.ibm.com>
Subject: [PATCH 3/6] hw/display/vga: Clean up global variable shadowing
Date: Mon,  9 Oct 2023 11:47:43 +0200
Message-ID: <20231009094747.54240-4-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231009094747.54240-1-philmd@linaro.org>
References: <20231009094747.54240-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::636;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x636.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=unavailable autolearn_force=no
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

Fix:

  hw/display/vga.c:2307:29: error: declaration shadows a variable in the global scope [-Werror,-Wshadow]
                MemoryRegion *address_space_io, bool init_vga_ports)
                            ^
  include/exec/address-spaces.h:35:21: note: previous declaration is here
  extern AddressSpace address_space_io;
                      ^

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/display/vga_int.h | 2 +-
 hw/display/vga.c     | 6 +++---
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/hw/display/vga_int.h b/hw/display/vga_int.h
index 7cf0d11201..94949d8a0c 100644
--- a/hw/display/vga_int.h
+++ b/hw/display/vga_int.h
@@ -157,7 +157,7 @@ static inline int c6_to_8(int v)
 }
 
 bool vga_common_init(VGACommonState *s, Object *obj, Error **errp);
-void vga_init(VGACommonState *s, Object *obj, MemoryRegion *address_space,
+void vga_init(VGACommonState *s, Object *obj, MemoryRegion *io,
               MemoryRegion *address_space_io, bool init_vga_ports);
 MemoryRegion *vga_init_io(VGACommonState *s, Object *obj,
                           const MemoryRegionPortio **vga_ports,
diff --git a/hw/display/vga.c b/hw/display/vga.c
index 37557c3442..bb4cd240ec 100644
--- a/hw/display/vga.c
+++ b/hw/display/vga.c
@@ -2304,7 +2304,7 @@ MemoryRegion *vga_init_io(VGACommonState *s, Object *obj,
 }
 
 void vga_init(VGACommonState *s, Object *obj, MemoryRegion *address_space,
-              MemoryRegion *address_space_io, bool init_vga_ports)
+              MemoryRegion *io, bool init_vga_ports)
 {
     MemoryRegion *vga_io_memory;
     const MemoryRegionPortio *vga_ports, *vbe_ports;
@@ -2324,10 +2324,10 @@ void vga_init(VGACommonState *s, Object *obj, MemoryRegion *address_space,
     if (init_vga_ports) {
         portio_list_init(&s->vga_port_list, obj, vga_ports, s, "vga");
         portio_list_set_flush_coalesced(&s->vga_port_list);
-        portio_list_add(&s->vga_port_list, address_space_io, 0x3b0);
+        portio_list_add(&s->vga_port_list, io, 0x3b0);
     }
     if (vbe_ports) {
         portio_list_init(&s->vbe_port_list, obj, vbe_ports, s, "vbe");
-        portio_list_add(&s->vbe_port_list, address_space_io, 0x1ce);
+        portio_list_add(&s->vbe_port_list, io, 0x1ce);
     }
 }
-- 
2.41.0



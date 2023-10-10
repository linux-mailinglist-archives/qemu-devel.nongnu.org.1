Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B7DDE7BFA5A
	for <lists+qemu-devel@lfdr.de>; Tue, 10 Oct 2023 13:52:22 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qqBGh-0007q9-NE; Tue, 10 Oct 2023 07:51:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qqBGd-0007jd-I8
 for qemu-devel@nongnu.org; Tue, 10 Oct 2023 07:51:15 -0400
Received: from mail-ej1-x632.google.com ([2a00:1450:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qqBGa-00072L-Vf
 for qemu-devel@nongnu.org; Tue, 10 Oct 2023 07:51:14 -0400
Received: by mail-ej1-x632.google.com with SMTP id
 a640c23a62f3a-9b6559cbd74so1011596166b.1
 for <qemu-devel@nongnu.org>; Tue, 10 Oct 2023 04:51:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1696938671; x=1697543471; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RzrCjZN13qxMauL0We9snVrFy91wRwtepgq3lfG8D4Q=;
 b=BmWZQPh/CH71/xrEpyBGM5k69eox6bdhMbjqUl/Gw6WAuFL8byt67OHUYHK6wT9pNu
 17d/cUNC4s+hYiwzOTtQvXB8i+9pz9iqpFhIARlrol3SKDWHfDW7Pwb6rJQPCwQhXOGP
 Ha1/mhbaAtPHzCYdE8pqTU0te3Fkcd+M6+VmJPGlu1W3UNSK+m8o++aD+u3EgP/9t9zt
 /fyXM638tLY/M+pO3kdHlVoUwNOshjErvEwBV25CzbfY0AUoO51UyD7a3pM+ISLb/fG7
 /zPZHmFc6RgAlrcAwTkeg5HUKI64gnx43S5D1R33uKwfmydkgGQCE+VURelMbeUKiPCl
 ylhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696938671; x=1697543471;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=RzrCjZN13qxMauL0We9snVrFy91wRwtepgq3lfG8D4Q=;
 b=i5YMjw7EjDdHD6tYjpX7QNWbkbsytgdxs3MnMBVR867j1wjlXfDGWfQP0iC3dm1DRO
 ZYXNEt7hWzGlL9fUPsWRuBELIxuT9ODnLRg8ndU91Z5uYjQsCY4d9HZjf5eePVdFIWcK
 o0hgjmsn3x/fdcM4OL1idLi3+4l7vyRX+yWA2v0j2wOjsTHrc+efrMDVi3MMOFU6hcM7
 Z7TcheHxDoKaKKa3HdjyfGt5wor6AGYsUCSBsoooYqJEGGL4OlkIrZowDrCDePzjAeB/
 cpADhTJ+CS/E2h1qsevHHPJeMhcm9Q+WAI3uPGd16+0JOElIizwX8Zz9vVo9AIx1YpIV
 VX4A==
X-Gm-Message-State: AOJu0YxAjzLobuEaCg4C43u1nXY4olQ8dVnWw3ik99MoQ3DfpGA0NZlV
 D1fUqzQvQ6SGX+MG40yU92aMBSsFN5ke7ddv6YIalA==
X-Google-Smtp-Source: AGHT+IGH88/ZCco2BOsjObl3KHCcgO8Q0FSG7SssMBIY6BGGOT6a1oJlCDsRtDx6eH+zPFll/25kGw==
X-Received: by 2002:a17:906:209a:b0:9ae:69b8:322b with SMTP id
 26-20020a170906209a00b009ae69b8322bmr15158000ejq.60.1696938670953; 
 Tue, 10 Oct 2023 04:51:10 -0700 (PDT)
Received: from m1x-phil.lan (aif79-h01-176-172-113-148.dsl.sta.abo.bbox.fr.
 [176.172.113.148]) by smtp.gmail.com with ESMTPSA id
 g7-20020a1709067c4700b0099bd1a78ef5sm8320491ejp.74.2023.10.10.04.51.09
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 10 Oct 2023 04:51:10 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Ilya Leoshkevich <iii@linux.ibm.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Halil Pasic <pasic@linux.ibm.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, Yanan Wang <wangyanan55@huawei.com>,
 Eduardo Habkost <eduardo@habkost.net>, Eric Farman <farman@linux.ibm.com>,
 qemu-s390x@nongnu.org, Christian Borntraeger <borntraeger@linux.ibm.com>,
 Thomas Huth <thuth@redhat.com>, Ani Sinha <anisinha@redhat.com>,
 David Hildenbrand <david@redhat.com>
Subject: [PATCH v2 3/6] hw/display/vga: Clean up global variable shadowing
Date: Tue, 10 Oct 2023 13:50:45 +0200
Message-ID: <20231010115048.11856-4-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231010115048.11856-1-philmd@linaro.org>
References: <20231010115048.11856-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::632;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x632.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Rename 'address_space' -> 'legacy_io' and
'address_space_io' -> 'io' to fix:

  hw/display/vga.c:2307:29: error: declaration shadows a variable in the global scope [-Werror,-Wshadow]
                MemoryRegion *address_space_io, bool init_vga_ports)
                            ^
  include/exec/address-spaces.h:35:21: note: previous declaration is here
  extern AddressSpace address_space_io;
                      ^

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/display/vga_int.h |  4 ++--
 hw/display/vga.c     | 12 ++++++------
 2 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/hw/display/vga_int.h b/hw/display/vga_int.h
index 7cf0d11201..0f5db522c2 100644
--- a/hw/display/vga_int.h
+++ b/hw/display/vga_int.h
@@ -157,8 +157,8 @@ static inline int c6_to_8(int v)
 }
 
 bool vga_common_init(VGACommonState *s, Object *obj, Error **errp);
-void vga_init(VGACommonState *s, Object *obj, MemoryRegion *address_space,
-              MemoryRegion *address_space_io, bool init_vga_ports);
+void vga_init(VGACommonState *s, Object *obj,
+              MemoryRegion *legacy_io, MemoryRegion *io, bool init_vga_ports);
 MemoryRegion *vga_init_io(VGACommonState *s, Object *obj,
                           const MemoryRegionPortio **vga_ports,
                           const MemoryRegionPortio **vbe_ports);
diff --git a/hw/display/vga.c b/hw/display/vga.c
index 37557c3442..4dc6535ae5 100644
--- a/hw/display/vga.c
+++ b/hw/display/vga.c
@@ -2303,8 +2303,8 @@ MemoryRegion *vga_init_io(VGACommonState *s, Object *obj,
     return vga_mem;
 }
 
-void vga_init(VGACommonState *s, Object *obj, MemoryRegion *address_space,
-              MemoryRegion *address_space_io, bool init_vga_ports)
+void vga_init(VGACommonState *s, Object *obj,
+              MemoryRegion *legacy_io, MemoryRegion *io, bool init_vga_ports)
 {
     MemoryRegion *vga_io_memory;
     const MemoryRegionPortio *vga_ports, *vbe_ports;
@@ -2313,10 +2313,10 @@ void vga_init(VGACommonState *s, Object *obj, MemoryRegion *address_space,
 
     s->bank_offset = 0;
 
-    s->legacy_address_space = address_space;
+    s->legacy_address_space = legacy_io;
 
     vga_io_memory = vga_init_io(s, obj, &vga_ports, &vbe_ports);
-    memory_region_add_subregion_overlap(address_space,
+    memory_region_add_subregion_overlap(legacy_io,
                                         0x000a0000,
                                         vga_io_memory,
                                         1);
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



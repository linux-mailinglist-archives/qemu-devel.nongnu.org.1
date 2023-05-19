Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B778709A82
	for <lists+qemu-devel@lfdr.de>; Fri, 19 May 2023 16:53:27 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q01Tw-0007iJ-H6; Fri, 19 May 2023 10:53:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1q01Tu-0007dt-VD
 for qemu-devel@nongnu.org; Fri, 19 May 2023 10:53:22 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1q01Tt-0003vP-8Q
 for qemu-devel@nongnu.org; Fri, 19 May 2023 10:53:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1684508000;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1tmyLUCgie0guMo2DyzPBcQwQPzOLQHwY6RFHxL/fUs=;
 b=hsAhfu3t2JT/LZScNKpegadTd9HxH29tfo4UGmiqwQPkt8FY5w5Je3ELonLElsvDuMTCXQ
 tr4GWTpvI/HnmSm9bJRhh65f+61ihA0xe3aEAUbcdwa9v7upvtfyfYBL7fyY+KUQ86gGkn
 pY1uEC0uPdb0OhezmblS86URE0HHy4M=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-613-ywOHwfm5Na2A1ubnt5yRyA-1; Fri, 19 May 2023 10:53:19 -0400
X-MC-Unique: ywOHwfm5Na2A1ubnt5yRyA-1
Received: by mail-lf1-f71.google.com with SMTP id
 2adb3069b0e04-4f225b6dc0dso2288832e87.2
 for <qemu-devel@nongnu.org>; Fri, 19 May 2023 07:53:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684507997; x=1687099997;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=1tmyLUCgie0guMo2DyzPBcQwQPzOLQHwY6RFHxL/fUs=;
 b=Dod4tJsfeElqgaoTSahjXFZX3B+4HYeUz6k7q278EcAL66jieLxcI9hMYZXAAeZZ7o
 JroX3gzrna3L5XZFn5MfQxUps2MtEZgWvcRE+OgJWzZbLVNBbCho5pNKi5ZPhXGBm/Aq
 adscItkRNS2RjenBo0pxU0oqwPEVCUzz7+IjHjIuWCJmx0odpYIGm2DAHrzHXyBi4QDV
 uOqnnJ1aSCb1A8u07n0LzXdCBqP/ORRlbEs4SStTVrKtRvkVE/9QIL7agfJcModqIFaD
 yV8qT5wY8zl9M7o7UOSV/dSBiY/wr+qxeeoIWevugY5/GqUXDBIhCtMEO4f5ztBBebmB
 CHoA==
X-Gm-Message-State: AC+VfDyS83P5ZsX+4UbDyLgsw8B6HWC6Mnoyl532tlo4TBw0oL1N3cIl
 UxihCIgepCwQlFPdCgmc2A3YMF1SjSwfln5U0y+ERL1FhqfNw9awSL9Js7D2X8zuvmWYhlHZepS
 NKLhAXcdjIwLbuffSJ0JoU4US+eCYUmDc/Kgs8fevFPoxw9wIS94X1O5uKW8aCrwHlAKP
X-Received: by 2002:ac2:5225:0:b0:4f2:455d:18bd with SMTP id
 i5-20020ac25225000000b004f2455d18bdmr857052lfl.16.1684507997548; 
 Fri, 19 May 2023 07:53:17 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ5JToqUeyw+GCIgpbJzHS3bQZ0F7ms86q2zGO5EbYfPAdje4GLsSQoS3aZtDH68nRIHuS/hgw==
X-Received: by 2002:ac2:5225:0:b0:4f2:455d:18bd with SMTP id
 i5-20020ac25225000000b004f2455d18bdmr857038lfl.16.1684507997170; 
 Fri, 19 May 2023 07:53:17 -0700 (PDT)
Received: from redhat.com ([176.12.184.180]) by smtp.gmail.com with ESMTPSA id
 b20-20020ac247f4000000b004efff420b0asm623388lfp.108.2023.05.19.07.53.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 19 May 2023 07:53:16 -0700 (PDT)
Date: Fri, 19 May 2023 10:53:11 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Bernhard Beschow <shentey@gmail.com>, Thomas Huth <thuth@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>
Subject: [PULL 40/40] hw/i386/pc: No need for rtc_state to be an out-parameter
Message-ID: <87af48a49c0a5663b3fff58c3407393772d3c448.1684507742.git.mst@redhat.com>
References: <cover.1684507742.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover.1684507742.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
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

From: Bernhard Beschow <shentey@gmail.com>

Now that the RTC is created as part of the southbridges it doesn't need
to be an out-parameter any longer.

Signed-off-by: Bernhard Beschow <shentey@gmail.com>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-Id: <20230519084734.220480-3-shentey@gmail.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 include/hw/i386/pc.h |  2 +-
 hw/i386/pc.c         | 12 ++++++------
 hw/i386/pc_piix.c    |  2 +-
 hw/i386/pc_q35.c     |  2 +-
 4 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/include/hw/i386/pc.h b/include/hw/i386/pc.h
index 4e638564ca..79e755879d 100644
--- a/include/hw/i386/pc.h
+++ b/include/hw/i386/pc.h
@@ -167,7 +167,7 @@ uint64_t pc_pci_hole64_start(void);
 DeviceState *pc_vga_init(ISABus *isa_bus, PCIBus *pci_bus);
 void pc_basic_device_init(struct PCMachineState *pcms,
                           ISABus *isa_bus, qemu_irq *gsi,
-                          ISADevice **rtc_state,
+                          ISADevice *rtc_state,
                           bool create_fdctrl,
                           uint32_t hpet_irqs);
 void pc_cmos_init(PCMachineState *pcms,
diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index 4a73786e20..b3d826a83a 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -1265,7 +1265,7 @@ static void pc_superio_init(ISABus *isa_bus, bool create_fdctrl,
 
 void pc_basic_device_init(struct PCMachineState *pcms,
                           ISABus *isa_bus, qemu_irq *gsi,
-                          ISADevice **rtc_state,
+                          ISADevice *rtc_state,
                           bool create_fdctrl,
                           uint32_t hpet_irqs)
 {
@@ -1320,14 +1320,14 @@ void pc_basic_device_init(struct PCMachineState *pcms,
     }
 
     if (rtc_irq) {
-        qdev_connect_gpio_out(DEVICE(*rtc_state), 0, rtc_irq);
+        qdev_connect_gpio_out(DEVICE(rtc_state), 0, rtc_irq);
     } else {
-        uint32_t irq = object_property_get_uint(OBJECT(*rtc_state),
+        uint32_t irq = object_property_get_uint(OBJECT(rtc_state),
                                                 "irq",
                                                 &error_fatal);
-        isa_connect_gpio_out(*rtc_state, 0, irq);
+        isa_connect_gpio_out(rtc_state, 0, irq);
     }
-    object_property_add_alias(OBJECT(pcms), "rtc-time", OBJECT(*rtc_state),
+    object_property_add_alias(OBJECT(pcms), "rtc-time", OBJECT(rtc_state),
                               "date");
 
 #ifdef CONFIG_XEN_EMU
@@ -1341,7 +1341,7 @@ void pc_basic_device_init(struct PCMachineState *pcms,
     }
 #endif
 
-    qemu_register_boot_set(pc_boot_set, *rtc_state);
+    qemu_register_boot_set(pc_boot_set, rtc_state);
 
     if (!xen_enabled() &&
         (x86ms->pit == ON_OFF_AUTO_AUTO || x86ms->pit == ON_OFF_AUTO_ON)) {
diff --git a/hw/i386/pc_piix.c b/hw/i386/pc_piix.c
index 34e81b79d0..10070ea9a5 100644
--- a/hw/i386/pc_piix.c
+++ b/hw/i386/pc_piix.c
@@ -277,7 +277,7 @@ static void pc_init1(MachineState *machine,
     }
 
     /* init basic PC hardware */
-    pc_basic_device_init(pcms, isa_bus, x86ms->gsi, &rtc_state, true,
+    pc_basic_device_init(pcms, isa_bus, x86ms->gsi, rtc_state, true,
                          0x4);
 
     pc_nic_init(pcmc, isa_bus, pci_bus);
diff --git a/hw/i386/pc_q35.c b/hw/i386/pc_q35.c
index 8faeb6ce05..8030d53da6 100644
--- a/hw/i386/pc_q35.c
+++ b/hw/i386/pc_q35.c
@@ -292,7 +292,7 @@ static void pc_q35_init(MachineState *machine)
     }
 
     /* init basic PC hardware */
-    pc_basic_device_init(pcms, isa_bus, x86ms->gsi, &rtc_state, !mc->no_floppy,
+    pc_basic_device_init(pcms, isa_bus, x86ms->gsi, rtc_state, !mc->no_floppy,
                          0xff0104);
 
     if (pcms->sata_enabled) {
-- 
MST



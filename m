Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 937BE7D222F
	for <lists+qemu-devel@lfdr.de>; Sun, 22 Oct 2023 11:26:00 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1quUht-0005ID-Ch; Sun, 22 Oct 2023 05:25:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1quUhg-0005Bm-1X
 for qemu-devel@nongnu.org; Sun, 22 Oct 2023 05:25:00 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1quUhe-0000cw-Gq
 for qemu-devel@nongnu.org; Sun, 22 Oct 2023 05:24:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697966698;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=lH1AqdjPXgfR1Memi78dfyy1TzArPQZzj3BdRAkG12A=;
 b=JM0Nb29C8Ft1eWx5VNRoWxBsRLBtsIKXK9oIj9niXSutImAtxZpFDU9aXskHkYqCbfUV/u
 0LqE5FbZEIoTR6fxr+ItP4Sb3zP7UlbeNhCafeAyS6XjX5ZiesJnWb/4km7Hv+Y9zCWM5W
 tMWhqCaen9XtkEnkbQCdLIXEiT6RATE=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-660-LlImwjDXOC6CNl62wSWPMA-1; Sun, 22 Oct 2023 05:24:56 -0400
X-MC-Unique: LlImwjDXOC6CNl62wSWPMA-1
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-3f5df65fa35so12549315e9.3
 for <qemu-devel@nongnu.org>; Sun, 22 Oct 2023 02:24:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697966694; x=1698571494;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lH1AqdjPXgfR1Memi78dfyy1TzArPQZzj3BdRAkG12A=;
 b=iRV3kz1qYQ9kLG9BnunUh/D38s5ej1/K88tjCkUXMBFZ12Gm116NlsRCrVas4lnk36
 qAWfn1YuQmnXlWd5ZNzDtw1gBj7O1a6FyglDlx0vkWZt0MVxDcAwY7/UI1cxT3uhyJYW
 iA+cGbMEmBI+EbuVfBeKukLblOOugcqdJeabJEFgY9ewTSIftfIgMq/E0zsIDKFQnA//
 uk5CJ8rMfcM0otIEkb1PZB3WPjQg2hbxXn6lQR66/WL1Am8PVm0RnPHELznZJDvdEAc1
 x7Hs6tyVL21eM3OFuHVB7cwDQrfC/OFbNQlFxx9B2M3hFvX0/zksngD35zW+beq+hHvY
 Rk6w==
X-Gm-Message-State: AOJu0YwqflZJ5VLFE8QW1DT8xPW0qv4NI6iazLB3eLEx+zpnakNkQJyu
 zKWvs1b4bruaBqnLHh5q8eeaMsz6oobX2JhruaapwcuflO78CibTIhAqSoMeJ6LhYXIRq6lyJxR
 f8lBbGpNAW3FKkwHWaWC4RvPdHf3lbqgiG79YK3abY4akL0RFzwYauZGk58eCMqBfafDt
X-Received: by 2002:a05:600c:3c8a:b0:401:bcd9:4871 with SMTP id
 bg10-20020a05600c3c8a00b00401bcd94871mr4842320wmb.21.1697966694492; 
 Sun, 22 Oct 2023 02:24:54 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF5XxL8PvkEwDo9lC6UIqxX/k2stmJD+aBOJSsOEhp6IIXmWLJQrLAjU/RF7BaKruoU4c4Wjw==
X-Received: by 2002:a05:600c:3c8a:b0:401:bcd9:4871 with SMTP id
 bg10-20020a05600c3c8a00b00401bcd94871mr4842303wmb.21.1697966694203; 
 Sun, 22 Oct 2023 02:24:54 -0700 (PDT)
Received: from redhat.com ([2.52.1.53]) by smtp.gmail.com with ESMTPSA id
 n11-20020adffe0b000000b0032dbf26e7aesm5268650wrr.65.2023.10.22.02.24.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 22 Oct 2023 02:24:53 -0700 (PDT)
Date: Sun, 22 Oct 2023 05:24:50 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Bernhard Beschow <shentey@gmail.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Aurelien Jarno <aurelien@aurel32.net>,
 =?utf-8?B?SGVydsOp?= Poussineau <hpoussin@reactos.org>
Subject: [PULL v3 42/62] hw/isa/piix: Allow for optional PIT creation in PIIX3
Message-ID: <ac4330359bee7a8cf3dab7f8639190dd17f1f4d1.1697966402.git.mst@redhat.com>
References: <cover.1697966402.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1697966402.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

In the PC machine, the PIT is created in board code to allow it to be
virtualized with various virtualization techniques. So explicitly disable its
creation in the PC machine via a property which defaults to enabled. Once the
PIIX implementations are consolidated this default will keep Malta working
without further ado.

Signed-off-by: Bernhard Beschow <shentey@gmail.com>
Message-Id: <20231007123843.127151-22-shentey@gmail.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 include/hw/southbridge/piix.h | 1 +
 hw/i386/pc_piix.c             | 2 ++
 hw/isa/piix.c                 | 6 ++++++
 3 files changed, 9 insertions(+)

diff --git a/include/hw/southbridge/piix.h b/include/hw/southbridge/piix.h
index 08491693b4..86709ba2e4 100644
--- a/include/hw/southbridge/piix.h
+++ b/include/hw/southbridge/piix.h
@@ -70,6 +70,7 @@ struct PIIXState {
 
     bool has_acpi;
     bool has_pic;
+    bool has_pit;
     bool has_usb;
     bool smm_enabled;
 };
diff --git a/hw/i386/pc_piix.c b/hw/i386/pc_piix.c
index fa39afd891..e38942a3c3 100644
--- a/hw/i386/pc_piix.c
+++ b/hw/i386/pc_piix.c
@@ -270,6 +270,8 @@ static void pc_init1(MachineState *machine,
                                  &error_abort);
         object_property_set_bool(OBJECT(pci_dev), "has-pic", false,
                                  &error_abort);
+        object_property_set_bool(OBJECT(pci_dev), "has-pit", false,
+                                 &error_abort);
         qdev_prop_set_uint32(DEVICE(pci_dev), "smb_io_base", 0xb100);
         object_property_set_bool(OBJECT(pci_dev), "smm-enabled",
                                  x86_machine_is_smm_enabled(x86ms),
diff --git a/hw/isa/piix.c b/hw/isa/piix.c
index d6d9ac6473..270b8eb1f7 100644
--- a/hw/isa/piix.c
+++ b/hw/isa/piix.c
@@ -361,6 +361,11 @@ static void pci_piix3_realize(PCIDevice *dev, Error **errp)
 
     isa_bus_register_input_irqs(isa_bus, d->isa_irqs_in);
 
+    /* PIT */
+    if (d->has_pit) {
+        i8254_pit_init(isa_bus, 0x40, 0, NULL);
+    }
+
     i8257_dma_init(isa_bus, 0);
 
     /* RTC */
@@ -436,6 +441,7 @@ static Property pci_piix3_props[] = {
     DEFINE_PROP_UINT32("smb_io_base", PIIXState, smb_io_base, 0),
     DEFINE_PROP_BOOL("has-acpi", PIIXState, has_acpi, true),
     DEFINE_PROP_BOOL("has-pic", PIIXState, has_pic, true),
+    DEFINE_PROP_BOOL("has-pit", PIIXState, has_pit, true),
     DEFINE_PROP_BOOL("has-usb", PIIXState, has_usb, true),
     DEFINE_PROP_BOOL("smm-enabled", PIIXState, smm_enabled, false),
     DEFINE_PROP_END_OF_LIST(),
-- 
MST



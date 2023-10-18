Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 13AEC7CE267
	for <lists+qemu-devel@lfdr.de>; Wed, 18 Oct 2023 18:12:03 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qt8wl-0001EH-OU; Wed, 18 Oct 2023 11:58:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qt8w8-0000Xw-MA
 for qemu-devel@nongnu.org; Wed, 18 Oct 2023 11:58:22 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qt8w6-0007ON-OV
 for qemu-devel@nongnu.org; Wed, 18 Oct 2023 11:58:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697644697;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=lH1AqdjPXgfR1Memi78dfyy1TzArPQZzj3BdRAkG12A=;
 b=ixUKBSt5YFpWUKQmUvuYw6ezee/8rURWCMzRxBPS7iat5F4oPconBXD0oEzYKn2fRYMxl6
 64zr1gJVw0oI2i+ewxkU9nyvlqj3GPNt5rvaEQJ3W7dl0XJDqTUgKSu+z1xDDciqH5mk3z
 lNTrmQ65xnXna5VMgUYuW9Oo35eyk4g=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-263-AQ99QkY2OQCSBfE1sYf2gA-1; Wed, 18 Oct 2023 11:58:15 -0400
X-MC-Unique: AQ99QkY2OQCSBfE1sYf2gA-1
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-4074cdf2566so35123125e9.1
 for <qemu-devel@nongnu.org>; Wed, 18 Oct 2023 08:58:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697644694; x=1698249494;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lH1AqdjPXgfR1Memi78dfyy1TzArPQZzj3BdRAkG12A=;
 b=xJWt5NUy0zTIiOxzEdvhvcgLbo8qVJVgCuWOQRhUvekgL2fEp0N3OYhuESwy02l/IK
 +/tiI0r7BTy0vifE3rjfpJ+s75hxtfAGsiikTZA6yXZbxUT24cqMzlZ6HpYaCZHGArgt
 7mVDvEMfd6dZIPXAABo/CrBmF03B0RV+7c+nnMXENjC9pSGu5rx/Jg6z6SYuBBpN50tO
 DW/AC6b7akiEPLzOHucu84foZ/UamHinvQLk/MVFB/xzt+e7nmA02Nu6ki/za1mSGjIt
 Vv3r2JUggjS7MZRe/2hmwtcSEoj75ICbsxGXEUNRmxRM8tX867h7SiU48Ap5pWcMofOD
 XqLw==
X-Gm-Message-State: AOJu0YxuIoCP1o6w0kQv61MKXq/687IgFFZWa9maHH5FBHMfpCQA7HSo
 cgZZm7zycDmdZiSc3I0gy2T/rG05EH9Bctlm0gjWiXeRaFzYUa0ILABRO2dGM/jGZlwi2xC3kfb
 9JeOxjOOhSc+YisS0hsOmlhPvBUhwZObUtAHvzyd1zeGk0fEEV/730y5zvChfsZngXpDF9ZE=
X-Received: by 2002:a05:600c:1d26:b0:407:5de2:ea4d with SMTP id
 l38-20020a05600c1d2600b004075de2ea4dmr5105135wms.13.1697644694123; 
 Wed, 18 Oct 2023 08:58:14 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHhqMvPWK74jLPKgfXn6rsH8oZZKxJYpNAvwLJIUaBm4yZfVBzGatHkKUDGiGqfOF3j/BqoiA==
X-Received: by 2002:a05:600c:1d26:b0:407:5de2:ea4d with SMTP id
 l38-20020a05600c1d2600b004075de2ea4dmr5105103wms.13.1697644693639; 
 Wed, 18 Oct 2023 08:58:13 -0700 (PDT)
Received: from redhat.com ([2a02:14f:1f2:2037:f34:d61b:7da0:a7be])
 by smtp.gmail.com with ESMTPSA id
 o36-20020a05600c512400b00405959469afsm2034151wms.3.2023.10.18.08.58.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Oct 2023 08:58:13 -0700 (PDT)
Date: Wed, 18 Oct 2023 11:58:08 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Bernhard Beschow <shentey@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?utf-8?B?SGVydsOp?= Poussineau <hpoussin@reactos.org>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Aurelien Jarno <aurelien@aurel32.net>
Subject: [PULL 63/83] hw/isa/piix: Allow for optional PIT creation in PIIX3
Message-ID: <9a43333153a589e122b185aee78971024d437ea0.1697644299.git.mst@redhat.com>
References: <cover.1697644299.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1697644299.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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



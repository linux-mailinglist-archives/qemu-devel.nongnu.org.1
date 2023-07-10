Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CB56074E1C5
	for <lists+qemu-devel@lfdr.de>; Tue, 11 Jul 2023 01:05:25 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qIzuj-0004nK-0k; Mon, 10 Jul 2023 19:03:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qIzug-0004cG-GA
 for qemu-devel@nongnu.org; Mon, 10 Jul 2023 19:03:26 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qIzue-0004Dy-VE
 for qemu-devel@nongnu.org; Mon, 10 Jul 2023 19:03:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1689030204;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=QkHlkRkwRqr2wnXNmLOmWdy8/xXSowfTeKJm6zvZ4CA=;
 b=ECIA+H3IxQuY2D7ymHc7/ISGAY//hBCWss+UMEl0FO2t1MDG5BOBTF0DlvErCq7lYdgn0m
 IbAeY3fWSZkw5gOP8ItDQBmWkYht1nbtVo1wuwuLZVPyyyNYbElPGLLV2gMJV2v+YdeKep
 zUN5x5sY2u/VKlc484RYDHJg3AyD7rA=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-627-qZbaidDJPEWj1uUG9REEPQ-1; Mon, 10 Jul 2023 19:03:23 -0400
X-MC-Unique: qZbaidDJPEWj1uUG9REEPQ-1
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-3fbe356b8deso31117235e9.0
 for <qemu-devel@nongnu.org>; Mon, 10 Jul 2023 16:03:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689030201; x=1691622201;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=QkHlkRkwRqr2wnXNmLOmWdy8/xXSowfTeKJm6zvZ4CA=;
 b=PVGrDeq14Gv7jR4VtZts4kSWom6J53UZ+ltbgs9ph2G1la7f6I8MmflxpeerYIvxsy
 XGNDn0CjZe86Ore/nZ1YAFb5bTOkdkh7nHiSGSjEzMLichsNzv5+G6+DD53MYLyuVxNB
 W+jdvptj+Irk78d4TT4wpMPSOX1oXZ53m6xckSHHQ+mhVuE9xdHJDulI8m9mgg0LjgwW
 n9LdFjCmn4A8YagS/b5iSwtZ9p6kRKE4LnJSC+MDh4PVKLkPbS1ewCe+n1xrunSo+TVg
 iwmOHqlD4hMLcrdb+OKsvVq2kq39BLTrCODBAaxyOIW+yJVHIzAbUTI9CAzOvNuoNfqW
 Zd9w==
X-Gm-Message-State: ABy/qLY7NhfW5JHp4t0SOqcvb3yelAgY6c8q4dSlGOvJ4vMys4LYrV0z
 F6yVjR65Yc1d26PQIP0xdfhbsMC3v1hrKlk+Hm43Wa9oiTlvlMhR3T40m1zpZNDgb22VzNCh+fD
 hHaBC3+kNcsS6yBrvM6U6QGlGjwtymEZHs5aeHlcfDRuxh9/3e+ycs7OIjyMuSklmdClx
X-Received: by 2002:a7b:c392:0:b0:3fb:d1db:5454 with SMTP id
 s18-20020a7bc392000000b003fbd1db5454mr14426808wmj.35.1689030201325; 
 Mon, 10 Jul 2023 16:03:21 -0700 (PDT)
X-Google-Smtp-Source: APBJJlEQfJrtJnQU7jlKYAFHIpb3sB2nekHEWYNXSfjpS/0g4fE8THSpEib9nSaYehgHtfyVuFE9CA==
X-Received: by 2002:a7b:c392:0:b0:3fb:d1db:5454 with SMTP id
 s18-20020a7bc392000000b003fbd1db5454mr14426792wmj.35.1689030201095; 
 Mon, 10 Jul 2023 16:03:21 -0700 (PDT)
Received: from redhat.com ([2.52.3.112]) by smtp.gmail.com with ESMTPSA id
 c18-20020a7bc012000000b003fbd2a9e94asm927921wmb.31.2023.07.10.16.03.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 10 Jul 2023 16:03:20 -0700 (PDT)
Date: Mon, 10 Jul 2023 19:03:18 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Bernhard Beschow <shentey@gmail.com>, Igor Mammedov <imammedo@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Subject: [PULL 19/66] hw/pci-host/q35: Initialize PCMachineState::bus in
 board code
Message-ID: <06a492bd2b75653970e30c3ae0ea79ab1ed4ae31.1689030052.git.mst@redhat.com>
References: <cover.1689030052.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover.1689030052.git.mst@redhat.com>
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

From: Bernhard Beschow <shentey@gmail.com>

The Q35 PCI host currently sets the PC machine's PCI bus attribute
through global state, thereby assuming the machine to be a PC machine.
The Q35 machine code already holds on to Q35's pci bus attribute, so can
easily set its own property while preserving encapsulation.

Signed-off-by: Bernhard Beschow <shentey@gmail.com>
Reviewed-by: Igor Mammedov <imammedo@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-Id: <20230630073720.21297-4-shentey@gmail.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/i386/pc_q35.c  | 4 +++-
 hw/pci-host/q35.c | 1 -
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/hw/i386/pc_q35.c b/hw/i386/pc_q35.c
index d9f3764184..4edc0b35f4 100644
--- a/hw/i386/pc_q35.c
+++ b/hw/i386/pc_q35.c
@@ -230,10 +230,12 @@ static void pc_q35_init(MachineState *machine)
                             x86ms->below_4g_mem_size, NULL);
     object_property_set_int(phb, PCI_HOST_ABOVE_4G_MEM_SIZE,
                             x86ms->above_4g_mem_size, NULL);
+    sysbus_realize_and_unref(SYS_BUS_DEVICE(phb), &error_fatal);
 
     /* pci */
-    sysbus_realize_and_unref(SYS_BUS_DEVICE(phb), &error_fatal);
     host_bus = PCI_BUS(qdev_get_child_bus(DEVICE(phb), "pcie.0"));
+    pcms->bus = host_bus;
+
     /* create ISA bus */
     lpc = pci_new_multifunction(PCI_DEVFN(ICH9_LPC_DEV, ICH9_LPC_FUNC), true,
                                 TYPE_ICH9_LPC_DEVICE);
diff --git a/hw/pci-host/q35.c b/hw/pci-host/q35.c
index 84137b9ad9..0604464074 100644
--- a/hw/pci-host/q35.c
+++ b/hw/pci-host/q35.c
@@ -66,7 +66,6 @@ static void q35_host_realize(DeviceState *dev, Error **errp)
                                 s->mch.pci_address_space,
                                 s->mch.address_space_io,
                                 0, TYPE_PCIE_BUS);
-    PC_MACHINE(qdev_get_machine())->bus = pci->bus;
     pci->bypass_iommu =
         PC_MACHINE(qdev_get_machine())->default_bus_bypass_iommu;
     qdev_realize(DEVICE(&s->mch), BUS(pci->bus), &error_fatal);
-- 
MST



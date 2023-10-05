Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id F3DA37B9A6F
	for <lists+qemu-devel@lfdr.de>; Thu,  5 Oct 2023 05:49:18 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qoFJI-0000Gj-0M; Wed, 04 Oct 2023 23:46:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qoFJ1-0008J1-QJ
 for qemu-devel@nongnu.org; Wed, 04 Oct 2023 23:45:45 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qoFIy-0000ln-H9
 for qemu-devel@nongnu.org; Wed, 04 Oct 2023 23:45:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1696477537;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=paof42DUy5YVFM8ix/mc19HfT2JnvVvvPuSSyPQvY8Q=;
 b=WLTCoClZblIG6TXCdZ4d6/0KHjGws8b8bXlcLwRZGKcxuS39LRg+lQ2cLYC+orubCu3RTY
 iQwkBVj64YBL3CMqctsihKbi6l27ZpW5WR1x63aXHzKsWXt65l0Vg1wpOA1mkAoTm0Iia6
 CfD5koqsxqZDL8LKmM9tdasHxUNJ8hU=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-468-OR0j186FPay82CeENPNrEg-1; Wed, 04 Oct 2023 23:45:26 -0400
X-MC-Unique: OR0j186FPay82CeENPNrEg-1
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-4067f186094so3810695e9.1
 for <qemu-devel@nongnu.org>; Wed, 04 Oct 2023 20:45:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696477524; x=1697082324;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=paof42DUy5YVFM8ix/mc19HfT2JnvVvvPuSSyPQvY8Q=;
 b=deLqLx1+Ygvv1GFpc7YkWqd2+wefc88ONT1xMsmkG/IS7IMzKK74eqZN+JnarurdG+
 Xm8X2yp9Xcwz2B9XeJ5RojizEg/80+lSZfggArKZAh0v0DOqOxByEWHaRAUpLJtfY9mI
 BxGOAwvM75MLj1qCruBmXCUKQauiyy+PvXT49UcGUsNseZTp7lSI1ps6n+gBaC74Lft7
 V23NAl/NrbJuzJGdXks9f8DHn+TDjPWhw/6syTAY23FH7yJtk3LQBYvV9q3dh9qploPM
 hwR4RsdKBVA5UzVk3RLB1Xtj3ryEPwLTCkm4SYs38WYjK+xpLIoN4OfrngL3IgtiF2j3
 91LQ==
X-Gm-Message-State: AOJu0YwGRQJzNilm1//ePCc/482Cuwh8/a4g11LUPUWckYQwB8JU9i9M
 IiLjohCnQu74hCL2J/mSC5GA4bhkJqBjUWb+XhR7w54zuG3YDmJbgu/19ylIKCmOVJZdBR/EIpH
 0dB9NmW0FHMIIr9XzhM/8DGLOVFFFQIkLrrJSDWyE4mYMWm7RBy0W0VT8KUBbbrapaK2v
X-Received: by 2002:a05:600c:4e0f:b0:406:4a32:1919 with SMTP id
 b15-20020a05600c4e0f00b004064a321919mr4160940wmq.29.1696477524438; 
 Wed, 04 Oct 2023 20:45:24 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFWhGPCXCv+krMryrFBWVmhqXJnlLkqxEsGGQCFWHw2E8MUnDRKLNLq/MFimdeHIuz7PVxxIw==
X-Received: by 2002:a05:600c:4e0f:b0:406:4a32:1919 with SMTP id
 b15-20020a05600c4e0f00b004064a321919mr4160928wmq.29.1696477524219; 
 Wed, 04 Oct 2023 20:45:24 -0700 (PDT)
Received: from redhat.com ([2.52.137.96]) by smtp.gmail.com with ESMTPSA id
 y8-20020a7bcd88000000b00406447b798bsm2792579wmj.37.2023.10.04.20.45.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Oct 2023 20:45:23 -0700 (PDT)
Date: Wed, 4 Oct 2023 23:45:19 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Akihiko Odaki <akihiko.odaki@daynix.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>
Subject: [PULL v2 43/53] amd_iommu: Fix APIC address check
Message-ID: <0114c4513095598cdf1cd8d7dacdfff757628121.1696477105.git.mst@redhat.com>
References: <cover.1696477105.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1696477105.git.mst@redhat.com>
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

From: Akihiko Odaki <akihiko.odaki@daynix.com>

An MSI from I/O APIC may not exactly equal to APIC_DEFAULT_ADDRESS. In
fact, Windows 17763.3650 configures I/O APIC to set the dest_mode bit.
Cover the range assigned to APIC.

Fixes: 577c470f43 ("x86_iommu/amd: Prepare for interrupt remap support")
Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
Message-Id: <20230921114612.40671-1-akihiko.odaki@daynix.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/i386/amd_iommu.h | 2 --
 hw/i386/amd_iommu.c | 9 ++-------
 2 files changed, 2 insertions(+), 9 deletions(-)

diff --git a/hw/i386/amd_iommu.h b/hw/i386/amd_iommu.h
index 6da893ee57..c5065a3e27 100644
--- a/hw/i386/amd_iommu.h
+++ b/hw/i386/amd_iommu.h
@@ -210,8 +210,6 @@
 #define AMDVI_INT_ADDR_FIRST    0xfee00000
 #define AMDVI_INT_ADDR_LAST     0xfeefffff
 #define AMDVI_INT_ADDR_SIZE     (AMDVI_INT_ADDR_LAST - AMDVI_INT_ADDR_FIRST + 1)
-#define AMDVI_MSI_ADDR_HI_MASK  (0xffffffff00000000ULL)
-#define AMDVI_MSI_ADDR_LO_MASK  (0x00000000ffffffffULL)
 
 /* SB IOAPIC is always on this device in AMD systems */
 #define AMDVI_IOAPIC_SB_DEVID   PCI_BUILD_BDF(0, PCI_DEVFN(0x14, 0))
diff --git a/hw/i386/amd_iommu.c b/hw/i386/amd_iommu.c
index c98a3c6e11..8d0f2f99dd 100644
--- a/hw/i386/amd_iommu.c
+++ b/hw/i386/amd_iommu.c
@@ -1246,13 +1246,8 @@ static int amdvi_int_remap_msi(AMDVIState *iommu,
         return -AMDVI_IR_ERR;
     }
 
-    if (origin->address & AMDVI_MSI_ADDR_HI_MASK) {
-        trace_amdvi_err("MSI address high 32 bits non-zero when "
-                        "Interrupt Remapping enabled.");
-        return -AMDVI_IR_ERR;
-    }
-
-    if ((origin->address & AMDVI_MSI_ADDR_LO_MASK) != APIC_DEFAULT_ADDRESS) {
+    if (origin->address < AMDVI_INT_ADDR_FIRST ||
+        origin->address + sizeof(origin->data) > AMDVI_INT_ADDR_LAST + 1) {
         trace_amdvi_err("MSI is not from IOAPIC.");
         return -AMDVI_IR_ERR;
     }
-- 
MST



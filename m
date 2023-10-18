Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 58B437CE223
	for <lists+qemu-devel@lfdr.de>; Wed, 18 Oct 2023 18:06:16 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qt8xi-0002Yl-R5; Wed, 18 Oct 2023 11:59:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qt8xL-00028W-O9
 for qemu-devel@nongnu.org; Wed, 18 Oct 2023 11:59:35 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qt8xJ-0007ln-MA
 for qemu-devel@nongnu.org; Wed, 18 Oct 2023 11:59:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697644772;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=x3My//pc/qVW2ftl9aWSgQDTy/uh8IXpNIimgHcVE8A=;
 b=g5PUduQ0LLdXZqlSFeIzGcLD8F3yxNhz+td7VMK1HliQCVjG984KmksZZktFAvDTz2BsDc
 S7glbQ5HeycPFnxGmE5gCy0R/ocopFhBswkPPaY/kqVtxl8Z7GAEGBjJsMRao46G/aW2sI
 XeCn9lB+48qjys1Gyj6oWeH1UxaKcfI=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-532-99GWxeLOMSCYox7xwcGfbg-1; Wed, 18 Oct 2023 11:58:55 -0400
X-MC-Unique: 99GWxeLOMSCYox7xwcGfbg-1
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-32d9b520d15so2819933f8f.3
 for <qemu-devel@nongnu.org>; Wed, 18 Oct 2023 08:58:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697644727; x=1698249527;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=x3My//pc/qVW2ftl9aWSgQDTy/uh8IXpNIimgHcVE8A=;
 b=CddMqOyGh3BUT7rmMnyk3+MJjKRWcE3Lz2uh3NigqXnoqr4JVHS7E3GSBlwNmZIYfJ
 Nb6S7ApfWHVRgrpGnBYBWGp3FZShg2XvmMn0xKDl3fAXqvK6pAycDq4SVPL85qig5xzb
 2mJ0RlSFdecHKUyhrUSvbtMoaYSRXT8vhRJkGcfJgIaktkgYiGwyDwR4kGDgqv0lgCJ+
 w4HDTpCT6lTxB1sOneQE1kDq1nuRgiWSxaleQk+SYUfuNKK1cqhvthO5lm1Qui+V7hZ2
 bplWmpABQP+mo4BGS8BUkn12Sz9/ZNFq61TEcSCHZY2V3vBNug54yZVobVjmF3G9OhgG
 nMnA==
X-Gm-Message-State: AOJu0YxbFk/kwSR5d9Igv+3dTgUYRCS1Yva4Rwb0o912L+mIXDdPf7wq
 EJSXKscRqUXEBTHl/G3fw28cC0SPlg3w6o/1iUz9Yoe66mEFn4Q0mxAIbublmkGY/i5Dgey0QLC
 aUw9iTxG5gMKUPhaxKqmxpFEFUVSTr8rSLgdzZBT3WpZ+BaEk5EmJZqGj7NI6z1LsD0naPmo=
X-Received: by 2002:a5d:4c81:0:b0:32d:9d66:5742 with SMTP id
 z1-20020a5d4c81000000b0032d9d665742mr5034875wrs.10.1697644727514; 
 Wed, 18 Oct 2023 08:58:47 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFznfcmpkY3gNQYQQJq5HO9C2vamX3P0lTImSm2ErmrV3qktRKNya3dmsBsPHQaM5tTBjr23Q==
X-Received: by 2002:a5d:4c81:0:b0:32d:9d66:5742 with SMTP id
 z1-20020a5d4c81000000b0032d9d665742mr5034858wrs.10.1697644727220; 
 Wed, 18 Oct 2023 08:58:47 -0700 (PDT)
Received: from redhat.com ([2a02:14f:1f2:2037:f34:d61b:7da0:a7be])
 by smtp.gmail.com with ESMTPSA id
 f12-20020adfb60c000000b00318147fd2d3sm2388456wre.41.2023.10.18.08.58.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Oct 2023 08:58:46 -0700 (PDT)
Date: Wed, 18 Oct 2023 11:58:42 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Bernhard Beschow <shentey@gmail.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Aurelien Jarno <aurelien@aurel32.net>,
 =?utf-8?B?SGVydsOp?= Poussineau <hpoussin@reactos.org>
Subject: [PULL 70/83] hw/isa/piix: Implement multi-process QEMU support also
 for PIIX4
Message-ID: <461585efb5d8ee352209cf5e37116046f1410b94.1697644299.git.mst@redhat.com>
References: <cover.1697644299.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1697644299.git.mst@redhat.com>
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

So far multi-process QEMU was only implemented for PIIX3. Move the support into
the base class to achieve feature parity between both device models.

Signed-off-by: Bernhard Beschow <shentey@gmail.com>
Message-Id: <20231007123843.127151-29-shentey@gmail.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/isa/piix.c | 9 +--------
 1 file changed, 1 insertion(+), 8 deletions(-)

diff --git a/hw/isa/piix.c b/hw/isa/piix.c
index cba2098ca2..04ebed5b52 100644
--- a/hw/isa/piix.c
+++ b/hw/isa/piix.c
@@ -374,6 +374,7 @@ static void pci_piix_realize(PCIDevice *dev, const char *uhci_type,
     }
 
     pci_bus_irqs(pci_bus, piix_set_pci_irq, d, PIIX_NUM_PIRQS);
+    pci_bus_set_route_irq_fn(pci_bus, piix_route_intx_pin_to_irq);
 }
 
 static void build_pci_isa_aml(AcpiDevAmlIf *adev, Aml *scope)
@@ -454,15 +455,7 @@ static const TypeInfo piix_pci_type_info = {
 
 static void piix3_realize(PCIDevice *dev, Error **errp)
 {
-    ERRP_GUARD();
-    PCIBus *pci_bus = pci_get_bus(dev);
-
     pci_piix_realize(dev, TYPE_PIIX3_USB_UHCI, errp);
-    if (*errp) {
-        return;
-    }
-
-    pci_bus_set_route_irq_fn(pci_bus, piix_route_intx_pin_to_irq);
 }
 
 static void piix3_init(Object *obj)
-- 
MST



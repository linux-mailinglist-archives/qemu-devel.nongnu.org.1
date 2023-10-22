Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 409ED7D2257
	for <lists+qemu-devel@lfdr.de>; Sun, 22 Oct 2023 11:31:54 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1quUiV-0007Jx-6L; Sun, 22 Oct 2023 05:25:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1quUiT-0007Fr-5w
 for qemu-devel@nongnu.org; Sun, 22 Oct 2023 05:25:49 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1quUiR-0000tk-MH
 for qemu-devel@nongnu.org; Sun, 22 Oct 2023 05:25:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697966747;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=x3My//pc/qVW2ftl9aWSgQDTy/uh8IXpNIimgHcVE8A=;
 b=AdgohZ86CmvUOuNp81hqTiuBHLqhDKGQntFIDBozWsbBxRMh9C/8L3RECIcToNrz/CFsG1
 mUxsI3fhJy0qtLxdlyVn4wTKjQeMDEks5+X3YtrkdsJj9yHQbYBZyU0cbIU4Dd52JhtwTF
 i1mm+JJkGmQQR4i2qlIE2DaLRBM6LzE=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-252-BF8NzkI2NBWi__Mh_ZGjMw-1; Sun, 22 Oct 2023 05:25:29 -0400
X-MC-Unique: BF8NzkI2NBWi__Mh_ZGjMw-1
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-32d931872cbso1110338f8f.0
 for <qemu-devel@nongnu.org>; Sun, 22 Oct 2023 02:25:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697966728; x=1698571528;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=x3My//pc/qVW2ftl9aWSgQDTy/uh8IXpNIimgHcVE8A=;
 b=Pv2Tam/v1rTD3rrY1g7rwuu6MBH16qf2GEYX34GYVhJrORNhp9yN0jtmrFEgx1oAcy
 nUs3iJvlMUjXKCTu8eRThcbsUD7Z7zYjaG+F8hnhpu65DldyTp91S1oCzuU6u7YdgA5I
 DnPq+oI4AWIWyjUOYRXrpzbb7UmkL8h5ZONQ6IWszJ9LfhtBf8NhV3MRHDe/CJ7ZYGeU
 z34KpxZ/LgJNNf7KQ2kRXdu5/QPxbsqSBGAREw9ir3evib5tRN+77ybJKUkzVj8O4meB
 SIYFnI2WGvJ0nnqMXVCyjonxzss2BOCJkoAoIEcsTdDsZcOBwDP2E+qs18OKQybM4vOL
 17vQ==
X-Gm-Message-State: AOJu0YwAWFOJek3SEH5cI8Eib+iSwQQ7nZsChy7bdIPz4tLrLgKLr7iO
 M27Gi+QUlTsNVwb/Yb4g4sC7nlyu8srEZM/gXt2nA+CEYHsx+f0LWdQSKx26AE+VgwWYXOLT4B7
 BSqubvETDhGbmKn8oytVei5m8EuKNxcgXHEIJejEsOHQR/CvKUsOpq/r6qhFLtcfVZ2iH
X-Received: by 2002:adf:fa83:0:b0:32d:5870:8b8a with SMTP id
 h3-20020adffa83000000b0032d58708b8amr4434057wrr.56.1697966727949; 
 Sun, 22 Oct 2023 02:25:27 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFr04qHT93B17R2ly0cgUEZoUEIsFzI3dOOC6YP9Kyfv2v/Ic0IA9cU7zrHvCftWT9PAOEqEg==
X-Received: by 2002:adf:fa83:0:b0:32d:5870:8b8a with SMTP id
 h3-20020adffa83000000b0032d58708b8amr4434039wrr.56.1697966727491; 
 Sun, 22 Oct 2023 02:25:27 -0700 (PDT)
Received: from redhat.com ([2.52.1.53]) by smtp.gmail.com with ESMTPSA id
 e16-20020adfe7d0000000b0032db8f7f378sm5287514wrn.71.2023.10.22.02.25.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 22 Oct 2023 02:25:26 -0700 (PDT)
Date: Sun, 22 Oct 2023 05:25:22 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Bernhard Beschow <shentey@gmail.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Aurelien Jarno <aurelien@aurel32.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?utf-8?B?SGVydsOp?= Poussineau <hpoussin@reactos.org>
Subject: [PULL v3 49/62] hw/isa/piix: Implement multi-process QEMU support
 also for PIIX4
Message-ID: <12cecd45505c239dedc8bad2ded8eab8bc2f0391.1697966402.git.mst@redhat.com>
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



Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AEBA82D084
	for <lists+qemu-devel@lfdr.de>; Sun, 14 Jan 2024 13:26:31 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rOzYp-0008K1-Eg; Sun, 14 Jan 2024 07:25:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1rOzYl-0008Io-Kh
 for qemu-devel@nongnu.org; Sun, 14 Jan 2024 07:25:52 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1rOzYj-00022v-7u
 for qemu-devel@nongnu.org; Sun, 14 Jan 2024 07:25:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1705235147;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=tAkYy2esf7Pd2G69r02QQxGJJf+2ehPe/4HNxSRnO8Q=;
 b=Rxei6mPO+rRpNgYnVXKbraEBTSO/hgk4sVn4sFuX+aQfTMVLcNUa9VLkh7pi1Uxw4DsoxY
 0fHRzo9Pv1A/79OfKT3XcHRblC3m7iUOuhWvnmmNYOXPI8szNykozEivk0PkCRDkIA8eYm
 FBp06L2APUmnd9qdStRTemecgBBPMc4=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-608-MFV1eOb4OrqHC_V9XFGtew-1; Sun, 14 Jan 2024 07:25:46 -0500
X-MC-Unique: MFV1eOb4OrqHC_V9XFGtew-1
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-33666ece1c6so5039935f8f.2
 for <qemu-devel@nongnu.org>; Sun, 14 Jan 2024 04:25:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705235145; x=1705839945;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tAkYy2esf7Pd2G69r02QQxGJJf+2ehPe/4HNxSRnO8Q=;
 b=d6B6OG9o1ogAkR/QFoAfPgv6mXek/00b+QzftHJhLlZ6Ti+UugF2/hcRnLoPIvBwXK
 0HPBh3ahD6kTuTLUwDX0V1HXBixI1my1EbGcXBuGTfJ3rCZbb2MDvosTrWCJ3taqm0re
 Kap4cBsGYAPOKKKPindCHHX3P86GpMB64a7XgS9h9Lojp0u0LLg3gigi5e/R+vT6QPCa
 T0MO105GALv/j7is6XNpVEx3hv6wwsmUcUPhG11SBuP4f6i0T2CX06M2vVNevgcNAun4
 sRVC7lvqiTRvWVme/I81RTHD9fmuVmlVuvWt/SNxN4J4VDcR5khgEervslRGOfxf4wRG
 oLDg==
X-Gm-Message-State: AOJu0Yzxkf3xL7WBa012XBnE28s3QCYAtdJZttQQ+VB+RguuudWURzY8
 hfW4j7pG/uJTMn4flxZHMY8u+9sgETuOSVJqztwQn+cQyoORQ0ZIa6TQnty9eSe7BA5RruATOLw
 kUMShw81LXhZMWW5neQVXX5k=
X-Received: by 2002:a5d:6283:0:b0:337:4fa6:2306 with SMTP id
 k3-20020a5d6283000000b003374fa62306mr1473317wru.158.1705235145118; 
 Sun, 14 Jan 2024 04:25:45 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGcs6wlsSgQGa8meTzrVry5X6WKhXJy+/DmR/kQta9Vn0vh4yGyp1UV+e1xl3ZaOJo+HPKNTQ==
X-Received: by 2002:a5d:6283:0:b0:337:4fa6:2306 with SMTP id
 k3-20020a5d6283000000b003374fa62306mr1473311wru.158.1705235144683; 
 Sun, 14 Jan 2024 04:25:44 -0800 (PST)
Received: from redhat.com ([2.52.131.87]) by smtp.gmail.com with ESMTPSA id
 v16-20020adfa1d0000000b003379d475928sm3925626wrv.18.2024.01.14.04.25.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 14 Jan 2024 04:25:43 -0800 (PST)
Date: Sun, 14 Jan 2024 07:25:40 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Bernhard Beschow <shentey@gmail.com>
Cc: qemu-devel@nongnu.org, Chuck Zmudzinski <brchuckz@aol.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Stefano Stabellini <sstabellini@kernel.org>,
 xen-devel@lists.xenproject.org, David Woodhouse <dwmw2@infradead.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Paul Durrant <paul@xen.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Anthony PERARD <anthony.perard@citrix.com>
Subject: Re: [PATCH] hw/i386/pc_piix: Make piix_intx_routing_notifier_xen()
 more device independent
Message-ID: <20240114072529-mutt-send-email-mst@kernel.org>
References: <20240107231623.5282-1-shentey@gmail.com>
 <B404ABCE-E6B5-4716-BA60-3CEE74B72701@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <B404ABCE-E6B5-4716-BA60-3CEE74B72701@gmail.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -48
X-Spam_score: -4.9
X-Spam_bar: ----
X-Spam_report: (-4.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.758,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Sun, Jan 14, 2024 at 12:21:59PM +0000, Bernhard Beschow wrote:
> 
> 
> Am 7. Januar 2024 23:16:23 UTC schrieb Bernhard Beschow <shentey@gmail.com>:
> >This is a follow-up on commit 89965db43cce "hw/isa/piix3: Avoid Xen-specific
> >variant of piix3_write_config()" which introduced
> >piix_intx_routing_notifier_xen(). This function is implemented in board code but
> >accesses the PCI configuration space of the PIIX ISA function to determine the
> >PCI interrupt routes. Avoid this by reusing pci_device_route_intx_to_irq() which
> >makes piix_intx_routing_notifier_xen() more device-agnostic.
> >
> >One remaining improvement would be making piix_intx_routing_notifier_xen()
> >agnostic towards the number of PCI interrupt routes and move it to xen-hvm.
> >This might be useful for possible Q35 Xen efforts but remains a future exercise
> >for now.
> >
> >Signed-off-by: Bernhard Beschow <shentey@gmail.com>
> 
> Hi Michael,
> 
> could you tag this, too? Or do we need another R-b?
> 
> Best regards,
> Bernhard

tagged, too.

> >---
> > hw/i386/pc_piix.c | 9 +++------
> > 1 file changed, 3 insertions(+), 6 deletions(-)
> >
> >diff --git a/hw/i386/pc_piix.c b/hw/i386/pc_piix.c
> >index 042c13cdbc..abfcfe4d2b 100644
> >--- a/hw/i386/pc_piix.c
> >+++ b/hw/i386/pc_piix.c
> >@@ -92,13 +92,10 @@ static void piix_intx_routing_notifier_xen(PCIDevice *dev)
> > {
> >     int i;
> > 
> >-    /* Scan for updates to PCI link routes (0x60-0x63). */
> >+    /* Scan for updates to PCI link routes. */
> >     for (i = 0; i < PIIX_NUM_PIRQS; i++) {
> >-        uint8_t v = dev->config_read(dev, PIIX_PIRQCA + i, 1);
> >-        if (v & 0x80) {
> >-            v = 0;
> >-        }
> >-        v &= 0xf;
> >+        const PCIINTxRoute route = pci_device_route_intx_to_irq(dev, i);
> >+        const uint8_t v = route.mode == PCI_INTX_ENABLED ? route.irq : 0;
> >         xen_set_pci_link_route(i, v);
> >     }
> > }



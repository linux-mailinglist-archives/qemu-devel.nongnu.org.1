Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B13427B9A69
	for <lists+qemu-devel@lfdr.de>; Thu,  5 Oct 2023 05:48:21 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qoFHv-0005tB-EM; Wed, 04 Oct 2023 23:44:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qoFHa-0004rF-Gs
 for qemu-devel@nongnu.org; Wed, 04 Oct 2023 23:44:18 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qoFHZ-0000E2-46
 for qemu-devel@nongnu.org; Wed, 04 Oct 2023 23:44:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1696477452;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=i08g2Y3CGAaSjKQp/C/ixb+I7WFjEj9qgGznvzU8bM4=;
 b=hAMaGO8YpLHm3Aya20474NcXr1fbBzTU/vekHcItsEcbIfkbp64luUOmJDISrqYgQjDQgs
 AwIbt9CMgDxL0z0LC9Ims4++r+uprxGTu5b9VuXdTvZUXqU9qP3mpyG4mzsHPkl5rYKF04
 aor+lSM2mr/M5XjfOUnXxAQfs6bscNY=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-70-GRg5-Z0hP1-CtB6q-3qDqg-1; Wed, 04 Oct 2023 23:44:05 -0400
X-MC-Unique: GRg5-Z0hP1-CtB6q-3qDqg-1
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-3fe1521678fso3817195e9.1
 for <qemu-devel@nongnu.org>; Wed, 04 Oct 2023 20:44:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696477444; x=1697082244;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=i08g2Y3CGAaSjKQp/C/ixb+I7WFjEj9qgGznvzU8bM4=;
 b=IRtxqzZ8A21WTXi2RCesvcvXSdvdBt/ipLGT2jBkbFkX1o3tuBglBwFvEpZt25z5hK
 bE5i15cgLjKjrgKDa9hODNo61ULmgBmZoRIctbzyp+QWyuG5N5uxjU+7faVg5JA/Q7aW
 5UAofj62tsQ6kqDnjeMHZnptJ0QTAmp2A4AT0sMgGdEN+uBCX/D6ungagXRTh2BFadvA
 E1n9+VLPn2vbYH5OlmnG5pWjNKnYdtcA5Hb8k+Nw0ct0VXKwAQXYBd3XtT2X0VXHLDcs
 /77lutlnXDnWiL8+ULwTyG/IPbw/JsFohfJe5rnW0iu5jpi6qI6BjSo9xgC461EA2H3E
 m3sQ==
X-Gm-Message-State: AOJu0YwWmHUGRDaDsWsQ4UzvCemmSloUr+aT7v1/f/H65DSslUi1zzoh
 gCBBcVrhpRH/41HHYSIGAAc1atTpnwsqFRisutyOlvO5zVeGiKEkFgaAmctwpaY0kdWGfJSygvI
 t9J6XhJlVfLk4wwNWmqlwnP+zxGCHCL9TLG4+g9GsnXJT1lWvVIkDKxz6RAwTN0uzVh08
X-Received: by 2002:a05:600c:21d5:b0:3fe:5501:d284 with SMTP id
 x21-20020a05600c21d500b003fe5501d284mr4164791wmj.11.1696477443865; 
 Wed, 04 Oct 2023 20:44:03 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHsKpVIVnrxh6H+LdzE/Zqc7KSYb/JdrXTo/GHIVFmHqMpL1lknkU4tTHiW4hWoQ2yrf2tYBA==
X-Received: by 2002:a05:600c:21d5:b0:3fe:5501:d284 with SMTP id
 x21-20020a05600c21d500b003fe5501d284mr4164781wmj.11.1696477443554; 
 Wed, 04 Oct 2023 20:44:03 -0700 (PDT)
Received: from redhat.com ([2.52.137.96]) by smtp.gmail.com with ESMTPSA id
 1-20020a05600c230100b0040644e699a0sm2775561wmo.45.2023.10.04.20.44.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Oct 2023 20:44:02 -0700 (PDT)
Date: Wed, 4 Oct 2023 23:44:00 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 David Woodhouse <dwmw@amazon.co.uk>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Subject: [PULL v2 24/53] hw/isa/ich9: Add comment on imperfect emulation of
 PIC vs. I/O APIC routing
Message-ID: <886e0a5f31bf3d40dd8d9199674a4bad64942fde.1696477105.git.mst@redhat.com>
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

From: David Woodhouse <dwmw@amazon.co.uk>

As noted in the comment, the PCI INTx lines are supposed to be routed
to *both* the PIC and the I/O APIC. It's just that we don't cope with
the concept of an IRQ being asserted to two *different* pins on the
two irqchips.

So we have this hack of routing to I/O APIC only if the PIRQ routing to
the PIC is disabled. Which seems to work well enough, even when I try
hard to break it with kexec. But should be explicitly documented and
understood.

Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
Message-Id: <112a09643b8191c4eae7d92fa247a861ab90a9ee.camel@infradead.org>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/isa/lpc_ich9.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/hw/isa/lpc_ich9.c b/hw/isa/lpc_ich9.c
index 9c47a2f6c7..bce487ac4e 100644
--- a/hw/isa/lpc_ich9.c
+++ b/hw/isa/lpc_ich9.c
@@ -304,6 +304,21 @@ static PCIINTxRoute ich9_route_intx_pin_to_irq(void *opaque, int pirq_pin)
             route.irq = -1;
         }
     } else {
+        /*
+         * Strictly speaking, this is wrong. The PIRQ should be routed
+         * to *both* the I/O APIC and the PIC, on different pins. The
+         * I/O APIC has a fixed mapping to IRQ16-23, while the PIC is
+         * routed according to the PIRQx_ROUT configuration. But QEMU
+         * doesn't (yet) cope with the concept of pin numbers differing
+         * between PIC and I/O APIC, and neither does the in-kernel KVM
+         * irqchip support. So we route to the I/O APIC *only* if the
+         * routing to the PIC is disabled in the PIRQx_ROUT settings.
+         *
+         * This seems to work even if we boot a Linux guest with 'noapic'
+         * to make it use the legacy PIC, and then kexec directly into a
+         * new kernel which uses the I/O APIC. The new kernel explicitly
+         * disables the PIRQ routing even though it doesn't need to care.
+         */
         route.irq = ich9_pirq_to_gsi(pirq_pin);
     }
 
-- 
MST



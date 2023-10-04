Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4440C7B7AEF
	for <lists+qemu-devel@lfdr.de>; Wed,  4 Oct 2023 11:00:14 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qnxWI-00085q-A7; Wed, 04 Oct 2023 04:46:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qnxVV-0007Nl-3r
 for qemu-devel@nongnu.org; Wed, 04 Oct 2023 04:45:27 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qnxVE-00027f-Hi
 for qemu-devel@nongnu.org; Wed, 04 Oct 2023 04:45:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1696409107;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=i08g2Y3CGAaSjKQp/C/ixb+I7WFjEj9qgGznvzU8bM4=;
 b=X/KDhcLJghwvU9UzLD6sh6UM2Y8KL13xf5moVihaaoGdJYchaCmzWHWi1jNKp8NpYkQdGI
 CgCvLrGuaX/Bi9oO2cTGYpA3qAKIj7eaHW9JBZ6U/hjlv4zEi5/+tXHXQMm/eNaVJkm64f
 v2Vqany1JobeV9Xus8/C8d7NWbwCRrc=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-457-n5vXlw4tMmaNrP2MsBIqSg-1; Wed, 04 Oct 2023 04:44:51 -0400
X-MC-Unique: n5vXlw4tMmaNrP2MsBIqSg-1
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-31fd48da316so1330746f8f.3
 for <qemu-devel@nongnu.org>; Wed, 04 Oct 2023 01:44:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696409089; x=1697013889;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=i08g2Y3CGAaSjKQp/C/ixb+I7WFjEj9qgGznvzU8bM4=;
 b=M919X+AIdC8IW0X2VS+kkr/IJtanciDHNRSt4RP61aJtEYAs4itTQ8NGfNwgJt65uV
 1qatNSHnPDlW3FGQM4+hI0ghlReiz6FBB6HpssAm6kEYF4rQm8MwQbTigPtaj2ko9MqW
 MlRlXQoeBchQfS2ET0NiZ4rB9gkgthg4hseqJBn/kvIOQlilWuEWxtdEEWgzpng1LX9r
 xAQhRaKT2MP2fcd+moe63PWmIYc8yTeJIAHApEyUhsgcjcyyCFtVPL8xADqH4uDLxIND
 qOkMyETYd4cS9Qhdn6qZzJ1vTyYZ4Nj1f/qjIMVARaJ5KFy/vbKc7a1BcO4ByeVxNWep
 CSZA==
X-Gm-Message-State: AOJu0Yx6kofK47yPGY48xtU5Ybzq1nlNqfpIKwYrT43iWENc1LyjteNg
 kEKsIdAjuTiYc19yXUbDqEMdYhmry1KMoSTXPdVFwI1oXxETnGbGS9Z1teMgoKt674TbFkGsPCA
 PL9am7i51I64RHu9g1xSeu4wSO4FarNF0pl4Vc5Fa0sAYldhu25Z/OgvXULTRYskz6E8V
X-Received: by 2002:a5d:4d8c:0:b0:323:36a3:8ca with SMTP id
 b12-20020a5d4d8c000000b0032336a308camr1444276wru.28.1696409089441; 
 Wed, 04 Oct 2023 01:44:49 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHzp6ofVJk0LfTuhT3AWJd9nINIUPbjNv/N6PODJRWKL9apw2QKgaErTnos0XWib7b7oh+Kqg==
X-Received: by 2002:a5d:4d8c:0:b0:323:36a3:8ca with SMTP id
 b12-20020a5d4d8c000000b0032336a308camr1444252wru.28.1696409088991; 
 Wed, 04 Oct 2023 01:44:48 -0700 (PDT)
Received: from redhat.com ([2.52.137.96]) by smtp.gmail.com with ESMTPSA id
 i5-20020adffdc5000000b0031fb91f23e9sm3477643wrs.43.2023.10.04.01.44.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Oct 2023 01:44:48 -0700 (PDT)
Date: Wed, 4 Oct 2023 04:44:46 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 David Woodhouse <dwmw@amazon.co.uk>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Subject: [PULL 31/63] hw/isa/ich9: Add comment on imperfect emulation of PIC
 vs. I/O APIC routing
Message-ID: <a1802d230f5de1b99631d6bd2df5ce1adaffe0c6.1696408966.git.mst@redhat.com>
References: <cover.1696408966.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1696408966.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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



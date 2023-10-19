Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BE397D01B2
	for <lists+qemu-devel@lfdr.de>; Thu, 19 Oct 2023 20:34:58 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qtXhX-00014n-Kn; Thu, 19 Oct 2023 14:24:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qtXgb-00084C-Hh
 for qemu-devel@nongnu.org; Thu, 19 Oct 2023 14:24:00 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qtXgZ-0001ld-LI
 for qemu-devel@nongnu.org; Thu, 19 Oct 2023 14:23:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697739835;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=f/7Z3H+51oJIJWzVgGhiU5HVqcfMDnbILXmSBJdNG3g=;
 b=L2r9Qk3YU9Rv66pmfMCjeG7Og4qjvec1YjKbYn32yEfjAIKiaZMHIrb/j6Ls4bWNJnvCy+
 jy00BvjBJLoWnX9tPKPN7GpRSMFyzP/a1NBpNFJdQ6ziwayza8mw3fFlHLJsrfYCMi/g6G
 uBM1hnKkdR/RQP3HyKyH2lwwK50VzS8=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-73-O5szvckFPXuV9Ppz-PN74g-1; Thu, 19 Oct 2023 14:23:53 -0400
X-MC-Unique: O5szvckFPXuV9Ppz-PN74g-1
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-4084163ecd9so9315075e9.3
 for <qemu-devel@nongnu.org>; Thu, 19 Oct 2023 11:23:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697739832; x=1698344632;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=f/7Z3H+51oJIJWzVgGhiU5HVqcfMDnbILXmSBJdNG3g=;
 b=TKFtZz24NaGypN5IcdoYM8BxURVtzhBeHYIiIW0vxu9R9Oen7+vxXQJq8li9N8krH3
 QexTkfjdDQ0DYg2nVOx+VauPLYyueQzl9Kx6WajS1KOqG/rW8NGU6f+9r9gZhfKWMzwn
 mzROj3WLkG5UOEeStWQ9VqUYiDP4AnwYbIw5Rww7v+diQHIUusw2fPWIlVtytS1ZXQ64
 5XW6e9hhLOjnfxl7IDSVMVflSzZibPGBbr89zo/I+oLSF8wfrVvf/qL9ksP2iSBdyER1
 EdudXm4ur+b/xC/A3SWoPypBK9um2djK7o+bMuYqrDriYVe5kuI9kyGNMyJFsDHmWUIS
 FmkA==
X-Gm-Message-State: AOJu0YzU5ujdN2l7WBscrV/x6vbV4YoLeHkNm7oHJNDZ/QfcFfryOLOo
 ojQJWkbNlSVZncURbNH1PssINV09NaiYTeC3Gda98AJR9MBi4k/+9biZGaKR8JSL5ULpFrk6aUz
 GMH+YxMUkPsO7bfsyF+aFBb8YfLapuKqjxT7d8C0/amgaYigKoZtJGDv4jTMn6BN+OBfB
X-Received: by 2002:a05:600c:45d1:b0:406:4a32:52fc with SMTP id
 s17-20020a05600c45d100b004064a3252fcmr2622389wmo.21.1697739832046; 
 Thu, 19 Oct 2023 11:23:52 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFRt5C+snR4lntL86DbK35CqKCzYTNYauKaTEkLgOSRpQ4ZiRYTKh/x3TNOWLor72nu445Kzg==
X-Received: by 2002:a05:600c:45d1:b0:406:4a32:52fc with SMTP id
 s17-20020a05600c45d100b004064a3252fcmr2622373wmo.21.1697739831693; 
 Thu, 19 Oct 2023 11:23:51 -0700 (PDT)
Received: from redhat.com ([2a06:c701:73d2:bf00:e379:826:5137:6b23])
 by smtp.gmail.com with ESMTPSA id
 bg34-20020a05600c3ca200b00402f713c56esm221604wmb.2.2023.10.19.11.23.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Oct 2023 11:23:50 -0700 (PDT)
Date: Thu, 19 Oct 2023 14:23:49 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Bernhard Beschow <shentey@gmail.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Aurelien Jarno <aurelien@aurel32.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?utf-8?B?SGVydsOp?= Poussineau <hpoussin@reactos.org>
Subject: [PULL v2 59/78] hw/isa/piix: Harmonize names of reset control memory
 regions
Message-ID: <2f88ed357542dae7a40b3253a9021e783d1be795.1697739629.git.mst@redhat.com>
References: <cover.1697739629.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover.1697739629.git.mst@redhat.com>
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

There is no need for having different names here. Having the same name
further allows code to be shared between PIIX3 and PIIX4.

Signed-off-by: Bernhard Beschow <shentey@gmail.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Message-Id: <20231007123843.127151-23-shentey@gmail.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/isa/piix.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/isa/piix.c b/hw/isa/piix.c
index 270b8eb1f7..bd66fb7475 100644
--- a/hw/isa/piix.c
+++ b/hw/isa/piix.c
@@ -339,7 +339,7 @@ static void pci_piix3_realize(PCIDevice *dev, Error **errp)
     }
 
     memory_region_init_io(&d->rcr_mem, OBJECT(dev), &rcr_ops, d,
-                          "piix3-reset-control", 1);
+                          "piix-reset-control", 1);
     memory_region_add_subregion_overlap(pci_address_space_io(dev),
                                         PIIX_RCR_IOPORT, &d->rcr_mem, 1);
 
@@ -532,7 +532,7 @@ static void piix4_realize(PCIDevice *dev, Error **errp)
                              "intr", 1);
 
     memory_region_init_io(&s->rcr_mem, OBJECT(dev), &rcr_ops, s,
-                          "reset-control", 1);
+                          "piix-reset-control", 1);
     memory_region_add_subregion_overlap(pci_address_space_io(dev),
                                         PIIX_RCR_IOPORT, &s->rcr_mem, 1);
 
-- 
MST



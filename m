Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 56F347D015A
	for <lists+qemu-devel@lfdr.de>; Thu, 19 Oct 2023 20:24:53 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qtXhJ-0000LX-N3; Thu, 19 Oct 2023 14:24:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qtXg3-0007Qr-BZ
 for qemu-devel@nongnu.org; Thu, 19 Oct 2023 14:23:31 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qtXfq-0000tC-56
 for qemu-devel@nongnu.org; Thu, 19 Oct 2023 14:23:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697739789;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=o+ER8U4zTaPMQSzbJAzk8GehGsCBqp1JYIJr1D7ENQ0=;
 b=HTjloLVyLXyERNrVXAOqFaAT9wzuEOXspt+p4CW88n/TosnaQt2wzSjvUE3j9xpjsWbGOe
 lgzEL/OytctJL83pPXrMsNrvYKDlWDImotrY0u/RI4GyiY+NqCZtvbj5NIp7FQnrzOxjZb
 Pcdj+6kN9nnNwMzXpxkck5thawNFHEU=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-640-GLxDjTJ8OkajbIyxlnXqKg-1; Thu, 19 Oct 2023 14:23:08 -0400
X-MC-Unique: GLxDjTJ8OkajbIyxlnXqKg-1
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-4084163ecd9so9310675e9.3
 for <qemu-devel@nongnu.org>; Thu, 19 Oct 2023 11:23:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697739785; x=1698344585;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=o+ER8U4zTaPMQSzbJAzk8GehGsCBqp1JYIJr1D7ENQ0=;
 b=rSVUz27fSN5KtV/TR7H0+h/r++3pSbr4CUgKK9beGxl8LVXEnoKZlZVRxa3Tt6PGMW
 jQZ0UJLiAV5dX7gnSgq4Q0uPlxgYzH39abdpiljKDjuW3Ft5OOQcuB9APVIo8wjAJ+oQ
 /FoZTVsPvDjXtSEDxP4Jk7tCwRi+TS/D0YtxDvrfcmoQoqqQfaAnVlPwzVNAQLO0O7Fx
 VW3JggycqYdqieW7gN3Cwk1q+sFplpSG+YktqLu02TPV+Tv5ZwdejuM7wJQ6omgbyZmU
 /OMBX6UnKqxKzXM+Vyy7uyjoKovPw5fHI4fR5c4J7IKIHMTapwPsEvxfpbCuJnSvXcSZ
 dqZw==
X-Gm-Message-State: AOJu0Yxl+lMRxQZHcF33RcJmz9XN3WVgJXFuA1ffitepN76SxPFU5r1N
 Q9VjX+LHkR/9RJwZyIIAyrr7fqYbL8mMGzGSygUsK3bWwC91+HupkSDP75VbZn+gRMepgHqrAAa
 ujKCht4A05CV1js4e59mQilQ3x0YhFTrm1jDVBG9ucvh5BSBrSEuAs8zP3egV/qKLBAAF
X-Received: by 2002:a05:600c:35c5:b0:408:4266:12db with SMTP id
 r5-20020a05600c35c500b00408426612dbmr2423916wmq.13.1697739785314; 
 Thu, 19 Oct 2023 11:23:05 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE9DOYcUxjaz0e08hZZk5sGOR0osXYYaYJwyJArwjM1RmBaQ0GVBiZXsHfHYx0TfaK1+PERpA==
X-Received: by 2002:a05:600c:35c5:b0:408:4266:12db with SMTP id
 r5-20020a05600c35c500b00408426612dbmr2423893wmq.13.1697739784937; 
 Thu, 19 Oct 2023 11:23:04 -0700 (PDT)
Received: from redhat.com ([2a06:c701:73d2:bf00:e379:826:5137:6b23])
 by smtp.gmail.com with ESMTPSA id
 i6-20020adfe486000000b0032415213a6fsm4990901wrm.87.2023.10.19.11.23.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Oct 2023 11:23:04 -0700 (PDT)
Date: Thu, 19 Oct 2023 14:23:02 -0400
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
Subject: [PULL v2 42/78] hw/i386/pc_piix: Wire PIIX3's ISA interrupts by new
 "isa-irqs" property
Message-ID: <e6d1ee24a79a4e298a12e89f4518a8b855d97d81.1697739629.git.mst@redhat.com>
References: <cover.1697739629.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1697739629.git.mst@redhat.com>
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

Avoid assigning the private member of struct PIIX3State from outside which goes
against best QOM practices. Instead, implement best QOM practice by adding an
"isa-irqs" array property to TYPE_PIIX3_DEVICE and assign it in board code, i.e.
from outside.

Signed-off-by: Bernhard Beschow <shentey@gmail.com>
Message-Id: <20231007123843.127151-6-shentey@gmail.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 include/hw/southbridge/piix.h | 2 +-
 hw/i386/pc_piix.c             | 7 ++++++-
 hw/isa/piix3.c                | 2 ++
 3 files changed, 9 insertions(+), 2 deletions(-)

diff --git a/include/hw/southbridge/piix.h b/include/hw/southbridge/piix.h
index 2317bb7974..bb898c6c88 100644
--- a/include/hw/southbridge/piix.h
+++ b/include/hw/southbridge/piix.h
@@ -46,7 +46,7 @@ struct PIIXState {
 #endif
     uint64_t pic_levels;
 
-    qemu_irq *pic;
+    qemu_irq pic[ISA_NUM_IRQS];
 
     /* This member isn't used. Just for save/load compatibility */
     int32_t pci_irq_levels_vmstate[PIIX_NUM_PIRQS];
diff --git a/hw/i386/pc_piix.c b/hw/i386/pc_piix.c
index a003923788..4dc7298c15 100644
--- a/hw/i386/pc_piix.c
+++ b/hw/i386/pc_piix.c
@@ -263,10 +263,15 @@ static void pc_init1(MachineState *machine,
     if (pcmc->pci_enabled) {
         PIIX3State *piix3;
         PCIDevice *pci_dev;
+        DeviceState *dev;
+        size_t i;
 
         pci_dev = pci_new_multifunction(-1, TYPE_PIIX3_DEVICE);
         piix3 = PIIX3_PCI_DEVICE(pci_dev);
-        piix3->pic = x86ms->gsi;
+        dev = DEVICE(pci_dev);
+        for (i = 0; i < ISA_NUM_IRQS; i++) {
+            qdev_connect_gpio_out_named(dev, "isa-irqs", i, x86ms->gsi[i]);
+        }
         pci_realize_and_unref(pci_dev, pci_bus, &error_fatal);
 
         if (xen_enabled()) {
diff --git a/hw/isa/piix3.c b/hw/isa/piix3.c
index 7240c91440..c17547a2c0 100644
--- a/hw/isa/piix3.c
+++ b/hw/isa/piix3.c
@@ -312,6 +312,8 @@ static void pci_piix3_init(Object *obj)
 {
     PIIX3State *d = PIIX3_PCI_DEVICE(obj);
 
+    qdev_init_gpio_out_named(DEVICE(obj), d->pic, "isa-irqs", ISA_NUM_IRQS);
+
     object_initialize_child(obj, "rtc", &d->rtc, TYPE_MC146818_RTC);
 }
 
-- 
MST



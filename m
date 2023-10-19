Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 37BD67D01A6
	for <lists+qemu-devel@lfdr.de>; Thu, 19 Oct 2023 20:33:54 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qtXiH-0002Uh-Vm; Thu, 19 Oct 2023 14:25:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qtXgY-0007zB-Hh
 for qemu-devel@nongnu.org; Thu, 19 Oct 2023 14:23:54 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qtXgW-0001l5-Vh
 for qemu-devel@nongnu.org; Thu, 19 Oct 2023 14:23:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697739832;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=lH1AqdjPXgfR1Memi78dfyy1TzArPQZzj3BdRAkG12A=;
 b=E7OHhJwUGmhHHUa7x7ffxxF9flE+049nx8/wZFZqQGgSGQgp01dOYQgXO5jwli2/2rkw2T
 h0/QMCS67tkWrMO5iXvIweIU7wvY92WoSYzFgk4eHdJ26hCy9+pzEiIs4AWqr5txwxi/8m
 8qf5BYHX3YKk2oD9D5c+dSwAZLtzlrA=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-473-XgVdFqM5OkuHBbxqY7Z6VQ-1; Thu, 19 Oct 2023 14:23:51 -0400
X-MC-Unique: XgVdFqM5OkuHBbxqY7Z6VQ-1
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-32db43129c6so2743f8f.1
 for <qemu-devel@nongnu.org>; Thu, 19 Oct 2023 11:23:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697739829; x=1698344629;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lH1AqdjPXgfR1Memi78dfyy1TzArPQZzj3BdRAkG12A=;
 b=nZrLo974d7g6+8sttNKd/Gy8iW3+S1IZSIS2MpM5yEERnjeGnNPj598NpDrqjrZ6ch
 /KAPLMVnZfbMQOROd/9KmqMW7wD7Mvrq2eWF4zWDCsVtgzBJpRwBkht8pf9m+j8fhMQy
 SpEghmllhxOqMLmaX8t1Q0dzvOCaozPISD0A+CYt5qrEjjAKYol/1RkzVPtniwz1PY82
 bBW1AuV2zBVqee+3An47V9okSj5gunSGiaJvySrKDthZ/3bMteEBuGQ57sPV50XdL1JO
 kPr9BZjUjtSmFmpo2xu7cTS2WizwZZEshqS0TF3gOgSroNdqc8jRgQk+EeTFhHpvRTZK
 5QDQ==
X-Gm-Message-State: AOJu0Yzm+pjFjaGF2vUMDV5Kr7yNMSD8JTSjEzUCaFMn7rofZcFhktZo
 8qfU/tx9QJtHQ51J3TV+ghwa0bZhjcNcXabZJ0gqh3JjdAcf/LbWIuxXl2Tu59lpEll9SN9K1wx
 wVhEHPt8Q7qr7NRzeCTVq56I6zFjw80BNS4GX+0xRlstefddiBnZ6aPwoeWKAtcdVliw+
X-Received: by 2002:a05:6000:1b06:b0:32d:ba78:2b33 with SMTP id
 f6-20020a0560001b0600b0032dba782b33mr2269036wrz.63.1697739829461; 
 Thu, 19 Oct 2023 11:23:49 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFBgF8FbCzpxQdvVSqKOsRN3045Sne+X0m1uP3tLSWgl+WudD+qmPdAq/rxkpDy1ON5yyGlpA==
X-Received: by 2002:a05:6000:1b06:b0:32d:ba78:2b33 with SMTP id
 f6-20020a0560001b0600b0032dba782b33mr2269016wrz.63.1697739828996; 
 Thu, 19 Oct 2023 11:23:48 -0700 (PDT)
Received: from redhat.com ([2a06:c701:73d2:bf00:e379:826:5137:6b23])
 by smtp.gmail.com with ESMTPSA id
 n13-20020adffe0d000000b0031ad2f9269dsm4993597wrr.40.2023.10.19.11.23.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Oct 2023 11:23:48 -0700 (PDT)
Date: Thu, 19 Oct 2023 14:23:46 -0400
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
Subject: [PULL v2 58/78] hw/isa/piix: Allow for optional PIT creation in PIIX3
Message-ID: <4a0ca61d89f3171ad4855c21052ce8f036f44df4.1697739629.git.mst@redhat.com>
References: <cover.1697739629.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
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



Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A6E7E7D0174
	for <lists+qemu-devel@lfdr.de>; Thu, 19 Oct 2023 20:28:30 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qtXhS-0000mS-PN; Thu, 19 Oct 2023 14:24:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qtXfg-00073M-3d
 for qemu-devel@nongnu.org; Thu, 19 Oct 2023 14:23:02 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qtXfe-0000rJ-K3
 for qemu-devel@nongnu.org; Thu, 19 Oct 2023 14:22:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697739777;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Pzl+3SpXCzlVlixQWa1M8uUNysQnsBwV7t6Y2e5urE4=;
 b=Xb4JNDtTcI23dFOSbHnamMs6EA74H/5UAgceg6zE8jXSgZZVyUTyTOPLB+2R33TIp3cR4j
 NJIZZiuGQgTcndCYhR31iAFq0Q4MAPy+UqieZ1x0x7XRi+T83KEg/dNWyyNI2TkS76auRP
 oS9yONwZqiZ/xEzS0rp1yP/iBAfucvU=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-371-KRSJs1AjMxKjgAsjdZ6K3A-1; Thu, 19 Oct 2023 14:22:56 -0400
X-MC-Unique: KRSJs1AjMxKjgAsjdZ6K3A-1
Received: by mail-lf1-f71.google.com with SMTP id
 2adb3069b0e04-507b9078aaaso4064077e87.2
 for <qemu-devel@nongnu.org>; Thu, 19 Oct 2023 11:22:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697739774; x=1698344574;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Pzl+3SpXCzlVlixQWa1M8uUNysQnsBwV7t6Y2e5urE4=;
 b=TLcS+TtUuAhPxJsALCrsN42KileYQLYnDWVfgtFVj2rVy7eqlW3ORCkjqaLP0ZbQ3W
 oxbhSjDQ1ByPqjLxJGXHmzm7lklxoiCkV10dRqTvj1KnqLhz327ERAmlziNi8RdWMBQe
 /4lQfgG8PD6uxrDzQ7wEBZMzJmrleBnLfi3W3uIPSpP8wkv/7GDeRLGxNRmlS6wBl8K1
 AGICUe3UL1ACs64zWPEe8A4CZJiweyevoPBPUqOtr13yktb30PSyfhetw+EOLNihgaY7
 mdGQwK2eldmj/e4VKBcejQhhg8Ph2uZNp2/rk1AIbatpPTt60uNaHBWGL3tTzyrO5ZjN
 nGAA==
X-Gm-Message-State: AOJu0YxeGRMITx9VwD5KzTehrwnbQ+B6I3XadU2jF15C1Yk8/Rb+XXuC
 ULRsaAANt1xl0TAOQbLpEaTZnMYjra0wY/OUb4tYt+9CeLTKa6gLSVnjLb3TBCK3NKhxQqYUxvl
 XgvX8mL3XfClcge6fryXFJZXkecxHTkcorB6c2EOkuKP6j044wfxq/XxvIVY+KCQcDYu9
X-Received: by 2002:a05:6512:20f:b0:500:7cab:efc3 with SMTP id
 a15-20020a056512020f00b005007cabefc3mr2135193lfo.11.1697739774425; 
 Thu, 19 Oct 2023 11:22:54 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHb32YmTmePsSh8Q/K363JPqLX4R1lcyrOLHOytv4y74WhhoPbIOXekXhDJc02ZWvXzJCScug==
X-Received: by 2002:a05:6512:20f:b0:500:7cab:efc3 with SMTP id
 a15-20020a056512020f00b005007cabefc3mr2135169lfo.11.1697739774004; 
 Thu, 19 Oct 2023 11:22:54 -0700 (PDT)
Received: from redhat.com ([2a06:c701:73d2:bf00:e379:826:5137:6b23])
 by smtp.gmail.com with ESMTPSA id
 k6-20020adfe8c6000000b0030647449730sm5021786wrn.74.2023.10.19.11.22.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Oct 2023 11:22:53 -0700 (PDT)
Date: Thu, 19 Oct 2023 14:22:51 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Bernhard Beschow <shentey@gmail.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>
Subject: [PULL v2 38/78] hw/i386/pc: Merge two if statements into one
Message-ID: <068f463a6bbdfc0715a996b5d93db3a07d8b8942.1697739629.git.mst@redhat.com>
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

By being the only entity assigning a non-NULL value to "rtc_irq", the first if
statement determines whether the second if statement is executed. So merge the
two statements into one.

Signed-off-by: Bernhard Beschow <shentey@gmail.com>
Message-Id: <20231007123843.127151-2-shentey@gmail.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/i386/pc.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index bb3854d1d0..7e6c4dc526 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -1199,7 +1199,6 @@ void pc_basic_device_init(struct PCMachineState *pcms,
     DeviceState *hpet = NULL;
     int pit_isa_irq = 0;
     qemu_irq pit_alt_irq = NULL;
-    qemu_irq rtc_irq = NULL;
     ISADevice *pit = NULL;
     MemoryRegion *ioport80_io = g_new(MemoryRegion, 1);
     MemoryRegion *ioportF0_io = g_new(MemoryRegion, 1);
@@ -1219,6 +1218,8 @@ void pc_basic_device_init(struct PCMachineState *pcms,
      */
     if (pcms->hpet_enabled && (!kvm_irqchip_in_kernel() ||
                                kvm_has_pit_state2())) {
+        qemu_irq rtc_irq;
+
         hpet = qdev_try_new(TYPE_HPET);
         if (!hpet) {
             error_report("couldn't create HPET device");
@@ -1243,9 +1244,6 @@ void pc_basic_device_init(struct PCMachineState *pcms,
         pit_isa_irq = -1;
         pit_alt_irq = qdev_get_gpio_in(hpet, HPET_LEGACY_PIT_INT);
         rtc_irq = qdev_get_gpio_in(hpet, HPET_LEGACY_RTC_INT);
-    }
-
-    if (rtc_irq) {
         qdev_connect_gpio_out(DEVICE(rtc_state), 0, rtc_irq);
     } else {
         uint32_t irq = object_property_get_uint(OBJECT(rtc_state),
@@ -1253,6 +1251,7 @@ void pc_basic_device_init(struct PCMachineState *pcms,
                                                 &error_fatal);
         isa_connect_gpio_out(rtc_state, 0, irq);
     }
+
     object_property_add_alias(OBJECT(pcms), "rtc-time", OBJECT(rtc_state),
                               "date");
 
-- 
MST



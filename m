Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E5AE7D2228
	for <lists+qemu-devel@lfdr.de>; Sun, 22 Oct 2023 11:24:27 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1quUgU-0005q7-6S; Sun, 22 Oct 2023 05:23:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1quUgP-00057c-Dq
 for qemu-devel@nongnu.org; Sun, 22 Oct 2023 05:23:41 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1quUgN-0000Pw-PD
 for qemu-devel@nongnu.org; Sun, 22 Oct 2023 05:23:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697966619;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Pzl+3SpXCzlVlixQWa1M8uUNysQnsBwV7t6Y2e5urE4=;
 b=C0PvUg2Cp2p267pgDHst6NK1HYqxdxDeFuqK86fy5pLgSAKIxS71WaxqIdP60Yo2hDLMAk
 W67ybYOU6xNSsSWZzCXaQV0LJfAkS5HvOljVUV+9ljPOe0d9bEBYuQAr4jalgsSPzcG4N4
 Ydk8x3/PRcXY2kGu3NauI49JxDpno4c=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-637-N1ibNbjFNkOrHDFyCJzgWA-1; Sun, 22 Oct 2023 05:23:37 -0400
X-MC-Unique: N1ibNbjFNkOrHDFyCJzgWA-1
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-32da47641b5so1033771f8f.0
 for <qemu-devel@nongnu.org>; Sun, 22 Oct 2023 02:23:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697966615; x=1698571415;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Pzl+3SpXCzlVlixQWa1M8uUNysQnsBwV7t6Y2e5urE4=;
 b=p6G1s4sLIZFxIIM4A8INAP6pL5Vq5YwoSFO1j8JgwAbtQ2w0SYnaYk2ZD5TiCHqGqD
 eN/3red5O5fc/kIGP1joL8SJh8Zra7zsIZxHVNa0fpJCM7QNZiolxxfR2zNPzf03G3on
 AhKoLI9vwYMeSYLH9FtnmTf/J2RIHRQ8qz2Oy9BvnQq9pzrOXp6WseMYe6AmmV1oaA19
 sde900uqIC4zE89NuotSvNU7zzO14xKIdpKTEkuJ9JAEmo6b4/3Qe8mb6xYbJ2pnlGgd
 buwphS5I+VcLdtX2C7bAGoJg4hA+oHM5urspltrKA2J6x7oEoBz+h+ZWcRQ11qpdWKo+
 cGdA==
X-Gm-Message-State: AOJu0Yx2BYm584EBB8S+4X/14OMtg5IBLrdECwQEpAW3e6XT2YqJ8fQ7
 UfIpz7X8MgDnqqKAfTVyEFHkO+PbGAFla0l30t7K1Tctdz9BPFBsiuW+rS4YbsiWLn8kxPKXsiw
 aKbYD29we7fSZ3eVjDI8PzfKO2usozQSnkjznaTWSg/jZTvi4n49lpGP52qV4tv2oTn+z
X-Received: by 2002:a5d:664c:0:b0:32d:93aa:3d63 with SMTP id
 f12-20020a5d664c000000b0032d93aa3d63mr4631557wrw.69.1697966615529; 
 Sun, 22 Oct 2023 02:23:35 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGvc9KUMTAncOmKvVGtz92vaBolbkXoWoNm1hAtcn4/6CB324NPi6cPb/tDr0snC82D7uEqqQ==
X-Received: by 2002:a5d:664c:0:b0:32d:93aa:3d63 with SMTP id
 f12-20020a5d664c000000b0032d93aa3d63mr4631541wrw.69.1697966615235; 
 Sun, 22 Oct 2023 02:23:35 -0700 (PDT)
Received: from redhat.com ([2.52.1.53]) by smtp.gmail.com with ESMTPSA id
 r6-20020a5d6946000000b0032da4c98ab2sm5274424wrw.35.2023.10.22.02.23.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 22 Oct 2023 02:23:34 -0700 (PDT)
Date: Sun, 22 Oct 2023 05:23:31 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Bernhard Beschow <shentey@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Subject: [PULL v3 22/62] hw/i386/pc: Merge two if statements into one
Message-ID: <9c91051119f8c493a5802c4f5347516679e55552.1697966402.git.mst@redhat.com>
References: <cover.1697966402.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1697966402.git.mst@redhat.com>
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



Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 572197CE1F4
	for <lists+qemu-devel@lfdr.de>; Wed, 18 Oct 2023 17:59:56 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qt8wh-0001Bb-M6; Wed, 18 Oct 2023 11:58:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qt8uh-0004Kv-Bn
 for qemu-devel@nongnu.org; Wed, 18 Oct 2023 11:56:53 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qt8uf-00077k-HW
 for qemu-devel@nongnu.org; Wed, 18 Oct 2023 11:56:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697644608;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Pzl+3SpXCzlVlixQWa1M8uUNysQnsBwV7t6Y2e5urE4=;
 b=bMqzSCdjVY2i4bDiCT16xJgCGWMOtiIj97JACnxS69JZ5dAyDCvqllbWPBdT6+lR0A7Qu4
 UvndNA39G/pYnt4ib0sGPwkPLchbfokoVPVWLEBvJ9AqOlFE7n2aI6SwzCPGji6fy4957O
 YpmFPQCNzyZJCCkZWDR7sXvqMg3q6x0=
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com
 [209.85.208.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-553-BcrutSg3OZmJi6lcji0sGQ-1; Wed, 18 Oct 2023 11:56:41 -0400
X-MC-Unique: BcrutSg3OZmJi6lcji0sGQ-1
Received: by mail-lj1-f199.google.com with SMTP id
 38308e7fff4ca-2c53c85e482so17633321fa.1
 for <qemu-devel@nongnu.org>; Wed, 18 Oct 2023 08:56:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697644600; x=1698249400;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Pzl+3SpXCzlVlixQWa1M8uUNysQnsBwV7t6Y2e5urE4=;
 b=kB8KGmURjgaJhwsiWjQsTjJVVKRRokTZK6bshDnDV2Wm3akVM9qAPyI4Rftu/c0++Y
 2yrRLS7tN0xdstOAVvBDrVmAiL0a1GS7lp2Yyr55yW4u9Xz4g/u1aH8nufEP+18HbWCw
 F1k6BeozLDr6g8Hyb7rQl0pnNRclL0X6yTz8EJ+rv8q9jEdMP8kNXigsU0JbPKQ3P4eu
 fp3sg20ulY8Mpm7ZTmZs5BVZ1ngBgm/vMRBQYCXabcGqIt2/N3yCDhG7JZLWDk9LqnyS
 icuYB9VC0ot8JISc8pd/vyHKaAWh7hq18Qf0MY3r53hF1njZDY/pYiJJ0gSeo96af6WZ
 JF0A==
X-Gm-Message-State: AOJu0Yw41F4ILfOygZxgTCC3SZ9aWA0Vb4VTAAKQFyi8bvaMY9ypQNuS
 9sO86OBWhuH/kR2IEY9UGZhjDPHPkyu5woZeGoZ7KNn6XYHp9roXC2VLuw4G+eHZthX7gniMMzX
 vspaiTelfYMW5aA/W+pqrAJdoB/eVFLuDRkYMxGcDeXVUzDm0tj+x/ts556fRk2qEEn/ef34=
X-Received: by 2002:a2e:7d04:0:b0:2c5:2fa8:716a with SMTP id
 y4-20020a2e7d04000000b002c52fa8716amr4341469ljc.9.1697644599801; 
 Wed, 18 Oct 2023 08:56:39 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH4cl0C62/P20R7jbQyYrUvQzg9wOIpAsbNlwtwp88CbQ5TWbJkI+yLvdLZfRXUcxMrbo/i2w==
X-Received: by 2002:a2e:7d04:0:b0:2c5:2fa8:716a with SMTP id
 y4-20020a2e7d04000000b002c52fa8716amr4341455ljc.9.1697644599513; 
 Wed, 18 Oct 2023 08:56:39 -0700 (PDT)
Received: from redhat.com ([2a02:14f:1f2:2037:f34:d61b:7da0:a7be])
 by smtp.gmail.com with ESMTPSA id
 b12-20020a05600c150c00b0040586360a36sm1971567wmg.17.2023.10.18.08.56.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Oct 2023 08:56:39 -0700 (PDT)
Date: Wed, 18 Oct 2023 11:56:35 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Bernhard Beschow <shentey@gmail.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>
Subject: [PULL 43/83] hw/i386/pc: Merge two if statements into one
Message-ID: <237b90d33a12914d4174d34269edf26c765b3b87.1697644299.git.mst@redhat.com>
References: <cover.1697644299.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1697644299.git.mst@redhat.com>
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



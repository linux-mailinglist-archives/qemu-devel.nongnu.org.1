Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 44A117D019C
	for <lists+qemu-devel@lfdr.de>; Thu, 19 Oct 2023 20:32:51 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qtXiE-0002Ft-7w; Thu, 19 Oct 2023 14:25:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qtXgB-0007XX-Bm
 for qemu-devel@nongnu.org; Thu, 19 Oct 2023 14:23:34 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qtXg3-0000tk-6o
 for qemu-devel@nongnu.org; Thu, 19 Oct 2023 14:23:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697739794;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=EV0w/juyamhfIdi/nYYRPk3ACWIP8V+WfsiMSqIQCVQ=;
 b=O/mQC0osdbFBV8AMegRR20C+UuLOW3jsHS+Fh0BDesIWOjYChf/htDHhi0E3+JvPht2zlz
 Igd25JBVDqVsWF2tLCCXl4Yu1bfIJLWE8dI/S9X7JtXtd3eQlAQmCnsKK74LyUQ2tKHIpN
 I0LmKoCYJLrkh8nhKCjV5mgw1zH+dpc=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-407-tXNn0bb5NBWIT0RPPoFJxQ-1; Thu, 19 Oct 2023 14:23:13 -0400
X-MC-Unique: tXNn0bb5NBWIT0RPPoFJxQ-1
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-3f5df65fa35so50958555e9.3
 for <qemu-devel@nongnu.org>; Thu, 19 Oct 2023 11:23:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697739791; x=1698344591;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=EV0w/juyamhfIdi/nYYRPk3ACWIP8V+WfsiMSqIQCVQ=;
 b=mO/qGLZ8eABy2zTTAfwSqDlHv/FYnQoo8l/ZcyaEMaIZQktFdlz6SpG4ztx/wE44+y
 gYOlJnBb0nmcXLPQJl8CLdOyomwqxAQv2ibalmo6d9wb6ZXdSg2I4SKm22SiGBC0dnzk
 NlyuTDi3DvPLNVa88H7B/qsX8VkWhda/aQP5ZnCWT8uceh4hE8U+lC4kKEea9J84ZTZq
 LHzX/fWNwvaw7IP9FopxbvP04z30zOXX4Kv24E8PNmtIKp+6OZ5WCQ8gsuQ7rpj0u+kR
 gsCA9mH3YWpRsielo0DwAVU17+VMHyJyo5VfnVy2mPWMTo7DnAwqj8lCBpXiNSZDpQGu
 Ou4Q==
X-Gm-Message-State: AOJu0Yx7jEmmEHT6hV56CYAFOzgjrbmi8D+FIubspM9c3Q15B1D8FBjo
 E7hjoBW06hb3nx/4fCxVZc3aXHkI8rE/b3ulHWTUuR7JkTS+n+TilhDlTNIicsPdmSawNFoYRxH
 f++m+gjyLNVl65j0LNZUVzurBHUD8gLfkdMsvvkwU71t6bwtLaUvpisq5INHqou0Z9USu
X-Received: by 2002:a05:600c:4f83:b0:408:41e7:96ea with SMTP id
 n3-20020a05600c4f8300b0040841e796eamr2457169wmq.31.1697739791303; 
 Thu, 19 Oct 2023 11:23:11 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGpxlmdKNumme+fjoL/nQA4NLwOYGaOXSbA6YEEU8LTwmunjgTkU/NMZhqIYDU8G7GYtxhlcA==
X-Received: by 2002:a05:600c:4f83:b0:408:41e7:96ea with SMTP id
 n3-20020a05600c4f8300b0040841e796eamr2457151wmq.31.1697739790956; 
 Thu, 19 Oct 2023 11:23:10 -0700 (PDT)
Received: from redhat.com ([2a06:c701:73d2:bf00:e379:826:5137:6b23])
 by smtp.gmail.com with ESMTPSA id
 d3-20020adfef83000000b0032dc2110d01sm5010480wro.61.2023.10.19.11.23.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Oct 2023 11:23:09 -0700 (PDT)
Date: Thu, 19 Oct 2023 14:23:08 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Bernhard Beschow <shentey@gmail.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Aurelien Jarno <aurelien@aurel32.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?utf-8?B?SGVydsOp?= Poussineau <hpoussin@reactos.org>
Subject: [PULL v2 44/78] hw/isa/piix3: Rename "pic" attribute to "isa_irqs_in"
Message-ID: <9fe11ba144a6301ed4c37f2d5d376f81d91570f9.1697739629.git.mst@redhat.com>
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

TYPE_PIIX3_DEVICE doesn't instantiate a PIC since it relies on the board to do
so. The "pic" attribute, however, suggests that there is one. Rename the
attribute to reflect that it represents ISA interrupt lines. Use the same naming
convention as in the VIA south bridges as well as in TYPE_I82378.

Signed-off-by: Bernhard Beschow <shentey@gmail.com>
Message-Id: <20231007123843.127151-8-shentey@gmail.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 include/hw/southbridge/piix.h | 2 +-
 hw/isa/piix3.c                | 5 +++--
 2 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/include/hw/southbridge/piix.h b/include/hw/southbridge/piix.h
index bb898c6c88..b07ff6bb26 100644
--- a/include/hw/southbridge/piix.h
+++ b/include/hw/southbridge/piix.h
@@ -46,7 +46,7 @@ struct PIIXState {
 #endif
     uint64_t pic_levels;
 
-    qemu_irq pic[ISA_NUM_IRQS];
+    qemu_irq isa_irqs_in[ISA_NUM_IRQS];
 
     /* This member isn't used. Just for save/load compatibility */
     int32_t pci_irq_levels_vmstate[PIIX_NUM_PIRQS];
diff --git a/hw/isa/piix3.c b/hw/isa/piix3.c
index c17547a2c0..616f5418fa 100644
--- a/hw/isa/piix3.c
+++ b/hw/isa/piix3.c
@@ -36,7 +36,7 @@
 
 static void piix3_set_irq_pic(PIIX3State *piix3, int pic_irq)
 {
-    qemu_set_irq(piix3->pic[pic_irq],
+    qemu_set_irq(piix3->isa_irqs_in[pic_irq],
                  !!(piix3->pic_levels &
                     (((1ULL << PIIX_NUM_PIRQS) - 1) <<
                      (pic_irq * PIIX_NUM_PIRQS))));
@@ -312,7 +312,8 @@ static void pci_piix3_init(Object *obj)
 {
     PIIX3State *d = PIIX3_PCI_DEVICE(obj);
 
-    qdev_init_gpio_out_named(DEVICE(obj), d->pic, "isa-irqs", ISA_NUM_IRQS);
+    qdev_init_gpio_out_named(DEVICE(obj), d->isa_irqs_in, "isa-irqs",
+                             ISA_NUM_IRQS);
 
     object_initialize_child(obj, "rtc", &d->rtc, TYPE_MC146818_RTC);
 }
-- 
MST



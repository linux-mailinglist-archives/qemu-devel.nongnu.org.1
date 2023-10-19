Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 424777D0175
	for <lists+qemu-devel@lfdr.de>; Thu, 19 Oct 2023 20:28:39 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qtXhb-0001DO-HP; Thu, 19 Oct 2023 14:24:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qtXgN-0007ek-4s
 for qemu-devel@nongnu.org; Thu, 19 Oct 2023 14:23:44 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qtXgL-0001Jl-0o
 for qemu-devel@nongnu.org; Thu, 19 Oct 2023 14:23:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697739820;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4arzXmLJ3FrdbgfYxEVNZzbkjzhvA/33H3ygks9bhhI=;
 b=fdpv4fa/pjRivw98wijMCnCou7FHE0uHE4Zu+Xp/ewb3tKB+29Z/+8BiRadKRxDV7ZUp84
 hxTZ6J3Haj95abuYEHeqpagkR3ZDtBM8YSPrcdzt0SC6B4nb/qldkO7NZxBbxoEfEHa0zS
 f+SLZP56JbfmzrSvCWDFt7SMnYEILbY=
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com
 [209.85.208.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-225-CQWK1w3NPS2HYrg7GRsG7Q-1; Thu, 19 Oct 2023 14:23:39 -0400
X-MC-Unique: CQWK1w3NPS2HYrg7GRsG7Q-1
Received: by mail-lj1-f198.google.com with SMTP id
 38308e7fff4ca-2c50bebd8dfso62320121fa.3
 for <qemu-devel@nongnu.org>; Thu, 19 Oct 2023 11:23:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697739817; x=1698344617;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=4arzXmLJ3FrdbgfYxEVNZzbkjzhvA/33H3ygks9bhhI=;
 b=E5KWOFWgUlhjBao+WwATolAf1f7kea12bYsDD67GEcuv9bPqL+vE9zsPVPQpnfDCUR
 GtOknazhuyiKAeCuVkKfclAcE4flzQbjm//NsiqBNRrlwFHt6/UxT8KTYddQbu8TnxMc
 36sTHglG+hWLs8HZNdQjPffEab5uQUtgLJrH5vU4Hrfaa7+3C1MhV2Qp6IxjDQViTbyV
 COUz/bh1znViM9ASRwcMUHmdjswxYwdUgaQuADvuevkEii9+T16/gGvU/yF8NXnP4MbB
 nqP0bxdFBEFg7N9UwXmnTbkQ/TonmNniVDglEvFPoXMGvqI6BIVyTMVkoWWyRvXx4S0M
 3oKg==
X-Gm-Message-State: AOJu0YyFEChfcUJnWy4+7LZa2G+F2V9vZQjdgRs0zYZtiPKrT73qSnzl
 3nyS5ym5hQJr2xiLVueEEP3IaIvIf8GSDxGKcI33D65tuZFMCDCGp05Noo6dOA/B095DuG4J38Z
 EEDRB8v2tC5QW5pAQwqA6Ym8MnWc6d81q8J1fO67lI6kMuZqK4a1Zt98n18pembHsr/53
X-Received: by 2002:a2e:b177:0:b0:2c5:1674:8d79 with SMTP id
 a23-20020a2eb177000000b002c516748d79mr2077355ljm.21.1697739816932; 
 Thu, 19 Oct 2023 11:23:36 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHx87C+xa9Y0HUhu+Zyrv1AFwyg5F6CeVjjHcZF8j9duBNEU3AtvoleuMZdcW6ediHxQNPngw==
X-Received: by 2002:a2e:b177:0:b0:2c5:1674:8d79 with SMTP id
 a23-20020a2eb177000000b002c516748d79mr2077338ljm.21.1697739816528; 
 Thu, 19 Oct 2023 11:23:36 -0700 (PDT)
Received: from redhat.com ([2a06:c701:73d2:bf00:e379:826:5137:6b23])
 by smtp.gmail.com with ESMTPSA id
 b14-20020a05600c4e0e00b0040607da271asm5041366wmq.31.2023.10.19.11.23.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Oct 2023 11:23:36 -0700 (PDT)
Date: Thu, 19 Oct 2023 14:23:34 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Bernhard Beschow <shentey@gmail.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL v2 54/78] hw/isa/piix4: Rename reset control operations to
 match PIIX3
Message-ID: <24f1eae318ffc5d971f5756e13f2a86232a29106.1697739629.git.mst@redhat.com>
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

Both implementations are the same and will be shared upon merging.

Signed-off-by: Bernhard Beschow <shentey@gmail.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Message-Id: <20231007123843.127151-18-shentey@gmail.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/isa/piix4.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/hw/isa/piix4.c b/hw/isa/piix4.c
index 9c8b6c98ab..eb456622c5 100644
--- a/hw/isa/piix4.c
+++ b/hw/isa/piix4.c
@@ -148,8 +148,8 @@ static void piix4_request_i8259_irq(void *opaque, int irq, int level)
     qemu_set_irq(s->cpu_intr, level);
 }
 
-static void piix4_rcr_write(void *opaque, hwaddr addr, uint64_t val,
-                            unsigned int len)
+static void rcr_write(void *opaque, hwaddr addr, uint64_t val,
+                      unsigned int len)
 {
     PIIX4State *s = opaque;
 
@@ -161,16 +161,16 @@ static void piix4_rcr_write(void *opaque, hwaddr addr, uint64_t val,
     s->rcr = val & 2; /* keep System Reset type only */
 }
 
-static uint64_t piix4_rcr_read(void *opaque, hwaddr addr, unsigned int len)
+static uint64_t rcr_read(void *opaque, hwaddr addr, unsigned int len)
 {
     PIIX4State *s = opaque;
 
     return s->rcr;
 }
 
-static const MemoryRegionOps piix4_rcr_ops = {
-    .read = piix4_rcr_read,
-    .write = piix4_rcr_write,
+static const MemoryRegionOps rcr_ops = {
+    .read = rcr_read,
+    .write = rcr_write,
     .endianness = DEVICE_LITTLE_ENDIAN,
     .impl = {
         .min_access_size = 1,
@@ -194,7 +194,7 @@ static void piix4_realize(PCIDevice *dev, Error **errp)
     qdev_init_gpio_out_named(DEVICE(dev), &s->cpu_intr,
                              "intr", 1);
 
-    memory_region_init_io(&s->rcr_mem, OBJECT(dev), &piix4_rcr_ops, s,
+    memory_region_init_io(&s->rcr_mem, OBJECT(dev), &rcr_ops, s,
                           "reset-control", 1);
     memory_region_add_subregion_overlap(pci_address_space_io(dev),
                                         PIIX_RCR_IOPORT, &s->rcr_mem, 1);
-- 
MST



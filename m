Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 66F197D223F
	for <lists+qemu-devel@lfdr.de>; Sun, 22 Oct 2023 11:28:51 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1quUhm-0005Gf-KH; Sun, 22 Oct 2023 05:25:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1quUhg-0005Cu-Ro
 for qemu-devel@nongnu.org; Sun, 22 Oct 2023 05:25:01 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1quUhf-0000d2-3q
 for qemu-devel@nongnu.org; Sun, 22 Oct 2023 05:25:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697966698;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4arzXmLJ3FrdbgfYxEVNZzbkjzhvA/33H3ygks9bhhI=;
 b=baldmX+XOkOeWsyLHys0BWY56Yxd36D5JLSFfwOPDUP2+Br9ZWzt9R42g5qxfAHnQ3tGN2
 rSxdntDtqxPiUOfOb9hXmHImjFeAvo2tJ0sVZjWZqRaDqeAlWFo2L5xLt7NAEGfe5LexOy
 9Eqcei62VBKG+Tw9NfPJZK5wJdVdPao=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-662-63pacfdVOq6dxTfEHEarRA-1; Sun, 22 Oct 2023 05:24:41 -0400
X-MC-Unique: 63pacfdVOq6dxTfEHEarRA-1
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-32da47641b5so1033910f8f.0
 for <qemu-devel@nongnu.org>; Sun, 22 Oct 2023 02:24:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697966679; x=1698571479;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=4arzXmLJ3FrdbgfYxEVNZzbkjzhvA/33H3ygks9bhhI=;
 b=cueA7XO8J1Ln9aFulGjkmqvwsFEDXlOqoz5EUebthM0OD6lFzTDNNMFmCxe4PdTWiW
 P3sru1XUEtlIcI3ijnIt7C2X8B3GTZqW68U5Wsj+6OJwyBWYc6EVkNfYRSzAzUcfkOTJ
 j1m+sdA2tFyuRGD5lSO9D9Ot0uUnOV42xx5q6PrYO1DZEmG0BOQrYMNxoozfRf+41w+2
 ALky4P77MGAXJx9c32KxpRfspHp5Z4+zhPcL/f1iEOtyJqmVMOrR700aJbmdLE5hPZNY
 j/71XgVD5AQoDch4dDci4mED1E3aq6F5E4KybAiaHgr738R91Z8c3VwgtNAIveFuZovt
 nKFw==
X-Gm-Message-State: AOJu0Ywmc6QhDehcRaNdCdm4QHKPSV03hd+z26jXjepGJfXpPO9pnAnh
 y/VuRNRvsremIncPMRQHsTR/e/yG2lxUq6anDHcVdO+JIGOJLAP6NXZ1csvRjXbsNI/k5XiDMev
 aI2ZRlS9yt8Vpsex3NJfTKJAPbhStvFHp314Vnaau8z5wAeyXVyG+SRTJFEegiYCx0NO1
X-Received: by 2002:adf:f390:0:b0:32d:9cd3:6aa3 with SMTP id
 m16-20020adff390000000b0032d9cd36aa3mr4491248wro.7.1697966679450; 
 Sun, 22 Oct 2023 02:24:39 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGhHc7Xs1exNkWBcyZQdFaU9HRZ0ofTwmntSk7+IonAC/CzLiY/5n435N7hSzFyQ6DnE5jLKg==
X-Received: by 2002:adf:f390:0:b0:32d:9cd3:6aa3 with SMTP id
 m16-20020adff390000000b0032d9cd36aa3mr4491237wro.7.1697966679137; 
 Sun, 22 Oct 2023 02:24:39 -0700 (PDT)
Received: from redhat.com ([2.52.1.53]) by smtp.gmail.com with ESMTPSA id
 r6-20020a5d6946000000b0032da4c98ab2sm5276036wrw.35.2023.10.22.02.24.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 22 Oct 2023 02:24:38 -0700 (PDT)
Date: Sun, 22 Oct 2023 05:24:36 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Bernhard Beschow <shentey@gmail.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL v3 38/62] hw/isa/piix4: Rename reset control operations to
 match PIIX3
Message-ID: <80ec6f5b574e5368007d8076fd32316765bf4ffb.1697966402.git.mst@redhat.com>
References: <cover.1697966402.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover.1697966402.git.mst@redhat.com>
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



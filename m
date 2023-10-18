Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 713297CE273
	for <lists+qemu-devel@lfdr.de>; Wed, 18 Oct 2023 18:12:49 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qt8wg-0001Ad-H8; Wed, 18 Oct 2023 11:58:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qt8vn-0008Bg-1N
 for qemu-devel@nongnu.org; Wed, 18 Oct 2023 11:58:00 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qt8vl-0007MY-Dy
 for qemu-devel@nongnu.org; Wed, 18 Oct 2023 11:57:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697644676;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4arzXmLJ3FrdbgfYxEVNZzbkjzhvA/33H3ygks9bhhI=;
 b=LgJJCmY08w6WZN2s9sCb3GoAOqLiE/yVDU98E9uJYDvuBrw7S4qr2W3xMScYkdVOUkCnMt
 lTMg7IaIxlmexEfcZ5G0YDPn8SWgQedtt7D5ym6RVQKSR0fKpmLQw18d1pB5riLSyPN7kI
 WGyda8f1DUNOGd9bRFURJWkUM4PebhA=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-653-OVyBKdhPPYa1CyJRzxh23Q-1; Wed, 18 Oct 2023 11:57:55 -0400
X-MC-Unique: OVyBKdhPPYa1CyJRzxh23Q-1
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-31fd48da316so4272532f8f.3
 for <qemu-devel@nongnu.org>; Wed, 18 Oct 2023 08:57:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697644673; x=1698249473;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=4arzXmLJ3FrdbgfYxEVNZzbkjzhvA/33H3ygks9bhhI=;
 b=m4ukw6gZ2gq3dODsS1zuWUofpPJ/b311MsDIBroBVa7jplNQ4OacZ7BZGZvfZ06x0z
 VJuU0j+JrNY8+RN7YcKzn7LBcpdisaaa2Rp8JQYg5ROHFe8yss3SV7/zj9MOuyhu4YRa
 y6BQcmqqq6qhCQHtA71O7Cjh6bFaBzHkAEBFNd9Vz45mLbLmVPZT7TvOPsu3LCENTdTd
 fxLpbFk/HO3sXFPndQa0C05MBWBnCe5SQP/6R3WAJJNnDdWxIlIH3/3foMUaLILPfTUM
 abZ/NObxHqduMYqesGmLJllKXaAqa2a5yBaB1MwGg85VaHLXo9LmpobtUqRaI83lBUlk
 IsqA==
X-Gm-Message-State: AOJu0YwkuOS1hL0Futl4pLfWnBYvIoeX7X0je4WYOnF0ZN3R1d2cGwFi
 6hmEFWoL7ms+p4BTX40sRFCM8msFrbJAf8QfpOvDquVq3mbtVLUbBYmqvbd2WIKG6q/ckI+P5Qz
 xLecdj0S5ix+LPHYaoUdUry1iBGbmg2aEUWi7oByv00wCFMaz4UyFgwEsAwaJLNbGSz6gyDo=
X-Received: by 2002:adf:e7cf:0:b0:32d:a40f:d920 with SMTP id
 e15-20020adfe7cf000000b0032da40fd920mr4162251wrn.20.1697644673770; 
 Wed, 18 Oct 2023 08:57:53 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEYYamnCP+azF53U+LLuofqXh1iLGt7Yxtrfn1yxXllFWNBCLTGg5O3EPiX3RRs5w+qQW1sSA==
X-Received: by 2002:adf:e7cf:0:b0:32d:a40f:d920 with SMTP id
 e15-20020adfe7cf000000b0032da40fd920mr4162242wrn.20.1697644673441; 
 Wed, 18 Oct 2023 08:57:53 -0700 (PDT)
Received: from redhat.com ([2a02:14f:1f2:2037:f34:d61b:7da0:a7be])
 by smtp.gmail.com with ESMTPSA id
 j17-20020a5d5651000000b0032d8f075810sm2395935wrw.10.2023.10.18.08.57.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Oct 2023 08:57:53 -0700 (PDT)
Date: Wed, 18 Oct 2023 11:57:50 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Bernhard Beschow <shentey@gmail.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 59/83] hw/isa/piix4: Rename reset control operations to match
 PIIX3
Message-ID: <ec32e56ddf74c6ae87b5cce8f7d7ab8498437c66.1697644299.git.mst@redhat.com>
References: <cover.1697644299.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
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



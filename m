Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 126B57CDEA8
	for <lists+qemu-devel@lfdr.de>; Wed, 18 Oct 2023 16:13:35 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qt7IR-0000cF-1b; Wed, 18 Oct 2023 10:13:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qt7IO-0000Y2-7a
 for qemu-devel@nongnu.org; Wed, 18 Oct 2023 10:13:12 -0400
Received: from mail-ej1-x633.google.com ([2a00:1450:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qt7IL-0004u9-Ow
 for qemu-devel@nongnu.org; Wed, 18 Oct 2023 10:13:11 -0400
Received: by mail-ej1-x633.google.com with SMTP id
 a640c23a62f3a-9adb9fa7200so1435695366b.0
 for <qemu-devel@nongnu.org>; Wed, 18 Oct 2023 07:13:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697638387; x=1698243187; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5QjYWheBMzRDx+1pua16/AosP+NmrpkNMedodm6UtRk=;
 b=di3V6BbdVruqxTchq4NR9tUEEqcWl6eQgprs6b5/8dCF5QTUt5LNOOPtb7acxhVDQ7
 6O3Jw/laLyBrjvX00bos53GPOvbOop/aigO+rvkrZu8NJow1uc1TOUAzoxntrh5/tpVS
 At41nmiHIVbjtOv2bbSUw7IHcAVXjGXiT0w5MrN8lMwKR/FZl8bjHGH010KntQBAfFpg
 ZeEzxojJcZd8h/8bZik19prC9Yk4s5aOxvYog2JkcQzwvwmtQaLnNQK/etUf/3s5OoMy
 U2pfS0J+Y4LNcQzi611GhoFqWezKJMnAZdGWpk8VbTyuIz7iY9O5kEC/pVO0HGB5Y417
 XAVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697638387; x=1698243187;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=5QjYWheBMzRDx+1pua16/AosP+NmrpkNMedodm6UtRk=;
 b=Rt7gD3QopXERVoDGJF7k2bwTtEPiwYioEuRcfZI5uMSqiLsUeastuQjW9s3Jvn2iIg
 3M3NDeShLr9bhve5ggGpB9OYkl1MKZOH4z8mSbJRNG5ZMoImZ4X+xYvy8WYQvQ64JTpC
 xGyEhEiZN76mgRe2JDSE5gRP5oHHNP+FW0Czasol0h/nksJm8ieDZwLBOZO+W/hYhHSV
 C4Aut/Q4nyScXpF+VrpxczEyf1gQXopoBlYszQX409gAb1hH0KURILrpyID+HPyWSZPA
 uaF+APAkvYx09emtNqwbOcD49O/YOmtHtD/XE4kO6qa7ODlpoUh5AFxuSCqS4k4AnQDQ
 hQOw==
X-Gm-Message-State: AOJu0YzWTsmZlFBclXzQisc/rbv96Qh/xEWLj1IxpCNzzoNZ8+VVA/dJ
 tIW3NNGd3edDfyQ3IPzvCN9uqByIACw0gonjIJw=
X-Google-Smtp-Source: AGHT+IGjlTWHpCOMT0QFUjuIGmJMfOY/C6d5YoCal4txOEFUGOMZeulJD8ipLal8AWH4HNNr9d+Npg==
X-Received: by 2002:a17:907:86ac:b0:9ad:8641:e91b with SMTP id
 qa44-20020a17090786ac00b009ad8641e91bmr4831802ejc.11.1697638387711; 
 Wed, 18 Oct 2023 07:13:07 -0700 (PDT)
Received: from m1x-phil.lan (gyl59-h01-176-171-218-149.dsl.sta.abo.bbox.fr.
 [176.171.218.149]) by smtp.gmail.com with ESMTPSA id
 fi10-20020a170906da0a00b0098669cc16b2sm1753999ejb.83.2023.10.18.07.13.04
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 18 Oct 2023 07:13:07 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Eric Farman <farman@linux.ibm.com>, Peter Xu <peterx@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Halil Pasic <pasic@linux.ibm.com>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Strahinja Jankovic <strahinja.p.jankovic@gmail.com>,
 Eduardo Habkost <eduardo@habkost.net>, Sergio Lopez <slp@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Jason Wang <jasowang@redhat.com>, qemu-arm@nongnu.org,
 qemu-s390x@nongnu.org, Ilya Leoshkevich <iii@linux.ibm.com>,
 Song Gao <gaosong@loongson.cn>, Huacai Chen <chenhuacai@kernel.org>,
 Beniamino Galvani <b.galvani@gmail.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Thomas Huth <thuth@redhat.com>, David Hildenbrand <david@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH 09/12] hw/s390x/css-bridge: Realize sysbus device before
 accessing it
Date: Wed, 18 Oct 2023 16:11:47 +0200
Message-ID: <20231018141151.87466-10-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231018141151.87466-1-philmd@linaro.org>
References: <20231018141151.87466-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::633;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x633.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

sysbus_mmio_map() should not be called on unrealized device.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/s390x/css-bridge.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/hw/s390x/css-bridge.c b/hw/s390x/css-bridge.c
index 4017081d49..15d26efc95 100644
--- a/hw/s390x/css-bridge.c
+++ b/hw/s390x/css-bridge.c
@@ -95,7 +95,6 @@ static const TypeInfo virtual_css_bus_info = {
 
 VirtualCssBus *virtual_css_bus_init(void)
 {
-    VirtualCssBus *cbus;
     BusState *bus;
     DeviceState *dev;
 
@@ -103,19 +102,19 @@ VirtualCssBus *virtual_css_bus_init(void)
     dev = qdev_new(TYPE_VIRTUAL_CSS_BRIDGE);
     object_property_add_child(qdev_get_machine(), TYPE_VIRTUAL_CSS_BRIDGE,
                               OBJECT(dev));
-    sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), &error_fatal);
 
     /* Create bus on bridge device */
     bus = qbus_new(TYPE_VIRTUAL_CSS_BUS, dev, "virtual-css");
-    cbus = VIRTUAL_CSS_BUS(bus);
 
     /* Enable hotplugging */
     qbus_set_hotplug_handler(bus, OBJECT(dev));
 
+    sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), &error_fatal);
+
     css_register_io_adapters(CSS_IO_ADAPTER_VIRTIO, true, false,
                              0, &error_abort);
 
-    return cbus;
+    return VIRTUAL_CSS_BUS(bus);
  }
 
 /***************** Virtual-css Bus Bridge Device ********************/
-- 
2.41.0



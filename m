Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 09E13AAC874
	for <lists+qemu-devel@lfdr.de>; Tue,  6 May 2025 16:45:47 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uCJXY-0003Yz-FK; Tue, 06 May 2025 10:45:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uCJTT-00006S-NQ
 for qemu-devel@nongnu.org; Tue, 06 May 2025 10:41:17 -0400
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uCJTP-0001u1-H2
 for qemu-devel@nongnu.org; Tue, 06 May 2025 10:40:47 -0400
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-441d1ed82faso5295715e9.0
 for <qemu-devel@nongnu.org>; Tue, 06 May 2025 07:40:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746542441; x=1747147241; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kg1vT0Z/kKcz1VyaWx5HUe6zicIy/oQzxPnBZl9mXrw=;
 b=sxDPRMaoadOTKAaJg3X4/AMIpL9xosCQ1kuiPnoqdqbri3yOBJg2QWj0juE/DP93DT
 x9LRnt6C3g9N+FdKrwV8+NwnuqGbFaVPwB65BiCqVjLUwuIlpqFN6tiYMrZPdqL4aKuX
 bShYlfW7Uz7KxGrHXA/ptDcGUrr9SCe0wFf5Vx6G0gRPZBIVLPV8ZQ+nJZ5K5603Lixi
 Zkez9X9IchRyZWGFjmHSDs4cKqRGrtRxXdmyHoeZhoal9w/pi8yWEl+3stKI/F8o/NtJ
 CaIMa/eXhfi6DnC2bbXnn6e/kAfcmccfq43SWEi/o/zeNNCZbJWmTq9HKX/9NA2FOFoW
 DTMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746542441; x=1747147241;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=kg1vT0Z/kKcz1VyaWx5HUe6zicIy/oQzxPnBZl9mXrw=;
 b=LFcsKeCdn7e5BsNhM+bWMCfvzE0W5frK2kqlg7W+i9LTH+2wK29djrF3ndT2LTv71Q
 quMXslDhbxQXlX+2hmGrYdAIqHMAFHXQNd4BumvAQCxQl5b7I1kCLH2snKiJwfca6UTa
 IFW0+W5MNQT9fr8I99KbSe8+5xjvTEcjnGdbNathKwqI856m/aTcB8+VkPG5TNCctbBO
 qP7cXp2uylK1oFpQ6uXOql7Cp8xvxAvmnSZTCVbsWA+r8RAkQdkS3jDO2Dvovdsq9UTP
 CNdiu4bRZ8bh4BpQtM9Sk/DoCKP5tElRmCVJcfGUOQldHK98J48P8nk3V5DiX1P5ZPYg
 pzkw==
X-Gm-Message-State: AOJu0Yyi/orU/ofBzZjFj7DFVgY2XLutlep6oF1i+YOdAfMtrp5NWLHP
 tKS2rSCAdE3Vx5qa0SRr45WNHM1OjNewvuEkYxkFKVAIqELpsmNZutJYo2uBBqp3m6DpojQKrhF
 Z
X-Gm-Gg: ASbGncsGMpT7NHvoE/rhsPxGF2UN2RM1rEIUabkCj5DKbJDHMZ/4uqo48Ib7V6AK3zY
 kETIJ5SpwA0LMBt60daA8BEV5vlor3XK2slbAmRSjERddrW9z+Si3H3hrgiE9q+kQMzAURfSjqb
 t+JfHbrl2nrbhpj/mjAGCW4Kzf5mpaYOmOWYG8oNXZLsmH+eFz1wCHFjHldBb+51DwyvEVEAqaJ
 yP4S6wmnwjsLcBx3spAIibOoK5aWFxXQzjS9dJgqdvshxpNX5DKyhBca4dcZ7iq7HiLHPdPULzI
 +Y92OCYJ/cdRzr21+eHbfxU1f0kM/CcPuJIT0/8CzWmkHPCT8FJN4bAOwOPFio0Wnl2DB8js396
 XXHK82djVNSWV/wGAoucG
X-Google-Smtp-Source: AGHT+IHQAZ49KYPxLoAHLWKw/VKWTWZ+8epupQywWW5mERzm9ktQJYWdc7U9XBedGXKsW+AvT47+jA==
X-Received: by 2002:a05:600c:34c7:b0:43c:eeee:b70a with SMTP id
 5b1f17b1804b1-441c491fcb6mr89439125e9.22.1746542441449; 
 Tue, 06 May 2025 07:40:41 -0700 (PDT)
Received: from localhost.localdomain (91-163-26-170.subs.proxad.net.
 [91.163.26.170]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-441b2b20a70sm220279655e9.31.2025.05.06.07.40.40
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 06 May 2025 07:40:41 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>, Fam Zheng <fam@euphon.net>,
 Hanna Reitz <hreitz@redhat.com>, Zhao Liu <zhao1.liu@intel.com>,
 qemu-block@nongnu.org, Dmitry Fleytman <dmitry.fleytman@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Laurent Vivier <lvivier@redhat.com>, John Snow <jsnow@redhat.com>,
 Jason Wang <jasowang@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Fabiano Rosas <farosas@suse.de>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH v3 19/19] hw/net/vmxnet3: Merge DeviceRealize in InstanceInit
Date: Tue,  6 May 2025 16:39:05 +0200
Message-ID: <20250506143905.4961-20-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250506143905.4961-1-philmd@linaro.org>
References: <20250506143905.4961-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x330.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Simplify merging vmxnet3_realize() within vmxnet3_instance_init(),
removing the need for device_class_set_parent_realize().

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
---
 hw/net/vmxnet3.c | 15 +--------------
 1 file changed, 1 insertion(+), 14 deletions(-)

diff --git a/hw/net/vmxnet3.c b/hw/net/vmxnet3.c
index d080fe9b38a..7c0ca56b7c0 100644
--- a/hw/net/vmxnet3.c
+++ b/hw/net/vmxnet3.c
@@ -2238,6 +2238,7 @@ static void vmxnet3_instance_init(Object *obj)
     device_add_bootindex_property(obj, &s->conf.bootindex,
                                   "bootindex", "/ethernet-phy@0",
                                   DEVICE(obj));
+    PCI_DEVICE(obj)->cap_present |= QEMU_PCI_CAP_EXPRESS;
 }
 
 static void vmxnet3_pci_uninit(PCIDevice *pci_dev)
@@ -2463,22 +2464,10 @@ static const Property vmxnet3_properties[] = {
     DEFINE_NIC_PROPERTIES(VMXNET3State, conf),
 };
 
-static void vmxnet3_realize(DeviceState *qdev, Error **errp)
-{
-    VMXNET3Class *vc = VMXNET3_DEVICE_GET_CLASS(qdev);
-    PCIDevice *pci_dev = PCI_DEVICE(qdev);
-    VMXNET3State *s = VMXNET3(qdev);
-
-    pci_dev->cap_present |= QEMU_PCI_CAP_EXPRESS;
-
-    vc->parent_dc_realize(qdev, errp);
-}
-
 static void vmxnet3_class_init(ObjectClass *class, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(class);
     PCIDeviceClass *c = PCI_DEVICE_CLASS(class);
-    VMXNET3Class *vc = VMXNET3_DEVICE_CLASS(class);
 
     c->realize = vmxnet3_pci_realize;
     c->exit = vmxnet3_pci_uninit;
@@ -2489,8 +2478,6 @@ static void vmxnet3_class_init(ObjectClass *class, const void *data)
     c->class_id = PCI_CLASS_NETWORK_ETHERNET;
     c->subsystem_vendor_id = PCI_VENDOR_ID_VMWARE;
     c->subsystem_id = PCI_DEVICE_ID_VMWARE_VMXNET3;
-    device_class_set_parent_realize(dc, vmxnet3_realize,
-                                    &vc->parent_dc_realize);
     dc->desc = "VMWare Paravirtualized Ethernet v3";
     device_class_set_legacy_reset(dc, vmxnet3_qdev_reset);
     dc->vmsd = &vmstate_vmxnet3;
-- 
2.47.1



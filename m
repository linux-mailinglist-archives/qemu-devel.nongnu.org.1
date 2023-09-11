Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9197A79A72D
	for <lists+qemu-devel@lfdr.de>; Mon, 11 Sep 2023 12:18:01 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qfdys-0001sY-Gz; Mon, 11 Sep 2023 06:17:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcin.juszkiewicz@linaro.org>)
 id 1qfdyq-0001sO-Hs
 for qemu-devel@nongnu.org; Mon, 11 Sep 2023 06:17:20 -0400
Received: from mail-ed1-x52a.google.com ([2a00:1450:4864:20::52a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcin.juszkiewicz@linaro.org>)
 id 1qfdyn-0001vO-S3
 for qemu-devel@nongnu.org; Mon, 11 Sep 2023 06:17:20 -0400
Received: by mail-ed1-x52a.google.com with SMTP id
 4fb4d7f45d1cf-52c88a03f99so5145946a12.2
 for <qemu-devel@nongnu.org>; Mon, 11 Sep 2023 03:17:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1694427436; x=1695032236; darn=nongnu.org;
 h=content-transfer-encoding:subject:organization:from:cc:to
 :content-language:user-agent:mime-version:date:message-id:from:to:cc
 :subject:date:message-id:reply-to;
 bh=h5jyXIL4MylxL7KTKKCeGpCc0CK6eglna7KZ9e7/cIc=;
 b=ll5J3St02RYICNkQjedie/tRB397Tf3YXCkzdtSaKvtOzF6ejTfSL5LJfQajqr9VSf
 SJbJqoXHmvR4aoBH52qYv1oVSq3vGRPdIrf+TPH0zpuyiWScbe9avdenfMnXx7MllH39
 PJ7uEqBaF0GbCOYHgrl4/B9+MQy/R1fd+5AEjUwJcagrAwSoij1UdoStbDsa21GkzC2t
 LmtcO7Css8YRMv8HpjlQomJIt7/AZ5QFSKlDL0qg7t5VRod7uxvpNaPGE1Ab5tLGC0su
 4wfS3OYNLzxli+WNkq8Mas+KplhqMv5lhWdRjN/uj4/03LUYHe3KRFqoSLUQAiJnKFKu
 YTRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694427436; x=1695032236;
 h=content-transfer-encoding:subject:organization:from:cc:to
 :content-language:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=h5jyXIL4MylxL7KTKKCeGpCc0CK6eglna7KZ9e7/cIc=;
 b=PHfUFwaUPT9B0ZPzqt+/wuiD32h2qiCz76xPNwvqF5ovmJ0ggG49GOVxy/GUg/xj+6
 jGT4SpkRqQVPFpMs/fvpzJM6kb9WCtotTGcVukHrFoKfQZAWsZjpWghQbMzHl57K8VsS
 PxF5jO8pbB6RxbjQnsqCCWlBlwBPubGUL4BF8yRB6HoeQrW2BELftTI5fCmsLIq6RoT5
 YkN8Dci793LzdT3arI0EFH19Z0iRsERb8gqdpC67nTZiPkOlYMFsz8z8SoVwHemfezmo
 FOXNhVGaetENl25YD/srf77LGMIwqHZVHKJxUOkpHwmmUK2LIR9RGWEWfohyK/f9O61z
 sSsA==
X-Gm-Message-State: AOJu0YwhkqastKiVxj+VtAzaXX7vkSSUKawOgIDJpeGNu7olSptgFSyg
 FBFuVgfzucCWPMpnqsKGlqixuJ4L/J7mT7arC8DNcg==
X-Google-Smtp-Source: AGHT+IH5oOMHEloCGvgyg7MGjJE5xABIh1O8v7NeY5pYQGATUYZkMsAoc8QBNMKPiXbfMctqskc6dw==
X-Received: by 2002:a50:ee0b:0:b0:523:18db:e3ab with SMTP id
 g11-20020a50ee0b000000b0052318dbe3abmr6897828eds.39.1694427435472; 
 Mon, 11 Sep 2023 03:17:15 -0700 (PDT)
Received: from [192.168.200.206] (83.21.94.247.ipv4.supernova.orange.pl.
 [83.21.94.247]) by smtp.gmail.com with ESMTPSA id
 m14-20020aa7d34e000000b0052a1a623267sm4396109edr.62.2023.09.11.03.17.14
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 11 Sep 2023 03:17:14 -0700 (PDT)
Message-ID: <6a0b9345-a447-4cf9-ba9a-88c420e7ab79@linaro.org>
Date: Mon, 11 Sep 2023 12:17:13 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: pl-PL, en-GB, en-HK
To: qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
From: Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>
Organization: Linaro
Subject: Should pcie-pci-bridge use 32-bit non-prefetchable memory?
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::52a;
 envelope-from=marcin.juszkiewicz@linaro.org; helo=mail-ed1-x52a.google.com
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

I am working on aarch64/sbsa-ref machine so people can have virtual
machine to test their OS against something reminding standards compliant
system.

One of tools I use is BSA ACS (Base System Architecture - Architecture
Compliance Suite) [1] written by Arm. It runs set of tests to check does
system conforms to BSA specification.

1. https://github.com/ARM-software/bsa-acs

To run tests I use my "boot-sbsa-ref.sh" script [2] which allows me to
run exactly same setup each time.

2. https://github.com/hrw/sbsa-ref-status/blob/main/boot-sbsa-ref.sh

Since we have ITS support in whole stack (qemu, tf-a, edk2) I use
overcomplicated PCIe setup:

-device igb
-device pcie-root-port,id=root_port_for_switch1,chassis=0,slot=0
  -device x3130-upstream,id=upstream_port1,bus=root_port_for_switch1
   -device xio3130-downstream,id=downstream_port1,bus=upstream_port1,chassis=1,slot=0
    -device ac97,bus=downstream_port1
-device pcie-root-port,id=root_port_for_nvme1,chassis=2,slot=0
  -device nvme,serial=deadbeef,bus=root_port_for_nvme1
-device pcie-root-port,id=root_port_for_igb,chassis=3,slot=0
  -device igb,bus=root_port_for_igb
-device pcie-root-port,id=root_port_for_xhci,chassis=4,slot=0
  -device qemu-xhci,bus=root_port_for_xhci
-device pcie-root-port,id=root_port_for_rng,chassis=5,slot=0
  -device virtio-rng-pci,bus=root_port_for_rng
-device pcie-root-port,id=root_port_for_pci,chassis=6,slot=0
  -device pcie-pci-bridge,id=pci,bus=root_port_for_pci
   -device es1370,bus=pci,addr=9
   -device e1000,bus=pci,addr=10
-device pxb-pcie,id=pxb1,bus_nr=1
  -device pcie-root-port,id=root_port_for_ahci,bus=pxb1,chassis=10,slot=0
   -device ahci,bus=root_port_for_ahci

BSA ACS test 841 checks do Type-1 PCIe devices have 32-bit
non-prefetchable memory. And fails on pcie-pci-bridge:

Operating System View:
  841 : NP type-1 PCIe supp 32-bit only                START

        BDF - 0x400
        BDF - 0x500
        BDF - 0x600
        BDF - 0x700
        BDF - 0x800
        BDF - 0x900
        BDF - 0x10000
        BDF - 0x30000
        Skipping Non Type-1 headers
        BDF - 0x40000
        Skipping Non Type-1 headers
        BDF - 0x50000
        Skipping Non Type-1 headers
        BDF - 0x60000
        Skipping Non Type-1 headers
        BDF - 0x70000
        NP type-1 pcie is not 32-bit mem type
        Failed on PE -    0
        PCI_MM_04
        Checkpoint --  1                           : Result:  FAIL

0x70000 is pcie-pci-bridge card.

I opened issue for BSA ACS [3] and asked where the problem is.

3. https://github.com/ARM-software/bsa-acs/issues/197

Got quote from BSA (Arm Base System Architecture) [4]
chapter E.2 PCI Express Memory Space:

> When PCI Express memory space is mapped as normal memory, the system
> must support unaligned accesses to that region.
> PCI Type 1 headers, used in PCI-to-PCI bridges, and therefore in root
> ports and switches, have to be programmed with the address space
> resources claimed by the given bridge.
> For non-prefetchable (NP) memory, Type 1 headers only support 32-bit
> addresses. This implies that endpoints on the other end of a
> PCI-to-PCI bridge only support 32-bit NP BARs

4. https://developer.arm.com/documentation/den0094/latest/


I looked at code and tried to switch pcie-pci-bridge to 32-bit:

------------------------------------------------------------------------
diff --git a/hw/pci-bridge/pcie_pci_bridge.c b/hw/pci-bridge/pcie_pci_bridge.c
index 2301b2ca0b..45199d2fa0 100644
--- a/hw/pci-bridge/pcie_pci_bridge.c
+++ b/hw/pci-bridge/pcie_pci_bridge.c
@@ -82,7 +82,7 @@ static void pcie_pci_bridge_realize(PCIDevice *d, Error **errp)
          }
      }
      pci_register_bar(d, 0, PCI_BASE_ADDRESS_SPACE_MEMORY |
-                     PCI_BASE_ADDRESS_MEM_TYPE_64, &pcie_br->shpc_bar);
+                     PCI_BASE_ADDRESS_MEM_TYPE_32, &pcie_br->shpc_bar);
      return;

  msi_error:

------------------------------------------------------------------------

With it, test 841 passes.

The difference in "lspci -vvvv" output suggests that this region address
was 32-bit in both cases:

-       Region 0: Memory at 81c00000 (64-bit, non-prefetchable) [size=256]
+       Region 0: Memory at 81c00000 (32-bit, non-prefetchable) [size=256]

Any ideas how to continue from here?


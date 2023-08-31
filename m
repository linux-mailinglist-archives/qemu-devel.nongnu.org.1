Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7144578E9E7
	for <lists+qemu-devel@lfdr.de>; Thu, 31 Aug 2023 12:06:37 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qbeZ1-0001c0-48; Thu, 31 Aug 2023 06:06:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcin.juszkiewicz@linaro.org>)
 id 1qbeYy-0001bH-Sf
 for qemu-devel@nongnu.org; Thu, 31 Aug 2023 06:06:08 -0400
Received: from mail-lj1-x235.google.com ([2a00:1450:4864:20::235])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcin.juszkiewicz@linaro.org>)
 id 1qbeYt-0003my-V5
 for qemu-devel@nongnu.org; Thu, 31 Aug 2023 06:06:08 -0400
Received: by mail-lj1-x235.google.com with SMTP id
 38308e7fff4ca-2bcc331f942so7152751fa.0
 for <qemu-devel@nongnu.org>; Thu, 31 Aug 2023 03:06:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1693476362; x=1694081162; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:organization:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=K9pC53nVetDko8SCaq8cdQDhTLcU7iHKY/1Vp9uPtbk=;
 b=CVDIkTLrHxrMEXBdrinKvpemXpP7jU4xZLjt5RJ6xJ5RMO4YTk0PbceLymbTtJea/M
 rWBMq00c06SdEXBbtvnPSIvEB7vtLEp+T32KiUbTqOIsxJafu3ohwu3b4QEXJazNVuBC
 0a3aJTC1CFOiAHdsk12gtCWf4D1ntL+2quD5I8YuNY8rPflmclxsag8Hhagwf9sseBYj
 5wAS3HdcWiIzklnzOO1I5cileuisu2s7DQo8LyJKkYlu83LW+yWGgXO1xmA/7M53AQiS
 2Pe9L0nViJlLuhqdV72BfC0+eXqfPK4zRGpHHXWdpjLdpHxioSJXGpMnxU7bsyROAE1M
 O6AA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693476362; x=1694081162;
 h=content-transfer-encoding:in-reply-to:organization:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=K9pC53nVetDko8SCaq8cdQDhTLcU7iHKY/1Vp9uPtbk=;
 b=hHeKf2Uz7fQ1Z3sgpwXT1MyRR5GO5qkmheFvFK87c6ZFBqTzYR9HLTb7mxzRNqHkrH
 2r0C1RHFHCyykYhonVrFxQo2x4vbmt4aED1Y0EF2CE4RpauVPt8mNrDyCAAJzXi4RLCe
 61PiUlCSnrVt/njM3j2eA6Brze3FA9r82AIAUlf+PkUbG0PyDDam3L6nBRtEXxsAItL2
 8r+si7yTtpKFjuAh7BF1OUJOYIsd7AVAR/Kv4rjDxAZwEvppm0NNPG0C97ddE4mVepIg
 GeqXgw09AmEFZpWUmUTZaUgMUw+LjKkj9fqttr6SPj1k121anhZBvS4tGgrQUhdzG6DG
 zdmQ==
X-Gm-Message-State: AOJu0YyEiJ13u48Obii3Kz3yQBbMqP2gXYJ7BU+OFr1ouZIz9wBDFSqN
 y3NyU4/Mbf2Uiv1zwtYToynngQ==
X-Google-Smtp-Source: AGHT+IGrFy4EaKsxfjTcmsV9zvv3YHW54NsqNrd9+8kQiNpPzLU31vQ1SETBxerzgum0M6uv+avM/w==
X-Received: by 2002:a05:651c:2c3:b0:2bc:d3b1:d6c1 with SMTP id
 f3-20020a05651c02c300b002bcd3b1d6c1mr712493ljo.9.1693476361686; 
 Thu, 31 Aug 2023 03:06:01 -0700 (PDT)
Received: from [192.168.200.206] (83.11.188.80.ipv4.supernova.orange.pl.
 [83.11.188.80]) by smtp.gmail.com with ESMTPSA id
 x2-20020a2e9dc2000000b002bce5e379a3sm239825ljj.7.2023.08.31.03.06.00
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 31 Aug 2023 03:06:01 -0700 (PDT)
Message-ID: <9cebce70-59fc-e7bb-5973-3091680b72ea@linaro.org>
Date: Thu, 31 Aug 2023 12:05:59 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] pci: SLT must be RO
To: "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org
Cc: Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>
References: <de9d05366a70172e1789d10591dbe59e39c3849c.1693432039.git.mst@redhat.com>
Content-Language: pl-PL, en-GB, en-HK
From: Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>
Organization: Linaro
In-Reply-To: <de9d05366a70172e1789d10591dbe59e39c3849c.1693432039.git.mst@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::235;
 envelope-from=marcin.juszkiewicz@linaro.org; helo=mail-lj1-x235.google.com
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

W dniu 30.08.2023 o 23:48, Michael S. Tsirkin pisze:
> current code sets PCI_SEC_LATENCY_TIMER to WO, but for
> pcie to pcie bridges it must be RO 0 according to
> pci express spec which says:
>      This register does not apply to PCI Express. It must be read-only
>      and hardwired to 00h. For PCI Express to PCI/PCI-X Bridges, refer to the
>      [PCIe-to-PCI-PCI-X-Bridge] for requirements for this register.
> 
> also, fix typo in comment where it's make writeable - this typo
> is likely what prevented us noticing we violate this requirement
> in the 1st place.
> 
> Reported-by: Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> ---

> Marcin, could you pls test this patch with virt-8.1 and latest?
> Thanks a lot!

Tested-by: Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>

sbsa-ref: PASS
virt:     PASS
virt-8.1: FAIL (as expected)
virt-8.0: FAIL (as expected)

./code/qemu/build/aarch64-softmmu/qemu-system-aarch64 \
  -machine virt \
  -m 4096  \
  -cpu neoverse-n1 \
  -smp 2 \
  -drive if=pflash,format=raw,file=QEMU_EFI.fd \
  -drive if=pflash,format=raw,file=QEMU_EFI-vars.fd \
-drive file=fat:rw:$PWD/disks/virtual/,format=raw \
-device pcie-root-port,id=root30,chassis=30,slot=0 \
-device igb,bus=root30 \
  -device qemu-xhci,id=usb \
  -device bochs-display \
  -device e1000e \
-nographic \
  -usb \
  -device usb-kbd \
  -device usb-tablet \
  -monitor telnet::45454,server,nowait \
  -serial stdio

> 
>   include/hw/pci/pci_bridge.h |  3 +++
>   hw/core/machine.c           |  5 ++++-
>   hw/pci/pci.c                |  2 +-
>   hw/pci/pci_bridge.c         | 14 ++++++++++++++
>   4 files changed, 22 insertions(+), 2 deletions(-)
> 
> diff --git a/include/hw/pci/pci_bridge.h b/include/hw/pci/pci_bridge.h
> index ea54a81a15..5cd452115a 100644
> --- a/include/hw/pci/pci_bridge.h
> +++ b/include/hw/pci/pci_bridge.h
> @@ -77,6 +77,9 @@ struct PCIBridge {
>   
>       pci_map_irq_fn map_irq;
>       const char *bus_name;
> +
> +    /* SLT is RO for PCIE to PCIE bridges, but old QEMU versions had it RW */
> +    bool pcie_writeable_slt_bug;
>   };
>   
>   #define PCI_BRIDGE_DEV_PROP_CHASSIS_NR "chassis_nr"
> diff --git a/hw/core/machine.c b/hw/core/machine.c
> index da699cf4e1..76743e3b31 100644
> --- a/hw/core/machine.c
> +++ b/hw/core/machine.c
> @@ -32,6 +32,7 @@
>   #include "qemu/error-report.h"
>   #include "sysemu/qtest.h"
>   #include "hw/pci/pci.h"
> +#include "hw/pci/pci_bridge.h"
>   #include "hw/mem/nvdimm.h"
>   #include "migration/global_state.h"
>   #include "migration/vmstate.h"
> @@ -39,7 +40,9 @@
>   #include "hw/virtio/virtio.h"
>   #include "hw/virtio/virtio-pci.h"
>   
> -GlobalProperty hw_compat_8_1[] = {};
> +GlobalProperty hw_compat_8_1[] = {
> +    { TYPE_PCI_BRIDGE, "x-pci-express-writeable-slt-bug", "true" },
> +};
>   const size_t hw_compat_8_1_len = G_N_ELEMENTS(hw_compat_8_1);
>   
>   GlobalProperty hw_compat_8_0[] = {
> diff --git a/hw/pci/pci.c b/hw/pci/pci.c
> index 881d774fb6..b0d21bf43a 100644
> --- a/hw/pci/pci.c
> +++ b/hw/pci/pci.c
> @@ -893,7 +893,7 @@ static void pci_init_w1cmask(PCIDevice *dev)
>   static void pci_init_mask_bridge(PCIDevice *d)
>   {
>       /* PCI_PRIMARY_BUS, PCI_SECONDARY_BUS, PCI_SUBORDINATE_BUS and
> -       PCI_SEC_LETENCY_TIMER */
> +       PCI_SEC_LATENCY_TIMER */
>       memset(d->wmask + PCI_PRIMARY_BUS, 0xff, 4);
>   
>       /* base and limit */
> diff --git a/hw/pci/pci_bridge.c b/hw/pci/pci_bridge.c
> index e7b9345615..6a4e38856d 100644
> --- a/hw/pci/pci_bridge.c
> +++ b/hw/pci/pci_bridge.c
> @@ -38,6 +38,7 @@
>   #include "qapi/error.h"
>   #include "hw/acpi/acpi_aml_interface.h"
>   #include "hw/acpi/pci.h"
> +#include "hw/qdev-properties.h"
>   
>   /* PCI bridge subsystem vendor ID helper functions */
>   #define PCI_SSVID_SIZEOF        8
> @@ -385,6 +386,11 @@ void pci_bridge_initfn(PCIDevice *dev, const char *typename)
>       pci_bridge_region_init(br);
>       QLIST_INIT(&sec_bus->child);
>       QLIST_INSERT_HEAD(&parent->child, sec_bus, sibling);
> +
> +    /* For express secondary buses, secondary latency timer is RO 0 */
> +    if (pci_bus_is_express(sec_bus) && !br->pcie_writeable_slt_bug) {
> +        dev->wmask[PCI_SEC_LATENCY_TIMER] = 0;
> +    }
>   }
>   
>   /* default qdev clean up function for PCI-to-PCI bridge */
> @@ -466,10 +472,18 @@ int pci_bridge_qemu_reserve_cap_init(PCIDevice *dev, int cap_offset,
>       return 0;
>   }
>   
> +static Property pci_bridge_properties[] = {
> +    DEFINE_PROP_BOOL("x-pci-express-writeable-slt-bug", PCIBridge,
> +                     pcie_writeable_slt_bug, false),
> +    DEFINE_PROP_END_OF_LIST(),
> +};
> +
>   static void pci_bridge_class_init(ObjectClass *klass, void *data)
>   {
>       AcpiDevAmlIfClass *adevc = ACPI_DEV_AML_IF_CLASS(klass);
> +    DeviceClass *k = DEVICE_CLASS(klass);
>   
> +    device_class_set_props(k, pci_bridge_properties);
>       adevc->build_dev_aml = build_pci_bridge_aml;
>   }
>   



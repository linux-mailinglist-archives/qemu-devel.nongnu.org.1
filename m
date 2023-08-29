Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CC6978D009
	for <lists+qemu-devel@lfdr.de>; Wed, 30 Aug 2023 01:12:11 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qb7ms-0000hR-Od; Tue, 29 Aug 2023 19:06:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcin.juszkiewicz@linaro.org>)
 id 1qb5N5-0005EL-Fg
 for qemu-devel@nongnu.org; Tue, 29 Aug 2023 16:31:31 -0400
Received: from mail-ej1-x632.google.com ([2a00:1450:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcin.juszkiewicz@linaro.org>)
 id 1qb5N2-0004zz-Uq
 for qemu-devel@nongnu.org; Tue, 29 Aug 2023 16:31:31 -0400
Received: by mail-ej1-x632.google.com with SMTP id
 a640c23a62f3a-99c3d3c3db9so623504266b.3
 for <qemu-devel@nongnu.org>; Tue, 29 Aug 2023 13:31:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1693341087; x=1693945887; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:organization:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=n7YAefGdmHBeUL/0o4FVoRATZWguYpoW0lVUtgm8wMU=;
 b=vo6K2RfS1lpIP0j7SgoQadieSnjD8xOjV/DiryIWrqQ3pyZx3IuvPoQHGtImdVnBOB
 t+eFNXXkGrZ0BqudKiqbWXzE/FZ0IUZshKJ5lc4KyWyZzEP3BuHR+eeM59pdmN/r/Zrk
 RXjSj+tTcfkHRNEfkjeowL579Ft8D3iJbopirOqtXhW1gUxC8DplDmcTE/Se9/RK8Alg
 iGBgO2HzX001LYr+BvEaee+W2bilSjMhCmSbMqOofuEq04VGreu1aIdI6uQ9lBRrIWQB
 fRxAeX9DT3wPw+1f4c+XTQOoPs/Kn4dM/o7ePbGbGJ313ZdBeLv9kuGsQenVkgzJgce3
 h41A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693341087; x=1693945887;
 h=content-transfer-encoding:in-reply-to:organization:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=n7YAefGdmHBeUL/0o4FVoRATZWguYpoW0lVUtgm8wMU=;
 b=KdRQYWdPCBwjJxjluuh7TyzvRIene85UCU6paFwTLarX+WWuUXO00tPXJpxAgJ8B65
 mbL8JEEirH3URQk6Ho0XI0Lim7TZgVs4p2H3iOEyW5+Rr7p9eg68ctHBUPkHgQsV4nBK
 VpPjnPpTK0xQMJKO4bF2Kw35/DA9k9l8bHP/hTqlCVt6cN443gBbq3JNUlEqlusWpuFb
 uZx3nuxY8AsTzIJ892pOogJOg2bpP3YxQhSfgEltOqix0R7ktFKa9XDnc674KVf+rikJ
 Xrk9kSM/o7x95uyQCHSlZpa3MeRwF1gSRZtLLdTkBDJwy6/HQ3Aki5E8Pf4EeU6PcBWo
 bAKw==
X-Gm-Message-State: AOJu0YzpAZmV2WyVMMjHVHp4sylVtI2eTwT12UYlEz1vEmLYi4Z1UuEw
 IyR862l/ed+qrs1QU2OOfuCixg==
X-Google-Smtp-Source: AGHT+IHukNU2PwkvIYnB7BZpikLUB9AlRuTPt0uizZJIQbiQGSkRZhKvM09WlC/C4dU4cQ9oLvF1aA==
X-Received: by 2002:a17:907:a068:b0:9a5:b875:eba with SMTP id
 ia8-20020a170907a06800b009a5b8750ebamr67828ejc.24.1693341087308; 
 Tue, 29 Aug 2023 13:31:27 -0700 (PDT)
Received: from [192.168.200.206] (83.11.188.80.ipv4.supernova.orange.pl.
 [83.11.188.80]) by smtp.gmail.com with ESMTPSA id
 b8-20020a170906194800b0099bd5b72d93sm6335923eje.43.2023.08.29.13.31.26
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 29 Aug 2023 13:31:26 -0700 (PDT)
Message-ID: <601619fb-5f1e-4b93-3dd1-b415d0ee8979@linaro.org>
Date: Tue, 29 Aug 2023 22:31:25 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: PCIe: SLT attribute mismatch: 0xFF020100 instead of 0x20100
Content-Language: pl-PL, en-GB, en-HK
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org,
 Gowtham Siddarth <gowtham.siddarth@arm.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
References: <56aa4acb-d54c-a457-5a32-9258cec1ac96@linaro.org>
 <CAFEAcA81xq_yEXYdtAXtkqcdR=MHagSNf5rXOtt+AwohMY_=BQ@mail.gmail.com>
 <20230829093909-mutt-send-email-mst@kernel.org>
 <43653986-c04f-0076-637b-9061f9702f77@linaro.org>
 <20230829130617-mutt-send-email-mst@kernel.org>
 <ff230439-5d76-1f50-a25a-1fd666c3f369@linaro.org>
 <20230829161732-mutt-send-email-mst@kernel.org>
From: Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>
Organization: Linaro
In-Reply-To: <20230829161732-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::632;
 envelope-from=marcin.juszkiewicz@linaro.org; helo=mail-ej1-x632.google.com
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

W dniu 29.08.2023 o 22:18, Michael S. Tsirkin pisze:
> On Tue, Aug 29, 2023 at 10:05:47PM +0200, Marcin Juszkiewicz wrote:
>> W dniu 29.08.2023 o 19:07, Michael S. Tsirkin pisze:
>>
>>> No - it depends on secondart bus type and only applies to bridges.
>>> Also we need compat machinery.
>>> Marcin could you pls test the following?
>>
>> Works fine:
>>
>>   822 : Check Type 1 config header rules           : Result:  PASS
> 
> Thanks! Now if possible I'd like to ask you to run the following test
> with both default machine and 8.1 machine types.
> With default should pass with 8.1 should fail as before.

It passes with sbsa-ref (which is not using QEMU versioning).

Fails (as expected) when used new property for each pcie-root-port
(ignore line breaks):

"-device pcie-root-port,
   x-pci-express-writeable-slt-bug=true,
   id=root30,chassis=30,slot=0"

> Thanks!

Thanks for sorting it out. I may have some more PCIe related
questions in future.
  
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
> index da699cf4e1..d665c79de3 100644
> --- a/hw/core/machine.c
> +++ b/hw/core/machine.c
> @@ -39,7 +39,9 @@
>   #include "hw/virtio/virtio.h"
>   #include "hw/virtio/virtio-pci.h"
>   
> -GlobalProperty hw_compat_8_1[] = {};
> +GlobalProperty hw_compat_8_1[] = {
> +    { TYPE_PCI_BRIDGE, "x-pci-express-writeable-slt-bug", "true" },

../hw/core/machine.c:43:7: error: ‘TYPE_PCI_BRIDGE’ undeclared here (not in a function); did you mean ‘TYPE_PCI_BUS’?
    43 |     { TYPE_PCI_BRIDGE, "x-pci-express-writeable-slt-bug", "true" },
       |       ^~~~~~~~~~~~~~~
       |       TYPE_PCI_BUS

Works with TYPE_PCI_BUS.

> +};
>   const size_t hw_compat_8_1_len = G_N_ELEMENTS(hw_compat_8_1);
>   
>   GlobalProperty hw_compat_8_0[] = {
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
> 



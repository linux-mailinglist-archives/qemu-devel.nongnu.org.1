Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B39F78D071
	for <lists+qemu-devel@lfdr.de>; Wed, 30 Aug 2023 01:24:52 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qb7nq-0001Z8-2t; Tue, 29 Aug 2023 19:07:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcin.juszkiewicz@linaro.org>)
 id 1qb4yK-0003G2-KZ
 for qemu-devel@nongnu.org; Tue, 29 Aug 2023 16:05:58 -0400
Received: from mail-lf1-x129.google.com ([2a00:1450:4864:20::129])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcin.juszkiewicz@linaro.org>)
 id 1qb4yG-0008P5-FE
 for qemu-devel@nongnu.org; Tue, 29 Aug 2023 16:05:56 -0400
Received: by mail-lf1-x129.google.com with SMTP id
 2adb3069b0e04-5009969be25so7569173e87.3
 for <qemu-devel@nongnu.org>; Tue, 29 Aug 2023 13:05:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1693339550; x=1693944350;
 h=content-transfer-encoding:in-reply-to:organization:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=6wIf0I6h+UevJji/rsFDWY6I1KcGzxVj9Gs+hlj7Ytw=;
 b=RzE7kOJXPyXqyL+jZVCIl/mgjqxLBGWToJh5bHlVcU4H0M5izIyLGDhN/0244dPSxB
 iFDh67HLxyAOkK96YnL7x5iIhLPjEW1kuQYhKBLxdQEAP40XEiWYGCfLpjc5PDa5vaW1
 fjhDRvCRTikwzj+tNiysUPCQ1fx2fuJR/d3K604B6TUY2l7l/mDhR8+ajtG7eh9oc1/f
 mc75zMmtSmHIFE2m2qcaeeEb044YimNjvCy1OqRwmpySn4DW5z2wANpWRbAdj2BvVs0p
 T5pShHwnFK8gx0wmyCwyCGoh/u6ZY6ZcGo8cstU6VYOufrIARNtKgitWIs/UcKg3YVVT
 pb2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693339550; x=1693944350;
 h=content-transfer-encoding:in-reply-to:organization:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=6wIf0I6h+UevJji/rsFDWY6I1KcGzxVj9Gs+hlj7Ytw=;
 b=SS2szFUc2YENk+9sg18gLsSnJageT+M2ljV3VXQR4CL7JQ+RZGkPwmu1N88h1S8+Be
 oie2Ux2NiKSHOhFTKvA2wWMUGGM1nxZMFinIY8Bn2xXmw8GoIIPWPpFMjr4Efayb5nk8
 NaQS7lYhfhpiuOx49WGWGYWjWhkY1MHQ0yy9epmc8/TBEUowAy+z+pIUgn0S2dq+B7E/
 ONHIUu60N+YyH4SU3jtvYEf+yF1QOjopggmve8mWlD2HUC2jYz0l2PPTxtksTSM/OKdT
 A93f8OunUhlzZgoeIajJzIkA4hYdT538q1s4hF/ZDIhPXcxorA9v7Na0f9/iKt0lWING
 T1MA==
X-Gm-Message-State: AOJu0YzwbL/HgVjp/pvR4bOY00OzXl6sQnsaW9G11a5WLDAGQLkkpvmx
 xsHO9j6BfgvaNzushtZ+veZpFA==
X-Google-Smtp-Source: AGHT+IEDZlxhA9AABYmfwGrAmP8mS5U93bI5RQjuFCPDnLk2WOAowzwYHho1Dfh5FxoDFeOhlEvlNQ==
X-Received: by 2002:a19:ac4b:0:b0:4ff:9efd:8a9e with SMTP id
 r11-20020a19ac4b000000b004ff9efd8a9emr17716537lfc.7.1693339549753; 
 Tue, 29 Aug 2023 13:05:49 -0700 (PDT)
Received: from [192.168.200.206] (83.11.188.80.ipv4.supernova.orange.pl.
 [83.11.188.80]) by smtp.gmail.com with ESMTPSA id
 b10-20020a170906490a00b009a1fef32ce6sm6392461ejq.177.2023.08.29.13.05.48
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 29 Aug 2023 13:05:49 -0700 (PDT)
Message-ID: <ff230439-5d76-1f50-a25a-1fd666c3f369@linaro.org>
Date: Tue, 29 Aug 2023 22:05:47 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: PCIe: SLT attribute mismatch: 0xFF020100 instead of 0x20100
Content-Language: pl-PL, en-GB, en-HK
To: "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org,
 Gowtham Siddarth <gowtham.siddarth@arm.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
References: <56aa4acb-d54c-a457-5a32-9258cec1ac96@linaro.org>
 <CAFEAcA81xq_yEXYdtAXtkqcdR=MHagSNf5rXOtt+AwohMY_=BQ@mail.gmail.com>
 <20230829093909-mutt-send-email-mst@kernel.org>
 <43653986-c04f-0076-637b-9061f9702f77@linaro.org>
 <20230829130617-mutt-send-email-mst@kernel.org>
From: Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>
Organization: Linaro
In-Reply-To: <20230829130617-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::129;
 envelope-from=marcin.juszkiewicz@linaro.org; helo=mail-lf1-x129.google.com
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

W dniu 29.08.2023 o 19:07, Michael S. Tsirkin pisze:

> No - it depends on secondart bus type and only applies to bridges.
> Also we need compat machinery.
> Marcin could you pls test the following?

Works fine:

  822 : Check Type 1 config header rules           : Result:  PASS

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
> 



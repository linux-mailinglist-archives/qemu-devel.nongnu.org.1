Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 893DD78E674
	for <lists+qemu-devel@lfdr.de>; Thu, 31 Aug 2023 08:23:59 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qbb4m-0000gX-5z; Thu, 31 Aug 2023 02:22:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qbb4j-0000gA-D8
 for qemu-devel@nongnu.org; Thu, 31 Aug 2023 02:22:41 -0400
Received: from mail-ed1-x536.google.com ([2a00:1450:4864:20::536])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qbb4h-0007t9-23
 for qemu-devel@nongnu.org; Thu, 31 Aug 2023 02:22:41 -0400
Received: by mail-ed1-x536.google.com with SMTP id
 4fb4d7f45d1cf-52a4737a08fso468373a12.3
 for <qemu-devel@nongnu.org>; Wed, 30 Aug 2023 23:22:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1693462957; x=1694067757; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=tS5vYakQdR3nVkQgnyszypHkbTRBZPUvRax7gaPHFxI=;
 b=RWWW2FXxgGb2/uvUqVym0K8aKFr2BmdrYy6bUgWXHkAfKbY2vqEmsfkormVfK9Z9c9
 n1hrUWceGfeMmHVtAMpbs7skXzPhlOHYY4URwwwK5ONhRz4ynnNu9bD60DhJkwxGO/KL
 ogdYMjUfER2TZYuV3RasxPXvJv1uWQXfklNokejs94rlySxG5VmmIXtCYGmWy2W+wV4G
 A3+LVXtR4xJ0zXLc5VBxe/gl5xWd1LziJTs+8InAg4/Hp7Z+wPDDB/VyRWyHGanJxDUT
 3C10gQ1I0RFJmGu0L5uI6cWzRuZKaD7e1/ix78gdpOcMfYa1fA5MXOybOBYlSL7LwYCT
 QeGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693462957; x=1694067757;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=tS5vYakQdR3nVkQgnyszypHkbTRBZPUvRax7gaPHFxI=;
 b=CAiJs6NVy5IzOuwDnJSjSz0nUbmblgem4Hhq7N0dlD1fjPi9bCyX1wl2RGAqPlmJ+g
 Z/6MnPP+xVYyjEfAatWv39/QQQOkbEEwtiwTJ1OL4scC4C8syCVFANaWrCF/GK7KZBTt
 ZftrVUYg0rZhPF+wOZftMxvBpYxuIN90mmqOvqloNg7BT+p2yDUlXO8Oke5vygxKdhUJ
 3g5sHE/rLs8xwMQqh30sIZezn5IixH9fW5Pbno2gbD7HSkOcDAtkKQo4GtDWD9tyZnuf
 wpvzby923FIX5TA7EXfUdMQ+u0Evg40hp9XWpZvG8CEbIzhPw7NqfM2auRltiBZlNzyd
 SCAw==
X-Gm-Message-State: AOJu0YwQIuWhNvKgCkJPpYnL2NFMKcAYo7Q/AZfuCUdnlJOg5f88VuvN
 qo/ZxZ2o7+5QeVj+ch6HPuWmrg==
X-Google-Smtp-Source: AGHT+IHMjOFTTBLn2DC8w18H05hGAcsI//wrD0exwEpG3VhtP9G/oW9u/4tTOnNbgLHFfmml3+JVEg==
X-Received: by 2002:a05:6402:124c:b0:523:d1ab:b2ed with SMTP id
 l12-20020a056402124c00b00523d1abb2edmr3566702edw.29.1693462957173; 
 Wed, 30 Aug 2023 23:22:37 -0700 (PDT)
Received: from [192.168.69.115] ([176.187.199.245])
 by smtp.gmail.com with ESMTPSA id
 p11-20020a056402074b00b005231e1780aasm400722edy.91.2023.08.30.23.22.35
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 30 Aug 2023 23:22:36 -0700 (PDT)
Message-ID: <084d2e90-86d4-eabc-3270-d3ef680c9631@linaro.org>
Date: Thu, 31 Aug 2023 08:22:34 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.14.0
Subject: Re: [PATCH] pci: SLT must be RO
Content-Language: en-US
To: "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org
Cc: Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Yanan Wang <wangyanan55@huawei.com>
References: <de9d05366a70172e1789d10591dbe59e39c3849c.1693432039.git.mst@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <de9d05366a70172e1789d10591dbe59e39c3849c.1693432039.git.mst@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::536;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x536.google.com
X-Spam_score_int: -32
X-Spam_score: -3.3
X-Spam_bar: ---
X-Spam_report: (-3.3 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-1.242,
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

Hi Michael,

On 30/8/23 23:48, Michael S. Tsirkin wrote:
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
> 
> Marcin, could you pls test this patch with virt-8.1 and latest?
> Thanks a lot!
> 
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

Patch LGTM, so:
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

> -GlobalProperty hw_compat_8_1[] = {};
> +GlobalProperty hw_compat_8_1[] = {
> +    { TYPE_PCI_BRIDGE, "x-pci-express-writeable-slt-bug", "true" },

However I don't understand why we can't clear the config register and
must use a compat flag, since per the spec it is hardwired to 0.

Do we need the "x-" compat prefix? This is not an experimental property.

> +};
>   const size_t hw_compat_8_1_len = G_N_ELEMENTS(hw_compat_8_1);


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





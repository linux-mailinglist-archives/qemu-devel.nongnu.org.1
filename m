Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 22D137CE26A
	for <lists+qemu-devel@lfdr.de>; Wed, 18 Oct 2023 18:12:12 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qt93O-0006HR-IL; Wed, 18 Oct 2023 12:05:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qt93F-0006FC-Lz
 for qemu-devel@nongnu.org; Wed, 18 Oct 2023 12:05:41 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qt93D-0000nR-5Q
 for qemu-devel@nongnu.org; Wed, 18 Oct 2023 12:05:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697645138;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=Q4oig/hzpB5AaAp4b4GPxSl5owH8+Typ4kIPdsGFzIU=;
 b=ZgM2clnh0+Vj/4lccDoC6AMRFj9FCwjcnNXHqFHGfk9hB+ESveLwEm/3zMBeiisKsLKYSZ
 pz0PEkXBSH8bQsyPrxj4DLXbvG7sQBcjprvFA7wCGKnVb/y6JbKRJlAGFQk2X4oB3Z9jI+
 rCDxeMO6fIKtHiGzS9A1EpgBwYFNK5w=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-591-Rk3xWGk1ME2Fh7EztQ3nYw-1; Wed, 18 Oct 2023 12:05:32 -0400
X-MC-Unique: Rk3xWGk1ME2Fh7EztQ3nYw-1
Received: by mail-qt1-f198.google.com with SMTP id
 d75a77b69052e-418099ca1c2so78983881cf.0
 for <qemu-devel@nongnu.org>; Wed, 18 Oct 2023 09:05:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697645131; x=1698249931;
 h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Q4oig/hzpB5AaAp4b4GPxSl5owH8+Typ4kIPdsGFzIU=;
 b=p3aaD8E6XDX5FhHLnPcdrO72CqmZ2RHxqqbBz9cqhm+me4MNrzyRTPEHggNBov5QLs
 YFkHZ9jaZiGohHf5zTbTUZg3ZFG3hz2O8M661pe3eYN+D5/dwOThDGflUugMz1DpwUtr
 Bi27iPGbbItSGyIRs02u0NuQU8SWY0l7nBtmM12MgNTurcgNwar6RjnFxJmTpbliPs/i
 HtcNsziNHvEXrIrE3B5xQJjG1X8K6wnT5yx0hDynSyvmS8uqsM7KnLfMVHngLYqbeC5m
 z9K7RQJqrb6zfvDbN/Bi32Sy3P7Cc2Qk5VHJCzp8pcaNwm38hlc12BhdSEMwCJHwElgK
 Rriw==
X-Gm-Message-State: AOJu0YxUpwE3PCXbZ10WuFjIsjbhIrpmgohQLMdzSZUO7n0BtSllEB6C
 cYCseDlCp46NVlSyrjYUyw+r0OgkoMgExerP6AXpcHwjAnGEft3qB4olo4DhYV0OTrTlp9gvdmS
 bygd3vL9LOgLbBtM=
X-Received: by 2002:a05:622a:282:b0:403:fcd9:963 with SMTP id
 z2-20020a05622a028200b00403fcd90963mr6155479qtw.67.1697645131418; 
 Wed, 18 Oct 2023 09:05:31 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFjUoNxzh7224M4iwVJ/bu9CzuNkoAGdOoqK5sAn1HcbKUh2lv9RPwoKaq9LFbmATSLV0CyjA==
X-Received: by 2002:a05:622a:282:b0:403:fcd9:963 with SMTP id
 z2-20020a05622a028200b00403fcd90963mr6155434qtw.67.1697645131124; 
 Wed, 18 Oct 2023 09:05:31 -0700 (PDT)
Received: from [192.168.0.5] (ip-109-43-176-141.web.vodafone.de.
 [109.43.176.141]) by smtp.gmail.com with ESMTPSA id
 h19-20020ac85053000000b004198f248e8dsm52393qtm.76.2023.10.18.09.05.17
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 18 Oct 2023 09:05:23 -0700 (PDT)
Message-ID: <6020a0cd-19a8-4cf7-a99d-781854464887@redhat.com>
Date: Wed, 18 Oct 2023 18:05:15 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 05/12] hw/pci-host/bonito: Do not use SysBus API to map
 local MMIO region
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Eric Farman <farman@linux.ibm.com>, Peter Xu <peterx@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Halil Pasic <pasic@linux.ibm.com>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Strahinja Jankovic <strahinja.p.jankovic@gmail.com>,
 Eduardo Habkost <eduardo@habkost.net>, Sergio Lopez <slp@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Jason Wang <jasowang@redhat.com>, qemu-arm@nongnu.org,
 qemu-s390x@nongnu.org, Ilya Leoshkevich <iii@linux.ibm.com>,
 Song Gao <gaosong@loongson.cn>, Huacai Chen <chenhuacai@kernel.org>,
 Beniamino Galvani <b.galvani@gmail.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 David Hildenbrand <david@redhat.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
References: <20231018141151.87466-1-philmd@linaro.org>
 <20231018141151.87466-6-philmd@linaro.org>
From: Thomas Huth <thuth@redhat.com>
Autocrypt: addr=thuth@redhat.com; keydata=
 xsFNBFH7eUwBEACzyOXKU+5Pcs6wNpKzrlJwzRl3VGZt95VCdb+FgoU9g11m7FWcOafrVRwU
 yYkTm9+7zBUc0sW5AuPGR/dp3pSLX/yFWsA/UB4nJsHqgDvDU7BImSeiTrnpMOTXb7Arw2a2
 4CflIyFqjCpfDM4MuTmzTjXq4Uov1giGE9X6viNo1pxyEpd7PanlKNnf4PqEQp06X4IgUacW
 tSGj6Gcns1bCuHV8OPWLkf4hkRnu8hdL6i60Yxz4E6TqlrpxsfYwLXgEeswPHOA6Mn4Cso9O
 0lewVYfFfsmokfAVMKWzOl1Sr0KGI5T9CpmRfAiSHpthhHWnECcJFwl72NTi6kUcUzG4se81
 O6n9d/kTj7pzTmBdfwuOZ0YUSqcqs0W+l1NcASSYZQaDoD3/SLk+nqVeCBB4OnYOGhgmIHNW
 0CwMRO/GK+20alxzk//V9GmIM2ACElbfF8+Uug3pqiHkVnKqM7W9/S1NH2qmxB6zMiJUHlTH
 gnVeZX0dgH27mzstcF786uPcdEqS0KJuxh2kk5IvUSL3Qn3ZgmgdxBMyCPciD/1cb7/Ahazr
 3ThHQXSHXkH/aDXdfLsKVuwDzHLVSkdSnZdt5HHh75/NFHxwaTlydgfHmFFwodK8y/TjyiGZ
 zg2Kje38xnz8zKn9iesFBCcONXS7txENTzX0z80WKBhK+XSFJwARAQABzR5UaG9tYXMgSHV0
 aCA8dGh1dGhAcmVkaGF0LmNvbT7CwXgEEwECACIFAlVgX6oCGwMGCwkIBwMCBhUIAgkKCwQW
 AgMBAh4BAheAAAoJEC7Z13T+cC21EbIP/ii9cvT2HHGbFRl8HqGT6+7Wkb+XLMqJBMAIGiQK
 QIP3xk1HPTsLfVG0ao4hy/oYkGNOP8+ubLnZen6Yq3zAFiMhQ44lvgigDYJo3Ve59gfe99KX
 EbtB+X95ODARkq0McR6OAsPNJ7gpEUzfkQUUJTXRDQXfG/FX303Gvk+YU0spm2tsIKPl6AmV
 1CegDljzjycyfJbk418MQmMu2T82kjrkEofUO2a24ed3VGC0/Uz//XCR2ZTo+vBoBUQl41BD
 eFFtoCSrzo3yPFS+w5fkH9NT8ChdpSlbNS32NhYQhJtr9zjWyFRf0Zk+T/1P7ECn6gTEkp5k
 ofFIA4MFBc/fXbaDRtBmPB0N9pqTFApIUI4vuFPPO0JDrII9dLwZ6lO9EKiwuVlvr1wwzsgq
 zJTPBU3qHaUO4d/8G+gD7AL/6T4zi8Jo/GmjBsnYaTzbm94lf0CjXjsOX3seMhaE6WAZOQQG
 tZHAO1kAPWpaxne+wtgMKthyPLNwelLf+xzGvrIKvLX6QuLoWMnWldu22z2ICVnLQChlR9d6
 WW8QFEpo/FK7omuS8KvvopFcOOdlbFMM8Y/8vBgVMSsK6fsYUhruny/PahprPbYGiNIhKqz7
 UvgyZVl4pBFjTaz/SbimTk210vIlkDyy1WuS8Zsn0htv4+jQPgo9rqFE4mipJjy/iboDzsFN
 BFH7eUwBEAC2nzfUeeI8dv0C4qrfCPze6NkryUflEut9WwHhfXCLjtvCjnoGqFelH/PE9NF4
 4VPSCdvD1SSmFVzu6T9qWdcwMSaC+e7G/z0/AhBfqTeosAF5XvKQlAb9ZPkdDr7YN0a1XDfa
 +NgA+JZB4ROyBZFFAwNHT+HCnyzy0v9Sh3BgJJwfpXHH2l3LfncvV8rgFv0bvdr70U+On2XH
 5bApOyW1WpIG5KPJlDdzcQTyptOJ1dnEHfwnABEfzI3dNf63rlxsGouX/NFRRRNqkdClQR3K
 gCwciaXfZ7ir7fF0u1N2UuLsWA8Ei1JrNypk+MRxhbvdQC4tyZCZ8mVDk+QOK6pyK2f4rMf/
 WmqxNTtAVmNuZIwnJdjRMMSs4W4w6N/bRvpqtykSqx7VXcgqtv6eqoDZrNuhGbekQA0sAnCJ
 VPArerAZGArm63o39me/bRUQeQVSxEBmg66yshF9HkcUPGVeC4B0TPwz+HFcVhheo6hoJjLq
 knFOPLRj+0h+ZL+D0GenyqD3CyuyeTT5dGcNU9qT74bdSr20k/CklvI7S9yoQje8BeQAHtdV
 cvO8XCLrpGuw9SgOS7OP5oI26a0548M4KldAY+kqX6XVphEw3/6U1KTf7WxW5zYLTtadjISB
 X9xsRWSU+Yqs3C7oN5TIPSoj9tXMoxZkCIHWvnqGwZ7JhwARAQABwsFfBBgBAgAJBQJR+3lM
 AhsMAAoJEC7Z13T+cC21hPAQAIsBL9MdGpdEpvXs9CYrBkd6tS9mbaSWj6XBDfA1AEdQkBOn
 ZH1Qt7HJesk+qNSnLv6+jP4VwqK5AFMrKJ6IjE7jqgzGxtcZnvSjeDGPF1h2CKZQPpTw890k
 fy18AvgFHkVk2Oylyexw3aOBsXg6ukN44vIFqPoc+YSU0+0QIdYJp/XFsgWxnFIMYwDpxSHS
 5fdDxUjsk3UBHZx+IhFjs2siVZi5wnHIqM7eK9abr2cK2weInTBwXwqVWjsXZ4tq5+jQrwDK
 cvxIcwXdUTLGxc4/Z/VRH1PZSvfQxdxMGmNTGaXVNfdFZjm4fz0mz+OUi6AHC4CZpwnsliGV
 ODqwX8Y1zic9viSTbKS01ZNp175POyWViUk9qisPZB7ypfSIVSEULrL347qY/hm9ahhqmn17
 Ng255syASv3ehvX7iwWDfzXbA0/TVaqwa1YIkec+/8miicV0zMP9siRcYQkyTqSzaTFBBmqD
 oiT+z+/E59qj/EKfyce3sbC9XLjXv3mHMrq1tKX4G7IJGnS989E/fg6crv6NHae9Ckm7+lSs
 IQu4bBP2GxiRQ+NV3iV/KU3ebMRzqIC//DCOxzQNFNJAKldPe/bKZMCxEqtVoRkuJtNdp/5a
 yXFZ6TfE1hGKrDBYAm4vrnZ4CXFSBDllL59cFFOJCkn4Xboj/aVxxJxF30bn
In-Reply-To: <20231018141151.87466-6-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 18/10/2023 16.11, Philippe Mathieu-Daudé wrote:
> There is no point in exposing an internal MMIO region via
> SysBus and directly mapping it in the very same device.
> 
> Just map it without using the SysBus API.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   hw/pci-host/bonito.c | 29 ++++++++++++++---------------
>   1 file changed, 14 insertions(+), 15 deletions(-)
> 
> diff --git a/hw/pci-host/bonito.c b/hw/pci-host/bonito.c
> index ee6cb85e97..3b803bcad3 100644
> --- a/hw/pci-host/bonito.c
> +++ b/hw/pci-host/bonito.c
> @@ -654,7 +654,6 @@ static void bonito_host_realize(DeviceState *dev, Error **errp)
>   static void bonito_pci_realize(PCIDevice *dev, Error **errp)
>   {
>       PCIBonitoState *s = PCI_BONITO(dev);
> -    SysBusDevice *sysbus = SYS_BUS_DEVICE(s->pcihost);
>       PCIHostState *phb = PCI_HOST_BRIDGE(s->pcihost);
>       BonitoState *bs = s->pcihost;
>       MemoryRegion *pcimem_alias = g_new(MemoryRegion, 1);
> @@ -668,48 +667,48 @@ static void bonito_pci_realize(PCIDevice *dev, Error **errp)
>       /* set the north bridge register mapping */
>       memory_region_init_io(&s->iomem, OBJECT(s), &bonito_ops, s,
>                             "north-bridge-register", BONITO_INTERNAL_REG_SIZE);
> -    sysbus_init_mmio(sysbus, &s->iomem);
> -    sysbus_mmio_map(sysbus, 0, BONITO_INTERNAL_REG_BASE);
> +    memory_region_add_subregion(get_system_memory(), BONITO_INTERNAL_REG_BASE,
> +                                &s->iomem);
>   
>       /* set the north bridge pci configure  mapping */
>       memory_region_init_io(&phb->conf_mem, OBJECT(s), &bonito_pciconf_ops, s,
>                             "north-bridge-pci-config", BONITO_PCICONFIG_SIZE);
> -    sysbus_init_mmio(sysbus, &phb->conf_mem);
> -    sysbus_mmio_map(sysbus, 1, BONITO_PCICONFIG_BASE);
> +    memory_region_add_subregion(get_system_memory(), BONITO_PCICONFIG_BASE,
> +                                &phb->conf_mem);
>   
>       /* set the south bridge pci configure  mapping */
>       memory_region_init_io(&phb->data_mem, OBJECT(s), &bonito_spciconf_ops, s,
>                             "south-bridge-pci-config", BONITO_SPCICONFIG_SIZE);
> -    sysbus_init_mmio(sysbus, &phb->data_mem);
> -    sysbus_mmio_map(sysbus, 2, BONITO_SPCICONFIG_BASE);
> +    memory_region_add_subregion(get_system_memory(), BONITO_SPCICONFIG_BASE,
> +                                &phb->data_mem);
>   
>       create_unimplemented_device("bonito", BONITO_REG_BASE, BONITO_REG_SIZE);
>   
>       memory_region_init_io(&s->iomem_ldma, OBJECT(s), &bonito_ldma_ops, s,
>                             "ldma", 0x100);
> -    sysbus_init_mmio(sysbus, &s->iomem_ldma);
> -    sysbus_mmio_map(sysbus, 3, 0x1fe00200);
> +    memory_region_add_subregion(get_system_memory(), 0x1fe00200,
> +                                &s->iomem_ldma);
>   
>       /* PCI copier */
>       memory_region_init_io(&s->iomem_cop, OBJECT(s), &bonito_cop_ops, s,
>                             "cop", 0x100);
> -    sysbus_init_mmio(sysbus, &s->iomem_cop);
> -    sysbus_mmio_map(sysbus, 4, 0x1fe00300);
> +    memory_region_add_subregion(get_system_memory(), 0x1fe00300,
> +                                &s->iomem_cop);
>   
>       create_unimplemented_device("ROMCS", BONITO_FLASH_BASE, 60 * MiB);
>   
>       /* Map PCI IO Space  0x1fd0 0000 - 0x1fd1 0000 */
>       memory_region_init_alias(&s->bonito_pciio, OBJECT(s), "isa_mmio",
>                                get_system_io(), 0, BONITO_PCIIO_SIZE);
> -    sysbus_init_mmio(sysbus, &s->bonito_pciio);
> -    sysbus_mmio_map(sysbus, 5, BONITO_PCIIO_BASE);
> +    memory_region_add_subregion(get_system_memory(), BONITO_PCIIO_BASE,
> +                                &s->bonito_pciio);
>   
>       /* add pci local io mapping */
>   
>       memory_region_init_alias(&s->bonito_localio, OBJECT(s), "IOCS[0]",
>                                get_system_io(), 0, 256 * KiB);
> -    sysbus_init_mmio(sysbus, &s->bonito_localio);
> -    sysbus_mmio_map(sysbus, 6, BONITO_DEV_BASE);
> +    memory_region_add_subregion(get_system_memory(), BONITO_DEV_BASE,
> +                                &s->bonito_localio);
>       create_unimplemented_device("IOCS[1]", BONITO_DEV_BASE + 1 * 256 * KiB,
>                                   256 * KiB);
>       create_unimplemented_device("IOCS[2]", BONITO_DEV_BASE + 2 * 256 * KiB,

Would it make sense to cache the return value of get_system_memory() in a 
local variable instead of calling it again and again ...?

  Thomas



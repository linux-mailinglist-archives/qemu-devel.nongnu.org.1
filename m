Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 70F1072C2C9
	for <lists+qemu-devel@lfdr.de>; Mon, 12 Jun 2023 13:31:56 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q8fll-00043x-Ev; Mon, 12 Jun 2023 07:31:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1q8flh-00043S-Cg
 for qemu-devel@nongnu.org; Mon, 12 Jun 2023 07:31:30 -0400
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1q8flf-0006XA-MF
 for qemu-devel@nongnu.org; Mon, 12 Jun 2023 07:31:29 -0400
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-3f735bfcbbbso30798985e9.2
 for <qemu-devel@nongnu.org>; Mon, 12 Jun 2023 04:31:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1686569485; x=1689161485;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=VsV2PTjfWgrBLX6tiACNoIpYe+2MGB16LdI1dJ87y18=;
 b=zlzNxgpPOYeSUHkb9DOIPUdqvuZdyoOdspnhRF0VviDX6L+7FIZFJzvtWBSUX4qo7C
 cZrBnAhUu6qqjSIHisH1qYWh5WZhJBd+0ijN+Z+l2LhuDWRTRbQndqNxNGSwmBwlgtxZ
 uxNs6IGSlr/hKW2tsR5HpYIX9+kshYh0ItQBpoYSR1c2pt/Zbi1YLGjZADiIJg1aMhWT
 tQIHZ8t+W3pgSiuJOS45D3/qv3Enb/WFSzEPX/KGVIBWh5LFmnOeJuOVt/Sa4K5pWP70
 V6A5dG99RoT0MtsO9HYi1YjZ2vAmFdbrI2uwaKivpuUwaRagiC0ykhYduOENb7YMOE1m
 W71g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686569485; x=1689161485;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=VsV2PTjfWgrBLX6tiACNoIpYe+2MGB16LdI1dJ87y18=;
 b=M48TSf0MTN1oVhpAqtrK0wloN+aO+xLdyCx1bDuLwzXeP+3L73SiZiKKKdwqxADTAt
 4f13h/eo91HCaIqQhPvnGSvzH5YSR50TVSFSCP7JEwj6VkKYkiggu2u6epOwCbGtCMNp
 T+rQmBXvqX3639ZqmfJl/cdr7a3WzV7jsTBM1ZY9H9Bx4UiI1v82H4CXfenjWzSA03PO
 ML+mkWv5Nu5nIqPWSs9xOi83n015ltWy9SGfdLcZf/oEt1KQCGp/2ngUpJkgVL1rkxKM
 ZgkwL6HXY/lS5J5pDdcLEkhGrVNLENWEBU5ydDaaka7x6VnBiFawTatZKHfUUsBUF+co
 PtBg==
X-Gm-Message-State: AC+VfDwfeuYDYfjy14/0mwTeMfGT9WmstHyeWv0C/BRO7hPH4PzLeQcR
 ahEU1r0u76i6LAG5RFU/LBtjSA==
X-Google-Smtp-Source: ACHHUZ4qrdWcSw3S7vPxTx2Bl3H5SodbQd1dIA9J7KtHAo1eescNkuzbaj2Zh4B+wU9spUh+ApznPw==
X-Received: by 2002:a05:600c:a38a:b0:3f7:eadb:9410 with SMTP id
 hn10-20020a05600ca38a00b003f7eadb9410mr6525074wmb.30.1686569484957; 
 Mon, 12 Jun 2023 04:31:24 -0700 (PDT)
Received: from [192.168.112.175] (176.red-88-28-1.dynamicip.rima-tde.net.
 [88.28.1.176]) by smtp.gmail.com with ESMTPSA id
 x22-20020a05600c21d600b003f70a7b4537sm11169721wmj.36.2023.06.12.04.31.23
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 12 Jun 2023 04:31:24 -0700 (PDT)
Message-ID: <4ec48852-4d3c-9fb3-ecfc-cbb3b30bdab5@linaro.org>
Date: Mon, 12 Jun 2023 12:19:20 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.11.2
Subject: Re: [PATCH 10/15] hw/pci-host/i440fx: Make MemoryRegion pointers
 accessible as properties
Content-Language: en-US
To: Bernhard Beschow <shentey@gmail.com>, qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Paolo Bonzini
 <pbonzini@redhat.com>, Richard Henderson <richard.henderson@linaro.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Eduardo Habkost <eduardo@habkost.net>
References: <20230611103412.12109-1-shentey@gmail.com>
 <20230611103412.12109-11-shentey@gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230611103412.12109-11-shentey@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32c.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.096,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On 11/6/23 12:34, Bernhard Beschow wrote:
> The goal is to eliminate i440fx_init() which is a legacy init function. This
> neccessitates the memory regions to be properties, like in Q35, which will be
> assigned in board code.
> 
> Since i440fx needs different PCI devices in Xen mode, and since i440fx shall
> be self-contained, the PCI device will be created during realization of the
> host. Thus the pointers need to be moved to the host structure to be usable as
> properties.
> 
> Signed-off-by: Bernhard Beschow <shentey@gmail.com>
> ---
>   include/hw/pci-host/i440fx.h |  3 ---
>   hw/pci-host/i440fx.c         | 44 ++++++++++++++++++++++++++----------
>   2 files changed, 32 insertions(+), 15 deletions(-)


> @@ -214,12 +220,25 @@ static void i440fx_pcihost_get_pci_hole64_end(Object *obj, Visitor *v,
>   
>   static void i440fx_pcihost_initfn(Object *obj)
>   {
> +    I440FXState *s = I440FX_PCI_HOST_BRIDGE(obj);
>       PCIHostState *phb = PCI_HOST_BRIDGE(obj);
>   
>       memory_region_init_io(&phb->conf_mem, obj, &pci_host_conf_le_ops, phb,
>                             "pci-conf-idx", 4);
>       memory_region_init_io(&phb->data_mem, obj, &pci_host_data_le_ops, phb,
>                             "pci-conf-data", 4);
> +
> +    object_property_add_link(obj, PCI_HOST_PROP_RAM_MEM, TYPE_MEMORY_REGION,
> +                             (Object **) &s->ram_memory,
> +                             qdev_prop_allow_set_link_before_realize, 0);
> +
> +    object_property_add_link(obj, PCI_HOST_PROP_PCI_MEM, TYPE_MEMORY_REGION,
> +                             (Object **) &s->pci_address_space,
> +                             qdev_prop_allow_set_link_before_realize, 0);
> +
> +    object_property_add_link(obj, PCI_HOST_PROP_SYSTEM_MEM, TYPE_MEMORY_REGION,
> +                             (Object **) &s->system_memory,
> +                             qdev_prop_allow_set_link_before_realize, 0);

I wonder why we can't simply use device_class_set_props() in 
i440fx_pcihost_class_init().

Anyhow,
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>



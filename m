Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C11E18358B3
	for <lists+qemu-devel@lfdr.de>; Mon, 22 Jan 2024 00:19:12 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rRh4M-0003rn-TE; Sun, 21 Jan 2024 18:17:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rRh4L-0003rV-7X
 for qemu-devel@nongnu.org; Sun, 21 Jan 2024 18:17:37 -0500
Received: from mail-pl1-x62d.google.com ([2607:f8b0:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rRh4J-0005dC-7N
 for qemu-devel@nongnu.org; Sun, 21 Jan 2024 18:17:36 -0500
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-1d714e224e0so19435735ad.2
 for <qemu-devel@nongnu.org>; Sun, 21 Jan 2024 15:17:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1705879053; x=1706483853; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=yAmz0ymgScWDrILf5EEp7nEmlftPxtxfSMusfxGQsYk=;
 b=nIgJ784cJWy/xf0gwV1CxI4gOlVju/NjWryG1svOMkp+bpxn82BBz+F5VISYSEgqYn
 V5+1MNzUgpUgePFgdomqVT0FTlrp/hJPqjSnmW+FtGBcSYAFM/t56rD5er1fRJR13esm
 +hbjM83KxO3/mYv4xH6NSxQRp98DsEq2XScRRexdJgDaZxh5HCXLxUyp5Ah0rdEfbhqF
 d6rhPlGAfLAjY29lG3gh7JX5wh7FNHfsaiyaN2v+JIWcbMVXlhpSCOBdnE3zUJradeZX
 5NEIvqmb+6M2P9uuusd0AzRsYungxFZQ6YCcyIQZRHGLhn3x9r3hKrkQtG6ZWPn32N7H
 f6hQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705879053; x=1706483853;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=yAmz0ymgScWDrILf5EEp7nEmlftPxtxfSMusfxGQsYk=;
 b=LYcTPBtnB5NCgtRhuup8WTx4eYVJllF4/xkIt0XctrOxkFnN8uH1sQ5b9psQ5usCun
 v08qoug/t1JWRU0Py3RPxDu9Yx3Pw0Wo072XjtjwSUku75oa3zL7RZZhqHTpZ1P16hCa
 XeWGZXxmNLkEsCx8m4wpppdP+eHpr9Ye0y9N/Z2V8cOlsHaFNmBlSuU14S5ZmEIUvVww
 4WCPzrBmdXD77ec+HWDh2oYp1ncL4riXqS7ZtwUfTJWdQqrLXFJBOGCePj/1FAl8gK/K
 uvZxy63HYAV9ppy9LHZAgI5KXA4i42e+KrXpP0kgHbSQyl3uX/y2OQCJlxjdJfKi8vRl
 WVRQ==
X-Gm-Message-State: AOJu0Yx8lUmVswawxHJqBcCCXg3mQLt1pVFBc90FseYBrfIvp7mvdj0q
 zPA4a/4JVi6Oy4PfHCAPYvNrhsOScop3Yyu/YXiGR1Zs8LBByQzea92k2A9zz9c=
X-Google-Smtp-Source: AGHT+IEnX/frQFgH7H9qPyRa1PWwinarZ1TJlnYmX0r1E/xv6V9B6cNbUorfoKIKBFm0+Yuuask3Vw==
X-Received: by 2002:a17:902:f684:b0:1d7:3100:9f8a with SMTP id
 l4-20020a170902f68400b001d731009f8amr4080314plg.43.1705879052971; 
 Sun, 21 Jan 2024 15:17:32 -0800 (PST)
Received: from [192.168.1.67] (88-178-114-168.subs.proxad.net.
 [88.178.114.168]) by smtp.gmail.com with ESMTPSA id
 je2-20020a170903264200b001d7385ef111sm2153176plb.79.2024.01.21.15.17.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 21 Jan 2024 15:17:32 -0800 (PST)
Message-ID: <98ede7dd-b254-43aa-bf7d-f5d90494b8c9@linaro.org>
Date: Mon, 22 Jan 2024 00:17:24 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] Handle wrap around in limit calculation
Content-Language: en-US
To: Shlomo Pongratz <shlomopongratz@gmail.com>, qemu-devel@nongnu.org
Cc: andrew.sminov@gmail.com, peter.maydell@linaro.com, shlomop@pliops.com,
 Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>
References: <20240121164754.47367-1-shlomop@pliops.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240121164754.47367-1-shlomop@pliops.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62d;
 envelope-from=philmd@linaro.org; helo=mail-pl1-x62d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

Hi Shlomo,

On 21/1/24 17:47, Shlomo Pongratz wrote:
> From: Shlomo Pongratz <shlomopongratz@gmail.com>
> 
>      Hanlde wrap around when calculating the viewport size
>      caused by the fact that perior to version 460A the limit variable
>      was 32bit quantity and not 64 bits quantity.
>      In the i.MX 6Dual/6Quad Applications Processor Reference Manual
>      document on which the original code was based upon in the
>      description of the iATU Region Upper Base Address Register it is
>      written:
>      Forms bits [63:32] of the start (and end) address of the address region to be
>      translated.
>      That is in this register is the upper of both base and the limit.
>      In the current implementation this value was ignored for the limit
>      which caused a wrap around of the size calculaiton.
>      Using the documnet example:
>      Base HI: 0x80000000 Base LO: 0xd0000000 Limit LO: 0xd000ffff
>      The correct size is 0x80000000d000ffff - 0x80000000d0000000 + 1 =
> 0x010000
>      The wrong result is 0xd000ffff - 0x80000000d0000000 + 1 = 0x8000000000010000
> 
>      Signed-off-by: Shlomo Pongratz <shlomop@pliops.com>
> 
>      ----
> 
>      Changes since v2:
>       * Don't try to fix the calculation.
>       * Change the limit variable from 32bit to 64 bit
>       * Set the limit bits [63:32] same as the base according to
>         the specification on which the original code was base upon.
> 
>      Changes since v1:
>       * Seperate subject and description
> ---
>   hw/pci-host/designware.c         | 19 ++++++++++++++-----
>   include/hw/pci-host/designware.h |  2 +-
>   2 files changed, 15 insertions(+), 6 deletions(-)
> 
> diff --git a/hw/pci-host/designware.c b/hw/pci-host/designware.c
> index dd9e389c07..43cba9432f 100644
> --- a/hw/pci-host/designware.c
> +++ b/hw/pci-host/designware.c
> @@ -269,7 +269,7 @@ static void designware_pcie_update_viewport(DesignwarePCIERoot *root,
>   {
>       const uint64_t target = viewport->target;
>       const uint64_t base   = viewport->base;
> -    const uint64_t size   = (uint64_t)viewport->limit - base + 1;
> +    const uint64_t size   = viewport->limit - base + 1;
>       const bool enabled    = viewport->cr[1] & DESIGNWARE_PCIE_ATU_ENABLE;
>   
>       MemoryRegion *current, *other;
> @@ -351,6 +351,14 @@ static void designware_pcie_root_config_write(PCIDevice *d, uint32_t address,
>       case DESIGNWARE_PCIE_ATU_UPPER_BASE:
>           viewport->base &= 0x00000000FFFFFFFFULL;
>           viewport->base |= (uint64_t)val << 32;
> +        /* The documentatoin states that the value of this register
> +         * "Forms bits [63:32] of the start (and end) address
> +         * of the address region to be translated.
> +         * Note that from version 406A there is a sperate
> +         * register fot the upper end address
> +         */
> +        viewport->limit &= 0x00000000FFFFFFFFULL;
> +        viewport->limit |= (uint64_t)val << 32;

This code is easier to review using:

           viewport->limit = deposit64(viewport->limit, 32, 32, val);

>           break;
>   
>       case DESIGNWARE_PCIE_ATU_LOWER_TARGET:
> @@ -364,7 +372,8 @@ static void designware_pcie_root_config_write(PCIDevice *d, uint32_t address,
>           break;
>   
>       case DESIGNWARE_PCIE_ATU_LIMIT:
> -        viewport->limit = val;
> +        viewport->limit &= 0xFFFFFFFF00000000ULL;
> +        viewport->limit |= val;

Here:

           viewport->limit = deposit64(viewport->limit, 0, 32, val);

>           break;
>   
>       case DESIGNWARE_PCIE_ATU_CR1:
> @@ -429,7 +438,7 @@ static void designware_pcie_root_realize(PCIDevice *dev, Error **errp)
>           viewport->inbound = true;
>           viewport->base    = 0x0000000000000000ULL;
>           viewport->target  = 0x0000000000000000ULL;
> -        viewport->limit   = UINT32_MAX;
> +        viewport->limit   = 0x00000000FFFFFFFFULL;

Previous code is easier to review IMHO.

>           viewport->cr[0]   = DESIGNWARE_PCIE_ATU_TYPE_MEM;
>   
>           source      = &host->pci.address_space_root;
> @@ -453,7 +462,7 @@ static void designware_pcie_root_realize(PCIDevice *dev, Error **errp)
>           viewport->inbound = false;
>           viewport->base    = 0x0000000000000000ULL;
>           viewport->target  = 0x0000000000000000ULL;
> -        viewport->limit   = UINT32_MAX;
> +        viewport->limit   = 0x00000000FFFFFFFFULL;

Ditto.

>           viewport->cr[0]   = DESIGNWARE_PCIE_ATU_TYPE_MEM;
>   
>           destination = &host->pci.memory;
> @@ -560,7 +569,7 @@ static const VMStateDescription vmstate_designware_pcie_viewport = {
>       .fields = (const VMStateField[]) {
>           VMSTATE_UINT64(base, DesignwarePCIEViewport),
>           VMSTATE_UINT64(target, DesignwarePCIEViewport),
> -        VMSTATE_UINT32(limit, DesignwarePCIEViewport),
> +        VMSTATE_UINT64(limit, DesignwarePCIEViewport),

Unfortunately this breaks the migration stream. I'm not sure
what is the best way to deal with it (Cc'ing migration
maintainers).

>           VMSTATE_UINT32_ARRAY(cr, DesignwarePCIEViewport, 2),
>           VMSTATE_END_OF_LIST()
>       }
Regards,

Phil.


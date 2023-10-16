Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8116D7CA014
	for <lists+qemu-devel@lfdr.de>; Mon, 16 Oct 2023 09:05:10 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qsHeQ-0007Ou-IT; Mon, 16 Oct 2023 03:04:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qsHeJ-0007Mv-6Z
 for qemu-devel@nongnu.org; Mon, 16 Oct 2023 03:04:24 -0400
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qsHeH-00021y-Iw
 for qemu-devel@nongnu.org; Mon, 16 Oct 2023 03:04:22 -0400
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-32db188e254so592456f8f.0
 for <qemu-devel@nongnu.org>; Mon, 16 Oct 2023 00:04:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697439860; x=1698044660; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=eWYHsWav78FLELT+tFlrNloPN870qfN/K9WbOVvbEvA=;
 b=yHCfpJZbpd/r4i+zNxsFfuYqFQX6thVr1wviIl6PnGM/5iLKzMqe0h0Y5PW2V4s5o0
 b87haHyl/xUdNF/i6TcIF2Zpv9/52neS6ku4CZFEGTBUh6r+ejmZi0Uasdp8PhUVVzfl
 nftdI04+FCriYjxY38Aw+tieg9+qi9zJ/0zXdnXbtafRkTDZeURk1TDWr8FzRCDJia4H
 zWLblnmCOI8Douzqasa1FVZqFuowc62zAQOXvh40yi0GSZdH9g+sqtvet5AgdwCLtdMC
 DCwHQNc+oVhwZxmTT09Fc+0n3FEfsFxj67+753vY1sRL+wUfSizLTdMkad0vxOietYco
 19Ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697439860; x=1698044660;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=eWYHsWav78FLELT+tFlrNloPN870qfN/K9WbOVvbEvA=;
 b=YfDhUOWQb/ebR+cokBOcIWRMf+27KHDk+0G7r/Ac2q9+3Bwc88p9q4ywZZTR+fySul
 1P1FMypRVwOu6lOQRd2MMfzv8f8RTUFFSplMuUVZJcK2+i504rj/JJxdmDUUxM5ZfJxX
 X+E8dQwr03x1T6SbHeMBoJsYvCFpivHPCMs+piqHANljcbc8SmrbkLLX6P/UALFnpQtT
 a7SgPLbLd5FVuE0kb7sRd3vqM2tjnhPYAuFYd/n5BXRJvc1pFBSPc8aKI86sNVgaeXqf
 Lw0aIem/K2O4a7kWg/PbjBUHZvYQGw/5hSZEelzAsLwasjuapPoWaiC5XU9XRJRMU+Dc
 7S7g==
X-Gm-Message-State: AOJu0YwDORDiVi8T3r4Oo4lZxThzvlut+PMMVP3d+Om942jSApLvQdTJ
 OoTgEWddZGfVgeXnr4dWQSf3SA==
X-Google-Smtp-Source: AGHT+IEFAJOWIKIh34xcS0A4orq55wUJa5f9xrTRBjv4h7ApQLKvl4zJ9JZgWOG1EvfXhOPatTSnBw==
X-Received: by 2002:a5d:6788:0:b0:32d:a4cf:99b3 with SMTP id
 v8-20020a5d6788000000b0032da4cf99b3mr4607191wru.67.1697439859894; 
 Mon, 16 Oct 2023 00:04:19 -0700 (PDT)
Received: from [192.168.69.115]
 (mdq11-h01-176-173-171-135.dsl.sta.abo.bbox.fr. [176.173.171.135])
 by smtp.gmail.com with ESMTPSA id
 o13-20020adfcf0d000000b0032008f99216sm8296853wrj.96.2023.10.16.00.04.18
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 16 Oct 2023 00:04:19 -0700 (PDT)
Message-ID: <bf5d344c-84a1-c6b9-3d17-0362a4c2c9e7@linaro.org>
Date: Mon, 16 Oct 2023 09:04:17 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.1
Subject: Re: [PATCH 3/4] hw/pci-host/bonito: Access memory regions via
 pci_address_space[_io]()
Content-Language: en-US
To: Bernhard Beschow <shentey@gmail.com>, qemu-devel@nongnu.org
Cc: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?UTF-8?Q?Herv=c3=a9_Poussineau?= <hpoussin@reactos.org>,
 Artyom Tarasenko <atar4qemu@gmail.com>, "Michael S. Tsirkin"
 <mst@redhat.com>, Huacai Chen <chenhuacai@kernel.org>, qemu-ppc@nongnu.org,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>
References: <20231011185954.10337-1-philmd@linaro.org>
 <20231011185954.10337-4-philmd@linaro.org>
 <5FD62714-3C33-4A93-B7E3-F3523FCE69C1@gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <5FD62714-3C33-4A93-B7E3-F3523FCE69C1@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::431;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x431.google.com
X-Spam_score_int: -53
X-Spam_score: -5.4
X-Spam_bar: -----
X-Spam_report: (-5.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-3.339,
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

On 16/10/23 00:19, Bernhard Beschow wrote:
> Am 11. Oktober 2023 18:59:53 UTC schrieb "Philippe Mathieu-Daudé" <philmd@linaro.org>:
>> PCI functions are plugged on a PCI bus. They can only access
>> external memory regions via the bus.
>>
>> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>> ---
>> hw/pci-host/bonito.c | 6 +++---
>> 1 file changed, 3 insertions(+), 3 deletions(-)


>> @@ -719,7 +719,7 @@ static void bonito_pci_realize(PCIDevice *dev, Error **errp)
>>
>>      memory_region_init_alias(pcimem_alias, NULL, "pci.mem.alias",
>>                               &bs->pci_mem, 0, BONITO_PCIHI_SIZE);
>> -    memory_region_add_subregion(get_system_memory(),
>> +    memory_region_add_subregion(pci_address_space(dev),
> 
> I need to keep `get_system_memory()` here to get the same results for `info mtree` in the QEMU console before and after this patch when running `qemu-system-mips64el -M fuloong2e -S`. The other two changes above seem to work as expected.

Good catch, thank you Bernhard!



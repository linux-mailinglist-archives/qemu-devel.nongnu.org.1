Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 56ED470F1A5
	for <lists+qemu-devel@lfdr.de>; Wed, 24 May 2023 11:01:40 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q1kLQ-0003KV-7a; Wed, 24 May 2023 04:59:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1q1kLO-0003J6-62
 for qemu-devel@nongnu.org; Wed, 24 May 2023 04:59:42 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1q1kLF-0005cW-SQ
 for qemu-devel@nongnu.org; Wed, 24 May 2023 04:59:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1684918772;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=xkqy27kyvMiqMriySDVMh9p4nXjBI8B+MVNT5/1J7VU=;
 b=e/pJAaTC7BdMkbENor1INP229etxBaGuwFHgBRXGMyJ+9CVpPAgYwPPTvP+eCmcZ4juivv
 xjgqPwjn16hQ8VQyQ7ueT5Q+HldaU6qj3ZIYdCs562YkEmh3K8OOo1q0sZsucrCxLMjBLr
 //bqh3vlEl/HO4PhvIeyI44h3jDhRTY=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-587-75kohm_VMjqeD_Kvuczf6w-1; Wed, 24 May 2023 04:59:30 -0400
X-MC-Unique: 75kohm_VMjqeD_Kvuczf6w-1
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-3f5fb41bc42so2920945e9.1
 for <qemu-devel@nongnu.org>; Wed, 24 May 2023 01:59:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684918769; x=1687510769;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=xkqy27kyvMiqMriySDVMh9p4nXjBI8B+MVNT5/1J7VU=;
 b=g1bCU21hjYYNCNDMOZ4MYwvjMw8fcsf279of/j6vTxBRbrXKn9GHDA+OY4SQe5H3Of
 cH1tg2Prm9nnVPM4TP7kEezJnz2dgzXZb4P0RGAqxzXH/ZbxcF1aWL1YcrxhDybtdm7E
 YVWDcKLhcRL8CLU/YhzhTsdE1xF3j55HWLTWPxZlZKPh+ZM6wkjlyMnL5Q6E3b3f2Bzt
 QE/F8fvymehy0U6sNS5ZqDvM/zfdW7EMdlVfC8Jlj1wCOJeoVuBGG1YMYA8x6tvzyNrt
 4DWQUKl2mMu6jJlKZGgQRyt0VkgAzD5c2HAJ5CACjAohJ5u64XAzsqG7j1l936VcDI82
 eN0A==
X-Gm-Message-State: AC+VfDzHREr45CSU8G59u8y473B81xnAHZ+9aphz7iWCpcSfmY1xzTWE
 QRNC5ybNDJoLiVZMFEilX0GnEROArbqNBypIoKlLh63whSMd5ulvyabNqhHl+YDXfMH4j8Fg3m8
 GJdTnjCPSGF1Aoaw=
X-Received: by 2002:a7b:cd0d:0:b0:3f6:787:4a70 with SMTP id
 f13-20020a7bcd0d000000b003f607874a70mr5407645wmj.15.1684918769091; 
 Wed, 24 May 2023 01:59:29 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ7UkQoUduhCb9cgQW4RmwPMe9/LjOddAnYX3i5M5R5hUawhHFO7zo1LOiHO+QL60c1aLoDM/A==
X-Received: by 2002:a7b:cd0d:0:b0:3f6:787:4a70 with SMTP id
 f13-20020a7bcd0d000000b003f607874a70mr5407629wmj.15.1684918768722; 
 Wed, 24 May 2023 01:59:28 -0700 (PDT)
Received: from [192.168.0.3] (ip-109-43-176-64.web.vodafone.de.
 [109.43.176.64]) by smtp.gmail.com with ESMTPSA id
 u5-20020a05600c00c500b003f0ad8d1c69sm1581551wmm.25.2023.05.24.01.59.27
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 24 May 2023 01:59:28 -0700 (PDT)
Message-ID: <ec6387a4-cc02-9cdc-1719-25f939f68946@redhat.com>
Date: Wed, 24 May 2023 10:59:26 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH 2/3] hw/arm/sbsa-ref: add gfx card only if we have pci
Content-Language: en-US
To: 20230524082037.1620952-1-thuth@redhat.com, qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, Leif Lindholm <quic_llindhol@quicinc.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>
References: <e682f6d5-acbe-7910-54ef-4d75c88a3d28@redhat.com>
 <20230524083913.696175-1-marcin.juszkiewicz@linaro.org>
 <20230524083913.696175-2-marcin.juszkiewicz@linaro.org>
From: Thomas Huth <thuth@redhat.com>
In-Reply-To: <20230524083913.696175-2-marcin.juszkiewicz@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.089, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On 24/05/2023 10.39, Marcin Juszkiewicz wrote:
> Creation of network card is guarded with check do we
> have pci bus. Do the same with graphics card.
> 
> Signed-off-by: Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>
> ---
>   hw/arm/sbsa-ref.c | 6 +++---
>   1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/hw/arm/sbsa-ref.c b/hw/arm/sbsa-ref.c
> index c540b2f1ba..9a3d77d6b6 100644
> --- a/hw/arm/sbsa-ref.c
> +++ b/hw/arm/sbsa-ref.c
> @@ -647,10 +647,10 @@ static void create_pcie(SBSAMachineState *sms)
>   
>               pci_nic_init_nofail(nd, pci->bus, nd->model, NULL);
>           }
> -    }
>   
> -    if (vga_interface_type != VGA_NONE) {
> -        pci_create_simple(pci->bus, -1, "bochs-display");
> +        if (vga_interface_type != VGA_NONE) {
> +            pci_create_simple(pci->bus, -1, "bochs-display");
> +        }
>       }
>   
>       create_smmu(sms, pci->bus);

I wonder whether pci->bus can ever be NULL in this function?

Anyway:
Reviewed-by: Thomas Huth <thuth@redhat.com>



Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B39970F59F
	for <lists+qemu-devel@lfdr.de>; Wed, 24 May 2023 13:49:05 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q1myY-0007f2-Ex; Wed, 24 May 2023 07:48:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1q1myV-0007ec-5a
 for qemu-devel@nongnu.org; Wed, 24 May 2023 07:48:16 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1q1myR-0007kI-U6
 for qemu-devel@nongnu.org; Wed, 24 May 2023 07:48:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1684928891;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=l4+8V8PVu+1cKG5cgq671ZthtkYbHOo22tgl8qIpW5Y=;
 b=bfxdFy+OLwrEam7kQp8P+iVyY91RYSXIfg+NV6CoiT2p9kowM21mzKccnyCoKZnrovJK+l
 iLj9PYOBHVKhgYl7370h3jl8a1LrtMzqFdRsMzldPjmPwpDyE6NLu3rYok30oBgH+D+1hY
 GhJy4mrsZTMEA48IRaPFYkE3Ipl6WTY=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-640-rWbj03SINtK7Mkbr5yYb9w-1; Wed, 24 May 2023 07:48:09 -0400
X-MC-Unique: rWbj03SINtK7Mkbr5yYb9w-1
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-3f50aa22cd2so5471795e9.1
 for <qemu-devel@nongnu.org>; Wed, 24 May 2023 04:48:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684928888; x=1687520888;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=l4+8V8PVu+1cKG5cgq671ZthtkYbHOo22tgl8qIpW5Y=;
 b=JktDdrEFfCqmdDr6Zpu4V2UIPBDFl/HJDHV2dSABHcK7LzAGDrC388Mx7slRklBJde
 RXcrALY/LCuoFGSA1xkFfnHzwxQTjhR6Tzp/ScuB/YNsyDExHYZCZotgJQX4wYywIiNR
 uBgvP8WGpHHcRDAh8SuhXCP6xIyPYVeF/b0ZLRJOTBeU1kCiMqeXKmC4Id6ynexqPoQ7
 00sFpTrJHf1RjCkLTyJA2aFMnorb1AWirhWWttlQYReO9kXJHqUrVP/4AXJTGbZxNCW0
 I+oOi9VuyNYs9TMvk3mg4dDwxTwn5ojH8jg9dT6Y2zP3R/05pZhTMJJ/YICPVyvmVNb7
 Tz2w==
X-Gm-Message-State: AC+VfDy4cxN0aAklZf17txUayv0kSPv3BEsp6bHRdGBUAPkzoce+m8Qu
 jpVN3F91ngtmVI1O1prVHC0qMtEOQckstgkxM3mqbEps1yJYSjVl3tLWEpdkIxjrFDgRZpmBrNn
 EXMiawej7mBHBv9Q=
X-Received: by 2002:a05:600c:b44:b0:3f6:3465:78e0 with SMTP id
 k4-20020a05600c0b4400b003f6346578e0mr886220wmr.40.1684928888628; 
 Wed, 24 May 2023 04:48:08 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ6Ar7ukh2cHN9+CpC62cuLGQ5oW9Jpfp+sJcxYAHp6WriPigW5Z1BBsbjrjcG+R6OfHlcs/RQ==
X-Received: by 2002:a05:600c:b44:b0:3f6:3465:78e0 with SMTP id
 k4-20020a05600c0b4400b003f6346578e0mr886207wmr.40.1684928888428; 
 Wed, 24 May 2023 04:48:08 -0700 (PDT)
Received: from [192.168.0.3] (ip-109-43-176-64.web.vodafone.de.
 [109.43.176.64]) by smtp.gmail.com with ESMTPSA id
 p20-20020a1c7414000000b003f60eb72cf5sm2174260wmc.2.2023.05.24.04.48.07
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 24 May 2023 04:48:07 -0700 (PDT)
Message-ID: <7cf5bc4f-844d-9dc4-9f85-f136853401e4@redhat.com>
Date: Wed, 24 May 2023 13:48:06 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v4 3/3] hw/arm/sbsa-ref: set default display to Bochs
Content-Language: en-US
To: Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>, qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, Leif Lindholm <quic_llindhol@quicinc.com>,
 Peter Maydell <peter.maydell@linaro.org>, Paolo Bonzini <pbonzini@redhat.com>
References: <20230524111413.833912-1-marcin.juszkiewicz@linaro.org>
 <20230524111413.833912-4-marcin.juszkiewicz@linaro.org>
From: Thomas Huth <thuth@redhat.com>
In-Reply-To: <20230524111413.833912-4-marcin.juszkiewicz@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.107, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
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

On 24/05/2023 13.14, Marcin Juszkiewicz wrote:
> This way we can use pci_vga_init() and have Bochs by default while still
> have an option to run with other VGA cards.
> 
> Signed-off-by: Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>
> ---
>   hw/arm/sbsa-ref.c | 5 +++--
>   1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/hw/arm/sbsa-ref.c b/hw/arm/sbsa-ref.c
> index 9c3e670ec6..ed7ed00b3d 100644
> --- a/hw/arm/sbsa-ref.c
> +++ b/hw/arm/sbsa-ref.c
> @@ -647,9 +647,9 @@ static void create_pcie(SBSAMachineState *sms)
>   
>               pci_nic_init_nofail(nd, pci->bus, nd->model, NULL);
>           }
> -    }
>   
> -    pci_create_simple(pci->bus, -1, "bochs-display");
> +        pci_vga_init(pci->bus);
> +    }
>   
>       create_smmu(sms, pci->bus);
>   }
> @@ -863,6 +863,7 @@ static void sbsa_ref_class_init(ObjectClass *oc, void *data)
>       mc->default_ram_size = 1 * GiB;
>       mc->default_ram_id = "sbsa-ref.ram";
>       mc->default_cpus = 4;
> +    mc->default_display = "bochs-display";
>       mc->possible_cpu_arch_ids = sbsa_ref_possible_cpu_arch_ids;
>       mc->cpu_index_to_instance_props = sbsa_ref_cpu_index_to_props;
>       mc->get_default_cpu_node_id = sbsa_ref_get_default_cpu_node_id;

Reviewed-by: Thomas Huth <thuth@redhat.com>



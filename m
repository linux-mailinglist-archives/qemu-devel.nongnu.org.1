Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 069BA70F17B
	for <lists+qemu-devel@lfdr.de>; Wed, 24 May 2023 10:52:50 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q1kEB-0006zW-N3; Wed, 24 May 2023 04:52:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1q1kE6-0006zH-9N
 for qemu-devel@nongnu.org; Wed, 24 May 2023 04:52:10 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1q1kDs-0003XJ-EW
 for qemu-devel@nongnu.org; Wed, 24 May 2023 04:52:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1684918315;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=l8doqJFucJygx1DAUBs42oslGuibioM5nA5nbvNdNto=;
 b=fzO8dOYiYGpEAtl14YLglHa+52IRWwLRZ3E+JR7MIFWwEdd71gqMRkweD3iy/PGbILawE0
 NghD3zwawU16PYbke0LBCLPCTDMOkI7Xe5UsP1D/eKWCwI3A6slsWihRfyre06SrFc4Htc
 JIvC+bzEVwtxLPGp6ahd1UZhComUwYE=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-223-a-vB3TafOf6_LEJieCOSPQ-1; Wed, 24 May 2023 04:51:53 -0400
X-MC-Unique: a-vB3TafOf6_LEJieCOSPQ-1
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-3f60536450eso4285705e9.1
 for <qemu-devel@nongnu.org>; Wed, 24 May 2023 01:51:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684918312; x=1687510312;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=l8doqJFucJygx1DAUBs42oslGuibioM5nA5nbvNdNto=;
 b=f/W4qqLjUTvb5n/WFGdV3YKIJIB6MlAZ99gGvyVf1i5Wz2ieDBG/xA6emsZ1H8BuPh
 tTVgyctlEw6fxqxf/RKDKdFcGtwFgPzt77/OoeRRA2Cg/RmueUA2P5ADhnzT0/6PPBaQ
 eN4qYAdYEdcr1wub4d9pTyisyMTGI2yKeWUIbwobPolDl8vyK9Advm6yyh6RVm+sTdqe
 hGZARtzD1g+Ds1S0zPOTYS0OhbzNkOnw9iIEgCqNOQTrwkp3aJ3ciGecaI/ivAW/5XNM
 vDSwTdmPz37YhMEhqoMkPec2uN1leLLAFxtH7truGykiIrllVFAaXc2ewGFWnCvLTlDA
 a9WA==
X-Gm-Message-State: AC+VfDwax6++H2NzhhwXGEUQChv+DaUCIZjDlGfhEgL/SG4uTnMksofK
 oA4ePJua7BMaA9QzV8d20obz8hNuI7gYv5dLaF0YV3qM1rnxf6wXZEmXfSOWwK8Jr8eFuxKWaws
 KgO3xrqeg1Rx7/cE8kq9nQuk=
X-Received: by 2002:a05:600c:364b:b0:3f6:c7b:d3c8 with SMTP id
 y11-20020a05600c364b00b003f60c7bd3c8mr3580151wmq.16.1684918312782; 
 Wed, 24 May 2023 01:51:52 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ5pQtM54j5YhHwPUs0AkhseMIfb+TlTJIsZSIeZiG8asi/YBL1tWaj9uKQCkGp1jl9RR9RM5g==
X-Received: by 2002:a05:600c:364b:b0:3f6:c7b:d3c8 with SMTP id
 y11-20020a05600c364b00b003f60c7bd3c8mr3580133wmq.16.1684918312541; 
 Wed, 24 May 2023 01:51:52 -0700 (PDT)
Received: from [192.168.0.3] (ip-109-43-176-64.web.vodafone.de.
 [109.43.176.64]) by smtp.gmail.com with ESMTPSA id
 f4-20020a1cc904000000b003f423508c6bsm1525818wmb.44.2023.05.24.01.51.51
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 24 May 2023 01:51:52 -0700 (PDT)
Message-ID: <f640fc7d-47b6-b833-16f6-14e29e09d433@redhat.com>
Date: Wed, 24 May 2023 10:51:50 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH 1/3] hw/arm/sbsa-ref: honor "-vga none" argument
Content-Language: en-US
To: 20230524082037.1620952-1-thuth@redhat.com, qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, Leif Lindholm <quic_llindhol@quicinc.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>
References: <e682f6d5-acbe-7910-54ef-4d75c88a3d28@redhat.com>
 <20230524083913.696175-1-marcin.juszkiewicz@linaro.org>
From: Thomas Huth <thuth@redhat.com>
In-Reply-To: <20230524083913.696175-1-marcin.juszkiewicz@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.089, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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
> In case someone wants to run without graphics card.
> 
> Signed-off-by: Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>
> ---
>   hw/arm/sbsa-ref.c | 4 +++-
>   1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/hw/arm/sbsa-ref.c b/hw/arm/sbsa-ref.c
> index 9c3e670ec6..c540b2f1ba 100644
> --- a/hw/arm/sbsa-ref.c
> +++ b/hw/arm/sbsa-ref.c
> @@ -649,7 +649,9 @@ static void create_pcie(SBSAMachineState *sms)
>           }
>       }
>   
> -    pci_create_simple(pci->bus, -1, "bochs-display");
> +    if (vga_interface_type != VGA_NONE) {
> +        pci_create_simple(pci->bus, -1, "bochs-display");
> +    }
>   
>       create_smmu(sms, pci->bus);
>   }

Reviewed-by: Thomas Huth <thuth@redhat.com>



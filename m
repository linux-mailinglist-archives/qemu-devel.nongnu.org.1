Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4655C7F367F
	for <lists+qemu-devel@lfdr.de>; Tue, 21 Nov 2023 19:51:33 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r5Vpc-0001PX-RU; Tue, 21 Nov 2023 13:50:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1r5Vpb-0001P9-1B
 for qemu-devel@nongnu.org; Tue, 21 Nov 2023 13:50:43 -0500
Received: from mail-ot1-x332.google.com ([2607:f8b0:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1r5VpZ-0007Xu-Kb
 for qemu-devel@nongnu.org; Tue, 21 Nov 2023 13:50:42 -0500
Received: by mail-ot1-x332.google.com with SMTP id
 46e09a7af769-6ce2c71c61fso3139846a34.1
 for <qemu-devel@nongnu.org>; Tue, 21 Nov 2023 10:50:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1700592640; x=1701197440; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=lNnPXcYVLt7Wr01bAS2uF3p1vIC/3B/3HyaD/sLeMK8=;
 b=O7aum+VJ13oxb6+gEPzA42By4mflD3UaFgRZkLFa4WRo5smJqMZxkVhDULvHB12RQm
 oyVuRORhfhSY//RV9Qz3Mri6z8BUzBJhyazB2VuZLKkIRZcvUWogFcGDBoOP/3zhJmfe
 qOOKegAOvdevMNXdQ3bAXL9dw/SVNGJsfkvKBLhUDAHUa49ub/RnYdCWyda/7ejQiSOC
 P3onN4/DVCN/mIAApxrqanwp17o+v8CFoxQOdYF+mJNd/DnWVIl/Dfp0zBCCVfkVyZac
 c5TrpndQYZQ3Vd7Eq4CY6GJLWI+CL95mNKmvWIvvy6FHenQnW1BChrEM6+npYV2gNP6R
 csMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700592640; x=1701197440;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=lNnPXcYVLt7Wr01bAS2uF3p1vIC/3B/3HyaD/sLeMK8=;
 b=jsAduqsAyBOiS76D+hkIZ9UVR5xiVnelYuKLUjfBOU4v4qHrPrPZNJYGPVWFrcWoT1
 zeRyQYMDrq88okvnMYKDteiah41Yz8Bn0Of6Di+xJF/RAW7f4ccpKu1ghBj/6oJIC6Ej
 COJ0k+xNyjI49QofVPCVK9H48hlHBcCH4AVY2W1KUD3H1EiRMZD4JnSKNo+6LQP9YGKr
 duRSePK7C7zCak1F0kHr9PaA8va3pGWYnrxpqe/ii2XzKx17BL4lNDkqi8OQQoGUaLkK
 qMNBOFpAuXuIMNIT1k2qZuz5A3asIzwmbXVTpAsJ9mqzq5NJ6m++8gOkDrtpKcCDeGQS
 OXsQ==
X-Gm-Message-State: AOJu0YwihWnvxMGdXWH7UZfCdsB/4vzZfmuyHU8omS7Cz7JMnWPQwjGr
 0q8rWLodSul0CW113K2Ix9Pk7A==
X-Google-Smtp-Source: AGHT+IF6VutuJPaNXeFdWJucyN13K5MBEeykXbq9XIAi8xoGvu2seic2d3DFliNufIaO+16bzifMrw==
X-Received: by 2002:a05:6871:459c:b0:1f9:352c:c213 with SMTP id
 nl28-20020a056871459c00b001f9352cc213mr152143oab.37.1700592640206; 
 Tue, 21 Nov 2023 10:50:40 -0800 (PST)
Received: from [172.20.7.39] ([187.217.227.247])
 by smtp.gmail.com with ESMTPSA id
 d14-20020a9d51ce000000b006b9443ce478sm1609593oth.27.2023.11.21.10.50.38
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 21 Nov 2023 10:50:39 -0800 (PST)
Message-ID: <958391d5-b1b5-43bf-b3d1-a6071e77b5cd@linaro.org>
Date: Tue, 21 Nov 2023 12:50:36 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH-for-9.0 04/25] memory: Simplify
 memory_region_init_rom_nomigrate() calls
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: David Hildenbrand <david@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, "Michael S. Tsirkin"
 <mst@redhat.com>, qemu-arm@nongnu.org,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Markus Armbruster <armbru@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>, qemu-ppc@nongnu.org,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>,
 Peter Xu <peterx@redhat.com>
References: <20231120213301.24349-1-philmd@linaro.org>
 <20231120213301.24349-5-philmd@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20231120213301.24349-5-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::332;
 envelope-from=richard.henderson@linaro.org; helo=mail-ot1-x332.google.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

On 11/20/23 15:32, Philippe Mathieu-Daudé wrote:
> Mechanical change using the following coccinelle script:
> 
> @@
> expression mr, owner, arg3, arg4, errp;
> @@
> -   memory_region_init_rom_nomigrate(mr, owner, arg3, arg4, &errp);
>      if (
> -       errp
> +       !memory_region_init_rom_nomigrate(mr, owner, arg3, arg4, &errp)

This coccinelle script doesn't quite match...

> @@ -3628,11 +3628,8 @@ void memory_region_init_rom(MemoryRegion *mr,
>                               Error **errp)
>   {
>       DeviceState *owner_dev;
> -    Error *err = NULL;
>   
> -    memory_region_init_rom_nomigrate(mr, owner, name, size, &err);

... this?

That said, the actual code change is good.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~


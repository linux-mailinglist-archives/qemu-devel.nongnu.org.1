Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 84FEB716F84
	for <lists+qemu-devel@lfdr.de>; Tue, 30 May 2023 23:15:51 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q46gW-0005Gk-Px; Tue, 30 May 2023 17:15:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1q46gM-0005GG-CB
 for qemu-devel@nongnu.org; Tue, 30 May 2023 17:15:06 -0400
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1q46gB-0004HS-3M
 for qemu-devel@nongnu.org; Tue, 30 May 2023 17:15:06 -0400
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-30ad752f433so3362801f8f.3
 for <qemu-devel@nongnu.org>; Tue, 30 May 2023 14:14:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1685481293; x=1688073293;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=gtRVJyUXzFxG1pACXeD3+Nrg2XKdLcVr2u1f15JHk4Y=;
 b=dv5N46gtqMU3slWQFLK9hu9J2bhufFdvnuCEM6LxyLHKL8N1rJIvbd6MMfWV/Jv6PS
 sqbeMjSOtKmxGi72lYWlDvisHn8KjKzRcF1KaasNMM+RRKaHfilpRuacUhcUigySeFeU
 +kyoBpudTc61tYdz2GwuU4PocMrpoglOlU9JCDtgR2GgcPgCMZIuLsd2/ZKhwZQGjmW2
 AgCtGqcjMHK6jYvZWq0CcUzB+qAtRp+bnwdxfHSvLTNVOc17015mHpwKQjptI0LMBijk
 DGAg45nchhPEOVQwiqGdJ/xhxStABSXLzARerjfnx4YDSFfJkvg7pVzrnVBr0yUhu5dP
 1tHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685481293; x=1688073293;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=gtRVJyUXzFxG1pACXeD3+Nrg2XKdLcVr2u1f15JHk4Y=;
 b=f+nySqtU0lGdmFI49ceOb/a4y21MflOXeo9VeIglPiWnN0/DuIyJPaNr6nq5FmRJ8E
 MPFBHbohMQDxqAVB2qrXPRC+kY/dneeyH7z0v97KxqV2ZGcqwMyd0BLmBIYWDX9Nq7sK
 VH7mQfNePcor/11Lu8jgiY6tf19hoq9xuArGTG+Mh5TDin8rucqR3Lt0xaWTScBaGzE0
 BeqEeIYGU7w69W1mViwqtYmZfRX8903jghNokzOZBxcTQl3Ghpyx+npkMGdsNZh/P0oB
 0MQUkrZ+Nt5YVI5ryOeyadJOGkUy2UhQk7qA+hOQjK3TUKNACogR7ywLQHOm3kHYZjRI
 9EWw==
X-Gm-Message-State: AC+VfDzh6X7XomchOWgqB8PpO6illGdNnxMi0nBotuqVdVmLiOyBc+j3
 2CN29qLfelXtG7dyQedA4QpsrA==
X-Google-Smtp-Source: ACHHUZ6MspnMlGSW/lplwkDnZMffaiD6G13Mv6Ex2UdO5krmPV0d4hiaTNPb+RInXxDgzHr8Q7EXJQ==
X-Received: by 2002:adf:f292:0:b0:306:3b39:9a3d with SMTP id
 k18-20020adff292000000b003063b399a3dmr2825475wro.15.1685481293174; 
 Tue, 30 May 2023 14:14:53 -0700 (PDT)
Received: from [192.168.69.115] ([176.176.180.1])
 by smtp.gmail.com with ESMTPSA id
 c17-20020adffb11000000b0030633152664sm4382421wrr.87.2023.05.30.14.14.52
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 30 May 2023 14:14:52 -0700 (PDT)
Message-ID: <5587a39e-1c17-2997-f679-d43a023149c6@linaro.org>
Date: Tue, 30 May 2023 23:14:50 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.11.0
Subject: Re: [PATCH 09/12] m25p80: Introduce an helper to retrieve the
 BlockBackend of a device
Content-Language: en-US
To: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>, qemu-arm@nongnu.org
Cc: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Joel Stanley <joel@jms.id.au>, Andrew Jeffery <andrew@aj.id.au>,
 Alistair Francis <alistair@alistair23.me>
References: <20230508075859.3326566-1-clg@kaod.org>
 <20230508075859.3326566-10-clg@kaod.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230508075859.3326566-10-clg@kaod.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::434;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x434.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.09,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, T_SCC_BODY_TEXT_LINE=-0.01,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

On 8/5/23 09:58, Cédric Le Goater wrote:
> It will help in getting rid of some drive_get(IF_MTD) calls by
> retrieving the BlockBackend directly from the m25p80 device.
> 
> Cc: Alistair Francis <alistair@alistair23.me>
> Signed-off-by: Cédric Le Goater <clg@kaod.org>
> ---
>   include/hw/block/flash.h | 4 ++++
>   hw/block/m25p80.c        | 6 ++++++
>   2 files changed, 10 insertions(+)
> 
> diff --git a/include/hw/block/flash.h b/include/hw/block/flash.h
> index 7198953702..de93756cbe 100644
> --- a/include/hw/block/flash.h
> +++ b/include/hw/block/flash.h
> @@ -76,4 +76,8 @@ uint8_t ecc_digest(ECCState *s, uint8_t sample);
>   void ecc_reset(ECCState *s);
>   extern const VMStateDescription vmstate_ecc_state;
>   
> +/* m25p80.c */
> +
> +BlockBackend *m25p80_get_blk(DeviceState *dev);

- Option 1, declare QOM typedef and use proper type:

   #define TYPE_M25P80 "m25p80-generic"
   OBJECT_DECLARE_TYPE(Flash, M25P80Class, M25P80)

   BlockBackend *m25p80_get_blk(Flash *dev);

- Option 2, preliminary patch renaming 'Flash' type to
'M25P80' then option 1 again

- Option 3: no change.

With the QOM style we try to enforce, I'd go for #2.

Still,
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

>   #endif
> diff --git a/hw/block/m25p80.c b/hw/block/m25p80.c
> index dc5ffbc4ff..afc3fdf4d6 100644
> --- a/hw/block/m25p80.c
> +++ b/hw/block/m25p80.c
> @@ -25,6 +25,7 @@
>   #include "qemu/units.h"
>   #include "sysemu/block-backend.h"
>   #include "hw/block/block.h"
> +#include "hw/block/flash.h"
>   #include "hw/qdev-properties.h"
>   #include "hw/qdev-properties-system.h"
>   #include "hw/ssi/ssi.h"
> @@ -1830,3 +1831,8 @@ static void m25p80_register_types(void)
>   }
>   
>   type_init(m25p80_register_types)
> +
> +BlockBackend *m25p80_get_blk(DeviceState *dev)
> +{
> +    return M25P80(dev)->blk;
> +}



Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C4066AB703F
	for <lists+qemu-devel@lfdr.de>; Wed, 14 May 2025 17:46:14 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uFEIW-0002rH-Ol; Wed, 14 May 2025 11:45:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1uFE6Q-0005aC-Sh
 for qemu-devel@nongnu.org; Wed, 14 May 2025 11:33:07 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1uFE6N-0001D1-Un
 for qemu-devel@nongnu.org; Wed, 14 May 2025 11:33:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1747236779;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=TmdMe2lbnU6i1EE6DgHrHUWFPxIJNIaFivomhQpt0IM=;
 b=EhMitUPtVBcBvM3uoVaM8Spa4BjmkxlRqt/KIn+mlmF69ocXvXP5dQB3/0Td4I/L0H+tAf
 d1FRvGuubbD5h3hC+wt4Q0kmeZpbhI16my0JJzeVZC3g/S7rnBZlV8UbCE7uQKA80dEE2i
 BEzh/u2LjM2G/xj+ayfkyFn79fxSqtI=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-576-5l6z1OJ9N0K7feeirN-KdA-1; Wed, 14 May 2025 11:32:57 -0400
X-MC-Unique: 5l6z1OJ9N0K7feeirN-KdA-1
X-Mimecast-MFC-AGG-ID: 5l6z1OJ9N0K7feeirN-KdA_1747236775
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-3a1f6c5f54cso2219669f8f.3
 for <qemu-devel@nongnu.org>; Wed, 14 May 2025 08:32:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747236775; x=1747841575;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TmdMe2lbnU6i1EE6DgHrHUWFPxIJNIaFivomhQpt0IM=;
 b=SDsiMqfBXa5BgmtTBBaPULwkFbF8umUqLN0DHltNWwjKPSkcgIaaZ9nAKiqTCd8nay
 qKI4/GEESeQI4EtDWTMf1DLEBihxDx6sY6GuWoepcxsGkxCp1w5Fpo/OPpLtJHSOm0ae
 hUsVMASfzL2OFeV27nBAvD0XMPXkJwA37G2HCNTXHIVCa9HTD843/TJpDErvzkFAeX7X
 Ujgtqx4QANgtQWpCn1hmjfV/FH5dc6ovN3oehbnZrf7kiKzoaA5KtgZvDdrHnnJw0jym
 oltwaQH3zsfab5Z7lvkUGDBp9TVYbvOOrqFPW5+kXoi0Lj3zVm+Sa1kjkWuO9KQyG98n
 GEwg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWFoM5UPZFWfCmfJ51LCAhyRh/db11dETBFgoxrkWL/MMlWGvTFTJOO7gYHVaZMesTHtDpXz7ojj8Y7@nongnu.org
X-Gm-Message-State: AOJu0YwL5HcvG44J3rSs83CosnODtVs8TDRHLkOmLAK83i+A3dX3d4Zy
 haXFW8kWm3dRtAemuArmJb4Tsd4ZE0riVdlMFeL9v6k1I90x/oHu/FEJzlme2g2nTGaOaCXlTrW
 5+udCTIes8lsWKikVINW84akG1RdlO69p6OzRJuJXk+ObOkNW8Is/
X-Gm-Gg: ASbGncs8cQhA9lKKEjoERHYBhxGl/JM1VV5IbOVv2G0JSFMs2JIHXVybrx1u+c6NCQ/
 9kGc3fA0rVUqnJ8ywI/esAq+ZH4+M0z91vkUyXPgARX+0j5iWydWs7wcRnGf/zu7Md0c0J37cKV
 qDqgUeRDmNHQQS3lj5mwWvUTz7MN08DA7At7+ZU8UK06ZmtnhcBXdnb8uW5tX+pXfQOvszxGqft
 7Z8jTQLZMhuzOkkWrxJYA6Jt5vUhJ78DhJWVLTazrNuSMEZeGqDdAZmnC9g7phaQcUui9Lg4pHn
 uMLt2KKRT3sxLQ8nXVwaPC+GWiuYpsXXWwViw4BekNFE7sM6zw==
X-Received: by 2002:a5d:5f8e:0:b0:3a1:f535:e9be with SMTP id
 ffacd0b85a97d-3a349694ac7mr3138870f8f.7.1747236775368; 
 Wed, 14 May 2025 08:32:55 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEGJ/di50oiGFbb5Yfh5nlBM7l31mPC2fYyS9Ggs8Y6wQpbeDbP3HBDqHkgY5y+Zs3f7zRl2A==
X-Received: by 2002:a5d:5f8e:0:b0:3a1:f535:e9be with SMTP id
 ffacd0b85a97d-3a349694ac7mr3138838f8f.7.1747236774942; 
 Wed, 14 May 2025 08:32:54 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:9db0:474c:ff43:9f5c?
 ([2a01:e0a:280:24f0:9db0:474c:ff43:9f5c])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-442f3368f2bsm37110115e9.4.2025.05.14.08.32.54
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 14 May 2025 08:32:54 -0700 (PDT)
Message-ID: <fc2da193-dc90-4824-b7de-fc426c38029a@redhat.com>
Date: Wed, 14 May 2025 17:32:53 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/5] hw/arm/fby35: Map BMC memory into system memory
To: Steven Lee <steven_lee@aspeedtech.com>,
 Peter Maydell <peter.maydell@linaro.org>, Troy Lee <leetroy@gmail.com>,
 Jamin Lin <jamin_lin@aspeedtech.com>,
 Andrew Jeffery <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>,
 "open list:ASPEED BMCs" <qemu-arm@nongnu.org>,
 "open list:All patches CC here" <qemu-devel@nongnu.org>
Cc: troy_lee@aspeedtech.com, longzl2@lenovo.com, yunlin.tang@aspeedtech.com
References: <20250514090354.1461717-1-steven_lee@aspeedtech.com>
 <20250514090354.1461717-5-steven_lee@aspeedtech.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <20250514090354.1461717-5-steven_lee@aspeedtech.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -37
X-Spam_score: -3.8
X-Spam_bar: ---
X-Spam_report: (-3.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.686,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 5/14/25 11:03, Steven Lee wrote:
> Add the BMC memory region as a subregion of system_memory so that
> modules relying on system memory can operate correctly.
> 
> Signed-off-by: Steven Lee <steven_lee@aspeedtech.com>


Reviewed-by: Cédric Le Goater <clg@redhat.com>

Thanks,

C.


> ---
>   hw/arm/fby35.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/hw/arm/fby35.c b/hw/arm/fby35.c
> index e123fa69e1..c14fc2efe9 100644
> --- a/hw/arm/fby35.c
> +++ b/hw/arm/fby35.c
> @@ -77,6 +77,7 @@ static void fby35_bmc_init(Fby35State *s)
>   
>       memory_region_init(&s->bmc_memory, OBJECT(&s->bmc), "bmc-memory",
>                          UINT64_MAX);
> +    memory_region_add_subregion(get_system_memory(), 0, &s->bmc_memory);
>       memory_region_init_ram(&s->bmc_dram, OBJECT(&s->bmc), "bmc-dram",
>                              FBY35_BMC_RAM_SIZE, &error_abort);
>   



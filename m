Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 133447E7203
	for <lists+qemu-devel@lfdr.de>; Thu,  9 Nov 2023 20:12:20 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r1AQb-0000ul-Sq; Thu, 09 Nov 2023 14:10:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1r1AQY-0000uP-Q4
 for qemu-devel@nongnu.org; Thu, 09 Nov 2023 14:10:55 -0500
Received: from mail-ed1-x52e.google.com ([2a00:1450:4864:20::52e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1r1AQX-0001s0-DH
 for qemu-devel@nongnu.org; Thu, 09 Nov 2023 14:10:54 -0500
Received: by mail-ed1-x52e.google.com with SMTP id
 4fb4d7f45d1cf-53f9af41444so2067885a12.1
 for <qemu-devel@nongnu.org>; Thu, 09 Nov 2023 11:10:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1699557051; x=1700161851; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=mdoA4bCOHV2xbFNH5vfe2cP2TsA1ItA50LkkszW2hqI=;
 b=iRS3CuV9GNmC6YyIAvgnMy5KcA5u5DMcfbbO1bZgkWURt/erhhwbV3yTMeNmO1+/gI
 YBHelgzomVE7+YSLVCW4nzdZ/anZ4mv88UG+rWKDcBbx0l5xay07q013xIBbZLcrVevg
 vsGw/RaV1eoICL1bdDaFqhYYjlvsXJ36fUJPUr5JgJJVqy7LmVdzXpvL6FZQhYCIWI1S
 T7g6Rlt38F1EM71nYBTWyu9km2KjNu93opsHqwwzPtYa0dlFFLloS3rRO4B/LWL6+ilC
 y6xMVTvRmk3mcN9g+uGI41SD1uNA2kWLEzVwKeitKFw+dc8bD6G7aKz/ZMmqFcs99rQG
 gD3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699557051; x=1700161851;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=mdoA4bCOHV2xbFNH5vfe2cP2TsA1ItA50LkkszW2hqI=;
 b=eu6bHJS3uP0VA3rGi3FIBj77DpUS3xm3c1O336PZU6964i6BE9F9nlO/7r6Ff+Ppw9
 EPu0Qr2XOO/tr0CX8ll3PS/to/P/Rd0svY2odxpL/wX+AwvjGPwBrKrXHQ2KIY7kjtRj
 KHfGORUN+4s19KDxQ9wROtdsMykKJyl3gKLiCv+IeQp6+FbbsAgGBF4Idm1/HhazIbCT
 49uj4vz3imoABYIcqTi8A02axFxOz8+hhygn5te+aqRaWWxoW3BSXpTDjmoA0nkct8Bh
 zUL7IszTNSK5Qyumzc0hWOW3DyuSb0tFu+aPO2kU1d0nR9sZeov2j4SCfIIh5swaa5cP
 +HUQ==
X-Gm-Message-State: AOJu0YxiK+bkaL0srQ7Hq+X8p8TFz6TjlyphCjX3ORUK8ygcUhd9m6LH
 ixFg/NxUwtSVCKIH8H/N/9N+OA==
X-Google-Smtp-Source: AGHT+IGQWLbS6fjT5uskXK5uqeX2dyiUo9uxOjYP+c47qUmCU1v4YNvZ6Y3IS8TXn8wbpntUm+aJhg==
X-Received: by 2002:a50:9508:0:b0:543:8391:a19a with SMTP id
 u8-20020a509508000000b005438391a19amr4551354eda.40.1699557051247; 
 Thu, 09 Nov 2023 11:10:51 -0800 (PST)
Received: from [192.168.69.115] ([176.187.199.161])
 by smtp.gmail.com with ESMTPSA id
 d4-20020a056402516400b0052febc781bfsm166756ede.36.2023.11.09.11.10.50
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 09 Nov 2023 11:10:50 -0800 (PST)
Message-ID: <d66214c1-fea9-418d-8497-4a3f2da1e734@linaro.org>
Date: Thu, 9 Nov 2023 20:10:49 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] include/hw/xen: Use more inclusive language in comment
Content-Language: en-US
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org,
 Stefano Stabellini <sstabellini@kernel.org>,
 Anthony Perard <anthony.perard@citrix.com>, Paul Durrant <paul@xen.org>
Cc: xen-devel@lists.xenproject.org, qemu-trivial@nongnu.org
References: <20231109174034.375392-1-thuth@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20231109174034.375392-1-thuth@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::52e;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x52e.google.com
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

On 9/11/23 18:40, Thomas Huth wrote:
> Let's improve the wording here.
> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>   include/hw/xen/interface/hvm/params.h | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>




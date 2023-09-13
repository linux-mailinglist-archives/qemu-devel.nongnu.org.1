Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 063C979EC42
	for <lists+qemu-devel@lfdr.de>; Wed, 13 Sep 2023 17:14:33 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qgRYv-0000ZS-5x; Wed, 13 Sep 2023 11:13:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qgRYs-0000Uw-Ow
 for qemu-devel@nongnu.org; Wed, 13 Sep 2023 11:13:50 -0400
Received: from mail-ej1-x629.google.com ([2a00:1450:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qgRYq-0007Pm-Ki
 for qemu-devel@nongnu.org; Wed, 13 Sep 2023 11:13:50 -0400
Received: by mail-ej1-x629.google.com with SMTP id
 a640c23a62f3a-9ada609bb62so84546266b.2
 for <qemu-devel@nongnu.org>; Wed, 13 Sep 2023 08:13:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1694618027; x=1695222827; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=YvYHTWcx999MsfcFCfJriQ9qr9KACof4xUlLdYEPfy4=;
 b=Wsk4uitut+dieV/IdSZ8Sg3femy8Z9WBmK2Q19EkW7chLTEuMF43xxpj7fMNn/CF6H
 w1r9DRhdjtXvBWCRRE7uhhOhV6tGWOBmU6kdNqT9Ui+knRssEZXCX5S2cxRlksYS2Uhi
 xx7lB0TtONy8duofCmpXmMBrZpQrj2CUx3DZ16E+XSZSi4QJOGpawtQtItxy3kdNv4vb
 QRhOFXUa7M5EHxLcxe7WCKdbD35YldnDlVXfO5aZjsQMuSLEPrMAUYW1WW3GVy/xBj77
 DydvmIm7gWAqr9GONUGEFLiKKSV9TOEuKF5UbF/sBiJXHCaFere6YM5zEGbIAtgf2dHm
 zJ/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694618027; x=1695222827;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=YvYHTWcx999MsfcFCfJriQ9qr9KACof4xUlLdYEPfy4=;
 b=dwYyRU8Mq/zKmo4uLsU5gLqYP1QuR+g81gKfLwP5P+ILYQ6ltKEnicGhsLW9OFEEQ0
 5HmC9ef9LEgGxe5iQfH7LA0OSWN1dJkRvzcsNc2YcU5BxrYU3+Tflwnhht1j2F7Ne/LR
 tfokOD9TwkJCXfqO3l6D3ETwHKYBRv1qdeaOpObPxoycyJTtxSlPEfVnzGb3KeIiNOpR
 KMCuk6I/4fAwGK9JNHeoFAsWfF+bDGdV2jN/TTMzx8WPRR3yPEB+8FiGtoTL+7oCiZBB
 BZsS/aPKr3Uxlur/Qqwq/OZKc8fwTqhU2wcXW8H2uo5TLWU5maxQZOWnsQe5mSyARwkY
 mp1g==
X-Gm-Message-State: AOJu0YzDOQzb/2LBpSmI/1yI+UAUX14IXyIiE2KePKvLuvEqUi+SA97L
 Do7t8ZJPjty9gJYeg04qPp1ewA==
X-Google-Smtp-Source: AGHT+IEuhKJyE6/ipLZYRqCIaR0EovNBgFsVDCTKsiam5aGU+52ijtIq/FQZdIzey4ZaZZ7opXoKJQ==
X-Received: by 2002:a17:907:762f:b0:9a9:fb1c:34ff with SMTP id
 jy15-20020a170907762f00b009a9fb1c34ffmr2183281ejc.73.1694618027013; 
 Wed, 13 Sep 2023 08:13:47 -0700 (PDT)
Received: from [192.168.69.115] (176-131-211-241.abo.bbox.fr.
 [176.131.211.241]) by smtp.gmail.com with ESMTPSA id
 x24-20020a170906805800b009a198078c53sm8521282ejw.214.2023.09.13.08.13.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 13 Sep 2023 08:13:46 -0700 (PDT)
Message-ID: <2f58db7b-4328-5950-34a3-cefdf4c594c3@linaro.org>
Date: Wed, 13 Sep 2023 17:13:45 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.0
Subject: Re: [PATCH 1/4] hw/cxl: Use a switch to explicitly check size in
 caps_reg_read()
Content-Language: en-US
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>, qemu-devel@nongnu.org,
 Michael Tsirkin <mst@redhat.com>, Fan Ni <fan.ni@samsung.com>
Cc: linuxarm@huawei.com
References: <20230913150521.30035-1-Jonathan.Cameron@huawei.com>
 <20230913150521.30035-2-Jonathan.Cameron@huawei.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230913150521.30035-2-Jonathan.Cameron@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::629;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x629.google.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-1.473,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 13/9/23 17:05, Jonathan Cameron wrote:
> Bring this read function inline with the others that do
> check for unexpected size values.
> 
> Also reduces line lengths to sub 80 chars.
> 
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> ---
>   hw/cxl/cxl-device-utils.c | 11 +++++++----
>   1 file changed, 7 insertions(+), 4 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>



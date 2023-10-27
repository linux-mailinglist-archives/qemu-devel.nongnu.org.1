Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A108F7D9454
	for <lists+qemu-devel@lfdr.de>; Fri, 27 Oct 2023 11:56:15 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qwJYp-0000co-Lh; Fri, 27 Oct 2023 05:55:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qwJYd-0000cT-BT
 for qemu-devel@nongnu.org; Fri, 27 Oct 2023 05:55:12 -0400
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qwJYY-0007Tr-0F
 for qemu-devel@nongnu.org; Fri, 27 Oct 2023 05:55:11 -0400
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-40838915cecso15014575e9.2
 for <qemu-devel@nongnu.org>; Fri, 27 Oct 2023 02:55:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698400503; x=1699005303; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=lmrx3N8BQfY5cIOwVkYnGDdfaIk0C8Bhjm/IN+yamc0=;
 b=FqYD3kb1Rk5/hUkhjBEArqvARIT01mQjcNjQY8vo+c5iH+79+ClxAHHG8mHfspvnk8
 1zM34V5AvKKBeORg6xV8ycTCn6rOQbo1mlwYwnSY0MuMvN3V3d6PwHikEychBKXkrBML
 7DkjRBVYmSDApO54jUAL2SUzsjBOunEHjKOSEU8hjjj2+mzCfB7bUXYrLRr2CJb6HeEI
 BvfdQhgbl/2knx5BQsrrbUGZiXphurNq5ATL53jCJajeXjA2XB2wlw4okxx6BAE8FxoL
 2ViABmo/OB0OaYh0WtbqwtPVnBj6PB4BHGIw3v2bidB/kz24hzQ6lJBTiW5YBKeLvp3m
 XZhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698400503; x=1699005303;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=lmrx3N8BQfY5cIOwVkYnGDdfaIk0C8Bhjm/IN+yamc0=;
 b=ZIS3L+KQWh0sId7Ra1e06fK4mVT3rJ4JOlLcj1+1KmnSn2ZJYXFjdX2egVzUQWbXpL
 xVJc06HKS2GqXTsVGK4RgX71lvVo98OzWn2uEIOSwJVXlsNuPJIBXpU8huOE/SSWTDtc
 gJIS1MSTyMZ8z6V9NZ/tARqwZoGVzfp22eAddoenZtnz4pN6fGQmu+tbKsUYqEGmPVYm
 d7yX3MGj79he7559HTcUBFLZezKQl1yhj/N28frOufMSyZw0648jwScin7V0kzzRMn8q
 BxzbvrYdKsb/CHuBqtpP0MzVXOaWSF4SVNicFtpshwTOs1r0txPknEtmYhIUNv0CAzNv
 4cNQ==
X-Gm-Message-State: AOJu0YwjZ+kl80fpDxhN2bSx7lFW8vOCMw1XIvjzVvYPsO6P7ejwZIAn
 8gxCm9CELKPHoi5ZUqP2XEs5z/+asXnMd3XqyBk=
X-Google-Smtp-Source: AGHT+IGJYLOKle8Z13RfAI2jh8tIdAuO122bg+da/6JqPctvVFuSVTA6rKbuX/wnTkca283M6T5tyg==
X-Received: by 2002:a05:600c:3c81:b0:401:bcd9:4871 with SMTP id
 bg1-20020a05600c3c8100b00401bcd94871mr2118505wmb.21.1698400503605; 
 Fri, 27 Oct 2023 02:55:03 -0700 (PDT)
Received: from [192.168.69.115] ([176.171.220.131])
 by smtp.gmail.com with ESMTPSA id
 p21-20020a05600c431500b003fe61c33df5sm4636057wme.3.2023.10.27.02.55.02
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 27 Oct 2023 02:55:03 -0700 (PDT)
Message-ID: <ea963d50-b0a6-d973-6b66-bbb58068d3f8@linaro.org>
Date: Fri, 27 Oct 2023 11:55:00 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.1
Subject: Re: [PATCH] MAINTAINERS: Add the can documenation file to the CAN
 section
Content-Language: en-US
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org,
 Pavel Pisa <pisa@cmp.felk.cvut.cz>, Vikram Garhwal <fnu.vikram@xilinx.com>
Cc: qemu-trivial@nongnu.org
References: <20231027060931.242491-1-thuth@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20231027060931.242491-1-thuth@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x333.google.com
X-Spam_score_int: -53
X-Spam_score: -5.4
X-Spam_bar: -----
X-Spam_report: (-5.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-3.339,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

On 27/10/23 08:09, Thomas Huth wrote:
> Add can.rst to the corresponding section in MAINTAINERS, so that
> the maintainers get CC:-ed on corresponding patches.
> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>   MAINTAINERS | 1 +
>   1 file changed, 1 insertion(+)

Since I'm preparing a PR, I'm queuing this patch using
"Add the CAN documentation file to the CAN section​" as
subject.

Thanks!


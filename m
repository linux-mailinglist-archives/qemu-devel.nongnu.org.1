Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 24EC47D99E8
	for <lists+qemu-devel@lfdr.de>; Fri, 27 Oct 2023 15:34:30 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qwMyB-000169-Hv; Fri, 27 Oct 2023 09:33:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qwMy7-000158-ON
 for qemu-devel@nongnu.org; Fri, 27 Oct 2023 09:33:43 -0400
Received: from mail-ej1-x632.google.com ([2a00:1450:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qwMy6-0005us-8C
 for qemu-devel@nongnu.org; Fri, 27 Oct 2023 09:33:43 -0400
Received: by mail-ej1-x632.google.com with SMTP id
 a640c23a62f3a-9c2a0725825so335116166b.2
 for <qemu-devel@nongnu.org>; Fri, 27 Oct 2023 06:33:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698413620; x=1699018420; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Bt1hJxIpz0b4+/7Z1+AD1h+KdMZIZu3N9EF51ynddmY=;
 b=GNAnCLSmrobe53gYOVSwSnbPYK0HcsZ9z7AgcYQOP+7rn5mdnfaqfUJvyJXPElAtqh
 5qQLMmgYv+oJgtANYIywKrS0yN+5yXbApPXm7eT/Z/XC6LiPbGu7zW0wwHyGJYyWlJsm
 DsnJyjvjZb81FPIhXZPM9Mk8BDM/7a2y8GPMGC4UZFtzcL0KtgVJ9xx8xe5dixl17Gcb
 /fR7Tv1nuzXro0CjTyjpLIquBR4EnjVyr+7/R+nzn5O/tYrfSvO/V6BO60rEiPjDZCtJ
 pEwHAUY9p8WmTnSx19qgkegf+wII9Ks6BROy3a+yMyzl0cr3InaxDEljcDsjBi8afPOb
 llOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698413620; x=1699018420;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Bt1hJxIpz0b4+/7Z1+AD1h+KdMZIZu3N9EF51ynddmY=;
 b=rzvu5zNlXoMEP9g8AzwIzpDMCzuEh4IUMeNxdwhcrCNMDX3/19HiVoIFmJJ7nWMGMI
 eiPDm9zZEZUh1gtRIk2MlRBd3maslPsso9M8EmI2NBeqPS3KQrkr6ojgON2FW1BWMoBU
 bQ40+98108wKyXYFDYyIKb2J187yguNeIv657wvoxHvOngOkUH36nKcJhtJDIOUFW5nT
 hi+6tHt8GPy5zwyI1mAuTbIHqUJkIc5GVDhQXNmnSd33YthxpYaD4V6Rj/Z76KoLl9n7
 zExTwqXJG2rLoATXf/XxMUhOE4Hs/5GoKobGjLqqdwu2WI4sE+Iwl2BtE1dFJZ715SsE
 oMcw==
X-Gm-Message-State: AOJu0YxKUORRXSuJm56hgi1LeO79IeBrO0fZW/NLZCUcw2XDD0cVcVE1
 q6ALbDeo+S9MB3SoKEVCB9MHOw==
X-Google-Smtp-Source: AGHT+IGJNVbBJ3Kr3OydVspWa3XdUwAWSeQGQyTbeRkveHae8m8sj2dY6CgqJPKEAXI6BqaKvNJA8w==
X-Received: by 2002:a17:907:d19:b0:9bf:5df1:38d2 with SMTP id
 gn25-20020a1709070d1900b009bf5df138d2mr2044776ejc.3.1698413620412; 
 Fri, 27 Oct 2023 06:33:40 -0700 (PDT)
Received: from [192.168.69.115] ([176.171.220.131])
 by smtp.gmail.com with ESMTPSA id
 p7-20020a170906228700b0099bd5d28dc4sm1205406eja.195.2023.10.27.06.33.38
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 27 Oct 2023 06:33:40 -0700 (PDT)
Message-ID: <7f20a803-db3a-fd4a-bd43-04b21db1c14e@linaro.org>
Date: Fri, 27 Oct 2023 15:33:37 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.1
Subject: Re: [PATCH v2 RESEND] misc/led: LED state is set opposite of what is
 expected
Content-Language: en-US
To: Peter Maydell <peter.maydell@linaro.org>,
 Glenn Miles <milesg@linux.vnet.ibm.com>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, clg@kaod.org,
 andrew@codeconstruct.com.au, joel@jms.id.au
References: <20231024191945.4135036-1-milesg@linux.vnet.ibm.com>
 <CAFEAcA8N7nUmoQHkhSFdVG+3amkW6N=jsVq8BqkfQAzygY_4yQ@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <CAFEAcA8N7nUmoQHkhSFdVG+3amkW6N=jsVq8BqkfQAzygY_4yQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::632;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x632.google.com
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

On 27/10/23 13:51, Peter Maydell wrote:
> On Tue, 24 Oct 2023 at 20:20, Glenn Miles <milesg@linux.vnet.ibm.com> wrote:
>>
>> Testing of the LED state showed that when the LED polarity was
>> set to GPIO_POLARITY_ACTIVE_LOW and a low logic value was set on
>> the input GPIO of the LED, the LED was being turn off when it was
>> expected to be turned on.
>>
>> Signed-off-by: Glenn Miles <milesg@linux.vnet.ibm.com>
>> ---
> 
> 
> 
> Applied to target-arm.next, thanks.

Sorry I'm still catching up.

Fixes: ddb67f6402 ("hw/misc/led: Allow connecting from GPIO output")
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>



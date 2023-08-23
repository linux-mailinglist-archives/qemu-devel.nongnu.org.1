Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 12D8778581F
	for <lists+qemu-devel@lfdr.de>; Wed, 23 Aug 2023 14:54:19 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qYnMG-0007rC-8b; Wed, 23 Aug 2023 08:53:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qYnLx-0007o1-7J
 for qemu-devel@nongnu.org; Wed, 23 Aug 2023 08:52:53 -0400
Received: from mail-ej1-x62b.google.com ([2a00:1450:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qYnLu-00082P-HU
 for qemu-devel@nongnu.org; Wed, 23 Aug 2023 08:52:52 -0400
Received: by mail-ej1-x62b.google.com with SMTP id
 a640c23a62f3a-9a1681fa868so676290366b.3
 for <qemu-devel@nongnu.org>; Wed, 23 Aug 2023 05:52:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1692795166; x=1693399966;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=5pLzxd8K+GCnDEep44EBtLu09X7evyoVuRH/YH/BDGM=;
 b=jdjqsXYsrXpGQ+v62mGZhtL2OvedsUZQseJqwdepOLZStjrgoGRgMGTfAqFHXT5kv4
 L+aHJJKLU0w1D0wBiwZ2Y2yMokywSY0XLJ2R5a+de2h83n8otBfQLGsdyhU9AQDovSAU
 +pEXO5pz+X2Ry3rJWVEstsf1HdWj1wwbZIgV2iJEp2KBuSIdSQuKEDIdQbtW1MGqrUAv
 uzztnxC21tn5iEhYFN7vDyK23WVVldmVpYZee6bU3uaLAv70BwizK4Udwoqf4j0pGEFS
 wUAD+Sx89x+ydRqG+QDjts8GHTGjwqsbGeyfz4/7PEqMtaqzt42P/N2wTyzSTyAyg+YU
 cjlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692795166; x=1693399966;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=5pLzxd8K+GCnDEep44EBtLu09X7evyoVuRH/YH/BDGM=;
 b=CttRAB2zHEU3aDgrC2bKgI6kz+1M3R959N5lFlGUkVD4EDF+4XWDTr4qbqZDEWQUiS
 pZFNuYpOuTr9kQEtR/gBhS1ehcSPy0Pzw2vTQ4rnvbPV6c3w7V2IO9vtULTz9qSznW+a
 sweeGA+7xpJ2Iv/vnPqzwYPEIu2tkAO2znPMx+ko/1KFQAp+AF61ZSfgkZhPsH2xJqaQ
 US29tdicLi0xoHDHY/qw9rU6cBd7XgtgX5cpCZenC4Oj46SUNVFQIbIWp/d+tH0FIQ+7
 qVq7lUMZTXmME47mP76aGLYNlwjBYWupDQPZQes8qbjWb0DCVNR4DqnGYxRA0wxOQCh6
 OSHA==
X-Gm-Message-State: AOJu0YzjkfiQonOeggcaoxTzbnrq1k5PCJOzSdQVA+1GoixjHVh1mKqU
 uujdRiuPA3UGmNtO2f+3fV17vA==
X-Google-Smtp-Source: AGHT+IF1PhVp+ZE/I7I4YRlhNWc/eR8tiSREcrCjq62qDJPBPcE7oEbiBeb1FEKm0zq1fm+ghIBy6Q==
X-Received: by 2002:a17:906:2d1:b0:991:d5ad:f1b1 with SMTP id
 17-20020a17090602d100b00991d5adf1b1mr11521648ejk.47.1692795166168; 
 Wed, 23 Aug 2023 05:52:46 -0700 (PDT)
Received: from [192.168.69.115] (gsv95-h03-176-172-10-165.dsl.sta.abo.bbox.fr.
 [176.172.10.165]) by smtp.gmail.com with ESMTPSA id
 w20-20020a17090652d400b009a1e73f2b4bsm563182ejn.48.2023.08.23.05.52.44
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 23 Aug 2023 05:52:45 -0700 (PDT)
Message-ID: <6448371b-9015-7aef-c833-ec6128b80606@linaro.org>
Date: Wed, 23 Aug 2023 14:52:43 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.14.0
Subject: Re: [PATCH 2/2] hw/misc/Kconfig: add switch for i2c-echo
Content-Language: en-US
To: Klaus Jensen <its@irrelevant.dk>, Thomas Huth <thuth@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>, Joel Stanley <joel@jms.id.au>,
 Andrew Jeffery <andrew@aj.id.au>, =?UTF-8?Q?C=c3=a9dric_Le_Goater?=
 <clg@kaod.org>, Klaus Jensen <k.jensen@samsung.com>
References: <20230823-i2c-echo-fixes-v1-0-ccc05a6028f0@samsung.com>
 <20230823-i2c-echo-fixes-v1-2-ccc05a6028f0@samsung.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230823-i2c-echo-fixes-v1-2-ccc05a6028f0@samsung.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62b;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x62b.google.com
X-Spam_score_int: -47
X-Spam_score: -4.8
X-Spam_bar: ----
X-Spam_report: (-4.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-2.684,
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

On 23/8/23 10:14, Klaus Jensen wrote:
> From: Klaus Jensen <k.jensen@samsung.com>
> 
> Associate i2c-echo with TEST_DEVICES and add a dependency on I2C.
> 
> Signed-off-by: Klaus Jensen <k.jensen@samsung.com>
> ---
>   hw/misc/Kconfig     | 5 +++++
>   hw/misc/meson.build | 2 +-
>   2 files changed, 6 insertions(+), 1 deletion(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>



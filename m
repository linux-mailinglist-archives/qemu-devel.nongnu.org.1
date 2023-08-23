Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A73F8785820
	for <lists+qemu-devel@lfdr.de>; Wed, 23 Aug 2023 14:54:19 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qYnMo-000886-80; Wed, 23 Aug 2023 08:53:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qYnMg-000851-6y
 for qemu-devel@nongnu.org; Wed, 23 Aug 2023 08:53:38 -0400
Received: from mail-ed1-x531.google.com ([2a00:1450:4864:20::531])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qYnMe-00088E-LX
 for qemu-devel@nongnu.org; Wed, 23 Aug 2023 08:53:37 -0400
Received: by mail-ed1-x531.google.com with SMTP id
 4fb4d7f45d1cf-52580a24128so7039614a12.2
 for <qemu-devel@nongnu.org>; Wed, 23 Aug 2023 05:53:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1692795214; x=1693400014;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=BqqEIeZ2vmwUfJOKOf7ZL8qN4VDSqt2WuqOrqKufJZA=;
 b=ilgDcG4+paDGxd7ndZGTbo3INbxDDRKJZmIN5SKRYz3JT8yHSWc1Z+TcHWrfnoK5zo
 KmdHS1GMjRSVvCXaLdH/mt/8YSkcpi3kuHes3fe7/9z2uRJV86mULHhuzsO/QtLoeOyt
 2nfUg4evpvudrqLg+MP2CKTSHQp3JaUlNsfMJCVq3E0XAeNRqpuoG/C+y6rbaYcT7NoF
 hUSvk9DZ/tTPOISA/5zojmF73RSk7eFqCyf15ZvgNzgseeV+ebQW1ONF7ORbg1ENEj41
 LuTkv82LkMvQU9YajA3SWxOELXy3GZJwBqFHyYwA8Q1WxrZjP9703GyWF/aOG3QnRz4p
 3IdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692795214; x=1693400014;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=BqqEIeZ2vmwUfJOKOf7ZL8qN4VDSqt2WuqOrqKufJZA=;
 b=cZqY+2tYLf50x0EBbP4U81S/NaA5AE97OTHS+XFhawFAMjCYNhSGFNueu+wrnB8SfR
 GFcJXuB7Ak5Y8cbgPKZAZx2jRxWKZfT/Z6uqtC1eiwWNrYcRf2dkDuFTT1+/9zjl/iqw
 6L45JWd97JtQCO5WBhVbgI9cHkSx5dGeF7SdFNjoloEeIZQ1a/5eZjdRjN9LPxarjk6Y
 qsZMvHprRZhjwtsDlFsFmzR7x50QkT+jQgXVRdM2DqSxx7NVxjXh5dhCzep9L48ExqUO
 FDHrnzJC3bTtcp115Yv9CgRu+nD+ojA6b5YtcbHvEk5I1u7F+rf8pd1zMzOvjp6Pnwpr
 CyfA==
X-Gm-Message-State: AOJu0YwHa3ql+iipXVwExLqTBcPyirfirqit66WvwCzAOWSwaJDYc08b
 vveyNQPR4fEChXvtmhiLmHGypg==
X-Google-Smtp-Source: AGHT+IH935U95528jJa0kgB8aogka0kE9UE/jUrvPUuQR4eP6qCXxiLduSuhh8APoT0fZZ3MG5Exdg==
X-Received: by 2002:a05:6402:330:b0:522:3855:7ec5 with SMTP id
 q16-20020a056402033000b0052238557ec5mr10590458edw.10.1692795214542; 
 Wed, 23 Aug 2023 05:53:34 -0700 (PDT)
Received: from [192.168.69.115] (gsv95-h03-176-172-10-165.dsl.sta.abo.bbox.fr.
 [176.172.10.165]) by smtp.gmail.com with ESMTPSA id
 l2-20020aa7cac2000000b0052239012c65sm9300054edt.82.2023.08.23.05.53.33
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 23 Aug 2023 05:53:34 -0700 (PDT)
Message-ID: <6679fdc3-c0aa-734a-44c3-d7b7c1fb5313@linaro.org>
Date: Wed, 23 Aug 2023 14:53:32 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.14.0
Subject: Re: [PATCH v2 2/2] hw/misc/Kconfig: add switch for i2c-echo
Content-Language: en-US
To: Klaus Jensen <its@irrelevant.dk>, Thomas Huth <thuth@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>, Joel Stanley <joel@jms.id.au>,
 Andrew Jeffery <andrew@aj.id.au>, =?UTF-8?Q?C=c3=a9dric_Le_Goater?=
 <clg@kaod.org>, Klaus Jensen <k.jensen@samsung.com>
References: <20230823-i2c-echo-fixes-v2-0-ff404db1bf99@samsung.com>
 <20230823-i2c-echo-fixes-v2-2-ff404db1bf99@samsung.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230823-i2c-echo-fixes-v2-2-ff404db1bf99@samsung.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::531;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x531.google.com
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

On 23/8/23 11:01, Klaus Jensen wrote:
> From: Klaus Jensen <k.jensen@samsung.com>
> 
> Associate i2c-echo with TEST_DEVICES and add a dependency on I2C.
> 
> Reviewed-by: Thomas Huth <thuth@redhat.com>
> Signed-off-by: Klaus Jensen <k.jensen@samsung.com>
> ---
>   hw/misc/Kconfig     | 5 +++++
>   hw/misc/meson.build | 2 +-
>   2 files changed, 6 insertions(+), 1 deletion(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>



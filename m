Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 90A9178531D
	for <lists+qemu-devel@lfdr.de>; Wed, 23 Aug 2023 10:53:42 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qYjcF-0002zd-5L; Wed, 23 Aug 2023 04:53:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qYjcB-0002zV-BL
 for qemu-devel@nongnu.org; Wed, 23 Aug 2023 04:53:23 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qYjc9-0007oX-UL
 for qemu-devel@nongnu.org; Wed, 23 Aug 2023 04:53:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1692780801;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=UEoDQftqse0NLmJnTqpHR9oaXPvrdp2sp0fBKDc6qLM=;
 b=gCNilJ1bgK3FFSx/aLomu6ZSBzxzdb8B1CAfKj6srzGm0/aVb9W3hriU1OdyJwr1T98LgT
 Q+BT74SYOlqPmUlMtvh/RYuARSiv+0b5N688G2oV0EOg52U8nfvO8sFNj0kQaa92+d4E6N
 DcQjrTAhfqqKJwkboYbwDJy65zg/VEc=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-97-CVSuwYy1N8S0KT4i5yrZGA-1; Wed, 23 Aug 2023 04:53:19 -0400
X-MC-Unique: CVSuwYy1N8S0KT4i5yrZGA-1
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-3fef2dde99dso19110655e9.3
 for <qemu-devel@nongnu.org>; Wed, 23 Aug 2023 01:53:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692780798; x=1693385598;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=UEoDQftqse0NLmJnTqpHR9oaXPvrdp2sp0fBKDc6qLM=;
 b=Ck38w3dGCA9XRYjTVX3cJxUW+iDZBkP11UDa2PUt6J0iW0RJSR5NGhRkBmTqE90iWh
 hr6Oxm5lp2pouaOj3M6/syuBwjNYnDtGPqY+FRuOfy8SFbFDsr0nZVfGJ0p0pU4IAzYV
 QFraAFPwhkwEmFUdUALXgOVSBDIk2xFj3rVVwRUKwHzOiIvwP09MuDp6uyHfDA/MGETO
 YWskm/FRJlWDgbEvL1nN5Vqnknb+y6GdjEe6Q6mjL+kTI5HJbDSNv1r/Gn1Y4O8IrKew
 fts1N2iFL7NmISVFYqbxtG8qsmBv0p/VLcrYSGm7q5SiW3jO/ThKY9aBNMpJhA2qLBlK
 sdaw==
X-Gm-Message-State: AOJu0YwoDY273lLatOpSle06VAFv2TrLp7j+mZiVKgq/K/W4x3ch0u/H
 8Zw3Q5hDUT82X9KWxYK3VI0xco1eq5njav+Xwr/O5Dk3InuYhtE6c+vielppiC/6g7EPu+MKiZ7
 r0gseubGoJzF9dgU=
X-Received: by 2002:a1c:7205:0:b0:3fc:5606:c243 with SMTP id
 n5-20020a1c7205000000b003fc5606c243mr9115192wmc.13.1692780798538; 
 Wed, 23 Aug 2023 01:53:18 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE+SxuTWJhKtJrewErwTiIj1DlDBMPoTERiqXB0snChKZfQtW391Q7kBJHvZwCc+2kFS3zLlA==
X-Received: by 2002:a1c:7205:0:b0:3fc:5606:c243 with SMTP id
 n5-20020a1c7205000000b003fc5606c243mr9115176wmc.13.1692780797914; 
 Wed, 23 Aug 2023 01:53:17 -0700 (PDT)
Received: from [192.168.0.5] (ip-109-43-177-178.web.vodafone.de.
 [109.43.177.178]) by smtp.gmail.com with ESMTPSA id
 o18-20020a05600c379200b003fc01189b0dsm17919757wmr.42.2023.08.23.01.53.16
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 23 Aug 2023 01:53:17 -0700 (PDT)
Message-ID: <70d55793-aad1-84b7-c6f2-bc8b40d33900@redhat.com>
Date: Wed, 23 Aug 2023 10:53:15 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 2/2] hw/misc/Kconfig: add switch for i2c-echo
Content-Language: en-US
To: Klaus Jensen <its@irrelevant.dk>
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>, Joel Stanley <joel@jms.id.au>,
 Andrew Jeffery <andrew@aj.id.au>, =?UTF-8?Q?C=c3=a9dric_Le_Goater?=
 <clg@kaod.org>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>,
 Klaus Jensen <k.jensen@samsung.com>
References: <20230823-i2c-echo-fixes-v1-0-ccc05a6028f0@samsung.com>
 <20230823-i2c-echo-fixes-v1-2-ccc05a6028f0@samsung.com>
From: Thomas Huth <thuth@redhat.com>
In-Reply-To: <20230823-i2c-echo-fixes-v1-2-ccc05a6028f0@samsung.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -4
X-Spam_score: -0.5
X-Spam_bar: /
X-Spam_report: (-0.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-1.767, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On 23/08/2023 10.14, Klaus Jensen wrote:
> From: Klaus Jensen <k.jensen@samsung.com>
> 
> Associate i2c-echo with TEST_DEVICES and add a dependency on I2C.
> 
> Signed-off-by: Klaus Jensen <k.jensen@samsung.com>
> ---
>   hw/misc/Kconfig     | 5 +++++
>   hw/misc/meson.build | 2 +-
>   2 files changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/hw/misc/Kconfig b/hw/misc/Kconfig
> index 6996d265e4c5..9ec7a40f973a 100644
> --- a/hw/misc/Kconfig
> +++ b/hw/misc/Kconfig
> @@ -34,6 +34,11 @@ config PCA9552
>       bool
>       depends on I2C
>   
> +config I2C_ECHO
> +    bool
> +    default y if TEST_DEVICES
> +    depends on I2C
> +
>   config PL310
>       bool
>   
> diff --git a/hw/misc/meson.build b/hw/misc/meson.build
> index 892f8b91c572..fbea23f8b27f 100644
> --- a/hw/misc/meson.build
> +++ b/hw/misc/meson.build
> @@ -132,7 +132,7 @@ system_ss.add(when: 'CONFIG_NRF51_SOC', if_true: files('nrf51_rng.c'))
>   
>   system_ss.add(when: 'CONFIG_GRLIB', if_true: files('grlib_ahb_apb_pnp.c'))
>   
> -system_ss.add(when: 'CONFIG_I2C', if_true: files('i2c-echo.c'))
> +system_ss.add(when: 'CONFIG_I2C_ECHO', if_true: files('i2c-echo.c'))
>   
>   specific_ss.add(when: 'CONFIG_AVR_POWER', if_true: files('avr_power.c'))

Thanks, very appreciated!

Reviewed-by: Thomas Huth <thuth@redhat.com>




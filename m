Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F025716EE4
	for <lists+qemu-devel@lfdr.de>; Tue, 30 May 2023 22:34:52 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q462m-0005t3-W8; Tue, 30 May 2023 16:34:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1q462l-0005qC-M7
 for qemu-devel@nongnu.org; Tue, 30 May 2023 16:34:11 -0400
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1q462k-0004Df-4G
 for qemu-devel@nongnu.org; Tue, 30 May 2023 16:34:11 -0400
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-3f6d7abe9a4so35977765e9.2
 for <qemu-devel@nongnu.org>; Tue, 30 May 2023 13:34:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1685478848; x=1688070848;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=EPhXbSL5yKgue2MBQWKD4XyO+uxl2kGsAyMFg2PqEPs=;
 b=NFS2EPNYjdc62/xvBLLhnfSfC1kRxHOjb0A2kyt+SSlXorBoHN8nts3w6WqP5pyk9H
 fLSr6oDP8nGKyH4zFu6Ny8+XOeq6nhMZ/HVQdx5HJXOHR+KhGvwH8pMujMc1twgKO4zL
 6EkIGObWjUm5KWymMQAGh2JJQQQiBI2TZG6iLb1rD5V4OMl7QT6wBiLxdIuddhcI+h/R
 rYAd4g1hWxx6CifiNkJX3kYPfHspPNEpGw1cjnXdVr8fvT9quoS+3/0zhMqSR9kccE4v
 0RgXW05vZGugLONzHmSua+HE/4ne+iZPGEVYWrQTeM6il3+iM2FhyVMTCarSZoFcAqDS
 FzMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685478848; x=1688070848;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=EPhXbSL5yKgue2MBQWKD4XyO+uxl2kGsAyMFg2PqEPs=;
 b=eqfwaAK/auGCPRxftmZJUsw1cFngahnihGsqonBQZcdUc6ThbV9NlMgpagJAdT1EXr
 OoUyO9yRAFB18IKJVx9csbAl5edse6vIq0zc9mD28WvKAnR0s5W0l0911JD4GxcOfW4c
 ZErmhZIRfa439tfElp9xr7dbgmkBB5YqX8SjJnA8QgV6qaGwLTCTD+jOhHeCirQMSo5p
 fRSkjE3pdPKVqMlwAsjkY7+yWvFnKWFcgbk9cJzQ76snUsp1jnSt4RTF/1ujb0m9n76x
 xpQO7D6aYygbz0oH0g2q7xfNdoeQFdvAt8KGGhNOem2Hzv9czzmhPq443mu8Kw/S9BxK
 RF4w==
X-Gm-Message-State: AC+VfDxQz+QhPoTKdw4Pl2IOFf7RoLH4FTP1D4mlQYUD+xKWMwgxYiJP
 sYt85uSt9fw79EPM2NOTv2fxYQ==
X-Google-Smtp-Source: ACHHUZ5+rCHDZ2dkU7osWaA5rh76SEPhTc8Su6I/mMrxlDg4aCfNj8fGy4gs9RSyAFr611X1rK4lkg==
X-Received: by 2002:adf:edca:0:b0:30a:e6d2:3ce3 with SMTP id
 v10-20020adfedca000000b0030ae6d23ce3mr2188100wro.16.1685478848571; 
 Tue, 30 May 2023 13:34:08 -0700 (PDT)
Received: from [192.168.69.115] ([176.176.180.1])
 by smtp.gmail.com with ESMTPSA id
 bf3-20020a0560001cc300b00307b5376b2csm4261955wrb.90.2023.05.30.13.34.07
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 30 May 2023 13:34:08 -0700 (PDT)
Message-ID: <40c8647d-201e-3ceb-97ca-ec98bdc84e88@linaro.org>
Date: Tue, 30 May 2023 22:34:06 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.11.0
Subject: Re: [PATCH 05/12] hw/ssi: Introduce a ssi_get_cs() helper
Content-Language: en-US
To: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>, qemu-arm@nongnu.org
Cc: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Joel Stanley <joel@jms.id.au>, Andrew Jeffery <andrew@aj.id.au>,
 Alistair Francis <alistair@alistair23.me>
References: <20230508075859.3326566-1-clg@kaod.org>
 <20230508075859.3326566-6-clg@kaod.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230508075859.3326566-6-clg@kaod.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x331.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.09,
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

On 8/5/23 09:58, Cédric Le Goater wrote:
> Simple routine to retrieve a DeviceState object on a SPI bus using its
> address/cs. It will be useful for the board to wire the CS lines.
> 
> Cc: Alistair Francis <alistair@alistair23.me>
> Signed-off-by: Cédric Le Goater <clg@kaod.org>
> ---
>   include/hw/ssi/ssi.h |  2 ++
>   hw/ssi/ssi.c         | 15 +++++++++++++++
>   2 files changed, 17 insertions(+)
> 
> diff --git a/include/hw/ssi/ssi.h b/include/hw/ssi/ssi.h
> index ffd3a34ba4..c7beabdb09 100644
> --- a/include/hw/ssi/ssi.h
> +++ b/include/hw/ssi/ssi.h
> @@ -112,4 +112,6 @@ SSIBus *ssi_create_bus(DeviceState *parent, const char *name);
>   
>   uint32_t ssi_transfer(SSIBus *bus, uint32_t val);
>   
> +DeviceState *ssi_get_cs(SSIBus *bus, int addr);

Previous patch use uint32_t. uint8_t is probably enough,
otherwise 'unsigned'? Otherwise

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>



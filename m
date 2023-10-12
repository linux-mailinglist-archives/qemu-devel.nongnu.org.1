Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B033B7C641E
	for <lists+qemu-devel@lfdr.de>; Thu, 12 Oct 2023 06:36:00 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qqnQI-000729-0F; Thu, 12 Oct 2023 00:35:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qqnQF-00071c-Uf
 for qemu-devel@nongnu.org; Thu, 12 Oct 2023 00:35:43 -0400
Received: from mail-ej1-x632.google.com ([2a00:1450:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qqnQD-00086n-SE
 for qemu-devel@nongnu.org; Thu, 12 Oct 2023 00:35:43 -0400
Received: by mail-ej1-x632.google.com with SMTP id
 a640c23a62f3a-9b64b98656bso82961866b.0
 for <qemu-devel@nongnu.org>; Wed, 11 Oct 2023 21:35:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697085340; x=1697690140; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=EN0IDyE+rC9sar4CoPaHY6iTywNrc39u7yDiBEnnNqE=;
 b=Moh8oaViGvVb6kI5YfTMGN9rBcPYNcwGv7TJ2+Bb2GFG4x4fm/mmr9+57DQNkFmMQZ
 B335NUbU73dipT3BbhHQ29QfxNsK5707QRiOoglCcJs8uE7VGH7ZTcwGe8D4FchcTmJj
 xV9mP1fd4eYRF7MVHFXUh34bH/DPDqertdXdUIDDgODUXp64CK2x7x83rzllMJFSmHZI
 FWmc3vs3BgbJ9AmKFlXf+KEjBjMLgKlRK8yhKjJcouEnsaF92UXvuQX5vLMqkWg62dD6
 cp2E+eBazH6YONzCXmNAUXGlLVlZ2qUJ7AlfQtZkUZnppktszZfR9UBgeBaOatcLM5O0
 h3zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697085340; x=1697690140;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=EN0IDyE+rC9sar4CoPaHY6iTywNrc39u7yDiBEnnNqE=;
 b=ITZmsXL7nFgPBbd3UWcNwAihdWZattflthRwIqfDWcrJJy5W+1iNxsZADOz/letB4H
 K43CbN9f/WkAZHmEDMQ+Oo8thFAPjhYkGXtwRRFVxhfzzB2OyKs322SmGNRoU68V8r5k
 VGgnv9dCi5A3ZjZ8gzoM5TaaKhVwiVRUNIUrh1hAviDozf8uTiF6ahvMAGOw8ybPo5j+
 oPOckUywi3DIeNx9NkEezperjdiqCpSfQmmi6vpV1DpNQSGiSRM2xUzawaBu/kynM5Fk
 pntKk2vdQTgjW5ULD0+g3nr3q0igkAWYkY+i3+9n/BK1J3LUT3uhmkEg/1BXWYoISK8N
 I89Q==
X-Gm-Message-State: AOJu0Ywc9CsO3OyJVCAUzKtaAiVvT7bRNZwK7RZr8f5s/yWQyfTxAV3X
 ZKgMNevxcXHD/c6OPA/T7OQUqQ==
X-Google-Smtp-Source: AGHT+IHqfTTeREdL7UgFh5Cs1S+vNAEcHOZ6kY1eJWqQLNipmRtaXlA6Q2NOzrlmsQEqljXXw+3WBA==
X-Received: by 2002:a17:906:73d3:b0:9b8:df8e:cbda with SMTP id
 n19-20020a17090673d300b009b8df8ecbdamr19464518ejl.59.1697085340024; 
 Wed, 11 Oct 2023 21:35:40 -0700 (PDT)
Received: from [192.168.69.115] (dcs23-h01-176-173-173-31.dsl.sta.abo.bbox.fr.
 [176.173.173.31]) by smtp.gmail.com with ESMTPSA id
 e5-20020a17090681c500b00993a37aebc5sm10508006ejx.50.2023.10.11.21.35.38
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 11 Oct 2023 21:35:39 -0700 (PDT)
Message-ID: <557f2d41-e605-af72-b9a6-85dd67b310ab@linaro.org>
Date: Thu, 12 Oct 2023 06:35:37 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.1
Subject: Re: [RFC/PATCH v0 08/12] gunyah: Specific device-tree location
Content-Language: en-US
To: Srivatsa Vaddagiri <quic_svaddagi@quicinc.com>, peter.maydell@linaro.org, 
 alex.bennee@linaro.org, qemu-devel@nongnu.org, qemu-arm@nongnu.org
Cc: quic_tsoni@quicinc.com, quic_pheragu@quicinc.com,
 quic_eberman@quicinc.com, quic_yvasi@quicinc.com, quic_cvanscha@quicinc.com,
 quic_mnalajal@quicinc.com
References: <20231011165234.1323725-1-quic_svaddagi@quicinc.com>
 <20231011165234.1323725-9-quic_svaddagi@quicinc.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20231011165234.1323725-9-quic_svaddagi@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::632;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x632.google.com
X-Spam_score_int: -53
X-Spam_score: -5.4
X-Spam_bar: -----
X-Spam_report: (-5.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-3.339,
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

On 11/10/23 18:52, Srivatsa Vaddagiri wrote:
> Specify the location of device-tree and its size, as Gunyah requires the
> device-tree to be parsed before VM can begin its execution.
> 
> Signed-off-by: Srivatsa Vaddagiri <quic_svaddagi@quicinc.com>
> ---
>   MAINTAINERS             |  1 +
>   hw/arm/virt.c           |  6 ++++++
>   include/sysemu/gunyah.h |  7 +++++++
>   target/arm/gunyah.c     | 45 +++++++++++++++++++++++++++++++++++++++++
>   target/arm/meson.build  |  4 ++++
>   5 files changed, 63 insertions(+)
>   create mode 100644 target/arm/gunyah.c


> diff --git a/include/sysemu/gunyah.h b/include/sysemu/gunyah.h
> index aded49cdf6..101e190619 100644
> --- a/include/sysemu/gunyah.h
> +++ b/include/sysemu/gunyah.h
> @@ -34,10 +34,17 @@ typedef struct GUNYAHState GUNYAHState;
>   DECLARE_INSTANCE_CHECKER(GUNYAHState, GUNYAH_STATE,
>                            TYPE_GUNYAH_ACCEL)
>   
> +int gunyah_arm_set_dtb(__u64 dtb_start, __u64 dtb_size);

By moving this declaration before the #ifdef ...

> +
>   #else   /* CONFIG_GUNYAH_IS_POSSIBLE */
>   
>   #define gunyah_enabled()    0
>   
> +static inline int gunyah_arm_set_dtb(__u64 dtb_start, __u64 dtb_size)
> +{
> +    return -1;
> +}

... you don't need this stub.

> +
>   #endif  /* CONFIG_GUNYAH_IS_POSSIBLE */
>   
>   #endif  /* QEMU_GUNYAH_H */



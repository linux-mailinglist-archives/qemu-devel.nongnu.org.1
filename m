Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A56AB7CC37C
	for <lists+qemu-devel@lfdr.de>; Tue, 17 Oct 2023 14:45:14 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qsjQn-00078a-33; Tue, 17 Oct 2023 08:44:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qsjQj-00077M-8e
 for qemu-devel@nongnu.org; Tue, 17 Oct 2023 08:44:13 -0400
Received: from mail-ej1-x636.google.com ([2a00:1450:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qsjQh-00086Z-G0
 for qemu-devel@nongnu.org; Tue, 17 Oct 2023 08:44:13 -0400
Received: by mail-ej1-x636.google.com with SMTP id
 a640c23a62f3a-9bf0ac97fdeso444616266b.2
 for <qemu-devel@nongnu.org>; Tue, 17 Oct 2023 05:44:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697546650; x=1698151450; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=OI6XxeHEGNN/AelK/4GCeSwmqDn2vKzxp14UeZdcQUY=;
 b=mHj+oaIkUkeI+vNTf8XsAvdcL/GNJTkNIlhVO8h0LjBBJQWERfuisIH7snre8kPWi9
 iwLu/FVnmp1OQpN0NJtC5yVRPitnLjQPl6+DU+IVFXDKOc2wBE8As+j4F0hWlABbV7LI
 DmeJCTfXKm3W3BPxwZugRjB8giEeBUTu+m9FIuDxAORhfjXY2KVPdgTk5CBaFoUrR8GS
 QfdznBUaPoEUR5qaIn7PdRITFCmwamVUKvJKfLAYrkZD7TfUpNKkuVknH+giLMdk47qW
 B/uIH6yQn+GD7x+qSCDFnGmW/X7mkdE8FKBKxsJ/amv52DUDK/3OcbrWeLXZ9uswZgei
 MlPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697546650; x=1698151450;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=OI6XxeHEGNN/AelK/4GCeSwmqDn2vKzxp14UeZdcQUY=;
 b=OePCjLIm1pyj9zrHnVBiw5iAv8Na9JeMpYI/Ww2dlrveawJyMddHrbXQ1bLAonQN1z
 YI3Z10et6TiTZCdPgZc8jkXyt1Jmd6XCuxLpY3wATgs+PZTrggKOlvd2fU0Q23KouSE+
 SR8ZqZSrKG+KwK7tIXVw+sgwKa6O+KvyroPBFQ9KtY3L7S44C0j1t71VL8k8Cj1Jr/eK
 Q+9vSESGq17UpBgweE6khLf81HlHzn/8osG+aVPDEpWhmC3Rqb918UA+VdFbgSW0HaWM
 xvaIN5qh5a9+Rx+XqDPBNiQ0vt/LRtvaUhESQyjmWl3pqhzR6DYKe6L7Rzktpa1pBthe
 zK5Q==
X-Gm-Message-State: AOJu0YwEuhpYfxIRAuFa0YuX/+wzQIbjof+tkQoVgLIfiozIKhg2qOOx
 3S4gpc9eLretoEtt0aa3mrxXuQ==
X-Google-Smtp-Source: AGHT+IENi+c/pGANhLBSTXcUVBIQJsh9gh+h33Y8CCs50+SrOKwAWQaQ7pk7ODv3oexNs18uubRkSQ==
X-Received: by 2002:a17:906:da88:b0:9a6:4f54:1da6 with SMTP id
 xh8-20020a170906da8800b009a64f541da6mr1356029ejb.57.1697546649620; 
 Tue, 17 Oct 2023 05:44:09 -0700 (PDT)
Received: from [192.168.69.115] ([176.172.118.33])
 by smtp.gmail.com with ESMTPSA id
 m15-20020a17090607cf00b0099ddc81903asm1201474ejc.221.2023.10.17.05.44.08
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 17 Oct 2023 05:44:09 -0700 (PDT)
Message-ID: <c61b98d3-cafd-862b-09ad-818a5e2f051d@linaro.org>
Date: Tue, 17 Oct 2023 14:44:07 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.1
Subject: Re: [PATCH 4/6] hw/input/stellaris_gamepad: Remove
 StellarisGamepadButton struct
Content-Language: en-US
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
References: <20231017122302.1692902-1-peter.maydell@linaro.org>
 <20231017122302.1692902-5-peter.maydell@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20231017122302.1692902-5-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::636;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x636.google.com
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

Hi Peter,

On 17/10/23 14:23, Peter Maydell wrote:
> Currently for each button on the device we have a
> StellarisGamepadButton struct which has the irq, keycode and pressed
> state for it.  When we convert to qdev, the qdev property and GPIO
> APIs are going to require that we have separate arrays for the irqs
> and keycodes.  Convert from array-of-structs to three separate arrays
> in preparation.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>   hw/input/stellaris_gamepad.c | 43 ++++++++++++------------------------
>   1 file changed, 14 insertions(+), 29 deletions(-)


> -static const VMStateDescription vmstate_stellaris_button = {
> -    .name = "stellaris_button",
> -    .version_id = 0,
> -    .minimum_version_id = 0,
> -    .fields = (VMStateField[]) {
> -        VMSTATE_UINT8(pressed, StellarisGamepadButton),
> -        VMSTATE_END_OF_LIST()
> -    }
> -};
> -
>   static const VMStateDescription vmstate_stellaris_gamepad = {
>       .name = "stellaris_gamepad",
>       .version_id = 2,
>       .minimum_version_id = 2,
>       .fields = (VMStateField[]) {
>           VMSTATE_INT32(extension, StellarisGamepad),
> -        VMSTATE_STRUCT_VARRAY_POINTER_INT32(buttons, StellarisGamepad,
> -                                            num_buttons,
> -                                            vmstate_stellaris_button,
> -                                            StellarisGamepadButton),
> +        VMSTATE_VARRAY_UINT32(pressed, StellarisGamepad, num_buttons,
> +                              0, vmstate_info_uint8, uint8_t),

Don't this break the migration stream?

>           VMSTATE_END_OF_LIST()
>       }
>   };



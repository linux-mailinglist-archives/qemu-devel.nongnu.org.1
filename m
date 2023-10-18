Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 719307CDCFF
	for <lists+qemu-devel@lfdr.de>; Wed, 18 Oct 2023 15:16:20 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qt6NE-0008UK-NX; Wed, 18 Oct 2023 09:14:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qt6Mj-0008Jr-Mv
 for qemu-devel@nongnu.org; Wed, 18 Oct 2023 09:13:40 -0400
Received: from mail-ed1-x536.google.com ([2a00:1450:4864:20::536])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qt6Mi-0000rb-6y
 for qemu-devel@nongnu.org; Wed, 18 Oct 2023 09:13:37 -0400
Received: by mail-ed1-x536.google.com with SMTP id
 4fb4d7f45d1cf-53e04b17132so11239984a12.0
 for <qemu-devel@nongnu.org>; Wed, 18 Oct 2023 06:13:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697634814; x=1698239614; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=nOEYkWvI6OGzs8qDWNjMO1MB9K12s+KF/8VSWMwKlts=;
 b=kmpBmob8WcmT/wuFCJ8ghD2tpvGsTsLUQkbBfXlzPuM9mNIWkg0il4pz73SZJq6laS
 J5vUYr8ESpta4YewPYxCyqt0yr6kbSEEXXZGuZmClPFV3eKsQrEnNPvpyV8e7Tn9C3nQ
 g7HWD/Ez0qkE9vQP/iqe5R7aluz4+ndm2tYqSZjekZC/6kpBI/A9LSvoHOG64z22Zu3D
 i/9zrF69S4AOWvZxyjMJ2TpFCC2loWLEbOuibjE+Y+yoYZ+N6o4rOBSkQDFQiFjkMhxM
 69ptNxqlXp7ONlLyimBM8sXAFHfbbvYWPpBQ2cf4rSG8e54Qq+F9+8ZRrXbb2A+8dVgo
 2oDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697634814; x=1698239614;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=nOEYkWvI6OGzs8qDWNjMO1MB9K12s+KF/8VSWMwKlts=;
 b=g904mstMXYW9GQ/4u3jlILk/ogSz8GnCurHwuxTrvEO7mU1iZnEBGWTKhT7hBpoCOH
 lA4EuJe/EwTEkmz0inr8UYA+p+mMnHDTH3mM/X26mmVUj1FkBxvvRSaiMQkQ4GldcdoY
 cQey5Wjxby2bJFLBFSvjp/Y73HaW74IVmAtuwefSgeLdwdAPQWdjZXS7y+MJ4LkELBUx
 KV18P3xJSaffm8KE8+RnmRMEZLMPZTe44M13GLTSxCax2cEnv7c4Cmye/hPAYYNKSPDa
 L4H5uyLuRE2YOQCnPLMY427QtH++m4U3utcewNZurbwbxgsi8QvPzf7dcM7+tDgxwKk8
 D43g==
X-Gm-Message-State: AOJu0Yy2fkxvh9XlvVUFpEcfDqN00f9uSr8WJdViQwEpY+sfP+KCsAZ5
 dSuYNid+V7FZ/oel8xjrkk+luadig8vJJbeEqbo=
X-Google-Smtp-Source: AGHT+IG84Nb3/RSJ/rP9kpR6K39Wd5Cn98hOI8aXZ3cAG+9diKYkv+Lk3Qs1JhgO248gsshppqfTww==
X-Received: by 2002:a05:6402:3493:b0:53d:a7ea:225c with SMTP id
 v19-20020a056402349300b0053da7ea225cmr4333544edc.30.1697634813788; 
 Wed, 18 Oct 2023 06:13:33 -0700 (PDT)
Received: from [192.168.69.115]
 (gyl59-h01-176-171-218-149.dsl.sta.abo.bbox.fr. [176.171.218.149])
 by smtp.gmail.com with ESMTPSA id
 da12-20020a056402176c00b0053e5957aa47sm2802678edb.33.2023.10.18.06.13.32
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 18 Oct 2023 06:13:33 -0700 (PDT)
Message-ID: <1b159c7a-f52c-3705-8757-c2b80a04965b@linaro.org>
Date: Wed, 18 Oct 2023 15:13:31 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.1
Subject: Re: [PATCH 0/8] hw/arm/pxa2xx: SysBus/QDev fixes
Content-Language: en-US
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org
References: <20231018131220.84380-1-philmd@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20231018131220.84380-1-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::536;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x536.google.com
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

On 18/10/23 15:12, Philippe Mathieu-Daudé wrote:
> Hi,
> 
> Extracted from a bigger series which enforce QDev state machine
> (qdev instance must be realized before external API is used on
> it).
> 
> While here, pxa2xx i2c/intc devices received some qdev fondness.

Forgot to mention, there is still an issue in pxa2xx_i2c_init()
where an odd 'dummy' i2c bus is created *after* the device is
realized.

> Philippe Mathieu-Daudé (8):
>    hw/sd/pxa2xx: Realize sysbus device before accessing it
>    hw/sd/pxa2xx: Do not open-code sysbus_create_simple()
>    hw/pcmcia/pxa2xx: Realize sysbus device before accessing it
>    hw/pcmcia/pxa2xx: Do not open-code sysbus_create_simple()
>    hw/pcmcia/pxa2xx: Inline pxa2xx_pcmcia_init()
>    hw/intc/pxa2xx: Convert to Resettable interface
>    hw/intc/pxa2xx: Pass CPU reference using QOM link property
>    hw/intc/pxa2xx: Factor pxa2xx_pic_realize() out of pxa2xx_pic_init()



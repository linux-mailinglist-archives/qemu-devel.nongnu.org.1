Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B479A9E604F
	for <lists+qemu-devel@lfdr.de>; Thu,  5 Dec 2024 23:04:21 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tJJwr-0006yM-BB; Thu, 05 Dec 2024 17:03:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tJJwo-0006xb-IO
 for qemu-devel@nongnu.org; Thu, 05 Dec 2024 17:03:46 -0500
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tJJwm-0000lK-Lu
 for qemu-devel@nongnu.org; Thu, 05 Dec 2024 17:03:46 -0500
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-434b3e32e9dso15099485e9.2
 for <qemu-devel@nongnu.org>; Thu, 05 Dec 2024 14:03:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733436223; x=1734041023; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=JkKt6OdZT5hMip/aCluKuPmTaua7wLiTWB62lQ4JtdY=;
 b=XF8wvWXeuRJzCSrWyQbw/H6F/C2bVlxzQGN7gV+8/MkDaScZlfsuQFgZRlsPE4NVAA
 8gli2T6MR+ua43l5G04pBNM1tiNJrmkq2C6Ife+S+ap8G5mACpLm4zT+/IY3DZAO0BKe
 wujmKmrB1r9ALvBFdh2ARGha25ghgRkWLSy51lT/VmNio/JbCsB9YEsKCkFFJgthd22c
 EbJhHXV+vZYOvN2pXKOBrH3BLmShpI1SQYMz1KMskvYUEM1nMuh9qyywZSZuH/ojch09
 BW2ORR1aFcI6FhEES0OVDPV4Qu2efNWLvwqWD/wBMQj1gN2MWORVK0qlVP+1SW5p5zBi
 OXgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733436223; x=1734041023;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=JkKt6OdZT5hMip/aCluKuPmTaua7wLiTWB62lQ4JtdY=;
 b=B+BnLpgQVtdOtFnbw572JrPdFNDWFPISOBDgAek2CZ3ZTUgh12vC5U3Kwadx8VQyYj
 dBDbTC2sNc71AHj02p1I89tR01n1jYBA7e53Nlx/PZWjSXrObQFBH4kV4+Wa0OghDtpT
 i9/MD7Fa9L5zEzKT4XtUSHBEIctkmEU4j16wpuE4Am5oBkhn7HLclP5MiRgNFDioB6k3
 SJSdaTtIVN0E+i7WmJa23iqcb4eaVcu9z9s0GC+iqjSMw/Esq58oK240j9eosIdcmyEQ
 lguLpR2Xej6jyOGfVeovkuUiAjLmpfnqKjV5RuP70YyrWwtfsGV/vRIli7xHFQr3vZO7
 4aCw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUNxtls1nRmYnkvb3S88LaQAbJfry1KIkbcFZMJxfEy05P69/2PNOnvmruMrMihC7ctOJUZv8XnAnzU@nongnu.org
X-Gm-Message-State: AOJu0YxXS6YFoajHjhq85Z5/B2iP+dgHsjfNMCsm4Rpia6E/MhX7Huy8
 /2CUFodXbQ+CIAQm4vV5scoG0h1p5me0T8gbZcb36RKNTDpwWwvpRlIdnuY0WAk=
X-Gm-Gg: ASbGncsgF2Ie4USEZsbQZ1UE3S92PMBAr4JRsOz/N5J3etTleGg4iAJwLHN0Cz5S+BJ
 W0LepvlecHYvv1QGlyI0EUO7xeTY0ApN+pvSoA0DLNf39iJVrHg3Sxcvv8tJbMgIAYvI2djd64f
 r8csxz7dbPMC2NVfMVsq217cfAqeCkQD2l89swHVVI6a0qjfWU4NmxxTS3ip4+tKfkKRDST7BKJ
 +5AI0iM/dw2muVUHh/0GUOih9pp76XbtRZkCj4DrV2Juhcemgbhk1xkPVdsyuqU9EoypD62hOwI
 j0ozA5p/Hc2ywRCdiQ==
X-Google-Smtp-Source: AGHT+IGrz+ES8JLbYNN/i4EayGyiD4lgwSFAHv9NpWILXRrEYx5gVEVj1IAccetlOM9xVnnDpdlThg==
X-Received: by 2002:a5d:47af:0:b0:385:d852:29ed with SMTP id
 ffacd0b85a97d-3862b3d0a3fmr398203f8f.36.1733436222889; 
 Thu, 05 Dec 2024 14:03:42 -0800 (PST)
Received: from [192.168.69.223] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3861f59ccd6sm3002857f8f.32.2024.12.05.14.03.40
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 05 Dec 2024 14:03:41 -0800 (PST)
Message-ID: <d80be891-e0f3-46c0-8cb1-7ed1df8e223a@linaro.org>
Date: Thu, 5 Dec 2024 23:03:40 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 16/26] hw/arm/virt: Disable DTB randomness for
 confidential VMs
To: Jean-Philippe Brucker <jean-philippe@linaro.org>, peter.maydell@linaro.org
Cc: richard.henderson@linaro.org, qemu-arm@nongnu.org, qemu-devel@nongnu.org, 
 alex.bennee@linaro.org
References: <20241125195626.856992-2-jean-philippe@linaro.org>
 <20241125195626.856992-18-jean-philippe@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20241125195626.856992-18-jean-philippe@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x331.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

On 25/11/24 20:56, Jean-Philippe Brucker wrote:
> The dtb-randomness feature, which adds random seeds to the DTB, isn't
> really compatible with confidential VMs since it randomizes the Realm
> Initial Measurement. Enabling it is not an error, but it prevents
> attestation. It also isn't useful to a Realm, which doesn't trust host
> input.
> 
> Currently the feature is automatically enabled, unless the user disables
> it on the command-line. Change it to OnOffAuto, and automatically
> disable it for confidential VMs, unless the user explicitly enables it.
> 
> Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
> ---
>   docs/system/arm/virt.rst |  9 +++++----
>   include/hw/arm/virt.h    |  2 +-
>   hw/arm/virt.c            | 41 +++++++++++++++++++++++++---------------
>   3 files changed, 32 insertions(+), 20 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>



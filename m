Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 47BC67E5334
	for <lists+qemu-devel@lfdr.de>; Wed,  8 Nov 2023 11:17:12 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r0fcQ-0002VA-08; Wed, 08 Nov 2023 05:17:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1r0fcL-0002Uq-Jr
 for qemu-devel@nongnu.org; Wed, 08 Nov 2023 05:17:01 -0500
Received: from mail-ej1-x630.google.com ([2a00:1450:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1r0fcK-00064l-4N
 for qemu-devel@nongnu.org; Wed, 08 Nov 2023 05:17:01 -0500
Received: by mail-ej1-x630.google.com with SMTP id
 a640c23a62f3a-9d224dca585so1027315566b.1
 for <qemu-devel@nongnu.org>; Wed, 08 Nov 2023 02:16:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1699438618; x=1700043418; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Yhqox3SpHKDFxfByI9ZKAnaupwYUGG51PrRNbYmM+Vw=;
 b=X0k9ztujIC4jFjswhWnypjdbae7tRg6NATDM2xxInqiXl1zuUpQEJw3mu3BUh7GUfQ
 8FO5EYv1zt/ELS54Hybnb0ZQnOfXOsJiLqIx5o3jmGfa4aIMZt/up1JnxgmwvknzxAyA
 +NwTbsIsKgsw7iXbPHSLyJVN6+ewFN1Eod+aajBSK5gIk1CZkpYowsS2KeWAiXZR4yAR
 /eZqY58rTuLK5li7ws2WvNvzmFqxVph3nJ6PU3E5o9jmCJd9dbHkwCZNXa1dTClbwOqd
 9uzv9fNlrQvCF5DoK7wxjPASQHg37q2vOcAjakggnXbH2414vSCu5exaZLeOQSH3bVED
 zayA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699438618; x=1700043418;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Yhqox3SpHKDFxfByI9ZKAnaupwYUGG51PrRNbYmM+Vw=;
 b=cP8aAEBSLNUZjvj6y1KoKm6+CGUkBQN9e5soM6v67GCvgNTG3grxW8gKA9Ctqtu7lR
 n0mFJ8ioyRGnUbWavBfbuV1SqSL8CeayCMt7AP+eRixBSxxlxdj5K9XGxS7gsAaJqz4F
 y5wCfIuio2LR31p4iG2qQmAVc5KB/H/fl/fBYfzyK58ZlS90nGbak7pgF/rUuX593Sk0
 RTEj7PWtV5FAw64yETKEAs4HNq/ST8RuqPbW3ls+i7z2O8rxo+JuRZA8/aimALw/1swu
 r8p4R/Hx5PCmR+5HPNkPf74AOEOoeCeM57tmtN8s1iWzaINvgR/lJipuW7macMRISRjf
 kfbg==
X-Gm-Message-State: AOJu0Yx2aioyl84BmzAklwbKJzqWJS5cqBXIMdcv71O1Wz1kEO1SjTEF
 3dDIF+OkzsnN/8BpgL/Np/qeng==
X-Google-Smtp-Source: AGHT+IGLNPr6Oclalf4ZSEaNAfE4VDVe9ufKWyLyDYa/T8FR9eR9qTr8HXvLGl2+0Q2/00kV2pW3SA==
X-Received: by 2002:a17:907:3183:b0:9be:68db:b763 with SMTP id
 xe3-20020a170907318300b009be68dbb763mr1160844ejb.71.1699438618441; 
 Wed, 08 Nov 2023 02:16:58 -0800 (PST)
Received: from [192.168.69.115] ([176.187.199.60])
 by smtp.gmail.com with ESMTPSA id
 o14-20020a1709062e8e00b00997cce73cc7sm794992eji.29.2023.11.08.02.16.57
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 08 Nov 2023 02:16:58 -0800 (PST)
Message-ID: <f83c35d3-aff4-40ba-adde-508f4b685619@linaro.org>
Date: Wed, 8 Nov 2023 11:16:57 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 69/71] util/fifo8: Constify VMState
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: quintela@redhat.com, peterx@redhat.com, farosas@suse.de, leobras@redhat.com
References: <20231106065827.543129-1-richard.henderson@linaro.org>
 <20231106065827.543129-70-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20231106065827.543129-70-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::630;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x630.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

On 6/11/23 07:58, Richard Henderson wrote:
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   util/fifo8.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>



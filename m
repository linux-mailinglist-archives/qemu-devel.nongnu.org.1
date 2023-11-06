Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CB637E209D
	for <lists+qemu-devel@lfdr.de>; Mon,  6 Nov 2023 13:00:35 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qzyGk-0007M0-Lj; Mon, 06 Nov 2023 06:59:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qzyGi-0007LP-Qa
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 06:59:48 -0500
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qzyGR-0007kb-TV
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 06:59:48 -0500
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-32faea0fa1fso2337064f8f.1
 for <qemu-devel@nongnu.org>; Mon, 06 Nov 2023 03:59:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1699271969; x=1699876769; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=CyM3rlEfZ9+NO+IGfBXHRBz3BT+cMJzydgbt6qMBtE4=;
 b=RxjWtKibcGrJwVWArXChxhRRjWmlCfVHEE652C20msUu/c+PrxMvjU6LbLnioLxv57
 ei4oD0OFB7kyri9q/DZwNeZQWqyI6eWOQmK9VxrU182zrLwMv7efQi8Ul1cSYc85C7xW
 cR6BLcsIk9wcSpzNTaixVcT9e6RY7vZ0SwrsUEL/aR5KyPLnxJWiGPOIO7dF9YyV/m/X
 2Vt+lPiDRarqKm2qvbCyQbzdj9lHXDq+ZIFve84t+RnKkBzx83CSqWgfofoZ5o4gNVL6
 ncMdM6inEQmGzdInXIg2hX1jfcZKdleYLJafcxub+s8BzIQj1g33PjEx4CIkZMFfSb/8
 B1JQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699271969; x=1699876769;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=CyM3rlEfZ9+NO+IGfBXHRBz3BT+cMJzydgbt6qMBtE4=;
 b=FxwWeNb/xdDBtkqdjBGrUWEs1JPbk5zpFWy4g8D5F2geRanJOVB9SFM+bKgK+gxEOy
 hdAXmm2Wj2kROyZ584loWKW+7Py5YPzRDwp/4rv97AAhJnqIp9IDhwXPz/SHF+2qd2XP
 kFnCIcnISpN9Z1vIHvKU1V4Vy3ipkqkX68zSGVwK/saiDCmzL970OppMJjYFei77JMF8
 Y2yqcvjFxONCER/1EvN6LknwtHa1A6nkDDXnyIlvsYquXs96IiQGeZZuh43/kRfHielf
 vslw0g1AVgB6Xc7Yjiw0kzP7ZABtt163Tx+35cUHLMoTlTfvQMO0Hku+qyIGGYEqSzb3
 6O1Q==
X-Gm-Message-State: AOJu0YyKpMuMsrWeXTXK50q3YOVetU/I9zWdZugO/17O8FYoU1cTGi6W
 KvImgrf9yk+WsJq0FYmg0+ytvg==
X-Google-Smtp-Source: AGHT+IGuG6RownrJjZBUBuuA/+ucvszgQUIZ/io6SmxDyjstUNA+GsjG4rwYwb1UTiwHpt2Qbi1msg==
X-Received: by 2002:a5d:64e4:0:b0:32d:cb21:4e99 with SMTP id
 g4-20020a5d64e4000000b0032dcb214e99mr11566706wri.13.1699271969691; 
 Mon, 06 Nov 2023 03:59:29 -0800 (PST)
Received: from [192.168.69.115] (176-131-220-199.abo.bbox.fr.
 [176.131.220.199]) by smtp.gmail.com with ESMTPSA id
 f4-20020a5d6644000000b0032da49e18fasm9301932wrw.23.2023.11.06.03.59.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 06 Nov 2023 03:59:29 -0800 (PST)
Message-ID: <4e080a94-214f-b8b2-6dcc-7b462b028310@linaro.org>
Date: Mon, 6 Nov 2023 12:59:27 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.1
Subject: Re: [PATCH] target/arm: Fix A64 LDRA immediate decode
Content-Language: en-US
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org
References: <20231106113445.1163063-1-peter.maydell@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20231106113445.1163063-1-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::429;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x429.google.com
X-Spam_score_int: -51
X-Spam_score: -5.2
X-Spam_bar: -----
X-Spam_report: (-5.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-3.085,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01,
 T_SPF_HELO_TEMPERROR=0.01 autolearn=unavailable autolearn_force=no
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

On 6/11/23 12:34, Peter Maydell wrote:
> In commit be23a049 in the conversion to decodetree we broke the
> decoding of the immediate value in the LDRA instruction.  This should
> be a 10 bit signed value that is scaled by 8, but in the conversion
> we incorrectly ended up scaling it only by 2.  Fix the scaling
> factor.
> 
> Cc: qemu-stable@nongnu.org
> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/1970
> Fixes: be23a049 ("target/arm: Convert load (pointer auth) insns to decodetree")
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>   target/arm/tcg/translate.h | 5 +++++
>   target/arm/tcg/a64.decode  | 2 +-
>   2 files changed, 6 insertions(+), 1 deletion(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>



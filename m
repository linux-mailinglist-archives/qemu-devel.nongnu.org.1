Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BE39725646
	for <lists+qemu-devel@lfdr.de>; Wed,  7 Jun 2023 09:47:21 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q6nsh-0006Oq-2R; Wed, 07 Jun 2023 03:46:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1q6nse-0006OL-4l
 for qemu-devel@nongnu.org; Wed, 07 Jun 2023 03:46:56 -0400
Received: from mail-wr1-x42d.google.com ([2a00:1450:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1q6nsb-0003Uv-KL
 for qemu-devel@nongnu.org; Wed, 07 Jun 2023 03:46:55 -0400
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-30aeee7c8a0so214615f8f.1
 for <qemu-devel@nongnu.org>; Wed, 07 Jun 2023 00:46:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1686124012; x=1688716012;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=weXaM3N7og6oPqkLmGRnoChCKjpn1ZdJQX//LF2/7FQ=;
 b=ZTiQEwuXpPZADK8EsiN/cEJQohtpZWO50uiF+pDHWOuZyIvmOO+Rqy4lj4xNVMrTaX
 ukRbXHu1mcZ6/2Yj84bq2AwdF3h+NM0MLzx8TwUs3EO9X3gRpWwVxH+rhl0K2xpo5Gcz
 5xCjbkRo5jE9l5YbTpOGGjuLlKc0lExqcmYjRvHLZGf/VgyZazPjEvRIfUuaLYPP8Ao3
 spKfSkEAcspt3h8cPHx7AJ6j7SgFuE3DDn4h6zfBMPWpUDvJh5ArwSZi+TaGgB+fH+2H
 UPuaV0i4zuSJ771YaeJ7wBtLLs3p/pOT8+MvaUOI4xeVhP/PAXvpkk5zJ/6rae0Innnw
 Ml+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686124012; x=1688716012;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=weXaM3N7og6oPqkLmGRnoChCKjpn1ZdJQX//LF2/7FQ=;
 b=fMecHD6hTzDht6Xik8VK92UIbNkpwZzQxDCm2FuQG4OS7rBfK/0T8iM/m8CUYEqPPN
 O1r3w2U6Sbr0EXFKOQE6n6kiJTv8NkMFZ6DbvR0QxGusiS5FYqqUX5ua/RTbaYALBhEG
 /46MAh7GplHEWi/5ebBAS600I304IGcgVzlQecDhu7znU/B0PMnwGvdd5ooevt9Eyd/K
 j7pkIb3yPllKiHVJbghwmE0HoM43BSS2FdI9tAqW+gOzJZdsdpar4qwzESHjJhNp86o5
 RD3/rP3hwkMznuSzNHw+jVTxNNmKLoqJbNr/3NmyBc7iGP10lnIWEVQHZTAz8vnfHNu1
 qcsA==
X-Gm-Message-State: AC+VfDxpBZWuIMJKINWGUMyPb3+Ekp+YDYhC9ullTJQnlQNTehLHlSB8
 RahSs4DW6wQGJ9KxA721oPIeFw==
X-Google-Smtp-Source: ACHHUZ52AHsuLXzI4b/H34zQbyeyZ2YWv7ZGkz9bbUxd7757glqnCsX87wV3E5fTn3dMx1ma11il8w==
X-Received: by 2002:a5d:534c:0:b0:30a:a193:3987 with SMTP id
 t12-20020a5d534c000000b0030aa1933987mr9918087wrv.30.1686124011975; 
 Wed, 07 Jun 2023 00:46:51 -0700 (PDT)
Received: from [192.168.69.115] (bd137-h02-176-184-46-52.dsl.sta.abo.bbox.fr.
 [176.184.46.52]) by smtp.gmail.com with ESMTPSA id
 x15-20020a5d650f000000b002fb60c7995esm14713947wru.8.2023.06.07.00.46.50
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 07 Jun 2023 00:46:51 -0700 (PDT)
Message-ID: <055657fc-92ba-0f91-df86-1ce4cf096ca4@linaro.org>
Date: Wed, 7 Jun 2023 09:46:50 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.11.2
Subject: Re: [PATCH 1/2] target/arm: Only include tcg/oversized-guest.h if
 CONFIG_TCG
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, alex.bennee@linaro.org, thuth@redhat.com
References: <20230606224609.208550-1-richard.henderson@linaro.org>
 <20230606224609.208550-2-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230606224609.208550-2-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42d;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42d.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.094,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

On 7/6/23 00:46, Richard Henderson wrote:
> Fixes the build for --disable-tcg.
> 
> This header is only needed for cross-hosting.  Without CONFIG_TCG,
> we know this is an AArch64 host, CONFIG_ATOMIC64 will be set, and
> the TCG_OVERSIZED_GUEST block will never be compiled.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   target/arm/ptw.c | 5 +++--
>   1 file changed, 3 insertions(+), 2 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>




Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BB5E9718402
	for <lists+qemu-devel@lfdr.de>; Wed, 31 May 2023 15:56:58 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q4MJV-00044l-P2; Wed, 31 May 2023 09:56:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1q4MJT-00044N-SW
 for qemu-devel@nongnu.org; Wed, 31 May 2023 09:56:32 -0400
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1q4MJS-0004bJ-3S
 for qemu-devel@nongnu.org; Wed, 31 May 2023 09:56:31 -0400
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-3f6e4554453so43746165e9.3
 for <qemu-devel@nongnu.org>; Wed, 31 May 2023 06:56:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1685541388; x=1688133388;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=f+cMeePrQDBg82crLgeu8VxFbIIryvV8p/+yDeBbwLY=;
 b=tCQMGRMHChSPhitKDgpE6p+oS4YksRgmjE4BoxeRIX1M080fq8AEUATg8fZObRK/NV
 baI9lWGbbu7VrCWpBlAq5+DxZhMffwjZwGnnn+m997g0H7gLWuB0eG8SHUBFBaz3xfAy
 VwXQw+lOqoemkPQjWkIDW/2g9tBxfE6JZ1TJeCr3gqx8Bol+KRrqEFMhayZpHVYwrf6w
 5UOijv9MeonDzYus8URycqqnZkEkYgkdxiRXUMoAophNTZL0DHwd8iZmTW2A9NXAMTq7
 DzGLrTgizC5InfBBuEWEMDyfD6DPvVwvZAorTpu828EP/I29pmAxYv8X9d5ABIWEwoOe
 xNdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685541388; x=1688133388;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=f+cMeePrQDBg82crLgeu8VxFbIIryvV8p/+yDeBbwLY=;
 b=AjKDU4hwjJf9CfWfRdvFL9AtasreHx/5m5taO7A6qG+kb7nexhH8iAB1qFuGmxntQz
 mjNKZoqbN98JBaWl5UBBMdef1by1Drh0vnEkt6OSN6+8VDN3+LPosQIRVnwnMkUMx8d2
 3qNRwKiuBOc2AjjFt2ugWujNuXKyen0l1J3dggRit0gP8ZdumEjR5giNnfUI67asuUQ4
 Eny7CZU1McJi4uSyzq2MqXeaEYbVJuIovL8GA1BIdJs3kgtuC++SGHS9wlHt+JVLRiFT
 uvdm4b/G/EPXOKtm4eDFGjhU+lkIK8sm2YDat+73sGqrDC7AUCQpCg+SC1Kd95aLSXRT
 IdhA==
X-Gm-Message-State: AC+VfDxPyDVCS7wmfTaTLkVI0aS6oOWFhRPYd2Z123Mbqed9ehZy4cV2
 edAElcHlStYmlKfu9X6FQuLryw==
X-Google-Smtp-Source: ACHHUZ4yuCjsjgLrc9qYTOcPFbNNhaZyK8Cw4YdSipes8VkgFwlI9Dt8yLTlnN1N8OcXIcUkXwR6Eg==
X-Received: by 2002:a1c:7401:0:b0:3f5:d313:db68 with SMTP id
 p1-20020a1c7401000000b003f5d313db68mr3732105wmc.5.1685541388273; 
 Wed, 31 May 2023 06:56:28 -0700 (PDT)
Received: from [192.168.69.115] ([176.176.146.12])
 by smtp.gmail.com with ESMTPSA id
 l5-20020adffe85000000b00307a83ea722sm7008362wrr.58.2023.05.31.06.56.27
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 31 May 2023 06:56:27 -0700 (PDT)
Message-ID: <4e76c989-a665-fb9a-cc13-9eb7b1f92b43@linaro.org>
Date: Wed, 31 May 2023 15:56:26 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.11.0
Subject: Re: [PATCH v2 01/23] q800: fix up minor spacing issues in
 hw_compat_q800 GlobalProperty array
Content-Language: en-US
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, laurent@vivier.eu,
 qemu-devel@nongnu.org
References: <20230531125400.288917-1-mark.cave-ayland@ilande.co.uk>
 <20230531125400.288917-2-mark.cave-ayland@ilande.co.uk>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230531125400.288917-2-mark.cave-ayland@ilande.co.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x336.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.091,
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

On 31/5/23 14:53, Mark Cave-Ayland wrote:
> Ensure there is a space before the final closing brace for all global
> properties.
> 
> Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
> Reviewed-by: Laurent Vivier <laurent@vivier.eu>
> ---
>   hw/m68k/q800.c | 10 +++++-----
>   1 file changed, 5 insertions(+), 5 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>



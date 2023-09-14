Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 256A17A0573
	for <lists+qemu-devel@lfdr.de>; Thu, 14 Sep 2023 15:21:45 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qgmHY-0006hZ-Em; Thu, 14 Sep 2023 09:21:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qgmHO-0006cC-QF
 for qemu-devel@nongnu.org; Thu, 14 Sep 2023 09:21:12 -0400
Received: from mail-oi1-x22e.google.com ([2607:f8b0:4864:20::22e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qgmHM-0001Bh-3P
 for qemu-devel@nongnu.org; Thu, 14 Sep 2023 09:21:10 -0400
Received: by mail-oi1-x22e.google.com with SMTP id
 5614622812f47-3a9b41ffe11so559388b6e.2
 for <qemu-devel@nongnu.org>; Thu, 14 Sep 2023 06:21:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1694697664; x=1695302464; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=ydzDPr5epNv+rP2XhgG6NWld2zGOhNH9pfERfWfXi9E=;
 b=MTl5oR4tOhWEk292kpfpnI2/1ZfQtJm2G+B+2WqivcbEox6bJXYYvmaWj0pTzVd+gL
 CHaMVIz515U+ekt7Eg6IOxFIcNc8XOMXM48ey7liMMqxCsTgUOJ4oOgwq6+DGD6E2F6G
 rvl39jxLvKuH7pbwWt2nFQjwycMWHBjGTfoVkl6UNje3r0TGA2w3grndEn33iyYlEas+
 0DyaVYcZiXYeuXKZ4sCz0XOF0oTfyisRnezCyUIMKODpfD4DL+GWyZ4z+CBvCEDs7mmB
 z8F2vEPsGsw/RaS/DOzeMbAJBUqUJJ2rsntJrm6fhXW2dBIJbhkOYrbxSO3DdlhTR7ew
 DWmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694697664; x=1695302464;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ydzDPr5epNv+rP2XhgG6NWld2zGOhNH9pfERfWfXi9E=;
 b=CJUsZIYgQXVXDb10UoIaKnoac7sTkTXRqVyHMjRGynRjTmTlW+2I/yj7FUhgqZfKwr
 cfAEzFp5FYgpIknsDpQXPSKvVVqTyeH/f4srGkESX1mDgwTLDAE2oDidIlH70GViNfAC
 xvjDiDfYYjQNnNTlYwXKA/Yk2Sz/JXP4ZB079w+zvtRSAwjHRYbUnNA2NvxufC9U0JFZ
 dAHxUkUzOVXqRJBpMD0+uAbvjKaFhyA5VkEZz61YJzpbYBTo0VDVOxK9b5UGOEAwh2vA
 9PKgvSXiKcG/P8aQoWwBGsdZPotrzwQmGojzs9Ubatt2muMB9WxyfcfgmfwwUbDbh5Ju
 l2uw==
X-Gm-Message-State: AOJu0Yz2Mru7eNGu6NuKSnedTWvqw88tb6WsixCTMvBmBf+SopGlvuIl
 I5npp6qSUDVag5eQbM08cOwuRQ==
X-Google-Smtp-Source: AGHT+IFz6UShsuVuH9yGA3UIsXz5SFwou7gpXgsrx5zub0VqjKnqsV8k433t7qnGt7N1mp8bxVN0eA==
X-Received: by 2002:a05:6808:1785:b0:3a7:64b4:81b0 with SMTP id
 bg5-20020a056808178500b003a764b481b0mr7376828oib.25.1694697664385; 
 Thu, 14 Sep 2023 06:21:04 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.131.115])
 by smtp.gmail.com with ESMTPSA id
 q13-20020a62e10d000000b0068fb43a72c3sm1318354pfh.20.2023.09.14.06.21.03
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 14 Sep 2023 06:21:03 -0700 (PDT)
Message-ID: <bc82e6f8-c3e7-9aef-a29a-8dade45c199a@linaro.org>
Date: Thu, 14 Sep 2023 06:21:02 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH] target/mips: Fix TX79 LQ/SQ opcodes
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>,
 Aurelien Jarno <aurelien@aurel32.net>, qemu-stable@nongnu.org
References: <20230914090447.12557-1-philmd@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230914090447.12557-1-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::22e;
 envelope-from=richard.henderson@linaro.org; helo=mail-oi1-x22e.google.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-1.473,
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

On 9/14/23 02:04, Philippe Mathieu-Daudé wrote:
> The base register address offset is*signed*.
> 
> Cc:qemu-stable@nongnu.org
> Fixes: aaaa82a9f9 ("target/mips/tx79: Introduce LQ opcode (Load Quadword)")
> Signed-off-by: Philippe Mathieu-Daudé<philmd@linaro.org>
> ---
>   target/mips/tcg/tx79.decode | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~


Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C7329745D88
	for <lists+qemu-devel@lfdr.de>; Mon,  3 Jul 2023 15:35:03 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qGJbD-00053x-4a; Mon, 03 Jul 2023 09:28:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qGJa0-0003wa-5Q
 for qemu-devel@nongnu.org; Mon, 03 Jul 2023 09:27:02 -0400
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qGJZy-00015Q-9t
 for qemu-devel@nongnu.org; Mon, 03 Jul 2023 09:26:59 -0400
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-313fb7f0f80so4927841f8f.2
 for <qemu-devel@nongnu.org>; Mon, 03 Jul 2023 06:26:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1688390816; x=1690982816;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=qspqHBXJZ9iSKqAPZji5GH8dMqbLtY8WG4N+RESPXF4=;
 b=yEyMS9/ddyGKEw8VNIF22TjyiY6SKPQw62jzK8Te3u9qidu7wAKySbP9etb/H4mQB8
 I8a5KwjGWWxGGAa3lpnPwUvMHKmnLzlhxl48Fijie93IiBEclAYe/w5u37SAvs7GwpXO
 dm29n7SWbRr/5r13LAQtoeHMaodOFHcNee+2COY9owyyRRh/9l1aXGBrXXaTtScH3Krs
 ZjzP+l622OxuxRFZmMnTUpE3i4BgU9vrp8/uljwY77LLUVyuMq5eqOYYXlTOn29pOI6H
 y9rQ/hziA6C9dRknUWerKc83HKk8cIyc1JGIWSTLEak/g7uGhYDp2DSTZcUhATNHa5UB
 PMuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688390816; x=1690982816;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=qspqHBXJZ9iSKqAPZji5GH8dMqbLtY8WG4N+RESPXF4=;
 b=QQ6jv7J0nuBDuHz66ZUPLzkEosS6POhxUl+85t5vpX0PyYoM02OfWa+lRSGyajL5kK
 TQiyy7Yl20p2Xu9wH0wU3/5J04gc4QXKQCZ8aGp1O7mzrYbWDxr2BPNPOIOA8tKEqm7Y
 MjlBwzH8lbIbEmVNtYtFewqkGE1ue0Yf+6SSF9oAbiOzVWtCKdAdlNDX5N9wox4R1e18
 b4ZtDHomGgFW3G0tK/FPQzkUKWrMulaed/3ZDfPS2YUP5HBXcAqvlZ06ew1jHH/nTKyN
 z92WooVB7qZCrnFT/40p9kLITPz7b/1wGm0/ek6AHHJ1QLIxwcB558biO5O+rxK84ZWD
 VdQg==
X-Gm-Message-State: ABy/qLYvUFui9NAwPdQhGJE68oPB8vVaCWFhfpLubE/h8RkC5soS+h4j
 xNud92cqWWMEQXYaDRDnAKoVyA==
X-Google-Smtp-Source: APBJJlG7Eosz0+KiSwgjcoxhj3t4JmsKsNiqnqrg1Jn/ud9AcQUwvK2aM58SabyDPRDHQbSV9urj8Q==
X-Received: by 2002:a5d:4947:0:b0:314:35df:4a3e with SMTP id
 r7-20020a5d4947000000b0031435df4a3emr2674034wrs.7.1688390816416; 
 Mon, 03 Jul 2023 06:26:56 -0700 (PDT)
Received: from [192.168.69.115] ([176.176.178.91])
 by smtp.gmail.com with ESMTPSA id
 x2-20020a5d54c2000000b003142439c7bcsm8550249wrv.80.2023.07.03.06.26.54
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 03 Jul 2023 06:26:56 -0700 (PDT)
Message-ID: <9fbf9403-fbfe-4d84-7ca4-aae19e9d207e@linaro.org>
Date: Mon, 3 Jul 2023 15:26:52 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.12.0
Subject: Re: [PATCH v3] target/ppc: Make checkstop actually stop the system
Content-Language: en-US
To: Nicholas Piggin <npiggin@gmail.com>, qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, Daniel Henrique Barboza <danielhb413@gmail.com>,
 =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>,
 David Gibson <david@gibson.dropbear.id.au>, Greg Kurz <groug@kaod.org>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 BALATON Zoltan <balaton@eik.bme.hu>
References: <20230703120340.45349-1-npiggin@gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230703120340.45349-1-npiggin@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42a;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42a.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.09,
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

On 3/7/23 14:03, Nicholas Piggin wrote:
> checkstop state does not halt the system, interrupts continue to be
> serviced, and other CPUs run. Stop the machine with
> qemu_system_guest_panicked.
> 
> Change the logging not to print separately to stderr because a
> checkstop is a guest error (or perhaps a simulated machine error)
> rather than a QEMU error. CPU registers are dumped.
> 
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>

<here ...>

> 
> Since v1:
> - Fix loop exit so it stops on the checkstop-causing instruction, rather than
>    after it.
> 
> Since v2:
> - Rebase on ppc-next.

[*]

> - Use qemu_system_guest_panicked rather than vm_stop (Richard)
> - Move away from printing to stderr (Zoltan)
> - Reduce changes to log messages.
> - Split out from larger series since it's independent (will skip attn
>    instruction for now).
> ---

... goes this line, so the version changes are stripped out
when the patch is applied (usually they are not useful in the
git history).

>   target/ppc/excp_helper.c | 26 ++++++++++++++++++--------
>   1 file changed, 18 insertions(+), 8 deletions(-)



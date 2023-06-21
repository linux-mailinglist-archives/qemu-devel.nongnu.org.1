Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CE686737A94
	for <lists+qemu-devel@lfdr.de>; Wed, 21 Jun 2023 07:20:25 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qBqFc-0004Do-TZ; Wed, 21 Jun 2023 01:19:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qBqFZ-0004Df-Cx
 for qemu-devel@nongnu.org; Wed, 21 Jun 2023 01:19:26 -0400
Received: from mail-ej1-x636.google.com ([2a00:1450:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qBqFV-000124-LO
 for qemu-devel@nongnu.org; Wed, 21 Jun 2023 01:19:25 -0400
Received: by mail-ej1-x636.google.com with SMTP id
 a640c23a62f3a-988689a5f44so399318166b.1
 for <qemu-devel@nongnu.org>; Tue, 20 Jun 2023 22:19:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1687324759; x=1689916759;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=/HN+yKqUD/yA9EKDJLg6477lfuJWVRhwH0D6rVXvrhc=;
 b=wgFzTQBvHD9Vv9XJmf1XtwzMUB4wrKqbwAiXCSPiVIdMb9rUGHHyMOkjprvngLrcQn
 Jw7dCxD2DHi28G+MQirewRA2IpkuwPd+dOQ/ORKvCWbbtHs/+LqOAMdNU+vG7XZcKM0E
 F33IRS8ALa/0iV+fXc6NaDv6bOROw4LTdjycyi3z4+JdNeNP3CPZreI55nFvXGYyha5u
 eX9re60rvaFemx99jOHflYbkpHMj2hm+cyF1CVPHDpRzUnao7TjI5ZQyJbcYlofLGW6j
 LF7PLNizLrDNTOLCAKazUoNOBBfzuv/YyfVooQZGXXjCNMRXOXl8poZvAIXwXxRkkVNe
 FFMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687324759; x=1689916759;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=/HN+yKqUD/yA9EKDJLg6477lfuJWVRhwH0D6rVXvrhc=;
 b=Mf1T4z7UynEMZnDvbhjLvpThTRuMKvVrHTQ4Og1pfBq73ZhQ5M6/U84yDZ3B0nRa5I
 caWAbBmisdwscEFWsRJTwR9L+9YcBHLuYxz57sh4CTRZBFcMC/ysdifN7W744KRb8aw5
 ZvbYmIHuMAh8D5acxvmG5kdot8iWnV4XUdci4tDMxaHCrV0mlIBxX1/mrbj/YUor1v0W
 jMDRP41WjBYZyYMXflj7WmTzekME6QpYK1H0FMn5KP/EClvfohQl7hAk9xC7yOuQmk+P
 SiGynk6Y1tY3975gUAzgBW12VS+o3UdjnXXExLwPMhpDCzFXVIL2b72Y22fb6wJbpEtT
 iBmg==
X-Gm-Message-State: AC+VfDy2J/6c8qRu8B83zw+R53vNrlJLrLTBVTNKgrWjLCsNEf6IDwxn
 llhy9ubi3rSA4Q5AFbc2UAsWx7nM86AbGGeI1+/EORl+
X-Google-Smtp-Source: ACHHUZ7TbOhz9kQpzU3FyBZybfUtaVMILUh3L19eIjaaETMkQA1YXfi0ZN4HWGodLvnllP84eaizfA==
X-Received: by 2002:a17:906:9b88:b0:988:91cb:afd1 with SMTP id
 dd8-20020a1709069b8800b0098891cbafd1mr8222160ejc.29.1687324759245; 
 Tue, 20 Jun 2023 22:19:19 -0700 (PDT)
Received: from [192.168.69.129] ([176.176.128.70])
 by smtp.gmail.com with ESMTPSA id
 u9-20020a17090617c900b0098768661505sm2474982eje.117.2023.06.20.22.19.18
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 20 Jun 2023 22:19:18 -0700 (PDT)
Message-ID: <5b2bf86d-44fa-35ae-8049-b395d715adcb@linaro.org>
Date: Wed, 21 Jun 2023 07:19:16 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH] Revert "cputlb: Restrict SavedIOTLB to system emulation"
Content-Language: en-US
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
References: <20230620175712.1331625-1-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230620175712.1331625-1-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::636;
 envelope-from=richard.henderson@linaro.org; helo=mail-ej1-x636.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.09,
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

On 6/20/23 19:57, Peter Maydell wrote:
> This reverts commit d7ee93e24359703debf4137f4cc632563aa4e8d1.
> 
> That commit tries to make a field in the CPUState struct not be
> present when CONFIG_USER_ONLY is set.  Unfortunately, you can't
> conditionally omit fields in structs like this based on ifdefs that
> are set per-target.  If you try it, then code in files compiled
> per-target (where CONFIG_USER_ONLY is or can be set) will disagree
> about the struct layout with files that are compiled once-only (where
> this kind of ifdef is never set).
> 
> This manifests specifically in 'make check-tcg' failing, because code
> in cpus-common.c that sets up the CPUState::cpu_index field puts it
> at a different offset from the code in plugins/core.c in
> qemu_plugin_vcpu_init_hook() which reads the cpu_index field.  The
> latter then hits an assert because from its point of view every
> thread has a 0 cpu_index. There might be other weird behaviour too.
> 
> Mostly we catch this kind of bug because the CONFIG_whatever is
> listed in include/exec/poison.h and so the reference to it in
> build-once source files will then cause a compiler error.
> Unfortunately CONFIG_USER_ONLY is an exception to that: we have some
> places where we use it in "safe" ways in headers that will be seen by
> once-only source files (e.g.  ifdeffing out function prototypes) and
> it would be a lot of refactoring to be able to get to a position
> where we could poison it.  This leaves us in a "you have to be
> careful to walk around the bear trap" situation...
> 
> Fixes: d7ee93e243597 ("cputlb: Restrict SavedIOTLB to system emulation")
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>   include/hw/core/cpu.h | 6 ++----
>   1 file changed, 2 insertions(+), 4 deletions(-)

Ho hum, thanks.  I'll apply this directly.

r~



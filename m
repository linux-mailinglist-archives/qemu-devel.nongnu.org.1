Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1457EAA6093
	for <lists+qemu-devel@lfdr.de>; Thu,  1 May 2025 17:16:07 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uAVdi-0004xO-Ew; Thu, 01 May 2025 11:15:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uAVdb-0004kD-QZ
 for qemu-devel@nongnu.org; Thu, 01 May 2025 11:15:51 -0400
Received: from mail-pj1-x102f.google.com ([2607:f8b0:4864:20::102f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uAVdZ-00021y-MM
 for qemu-devel@nongnu.org; Thu, 01 May 2025 11:15:47 -0400
Received: by mail-pj1-x102f.google.com with SMTP id
 98e67ed59e1d1-3081fe5987eso1112242a91.3
 for <qemu-devel@nongnu.org>; Thu, 01 May 2025 08:15:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746112544; x=1746717344; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=o9YF4VdarcUzqcru+xCQ9pFm43bwCCqoeOh82TAihtU=;
 b=IWkGIxbwdNyp4GuriaHPGBbMlJPwkBAM381EiSOxrj/avM4Jxph6mR0rEWEQmoMNMm
 2ojAjLqxiPPcOE7O4V+0tOjXfK4Y5x3Rl2sgpufHl0qc34KYOmwHDLC5s+Y+2Dbdqrxt
 uWBQURVaLnkG9tJIDOxHN7jr1qAWE65QqXHW3yo+o14Jyb7+zkA2UCJDEQhRdNqNlTc3
 ABfMsrES7klYwvqJyg2HeY+3FPzZjg5pnv8pzf5uimqyTaK+pKAJZ0UlVHpRkeURVYly
 xZCpPIW1oLrVgbCtGQiWlfGkGAgHDsIBD9lKDGdFUcKGpwmBqdJyQZ7OGhe1GxgMO3tr
 Iu1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746112544; x=1746717344;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=o9YF4VdarcUzqcru+xCQ9pFm43bwCCqoeOh82TAihtU=;
 b=qU7kqTJ9FBx5hnV/5RzKm9M8ay+InbV1SmxWiHzZZR8rhJuKbXvPBNWKO9r8xmAXJn
 vXfnVpa+CwRzwijbJoXvgC1dWCb5dlLYfSK6FPyCat1xbSJu66a8/X3Afk9lyB7eP+9H
 aw7O37Ey3Wi/gdz0bLTiOeaZ6Sc8Y7QMUC8mMGRqAyXIaTm9VzXGXeYpDzuySm4Eidy+
 TOJUwpnkvBu+BFKC1nXtxYlPKfAn7bUdiwAxpACp94AmxrQvu/V6vbNw6uw3EqgIL9Ii
 AXTT1YhvPCG4m+rZ8977nlas8FM2XK6FVp/qhKjI62j5dB6Lw1lWnd6O59HlBfZcSX1T
 /Ibw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUcLeQh+nYj8ENFslrv4CmmcVz7Uym1cvuLUskCUERYYV2MlrpGLirfoVC3+zTyXC07ixrKz+020XCT@nongnu.org
X-Gm-Message-State: AOJu0Ywgea/aaDqbrSEOkvxdyGBziWAsvb7amTmrcHjccKzFVaqeoGWc
 0fmJdvjxgiIhfbtbgIpp//UNhf1Bi55DuGkbrFL8L7qYXtMsv98oUnn5or0VPG4=
X-Gm-Gg: ASbGncsSkFsHQUzt6O4xbUwLZeO+qh9PfSztt5/Tyf0MkOHN+CNjA2JCSyLqFggBIcQ
 vXJsTumQUF9eshSBfd0rVEBhh46KAjk56i65UOvZbAUZFowbTyvhZp3PX+24aVY2HnwuJm27ija
 DeIRaZEHPIPFIaFKBo0CEmKl1oqbRNCZXGDiaG2rwjoRUgV4f1smuSF43AKUerB79IzKsleoiYB
 Bn6XkwncJDlIhWb18iXW7KGkuFgKEcbvVkz//+73JLVveWoq7YUomFRkN+fSpnwQdTTYWmcRmR7
 sdZM6yU88f68v6YRX+4dmH51rc7HpB0+EqAToQbZpWZI93+ZBOhkdp1dxqINbuG3STWXnw0IlKB
 Vihb3nPs=
X-Google-Smtp-Source: AGHT+IERIGRaWjaqtZwcbtTyPeLfdjPE0lHKg9DKCKEf2LmmlpAdU1RNvXJwqWOBdTUZoY4u10k+pQ==
X-Received: by 2002:a17:90b:5388:b0:305:5f25:fd30 with SMTP id
 98e67ed59e1d1-30a343ce769mr10555550a91.4.1746112544064; 
 Thu, 01 May 2025 08:15:44 -0700 (PDT)
Received: from [192.168.0.4] (71-212-47-143.tukw.qwest.net. [71.212.47.143])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-30a34826760sm3755129a91.46.2025.05.01.08.15.43
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 01 May 2025 08:15:43 -0700 (PDT)
Message-ID: <67d187a1-95d3-4e9a-a891-ae8090e7c6b6@linaro.org>
Date: Thu, 1 May 2025 08:15:42 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 20/33] target/arm/helper: replace target_ulong by vaddr
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 alex.bennee@linaro.org, Paolo Bonzini <pbonzini@redhat.com>, anjo@rev.ng,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 kvm@vger.kernel.org
References: <20250501062344.2526061-1-pierrick.bouvier@linaro.org>
 <20250501062344.2526061-21-pierrick.bouvier@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250501062344.2526061-21-pierrick.bouvier@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102f;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x102f.google.com
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

On 4/30/25 23:23, Pierrick Bouvier wrote:
> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
> ---
>   target/arm/helper.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/target/arm/helper.c b/target/arm/helper.c
> index 085c1656027..595d9334977 100644
> --- a/target/arm/helper.c
> +++ b/target/arm/helper.c
> @@ -10641,7 +10641,7 @@ static void arm_cpu_do_interrupt_aarch64(CPUState *cs)
>       ARMCPU *cpu = ARM_CPU(cs);
>       CPUARMState *env = &cpu->env;
>       unsigned int new_el = env->exception.target_el;
> -    target_ulong addr = env->cp15.vbar_el[new_el];
> +    vaddr addr = env->cp15.vbar_el[new_el];
>       unsigned int new_mode = aarch64_pstate_mode(new_el, true);
>       unsigned int old_mode;
>       unsigned int cur_el = arm_current_el(env);

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~


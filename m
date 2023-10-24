Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C07267D4B56
	for <lists+qemu-devel@lfdr.de>; Tue, 24 Oct 2023 10:57:55 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qvDE4-0004QI-KJ; Tue, 24 Oct 2023 04:57:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qvDDz-0004PV-5t
 for qemu-devel@nongnu.org; Tue, 24 Oct 2023 04:57:19 -0400
Received: from mail-wr1-x42f.google.com ([2a00:1450:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qvDDw-0007Gz-5d
 for qemu-devel@nongnu.org; Tue, 24 Oct 2023 04:57:18 -0400
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-3296b3f03e5so2928911f8f.2
 for <qemu-devel@nongnu.org>; Tue, 24 Oct 2023 01:57:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698137834; x=1698742634; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Gszw/S1ONrfVdry4P+PqiQ2HuI5f/oqQSX0OoRQiEJ4=;
 b=g5lp50Mqzxw9OqSNooYkbbJ3lldOGVd4etaqO7drRAt7BgOSn9z8ipg1bZIHVyeh7G
 8XZyzGUEk9qiwSkap2alTh1sKIBevZH2Bafsv3hDpsqWHpIr68iR/4zeJQcRGlSvCmDP
 c5LWPS4dLm6UWSBXf8RVh2Xgvp4rgsHjsPRaUrIfBbgoaaX8Z2jrQ5tZU7p4CyNE5f8c
 9N9WvY8KX+6QmjDCZEBRQS/1GBtqepzHUml7XZJikaMYgs4AyvwspRPoYcBOzQ0aa0Z/
 nKqH6yASFtmaAxgvpk3+bLedADILqtMie87KikSh/aoEYw+Z0K2ZRP6XTNtV5LgduoNX
 4Xvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698137834; x=1698742634;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Gszw/S1ONrfVdry4P+PqiQ2HuI5f/oqQSX0OoRQiEJ4=;
 b=ZIlkoax6Kx4J5j1g77IwJxZFd5pbmjyUCSXf/UNBicAdabxfk/gnm4XJyUBYyCaakm
 fsORbze26xxrinvL+uiScelIogz3e5vIkC6nUljrzW6teBfcRfxaH4+ppXG4mzOqHYg+
 Xir10Fe9CartgWlRfg/T118T5SV7IFxZv9LojNlltSlw9PjySAjjAyNuWzfxpfStlBdH
 pW74myuomQs+eagkCXUi8U+jfnsX99WM6ntnIFB71JaHiVcRQvP4HN7mMHtLEotZs92l
 +sPiEm/XuH8zP67M2jtJIav0kIvEnNJpYylsil3XpYv4HVWXCvwQnS/PG3KTJStqxLyo
 R2xw==
X-Gm-Message-State: AOJu0Yxb7nALkKokunq6SLsKOzEDXe8xA77Iomc7afBZ4sPQO8NXMOrq
 +obutLcgdIgtY0kt0L42OfOrHA==
X-Google-Smtp-Source: AGHT+IFtwrUF+8k8xANbIN5hy3kHSKo9lIXw01dFhRivRZ/AO9TuEnlYPVLXVT7c2DtBCv18DK8vvg==
X-Received: by 2002:a5d:4529:0:b0:32d:8246:5c67 with SMTP id
 j9-20020a5d4529000000b0032d82465c67mr7809278wra.29.1698137834395; 
 Tue, 24 Oct 2023 01:57:14 -0700 (PDT)
Received: from [192.168.69.115] (sem44-h01-176-172-55-165.dsl.sta.abo.bbox.fr.
 [176.172.55.165]) by smtp.gmail.com with ESMTPSA id
 p17-20020a5d68d1000000b0032d687fd9d0sm9477700wrw.19.2023.10.24.01.57.13
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 24 Oct 2023 01:57:14 -0700 (PDT)
Message-ID: <e3592631-42f0-dc03-96b8-dee41458d0a0@linaro.org>
Date: Tue, 24 Oct 2023 10:57:11 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.1
Subject: Re: [PATCH 7/9] target/mips: Use tcg_gen_sextract_tl
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, Aurelien Jarno <aurelien@aurel32.net>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>,
 Siarhei Volkau <lis8215@gmail.com>
References: <20231023160944.10692-1-philmd@linaro.org>
 <20231023160944.10692-8-philmd@linaro.org>
 <d9092d0e-852e-43f7-a087-be0781744e6e@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <d9092d0e-852e-43f7-a087-be0781744e6e@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42f;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42f.google.com
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

On 24/10/23 02:14, Richard Henderson wrote:
> On 10/23/23 09:09, Philippe Mathieu-Daudé wrote:
>> Inspired-by: Richard Henderson <richard.henderson@linaro.org>
>> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>> ---
>>   target/mips/tcg/mxu_translate.c | 6 ++----
>>   1 file changed, 2 insertions(+), 4 deletions(-)
>>
>> diff --git a/target/mips/tcg/mxu_translate.c 
>> b/target/mips/tcg/mxu_translate.c
>> index c517258ac5..6eb73256b2 100644
>> --- a/target/mips/tcg/mxu_translate.c
>> +++ b/target/mips/tcg/mxu_translate.c
>> @@ -3840,8 +3840,7 @@ static void gen_mxu_Q16SAT(DisasContext *ctx)
>>               tcg_gen_movi_tl(t0, 255);
>>               gen_set_label(l_lo);
>> -            tcg_gen_shli_tl(t1, mxu_gpr[XRb - 1], 16);
>> -            tcg_gen_sari_tl(t1, t1, 16);
>> +            tcg_gen_sextract_tl(t1, mxu_gpr[XRb - 1], 0, 16);
> 
> The most simple replacement here is tcg_gen_ext16s_tl.
> 
> I'll also note that the entire function should be replaced, e.g.
> 
>      TCGv min = tcg_constant_tl(0);
>      TCGv max = tcg_constant_tl(0xff);
>      TCGv tmp[2];
> 
>      tmp[0] = tcg_temp_new();
>      tmp[1] = tcg_temp_new();
> 
>      for (i = 0; i < 4; i++) {
>          int rs = i & 2 ? XRc : XRb;
>          TCGv t = tmp[i & 1];
> 
>          gen_load_mxu_gpr(t, rs);
>          tcg_gen_sextract_tl(t, t, (i & 1) * 16, 16);
>          tcg_gen_smax_tl(t, t, min);
>          tcg_gen_smin_tl(t, t, max);
>          if (i != 0) {
>              tcg_gen_shli_tl(t, t, i * 8);
>              tcg_gen_or_tl(t, t, tmp[(i - 1) & 1];
>          }
>      }
>      gen_store_mxu_gpr(tmp[1], XRa);
> 
> 
> And lots of other similar work within this file.  :-/

Yeah, this code is upported from some old tree. It should
use the TCG GVec API. See:
https://lore.kernel.org/qemu-devel/781894e9-2565-b54f-8df3-9cbd1cf68e2a@linaro.org/



Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 538AD7D5936
	for <lists+qemu-devel@lfdr.de>; Tue, 24 Oct 2023 18:56:15 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qvKgq-0005x3-Ae; Tue, 24 Oct 2023 12:55:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qvKgn-0005vx-Sh
 for qemu-devel@nongnu.org; Tue, 24 Oct 2023 12:55:33 -0400
Received: from mail-ej1-x62b.google.com ([2a00:1450:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qvKgl-0001xD-TH
 for qemu-devel@nongnu.org; Tue, 24 Oct 2023 12:55:33 -0400
Received: by mail-ej1-x62b.google.com with SMTP id
 a640c23a62f3a-9becde9ea7bso1214365666b.0
 for <qemu-devel@nongnu.org>; Tue, 24 Oct 2023 09:55:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698166530; x=1698771330; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:references:cc:to:from
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=xrWafQIiBseQvpnl3tcykrM7SyT8VfzRtTrQ0ss2/Mg=;
 b=jUhl9txz7NUfGiF5mc+KZWdFHg+BIBuVd/mOcoYIcE7tO+3yl+DmxHnVu/7j/BwB2Q
 VdKimihRCcT72S0/Tmhp3JKCWG/91db54k2YKWrPeHWOOgcllqqFpdxTLci1Ny2y5TxM
 oW1K7OKi5ysw8JRxQaY175S5SdOWg3lsaTDOMrV6VUSvjjuVG2k3svp/InkHdLZi28MW
 twmWdjkGu+52RQ1SnvlQBtz/TaqkYzG2jY2XYq1uiWTTXXS+HOVCrXVh1+HsIebr6atm
 6qSbMZSBAMUU4l+oV3id8baSKcbUH3GQnoB+Ak8/HVhY0F5qsAuheRB0SxTsoN+5IL+A
 U6Eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698166530; x=1698771330;
 h=content-transfer-encoding:in-reply-to:references:cc:to:from
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=xrWafQIiBseQvpnl3tcykrM7SyT8VfzRtTrQ0ss2/Mg=;
 b=kWW8ltlA4YSpkdY7eok9koJBmGEcL1YAIbRPBigDg5uS1pJ9S+k9h9+3tPsdxMXcEG
 djUyQPMNPbG2IL8HVTHheKSu/xhjlktwMRsLxa5AhOxkYs46jaLDLn9WeMj4oc7oaQ3I
 f+4Weu7rjGVxeIjWFRnbsIiPfhXQl5bmQp3krdTW0g0fspHRJfr/aESUrU2yEutiyaw5
 JSnJ5HV5ab//f5KHNdoyiBG2gelRNXRhxjG1k8zCvla9ZTXyqa6zCBUdEVsggKkebYsf
 sktMRdp5AU92Nwe/I+CP7EWKB5uQVOARqeQ2jPpwDjnAsdxP9k/AoTXwjIYKx62LdETQ
 /gRg==
X-Gm-Message-State: AOJu0YwdRmh/Q+2uff8n8UVuwlv1w2E60wpgv6GBoSwqzlc2dze2VBaN
 L8k25iMH1BYViGwZrrS3tECL8A==
X-Google-Smtp-Source: AGHT+IGA4XodaumW8ZR/jGUh7a15HaQAitV9mUzlBIYwMQJ64k3cUh9R239u5Vfj2XbM3Jp3ZH+N2A==
X-Received: by 2002:a17:907:6ea5:b0:9a5:962c:cb6c with SMTP id
 sh37-20020a1709076ea500b009a5962ccb6cmr15441446ejc.31.1698166530077; 
 Tue, 24 Oct 2023 09:55:30 -0700 (PDT)
Received: from [192.168.69.115] (sem44-h01-176-172-55-165.dsl.sta.abo.bbox.fr.
 [176.172.55.165]) by smtp.gmail.com with ESMTPSA id
 kb3-20020a1709070f8300b009adcb6c0f0esm8484568ejc.193.2023.10.24.09.55.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 24 Oct 2023 09:55:29 -0700 (PDT)
Message-ID: <ced280b5-fb44-31a0-8dc8-5769fc79b871@linaro.org>
Date: Tue, 24 Oct 2023 18:55:27 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.1
Subject: Re: [PATCH 7/9] target/mips: Use tcg_gen_sextract_tl
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, Aurelien Jarno <aurelien@aurel32.net>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>,
 Siarhei Volkau <lis8215@gmail.com>
References: <20231023160944.10692-1-philmd@linaro.org>
 <20231023160944.10692-8-philmd@linaro.org>
 <d9092d0e-852e-43f7-a087-be0781744e6e@linaro.org>
 <e3592631-42f0-dc03-96b8-dee41458d0a0@linaro.org>
In-Reply-To: <e3592631-42f0-dc03-96b8-dee41458d0a0@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62b;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x62b.google.com
X-Spam_score_int: -53
X-Spam_score: -5.4
X-Spam_bar: -----
X-Spam_report: (-5.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-3.339,
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

On 24/10/23 10:57, Philippe Mathieu-Daudé wrote:
> On 24/10/23 02:14, Richard Henderson wrote:
>> On 10/23/23 09:09, Philippe Mathieu-Daudé wrote:
>>> Inspired-by: Richard Henderson <richard.henderson@linaro.org>
>>> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>>> ---
>>>   target/mips/tcg/mxu_translate.c | 6 ++----
>>>   1 file changed, 2 insertions(+), 4 deletions(-)
>>>
>>> diff --git a/target/mips/tcg/mxu_translate.c 
>>> b/target/mips/tcg/mxu_translate.c
>>> index c517258ac5..6eb73256b2 100644
>>> --- a/target/mips/tcg/mxu_translate.c
>>> +++ b/target/mips/tcg/mxu_translate.c
>>> @@ -3840,8 +3840,7 @@ static void gen_mxu_Q16SAT(DisasContext *ctx)
>>>               tcg_gen_movi_tl(t0, 255);
>>>               gen_set_label(l_lo);
>>> -            tcg_gen_shli_tl(t1, mxu_gpr[XRb - 1], 16);
>>> -            tcg_gen_sari_tl(t1, t1, 16);
>>> +            tcg_gen_sextract_tl(t1, mxu_gpr[XRb - 1], 0, 16);
>>
>> The most simple replacement here is tcg_gen_ext16s_tl.
>>
>> I'll also note that the entire function should be replaced, e.g.
>>
>>      TCGv min = tcg_constant_tl(0);
>>      TCGv max = tcg_constant_tl(0xff);
>>      TCGv tmp[2];
>>
>>      tmp[0] = tcg_temp_new();
>>      tmp[1] = tcg_temp_new();
>>
>>      for (i = 0; i < 4; i++) {
>>          int rs = i & 2 ? XRc : XRb;
>>          TCGv t = tmp[i & 1];
>>
>>          gen_load_mxu_gpr(t, rs);
>>          tcg_gen_sextract_tl(t, t, (i & 1) * 16, 16);
>>          tcg_gen_smax_tl(t, t, min);
>>          tcg_gen_smin_tl(t, t, max);
>>          if (i != 0) {
>>              tcg_gen_shli_tl(t, t, i * 8);
>>              tcg_gen_or_tl(t, t, tmp[(i - 1) & 1];
>>          }
>>      }
>>      gen_store_mxu_gpr(tmp[1], XRa);

I'll tag your suggestion for later, thanks!

>> And lots of other similar work within this file.  :-/
> 
> Yeah, this code is upported from some old tree. It should
> use the TCG GVec API. See:
> https://lore.kernel.org/qemu-devel/781894e9-2565-b54f-8df3-9cbd1cf68e2a@linaro.org/
> 



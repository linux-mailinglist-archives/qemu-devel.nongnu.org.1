Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 30A36709859
	for <lists+qemu-devel@lfdr.de>; Fri, 19 May 2023 15:31:40 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q00Bc-0003PU-9l; Fri, 19 May 2023 09:30:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q00Ba-0003PD-4i
 for qemu-devel@nongnu.org; Fri, 19 May 2023 09:30:22 -0400
Received: from mail-pl1-x62b.google.com ([2607:f8b0:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q00BY-0005O4-1w
 for qemu-devel@nongnu.org; Fri, 19 May 2023 09:30:21 -0400
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-1a516fb6523so30924765ad.3
 for <qemu-devel@nongnu.org>; Fri, 19 May 2023 06:30:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1684503018; x=1687095018;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=xzVhHKbZ2mR1wPsTPQ0oiOD+r1sjZF7340pwhoUEuHE=;
 b=Z8FVP6itoUtel8zEWSv2bNyGwO+6ni2kSqiCq+5xxF4715a2sFDwXT63XsVHymMk4p
 pJR65tFwxPXAyFt4s+xXvO/tgA91hb8iP7+aN8KL4LgR2JMaPz7ZyWrnFPsHzNXOA0uv
 HVWB7o4X5EB4k1bfcJODRzajKKXIo8qolB3+0j+xcpYAko4bRZ41Inkz/A+XA6fQYir7
 waadT7FcfgKDQw/k9p+cybBeCCgyYa02VvwJkcs9UWiEZ4CM0fJknPs+YyaWB7PhJ3Rl
 P6Okm4y+bRkLM5+9QLQwNlh5F62qO2KCoLUsH7oSHpi58IdbJluQw2amwZbVytZhYLbh
 JwfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684503018; x=1687095018;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=xzVhHKbZ2mR1wPsTPQ0oiOD+r1sjZF7340pwhoUEuHE=;
 b=k18C3fSb8+vUyCKVfTXFbbNgqEJdr2zh/z8wNQLMOHmj/LS+6rwjLGr/Es40hSvSRm
 7e1bRvI7NFR3B7T14DIgeuCS876tj6NCkc2awbWU4CTZIFgTVWhEumrO9Y80w26Od0Yb
 eTjT/mBbqGHmUMjPxWDQxRuwW5BOAFVyV5R3VIINDXxaRrXTWCxEHZc/kkpo29gE/FrQ
 Qk/UmcgM6CaFO5KHa6HDgGE3M4fCZMuJEx4MQqoCnIEEVsZ8TkSJqlFiTQJ1giFivnhH
 74fD20PaAglhSRuIhHQNvBWS/0wQ42NXI/G1iLPzEazrFgZ02vnxKT5ERYM2RLwDT47O
 FHPA==
X-Gm-Message-State: AC+VfDzVK8SrGalM71Lno2TM0wacuoeTgUzHPUd7Am8/xK/b+1+ZXURG
 TBv7lfvTP9qJAHHkmRdvD7Qjow==
X-Google-Smtp-Source: ACHHUZ45r0u03Lby0N1awhRTdo8PT4dRu+GxqxqKR/T7LR4kA+EyeMWDKsg99E3nYW29BpjZHPLTDw==
X-Received: by 2002:a17:902:db0a:b0:1ac:5c90:23e with SMTP id
 m10-20020a170902db0a00b001ac5c90023emr3407389plx.7.1684503018309; 
 Fri, 19 May 2023 06:30:18 -0700 (PDT)
Received: from ?IPV6:2602:ae:1598:4c01:686f:d1bb:8fc4:dc38?
 ([2602:ae:1598:4c01:686f:d1bb:8fc4:dc38])
 by smtp.gmail.com with ESMTPSA id
 iw17-20020a170903045100b001ae62d7cb2bsm3397839plb.199.2023.05.19.06.30.17
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 19 May 2023 06:30:17 -0700 (PDT)
Message-ID: <876cc081-8338-aeb9-3c10-7d7318ffd00c@linaro.org>
Date: Fri, 19 May 2023 06:30:15 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: gitlab shared runner time expired
Content-Language: en-US
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel <qemu-devel@nongnu.org>
References: <58b8067d-3136-94ed-f53e-2ccd0feb8c75@linaro.org>
 <CAFEAcA8nKiES473FbfCa=jkTO2SaVTKOgGPoAAFAzaojZZ86jA@mail.gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <CAFEAcA8nKiES473FbfCa=jkTO2SaVTKOgGPoAAFAzaojZZ86jA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62b;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62b.google.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-1.527,
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

On 5/19/23 02:18, Peter Maydell wrote:
> On Thu, 18 May 2023 at 20:27, Richard Henderson
> <richard.henderson@linaro.org> wrote:
>>
>> So, here we are again, out of runner time with 13 days left in the month.
> 
> This is quite early -- have you been processing pull requests
> strictly one at a time, or in (small) batches ?

Mostly one at a time, because most pull requests have had errors.  Every single time I've 
tried to batch them this month it has been futile.


r~


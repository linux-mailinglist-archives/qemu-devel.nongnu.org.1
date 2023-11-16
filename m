Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 638407EDD27
	for <lists+qemu-devel@lfdr.de>; Thu, 16 Nov 2023 09:54:58 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r3Y8t-0007Fd-6e; Thu, 16 Nov 2023 03:54:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1r3Y8q-0007FG-Um
 for qemu-devel@nongnu.org; Thu, 16 Nov 2023 03:54:28 -0500
Received: from mail-ej1-x634.google.com ([2a00:1450:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1r3Y8g-0007QN-HJ
 for qemu-devel@nongnu.org; Thu, 16 Nov 2023 03:54:28 -0500
Received: by mail-ej1-x634.google.com with SMTP id
 a640c23a62f3a-9c41e95efcbso75964866b.3
 for <qemu-devel@nongnu.org>; Thu, 16 Nov 2023 00:54:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1700124857; x=1700729657; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=oMUc5I/jJpnTa8cAqCMl24XkNRu1rsgpgqba0P+wVnA=;
 b=I24Otp5qTT7gRMF/59joTi/OfJQfqMfgrOWu9PJvMbLhB3CKv4zjBQCjDqfJ82QpOz
 47WZUMkhPHK2uT8RaWWd19en/uwGuxOeDdaT59Wj8GTc9B/jnjghuLCze8g1vo0V5RLa
 16FVcMoMbWyTNYxuM29biDxekRlpV7pv/1kxLxyWmgd1kOw6cdAKqlY4ps7R+9RsItiP
 yS3IcOYxSz8E4HmOW9eGwnjhjWreCVCJBco/CEXXh0rvF62jY5S5SSKlPVLiJ6KKeVcG
 /tZDNGYkXSa+COi9Rh7Z2e7h6zpyqMPw+flYgnG0NDog7ki1abcqnDqBoZcnsIfzJzeT
 1UNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700124857; x=1700729657;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=oMUc5I/jJpnTa8cAqCMl24XkNRu1rsgpgqba0P+wVnA=;
 b=n1uOCekb37L6EiQiLABDijAG1mpd2aEkauz0CIqedzfIvRuqo+9kq9+AniIW0/MQ7g
 zU/8k6WcrL1zsKoIFB6/2DGkR8OLyflBOzWsNWDZ8w14cOAVZaL/zkp5vzwkoxuynUg2
 Z86zQhWq1DVoUH+wWzEuXaHODFSGmtBYOwRjLRG/trgAVXJeqMAGlytm3IWCcVH13kLq
 70kGnPUFbwXNC7j27EcqpLlRFKkZhbb7pd7wOQodF/8hKj/EJYgGbj+nxmIMb8vs1mSY
 ZllZac1guyNxFw7dJj4ABpx/jTE3V2YGGpcHLmUK8gtn3ppsdqAM+DS9kZNu8a2mVKrc
 pbgw==
X-Gm-Message-State: AOJu0YwcdhtLSSDEJudK87L8UN5CufcLW3m4qUVyFoYXuhoWXlTj3heH
 qcpuGqoB+vOWbbr5Ug+5pCUaWw==
X-Google-Smtp-Source: AGHT+IFQ1YlP6dZYoJMSJ2QeT5QRQwyfBjRXyse55hXwt1RD0KGgoyJBmstBClgRuSJJbQ9AD9P+/g==
X-Received: by 2002:a17:906:a44e:b0:9e4:6b68:fbef with SMTP id
 cb14-20020a170906a44e00b009e46b68fbefmr10208313ejb.60.1700124856842; 
 Thu, 16 Nov 2023 00:54:16 -0800 (PST)
Received: from [192.168.69.100] ([176.187.220.205])
 by smtp.gmail.com with ESMTPSA id
 dx5-20020a170906a84500b0099bd1a78ef5sm8066432ejb.74.2023.11.16.00.54.15
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 16 Nov 2023 00:54:16 -0800 (PST)
Message-ID: <3839ec93-8fc3-4e30-b554-6bb257e3da6d@linaro.org>
Date: Thu, 16 Nov 2023 09:54:15 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH-for-8.2] virtio-sound: add realize() error cleanup path
Content-Language: en-US
To: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Volker_R_=C3=BC_melin?= <vr_qemu@t-online.de>,
 Gerd Hoffmann <kraxel@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>
References: <20231116072046.4002957-1-manos.pitsidianakis@linaro.org>
 <88363f15-697b-4b04-ad4d-af0aa5fb75aa@linaro.org>
 <47h4g.6wu5d10yw748@linaro.org>
 <688bc783-e56f-4e24-95f6-a69aa4bc8863@linaro.org>
 <47klp.p79qnee6q9fx@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <47klp.p79qnee6q9fx@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::634;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x634.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On 16/11/23 09:48, Manos Pitsidianakis wrote:
> On Thu, 16 Nov 2023 10:42, Philippe Mathieu-Daudé <philmd@linaro.org> 
> wrote:
>> On 16/11/23 08:33, Manos Pitsidianakis wrote:
>>> On Thu, 16 Nov 2023 09:32, Philippe Mathieu-Daudé <philmd@linaro.org> 
>>> wrote:
>>>>> ---
>>>>>
>>>>> Notes:
>>>>>      Requires patch 
>>>>> <20231109162034.2108018-1-manos.pitsidianakis@linaro.org>
>>>>
>>>> This is the 'Based-on: ' tag I guess.
>>>
>>> There is
>>>
>>>   prerequisite-patch-id: 484ec9f7f6109c10d4be0484fe8e3c2550c415f4
>>
>> $ git show 484ec9f7f6109c10d4be0484fe8e3c2550c415f4
>> fatal: bad object 484ec9f7f6109c10d4be0484fe8e3c2550c415f4
>>
>> In which tree can we find this commit? Better to use the msg-id,
>> so tools cat fetch prerequisite.
>>
>> I guess the 'patches' tool understand 'Based-on'. Or was it 'patchew'?
> 
> It's not a commit SHA, that's why. It's a sha produced by git-patch-id 
> --stable. It hashes the diffs of the plain-text patch.
> 
> https://git-scm.com/docs/git-patch-id

Hmm OK I didn't know, but not sure this could be useful in my patch
workflow.

> Yes, whatever works with current tools is best!
> 
> Manos



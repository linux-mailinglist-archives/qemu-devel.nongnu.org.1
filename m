Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 06A1D7A0571
	for <lists+qemu-devel@lfdr.de>; Thu, 14 Sep 2023 15:20:44 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qgmGi-0005pZ-O0; Thu, 14 Sep 2023 09:20:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qgmGg-0005oi-32
 for qemu-devel@nongnu.org; Thu, 14 Sep 2023 09:20:26 -0400
Received: from mail-oi1-x22b.google.com ([2607:f8b0:4864:20::22b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qgmGe-00014B-IF
 for qemu-devel@nongnu.org; Thu, 14 Sep 2023 09:20:25 -0400
Received: by mail-oi1-x22b.google.com with SMTP id
 5614622812f47-3aa1c046659so575649b6e.0
 for <qemu-devel@nongnu.org>; Thu, 14 Sep 2023 06:20:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1694697622; x=1695302422; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=zx/uqGtlEEVl8CtogtbEb0sVM+5Rf+fOAVU7XeVmeVQ=;
 b=N7Lk5vlft+20Vu/OhbAn6NyI3cDTYZfftQWxNcJi32YapOHxnqtK+7t1LxcQ+Ec9i2
 0l4TEe3YR7fqbUXlKz9jGBytH/15F/SwhqJrmzg4MxI3agZ1JYzQgM8iXzJv8oRVRb14
 F6b+xjBebHLup3dOajmI+aZQvC/6IdvyY7H+g/8SNMALwqT3dRRi7wzytxe3WA7vEwdG
 mF2HGCmejcWrp3yZ2wV0YlxrY/YuxFmrj4RjUZuxWIQMaD0zxYvyaJ9hrrZrevPGvKAx
 leza4g/DrrMH78lVDkhhhVGnTusIwISgG3JEs9FcDX0fGXOH2JMBcl+zOAROVkUyNyTw
 jVhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694697622; x=1695302422;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=zx/uqGtlEEVl8CtogtbEb0sVM+5Rf+fOAVU7XeVmeVQ=;
 b=Z0FCHaOY7Fz6HXZc3XbTmt6nmwYoVQBYk1y9ScZ/nrwnuafhcv3KsedoGhnDwc0Q71
 mWY8HxrajKYhbJKG0VJBJayBxFOmiT69CS5LfTShaY+mBpsLRLhEwd1qkT5uqaZErT0o
 hj7qtE1GHjBBIgo6iWZC5VvvjgFgMkKjQQLy/J4zXoxY9hxFYOELGIOp52zrRydPHI5j
 /u6UFWdEv7Pv7DORYwQ32JYPvVlaaaoSqPb9Juy35kRg6q+zy4EIyR+rErtcjgKrQ++7
 vupCChS5lPRAEZPDRtc0CqeFm2pZ508ERyH1SMFnscXQeoVVrBqtgXOhIMVUVu4fohKs
 Cztw==
X-Gm-Message-State: AOJu0YzcymR9FIg10uEe/WF/0v0/f6TCRmLYKSARc6lMoSGSg/EWAwVb
 CRjd0r5DCvUhkIHx5nSSKviVVQ==
X-Google-Smtp-Source: AGHT+IGzghytlEmqSZuDCiGi0bUq4MI/r6VF3e7b9ILROP26uDimGqVHsmNR/8IRue6rGp3noFw3Bw==
X-Received: by 2002:a05:6808:1a13:b0:3a7:b15d:b58c with SMTP id
 bk19-20020a0568081a1300b003a7b15db58cmr6899458oib.34.1694697622061; 
 Thu, 14 Sep 2023 06:20:22 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.131.115])
 by smtp.gmail.com with ESMTPSA id
 w16-20020aa78590000000b0068fece22469sm1329480pfn.4.2023.09.14.06.20.21
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 14 Sep 2023 06:20:21 -0700 (PDT)
Message-ID: <093c4948-ca13-0de0-664c-4c58daa9da2e@linaro.org>
Date: Thu, 14 Sep 2023 06:20:19 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH] target/mips: Fix MSA BZ/BNZ opcodes displacement
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Aurelien Jarno <aurelien@aurel32.net>,
 Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>,
 Ni Hui <shuizhuyuanluo@126.com>, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 qemu-stable@nongnu.org, Sergey Evlashev <vectorchiefrocks@gmail.com>
References: <20230914085807.12241-1-philmd@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230914085807.12241-1-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::22b;
 envelope-from=richard.henderson@linaro.org; helo=mail-oi1-x22b.google.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-1.473,
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

On 9/14/23 01:58, Philippe Mathieu-Daudé wrote:
> The PC offset is*signed*.
> 
> Cc:qemu-stable@nongnu.org
> Reported-by: Sergey Evlashev<vectorchiefrocks@gmail.com>
> Resolves:https://gitlab.com/qemu-project/qemu/-/issues/1624
> Fixes: c7a9ef7517 ("target/mips: Introduce decode tree bindings for MSA ASE")
> Signed-off-by: Philippe Mathieu-Daudé<philmd@linaro.org>
> ---
>   target/mips/tcg/msa.decode | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~


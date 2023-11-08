Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C67A67E538D
	for <lists+qemu-devel@lfdr.de>; Wed,  8 Nov 2023 11:42:38 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r0g0l-0002iU-E8; Wed, 08 Nov 2023 05:42:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1r0g0j-0002hg-BT
 for qemu-devel@nongnu.org; Wed, 08 Nov 2023 05:42:13 -0500
Received: from mail-ej1-x629.google.com ([2a00:1450:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1r0g0h-0001x0-K0
 for qemu-devel@nongnu.org; Wed, 08 Nov 2023 05:42:13 -0500
Received: by mail-ej1-x629.google.com with SMTP id
 a640c23a62f3a-9e1fb7faa9dso322944166b.2
 for <qemu-devel@nongnu.org>; Wed, 08 Nov 2023 02:42:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1699440130; x=1700044930; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:references:cc:to:from
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=ze7TsIR1SPoCiVi7j0NSi7P0uUbi1Jh/VvPQbpP6Jgs=;
 b=KLkT8sVLY0izDRdPA1JzLZNF8osz1tYq/Y7COfLF4Kymm60xzZj5l/pHQuBb+WQPK/
 GSbcnLSSKb3VeRCik35EPLMZCu7k1Pa8mKEWbAxn33GEzjlyalWylCzJ6sAeIwaApy9u
 nD5KTlHU/kKHn8MuhtzjZAt742z4j2NFJ6VdZS5IgnwQfyv4tm5+BaNxWqygMsppON5h
 TnA8xO4WtE+ZqXy2+26TbeaNqnICAHiDv+gp3n6hzQi8bgjiBQwbvvTBfekY4jBkIzoT
 5Q6Js5vRVTwaw/6Y+8XBUj1aKc1l5zrm94BI1dB2FvNyhUbMn5BlkMDYyrA0AocJwnef
 NTjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699440130; x=1700044930;
 h=content-transfer-encoding:in-reply-to:references:cc:to:from
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ze7TsIR1SPoCiVi7j0NSi7P0uUbi1Jh/VvPQbpP6Jgs=;
 b=dclc5v71JmpUUr8PjrxS1VUN9JCsG2eeVQ4mYzg5i+5oo9AqxJfmu2eT1voVyi7Qe6
 lx1K3KbSp0Q5SpTuJUKZdj46TN5xG9VOfwXnHXpP+LJ/Q7CSkC7tCuSVyzKntJkXLh2y
 vD/kbB/DhOeYhOOI0M6d+L+wo0o0wjdkTVh+9RTc+9udjdY9fr4AhAL0Kozea6ueTzaU
 J7bpcqz8eIkVDcnpAsay4YFb5fjXi11Zc7GZHjdceTBFdl6ouSD3x/jcjrEUY6Gl5wI0
 BqSotteNOi9Y0QSxPoq68sLgKdwdomvWsWaJpFEKt/lDPwzlhJF1Y3OonPEAM+W8nkRf
 l2Tw==
X-Gm-Message-State: AOJu0YxUGEeOJsoQD+E5TLGNGU8bD65BUvzknuy53k0HF8pQ7LDs8AsR
 Ksh54sv1THmyKqP00lpArGgSiQ==
X-Google-Smtp-Source: AGHT+IE+4OPRld2dbzgHQw4RfOXxuDDapC/AvbwK3+hUAsYwMMwJEXvxgcCr9pdcZcWRKttDgC8PoA==
X-Received: by 2002:a17:906:d553:b0:9ba:2b14:44f4 with SMTP id
 cr19-20020a170906d55300b009ba2b1444f4mr1131401ejc.49.1699440130027; 
 Wed, 08 Nov 2023 02:42:10 -0800 (PST)
Received: from [192.168.69.115] ([176.187.199.60])
 by smtp.gmail.com with ESMTPSA id
 dx15-20020a170906a84f00b0099cce6f7d50sm833565ejb.64.2023.11.08.02.42.09
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 08 Nov 2023 02:42:09 -0800 (PST)
Message-ID: <7e87bf56-e96d-49c2-aa37-e8eaf3d0b5b2@linaro.org>
Date: Wed, 8 Nov 2023 11:42:08 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] vl: constify default_list
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: marcandre.lureau@redhat.com, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>
References: <20231030101529.105266-1-marcandre.lureau@redhat.com>
 <9d80aef7-084a-b9ee-832f-4e4b7549713e@linaro.org>
In-Reply-To: <9d80aef7-084a-b9ee-832f-4e4b7549713e@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::629;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x629.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

On 30/10/23 11:19, Philippe Mathieu-Daudé wrote:
> On 30/10/23 11:15, marcandre.lureau@redhat.com wrote:
>> From: Marc-André Lureau <marcandre.lureau@redhat.com>
>>
>> It's not modified, let's make it const.
>>
>> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
>> ---
>>   system/vl.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

... and queued via my cpu/misc tree, thanks!




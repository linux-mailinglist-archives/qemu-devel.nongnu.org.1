Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B5AFB83012D
	for <lists+qemu-devel@lfdr.de>; Wed, 17 Jan 2024 09:20:27 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rQ19n-0005lS-IJ; Wed, 17 Jan 2024 03:20:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rQ19i-0005cm-5T
 for qemu-devel@nongnu.org; Wed, 17 Jan 2024 03:20:15 -0500
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rQ19e-0005mn-VW
 for qemu-devel@nongnu.org; Wed, 17 Jan 2024 03:20:13 -0500
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-40b5155e154so129710765e9.3
 for <qemu-devel@nongnu.org>; Wed, 17 Jan 2024 00:20:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1705479609; x=1706084409; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=PU8+Bi/E/EKS18C+pVeQkib9/FEyWy8DaaBM4bDDjx0=;
 b=SOEkXFi6o9m0lK2fvKXNKj8XLIxbuksxwPfH74TRtz0bHpoHbR/zsvguBWd1zP3APW
 fcGA15xzQMTH5+tE0fFIz6IY/eoapcAmiP/Wu73ZtME7A6yohpqGU0WdkKPtu2lbhBQM
 AOoKYBe/mjj7Pb7GbJ47d/XyDM2zcOi/Cn/aEVWTn7eheq46r5peorHFyvNY5PcgrdMD
 r2nlJBNwraL/FF5z8YSrnk6RYUIPrGVGFHJAfEWyD89GB8T5g4PVpOYw6yO/h4KMlsk8
 exOEgTJPOf4OYV8ooWjgirHqNGkZxJD7JqzMiqPZRndfdpFpIFUf58W5KK2G2rTLpGc2
 mchQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705479609; x=1706084409;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=PU8+Bi/E/EKS18C+pVeQkib9/FEyWy8DaaBM4bDDjx0=;
 b=oKm3TzSZCD2YG62+44mVhniRexdZHTBn2fJGipiatJDYrP+Ws2afyQH7LPAZxfWrfG
 W+usNF8aqV6MAH8Zifu+voSoP/DSLKauncMixtvOUR3S8X0/mugGZE2W++UOmqe4Q/jr
 qXjjwZx6U1dKnA2RDAkKJdatxEQ/H8Ui4MwOwDZL9jE5wgq1F/w1JaCLnaH+gJ4/ftXF
 5f8UNk39mWrsvnPiX/UXrapYM7MSwFzDjrKLMpveZaTJI8QqQ++H48aXifA9HF905CDM
 RIIvjCS5YZXVWPnpK7JHe5hPaB6yZZau3RkYpW2zh5By1B6RlChNHzCROp8PzN0d76hh
 fTdg==
X-Gm-Message-State: AOJu0Yzn6EpSS0JR77RQ4AkKcGGgbqDnatSekusn2bgoQLB7mdGtwuk1
 Db/unv50CjWF/EA+nOr/iWaOUBxkum9keA==
X-Google-Smtp-Source: AGHT+IGk7Z9Tmo3DATVpAk50jfvR3Ry80wh3EYc4vqdcOg2pueUn5qwcS1049Au8487vkckCJ1xplQ==
X-Received: by 2002:a05:600c:1f94:b0:40e:3963:43c3 with SMTP id
 je20-20020a05600c1f9400b0040e396343c3mr4182671wmb.148.1705479609129; 
 Wed, 17 Jan 2024 00:20:09 -0800 (PST)
Received: from [192.168.69.100] ([176.176.156.199])
 by smtp.gmail.com with ESMTPSA id
 n13-20020a5d51cd000000b0033673ddd81csm1033645wrv.112.2024.01.17.00.20.07
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 17 Jan 2024 00:20:08 -0800 (PST)
Message-ID: <0c66e625-3719-43e0-b121-baa9978afc7b@linaro.org>
Date: Wed, 17 Jan 2024 09:20:07 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] cpus: Restrict 'start-powered-off' property to system
 emulation
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>
References: <20240111161817.43150-1-philmd@linaro.org>
 <88a60a9a-e678-4bb4-b8c3-bafae3d1d09e@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <88a60a9a-e678-4bb4-b8c3-bafae3d1d09e@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x334.google.com
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

On 11/1/24 22:48, Richard Henderson wrote:
> On 1/12/24 03:18, Philippe Mathieu-Daudé wrote:
>> Since the CPUState::start-powered-off property is irrelevant
>> to user emulation, restrict it to system emulation.
>>
>> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>> ---
>>   cpu-target.c | 7 ++++++-
>>   1 file changed, 6 insertions(+), 1 deletion(-)
> 
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

Thanks, patch queued.




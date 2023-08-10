Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DC3F1777760
	for <lists+qemu-devel@lfdr.de>; Thu, 10 Aug 2023 13:41:24 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qU3Uu-0003Ir-8R; Thu, 10 Aug 2023 07:06:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qU3Us-0003IG-4Q
 for qemu-devel@nongnu.org; Thu, 10 Aug 2023 07:06:30 -0400
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qU3Up-0005AM-AT
 for qemu-devel@nongnu.org; Thu, 10 Aug 2023 07:06:29 -0400
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-3fe4a89e8c4so6541285e9.3
 for <qemu-devel@nongnu.org>; Thu, 10 Aug 2023 04:06:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1691665586; x=1692270386;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=W9N0eG7bJF5F2DqKSGshySs7Hpw17RoXdq+mT+DMqes=;
 b=v4rpNIEeZroDTl7NXS6bTvv2NREy/ZzNfB6s8Hz0nt9A0YeuTtYx63SnrpJgDzCKLQ
 h0yiKZAKWVWDjpCAznA4DdPkios1lNGX6M0TbTGergpOqRoh9URV670CtJRcezEj7hs8
 F53nVRNzk4MGaHoOEXoWdcR5KNJPjOBCZCNfJvbRi3nfOs6R6xPlY5zd/4VSgXp0NaD+
 46p4m/2t7aHsk7zSH1tx345qS3+C82133wLDPBjBNqwOPPaC0ShEiZ0vgIQpqExRPOwI
 RxFcG7KKnc59O1U5iUGvxwronC1C9woZWwOWDYW0YM5q9GT6jZ2wx00nTJxo2TLAF0Vz
 iV+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691665586; x=1692270386;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=W9N0eG7bJF5F2DqKSGshySs7Hpw17RoXdq+mT+DMqes=;
 b=hackEajp5OZAnGvjRxCg+Kh2nCMDFU2u8Qe9YojUxEujZQk2ZDtkIdxrGwG1Org/M3
 uOt7uKP1t84OeC+uTj2jca4yVrVDY/T2tJ8fl7DopEZxocJu+Cyz7nUWdATlyGorqSP3
 kt23+tZFiWZej5WdPUw5PS/rPIvBNY60uSy5TGLyC603R4i0a/5UvBVJaP7GpdFt/4u6
 TX2J3r9NqGFD1DDLBvQHAg7+zn5y35peQYiT3QlE+DEqdREmq10sbPIIRZv1RNRmBkn1
 +vkf6Cm5cL5jPCqq1zlfX5VcLUCMMjyp42kGe3bOHdnQ9MOlQTPARiCG+Hs1u2WAi+0c
 xMcA==
X-Gm-Message-State: AOJu0Yx5cr59a14AYd59gh/2cA9DEiANERtTS+n54GOhiHeTAmEpeU5d
 lyQfdUJTLku5bHHGL4IfU+LngA==
X-Google-Smtp-Source: AGHT+IGlifux1a2tYEJwC5yDuIIqlQpwUCz3AJeXzJAtP3IfJSpW4z1y7oaPbriiJG2kjYcyfftfLw==
X-Received: by 2002:a5d:4cc7:0:b0:316:ff0e:81b6 with SMTP id
 c7-20020a5d4cc7000000b00316ff0e81b6mr1902829wrt.32.1691665585708; 
 Thu, 10 Aug 2023 04:06:25 -0700 (PDT)
Received: from [192.168.69.115] ([176.176.158.65])
 by smtp.gmail.com with ESMTPSA id
 w17-20020adfee51000000b00317eee26bf0sm1824481wro.69.2023.08.10.04.06.24
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 10 Aug 2023 04:06:25 -0700 (PDT)
Message-ID: <70d2f340-17ba-fa9c-e40d-39fe3515180e@linaro.org>
Date: Thu, 10 Aug 2023 13:06:23 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.13.0
Subject: Re: [PATCH v4 01/11] target/loongarch: Add macro to check current arch
Content-Language: en-US
To: Jiajie Chen <c@jia.je>, qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org, yijun@loongson.cn, shenjinyang@loongson.cn, 
 gaosong@loongson.cn, i.qemu@xen0n.name
References: <20230808015506.1705140-1-c@jia.je>
 <20230808015506.1705140-2-c@jia.je>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230808015506.1705140-2-c@jia.je>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x335.google.com
X-Spam_score_int: -42
X-Spam_score: -4.3
X-Spam_bar: ----
X-Spam_report: (-4.3 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-2.156,
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

On 8/8/23 03:54, Jiajie Chen wrote:
> Add macro to check if the current cpucfg[1].arch equals to 1(LA32) or
> 2(LA64).
> 
> Signed-off-by: Jiajie Chen <c@jia.je>
> ---
>   target/loongarch/cpu.h | 7 +++++++
>   1 file changed, 7 insertions(+)
> 
> diff --git a/target/loongarch/cpu.h b/target/loongarch/cpu.h
> index fa371ca8ba..bf0da8d5b4 100644
> --- a/target/loongarch/cpu.h
> +++ b/target/loongarch/cpu.h
> @@ -132,6 +132,13 @@ FIELD(CPUCFG1, HP, 24, 1)
>   FIELD(CPUCFG1, IOCSR_BRD, 25, 1)
>   FIELD(CPUCFG1, MSG_INT, 26, 1)
>   
> +/* cpucfg[1].arch */
> +#define CPUCFG1_ARCH_LA32        1
> +#define CPUCFG1_ARCH_LA64        2
> +
> +#define LOONGARCH_CPUCFG_ARCH(env, mode) \
> +  (FIELD_EX32(env->cpucfg[1], CPUCFG1, ARCH) == CPUCFG1_ARCH_##mode)

The 'LOONGARCH_CPUCFG_ARCH()' macro name is misleading. If you want
to return a boolean, maybe rename as CHECK(). But clearer would be
a function (taking an enum CPUCFG1_ARCH_LAxx argument).

>   /* cpucfg[2] bits */
>   FIELD(CPUCFG2, FP, 0, 1)
>   FIELD(CPUCFG2, FP_SP, 1, 1)



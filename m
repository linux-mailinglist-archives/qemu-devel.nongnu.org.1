Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DCF5722A23
	for <lists+qemu-devel@lfdr.de>; Mon,  5 Jun 2023 17:02:21 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q6BiA-0003tH-5q; Mon, 05 Jun 2023 11:01:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1q6Bi8-0003t7-8E
 for qemu-devel@nongnu.org; Mon, 05 Jun 2023 11:01:32 -0400
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1q6Bi6-00007V-KH
 for qemu-devel@nongnu.org; Mon, 05 Jun 2023 11:01:32 -0400
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-30d5931d17aso1886548f8f.3
 for <qemu-devel@nongnu.org>; Mon, 05 Jun 2023 08:01:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1685977285; x=1688569285;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=1T9b9X3PYBbdQsfKpGC6QcSzt31CJ4CGNIO3EruJ1Ck=;
 b=Po6qWHik7eqGrHADgeGNEGjrV1qZnklk4J4iohprfNgCPbKsc5rHylb3DpkxPTNsUa
 l+OOKroWm2VAEXdEOrwazVEi5iBt94NM1ReMEVPq/W4CaBmIwB8bRM8hoKOfwx5wPUEx
 vUXV/H3520oE1szFo86QgxW6r9mOOR0b3BMO9Ta7NA2YbZ6mwwKD9G0UWcytYK7pnX5F
 plziC7uvY190cGS/uhFftkX10+owIfMb46BhRHESNFGed6z0h671d13Gw043ocyMtsSH
 h6gex/i9tLmLXnwj1BbKEodQkpVPZV/jsvjgeZtawHFJpGA2c1LXIZ9uqzLv3dw2MY3y
 jWtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685977285; x=1688569285;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=1T9b9X3PYBbdQsfKpGC6QcSzt31CJ4CGNIO3EruJ1Ck=;
 b=iXESP3303No6a6KIOGRrNmSGjGLj/APCxXb2jICDjuVqiZyDuuzUXETvoQ7XhLt68c
 hczr12teX3qhTtKPkUq0S/NLuuGxoqnsZ6PQccdl48I1aFYvrMCQCs39vDdBJh9F94pi
 dUiIy59dffdxETIhHMrggQ8MS9idkivemszbskaNJTawb2tr5ViP8Rgim9SrPPP3zimu
 9YJ0vbnPGDkplzokBmDsZHfR8AzfWTF/IiqNOqGhF6mxE+zSS660onAR+J6AmIoQVHE/
 2dv9qmOlXZSvEnhVCZ2SOz4sYJDz6kB7c9zaCrgN0nBD6tQfwU/iwk+9lg9nneHVjNOf
 TyYA==
X-Gm-Message-State: AC+VfDyxM42oxBPSvCNngzXpBTTjykvbsR3Hd/0eXZKGyHqqFpRD0Xjf
 x7izZ66m0S/YlCZX9rQ0cD4g81XX1q/YAeVbYss=
X-Google-Smtp-Source: ACHHUZ54+17lFSJI3paf5oZlbQsx8C4TRTH1EfPf+vBetynW1qKnf1GSUFXYj+eIPS1mNVePTwCRiA==
X-Received: by 2002:a5d:55c6:0:b0:30a:93ad:ab9f with SMTP id
 i6-20020a5d55c6000000b0030a93adab9fmr5307696wrw.11.1685977285594; 
 Mon, 05 Jun 2023 08:01:25 -0700 (PDT)
Received: from [192.168.69.115] ([176.187.217.157])
 by smtp.gmail.com with ESMTPSA id
 m14-20020a7bcb8e000000b003f7ba52eeccsm3472085wmi.7.2023.06.05.08.01.24
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 05 Jun 2023 08:01:25 -0700 (PDT)
Message-ID: <6068e086-6596-a236-ce76-77b49d2caea5@linaro.org>
Date: Mon, 5 Jun 2023 17:01:23 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.11.2
Subject: Re: [PATCH] target/sh4: Emit insn_start for each insn in gUSA region
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: ysato@users.sourceforge.jp
References: <20230603165530.1189588-1-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230603165530.1189588-1-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::434;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x434.google.com
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

On 3/6/23 18:55, Richard Henderson wrote:
> Fixes an assert in tcg_gen_code that we don't accidentally
> eliminate an insn_start during optimization.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
> 
> Test case is tests/tcg/multiarch/testthread.c; the assert for
> equality is new with
> 
> https://lore.kernel.org/qemu-devel/20230531040330.8950-26-richard.henderson@linaro.org/
> 
> 
> r~
> ---
>   target/sh4/translate.c | 15 ++++++++++++---
>   1 file changed, 12 insertions(+), 3 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>



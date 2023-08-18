Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EA9E781201
	for <lists+qemu-devel@lfdr.de>; Fri, 18 Aug 2023 19:33:54 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qX3Kt-0004y4-L3; Fri, 18 Aug 2023 13:32:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qX3Kr-0004xf-3E
 for qemu-devel@nongnu.org; Fri, 18 Aug 2023 13:32:33 -0400
Received: from mail-pf1-x430.google.com ([2607:f8b0:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qX3Kp-00067s-0A
 for qemu-devel@nongnu.org; Fri, 18 Aug 2023 13:32:32 -0400
Received: by mail-pf1-x430.google.com with SMTP id
 d2e1a72fcca58-68891000f34so1011734b3a.0
 for <qemu-devel@nongnu.org>; Fri, 18 Aug 2023 10:32:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1692379949; x=1692984749;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=xwF6RsC/4jGL9WcyOSNbAyjdYwv0KcxtEqKwZO9AKT0=;
 b=WBTBsrcRLpLlWs8KDskxp0334q1vAyJ/GaySh6fDSgs04CN2MaB1nnjzJjJlsAShzv
 hZDiJ49GEORQuncjyj4Kf6f8scwZqPHtqTWZ5hkmtJ0ggbnS+Qv9C0AIRYSzhRdsJCKN
 sXy8AKnJ4mns/GSeJtWzgJFiDd/dvsRR0OQOE03lwT3ubAB5D2xiDNBKxSTLnVaoWm9S
 GivPew0JrEPAPfLCw/aHM44kzKThTjHN3OkiVYiybetiCdtR4eELzOKDuveQmK6XAdKF
 3/GWB2JoLruQwWrPNs/zT/thVLO/I1s9LVDe2IkGPUUZjd8aFzqanCwpLN8m6cvLPMga
 Z4gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692379949; x=1692984749;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=xwF6RsC/4jGL9WcyOSNbAyjdYwv0KcxtEqKwZO9AKT0=;
 b=YBf1bTcheEBNScgYRd2IaNhPYvrwIYdtftz+NjGg4LAWAlZHE36ndl8BJuOwy47X9u
 0Cb0uhruJ+wznPQIjgqWgwa3Isn5GWzZm4qTNnv7xPf9LqXNO5BWCvpLOsbV/SavDCws
 lwEdGrMcEVJbt3xKVkoifsfGXiCBfBFjDowdsMgDVzrqs7IpgC7Qe9ShMRIcYvu1MvKI
 00jp0muv74WKcK9NiS3G6KssZGjZtByKNUqIP3RoUje+YFyASyKDK1XmtylXWVwRmaHV
 nZEvv4K/cPqtM8wC05eCuRqLdEzJCI8k3f0QSnG54vcbYKYcqLMwgcRg8en28sscMLIl
 oJVg==
X-Gm-Message-State: AOJu0YwvTecHIc325I3xVwimUBPKc479iquCNJD+P1lGQiPX0zqjYGjI
 qzMEPjXlbYt/r14PvxebY+Z3dg==
X-Google-Smtp-Source: AGHT+IEJSXH9vz8NgxivevCIi0Gv43T7XRqXrYRW0CtsmCcZzM1XS3GVbj8vk4EYSUJr9J9ZlGgo6A==
X-Received: by 2002:a05:6a00:1a89:b0:689:f3eb:e275 with SMTP id
 e9-20020a056a001a8900b00689f3ebe275mr3682035pfv.34.1692379949308; 
 Fri, 18 Aug 2023 10:32:29 -0700 (PDT)
Received: from ?IPV6:2602:47:d483:7301:cf24:6daf:2b9e:7972?
 ([2602:47:d483:7301:cf24:6daf:2b9e:7972])
 by smtp.gmail.com with ESMTPSA id
 h5-20020aa786c5000000b0064d57ecaa1dsm1810237pfo.28.2023.08.18.10.32.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 18 Aug 2023 10:32:28 -0700 (PDT)
Message-ID: <f8659f5c-5dcc-91b2-d494-f91f8586fb1c@linaro.org>
Date: Fri, 18 Aug 2023 10:32:27 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v2 5/8] target/loongarch: Extract 64-bit specifics to
 loongarch64_cpu_class_init
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Huacai Chen <chenhuacai@loongson.cn>,
 Xiaojuan Yang <yangxiaojuan@loongson.cn>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, Jiajie Chen
 <c@jia.je>, Song Gao <gaosong@loongson.cn>
References: <20230818172016.24504-1-philmd@linaro.org>
 <20230818172016.24504-6-philmd@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230818172016.24504-6-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::430;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x430.google.com
X-Spam_score_int: -55
X-Spam_score: -5.6
X-Spam_bar: -----
X-Spam_report: (-5.6 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-3.454,
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

On 8/18/23 10:20, Philippe Mathieu-Daudé wrote:
> Extract loongarch64 specific code from loongarch_cpu_class_init()
> to a new loongarch64_cpu_class_init().
> 
> In preparation of supporting loongarch32 cores, rename these
> functions using the '64' suffix.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   target/loongarch/cpu.c | 27 +++++++++++++++++----------
>   1 file changed, 17 insertions(+), 10 deletions(-)
> 
> diff --git a/target/loongarch/cpu.c b/target/loongarch/cpu.c
> index 34d6c5a31d..356d039560 100644
> --- a/target/loongarch/cpu.c
> +++ b/target/loongarch/cpu.c
> @@ -356,7 +356,7 @@ static bool loongarch_cpu_has_work(CPUState *cs)
>   #endif
>   }
>   
> -static void loongarch_la464_initfn(Object *obj)
> +static void loongarch64_la464_initfn(Object *obj)

This rename is not relevant to populating the abstract loongarch64 class.

Otherwise,
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~


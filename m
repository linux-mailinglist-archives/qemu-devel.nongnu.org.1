Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 862AF7762FC
	for <lists+qemu-devel@lfdr.de>; Wed,  9 Aug 2023 16:49:06 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qTkTq-00065A-7a; Wed, 09 Aug 2023 10:48:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qTkTl-00064t-3y
 for qemu-devel@nongnu.org; Wed, 09 Aug 2023 10:48:05 -0400
Received: from mail-pf1-x429.google.com ([2607:f8b0:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qTkTj-0003SY-D7
 for qemu-devel@nongnu.org; Wed, 09 Aug 2023 10:48:04 -0400
Received: by mail-pf1-x429.google.com with SMTP id
 d2e1a72fcca58-686bea20652so6678903b3a.1
 for <qemu-devel@nongnu.org>; Wed, 09 Aug 2023 07:48:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1691592481; x=1692197281;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=J6tVxbZta+8R3CC8UaTDwmo2drRy99hKdo52zw2Uk6E=;
 b=ZxxKjk58cwMG9jXjvRSebpbl+hu+yoPCuA1PDCDHwJtedW2xPgp+iv4jOMVpBlxeru
 WCgLpFFhSgiq5rxDB6IhXAgtWQVsoJka2HRmyGkVKANXBp87ZIx3xuzVpk1+D/k7i8dG
 1/E7kHAKJ6NW4ATqxVcqvayGMI/NHNDVZIMr3R/ktnqYXJ0/Asnu5cuI9p0WOeGYASU3
 FWmWa+cG3r3FMFrZla+/FK2h2rG9E77XXCVQpmtGqLyFkZr695N3HKexBA6eMUtP7DWu
 rLD1G8TB/87U5rhBY1clCFJGD0c50I42AaUokzaCGjkU/b4DxuDsPHH8QzYCfd8VK9uJ
 orgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691592481; x=1692197281;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=J6tVxbZta+8R3CC8UaTDwmo2drRy99hKdo52zw2Uk6E=;
 b=I69pXka2cb2QGtqszArKgQnONQAOXnS4fKLHSHl5Y+qGDPGsLRx0MlE+ChzBa9D82q
 nIgEPIaQSF1N8XIDr7FdhjpeXzhANRR3JppRlvzGl7Yx4Il86sT/HmaWioJ1naVx+tT0
 kzVdTNOvxul1pJLHzTe06t44rAAXjeHRzNcvOTmqvFru4K4mkgoV8P3Cxemg+wmXCSdo
 739VnlDOSfGrG1iNJ5DQLHURG2xdAdQMAKShD2m99gmEYLBAEUQhpD7/DqqolelU4B7X
 murQfiPrxd/f/Rw6IbPKWl0wuD0PS6Yc0Larvp2a6yHghxQpWmgrL4tTTZzSD9J8bVVy
 wi6Q==
X-Gm-Message-State: AOJu0Ywwm5TQg4YfzTI+obkgKpPQtglA0Cq6p5cbVFGDuqCUNA3Nl1TN
 zWsauG2WUqjQw1fbOGucHfHFveunzkhrGlY3IAk=
X-Google-Smtp-Source: AGHT+IEBM//u8X91d4P6NcEtFz9JyUT8GPIDcRceyjFKx1Pvrj25euDYekY0oizGOASat3jbKHlkPg==
X-Received: by 2002:a05:6a20:4315:b0:13d:b8ed:a5b8 with SMTP id
 h21-20020a056a20431500b0013db8eda5b8mr3318055pzk.12.1691592481608; 
 Wed, 09 Aug 2023 07:48:01 -0700 (PDT)
Received: from ?IPV6:2602:47:d483:7301:6bf0:9674:6ac4:f74c?
 ([2602:47:d483:7301:6bf0:9674:6ac4:f74c])
 by smtp.gmail.com with ESMTPSA id
 b14-20020a170902650e00b001bba3650448sm11366419plk.258.2023.08.09.07.48.00
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 09 Aug 2023 07:48:01 -0700 (PDT)
Message-ID: <21dcbda3-3745-5ebc-99ea-1da19a362560@linaro.org>
Date: Wed, 9 Aug 2023 07:47:59 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v5 02/11] target/loongarch: Add new object class for
 loongarch32 cpus
Content-Language: en-US
To: Jiajie Chen <c@jia.je>, qemu-devel@nongnu.org
Cc: yijun@loongson.cn, shenjinyang@loongson.cn, gaosong@loongson.cn,
 i.qemu@xen0n.name, Xiaojuan Yang <yangxiaojuan@loongson.cn>
References: <20230809083258.1787464-1-c@jia.je>
 <20230809083258.1787464-3-c@jia.je>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230809083258.1787464-3-c@jia.je>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::429;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x429.google.com
X-Spam_score_int: -61
X-Spam_score: -6.2
X-Spam_bar: ------
X-Spam_report: (-6.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-4.14,
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

On 8/9/23 01:26, Jiajie Chen wrote:
> Add object class for future loongarch32 cpus. It is derived from the
> loongarch64 object class.
> 
> Signed-off-by: Jiajie Chen<c@jia.je>
> ---
>   target/loongarch/cpu.c | 19 +++++++++++++++++++
>   target/loongarch/cpu.h |  1 +
>   2 files changed, 20 insertions(+)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~


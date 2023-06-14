Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 50E5972F37A
	for <lists+qemu-devel@lfdr.de>; Wed, 14 Jun 2023 06:20:53 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q9Hzh-0001F1-RL; Wed, 14 Jun 2023 00:20:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q9Hzf-0001En-FZ
 for qemu-devel@nongnu.org; Wed, 14 Jun 2023 00:20:27 -0400
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q9Hzd-00077n-R9
 for qemu-devel@nongnu.org; Wed, 14 Jun 2023 00:20:27 -0400
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-30e412a852dso4313552f8f.0
 for <qemu-devel@nongnu.org>; Tue, 13 Jun 2023 21:20:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1686716423; x=1689308423;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=hIkw/EmrdzYUGFrPOAFK5KXobF9DSTMY4i6PeCRrGOg=;
 b=gM3+T/y2yqmZBZQGW7x5bEzH2w0j2QOxJGlXSt8BAAHSAcYGDeIKIQZKtbQpudzG60
 ffsHvPSioAgfAoeiamay8/9eyibxTuO60FNynTCWmPrDKdrr8Qzc4BCsaA9QiTqHXmVH
 /wKFhD/UHu9lcYwtJlxGxxvfghUMws50G9TTphZmx+oJiAEtwewX+jaHolWPzkXTJdUN
 A+IypYJBdhHaLwjI/p2xuuF7VO5VIeI0migLp5F8oXntdUyNeu9BvL8Tg8wTgTbaSDaN
 s6C/wYjr3IjYeN6/9KZnDu8ZKwZmOll86to5L3bH0zZLdk0aKPHVmLOegPBPFJSDDcJs
 9crA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686716423; x=1689308423;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=hIkw/EmrdzYUGFrPOAFK5KXobF9DSTMY4i6PeCRrGOg=;
 b=hIP80sGhJh88pPxaHYcxXnrbiPEcUuvxFuuIE8dKU09H5mfv/gif/2Oi280W641ZfQ
 U5bS7DMNszAPaqgbzFhwmPtknmCXyk9JAGq4uDPCxfLHgouHSLUCKXl+SgJeB4g7dq/U
 YUDh1BgtJwZkxB5UBlK8WmuzkWCupzOIGSBiQnKXUo1XRaBr5OFlBo7WtUFIopJc7hbT
 P3YcCQCkc43Bi3yybKqQ2FvvZPec2aR4NUS/OO6iWGGtcJXNO9Sw2tke/RcpxaUi47eA
 oMUmSAM599Wgaz7adALPY426xENrfHwBN/2zHeV+lNGeoiW5ZazurGPn6VsreFRUwjfQ
 KvDw==
X-Gm-Message-State: AC+VfDxIqd5Q/Z44nX7E8eAQT9qp30xTuCLgvhU8zIC9cTYe/jJp0Gi2
 DPu0O1DirQf6hXfs/IW0r4OFfA==
X-Google-Smtp-Source: ACHHUZ7oo0XpkH7nQGPu5HvHWH9sz08Z1QAfKM981Wqu52qkVg761HQ6OUAXI7X2X0KqGjxs8RhOcw==
X-Received: by 2002:adf:ee0a:0:b0:30a:c2c4:7133 with SMTP id
 y10-20020adfee0a000000b0030ac2c47133mr6868784wrn.49.1686716423557; 
 Tue, 13 Jun 2023 21:20:23 -0700 (PDT)
Received: from [192.168.4.112] (90-182-62-66.rcp.o2.cz. [90.182.62.66])
 by smtp.gmail.com with ESMTPSA id
 t11-20020adfdc0b000000b0030ae3a6be5bsm17000426wri.78.2023.06.13.21.20.22
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 13 Jun 2023 21:20:23 -0700 (PDT)
Message-ID: <34aad222-408d-0817-1bb7-87a5a10b2092@linaro.org>
Date: Wed, 14 Jun 2023 06:20:21 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PULL v4 09/10] hw/arm: introduce xenpvh machine
Content-Language: en-US
To: Vikram Garhwal <vikram.garhwal@amd.com>,
 Stefano Stabellini <sstabellini@kernel.org>, peter.maydell@linaro.org
Cc: qemu-devel@nongnu.org, Stefano Stabellini <stefano.stabellini@amd.com>
References: <alpine.DEB.2.22.394.2306091007210.3803068@ubuntu-linux-20-04-desktop>
 <20230609170751.4059054-9-sstabellini@kernel.org>
 <3925158f-cd95-781f-5f46-fe3f5d8326ab@linaro.org>
 <6ad25146-0cd2-f58f-ada4-fd0a3f8a5b95@amd.com>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <6ad25146-0cd2-f58f-ada4-fd0a3f8a5b95@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::431;
 envelope-from=richard.henderson@linaro.org; helo=mail-wr1-x431.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.098,
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

On 6/12/23 02:10, Vikram Garhwal wrote:
> Found the fix. QTest adds 'accel = qtest' and xen machines already have "accel = xen" 
> option by default. Adding this xenpvh machine to skip fixed the issue, other xen machines 
> are already in skip list. I am running the gitlab-ci locally to see if there are other fails/

Sounds right.

> i checked your pipeline and can see there are other failure but unrelated to Xen. To make 
> sure, are there any others failures related to my patches?

I don't think so.

> Also, I am not an expert on gitlab ci flow. What i do to run gitlab-ci is this: Create a 
> new gitlab pipeline with QEMU_CI = 2 and this runs around 120+ jobs. Is this enough or 
> there any other variable setting needed?

That's correct.


r~



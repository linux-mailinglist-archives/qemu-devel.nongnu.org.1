Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E1B327529F4
	for <lists+qemu-devel@lfdr.de>; Thu, 13 Jul 2023 19:38:48 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qK0GJ-0004rh-Pi; Thu, 13 Jul 2023 13:37:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qK0GH-0004qV-Sv
 for qemu-devel@nongnu.org; Thu, 13 Jul 2023 13:37:53 -0400
Received: from mail-yb1-xb2c.google.com ([2607:f8b0:4864:20::b2c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qK0GG-00073c-Gq
 for qemu-devel@nongnu.org; Thu, 13 Jul 2023 13:37:53 -0400
Received: by mail-yb1-xb2c.google.com with SMTP id
 3f1490d57ef6-bcb6dbc477eso888963276.1
 for <qemu-devel@nongnu.org>; Thu, 13 Jul 2023 10:37:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1689269871; x=1691861871;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=dVFP3JlHoUQ/pnlO9li0Bc+vPsPmYInxmgBiusg+Ytk=;
 b=Q7d/bRoIj7VGol+5DJMNBS5JGNsowEqHEyvSNH2Ik93uYnf1uvUN/MJXT9DRmDgSdZ
 azImftPRxt1rwTk5NW43P/wlRirGlx5ux/yKIWpS7XFkllJiA+X7J6sqyRQl3rWRGrpy
 vmDpOls90kCWoZfNFEtN3YrPcjlkWXXdfZM/YCINX645Uy85WhTRwxTSWNoDI+BWbYWf
 LN/TQIzYNTZAyFUYjCMOTTgB5qD1niH2n1e6+da0P7OvfHvWM21rwnjAf9j9cyn61iM0
 dxYlBjeUBCgYTC+cm8sJMoTki3CtTXVm1y7B6O4tqEDw21MRq7QLQXscs9D1urDLLdo0
 08mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689269871; x=1691861871;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=dVFP3JlHoUQ/pnlO9li0Bc+vPsPmYInxmgBiusg+Ytk=;
 b=CPzcyN932k8gy/WYEAnKHD1p4F0KqElCmeqe5tJPqoMOBqClsVwfDuG5Ag9PiBKsfo
 vvxjt9YKTqJHApmPtrhKIpjjqiNblbFmkvT3LsX8uwGPWpM2Ay5AuY4JHSRb+RR8Z424
 KThCJqOwMmoV2mwo+KmNnjK/DkJwHn3W3dQJa+Ctda+gaU7/YH/a9ydqEobbNXNDqKAw
 PVfzONEdNIMGiiNX+w+XMS89cVzFdAaV8bRDBSFoTYn+8ugHZoVtS7xwwl3w9mSa1D2q
 XDWcD8KjMLq/yO8bE8CUF/cWJNR9662dpRhOxj1ROSS0FKrn+ar5MvQfPsAuPRYg69k/
 qNzA==
X-Gm-Message-State: ABy/qLaj1CtGF1EX03fYFNLHj06h0F4+0TfffpBzVpq4ocr+Fro84OiJ
 FbCW2FztK6mJ6gqMHcfY/CBJng==
X-Google-Smtp-Source: APBJJlF4qISw1I6RAjYRQ1IRLVwh/HaujCdeeawWhOYU8BEbaQI8k6EMa4GSajYZga8J795YhfZvUg==
X-Received: by 2002:a25:b44:0:b0:cb0:3ce5:2bbc with SMTP id
 65-20020a250b44000000b00cb03ce52bbcmr1632321ybl.16.1689269871090; 
 Thu, 13 Jul 2023 10:37:51 -0700 (PDT)
Received: from [192.168.88.227] ([172.58.139.107])
 by smtp.gmail.com with ESMTPSA id
 k77-20020a252450000000b00c624de0d9absm1505377ybk.5.2023.07.13.10.37.48
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 13 Jul 2023 10:37:50 -0700 (PDT)
Message-ID: <ba359b58-c854-3608-c736-90dac2eb6356@linaro.org>
Date: Thu, 13 Jul 2023 18:37:44 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH for-8.1 1/3] target/arm/ptw.c: Add comments to S1Translate
 struct fields
Content-Language: en-US
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>
References: <20230710152130.3928330-1-peter.maydell@linaro.org>
 <20230710152130.3928330-2-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230710152130.3928330-2-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::b2c;
 envelope-from=richard.henderson@linaro.org; helo=mail-yb1-xb2c.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.096,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

On 7/10/23 16:21, Peter Maydell wrote:
> Add comments to the in_* fields in the S1Translate struct
> that explain what they're doing.
> 
> Signed-off-by: Peter Maydell<peter.maydell@linaro.org>
> ---
> I figured some of this out when writing commit fcc0b0418fff,
> and then I found I'd forgotten it all when I was trying
> to fix this new bug. So this time I'm writing this down :-)
> ---
>   target/arm/ptw.c | 40 ++++++++++++++++++++++++++++++++++++++++
>   1 file changed, 40 insertions(+)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~


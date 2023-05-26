Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E2979712835
	for <lists+qemu-devel@lfdr.de>; Fri, 26 May 2023 16:27:56 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q2YPq-0003CU-Vf; Fri, 26 May 2023 10:27:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q2YPn-0003C4-Qi
 for qemu-devel@nongnu.org; Fri, 26 May 2023 10:27:35 -0400
Received: from mail-pf1-x432.google.com ([2607:f8b0:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q2YPm-0008N0-As
 for qemu-devel@nongnu.org; Fri, 26 May 2023 10:27:35 -0400
Received: by mail-pf1-x432.google.com with SMTP id
 d2e1a72fcca58-64d2a613ec4so774814b3a.1
 for <qemu-devel@nongnu.org>; Fri, 26 May 2023 07:27:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1685111252; x=1687703252;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=oCFXtAvfvF3yZxUUrYdVFXvSck8cECqnU/ROcL18s+U=;
 b=OJOM50DEXTI3Jl1YD/mi9S0rrR+vJ4l69M9mdMpct949ZjBeZ1+HaLchXGhjkziVoG
 l2diY3eQr0C85jNAKF16BBwC2o0CY7GV8xTye4q0gNRPhhizWwa8HL/EHL6R3tj9MCVF
 aLEbK87ouwqv5j1dMI7wz5kuTGzERw7GO92y0UEC72wflZVSQHEIAB5Yk99JtX/h2tEJ
 omomK8bKqAm7okxNavy/Vil8YBckL/U5iJZaM6aT5Vrctwn1eUBCvRpbI/tnMEYDVaHE
 cCTK+mjLIQfFWvsyTWILkX44oz44lcksQFxmDl0IhLkHldOsE+3UKN/Akv3o6GA6jIqG
 pOWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685111252; x=1687703252;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=oCFXtAvfvF3yZxUUrYdVFXvSck8cECqnU/ROcL18s+U=;
 b=M5vRa83eTZ/Au8JujtNO5G54/1MmbtWo4JD0R6EKcTNGIu8cBRoVBsdCVfTxA97Kmh
 h2QEKbyzJSy8B2BQY7JK+z4A/p2JPer4aBMsLWsjI+/7l96znr2QOgUYeCvg5A/z8uJp
 ub2njTpboJoJVgWOZu3y2Cph+DhVAYAqDWtSzkpHr/WMrTAndJGsb5xGP15XM9j+hF2o
 T0KTjh5QSsGyjCxTBuid571iaB9s3EJU0IM9aEUewVE66y2iEBK2Nzi8EV+dej9A8OR7
 B+pMGcarXhwd0WfuXBI0HGUcvYtBycMK3nHZveDTbY+sAVllEuGo3O4MSsDvOFAInIPh
 79DA==
X-Gm-Message-State: AC+VfDzbi1JsldueLHEG7UmDqBulBmbWQf5Sl523TohgAl4PpuulCrMO
 EbYKJsWgzyY7Tzp8ceaQ545mrQ==
X-Google-Smtp-Source: ACHHUZ69oKKg+C3qRM9hoYyUXlPgqlLrno3BMqRe2NhX97LxH4YEuPp0h9GzRdKAsnAzHnzUEtF6ng==
X-Received: by 2002:a05:6a00:2194:b0:64f:7c9d:9c01 with SMTP id
 h20-20020a056a00219400b0064f7c9d9c01mr3019173pfi.30.1685111252418; 
 Fri, 26 May 2023 07:27:32 -0700 (PDT)
Received: from ?IPV6:2602:ae:1598:4c01:86cc:4482:68db:2c0f?
 ([2602:ae:1598:4c01:86cc:4482:68db:2c0f])
 by smtp.gmail.com with ESMTPSA id
 u7-20020aa78387000000b006260526cf0csm2829513pfm.116.2023.05.26.07.27.31
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 26 May 2023 07:27:31 -0700 (PDT)
Message-ID: <d82e342e-a0bc-b005-53fe-3a22fb8f8121@linaro.org>
Date: Fri, 26 May 2023 07:27:28 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH] linux-user/i386: Properly align signal frame
To: fanwj@mail.ustc.edu.cn
Cc: qemu-devel@nongnu.org, laurent@vivier.eu
References: <20230524054647.1093758-1-richard.henderson@linaro.org>
 <fa83ba4a-0d85-a923-a3d7-089c4d7c4be2@linaro.org>
 <3cba4226.1d2fb.18855fc889f.Coremail.fanwj@mail.ustc.edu.cn>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <3cba4226.1d2fb.18855fc889f.Coremail.fanwj@mail.ustc.edu.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::432;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x432.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.092,
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

On 5/25/23 19:56, fanwj@mail.ustc.edu.cn wrote:
> 
> "The beginning of the structure, with pretaddr, should be just below 16-byte alignment."
> 
> It is incorrect! The beginning of the structure, with pretaddr not aligned as 16-byte!
> On x86-64, It aligned as (16n - sizeof(void*)) because of instruction "call" !

Exactly: 16n - sizeof(void*) is why I mean by "just below 16-byte alignment".
Which is exactly what I have done...

>>> +    esp = esp - *frame_size + sizeof(abi_ulong);
>>> +    esp = ROUND_DOWN(esp, 16) - sizeof(abi_ulong);

... here.


r~


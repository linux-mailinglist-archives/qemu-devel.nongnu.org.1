Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DAA1A7FD956
	for <lists+qemu-devel@lfdr.de>; Wed, 29 Nov 2023 15:27:45 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r8LWx-0006Ck-CX; Wed, 29 Nov 2023 09:27:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1r8LWu-0006CJ-MI
 for qemu-devel@nongnu.org; Wed, 29 Nov 2023 09:27:08 -0500
Received: from mail-oi1-x231.google.com ([2607:f8b0:4864:20::231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1r8LWt-0001Ur-5I
 for qemu-devel@nongnu.org; Wed, 29 Nov 2023 09:27:08 -0500
Received: by mail-oi1-x231.google.com with SMTP id
 5614622812f47-3b8952b8066so371474b6e.1
 for <qemu-devel@nongnu.org>; Wed, 29 Nov 2023 06:27:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1701268025; x=1701872825; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=5I0DAkQYZ3YtUULNbkZbwLcIKUtfCwU9KHZNEM1L/8w=;
 b=Ylbmvj8wyMCQbUEg6fYsh3n9a19kxuz8CGWreq1IBsdtc0KzJPwY8Yw+5NKbrxOa/B
 LrvZyJi6H+/qr9bp4ymNAcV1XJgb/3MjoXR4mbaMeaavSdmIPFXXmblzGECoO2pFdzTb
 O4L11TnrWpexgrgFOxaEEcKJTk1bhuVZwQgWcYX48vvx66Ffxpc02Kf6ECKvzO9l2cPt
 5ylWeiE9VzYrOVn2ajXJI8hGLAWDFtSwRb+mHLidsMejMa3BzBjgAfzXnYr49OPzd77m
 wX+wWFa8TPVMg6KL7y0auhn3s6pNlKNWNPEJ/TGLSCOIXRkGg5DD9zmBpHd/1o2ZgGQ3
 24Iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701268025; x=1701872825;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=5I0DAkQYZ3YtUULNbkZbwLcIKUtfCwU9KHZNEM1L/8w=;
 b=YmOfFKoOi9gEJwgHq0l8FXnchfER+3TlegaHC5vjHqjhDMlT7M9UuLh3IwDwTJkJIM
 DvQP2QF/1Sz9yjSRvxyFyn2iRVaxO0PjwH0XMfrrkOGtE9/gBjnWCxS76nMaCkl7PZMo
 d6Je9Ow3gU4aK2mp2qOq5gZfY1jaXG6hoszL8AP9m/Ys464/U4fWjujOUMIwsA5ccQ/g
 xEZiw2nogn870Nqaqa5biOBBz+iYNNF0yenlVU1auoNgsKRR2iib60jU1Sf8e5FIQCc2
 pYLAb+IRr9bGlboLh9Qg0WwFZWiZjZgtCfl1zkM0iaeQDjLxq0ApssZiF56eTXF6RK32
 yoBw==
X-Gm-Message-State: AOJu0Yx0FrRCaYlzlwv+cnBg8UmdeRNYfeyDpczmFz9XzX0RhY1LZEk8
 YjycGG4xw9psZ18H5lPxrKwVmQ==
X-Google-Smtp-Source: AGHT+IHnMT09iIM/usX/y23reqHW4CZjIRB1IEWTHyLuYXZKWcrsKGn8tO9OdwUNPnY44SAWaA6w+w==
X-Received: by 2002:a05:6808:3029:b0:3ad:c018:7d9a with SMTP id
 ay41-20020a056808302900b003adc0187d9amr10238826oib.13.1701268024966; 
 Wed, 29 Nov 2023 06:27:04 -0800 (PST)
Received: from [192.168.174.227] (rrcs-71-42-197-3.sw.biz.rr.com.
 [71.42.197.3]) by smtp.gmail.com with ESMTPSA id
 bj29-20020a056808199d00b003b2f2724c48sm2234178oib.11.2023.11.29.06.27.04
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 29 Nov 2023 06:27:04 -0800 (PST)
Message-ID: <6de19df3-04d5-4179-adfe-ec642f8eb73c@linaro.org>
Date: Wed, 29 Nov 2023 08:27:02 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] qemu/timer: Don't use RDTSC on i486
Content-Language: en-US
To: Petr Cvek <petrcvekcz@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 "S. Tsirkin, Michael" <mst@redhat.com>
References: <6826113a-d428-401e-b5a3-56ad5d8fbaa4@gmail.com>
 <CABgObfabW_WKdfGFgao0BJ0wHYHRx6KzMsLzvqUvzu3ZMx5Bdw@mail.gmail.com>
 <5717e259-7d0f-42bf-8d5a-43120bdb0284@linaro.org>
 <7ac7d010-a984-48bf-b254-02f87324be83@gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <7ac7d010-a984-48bf-b254-02f87324be83@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::231;
 envelope-from=richard.henderson@linaro.org; helo=mail-oi1-x231.google.com
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

On 11/29/23 07:50, Petr Cvek wrote:
> I can agree that binary compiled for i486 doesn't contain cmpxchg8b and works OK with exception of setjmp bug I described in another thread [1]. glxgears which doesn't use signals works without problem. 64bit atomic operations seems to be emulated in util/atomic64.c.
> 
> However I've found out the compilation for i386 seems to fail during configure due to the lack of i386 atomic instructions in my GCC 13.2.0 version. If this is normal behavior, I guess __tune_i386__ check doesn't make sense to add.

Correct, we cannot operate at all without the i486 atomic insns.


r~


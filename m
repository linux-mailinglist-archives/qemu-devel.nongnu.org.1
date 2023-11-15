Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5201A7EBAA9
	for <lists+qemu-devel@lfdr.de>; Wed, 15 Nov 2023 01:45:46 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r341l-0000X3-8R; Tue, 14 Nov 2023 19:45:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1r341g-0000Wt-H9
 for qemu-devel@nongnu.org; Tue, 14 Nov 2023 19:45:04 -0500
Received: from mail-pf1-x435.google.com ([2607:f8b0:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1r341e-00012V-TF
 for qemu-devel@nongnu.org; Tue, 14 Nov 2023 19:45:04 -0500
Received: by mail-pf1-x435.google.com with SMTP id
 d2e1a72fcca58-6b2018a11efso6477927b3a.0
 for <qemu-devel@nongnu.org>; Tue, 14 Nov 2023 16:45:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1700009101; x=1700613901; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=9MxWwP6hTNgbR8IOKAd6dzhaIsOo03k4IJ7thBCHsZI=;
 b=LlTOyluWzwXlq8TUO9yXPpNNy31HdEkdvkQPLQmrUr/P6hDhgMedYVrPd50CZp0C60
 vw9gPm3EVJbeYOFf+wmEnAeyHEtYsyvkOJ+FOeS821V4NU9Dc7Jzu/IebEr2rFiYrdq6
 f7wPv66JbRTc0ae2a3Nu24IURkyGwaBZoP6iLSmZUwyUWL8EcNCbwcRHcrOIocLN1YNb
 XGspF/4/iyy3I7egq8ub2jTjdYxquYDYmEXNEeDl0pDFr9KaooPRaZpQOEwaw+AxyQ9M
 rxIQwTazfyNEpuvmfeGFI2XeWCS+4ReZiIhhFpiZY4L7je5zhQLSg38Qk0mn8nzjOcsn
 Xi0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700009101; x=1700613901;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=9MxWwP6hTNgbR8IOKAd6dzhaIsOo03k4IJ7thBCHsZI=;
 b=COi4xgxyOW2JvOxwIwuqoEpZM+ZwLn7KAjGqHjJ26eV2WWYwEGmzs3DGbC05gAwLD8
 FH/odeotXyBFMU4wmmsI5OqYSqjpHLNnrA7VVDH/F/usrDN5fvVdEXNgw+0zeAvzFA78
 kbGi7TSHMlLddREQTm1n/4Qyh7PPN7bBIvZYSbl5zoLHfEtZLeWmPjpmFi5goQ8ai1Hr
 VC/QEqDFx/F11p2df1xC6MH1rIhKQMu06TPIqDZrxVofNfOE43PFdOmo7/7iUMAv2Fd7
 1Xeo2/x5c7GbPkpptowK3L4gEwC09rXhYhgb1M43gUi+URcFKAS1D2Buca9gCumgH8Sx
 nEng==
X-Gm-Message-State: AOJu0YyvaRjVhauvgSzwzBb1Lk4K60el9X5MXmd7qaovShmfXG1blxfH
 DhIoVhTReOfXPExI+srtqY1//34qCdVXbpJfn4U=
X-Google-Smtp-Source: AGHT+IHMpNypEpBYYPi6tFvsEoCNvxpKPk6njgovVPeSl3g50RxeoOKKwTEQ5iCWo2SJJXqacxBCsg==
X-Received: by 2002:aa7:8456:0:b0:6c4:db03:d20f with SMTP id
 r22-20020aa78456000000b006c4db03d20fmr10488176pfn.17.1700009101186; 
 Tue, 14 Nov 2023 16:45:01 -0800 (PST)
Received: from [192.168.0.4] ([71.212.149.95])
 by smtp.gmail.com with ESMTPSA id
 i20-20020aa787d4000000b006c4db182074sm1769511pfo.196.2023.11.14.16.45.00
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 14 Nov 2023 16:45:00 -0800 (PST)
Message-ID: <2aab9010-9194-4f1f-8125-262417f117ba@linaro.org>
Date: Tue, 14 Nov 2023 16:44:59 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 10/31] target/cris: Use generic cpu_list()
Content-Language: en-US
To: Gavin Shan <gshan@redhat.com>
Cc: qemu-devel@nongnu.org
References: <20231114235628.534334-1-gshan@redhat.com>
 <20231114235628.534334-11-gshan@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20231114235628.534334-11-gshan@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::435;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x435.google.com
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

On 11/14/23 15:56, Gavin Shan wrote:
> Before it's applied:
> 
> [gshan@gshan q]$ ./build/qemu-system-cris -cpu ?
> Available CPUs:
>    crisv8
>    crisv9
>    crisv10
>    crisv11
>    crisv17
>    crisv32
> 
> After it's applied:
> 
> [gshan@gshan q]$ ./build/qemu-system-cris -cpu ?
> Available CPUs:
>    crisv10
>    crisv11
>    crisv17
>    crisv32
>    crisv8
>    crisv9
> 
> Signed-off-by: Gavin Shan <gshan@redhat.com>
> ---
>   target/cris/cpu.c | 38 --------------------------------------
>   target/cris/cpu.h |  3 ---
>   2 files changed, 41 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~


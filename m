Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 22D4685E945
	for <lists+qemu-devel@lfdr.de>; Wed, 21 Feb 2024 21:53:45 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rctZh-0002CP-IJ; Wed, 21 Feb 2024 15:52:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rctZg-0002C8-Jc
 for qemu-devel@nongnu.org; Wed, 21 Feb 2024 15:52:16 -0500
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rctZe-0004ki-DL
 for qemu-devel@nongnu.org; Wed, 21 Feb 2024 15:52:16 -0500
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-41279203064so5511235e9.1
 for <qemu-devel@nongnu.org>; Wed, 21 Feb 2024 12:52:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708548733; x=1709153533; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=tAb+IZJURPm8lO9YaFguG0cjar2ldCOv1GxmfhUyOvI=;
 b=IwPL6G1kTDoJt8mvpbgOhi7/Q/KPHLF5l4NlJyOog5AcDFag/IDVkgPzKTEa3ulvyM
 EHTyWGXsN2NK9ZeB4G/S5uEluG5fc7u3Wmn2kzGeh4KGbYz54fUzcj5y48iCG7KUBlZK
 Ovl6lNEmA6kgd2UDXGDH0HsQmF3d5WHjYSAvTabiM8CT6RdtpvfZW2wyPa6Bq5VrXRkZ
 hEtaGPgWisHhgeUJEZo/UEHNkB1+zqHjTtoG7BhfdWXYfvaB7AhWHxqoQ8h4ikQstQyb
 K9MBudH53gFy6Z99wH9epgul2qLm+aQHXnGQF9P2rxrFOB+uiSWMbs0H1j67BhAvw70c
 C2nQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708548733; x=1709153533;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=tAb+IZJURPm8lO9YaFguG0cjar2ldCOv1GxmfhUyOvI=;
 b=k7Aev8Xvd+rvY4gxKemOyzMCH66QBQfZca74tX1lXma8zbY3vFCN6KHDqso+mIWwzQ
 gGZsaEO4Ex904D2MFpqB7zM1or+YqahjDo/TRsHfsXdkvgKAKCLZNWEqaaH8C9/vrlrg
 207CyM7yxiUeGou6Sebq/UYY0hc0Chc8bCY+zsrPiJIqx80yCuC3vjssAx7Il4Ks/TMa
 SDozK4xW0dnNA25PJPRMb0Ugge7Sq/cwWBdIt+R0A2Df4iYJFZXBblRo3eISGj+JPyoI
 FqG2AiMJK98x7f+Ijs0TEhyI+r6hC83q4+/nuf/ggtd0cg2sAyHo4yjYgBK3A/WftzwS
 dXAQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCV5ih1sXxkccv/JfcTnYwTcOKLVAgHX8GiksKLw3iHUl9cVvf3rDQqvjZMYrZNIKfR4MRpofHWyyJHubj6acufuukluOrQ=
X-Gm-Message-State: AOJu0Ywa5lVuHyyymY2Tl+JkP0BzgdDgE6dz9AFCwVGyAHR25Czj+FXB
 3rSOUIKfkn0u6wTN/SNzRLcx138X3XqUd29b+8zwXWY4/ApkDTV0cgxuyKnKSRU=
X-Google-Smtp-Source: AGHT+IHFcvvT0A7gVFwFmRnXIYybQPbzwaULRNy2hDjISmCIBeIZV7B7xTM6EbL2v57J3R47ypp5sQ==
X-Received: by 2002:a05:600c:5390:b0:411:c789:5730 with SMTP id
 hg16-20020a05600c539000b00411c7895730mr14142961wmb.35.1708548732611; 
 Wed, 21 Feb 2024 12:52:12 -0800 (PST)
Received: from [192.168.69.100] ([176.187.211.34])
 by smtp.gmail.com with ESMTPSA id
 m23-20020a7bca57000000b0041262355aeasm3628034wml.16.2024.02.21.12.52.11
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 21 Feb 2024 12:52:11 -0800 (PST)
Message-ID: <858c4ece-bfea-4211-aca9-4b541ad35fb8@linaro.org>
Date: Wed, 21 Feb 2024 21:52:10 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/7] hw/ide: Move IDE device related definitions to
 ide-dev.h
Content-Language: en-US
To: Thomas Huth <thuth@redhat.com>, John Snow <jsnow@redhat.com>,
 qemu-devel@nongnu.org
Cc: BALATON Zoltan <balaton@eik.bme.hu>, qemu-block@nongnu.org
References: <20240220085505.30255-1-thuth@redhat.com>
 <20240220085505.30255-5-thuth@redhat.com>
 <d1b005a8-ee10-414e-b76b-9c56ef657a9b@linaro.org>
 <767097cd-06f5-4eec-a778-94b60f947e2b@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <767097cd-06f5-4eec-a778-94b60f947e2b@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x330.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

On 21/2/24 20:13, Thomas Huth wrote:
> On 21/02/2024 19.43, Philippe Mathieu-Daudé wrote:
>> On 20/2/24 09:55, Thomas Huth wrote:
>>> Unentangle internal.h by moving public IDE device related
>>
>> Disentangle ... from? Untangle? TIL Unentangle.
> 
> You're right, "disentangle" seems to be the more appropriate word.
> I'll fix it up.

No need, series queued and fixed!

>> Anyway I'm not a native English speaker, so:
>> Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> 
> Thanks!
> 
>   Thomas
> 
> 



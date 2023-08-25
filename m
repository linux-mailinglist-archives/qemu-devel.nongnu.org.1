Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 75AA97885E1
	for <lists+qemu-devel@lfdr.de>; Fri, 25 Aug 2023 13:38:20 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qZV7L-00014H-Lt; Fri, 25 Aug 2023 07:36:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qZV7H-00012c-SU
 for qemu-devel@nongnu.org; Fri, 25 Aug 2023 07:36:39 -0400
Received: from mail-wr1-x42e.google.com ([2a00:1450:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qZV7E-00047Z-FK
 for qemu-devel@nongnu.org; Fri, 25 Aug 2023 07:36:38 -0400
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-307d58b3efbso618944f8f.0
 for <qemu-devel@nongnu.org>; Fri, 25 Aug 2023 04:36:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1692963394; x=1693568194;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=1KFbDqa7KTC9+seoswv8VJ3hVPmPN19uDYhxhL/KXMk=;
 b=P6JXG00x0U+hvwovCuOVVt9X7DxqlCsC8/TLcWCIW0Ysar1W8fwbDbvFAMF28IBud6
 1mh7XV6WkHEFG0LUq5lO9xONHk/HfmEJ++IUhi8h+ZPIeAUbcU9pFkTD+3b3DkgYMuac
 sph9o/7JbW1Jhdds3G3odGlBiGm4t+sJv7EHpsowCi3gfAWr8eJUEnUHp6UdWao1yWEK
 VY4R/p5uX3PrjiAJ+6x3gxDmk/krrvZH0W2uTsR77exjsyhAI8li8FEhWUHi11lS7mzL
 as7nJrmECfYj/W0RqK71E/h8DepRbXQ9KWmusdSAltM5JV6894EvOGPY5mFqhXSoyrZj
 KpBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692963394; x=1693568194;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=1KFbDqa7KTC9+seoswv8VJ3hVPmPN19uDYhxhL/KXMk=;
 b=hsxX0JVDvQtkJzbikeaA7dAjucVv0EjEZCl7x5oogsm2bEyXTDbawHhKDSmJR5+59P
 LJse0wDpTRz16mC5ofcDshJx9P31/VKZjxgJpFbrrTjgdtdLkQM5iJ7njjTdaMcbql81
 rOFTgqlOMYyQDOBoAo1coeU+ZlLU6Cp4zcyCFdDmnRknzycvWZ76BaPSQxRhso2S4Xq6
 QQeC5TBJ817S5mkxOON01cPV3NrW6kLpJObdwfDJoAoIIj6kLmPy9c5/C+Xn8/T46We5
 KgdPDdvk8ZiRsgaK5igYrGJ3WqKUBY26O6GeGpT5o8uEtVwcDmofScPNhzYNMJVGo9zm
 pkNQ==
X-Gm-Message-State: AOJu0YxMCmgjK7lGUF5UiY7Gy679RdA7tWr/Lu0T4lxOnykbF67zrFNS
 xoNbhJZpq/q8PoUEnYYVnTTVKw==
X-Google-Smtp-Source: AGHT+IF7rnqCBvtvaSxB3+arzlkRwu+N3IS68FkJCmpHw6Df9mv8zMeHHp31cHisNSkRolhAQPHOZw==
X-Received: by 2002:a5d:498e:0:b0:317:50b7:2ce3 with SMTP id
 r14-20020a5d498e000000b0031750b72ce3mr13702758wrq.51.1692963393754; 
 Fri, 25 Aug 2023 04:36:33 -0700 (PDT)
Received: from [192.168.69.115] ([176.164.69.26])
 by smtp.gmail.com with ESMTPSA id
 i15-20020a5d630f000000b0031989784d96sm1974734wru.76.2023.08.25.04.36.32
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 25 Aug 2023 04:36:33 -0700 (PDT)
Message-ID: <4781bd27-23a8-6ad8-ac1c-8e8369d14eba@linaro.org>
Date: Fri, 25 Aug 2023 13:36:29 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.14.0
Subject: Re: Failing avocado tests in CI (was: Re: [PULL 00/24] tcg +
 linux-user queue for 8.1-rc3)
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>
References: <20230806033715.244648-1-richard.henderson@linaro.org>
 <772eb951-8a43-902b-3737-e52b44f7dcdb@redhat.com>
 <59a970fb-ad7b-d30b-1290-7b167bec0226@linaro.org> <87sf88fobd.fsf@linaro.org>
 <5d1a0fcf-12a9-7b7a-7aa6-f4b5960a4d1e@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <5d1a0fcf-12a9-7b7a-7aa6-f4b5960a4d1e@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42e;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42e.google.com
X-Spam_score_int: -36
X-Spam_score: -3.7
X-Spam_bar: ---
X-Spam_report: (-3.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-1.57,
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

On 24/8/23 20:31, Richard Henderson wrote:
> On 8/24/23 08:31, Alex Bennée wrote:
>>> It's some sort of timing issue, which sometimes goes away when re-run.
>>> I was re-running tests *a lot* in order to get them to go green while
>>> running the 8.1 release.
>>
>> There is a definite regression point for the test_pc_q35 case:
> 
> Not exactly "definite" because it does vanish.
> 
>> which bisects to:
>>
>>    commit f7eaf9d702efdd02481d5f1c25f7d8e0ffb64c6e (HEAD, 
>> refs/bisect/bad)
>>    Author: Richard Henderson <richard.henderson@linaro.org>
>>    Date:   Tue Aug 1 10:46:03 2023 -0700
>>
>>        accel/tcg: Do not issue misaligned i/o
> 
> Well, since you can reproduce it, would you please debug it.

Not sure if that helps, but there is no failure when using -icount auto.


Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D5951744781
	for <lists+qemu-devel@lfdr.de>; Sat,  1 Jul 2023 08:59:46 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qFUZu-0006eW-QQ; Sat, 01 Jul 2023 02:59:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qFUZs-0006di-6o
 for qemu-devel@nongnu.org; Sat, 01 Jul 2023 02:59:28 -0400
Received: from mail-wr1-x430.google.com ([2a00:1450:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qFUZh-0008EY-Ni
 for qemu-devel@nongnu.org; Sat, 01 Jul 2023 02:59:27 -0400
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-3142860734aso597943f8f.1
 for <qemu-devel@nongnu.org>; Fri, 30 Jun 2023 23:59:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1688194756; x=1690786756;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=RITFnRrDrO6I338+of5HFzJT359Eu9SWXrbeWUUD5eU=;
 b=YtYPRT8onSjUOTXsFCTZIIjf4v4vttzBiBG/1i67sb46zEHqHZryV0qHph+fJz9XIt
 qwby5DZ58hbH3ZBXdpWsUqGMknktZl0b5BUG33+jvUfgW7NvhFYDrVaA515z0wX2EcSu
 G5ee9TuQ4F5LIXuSRQvkyD4nIddggKpnse+Z2HxQd6P8qdovVuS984/i25R9lN75bdz4
 J/EztVymI+4/0hnpyr5P49hGfTGpEtF4kDGb6kvJvIOy19QTtNY1zjMwpBS726dbYgom
 95WeRBuGZ1ObGisi4XAmVsycUIup8jEmk1J0SiALEQukK6i0a7mgfmCminwAzhVD/Z2R
 /Xhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688194756; x=1690786756;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=RITFnRrDrO6I338+of5HFzJT359Eu9SWXrbeWUUD5eU=;
 b=KFc6I4RVKD8bTAuysY5eimskoov7Vma3JW9uTPGXVI6OpZPZXGdbj2QoHlRJS3/RM8
 KbZM8saOYIkUZo8GzWUJ0p9obicoQwkDjy9QuiyX8M5l6UDeQTUWLn5e5W+c7+qSZyvU
 8XemkCYp2KgFQ5tgGF9f8jeTUagkgWWKRC1L+No3ClpMX18xf31slZu1L7s0KlwV0hqV
 Gr6fthT7wc2L8tcsmBZBU21caZ8rmM3S8CRwi5fogEqj0bJeyoAbHU534nBWTWlfFpkI
 C+yVImPDgaKgswfiBrrWq6VVUtQdR26FWjlvah4FYJw0Spsd05+oSTinuZkiVOW1pkEE
 MeOw==
X-Gm-Message-State: AC+VfDwdT3drOSsHAf6g/PYDJBAIscrLbZgSikYjjvc0srSDV5qkCHg6
 rxS1XsCYKU8DNJhz1e/AzuKV+g==
X-Google-Smtp-Source: ACHHUZ57cOKzV9h6yd/sSYDEjCQ6ARfH+b7hLic+4ohxd5mVvkBKIV9dtMXi4Ht+KnicxjLBzOZc8g==
X-Received: by 2002:a5d:4586:0:b0:314:3f1:cebf with SMTP id
 p6-20020a5d4586000000b0031403f1cebfmr9659371wrq.28.1688194756021; 
 Fri, 30 Jun 2023 23:59:16 -0700 (PDT)
Received: from [192.168.1.208] ([139.47.41.96])
 by smtp.gmail.com with ESMTPSA id
 m3-20020a056000180300b003141e9e2f81sm4254636wrh.4.2023.06.30.23.59.15
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 30 Jun 2023 23:59:15 -0700 (PDT)
Message-ID: <a0f19d7b-789c-cd97-6b5c-9b9630b62cff@linaro.org>
Date: Sat, 1 Jul 2023 08:59:13 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH] linux-user: Avoid mmap of the last byte of the reserved_va
Content-Language: en-US
To: Michael Tokarev <mjt@tls.msk.ru>, qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org
References: <20230629080835.71371-1-richard.henderson@linaro.org>
 <48a6d541-4edf-4738-1ca9-34cab29a8bdc@tls.msk.ru>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <48a6d541-4edf-4738-1ca9-34cab29a8bdc@tls.msk.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::430;
 envelope-from=richard.henderson@linaro.org; helo=mail-wr1-x430.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.095,
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

On 6/30/23 18:06, Michael Tokarev wrote:
> 29.06.2023 11:08, Richard Henderson wrote:
>> There is an overflow problem in mmap_find_vma_reserved:
>> when reserved_va == UINT32_MAX, end may overflow to 0.
>> Rather than a larger rewrite at this time, simply avoid
>> the final byte of the VA, which avoids searching the
>> final page, which avoids the overflow.
> 
> This hack appears to fix known issues and apparently does not
> introduce regressions.
> 
> Can it be applied to master and picked up from there, since
> master is also broken?  You can revert it in the subsequent
> patchset like the one you posted today.
> 
> You can add my:
> 
> Tested-by: Michael Tokarev <mjt@tls.msk.ru>
> Reviewed-by: Michael Tokarev <mjt@tls.msk.ru>

Yes, that's a good idea.  Queued to tcg-next.


r~



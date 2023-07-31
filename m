Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DF9E769B02
	for <lists+qemu-devel@lfdr.de>; Mon, 31 Jul 2023 17:45:00 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qQV4Y-0006Y8-Er; Mon, 31 Jul 2023 11:44:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qQV4J-0006Nx-9j
 for qemu-devel@nongnu.org; Mon, 31 Jul 2023 11:44:24 -0400
Received: from mail-pf1-x431.google.com ([2607:f8b0:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qQV4H-00009e-S9
 for qemu-devel@nongnu.org; Mon, 31 Jul 2023 11:44:23 -0400
Received: by mail-pf1-x431.google.com with SMTP id
 d2e1a72fcca58-686f38692b3so4431522b3a.2
 for <qemu-devel@nongnu.org>; Mon, 31 Jul 2023 08:44:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1690818260; x=1691423060;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=oObVEZ03WQ2hO2GHiiqmFtTX7gdoVHAxMKSUGAdrAGo=;
 b=ilQhmJRw6GaXpb+2w2/88vn+idbvbVnJw+VjOx/YFrSsty9NAjy9aWyh7igLlq3xK6
 ZVdwEPouxYSOVs7SWe8o42UukWk1BBu6lUrISL4vmquZWDHSIl/CR+UL5hAeKeNdrSDt
 M7GZRbrW1nqOiMVe2IVFv+XlQIHDJULjHAmTg3/Em0zbVai9Oo0d5GP+kELBKB1iiu55
 VkebQcV5ze0bayQcamEGsohT6Xsm6dx8qqzRwcVstkuVKRRHxTT0HYU2vW9danlO5A2c
 Wjw3Cm6nwqM1U6jMdCR5uoxGn3J5GINgGLWKYZcx3dmazIDj1c0PBmeAP7GIfb7djnfP
 851w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1690818260; x=1691423060;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=oObVEZ03WQ2hO2GHiiqmFtTX7gdoVHAxMKSUGAdrAGo=;
 b=gnf9UPYoUqpOUN80YS8y3mqPkxmjgUz8f04R9RXx5xwhFqyOhZyJtqgnoWFmWTNoNw
 bU1D0kZw154LwTdob9wN8f07aFWB6573t7wa6ZBU86tVVk08SMKKIOi9nMnAa2UxLTZt
 NHb4q4XuFo/6tr3v5X4C8kha3m2AE+vI77bKiq3vup9QtTkcIeuK9VnLM6pJgv1Qh2ec
 hdi7a4pL+KoPrN55/isUzta0EGNEeAK7yRunMWYtNi0rYEyh4YvlPRS3UpDU7O+fYnzC
 uQnXdzMZH5sEh9C725OUr3k8Y9Lpf76Xk3IliI6xhDwHJgG2Yswus8WeIivRU5qPQcfv
 hSPg==
X-Gm-Message-State: ABy/qLZGW7bmbs0N/5kDUrHnlfvg3lhEj9/8MC47sl6KSu2dOrAX41aP
 ldFISfi798TRq6ejrYLpYoBK+w==
X-Google-Smtp-Source: APBJJlFAc3c5tR+SE7xMkC6wTAnsVHmJTnePY4Sv5jJIWX7pY1LHg+C5HAsg3BvN5g81SW0S66wTQw==
X-Received: by 2002:a17:90a:5a4c:b0:268:18e:ade5 with SMTP id
 m12-20020a17090a5a4c00b00268018eade5mr9123379pji.24.1690818260194; 
 Mon, 31 Jul 2023 08:44:20 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.144.105])
 by smtp.gmail.com with ESMTPSA id
 29-20020a17090a1a5d00b0025c2c398d33sm6951809pjl.39.2023.07.31.08.44.19
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 31 Jul 2023 08:44:19 -0700 (PDT)
Message-ID: <85082725-0bc5-96a5-ef1d-b0e2985a4a8e@linaro.org>
Date: Mon, 31 Jul 2023 08:44:17 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 3/5] linux-user: Use MAP_FIXED_NOREPLACE for do_brk()
Content-Language: en-US
To: Akihiko Odaki <akihiko.odaki@daynix.com>,
 Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, Laurent Vivier <laurent@vivier.eu>
References: <20230731080317.112658-1-akihiko.odaki@daynix.com>
 <20230731080317.112658-4-akihiko.odaki@daynix.com>
 <CAFEAcA_gdK_nSkiaJQ2mDPeb3Se39AYN+DkDg1U-D2CJ1vUOuQ@mail.gmail.com>
 <9f2a49dd-75ce-4e23-3873-0ad4fd78277b@daynix.com>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <9f2a49dd-75ce-4e23-3873-0ad4fd78277b@daynix.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::431;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x431.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.101,
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

On 7/31/23 06:32, Akihiko Odaki wrote:
> On 2023/07/31 20:44, Peter Maydell wrote:
>> On Mon, 31 Jul 2023 at 09:04, Akihiko Odaki <akihiko.odaki@daynix.com> wrote:
>>>
>>> MAP_FIXED_NOREPLACE can ensure the mapped address is fixed without
>>> concerning that the new mapping overwrites something else.
>>
>> MAP_FIXED_NOREPLACE only came in with Linux 4.17. So
>> I think we still need to handle the "mapped address
>> is not the one we asked for" error condition, because
>> it can happen on older host kernels that ignore the
>> MAP_FIXED_NOREPLACE flag.
>>
>> thanks
>> -- PMM
> 
> MAP_FIXED_NOREPLACE is substituted with MAP_FIXED before passing to the host with patch 1. 
> The NOREPLACE constraint is still ensured by inspecting the guest page table.

Won't work for 64-bit guests.


r~



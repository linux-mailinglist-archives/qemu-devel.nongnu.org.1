Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C463170719E
	for <lists+qemu-devel@lfdr.de>; Wed, 17 May 2023 21:12:27 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1pzMYH-0006yB-IN; Wed, 17 May 2023 15:11:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1pzMYE-0006vV-00
 for qemu-devel@nongnu.org; Wed, 17 May 2023 15:11:06 -0400
Received: from mail-pl1-x633.google.com ([2607:f8b0:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1pzMYA-000077-Sf
 for qemu-devel@nongnu.org; Wed, 17 May 2023 15:11:05 -0400
Received: by mail-pl1-x633.google.com with SMTP id
 d9443c01a7336-1ae454844edso9491675ad.1
 for <qemu-devel@nongnu.org>; Wed, 17 May 2023 12:11:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1684350661; x=1686942661;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=RbL6qi/wj98SmsSl5gibOn+93osLkjRMxXeX+u0rzsI=;
 b=GyeI37jsHREd7iT5WzVJNXv1mTFozBScKdRyB795rVinZw+pkf8g9n6f7SFJHEbEL5
 re3Gr/cQtZjwMEwJxkVC5/vSuvWj67DH6pNVbvNZmW9lCIFyItljgQ1LGevEStJXGBT1
 AlWPQ3+JbMeJNu7eq6ntsvtVSmThOqmdvPiQFcA/vR0mrGQa8EPKxrwy9qjdC1C/u2IH
 GYVwxEKQTLXnAaRJeeiXG2OaK9wUhB05lCDhAjkZ4QDFSAOwOguEOqa2giPgbh76uV7s
 GwI+9yariocBETdrW+PRakyYhKOUbkie1UY8qVc9VyPj9eGoxV/g/QXbqJPZiZ1w27w1
 XUYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684350661; x=1686942661;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=RbL6qi/wj98SmsSl5gibOn+93osLkjRMxXeX+u0rzsI=;
 b=Ok8xrDqybq8NUYd8cwgkfPUZReRS4PEdsjFE38O2pavyMsW4xBdKZdD6bzOY1Rac9U
 vkxfqk5ecfCIic6IywGSvdqrviFuqe0JXUknSLjaK4HzS4fAAu/RIJwk2x7y2kL+5Ulm
 MbcTmS6392WU2jSKC9jDXMksr4c9JE5RCXHRtxiAmXax4PSNwSgHj7vhm6Y/shw1WKYu
 yKI1qto3aLDFRo5SOLftlMIT3NiZbGEZ0DyQ5mw5kkZZmDvu1pYSyjNf9mu6+8CDkk//
 5dPr+7zyGTKPoLyxX+EHCtDr5UNo0fOny3eXeyeD4V2M2MtIz5wGXqRP/k1tZFAc31Wr
 HseA==
X-Gm-Message-State: AC+VfDztwjVe2S0E5+anUa2R7qQ6E6+93axLtwJO4msFXKAA60lHT6F1
 CkIXCxV61JzuiJOBVxqy3L0M/A==
X-Google-Smtp-Source: ACHHUZ5+38z8h1j3ok7B6fxZIox1eXgEqwLZDJX/4p4OBbSNCNYSXCpEkGbq4lG3CFHZOvzPWRdAZw==
X-Received: by 2002:a17:902:6b03:b0:1a6:a1ec:53a3 with SMTP id
 o3-20020a1709026b0300b001a6a1ec53a3mr40530341plk.3.1684350661291; 
 Wed, 17 May 2023 12:11:01 -0700 (PDT)
Received: from ?IPV6:2602:ae:1598:4c01:17a4:1aa0:c49d:e8f7?
 ([2602:ae:1598:4c01:17a4:1aa0:c49d:e8f7])
 by smtp.gmail.com with ESMTPSA id
 k10-20020a170902694a00b001aafa2e212esm17873559plt.52.2023.05.17.12.10.58
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 17 May 2023 12:10:59 -0700 (PDT)
Message-ID: <1d53f391-7fa4-f60d-119c-0cacb14209d6@linaro.org>
Date: Wed, 17 May 2023 12:10:57 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PULL 18/18] tested: add test for nested aio_poll() in poll
 handlers
Content-Language: en-US
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org
References: <20230517165116.475123-1-kwolf@redhat.com>
 <20230517165116.475123-19-kwolf@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230517165116.475123-19-kwolf@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::633;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x633.google.com
X-Spam_score_int: -34
X-Spam_score: -3.5
X-Spam_bar: ---
X-Spam_report: (-3.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-1.412,
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

On 5/17/23 09:51, Kevin Wolf wrote:
> From: Stefan Hajnoczi <stefanha@redhat.com>
> 
> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> Message-Id: <20230502184134.534703-3-stefanha@redhat.com>
> Tested-by: Kevin Wolf <kwolf@redhat.com>
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> ---
>   tests/unit/test-nested-aio-poll.c | 130 ++++++++++++++++++++++++++++++
>   tests/unit/meson.build            |   1 +
>   2 files changed, 131 insertions(+)
>   create mode 100644 tests/unit/test-nested-aio-poll.c

This new test fails on windows:

https://gitlab.com/qemu-project/qemu/-/jobs/4304413315#L3375
https://gitlab.com/qemu-project/qemu/-/jobs/4304413313#L3357


r~


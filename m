Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B0EED737107
	for <lists+qemu-devel@lfdr.de>; Tue, 20 Jun 2023 17:56:08 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qBdhZ-000397-HO; Tue, 20 Jun 2023 11:55:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qBdhU-00038J-AH
 for qemu-devel@nongnu.org; Tue, 20 Jun 2023 11:55:24 -0400
Received: from mail-ed1-x52c.google.com ([2a00:1450:4864:20::52c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qBdhS-0005C7-Ke
 for qemu-devel@nongnu.org; Tue, 20 Jun 2023 11:55:24 -0400
Received: by mail-ed1-x52c.google.com with SMTP id
 4fb4d7f45d1cf-51a3e7a9127so8539155a12.1
 for <qemu-devel@nongnu.org>; Tue, 20 Jun 2023 08:55:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1687276521; x=1689868521;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=5EjdYSK6uwJlUxiQ/9t03UH4gZNYinvfc21zQqD6zDU=;
 b=CBDzBCSzBkQWhqpNL8a76hylnvcMrdyCjX63pN6jU93AaP8NeptLcLZMsGpvxU0fZ0
 fPh4WBOcolJbgvkCiC7afAT9cAb55nxX+oljRZk+asvxmO4J30lKDOuk3ORYtPu7X5To
 DNIRVqZ+jLEmdKHtV2+7MGXVKQrnDdF1cQ7F98+Y5Qm0bE9iL78EMi9FvQYAXj3SGOCm
 cjHq7v+SN+awakQWer58tZAMoV6HwG+sdTKHCa/Efntntu+r+gvMazPwmm3DvwUQZox9
 FkJaudauIwCsr1mDTisTjKKxCNR8P0kFjZFKxFZ1Kg7CZ7V0VD4pVDQ4HQg3a+xkLPkv
 MFtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687276521; x=1689868521;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=5EjdYSK6uwJlUxiQ/9t03UH4gZNYinvfc21zQqD6zDU=;
 b=J2hbTw4l/CP96UJGmn0Fjv783Q+lCLtUCna5ZqcX3XHPZfZEZn6ictIQmMudPAioSN
 yVzruBJTlB8Wyo/ZDpvAA2YGtxAoXGjPBG9ZB1wPYUwKcUEE44wR5vkB/2/+XyiQE1YE
 DSOc4AHmNklQl79wG+gZSlldhB7VJHuQXbPW2AakzCRH+k2F078ACHNYLGHWCNwq5R8z
 vvpBf6gKgQCWrxyuwXHn6clSTPzfNekXLtUgiaTkOPzLJnpjY1v19M+U136j6QsJoR8+
 5mM9ki97cdEGc+aBjTkRanZ/Jjyp3lXcacp1hBf5H+DeMpGcCUWfDHP21gxbxDXcIdaI
 JNBw==
X-Gm-Message-State: AC+VfDxODAgIiO+hmKJbtO81TG3nyxvT9r+tgAIDAL7jLqoTPla64uEp
 iD5ak8rcLe0vSpQtAtOyKjEPYi/+6FF28wKXEEV9aPXI
X-Google-Smtp-Source: ACHHUZ5YsyVZ3vjEqSzTvbqqWxjUezGERIfs3KVvrZ03xAP180Sq9VvKWThhO+ZLsjwhTH4j5N8ATw==
X-Received: by 2002:a05:6402:31f5:b0:51a:2d16:66f6 with SMTP id
 dy21-20020a05640231f500b0051a2d1666f6mr9890089edb.20.1687276521166; 
 Tue, 20 Jun 2023 08:55:21 -0700 (PDT)
Received: from [192.168.69.129] ([176.176.183.29])
 by smtp.gmail.com with ESMTPSA id
 k22-20020a056402049600b0051bc58b8dbcsm1368513edv.59.2023.06.20.08.55.20
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 20 Jun 2023 08:55:20 -0700 (PDT)
Message-ID: <bcafa996-128a-d25c-f35a-115b26498710@linaro.org>
Date: Tue, 20 Jun 2023 17:55:18 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [RFC PATCH] qemu-keymap: properly check return from
 xkb_keymap_mod_get_index
Content-Language: en-US
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org
References: <20230620150335.814005-1-alex.bennee@linaro.org>
 <CAFEAcA9jWuxVVb-+rbv4dEF+0_P1+5z7Z6HQajGv5Jg3yje11g@mail.gmail.com>
 <87bkhai1p4.fsf@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <87bkhai1p4.fsf@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::52c;
 envelope-from=richard.henderson@linaro.org; helo=mail-ed1-x52c.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.09,
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

On 6/20/23 17:37, Alex Bennée wrote:
> ar maybe? it only got flagged in clang-system once fedora was updated (I
> assume with better sanitizers):
> 
>    [2773/3696] Generating pc-bios/keymaps/ar with a custom command
>    FAILED: pc-bios/keymaps/ar
>    /builds/stsquad/qemu/build/qemu-keymap -f pc-bios/keymaps/ar -l ar
>    ../qemu-keymap.c:223:16: runtime error: shift exponent 4294967295 is too large for 32-bit type 'int'
>    SUMMARY: UndefinedBehaviorSanitizer: undefined-behavior ../qemu-keymap.c:223:16 in
>    [2774/3696] Generating pc-bios/edk2-x86_64-code.fd with a custom command (wrapped by meson to capture output)
>    [2775/3696] Generating pc-bios/edk2-x86_64-secure-code.fd with a custom command (wrapped by meson to capture output)
>    ninja: build stopped: subcommand failed.
>    make: *** [Makefile:153: run-ninja] Error 1
> 
> https://gitlab.com/stsquad/qemu/-/jobs/4500683186#L3957

Related:

https://gitlab.com/qemu-project/qemu/-/issues/1709
https://gitlab.com/qemu-project/qemu/-/issues/1712

which note that keymaps/ar has changed to keymaps/ara in xkeyboard-config from 2.38 to 2.39.


r~



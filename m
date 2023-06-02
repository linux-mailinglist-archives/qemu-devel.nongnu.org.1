Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B5C70720C38
	for <lists+qemu-devel@lfdr.de>; Sat,  3 Jun 2023 01:16:00 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q5Dyk-00080o-1u; Fri, 02 Jun 2023 19:14:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1q5Dyi-00080g-9B
 for qemu-devel@nongnu.org; Fri, 02 Jun 2023 19:14:40 -0400
Received: from mail-wr1-x430.google.com ([2a00:1450:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1q5Dyg-0005Go-30
 for qemu-devel@nongnu.org; Fri, 02 Jun 2023 19:14:39 -0400
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-30ae69ef78aso3011204f8f.1
 for <qemu-devel@nongnu.org>; Fri, 02 Jun 2023 16:14:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1685747674; x=1688339674;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=ttFKDfisrnCDkYvmg1WkgFctjFiNKmQXhXbgwRvSl7o=;
 b=r5vBvd58ze/192a+lTPSpb5t6gRNNbAob0S+i0SzA3Fl2mUzApDb4/mZVG78ZJiO11
 fDVSYT4tg8LFW5ZRy4cfSyPrLBfUEjL+7cDOB1WCyfjCIPZlhYHegQRgAmlC9GhOeBqz
 q/c+lJNP5+7O3qpJlVBl9OLnr53Rjp8TSxsIDrjdyVvDrpHnb03LTkDh1nA4d6vnM6AE
 XoiG+dH4N01nOpkKInRrHYMbmDUnMIJ+TQY2FCOvjDeBG2n7Me5nY5aAsR7AcMpbqKm7
 BvYVRpdRg7g9ZkGSOPl9gT5OdttsiT9D/gMz9W4Ir/uNZrXbGKueDjxnklDgEK0eWbIi
 a/+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685747674; x=1688339674;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ttFKDfisrnCDkYvmg1WkgFctjFiNKmQXhXbgwRvSl7o=;
 b=kSfioaXy6db3MSYCIBKME0vEQMSEXKWEqM/KPNG6q5FrQvEY7xMAgbWNvO/qMNyKsZ
 qFwTdPCbgRu7ZTRwKwQtkfU/htaG3HPws6DVOoin0fvrhbYq6LdDI+X2XA6r8lRbERe9
 mCeEQhm9FKBY9SA1uE3A+xGVLJdOZqXAyWtwlCH91JAGH0dCh3aL2asWnB+xd3GbHdVM
 cfsFhmeRzYUH0TxYWh3GkMXz5C9BG+gMtJnonInkkzShg0A94tJYxzfRjf83Wk6unYLN
 jTIzObsf+0CD6IpIXXNnsY5/pAyHFxdINArsT7Ax6EpAVwa0SQ3Qd66mvH3mxsNVprfl
 aSlg==
X-Gm-Message-State: AC+VfDzMICdKNZw7pValhiwLM2t+uDrh4VJ8mOkPX9G/VLQ4g4sw7Qbk
 X9u3yhoEQEKqeR5gkwVR17WXqUHGcOB21OuXIPI=
X-Google-Smtp-Source: ACHHUZ59yMhZqlC3/0IKFOXdxlQlP5ahR00nq2KEpCfigS9sERl9iFZ0KmvZ5nHLaQLFF3ndfE3j8Q==
X-Received: by 2002:a5d:5581:0:b0:309:48eb:993d with SMTP id
 i1-20020a5d5581000000b0030948eb993dmr972248wrv.15.1685747674519; 
 Fri, 02 Jun 2023 16:14:34 -0700 (PDT)
Received: from [192.168.69.115] ([176.187.218.254])
 by smtp.gmail.com with ESMTPSA id
 i13-20020a5d438d000000b0030ae3a6be4asm2799866wrq.72.2023.06.02.16.14.33
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 02 Jun 2023 16:14:34 -0700 (PDT)
Message-ID: <9cd4b1cf-f8f9-2bb9-0546-872be0f25e86@linaro.org>
Date: Sat, 3 Jun 2023 01:14:32 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.11.0
Subject: Re: [RFC PATCH 2/2] bulk: Replace !CONFIG_USER_ONLY -> CONFIG_SOFTMMU
Content-Language: en-US
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Thomas Huth <thuth@redhat.com>, Markus Armbruster <armbru@redhat.com>
References: <20230602225811.60152-1-philmd@linaro.org>
 <20230602225811.60152-3-philmd@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230602225811.60152-3-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::430;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x430.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.095,
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

On 3/6/23 00:58, Philippe Mathieu-Daudé wrote:
> CONFIG_SOFTMMU is the opposite of CONFIG_USER_ONLY.
> Now that CONFIG_SOFTMMU isn't poisoined anymore,
> replace !CONFIG_USER_ONLY negation by the positive
> form which is clearer when reviewing code.
> 
> Change mostly done mechanically using:
> 
>    $ sed -i -e 's/ifndef CONFIG_USER_ONLY/ifdef CONFIG_SOFTMMU/' \
>             -e 's/!defined(CONFIG_USER_ONLY)/defined(CONFIG_SOFTMMU)/' \
>                 $(git grep -l CONFIG_USER_ONLY)
> 
> and adapting comments manually.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>

*Sigh* I was not building in the correct build directory,
now I realize this patch is crap because the CONFIG_SOFTMMU
definitions is not propagated on all objects.

Please disregard...


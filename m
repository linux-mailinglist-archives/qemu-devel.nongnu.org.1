Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BBD6753258
	for <lists+qemu-devel@lfdr.de>; Fri, 14 Jul 2023 08:56:58 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qKCj3-0006Uj-Nj; Fri, 14 Jul 2023 02:56:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qKCj1-0006UO-7s
 for qemu-devel@nongnu.org; Fri, 14 Jul 2023 02:56:23 -0400
Received: from mail-pg1-x52f.google.com ([2607:f8b0:4864:20::52f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qKCiw-00073K-Ay
 for qemu-devel@nongnu.org; Fri, 14 Jul 2023 02:56:22 -0400
Received: by mail-pg1-x52f.google.com with SMTP id
 41be03b00d2f7-553b2979fceso723072a12.3
 for <qemu-devel@nongnu.org>; Thu, 13 Jul 2023 23:56:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1689317777; x=1691909777;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=foEaLFX8KMgUyuIBJtXqPi7GafqmcF/xw/u41e+TOWk=;
 b=HhoAGlYRpXVGnG5V3gfy/fWwqmztzE3h7aQcRzhg0VSz6xnr58sZxczal1ijoQweIC
 TvWz5ulOP+hJAQKCQqnPb2Bo0fS0bOHQZ00GNlA49r7OMt4FKkIJ27mvQnelm22eN9Di
 ilNTyl+X/iFipIOtOOxzof0E5MUZAW2Xd1TEtHpa+vi1S3sRn14NXay0LcIdcVstfzv2
 2u9y7Ao/7nCPq2O72/kyrlMD3/PRt0C/kh7cLGUlzTAtIGNXYqfEvjxnmLm+wuPCLAit
 uYcwa8BaO7d7M2TFmkR5vYoiqTjOw1AJThECkr8dUuXzsfiXMDL3UK5pvkIblKYA6Jpc
 gTuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689317777; x=1691909777;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=foEaLFX8KMgUyuIBJtXqPi7GafqmcF/xw/u41e+TOWk=;
 b=DMSlVMACYcNZom0gVh9wAhNe3xPN6tIl1IKoa98nQ2NOBiBgy6JaJ9uMEVsMXVseoQ
 D/d3ucKz1WFci7CWO3v/TFfDNA7bKPFtwc1ibufkuExB9Azvw311ebmy9nYw+tkh1pNK
 q2nIS0hHNBZJmYHVAUTTvELH99GG8rrMK/cGmAesQoucJqlq91pnyslHm40oJmzpR/M6
 89M82d9bsWmhjE0FvO29ZW3CYb8OvWaPzH/i5xx9xZ8X+dE7EMCJWHWWA0HiKPkAj5Fa
 bTLjTeHxej/pTI3q7xHLdSfrmgvaW7l5rEKokEJpdu5PZAlcV79h8vj3mXBXdak4+wdS
 CILw==
X-Gm-Message-State: ABy/qLZFZGnlox4b/wr5+ByyQAZm0aQ902sKqI7QME0YAjEeWPvN3hiy
 iotRe9lHuuEqobm877yoFwZsgFKlkqylQPIQg18Agw==
X-Google-Smtp-Source: APBJJlE6d9hQwH8FrO20wbJ0bTuneSPE60Czujy6eebW1h0vb+7gLcQ9xFFHA+2BWF9YDWksGm7fag==
X-Received: by 2002:a17:902:c381:b0:1b8:9db5:2ec1 with SMTP id
 g1-20020a170902c38100b001b89db52ec1mr2536584plg.67.1689317776915; 
 Thu, 13 Jul 2023 23:56:16 -0700 (PDT)
Received: from [192.168.149.227] ([172.58.27.104])
 by smtp.gmail.com with ESMTPSA id
 x22-20020a170902821600b001b8a897cd26sm6947822pln.195.2023.07.13.23.56.12
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 13 Jul 2023 23:56:16 -0700 (PDT)
Message-ID: <5bb250f0-744e-8820-b9b2-0ce1a0eee3a3@linaro.org>
Date: Fri, 14 Jul 2023 07:56:09 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v2 05/11] hw/char/pl011: Split RX/TX path of
 pl011_reset_fifo()
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Evgeny Iakovlev <eiakovlev@linux.microsoft.com>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 Gavin Shan <gshan@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 qemu-arm@nongnu.org
References: <20230710175102.32429-1-philmd@linaro.org>
 <20230710175102.32429-6-philmd@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230710175102.32429-6-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52f;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x52f.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.096,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01,
 T_SPF_HELO_TEMPERROR=0.01 autolearn=unavailable autolearn_force=no
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

On 7/10/23 18:50, Philippe Mathieu-Daudé wrote:
> To be able to reset the RX or TX FIFO separately,
> split pl011_reset_fifo() in two.
> 
> Signed-off-by: Philippe Mathieu-Daudé<philmd@linaro.org>
> Reviewed-by: Alex Bennée<alex.bennee@linaro.org>
> ---
>   hw/char/pl011.c | 19 ++++++++++++++-----
>   1 file changed, 14 insertions(+), 5 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~


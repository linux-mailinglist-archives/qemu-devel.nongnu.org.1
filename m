Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C028875324F
	for <lists+qemu-devel@lfdr.de>; Fri, 14 Jul 2023 08:56:07 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qKChf-0005ff-2s; Fri, 14 Jul 2023 02:54:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qKChd-0005e6-8e
 for qemu-devel@nongnu.org; Fri, 14 Jul 2023 02:54:57 -0400
Received: from mail-pg1-x529.google.com ([2607:f8b0:4864:20::529])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qKChb-0001UY-R4
 for qemu-devel@nongnu.org; Fri, 14 Jul 2023 02:54:57 -0400
Received: by mail-pg1-x529.google.com with SMTP id
 41be03b00d2f7-55b5a3915f5so983642a12.0
 for <qemu-devel@nongnu.org>; Thu, 13 Jul 2023 23:54:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1689317694; x=1691909694;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=8XreADdZGjiQFEnjQQAMs4fWo4glXBmdWp5So2413Ik=;
 b=n/wQthjzTj+0SNlXMQfpKfsOPpJSWxrm57qk1R/kOcEu7GoqaKwOILW2I+zBog1hvY
 fMZmuLNsYb4wf00npY7J2OGEi4xVWOjzTlzyHqVP8i1rABUtAqkuGuAsKfeT5SojgPNE
 VClwCtgyvHUAc7dFiNqtXO/aCBSkhEOFDu4RYPyZTKS+MyMaiJp45ekzCK6qwvIFwJvl
 sh6RVQaHZ9qI8NS+LXL+Gw6+VExBHAOuuJO8sWs/BHEs/JJy92PyGwqsKZFbRLphcl1U
 Z8VrB4lwMGv3sRipjewKLMtF34LE987pesR9Pk1BPJCdUqirWjPAnM6T+U5vMQS9/XhV
 Ky9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689317694; x=1691909694;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=8XreADdZGjiQFEnjQQAMs4fWo4glXBmdWp5So2413Ik=;
 b=bPq5qVXa/PLg2DKcbA3e7969Q+RL1tc/Vmuxpqp10fOYA7N1g62BXGGZKccvziutI0
 SMfH5hZbA5fW2CjGaboD1nNSYNUfNKdyu4/Z+v0ios6+ftqM3SeVz5t5IfF18nZYUiW+
 3xfiESoUdP+ET3hf7cxwJVvrhl5kIpzLydymzcFlGdsrX0PmzXc9vBu1+ZODzIMagyys
 3tVPoc0LQBuZXXloLVaXuCU26KnkdXis20ua6lWfkGv1HoLIA5jX90vjN5koiANcu3JC
 fl8OM/9HDT7j4HmDHWvbUz9hIddwhc96uQR50NR3CAxiHHJQ7PPSyOdZZ4d5q9JKHI2q
 LpdQ==
X-Gm-Message-State: ABy/qLbt2O9+/mmhZw7nPhj5I8sY0tk2h/hiNW7LIfCvfGnti4v8Z8Ao
 glUfKIoqzz6aFM55qxIW4aP2Bw==
X-Google-Smtp-Source: APBJJlGY2Kuo1stsMM9qF7TcsW1N5flabFei245JKgjfeZ/HkfO3LeByhIDc7gVFG/DHx4yYVh4yQw==
X-Received: by 2002:a05:6a20:5499:b0:12c:9f36:e7b9 with SMTP id
 i25-20020a056a20549900b0012c9f36e7b9mr3308417pzk.2.1689317694339; 
 Thu, 13 Jul 2023 23:54:54 -0700 (PDT)
Received: from [192.168.149.227] ([172.58.27.104])
 by smtp.gmail.com with ESMTPSA id
 b15-20020a170903228f00b001b872c17535sm7022915plh.13.2023.07.13.23.54.50
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 13 Jul 2023 23:54:53 -0700 (PDT)
Message-ID: <3784cbec-d137-3df7-291f-b283595058c4@linaro.org>
Date: Fri, 14 Jul 2023 07:54:45 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v2 04/11] hw/char/pl011: Replace magic values by register
 field definitions
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
 <20230710175102.32429-5-philmd@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230710175102.32429-5-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::529;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x529.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.096,
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

On 7/10/23 18:50, Philippe Mathieu-Daudé wrote:
> 0x400 is Data Register Break Error (DR_BE),
> 0x10 is Line Control Register Fifo Enabled (LCR_FEN)
> and 0x1 is Send Break (LCR_BRK).
> 
> Signed-off-by: Philippe Mathieu-Daudé<philmd@linaro.org>
> Reviewed-by: Alex Bennée<alex.bennee@linaro.org>
> ---
>   hw/char/pl011.c | 22 +++++++++++++++-------
>   1 file changed, 15 insertions(+), 7 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~


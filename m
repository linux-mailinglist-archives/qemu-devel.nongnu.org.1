Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EE477242A5
	for <lists+qemu-devel@lfdr.de>; Tue,  6 Jun 2023 14:44:32 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q6VyW-0003Eu-NZ; Tue, 06 Jun 2023 08:39:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1q6Vy3-0002rb-96
 for qemu-devel@nongnu.org; Tue, 06 Jun 2023 08:39:19 -0400
Received: from mail-wr1-x435.google.com ([2a00:1450:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1q6Vxx-0000jQ-LG
 for qemu-devel@nongnu.org; Tue, 06 Jun 2023 08:39:15 -0400
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-30c5e5226bdso4098015f8f.2
 for <qemu-devel@nongnu.org>; Tue, 06 Jun 2023 05:39:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1686055151; x=1688647151;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=giH5+9PRQ02fyC6kYPCR2wTx5ypu7bqp8+hyoOIuEws=;
 b=TAKBOC9g9XUHEu2HJUEZmf66BtKydRJ9q835WZ4h4dEePXuju0mrOPT6fP9VY5JRKo
 T1bUgNlMq+kte0eGxPXZz4LA+bpQAyui2Ap/G4/5XBvzklGgPXsPKT1XeQtjqZhyxyWD
 wy3iJm89zjvW2d2vkZMB1cgHjB4qHFK9rD62lB7EMtposLnwSj/zVf/pd2W3EYzEHM/l
 GLMBdlU/hA3KLIauGZW0hUovuIDe/HG8OXDRU5rPSLW+dM8bXJUI/8kLX70bplNZWpvU
 euK8MzaqrEPm7NHrpEw41C7S39LO8IVVmlqGM55+8qpFycNTUMzLIOsimqDtos8jGVBl
 OgtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686055151; x=1688647151;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=giH5+9PRQ02fyC6kYPCR2wTx5ypu7bqp8+hyoOIuEws=;
 b=SIlsIoOfIv7rQtOHvp6l8+nCb9gf88a2qFaZtftNPzhGC+pxmdnqVqTZr7fv0M3ToX
 OdI2v6EAl5NuQpaodWJmLXM+fxidQ9Yo9CRqMCchfaekIXrUXJKpePpujCHIr9Z4QLYw
 7dQEMz0USch6RZNHmTYaPkS+4dFVV/wVupa6NNdnp7Dj96ddtN81LFpscjiMiEXLfn+e
 ZnYilkGXh6ixmfc049WKZh5VqpKXjghA+fDffU+KQSvhrWD0VQuQt7XwVbKTiOizWgqn
 57mPyYASqgmcI40xbQw52HyqLGSD5x4P2bDZQGYDoYQDasuUqszhjRpLQ5dzL8Kc/SkV
 PzAw==
X-Gm-Message-State: AC+VfDwvFNtg+XPPa/EQGSNMIyUiGzv5zquJcJNMDy+lleLruuwmWDYy
 dEQjTY3rSpPs7T1lSGtw+11YQQ==
X-Google-Smtp-Source: ACHHUZ6VbSzWXmI6yOU+mcR7m1d/Xhe2dNcDfnyYdnfGyAShTQjSZHUw2fR2v7c0wkLJcKJNrs+qsQ==
X-Received: by 2002:adf:f212:0:b0:30d:5cce:3bb5 with SMTP id
 p18-20020adff212000000b0030d5cce3bb5mr1751618wro.60.1686055151712; 
 Tue, 06 Jun 2023 05:39:11 -0700 (PDT)
Received: from [192.168.69.115] (vbo91-h01-176-184-50-104.dsl.sta.abo.bbox.fr.
 [176.184.50.104]) by smtp.gmail.com with ESMTPSA id
 p6-20020a056000018600b0030aefd11892sm12501132wrx.41.2023.06.06.05.39.10
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 06 Jun 2023 05:39:11 -0700 (PDT)
Message-ID: <635fdcd8-23fe-c0db-c912-3aa0517dd4b7@linaro.org>
Date: Tue, 6 Jun 2023 14:39:08 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.11.2
Subject: Re: [PATCH 2/2] hw/sd/allwinner-sdhost: Don't send non-boolean IRQ
 line levels
Content-Language: en-US
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
Cc: Beniamino Galvani <b.galvani@gmail.com>,
 Strahinja Jankovic <strahinja.p.jankovic@gmail.com>,
 Guenter Roeck <linux@roeck-us.net>, qemu-stable@nongnu.org,
 Michael Tokarev <mjt@tls.msk.ru>
References: <20230606104609.3692557-1-peter.maydell@linaro.org>
 <20230606104609.3692557-3-peter.maydell@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230606104609.3692557-3-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::435;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x435.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.094,
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

Hi Peter,

On 6/6/23 12:46, Peter Maydell wrote:
> QEMU allows qemu_irq lines to transfer arbitrary integers.  However
> the convention is that for a simple IRQ line the values transferred
> are always 0 and 1.  The A10 SD controller device instead assumes a
> 0-vs-non-0 convention, which happens to work with the interrupt
> controller it is wired up to.
> 
> Coerce the value to boolean to follow our usual convention.

I remember once wanting to convert qemu_set_irq() to take a boolean
argument but someone said using integer was more useful because ...?
I searched a bit but can't find that in my mail archives, maybe this
was on IRC. Any clue? (I find simpler to use a boolean rather than
having a convention of using integers restricted to [0, 1] range).

Regards,

Phil.


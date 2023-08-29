Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AD2678C784
	for <lists+qemu-devel@lfdr.de>; Tue, 29 Aug 2023 16:27:39 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qazgQ-00038q-HW; Tue, 29 Aug 2023 10:27:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qazgP-00037b-E9
 for qemu-devel@nongnu.org; Tue, 29 Aug 2023 10:27:05 -0400
Received: from mail-lf1-x12c.google.com ([2a00:1450:4864:20::12c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qazgL-0005Hk-3q
 for qemu-devel@nongnu.org; Tue, 29 Aug 2023 10:27:05 -0400
Received: by mail-lf1-x12c.google.com with SMTP id
 2adb3069b0e04-4fe15bfb1adso6970102e87.0
 for <qemu-devel@nongnu.org>; Tue, 29 Aug 2023 07:27:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1693319219; x=1693924019;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Ehtc+6OrHlqRes37XA4HVDuT2STxpnQYFMX3JbL2Erk=;
 b=vX116y1dRKwvRpduPZ9RmBhTJ69K2/oL0mOY3VJWFhOOoxDIdQp073LkZuo2fuCF1x
 eXdMTxHdQmTjoxk4RTm8ZgN/hSOqoOepTTEtEVkrBhhlP6cc5BHnPs9X6VrAV8vuRUhL
 aocRU0hTf9MJfe1v5yM/9Ovh72NpZ6cKEimD+c4JbP7oQCOclUAP162B5h4wDfAfdJHC
 rMUxIdwCplp8kE1OZUg8QdWFfyfkwsFFa2+fPxUAJq6P9AV/EJdKznTWjPpA6aCFD9Xl
 mIiRiottbsavqyEKyVj4eH+qDfQUsXtG6NUNw0rDu9EF8BIvEJ8QGaynwG1+V/PK8CvP
 gxqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693319219; x=1693924019;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Ehtc+6OrHlqRes37XA4HVDuT2STxpnQYFMX3JbL2Erk=;
 b=cPn/PRX7lOb48SoqBAeLhvERW7D1qZ3Fftdn3pOaGNDVFMZIm0P4j3uWh1u4vkFgve
 ahqbgojV7tYD3cipAiSKahWjYpdzl/5BpeQSrTe9KNPtIhc96fRs/XUZ26ScOOes6ILA
 1Iu9UjACEycEMYazLb1BUM5Ui7JlWH0SYoJ+qw9caQiSKwupPcYehA5j2w+c6niuVmp9
 9pINUtzoZVNJwffgtpLY07FqzratUm+IiUJCHu2HmongX47jDjTM0t8M/zAdFta4yRY2
 X13Kt/GsHT5kb9ThoMxDC0FG/nFPWM9Kcg5PLz8f9O4RPI/GqUrbp6eH4ziMVgxVEniH
 glhA==
X-Gm-Message-State: AOJu0YyvD6tB3EUGelLn65DZY2xXDD0Kwvj41juCCk/juS5oEIQmF7VF
 0Pjwxl4Mjj8wbThy6x0RDCR6gCmaeol8z3zS7nE=
X-Google-Smtp-Source: AGHT+IGRS3+4YlsdiuW5YgzLnNsnWkUN0nHFhA7U7rLgiJEOFjLzLN8r28Chheo8mEkvsMvFSZkDBw==
X-Received: by 2002:a19:381d:0:b0:500:96fc:129d with SMTP id
 f29-20020a19381d000000b0050096fc129dmr10744219lfa.14.1693319219292; 
 Tue, 29 Aug 2023 07:26:59 -0700 (PDT)
Received: from [192.168.69.115] (sml13-h01-176-184-15-56.dsl.sta.abo.bbox.fr.
 [176.184.15.56]) by smtp.gmail.com with ESMTPSA id
 a8-20020a1709066d4800b0098e422d6758sm5970882ejt.219.2023.08.29.07.26.58
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 29 Aug 2023 07:26:58 -0700 (PDT)
Message-ID: <e3f0ee9c-7720-8017-91f6-3e662bea8b40@linaro.org>
Date: Tue, 29 Aug 2023 16:26:57 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.14.0
Subject: Re: [PATCH 07/10] meson: do not use config_host to pick tap
 implementations
Content-Language: en-US
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
References: <20230829082931.67601-1-pbonzini@redhat.com>
 <20230829082931.67601-8-pbonzini@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230829082931.67601-8-pbonzini@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::12c;
 envelope-from=philmd@linaro.org; helo=mail-lf1-x12c.google.com
X-Spam_score_int: -32
X-Spam_score: -3.3
X-Spam_bar: ---
X-Spam_report: (-3.3 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-1.242,
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

On 29/8/23 10:29, Paolo Bonzini wrote:
> The target OS is invariant and does not depend on the configuration, so move
> away from config_host and just use unconditional rules in softmmu_ss.
> 
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>   net/meson.build | 18 ++++++++++--------
>   1 file changed, 10 insertions(+), 8 deletions(-)

Nice.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>



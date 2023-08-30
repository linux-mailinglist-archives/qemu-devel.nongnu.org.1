Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id EC86778D4C7
	for <lists+qemu-devel@lfdr.de>; Wed, 30 Aug 2023 11:43:51 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qbHgx-0006H8-QX; Wed, 30 Aug 2023 05:40:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qbHgv-0006FX-Lq
 for qemu-devel@nongnu.org; Wed, 30 Aug 2023 05:40:49 -0400
Received: from mail-wr1-x42f.google.com ([2a00:1450:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qbHgs-0001RD-Gv
 for qemu-devel@nongnu.org; Wed, 30 Aug 2023 05:40:49 -0400
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-31ad9155414so4250901f8f.3
 for <qemu-devel@nongnu.org>; Wed, 30 Aug 2023 02:40:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1693388445; x=1693993245; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=RrrvwDtJP3AZowEV7JVzB50ZQN9LutCZLe9szuB4gMI=;
 b=AuAXDbAnYDZTHk2x5p0lNbIPms87MaGpaFjKkSi4QjlTgT87T2pN3zHEYZeYfmtz/p
 w0lfLIHIl3VwJf3aEa6dep0cM7Bb0BkBj2P1CYz9Z6Bhrdg0u3IFxKX2bgG3q+eaALqd
 65C7hbZNWy2Aq83O87T5N0rTCqmAlw4Z3YUFwgAtkce0yodzYLAg6tzeUFqs9oIMU/5h
 KQ88HpdoyUdZ1knI5D5zWw2aHyK0rZtAD7xn0yLfGZwSfB1XgqGZT5/TY7YxUAlKyORz
 A8xZ2p4kJIZse7UlnWiN6mdZspCTqHefBWaHeuMFBUwM0K2qcYpvy86v6OiZzolLgoS6
 DZAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693388445; x=1693993245;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=RrrvwDtJP3AZowEV7JVzB50ZQN9LutCZLe9szuB4gMI=;
 b=JZvSomMABMpJshvmnYmjNmK7VxFQHPBPOCERp1wecHVrlrwl56cF+6jrO3S8P6G9ce
 EC3TjTfxUCdHBw6m6QwAI2SH1KJa0K5EmURf8aTNMwx1b6YqEaY5x0CATq60Yn74trjE
 CdQW0t/XQhI8vARL61fNG7B4y/Wr0XDbiAl1Oo/ZU0i6aTHqmOgm0N0xCVyovsZ739fJ
 eDl/c4y0k77bQXV5jt5rpnJhIBDcHqViROy0w3S6IVkkeGDqJF0vcvqCx+eBvElaOjwW
 7Es3ntvD8Hbw4wB3cCXm+0J7MzSvU7PCdApqCPSnL7coi06Hmw9yMrpi0oUAgGJeLG7h
 4HRA==
X-Gm-Message-State: AOJu0Yw8Ws+xBP/LU39k3fxSY+uCYYobM5EgH63WGSCTfHmNpmWuaiEs
 sbk7PUHfC2mBEQSkUFI5cOAqpg==
X-Google-Smtp-Source: AGHT+IFDtsr3H3RYvs/DqXQFVycjFXhl1haisIMldTfduYHjkGJYYZfh9wH5bygm7ZXMvZv3B4SCBg==
X-Received: by 2002:a05:6000:108c:b0:317:e68f:e1b2 with SMTP id
 y12-20020a056000108c00b00317e68fe1b2mr1021784wrw.28.1693388444816; 
 Wed, 30 Aug 2023 02:40:44 -0700 (PDT)
Received: from [192.168.18.115] ([91.219.21.246])
 by smtp.gmail.com with ESMTPSA id
 j4-20020a5d6184000000b0030ae53550f5sm16255661wru.51.2023.08.30.02.40.43
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 30 Aug 2023 02:40:44 -0700 (PDT)
Message-ID: <94f1f839-b168-e2f7-2d50-58d5dc522cf2@linaro.org>
Date: Wed, 30 Aug 2023 11:40:43 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.14.0
Subject: Re: [PATCH v2 2/4] nbd: drop unused nbd_start_negotiate() aio_context
 argument
Content-Language: en-US
To: Stefan Hajnoczi <stefanha@redhat.com>, qemu-devel@nongnu.org
Cc: Leonardo Bras <leobras@redhat.com>, eblake@redhat.com,
 =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 farosas@suse.de, kwolf@redhat.com, Peter Xu <peterx@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 Juan Quintela <quintela@redhat.com>, qemu-block@nongnu.org,
 Coiby Xu <Coiby.Xu@gmail.com>, Fam Zheng <fam@euphon.net>,
 Hanna Reitz <hreitz@redhat.com>
References: <20230829160623.277411-1-stefanha@redhat.com>
 <20230829160623.277411-3-stefanha@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230829160623.277411-3-stefanha@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42f;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42f.google.com
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

On 29/8/23 18:06, Stefan Hajnoczi wrote:
> aio_context is always NULL, so drop it.
> 
> Suggested-by: Fabiano Rosas <farosas@suse.de>
> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> ---
>   nbd/client.c | 11 +++--------
>   1 file changed, 3 insertions(+), 8 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>



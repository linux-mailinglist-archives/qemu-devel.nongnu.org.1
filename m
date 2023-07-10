Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 72BE574D7F1
	for <lists+qemu-devel@lfdr.de>; Mon, 10 Jul 2023 15:42:49 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qIr9j-0000s3-3V; Mon, 10 Jul 2023 09:42:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qIr9g-0000r6-L8
 for qemu-devel@nongnu.org; Mon, 10 Jul 2023 09:42:20 -0400
Received: from mail-wr1-x432.google.com ([2a00:1450:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qIr9d-0006n5-W0
 for qemu-devel@nongnu.org; Mon, 10 Jul 2023 09:42:20 -0400
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-3142ee41fd2so4532243f8f.3
 for <qemu-devel@nongnu.org>; Mon, 10 Jul 2023 06:42:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1688996533; x=1691588533;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=vG+Dg364KO9I/c62hB38t2OpronlH4pFKmqX4idIxSU=;
 b=LDeVt14EbyU061yBD2tbUXviHoCgZw/YERwsch7yFmSfJ0iqSaM6HvS1G2KGx0MYKJ
 7z+uR2tCi6o1M5BWzYPXT6AiFss0GV9efyezldCmjO5bLh7ssvReV3YQOBIU3x3WS3ME
 CiEvWVg3v9hykggE4dAvSVcBDcc6vEE6vgIajE80HH/7YGS02y0CuzA9wvp+3e9a2qQ/
 +ujcleE6mUEWLD/XhhKDL1QShm2aZCXUq5KQUKLQ7XOdmRxY6+CNyXzZKf/2/KVDCsS0
 MJ3kXSwH+cEQ7bI7s7cHQt6IiBI803p46K8srysJbX7v7rGI0r/z1H3tlI0IcS8FqHfX
 mFoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688996533; x=1691588533;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=vG+Dg364KO9I/c62hB38t2OpronlH4pFKmqX4idIxSU=;
 b=VCm67cnAWontdc1sNb0KMgd0tnvMBiquOUlUHVLYVsZ2huD6Ax46gz56uG06KGJLLH
 6dCHX1Lr1+yGzUQ4UsPtw3TE/B1O0JcCP/N4Vav73fcxYzizVgJ/Qk7EWD5MCuRqcWrO
 0buQOPrPw5bLU1ebe6UnWxFJbVzJrozjdOUfYxCSjgTRVHlokvGpVddqDZ0pv53PnkSa
 p8hx9TzCjsK2l/XfDjv4KgJfF0gTQALfh1Ai7x8frIgKFR+7pZ3QbO1rQKtfbQcESgCA
 KazranRvGN9ZBlCMoPdrso5YXKDF7UcDyODgxkfSA8RYtb4B0O4oRBHETgEkyfSavAsj
 5ItA==
X-Gm-Message-State: ABy/qLagtDW2Irr0jg+lOld2I8Vp1bLS8km1Tegacy6R8k5Q8X4pjYDJ
 +U3FGOvsh1Nvmu+Uugj7YMPvFA==
X-Google-Smtp-Source: APBJJlGXRgVUyONn6uGtYkRhMxnt6rmTv0JYJTirNNQkwQyvBr45BF03mTFDXYGtjxyyMkmPMWki4g==
X-Received: by 2002:a5d:4fc5:0:b0:313:ea84:147a with SMTP id
 h5-20020a5d4fc5000000b00313ea84147amr10327526wrw.64.1688996533306; 
 Mon, 10 Jul 2023 06:42:13 -0700 (PDT)
Received: from [192.168.69.115] (mst45-h01-176-184-47-225.dsl.sta.abo.bbox.fr.
 [176.184.47.225]) by smtp.gmail.com with ESMTPSA id
 o5-20020a056000010500b0030c4d8930b1sm11778909wrx.91.2023.07.10.06.42.11
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 10 Jul 2023 06:42:12 -0700 (PDT)
Message-ID: <2b7a3ab6-e174-f4a8-e1a8-cf2e5a55ab90@linaro.org>
Date: Mon, 10 Jul 2023 15:42:09 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.13.0
Subject: Re: [PATCH 2/4] chardev/char-fe: Clarify qemu_chr_fe_add_watch
 'condition' arg is a mask
Content-Language: en-US
To: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@gmail.com>
Cc: qemu-devel@nongnu.org, Gerd Hoffmann <kraxel@redhat.com>,
 Joel Stanley <joel@jms.id.au>, Markus Armbruster <armbru@redhat.com>,
 Alistair Francis <alistair@alistair23.me>,
 Laurent Vivier <lvivier@redhat.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 "Dr. David Alan Gilbert" <dave@treblig.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Amit Shah <amit@kernel.org>,
 qemu-riscv@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>,
 Jason Wang <jasowang@redhat.com>, qemu-arm@nongnu.org,
 =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>
References: <20230705133139.54419-1-philmd@linaro.org>
 <20230705133139.54419-3-philmd@linaro.org>
 <CAJ+F1CJ_vkZRK4F7mYY_+rFZmHMuO6ivB8L=aemJswgrvUhHWA@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <CAJ+F1CJ_vkZRK4F7mYY_+rFZmHMuO6ivB8L=aemJswgrvUhHWA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::432;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x432.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.101,
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

On 10/7/23 13:19, Marc-André Lureau wrote:
> 
> 
> On Wed, Jul 5, 2023 at 5:33 PM Philippe Mathieu-Daudé <philmd@linaro.org 
> <mailto:philmd@linaro.org>> wrote:
> 
>     qemu_chr_fe_add_watch() can poll for multiple conditions.
>     It's @cond argument is a combination of all the condition bits.
> 
>     Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org
>     <mailto:philmd@linaro.org>>
>     ---
>       include/chardev/char-fe.h | 4 ++--
>       1 file changed, 2 insertions(+), 2 deletions(-)
> 
>     diff --git a/include/chardev/char-fe.h b/include/chardev/char-fe.h
>     index 8c420fa36e..309960046a 100644
>     --- a/include/chardev/char-fe.h
>     +++ b/include/chardev/char-fe.h
>     @@ -179,8 +179,8 @@ typedef gboolean (*FEWatchFunc)(void
>     *do_not_use, GIOCondition condition, void *
> 
>       /**
>        * qemu_chr_fe_add_watch:
>     - * @cond: the condition to poll for
> 
>     - * @func: the function to call when the condition happens
>     + * @cond: bitwise combination of conditions to poll for
>     + * @func: the function to call when the conditions are satisfied
> 
> 
> Not really worth imo, do you want to also fix all the io/ docs for 
> @condition? and probably elsewhere...
> 
> The rewording of @func isn't much clearer either... "any of the conditions"?

Hmm OK I'll just drop this patch for now, thanks.


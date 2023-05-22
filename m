Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 88A4570C14A
	for <lists+qemu-devel@lfdr.de>; Mon, 22 May 2023 16:40:51 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q16h0-0008SS-LE; Mon, 22 May 2023 10:39:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q16gy-0008SJ-3o
 for qemu-devel@nongnu.org; Mon, 22 May 2023 10:39:20 -0400
Received: from mail-pf1-x434.google.com ([2607:f8b0:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q16gw-0006EM-E5
 for qemu-devel@nongnu.org; Mon, 22 May 2023 10:39:19 -0400
Received: by mail-pf1-x434.google.com with SMTP id
 d2e1a72fcca58-64d5b4c400fso1985597b3a.1
 for <qemu-devel@nongnu.org>; Mon, 22 May 2023 07:39:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1684766357; x=1687358357;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=kKji7brr4/IRQBaroWt3D0Op1H9NbBWcaVyG8x9lm1M=;
 b=Py7PnwHncCYLqcb604+0xeAWbZI573KUg+G4ga6rAxVoS1Y6DrolkXaIykvo9badjo
 RJlEMdYJlwzexnFO9hUfvNabY0DtEOYJCGudPflSvKiezV4ItHUtvDrJ8GML3h7mPZSA
 KdG80Wb8zdQ6L9va54x59+ZpOJ0prdAwH9pV43cu0KfNMvMMGukBkbxeUvTak5mMonJ6
 LGzVmIbN8nZvcFkIKByGfoMfZ9lBaC4Pi9CyeWAywI+TQQIp/VgfV46cAlPKrvplLcyZ
 MHC9jfva9Y303HNDy6OCaSijIACkBgJuvBWYP7hzlyMH8l65Yzf5c6YqzKMsxZW2SOUS
 69HA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684766357; x=1687358357;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=kKji7brr4/IRQBaroWt3D0Op1H9NbBWcaVyG8x9lm1M=;
 b=BlYi9K/In6rtf4IG0WuMjTn54yNUX1cWftJFUisVkTqXPhMdaU/WsQxVRpA11BaNlo
 6sfOglqGii+iORy6MS0qciQfEJGfg0Z818XUKNbyYh4vkgXnL/4uEtlIO+Nsx47IaWCW
 HXwCFpJQi3mVE+3MjzNpEMzN2XsXpjhSeVsEjtKgIb4ygdwdwgKbpPN04C7ZCuR/Pj4c
 3DbIy4OjruCCoxdJryr33m+fxbu78M8Y3m85Vszo5xeKULfYM7Bz0ekkPUhbHhU5VN6L
 L9wY+XJziJefPpm2FZZAdSRayQIGnhZRkmxSaTmPIY3OC2dyGCRTlnoVLkKRK7DD6OxH
 MBgA==
X-Gm-Message-State: AC+VfDwR6g9B9yonqfvj8XEEIX3/YGhYe6rcNGULEsYVazfWe8lcK9mt
 J4wZWEZPeWpIDqUG5+XWL4CKhA==
X-Google-Smtp-Source: ACHHUZ4qCK3IceHyRmEwHKx+651ATA4tebqZUgxEKViYF4902zfr0TfRY5QaVFu3vkOVKHgTiKiQTg==
X-Received: by 2002:a05:6a00:1814:b0:646:9232:df8 with SMTP id
 y20-20020a056a00181400b0064692320df8mr15924334pfa.15.1684766356831; 
 Mon, 22 May 2023 07:39:16 -0700 (PDT)
Received: from [10.0.14.188] (static-66-243-253-154.ellensburg.fairpoint.net.
 [66.243.253.154]) by smtp.gmail.com with ESMTPSA id
 v15-20020aa7850f000000b0063a04905379sm4248178pfn.137.2023.05.22.07.39.16
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 22 May 2023 07:39:16 -0700 (PDT)
Message-ID: <9223027b-07af-7fc6-103f-3281c7562fa9@linaro.org>
Date: Mon, 22 May 2023 07:39:14 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH] meson: remove -no-pie linker flag
Content-Language: en-US
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: vr_qemu@t-online.de, marcandre.lureau@redhat.com
References: <20230522080816.66320-1-pbonzini@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230522080816.66320-1-pbonzini@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::434;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x434.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.091,
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

On 5/22/23 01:08, Paolo Bonzini wrote:
> The large comment in the patch says it all; the -no-pie flag is broken and
> this is why it was not included in QEMU_LDFLAGS before commit a988b4c5614
> ("build: move remaining compiler flag tests to meson", 2023-05-18).
> 
> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/1664
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>   meson.build | 13 +++++++++----
>   1 file changed, 9 insertions(+), 4 deletions(-)
> 
> diff --git a/meson.build b/meson.build
> index 0a5cdefd4d3d..6733b2917081 100644
> --- a/meson.build
> +++ b/meson.build
> @@ -267,10 +267,15 @@ endif
>   # has explicitly disabled PIE we need to extend our cflags.
>   if not get_option('b_pie')
>     qemu_common_flags += cc.get_supported_arguments('-fno-pie')
> -  if not get_option('prefer_static')
> -    # No PIE is implied by -static which we added above.
> -    qemu_ldflags += cc.get_supported_link_arguments('-no-pie')
> -  endif
> +  # What about linker flags?  For a static build, no PIE is implied by -static
> +  # which we added above.

Is it though?  That was the major problem at the time: it wasn't.

IIRC, debian has enabled link-pie-by-default, so '-static' meant '-static-pie'.  Moreover, 
not all of their static libraries were built -fpie, which led to link errors.

Trying both now, e.g. '--static --disable-system --disable-tools --disable-docs',
a link line contains

... -Wl,--as-needed -Wl,--no-undefined -pie -Wl,--whole-archive libhwcore.fa ...
                                        ^^^^

Where does that come from, and why isn't -no-pie the antidote?


r~


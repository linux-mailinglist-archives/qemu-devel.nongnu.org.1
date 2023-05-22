Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8855170C2D0
	for <lists+qemu-devel@lfdr.de>; Mon, 22 May 2023 17:55:50 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q17rT-00060R-J3; Mon, 22 May 2023 11:54:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q17rR-0005y6-1T
 for qemu-devel@nongnu.org; Mon, 22 May 2023 11:54:13 -0400
Received: from mail-pj1-x102a.google.com ([2607:f8b0:4864:20::102a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q17rP-00066i-91
 for qemu-devel@nongnu.org; Mon, 22 May 2023 11:54:12 -0400
Received: by mail-pj1-x102a.google.com with SMTP id
 98e67ed59e1d1-253570deb8dso3792377a91.1
 for <qemu-devel@nongnu.org>; Mon, 22 May 2023 08:54:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1684770849; x=1687362849;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=FQiPxQehculiryxaHDAQcjPK8SkpxRHFkU8nz3e8/yM=;
 b=rK1Id13Vh88BpC5lW0/UdV2JVRQUnTLkx1Pl1N/zgznM13PxeGw0yXbm25CtlZ7q1g
 iNSWZ2Ji/F/lb6ZZ5/0CJqJPvEk+RbZHjur6Y+uAofxJNg4ulDgMJiYc48qzBQ2NGL8X
 gq8/eulWrQehVxdpKHPkW82gB4rjso31jBQVBK1Ugqf9SwrReExZKP6DRgT+GEqpC7U5
 s+7QBbeWC9Kvbvs9S39wpoRw5AwHO5GbP8cb8L6WenEab0QyTgRUznI0pPfDcrDBOA+5
 mVlRATnCzbtvkmZ/nVoDoI5k+fJZYticMQbZ4baO6gyDvtC+Ho+5w5g5l99w+uaNMarc
 2Nzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684770849; x=1687362849;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=FQiPxQehculiryxaHDAQcjPK8SkpxRHFkU8nz3e8/yM=;
 b=O30PirIvVtbDA8Iv5oQHfL19mc4QSZLMlGK6r9UrJ0R480kU4EItYLJbC+MoakMN6j
 Oe/dzRfTYGSwj38voMXf57+6FlMhKJl+1014DWXMF6K5LpxFv590y6RUXEsxjEvmnrSa
 46qSdRoTHoNKKbQwjYbxgAweeOjfWy+3awgSD2UVL0wi/vbjK5U8PKEgnNm9c9pdVaRQ
 CrO0KjGLDB60lQgsNjnVgwZY+MfJQ1Me3ZllBlvR9DDSsBtj7/SDIlinKeuSw8OYHunQ
 2UjSaoLjCwN2NVID6J9TkXz4hzoY5TN2gK7mXtT5ks6mktDdSvtoAxlOQLv1rW8h2XI2
 pfog==
X-Gm-Message-State: AC+VfDyj3UZCYRZVTNcAmxs8ehw81L4vMewdQnCeboJju6+i4nfJ0zI2
 32jhS5su/N64XfBbqG3FpJVN/Q==
X-Google-Smtp-Source: ACHHUZ45cAc/f50vUaD07esll/IrZvUr6ywEVrZbpLJ7Uki6WsD9t63yiOdJN9SEJdYvTtalFN6Gzw==
X-Received: by 2002:a17:90b:1e50:b0:252:b14a:55c2 with SMTP id
 pi16-20020a17090b1e5000b00252b14a55c2mr10099239pjb.9.1684770849232; 
 Mon, 22 May 2023 08:54:09 -0700 (PDT)
Received: from ?IPV6:2607:fb90:8063:704:7944:82ed:f254:5737?
 ([2607:fb90:8063:704:7944:82ed:f254:5737])
 by smtp.gmail.com with ESMTPSA id
 mp14-20020a17090b190e00b00247735d1463sm4269730pjb.39.2023.05.22.08.54.08
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 22 May 2023 08:54:08 -0700 (PDT)
Message-ID: <e36730f8-5f32-1bfb-b09a-d6943732f0df@linaro.org>
Date: Mon, 22 May 2023 08:54:05 -0700
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
Received-SPF: pass client-ip=2607:f8b0:4864:20::102a;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x102a.google.com
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

It's not nearly as simple as that.

> +  # What about linker flags?  For a static build, no PIE is implied by -static
> +  # which we added above.  For dynamic linking, adding -no-pie is messy because
> +  # it overrides -shared: the linker then wants to build an executable instead
> +  # of a shared library and the build fails.  Before moving this code to Meson,
> +  # we went through a dozen different commits affecting the usage of -no-pie,
> +  # ultimately settling for a completely broken one that added -no-pie to the
> +  # compiler flags together with -fno-pie... except that -no-pie is a linker
> +  # flag that has no effect on the compiler command line.

-no-pie is a linker flag, but distro folk that didn't quite know what they were doing made 
local changes to gcc's specs file.  So it *is* a compiler command-line flag, but only for 
some builds of gcc.

We can't just remove -no-pie, we need to probe for it as cc.get_supported_arguments 
instead of cc.get_supported_link_arguments.

Or something.  It's a mess, for sure.


r~



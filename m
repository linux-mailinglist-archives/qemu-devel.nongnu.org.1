Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C4E337CEC93
	for <lists+qemu-devel@lfdr.de>; Thu, 19 Oct 2023 02:08:02 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qtGYt-0005C2-5A; Wed, 18 Oct 2023 20:06:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qtGYr-0005Bn-AI
 for qemu-devel@nongnu.org; Wed, 18 Oct 2023 20:06:49 -0400
Received: from mail-pf1-x432.google.com ([2607:f8b0:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qtGYp-0000ws-8v
 for qemu-devel@nongnu.org; Wed, 18 Oct 2023 20:06:49 -0400
Received: by mail-pf1-x432.google.com with SMTP id
 d2e1a72fcca58-6bd96cfb99cso3297368b3a.2
 for <qemu-devel@nongnu.org>; Wed, 18 Oct 2023 17:06:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697674005; x=1698278805; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=fhnhdLi000+qRZyvXgetQio/v4QW1omlTIQQG540hX0=;
 b=aMSJE73AfUll2UfddeyOMxcgtnjS2eKouPT7OOY5iZ1fI5bmwhPCM7XEnVgikEVZIg
 KGQBHeQI9sS43jPXF37FikBwgOLX6mbGPHBhKKZ1U7RbCg8nmPkda5MvJdWz1pI0SyKA
 JnjU6hgEyo2hVouJ06UdOs6WirNs3cXRSKqWG3Vhtn1Z+tdo+lxJ+Yn0RqPGVgf2w6qI
 lTHB7K4XGPIe+BzULelV+zOI0QP+VWgrwtRLD5vLfn+jLxrv4f2z/5LXRxvrUS45Rpul
 vJY1sg/kdd7kO/q3rn9NdYUrMjlXvXmm71PyCLZMjaIh/uSAE942ST1kflUaXSbeHF5q
 gXGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697674005; x=1698278805;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=fhnhdLi000+qRZyvXgetQio/v4QW1omlTIQQG540hX0=;
 b=vV3GkzbdtDzgEB+cfJhL1JdUqjSO93mobLId0hpbfru13BPEUdeUjIVAVzQlVcUg8f
 J67vZjsVlAL6dzO3mMeS2JFxOIYwVBsTgUbb1iIlGy4NvGlV3ge6jBhsX02TLxl0+UX2
 LWzd0weTcnHLNAWqbn9fF6acckiOOWbycBuHnxw1JEpGD+XANKG2xJ3HfMWhqmZTyqT+
 kRT78TQx+pQ6leAI5XqV0cO/K9OvXJG22HCgTWSj/IImeOYdwYHRfloZmefZ9yO32yFx
 s01ECD4Fsty19gh/7Dqu2EgZNtDxq/jEE+XOgw2/8b1z7vJmaO3WvHwAWiWfdfFQURqH
 e4bQ==
X-Gm-Message-State: AOJu0YytLWCbyi/HkVkXGOE7IKcpKKr64b4QH559W9mw5UzGAdOwtCv6
 G0CkW8kCB8oPLvH/bEfvUCMDetS68KruCOE3LlE=
X-Google-Smtp-Source: AGHT+IEiRJof5guNoLlH678fjjqXrGIM9KgWvJ88Abi0rU+oRN9arUfNrRiROQUL56tKAOJn/LfoMw==
X-Received: by 2002:a05:6a00:1344:b0:690:c306:151a with SMTP id
 k4-20020a056a00134400b00690c306151amr723473pfu.0.1697674005502; 
 Wed, 18 Oct 2023 17:06:45 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.149.95])
 by smtp.gmail.com with ESMTPSA id
 v64-20020a626143000000b006be0b0fc83asm4035581pfb.125.2023.10.18.17.06.44
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 18 Oct 2023 17:06:45 -0700 (PDT)
Message-ID: <2ebff1c7-e820-40db-ae5b-6cb8e6e4f359@linaro.org>
Date: Wed, 18 Oct 2023 17:06:43 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 02/17] meson: do not use set10
Content-Language: en-US
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
References: <20231016063127.161204-1-pbonzini@redhat.com>
 <20231016063127.161204-3-pbonzini@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20231016063127.161204-3-pbonzini@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::432;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x432.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

On 10/15/23 23:31, Paolo Bonzini wrote:
> Make all items of config-host.h consistent.  To keep the --disable-coroutine-pool
> code visible to the compiler, mutuate the IS_ENABLED() macro from Linux.
> 
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>   include/qemu/compiler.h     | 15 +++++++++++++++
>   meson.build                 |  2 +-
>   tests/unit/test-coroutine.c |  2 +-
>   util/qemu-coroutine.c       |  4 ++--
>   4 files changed, 19 insertions(+), 4 deletions(-)
> 
> diff --git a/include/qemu/compiler.h b/include/qemu/compiler.h
> index 1109482a000..c797f0d4572 100644
> --- a/include/qemu/compiler.h
> +++ b/include/qemu/compiler.h
> @@ -212,4 +212,19 @@
>   # define QEMU_USED
>   #endif
>   
> +/*
> + * Ugly CPP trick that is like "defined FOO", but also works in C
> + * code.  Useful to replace #ifdef with "if" statements; assumes
> + * the symbol was defined with Meson's "config.set()", so it is empty
> + * if defined.
> + */
> +#define IS_ENABLED(x)                  IS_EMPTY(x)
> +
> +#define IS_EMPTY_JUNK_                 junk,
> +#define IS_EMPTY(value)                IS_EMPTY_(IS_EMPTY_JUNK_##value)
> +
> +/* Expands to either SECOND_ARG(junk, 1, 0) or SECOND_ARG(IS_EMPTY_JUNK_CONFIG_FOO 1, 0)  */
> +#define SECOND_ARG(first, second, ...) second
> +#define IS_EMPTY_(junk_maybecomma)     SECOND_ARG(junk_maybecomma 1, 0)

Clever that.

However, if I had a preference I would go the other way and model after glibc:

Convert everything away from ifdef and always use set01.
Then enable -Wundef so that you catch typos in the usage of these macros.

But this is an improvement of a sort so,
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~



Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4486481FECA
	for <lists+qemu-devel@lfdr.de>; Fri, 29 Dec 2023 10:55:02 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rJ9ZY-0007Pq-6X; Fri, 29 Dec 2023 04:54:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rJ9ZJ-0007PZ-GA
 for qemu-devel@nongnu.org; Fri, 29 Dec 2023 04:54:17 -0500
Received: from mail-ed1-x52a.google.com ([2a00:1450:4864:20::52a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rJ9ZH-0003Eu-Ps
 for qemu-devel@nongnu.org; Fri, 29 Dec 2023 04:54:17 -0500
Received: by mail-ed1-x52a.google.com with SMTP id
 4fb4d7f45d1cf-5537dd673e5so5415260a12.0
 for <qemu-devel@nongnu.org>; Fri, 29 Dec 2023 01:54:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1703843654; x=1704448454; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=ySwWi0rCvEbpZsSOJ/TOPF+NtutBM8Iw3/impWisCyg=;
 b=o8MeLA2fCa3NLde5yT+rvYeY+/LV1TZOLMoDDfNX0mulgfcXs/GC3qDYix/icoc8ok
 w6BRcJ9MxdLK1eoZLY3e1YjFKffS58yWgBm+dUrSgYqCkOpnukifV/GO5jPVl91L1k6b
 ulsO66VJNd6t9Awb7y1wbErfjyzdIGlTee38Mq5077xcAfUzfCrG237X4sqlmnSENaKt
 SL5HoYwwOJUlogE+fXsNzkMJqFl2y91UOmliPKcmSpvaCCnGqk44cNPyUx/EAi4HTKWj
 SKUeh6ugrr5cws++e6stPHTTvKV8OF1IaPf5AtqUshSXuI8X2lgJQmBgH4YOHk27Xk7i
 YO7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703843654; x=1704448454;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ySwWi0rCvEbpZsSOJ/TOPF+NtutBM8Iw3/impWisCyg=;
 b=c/xiIOo4/cA3vMlGwg/IDISZ9YL4rFPK6WQQccKt4LYWEjSnzI0IGLhREI356eM7Xa
 p4vsgZhI9Bwj3soFqArXovCDwxUc7VRFzCht4aAJmg8ZM205W5QPsu8vQfLc5P5PgRJX
 UWEcqUp0XJPGMugoAdFUMVVIgQh41wnbIwhyW3XOMxHeYXWuntQFkhbLppyZyKSmijU8
 Ucidd4A6jQFJMptwuj4sAAAd2MuGFfC+dfZRflFwofj/3smexbeuGWhPvKGrfaoD3RSk
 j5ajmVWIhFa0lDs1vMvlW7AFxnjMbdql9KtjGCgsI+h9O9cSMjNN5958KWk4MqNKoEUG
 zBkg==
X-Gm-Message-State: AOJu0Yxifzq8gd6nMr/PvXoLcvGVUEs0xUul0Se38AwGK/Dzy/0ObaI5
 vllz+KLt5Tx0PluyWKzPy5MlXnfKEtR/JgSVmSmGlpk2oDY=
X-Google-Smtp-Source: AGHT+IGtQSS4qZFEVRng2YpOd21NjB5A3lAxRDpo81RR2JvTg1MA9BlMiVgIjsH7mxdPk5roiy7qCQ==
X-Received: by 2002:a50:9f82:0:b0:555:11da:d813 with SMTP id
 c2-20020a509f82000000b0055511dad813mr3324767edf.83.1703843654105; 
 Fri, 29 Dec 2023 01:54:14 -0800 (PST)
Received: from [192.168.69.100] ([176.187.202.55])
 by smtp.gmail.com with ESMTPSA id
 fi11-20020a056402550b00b005550192159bsm4908811edb.62.2023.12.29.01.54.13
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 29 Dec 2023 01:54:13 -0800 (PST)
Message-ID: <da95f303-c23c-4389-a3e9-42fcf0f90e9b@linaro.org>
Date: Fri, 29 Dec 2023 10:54:12 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 16/21] meson: separate host-specific checks from option
 validation
Content-Language: en-US
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
References: <20231221171958.59350-1-pbonzini@redhat.com>
 <20231221171958.59350-17-pbonzini@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20231221171958.59350-17-pbonzini@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::52a;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x52a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

On 21/12/23 18:19, Paolo Bonzini wrote:
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>   meson.build | 97 +++++++++++++++++++++++++++--------------------------
>   1 file changed, 50 insertions(+), 47 deletions(-

[...]

> -elif targetos == 'openbsd'
> -  if get_option('tcg').allowed() and target_dirs.length() > 0
> -    # Disable OpenBSD W^X if available
> -    emulator_link_args = cc.get_supported_link_arguments('-Wl,-z,wxneeded')
> -  endif
> -endif
> -
>   # Target-specific configuration of accelerators
>   accelerators = []
>   if get_option('kvm').allowed() and targetos == 'linux'
> @@ -716,6 +669,56 @@ if 'CONFIG_WHPX' not in accelerators and get_option('whpx').enabled()
>     error('WHPX not available on this platform')
>   endif

[*]

> +#####################################
> +# Host-specific libraries and flags #
> +#####################################
> +
> +libm = cc.find_library('m', required: false)
> +threads = dependency('threads')
> +util = cc.find_library('util', required: false)
> +winmm = []
> +socket = []
> +version_res = []
> +coref = []
> +iokit = []
> +emulator_link_args = []

This ...

> +nvmm =not_found
> +hvf = not_found

... could be moved at [*] with 'accelerators'.
(missing space around nvmm)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

> +midl = not_found
> +widl = not_found
> +pathcch = not_found
> +host_dsosuf = '.so'
> +if targetos == 'windows'
> +  midl = find_program('midl', required: false)
> +  widl = find_program('widl', required: false)
> +  pathcch = cc.find_library('pathcch')
> +  socket = cc.find_library('ws2_32')
> +  winmm = cc.find_library('winmm')

[...]


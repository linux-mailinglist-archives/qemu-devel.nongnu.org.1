Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id F2C0F70AD83
	for <lists+qemu-devel@lfdr.de>; Sun, 21 May 2023 12:48:23 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q0gbJ-0002V9-2a; Sun, 21 May 2023 06:47:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1q0gb5-0002Ui-No
 for qemu-devel@nongnu.org; Sun, 21 May 2023 06:47:32 -0400
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1q0gb4-0007fn-2c
 for qemu-devel@nongnu.org; Sun, 21 May 2023 06:47:31 -0400
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-3f6042d610fso498835e9.1
 for <qemu-devel@nongnu.org>; Sun, 21 May 2023 03:47:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1684666048; x=1687258048;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=6cYsSlpsUo2NEw0M7LWJm5pe6RfuXpa7vSt/MgnCt98=;
 b=YFCa90RWXZEDaRh95VEL91w8G9X8th3ucm/fh1edHuHJ8rVzeS39Bpgwi44v/mhlf4
 f+oVqX/P2K/W91U7q+4ZJf4s3XNeO0dx+KJIJ6eUh+Ws52W9VgExJRc+/6NAweurafDK
 Xod6iRS+iSDsrcQDHo5sqCa5J5x/EkphI72roQT56aX18ch5mhgWalJMoExGchTEj4mt
 3MkBomaPsKkgbGmObTW0bVism36rqB1ykcWitPHxl1EmXbvJHjksCLWDZTaLiXhwmADU
 zLEPsaAP3NMFH9xPgJ/4/ZAh/u3l9O63Ww/95iB+wKYbdsPAlz2+9EjMmGjmIj+eM0Fy
 oDgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684666048; x=1687258048;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=6cYsSlpsUo2NEw0M7LWJm5pe6RfuXpa7vSt/MgnCt98=;
 b=Ke1PNTwMcctjEjE09ASq63PJfxaJ/1R4Cl5LhpwWNyx0spurqM/CnMvb8BGAD7QMfN
 isSyFkYXv3VGiV2ClUegsjfQezATbv2bH5JCnh9tol1dCRmqS3Q8pD/hMxATIH0g66rt
 Z/C/VSMgoUZ/QkVf0tWo0O3FZCMIn26yh6JmYn12pswQjIgzXAALRtr6sGs3OorjOZLq
 AqB/VcjKULlXCtY0yxZ8veqtdC07/EqhIWqkJUs24X+QkxI8/xMQxvVToQZDNWUsuvwm
 vX4OXrDLErcYiDoKMBLlAXuXk0z6faTbnouBCxMhMI1hPAUmtWHFKg6zRrb/5LGujeDG
 0hLw==
X-Gm-Message-State: AC+VfDzh1AjHcMzHbP9tMtCNdlosrC/q30sojjWtm4XHMLlQYn1w7f+c
 IFTpDDtyvoz4MIcaTcpZBHXV9A==
X-Google-Smtp-Source: ACHHUZ4OSJWvOCMMbslWys7j98NEP6lxsSlI53rGnbgtixXTI4LPA9UKZAAr218OawMucDI31JwSQw==
X-Received: by 2002:a05:600c:245:b0:3f5:4e1:2a89 with SMTP id
 5-20020a05600c024500b003f504e12a89mr5163982wmj.34.1684666048393; 
 Sun, 21 May 2023 03:47:28 -0700 (PDT)
Received: from [192.168.69.115] ([176.176.152.177])
 by smtp.gmail.com with ESMTPSA id
 m9-20020a7bce09000000b003f4247fbb5fsm8028151wmc.10.2023.05.21.03.47.27
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 21 May 2023 03:47:27 -0700 (PDT)
Message-ID: <80ec6d3c-f4bb-2513-ab88-4179e3396c23@linaro.org>
Date: Sun, 21 May 2023 12:47:26 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.11.0
Subject: Re: [PATCH 01/27] util: Introduce host-specific cpuinfo.h
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, Juan Quintela <quintela@redhat.com>
References: <20230520162634.3991009-1-richard.henderson@linaro.org>
 <20230520162634.3991009-2-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230520162634.3991009-2-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32f.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.098,
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

On 20/5/23 18:26, Richard Henderson wrote:
> The entire contents of the header is host-specific, but the
> existence of such a header is not, which could prevent some
> host specific ifdefs at the top of the file for the include.
> 
> Add host/include/{arch,generic} to the project arguments.
> 
> Reviewed-by: Juan Quintela <quintela@redhat.com>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   host/include/generic/host/cpuinfo.h | 4 ++++
>   meson.build                         | 8 ++++++++
>   2 files changed, 12 insertions(+)
>   create mode 100644 host/include/generic/host/cpuinfo.h
> 
> diff --git a/host/include/generic/host/cpuinfo.h b/host/include/generic/host/cpuinfo.h
> new file mode 100644
> index 0000000000..eca672064a
> --- /dev/null
> +++ b/host/include/generic/host/cpuinfo.h
> @@ -0,0 +1,4 @@
> +/*
> + * No host specific cpu indentification.
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + */
> diff --git a/meson.build b/meson.build
> index 0a5cdefd4d..4ffc0d3e59 100644
> --- a/meson.build
> +++ b/meson.build
> @@ -512,6 +512,14 @@ add_project_arguments('-iquote', '.',
>                         '-iquote', meson.current_source_dir() / 'include',
>                         language: all_languages)
>   
> +host_include = meson.current_source_dir() / 'host/include/'
> +if fs.is_dir(host_include / host_arch)
> +  add_project_arguments('-iquote', host_include / host_arch,
> +                        language: all_languages)
> +endif

Maybe add a comment "generic include path must come last, after
host specific include path".

> +add_project_arguments('-iquote', host_include / 'generic',
> +                      language: all_languages)
> +
>   sparse = find_program('cgcc', required: get_option('sparse'))
>   if sparse.found()
>     run_target('sparse',

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>



Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A8077F26BE
	for <lists+qemu-devel@lfdr.de>; Tue, 21 Nov 2023 08:56:03 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r5LaR-0004Wu-RG; Tue, 21 Nov 2023 02:54:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1r5LaP-0004Wg-Tp
 for qemu-devel@nongnu.org; Tue, 21 Nov 2023 02:54:21 -0500
Received: from mail-ej1-x633.google.com ([2a00:1450:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1r5LaO-00059e-AZ
 for qemu-devel@nongnu.org; Tue, 21 Nov 2023 02:54:21 -0500
Received: by mail-ej1-x633.google.com with SMTP id
 a640c23a62f3a-9c41e95efcbso711036766b.3
 for <qemu-devel@nongnu.org>; Mon, 20 Nov 2023 23:54:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1700553258; x=1701158058; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=ZX9lkn0n3fOMqDe7YvZf7g7MLGIFe6LfSL7HbLbLjz0=;
 b=TYhpigXU/BPp/C3Ze18qlcZy/MPrMwKS+UXiD5sSigUP5wh77v80zVYOPlgq1nbHCK
 Unirld8sQT35yXKYonnxxIqs5e4SK+Mlre0rf3C7IQEQ0GjtLDwbS8pPDXadx8jlv0wc
 19IIx2I+oLxRdqDirD8bktFQ2ls1r23QUzGr2IjaJcLGEGsMJQTVSHKKushpZPkOcqKn
 kEus/rBviW00z+oFPeiqNpjy8p1m+UTIHjSCPa6gGAnBw2bbnXtdjxi7GjMS3WdfX2nB
 PtWFyTTwED4SZ6qEfF1vGnpKz16cGpLUYqeNZ+GKfchN5t6iCc8zqGNWbYw5ce5z8Zmf
 dSmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700553258; x=1701158058;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ZX9lkn0n3fOMqDe7YvZf7g7MLGIFe6LfSL7HbLbLjz0=;
 b=FMVmgXxLfikRDuarojZKpG3V/OvFLOOdiIGAILAt5AgR2vjxBKjVPc6DIJG5T8yhbV
 5TqLbyyOB8mcC5JAC1QXutdBUTsfSMZxS8EWYgvOepAuz6d1FM6L/SFJHdj1IHN1k1Vs
 n0MXihJWRfiCZ40BaXab+DH08P5uydc/zknc7oV6QcsJmFwC+k7v7c8MxWgHKWZBdHp3
 1WwafXtZ9O4RgbYMFR1kR6+9ST2WstAqVgJeNxXYQ7Ex4U+ngkurKPNd9T/dSF5L9g9J
 FTlEpeFktLmgRokEVT0jjo/ZnHBH/iirybqO+SHtCcRdQ9Vaj1EUSFAkCodyFYKHJM02
 NLiA==
X-Gm-Message-State: AOJu0Yxk2wpJEAY7JbU9oFyjdJqz6faXsAisYHpGUUyiSJVTlZ838MDW
 J5GweIJF9Hy643dyYwOeXVhPgQ==
X-Google-Smtp-Source: AGHT+IG9mN1JIdXBtnZlLvyvwjzLc/TdIlk/Nxe4wJ0BPY2M5frZoW/UDoi/2ZGAWwO1+/v6oEyMYA==
X-Received: by 2002:a17:907:720a:b0:a00:afeb:5d15 with SMTP id
 dr10-20020a170907720a00b00a00afeb5d15mr2344904ejc.33.1700553258083; 
 Mon, 20 Nov 2023 23:54:18 -0800 (PST)
Received: from [192.168.69.100] (lgp44-h02-176-184-8-219.dsl.sta.abo.bbox.fr.
 [176.184.8.219]) by smtp.gmail.com with ESMTPSA id
 ov13-20020a170906fc0d00b009ff1997ce86sm1819903ejb.149.2023.11.20.23.54.12
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 20 Nov 2023 23:54:17 -0800 (PST)
Message-ID: <5c82ad73-aeee-4f46-9559-3b6ea12aadab@linaro.org>
Date: Tue, 21 Nov 2023 08:54:03 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] disas/cris: Pass buffer size to format_dec() to avoid
 overflow warning
Content-Language: en-US
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: Akihiko Odaki <akihiko.odaki@daynix.com>
References: <20231120214520.59431-1-pbonzini@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20231120214520.59431-1-pbonzini@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::633;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x633.google.com
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

On 20/11/23 22:45, Paolo Bonzini wrote:
> From: Philippe Mathieu-Daudé <philmd@linaro.org>
> 
> Propagate the buffer size to format_dec() and use snprintf().
> 
> This should silence this UBSan -Wformat-overflow warning:

"produced when using GCC 12.1.0:"

> 
>    In file included from /usr/include/stdio.h:906,
>                     from include/qemu/osdep.h:114,
>                     from ../disas/cris.c:21:
>    In function 'sprintf',
>        inlined from 'format_dec' at ../disas/cris.c:1737:3,
>        inlined from 'print_with_operands' at ../disas/cris.c:2477:12,
>        inlined from 'print_insn_cris_generic.constprop' at ../disas/cris.c:2690:8:
>    /usr/include/bits/stdio2.h:30:10: warning: null destination pointer [-Wformat-overflow=]
>     30 |   return __builtin___sprintf_chk (__s, __USE_FORTIFY_LEVEL - 1,
>        |          ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>     31 |                                   __glibc_objsize (__s), __fmt,
>        |                                   ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>     32 |                                   __va_arg_pack ());
>        |                                   ~~~~~~~~~~~~~~~~~
> 
> Reported-by: Akihiko Odaki <akihiko.odaki@daynix.com>
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> Message-ID: <20231120132222.82138-1-philmd@linaro.org>
> [Rewritten to fix logic and avoid repeated expression. - Paolo]
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>   disas/cris.c | 26 ++++++++++++++++----------
>   1 file changed, 16 insertions(+), 10 deletions(-)
> 
> diff --git a/disas/cris.c b/disas/cris.c
> index 0b0a3fb9165..409a224c5d1 100644
> --- a/disas/cris.c
> +++ b/disas/cris.c
> @@ -1731,10 +1731,10 @@ format_hex (unsigned long number,
>      unsigned (== 0).  */
>   
>   static char *
> -format_dec (long number, char *outbuffer, int signedp)
> +format_dec (long number, char *outbuffer, size_t outsize, int signedp)
>   {
>     last_immediate = number;
> -  sprintf (outbuffer, signedp ? "%ld" : "%lu", number);
> +  snprintf (outbuffer, outsize, signedp ? "%ld" : "%lu", number);
>   
>     return outbuffer + strlen (outbuffer);
>   }
> @@ -1876,6 +1876,12 @@ print_flags (struct cris_disasm_data *disdata, unsigned int insn, char *cp)
>     return cp;
>   }
>   
> +#define FORMAT_DEC(number, tp, signedp)                      \
> +    format_dec (number, tp, ({                                \
> +            assert(tp >= temp && tp <= temp + sizeof(temp)); \
> +            temp + sizeof(temp) - tp;                        \
> +        }), signedp)

Thank you Paolo for this respin!

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>



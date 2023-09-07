Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A967779718E
	for <lists+qemu-devel@lfdr.de>; Thu,  7 Sep 2023 12:49:53 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qeCYQ-00078m-UN; Thu, 07 Sep 2023 06:48:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qeCYP-00078e-H2
 for qemu-devel@nongnu.org; Thu, 07 Sep 2023 06:48:05 -0400
Received: from mail-ej1-x636.google.com ([2a00:1450:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qeCYN-0004Mx-9K
 for qemu-devel@nongnu.org; Thu, 07 Sep 2023 06:48:05 -0400
Received: by mail-ej1-x636.google.com with SMTP id
 a640c23a62f3a-99de884ad25so98687466b.3
 for <qemu-devel@nongnu.org>; Thu, 07 Sep 2023 03:48:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1694083680; x=1694688480; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=fTylc0K7/+vt52knuYypbLAgZsxAiqt3kM0KK8AbNGE=;
 b=JkcPxSHqfefKP0+cfPJK2u9Kx30u3eeYuVW8xKkEOzxNJh69Chaf8mwhrNk9SpsR0H
 2xVaQmfeiXtRpdq+JASeek0EOtxxhQ5irtbaL6K/2oja78Xj0DHxjZ2mkz507n5DteGW
 7qKwajJmquCRvbqV34T6cnHE5mwE7l3YuIx/kZQJQGZoj7mAmjYV8ZtvXpZzGiAn+xx7
 6HfOFDQOfrkEERRAAMcVf8+nAnpzElBEPoawfuXEKvnKVLcjGr5ihCtTtv8zbXYhWyu4
 yh/uzdjV/Q/qOTH7G09AjS/dRsbCdX2p7ql/fchnhZta3pH+pFWtN14FVxxjs6ssmjxD
 HIHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1694083680; x=1694688480;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=fTylc0K7/+vt52knuYypbLAgZsxAiqt3kM0KK8AbNGE=;
 b=TRx5PAzymzZrtLxZIRY7lsHDSmEHFi3yIaz0lPynnW3iMdzxrSQArvr37Uk5fV5TzL
 +wn/mcuoy77hZfW6kKNbfbDWgvSnAPamZw/q6X1AI3pNcnBy2y3/6c0R1+qrMIXKCmJA
 RTC00TityMvzXW3cl9hc1/NBP65UQXBXSBb1e90bSjgy+MIOUAyLRTWP+wLoqSu9dPQv
 liT137rfl8Ewq5rkNzp1eQ4dbJetflT5wEDgyz4snu5ytLxsjAyCU5dfRH59ZmkMjF32
 /wA+iiOEnrukSSST+2XfzYrjHEjcdjb8d4z+sE/1WNZGMCeTVtYeRS6uRdjWlwZ4oTAB
 unww==
X-Gm-Message-State: AOJu0YyZmc8ixiYYrDtpIbUq/A2AOONim4yWqPgafJyWjil1vJo11wII
 Gr+rxA2n/34hWKZCe6Lmq1eU7w==
X-Google-Smtp-Source: AGHT+IFVZqf1vaPzh06M1B1nEiWv+ghKpia8cj1TkPIx6CJFigHW9ybZgBSq/mNK8EhCFTgGp/pnpA==
X-Received: by 2002:a17:907:a061:b0:9a5:846d:d829 with SMTP id
 ia1-20020a170907a06100b009a5846dd829mr4221583ejc.18.1694083680147; 
 Thu, 07 Sep 2023 03:48:00 -0700 (PDT)
Received: from [192.168.69.115] (176-131-222-226.abo.bbox.fr.
 [176.131.222.226]) by smtp.gmail.com with ESMTPSA id
 rs10-20020a170907036a00b00992b510089asm10306708ejb.84.2023.09.07.03.47.59
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 07 Sep 2023 03:47:59 -0700 (PDT)
Message-ID: <7459b394-b136-e892-a19a-38b08dc1a3a0@linaro.org>
Date: Thu, 7 Sep 2023 12:47:58 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.0
Subject: Re: [PATCH] contrib/plugins: remove -soname argument
Content-Language: en-US
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: alex.bennee@linaro.org
References: <20230907101811.469236-1-pbonzini@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230907101811.469236-1-pbonzini@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::636;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x636.google.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-1.473,
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

On 7/9/23 12:18, Paolo Bonzini wrote:
> -soname is not needed for runtime-loaded modules.  For example, Meson says:
> 
>              if not isinstance(target, build.SharedModule) or target.force_soname:
>                  # Add -Wl,-soname arguments on Linux, -install_name on OS X
>                  commands += linker.get_soname_args(
>                      self.environment, target.prefix, target.name, target.suffix,
>                      target.soversion, target.darwin_versions)
> 
> (force_soname is set is shared modules are linked into a build target, which is not
> the case here.
> 
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>   contrib/plugins/Makefile | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/contrib/plugins/Makefile b/contrib/plugins/Makefile
> index b2b9db9f51a..db1bd04dfa6 100644
> --- a/contrib/plugins/Makefile
> +++ b/contrib/plugins/Makefile
> @@ -37,7 +37,7 @@ all: $(SONAMES)
>   	$(CC) $(CFLAGS) -c -o $@ $<
>   
>   lib%.so: %.o
> -	$(CC) -shared -Wl,-soname,$@ -o $@ $^ $(LDLIBS)
> +	$(CC) -shared -o $@ $^ $(LDLIBS)

This fixes on Darwin:

ld: unknown option: -soname
clang: error: linker command failed with exit code 1 (use -v to see 
invocation)
make: *** [plugins] Error 2

Tested-by: Philippe Mathieu-Daudé <philmd@linaro.org>



Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F1FD72816C
	for <lists+qemu-devel@lfdr.de>; Thu,  8 Jun 2023 15:33:25 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q7Fl4-0003yL-4F; Thu, 08 Jun 2023 09:32:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1q7Fl1-0003wV-G7
 for qemu-devel@nongnu.org; Thu, 08 Jun 2023 09:32:55 -0400
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1q7Fkv-00068P-97
 for qemu-devel@nongnu.org; Thu, 08 Jun 2023 09:32:55 -0400
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-3f6e1393f13so4109895e9.0
 for <qemu-devel@nongnu.org>; Thu, 08 Jun 2023 06:32:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1686231167; x=1688823167;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=ng8czX/rPWnhz7zc/NWQ/lu09zS0NPFurTxHK6zk5Dg=;
 b=MdmYJutTLKX7pmwg34JehTXAaBuSm9j+gOzCmmCZL+3zSfvibE6ZzESg/spuiUq6AM
 DjiOUo0btHa7hHYu+MoR/QTBNQirC6MA4THicyCIdnZ8mf8/sT73bLLqXtdiBeuo9vP/
 0z6hgBIaVLIrTgn0mfE2YZ9MuED+hVIYdPi1/FvTVTZqOVQRc6UidQu3cylgIVyjHCuo
 ULhwCFRTERY/W7nMmCwDBq368WP45cjAaD0uWf+mKm0HuFWj0aDLQXOWcZTQIxNbvVI1
 r+C3zjCWWjIuEXBLL8jvcG5Cpb4roqxS9FcFpJmMF462pEa/TC/sMq3tGDZOVziNOFZW
 fQ0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686231167; x=1688823167;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ng8czX/rPWnhz7zc/NWQ/lu09zS0NPFurTxHK6zk5Dg=;
 b=B1TelIDEdY58Rsg7yFUFzHpQqAtYhqG/zFH61AL0KJNIG/uQRZYQpOEO94yw1YRiAj
 TjfMHMVvNZZK1qserD1zKjRj73SByq2tj3VXNkQ22Htb3p+096PkFKvshJNJe6S9RYoO
 tAxjI7g+bVBukVj2oI+lrTzXnmmH75r2MC/U5XC9HDpTJsFsIAchOSjON0yI2mnqfeiq
 Hzn+1iWKPGJ5aLx5WearkIk4FNkoJHYRAo5xJXQCT1kxhU8mD+zelXxAllCF1+OgElHg
 gsGRZtLcfVQRQfdOfnRaO2xhk/uy8S3ri6Jlm+OQ4lkdLR/n9yN8l9pYtwsHmVpWCyKD
 TAVg==
X-Gm-Message-State: AC+VfDyFo4+Fnv4bkGMANfABvr2dYeVlCnVULVxABI3UCYdxhcbkz2DY
 ldXvlWLFStojkqP/q8PzkzdlREL+az5vI/wX1FI=
X-Google-Smtp-Source: ACHHUZ4Bc9yWi+ZscP+LOcDpEsjGX2o90Kw18zFXDbUVvTkFaczlrPI8ZhL4OrU6CNv9L99mVLyPag==
X-Received: by 2002:a1c:7717:0:b0:3f7:34dc:ed0d with SMTP id
 t23-20020a1c7717000000b003f734dced0dmr1404330wmi.25.1686231167296; 
 Thu, 08 Jun 2023 06:32:47 -0700 (PDT)
Received: from [192.168.69.115] ([176.176.169.168])
 by smtp.gmail.com with ESMTPSA id
 c3-20020a7bc843000000b003f7f4b7f286sm3595167wml.12.2023.06.08.06.32.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 08 Jun 2023 06:32:46 -0700 (PDT)
Message-ID: <22f84ca4-cd6e-88c5-ff0e-02632c416677@linaro.org>
Date: Thu, 8 Jun 2023 15:32:44 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.11.2
Subject: Re: [PATCH v2 1/5] hw/remote/proxy: Remove dubious
 'event_notifier-posix.c' include
Content-Language: en-US
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>, qemu-arm@nongnu.org,
 qemu-ppc@nongnu.org, qemu-s390x@nongnu.org, qemu-riscv@nongnu.org
References: <20230608133108.72655-1-philmd@linaro.org>
 <20230608133108.72655-2-philmd@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230608133108.72655-2-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x329.google.com
X-Spam_score_int: 3
X-Spam_score: 0.3
X-Spam_bar: /
X-Spam_report: (0.3 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.091,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001, SUSPICIOUS_RECIPS=2.51,
 T_SCC_BODY_TEXT_LINE=-0.01,
 T_SPF_HELO_TEMPERROR=0.01 autolearn=no autolearn_force=no
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

On 8/6/23 15:31, Philippe Mathieu-Daudé wrote:
> event_notifier-posix.c is registered in meson's util_ss[] source
> set, which is built as libqemuutil.a.p library. Both tools and
> system emulation binaries are linked with qemuutil, so there is
> no point in including this source file.
> 
> Introduced in commit bd36adb8df ("multi-process: create IOHUB
> object to handle irq").
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
> Note, --enable-multiprocess doesn't seem to be covered in CI.
> ---
>   hw/remote/proxy.c | 1 -
>   1 file changed, 1 deletion(-)
> 
> diff --git a/hw/remote/proxy.c b/hw/remote/proxy.c
> index 1c7786b52c..2052d721e5 100644
> --- a/hw/remote/proxy.c
> +++ b/hw/remote/proxy.c
> @@ -22,7 +22,6 @@
>   #include "qom/object.h"
>   #include "qemu/event_notifier.h"
>   #include "sysemu/kvm.h"
> -#include "util/event_notifier-posix.c"

Err wrong branch base, please discard this patch which is already
in Paolo's queue.



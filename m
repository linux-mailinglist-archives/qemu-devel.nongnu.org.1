Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F13E7ED5C9
	for <lists+qemu-devel@lfdr.de>; Wed, 15 Nov 2023 22:12:55 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r3NAU-0001S6-Vx; Wed, 15 Nov 2023 16:11:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1r3NAR-0001P5-Di
 for qemu-devel@nongnu.org; Wed, 15 Nov 2023 16:11:23 -0500
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1r3NAO-00086f-Bv
 for qemu-devel@nongnu.org; Wed, 15 Nov 2023 16:11:23 -0500
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-1cc938f9612so1128555ad.1
 for <qemu-devel@nongnu.org>; Wed, 15 Nov 2023 13:11:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1700082678; x=1700687478; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=SJFan03wMlzbUu0MfOpcJ7FeGLQONjoLlqrUnGtafbI=;
 b=BCKhTTYEwOfUOhiHh37TDuXzZtZ7odGAHuzYuAUZL0/NlTWutzh2OZ371HGQYHpiER
 I+bep45P19XGjEINyACrmQaTZEPMoxvIuQLYXjhYwpUAxbHKaplDRPLhP2TmAqvDaMjV
 n4wFPEt8fthfcKNdXzJq1ZKxBLBTVh9ZNlDR0yVYs0SSZB4xBK5rXLDvXoERNqo7aVYn
 woXrRTdMHJAqYhVMRamhP86f6FQ+wZlLHeYyLPn4Sm1SgQbIQz+JIHiqhzZn8bXpNKh0
 beeD6PXUHgumf58BVQQG/Q3h69KwpH2u6X6y79DcXk+/uSkXXAYz2YQzwSdJ/hvvBK1e
 bD9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700082678; x=1700687478;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=SJFan03wMlzbUu0MfOpcJ7FeGLQONjoLlqrUnGtafbI=;
 b=BDyIRPyOYsY6b+ZJ623/0NbIE5NcHL5dX+t2vsfDRfd6hkp3Ff6+nzPvyMtZ4dabfn
 ZTEyljkyCHJWHG92ZJM6uH6CkHdG9jsAILarOM3N+k1Q1MRjz63X0rYmZyGwLBgsnykW
 NtMf6FDRQWmPDPfXxc9TNkBD3JoSGS575dKclrFBKz2tgSfC+3qSDHVEqzHdZJzuSuCx
 s0hflUKr5CVCbdEiOZDpUhImCQ67zL8Y6sRrWKGV0h7O49krWYDeyGE/VFFW1AASBuWh
 8JPOU7ukhacBOKgLI6zAZJv9q2tz6BXpHgtjOA63OyaOrhUBGsXP0nKNdmSSpcEZ+e6z
 9D/A==
X-Gm-Message-State: AOJu0YxKqFe+DyBH/O/bD9u4Y+nLV5h+wb5DZYu8gBqMrWiOCUEf0lIn
 a+GTehqGuD6iqEFKNOzIVasHow==
X-Google-Smtp-Source: AGHT+IFNamy9O4wH58Oel9w99an/ZGXoVdJNWR+DuDoK+2c9PZtbyoOSU8XVAFcw1IklpAf0STkgOw==
X-Received: by 2002:a17:902:ce8f:b0:1cc:5392:3ef4 with SMTP id
 f15-20020a170902ce8f00b001cc53923ef4mr6856433plg.21.1700082678420; 
 Wed, 15 Nov 2023 13:11:18 -0800 (PST)
Received: from [192.168.0.4] ([71.212.149.95])
 by smtp.gmail.com with ESMTPSA id
 w6-20020a170902e88600b001cc3fae06a6sm7805990plg.159.2023.11.15.13.11.17
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 15 Nov 2023 13:11:18 -0800 (PST)
Message-ID: <e35e82c3-97d7-4428-b660-c0d6e43a96c7@linaro.org>
Date: Wed, 15 Nov 2023 13:11:16 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 07/10] hw/core: skip loading debug on all failures
Content-Language: en-US
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, Beraldo Leal <bleal@redhat.com>,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>, qemu-arm@nongnu.org,
 Alexandre Iooss <erdnaxe@crans.org>
References: <20231115205542.3092038-1-alex.bennee@linaro.org>
 <20231115205542.3092038-8-alex.bennee@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20231115205542.3092038-8-alex.bennee@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::631;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x631.google.com
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

On 11/15/23 12:55, Alex Bennée wrote:
> ELF_LOAD_FAILED is one of many negative return codes we can have. Lets
> treat any positive size_t as a success for loading.
> 
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> ---
>   hw/core/loader.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

> 
> diff --git a/hw/core/loader.c b/hw/core/loader.c
> index 3c79283777..e7a9b3775b 100644
> --- a/hw/core/loader.c
> +++ b/hw/core/loader.c
> @@ -505,7 +505,7 @@ ssize_t load_elf_ram_sym(const char *filename,
>                            clear_lsb, data_swab, as, load_rom, sym_cb);
>       }
>   
> -    if (ret != ELF_LOAD_FAILED) {
> +    if (ret > 0) {
>           debuginfo_report_elf(filename, fd, 0);
>       }
>   



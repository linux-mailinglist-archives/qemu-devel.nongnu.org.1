Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6728173649B
	for <lists+qemu-devel@lfdr.de>; Tue, 20 Jun 2023 09:32:52 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qBVqk-0007oM-Qo; Tue, 20 Jun 2023 03:32:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qBVqa-0007iC-Rw
 for qemu-devel@nongnu.org; Tue, 20 Jun 2023 03:32:16 -0400
Received: from mail-ej1-x632.google.com ([2a00:1450:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qBVqY-0000ig-Tm
 for qemu-devel@nongnu.org; Tue, 20 Jun 2023 03:32:16 -0400
Received: by mail-ej1-x632.google.com with SMTP id
 a640c23a62f3a-982a88ca610so519586466b.2
 for <qemu-devel@nongnu.org>; Tue, 20 Jun 2023 00:32:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1687246333; x=1689838333;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=OXoncybMt8iiMhAE7YB+rTdIxHNRU8KW6uRKJncDUfA=;
 b=MKf1MBjTN7if5FMC344TLhZwehHtyGjWjxqINpXB9Aeqke2oLOCQjoB0RaHdJ4E5NV
 SQVarXFVQbtdbIhDW1YQJ+tl1sxIMDQcg/ZrRLxQfCwwWxQC2d1IqW8mvud8a2pgfZgG
 Zx6egfo9jOQKlQNvJgn9Q02dvQMdh0memxTiLmkeES7XOGnbZpP+rQBf3NdbWRgP9PbW
 NGf7PTRUXwD+ilpqfg2uM7h2aGV+P69iA+6l4GWUqtYVyXflQjDG059ozi2eDz6IMSoT
 SXXTiaw3dZ1ZS1xtBMKhQ0ctg7j6iixrnz7lnnQRATuxPRMOKCH9xBI1cQGfoYyKZQaO
 9p3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687246333; x=1689838333;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=OXoncybMt8iiMhAE7YB+rTdIxHNRU8KW6uRKJncDUfA=;
 b=R2hcd3FP03qEVg9sAfZ1wbWtFW2+BxfmyysL7Li4kIqfitdTdqIyp3gBpGtEX8jfF0
 HYjCWrB+AbSoaXh9xIW9VHaVIPYswEqlvot3UBcU/f4t8F1KNQ9fUty9bU4ma2ACnAv8
 mISw25gfbuujFApx72qOCZMSD1TUUjc6OBAT6z6+ykrKB6v1iMkGvhii0fJnmvDtmMTl
 SjCWA+vUQPTzg9rdnBVHigo8JTGQqpRS3SJoEc6y4KcLVOypA9IuWFvOyxDSgaYDJZ5X
 8wT2CNR6R8GTGvXg6ynZShTBNZO/epRSDHAoXkTla50uxHGo+eW+BNklAzW927B9bHzu
 8Nvw==
X-Gm-Message-State: AC+VfDwC/Cwh/k+iYg7QRXMXbIcFuKQUa7eNxkyFuhx9tDMr4Dy7C6XU
 0/Qoe7Vl8i+aMB53xe1geuTCcA==
X-Google-Smtp-Source: ACHHUZ788olubTiwP7HbBqTa2tiT1ITZ8uAHBoZ3UAHfUrhsNOU1GPlDi3ezqxkZxQonrAqmEd1ZXA==
X-Received: by 2002:a17:907:6ea8:b0:974:1f03:fcd1 with SMTP id
 sh40-20020a1709076ea800b009741f03fcd1mr11146654ejc.3.1687246333264; 
 Tue, 20 Jun 2023 00:32:13 -0700 (PDT)
Received: from [192.168.69.129] ([176.176.183.29])
 by smtp.gmail.com with ESMTPSA id
 x17-20020a170906711100b009884f015a44sm840311ejj.49.2023.06.20.00.32.12
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 20 Jun 2023 00:32:13 -0700 (PDT)
Message-ID: <910efeb9-78c2-659c-3101-0e7dc3770ef5@linaro.org>
Date: Tue, 20 Jun 2023 09:32:10 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH qemu 2/2] gdbstub: Fixed gdb_open() does not work issue
 while an extra 'x' is being added when converting '%s' to a pointer
Content-Language: en-US
To: ~foxes <foxes687@andestech.com>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
References: <168723238949.9156.9853906656288727865-1@git.sr.ht>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <168723238949.9156.9853906656288727865-1@git.sr.ht>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::632;
 envelope-from=richard.henderson@linaro.org; helo=mail-ej1-x632.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.09,
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

On 6/8/23 11:06, ~foxes wrote:
> From: Foxes Hung <foxes687@andestech.com>
> 
> Signed-off-by: Foxes Hung <foxes687@andestech.com>
> ---
>   gdbstub/syscalls.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/gdbstub/syscalls.c b/gdbstub/syscalls.c
> index 02e3a8f74c..4c6b5f728b 100644
> --- a/gdbstub/syscalls.c
> +++ b/gdbstub/syscalls.c
> @@ -126,7 +126,7 @@ void gdb_do_syscall(gdb_syscall_complete_cb cb, const char *fmt, ...)
>               case 's':
>                   i64 = va_arg(va, uint64_t);
>                   i32 = va_arg(va, uint32_t);
> -                p += snprintf(p, p_end - p, "%" PRIx64 "/%x" PRIx32, i64, i32);
> +                p += snprintf(p, p_end - p, "%" PRIx64 "/%" PRIx32, i64, i32);
>                   break;
>               default:
>               bad_format:

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~


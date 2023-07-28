Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C5757670F0
	for <lists+qemu-devel@lfdr.de>; Fri, 28 Jul 2023 17:48:45 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qPPVT-0007KL-Qf; Fri, 28 Jul 2023 11:35:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qPPVR-0007Jz-E1
 for qemu-devel@nongnu.org; Fri, 28 Jul 2023 11:35:54 -0400
Received: from mail-pf1-x42c.google.com ([2607:f8b0:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qPPVP-0007BQ-VP
 for qemu-devel@nongnu.org; Fri, 28 Jul 2023 11:35:53 -0400
Received: by mail-pf1-x42c.google.com with SMTP id
 d2e1a72fcca58-686fa3fc860so1314119b3a.1
 for <qemu-devel@nongnu.org>; Fri, 28 Jul 2023 08:35:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1690558550; x=1691163350;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=bebwn8IMMltcLNdqkMVjsGyWiYDtC7aRLw2duVAySZ8=;
 b=B78B4DOJrDn+DnDxLmgCp6/c6OQ6gS2xcCIPPrx+ZCvgFpZ8ZBEf3cuAJFPXrR0O/C
 JYMjzTLisc9NW4au9ALrjkqaNR5pUllFnHOhN487YsoLla96PIY5lBFZv1lzGzFA0XcI
 /frGexnV8ypNEmOLWtmJhAh3wbSvnRZFjpHQp4mzDZrnMeNBUSucmrNcFupt9YanK4P0
 gIfCgqZmPzt2fUeSNUXQR64viB7CwWPq4309bkSrvI1X8wMbBYBeLHRlTV50W5wqmWQn
 2bDVke9jc6IcJMjVFVNYH4rfXq3TdGQkWpJZFq/o6YIq/XByTqo26d1jx3GI0UNumJlo
 CVlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1690558550; x=1691163350;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=bebwn8IMMltcLNdqkMVjsGyWiYDtC7aRLw2duVAySZ8=;
 b=dEzs0nf8yIMc52eBAB11Ni4A7IO9TXXeMX/nwOhbWlWnzduHNWwJe+o3REbYLq/A8H
 SXk06A3ZEutqe4c4nuoMfkB1V4+uDVQBKAYsxCN8WHMNxyZWQ5wsabeBVWVwZVBW1r5M
 CUsMrHxRy4m9fWK3Qew+6/JiROjldzarT2KlISKj0x+eV1m37BJhFDyF2wNuOn7N1h7E
 S0bjpEnUvN4QCXxdqtf4z+sLg3S2/6rqienOokvzHIXhaydAro5UZT1LYQhS7ePnBC76
 vhQfI19KqChjZgOwY3hpL+6ZwN5ic37cyUi9XKqq3oJGNyEACmCBPPKgGCOeuVtBYYkv
 upIw==
X-Gm-Message-State: ABy/qLbHdy6wUUHB+ab7FjXWtqB8EgHugb8nfHAR17bQ5AWNx43yB6PV
 17WSaQ8iCRf6g/hSP2OtAMQltw==
X-Google-Smtp-Source: APBJJlF99qntw1mXt/irwLMX7I6RvNMOXLOMqbKcq9A3MO/EwdKKZqJH8zm16JchHDYdRi3HDk46/A==
X-Received: by 2002:a05:6a00:ac4:b0:679:bc89:e5b with SMTP id
 c4-20020a056a000ac400b00679bc890e5bmr2249038pfl.19.1690558549955; 
 Fri, 28 Jul 2023 08:35:49 -0700 (PDT)
Received: from ?IPV6:2602:ae:154e:c001:cfba:2f6a:7070:67a9?
 ([2602:ae:154e:c001:cfba:2f6a:7070:67a9])
 by smtp.gmail.com with ESMTPSA id
 w12-20020a63b74c000000b0051b36aee4f6sm3385470pgt.83.2023.07.28.08.35.49
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 28 Jul 2023 08:35:49 -0700 (PDT)
Message-ID: <f6129139-54f6-1d96-1edc-cb1bdf7dac89@linaro.org>
Date: Fri, 28 Jul 2023 08:35:47 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v2] linux-user/armeb: Fix __kernel_cmpxchg() for armeb
Content-Language: en-US
To: Helge Deller <deller@gmx.de>, Laurent Vivier <laurent@vivier.eu>,
 qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 John Reiser <jreiser@bitwagon.com>,
 "Markus F.X.J. Oberhumer" <markus@oberhumer.com>
References: <ZMNJ+Ga7A4zDXjAg@p100>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <ZMNJ+Ga7A4zDXjAg@p100>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42c;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42c.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.094,
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

On 7/27/23 21:54, Helge Deller wrote:
> @@ -174,6 +175,10 @@ static void arm_kernel_cmpxchg64_helper(CPUARMState *env)
>           return;
>       }
> 
> +    /* endianess-swap if emulating armeb */
> +    oldval = tswap32(oldval);
> +    newval = tswap32(newval);

Must be tswap64.


r~


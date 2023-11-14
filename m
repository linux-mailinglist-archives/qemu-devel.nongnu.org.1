Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AF6E7EB87F
	for <lists+qemu-devel@lfdr.de>; Tue, 14 Nov 2023 22:20:00 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r30nz-000305-3F; Tue, 14 Nov 2023 16:18:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1r30nw-0002zh-V4
 for qemu-devel@nongnu.org; Tue, 14 Nov 2023 16:18:41 -0500
Received: from mail-pf1-x436.google.com ([2607:f8b0:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1r30nv-00024g-Gi
 for qemu-devel@nongnu.org; Tue, 14 Nov 2023 16:18:40 -0500
Received: by mail-pf1-x436.google.com with SMTP id
 d2e1a72fcca58-6c4884521f6so5236540b3a.0
 for <qemu-devel@nongnu.org>; Tue, 14 Nov 2023 13:18:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1699996718; x=1700601518; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=ERh2XMKqEuEHX9IliOfW1NwKWXcFOlQle3Hozf77hcg=;
 b=ZzhyDxhRiAjtgqpzHSiEjd6PHeTjsJoz8n5VMbBF1J1H5tHqNRrL/62ghrGqkXR6NY
 OqWMid/aI4hRdD0UH8k/9mBEHak/9er8wGgEO1KOUslNswEHwG1whia1MYkKSk+ifebB
 woFih6RbAQ9Z7ydCY2s+EkSd5/u82MOvQ1sMV/UvE1sXyStQAN+ko2Cgjfw3WS+wylfa
 lKpmA6t2pEFcCAqjvQsCjnsgNN6mqJF59b92jcGRk+oj6DmtJIFOM08KFMp03MQcSPNA
 dPofVNAJ72f+oAvsQ1TMApjeR9t47fKJh1ZJd1+Ej7SdtLPZkXljkvgjWn9soR40QXbV
 wspg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699996718; x=1700601518;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ERh2XMKqEuEHX9IliOfW1NwKWXcFOlQle3Hozf77hcg=;
 b=pfaLQdJRN8tp2KTULLVLt58+m4gsnYJlumDVKmMSZEiV/2VnqSZ1/mWrkvJMUi/YP1
 wN079fe7lX5KPGNG7fGENvUUgkrax7pOc2zxwg51+Nf7jLAENM/8+/UaXvtv9iTi6xsH
 FGC8p0UP3xFZT9ytNNc9okSYWz3kVNUcjB+92Gn9q4dcsdGs436oLmN5LGCIfAxxIzdz
 dXI8SE+94OrmyNyIU8gMIf4m55eX1Y5F55/JClSkwHFnBG14oj7FPA9aCzzwUGhi2auU
 8mzTZF3/Pz1mBkgqebCTcawJsIJUsC2r4gATX1ZDHjW3kRfbgM46hI70cte6nh0CK+d7
 b7og==
X-Gm-Message-State: AOJu0YzoiV4tAtjqvHQ6LNgCLmkWX0oi3qtHngppYsAsk2NPi4aXmsVd
 qm2nHcPJLtpDG7X6FzsTj6wlUQ==
X-Google-Smtp-Source: AGHT+IEKl64FIeUazp9+2qDWFQhxwBbKHl+ZLb0BfGlf2aBbMsUe6ceMw735dpQKxtTDKIl/Su+sBw==
X-Received: by 2002:a62:f251:0:b0:6be:bf7:fda5 with SMTP id
 y17-20020a62f251000000b006be0bf7fda5mr8165518pfl.12.1699996717967; 
 Tue, 14 Nov 2023 13:18:37 -0800 (PST)
Received: from [192.168.0.4] ([71.212.149.95])
 by smtp.gmail.com with ESMTPSA id
 e23-20020a62aa17000000b0068842ebfd10sm1606301pff.160.2023.11.14.13.18.37
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 14 Nov 2023 13:18:37 -0800 (PST)
Message-ID: <bc43ecb5-f93b-4288-a6e1-624aebfcffcc@linaro.org>
Date: Tue, 14 Nov 2023 13:18:35 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] softmmu/memory: use memcpy for multi-byte accesses
Content-Language: en-US
To: Patrick Venture <venture@google.com>, pbonzini@redhat.com,
 peterx@redhat.com, david@redhat.com, philmd@linaro.org,
 peter.maydell@linaro.org
Cc: qemu-devel@nongnu.org, Chris Rauer <crauer@google.com>,
 Peter Foley <pefoley@google.com>
References: <20231114205507.3792947-1-venture@google.com>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20231114205507.3792947-1-venture@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::436;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x436.google.com
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

On 11/14/23 12:55, Patrick Venture wrote:
> Avoids unaligned pointer issues.
> 
> Reviewed-by: Chris Rauer <crauer@google.com>
> Reviewed-by: Peter Foley <pefoley@google.com>
> Signed-off-by: Patrick Venture <venture@google.com>
> ---
>   system/memory.c | 16 ++++++++--------
>   1 file changed, 8 insertions(+), 8 deletions(-)
> 
> diff --git a/system/memory.c b/system/memory.c
> index 304fa843ea..02c97d5187 100644
> --- a/system/memory.c
> +++ b/system/memory.c
> @@ -1343,16 +1343,16 @@ static uint64_t memory_region_ram_device_read(void *opaque,
>   
>       switch (size) {
>       case 1:
> -        data = *(uint8_t *)(mr->ram_block->host + addr);
> +        memcpy(&data, mr->ram_block->host + addr, sizeof(uint8_t));


This is incorrect, especially for big-endian hosts.

You want to use "qemu/bswap.h", ld*_he_p(), st*_he_p().


r~


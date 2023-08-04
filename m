Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B319A77020F
	for <lists+qemu-devel@lfdr.de>; Fri,  4 Aug 2023 15:42:28 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qRv3k-0003eJ-5f; Fri, 04 Aug 2023 09:41:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qRv3h-0003dN-NZ
 for qemu-devel@nongnu.org; Fri, 04 Aug 2023 09:41:37 -0400
Received: from mail-pl1-x62d.google.com ([2607:f8b0:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qRv3g-0002Vh-68
 for qemu-devel@nongnu.org; Fri, 04 Aug 2023 09:41:37 -0400
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-1bb893e6365so14754975ad.2
 for <qemu-devel@nongnu.org>; Fri, 04 Aug 2023 06:41:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1691156494; x=1691761294;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=DrlQwcI5vmCwNcVN4ouThYvJTY5NWvd1qxQVHO8HESU=;
 b=Bd7FppI0dLvNoWsEohtHeT2lMhq2lOSNZn2s+RV4aJAL0leOqsmQbYnYs9ysKswx9o
 3HCemCzJcSXPf36It9K7pcPGLya6KqO9yRm64PWQaIZX7H8TMSbDBbneZQnTkxRa2U/b
 Cxc/faKrmCEAMOf1GAbN2zs0EUjQbB1DY3/rTy+QEoRdk/fI53XlG2SXT8tWebfAS74M
 gqzmznujJb8E0lJTehv17eu1IyR3B17qQL7kWpfzDbDRQC+6fEhbXJDjTE7WDVzm/4IR
 sgJRcsn9ZxTP5PXlgjKW+EcUUGSHxTrCB1mv8RsCuVmQxLGjewMqI4x79tD2JC2nhOV7
 gRjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691156494; x=1691761294;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=DrlQwcI5vmCwNcVN4ouThYvJTY5NWvd1qxQVHO8HESU=;
 b=aChUh1q5vnIGQqVMbdPVb6sUM4rYjH0KOw7XgD8HE8bV8KU+RPJVETwIX+yusZPjMh
 BCGan194bBQauIZpsvqBdZSXMBrUhvZCg1qfS32E7dOpv/roxUX1s7nO8MtfaursURe6
 5yH2QPL2k1UG4CCayCbUafT4KebdMQLTtD9XTTTqU5/n6B2vtO6prsAektKXBIz3hVhE
 bVQ6jPOyJBAOtBFs28T/Ib5nuMSf3FOR0GO0z5hRGwWz3dtPGL4a8f6dY3+E2b2etHLM
 4/lUmNb+2MWl5VXKfQrXBzlJ/R08T42w+Y7CM2tVTdCnipEwN+JzYwBHd8KnjRJYk0vo
 /UNw==
X-Gm-Message-State: AOJu0YyDnj+udRiY9eGIoe0gSoqCQjuT/WXzBoBFAV/p4rNTzO+DYnE8
 ZcEvNsiNVB3PlVLDGt7B6Jsjfw==
X-Google-Smtp-Source: AGHT+IE/5BTbfyu9D5PoL+BpL5x98+9FYJZf5Ll4Bgg19tC4vnPVWov1dWk6vKEyaqKX978/w5br/A==
X-Received: by 2002:a17:902:e849:b0:1bb:bc6d:45a with SMTP id
 t9-20020a170902e84900b001bbbc6d045amr1761316plg.28.1691156494543; 
 Fri, 04 Aug 2023 06:41:34 -0700 (PDT)
Received: from ?IPV6:2602:47:d490:6901:1eed:f77f:f320:8b14?
 ([2602:47:d490:6901:1eed:f77f:f320:8b14])
 by smtp.gmail.com with ESMTPSA id
 a4-20020a170902ecc400b001b8b4730355sm1754714plh.287.2023.08.04.06.41.33
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 04 Aug 2023 06:41:34 -0700 (PDT)
Message-ID: <04b4edc5-f24d-3d33-970a-172e889d9c02@linaro.org>
Date: Fri, 4 Aug 2023 06:41:31 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PULL 02/10] util/interval-tree: Use qatomic_set_mb in
 rb_link_node
Content-Language: en-US
To: Michael Tokarev <mjt@tls.msk.ru>, qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Peter Maydell <peter.maydell@linaro.org>
References: <20230731210211.137353-1-richard.henderson@linaro.org>
 <20230731210211.137353-3-richard.henderson@linaro.org>
 <8854030f-73ea-b92b-2ee4-c219acfbe1c3@tls.msk.ru>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <8854030f-73ea-b92b-2ee4-c219acfbe1c3@tls.msk.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62d;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62d.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.093,
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

On 8/4/23 02:02, Michael Tokarev wrote:
> 01.08.2023 00:02, Richard Henderson wrote:
>> Ensure that the stores to rb_left and rb_right are complete before
>> inserting the new node into the tree.  Otherwise a concurrent reader
>> could see garbage in the new leaf.
>>
>> Cc: qemu-stable@nongnu.org
>> Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
>> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
>> ---
>>   util/interval-tree.c | 6 +++++-
>>   1 file changed, 5 insertions(+), 1 deletion(-)
>>
>> diff --git a/util/interval-tree.c b/util/interval-tree.c
>> index 5a0ad21b2d..759562db7d 100644
>> --- a/util/interval-tree.c
>> +++ b/util/interval-tree.c
>> @@ -128,7 +128,11 @@ static inline void rb_link_node(RBNode *node, RBNode *parent, 
>> RBNode **rb_link)
>>       node->rb_parent_color = (uintptr_t)parent;
>>       node->rb_left = node->rb_right = NULL;
>> -    qatomic_set(rb_link, node);
>> +    /*
>> +     * Ensure that node is initialized before insertion,
>> +     * as viewed by a concurrent search.
>> +     */
>> +    qatomic_set_mb(rb_link, node);
> 
> FWIW, there's no qatomic_set_mb() in 8.0 and before, so this can not be
> directly applied to stable-8.0.  This commit is missing in 8.0 before
> qatomic_set_mb() can be used:
> 
> commit 06831001ac8949b0801e0d20c347d97339769a20
> Author: Paolo Bonzini <pbonzini@redhat.com>
> Date:   Fri Mar 3 14:37:51 2023 +0100
> 
>      atomics: eliminate mb_read/mb_set
> 
> I don't think it's a good idea to back-port this commit to stable-8.0.
> 
> How do you think we can solve this for 8.0?

The function is called qatomic_mb_set instead of qatomic_set_mb in stable-8.0.


r~


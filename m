Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 88B7E77029D
	for <lists+qemu-devel@lfdr.de>; Fri,  4 Aug 2023 16:10:42 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qRvVA-00065j-TV; Fri, 04 Aug 2023 10:10:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qRvV9-00065U-3u
 for qemu-devel@nongnu.org; Fri, 04 Aug 2023 10:09:59 -0400
Received: from mail-pl1-x62d.google.com ([2607:f8b0:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qRvV7-0004Ka-Q7
 for qemu-devel@nongnu.org; Fri, 04 Aug 2023 10:09:58 -0400
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-1b9c5e07c1bso18527795ad.2
 for <qemu-devel@nongnu.org>; Fri, 04 Aug 2023 07:09:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1691158196; x=1691762996;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=so2CK6dyp1IFmPB3Uh21YmEZvaNgNRa928Um22nyWF0=;
 b=Vncvq9EBfv9B8Gj6F47WhuIhSRQzmKInuEZOk2guO8S0R45iIdzvCgrChjGNWvLB1J
 5ArQ4oUO8hmoEy8USYONwcRQgx5+wKvZC3tjNhS0zzGDzp9tyq9vxIfqKOgBDDnt+h3o
 vO3M2PnNvPF56D7RSIRZl4FoH8tVtEh4BkeILPyVLM+OlWadybY4J3lCTnM6fnvbooMn
 GUun6LJfGMXvaknrQzxvoHNKPixkYMLuqvzbDsaKdeaDoMzgnPPapPw3Ck9+72mDMyDU
 /2Ubb804+OjAoVo4k5/0oh3zz0AgtNQWpbKI0j3vmi6uXYQnvfBKnuYF3tvkWmgrp3D3
 HRMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691158196; x=1691762996;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=so2CK6dyp1IFmPB3Uh21YmEZvaNgNRa928Um22nyWF0=;
 b=K1rGXDL6rLke+1rTTGml1yBXhcU1TGzoQiVl1Vzrco5iU9T0JDJ2489BMUyG1o0lOH
 /eofwpzOP3vjEJWxABQDMLLy0Q6dKVVpTyVwd+UE1eNQ1RX9ZNWQmN4APlhm2H2FI/QU
 8ZCLShpqlpCKHdlhPo6L+0f+r4iskZP8uSp9O4zgtGjCX6DU8FnPMSWbFX7xhJR49S8p
 WFJftNZ4TI3QwFfXy7RCPIgvKG6mm22eZ8T69hU/D/6SRULKit0o2+hz6AGatwiT/E/Y
 NAOV4PrYMl0HhnRvIYu5IhyOwCEUe92+0UZo9KLZf5zfCQK9USEqM5VifUq8K1u/mAqD
 aOHQ==
X-Gm-Message-State: AOJu0YwyTu4XMcfDdiIBvafpkhzaY0RBdzcX3gydDW4CJ42Js+CVPeWC
 ZjKtPs+9bYe1C5CViBn6oO9mSw==
X-Google-Smtp-Source: AGHT+IFGC6ij54Hmv+DpcdQ3og1CD7DG9NrJH2GGT9G+AzcGISxFZOCR3jHu4NPHoUon02eb0EzKiw==
X-Received: by 2002:a17:902:b20b:b0:1b8:94f4:3e0 with SMTP id
 t11-20020a170902b20b00b001b894f403e0mr1804691plr.14.1691158195604; 
 Fri, 04 Aug 2023 07:09:55 -0700 (PDT)
Received: from ?IPV6:2602:47:d490:6901:1eed:f77f:f320:8b14?
 ([2602:47:d490:6901:1eed:f77f:f320:8b14])
 by smtp.gmail.com with ESMTPSA id
 m1-20020a170902d18100b001b9d7c8f44dsm1815295plb.182.2023.08.04.07.09.54
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 04 Aug 2023 07:09:55 -0700 (PDT)
Message-ID: <60c59e50-249b-0387-a128-d2f54cf968f0@linaro.org>
Date: Fri, 4 Aug 2023 07:09:53 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v8 10/17] linux-user: Define ELF_ET_DYN_BASE in
 $guest/target_mman.h
Content-Language: en-US
To: Akihiko Odaki <akihiko.odaki@daynix.com>, qemu-devel@nongnu.org
Cc: joel@jms.id.au, laurent@vivier.eu, deller@gmx.de
References: <20230804014517.6361-1-richard.henderson@linaro.org>
 <20230804014517.6361-11-richard.henderson@linaro.org>
 <e6b824bb-9bc6-3609-e58c-37963e110fbe@daynix.com>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <e6b824bb-9bc6-3609-e58c-37963e110fbe@daynix.com>
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

On 8/3/23 22:20, Akihiko Odaki wrote:
>> +    if (reserved_va) {
>> +        if (ELF_ET_DYN_BASE < reserved_va) {
>> +            elf_et_dyn_base = ELF_ET_DYN_BASE;
>> +        } else {
>> +            /* The most common default formula is TASK_SIZE / 3 * 2. */
>> +            task_unmapped_base = TARGET_PAGE_ALIGN(reserved_va / 3) * 2;
> 
> This assigns a value to task_unmapped_base and that does not seem correct.
> 

Gah, I fixed this on a different copy of my branch, then lost it.


r~


Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C76276CA35
	for <lists+qemu-devel@lfdr.de>; Wed,  2 Aug 2023 12:00:06 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qR8co-0006G0-Qy; Wed, 02 Aug 2023 05:58:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1qR8cl-0006FB-Sv
 for qemu-devel@nongnu.org; Wed, 02 Aug 2023 05:58:36 -0400
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1qR8ck-0004tK-7d
 for qemu-devel@nongnu.org; Wed, 02 Aug 2023 05:58:35 -0400
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-1bbf8cb694aso36706225ad.3
 for <qemu-devel@nongnu.org>; Wed, 02 Aug 2023 02:58:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20221208.gappssmtp.com; s=20221208; t=1690970313; x=1691575113;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=0eXML+MI0NmEs9/LL/RFACVn99K4LLrC2IPfOeZQfpQ=;
 b=Siyp13u9vNgdpSOwPrV8vTd8Xi7TZl9MHxqzFqr1ZEH3Az0/Cd/tA9i6RgoNjNpheB
 Z2rNkoYKQEoVJ2azkRgtpnsvGu17fwnj1MGoUMVmMb4patLGWWH2D1nT4DWp/+RoRTQO
 xY0c0BikfS8o3EFvHA8vUPiCspmXE9HUwxomNKEN3RV0aPd6RuN995aLH+jbRREzgz33
 Swl2dhAwMJrlu3ixvE5cMRhQgmVf2An1x6OXaNbgOKfwxvK2jn3DVplQXy/Tvs/o4ddz
 CoBCGlzywYvIF/9vEFMa9y4fEwgb8xCuqzKrlAFf9SkZhXNqukwKTrQLgqIRuJsNnvfi
 r6mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1690970313; x=1691575113;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=0eXML+MI0NmEs9/LL/RFACVn99K4LLrC2IPfOeZQfpQ=;
 b=AK3JwI8rt+1KB9hC37oLOjEbPPyOY0K5G8JhNiv/DcsR/t23hQCJ8LgKF6UNICqAXc
 /KNDn+ar091pPECbiwfdV9xAKzu7jyiX2ujsLzyAje4AKuvcIUr/xErRK+33D5Wl8sxM
 0MWjL8NzMCi+ma5rI2pqvTQjGNtewor9KfQSy0TMP8VKTvVJFuGZzgFiybf37JnRn4R6
 RlHWoVd87PX5wGFQNVGd+AYWfJ9JPme/GuGIiwRTtPfCiZD3eKqaQKRj0G8XZvVfy6Dq
 uyDi7pbGkKLVJrIiSk0cr8xhczXuycUnKsHkDt1aNJEQDfZzh77gERm0jYV2GHIdst6E
 UlvA==
X-Gm-Message-State: ABy/qLZjpLJVlVKIZO+p/aoT52Hc50/qQF9XANrI8DBlqgGkmbeNZTYR
 6SwDKNuq7nfagzVh+gINh4DSxg==
X-Google-Smtp-Source: APBJJlH7pBGrGM9pJ74CBXAsKAlnmnPOFVAtTJm/+HTAc+tUpHCKrHMEj8qjFwTWn6ue9zhR2OZV4A==
X-Received: by 2002:a17:902:c20c:b0:1b8:adc:7c3d with SMTP id
 12-20020a170902c20c00b001b80adc7c3dmr15686917pll.40.1690970312782; 
 Wed, 02 Aug 2023 02:58:32 -0700 (PDT)
Received: from ?IPV6:2400:4050:a840:1e00:78d2:b862:10a7:d486?
 ([2400:4050:a840:1e00:78d2:b862:10a7:d486])
 by smtp.gmail.com with ESMTPSA id
 p16-20020a170902e75000b001b9cb27e07dsm12015956plf.45.2023.08.02.02.58.30
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 02 Aug 2023 02:58:32 -0700 (PDT)
Message-ID: <bb3d5dea-5c64-862b-b3b1-6d18c9fba5b4@daynix.com>
Date: Wed, 2 Aug 2023 18:58:29 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 8/8] linux-user: Load pie executables at upper memory
To: Helge Deller <deller@gmx.de>, qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>, Paolo Bonzini <pbonzini@redhat.com>,
 Joel Stanley <joel@jms.id.au>
References: <20230801232745.4125-1-deller@gmx.de>
 <20230801232745.4125-9-deller@gmx.de>
 <6126807c-2390-27d9-315d-de67c31a8f60@daynix.com>
 <c1e68eb1-6d26-22fd-8c51-c1ba1e472187@gmx.de>
 <6f73b04e-7c85-0dfb-c3cc-7a43b4663593@daynix.com>
 <69247c58-52c4-65c2-8d08-c553adda0d9d@gmx.de>
Content-Language: en-US
From: Akihiko Odaki <akihiko.odaki@daynix.com>
In-Reply-To: <69247c58-52c4-65c2-8d08-c553adda0d9d@gmx.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::631;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pl1-x631.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On 2023/08/02 18:34, Helge Deller wrote:
> On 8/2/23 10:44, Akihiko Odaki wrote:
>> On 2023/08/02 17:42, Helge Deller wrote:
>>> On 8/2/23 09:49, Akihiko Odaki wrote:
>>>> On 2023/08/02 8:27, Helge Deller wrote:
>>>>> Fix the elf loader to calculate a valid TASK_UNMAPPED_BASE address 
>>>>> for all
>>>>> 32-bit architectures, based on the GUEST_ADDR_MAX constant.
>>>>>
>>>>> Additionally modify the elf loader to load dynamic pie executables at
>>>>> around:
>>>>> ~ 0x5500000000  for 64-bit guest binaries on 64-bit host,
>>>>> - 0x00300000    for 32-bit guest binaries on 64-bit host, and
>>>>> - 0x00000000    for 32-bit guest binaries on 32-bit host.
>>>>
>>>> Why do you change guest addresses depending on the host?
>>>
>>> The addresses are guest-addresses.
>>> A 32-bit guest PIE can't be loaded at e.g. 0x5500000000,
>>> while a 64-bit guest PIE needs to be loaded at 0x5500000000.
>>
>> I mean, why do you use address 0x00000000 for 32-bit guest binaries on 
>> 32-bit host while you use address 0x00300000 on 64-bit host?
> 
> To keep the memory pressure for the 32-bit qemu binary minimal.
> On 64-bit host we have the full 32-bit address space for the guest.
> 
> Helge
> 

That makes sense. I'm worried that using 0x00000000 may break NULL 
checks on the guest though.

Regards,
Akihiko Odaki


Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EEFB704BD1
	for <lists+qemu-devel@lfdr.de>; Tue, 16 May 2023 13:08:33 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1pysXK-0002UY-92; Tue, 16 May 2023 07:08:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <danielhb413@gmail.com>)
 id 1pysXH-0002Rb-Cq; Tue, 16 May 2023 07:08:07 -0400
Received: from mail-oa1-x36.google.com ([2001:4860:4864:20::36])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <danielhb413@gmail.com>)
 id 1pysXF-0002SD-U6; Tue, 16 May 2023 07:08:07 -0400
Received: by mail-oa1-x36.google.com with SMTP id
 586e51a60fabf-1928eee97f7so11416918fac.2; 
 Tue, 16 May 2023 04:08:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1684235283; x=1686827283;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=1qFaX52X2QrYlm3bt4NFg+U0zuzwGlX6Lv0Nx0DKRQI=;
 b=DyHUjsLu7VNTeNBaXV7OkW6ktqLsBygLzsp226XSRXi/+ql3JI2NucjuBF9xv4gDT/
 AjusYcsoxa5QVHHzqvXAqmvZQbPtTgNNfhRrpjSGXuhx0RBYDUuVB9wjnEEPB60GrbBI
 S+XzErGWIqnu7A95kuen48QMU+bBr54mhXdoAgDUrXJI5qphcmePTO/9NmKcmtBFuchD
 wIs5eZRF1Wyq0881LOtZp21uNY7fpgmxh9Mkp8hWZ6kga5PfEPxS8xQ7N/wS0NeJ+c+e
 azBqnETkIU4eQ6xLoAgRKaEHSmB1e2wx6IBYz4HCZjpotibXZ/T9eQNyeDKvOWHCkTQ0
 ifDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684235283; x=1686827283;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=1qFaX52X2QrYlm3bt4NFg+U0zuzwGlX6Lv0Nx0DKRQI=;
 b=Mjihmj3o2aj6XU5TxoPoy7Dcy/MHgG+dbcqyUA+dJuGopdqrWY88ngaUXyqiXWsDRY
 AHA6ai6QPrSXLzOCMuL0GcDINdr4YTXZKtEI9Jpy1T2PHfn1a6E5BggAFY78pzfartQG
 2wE42JN6/mbjbjkAWXFwfnetHYLhUxXeDDzMqWEL9leCrKGThyLLzIkR/yllWK9icleS
 Qo+l6hM34jXUFXzsrpkuAQha5gKG+MFPL00DNy99LxLDtW2NsognBxe3xqzH7hUOtNBr
 tgJCTM9f9Uvjr2uKi3zFGJE/ISLKr9R/n48neIbMRXjxXvgM5H9bnY7yiA340a29uwlO
 eaIA==
X-Gm-Message-State: AC+VfDzGW/edCJma5512isWAYantM4+CUJc62mnt3KvVv6vnK1OcxD6E
 mpIMO93lvKw+UqBkGCu3Ky4=
X-Google-Smtp-Source: ACHHUZ6WbwQAqOWkxSl718gFNbUawm2OhuGEfsaFHqaiOXtWupo+lnMwLIQ0Qi4vQGVyZEHCbAWVmQ==
X-Received: by 2002:a05:6870:3a32:b0:192:57d6:cc2a with SMTP id
 du50-20020a0568703a3200b0019257d6cc2amr17302832oab.14.1684235283607; 
 Tue, 16 May 2023 04:08:03 -0700 (PDT)
Received: from [192.168.68.107] (189-46-207-53.dsl.telesp.net.br.
 [189.46.207.53]) by smtp.gmail.com with ESMTPSA id
 v5-20020a056870198500b001807f020a39sm12837726oam.12.2023.05.16.04.08.01
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 16 May 2023 04:08:03 -0700 (PDT)
Message-ID: <d78df958-ee12-7497-761d-91d03ffe74fa@gmail.com>
Date: Tue, 16 May 2023 08:07:59 -0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v3 2/9] target/ppc: Fix PMU MMCR0[PMCjCE] bit in hflags
 calculation
Content-Language: en-US
To: Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org
Cc: qemu-devel@nongnu.org, Daniel Henrique Barboza <dbarboza@ventanamicro.com>
References: <20230515092655.171206-1-npiggin@gmail.com>
 <20230515092655.171206-3-npiggin@gmail.com>
 <4b7c4c7b-d374-766b-48f1-c6769805f0bc@gmail.com>
 <CSNN2JCJ9ZUZ.3U1FM12NO5AIQ@wheely>
From: Daniel Henrique Barboza <danielhb413@gmail.com>
In-Reply-To: <CSNN2JCJ9ZUZ.3U1FM12NO5AIQ@wheely>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2001:4860:4864:20::36;
 envelope-from=danielhb413@gmail.com; helo=mail-oa1-x36.google.com
X-Spam_score_int: -44
X-Spam_score: -4.5
X-Spam_bar: ----
X-Spam_report: (-4.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001, NICE_REPLY_A=-2.666,
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



On 5/16/23 07:44, Nicholas Piggin wrote:
> On Tue May 16, 2023 at 7:32 PM AEST, Daniel Henrique Barboza wrote:
>>
>>
>> On 5/15/23 06:26, Nicholas Piggin wrote:
>>> A store to MMCR0 with PMCjCE=1 fails to update hflags correctly and
>>> results in hflags mismatch:
>>>
>>>     qemu: fatal: TCG hflags mismatch (current:0x2408003d rebuilt:0x240a003d)
>>>
>>> This can be reproduced by running perf on a recent machine.
>>>
>>> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
>>> ---
>>
>> Fixes: c2eff582a32f ("target/ppc: PMU basic cycle count for pseries TCG")
> 
> Or is it this one? 0625c7760d54 ("target/ppc: do not call
> hreg_compute_hflags() in helper_store_mmcr0()")
> 
> Ah, neither! It looks like 8b3d1c49a9f0 ("target/ppc: Add new PMC
> HFLAGS"). But that shows I have probably missed HFLAGS_PMC_OTHER
> here.
> 
> Let me do a bit more investigation and send an updated patch if
> necessary.


Sure, let's hold this one for now.


Daniel

> 
> Thanks,
> Nick
> 
>>
>> (not sure why I didn't hit this back in 2021)
>>
>>
>> Reviewed-by: Daniel Henrique Barboza <danielhb413@gmail.com>


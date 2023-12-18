Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C7FC817D16
	for <lists+qemu-devel@lfdr.de>; Mon, 18 Dec 2023 23:02:52 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rFLfU-0007MO-On; Mon, 18 Dec 2023 17:00:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1rFLfR-0007M7-St
 for qemu-devel@nongnu.org; Mon, 18 Dec 2023 17:00:53 -0500
Received: from mail-pl1-x62e.google.com ([2607:f8b0:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1rFLfP-0005Z7-P1
 for qemu-devel@nongnu.org; Mon, 18 Dec 2023 17:00:53 -0500
Received: by mail-pl1-x62e.google.com with SMTP id
 d9443c01a7336-1d3cfb1568eso7500755ad.1
 for <qemu-devel@nongnu.org>; Mon, 18 Dec 2023 14:00:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1702936850; x=1703541650; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=AkqEURBx3aCOt9Pnvek4xVOOVZy2X+5UwM7Trc5uEKw=;
 b=muomVD3AKqII9aBD+oIfr2qOydLVji7H77a8B5QaAAtvlEpcjfO9wcBbUVSWcXTfez
 4x43+iJUqxo8ZSfaPA1Vo/qY5FgetomPcSsX6Z7bebER114aaHMbtfUQbo1x6EDs09sX
 hJEhILTAiUpVj3lYGxZHZwwTEB3wXasAgYXRKGR7cdUdOLXpSP+Zo9GN9/00hMXZdRRG
 ded8DhdhwCSegFK2nYVavD2Cmo8LrG1N8YmfWpvATLGqUHhAb/UoAZjnKJ3bvtEcu+OR
 UPdVvgcG2VgDlRPHBZvXoCLf83FiToSTTZTNy0zm9s8cMAim/F5QdZnvMzT2/GwH5lnw
 xf1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702936850; x=1703541650;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=AkqEURBx3aCOt9Pnvek4xVOOVZy2X+5UwM7Trc5uEKw=;
 b=vsZuBmjtVmdP4qFNjRrPjAfANGJSZZSk6IzTeIxRxpPkatgZp07AZqQr2F5fBfnF1H
 dCYbVZUHSbACdklx7bV7v6GcFIKkRMiSXfTwoOIBqFgeP8JZ0apf4LIJq5OWBitftolC
 5OOe94nt25sYGzWHWFQBcZfyd0ayi6QABMaL+cdfdkGYoOJLeqSi7FLX7yKsAWPP1rAi
 nqa1wzGZqJsJw5vGbzRwpq2O5OWw4BhK4VYQ/q9NeWj/ld6A/ZzCdrVqFNYopdMp8YR6
 1e7wtQ5XzUWGHz+37up20e6XQv+ZWkmdRkEadhx4HzwXn5DgyrkAMGgqhcYb6wrbkCkk
 F22Q==
X-Gm-Message-State: AOJu0YxdNLjDrLWzDpGIIDnAlgFBph968cYPhYddAGimCNorSp+YqKpA
 tJfY1QWiccu9tVVPYHQiFYfniw==
X-Google-Smtp-Source: AGHT+IE7tYp0hWzxSsI3PxQ8Q5jEl1Tfqkdx6J3KQl0fCyMh0Ahxmn6xVYdXha2KGPwoQhEpYZAUPw==
X-Received: by 2002:a17:902:ea04:b0:1d3:b4ce:f8d4 with SMTP id
 s4-20020a170902ea0400b001d3b4cef8d4mr2618031plg.54.1702936850199; 
 Mon, 18 Dec 2023 14:00:50 -0800 (PST)
Received: from [192.168.68.110] ([179.93.21.205])
 by smtp.gmail.com with ESMTPSA id
 t4-20020a170902b20400b001d33a7fd3fcsm12210091plr.16.2023.12.18.14.00.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 18 Dec 2023 14:00:49 -0800 (PST)
Message-ID: <3ba366c4-3fef-4d4a-bcfb-4cb3dd8e8ea6@ventanamicro.com>
Date: Mon, 18 Dec 2023 19:00:44 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] target/riscv/kvm: do not use non-portable
 strerrorname_np()
Content-Language: en-US
To: Michael Tokarev <mjt@tls.msk.ru>, Natanael Copa <ncopa@alpinelinux.org>,
 qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, qemu-trivial@nongnu.org,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Bin Meng <bin.meng@windriver.com>, Weiwei Li <liwei1518@gmail.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 "open list:RISC-V TCG CPUs" <qemu-riscv@nongnu.org>
References: <20231218162301.14817-1-ncopa@alpinelinux.org>
 <dfb9bf4e-820a-4e7e-b62b-8df952099e7a@ventanamicro.com>
 <3a159117-1f07-4d1d-911f-98e102959dab@tls.msk.ru>
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
In-Reply-To: <3a159117-1f07-4d1d-911f-98e102959dab@tls.msk.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62e;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-pl1-x62e.google.com
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



On 12/18/23 18:35, Michael Tokarev wrote:
> 18.12.2023 20:20, Daniel Henrique Barboza wrote:
>>
>>
>> On 12/18/23 13:22, Natanael Copa wrote:
>>> strerrorname_np is non-portable and breaks building with musl libc.
>>>
>>> Use strerror(errno) instead, like we do other places.
>>>
>>> Cc: qemu-stable@nongnu.org
>>> Fixes: commit 082e9e4a58ba (target/riscv/kvm: improve 'init_multiext_cfg' error msg)
>>> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2041
>>> Buglink: https://gitlab.alpinelinux.org/alpine/aports/-/issues/15541
>>> Signed-off-by: Natanael Copa <ncopa@alpinelinux.org>
>>> ---
>>>   target/riscv/kvm/kvm-cpu.c | 18 ++++++++----------
>>>   1 file changed, 8 insertions(+), 10 deletions(-)
>>>
>>> diff --git a/target/riscv/kvm/kvm-cpu.c b/target/riscv/kvm/kvm-cpu.c
>>> index 45b6cf1cfa..117e33cf90 100644
>>> --- a/target/riscv/kvm/kvm-cpu.c
>>> +++ b/target/riscv/kvm/kvm-cpu.c
>>> @@ -832,9 +832,8 @@ static void kvm_riscv_read_multiext_legacy(RISCVCPU *cpu,
>>>                   multi_ext_cfg->supported = false;
>>>                   val = false;
>>>               } else {
>>> -                error_report("Unable to read ISA_EXT KVM register %s, "
>>> -                             "error code: %s", multi_ext_cfg->name,
>>> -                             strerrorname_np(errno));
>>> +                error_report("Unable to read ISA_EXT KVM register %s: %s",
>>> +                             multi_ext_cfg->name, strerror(errno));
>>
>>
>> The reason I did this change, as described in 082e9e4a58ba mentioned in the commit
>> message, was precisely to avoid things like this:
>>
>> qemu-system-riscv64: Unable to read ISA_EXT KVM register ssaia, error: no such file or directory
> 
> If KVM context puts its own unique meaning for ENOENT, maybe something like
> 
>   "unable to read KVM register: %s\n", errno == ENOENT ? "no such register" : strerror(errno)
> 
> would do it better?


A solution like this is something I can go after if I'm bothered enough with how strerror()
is working in the RISC-V KVM driver.

For now I think we can live with this fix as is since fixing the build is more important
that aesthetics.


Thanks,

Daniel

> 
> To me, "No such file or directory" already tells everything and does not look
> weird, but that's because I've seen this error message for all sorts of contexts
> and got used to this. It is definitely understandable.
> 
> /mjt


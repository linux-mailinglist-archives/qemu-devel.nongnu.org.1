Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CB5773E66A
	for <lists+qemu-devel@lfdr.de>; Mon, 26 Jun 2023 19:29:07 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qDq0O-0000pC-96; Mon, 26 Jun 2023 13:28:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1qDq0F-0000oN-SX
 for qemu-devel@nongnu.org; Mon, 26 Jun 2023 13:27:52 -0400
Received: from mail-oa1-x2a.google.com ([2001:4860:4864:20::2a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1qDq0E-0001xe-6T
 for qemu-devel@nongnu.org; Mon, 26 Jun 2023 13:27:51 -0400
Received: by mail-oa1-x2a.google.com with SMTP id
 586e51a60fabf-1b038d7a5faso1224608fac.1
 for <qemu-devel@nongnu.org>; Mon, 26 Jun 2023 10:27:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1687800469; x=1690392469;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=8Plo6xnpIPmTTpB2LD2W6Po7Z8za3kqWVcMrwmPub64=;
 b=MaxgaofGfAoqy1VedRncuEYlaafkDkeCV+CAr4GgHZs7lp05htNaw7uN5YYVRDYcpq
 YNFiOdiKHqb8n8JgdgaIYY3OBJ/KlUhyaRvGkG1APX4rE+uQi5YsktyI0iu7niP8/fN0
 dNNWursczAFec/1oYETH24ZxNYlHbmbBB9Ax4vVMq09pv07z+5mgyjeJDYXk8rxPhHJR
 w6CbAcsN2baAERA1jc1EBdDOIFAw10AAf2I5xiRViAtCyRsvgdaM/pJ+PCdqjjdGNSWr
 hD5BEiaYL36i84npQmflcmw7cNzKfUEY8eHBiWIBp7UQhAEeCDJSb4qHiC+UL73UrbS2
 AerA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687800469; x=1690392469;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=8Plo6xnpIPmTTpB2LD2W6Po7Z8za3kqWVcMrwmPub64=;
 b=ZANGoPXhGD8AvBn5W+WXIarlRVQU1uBzHYcUQXAFT0UVfVI2neKQOi/aMgN4i0ArTJ
 G4wkgEZb8n7VfggnVRlaHw50H6gMZO0kgDYAaZ+wynMVKh1LfAKYqisXuBOZYYXAPW7P
 YVvUCUZby/50j41xcnHrll5wm1PT6IbLnZrlRu4gyCtubCfSwk73fyjDRoyW67zEN5x/
 1evSpK/2eg0cP2mW+vUxDz2s33smRofZWw6HqBfkFXw78NOWRXsEoRDnEXS2ZxmOlrWr
 ux+bmjtyzvIExYOIHpQltNujihewkFIln2v0QCV1bq4jom+clkrZwhoWjzkBbQ27cGcZ
 5BhQ==
X-Gm-Message-State: AC+VfDxlwMLUlFDysSPl7yOY04qbLi5ICw9Laj6R8b/plKDE9gp2FRjI
 JVrXVwCBxoFumgTeeK7hvhafbA==
X-Google-Smtp-Source: ACHHUZ5HwgmmnFjls94cIEA0vBAPWNuvXwSiQ356wskzKCHSruLrkkKBja2GLIIZH0cy73rm5sZ8LA==
X-Received: by 2002:a05:6870:63ac:b0:18b:1d56:b83d with SMTP id
 t44-20020a05687063ac00b0018b1d56b83dmr24503732oap.59.1687800468752; 
 Mon, 26 Jun 2023 10:27:48 -0700 (PDT)
Received: from [192.168.68.107] (201-69-66-110.dial-up.telesp.net.br.
 [201.69.66.110]) by smtp.gmail.com with ESMTPSA id
 l10-20020a056870f14a00b001b011efb1ebsm3422412oac.0.2023.06.26.10.27.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 26 Jun 2023 10:27:48 -0700 (PDT)
Message-ID: <3426d6b0-87b5-8a71-f1ce-86ac03894bf7@ventanamicro.com>
Date: Mon, 26 Jun 2023 14:27:44 -0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v3 16/19] target/riscv/cpu.c: create KVM mock properties
Content-Language: en-US
To: Andrew Jones <ajones@ventanamicro.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, alistair.francis@wdc.com,
 bmeng@tinylab.org, liweiwei@iscas.ac.cn, zhiwei_liu@linux.alibaba.com,
 palmer@rivosinc.com
References: <20230622135700.105383-1-dbarboza@ventanamicro.com>
 <20230622135700.105383-17-dbarboza@ventanamicro.com>
 <20230623-421ca497f9f83486881b9d9c@orel>
 <c1056ba9-4418-d6ce-536b-93155fff84a2@ventanamicro.com>
 <20230624-fad369c515a7f4edd9d21c2a@orel>
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
In-Reply-To: <20230624-fad369c515a7f4edd9d21c2a@orel>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2001:4860:4864:20::2a;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-oa1-x2a.google.com
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



On 6/24/23 04:41, Andrew Jones wrote:
> On Fri, Jun 23, 2023 at 11:28:03AM -0300, Daniel Henrique Barboza wrote:
> ...
>>> I think we should actually fail with an error when the user tries to
>>> enable an extension KVM doesn't support. Otherwise a user may be
>>> confused as to why their Zawrs=on didn't provide them a machine with
>>> Zawrs. And, when KVM learns how to provide that support to guests
>>> (Zawrs is actually on my TODO...), then migrating the same VM to
>>> later KVM/QEMU will actually enable the feature, possibly confusing
>>> the guest.
>>>
>>> So, we should probably just not add any extension properties to KVM
>>> guests which can't be enabled. Then, as we add support to KVM, we'll
>>> add the properties too.
>>
>> By 'extension properties' do you mean just the flags that enable/disable them,
>> like '-cpu, rawrs=<bool>', or also the other properties related to extensions
>> that KVM might not support, like 'vlen' and 'elen' from RVV? I'd say that it's
>> ok to leave things such as 'vlen' because the user won't be able to enable RVV
>> in KVM anyways.
> 
> Properties like 'vlen', which have a dependency on an extension, should
> probably have their own error checking at cpu finalize features time.
> I.e. if 'vlen' is present, but not V, then QEMU should complain. I see
> we don't currently do that, though.

We do some checks during realize() in riscv_validate_set_extensions(), via
riscv_cpu_validate_v(). However, 'is the user set vlen but not V we should error
out' is not possible because we don't have a 'user_set' flag for this option, and
we can't say if vlen = 128 is the default, untouched value, or if the user
set vlen = 128 in the command line.

I think we're getting closer to a point where we can "export" the KVM config
options model to TCG. Let's see if we can pull something off for the next
release.

> 
>>
>> And what error do we want to throw? With this patch it's easy to just add an
>> Extension zawrs is not available using KVM" error message. Otherwise we can
>> not add the property at all and then QEMU will fail with a "property cpu.X not
>> found" type of error. Both will error out, question is whether we want to be
>> more informative about it.
> 
> It's probably best to do the "not available with KVM" error by changing
> this patch from adding a no-op setter to an error-out setter. That way,
> our story that a riscv machine is the same for both KVM and TCG still
> remains, i.e. all properties are still present, but we add the honesty
> to the story that not everything works with KVM.

Got it. I'll add an error message in v4. Thanks,


Daniel

> 
> Thanks,
> drew


Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 14BF379E29C
	for <lists+qemu-devel@lfdr.de>; Wed, 13 Sep 2023 10:51:12 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qgLZh-0003TG-AQ; Wed, 13 Sep 2023 04:50:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qgLZe-0003Rq-J6
 for qemu-devel@nongnu.org; Wed, 13 Sep 2023 04:50:14 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qgLZc-0005cB-17
 for qemu-devel@nongnu.org; Wed, 13 Sep 2023 04:50:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1694595010;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=nsU0BgJc3qYJ7FpPjMHSsXKrsmrHsXNL15b9+2O8vWU=;
 b=dg33uhdZCnht9zFzHbvQc6zcUiKQs1kWGEJXu137wohBZECTYq+5FQLQAIRGmYWwBYwr49
 uqjACFnJvzYYAcyoihHY5q4dIa6Ju6NDxne+rny4QXK5nFj4NqGAvb/3rSrXxtcdOTq891
 MYDYOiMgiqXr9Jz39CoqB3UYa7FXrt8=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-329-AVowMCpPPC2TwZZWw2pCsA-1; Wed, 13 Sep 2023 04:50:09 -0400
X-MC-Unique: AVowMCpPPC2TwZZWw2pCsA-1
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-402cba95486so51272545e9.0
 for <qemu-devel@nongnu.org>; Wed, 13 Sep 2023 01:50:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694595008; x=1695199808;
 h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
 :content-language:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=nsU0BgJc3qYJ7FpPjMHSsXKrsmrHsXNL15b9+2O8vWU=;
 b=D5Pf3R5WNX9LujjCdFXSWo4Fvak3NnSCAXeg4UCWYl+xQ3uBPCVS39tekBb5DR0pEc
 cqY2sVCFiQPWAbrqAeZ7I9R8su/47RwoIR1m+LGBuuzGtgyVLCe9ViKVlTCqKikEhXvC
 2ir/S1frmAvDrfWa7vm9Lpw5zrF+vdgtzyh9soX255qENvduqG6HlQVQDMZ7aNSLc+Yz
 Suut5ziEWRXbpJ46puQcr285rh7qiAOiSEcuXUuRSxCJbPZNZyqrS/AgydooNbw3fI3V
 0VXjLVODC93D1zDd7bBHuCNBeynFa+NLotuLIXgzULjYOl3gJmGKQLW8hX7GCJnZM//h
 BNhw==
X-Gm-Message-State: AOJu0Yw8kJFpJaAmRi5VlGuo67qIFuBMKmjvd49IqhepJ2Q1XGlF8gj9
 hUkvErG1TESjlgtpzKYieU5MDFVnol19ys4KH9VcaCGOzzjZOhgiFOv87Bnq+iSHg0S8T99ZumC
 r0aE1p1kTKfss43w=
X-Received: by 2002:a1c:790d:0:b0:403:b86:f620 with SMTP id
 l13-20020a1c790d000000b004030b86f620mr1460067wme.12.1694595008050; 
 Wed, 13 Sep 2023 01:50:08 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG4vzQPgzw0XWZnsnNLpFmXXtfZmhsPhEmdxdIHXmdnzMVvjUf/KXg/QWxn51Vwje/0CRTUfQ==
X-Received: by 2002:a1c:790d:0:b0:403:b86:f620 with SMTP id
 l13-20020a1c790d000000b004030b86f620mr1460049wme.12.1694595007658; 
 Wed, 13 Sep 2023 01:50:07 -0700 (PDT)
Received: from [10.33.192.218] (nat-pool-str-t.redhat.com. [149.14.88.106])
 by smtp.gmail.com with ESMTPSA id
 y5-20020a1c4b05000000b0040303a9965asm1382313wma.40.2023.09.13.01.50.06
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 13 Sep 2023 01:50:07 -0700 (PDT)
Message-ID: <d17c56f3-c177-58ce-559e-cc514c70af4d@redhat.com>
Date: Wed, 13 Sep 2023 10:50:06 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Content-Language: en-US
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-s390x@nongnu.org, qemu-devel@nongnu.org,
 Richard Henderson <richard.henderson@linaro.org>,
 Ilya Leoshkevich <iii@linux.ibm.com>, David Hildenbrand <david@redhat.com>
References: <20230905115000.53587-1-thuth@redhat.com>
 <20230905115000.53587-2-thuth@redhat.com>
 <CAFEAcA8pKuFso_boUxzAsAktegT4DJ9U2q26RmiqYK5TWKTinw@mail.gmail.com>
From: Thomas Huth <thuth@redhat.com>
Subject: Re: [risu PATCH v2 1/4] s390x: Add basic s390x support to the C code
In-Reply-To: <CAFEAcA8pKuFso_boUxzAsAktegT4DJ9U2q26RmiqYK5TWKTinw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-1.473, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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

On 12/09/2023 18.50, Peter Maydell wrote:
> On Tue, 5 Sept 2023 at 12:50, Thomas Huth <thuth@redhat.com> wrote:
>>
>> With these changes, it is now possible to compile the "risu" binary
>> for s390x hosts.
>>
>> Acked-by: Ilya Leoshkevich <iii@linux.ibm.com>
>> Signed-off-by: Thomas Huth <thuth@redhat.com>
> 
> 
> 
>> +/* reginfo_init: initialize with a ucontext */
>> +void reginfo_init(struct reginfo *ri, ucontext_t *uc)
>> +{
>> +    int i;
>> +
>> +    memset(ri, 0, sizeof(*ri));
>> +
>> +    ri->faulting_insn = *((uint32_t *) uc->uc_mcontext.psw.addr);
> 
> Here we extract the faulting instruction, assuming it to
> be a 32-bit insn starting at uc_mcontext.psw.addr...
> 
>> +    ri->psw_mask = uc->uc_mcontext.psw.mask;
>> +    ri->psw_addr = uc->uc_mcontext.psw.addr - image_start_address;
>> +
>> +    for (i = 0; i < 16; i++) {
>> +        ri->gregs[i] = uc->uc_mcontext.gregs[i];
>> +    }
>> +
>> +    memcpy(&ri->fpregs, &uc->uc_mcontext.fpregs, sizeof(fpregset_t));
>> +}
> 
>> +void advance_pc(void *vuc)
>> +{
>> +    /*
>> +     * Note: The PSW address already points to the next instruction
>> +     * after we get a SIGILL, so we must not advance it here!
>> +     */
>> +    // ucontext_t *uc = (ucontext_t *) vuc;
>> +    // uc->uc_mcontext.psw.addr += 4;
> 
> ...but here we say that psw.addr points to the instruction
> *after* the faulting one.
> 
> These don't seem like they can both be correct?

Drat, you're right, thanks for the hint! The code in reginfo_init() is 
wrong, it takes the instruction after the illegal one. It was just working 
(wrongly, but without crashing) by accident here since the OP_TESTEND 
instruction was preceeded by an OP_COMPARE instruction :-/

To get the address (and thus opcode) of the faulting instruction, I have to 
use siginfo_t->si_addr instead of using the ucontext_t structure. I will fix 
it in the next version.

  Thomas



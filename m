Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6968E7BB22B
	for <lists+qemu-devel@lfdr.de>; Fri,  6 Oct 2023 09:31:30 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qofHr-0005Sn-7j; Fri, 06 Oct 2023 03:30:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qofHq-0005Ry-00
 for qemu-devel@nongnu.org; Fri, 06 Oct 2023 03:30:14 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qofHo-0002ND-8R
 for qemu-devel@nongnu.org; Fri, 06 Oct 2023 03:30:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1696577410;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=OwON+fjQ3ZcDMQ5QiBaHfEj/eiSwIAwOwf49n72SkOg=;
 b=co0E/hHaUW9NQERbQfykkpULE0Q9KI4R1638rUdnoR4ApP9QKGBTg46CAMKH434R4uh6Md
 Tlk4D14CW/tLvWYhmol+3awrg2WQKrI6bGvgVJ0n3xI4rUUKyX4pcYDuKV3H3rTUlOfOJe
 b+w8u6UOqu9xsvA8WJ8t2as+CLhUHbk=
Received: from mail-yb1-f197.google.com (mail-yb1-f197.google.com
 [209.85.219.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-625-14flT_sYNrePiCRya_3O2g-1; Fri, 06 Oct 2023 03:30:09 -0400
X-MC-Unique: 14flT_sYNrePiCRya_3O2g-1
Received: by mail-yb1-f197.google.com with SMTP id
 3f1490d57ef6-d865a8a7819so2605126276.2
 for <qemu-devel@nongnu.org>; Fri, 06 Oct 2023 00:30:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696577408; x=1697182208;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=OwON+fjQ3ZcDMQ5QiBaHfEj/eiSwIAwOwf49n72SkOg=;
 b=j7kUsOe+7tOuZXIfE89ivuvMEfUzbQYdncQmHbrA9hzz6E0Ue79YSBeon39aNIATe1
 HqmJUxdEm4AZYYGh822byrF/Ry65z6f4XCYk2WXmtzcSA0/3Ue5W3v5rF/bGoj4SYh7j
 Q1fsn2w891Lxm+eHXlZ4ZSXDZL2mIE+6Z9PxEXdo5y7daPDBwaAOjoaYjvwoEUDamSff
 t83y0M8UNTWqNaZQAizYuQlM4iAD0V7TMr2QmOtMMlyLEy7UsdT7Ac87cS9B7zDMXhtk
 eXIXbyE+7CYN2KFsstF4/FeNZichfhi7CuGxpLh35dsiR88aTTi+h3d9+TABp1nKB9xv
 Rz0A==
X-Gm-Message-State: AOJu0YwMZ4gzbZOLvK7hKRX+P+U6I1oH2BOEQT80I4TscGt3xtaAKY70
 K1hqfzO+IjJCgzpbn1SbB04aeCuM8txRUu3Ajw2talBbHIX3ZiABHXOGOiSOhBx/UazeaVgXR+d
 iNHCqa+Z299lnK+k=
X-Received: by 2002:a05:6902:8d:b0:d72:a54d:4b7 with SMTP id
 h13-20020a056902008d00b00d72a54d04b7mr6372971ybs.1.1696577408660; 
 Fri, 06 Oct 2023 00:30:08 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG0rgZ4L7UW4q1uPU8Sz3f3ScKU3IEUYH91sb5VelhOlwlS3SxRfln8RVhmPy1kSHz0wg660g==
X-Received: by 2002:a05:6902:8d:b0:d72:a54d:4b7 with SMTP id
 h13-20020a056902008d00b00d72a54d04b7mr6372951ybs.1.1696577407923; 
 Fri, 06 Oct 2023 00:30:07 -0700 (PDT)
Received: from [10.33.192.205] (nat-pool-str-t.redhat.com. [149.14.88.106])
 by smtp.gmail.com with ESMTPSA id
 g20-20020a0ce4d4000000b00641899958efsm1148695qvm.130.2023.10.06.00.30.06
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 06 Oct 2023 00:30:07 -0700 (PDT)
Message-ID: <8ecd7fb8-c107-2116-628b-0a5ab7ba37f6@redhat.com>
Date: Fri, 6 Oct 2023 09:30:05 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v6 18/19] linux-user/s390x: Add vdso
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: alex.bennee@linaro.org, laurent@vivier.eu,
 David Hildenbrand <david@redhat.com>
References: <20230930021529.987950-1-richard.henderson@linaro.org>
 <20230930021529.987950-19-richard.henderson@linaro.org>
 <92c8b00d-157e-6a03-7629-c331cf41ffc5@linaro.org>
 <4e1ade7c-8414-eade-6ea6-5e3fa58583fb@linaro.org>
 <3ff69283-ee2a-5feb-6736-93e6f3848e34@linaro.org>
From: Thomas Huth <thuth@redhat.com>
In-Reply-To: <3ff69283-ee2a-5feb-6736-93e6f3848e34@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -62
X-Spam_score: -6.3
X-Spam_bar: ------
X-Spam_report: (-6.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-4.219, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
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

On 05/10/2023 18.14, Philippe Mathieu-Daudé wrote:
> On 4/10/23 01:01, Richard Henderson wrote:
>> On 10/3/23 06:07, Philippe Mathieu-Daudé wrote:
>>>> +++ b/linux-user/s390x/vdso.ld
>>>> @@ -0,0 +1,69 @@
>>>> +/*
>>>> + * Linker script for linux x86-64 replacement vdso.

Should that be s390x instead of x86-64 ?

>>>> + * Copyright 2023 Linaro, Ltd.
>>>> + *
>>>> + * SPDX-License-Identifier: GPL-2.0-or-later
>>>> + */
>>>> +
>>>> +VERSION {
>>>> +        LINUX_2.6.29 {
>>>> +        global:
>>>> +                __kernel_gettimeofday;
>>>> +                __kernel_clock_gettime;
>>>> +                __kernel_clock_getres;
>>>> +                __kernel_getcpu;
>>>> +                __kernel_restart_syscall;
>>>
>>> Where is __kernel_restart_syscall defined?
>>
>> It isn't, and I guess isn't needed for qemu (we have QEMU_ERESTARTSYS).
>> I'm not sure why it's an exported symbol for the s390x vdso for the 
>> kernel, even if they do require some user-space code.
>>
>> Anyway, I'll remove the symbol here.
> 
> OK.
> 
> I dare to give:
> 
> Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> 
> But still I'm Cc'ing David / Thomas who better know s390x :)

Uh, oh, vdso ... I remember some dark magic here on the real kernels on 
s390x, involving access registers ... good that we don't need those here :-)

I quickly glanced through the code, and apart from the typo above, it looks 
good to me, so:

Acked-by: Thomas Huth <thuth@redhat.com>



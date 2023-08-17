Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A27DE77FB0D
	for <lists+qemu-devel@lfdr.de>; Thu, 17 Aug 2023 17:44:11 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qWfA9-0000UO-L7; Thu, 17 Aug 2023 11:43:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1qWfA7-0000U5-8l
 for qemu-devel@nongnu.org; Thu, 17 Aug 2023 11:43:51 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1qWfA5-0006bM-2P
 for qemu-devel@nongnu.org; Thu, 17 Aug 2023 11:43:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1692287027;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=kaSAzSzQGaVF2ImTtaYRWUdxji8rUTb1sARiLVrNFxM=;
 b=YSKzAoC09iAZhUNQ2fJ6GrRLRigaRNSKO0lcXtFwZ2LjK/B4y3sC+6kqDCJLCH7AJG5Sds
 3cEmLSE6Y0nKnXad8E15QEJWhxeXhUY3sBNZmEtlt6VTiu+la+9XuuCdrwF7VBzIC03Pi8
 ArAk7qJdMOAOTx+vGIgmU7iZUkNh3/A=
Received: from mail-lj1-f200.google.com (mail-lj1-f200.google.com
 [209.85.208.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-377-QAFLpCSsOS-yrAr8V8hkaw-1; Thu, 17 Aug 2023 11:43:46 -0400
X-MC-Unique: QAFLpCSsOS-yrAr8V8hkaw-1
Received: by mail-lj1-f200.google.com with SMTP id
 38308e7fff4ca-2b9ba3d6191so78776661fa.2
 for <qemu-devel@nongnu.org>; Thu, 17 Aug 2023 08:43:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692287025; x=1692891825;
 h=content-transfer-encoding:in-reply-to:subject:organization:from
 :references:cc:to:content-language:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=kaSAzSzQGaVF2ImTtaYRWUdxji8rUTb1sARiLVrNFxM=;
 b=Qw52t2nTybD0VqCn/QtTdFcc40+LQ7y1CWLTM7eEAjI9jgOIkpYzPyqbeZRmk9kbTs
 LhdKJCxT2pe0ZdYE6QVqastmfOk360jiGFby+rMpkBA5ystx2h0zcBVe5zZElzoNXzFz
 pBetCAdX8szJaLdFQVxz/jNoArLnjC1wX6lZR4pOqixad1sPnVYXET3P+2xhi6dKhXl6
 3XxObbxyGnndKli/zx37afEWeP3ZbfkzRvG4iyFM64Da01bUFewPkYS7YlNKWLiDqqs0
 gAKbLOs7uI6qN6Lm2KIt9bmy4WCS4e2yXvN0gk3P2ZwUOmGAwHIO62K4dqMkN+ezcPEU
 8oJw==
X-Gm-Message-State: AOJu0YwU5tnhj00xR2pnER0BDKXfGlfBb8wNKmqxGMCySBjVjLQJACVr
 7sOr4KPbmgIsIR7uif+svrhsY3h4fAy4eADgS0WvVyyGlCMuzXUCQQopaVQeW4tALsWK9Wv0niS
 paBtmypfD28S/alw=
X-Received: by 2002:a2e:94c2:0:b0:2b5:8a21:5627 with SMTP id
 r2-20020a2e94c2000000b002b58a215627mr4351061ljh.51.1692287024919; 
 Thu, 17 Aug 2023 08:43:44 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHmrAMHZH759yOwKeP0ybJvaEF0orR7mx7y61r0cOMlL7dx3Rn6gIXJUpOlhA7rOLabUxmQjA==
X-Received: by 2002:a2e:94c2:0:b0:2b5:8a21:5627 with SMTP id
 r2-20020a2e94c2000000b002b58a215627mr4351048ljh.51.1692287024478; 
 Thu, 17 Aug 2023 08:43:44 -0700 (PDT)
Received: from ?IPV6:2a09:80c0:192:0:5dac:bf3d:c41:c3e7?
 ([2a09:80c0:192:0:5dac:bf3d:c41:c3e7])
 by smtp.gmail.com with ESMTPSA id
 v10-20020a1cf70a000000b003fe29dc0ff2sm3413491wmh.21.2023.08.17.08.43.43
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 17 Aug 2023 08:43:43 -0700 (PDT)
Message-ID: <fdc69e34-2dc2-a4ae-53a4-e8cb7495a323@redhat.com>
Date: Thu, 17 Aug 2023 17:43:43 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Content-Language: en-US
To: Peter Xu <peterx@redhat.com>
Cc: Stefan Hajnoczi <stefanha@gmail.com>, ThinerLogoer
 <logoerthiner1@163.com>, "stefanha@redhat.com" <stefanha@redhat.com>,
 qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
References: <ZNOti1OKN79t68jP@x1n>
 <e9c53fbd-369c-2605-1470-e67a765f923b@redhat.com>
 <6152f171.6a4c.189e069baf7.Coremail.logoerthiner1@163.com>
 <ZNVVmxuQAsSEHqZq@x1n>
 <1b4168d2.4182.189e324e0ef.Coremail.logoerthiner1@163.com>
 <08cc9db9-b774-b027-58f5-dd7e6c374657@redhat.com>
 <2b967b3.13b7.189e82ee694.Coremail.logoerthiner1@163.com>
 <06f9a805-8150-8106-7d0a-05d0d2465cd0@redhat.com>
 <CAJSP0QVjxNQ=sMjzEFzbyhJ0e+O5bGBiXkHMgWiB2GOVw4NqHQ@mail.gmail.com>
 <9b2b884e-095c-7cd5-380b-b3b0c5aad9b6@redhat.com> <ZN49bPlANaNrgXCu@x1n>
From: David Hildenbrand <david@redhat.com>
Organization: Red Hat
Subject: Re: [PATCH v1 1/3] softmmu/physmem: fallback to opening guest RAM
 file as readonly in a MAP_PRIVATE mapping
In-Reply-To: <ZN49bPlANaNrgXCu@x1n>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=david@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -60
X-Spam_score: -6.1
X-Spam_bar: ------
X-Spam_report: (-6.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.021,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-4.01, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
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

On 17.08.23 17:31, Peter Xu wrote:
> On Thu, Aug 17, 2023 at 05:15:52PM +0200, David Hildenbrand wrote:
>>> I don't know how important that requirement was (that commit was a
>>> request from Kata Containers).
>>
>> Let me take a look if Kata passes "share=on,readonly=on" or
>> "share=off,readonly=off".
> 
> The question is whether it's good enough if we change the semantics as long
> as we guarantee the original purposes of when introducing those flags would
> be enough (nvdimm, kata, etc.), as anything introduced in qemu can
> potentially be used elsewhere too.
> 

Right. And we have to keep the R/O NVDIMM use case working as is apparently.

> David, could you share your concern on simply "having a new flag, while
> keeping all existing flags unchanged on behavior"?  You mentioned it's not
> wanted, but I didn't yet see the reason behind.

I'm really having a hard time to come up with something reasonable to 
configure this. And apparently, we only want to configure 
"share=off,readonly=on".

The best I was imagining was "readonly=file-only" but I'm also not too 
happy about that. Doesn't make any sense for "share=on".

So if we could just let the memory backend do something reasonable and 
have the single existing consumer (R/O NVDIMM) handle the changes case 
explicitly internally, that turns up much cleaner.

IMHO, the user shouldn't have to worry about "how is it mmaped". "share" 
and "readonly" express the memory semantics and the file semantics.

A R/O DIMM on the other hand (unarmed=on), knows that it is R/O, and the 
user configured exactly that. So maybe it can simply expose it to the 
system as readonly by marking the memory region container as being a ROM.

I have not given up yet, but this case is starting to be annoying.

-- 
Cheers,

David / dhildenb



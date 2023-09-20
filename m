Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 78AF47A8E5A
	for <lists+qemu-devel@lfdr.de>; Wed, 20 Sep 2023 23:24:58 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qj4fj-0002Jf-Kt; Wed, 20 Sep 2023 17:23:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qj4fh-0002JH-QN
 for qemu-devel@nongnu.org; Wed, 20 Sep 2023 17:23:45 -0400
Received: from mail-wr1-x435.google.com ([2a00:1450:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qj4ff-0003Qb-4z
 for qemu-devel@nongnu.org; Wed, 20 Sep 2023 17:23:44 -0400
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-31fe3426a61so264171f8f.1
 for <qemu-devel@nongnu.org>; Wed, 20 Sep 2023 14:23:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1695245021; x=1695849821; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
 :subject:cc:to:from:user-agent:references:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jE1QjtHsRPqPhV12sYXLQNPmnK1NQLYBG33rEB9KJX0=;
 b=raYHQOERg2L3xsGXrJRb3lRxYcWlHCT+C0JiV2YrAiIHYA5uVA3681VEzkx1TJz2Yr
 cxdHsnB7K1hCFKeNFJ8WkGueNgi4892LIJCzcdiF8z9xLxlLAc/C7Exw9xuq0+xsXzPh
 6gPZyjhwc7Xbw4dyEWFFQMTaa3KffF1weIvvrkzGGtNNIpdnULcwljJJ4UBBPUA5M/f3
 nQJB0cCa3ytOuUcxgecKu8vzoqCogkswDdgNvVg9NR8MDXeBZcIao7VBmg0xrYF+75eW
 wolmc63eVwj/viFB6NF7439xNuOobFYPcU3lEyTw7loSGlEYugxI8TRQRBsH66E7hMYy
 vaWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695245021; x=1695849821;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
 :subject:cc:to:from:user-agent:references:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=jE1QjtHsRPqPhV12sYXLQNPmnK1NQLYBG33rEB9KJX0=;
 b=HW9DiP+7pAwGXzsIXD0gr3ri5cbwykyI7LcAV5JMVkpBhLgePtZoTE4g88ezPwE4NE
 BwFuiYK8ZWKv+eAIQp/soPSch43Hamwngf91ofnyfuDqt9DvrvWSiho8BNkyBgmKLqiE
 WKiVh9zLEKpF1B+ft9i96aqEsiE890QE52IAnnXqNTzzfIXX+x4ZcUl7jMofoRu2FkoZ
 rYV/3qV/8t2jQxTpEMx7lXLhDp1x8n9x/6e+CRVpCZBjY8B0oXB+83woWrB1dbp9981a
 1+vQLn1xP57Gl1qdkKL9hWZb0sYdqfC/fmf6NHzlk92lsK1G0ctTPrccqzCgyt/WkebK
 yT9w==
X-Gm-Message-State: AOJu0Yyu+5P92pXYVJxW66gsm5Cj6bbeBsLUInNPqhA/xl65fRckHL4j
 7XkY6hiVjyUhltjJWxkTugF4AQ==
X-Google-Smtp-Source: AGHT+IE5AGgwP/NRREj1aocivwBmDJ3CvUyDWZZ4CX1fwgzRR25Mm52mE9HA9EpG9lqgViW8wjoUIg==
X-Received: by 2002:adf:f1cc:0:b0:316:efb9:ffa with SMTP id
 z12-20020adff1cc000000b00316efb90ffamr3474243wro.35.1695245021048; 
 Wed, 20 Sep 2023 14:23:41 -0700 (PDT)
Received: from zen.linaroharston ([85.9.250.243])
 by smtp.gmail.com with ESMTPSA id
 g14-20020a5d698e000000b0031759e6b43fsm19585395wru.39.2023.09.20.14.23.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 20 Sep 2023 14:23:40 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id EE38A1FFBB;
 Wed, 20 Sep 2023 10:34:01 +0100 (BST)
References: <qemu-stable-8.1.1-20230909131531@cover.tls.msk.ru>
 <20230909102747.346522-11-mjt@tls.msk.ru>
 <5a617673-efe0-18b9-e3db-88277b09ba52@tls.msk.ru>
User-agent: mu4e 1.11.20; emacs 29.1.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Michael Tokarev <mjt@tls.msk.ru>
Cc: qemu-devel@nongnu.org, qemu-stable@nongnu.org, Richard Henderson
 <richard.henderson@linaro.org>
Subject: Re: [Stable-8.1.1 11/34] softmmu: Assert data in bounds in
 iotlb_to_section
Date: Wed, 20 Sep 2023 10:23:28 +0100
In-reply-to: <5a617673-efe0-18b9-e3db-88277b09ba52@tls.msk.ru>
Message-ID: <87y1h1ur1y.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::435;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x435.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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


Michael Tokarev <mjt@tls.msk.ru> writes:

> 09.09.2023 13:27, Michael Tokarev wrote:
>> From: Richard Henderson <richard.henderson@linaro.org>
>> Acked-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
>> Suggested-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
>> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
>> (cherry picked from commit 86e4f93d827d3c1efd00cd8a906e38a2c0f2b5bc)
>> Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>
>> diff --git a/softmmu/physmem.c b/softmmu/physmem.c
>> index 3df73542e1..7597dc1c39 100644
>> --- a/softmmu/physmem.c
>> +++ b/softmmu/physmem.c
>> @@ -2413,9 +2413,15 @@ MemoryRegionSection *iotlb_to_section(CPUState *c=
pu,
>>       int asidx =3D cpu_asidx_from_attrs(cpu, attrs);
>>       CPUAddressSpace *cpuas =3D &cpu->cpu_ases[asidx];
>>       AddressSpaceDispatch *d =3D qatomic_rcu_read(&cpuas->memory_dispat=
ch);
>> -    MemoryRegionSection *sections =3D d->map.sections;
>> +    int section_index =3D index & ~TARGET_PAGE_MASK;
>> +    MemoryRegionSection *ret;
>> +
>> +    assert(section_index < d->map.sections_nb);
>
> This assert now triggers on staging-8.1
>
> https://ci.debian.net/data/autopkgtest/testing/amd64/d/dropbear/37993610/=
log.gz
> https://ci.debian.net/data/autopkgtest/testing/amd64/c/cryptsetup/3799360=
6/log.gz

The asserts are basically there to detect when we attempt to do a MR
lookup and it is not fully committed. If they are firing its because
things have gone wrong (which we know because we still have patches in
flight for the full fix).

The main benefit of the assert is we fail early rather than later on in
various cryptic ways (evidenced by the fact we raised 3 different bugs
which exhibited slightly different symptoms that where all fundamentally
caused by getting bogus memory region data).

>
>> +    ret =3D d->map.sections + section_index;
>> +    assert(ret->mr);
>> +    assert(ret->mr->ops);
>>   -    return &sections[index & ~TARGET_PAGE_MASK];
>> +    return ret;
>>   }
>>     static void io_mem_init(void)
>
> In this upload I removed softmmu-Use-async_run_on_cpu-in-tcg_commit.patch=
 (0d58c660689f6da1),
> and the test run uses tcg and -smp 4, which is the configuration which 0d=
58c6606
> was supposed to fix.
>
> qemu-system-x86_64 -no-user-config -nodefaults -name autopkgtest-cryptset=
up-cryptroot-sysvinit \
>  -machine type=3Dq35,graphics=3Doff -cpu qemu64,-svm,-vmx -smp cpus=3D4 -=
m size=3D2G \
>  -vga none -display none -object rng....
>
> I wonder if I should keep 0d58c6606 for 8.1.1 (the deadline is
> tomorrow)..

Unfortunately 0d58c is not the full fix, it papered over one crack but
revealed others. It might be leading to a false sense of security. So I
would argue:

  - keep the assert - better to fail early than to fail later in a hard
    to understand way
  - toss a coin for the 0d58c66 fix, if we include it we may end up
    reverting later once we have the "complete" fix but at least its
    slightly better for x86 while definitely breaking MIPS
=20=20=20=20
>
> Thanks,
>
> /mjt


--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro


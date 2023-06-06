Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B6DF9723C1C
	for <lists+qemu-devel@lfdr.de>; Tue,  6 Jun 2023 10:46:53 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q6SJh-0005Wt-FB; Tue, 06 Jun 2023 04:45:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1q6SJe-0005VD-IX
 for qemu-devel@nongnu.org; Tue, 06 Jun 2023 04:45:22 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1q6SJc-0001w1-7r
 for qemu-devel@nongnu.org; Tue, 06 Jun 2023 04:45:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1686041119;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=EZJvy0GduPFibgUgwRc55YnRG8yHGz1G7TW9PG7Y/w0=;
 b=ZoQoVwjS7sbbG20bpToQFlDzvJCAhF+N0NUGuCti5yTaAt1L8OUezJ2PSei187Bm6D9s6h
 wR9/LymQ3d4UvXl8vGODWzsy6C3ASGcSf5tsF+J2Vq+0IS7pRR2JPAvNUIBehWEYG2tgdZ
 eQaZKAJCTHWZkUpEGAjpGYQuQ4B0lVU=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-591-1Kh3f27WNPOPa4LcHEWlXg-1; Tue, 06 Jun 2023 04:45:16 -0400
X-MC-Unique: 1Kh3f27WNPOPa4LcHEWlXg-1
Received: by mail-ej1-f69.google.com with SMTP id
 a640c23a62f3a-97463348446so366061266b.2
 for <qemu-devel@nongnu.org>; Tue, 06 Jun 2023 01:45:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686041115; x=1688633115;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=EZJvy0GduPFibgUgwRc55YnRG8yHGz1G7TW9PG7Y/w0=;
 b=Qk1UJqXEJdiSJHyNnSzp4tBkJyHlTMJkCEVnh5HIBVmY0jrGbixfgoasXZ/25iR5vZ
 l5/qIDXtGkJ1ib8IdIkRbN6MzmTQOq0buCUpsZHjUIv+kQrwwfA6ifvND5OrhZOW1g+d
 epBCuHkeNWaTpx92Us8E7EqS8lAovHYJ0vQ/ZwIJE6UyvJyPb/k0hsgU7SYVjlXzQzwO
 xwnfw6FJ1I2UDxpY/N6SxihKDIeGkcUz93cBP33cmTm28weJMDIHiTZf1JUk/TCuOagS
 2WX2K0CFacRoPVTXvNpIQTB5FxxS0UGHGoxssqK/lBZQnIrPriVxs0h6JUGmqpMvmGT3
 /ftQ==
X-Gm-Message-State: AC+VfDzfA8CqnKLxGEe5cEcOaNFrwAIkK4zI4PYcgTl2h/3p1cPPqUMm
 4+VlmIcZSeIg3Ihk1RtQ71SOfNVLFdiG+pPdKgCQWbd/kyXVCzSJgMpa0i73P3k7Uk9c21u8P2B
 +VUkcSL9BZD98njA=
X-Received: by 2002:a17:907:968d:b0:973:8198:bbf7 with SMTP id
 hd13-20020a170907968d00b009738198bbf7mr1981446ejc.11.1686041115085; 
 Tue, 06 Jun 2023 01:45:15 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ7/aY/1QclUvammpDUgB97wyzBF26YfcgAdFTrLVlkJ5tZvKlgFDU93uSPUbFd8DFRRxOaXXA==
X-Received: by 2002:a17:907:968d:b0:973:8198:bbf7 with SMTP id
 hd13-20020a170907968d00b009738198bbf7mr1981428ejc.11.1686041114786; 
 Tue, 06 Jun 2023 01:45:14 -0700 (PDT)
Received: from ?IPV6:2003:cf:d740:9017:191d:265b:b68c:4fa4?
 (p200300cfd7409017191d265bb68c4fa4.dip0.t-ipconnect.de.
 [2003:cf:d740:9017:191d:265b:b68c:4fa4])
 by smtp.gmail.com with ESMTPSA id
 b13-20020a17090636cd00b00977eec5bb2csm1396765ejc.156.2023.06.06.01.45.13
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 06 Jun 2023 01:45:14 -0700 (PDT)
Message-ID: <8e681dcd-43ab-40ed-5e96-426557d87380@redhat.com>
Date: Tue, 6 Jun 2023 10:45:13 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PULL 02/17] block: Collapse padded I/O vecs exceeding IOV_MAX
To: Michael Tokarev <mjt@tls.msk.ru>, qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
References: <20230605154541.1043261-1-hreitz@redhat.com>
 <20230605154541.1043261-3-hreitz@redhat.com>
 <4604b88b-5499-9e60-2d25-63b93f0517f4@tls.msk.ru>
Content-Language: en-US
From: Hanna Czenczek <hreitz@redhat.com>
In-Reply-To: <4604b88b-5499-9e60-2d25-63b93f0517f4@tls.msk.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=hreitz@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.09, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

On 06.06.23 10:00, Michael Tokarev wrote:
> 05.06.2023 18:45, Hanna Czenczek wrote:
>> When processing vectored guest requests that are not aligned to the
>> storage request alignment, we pad them by adding head and/or tail
>> buffers for a read-modify-write cycle.
>>
>> The guest can submit I/O vectors up to IOV_MAX (1024) in length, but
>> with this padding, the vector can exceed that limit.  As of
>> 4c002cef0e9abe7135d7916c51abce47f7fc1ee2 ("util/iov: make
>> qemu_iovec_init_extended() honest"), we refuse to pad vectors beyond the
>> limit, instead returning an error to the guest.
>>
>> To the guest, this appears as a random I/O error.  We should not return
>> an I/O error to the guest when it issued a perfectly valid request.
>>
>> Before 4c002cef0e9abe7135d7916c51abce47f7fc1ee2, we just made the vector
>> longer than IOV_MAX, which generally seems to work (because the guest
>> assumes a smaller alignment than we really have, file-posix's
>> raw_co_prw() will generally see bdrv_qiov_is_aligned() return false, and
>> so emulate the request, so that the IOV_MAX does not matter). However,
>> that does not seem exactly great.
>
> Why it is not "exactly great"?  To me, it seems to be the best solution.
> I'd say we should be able to tolerate "slight" increase over IOV_MAX for
> "internal purposes", so to say.  We can limit guest-supplied vector to
> IOV_MAX, but internally guard against integer overflow only.

That’s a good point that may have been worth investigating.

I considered it not great because I assumed that that 
4c002cef0e9abe7135d7916c51abce47f7fc1ee2 was written with intent, i.e. 
that the IOV_MAX limit was put in because we just generally assume in 
the block layer that it isn’t exceeded.  It may have worked out fine 
before for one specific protocol driver (file-posix) most of the 
time[1], but I think it’s reasonable to assume that code in the block 
layer has generally been written under the assumption that vectors will 
not exceed the IOV_MAX limit (or otherwise we wouldn’t use that constant 
in the block layer).  So in addition to file-posix, we’d also need to 
inspect other code (like the blkio driver that will submit vectored 
requests to an external library) what the implications of exceeding that 
limit are in all places.

That is not to say that it might not have been the simpler solution to 
agree to exceed the limit internally, but it is to say that the full 
implications would need to be investigated first.  In contrast, the 
solution added here is more complicated in code, but is localized.

[1] It won’t be fine if all buffers are 4k in size and 4k-aligned, which 
I admit is unlikely for a request whose offset isn’t aligned, but which 
could happen with a partition that isn’t aligned to 4k.

>> I see two ways to fix this problem:
>> 1. We split such long requests into two requests.
>> 2. We join some elements of the vector into new buffers to make it
>>     shorter.
>
> This seems to be over-complicated, both of them, no?

I would have preferred to have this discussion while the patch was still 
on-list for review (this specific version was for two months, counting 
from the first version was three).  Do you think it is so complicated 
and thus bug-prone that we must revert this series now and try the other 
route?

I can agree that perhaps the other route could have been simpler, but 
now we already have patches that are reviewed and in master, which solve 
the problem.  So I won’t spend more time on tackling this issue from 
another angle.  If you are happy to do so, patches are always welcome.

Hanna



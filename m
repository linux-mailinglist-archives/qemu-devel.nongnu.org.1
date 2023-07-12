Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 267A8750B6C
	for <lists+qemu-devel@lfdr.de>; Wed, 12 Jul 2023 16:52:23 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qJbBV-00058w-Of; Wed, 12 Jul 2023 10:51:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1qJbBK-00058k-LH
 for qemu-devel@nongnu.org; Wed, 12 Jul 2023 10:51:06 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1qJbBI-0002Fe-M4
 for qemu-devel@nongnu.org; Wed, 12 Jul 2023 10:51:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1689173463;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=jWuQgMeX9PZ1RdlpShGfPLhThshDCKTC1G5pPOOHR28=;
 b=DNc2IKeg7vGcGmrDqAzSnKGpNW5QYvZGqcFc4bEhLFjgrosbWlpQJcSKgFttYpEzUc8vhy
 IxZ9gfGmfHrm7Y6KnuiS1jPLHroixDrD/vspKBmHoPBNMvcIiaFv1xl2SV3aAoqWu7h8oX
 k0AwfNjOfMPWFC3e9C6rnWq/xQt4L8w=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-10-YPYrP0PZP5W5PTELPwcoug-1; Wed, 12 Jul 2023 10:50:56 -0400
X-MC-Unique: YPYrP0PZP5W5PTELPwcoug-1
Received: by mail-ed1-f69.google.com with SMTP id
 4fb4d7f45d1cf-51e0fc38f16so4591401a12.2
 for <qemu-devel@nongnu.org>; Wed, 12 Jul 2023 07:50:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689173455; x=1691765455;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=jWuQgMeX9PZ1RdlpShGfPLhThshDCKTC1G5pPOOHR28=;
 b=RM2m8BpoCxRTwrtYR37snEn8wYzC8gg1IF8Z4IkYQ0UOn2ov8qf4buNsF8offlebQ2
 5KTUFggaMToGx8Hlusba3N7fgO+VXTl8zqJYEQynO44TEJPnrReOeIGEBCzuM6bF4dNA
 qa9IeRXkLi8nCBVtLzowTyM+0iJFF8hb35hxj6vL9kFnsyLLmcCrTlU0TfSJDBRdDjh7
 S9SC9e5gOHoflDbQG2mu2kB95nhOq4MlnqRycPzaB5QzuH3INL1v9NXzR2g92BevWvyV
 TkIRFrFtUu/MNNwPxrdqrnu+L1D59UfL8Gt8pXh3fMsH+PRLJyqWDKAlbB1N8MOaMjd6
 6qMA==
X-Gm-Message-State: ABy/qLZ8jrjYJfCvDOzNWYrrgBZeRvg164M5PelXQedz1fQEbrMoaCeB
 JNu9utb3O87ahMse/0q9/dCavS6ydKWsBj2eL20xbvZH4ltwh0R5AGnse/dQ3GEwyVRHFZwZdp0
 RgYwYUm+RmiE/e0o=
X-Received: by 2002:a50:eac5:0:b0:51e:fbe:dc81 with SMTP id
 u5-20020a50eac5000000b0051e0fbedc81mr18140315edp.3.1689173455497; 
 Wed, 12 Jul 2023 07:50:55 -0700 (PDT)
X-Google-Smtp-Source: APBJJlGZ0UZ9UABiwaf7IcQfVSe0IcXuomTRztHt95rKI2eBX9aMvD8MUEKzmMlqJD+jiwvHTBIAaA==
X-Received: by 2002:a50:eac5:0:b0:51e:fbe:dc81 with SMTP id
 u5-20020a50eac5000000b0051e0fbedc81mr18140292edp.3.1689173455165; 
 Wed, 12 Jul 2023 07:50:55 -0700 (PDT)
Received: from ?IPV6:2003:cf:d71a:f311:dd11:f574:b001:d931?
 (p200300cfd71af311dd11f574b001d931.dip0.t-ipconnect.de.
 [2003:cf:d71a:f311:dd11:f574:b001:d931])
 by smtp.gmail.com with ESMTPSA id
 h10-20020aa7c60a000000b0051bfb7de166sm2868787edq.39.2023.07.12.07.50.54
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 12 Jul 2023 07:50:54 -0700 (PDT)
Message-ID: <ee1afad7-daef-1217-fc2f-bd540f71e420@redhat.com>
Date: Wed, 12 Jul 2023 16:50:53 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH] block: Fix pad_request's request restriction
Content-Language: en-US
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org,
 Kevin Wolf <kwolf@redhat.com>, Peter Maydell <peter.maydell@linaro.org>
References: <20230609083316.24629-1-hreitz@redhat.com>
 <20230711202321.GB154686@fedora>
 <d4459ee1-bdea-bff0-ab99-b38de004c2a7@redhat.com>
 <20230712141535.GA215287@fedora>
From: Hanna Czenczek <hreitz@redhat.com>
In-Reply-To: <20230712141535.GA215287@fedora>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=hreitz@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.11, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On 12.07.23 16:15, Stefan Hajnoczi wrote:
> On Wed, Jul 12, 2023 at 09:41:05AM +0200, Hanna Czenczek wrote:
>> On 11.07.23 22:23, Stefan Hajnoczi wrote:
>>> On Fri, Jun 09, 2023 at 10:33:16AM +0200, Hanna Czenczek wrote:
>>>> bdrv_pad_request() relies on requests' lengths not to exceed SIZE_MAX,
>>>> which bdrv_check_qiov_request() does not guarantee.
>>>>
>>>> bdrv_check_request32() however will guarantee this, and both of
>>>> bdrv_pad_request()'s callers (bdrv_co_preadv_part() and
>>>> bdrv_co_pwritev_part()) already run it before calling
>>>> bdrv_pad_request().  Therefore, bdrv_pad_request() can safely call
>>>> bdrv_check_request32() without expecting error, too.
>>>>
>>>> There is one difference between bdrv_check_qiov_request() and
>>>> bdrv_check_request32(): The former takes an errp, the latter does not,
>>>> so we can no longer just pass &error_abort.  Instead, we need to check
>>>> the returned value.  While we do expect success (because the callers
>>>> have already run this function), an assert(ret == 0) is not much simpler
>>>> than just to return an error if it occurs, so let us handle errors by
>>>> returning them up the stack now.
>>> Is this patch intended to silence a Coverity warning or can this be
>>> triggered by a guest?
>> Neither.  There was a Coverity warning about the `assert(*bytes <=
>> SIZE_MAX)`, which is always true on 32-bit architectures. Regardless of
>> Coverity, Peter inquired how bdrv_check_qiov_request() would guarantee this
>> condition (as the comments I’ve put above the assertions say).  It doesn’t,
>> only bdrv_check_request32() does, which I was thinking of, and just confused
>> the two.
> It's unclear to me whether this patch silences a Coverity warning or
> not? You said "neither", but then you acknowledged there was a Coverity
> warning. Maybe "was" (past-tense) means something else already fixed it
> but I don't see any relevant commits in the git log.

There was and is no fix for the Coverity warning.  I have mentioned that 
warning because the question as to why the code uses 
bdrv_check_qiov_request() came in the context of discussing it 
(https://lists.nongnu.org/archive/html/qemu-devel/2023-06/msg01809.html).

I’m not planning on fixing the Coverity warning in the code. `assert(x 
<= SIZE_MAX)` to me is an absolutely reasonable piece of code, even if 
always true (on some platforms), in fact, I find it a good thing if 
asserted conditions are always true, not least because then the compiler 
can optimize them out.  I don’t think we should make it more complicated 
to make Coverity happier.

>> As the commit message says, all callers already run bdrv_check_request32(),
>> so I expect this change to functionally be a no-op.  (That is why the
>> pre-patch code runs bdrv_check_qiov_request() with `&error_abort`.)
> Okay, this means a guest cannot trigger the assertion failure.
>
> Please mention the intent in the commit description: a code cleanup
> requested by Peter and/or a Coverity warning fix, but definitely not
> guest triggerable assertion failure.

Sure!

>>> I find this commit description and patch confusing. Instead of checking
>>> the actual SIZE_MAX value that bdrv_pad_request() relies on, we use a
>>> 32-bit offsets/lengths helper because it checks INT_MAX or SIZE_MAX (but
>>> really INT_MAX, because that's always smaller on host architectures that
>>> QEMU supports).
>> I preferred to use a bounds-checking function that we already use for
>> requests, and that happens to be used to limit all I/O that ends up here in
>> bdrv_pad_request() anyway, instead of adding a new specific limit.
>>
>> It doesn’t matter to me, though.  The callers already ensure that everything
>> is in bounds, so I’d be happy with anything, ranging from keeping the bare
>> assertions with no checks beforehand, over specifically checking SIZE_MAX
>> and returning an error then, to bdrv_check_request32().
>>
>> (I thought repeating the simple bounds check that all callers already did
>> for verbosity would be the most robust and obvious way to do it, but now I’m
>> biting myself for not just using bare assertions annotated with “Caller must
>> guarantee this” from the start...)
> Okay. I looked at the code more and don't see a cleanup for the overall
> problem of duplicated checks and type mismatches (size_t vs int64_t)
> that is appropriate for this patch.
>
> I'm okay with this fix, but please clarify the intent as mentioned above.

I can’t quite fit these two paragraphs together.  It sounds like you 
would rather not duplicate the call to bdrv_check_request32() in 
bdrv_pad_request() and just defer to the callers on that one, and also 
address the Coverity warning in the code (instead of just ignoring it).  
So would you rather have me remove the bdrv_check_request32() and/or 
somehow address the Coverity report in the code?

Hanna



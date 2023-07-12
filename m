Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 86932750053
	for <lists+qemu-devel@lfdr.de>; Wed, 12 Jul 2023 09:43:06 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qJUTi-0000vJ-V4; Wed, 12 Jul 2023 03:41:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1qJUTN-0000W3-0e
 for qemu-devel@nongnu.org; Wed, 12 Jul 2023 03:41:17 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1qJUTH-0007L5-IW
 for qemu-devel@nongnu.org; Wed, 12 Jul 2023 03:41:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1689147670;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=plTMktnacQAZ98RQzgRrfBuf/Ry3aPDrmwkG+F2ozyg=;
 b=c6kkNLahrn+oOrMyA4tjdXIFtrMKDNKGiVjvFZYw6KRBmGcku21Cwfi9tCX3jFucgj+FEH
 zG5u+XHZ8zJX+useCkaZugklPPPem3ZCJEQHWDig0hLzv3XjdHflRV6MIa1s2Ey/jzD+0Q
 ZpzinoOB+xN63nNcBBeSjhfw3Y+kKY0=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-288-eBNjCmMnPMOrUzxi-8T4lw-1; Wed, 12 Jul 2023 03:41:08 -0400
X-MC-Unique: eBNjCmMnPMOrUzxi-8T4lw-1
Received: by mail-ej1-f70.google.com with SMTP id
 a640c23a62f3a-9932bf9a1e8so416430966b.0
 for <qemu-devel@nongnu.org>; Wed, 12 Jul 2023 00:41:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689147667; x=1691739667;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=plTMktnacQAZ98RQzgRrfBuf/Ry3aPDrmwkG+F2ozyg=;
 b=bRMLd51rkD46kDUvUwNV96ZhEFoiUGpbH86IR3KI/OlUNdlds6QmrEhess0VnvgcPp
 jZkYuIja/Ao1WhrNkCnEmKQGBE4iSnSb8tOBRkYILhSGYgUAT4ZKpReAL3b4MIkBK9Bj
 XuDmbiddj822X4PyCl5qTq+YaA5fwUQha4rC0Z8juU08Zk4C/wOPkpQCkpp4k78ZJkJ+
 uvS8VHIEEbqEh4Z/7W/NCF8t1ADFqcrWLgTq2lL0Kb+4/znkeWWuGHWxJ3fNX7MvvEbg
 59kGWrBbwf2MovZGdKxmw+L0hrN6Lk2kOdAXY9GBkV8s0SCkg1SqSQTlhl0N619A97o3
 7dtQ==
X-Gm-Message-State: ABy/qLbUOzcYcsn9nKM1FuOPBojR3UM3yHI1NJ2yhBhjpd2ph0P/YBoW
 UzwfDi85OMZwRPWEhUswc/PApokSWzd5ZregHWmPH7H1/+de+DX3BNT4bxvU6mV4jSlC/u9upaI
 BmlCmoDS6Tle7aRc=
X-Received: by 2002:a17:907:9485:b0:992:d337:6e44 with SMTP id
 dm5-20020a170907948500b00992d3376e44mr20308409ejc.58.1689147667652; 
 Wed, 12 Jul 2023 00:41:07 -0700 (PDT)
X-Google-Smtp-Source: APBJJlEsTbDmyFG9Qsg79b+NgNfB3yGbGMjkTLIRKxQmyq02DeGzR6DCicm6T95LrrrOz9tc4go9wA==
X-Received: by 2002:a17:907:9485:b0:992:d337:6e44 with SMTP id
 dm5-20020a170907948500b00992d3376e44mr20308386ejc.58.1689147667242; 
 Wed, 12 Jul 2023 00:41:07 -0700 (PDT)
Received: from ?IPV6:2003:cf:d71a:f311:dd11:f574:b001:d931?
 (p200300cfd71af311dd11f574b001d931.dip0.t-ipconnect.de.
 [2003:cf:d71a:f311:dd11:f574:b001:d931])
 by smtp.gmail.com with ESMTPSA id
 f18-20020a170906139200b009883a3edcfcsm2194975ejc.171.2023.07.12.00.41.06
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 12 Jul 2023 00:41:06 -0700 (PDT)
Message-ID: <d4459ee1-bdea-bff0-ab99-b38de004c2a7@redhat.com>
Date: Wed, 12 Jul 2023 09:41:05 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH] block: Fix pad_request's request restriction
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org,
 Kevin Wolf <kwolf@redhat.com>, Peter Maydell <peter.maydell@linaro.org>
References: <20230609083316.24629-1-hreitz@redhat.com>
 <20230711202321.GB154686@fedora>
Content-Language: en-US
From: Hanna Czenczek <hreitz@redhat.com>
In-Reply-To: <20230711202321.GB154686@fedora>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=hreitz@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, NICE_REPLY_A=-0.089, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

On 11.07.23 22:23, Stefan Hajnoczi wrote:
> On Fri, Jun 09, 2023 at 10:33:16AM +0200, Hanna Czenczek wrote:
>> bdrv_pad_request() relies on requests' lengths not to exceed SIZE_MAX,
>> which bdrv_check_qiov_request() does not guarantee.
>>
>> bdrv_check_request32() however will guarantee this, and both of
>> bdrv_pad_request()'s callers (bdrv_co_preadv_part() and
>> bdrv_co_pwritev_part()) already run it before calling
>> bdrv_pad_request().  Therefore, bdrv_pad_request() can safely call
>> bdrv_check_request32() without expecting error, too.
>>
>> There is one difference between bdrv_check_qiov_request() and
>> bdrv_check_request32(): The former takes an errp, the latter does not,
>> so we can no longer just pass &error_abort.  Instead, we need to check
>> the returned value.  While we do expect success (because the callers
>> have already run this function), an assert(ret == 0) is not much simpler
>> than just to return an error if it occurs, so let us handle errors by
>> returning them up the stack now.
> Is this patch intended to silence a Coverity warning or can this be
> triggered by a guest?

Neither.  There was a Coverity warning about the `assert(*bytes <= 
SIZE_MAX)`, which is always true on 32-bit architectures. Regardless of 
Coverity, Peter inquired how bdrv_check_qiov_request() would guarantee 
this condition (as the comments I’ve put above the assertions say).  It 
doesn’t, only bdrv_check_request32() does, which I was thinking of, and 
just confused the two.

As the commit message says, all callers already run 
bdrv_check_request32(), so I expect this change to functionally be a 
no-op.  (That is why the pre-patch code runs bdrv_check_qiov_request() 
with `&error_abort`.)

> I find this commit description and patch confusing. Instead of checking
> the actual SIZE_MAX value that bdrv_pad_request() relies on, we use a
> 32-bit offsets/lengths helper because it checks INT_MAX or SIZE_MAX (but
> really INT_MAX, because that's always smaller on host architectures that
> QEMU supports).

I preferred to use a bounds-checking function that we already use for 
requests, and that happens to be used to limit all I/O that ends up here 
in bdrv_pad_request() anyway, instead of adding a new specific limit.

It doesn’t matter to me, though.  The callers already ensure that 
everything is in bounds, so I’d be happy with anything, ranging from 
keeping the bare assertions with no checks beforehand, over specifically 
checking SIZE_MAX and returning an error then, to bdrv_check_request32().

(I thought repeating the simple bounds check that all callers already 
did for verbosity would be the most robust and obvious way to do it, but 
now I’m biting myself for not just using bare assertions annotated with 
“Caller must guarantee this” from the start...)

Hanna

> Vladimir: Is this the intended use of bdrv_check_request32()?
>
>> Reported-by: Peter Maydell <peter.maydell@linaro.org>
>> Fixes: 18743311b829cafc1737a5f20bc3248d5f91ee2a
>>         ("block: Collapse padded I/O vecs exceeding IOV_MAX")
>> Signed-off-by: Hanna Czenczek <hreitz@redhat.com>
>> ---
>>   block/io.c | 8 ++++++--
>>   1 file changed, 6 insertions(+), 2 deletions(-)
>> diff --git a/block/io.c b/block/io.c
>> index 30748f0b59..e43b4ad09b 100644
>> --- a/block/io.c
>> +++ b/block/io.c
>> @@ -1710,7 +1710,11 @@ static int bdrv_pad_request(BlockDriverState *bs,
>>       int sliced_niov;
>>       size_t sliced_head, sliced_tail;
>>   
>> -    bdrv_check_qiov_request(*offset, *bytes, *qiov, *qiov_offset, &error_abort);
>> +    /* Should have been checked by the caller already */
>> +    ret = bdrv_check_request32(*offset, *bytes, *qiov, *qiov_offset);
>> +    if (ret < 0) {
>> +        return ret;
>> +    }
>>   
>>       if (!bdrv_init_padding(bs, *offset, *bytes, write, pad)) {
>>           if (padded) {
>> @@ -1723,7 +1727,7 @@ static int bdrv_pad_request(BlockDriverState *bs,
>>                                     &sliced_head, &sliced_tail,
>>                                     &sliced_niov);
>>   
>> -    /* Guaranteed by bdrv_check_qiov_request() */
>> +    /* Guaranteed by bdrv_check_request32() */
>>       assert(*bytes <= SIZE_MAX);
>>       ret = bdrv_create_padded_qiov(bs, pad, sliced_iov, sliced_niov,
>>                                     sliced_head, *bytes);
>> -- 
>> 2.40.1
>>



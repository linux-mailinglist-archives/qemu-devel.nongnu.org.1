Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DD71F7919A6
	for <lists+qemu-devel@lfdr.de>; Mon,  4 Sep 2023 16:28:48 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qdAYR-0006pE-OE; Mon, 04 Sep 2023 10:27:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qdAYP-0006ob-M6
 for qemu-devel@nongnu.org; Mon, 04 Sep 2023 10:27:49 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qdAYN-0006aa-7O
 for qemu-devel@nongnu.org; Mon, 04 Sep 2023 10:27:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1693837665;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=QdAc4uKgLaMZh3ZWems8sQk3G22S3TZNm5uneNKwVHM=;
 b=Wk5Q6qTPyfWOLeo8vq9Rw12SoVECVJpvCJ8WyIPdgANA0l1MlZygNID+qBcpE+8uKjBds0
 qsblWWokBocnnBZNySgFv4wZvFJZke9WO2N385XFAJF9SCm4/wFaj9fMFekTxd1EXYBV53
 UrGMNYie1RDS9fMZideOtrGaEdQ9F3U=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-139-gIsR1AOgOJ6Hs8rttxbMMA-1; Mon, 04 Sep 2023 10:27:43 -0400
X-MC-Unique: gIsR1AOgOJ6Hs8rttxbMMA-1
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-401e521122fso10766645e9.3
 for <qemu-devel@nongnu.org>; Mon, 04 Sep 2023 07:27:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693837663; x=1694442463;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=QdAc4uKgLaMZh3ZWems8sQk3G22S3TZNm5uneNKwVHM=;
 b=L9c+0E7kP84KCf8TCSxjc+GCK3BM2mSK2o88YwKHaE/7KRUYzGKTMwWxQ3PVrzlT+g
 mTd+Q988TbjaAyQfAOUPXaK1poUsz6kirVr4dy1u8Poq8Mm37mt38UMPB8zlYtH52pKZ
 Fq8QL63G1k7mpXwH5pxu589NTjSk0z6f+xw6YO/DUE9vJAL4ReB/usnpS0UsqoAHoaD0
 rAKiZ83+A3ogiITbRfF4N5pKTn4mWFR4JOA11Anx5Xa95zcy7WBG2MvXYbY71femE2wP
 KKqtdKpYMDYI8AfIphLCgNFD6Yj/dOE9sPVkd5uE7vW8tbk9JSi00tB3qmCmOyDEVUvp
 KE1Q==
X-Gm-Message-State: AOJu0YxBh+G/gBOVaQzuk8LMeyVpDZARuvLCCryp/QE/q6rz2qo9d0p0
 Syh4wxsHmygp6j8miF40002zKncB92ijZQuLYT149g7aYltNTLwdsgYgz8HOcdc68+iU1/RUi15
 a1H6PTpacHgERskc=
X-Received: by 2002:a05:600c:2256:b0:401:daf2:2737 with SMTP id
 a22-20020a05600c225600b00401daf22737mr8131805wmm.30.1693837662837; 
 Mon, 04 Sep 2023 07:27:42 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEqY4K7+TpNep+r0vUiFfk9+BpSZaaoLS22uAjg5uNqWjX0Pw2sQexfVpvkdyQlJ7zAzFZMLg==
X-Received: by 2002:a05:600c:2256:b0:401:daf2:2737 with SMTP id
 a22-20020a05600c225600b00401daf22737mr8131791wmm.30.1693837662470; 
 Mon, 04 Sep 2023 07:27:42 -0700 (PDT)
Received: from [10.33.192.199] (nat-pool-str-t.redhat.com. [149.14.88.106])
 by smtp.gmail.com with ESMTPSA id
 a22-20020a05600c225600b003fefcbe7fa8sm14275744wmm.28.2023.09.04.07.27.41
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 04 Sep 2023 07:27:41 -0700 (PDT)
Message-ID: <45de8d05-0bd8-3de1-245f-e9f5963586d2@redhat.com>
Date: Mon, 4 Sep 2023 16:27:41 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [risu PATCH 1/4] s390x: Add basic s390x support to the C code
Content-Language: en-US
To: Ilya Leoshkevich <iii@linux.ibm.com>,
 Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-s390x@nongnu.org, qemu-devel@nongnu.org,
 Richard Henderson <richard.henderson@linaro.org>,
 David Hildenbrand <david@redhat.com>
References: <20230904140040.33153-1-thuth@redhat.com>
 <20230904140040.33153-2-thuth@redhat.com>
 <cb8382fe4209c8ebe15f4d2b189ca77e20586ee8.camel@linux.ibm.com>
From: Thomas Huth <thuth@redhat.com>
In-Reply-To: <cb8382fe4209c8ebe15f4d2b189ca77e20586ee8.camel@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-1.473, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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

On 04/09/2023 16.19, Ilya Leoshkevich wrote:
> On Mon, 2023-09-04 at 16:00 +0200, Thomas Huth wrote:
>> With these changes, it is now possible to compile the "risu" binary
>> for s390x hosts.
>>
>> Signed-off-by: Thomas Huth <thuth@redhat.com>
>> ---
>>   risu_reginfo_s390x.c | 142
>> +++++++++++++++++++++++++++++++++++++++++++
>>   risu_reginfo_s390x.h |  23 +++++++
>>   risu_s390x.c         |  48 +++++++++++++++
>>   test_s390x.S         |  32 ++++++++++
>>   4 files changed, 245 insertions(+)
>>   create mode 100644 risu_reginfo_s390x.c
>>   create mode 100644 risu_reginfo_s390x.h
>>   create mode 100644 risu_s390x.c
>>   create mode 100644 test_s390x.S
> 
> Looks really interesting! I was doing similar qemu-system-s390x testing
> with a bunch of ad-hoc scripts, and there are quite a few unresolved
> problems still, especially in the error handling area.
> 
> Acked-by: Ilya Leoshkevich <iii@linux.ibm.com>
> 
> I have one small question (see below).
> 
> [...]
> 
>> +/* reginfo_is_eq: compare the reginfo structs, returns nonzero if
>> equal */
>> +int reginfo_is_eq(struct reginfo *m, struct reginfo *a)
>> +{
>> +    int i;
>> +
>> +    if (m->psw_mask != a->psw_mask || m->psw_addr != a->psw_addr) {
>> +        return 0;
>> +    }
>> +
>> +    /* Skip return address register and stack register for
>> comparison */
> 
> Is this because of ASLR? In this case, would it be possible to build a
> non-PIE binary and switch to a private stack at the beginning? This
> could be useful for the other architectures as well.

Ah, no, it's not due to ASLR ... I just experienced some crashes during 
development and saw that other targets like m68k skip the stack pointer 
here, too, so I did it the same way on s390x.
(But I finally discovered that the crashes were due to other reasons that I 
then fixed)

Looking through the code, it seems like there is already support for an 
alternate signal handler stack:

 
https://git.linaro.org/people/peter.maydell/risu.git/commit/?id=ad82a069e8d6a21842bbb265

... maybe it's working on s390x, too ... I'll give it a try.

  Thomas



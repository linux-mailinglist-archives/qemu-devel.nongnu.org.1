Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 828997591E1
	for <lists+qemu-devel@lfdr.de>; Wed, 19 Jul 2023 11:45:22 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qM3j8-0001UT-3L; Wed, 19 Jul 2023 05:44:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1qM3j5-0001Sj-0A
 for qemu-devel@nongnu.org; Wed, 19 Jul 2023 05:44:07 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1qM3j3-0002L9-Az
 for qemu-devel@nongnu.org; Wed, 19 Jul 2023 05:44:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1689759844;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=nrwyzvJRwSvXxBmVWFcJhUhvAwlq1g8WHHgumJIpogI=;
 b=W8ssU1d0VkHv/Lqsq3PqYbjSFhQbNKZb75zd6rOEduP7a5OGPFMWb78JTADGRPoAWSRBKu
 /ef0R9pvvnOwynAuXkxf5cTPJ1VGnRi7aleSNFGoazKF30W6loscBYx+kvfZsxRIFmrtVI
 zjHm2Y2XuGGchnCkTcXTgGx37lA6CrI=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-379-sP2RFBtaPS6t9QTJcBKq5w-1; Wed, 19 Jul 2023 05:44:02 -0400
X-MC-Unique: sP2RFBtaPS6t9QTJcBKq5w-1
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-3fbab56aac7so35395575e9.1
 for <qemu-devel@nongnu.org>; Wed, 19 Jul 2023 02:44:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689759841; x=1692351841;
 h=content-transfer-encoding:in-reply-to:organization:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=nrwyzvJRwSvXxBmVWFcJhUhvAwlq1g8WHHgumJIpogI=;
 b=aDdHOrhiEXsl8TK8+zRaJb3EMD8U6LYQCeibcW0CN5n0e5U81ul7HJMQ11E+fgMm6Y
 KsFf2s7KedWx5++FiNjUOxzx5FSSK3jgbRLGoalI7OJzvaPGG1UUi9VfW5k4NSS82BGp
 eaLI0VusgjbiI2K2lQ8+UefMbVPJrypJOEkCoQ6Wp40bv7BXVpAZ7J1DGMTAsICFG/o6
 IoVSy3FiKMz7rvoKATTOBMxBYWOr8N5to+DM4Cf6jKNYsQDopu/AezStUtWF/awSKxyA
 iUWIb7kh+h8PUhqCGVpRTTdP+b4ADgop7UTEx5QHz9p0Omc+wzPndeTMQRe93NGxeXOO
 d/CQ==
X-Gm-Message-State: ABy/qLaY3Nvu92/zilvV9Xu5/SHJj2B+ypenFV/C+t6fW6lob62ptXzI
 bM2A9omyRC6OOkg5NybKIf3keeopX7FX93rYPEBNxkp6pFiosZHoym0HMTDD9bE5poMsLXsYAhd
 jVnhMqNBs8xK4ZGo=
X-Received: by 2002:a7b:cbd6:0:b0:3fd:45b:45f8 with SMTP id
 n22-20020a7bcbd6000000b003fd045b45f8mr796147wmi.23.1689759841622; 
 Wed, 19 Jul 2023 02:44:01 -0700 (PDT)
X-Google-Smtp-Source: APBJJlHM0hQd9xD+1M6EtRH5v19DDjksoqx/nRDFYe6dsIjzn5SBON4ZkXbBNyEfcLI8d3POgEEzQQ==
X-Received: by 2002:a7b:cbd6:0:b0:3fd:45b:45f8 with SMTP id
 n22-20020a7bcbd6000000b003fd045b45f8mr796118wmi.23.1689759841192; 
 Wed, 19 Jul 2023 02:44:01 -0700 (PDT)
Received: from ?IPV6:2003:cb:c74b:4f00:b030:1632:49f2:63?
 (p200300cbc74b4f00b030163249f20063.dip0.t-ipconnect.de.
 [2003:cb:c74b:4f00:b030:1632:49f2:63])
 by smtp.gmail.com with ESMTPSA id
 n23-20020a7bc5d7000000b003fc06169abdsm1295631wmk.2.2023.07.19.02.44.00
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 19 Jul 2023 02:44:00 -0700 (PDT)
Message-ID: <2b1fa095-e5f0-9811-fa22-00fb4f85ae74@redhat.com>
Date: Wed, 19 Jul 2023 11:44:00 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH 07/14] target/s390x: Fix assertion failure in VFMIN/VFMAX
 with reserved type
Content-Language: en-US
To: Ilya Leoshkevich <iii@linux.ibm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Thomas Huth <thuth@redhat.com>
Cc: qemu-s390x@nongnu.org, qemu-devel@nongnu.org, qemu-stable@nongnu.org
References: <20230718213531.117976-1-iii@linux.ibm.com>
 <20230718213531.117976-8-iii@linux.ibm.com>
 <581f6cc6-befb-4c6e-8ed6-191429d9be1c@redhat.com>
 <42c07b30625903256e3448a621ab58a06fcc7ad3.camel@linux.ibm.com>
From: David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <42c07b30625903256e3448a621ab58a06fcc7ad3.camel@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=david@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.095, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On 19.07.23 11:34, Ilya Leoshkevich wrote:
> On Wed, 2023-07-19 at 10:40 +0200, David Hildenbrand wrote:
>> On 18.07.23 23:21, Ilya Leoshkevich wrote:
>>> Passing reserved type to VFMIN/VFMAX causes an assertion failure in
>>> vfmin_res() and vfmax_res(). These instructions should raise a
>>> specification exception in this case.
>>>
>>> Cc: qemu-stable@nongnu.org
>>> Fixes: da4807527f3b ("s390x/tcg: Implement VECTOR FP
>>> (MAXIMUM|MINIMUM)")
>>> Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
>>> ---
>>>    target/s390x/tcg/vec_fpu_helper.c | 24 +++++++++++++++---------
>>>    1 file changed, 15 insertions(+), 9 deletions(-)
>>>
>>> diff --git a/target/s390x/tcg/vec_fpu_helper.c
>>> b/target/s390x/tcg/vec_fpu_helper.c
>>> index 75cf605b9f4..f1671679879 100644
>>> --- a/target/s390x/tcg/vec_fpu_helper.c
>>> +++ b/target/s390x/tcg/vec_fpu_helper.c
>>> @@ -915,7 +915,7 @@ static void vfminmax32(S390Vector *v1, const
>>> S390Vector *v2,
>>>            float32 b = s390_vec_read_float32(v3, i);
>>>            float32 result;
>>>    
>>
>> Why not check for invalid types once first and leave the rest of that
>> function alone?
>>
>> diff --git a/target/s390x/tcg/vec_fpu_helper.c
>> b/target/s390x/tcg/vec_fpu_helper.c
>> index 75cf605b9f..e0b2a78632 100644
>> --- a/target/s390x/tcg/vec_fpu_helper.c
>> +++ b/target/s390x/tcg/vec_fpu_helper.c
>> @@ -910,6 +910,11 @@ static void vfminmax32(S390Vector *v1, const
>> S390Vector *v2,
>>        S390Vector tmp = {};
>>        int i;
>>    
>> +    if (type > S390_MINMAX_TYPE_F) {
>> +        tcg_s390_program_interrupt(env, PGM_SPECIFICATION, retaddr);
>> +    }
>> +
>>        for (i = 0; i < 4; i++) {
>>            float32 a = s390_vec_read_float32(v2, i);
>>            float32 b = s390_vec_read_float32(v3, i);
>>
> 
> I have taken another look, and turns out there already is:
> 
> static DisasJumpType op_vfmax(DisasContext *s, DisasOps *o)
> {
>      ...
> 
>      if (m6 == 5 || m6 == 6 || m6 == 7 || m6 > 13) {
>          gen_program_exception(s, PGM_SPECIFICATION);
>          return DISAS_NORETURN;
>      }
> 
> What the fuzzer has found was the m6 == 13 case, so only a small
> adjustment is needed.
> 

Oh, good!

-- 
Cheers,

David / dhildenb



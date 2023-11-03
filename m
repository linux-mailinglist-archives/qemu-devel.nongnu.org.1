Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FEC37E0729
	for <lists+qemu-devel@lfdr.de>; Fri,  3 Nov 2023 18:04:20 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qyxZ9-0006Mc-GH; Fri, 03 Nov 2023 13:02:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1qyxZ7-0006Lo-A1
 for qemu-devel@nongnu.org; Fri, 03 Nov 2023 13:02:37 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1qyxZ5-0003CJ-Pi
 for qemu-devel@nongnu.org; Fri, 03 Nov 2023 13:02:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1699030954;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=BM8H5EtSaEzwBZXB000m1kpg6iKU5Vd7yf7vUO5C4cw=;
 b=MDdekmQFQKzsLK1oum42n+VqV5QpTvUNNkEH27g8npzK/j4vpV9JDeI2dPv2ewsnqC5kTj
 X29lm4mQViaJVFF5SqssJF/Ekqv3iPde33kjD6oQ8VLIiAS5cxL4oHXoB18czk9ZuO+QUv
 szoxhrSgFsT6/hj3QSBqYwVEYqWAsSM=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-671-RTTiWuz8Mu-WFipb2J2bdw-1; Fri, 03 Nov 2023 13:02:31 -0400
X-MC-Unique: RTTiWuz8Mu-WFipb2J2bdw-1
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-32fa25668acso1050188f8f.1
 for <qemu-devel@nongnu.org>; Fri, 03 Nov 2023 10:02:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699030950; x=1699635750;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
 :references:cc:to:content-language:subject:user-agent:mime-version
 :date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BM8H5EtSaEzwBZXB000m1kpg6iKU5Vd7yf7vUO5C4cw=;
 b=GtymqG2QIFodyXa/5M3Ymh4gUF2ddc92Xu44MHDoSX0BJ3wbPBMU3cmZZwIXvzpHuk
 8LL4RHrRxPPg2LsC8EiGWPiF9iv9KJ0cRI7xcRut8o8XAISID+t/KXzZYGQSPhZytpsD
 z5MRbt4JnC46Bw7SDV3hMS57NUzcz7BbzbpjfzYtWaQVQmH3OyrA5hZGFMks5g4FFkQG
 CBVCoVrXcw6bhv9O8g0LRy8BWQraKll8JmdC1Xfw0gkdk0cBEhhjF8bTdNd9ExMlC0g6
 90FhfS57iAemvyCH7+xR8b0vuiuluDuZd0qDNnrFiSXeW9473AmQ7XpnSP2OjkRdKoM2
 f7bg==
X-Gm-Message-State: AOJu0YyBK7QFXgDKZLnnEEGGzQJYxMbxiI5ECNQ64QWSfZORG+sFsk5D
 dMtch9JZpV7tOtiMxcyYR7Pg0sDn+YqXIH+F+1btoq4751WoD+BEi4zT7Y38OvHeVxr2uFHDJW4
 U0h+4F/EMErUFEro=
X-Received: by 2002:a5d:4b12:0:b0:32d:a0f7:40cc with SMTP id
 v18-20020a5d4b12000000b0032da0f740ccmr15567793wrq.68.1699030949830; 
 Fri, 03 Nov 2023 10:02:29 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHkicQp3QPnewHgMFDFfRMWM6eHzeOuw9JVwC4tvnRXz2N6OANdnhnHw4BSKhWfxvY0wWqgVg==
X-Received: by 2002:a5d:4b12:0:b0:32d:a0f7:40cc with SMTP id
 v18-20020a5d4b12000000b0032da0f740ccmr15567770wrq.68.1699030949384; 
 Fri, 03 Nov 2023 10:02:29 -0700 (PDT)
Received: from ?IPV6:2003:cb:c70a:a600:bc48:cd31:d01f:f468?
 (p200300cbc70aa600bc48cd31d01ff468.dip0.t-ipconnect.de.
 [2003:cb:c70a:a600:bc48:cd31:d01f:f468])
 by smtp.gmail.com with ESMTPSA id
 s6-20020a5d4ec6000000b0032f79e55eb8sm2296752wrv.16.2023.11.03.10.02.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 03 Nov 2023 10:02:28 -0700 (PDT)
Message-ID: <84b89d5d-96f5-45ab-b38a-be6699cc5260@redhat.com>
Date: Fri, 3 Nov 2023 18:02:27 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/4] target/s390x: CC fixes
Content-Language: en-US
To: Ilya Leoshkevich <iii@linux.ibm.com>,
 Richard Henderson <richard.henderson@linaro.org>
Cc: Thomas Huth <thuth@redhat.com>, qemu-s390x@nongnu.org,
 qemu-devel@nongnu.org, Michael Tokarev <mjt@tls.msk.ru>
References: <20231031053718.347100-1-iii@linux.ibm.com>
 <a7d962b5-d9d2-41f6-9f28-b84490cad0f8@redhat.com>
 <cbbffb85272fab70d1051d98ce024031215afe6e.camel@linux.ibm.com>
From: David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <cbbffb85272fab70d1051d98ce024031215afe6e.camel@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=david@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.47,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On 03.11.23 17:44, Ilya Leoshkevich wrote:
> On Tue, 2023-10-31 at 09:38 +0100, David Hildenbrand wrote:
>> On 31.10.23 06:32, Ilya Leoshkevich wrote:
>>> Hi,
>>>
>>> This series fixes two issues with updating CC. David was suggesting
>>> a
>>> bigger rewrite [1], but I did not dare do this (yet). Instead,
>>> these
>>
>> I started coding that up but was distracted by other things; last
>> time I
>> looked at that, I concluded that the way we are calculating the carry
>> in
>> not suitable when we're doing two additions (like ADD LOGICAL WITH
>> CARRY).
> 
> Do you per chance remember any details? IIUC the code in question is:

Unfortunately, I don't. I thought there would be a case where we could 
overflow twice, and result in a carry value of 2. Or some other weird 
corner case where the result would not be expressive.

Maybe I was daydreaming, let me see if I can re-discover what I found 
(should have taken notes but was just briefly looking at this).

If not, your fixes might be just good enough.

-- 
Cheers,

David / dhildenb



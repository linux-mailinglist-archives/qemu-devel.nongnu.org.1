Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E320EA45737
	for <lists+qemu-devel@lfdr.de>; Wed, 26 Feb 2025 08:55:17 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tnCFW-0005q8-T8; Wed, 26 Feb 2025 02:54:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1tnCFU-0005pF-KL
 for qemu-devel@nongnu.org; Wed, 26 Feb 2025 02:54:32 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1tnCFS-0006me-Ux
 for qemu-devel@nongnu.org; Wed, 26 Feb 2025 02:54:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1740556469;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=V8zDlKlzLN/PdVYfjlCqH1UzYBf6b17ENTGJMZ7XSg8=;
 b=XfBQxs3uaMqXfEj5eFUyMs39ocHP1sGERKmzSAVEoXQ44ik4RN/CLwt2E1ANoi6+botlDa
 xVf7LFkCPK+DZ3LrM8vpPBlGfSFNR2OZFA5Owp2OVcBSyFieIfusVlq6qtT2TH4BY+5hWn
 TETT2aa1U0MxjAlHQb1zoC5yQxEtB7o=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-654-fPJx5KbLN6qTQTJAXVOE4Q-1; Wed, 26 Feb 2025 02:54:27 -0500
X-MC-Unique: fPJx5KbLN6qTQTJAXVOE4Q-1
X-Mimecast-MFC-AGG-ID: fPJx5KbLN6qTQTJAXVOE4Q_1740556466
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-4393e89e910so35064985e9.0
 for <qemu-devel@nongnu.org>; Tue, 25 Feb 2025 23:54:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740556466; x=1741161266;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=V8zDlKlzLN/PdVYfjlCqH1UzYBf6b17ENTGJMZ7XSg8=;
 b=I/j/aHyqCWgLljhRoNNv/LoGwXhjXYwWDWZ8oEA+vcJFc7t5MgOq5qf7jbXyj6UqIZ
 O9Qz6tVeB2adRfKTdputK4bL+lsVp/7yibQGL7NB6zgs6m/XNRY5IqTniiUq+Mlw8Zpn
 RKXH8Z4+AhDyyPxFVQql/ilWEBlv+Z2dnYksevWYWdnirpPzmyeQhER1goyQJyyn2A16
 egRQGN27oP4mbcch0A/spAbz+bE9TT5r4ipEKqa5ZrlgC6HJzq7D6Jz515I3mxNW7EGu
 wKJNXCvT5/qFMjecoTU9SYyt6oYlVn4/76aeQ1xFBDltJze8LJQWPlBJz3JaUbZzWLNi
 0Q9Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCUx1VtvqmieOofJRRQEknMIpdDvuyZqOPOVT6qMYbRkUPeu3gzwD0cj8iZOrNkMBm5nvWKTB3t/yoCg@nongnu.org
X-Gm-Message-State: AOJu0Yy1XWVOL58bJibuL8oPjXMZn03EExSPBoYKNJFGpR+mUFLEKWVg
 PVlYJHrUG5Wy8hCFqYUrUbYjy4RDx7ZHtkI0IGfYjX0KO5NzXsEf3rAGM6yEOVk67hnW4Y2Q4kr
 10umwNdKhn7S4Ios5aLBBZxrRU/WHreVGT9BSR1KHueKpqeTZCAyQ
X-Gm-Gg: ASbGncuU5VYIw1/LEO6pOfqe+xKDMd2fYoCUtOLbYOCzInARZIWjv6Hut+SWJJfWNQH
 aIf8fFwtPdaQeoaNfjyz/V+KsUaos8gmt2xkJVPOh9ghU9y/Eeyos+EDYuwWRIOxEgcCl3ODFcB
 lyOgQwBvGQysWkSRnBHPOm9Jp7OmQItnNVfoKjxpG5SHwT1hWIxlu4pLptceZtTAd1h6O/ClUnI
 nHVpJQ+IqwDWq+9KdVxj0MQ4KZcBy6WmPPjCPAYPKTeUarkVSgZQiya0P9tfybHpU1H9+/f7zFD
 tu4fSmA3vMQwGeB0zyOJtIhcrCUnIdY+BO18ySW7lOZKMMCnNAgAIb35p20=
X-Received: by 2002:a05:600c:4684:b0:439:56f3:d40f with SMTP id
 5b1f17b1804b1-43ab0f6dedcmr44560105e9.21.1740556465911; 
 Tue, 25 Feb 2025 23:54:25 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEM+7ftOPnreqtLqToBXYro66dPvjE3lNWLwL6jA7WUEVyXPvmpsUxSQVdiMiJIuqFPlPZ0uw==
X-Received: by 2002:a05:600c:4684:b0:439:56f3:d40f with SMTP id
 5b1f17b1804b1-43ab0f6dedcmr44560025e9.21.1740556465577; 
 Tue, 25 Feb 2025 23:54:25 -0800 (PST)
Received: from ?IPV6:2a01:cb19:9004:d500:a732:5611:7f59:8bb3?
 ([2a01:cb19:9004:d500:a732:5611:7f59:8bb3])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43ab2cb1063sm26554855e9.2.2025.02.25.23.54.23
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 25 Feb 2025 23:54:24 -0800 (PST)
Message-ID: <cb6e9bb4-5eee-4492-abe0-073ecf586267@redhat.com>
Date: Wed, 26 Feb 2025 08:54:22 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] tests/functional: Update the ppc64 pseries and pnv tests
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, Nicholas Piggin <npiggin@gmail.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>
References: <20250226065401.197915-1-clg@redhat.com>
 <d61872e1-2eca-4af7-a135-96659ec5fb6e@redhat.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <d61872e1-2eca-4af7-a135-96659ec5fb6e@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.443,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 2/26/25 08:01, Thomas Huth wrote:
> On 26/02/2025 07.54, Cédric Le Goater wrote:
>> The tests are using a now archived Fedora29 release. Switch to the
>> most recent Fedora41 release.
>>
>> Signed-off-by: Cédric Le Goater <clg@redhat.com>
>> ---
>>   tests/functional/test_ppc64_powernv.py | 6 +++---
>>   tests/functional/test_ppc64_pseries.py | 6 +++---
>>   2 files changed, 6 insertions(+), 6 deletions(-)
>>
>> diff --git a/tests/functional/test_ppc64_powernv.py b/tests/functional/test_ppc64_powernv.py
>> index 685e2178ed78..a9da7905366e 100755
>> --- a/tests/functional/test_ppc64_powernv.py
>> +++ b/tests/functional/test_ppc64_powernv.py
>> @@ -18,9 +18,9 @@ class powernvMachine(LinuxKernelTest):
>>       good_message = 'VFS: Cannot open root device'
>>       ASSET_KERNEL = Asset(
>> -        ('https://archives.fedoraproject.org/pub/archive/fedora-secondary/'
>> -         'releases/29/Everything/ppc64le/os/ppc/ppc64/vmlinuz'),
>> -        '383c2f5c23bc0d9d32680c3924d3fd7ee25cc5ef97091ac1aa5e1d853422fc5f')
>> +        ('https://archives.fedoraproject.org/pub/fedora-secondary/'
>> +         'releases/41/Everything/ppc64le/os/ppc/ppc64/vmlinuz'),
>> +        'eca627adbe42437cacea169beeb4c3c12a5cfbca1a6b1ba5218d28139d2143c4')
> 
> I think we should rather avoid the very latest and greatest Fedora URLs here... they will be invalid in a couple of months after Fedora 43 has been released. And if we keep switching the test assets all the time, this will make it more difficult to bisect regressions in the future.
> 
>   Thomas
> 

So we should point to the latest archive (fedora38) then ?


Thanks,

C.





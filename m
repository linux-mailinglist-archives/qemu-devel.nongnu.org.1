Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B1FEB106E2
	for <lists+qemu-devel@lfdr.de>; Thu, 24 Jul 2025 11:48:17 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uesYD-00021n-5E; Thu, 24 Jul 2025 05:47:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1uesY1-0001oj-Dv
 for qemu-devel@nongnu.org; Thu, 24 Jul 2025 05:47:34 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1uesXy-00007i-Ez
 for qemu-devel@nongnu.org; Thu, 24 Jul 2025 05:47:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1753350448;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=hHyjI/ffDAmiOlAfzFMYnJIq80HcteJxRngfTYXd+3E=;
 b=hJitDQH3ruhXmznPR8fYRPRcYc0kAqPtvqLJSvIyzzHFllnNtzFw2dqfm8QhJPpDEnlbXm
 0VQ5f+da4KasuBi3UYnJVHaAtO/B9cvlO259jXUzfrVU76YKBbhfc62kDkPxollM2FMDui
 3obUdxu9Lkju2lWGQgFXZCuWpDavcEA=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-589-82_uAZosNMC-HF2Q-eTzYw-1; Thu, 24 Jul 2025 05:47:26 -0400
X-MC-Unique: 82_uAZosNMC-HF2Q-eTzYw-1
X-Mimecast-MFC-AGG-ID: 82_uAZosNMC-HF2Q-eTzYw_1753350446
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-45867ac308dso4267105e9.2
 for <qemu-devel@nongnu.org>; Thu, 24 Jul 2025 02:47:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753350445; x=1753955245;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hHyjI/ffDAmiOlAfzFMYnJIq80HcteJxRngfTYXd+3E=;
 b=XBd4EFs5tcV/G2HqoP4Oo1LHAyNZC4yFLRLdRuhkmRMHMGYT5usqp4DCWiHoKThYZr
 7cIVjoBLzOIvAnzgtQhJeq+kk3oMXwwgb9NpcjpKgtOI7ZqfBRaAG4wTaO5uMV7ukzbE
 YQQ0lhhEauX4dgxFV/eTCKhYBRFrhjEvlr1Rk1MTB4DhER9oLP8ghILIeHgErMzDnWBC
 UrGhUI1Sqv/8hpJMZoce2HoxqD2cZ3wzKCK7lEcmPclmRC2ApOhheZ9lTVNBwAyEgJ1y
 Im8PGDSW2xaekJV9p3ywXCCTfDpuBF8EFPQHS0mcgLTrjwbIyxWNLX+iAFG1jDHg4aAw
 twmw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWEdqecEiYP9pc1ZtR38A0AfjzH8rEB9w685dlNzTjdBenOKZlVPtdBrlU1g4w/GtOjqXKHP7XDz0LM@nongnu.org
X-Gm-Message-State: AOJu0YwK1YHdgClrOJ5EGPAnfKqT98qqL9FDGsumLMZWpqvO8B0SrHQR
 7tEv5y9xKIQRSXWMIIUwMd0d5QfbzKGk/AM2WgDoSI4HrbQuA5iKtWCOhRpZg1DTYu6Ht78SB8m
 8pBdWElwVN/fdItwcnwZzUNtGUrCYhbQtMAKrpDbNZ+tQdSITChOlXzUc
X-Gm-Gg: ASbGncstIyr3zndv2Kl4o532tCoMAoXqhGSVs7t/CXEIRpkf26UWDnE1cVT1zqGs7oJ
 tl4il+0uWX95j/LZpeZ01j9d7E786+mMBckDqSDoBkns8VJlZiu1WQOk/YVdnv1Jh0Tl4hqkE1+
 Dr4UQEMvM/IMwZo8VjBXT5ichbKlph0jueLAdRKGbiegJHZKMMBQkwny0XpcLCXvZNIBzyTTAs3
 1vkdk5eYblhSYm5upH0A9uXYRc0zTHsoTUWr0IFbLDIqLCKUXN2zS7nshw/xEmPL8X3icRQD+rv
 1ykq6NcOQ6JG51+KwoqnIZbQnSDK2gOPOEDl47rUuPUlkAb/9lx21YmW17PMm3gemeAQEhYL35h
 aCg==
X-Received: by 2002:a05:600c:83c8:b0:456:2d06:618a with SMTP id
 5b1f17b1804b1-4586b3b0bdcmr51683725e9.18.1753350445304; 
 Thu, 24 Jul 2025 02:47:25 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHznsbhxViuxMW3gJcHeBshbZKFDwk1mFbzO54cfFH0M8yuttBRLkF5jQBsAfEq95pGCJJC7g==
X-Received: by 2002:a05:600c:83c8:b0:456:2d06:618a with SMTP id
 5b1f17b1804b1-4586b3b0bdcmr51683335e9.18.1753350444726; 
 Thu, 24 Jul 2025 02:47:24 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:576b:abc6:6396:ed4a?
 ([2a01:e0a:280:24f0:576b:abc6:6396:ed4a])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b76fcad2b4sm1630212f8f.47.2025.07.24.02.47.23
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 24 Jul 2025 02:47:23 -0700 (PDT)
Message-ID: <d14c7e44-14fe-430e-96eb-0d1325953612@redhat.com>
Date: Thu, 24 Jul 2025 11:47:23 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/5] MAINTAINERS updates for ppc/spapr/pnv/xive
To: Harsh Prateek Bora <harshpb@linux.ibm.com>, qemu-ppc@nongnu.org,
 qemu-devel@nongnu.org, npiggin@gmail.com
Cc: danielhb413@gmail.com, fbarrat@linux.ibm.com, rathc@linux.ibm.com,
 adityag@linux.ibm.com, gautam@linux.ibm.com
References: <20250724063623.3038984-1-harshpb@linux.ibm.com>
 <642a5b59-a306-4fbd-a55c-008b9fd8ace0@redhat.com>
 <74e8e729-3bae-4315-9519-5bd0b6f08731@linux.ibm.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <74e8e729-3bae-4315-9519-5bd0b6f08731@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.377,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 7/24/25 11:12, Harsh Prateek Bora wrote:
> 
> 
> On 7/24/25 13:10, Cédric Le Goater wrote:
>> On 7/24/25 08:36, Harsh Prateek Bora wrote:
>>> Some of us at IBM have been actively working/contributing in
>>> ppc/spapr/pnv/xive and would like to step up to help with
>>> reviews and co-maintainer activities. I have also included proposal
>>> patches from Chinmay and Aditya in this patchset which had already
>>> been posted to list earlier to request for merge.
>>>
>>> Thanks
>>> Harsh
>>>
>>> Aditya Gupta (1):
>>>    MAINTAINERS: Add myself as a reviewer of PowerNV emulation
>>>
>>> Chinmay Rath (1):
>>>    MAINTAINERS: Add myself as reviewer for PowerPC TCG CPUs
>>>
>>> Gautam Menghani (1):
>>>    MAINTAINERS: Add myself as a reviewer for XIVE
>>>
>>> Harsh Prateek Bora (2):
>>>    MAINTAINERS: Adding myself as a co-maintainer for ppc/spapr
>>>    MAINTAINERS: Adding myself as reviewer for PPC KVM cpus.
>>>
>>>   MAINTAINERS | 5 +++++
>>>   1 file changed, 5 insertions(+)
>>>
>>
>> I can merge these changes through the vfio queue.
>>
>> Reviewed-by: Cédric Le Goater <clg@redhat.com>
> 
> Thanks Cedric !
Would you mind resending a v2 with all S-o-b fixed please ?

Thanks,

C.

  



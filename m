Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B534C9F0F10
	for <lists+qemu-devel@lfdr.de>; Fri, 13 Dec 2024 15:27:22 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tM6cs-0006NR-2b; Fri, 13 Dec 2024 09:26:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1tM6cU-000618-2O
 for qemu-devel@nongnu.org; Fri, 13 Dec 2024 09:26:21 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1tM6cO-0002tS-9A
 for qemu-devel@nongnu.org; Fri, 13 Dec 2024 09:26:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1734099968;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=JOLk/4JaJHY54r9iBMPfvY5vXz14Fu0YCb+NvaosAwU=;
 b=G96PQX97lycNFbE5LLN162LxYHVxUIanPyfEcBokLNM3LsjeAFwxrruiJ/a3cFVcN32+Be
 eh8ohQqgj80lwwDvfPc6gF/eGDpFWaT56FK59u9pmisKg/YzUaFG4oHbKAz5cwCOV/Aupn
 VrjMNvxKcxlzyYBHRM0XA6MFNb4kOmA=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-191-se5Daj-SM--lYWwmYHLeJg-1; Fri, 13 Dec 2024 09:26:06 -0500
X-MC-Unique: se5Daj-SM--lYWwmYHLeJg-1
X-Mimecast-MFC-AGG-ID: se5Daj-SM--lYWwmYHLeJg
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-43624b08181so9930805e9.0
 for <qemu-devel@nongnu.org>; Fri, 13 Dec 2024 06:26:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734099965; x=1734704765;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:from:references:cc:to:subject:user-agent
 :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to;
 bh=JOLk/4JaJHY54r9iBMPfvY5vXz14Fu0YCb+NvaosAwU=;
 b=iXQu1+0GICZTBwjBV8RV3yWPRgmPLy+SFZAkCnkAmXXl3GY3jzbAqZVmyirczK52P7
 MXK0ukg3ieOOBTUFBBkuItYzNXdeDSfCJKhvgC5ENUcqQ0/7RFeoanC1FDlBF6J5tKpM
 aiGHPYvLY9xqfM39ILGwbTzwKDxk7lNAzwbk2q6mqyB69JwKANjPP4ox3xUbd/Sg1vNH
 zaUBx33aUJH9aGgEv1zc1LwT6JvBjT/iF6ygUEoHO6MKJ3gAsvmm3cAK37AEulYKa2kw
 WHG+G3tt0edtAwQoxfA91HMJ682mYOqiZsPTNb3SIEdzlDLs1Ev/BDZA3NOSmqx0DZRg
 d4Dg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUj4dsdGoSfsEiZ3QEON3GX1rOhULYIMUK4ujeB95ig6v4+mrDeaRt/OGaYqO0QzLKOZs2L/BhoBLD2@nongnu.org
X-Gm-Message-State: AOJu0YxdkgvRPTz1E8OXvAvkAN22COvwG3QF4aNl33hcBLYsJcLBtNRD
 IvhN8mC1mjdKSouv5jma2mztQrD3edals1dBGP2qgq0xFRQEGKKas/yL3HZhTizErReWb7zP8dR
 7ckkyNXEUg2EAfG/ALkhZoqd+HW7SGapgUJkJavmg8lWbgUttTLZQ
X-Gm-Gg: ASbGncsno+AfJKlhqxP1flMZ0cKPla4JzQWFMm4RPKG0YxdFirj91DgpB99U0MwmuFj
 EqQcki9+V8MFYfsCfu5+lPBstM9JMEYaStnNkgf+QF6FSULvdQVxhDXKwufvIzepEbczf5/IFWt
 OQgit2YJP+BP+yjSz9iIhvVsbpWTgpQM/yeBHN0j0SdJ7S6t5C74c5fNJHvFIFw8iI2Eqk0HAx8
 4N2smGor19r9AkEhPH44ETTN47gkjHuruPCJRF7ieCOPmhuqmg7tGTSUsy9zVjq+fNqX7JZyZmX
 oDs9r/eGTWDMUc7OlmjQkZd0vno/1ZLkOcruUE7pOwlyMhA9mCr0O491sdHSMkw1XOllzMJtdHX
 iWQ0ctg==
X-Received: by 2002:a05:600c:c8c:b0:42c:b8c9:16c8 with SMTP id
 5b1f17b1804b1-4362b14bbe0mr20122115e9.10.1734099965625; 
 Fri, 13 Dec 2024 06:26:05 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFvmuiQniEFREmcTScVZastEBbYoyPFkSow3TUP9sZ38T5q2JN+l4HQuRXKIBzJrttX+xbKPw==
X-Received: by 2002:a05:600c:c8c:b0:42c:b8c9:16c8 with SMTP id
 5b1f17b1804b1-4362b14bbe0mr20121945e9.10.1734099965210; 
 Fri, 13 Dec 2024 06:26:05 -0800 (PST)
Received: from ?IPV6:2003:cb:c707:7500:e6f:ae52:22f6:4582?
 (p200300cbc70775000e6fae5222f64582.dip0.t-ipconnect.de.
 [2003:cb:c707:7500:e6f:ae52:22f6:4582])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-436256b4520sm50345125e9.32.2024.12.13.06.26.03
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 13 Dec 2024 06:26:03 -0800 (PST)
Message-ID: <9089e146-d665-471b-a918-2571a212c99b@redhat.com>
Date: Fri, 13 Dec 2024 15:26:02 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 00/14] s390x: virtio-mem support
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Eric Farman <farman@linux.ibm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Nina Schoetterl-Glausch <nsg@linux.ibm.com>,
 Heiko Carstens <hca@linux.ibm.com>, Ilya Leoshkevich <iii@linux.ibm.com>,
 Janosch Frank <frankja@linux.ibm.com>, "Michael S. Tsirkin"
 <mst@redhat.com>, Cornelia Huck <cohuck@redhat.com>
References: <20241008105455.2302628-1-david@redhat.com>
 <07ca4492-1590-4cc6-94a1-0eea417da59e@redhat.com>
 <7e1025b4-c246-432c-b70d-e7156afb6519@redhat.com>
 <8d06030b-37a2-4c41-9907-8e072dde47f7@redhat.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <8d06030b-37a2-4c41-9907-8e072dde47f7@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=david@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.495,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 13.12.24 13:35, Thomas Huth wrote:
> On 12/12/2024 22.52, David Hildenbrand wrote:
>> On 13.11.24 15:46, David Hildenbrand wrote:
>>> On 08.10.24 12:54, David Hildenbrand wrote:
>>>> Based on current master.
>>>>
>>>> There is really not much left to do on s390x, because virtio-mem already
>>>> implements most things we need today (e.g., early-migration,
>>>> unplugged-inaccessible). The biggest part of this series is just doing what
>>>> we do with virtio-pci, wiring it up in the machine hotplug handler and ...
>>>> well, messing with the physical memory layout where we can now exceed
>>>> initial RAM size and have sparsity (memory holes).
>>>>
>>>> I tested a lot of things, including:
>>>>     * Memory hotplug/unplug
>>>>     * Device hotplug/unplug
>>>>     * System resets / reboots
>>>>     * Migrate to/from file (including storage attributes under KVM)
>>>>     * Basic live migration
>>>>     * Basic postcopy live migration
>>>>
>>>> More details on how to use it on s390x -- which is pretty much how
>>>> we use it on other architectures, except
>>>> s/virtio-mem-pci/virtio-mem-ccw/ --- is in the last patch.
>>>>
>>>> This series introduces a new diag(500) "STORAGE LIMIT" subcode that will
>>>> be documented in the kernel and at [2] once this+kernel part go upstream.
>>>>
>>>> There are not many s390x-specific virtio-mem future work items, except:
>>>> * Storage attribute migration might be improved
>>>> * We might want to reset storage attributes of unplugged memory
>>>>      (might or might not be required for upcoming page table reclaim in
>>>>       Linux; TBD)
>>>>
>>>> The Linux driver is available at [3].
>>>>
>>>> [1] https://lkml.kernel.org/r/20240906101658.514470-1-pbonzini@redhat.com
>>>> [2] https://gitlab.com/davidhildenbrand/s390x-os-virt-spec
>>>> [3] https://lkml.kernel.org/r/20240910191541.2179655-6-david@redhat.com
>>>
>>> Gentle ping (and thanks to Thomas for the review!).
>>>
>>> I assume the kernel portion will go upstream in the next merge window.
>>> I'd like get the QEMU parts merged soon after that.
>>>
>>> 9.2 is going to get released in roughly one month, so there is still time.
>>
>> In the meantime, 9.2 was released. I don't have any changes planned. Series
>> still applies to current master, I'll do a quick test tomorrow.
>>
>>>
>>> @Thomas, this is mostly s390x stuff, so I guess it should go through the
>>> s390x tree? But I could also take this through my "memory devices" tree.
>>
>> @Thomas, any thoughts?
> 
> I'm fine either way - feel free to put it into your tree, otherwise I'll
> pick it up likely sometime next week.

Okay, let me let this sit here for a couple days longer and retest it 
next week. I can queue it then, as another required patch ("virtio-mem: 
unplug memory only during system resets, not device resets") still sits 
in my tree all-lonely. :)

-- 
Cheers,

David / dhildenb



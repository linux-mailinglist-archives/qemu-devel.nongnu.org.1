Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B8B51AB8058
	for <lists+qemu-devel@lfdr.de>; Thu, 15 May 2025 10:23:54 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uFTsB-0006M1-5L; Thu, 15 May 2025 04:23:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1uFTs4-00066y-Sh
 for qemu-devel@nongnu.org; Thu, 15 May 2025 04:23:20 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1uFTrw-000323-IE
 for qemu-devel@nongnu.org; Thu, 15 May 2025 04:23:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1747297385;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=hWVidlQTN830S3GH22eERnj/+tc0U9j8bHF8V9i3TAc=;
 b=bxqIDnSjNWT83PSVWyu/ECztIOpaMH/V1jBeSIEiXzFuqYDTMlT4NJNHGcmPFjHzRrReF3
 tifgXaeDRqGO1zk66yPwTaId7CknnmF5pRRs7WEngtGgfKiouQWOIYVn8G6vXsupWFYV/F
 JH3YW8RF0k0xygTYN+oS3qEwpxV7YkA=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-632-Pq_YcJV9Mb6yaHafYUUqDA-1; Thu, 15 May 2025 04:23:01 -0400
X-MC-Unique: Pq_YcJV9Mb6yaHafYUUqDA-1
X-Mimecast-MFC-AGG-ID: Pq_YcJV9Mb6yaHafYUUqDA_1747297380
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-43eea5a5d80so3714055e9.1
 for <qemu-devel@nongnu.org>; Thu, 15 May 2025 01:23:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747297380; x=1747902180;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:from:references:cc:to:subject:user-agent
 :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to;
 bh=hWVidlQTN830S3GH22eERnj/+tc0U9j8bHF8V9i3TAc=;
 b=b6K3BKSuKE5l34cYNfSNSQ7Vff/07NLQLdTctBMGpFV7Ix4YNkdaMLoizQG+5uyL3u
 z6XLgYVMI1hQlV2aCzxthhN2Z+4S9yQWY0p+vGpRYdls4gvCjMqsoFHmU46VQvWnfcjF
 +0kwbeRWaOEvv7SIi01FQj2RuTVohJIGSpckyzPC0fTqfZZ/NNaZJO3mOsBPxWueXOaD
 FoeWgTY79w9gRfcV+5KZrUsUKLZyDyg1a/r4ewo3hekof/KXFLTULja4LjW1xdgpJjoH
 ZBi2TXJgnQxED7ctZC5J4QR/ZbC2RbAw2YI74rVO9pCp3nHJt7+xZmVzLMKqjLv7nzt+
 opwA==
X-Gm-Message-State: AOJu0YxSv0l+s9X0t1iKFY/mE5lFjS2FXH6zENEV7bTQ6j1+A1ACUG1e
 WVFKSPSj2pUTEAYO4KI2vjb1YB3XCjFAxBaHn3g3X9HvCgiRCftxLA0MbGdqdc/FuHMuk3zOYs0
 iV5svLbrmsKZG+ASsqQ/HENH6Pqw3zYy3SbVV05SsVgozGf1oFbrj
X-Gm-Gg: ASbGncu2rg2aFaFsotq/T31DKLNDISMRFXH5v89klJjbni9wKJzX5tV0Ee9xGn5wRaA
 kwSLDApfM0jHMYI1HYPqAo8J/P4zxfNwRKbiPShINN0kxxMMDPRqjDarPbYapLClU2ucz8rXShA
 r3UOoUxQnc4ZH0BOy90wWDijraqeL3L5p7eeFVWBxefzViUEXL+1iSqLUVT3/tbXPLSNv7SoeLR
 QPE2tNTF6jcAmSluo2gXrEu7uxB5jEUd0rdVbDlkMEhmn1X+xDv7+gijSf2jmG1DpACLDEVjC6c
 G5a3d7Zz6d+9gjtgMtx3XmzGx6tjcVd2jLOtrkC2wz06O1M1mFmATZc5U4PEFvHajoq9ud/rpRG
 rnYQR82CSrQjHnW1GUKrPHQpA1BTNYwo2jF3R3dg=
X-Received: by 2002:a05:600c:1d8c:b0:43d:45a:8fca with SMTP id
 5b1f17b1804b1-442f971a4a6mr15764315e9.30.1747297380310; 
 Thu, 15 May 2025 01:23:00 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGx88giFGBFcOAScbVBQT7zYG/2DPS1FupHR8EW0opJf+ICoWP+Nf9M2+jJvw/9Lq//UNhieQ==
X-Received: by 2002:a05:600c:1d8c:b0:43d:45a:8fca with SMTP id
 5b1f17b1804b1-442f971a4a6mr15763985e9.30.1747297379918; 
 Thu, 15 May 2025 01:22:59 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f4a:8900:884a:b3af:e3c9:ec88?
 (p200300d82f4a8900884ab3afe3c9ec88.dip0.t-ipconnect.de.
 [2003:d8:2f4a:8900:884a:b3af:e3c9:ec88])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-442f33691fdsm60994665e9.5.2025.05.15.01.22.58
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 15 May 2025 01:22:59 -0700 (PDT)
Message-ID: <c53f8cf6-fbf7-4182-9933-5c6ae1ed9d93@redhat.com>
Date: Thu, 15 May 2025 10:22:58 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V3 26/42] vfio: return mr from vfio_get_xlat_addr
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>,
 John Levon <levon@movementarian.org>,
 Steve Sistare <steven.sistare@oracle.com>
Cc: qemu-devel@nongnu.org, Alex Williamson <alex.williamson@redhat.com>,
 Yi Liu <yi.l.liu@intel.com>, Eric Auger <eric.auger@redhat.com>,
 Zhenzhong Duan <zhenzhong.duan@intel.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Peter Xu <peterx@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
References: <1747063973-124548-1-git-send-email-steven.sistare@oracle.com>
 <1747063973-124548-27-git-send-email-steven.sistare@oracle.com>
 <aCJfQ2jJ-B5q8hRW@movementarian.org>
 <a1f5d185-445d-417f-bf0f-1e11c84c91a1@redhat.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <a1f5d185-445d-417f-bf0f-1e11c84c91a1@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=david@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -37
X-Spam_score: -3.8
X-Spam_bar: ---
X-Spam_report: (-3.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.686,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On 14.05.25 19:03, Cédric Le Goater wrote:
> + Paolo
> + David
> + Peter
> + Phil
> 
> On 5/12/25 22:51, John Levon wrote:
>> On Mon, May 12, 2025 at 08:32:37AM -0700, Steve Sistare wrote:
>>
>>> Modify memory_get_xlat_addr and vfio_get_xlat_addr to return the memory
>>> region that the translated address is found in.  This will be needed by
>>> CPR in a subsequent patch to map blocks using IOMMU_IOAS_MAP_FILE.
>>>
>>> Also return the xlat offset, so we can simplify the interface by removing
>>> the out parameters that can be trivially derived from mr and xlat.
>>>
>>> Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
>>
>> Steve, would you consider splitting this out from the full CPR series and
>> submitting as a standalone, as we both have a dependency on doing this, and your
>> patch seems much nicer than the current one in vfio-user series?
> 
> May be we can merge this version if maintainers ack the change ?

The change itself looks good to me. Now that we want to return the mr 
from memory_get_xlat_addr(), why not make that the return type (NULL vs. 
! NULL), to get rid of the boolean?

MemoryRegion *memory_get_xlat_addr(IOMMUTLBEntry *iotlb, hwaddr *xlat_p,
		Error **errp);

Same with "vfio_get_xlat_addr".

Of course, we could consider renaming both functions to something like

memory_translate_iotlb()
vfio_translate_iotlb()

-- 
Cheers,

David / dhildenb



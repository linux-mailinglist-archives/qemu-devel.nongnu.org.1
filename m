Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 36ED2A27310
	for <lists+qemu-devel@lfdr.de>; Tue,  4 Feb 2025 14:42:56 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tfJCR-0005YB-Uu; Tue, 04 Feb 2025 08:42:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1tfJCP-0005Xz-7k
 for qemu-devel@nongnu.org; Tue, 04 Feb 2025 08:42:45 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1tfJCN-0002A3-E7
 for qemu-devel@nongnu.org; Tue, 04 Feb 2025 08:42:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1738676561;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=3HH4i/2ygnec+xMcPHEvVDyUfMsLSzkJsBaOj9jJAbw=;
 b=dFgcuaWXKrGcNui6UQdxe3B+CEoiRKqNglwnH0b49LGHMgiUxs4Ql9Z3ZzWcga3y9Ac8UX
 h9aJWpUxP95O0KopR1I4Pse8Vq0uFwmqVyAGalstk0IfeblJczrrFWGCrRBT56PVNiHMEk
 tux3h+0OzDModsZmjB94Bzzkd4fLLV8=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-208-20XBQdpSNHW0RMYj0Esztg-1; Tue, 04 Feb 2025 08:42:39 -0500
X-MC-Unique: 20XBQdpSNHW0RMYj0Esztg-1
X-Mimecast-MFC-AGG-ID: 20XBQdpSNHW0RMYj0Esztg
Received: by mail-qv1-f71.google.com with SMTP id
 6a1803df08f44-6e4237b6cf0so11492986d6.1
 for <qemu-devel@nongnu.org>; Tue, 04 Feb 2025 05:42:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738676559; x=1739281359;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3HH4i/2ygnec+xMcPHEvVDyUfMsLSzkJsBaOj9jJAbw=;
 b=waDcEXvnxhSL05zxd3/jkrhaOlID8MTYuK2iFZXc2rMTwzptNBF0Q5PpXUZ5m1ZEli
 R59wcGNN10c6fdp7PMzedQthO5CZrZCNEiKf0eUwRb4OWZMAW3AfvTwmadO8CTMNr/cy
 kz8UEqODvL6pWN7/F812GQYDvn1ph/TzC0flHN3esZILXkAp3OwnYgS1ZM/JQEwNFsjK
 8WZ2T9J0ZXBVMgcyTML6sVJowLfa6THYrhpmhc7kgfMRBzbZKoGBlJcV+WaBtotsyor3
 GOa26qhJCWIrgOYkz6YdGsrZpEuehqGMEUO/mL2VOSmSKlAHG4Sgw1Qm1fXEPGPpeKG7
 nOdQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXQGcM7WZVP47XiswT/O29TqMjsphbsHbirUC2igyqaP+nUaxsYZUxDE3VGaX4w/9WzyroYsgH/Z234@nongnu.org
X-Gm-Message-State: AOJu0YxCQkBhb1mhTabHinDG8y9mSPeF8r/RdF/1pVpezOPSmApvfluw
 8UQLMdyIG3kGU+AEAd645A4PZ0KLUVkAvUlOPYNP241CgW3kwZl5FyRb6bWNyooOs2ZXXttq/yG
 0qPUkY1dIIPLT1h2IeCFzl8nnYYOOgJ3tvUO6R4SesKQLeVBK7x/2
X-Gm-Gg: ASbGncuoGjluQcGQtG8CAFUqPJRhVuus7RtUEfuPv/jlxn13u+XjhInaDqXK4ShpAst
 1wnT7jU8I3pybsf0QWGiwc7NL13pDt/CIsVm7ypHENlAjHWuWDFwibWYUHvEvo0tfogmvVOo8OP
 WnGpEoI++uaRJZarudWDOIfcOMUsFWLQb16OMklfkHExCsAEv8vnWdSKZQrCg7M5naQsvD0E761
 +NDoFzJ2LCYMuBG20STKxPdwsJ5hJXXgpF5FR+6KTXYG8ix2StdC8s7YygvBRH9oYMESdOBPJlO
 tYAkNhQEz6yanhZMa3om2VTMdNV1H8tfUqWYCyTjG9E=
X-Received: by 2002:a05:6214:202c:b0:6da:dc79:a3c9 with SMTP id
 6a1803df08f44-6e243b910e7mr326914236d6.9.1738676558989; 
 Tue, 04 Feb 2025 05:42:38 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGLESZFyb7FPpqATOzCe4f1if+GggYCxOLuNh8QIzrvkJ6SeqTqcxxVnegZkndNMTHQVoIDyA==
X-Received: by 2002:a05:6214:202c:b0:6da:dc79:a3c9 with SMTP id
 6a1803df08f44-6e243b910e7mr326913976d6.9.1738676558634; 
 Tue, 04 Feb 2025 05:42:38 -0800 (PST)
Received: from ?IPV6:2a01:e0a:280:24f0:9db0:474c:ff43:9f5c?
 ([2a01:e0a:280:24f0:9db0:474c:ff43:9f5c])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6e254922e21sm61957506d6.92.2025.02.04.05.42.37
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 04 Feb 2025 05:42:38 -0800 (PST)
Message-ID: <8638674e-5a79-4405-9063-89ba78112c8f@redhat.com>
Date: Tue, 4 Feb 2025 14:42:36 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] MAINTAINER: Add a maintainer for CPR
To: Steven Sistare <steven.sistare@oracle.com>, qemu-devel@nongnu.org
Cc: Fabiano Rosas <farosas@suse.de>, Peter Xu <peterx@redhat.com>
References: <20250204082859.846886-1-clg@redhat.com>
 <8599e016-4ea4-4c1d-b4d2-c583c57a9558@oracle.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <8599e016-4ea4-4c1d-b4d2-c583c57a9558@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

On 2/4/25 14:31, Steven Sistare wrote:
> Hi Cedric, CPR is a mode of live migration, integrated so closely that
> it makes more sense for the migration maintainers to maintain it, and
> consult me if/when necessary.  "migration" appears in 4 of the 5 paths
> you list below.

CPR is growing with the recent proposal and it is a large enough
feature to have its own maintainer IMHO.

Should we add cpr* files under the migration subsystem then ?

Thanks,

C.

> - Steve
> 
> On 2/4/2025 3:28 AM, Cédric Le Goater wrote:
>> The CPR feature was added in QEMU 9.0 and it lacks a maintainer.
>> Propose the main contributor to become one.
>>
>> Cc: Steve Sistare <steven.sistare@oracle.com>
>> Signed-off-by: Cédric Le Goater <clg@redhat.com>
>> ---
>>   MAINTAINERS | 9 +++++++++
>>   1 file changed, 9 insertions(+)
>>
>> diff --git a/MAINTAINERS b/MAINTAINERS
>> index db8c41fbe0f9..efb9da02f142 100644
>> --- a/MAINTAINERS
>> +++ b/MAINTAINERS
>> @@ -2943,6 +2943,15 @@ F: include/qemu/co-shared-resource.h
>>   T: git https://gitlab.com/jsnow/qemu.git jobs
>>   T: git https://gitlab.com/vsementsov/qemu.git block
>> +CheckPoint and Restart (CPR)
>> +M: Steve Sistare <steven.sistare@oracle.com>
>> +S: Supported
>> +F: hw/vfio/cpr*
>> +F: include/migration/cpr.h
>> +F: migration/cpr*
>> +F: tests/qtest/migration/cpr*
>> +F: docs/devel/migration/CPR.rst
>> +
>>   Compute Express Link
>>   M: Jonathan Cameron <jonathan.cameron@huawei.com>
>>   R: Fan Ni <fan.ni@samsung.com>
> 



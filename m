Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CDA18AA5B7D
	for <lists+qemu-devel@lfdr.de>; Thu,  1 May 2025 09:42:48 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uAOXa-0004H1-IZ; Thu, 01 May 2025 03:41:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1uAOXY-0004GT-Gi
 for qemu-devel@nongnu.org; Thu, 01 May 2025 03:41:04 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1uAOXW-00020M-QZ
 for qemu-devel@nongnu.org; Thu, 01 May 2025 03:41:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1746085259;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=Xpy+O/T01IFMWbkxvGplcGNz8a/nVIVRccLFohOpFMA=;
 b=gPxdWg7ydjSXdMEZLmMNooWp4MohIpm0lrNsC9uImIpH2hGHV4Zw7GJT8mBxvhRMG9Cgzb
 HpNXaLg1TWQBpx92MvkpDZ/Ysy/jbeKVmeSPLJOfdnIcn2Gk75Z858Qw9uBpJmShjYAge+
 jy1rSPikze5VE17rj4Q9OJbU19K7bKo=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-493-bzaxbtjfMSytPvuRvBaNig-1; Thu, 01 May 2025 03:40:57 -0400
X-MC-Unique: bzaxbtjfMSytPvuRvBaNig-1
X-Mimecast-MFC-AGG-ID: bzaxbtjfMSytPvuRvBaNig_1746085257
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-43ea256f039so3958515e9.0
 for <qemu-devel@nongnu.org>; Thu, 01 May 2025 00:40:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746085257; x=1746690057;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Xpy+O/T01IFMWbkxvGplcGNz8a/nVIVRccLFohOpFMA=;
 b=KPjI6hlSde0FFeV7dBE4JBcmo9mO1+X25fs3lVVV4CPqvQbZo4gJ6VjaTuGf2/Fg16
 oZr7h+/mNoyxVr4IfIfYYGsTlRg5SxzkUoXKB18ki0X6+sEvZ1+gz9loAE0nwXfWruA0
 m1JJAqS8oi3AdgaGUMOns2RsoyIyHYGwhpKm+08M9pmlykYn6gyagvkQbMTkNDatPPfY
 UsA6W7eXyXOihipXjSuWoravt/rAqYkg59LdKmZxExJtpgJuxd1XGKuaRtzbjKM/7Rhy
 0zQLfuQ7Zmr/vFP2ZrsgFNsRdJkQ/4ppk+xBCrH6vumk22PxkNCUKm2/dQNqXz1ssfdO
 OwHA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUQe33ov5MOejRHygLiUDsCZ2SeS6z8J/1Tbp78s2vkIPvbRLwiGs8vyDvW4QUSUZxIAVl2IH990sno@nongnu.org
X-Gm-Message-State: AOJu0YxM8s3HCbUpSwWdAsSRYKu+sWhvWHgY/7xX45rX56KRpCg593uB
 UP/ZnRabypGO/ZNO0Y//I3J7mskFkWPj/pGVnEYmi4C8F4AdWTvvOJObT2G7pGeQd7fnkmLb+1J
 hNbaYkfStpN68Fp37u2y5Yz86V8YNceLrpZkfvnJ+rCCRNg2GIquw
X-Gm-Gg: ASbGncv5T9EUKzPL+UJLoxDml3ke84UfJoNANI0MTfw+ZQgozUMWG4Y6kokyCim95ix
 +KvIRFYzT/WqDDh1V9yADIylPMub5ZK8UrLDEab/n9wr7WgKLBb5LLOGLSHOKsw18ENZe3n8P2k
 4YYAd2S0ODwJz5yNs3FAEf+C6oOuA6b/er5+1s0L00H0EoWu8D7sjU+sCOndzhIGePUqt5M+Sb+
 y6CXauWlorcwa/8h2xPNgkloePkAyrNotiYDwXSgqjNYzqkHWznG0Tz56MtHyhZG5H4R6qzgWpN
 Y77zPML7NfNxuFtOvTXNsIhm7QWFCDoKILeyugFKNS2/3bqsCw==
X-Received: by 2002:a05:600c:8184:b0:43c:ec97:75db with SMTP id
 5b1f17b1804b1-441b6ff5d90mr11362355e9.11.1746085256761; 
 Thu, 01 May 2025 00:40:56 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEsnSmgkI1WJv5iu1uZWc7HVGHGLvTfhGuL9aGIj1sRXkcGlvmgW3y5AKVBTysH/ardiHNWGg==
X-Received: by 2002:a05:600c:8184:b0:43c:ec97:75db with SMTP id
 5b1f17b1804b1-441b6ff5d90mr11362105e9.11.1746085256392; 
 Thu, 01 May 2025 00:40:56 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:3f78:514a:4f03:fdc0?
 ([2a01:e0a:280:24f0:3f78:514a:4f03:fdc0])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-441b8992b4csm3908275e9.0.2025.05.01.00.40.54
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 01 May 2025 00:40:55 -0700 (PDT)
Message-ID: <80435587-4601-4be7-859a-424b123e4828@redhat.com>
Date: Thu, 1 May 2025 09:40:54 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 0/6] Report vfio-ap configuration changes
To: Rorie Reyes <rreyes@linux.ibm.com>, qemu-devel@nongnu.org,
 qemu-s390x@nongnu.org
Cc: pbonzini@redhat.com, cohuck@redhat.com, pasic@linux.ibm.com,
 jjherne@linux.ibm.com, borntraeger@linux.ibm.com,
 alex.williamson@redhat.com, thuth@redhat.com, akrowiak@linux.ibm.com
References: <20250425052401.8287-1-rreyes@linux.ibm.com>
 <e35561c9-f104-4be0-8bf4-cae726118028@redhat.com>
 <8c8463d3-a1a2-476d-b9a0-fbbc0cb58c22@linux.ibm.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <8c8463d3-a1a2-476d-b9a0-fbbc0cb58c22@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.483,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On 4/30/25 22:55, Rorie Reyes wrote:
> 
> On 4/28/25 5:29 PM, Cédric Le Goater wrote:
>> On 4/25/25 07:23, Rorie Reyes wrote:
>>> Changelog:
>>> v7:
>>> - Dropped initial commit for linux-header file vfio.h since I created two new commits
>>> to address the changes made in v6
>>> - Moved patches 6 and 7 to the beginning of the series after dropping the first patch
>>>     - Because I dropped the initial commit for linux-header file vfio.h, I had to add
>>> VFIO_AP_CFG_CHG_IRQ_INDEX
>>> - Resyncing latest to v6.15-rc3
>>> - Still need Thomas Huth's review of v5 changes for patch 6/6
>>
>> I checked the build without default devices.
>>
>> Applied to vfio-next.
>>
>> Thanks,
>>
>> C.
>>
>>
> Hey Cedric, are my QEMU patches considered good for this series?

AFAICT, yes. They are reviewed and they build correctly.

I will let you address the downstream process.

Thanks,

C.




  



Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 370857D3416
	for <lists+qemu-devel@lfdr.de>; Mon, 23 Oct 2023 13:36:44 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qutDz-0008Nm-7n; Mon, 23 Oct 2023 07:35:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qutDw-0008AQ-OI
 for qemu-devel@nongnu.org; Mon, 23 Oct 2023 07:35:56 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qutDp-0004dp-RX
 for qemu-devel@nongnu.org; Mon, 23 Oct 2023 07:35:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1698060944;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=kv46gBeOZxk+q+k0enrSPHq+ENBAJzbWk5zZVjus3Wo=;
 b=GzWbXN32BJSqAT1fCqAPY9zNPh79GuFGw/9UrgKogp5HljMBU6kzbXjjwhwAWqgcToF7Tm
 rIHrV16u3nLlwnz6UJYa6Wv5KF/BaZsYVL0Dhgkqn0xoJfd7ZNjYuGO0odr+T2akDR1chP
 NCw8vwsvh4PjLh6Op+RUW2qm4mt6lt4=
Received: from mail-oi1-f200.google.com (mail-oi1-f200.google.com
 [209.85.167.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-479-xB7j6QOHPqCs14E6HZu4oA-1; Mon, 23 Oct 2023 07:35:33 -0400
X-MC-Unique: xB7j6QOHPqCs14E6HZu4oA-1
Received: by mail-oi1-f200.google.com with SMTP id
 5614622812f47-3b3447c72c4so5869349b6e.1
 for <qemu-devel@nongnu.org>; Mon, 23 Oct 2023 04:35:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698060932; x=1698665732;
 h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=kv46gBeOZxk+q+k0enrSPHq+ENBAJzbWk5zZVjus3Wo=;
 b=h4uRVUYhXEjo6+CWbdTdeLiZdWy/ehaVlUocJS9+zOEZAHddrreJ+y27wSwU6v2Nuk
 Vz5v13kBGdhL9w1H39wRD1khnyIK7XMbgGa4FXPopIywY6dOEOiYBdRsFVRCzD7eXOaC
 FMzZXQ4f3tATc7N26RAW8DpkV7a5w7vIOGDvfXzLr67aCXe9H2mu+9jMUGqpnkTQMvCZ
 gZl9LTFN9vTwbdRgp2lAjmcwuM6EMDOKHJVu9VPOdGGPO5HO0aNFO/ISFVJUyX8wkE6y
 Gmjj34553CyLlYm4UdJB2b0/0bDpwpabV7omEkmJUq9HOMqdxFN1u5Z3Pw5Nz8vZ4x3W
 s9FQ==
X-Gm-Message-State: AOJu0YxqqV/4Zfbf2pvPv58iLabUXXlkM0lkj2kjiH3WQUbm6DbtoTQT
 lpYrUSyE+MYqVLxVn6JqzeqTPAj2q8pssHn0zkwTTjj2mOLe2q9ZLv1fcnETdSTra1YKKnS6tFp
 pycUJVH9EyQgfesM=
X-Received: by 2002:a05:6808:983:b0:3af:585:402a with SMTP id
 a3-20020a056808098300b003af0585402amr9904352oic.39.1698060932801; 
 Mon, 23 Oct 2023 04:35:32 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF3FAWIsQ087QU/yvPlny3TthAoyokX0v2GyP8SeIGCRkm2dbN13lN26pYYH/tWPkidS97zOA==
X-Received: by 2002:a05:6808:983:b0:3af:585:402a with SMTP id
 a3-20020a056808098300b003af0585402amr9904334oic.39.1698060932524; 
 Mon, 23 Oct 2023 04:35:32 -0700 (PDT)
Received: from [192.168.0.5] (ip-109-43-176-141.web.vodafone.de.
 [109.43.176.141]) by smtp.gmail.com with ESMTPSA id
 jy20-20020a0562142b5400b0065d051fc445sm2823381qvb.55.2023.10.23.04.35.30
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 23 Oct 2023 04:35:31 -0700 (PDT)
Message-ID: <b6e5631f-e955-4cbc-b0d6-e4f3aa896bec@redhat.com>
Date: Mon, 23 Oct 2023 13:35:28 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/3] hw/s390x: Don't call register_savevm_live() during
 instance_init()
Content-Language: en-US
To: quintela@redhat.com
Cc: qemu-devel@nongnu.org, Christian Borntraeger <borntraeger@linux.ibm.com>, 
 qemu-s390x@nongnu.org, Halil Pasic <pasic@linux.ibm.com>,
 Eric Farman <farman@linux.ibm.com>, David Hildenbrand <david@redhat.com>,
 Claudio Imbrenda <imbrenda@linux.ibm.com>
References: <20231020150554.664422-1-thuth@redhat.com>
 <87lebtshf8.fsf@secure.mitica>
From: Thomas Huth <thuth@redhat.com>
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <87lebtshf8.fsf@secure.mitica>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On 23/10/2023 13.32, Juan Quintela wrote:
> Thomas Huth <thuth@redhat.com> wrote:
>> We must not call register_savevm_live() during instance_init()
>> since instances can be created at any time, e.g. during introspection
>> of a device. We must register the savevm handler during realize()
>> instead. Fix it now in the s390x devices.
>>
>> v2:
>> - Fixed bug in the third patch ("sas" -> "dev")
>> - Add an early return in case of error in the third patch
>> - Added Acked-by/Reviewed by from David and Eric (thanks!)
>>
>> Thomas Huth (3):
>>    hw/s390x/s390-skeys: Don't call register_savevm_live() during
>>      instance_init()
>>    hw/s390x/s390-stattrib: Simplify handling of the "migration-enabled"
>>      property
>>    hw/s390x/s390-stattrib: Don't call register_savevm_live() during
>>      instance_init()
>>
>>   hw/s390x/s390-skeys.c    | 35 ++++++-------------------
>>   hw/s390x/s390-stattrib.c | 55 +++++++++++++++-------------------------
>>   2 files changed, 29 insertions(+), 61 deletions(-)
> 
> Acked-by: Juan Quintela <quintela@redhat.com>
> 
> It makes things work for my test, Thanks.
> 
> Should I get those through the migration tree?

Sure, if you plan to do a pull request soon, feel free to take them!
(Otherwise I'll queue them for my next s390x pull request ... likely not 
happening within the next two weeks, though)

  Thomas



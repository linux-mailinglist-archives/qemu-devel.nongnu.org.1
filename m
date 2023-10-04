Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CB2AE7B85ED
	for <lists+qemu-devel@lfdr.de>; Wed,  4 Oct 2023 18:56:27 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qo59t-0001K7-8w; Wed, 04 Oct 2023 12:55:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1qo59o-0000z3-BS
 for qemu-devel@nongnu.org; Wed, 04 Oct 2023 12:55:32 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1qo59i-0002KN-4v
 for qemu-devel@nongnu.org; Wed, 04 Oct 2023 12:55:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1696438522;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=g+s58d1+N5ZPTbUVytwnDyYfn5yyRaUY9AGeaEeidbM=;
 b=AULb92xmy/wXY+pQYcIUVLDVzY9LlJvE18KWTc+Mvz3xI8RUa8iUJHHrvf/1/ZbVSHZ4qF
 tT/68kRK52hf/7vvhJqUVW5yRjCMC+lrxm4VznznUxsVBeOx35Ff78TlH4bnduodusprhE
 S33qoMfPY2QApD5pL2ZPYsBkxBtfC1U=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-679-9eSKKRfGNKWD9Ltots_Guw-1; Wed, 04 Oct 2023 12:55:21 -0400
X-MC-Unique: 9eSKKRfGNKWD9Ltots_Guw-1
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-774309ff5e2so1167485a.1
 for <qemu-devel@nongnu.org>; Wed, 04 Oct 2023 09:55:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696438520; x=1697043320;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=g+s58d1+N5ZPTbUVytwnDyYfn5yyRaUY9AGeaEeidbM=;
 b=emgb8ZE+gi8vAR5x71P3oUeuZxLYSx5Mi0C0X5T/7jt+JricvSK1bWgsBXuyMAukAz
 IhiknWOQVgVKmXveTqzLD+2xxrbsD+H3tLBb7n72AzHBuB1qO8UPNxpl8Z++04Hn+Ray
 0BNpT/Qmtf/lt37Tpcj1SR0u6VxVkzmGRTBdMbPthFltHfmZ3ENlyk+EPYUyfLUBj7UX
 JIQTA8uynVS18l1YKvhrumspGWPcW2OToFPOjgn274VMTGO4amyY2X0277M9MT/BR5nk
 /HWkxIG8shsHEU7A7jjmhJ2RQtms6PbyRdnU9nskxe5lmucv+/4Eujq5czrj+gMghy7A
 A3KQ==
X-Gm-Message-State: AOJu0Yw3gFkVX3XImdkr+p0xyJ+m7jSoonNWmsi4v6WSjo57sZPlD4dC
 KS0Y9B4WP3y7rXxz8pT/ipoI0JwntWOV8nBhAgDeEXcRCe5n4/oZBmrOSPlTYXD2BTtUuNJizwa
 kKLmIIYnOuV/hLbM=
X-Received: by 2002:a05:620a:22f5:b0:774:1adc:c572 with SMTP id
 p21-20020a05620a22f500b007741adcc572mr2708001qki.74.1696438520543; 
 Wed, 04 Oct 2023 09:55:20 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEPz/yEqDhrkOzy+LqgcZzc+1gTUd+KeXPiLVeXpqlRlaK6tnx497EKamVNsR21LZ+l7JAYRw==
X-Received: by 2002:a05:620a:22f5:b0:774:1adc:c572 with SMTP id
 p21-20020a05620a22f500b007741adcc572mr2707987qki.74.1696438520310; 
 Wed, 04 Oct 2023 09:55:20 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:9db0:474c:ff43:9f5c?
 ([2a01:e0a:280:24f0:9db0:474c:ff43:9f5c])
 by smtp.gmail.com with ESMTPSA id
 o23-20020a05620a131700b00772662b7804sm1387993qkj.100.2023.10.04.09.55.18
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 04 Oct 2023 09:55:19 -0700 (PDT)
Message-ID: <52120fe3-1647-1513-b005-f5099c16a862@redhat.com>
Date: Wed, 4 Oct 2023 18:55:17 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v3 13/15] vfio/common: Store the parent container in
 VFIODevice
Content-Language: en-US
To: eric.auger@redhat.com, eric.auger.pro@gmail.com, qemu-devel@nongnu.org,
 zhenzhong.duan@intel.com, alex.williamson@redhat.com, jgg@nvidia.com,
 nicolinc@nvidia.com, joao.m.martins@oracle.com, peterx@redhat.com,
 kevin.tian@intel.com, yi.l.liu@intel.com, yi.y.sun@intel.com,
 chao.p.peng@intel.com, mjrosato@linux.ibm.com
References: <20231003101530.288864-1-eric.auger@redhat.com>
 <20231003101530.288864-14-eric.auger@redhat.com>
 <79fb6650-783c-f9d7-4294-668bebe23fe0@redhat.com>
 <4098f81f-bb7c-bbcb-4d73-04e3981a08f5@redhat.com>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@redhat.com>
In-Reply-To: <4098f81f-bb7c-bbcb-4d73-04e3981a08f5@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-1.528, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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


Hello Eric,


>>> @@ -2664,7 +2665,12 @@ void vfio_detach_device(VFIODevice *vbasedev)
>>>    {
>>>        VFIOGroup *group = vbasedev->group;
>>>    +    if (!vbasedev->container) {
>>> +        return;
>>> +    }
>>
>> Can this happen ? Should it be an assert ?
>
> I don't think so. Let me simply drop the check.

the device-introspect-test needs it. No need to resend a v5, I can add it
back in v4 if you are ok with that.


Thanks,

C.



Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E068C7D8028
	for <lists+qemu-devel@lfdr.de>; Thu, 26 Oct 2023 11:59:48 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qvx88-00089s-3e; Thu, 26 Oct 2023 05:58:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1qvx84-00089b-MH
 for qemu-devel@nongnu.org; Thu, 26 Oct 2023 05:58:16 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1qvx83-0005v8-96
 for qemu-devel@nongnu.org; Thu, 26 Oct 2023 05:58:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1698314292;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=y+DalL7KzzgZJHZE/10krEqMLrahnJY7jaDU4f8BBpE=;
 b=ZYhTVYL8a7grs17xUPaBn1Aic/NmbiWraTmHt6bb4rwxuECIBuD4CARIaeT3hgLIj6y+mC
 QEdI8DIwux+vbshQo10pJjsCYOnORbcRPRBo4UJeQinBvL33mHH75YrH6Y+eieikr64zOS
 XE/IuKG2UNzoV1OaH8NqM4g3fZsbK9I=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-120-3ag_QKTqNKyQEM8V2MNZNg-1; Thu, 26 Oct 2023 05:58:09 -0400
X-MC-Unique: 3ag_QKTqNKyQEM8V2MNZNg-1
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-7788fa5f1b0so103675785a.2
 for <qemu-devel@nongnu.org>; Thu, 26 Oct 2023 02:58:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698314289; x=1698919089;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=y+DalL7KzzgZJHZE/10krEqMLrahnJY7jaDU4f8BBpE=;
 b=I4x0OjX+DfQfZI+vOxAw90RpCPuF4gRui6+aGcVXT+sGWZ8dnKZb5z/GsO7Doy8U8v
 rM8EvdaJ1416LFM0xtwHDWwvuaKWWdZrrWorVhZfTKPR/V1dHyEQ3Muxt+JR1Voged6W
 Ba1Y9Wc584R7F8xuOtGzNruSfAFQYrAVGeJPntyRbBfp1/LzAkiy6tn5b6h1Lc7cPGB9
 O29qwEYr9ApI5yqqux8tdaZxZGM2z9u2QEEjKo8igMmVcJA3igMT2jrQySk/J8CAtkTC
 F1UGRMUI9+FVPuzFzXm4pqKsdeNOYwr3grA5XaUze7xcUpJ+y6DaIXX277m9ZpN6PmZ8
 8FgA==
X-Gm-Message-State: AOJu0Ywe6cr9wATHV+h4j7CJbDKt6hTkQCbKbCrVtqheleMMDisMIssJ
 x+ogqoCWfwwAUhLpXpJA24HLuQw4/eSnueOK7uG/UH++MqZZzu4liELNwrssRG6EfGUym8zu1yN
 +g7ShdMsrucVtJGc=
X-Received: by 2002:a05:620a:1309:b0:778:9148:3c2c with SMTP id
 o9-20020a05620a130900b0077891483c2cmr15709582qkj.18.1698314288862; 
 Thu, 26 Oct 2023 02:58:08 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEgMVlYNinK2/egZ6yK7pG5K5sMfSLet1wOM2mNLsVwhzSM7ThNHbEpyuSj4obl9rU9e8K0gQ==
X-Received: by 2002:a05:620a:1309:b0:778:9148:3c2c with SMTP id
 o9-20020a05620a130900b0077891483c2cmr15709569qkj.18.1698314288575; 
 Thu, 26 Oct 2023 02:58:08 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:9e2:9000:b215:e40:e078:4b27?
 ([2a01:e0a:9e2:9000:b215:e40:e078:4b27])
 by smtp.gmail.com with ESMTPSA id
 n13-20020a05620a222d00b0077a02b8b504sm532316qkh.52.2023.10.26.02.58.05
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 26 Oct 2023 02:58:07 -0700 (PDT)
Message-ID: <bad03ec1-049c-46e2-a4da-dd2d6d88bad1@redhat.com>
Date: Thu, 26 Oct 2023 11:58:04 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/3] vfio/pci: Fix buffer overrun when writing the VF
 token
Content-Language: en-US
To: "Denis V. Lunev" <den@virtuozzo.com>, qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>, "Denis V . Lunev"
 <den@openvz.org>, Kevin Wolf <kwolf@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>, Stefan Weil <sw@weilnetz.de>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 "Maciej S . Szmigiero" <maciej.szmigiero@oracle.com>,
 Fam Zheng <fam@euphon.net>, Juan Quintela <quintela@redhat.com>,
 Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Leonardo Bras <leobras@redhat.com>
References: <20231026070636.1165037-1-clg@redhat.com>
 <5d9ab399-c5b2-41cd-9f2d-73d478e3c72a@virtuozzo.com>
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
In-Reply-To: <5d9ab399-c5b2-41cd-9f2d-73d478e3c72a@virtuozzo.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -5
X-Spam_score: -0.6
X-Spam_bar: /
X-Spam_report: (-0.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SORBS_WEB=1.5, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On 10/26/23 10:41, Denis V. Lunev wrote:
> On 10/26/23 09:06, Cédric Le Goater wrote:
>> Hello,
>>
>> This series fixes a buffer overrun in VFIO. The buffer used in
>> vfio_realize() by qemu_uuid_unparse() is too small, UUID_FMT_LEN lacks
>> one byte for the trailing NUL.
>>
>> Instead of adding + 1, as done elsewhere, the changes introduce a
>> UUID_STR_LEN define for the correct size and use it where required.
>>
>> Thanks,
>>
>> C.
>>
>> Changes in v2:
>>   - removal of UUID_FMT_LEN
>>
>> Cédric Le Goater (3):
>>    util/uuid: Add UUID_STR_LEN definition
>>    vfio/pci: Fix buffer overrun when writing the VF token
>>    util/uuid: Remove UUID_FMT_LEN
>>
>>   include/qemu/uuid.h              | 2 +-
>>   block/parallels-ext.c            | 2 +-
>>   block/vdi.c                      | 2 +-
>>   hw/core/qdev-properties-system.c | 2 +-
>>   hw/hyperv/vmbus.c                | 4 ++--
>>   hw/vfio/pci.c                    | 2 +-
>>   migration/savevm.c               | 4 ++--
>>   tests/unit/test-uuid.c           | 2 +-
>>   util/uuid.c                      | 2 +-
>>   9 files changed, 11 insertions(+), 11 deletions(-)
>>
> Reviwed-by: Denis V. Lunev <den@openvz.org>

I changed that to "Reviewed-by".

Interesting to see that b4 was ok with this new tag.

Thanks,

C.



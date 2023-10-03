Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 40B3A7B6A12
	for <lists+qemu-devel@lfdr.de>; Tue,  3 Oct 2023 15:17:32 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qnfGb-0007sP-Gi; Tue, 03 Oct 2023 09:16:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1qnfGZ-0007qh-Aw
 for qemu-devel@nongnu.org; Tue, 03 Oct 2023 09:16:47 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1qnfGX-0001US-Ik
 for qemu-devel@nongnu.org; Tue, 03 Oct 2023 09:16:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1696339004;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+bWcOMINY2DyosxwYYRHJoRwaNiugsZstLCOluNwiJk=;
 b=UGKJm/QTz3MVjCpM5KZGOGCGczN7pC1gBOt8aAGz5RUaS7wSiE32PuOctkDoobtOGEACoj
 Ao03eTsCuZwzO7zOlEbueyqeHAe0V5TSH1d8bQTXmm0LuXV3cUX738aDxW17+GscwNxW2L
 2OMnsUzv+I1SgU67nPsPjYi807575L4=
Received: from mail-oo1-f70.google.com (mail-oo1-f70.google.com
 [209.85.161.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-605-GoWH7R38N4msLuJ6xjZ3vg-1; Tue, 03 Oct 2023 09:16:43 -0400
X-MC-Unique: GoWH7R38N4msLuJ6xjZ3vg-1
Received: by mail-oo1-f70.google.com with SMTP id
 006d021491bc7-57badc96ba6so1154967eaf.2
 for <qemu-devel@nongnu.org>; Tue, 03 Oct 2023 06:16:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696339002; x=1696943802;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=+bWcOMINY2DyosxwYYRHJoRwaNiugsZstLCOluNwiJk=;
 b=CvlNxmAxaV51BCQCydMT87sr6rt04FWNPzXjwgG3FQuzAhWmVgPqQXcKNu2nMrjD4Q
 qQQCE/IV+bVpCGpoZZgYB60F0l+82ICNu/LCRWo1hv54Por1OXHjuQFJSFDOGTOFN9bC
 M7pHmHwUIldumFhZmzCnI83HJp4qCHX60rm4fBBEP+2ENDgFeKnefz9jVGP22JltFMPy
 AhWCMnriBXbBD/Ph/74plU8zBlbjavh08Zq8km1FGsH1gPtvtmxUUZtFm8Cqz58eKAOT
 6lENwpZ+p5KE6JSKeqNzWhQqc9DGy6dCyGORqeNpnxM4MV94F4y68gR7tCabyYx6ilbh
 oM6w==
X-Gm-Message-State: AOJu0Yz4j8I/1WY6SwQdLkwenmrZE7/cNQR331KTM+d0fnnQNS1XWo4x
 WrItaMkpjGS78xA0c3XO5VHBS2UWWMLvZKAS5Bqg2cz40AX8l8vOiVRmP+FFkQeiml/txmFpGbz
 /Qy1Ldq/waxCa0v0=
X-Received: by 2002:a05:6358:e49c:b0:143:9bc0:a975 with SMTP id
 by28-20020a056358e49c00b001439bc0a975mr16398721rwb.7.1696339002416; 
 Tue, 03 Oct 2023 06:16:42 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEUZN5qeZf5MehIW7JBWH/P0B49kzsNdH4foPXxjKufuJHWjVUePR5aAkS1wZy7FZg56+BoWA==
X-Received: by 2002:a05:6358:e49c:b0:143:9bc0:a975 with SMTP id
 by28-20020a056358e49c00b001439bc0a975mr16398700rwb.7.1696339002102; 
 Tue, 03 Oct 2023 06:16:42 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:59e:9d80:527b:9dff:feef:3874?
 ([2a01:e0a:59e:9d80:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 ka23-20020a05622a441700b0040ff6194ef3sm429544qtb.70.2023.10.03.06.16.40
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 03 Oct 2023 06:16:41 -0700 (PDT)
Message-ID: <250c14cc-6eba-3ad2-9247-b71316d6ad50@redhat.com>
Date: Tue, 3 Oct 2023 15:16:38 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] vhost: Add a defensive check in vhost_commit against
 wrong deallocation
Content-Language: en-US
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: eric.auger.pro@gmail.com, qemu-devel@nongnu.org, jasowang@redhat.com,
 lvivier@redhat.com
References: <20230913074657.523530-1-eric.auger@redhat.com>
 <20231003084047-mutt-send-email-mst@kernel.org>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <20231003084047-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -31
X-Spam_score: -3.2
X-Spam_bar: ---
X-Spam_report: (-3.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-1.09, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
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
Reply-To: eric.auger@redhat.com
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

Hi Michael,

On 10/3/23 14:43, Michael S. Tsirkin wrote:
> On Wed, Sep 13, 2023 at 09:46:57AM +0200, Eric Auger wrote:
>> In vhost_commit(), it may happen that dev->mem_sections and
>> dev->tmp_sections are equal,
> Could you please explain a bit more how this can happen?
> I don't see how.
>
>> in which case, unconditionally
>> freeing old_sections at the end of the function will also free
>> dev->mem_sections used on subsequent call leading to a segmentation
>> fault.
>>
>> Check this situation before deallocating memory.
>>
>> Signed-off-by: Eric Auger <eric.auger@redhat.com>
>> Fixes: c44317efecb2 ("vhost: Build temporary section list and deref
>> after commit")
>> CC: QEMU Stable <qemu-stable@nongnu.org>
>>
>> ---
>>
>> This SIGSEV condition can be reproduced with
>> https://lore.kernel.org/all/20230904080451.424731-1-eric.auger@redhat.com/#r
>> This is most probably happening in a situation where the memory API is
>> used in a wrong manner but well.
> sounds like misusing the memory API can lead to all kind of mischief.
This happened in a situation where I resized an [IOMMU] MR within the
VFIO vfio_listener_region_add leading to recursive calls ot region_add
callbacks.
The issue is it was not straightforward to find the link with vhost.

Thanks

Eric
>
>> ---
>>  hw/virtio/vhost.c | 5 +++++
>>  1 file changed, 5 insertions(+)
>>
>> diff --git a/hw/virtio/vhost.c b/hw/virtio/vhost.c
>> index e2f6ffb446..c02c599ef0 100644
>> --- a/hw/virtio/vhost.c
>> +++ b/hw/virtio/vhost.c
>> @@ -545,6 +545,11 @@ static void vhost_commit(MemoryListener *listener)
>>      dev->mem_sections = dev->tmp_sections;
>>      dev->n_mem_sections = dev->n_tmp_sections;
>>  
>> +    if (old_sections == dev->mem_sections) {
>> +        assert(n_old_sections ==  dev->n_mem_sections);
>> +        return;
>> +    }
>> +
>>      if (dev->n_mem_sections != n_old_sections) {
>>          changed = true;
>>      } else {
>> -- 
>> 2.41.0



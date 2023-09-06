Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6521A793F0E
	for <lists+qemu-devel@lfdr.de>; Wed,  6 Sep 2023 16:38:02 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qdtf6-0006hG-6G; Wed, 06 Sep 2023 10:37:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1qdtf4-0006aM-6y
 for qemu-devel@nongnu.org; Wed, 06 Sep 2023 10:37:42 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1qdtf1-0006LN-U4
 for qemu-devel@nongnu.org; Wed, 06 Sep 2023 10:37:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1694011059;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=lg2fMO06PnQXvtf+z6WSmsHkPqrM9ZYU8QTTgt0YWXQ=;
 b=ERKRAldWV71Crxd7M/NHhpJUzk0VS8YnWPA76b/rO9+FyNw9zk1ohVsD8cIPt/yU5H/lXt
 RBIA1KaKNQ0x2vM9nNEGR0IW8RHJKfKdgI+YL3AcXNq0E9XtUTrgVFnyZIU8ExSbB3TpBC
 xaTmVExdPRWkwLjsVhTCwcA/FVrp2H0=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-459-Koxi_cTTPgygDHGGdVaYGA-1; Wed, 06 Sep 2023 10:37:37 -0400
X-MC-Unique: Koxi_cTTPgygDHGGdVaYGA-1
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-31c879c41f4so2081239f8f.2
 for <qemu-devel@nongnu.org>; Wed, 06 Sep 2023 07:37:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1694011056; x=1694615856;
 h=content-transfer-encoding:in-reply-to:organization:references:cc:to
 :from:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=lg2fMO06PnQXvtf+z6WSmsHkPqrM9ZYU8QTTgt0YWXQ=;
 b=PLHKXwbqYKDlFyouHGETfU3SgFXtE/7E3XpWJqAvHhpZHqy3IfmrvvEXPofnZqSPJB
 2EgeWXZXdpvqeeH2eeJPqhoCZgDVqfW7qdSFK+IDJ++bqP0mhrtNAae9fE2xuteOuQS2
 Doh99nkUnfd6MqlOZtYPGaAbDd4rXkjuTvlt0A+2dJ+/sap+8NxqA/7ffEM5t7jbgG+d
 RLJKkVhcYZF73cTFuOFc0oMpUcMS5gm5T5M3SVST83PXCtdPe5Pz7ozaO60t293NaWv3
 FXlueyyHwgDHRfZMLcnONuJnhS63EoDthD4ep7YOQLpn+s9/qm2HIBEadWauYygqjVzb
 XJpg==
X-Gm-Message-State: AOJu0Yxn/u9Z7CiJ1mcHC0iokP4r/qRqrR/hhKVS9dLAAt/o17xccVv/
 VYPVvAp+JbEjWe7KJY2kqHMUau7SmWS58dwD9fIfm/aSzfMgiICndqvxf6Sq47breveem38DzZY
 5okWVzOF0AD6ZEZ8=
X-Received: by 2002:adf:dc8c:0:b0:317:5351:e428 with SMTP id
 r12-20020adfdc8c000000b003175351e428mr2259895wrj.4.1694011056322; 
 Wed, 06 Sep 2023 07:37:36 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE6FP2trIpa9SyMRqQVDHpkv6KR2bWRmBHizszpCaWuoC2c7TXCDXjhpfQSjz/N58+wSW/0iw==
X-Received: by 2002:adf:dc8c:0:b0:317:5351:e428 with SMTP id
 r12-20020adfdc8c000000b003175351e428mr2259886wrj.4.1694011055968; 
 Wed, 06 Sep 2023 07:37:35 -0700 (PDT)
Received: from ?IPV6:2003:cb:c70c:6c00:92a4:6f8:ff7e:6853?
 (p200300cbc70c6c0092a406f8ff7e6853.dip0.t-ipconnect.de.
 [2003:cb:c70c:6c00:92a4:6f8:ff7e:6853])
 by smtp.gmail.com with ESMTPSA id
 j17-20020a5d5651000000b003197efd1e7bsm20671464wrw.114.2023.09.06.07.37.34
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 06 Sep 2023 07:37:35 -0700 (PDT)
Message-ID: <de45c2d4-13b6-d022-e32a-ea5296e04b1d@redhat.com>
Date: Wed, 6 Sep 2023 16:37:34 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v2 04/16] kvm: Return number of free memslots
Content-Language: en-US
From: David Hildenbrand <david@redhat.com>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Igor Mammedov <imammedo@redhat.com>, 
 Xiao Guangrong <xiaoguangrong.eric@gmail.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Peter Xu <peterx@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Yanan Wang <wangyanan55@huawei.com>, Michal Privoznik <mprivozn@redhat.com>,
 =?UTF-8?Q?Daniel_P_=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 Gavin Shan <gshan@redhat.com>, Alex Williamson <alex.williamson@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 "Maciej S . Szmigiero" <mail@maciej.szmigiero.name>, kvm@vger.kernel.org
References: <20230825132149.366064-1-david@redhat.com>
 <20230825132149.366064-5-david@redhat.com>
 <1d68ca74-ce92-ca5f-2c8b-e4567265e2fc@linaro.org>
 <ee1bbc2b-3180-ab79-4f0d-6159577b2164@redhat.com>
Organization: Red Hat
In-Reply-To: <ee1bbc2b-3180-ab79-4f0d-6159577b2164@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=david@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-1.473, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
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

On 06.09.23 16:14, David Hildenbrand wrote:
> On 29.08.23 00:26, Philippe Mathieu-Daudé wrote:
>> On 25/8/23 15:21, David Hildenbrand wrote:
>>> Let's return the number of free slots instead of only checking if there
>>> is a free slot. While at it, check all address spaces, which will also
>>> consider SMM under x86 correctly.
>>>
>>> Make the stub return UINT_MAX, such that we can call the function
>>> unconditionally.
>>>
>>> This is a preparation for memory devices that consume multiple memslots.
>>>
>>> Signed-off-by: David Hildenbrand <david@redhat.com>
>>> ---
>>>     accel/kvm/kvm-all.c      | 33 ++++++++++++++++++++-------------
>>>     accel/stubs/kvm-stub.c   |  4 ++--
>>>     hw/mem/memory-device.c   |  2 +-
>>>     include/sysemu/kvm.h     |  2 +-
>>>     include/sysemu/kvm_int.h |  1 +
>>>     5 files changed, 25 insertions(+), 17 deletions(-)
>>
>>
>>> diff --git a/accel/stubs/kvm-stub.c b/accel/stubs/kvm-stub.c
>>> index 235dc661bc..f39997d86e 100644
>>> --- a/accel/stubs/kvm-stub.c
>>> +++ b/accel/stubs/kvm-stub.c
>>> @@ -109,9 +109,9 @@ int kvm_irqchip_remove_irqfd_notifier_gsi(KVMState *s, EventNotifier *n,
>>>         return -ENOSYS;
>>>     }
>>>     
>>> -bool kvm_has_free_slot(MachineState *ms)
>>> +unsigned int kvm_get_free_memslots(void)
>>>     {
>>> -    return false;
>>> +    return UINT_MAX;
>>
>> Isn't it clearer returning 0 here and keeping kvm_enabled() below?
> 
> I tried doing it similarly to vhost_has_free_slot().
> 

I'll leave the kvm_enabled() check in place, looks cleaner.

-- 
Cheers,

David / dhildenb



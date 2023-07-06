Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E1C9749A95
	for <lists+qemu-devel@lfdr.de>; Thu,  6 Jul 2023 13:28:38 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qHN9N-0001gM-70; Thu, 06 Jul 2023 07:27:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1qHN9L-0001g8-U8
 for qemu-devel@nongnu.org; Thu, 06 Jul 2023 07:27:51 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1qHN9J-00051v-Vm
 for qemu-devel@nongnu.org; Thu, 06 Jul 2023 07:27:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1688642867;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=UgUCMAvQmgyZUKrP52mCTFcPPq4PYhhi1hoGBse5uDo=;
 b=Yq8K0onf6FFx+UIalcHc8LjybvCtnrZwdWdukkpEr/VIWKfMtN5Mfjnx0mQq2jPBcGfOTx
 Yjmo7bDiobHhBrasr8DG7XpF3/PLk2t1mvnpiGlDNNSvj0wxctsszfFX9aw8lfUMnHxVgf
 EvY5scSoNXyvMh8pwP1B8cPSUJ9NYyE=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-581-uWUw2LOWOaudJDyJkhQhdQ-1; Thu, 06 Jul 2023 07:27:46 -0400
X-MC-Unique: uWUw2LOWOaudJDyJkhQhdQ-1
Received: by mail-lf1-f70.google.com with SMTP id
 2adb3069b0e04-4edbdd8268bso562601e87.2
 for <qemu-devel@nongnu.org>; Thu, 06 Jul 2023 04:27:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688642864; x=1691234864;
 h=content-transfer-encoding:in-reply-to:subject:organization:from
 :references:cc:to:content-language:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=UgUCMAvQmgyZUKrP52mCTFcPPq4PYhhi1hoGBse5uDo=;
 b=W2eop4uBRd/HpHQk/eqALEs8uIkaEAhntzfWvhnQ+/oRdBiQiEHif7XHDqIHtMgaMf
 4Maf9ykppjNnowWE2H0n7z3d/50jpZcNE7WDV6HHFe1+FDbpZEMubt66Xc1H4s6ICtOl
 FIr6Lv5+3uDGVgBsaX0zceeuqbW9IKmToD1Y//NAm1kgef3tTQeQ6z0ao9EOqdoMZ4wX
 X9R5EeFXFukJ4abKm9UzmEg3FeAPa/fjG0l1VIlyGfDPR/gkme5W16ulxNv/FR2tL4lT
 4YOCLEVnZhsXoG88QuMb2khht1rhNWFDqZQtdMbvGKUrx8G8eg5IfhbJvW9QlaopxQwZ
 7NzQ==
X-Gm-Message-State: ABy/qLZM28EsoFSbvLcKvDkuv9ygEUduLTbP51Wn5xEiauCFruBvWoX3
 yxFcqXKAySo7H2UApp5sNDLORSf01hQFXTcH8TxkIoyp5v68n8y5/PIDDW4aPDPwDY6Zzgo9vLl
 M8jHCrubX/XyvRG8=
X-Received: by 2002:a05:6512:ad6:b0:4fb:89e3:5ac4 with SMTP id
 n22-20020a0565120ad600b004fb89e35ac4mr1395008lfu.66.1688642864248; 
 Thu, 06 Jul 2023 04:27:44 -0700 (PDT)
X-Google-Smtp-Source: APBJJlFPaRFz+/PV0zhT86Anp/iKbsOpdHps0eFYhp86oYg2quwdKa+P1Lk0zfdzOLh+6E86lbuIgw==
X-Received: by 2002:a05:6512:ad6:b0:4fb:89e3:5ac4 with SMTP id
 n22-20020a0565120ad600b004fb89e35ac4mr1394993lfu.66.1688642863820; 
 Thu, 06 Jul 2023 04:27:43 -0700 (PDT)
Received: from ?IPV6:2a09:80c0:192:0:5dac:bf3d:c41:c3e7?
 ([2a09:80c0:192:0:5dac:bf3d:c41:c3e7])
 by smtp.gmail.com with ESMTPSA id
 n12-20020adfe78c000000b00314367cf43asm1626335wrm.106.2023.07.06.04.27.43
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 06 Jul 2023 04:27:43 -0700 (PDT)
Message-ID: <f30c1439-b7bd-172a-b01a-f7c16d838465@redhat.com>
Date: Thu, 6 Jul 2023 13:27:42 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Content-Language: en-US
To: quintela@redhat.com
Cc: qemu-devel@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>,
 Peter Xu <peterx@redhat.com>, Leonardo Bras <leobras@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>,
 Peng Tao <tao.peng@linux.alibaba.com>, Mario Casquero <mcasquer@redhat.com>
References: <20230706075612.67404-1-david@redhat.com>
 <20230706075612.67404-5-david@redhat.com> <875y6xb8pj.fsf@secure.mitica>
From: David Hildenbrand <david@redhat.com>
Organization: Red Hat
Subject: Re: [PATCH v2 4/4] virtio-mem: Support "x-ignore-shared" migration
In-Reply-To: <875y6xb8pj.fsf@secure.mitica>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=david@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.091, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On 06.07.23 13:06, Juan Quintela wrote:
> David Hildenbrand <david@redhat.com> wrote:
>> To achieve desired "x-ignore-shared" functionality, we should not
>> discard all RAM when realizing the device and not mess with
>> preallocation/postcopy when loading device state. In essence, we should
>> not touch RAM content.
>>
>> As "x-ignore-shared" gets set after realizing the device, we cannot
>> rely on that. Let's simply skip discarding of RAM on incoming migration.
>> Note that virtio_mem_post_load() will call
>> virtio_mem_restore_unplugged() -- unless "x-ignore-shared" is set. So
>> once migration finished we'll have a consistent state.
>>
>> The initial system reset will also not discard any RAM, because
>> virtio_mem_unplug_all() will not call virtio_mem_unplug_all() when no
>> memory is plugged (which is the case before loading the device state).
>>
>> Note that something like VM templating -- see commit b17fbbe55cba
>> ("migration: allow private destination ram with x-ignore-shared")
> 
> And here I am, I reviewed the patch, and 4 years later I don't remember
> anything about it O:-)

:)

[...]

>> +    /*
>> +     * If shared RAM is migrated using the file content and not using QEMU,
>> +     * don't mess with preallocation and postcopy.
>> +     */
>> +    if (migrate_ram_is_ignored(vmem->memdev->mr.ram_block)) {
>> +        return 0;
>> +    }
>> +
>> +    if (vmem->prealloc && !vmem->early_migration) {
>> +        warn_report("Proper preallocation with migration requires a newer QEMU machine");
>> +    }
>> +
> 
> Could you explain why you are putting the check after calling
> virtio_mem_notify_populate_cb()?
> 
> What is it expected to for file memory backed RAM?  I got lost when I
> saw that it just calls:
> 
> static int virtio_mem_notify_populate_cb(MemoryRegionSection *s, void *arg)
> {
>      RamDiscardListener *rdl = arg;
> 
>      return rdl->notify_populate(rdl, s);
> }
> 
> 
> I end in vfio, and got completely confused about what is going on there.


:)


Once we reached virtio_mem_post_load(), we restored the bitmap that 
contains the state of all device blocks (plugged vs. unplugged).

Whenever we modify the bitmap (plug / unplug), we have to notify 
(RamDiscardManager) listeners, such that they are aware of the state 
change and can perform according action.

For example, vfio will go ahead and register the newly plugged blocks 
with the kernel (DMA map it into the vfio), where the kernel will end up 
long-term pinning these pages. Effectively, we only end up DMA-mapping 
plugged memory blocks, so only these get pinned by the kernel (and we 
can actually release the memory of unplugged blocks).


So here (virtio_mem_post_load()), we just restored the bitmap from the 
migration stream and effectively went from 0 plugged blocks (bitmap 
empty) before migration to "maybe some plugged blocks in the bitmap".

So we go over the bitmap and tell the world (vfio) to go ahead and 
DMA-map these blocks that are suddenly plugged.


And that part is independent of the actual RAM migration / 
x-ignore-shared, sow have to do it unconditional.



Thanks for the thorough review!

-- 
Cheers,

David / dhildenb



Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DE705749795
	for <lists+qemu-devel@lfdr.de>; Thu,  6 Jul 2023 10:38:42 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qHKVG-0004Yz-Iq; Thu, 06 Jul 2023 04:38:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1qHKVE-0004Yi-PU
 for qemu-devel@nongnu.org; Thu, 06 Jul 2023 04:38:16 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1qHKVD-0008Mb-4I
 for qemu-devel@nongnu.org; Thu, 06 Jul 2023 04:38:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1688632694;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Fnzxx0FjlCL8P9+nk9oJvNm0Zgo5W8HDK3UIFTwch5A=;
 b=DbG4jP3qPZE5IVIDWyRYGpt09VmUEJoZjriKLPIuYdFN95Ng8HQhKYolvDVdZ8qxoeMl9f
 whHKlkWInf8kVLDcCop72oCy1th6jdw9EwVvUhoaFG/HM2X1tJ+LTVhAONt6mPgYHOtXL0
 At9T2Wi5mEQ6+bxoAkD1nSIOVImsslM=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-328-GfSH4Z87PRay2EF2Il6HiA-1; Thu, 06 Jul 2023 04:38:13 -0400
X-MC-Unique: GfSH4Z87PRay2EF2Il6HiA-1
Received: by mail-lf1-f71.google.com with SMTP id
 2adb3069b0e04-4fb748a83b4so194950e87.2
 for <qemu-devel@nongnu.org>; Thu, 06 Jul 2023 01:38:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688632691; x=1691224691;
 h=content-transfer-encoding:in-reply-to:subject:organization:from
 :references:cc:to:content-language:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Fnzxx0FjlCL8P9+nk9oJvNm0Zgo5W8HDK3UIFTwch5A=;
 b=HQIHOqWWndpB0kYZ+hekXNQZBeEDvBFZAnJig+CYk/RBibsUq9LZK98QMvV5gVZAJo
 /auHw1b+rOez80w/PSMKY8yeUCv4tnTgBLPNGM+KgY0FwlB13wXlLW+E9AaXggm8ir+k
 zW/h0vUM2i58A99yVdy+JHecjsVOdO7GWVoH8/HR1Jafbg2ShIXpwjgt43r3C0TPGZfu
 DGIXk6A3NeDVOwhuQS3+jTX7dQWVSS1Mn9+nhkhTfSrsmUnWfVFPvGZwbhU43dRK9qlJ
 NpgOk0oUx/zVzIwqvqLEbq2DBPTsSFTEXUbb1cMAtK3dHJRVIGzso0QNr5pF9oLQSDe/
 G01A==
X-Gm-Message-State: ABy/qLZQypf6myYPADanCMqCl/uR4FXcytR2sHJpe1UgOc6CDLDgZfAw
 5RQNgMdwNzFfr/lRkpMLXRLYZGV6uG4PgdZb7h+ptU05mnMSbdT+4xtsJkIxoIwQ3fnFTcnUKsh
 QxJELtVLMyvKNhNY=
X-Received: by 2002:a05:6512:3157:b0:4f8:7617:6445 with SMTP id
 s23-20020a056512315700b004f876176445mr879814lfi.48.1688632691554; 
 Thu, 06 Jul 2023 01:38:11 -0700 (PDT)
X-Google-Smtp-Source: APBJJlG8XzbGHVDxf+BykaVxoHiEK69JWxH8R0iOqeGq6f/HxT0lfDwcJ7LryILlPEwdrkj40Vl9BQ==
X-Received: by 2002:a05:6512:3157:b0:4f8:7617:6445 with SMTP id
 s23-20020a056512315700b004f876176445mr879789lfi.48.1688632691164; 
 Thu, 06 Jul 2023 01:38:11 -0700 (PDT)
Received: from ?IPV6:2a09:80c0:192:0:5dac:bf3d:c41:c3e7?
 ([2a09:80c0:192:0:5dac:bf3d:c41:c3e7])
 by smtp.gmail.com with ESMTPSA id
 t19-20020a7bc3d3000000b003fb739d27aesm4398333wmj.35.2023.07.06.01.38.10
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 06 Jul 2023 01:38:10 -0700 (PDT)
Message-ID: <02c15d72-b29f-b0da-42a6-f77040d4f8ab@redhat.com>
Date: Thu, 6 Jul 2023 10:38:09 +0200
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
 <20230706075612.67404-3-david@redhat.com> <87fs61bglq.fsf@secure.mitica>
From: David Hildenbrand <david@redhat.com>
Organization: Red Hat
Subject: Re: [PATCH v2 2/4] virtio-mem: Skip most of virtio_mem_unplug_all()
 without plugged memory
In-Reply-To: <87fs61bglq.fsf@secure.mitica>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=david@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.089, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
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

On 06.07.23 10:15, Juan Quintela wrote:
> David Hildenbrand <david@redhat.com> wrote:
>> Already when starting QEMU we perform one system reset that ends up
>> triggering virtio_mem_unplug_all() with no actual memory plugged yet.
>> That, in turn will trigger ram_block_discard_range() and perform some
>> other actions that are not required in that case.
>>
>> Let's optimize virtio_mem_unplug_all() for the case that no memory is
>> plugged. This will be beneficial for x-ignore-shared support as well.
>>
>> Tested-by: Mario Casquero <mcasquer@redhat.com>
>> Signed-off-by: David Hildenbrand <david@redhat.com>
> 
> It works, so ...
> 
> Reviewed-by: Juan Quintela <quintela@redhat.com>

Thanks!

[...]

>> +        bitmap_clear(vmem->bitmap, 0, vmem->bitmap_size);
>>           vmem->size = 0;
>>           notifier_list_notify(&vmem->size_change_notifiers, &vmem->size);
>>       }
>> +
>>       trace_virtio_mem_unplugged_all();
>>       virtio_mem_resize_usable_region(vmem, vmem->requested_size, true);
>>       return 0;
> 
> Once that we are here.  Do you remember _why_ do we allow virtio-mem
> plug/unplug in the middle of a migration.
> 
> We forbid to plug/unplug everything else.  Why do we need to plug/unplug
> virtio-mem during migration?

With virtio-mem you tell the VM the desired size for the device 
(requested-size), and the VM will select blocks to (un)plug and send 
(un)plug requests to the hypervisor in order to reach the requested size.

So changing the requested size in the hypervisor (by the QEMU user) and 
the VM processing that resize request is asynchronous -- similar to 
memory ballooning.

As the VM can send these (un)plug requests any time, and we exactly 
don't want to allow (un)plug during migration, we have 
virtio_mem_is_busy() to reject any such requests to tell the VM "please 
try again later".

-- 
Cheers,

David / dhildenb



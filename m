Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C2D5C80A2AF
	for <lists+qemu-devel@lfdr.de>; Fri,  8 Dec 2023 12:53:35 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rBZP1-0002z3-BT; Fri, 08 Dec 2023 06:52:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1rBZOz-0002yD-GQ
 for qemu-devel@nongnu.org; Fri, 08 Dec 2023 06:52:17 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1rBZOx-0004F2-O9
 for qemu-devel@nongnu.org; Fri, 08 Dec 2023 06:52:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1702036333;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=3FC2fMkSj7t/aKoSEFNC7g8QI3PSapfBcOBg37QM8Uk=;
 b=WbUV+P40uyrRryEzApHxeyL/sP1wfcHviNIyABpPG4QLRUA6DveMFj00xf4psVjxKpgJYB
 8aulG1abzb7B0J7gHqtJfNi6t6HJherswFgknhISjrvQo633ncsQui0/2Y41qmm24jOR0Y
 e99PVznNrW0Za8n4quzLZEIk3s2gIW0=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-28-myhBIpMiNQmdqSNVdShbjA-1; Fri, 08 Dec 2023 06:52:12 -0500
X-MC-Unique: myhBIpMiNQmdqSNVdShbjA-1
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-3334e7d1951so1698574f8f.3
 for <qemu-devel@nongnu.org>; Fri, 08 Dec 2023 03:52:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702036331; x=1702641131;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
 :references:cc:to:content-language:subject:user-agent:mime-version
 :date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3FC2fMkSj7t/aKoSEFNC7g8QI3PSapfBcOBg37QM8Uk=;
 b=s86FDiQyBGd6JIM22Pm1tTiQj3/xc/WwfG6/vxlQo5E92Mqr6xWjX9EpfFZy+RY+MD
 YquBzsXmEKMOqOzKzIpcwimOw/ifwGoP+Pbi0F2tKJBpVTdtqIT0NH+1KGAF1Z5+YPT4
 JSx4hsNHYQIF49jmXNXnHkmXaCRzCqTeTsUb6RB2AELzsS7f6ElHyfKQXGJ259sgSpj3
 ipqqQR8btQj5/zOEfoju1heA0FoQb9g/KZqTdfA7kkG08Vxna0XNaTBU+wt+9NdZ0k+J
 vCBoFJycTD54s/ksz/qzzu52R5rAkXUIfOxfuGUVcJmQOikCHLrvSUfOarnJjJNxsA7c
 IS4w==
X-Gm-Message-State: AOJu0YyZl0H2Q/TQVp3ut9SKesl8x0vL+AIqb6p20m43+FXYcgyNbCT2
 1Aztjmx03DZ5dMy36kLK4/71uLR5+mYlba5xwT+zAJcgv35Rce4h9lI+yC764x65aFiOCFVsROm
 kvlxnzDIoZ1ychTg=
X-Received: by 2002:a5d:4382:0:b0:32d:9d99:d0a5 with SMTP id
 i2-20020a5d4382000000b0032d9d99d0a5mr1203895wrq.5.1702036331193; 
 Fri, 08 Dec 2023 03:52:11 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFCmqGAVma4HSVGEhMTDYvNAlnnl3d64tSTTFQkzxK7NmqmSMNZza6+X+hc9ahz+ea4545kkg==
X-Received: by 2002:a5d:4382:0:b0:32d:9d99:d0a5 with SMTP id
 i2-20020a5d4382000000b0032d9d99d0a5mr1203879wrq.5.1702036330761; 
 Fri, 08 Dec 2023 03:52:10 -0800 (PST)
Received: from ?IPV6:2003:cb:c724:2100:3826:4f41:d72c:dc1b?
 (p200300cbc724210038264f41d72cdc1b.dip0.t-ipconnect.de.
 [2003:cb:c724:2100:3826:4f41:d72c:dc1b])
 by smtp.gmail.com with ESMTPSA id
 c3-20020a056000104300b003332faefd86sm1937513wrx.0.2023.12.08.03.52.08
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 08 Dec 2023 03:52:10 -0800 (PST)
Message-ID: <0dc03b42-23c3-4e02-868e-289b3fedf6af@redhat.com>
Date: Fri, 8 Dec 2023 12:52:07 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 09/70] physmem: Introduce ram_block_convert_range() for
 page conversion
Content-Language: en-US
To: Xiaoyao Li <xiaoyao.li@intel.com>,
 Isaku Yamahata <isaku.yamahata@linux.intel.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Igor Mammedov <imammedo@redhat.com>, 
 "Michael S . Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Peter Xu <peterx@redhat.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, Cornelia Huck <cohuck@redhat.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Marcelo Tosatti <mtosatti@redhat.com>, qemu-devel@nongnu.org,
 kvm@vger.kernel.org, Michael Roth <michael.roth@amd.com>,
 Sean Christopherson <seanjc@google.com>, Claudio Fontana <cfontana@suse.de>,
 Gerd Hoffmann <kraxel@redhat.com>, Isaku Yamahata
 <isaku.yamahata@gmail.com>, Chenyi Qiang <chenyi.qiang@intel.com>,
 isaku.yamahata@intel.com
References: <20231115071519.2864957-1-xiaoyao.li@intel.com>
 <20231115071519.2864957-10-xiaoyao.li@intel.com>
 <20231117210304.GC1645850@ls.amr.corp.intel.com>
 <8f20d060-38fe-49d7-8fea-fe665c3c6c78@intel.com>
From: David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <8f20d060-38fe-49d7-8fea-fe665c3c6c78@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=david@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On 08.12.23 08:59, Xiaoyao Li wrote:
> On 11/18/2023 5:03 AM, Isaku Yamahata wrote:
>> On Wed, Nov 15, 2023 at 02:14:18AM -0500,
>> Xiaoyao Li <xiaoyao.li@intel.com> wrote:
>>
>>> It's used for discarding opposite memory after memory conversion, for
>>> confidential guest.
>>>
>>> When page is converted from shared to private, the original shared
>>> memory can be discarded via ram_block_discard_range();
>>>
>>> When page is converted from private to shared, the original private
>>> memory is back'ed by guest_memfd. Introduce
>>> ram_block_discard_guest_memfd_range() for discarding memory in
>>> guest_memfd.
>>>
>>> Originally-from: Isaku Yamahata <isaku.yamahata@intel.com>
>>> Codeveloped-by: Xiaoyao Li <xiaoyao.li@intel.com>
>>> Signed-off-by: Xiaoyao Li <xiaoyao.li@intel.com>
>>> ---
>>>    include/exec/cpu-common.h |  2 ++
>>>    system/physmem.c          | 50 +++++++++++++++++++++++++++++++++++++++
>>>    2 files changed, 52 insertions(+)
>>>
>>> diff --git a/include/exec/cpu-common.h b/include/exec/cpu-common.h
>>> index 41115d891940..de728a18eef2 100644
>>> --- a/include/exec/cpu-common.h
>>> +++ b/include/exec/cpu-common.h
>>> @@ -175,6 +175,8 @@ typedef int (RAMBlockIterFunc)(RAMBlock *rb, void *opaque);
>>>    
>>>    int qemu_ram_foreach_block(RAMBlockIterFunc func, void *opaque);
>>>    int ram_block_discard_range(RAMBlock *rb, uint64_t start, size_t length);
>>> +int ram_block_convert_range(RAMBlock *rb, uint64_t start, size_t length,
>>> +                            bool shared_to_private);
>>>    
>>>    #endif
>>>    
>>> diff --git a/system/physmem.c b/system/physmem.c
>>> index ddfecddefcd6..cd6008fa09ad 100644
>>> --- a/system/physmem.c
>>> +++ b/system/physmem.c
>>> @@ -3641,6 +3641,29 @@ err:
>>>        return ret;
>>>    }
>>>    
>>> +static int ram_block_discard_guest_memfd_range(RAMBlock *rb, uint64_t start,
>>> +                                               size_t length)
>>> +{
>>> +    int ret = -1;
>>> +
>>> +#ifdef CONFIG_FALLOCATE_PUNCH_HOLE
>>> +    ret = fallocate(rb->guest_memfd, FALLOC_FL_PUNCH_HOLE | FALLOC_FL_KEEP_SIZE,
>>> +                    start, length);
>>> +
>>> +    if (ret) {
>>> +        ret = -errno;
>>> +        error_report("%s: Failed to fallocate %s:%" PRIx64 " +%zx (%d)",
>>> +                     __func__, rb->idstr, start, length, ret);
>>> +    }
>>> +#else
>>> +    ret = -ENOSYS;
>>> +    error_report("%s: fallocate not available %s:%" PRIx64 " +%zx (%d)",
>>> +                 __func__, rb->idstr, start, length, ret);
>>> +#endif
>>> +
>>> +    return ret;
>>> +}
>>> +
>>>    bool ramblock_is_pmem(RAMBlock *rb)
>>>    {
>>>        return rb->flags & RAM_PMEM;
>>> @@ -3828,3 +3851,30 @@ bool ram_block_discard_is_required(void)
>>>        return qatomic_read(&ram_block_discard_required_cnt) ||
>>>               qatomic_read(&ram_block_coordinated_discard_required_cnt);
>>>    }
>>> +
>>> +int ram_block_convert_range(RAMBlock *rb, uint64_t start, size_t length,
>>> +                            bool shared_to_private)
>>> +{
>>> +    if (!rb || rb->guest_memfd < 0) {
>>> +        return -1;
>>> +    }
>>> +
>>> +    if (!QEMU_PTR_IS_ALIGNED(start, qemu_host_page_size) ||
>>> +        !QEMU_PTR_IS_ALIGNED(length, qemu_host_page_size)) {
>>> +        return -1;
>>> +    }
>>> +
>>> +    if (!length) {
>>> +        return -1;
>>> +    }
>>> +
>>> +    if (start + length > rb->max_length) {
>>> +        return -1;
>>> +    }
>>> +
>>> +    if (shared_to_private) {
>>> +        return ram_block_discard_range(rb, start, length);
>>> +    } else {
>>> +        return ram_block_discard_guest_memfd_range(rb, start, length);
>>> +    }
>>> +}
>>
>> Originally this function issued KVM_SET_MEMORY_ATTRIBUTES, the function name
>> mad sense. But now it doesn't, and it issues only punch hole. We should rename
>> it to represent what it actually does. discard_range?
> 
> ram_block_discard_range() already exists for non-guest-memfd memory discard.
> 
> I cannot come up with a proper name. e.g.,
> ram_block_discard_opposite_range() while *opposite* seems unclear.
> 
> Do you have any better idea?

Having some indication that this is about "guest_memfd" back and forth 
switching/conversion will make sense. But I'm also not able to come up 
with a better name.

Maybe have two functions:

ram_block_activate_guest_memfd_range
ram_block_deactivate_guest_memfd_range

-- 
Cheers,

David / dhildenb



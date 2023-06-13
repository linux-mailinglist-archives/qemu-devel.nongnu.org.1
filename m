Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BF8FE72EA3D
	for <lists+qemu-devel@lfdr.de>; Tue, 13 Jun 2023 19:52:09 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q98An-0008PP-V4; Tue, 13 Jun 2023 13:51:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1q98Ak-0008P9-Bo
 for qemu-devel@nongnu.org; Tue, 13 Jun 2023 13:51:14 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1q98Ai-0002gf-H7
 for qemu-devel@nongnu.org; Tue, 13 Jun 2023 13:51:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1686678671;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=juXhP8h8oDmvEUGxpUcem9DQ8p6SNtDcHFetvbuMc3c=;
 b=i5Nt9ICCQ1m1oH6WFBDNiCY4PXEjofmvtij4k868dCgFk5JqolMXF/1lwOzkei4mCzr3uh
 2w71B1Ju9TNAQi+UpYMqeEEgUA1/OJDPOUwhaFjxZGM3HKYfmz7//Xh8GU6adXgb0ZTkug
 mDwV69eiVuU0H42mDJdq/o8WruJ2ILE=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-488-Op7L_dcVOBmy8uwQh7ofbw-1; Tue, 13 Jun 2023 13:51:09 -0400
X-MC-Unique: Op7L_dcVOBmy8uwQh7ofbw-1
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-30fd136ccb7so289746f8f.3
 for <qemu-devel@nongnu.org>; Tue, 13 Jun 2023 10:51:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686678668; x=1689270668;
 h=content-transfer-encoding:in-reply-to:subject:organization:from
 :references:cc:to:content-language:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=juXhP8h8oDmvEUGxpUcem9DQ8p6SNtDcHFetvbuMc3c=;
 b=PJpAiXmClwZPnBVsxcZj/I4WVrQMXfYRCIqMU26EcybmUsB9txCdxOEf6eT8glAVD2
 y3+jkNChMhKd5D2AuMjLIfJDT4gMRC0SmatCORV9j0mgPJBqCmavtG7HsNCiT180CHAZ
 25CZlI8knVs+Sy1OPPiHmBD0Rr0K6un7BCq0vQRdhYbuKTF0V9WBSh90zWHZaDaq9Tlf
 pizlZXe4lDndadfTRpzY+kV7Tl3B3Hr4USyHv5Nlz/RjwXjyhyQJIzoy86GtZJLwN/sk
 hjuPAkfjCnMVYZ10BPwTmdPQ0nG99xZcCGmmauxswG2aFdn2p22IbEcvlXHYXUttYBCs
 jUww==
X-Gm-Message-State: AC+VfDz3dNkUF1cc/1on3jAHQW2EhqsDI3P0brv3UGpcmce9k0ESebvI
 0KEkHB/vAas5CVkCTXE+o78QFL9ORrL1uojnOxOtb9jsMWR1hkp6mIOJUkIqqxmP+LgAy18aW1T
 ltgeWYzmo9vvLWd4=
X-Received: by 2002:a5d:550f:0:b0:30f:d2a2:4789 with SMTP id
 b15-20020a5d550f000000b0030fd2a24789mr555642wrv.15.1686678667877; 
 Tue, 13 Jun 2023 10:51:07 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ6lyYhUT4jenaM6rLsrwexVg0v9nokG/WYAFV8FGI+Et386/Ww0vCErRFY7lVfu35C1ypzfbg==
X-Received: by 2002:a5d:550f:0:b0:30f:d2a2:4789 with SMTP id
 b15-20020a5d550f000000b0030fd2a24789mr555631wrv.15.1686678667516; 
 Tue, 13 Jun 2023 10:51:07 -0700 (PDT)
Received: from ?IPV6:2003:cb:c710:ff00:1a06:80f:733a:e8c6?
 (p200300cbc710ff001a06080f733ae8c6.dip0.t-ipconnect.de.
 [2003:cb:c710:ff00:1a06:80f:733a:e8c6])
 by smtp.gmail.com with ESMTPSA id
 h4-20020adffa84000000b0030647d1f34bsm15965105wrr.1.2023.06.13.10.51.06
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 13 Jun 2023 10:51:07 -0700 (PDT)
Message-ID: <676ee47d-8ca0-94c4-7454-46e9915ea36a@redhat.com>
Date: Tue, 13 Jun 2023 19:51:05 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Content-Language: en-US
To: "Kasireddy, Vivek" <vivek.kasireddy@intel.com>,
 Mike Kravetz <mike.kravetz@oracle.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-mm@kvack.org" <linux-mm@kvack.org>,
 "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Hugh Dickins <hughd@google.com>
Cc: Gerd Hoffmann <kraxel@redhat.com>, "Kim, Dongwon"
 <dongwon.kim@intel.com>, "Chang, Junxiao" <junxiao.chang@intel.com>,
 "kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>,
 "Hocko, Michal" <mhocko@suse.com>, "jmarchan@redhat.com"
 <jmarchan@redhat.com>, "muchun.song@linux.dev" <muchun.song@linux.dev>,
 James Houghton <jthoughton@google.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 "stable@vger.kernel.org" <stable@vger.kernel.org>
References: <20230608204927.88711-1-mike.kravetz@oracle.com>
 <IA0PR11MB71851B64A5E7062E3BDD8D2FF854A@IA0PR11MB7185.namprd11.prod.outlook.com>
 <281caf4f-25da-3a73-554b-4fb252963035@redhat.com>
 <IA0PR11MB71852D6B27C83658670CBFBDF855A@IA0PR11MB7185.namprd11.prod.outlook.com>
From: David Hildenbrand <david@redhat.com>
Organization: Red Hat
Subject: Re: [PATCH] udmabuf: revert 'Add support for mapping hugepages (v4)'
In-Reply-To: <IA0PR11MB71852D6B27C83658670CBFBDF855A@IA0PR11MB7185.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=david@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.098, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
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

On 13.06.23 10:26, Kasireddy, Vivek wrote:
> Hi David,
> 
>>
>> On 12.06.23 09:10, Kasireddy, Vivek wrote:
>>> Hi Mike,
>>
>> Hi Vivek,
>>
>>>
>>> Sorry for the late reply; I just got back from vacation.
>>> If it is unsafe to directly use the subpages of a hugetlb page, then reverting
>>> this patch seems like the only option for addressing this issue immediately.
>>> So, this patch is
>>> Acked-by: Vivek Kasireddy <vivek.kasireddy@intel.com>
>>>
>>> As far as the use-case is concerned, there are two main users of the
>> udmabuf
>>> driver: Qemu and CrosVM VMMs. However, it appears Qemu is the only
>> one
>>> that uses hugetlb pages (when hugetlb=on is set) as the backing store for
>>> Guest (Linux, Android and Windows) system memory. The main goal is to
>>> share the pages associated with the Guest allocated framebuffer (FB) with
>>> the Host GPU driver and other components in a zero-copy way. To that
>> end,
>>> the guest GPU driver (virtio-gpu) allocates 4k size pages (associated with
>>> the FB) and pins them before sharing the (guest) physical (or dma)
>> addresses
>>> (and lengths) with Qemu. Qemu then translates the addresses into file
>>> offsets and shares these offsets with udmabuf.
>>
>> Is my understanding correct, that we can effectively long-term pin
>> (worse than mlock) 64 MiB per UDMABUF_CREATE, allowing eventually !root
> The 64 MiB limit is the theoretical upper bound that we have not seen hit in
> practice. Typically, for a 1920x1080 resolution (commonly used in Guests),
> the size of the FB is ~8 MB (1920x1080x4). And, most modern Graphics
> compositors flip between two FBs.
> 

Okay, but users with privileges to open that file can just create as 
many as they want? I think I'll have to play with it.

>> users
>>
>> ll /dev/udmabuf
>> crw-rw---- 1 root kvm 10, 125 12. Jun 08:12 /dev/udmabuf
>>
>> to bypass there effective MEMLOCK limit, fragmenting physical memory and
>> breaking swap?
> Right, it does not look like the mlock limits are honored.
> 

That should be added.

>>
>> Regarding the udmabuf_vm_fault(), I assume we're mapping pages we
>> obtained from the memfd ourselves into a special VMA (mmap() of the
> mmap operation is really needed only if any component on the Host needs
> CPU access to the buffer. But in most scenarios, we try to ensure direct GPU
> access (h/w acceleration via gl) to these pages.
> 
>> udmabuf). I'm not sure how well shmem pages are prepared for getting
>> mapped by someone else into an arbitrary VMA (page->index?).
> Most drm/gpu drivers use shmem pages as the backing store for FBs and
> other buffers and also provide mmap capability. What concerns do you see
> with this approach?

Are these mmaping the pages the way udmabuf maps these pages (IOW, 
on-demand fault where we core-mm will adjust the mapcount etc)?

Skimming over at shmem_read_mapping_page() users, I assume most of them 
use a VM_PFNMAP mapping (or don't mmap them at all), where we won't be 
messing with the struct page at all.

(That might even allow you to mmap hugetlb sub-pages, because the struct 
page -- and mapcount -- will be ignored completely and not touched.)

> 
>>
>> ... also, just imagine someone doing FALLOC_FL_PUNCH_HOLE / ftruncate()
>> on the memfd. What's mapped into the memfd no longer corresponds to
>> what's pinned / mapped into the VMA.
> IIUC, making use of the DMA_BUF_IOCTL_SYNC ioctl would help with any
> coherency issues:
> https://www.kernel.org/doc/html/v6.2/driver-api/dma-buf.html#c.dma_buf_sync
> 

Would it as of now? udmabuf_create() pulls the shmem pages out of the 
memfd, not sure how DMA_BUF_IOCTL_SYNC would help to update that 
whenever the pages inside the memfd would change (e.g., 
FALLOC_FL_PUNCH_HOLE + realloc).

But that's most probably simply "not supported".

>>
>>
>> Was linux-mm (and especially shmem maintainers, ccing Hugh) involved in
>> the upstreaming of udmabuf?
> It does not appear so from the link below although other key lists were cc'd:
> https://patchwork.freedesktop.org/patch/246100/?series=39879&rev=7

That's unfortunate :(

-- 
Cheers,

David / dhildenb



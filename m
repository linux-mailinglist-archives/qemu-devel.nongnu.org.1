Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D1914738AD1
	for <lists+qemu-devel@lfdr.de>; Wed, 21 Jun 2023 18:19:10 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qC0Wn-0003lg-78; Wed, 21 Jun 2023 12:17:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1qC0Wg-0003b9-DJ
 for qemu-devel@nongnu.org; Wed, 21 Jun 2023 12:17:48 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1qC0We-0008No-I6
 for qemu-devel@nongnu.org; Wed, 21 Jun 2023 12:17:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1687364262;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8wi4RU7QB1/lbnv1YOA+giWOROtFCLBZBUZY92X/KDs=;
 b=RPOraywNPcZQf/+KPNikmFba0rfLVcSyVbe6um90VZNFgVudt9MY5XY1KciRheDnN8wWYb
 qSi3R9Gs9c8nlsghwhG5gQpAwiCQllf25n7f7vg1rrczzsLSfuF0Zh1yjnEjcl1im76yKQ
 /yhKTVRdRL56FCDhj/v+9z7ayseP3gc=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-472-5zbNgrXjOemOxKtpADqrKQ-1; Wed, 21 Jun 2023 12:17:41 -0400
X-MC-Unique: 5zbNgrXjOemOxKtpADqrKQ-1
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-31118de9a69so2375181f8f.2
 for <qemu-devel@nongnu.org>; Wed, 21 Jun 2023 09:17:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687364259; x=1689956259;
 h=content-transfer-encoding:in-reply-to:subject:organization:from
 :content-language:references:cc:to:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=8wi4RU7QB1/lbnv1YOA+giWOROtFCLBZBUZY92X/KDs=;
 b=AEUl1Yfm+nmLbRvqIFvxsmIiF9DxgD/81gfKB1BNWK9l5iiU9/6D94kvrmNynVcSnj
 lu/mofigiWHpXc0DyFhUob7t5jIFYO8nCDDDR7EfuaOZRMgdeRDvSKO+izZtpr6xOHRd
 3htj1kAxRYd/zDAvjLllhnPzhrv3GBAUDlCRrSY7ehTQnc9kvX3+LYP2s0iOX1+RD2mf
 P73ttUlYT0xV3bJGLN5E2l4XukvRRP8/KFpPfaMJHfrny14Jj8XLaFsvdYRUfW1tr/Dx
 9wgYG+qtHcw+zwK6cqwPjmm1VmsDq+JED7SBu+FK4CYE/Px3CI87H/xkwaarSwTISgGE
 cutQ==
X-Gm-Message-State: AC+VfDxI0I6pd+bzMhh9dyNxsZZDq4Z+BL2X0RFlLwj+v/VDqcyRKVjn
 BjtJP8DiJ3saCLuw61G7rpWOI4ZxoLDA3WIx/7eRgnN5NM9qZy1ERJNnrp5NOdQLesYKihLLBco
 jjXLlUDmvGCDBQX0=
X-Received: by 2002:adf:ffce:0:b0:30f:b045:8b60 with SMTP id
 x14-20020adfffce000000b0030fb0458b60mr10633177wrs.69.1687364259774; 
 Wed, 21 Jun 2023 09:17:39 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ7DTQ017Z5+WoILLsZIwTePFFfTErcOiNihXKNTbs8/ahA0GU8udsa5K67+L5hA+p2cDDHyTQ==
X-Received: by 2002:adf:ffce:0:b0:30f:b045:8b60 with SMTP id
 x14-20020adfffce000000b0030fb0458b60mr10633160wrs.69.1687364259406; 
 Wed, 21 Jun 2023 09:17:39 -0700 (PDT)
Received: from ?IPV6:2003:cb:c70b:9c00:7978:3030:9d9a:1aef?
 (p200300cbc70b9c00797830309d9a1aef.dip0.t-ipconnect.de.
 [2003:cb:c70b:9c00:7978:3030:9d9a:1aef])
 by smtp.gmail.com with ESMTPSA id
 z13-20020adff74d000000b0030af15d7e41sm4935121wrp.4.2023.06.21.09.17.38
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 21 Jun 2023 09:17:38 -0700 (PDT)
Message-ID: <9f7afce0-ff7f-33f8-4f39-bba77f2b2ba4@redhat.com>
Date: Wed, 21 Jun 2023 18:17:37 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>,
 Juan Quintela <quintela@redhat.com>, Leonardo Bras <leobras@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>,
 Peng Tao <tao.peng@linux.alibaba.com>
References: <20230620130354.322180-1-david@redhat.com>
 <20230620130354.322180-2-david@redhat.com> <ZJMdZRoeu9BVm0z8@x1n>
Content-Language: en-US
From: David Hildenbrand <david@redhat.com>
Organization: Red Hat
Subject: Re: [PATCH v1 1/4] softmmu/physmem: Warn with
 ram_block_discard_range() on MAP_PRIVATE file mapping
In-Reply-To: <ZJMdZRoeu9BVm0z8@x1n>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=david@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.093, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
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

On 21.06.23 17:55, Peter Xu wrote:
> On Tue, Jun 20, 2023 at 03:03:51PM +0200, David Hildenbrand wrote:
>> ram_block_discard_range() cannot possibly do the right thing in
>> MAP_PRIVATE file mappings in the general case.
>>
>> To achieve the documented semantics, we also have to punch a hole into
>> the file, possibly messing with other MAP_PRIVATE/MAP_SHARED mappings
>> of such a file.
>>
>> For example, using VM templating -- see commit b17fbbe55cba ("migration:
>> allow private destination ram with x-ignore-shared") -- in combination with
>> any mechanism that relies on discarding of RAM is problematic. This
>> includes:
>> * Postcopy live migration
>> * virtio-balloon inflation/deflation or free-page-reporting
>> * virtio-mem
>>
>> So at least warn that there is something possibly dangerous is going on
>> when using ram_block_discard_range() in these cases.
> 
> The issue is probably valid.
> 
> One thing I worry is when the user (or, qemu instance) exclusively owns the
> file, just forgot to attach share=on, where it used to work perfectly then
> it'll show this warning.  But I agree maybe it's good to remind them just
> to attach the share=on.

For memory-backend-memfd "share=on" is fortunately the default. For 
memory-backend-file it isn't (and in most cases you do want share=on, 
like for hugetlbfs or tmpfs).

Missing the "share=on" for memory-backend-file can have sane use cases, 
but for the common /dev/shm/ case it even results in an undesired 
double-memory consumption (just like memory-backend-memfd,share=off).


> 
> For real private mem users, the warning can of real help, one should
> probably leverage things like file snapshot provided by modern file
> systems, so each VM should just have its own snapshot ram file to use then
> map it share=on I suppose.

Yes, I agree. Although we recently learned that fs-backed VM RAM (SSD) 
performs poorly and will severely wear your SSD severly :(

> 
> For the long term, maybe we should simply support private mem here simply
> by a MADV_DONTNEED.  I assume that's the right semantics for postcopy (just
> need to support MINOR faults, though; MISSING faults definitely will stop
> working.. but for all the rest framework shouldn't need much change), and I
> hope that's also the semantics that balloon/virtio-mem wants here.  Not
> sure whether/when that's strongly needed, assuming the corner case above
> can still be work arounded properly by other means.

I briefly thought about that but came to the conclusion that fixing it 
is not that easy. So I went with the warn.

As documented, ram_block_discard_range() guarantees two things

a) Read 0 after discarding succeeded
b) Make postcopy work by triggering a fault on next access

And if we'd simply want to drop the FALLOC_FL_PUNCH_HOLE:

1) For hugetlb, only newer kernels support MADV_DONTNEED. So there is no 
way to just discard in a private mapping here that works for kernels we 
still care about.

2) free-page-reporting wants to read 0's when re-accessing discarded 
memory. If there is still something there in the file, that won't work.

3) Regarding postcopy on MAP_PRIVATE shmem, I am not sure if it will 
actually do what you want if the pagecache holds a page. Maybe it works, 
but I am not so sure. Needs investigation.


> 
> For now, a warning looks all sane.
> 
>>
>> Signed-off-by: David Hildenbrand <david@redhat.com>
> 
> Acked-by: Peter Xu <peterx@redhat.com>

Thanks!

-- 
Cheers,

David / dhildenb



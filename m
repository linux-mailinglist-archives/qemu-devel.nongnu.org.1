Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 03D3B7616C9
	for <lists+qemu-devel@lfdr.de>; Tue, 25 Jul 2023 13:43:25 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qOGR8-0003IB-K5; Tue, 25 Jul 2023 07:42:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1qOGR3-0003GQ-U8
 for qemu-devel@nongnu.org; Tue, 25 Jul 2023 07:42:37 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1qOGR2-0000AE-4A
 for qemu-devel@nongnu.org; Tue, 25 Jul 2023 07:42:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1690285354;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=igemUwNXL4OXK3VF+6G7lyoN7kejuu69A4ERCRcuiqM=;
 b=VpckfLhruI7Iz1Gj49FYQJJMs/knKvccWjaDUQLbPsdw4Deg7g9hbsM4NWeqs38in7/0DD
 RSU1WC9Lf0WXgqNBSFsqrfuHPmA7TFt+o+oPtbIpP3QJcDwFchp1t6m8HC7/dYFkKyn1xp
 1F2K2amAd7kPrv5Y6u5Fa1fJyfkSQls=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-593-PnGWwuX1MYOxyOvq-n_EyQ-1; Tue, 25 Jul 2023 07:42:33 -0400
X-MC-Unique: PnGWwuX1MYOxyOvq-n_EyQ-1
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-315998d6e7fso2560381f8f.3
 for <qemu-devel@nongnu.org>; Tue, 25 Jul 2023 04:42:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1690285352; x=1690890152;
 h=content-transfer-encoding:in-reply-to:subject:organization:from
 :references:cc:to:content-language:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=igemUwNXL4OXK3VF+6G7lyoN7kejuu69A4ERCRcuiqM=;
 b=EbKvKi9sS7SnORBo8cVRiv/eudQM5VjKvx0BVpSzuvgkYYPm0zR2Dg7Mn6lIX4EJgn
 y2Tr0EgwAawSZXCXEm+56ne0JRpEsu7HNOIXddCBtWt2hx+NgdOJNO6NRAFu6BJ3LNcE
 LVjRcYRfpFdFmlYhGSMWKKfUysJHwKmnu5IvWRGm8J6SongB0OwSTnFA97tGfsDm51b+
 7ad+HsAEVebDd0JLCpXZrfp1osSK7U9K6s/feC24R49YJiqqiddZAyU3zGsdVmREh5F5
 u6PDdivSt6BYG+Wi0l3HaIX/R9sZUy1xm0DZzUDCIIE28MDdzliHNhEfC3NnELbiE5iM
 twfg==
X-Gm-Message-State: ABy/qLZTaJt3ZJjNbwksBXbDBws9/fD+AQamVqJXiVZHG0PnfWVXthzV
 fKw5vzj0mgXicsToxGfsxtve+E6kHFItt/aw8a5lX0GsZc/Q8OFFjfkgg/SuJINMAr86p4A+aDZ
 Qjfvw0a/uS01Arq/bbHEjgLI=
X-Received: by 2002:a5d:638f:0:b0:317:51ff:c249 with SMTP id
 p15-20020a5d638f000000b0031751ffc249mr6112065wru.13.1690285352139; 
 Tue, 25 Jul 2023 04:42:32 -0700 (PDT)
X-Google-Smtp-Source: APBJJlF0vGOaX6GULN8k4/vj8hSXVC8kNnI3C6nOlWc48WaTNhY9kDhEsg398HALT+JN31NeEYYTow==
X-Received: by 2002:a5d:638f:0:b0:317:51ff:c249 with SMTP id
 p15-20020a5d638f000000b0031751ffc249mr6112049wru.13.1690285351735; 
 Tue, 25 Jul 2023 04:42:31 -0700 (PDT)
Received: from ?IPV6:2003:cb:c73f:e900:3b0d:87a6:2953:20d1?
 (p200300cbc73fe9003b0d87a6295320d1.dip0.t-ipconnect.de.
 [2003:cb:c73f:e900:3b0d:87a6:2953:20d1])
 by smtp.gmail.com with ESMTPSA id
 q13-20020adff94d000000b003143c9beeaesm16311305wrr.44.2023.07.25.04.42.31
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 25 Jul 2023 04:42:31 -0700 (PDT)
Message-ID: <5395c9a4-ead5-ad94-c5c6-6128953fdcc8@redhat.com>
Date: Tue, 25 Jul 2023 13:42:30 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Content-Language: en-US
To: Thiner Logoer <logoerthiner1@163.com>, qemu-devel@nongnu.org
Cc: imammedo@redhat.com
References: <20230725105239.2022-1-logoerthiner1@163.com>
From: David Hildenbrand <david@redhat.com>
Organization: Red Hat
Subject: Re: [PATCH] Open file as read only on private mapping in
 qemu_ram_alloc_from_file
In-Reply-To: <20230725105239.2022-1-logoerthiner1@163.com>
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

Hi,

patch subject should start with "softmmu/physmem: Open ..."

On 25.07.23 12:52, Thiner Logoer wrote:
> An read only file can be mapped with read write as long as the
> mapping is private, which is very common case. Make

At least in the environments I know, using private file mappings is a corner case ;)

What is you use case? VM templating?

> qemu_ram_alloc_from_file open file as read only when the
> mapping is private, otherwise open will fail when file
> does not allow write.
> 
> If this file does not exist or is a directory, the flag is not used,
> so it should be OK.
> 
> from https://gitlab.com/qemu-project/qemu/-/issues/1689
> 
> Signed-off-by: Thiner Logoer <logoerthiner1@163.com>
> ---
>   softmmu/physmem.c | 9 ++++++++-
>   1 file changed, 8 insertions(+), 1 deletion(-)
> 
> diff --git a/softmmu/physmem.c b/softmmu/physmem.c
> index 3df73542e1..e8036ee335 100644
> --- a/softmmu/physmem.c
> +++ b/softmmu/physmem.c
> @@ -1945,8 +1945,15 @@ RAMBlock *qemu_ram_alloc_from_file(ram_addr_t size, MemoryRegion *mr,
>       int fd;
>       bool created;
>       RAMBlock *block;
> +

^

.git/rebase-apply/patch:13: trailing whitespace.

> +    /*
> +     * If map is private, the fd does not need to be writable.
> +     * This only get effective when the file is existent.

"This will get ignored if the file does not yet exist."

> +     */
> +    bool open_as_readonly = readonly || !(ram_flags & RAM_SHARED);
>   
> -    fd = file_ram_open(mem_path, memory_region_name(mr), readonly, &created,
> +    fd = file_ram_open(mem_path, memory_region_name(mr),
> +                       open_as_readonly, &created,
>                          errp);
>       if (fd < 0) {
>           return NULL;


Opening a file R/O will also make operations like fallocate/ftruncate/ ... fail.

For example, this will make fallocate(FALLOC_FL_PUNCH_HOLE) stop working and in
turn make ram_block_discard_range() bail out.


There was a recent discussion/patch on that:

commit 1d44ff586f8a8e113379430750b5a0a2a3f64cf9
Author: David Hildenbrand <david@redhat.com>
Date:   Thu Jul 6 09:56:06 2023 +0200

     softmmu/physmem: Warn with ram_block_discard_range() on MAP_PRIVATE file mapping
     
     ram_block_discard_range() cannot possibly do the right thing in
     MAP_PRIVATE file mappings in the general case.
     
     To achieve the documented semantics, we also have to punch a hole into
     the file, possibly messing with other MAP_PRIVATE/MAP_SHARED mappings
     of such a file.
     
     For example, using VM templating -- see commit b17fbbe55cba ("migration:
     allow private destination ram with x-ignore-shared") -- in combination with
     any mechanism that relies on discarding of RAM is problematic. This
     includes:
     * Postcopy live migration
     * virtio-balloon inflation/deflation or free-page-reporting
     * virtio-mem
     
     So at least warn that there is something possibly dangerous is going on
     when using ram_block_discard_range() in these cases.


While it doesn't work "in the general case", it works in the "single file owner" case
where someone simply forgot to specify "share=on" -- "share=off" is the default for
memory-backend-file :( .


For example, with hugetlb+virtio-mem the following works if the file does not exists:

(note that virtio-mem will fallocate(FALLOC_FL_PUNCH_HOLE) the whole file upfront)

...
-object memory-backend-file,share=off,mem-path=/dev/hugepages/vmem0,id=mem2,size=2G \
-device virtio-mem-pci,id=vmem0,memdev=mem2,requested-size=1g,bus=root


With you patch, once the file already exists, we would now get

qemu-system-x86_64: -device virtio-mem-pci,id=vmem0,memdev=mem2,requested-size=1g,bus=root: ram_block_discard_range: Failed to fallocate :0 +80000000 (-9)
qemu-system-x86_64: -device virtio-mem-pci,id=vmem0,memdev=mem2,requested-size=1g,bus=root: Unexpected error discarding RAM: Bad file descriptor


So this has the potential to break existing setups.

The easy fix for these would be to configure "share=on" in these now-failing setups. Hmmmmm ....

-- 
Cheers,

David / dhildenb



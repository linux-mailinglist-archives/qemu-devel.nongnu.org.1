Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BB2C800694
	for <lists+qemu-devel@lfdr.de>; Fri,  1 Dec 2023 10:09:28 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r8zV6-0006yC-Kl; Fri, 01 Dec 2023 04:07:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mprivozn@redhat.com>)
 id 1r8zV4-0006xm-5X
 for qemu-devel@nongnu.org; Fri, 01 Dec 2023 04:07:54 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mprivozn@redhat.com>)
 id 1r8zUp-00059s-6Q
 for qemu-devel@nongnu.org; Fri, 01 Dec 2023 04:07:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1701421657;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=A9eCwdznEfwk6zN1R6l8MArlkRgoou+vOpOnzaUmnys=;
 b=UW668tbAIhCuYOPPvWiV9GWjo19JtUSzDK8yazh+c4hNji4/SrLAKhxzW55nyd8t7rdLOG
 gNDjf/Cs43cxiGDmi/VxT7pkQQ2hnKXkgZuilV5Mv/My3+vdwuxnkYoqY9ZyiqqZ6Vs2q5
 JZLgi9iieQ08BGb0r0Z3lfmc2Y7YIvU=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-677-hMnVxx_FOxGMlk1jflQWeQ-1; Fri, 01 Dec 2023 04:07:35 -0500
X-MC-Unique: hMnVxx_FOxGMlk1jflQWeQ-1
Received: by mail-ed1-f69.google.com with SMTP id
 4fb4d7f45d1cf-54c671c035dso62991a12.1
 for <qemu-devel@nongnu.org>; Fri, 01 Dec 2023 01:07:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701421654; x=1702026454;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=A9eCwdznEfwk6zN1R6l8MArlkRgoou+vOpOnzaUmnys=;
 b=Xsq/UhYNfTA2ZnvvCHy2KZZLm4PiijyKuPmBZ4uyCnwJ8nkLvC8HpwOWeAdZTQ6QsW
 bCcZKmfGgvTx+dGWix1xWzwDNAUDv5aM13ilFwgxQVZTo/W7QWsXjlXPl7j8oZj2eGpK
 1Z2U32abDEHhLwFi77FgCsOKmtFfRTeUV/TQCFf6sSR2tINck/WnsVy4GunWamFlG3Bc
 TLmZwnIyjCNDQ8KiMD9icDY8Oj7MyQgavjgiSvRSASgq86R+QSBSc4qhF95aP1ekXHak
 ISPkXsl9XGDacBrNqhukY4xi7oDvOsU8ECKTFO/6oNNUg4rXA0R6aey6ZkP2+r/cTc0o
 BaIw==
X-Gm-Message-State: AOJu0Yxp/aCnj+wG1dA8JAT7wpg1VC/1xwfyWMPK8E/EHckC0V/TChSc
 b43cpNpAxhzoybolFy+7IMjB8s91LnHIolBCXdFRZMP/rn+U8+AK5FFULMbbNV8gycx+25WbXoH
 Zpo13b7TB8OTI8d0=
X-Received: by 2002:a50:d709:0:b0:54b:a930:b4c4 with SMTP id
 t9-20020a50d709000000b0054ba930b4c4mr479385edi.15.1701421654076; 
 Fri, 01 Dec 2023 01:07:34 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGqXcD6f64HtWANpD1gUxJl4JDbWXgZKvC//HBhaDMyc6NJrFb6Hm10PuI2cgqImV+tN8yyDg==
X-Received: by 2002:a50:d709:0:b0:54b:a930:b4c4 with SMTP id
 t9-20020a50d709000000b0054ba930b4c4mr479377edi.15.1701421653655; 
 Fri, 01 Dec 2023 01:07:33 -0800 (PST)
Received: from [10.43.3.102] (nat-pool-brq-t.redhat.com. [213.175.37.10])
 by smtp.gmail.com with ESMTPSA id
 m14-20020aa7c2ce000000b0054affcfea3csm1443513edp.34.2023.12.01.01.07.32
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 01 Dec 2023 01:07:33 -0800 (PST)
Message-ID: <de569c7a-2e21-4a98-a4a9-98132b43c621@redhat.com>
Date: Fri, 1 Dec 2023 10:07:32 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hostmem: Round up memory size for qemu_madvise() in
 host_memory_backend_memory_complete()
Content-Language: en-US
To: David Hildenbrand <david@redhat.com>, qemu-devel@nongnu.org
Cc: imammedo@redhat.com
References: <f77d641d500324525ac036fe1827b3070de75fc1.1701088320.git.mprivozn@redhat.com>
 <9b8a2863-1264-4058-b367-0b61a75921ac@redhat.com>
 <b9c8b4da-cb14-4a67-b98d-655ed7348bef@redhat.com>
From: =?UTF-8?B?TWljaGFsIFByw612b3puw61r?= <mprivozn@redhat.com>
In-Reply-To: <b9c8b4da-cb14-4a67-b98d-655ed7348bef@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mprivozn@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

On 11/27/23 14:55, David Hildenbrand wrote:
> On 27.11.23 14:37, David Hildenbrand wrote:
>> On 27.11.23 13:32, Michal Privoznik wrote:
>>> Simple reproducer:
>>> qemu.git $ ./build/qemu-system-x86_64 \
>>> -m size=8389632k,slots=16,maxmem=25600000k \
>>> -object
>>> '{"qom-type":"memory-backend-file","id":"ram-node0","mem-path":"/hugepages2M/","prealloc":true,"size":8590983168,"host-nodes":[0],"policy":"bind"}' \
>>> -numa node,nodeid=0,cpus=0,memdev=ram-node0
>>>
>>> With current master I get:
>>>
>>> qemu-system-x86_64: cannot bind memory to host NUMA nodes: Invalid
>>> argument
>>>
>>> The problem is that memory size (8193MiB) is not an integer
>>> multiple of underlying pagesize (2MiB) which triggers a check
>>> inside of madvise(), since we can't really set a madvise() policy
>>> just to a fraction of a page.
>>
>> I thought we would just always fail create something that doesn't really
>> make any sense.
>>
>> Why would we want to support that case?
>>
>> Let me dig, I thought we would have had some check there at some point
>> that would make that fail (especially: RAM block not aligned to the
>> pagesize).
> 
> 
> At least memory-backend-memfd properly fails for that case:
> 
> $ ./build/qemu-system-x86_64 -object
> memory-backend-memfd,hugetlb=on,size=3m,id=tmp
> qemu-system-x86_64: failed to resize memfd to 3145728: Invalid argument
> 
> memory-backend-file ends up creating a new file:
> 
>  $ ./build/qemu-system-x86_64 -object
> memory-backend-file,share=on,mem-path=/dev/hugepages/tmp,size=3m,id=tmp
> 
> $ stat /dev/hugepages/tmp
>   File: /dev/hugepages/tmp
>   Size: 4194304         Blocks: 0          IO Block: 2097152 regular file
> 
> ... and ends up sizing it properly aligned to the huge page size.
> 
> 
> Seems to be due to:
> 
>     if (memory < block->page_size) {
>         error_setg(errp, "memory size 0x" RAM_ADDR_FMT " must be equal to "
>                    "or larger than page size 0x%zx",
>                    memory, block->page_size);
>         return NULL;
>     }
> 
>     memory = ROUND_UP(memory, block->page_size);
> 
>     /*
>      * ftruncate is not supported by hugetlbfs in older
>      * hosts, so don't bother bailing out on errors.
>      * If anything goes wrong with it under other filesystems,
>      * mmap will fail.
>      *
>      * Do not truncate the non-empty backend file to avoid corrupting
>      * the existing data in the file. Disabling shrinking is not
>      * enough. For example, the current vNVDIMM implementation stores
>      * the guest NVDIMM labels at the end of the backend file. If the
>      * backend file is later extended, QEMU will not be able to find
>      * those labels. Therefore, extending the non-empty backend file
>      * is disabled as well.
>      */
>     if (truncate && ftruncate(fd, offset + memory)) {
>         perror("ftruncate");
>     }
> 
> So we create a bigger file and map the bigger file and also have a
> RAMBlock that is bigger. So we'll also consume more memory.
> 
> ... but the memory region is smaller and we tell the VM that it has
> less memory. Lot of work with no obvious benefit, and only some
> memory waste :)
> 
> 
> We better should have just rejected such memory backends right from
> the start. But now it's likely too late.
> 
> I suspect other things like
>  * qemu_madvise(ptr, sz, QEMU_MADV_MERGEABLE);
>  * qemu_madvise(ptr, sz, QEMU_MADV_DONTDUMP);
> 
> fail, but we don't care for hugetlb at least regarding merging
> and don't even log an error.
> 
> But QEMU_MADV_DONTDUMP might also be broken, because that
> qemu_madvise() call will just fail.
> 
> Your fix would be correct. But I do wonder if we want to just let that
> case fail and warn users that they are doing something that doesn't
> make too much sense.
> 

Yeah, what's suspicious is: if the size is smaller than page size we
error out, but if it's larger (but still not aligned) we accept that.
I'm failing to see reasoning there. Looks like the ROUND_UP() was added
in v0.13.0-rc0~1201^2~4 (though it's done with some bit magic) and the
check itself was added in v2.8.0-rc0~30^2~23. So it's a bit late, yes.

OTOH - if users want to waste resources, should we stop them? For
instance, when user requests more vCPUs than physical CPUs a warning is
printed:

$ ./build/qemu-system-x86_64 -accel kvm -smp cpus=128
qemu-system-x86_64: -accel kvm: warning: Number of SMP cpus requested
(128) exceeds the recommended cpus supported by KVM (8)

but that's about it. So maybe the error can be demoted to just a warning?

Michal



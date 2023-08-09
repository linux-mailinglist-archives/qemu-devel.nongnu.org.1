Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B71F8775641
	for <lists+qemu-devel@lfdr.de>; Wed,  9 Aug 2023 11:21:43 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qTfMa-00025t-IX; Wed, 09 Aug 2023 05:20:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1qTfMY-00025i-R1
 for qemu-devel@nongnu.org; Wed, 09 Aug 2023 05:20:18 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1qTfMX-00028u-2S
 for qemu-devel@nongnu.org; Wed, 09 Aug 2023 05:20:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1691572815;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=zX/iOgKNQ1ZCDprwcJjOpDQNjjOW4VtF6d7R5ipwhMc=;
 b=SGTVb1TUv2Vbb3L8Idghy2+cLVAjf7oUtRjl/SnQP2NTtjFBWvhPi2L7Rb9O+K/+Bl0Oi7
 3JPC5MlCOLzfHunMRvNGFC5O9pa9KgppJeT3FS/PL1fPgRdHXp8l9u1ebYmYSeNgpCSXkU
 XyaYTJ2BLZz8dQ6hJb9Pi6+jW5vyVkc=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-408-8QZ-T7WqMnGT4YXZNP6peg-1; Wed, 09 Aug 2023 05:20:14 -0400
X-MC-Unique: 8QZ-T7WqMnGT4YXZNP6peg-1
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-3178532c6c8so3315248f8f.1
 for <qemu-devel@nongnu.org>; Wed, 09 Aug 2023 02:20:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691572813; x=1692177613;
 h=content-transfer-encoding:in-reply-to:subject:organization:from
 :references:cc:to:content-language:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=zX/iOgKNQ1ZCDprwcJjOpDQNjjOW4VtF6d7R5ipwhMc=;
 b=iDlKlyaH+vddw+vP4Lu7T0YmvBMvMGABglfYdJtVIN6+2I7YjYZs8+DkhFPbJGAspa
 HmQ9oBW6FHlhCOwTTvpjGngXZcKZCW38UoBj+lRrRnW0wuVc82JiHVkOo68cCC3XpE2v
 fSR0GiKFUOWIk+ciBn0NkIZM1OJxoi0c4veZF3JkV+UzqKfDASWOFsnQEsiRQcoK3RGm
 E8xdW5hAl2y4FGAco/cbD4J/Zj0UfOSR/Y4a0YTnPaQ3DGiKwNc+rS8Pn3fkgphU0Y0u
 NmukjKmlrWFWfzJRvZ99KtKSXi3gfn5Eq1NvNtR3pDOhmEI9DX+ex5fkLIemXrkyKcFo
 LP9Q==
X-Gm-Message-State: AOJu0YyOwwARTWE35TTQuC9cGwXOmzsh0TWNdqKaPq8/VnCWkq87kgds
 1JQKNdfLrFieiYzk7pHwn3VRXyLKuqHEpJv+4HiGfHwyyGE/F1Mteief1R8HnortieXIX21HQ52
 SunFNi9f8LOeV9Fk=
X-Received: by 2002:adf:b613:0:b0:313:fbd0:9810 with SMTP id
 f19-20020adfb613000000b00313fbd09810mr1480255wre.4.1691572812867; 
 Wed, 09 Aug 2023 02:20:12 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGLh5N09ODRhrOr7dcifO++fvxRqr704Gy/AN01XA7kmDehLnvK96Nk9jgeA2vRfPEdnWl2rw==
X-Received: by 2002:adf:b613:0:b0:313:fbd0:9810 with SMTP id
 f19-20020adfb613000000b00313fbd09810mr1480242wre.4.1691572812436; 
 Wed, 09 Aug 2023 02:20:12 -0700 (PDT)
Received: from ?IPV6:2003:cb:c70e:6800:9933:28db:f83a:ef5?
 (p200300cbc70e6800993328dbf83a0ef5.dip0.t-ipconnect.de.
 [2003:cb:c70e:6800:9933:28db:f83a:ef5])
 by smtp.gmail.com with ESMTPSA id
 j6-20020adff006000000b00317b0155502sm16205446wro.8.2023.08.09.02.20.11
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 09 Aug 2023 02:20:11 -0700 (PDT)
Message-ID: <1d1a7d8f-6260-5905-57ea-514b762ce869@redhat.com>
Date: Wed, 9 Aug 2023 11:20:11 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Content-Language: en-US
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>, Thiner Logoer <logoerthiner1@163.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
References: <20230807190736.572665-1-david@redhat.com>
 <20230807190736.572665-2-david@redhat.com> <ZNKtHVotkfgI1tb4@x1n>
From: David Hildenbrand <david@redhat.com>
Organization: Red Hat
Subject: Re: [PATCH v1 1/3] softmmu/physmem: fallback to opening guest RAM
 file as readonly in a MAP_PRIVATE mapping
In-Reply-To: <ZNKtHVotkfgI1tb4@x1n>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=david@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -61
X-Spam_score: -6.2
X-Spam_bar: ------
X-Spam_report: (-6.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-4.14, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
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

Hi Peter!

>> -    fd = file_ram_open(mem_path, memory_region_name(mr), readonly, &created,
>> -                       errp);
>> +    fd = file_ram_open(mem_path, memory_region_name(mr), readonly, &created);
>> +    if (fd == -EACCES && !(ram_flags & RAM_SHARED) && !readonly) {
>> +        /*
>> +         * We can have a writable MAP_PRIVATE mapping of a readonly file.
>> +         * However, some operations like ftruncate() or fallocate() might fail
>> +         * later, let's warn the user.
>> +         */
>> +        fd = file_ram_open(mem_path, memory_region_name(mr), true, &created);
>> +        if (fd >= 0) {
>> +            warn_report("backing store %s for guest RAM (MAP_PRIVATE) opened"
>> +                        " readonly because the file is not writable", mem_path);
> 
> I can understand the use case, but this will be slightly unwanted,
> especially the user doesn't yet have a way to predict when will it happen.

Users can set the file permissions accordingly I guess. If they don't 
want the file to never ever be modified via QEMU, set it R/O.

> 
> Meanwhile this changes the behavior, is it a concern that someone may want
> to rely on current behavior of failing?

The scenario would be that someone passes a readonly file to "-mem-path" 
or "-object memory-backend-file,share=off,readonly=off", with the 
expectation that it would currently fail.

If it now doesn't fail (and we warn instead), what would happen is:
* In file_ram_alloc() we won't even try ftruncate(), because the file
   already had a size > 0. So ftruncate() is not a concern as I now
   realize.
* fallocate might fail later. AFAIKS, that only applies to
   ram_block_discard_range().
  -> virtio-mem performs an initial ram_block_discard_range() check and
     fails gracefully early.
  -> virtio-ballooon ignores any errors
  -> ram_discard_range() in migration code fails early for postcopy in
     init_range() and loadvm_postcopy_ram_handle_discard(), handling it
     gracefully.

So mostly nothing "bad" would happen, it might just be undesirable, and 
we properly warn.

Most importantly, we won't be corrupting/touching the original file in 
any case, because it is R/O.

If we really want to be careful, we could clue that behavior to compat 
machines. I'm not really sure yet if we really have to go down that path.

Any other alternatives? I'd like to avoid new flags where not really 
required.

> 
> To think from a higher level of current use case, the ideal solution seems
> to me that if the ram file can be put on a file system that supports CoW
> itself (like btrfs), we can snapshot that ram file and make it RW for the
> qemu instance. Then here it'll be able to open the file.  We'll be able to
> keep the interface working as before, meanwhile it'll work with fallocate
> or truncations too I assume.
> 
> Would that be better instead of changing QEMU?

As I recently learned, using file-backed VMs (on real ssd/disks, not 
shmem/hugetlb) is usually undesired, because the dirtied pages will 
constantly get rewritten to disk by background writeback threads, 
eventually resulting in bad performance and SSD wear.

So while using a COW filesystem sounds cleaner in theory, it's not 
applicable in practice -- unless one disables any background writeback, 
which has different side effects because it cannot be configured on a 
per-file basis.

So for VM templating, it makes sense to capture the guest RAM and store 
it in a file, to then use a COW (MAP_PRIVATE) mapping. Using a read-only 
file makes perfect sense in that scenario IMHO.

[I'm curious at what point a filesystem will actually break COW. if it's 
wired up to the writenotify infrastructure, it would happen when 
actually writing to a page, not at mmap time. I know that filesystems 
use writenotify for lazy allocation of disk blocks on file holes, maybe 
they also do that for lazy allocation of disk blocks on COW]

Thanks!

-- 
Cheers,

David / dhildenb



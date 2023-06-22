Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 814CC73A18C
	for <lists+qemu-devel@lfdr.de>; Thu, 22 Jun 2023 15:11:46 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qCK5o-00071c-VQ; Thu, 22 Jun 2023 09:11:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1qCK5j-00071S-0Z
 for qemu-devel@nongnu.org; Thu, 22 Jun 2023 09:11:17 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1qCK5h-0008CB-Hh
 for qemu-devel@nongnu.org; Thu, 22 Jun 2023 09:11:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1687439472;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=n89m/SrAH6JVNZOGhqPJ9Vqr0FQk728C112jp9EjiPs=;
 b=HOU217XVATpHfRpto6190zKXoK+5dujK73WE4hlncmdkjndN2ecjRVM3CVI0tJwo1Md0wV
 4bJ9vzGCkQDqQjuNfZmroQ7n7agL2vAkLgwVTamAaxfK04tcdLBV6DusoFamrWigBrvVuM
 Ij6M1/EQhSjXT34T9QudXhoT1FKIJcY=
Received: from mail-lf1-f70.google.com (209.85.167.70 [209.85.167.70]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-553-9ukxONAUPSWoiW1msBOnOg-1; Thu,
 22 Jun 2023 09:10:56 -0400
X-MC-Unique: 9ukxONAUPSWoiW1msBOnOg-1
Received: by mail-lf1-f70.google.com with SMTP id
 2adb3069b0e04-4f3932e595dso5241074e87.1
 for <qemu-devel@nongnu.org>; Thu, 22 Jun 2023 06:10:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687439450; x=1690031450;
 h=content-transfer-encoding:in-reply-to:organization:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=n89m/SrAH6JVNZOGhqPJ9Vqr0FQk728C112jp9EjiPs=;
 b=JHfTYE3jzesF+LNvDTHsjcn4RK5ZJEBNJN9wjm7VF0816VvyP+dFyVMnV96vrfpa3l
 /JMHbgs2066QnCrLFTkCh5FW++SgV/69w5pCoLNykhquN4JV/9XVXXKDplsm9YHY/kDn
 dftrtg57UJXQxPpoDLBGZ4B2DDafgCWCJlNT4wXWrptLUhAChNvUfQpRIUrphhhSbiSI
 fwI4eaBqJLgRtmKz4pX0k7zMilnjikG0eEFgrZJE6DrNy1DiP15RBBIlN3jTVAT+pi75
 8ZCvOEmAnig8/4SV8KOgIDUnWV57fo5EaJOt+k5iWJ6aPMvdYDmsKzVs//NsuSdwi29W
 XudA==
X-Gm-Message-State: AC+VfDwthu5rQ3R/mdb0XHLqK0L8oqBmUZr0n5x9UBXx9dWzHVyQdAda
 x3wWUvfSTfidR3gzPgkOAK5ZudI/pLfXM/ZuVQlhGivtM/NdkZ4Nzj6BEyjXLn/EUKXgmUSvPIb
 sVA3OAq9B+stjN+k=
X-Received: by 2002:a05:6512:614:b0:4f8:7489:f1e5 with SMTP id
 b20-20020a056512061400b004f87489f1e5mr1789365lfe.38.1687439449777; 
 Thu, 22 Jun 2023 06:10:49 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ50jtgRPVpOE3dsPE77V/Vqqv44BPBXyfVI+cDcmFH/H1XEW/Jnjbd0BGP26mQFqNSOaNZl+A==
X-Received: by 2002:a05:6512:614:b0:4f8:7489:f1e5 with SMTP id
 b20-20020a056512061400b004f87489f1e5mr1789341lfe.38.1687439449397; 
 Thu, 22 Jun 2023 06:10:49 -0700 (PDT)
Received: from ?IPV6:2003:cb:c71a:c00:a3d3:85e8:742c:2e9?
 (p200300cbc71a0c00a3d385e8742c02e9.dip0.t-ipconnect.de.
 [2003:cb:c71a:c00:a3d3:85e8:742c:2e9])
 by smtp.gmail.com with ESMTPSA id
 f20-20020a7bcd14000000b003f7f2a1484csm7720491wmj.5.2023.06.22.06.10.48
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 22 Jun 2023 06:10:48 -0700 (PDT)
Message-ID: <0c2d7680-4aa4-9d88-7cc7-62dc3b9535a1@redhat.com>
Date: Thu, 22 Jun 2023 15:10:47 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v1 1/4] softmmu/physmem: Warn with
 ram_block_discard_range() on MAP_PRIVATE file mapping
Content-Language: en-US
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>,
 Juan Quintela <quintela@redhat.com>, Leonardo Bras <leobras@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>,
 Peng Tao <tao.peng@linux.alibaba.com>
References: <20230620130354.322180-1-david@redhat.com>
 <20230620130354.322180-2-david@redhat.com> <ZJMdZRoeu9BVm0z8@x1n>
 <9f7afce0-ff7f-33f8-4f39-bba77f2b2ba4@redhat.com> <ZJMrhgEbzYUyt1KH@x1n>
From: David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <ZJMrhgEbzYUyt1KH@x1n>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=david@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.09, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
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

On 21.06.23 18:55, Peter Xu wrote:
> On Wed, Jun 21, 2023 at 06:17:37PM +0200, David Hildenbrand wrote:
>> As documented, ram_block_discard_range() guarantees two things
>>
>> a) Read 0 after discarding succeeded
>> b) Make postcopy work by triggering a fault on next access
>>
>> And if we'd simply want to drop the FALLOC_FL_PUNCH_HOLE:
>>
>> 1) For hugetlb, only newer kernels support MADV_DONTNEED. So there is no way
>> to just discard in a private mapping here that works for kernels we still
>> care about.
>>
>> 2) free-page-reporting wants to read 0's when re-accessing discarded memory.
>> If there is still something there in the file, that won't work.
> 
> Ah right.  The semantics is indeed slightly different..
> 
> IMHO, ideally here we need a zero page installed as private, ignoring the
> page cache underneath, freeing any possible private page.  But I just don't
> know how to do that easily with current default mm infrastructures, or
> free-page-reporting over private mem seems just won't really work at all,
> it seems to me.
> 
> Maybe.. UFFDIO_ZEROPAGE would work? We need uffd registered by default, but
> that's slightly tricky.

Maybe ... depends also on the uffd semantics as in 3).

> 
>>
>> 3) Regarding postcopy on MAP_PRIVATE shmem, I am not sure if it will
>> actually do what you want if the pagecache holds a page. Maybe it works, but
>> I am not so sure. Needs investigation.
> 
> For MINOR I think it will.  I actually already implemented some of that (I
> think, all of that is required) in the HGM qemu rfc series, and smoked it a
> bit without any known issue yet with the HGM kernel.
> 
> IIUC we can work on MINOR support without HGM; I can separate it out.  It's
> really a matter of whether it'll be worthwhile the effort and time.

Yes, MINOR might work. But especially postcopy doesn't make too much 
sense targeting a private mapping that has some other pages in there 
already ... so it might not be worth the trouble I guess.

-- 
Cheers,

David / dhildenb



Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 940369C8589
	for <lists+qemu-devel@lfdr.de>; Thu, 14 Nov 2024 10:04:17 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tBVkW-0004PG-GM; Thu, 14 Nov 2024 04:02:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1tBVkT-0004P2-98
 for qemu-devel@nongnu.org; Thu, 14 Nov 2024 04:02:45 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1tBVkR-000436-L6
 for qemu-devel@nongnu.org; Thu, 14 Nov 2024 04:02:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1731574962;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=fk0q/jRGDLHMbe3Ex0vyqxLPpSz1wJ/DZ790vQfoea4=;
 b=OaiGbHjmWmyCdxIiVmhhy5C8YOtchHRXHHoMpgwM1qfLEGjqpd2tYi1Um8arsI4Hw4VapM
 I43RL7LMjkuw0N+2WjpphCwTBsm0AxMgnGhcfbzZ2R93ncCFx2efw+EQCXsQKASjdbcyRu
 YRlxDPlk1t/TwL1eHG7Rcb3Z1ttA12k=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-75-DjBvh-AbPB2442g3DS_qxg-1; Thu, 14 Nov 2024 04:02:40 -0500
X-MC-Unique: DjBvh-AbPB2442g3DS_qxg-1
X-Mimecast-MFC-AGG-ID: DjBvh-AbPB2442g3DS_qxg
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-4315cefda02so3450565e9.0
 for <qemu-devel@nongnu.org>; Thu, 14 Nov 2024 01:02:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731574959; x=1732179759;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:from:references:cc:to:subject:user-agent
 :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to;
 bh=fk0q/jRGDLHMbe3Ex0vyqxLPpSz1wJ/DZ790vQfoea4=;
 b=wS2PwAMis/+ueA0o/pcnmHXgyC+nwB8BwJcBHorWN2fV1I4tqsnAUNCmbibcuFZCS1
 cI1LXXEF0kt1zaZk5pll9dd+B0fIp82SB3YUHrfdsjPsiXAVmVHGNrN82kA7MY8aRSqo
 Num+JJS+FpzPMJo7uriZkXCPUl50mpJIWDwnGe0ba9THZwwwG9+UgrfKNTnmVXFUrHqV
 mpNPA7xEy3gnIcVx8hdFoD/FBTbtZFSAOirM2MNqgzuFwri1FBvnz84noUYcysBYjnle
 GfQtJcLCN129dilvLJJuu7vm+9uFBo869lJL8WLgG2aJk8vnzdlG4xWpWNdcPMI9200n
 /UIg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUaCeGhkz7BqcQR0X4fxiseVwVb4Fek7D2PTylE9iK0s9S1texBZQ68X9BDg1SI2knSGlUxS+oIuuid@nongnu.org
X-Gm-Message-State: AOJu0Yz0UKgqK1XsLMhHfofFmlZUgWzHKPiZ/9opm12DSr7PKLLtxged
 7lFbUxlZ86W1nut3FzIyhDbx/fbrIjQG3MLsKshlP0MP8LiXQFaXaTCBCfuFAEKxlOi1VtrjMVP
 EVsGS+HZZqfUm5QtamxFqG1yEmz+AIPiZsJk8rHoMigrc+HWfL/xX
X-Received: by 2002:a05:600c:4684:b0:431:5632:448b with SMTP id
 5b1f17b1804b1-432d4acf54bmr54018445e9.25.1731574959566; 
 Thu, 14 Nov 2024 01:02:39 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEygWFwEtfEHN4up5O7ZOcQocr/wLqwO/gcTzb+8PuqueYdZ20E7UeYNLZgK1+g8p6DJJkUaQ==
X-Received: by 2002:a05:600c:4684:b0:431:5632:448b with SMTP id
 5b1f17b1804b1-432d4acf54bmr54018155e9.25.1731574959238; 
 Thu, 14 Nov 2024 01:02:39 -0800 (PST)
Received: from ?IPV6:2003:cb:c715:6600:a077:c7da:3362:6896?
 (p200300cbc7156600a077c7da33626896.dip0.t-ipconnect.de.
 [2003:cb:c715:6600:a077:c7da:3362:6896])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-432da27fcb4sm16417245e9.23.2024.11.14.01.02.37
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 14 Nov 2024 01:02:37 -0800 (PST)
Message-ID: <8ee7d398-0139-4628-9276-f6a89fa35245@redhat.com>
Date: Thu, 14 Nov 2024 10:02:37 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 2/2] migration: Do not perform RAMBlock dirty sync
 during the first iteration
To: Peter Xu <peterx@redhat.com>
Cc: Yong Huang <yong.huang@smartx.com>, qemu-devel@nongnu.org,
 Fabiano Rosas <farosas@suse.de>, Wei Wang <wei.w.wang@intel.com>,
 "Michael S . Tsirkin" <mst@redhat.com>
References: <cover.1731128180.git.yong.huang@smartx.com>
 <c25abae360ac204321acc5010a745a8e594f24bd.1731128180.git.yong.huang@smartx.com>
 <b2e42ed6-d514-46c9-993c-e7ae6384592f@redhat.com>
 <CAK9dgmak97Uv_RO+WFEb+KLkiuZ5+ibO3bigm3379L4aD55TvA@mail.gmail.com>
 <43700d36-b9f8-42da-ba72-b0ec6580032d@redhat.com>
 <CAK9dgmY8BAy4JAj5y-fY_YOpM6b3=86cmckPJZFuk9k=X1TYfQ@mail.gmail.com>
 <3049bc19-2556-4fbf-9d34-578db523b63b@redhat.com> <ZzTkopUrLGL5iqSv@x1n>
 <382461ab-d620-4d2e-becd-720daadf3c55@redhat.com> <ZzUIOFPtvHKDJPei@x1n>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <ZzUIOFPtvHKDJPei@x1n>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=david@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -29
X-Spam_score: -3.0
X-Spam_bar: ---
X-Spam_report: (-3.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.119,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.738,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 13.11.24 21:12, Peter Xu wrote:
> On Wed, Nov 13, 2024 at 07:49:44PM +0100, David Hildenbrand wrote:
>> I think I had precisely that, and I recall you suggested to have it only
>> after the initial sync. Would work for me, but I'd still like to understand
>> why essentially none of the "discard" was effective -- all of guest RAM got
>> touched.
> 
> Yes it'll be interesting to know..
> 
> One thing I'm wildly guessing is dirty_memory_extend(), so maybe after the
> ramblock is created nobody yet to clear the "1"s there for each of the
> client, including DIRTY_MEMORY_MIGRATION.  Then it'll be synced to ramblock
> bmap only in the initial sync, once for each qemu lifecycle.


In ram_block_add() we do the

cpu_physical_memory_set_dirty_range(new_block->offset,
				    new_block->used_length,
				    DIRTY_CLIENTS_ALL);

ramblock_dirty_bitmap_clear_discarded_pages()->...->migration_clear_memory_region_dirty_bitmap_range()->migration_clear_memory_region_dirty_bitmap() 
won't end up clearing the bits in the dirty bitmap.

First I thought because of:

if (!rb->clear_bmap || !clear_bmap_test_and_clear(rb, page)) {
     return;
}

But then I realized that even memory_region_clear_dirty_bitmap() will 
not clear the ramblock_dirty_bitmap_ bits! It's only concerned about 
listener->log_clear() calls.

Looking for DIRTY_MEMORY_BLOCK_SIZE users, only 
cpu_physical_memory_sync_dirty_bitmap() and 
cpu_physical_memory_clear_dirty_range() clear them, whereby the latter 
is only used when resizing RAMblocks.

At first I wondered whether 
ramblock_dirty_bitmap_clear_discarded_pages() should also call 
cpu_physical_memory_clear_dirty_range(), but then I am not so sure if 
that is really the right approach.


virtio-balloon() calls qemu_guest_free_page_hint() which calls

migration_clear_memory_region_dirty_bitmap_range()
bitmap_clear()

So it would maybe have the same issue.

-- 
Cheers,

David / dhildenb



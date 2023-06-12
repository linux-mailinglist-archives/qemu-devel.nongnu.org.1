Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 27D1D72B907
	for <lists+qemu-devel@lfdr.de>; Mon, 12 Jun 2023 09:48:25 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q8cG1-0004EH-Ml; Mon, 12 Jun 2023 03:46:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1q8cFz-0004Dx-0a
 for qemu-devel@nongnu.org; Mon, 12 Jun 2023 03:46:31 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1q8cFx-00079U-Af
 for qemu-devel@nongnu.org; Mon, 12 Jun 2023 03:46:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1686555987;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=yP4vMHkO+yCSQ+z82iPRDsudDDu4cQh6jmBlyoee49w=;
 b=MjisV+eiM7lhIJAbrwALYToMgji3BkE1ezY4OUE0dYSiVHzuxUtKlhzfx3MxYqKtAsEBeP
 TCXrWCl14r1XSDeh8y+ktg7ZNRp8Yw23PaJCKcXCinwPkqhZUYtEhk/ANxYXO/lgFA4Tvp
 4/zQdD1Ky9i3YU8cU7uJSA5b0Ky7ORU=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-232-oYYq8h_1P9uWgRSdoyEZUA-1; Mon, 12 Jun 2023 03:46:25 -0400
X-MC-Unique: oYYq8h_1P9uWgRSdoyEZUA-1
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-30fc5d6e697so130394f8f.0
 for <qemu-devel@nongnu.org>; Mon, 12 Jun 2023 00:46:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686555984; x=1689147984;
 h=content-transfer-encoding:in-reply-to:subject:organization:from
 :references:cc:to:content-language:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=yP4vMHkO+yCSQ+z82iPRDsudDDu4cQh6jmBlyoee49w=;
 b=irdZWXL4AzupqprF2jcXhTyp4paFmdMncZukp/NDYqiDms61Kw2hcNNKhU5zYk7x40
 OWunywGYsRXCfcsY3kXZleLIDBkSpyV2A9h0IYfSiEDmhuZNGheVwj08uKOCGj/aju8A
 2grsDf0T6f6PMVutJn8KPaGt8nTReteRAMo2yj69Np8VWIA7Pax2sh9lkZ0+0vts+hTh
 btJ4csZf9wpfwVt7bNxYUjrp8I2jlO33XrPRTcbsTwOHN6DVGQHynPrOqDqKLAw8AEQ9
 KPyOfEx0CfVV8cKLaMbWRrXl1A7XkMriZsuCRzf0Lqjf/AecESSfWj0sM0lNo4opIoc+
 9nGA==
X-Gm-Message-State: AC+VfDw5orvZXWx33+GfAcpjwo1O0l1b5zJ9iTLELPil52PeNlbziEJ5
 Im1+XE/ZGzdlCnD94XU2ZCbsIW2iakbTZkjDH5SAGE1HdVT4+hUXDLLKagMR06GBZkRY9/4pSzE
 wtGjJhM08aUa/owk=
X-Received: by 2002:a05:6000:14c:b0:30f:a895:d991 with SMTP id
 r12-20020a056000014c00b0030fa895d991mr3131808wrx.55.1686555984695; 
 Mon, 12 Jun 2023 00:46:24 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ73G0tqHUKMiC3veRGtl5w/v7h2Kk9F4KUkzVL4unSRQmLHkul9W56Mg29yppbvMAA2E73L5A==
X-Received: by 2002:a05:6000:14c:b0:30f:a895:d991 with SMTP id
 r12-20020a056000014c00b0030fa895d991mr3131789wrx.55.1686555984277; 
 Mon, 12 Jun 2023 00:46:24 -0700 (PDT)
Received: from ?IPV6:2003:cb:c74e:1600:4f67:25b2:3e8c:2a4e?
 (p200300cbc74e16004f6725b23e8c2a4e.dip0.t-ipconnect.de.
 [2003:cb:c74e:1600:4f67:25b2:3e8c:2a4e])
 by smtp.gmail.com with ESMTPSA id
 b5-20020adff905000000b0030aedb8156esm11491237wrr.102.2023.06.12.00.46.22
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 12 Jun 2023 00:46:23 -0700 (PDT)
Message-ID: <281caf4f-25da-3a73-554b-4fb252963035@redhat.com>
Date: Mon, 12 Jun 2023 09:46:22 +0200
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
From: David Hildenbrand <david@redhat.com>
Organization: Red Hat
Subject: Re: [PATCH] udmabuf: revert 'Add support for mapping hugepages (v4)'
In-Reply-To: <IA0PR11MB71851B64A5E7062E3BDD8D2FF854A@IA0PR11MB7185.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=david@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -31
X-Spam_score: -3.2
X-Spam_bar: ---
X-Spam_report: (-3.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.093, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1,
 RCVD_IN_MSPIKE_WL=-0.01, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On 12.06.23 09:10, Kasireddy, Vivek wrote:
> Hi Mike,

Hi Vivek,

> 
> Sorry for the late reply; I just got back from vacation.
> If it is unsafe to directly use the subpages of a hugetlb page, then reverting
> this patch seems like the only option for addressing this issue immediately.
> So, this patch is
> Acked-by: Vivek Kasireddy <vivek.kasireddy@intel.com>
> 
> As far as the use-case is concerned, there are two main users of the udmabuf
> driver: Qemu and CrosVM VMMs. However, it appears Qemu is the only one
> that uses hugetlb pages (when hugetlb=on is set) as the backing store for
> Guest (Linux, Android and Windows) system memory. The main goal is to
> share the pages associated with the Guest allocated framebuffer (FB) with
> the Host GPU driver and other components in a zero-copy way. To that end,
> the guest GPU driver (virtio-gpu) allocates 4k size pages (associated with
> the FB) and pins them before sharing the (guest) physical (or dma) addresses
> (and lengths) with Qemu. Qemu then translates the addresses into file
> offsets and shares these offsets with udmabuf.

Is my understanding correct, that we can effectively long-term pin 
(worse than mlock) 64 MiB per UDMABUF_CREATE, allowing eventually !root 
users

ll /dev/udmabuf
crw-rw---- 1 root kvm 10, 125 12. Jun 08:12 /dev/udmabuf

to bypass there effective MEMLOCK limit, fragmenting physical memory and 
breaking swap?


Regarding the udmabuf_vm_fault(), I assume we're mapping pages we 
obtained from the memfd ourselves into a special VMA (mmap() of the 
udmabuf). I'm not sure how well shmem pages are prepared for getting 
mapped by someone else into an arbitrary VMA (page->index?).

... also, just imagine someone doing FALLOC_FL_PUNCH_HOLE / ftruncate() 
on the memfd. What's mapped into the memfd no longer corresponds to 
what's pinned / mapped into the VMA.


Was linux-mm (and especially shmem maintainers, ccing Hugh) involved in 
the upstreaming of udmabuf?

-- 
Cheers,

David / dhildenb



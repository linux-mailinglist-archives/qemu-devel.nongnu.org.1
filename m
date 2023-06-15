Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2096773146F
	for <lists+qemu-devel@lfdr.de>; Thu, 15 Jun 2023 11:49:21 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q9jau-0002qd-Ha; Thu, 15 Jun 2023 05:48:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1q9jat-0002qT-42
 for qemu-devel@nongnu.org; Thu, 15 Jun 2023 05:48:43 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1q9jar-0006v1-Ga
 for qemu-devel@nongnu.org; Thu, 15 Jun 2023 05:48:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1686822520;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=tFas5ce2A1vgl/Pd1KLK4gSYDaGRoYeIBhP4kavIodY=;
 b=Rkva/9+cC8pNRv5Jh/EQ/fOlV15WLFgoiRfFrXsHvBX9gNFfG5nMHPar2DksxMtWek1nqL
 5TXeAdxLvnO24Klk8Zfi3Mwx6rMRbRh5yBVA5lmI95bPpeBy8R2AwbsxGTAQQ/jzOnvKFI
 IXvmI5XgUeEAJa749YxWhwqo0BQg0H4=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-322-fu39eExhN7mIrEP-_yixZg-1; Thu, 15 Jun 2023 05:48:38 -0400
X-MC-Unique: fu39eExhN7mIrEP-_yixZg-1
Received: by mail-lf1-f70.google.com with SMTP id
 2adb3069b0e04-4f76712f950so1584203e87.0
 for <qemu-devel@nongnu.org>; Thu, 15 Jun 2023 02:48:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686822517; x=1689414517;
 h=content-transfer-encoding:in-reply-to:subject:organization:from
 :references:cc:to:content-language:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=tFas5ce2A1vgl/Pd1KLK4gSYDaGRoYeIBhP4kavIodY=;
 b=YQRmFgfD3lopVnnNRb9Xi0KxiGR7My+ojPjeuj7f3QoVxoZ0fD/CqQ+VQtYlBnP7se
 F1gXgK+AEcXtieUJyAHNzrbZZHmb1P6XN7+htaOf/fhg7YHi/8WOiAPvf65aJfrCozG7
 OdKEq+ZuiwJQ/JUN1l6+om284dExSJEOF6Eow7kFLzDSDKFx6uQGImiGG6C0Q5vQabqT
 utGzN+CGrK8K0UlG7G4Icxz/qZWVev15jJ4GJiCk80sE93Sr/EHdRBpBMGTcgi+lBwJt
 vscGigcfXyL9YUXAhnAZRXmJDS6X3jU2UeilYqQAwQxuBAwEOymExWSkx5rDRmITO20X
 wOeg==
X-Gm-Message-State: AC+VfDxjs/CX808mFvYPSIpObZ6uk2fG5ifHtdchjqYygPMOPrLVRorA
 AIi0iJdcsIzEtne2uCoXPY4ieWTwR/2hnBFD8y+/PWJ2+37S/vpxO3FfQJyXSNMSVKdVLGqGmxp
 uL80wLOc/OW7A1ys=
X-Received: by 2002:a19:f205:0:b0:4dd:ce0b:7692 with SMTP id
 q5-20020a19f205000000b004ddce0b7692mr9513514lfh.46.1686822517132; 
 Thu, 15 Jun 2023 02:48:37 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ46ndnLtQ+lzJHNZ0kHKuZExuBXAwZ8nLK7yynFFKnsFo1JVRKjQW7nWIYv41TgUUl1IrX0NA==
X-Received: by 2002:a19:f205:0:b0:4dd:ce0b:7692 with SMTP id
 q5-20020a19f205000000b004ddce0b7692mr9513496lfh.46.1686822516710; 
 Thu, 15 Jun 2023 02:48:36 -0700 (PDT)
Received: from ?IPV6:2a09:80c0:192:0:5dac:bf3d:c41:c3e7?
 ([2a09:80c0:192:0:5dac:bf3d:c41:c3e7])
 by smtp.gmail.com with ESMTPSA id
 z15-20020a7bc7cf000000b003f6129d2e30sm20115269wmk.1.2023.06.15.02.48.35
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 15 Jun 2023 02:48:36 -0700 (PDT)
Message-ID: <015062b6-2d4a-7b91-8f64-1695f526f794@redhat.com>
Date: Thu, 15 Jun 2023 11:48:34 +0200
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
Cc: "Hocko, Michal" <mhocko@suse.com>,
 "jmarchan@redhat.com" <jmarchan@redhat.com>,
 "Kim, Dongwon" <dongwon.kim@intel.com>,
 "Chang, Junxiao" <junxiao.chang@intel.com>,
 "muchun.song@linux.dev" <muchun.song@linux.dev>,
 "stable@vger.kernel.org" <stable@vger.kernel.org>,
 James Houghton <jthoughton@google.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 "kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>
References: <20230608204927.88711-1-mike.kravetz@oracle.com>
 <IA0PR11MB71851B64A5E7062E3BDD8D2FF854A@IA0PR11MB7185.namprd11.prod.outlook.com>
 <281caf4f-25da-3a73-554b-4fb252963035@redhat.com>
 <IA0PR11MB71852D6B27C83658670CBFBDF855A@IA0PR11MB7185.namprd11.prod.outlook.com>
 <676ee47d-8ca0-94c4-7454-46e9915ea36a@redhat.com>
 <IA0PR11MB71850D8A446FE1342B428EA1F85AA@IA0PR11MB7185.namprd11.prod.outlook.com>
From: David Hildenbrand <david@redhat.com>
Organization: Red Hat
Subject: Re: [PATCH] udmabuf: revert 'Add support for mapping hugepages (v4)'
In-Reply-To: <IA0PR11MB71850D8A446FE1342B428EA1F85AA@IA0PR11MB7185.namprd11.prod.outlook.com>
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


>> Skimming over at shmem_read_mapping_page() users, I assume most of
>> them
>> use a VM_PFNMAP mapping (or don't mmap them at all), where we won't be
>> messing with the struct page at all.
>>
>> (That might even allow you to mmap hugetlb sub-pages, because the struct
>> page -- and mapcount -- will be ignored completely and not touched.)
> Oh, are you suggesting that if we do vma->vm_flags |= VM_PFNMAP
> in the mmap handler (mmap_udmabuf) and also do
> vmf_insert_pfn(vma, vmf->address, page_to_pfn(page))
> instead of
> vmf->page = ubuf->pages[pgoff];
> get_page(vmf->page);
> 
> in the vma fault handler (udmabuf_vm_fault), we can avoid most of the
> pitfalls you have identified -- including with the usage of hugetlb subpages?

Yes, that's my thinking, but I have to do my homework first to see if 
that would really work for hugetlb.

The thing is, I kind-of consider what udmabuf does a layer violation: we 
have a filesystem (shmem/hugetlb) that should handle mappings to user 
space. Yet, a driver decides to bypass that and simply map the pages 
ordinarily to user space. (revealed by the fact that hugetlb does never 
map sub-pages but udmabuf decides to do so)

In an ideal world everybody would simply mmap() the original memfd, but 
thinking about offset+size configuration within the memfd that might not 
always be desirable. As a workaround, we could mmap() only the PFNs, 
leaving the struct page unaffected.

I'll have to look closer into that.

-- 
Cheers,

David / dhildenb



Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E8FB696C97F
	for <lists+qemu-devel@lfdr.de>; Wed,  4 Sep 2024 23:23:58 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1slxTa-0007XW-9q; Wed, 04 Sep 2024 17:23:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1slxTY-0007X0-P6
 for qemu-devel@nongnu.org; Wed, 04 Sep 2024 17:23:40 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1slxTX-00074a-5c
 for qemu-devel@nongnu.org; Wed, 04 Sep 2024 17:23:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1725485018;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=IS6SoUsI2JMXfureIxrLGv4HIZia2VJEUP52Y6ve35w=;
 b=c7ZQJI7W8QJXYhhDn2xSZp7ZUmKIxbzVU3048fu5zBxBYcVkkXazHWu6xUgX1Xf+MqaSCt
 E9kAqJ8CC4PKXJgdPlaiwTr7z5Qlp//Tlr3NqwzwynmedeZJPI2o9FHNC0glbe1pEXOsF4
 wnS8rKEhBrzd0CvO4OAVlDH5OOX8xfQ=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-204-Evtyvh5eN42nVXD96HeTRA-1; Wed, 04 Sep 2024 17:23:37 -0400
X-MC-Unique: Evtyvh5eN42nVXD96HeTRA-1
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-42c7936e564so42192335e9.2
 for <qemu-devel@nongnu.org>; Wed, 04 Sep 2024 14:23:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725485016; x=1726089816;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=IS6SoUsI2JMXfureIxrLGv4HIZia2VJEUP52Y6ve35w=;
 b=BVrNFz6gZasVBLhfakqHnzKtH5YMlu6XYQ71GNENJ/82tNFpD2KLSn9qompCG864rJ
 BGr3n9aBtyi8r7NwCpgWmbH76DZvH3ACtt67bWD5SLTE3lQb1qSXo9XQ7UMUBJ5NzldP
 jC05WkqQDR0sOdvjNgCEGEM1GwBuKnAX9NI885N6gFSihK7ozqq+oGYIOAEHrLTbNh65
 1jz9cXassBAHcUDapICr8g6GeqVRPWUnw1ZMzlWUGjgJkTaRstCsCXzE2HyYMv5wN/DU
 yrJVGuCmXMy6qY5icHd+lCzGToYW1WlE8c4V8wXIK0aCkRpw0bT7Erq3jzoVgRpkDxKt
 Lp3w==
X-Gm-Message-State: AOJu0YzkGKREozXyTT9C8+aUtbzfFDtvIeKT+gXpsm6wfFg1u0FDJ8IG
 475PPdghCe61YqeekJ+mVLu5VM/w3obG8yLHsV0oiZ2SqsvPhGCXS6o6cbPrsS7DX7fQwTg2nwe
 SCmbQAmjFjSpEMGHc7Pd5woYAauA67zolasj2jQyfHFEw+L1pzJ5E
X-Received: by 2002:a05:600c:3b8a:b0:426:58ca:5a3 with SMTP id
 5b1f17b1804b1-42c881031e2mr65059315e9.30.1725485015880; 
 Wed, 04 Sep 2024 14:23:35 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHAviooP+4pLdwh8Z0+dvP0wwPl55Ws+v8pBf7OFWBZigURxMKZAfPEnb1/xcN8r/OfiORjqg==
X-Received: by 2002:a05:600c:3b8a:b0:426:58ca:5a3 with SMTP id
 5b1f17b1804b1-42c881031e2mr65059145e9.30.1725485015231; 
 Wed, 04 Sep 2024 14:23:35 -0700 (PDT)
Received: from ?IPV6:2003:cb:c715:d00:e9a5:ae4b:9bdb:d992?
 (p200300cbc7150d00e9a5ae4b9bdbd992.dip0.t-ipconnect.de.
 [2003:cb:c715:d00:e9a5:ae4b:9bdb:d992])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-374c1b0a62esm12453428f8f.47.2024.09.04.14.23.34
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 04 Sep 2024 14:23:34 -0700 (PDT)
Message-ID: <ff6430ac-f7f4-49f3-a63b-76eae5b2f791@redhat.com>
Date: Wed, 4 Sep 2024 23:23:33 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/4] KVM: Dynamic sized kvm memslots array
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Juraj Marcin <jmarcin@redhat.com>,
 Prasad Pandit <ppandit@redhat.com>, Julia Suvorova <jusual@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Vitaly Kuznetsov <vkuznets@redhat.com>, Zhiyi Guo <zhguo@redhat.com>
References: <20240904191635.3045606-1-peterx@redhat.com>
 <20240904191635.3045606-4-peterx@redhat.com>
 <b2cf2a87-848f-4c07-9d05-39b53c638950@redhat.com> <ZtjPA9eCN1Ro9HFp@x1n>
Content-Language: en-US
From: David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; keydata=
 xsFNBFXLn5EBEAC+zYvAFJxCBY9Tr1xZgcESmxVNI/0ffzE/ZQOiHJl6mGkmA1R7/uUpiCjJ
 dBrn+lhhOYjjNefFQou6478faXE6o2AhmebqT4KiQoUQFV4R7y1KMEKoSyy8hQaK1umALTdL
 QZLQMzNE74ap+GDK0wnacPQFpcG1AE9RMq3aeErY5tujekBS32jfC/7AnH7I0v1v1TbbK3Gp
 XNeiN4QroO+5qaSr0ID2sz5jtBLRb15RMre27E1ImpaIv2Jw8NJgW0k/D1RyKCwaTsgRdwuK
 Kx/Y91XuSBdz0uOyU/S8kM1+ag0wvsGlpBVxRR/xw/E8M7TEwuCZQArqqTCmkG6HGcXFT0V9
 PXFNNgV5jXMQRwU0O/ztJIQqsE5LsUomE//bLwzj9IVsaQpKDqW6TAPjcdBDPLHvriq7kGjt
 WhVhdl0qEYB8lkBEU7V2Yb+SYhmhpDrti9Fq1EsmhiHSkxJcGREoMK/63r9WLZYI3+4W2rAc
 UucZa4OT27U5ZISjNg3Ev0rxU5UH2/pT4wJCfxwocmqaRr6UYmrtZmND89X0KigoFD/XSeVv
 jwBRNjPAubK9/k5NoRrYqztM9W6sJqrH8+UWZ1Idd/DdmogJh0gNC0+N42Za9yBRURfIdKSb
 B3JfpUqcWwE7vUaYrHG1nw54pLUoPG6sAA7Mehl3nd4pZUALHwARAQABzSREYXZpZCBIaWxk
 ZW5icmFuZCA8ZGF2aWRAcmVkaGF0LmNvbT7CwZgEEwEIAEICGwMGCwkIBwMCBhUIAgkKCwQW
 AgMBAh4BAheAAhkBFiEEG9nKrXNcTDpGDfzKTd4Q9wD/g1oFAl8Ox4kFCRKpKXgACgkQTd4Q
 9wD/g1oHcA//a6Tj7SBNjFNM1iNhWUo1lxAja0lpSodSnB2g4FCZ4R61SBR4l/psBL73xktp
 rDHrx4aSpwkRP6Epu6mLvhlfjmkRG4OynJ5HG1gfv7RJJfnUdUM1z5kdS8JBrOhMJS2c/gPf
 wv1TGRq2XdMPnfY2o0CxRqpcLkx4vBODvJGl2mQyJF/gPepdDfcT8/PY9BJ7FL6Hrq1gnAo4
 3Iv9qV0JiT2wmZciNyYQhmA1V6dyTRiQ4YAc31zOo2IM+xisPzeSHgw3ONY/XhYvfZ9r7W1l
 pNQdc2G+o4Di9NPFHQQhDw3YTRR1opJaTlRDzxYxzU6ZnUUBghxt9cwUWTpfCktkMZiPSDGd
 KgQBjnweV2jw9UOTxjb4LXqDjmSNkjDdQUOU69jGMUXgihvo4zhYcMX8F5gWdRtMR7DzW/YE
 BgVcyxNkMIXoY1aYj6npHYiNQesQlqjU6azjbH70/SXKM5tNRplgW8TNprMDuntdvV9wNkFs
 9TyM02V5aWxFfI42+aivc4KEw69SE9KXwC7FSf5wXzuTot97N9Phj/Z3+jx443jo2NR34XgF
 89cct7wJMjOF7bBefo0fPPZQuIma0Zym71cP61OP/i11ahNye6HGKfxGCOcs5wW9kRQEk8P9
 M/k2wt3mt/fCQnuP/mWutNPt95w9wSsUyATLmtNrwccz63XOwU0EVcufkQEQAOfX3n0g0fZz
 Bgm/S2zF/kxQKCEKP8ID+Vz8sy2GpDvveBq4H2Y34XWsT1zLJdvqPI4af4ZSMxuerWjXbVWb
 T6d4odQIG0fKx4F8NccDqbgHeZRNajXeeJ3R7gAzvWvQNLz4piHrO/B4tf8svmRBL0ZB5P5A
 2uhdwLU3NZuK22zpNn4is87BPWF8HhY0L5fafgDMOqnf4guJVJPYNPhUFzXUbPqOKOkL8ojk
 CXxkOFHAbjstSK5Ca3fKquY3rdX3DNo+EL7FvAiw1mUtS+5GeYE+RMnDCsVFm/C7kY8c2d0G
 NWkB9pJM5+mnIoFNxy7YBcldYATVeOHoY4LyaUWNnAvFYWp08dHWfZo9WCiJMuTfgtH9tc75
 7QanMVdPt6fDK8UUXIBLQ2TWr/sQKE9xtFuEmoQGlE1l6bGaDnnMLcYu+Asp3kDT0w4zYGsx
 5r6XQVRH4+5N6eHZiaeYtFOujp5n+pjBaQK7wUUjDilPQ5QMzIuCL4YjVoylWiBNknvQWBXS
 lQCWmavOT9sttGQXdPCC5ynI+1ymZC1ORZKANLnRAb0NH/UCzcsstw2TAkFnMEbo9Zu9w7Kv
 AxBQXWeXhJI9XQssfrf4Gusdqx8nPEpfOqCtbbwJMATbHyqLt7/oz/5deGuwxgb65pWIzufa
 N7eop7uh+6bezi+rugUI+w6DABEBAAHCwXwEGAEIACYCGwwWIQQb2cqtc1xMOkYN/MpN3hD3
 AP+DWgUCXw7HsgUJEqkpoQAKCRBN3hD3AP+DWrrpD/4qS3dyVRxDcDHIlmguXjC1Q5tZTwNB
 boaBTPHSy/Nksu0eY7x6HfQJ3xajVH32Ms6t1trDQmPx2iP5+7iDsb7OKAb5eOS8h+BEBDeq
 3ecsQDv0fFJOA9ag5O3LLNk+3x3q7e0uo06XMaY7UHS341ozXUUI7wC7iKfoUTv03iO9El5f
 XpNMx/YrIMduZ2+nd9Di7o5+KIwlb2mAB9sTNHdMrXesX8eBL6T9b+MZJk+mZuPxKNVfEQMQ
 a5SxUEADIPQTPNvBewdeI80yeOCrN+Zzwy/Mrx9EPeu59Y5vSJOx/z6OUImD/GhX7Xvkt3kq
 Er5KTrJz3++B6SH9pum9PuoE/k+nntJkNMmQpR4MCBaV/J9gIOPGodDKnjdng+mXliF3Ptu6
 3oxc2RCyGzTlxyMwuc2U5Q7KtUNTdDe8T0uE+9b8BLMVQDDfJjqY0VVqSUwImzTDLX9S4g/8
 kC4HRcclk8hpyhY2jKGluZO0awwTIMgVEzmTyBphDg/Gx7dZU1Xf8HFuE+UZ5UDHDTnwgv7E
 th6RC9+WrhDNspZ9fJjKWRbveQgUFCpe1sa77LAw+XFrKmBHXp9ZVIe90RMe2tRL06BGiRZr
 jPrnvUsUUsjRoRNJjKKA/REq+sAnhkNPPZ/NNMjaZ5b8Tovi8C0tmxiCHaQYqj7G2rgnT0kt
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <ZtjPA9eCN1Ro9HFp@x1n>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=david@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.142,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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


>>
>> Then, you can remove the parameter from kvm_slots_grow() completely and just call it
>> kvm_slots_double() and simplify a bit:
>>
>> static bool kvm_slots_double(KVMMemoryListener *kml)
>> {
>>      unsigned int i, nr_slots_new, cur = kml->nr_slots_allocated;
>>      KVMSlot *slots;
>>
>>      nr_slots_new = MIN(cur * 2, kvm_state->nr_slots_max);
>>      if (nr_slots_new == kvm_state->nr_slots_max) {
>>          /* We reached the maximum */
>> 	return false;
>>      }
>>
>>      assert(kml->slots);
>>      slots = g_renew(KVMSlot, kml->slots, nr_slots_new);
>>      /*
>>       * g_renew() doesn't initialize extended buffers, however kvm
>>       * memslots require fields to be zero-initialized. E.g. pointers,
>>       * memory_size field, etc.
>>       */
>>      memset(&slots[cur], 0x0, sizeof(slots[0]) * (nr_slots_new - cur));
>>
>>      for (i = cur; i < nr_slots_new; i++) {
>>          slots[i].slot = i;
>>      }
>>
>>      kml->slots = slots;
>>      kml->nr_slots_allocated = nr_slots_new;
>>      trace_kvm_slots_grow(cur, nr_slots_new);
>>
>>      return true;
>> }
> 
> Personally I still think it cleaner to allow setting whatever size.

Why would one need that? If any, at some point we would want to shrink 
or rather "compact".

> 
> We only have one place growing so far, which is pretty trivial to double
> there, IMO.  I'll wait for a second opinion, or let me know if you have
> strong feelings..

I think the simplicity of kvm_slots_double() speaks for itself, but I 
won't fight for it.

-- 
Cheers,

David / dhildenb



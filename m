Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 99204A47CC9
	for <lists+qemu-devel@lfdr.de>; Thu, 27 Feb 2025 13:03:53 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tncbM-00080F-87; Thu, 27 Feb 2025 07:02:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1tncbB-0007zg-Hw
 for qemu-devel@nongnu.org; Thu, 27 Feb 2025 07:02:41 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1tncb9-0002JK-RM
 for qemu-devel@nongnu.org; Thu, 27 Feb 2025 07:02:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1740657758;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=fkOklwY5VSJpS8Hd4X8XFs0xRtKa6uKL2I4NFLHfgq0=;
 b=iJ9JevZxHqEAyhHf8BRWZTXdqjYLaWBqEz7LHkGtb/EtHBcDA9Nk9p0Ut553+XaVqTZlIh
 jjWyNvteJ4c7sTKKZ3i1jMjgZtn6ns9JG5lpVoKujsWKcWMYcuPMKsvr3jZhRd3lneOxyL
 IXZIC0IjL5n6NbmMU2WRFk2PSclQ2es=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-605-UsLO2QSBPb6afeY9HcpoCw-1; Thu, 27 Feb 2025 07:02:31 -0500
X-MC-Unique: UsLO2QSBPb6afeY9HcpoCw-1
X-Mimecast-MFC-AGG-ID: UsLO2QSBPb6afeY9HcpoCw_1740657751
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-390df5962e1so611222f8f.0
 for <qemu-devel@nongnu.org>; Thu, 27 Feb 2025 04:02:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740657750; x=1741262550;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:from:references:cc:to:subject:user-agent
 :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to;
 bh=fkOklwY5VSJpS8Hd4X8XFs0xRtKa6uKL2I4NFLHfgq0=;
 b=YXjXHV6ZWdo3KFJbDlNmuYJ9jLjH+rK95hQMPZ6dftWGP4XpWq/Pgc+D2AqSZiT5bV
 NmjmG/PQDPHJsmjnFu8wU7xYw2NEtZWx9IPAaO49GmFMiOnN9G098X1EuwIWCb+tXViq
 ZxGjv5t7mGnIskp28gA961Tng2ZLZ/JnWdTughtp1m8folLMKSR2VOItbbD03YYxZRqM
 a9HSTj2MfOZNSZoMXDd+PGjJMoW6peX3Yg8h9F4fc1F3GTaYhS82+x37xkYtKGOTO6Y3
 NRtNIbokwYFSL3Zbd6F6B7JEQInHbs7e2y0JlFnYcacmupWZWeE4WnX+Ea/TLBcpzvU9
 /60g==
X-Forwarded-Encrypted: i=1;
 AJvYcCUCQmXqSHIOXissFCqYKLpRnGtskJS2Gl2HpXewSBPGJ1bHENVlbwXLMlkXaAiqDdWzrdaOy2n2PLVH@nongnu.org
X-Gm-Message-State: AOJu0YyHG4F1O7Qb/R0TGoMF2+Lwfly7ouLscpT7a/HylCp2tgbK3Tax
 LB8Iy0zOAkCotk+9SGu72Q8SQWnlH9ms1qRgSiSQSSiqiyrF2cuwy9sRRxyxxvz3ptZJKd/5qk5
 9NE7nX4BLqDll6qXc749zn9v9JZQTQ0/JjVAgLRKSQxCeH3BRfcuY
X-Gm-Gg: ASbGncuhco+DUyL0K22SbSfTJKN3sHgpm8oC1D5DmhD6gYOcFKGNkxrijzxbBMch8dW
 EdzH4cGrrZFptbSzBh6rjN+/V5GGBlaTjYl1NDUHt9PK13ITwjpNfB8ooAnMjqV6gAzM408RcxD
 5Sm9FzidQMxSb9xypTGMivWYF0hhcx7er3EDaZeSE8GyFRtQNgWPoqqXRRHHfL1L+ePg/xR2AxS
 uOdcAtzUFd5Q/9tSVjdfrwzF2qHaGtyMm9yARAPQ6sUWrMjw4sHTHrNkb2MjGbaPRXaTbBX0T7w
 cUe48cwkODx0zKkdbJSSZJrhd70gWo97gdeKdkPK/TgYmr/wWyCogHJg7pngFkMxgzDwdILi/kL
 Mj72ccub29YYPk9+43FQDT38Txjp16DkpBxF9KHv6BrA=
X-Received: by 2002:a05:6000:400a:b0:38f:23c4:208c with SMTP id
 ffacd0b85a97d-390e18c8b0amr2258522f8f.18.1740657749122; 
 Thu, 27 Feb 2025 04:02:29 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHGbMyQ0cNuVjh472X6LNe/MKy7YhUl42Ms5Slwnfhzv4FrPGSZ18WeVpxVZYJT3aUNhjZA+w==
X-Received: by 2002:a05:6000:400a:b0:38f:23c4:208c with SMTP id
 ffacd0b85a97d-390e18c8b0amr2258490f8f.18.1740657748778; 
 Thu, 27 Feb 2025 04:02:28 -0800 (PST)
Received: from ?IPV6:2003:cb:c74f:b800:58e5:8355:5366:573d?
 (p200300cbc74fb80058e583555366573d.dip0.t-ipconnect.de.
 [2003:cb:c74f:b800:58e5:8355:5366:573d])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-390e47b7dcfsm1856805f8f.55.2025.02.27.04.02.27
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 27 Feb 2025 04:02:28 -0800 (PST)
Message-ID: <b02ecb38-039e-48aa-9407-67cc43a5b7e7@redhat.com>
Date: Thu, 27 Feb 2025 13:02:27 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 1/2] s390x/pci: add support for guests that request
 direct mapping
To: Matthew Rosato <mjrosato@linux.ibm.com>, qemu-s390x@nongnu.org
Cc: farman@linux.ibm.com, schnelle@linux.ibm.com, thuth@redhat.com,
 pasic@linux.ibm.com, borntraeger@linux.ibm.com,
 richard.henderson@linaro.org, iii@linux.ibm.com, clg@redhat.com,
 qemu-devel@nongnu.org
References: <20250226210013.238349-1-mjrosato@linux.ibm.com>
 <20250226210013.238349-2-mjrosato@linux.ibm.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
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
In-Reply-To: <20250226210013.238349-2-mjrosato@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=david@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.438,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On 26.02.25 22:00, Matthew Rosato wrote:
> When receiving a guest mpcifc(4) or mpcifc(6) instruction without the T
> bit set, treat this as a request to perform direct mapping instead of
> address translation.  In order to facilitate this, pin the entirety of
> guest memory into the host iommu.
> 
> Pinning for the direct mapping case is handled via vfio and its memory
> listener.  Additionally, ram discard settings are inherited from vfio:
> coordinated discards (e.g. virtio-mem) are allowed while uncoordinated
> discards (e.g. virtio-balloon) are disabled.
> 
> Subsequent guest DMA operations are all expected to be of the format
> guest_phys+sdma, allowing them to be used as lookup into the host
> iommu table.

Reviewed-by: David Hildenbrand <david@redhat.com>

-- 
Cheers,

David / dhildenb



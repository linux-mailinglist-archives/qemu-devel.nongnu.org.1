Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 27CB4AC3BE3
	for <lists+qemu-devel@lfdr.de>; Mon, 26 May 2025 10:42:40 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uJTPS-0000cQ-Kq; Mon, 26 May 2025 04:42:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1uJTPP-0000W9-Cy
 for qemu-devel@nongnu.org; Mon, 26 May 2025 04:42:11 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1uJTPN-0006VN-FC
 for qemu-devel@nongnu.org; Mon, 26 May 2025 04:42:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1748248927;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=97kbZtlgIExA4qKYGRP1ynOk/EWcY3gmjZBtZIIcE1E=;
 b=WiBe1lCrkENIHDOAWeMkvWrzbGPEZNujyO7CXH2D4LpaStBbLbC6NJJ5AFjrqJ4BRLuNYY
 AXNjmCdN05BY/yXJQ6imUCFrf6XfMLwdNeDvK4XvkPa+VPiH8HJRyfAqhf14D8Po97mqiU
 kk9kU1eEd6d86oEq9p4KgCuHpd7Vf9I=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-621-5zn6jXVxMDeYclz89g1tdw-1; Mon, 26 May 2025 04:42:05 -0400
X-MC-Unique: 5zn6jXVxMDeYclz89g1tdw-1
X-Mimecast-MFC-AGG-ID: 5zn6jXVxMDeYclz89g1tdw_1748248925
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-43d209dc2d3so11950595e9.3
 for <qemu-devel@nongnu.org>; Mon, 26 May 2025 01:42:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748248925; x=1748853725;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:from:references:cc:to:subject:user-agent
 :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to;
 bh=97kbZtlgIExA4qKYGRP1ynOk/EWcY3gmjZBtZIIcE1E=;
 b=dzuzputTI0dY+e/fajcuKgo4wfrdjuf1WqKoCy/BA40tD7MoWshoD5n3VV9+qpiKVJ
 bJRzQQr8fLs3YyXCNn+WKxcdxNUWNKInbOee4tDD+ByA5GBESltwXuzyboFO6opiDVoY
 Yjzd9vK4e5aGFdu/TTT0oJSlTf5TLbXOamfcDGMwIWt8ICR4KaYGi6YYQGPcJyhy/xvt
 ZH0ERk9MqeH2utz26Pq+umAcLaZJwGKMs2ouSXaeI5kgKTcdVfhAeRpF6Bje34XpqKFO
 QHtMgr0KPm8g7rzVV+RHR3Zl27e7nqIIuWAE6LKIHm5EvfclUuBUn9cm9e2eClOAj1AW
 Vg2Q==
X-Gm-Message-State: AOJu0YxfAAK8a3Nz5ef3xTgJ5VYIG5FxBfxRPvVmjMvC4lW09LAhFt0V
 6GKO6W6pc1kZ3PXFS6TKOJvQwcFTgRJ1M66AnQSgjKYBjJUT8a4szNI3bWbbsEJDIYZFrhG5tHF
 Hoj0V521mngDLe8vtKDO/mSszzJARe87QxsEx/XtbtPdC3dVRnSJMUPPl
X-Gm-Gg: ASbGnctt8eD8wJEIaAtEWMjAEWZ/jzHwMuKsxn6mIB1T4uYPgMPcUdpH/Fm842FOu4I
 lppIBlDndKr2w3qjI59e18WfFhNnNUNZBrRNUqflwZZK9H0DNRaSxtir4mGG74flJ/uyr6MEf6T
 IfH8LNChdJt+gemsQbs7tlqkZoiUKoXOS0aP7tWO1bZkGvIBZpuIkc1hUcYF4MhxjIgj6oBHn38
 8z/bOvrJPW1wsSSY3+gK+SC0s7jfIML/MOdOd7FUO7Cr9RiZBRw9PjRs6nXimI19ea8zi68r6GJ
 rgOuABiDiUSsANEODq0NqaXc7fh8L2lhAWcZEpOv0FeFQREhxJlUSLf5xPd5a3Kn0+fV15aAaZL
 Ual3EDytlcYiimSIFrDRrzpk2LxIPr8B2fMqgbMc=
X-Received: by 2002:a05:600c:3c84:b0:442:f4d4:53a with SMTP id
 5b1f17b1804b1-44c9151293fmr82089755e9.2.1748248924820; 
 Mon, 26 May 2025 01:42:04 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF+4zjh0O/r8X0NQKFOR2Y6GHPZFlzGjvoXiENYfVluXT0XK1FAhn8FH2HkNN46fQhcZ46RPQ==
X-Received: by 2002:a05:600c:3c84:b0:442:f4d4:53a with SMTP id
 5b1f17b1804b1-44c9151293fmr82089345e9.2.1748248924369; 
 Mon, 26 May 2025 01:42:04 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f19:6500:e1c1:8216:4c25:efe4?
 (p200300d82f196500e1c182164c25efe4.dip0.t-ipconnect.de.
 [2003:d8:2f19:6500:e1c1:8216:4c25:efe4])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-447f3dd9c21sm234863005e9.38.2025.05.26.01.42.01
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 26 May 2025 01:42:04 -0700 (PDT)
Message-ID: <7f10e5e8-9585-4323-96d5-760e6652db1b@redhat.com>
Date: Mon, 26 May 2025 10:42:01 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 03/10] memory: Unify the definiton of
 ReplayRamPopulate() and ReplayRamDiscard()
To: Chenyi Qiang <chenyi.qiang@intel.com>, Alexey Kardashevskiy
 <aik@amd.com>, Peter Xu <peterx@redhat.com>,
 Gupta Pankaj <pankaj.gupta@amd.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Michael Roth <michael.roth@amd.com>
Cc: qemu-devel@nongnu.org, kvm@vger.kernel.org,
 Williams Dan J <dan.j.williams@intel.com>, Zhao Liu <zhao1.liu@intel.com>,
 Baolu Lu <baolu.lu@linux.intel.com>, Gao Chao <chao.gao@intel.com>,
 Xu Yilun <yilun.xu@intel.com>, Li Xiaoyao <xiaoyao.li@intel.com>
References: <20250520102856.132417-1-chenyi.qiang@intel.com>
 <20250520102856.132417-4-chenyi.qiang@intel.com>
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
In-Reply-To: <20250520102856.132417-4-chenyi.qiang@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=david@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -59
X-Spam_score: -6.0
X-Spam_bar: ------
X-Spam_report: (-6.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.904,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
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

On 20.05.25 12:28, Chenyi Qiang wrote:
> Update ReplayRamDiscard() function to return the result and unify the
> ReplayRamPopulate() and ReplayRamDiscard() to ReplayRamDiscardState() at
> the same time due to their identical definitions. This unification
> simplifies related structures, such as VirtIOMEMReplayData, which makes
> it cleaner.
> 
> Signed-off-by: Chenyi Qiang <chenyi.qiang@intel.com>

Reviewed-by: David Hildenbrand <david@redhat.com>

-- 
Cheers,

David / dhildenb



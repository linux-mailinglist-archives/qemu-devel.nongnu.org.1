Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F273AB65A7
	for <lists+qemu-devel@lfdr.de>; Wed, 14 May 2025 10:18:45 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uF7In-0005SB-7g; Wed, 14 May 2025 04:17:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1uF7Ij-0005R9-Ak
 for qemu-devel@nongnu.org; Wed, 14 May 2025 04:17:17 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1uF7Ih-0004Sw-Oz
 for qemu-devel@nongnu.org; Wed, 14 May 2025 04:17:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1747210634;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=rux/UKloZxeoFeU7MXEGU/bMDNyvVdMTjKbFt2gcZ2I=;
 b=ZPdQXo4OkD8WNr/MLvEGBPuMW7gXIFcS0icOO7ZTULu8xKabm427phOIfv0voALt0YQggd
 Bfwp2gwJvEjDTV/6bdk8PCva7FErUd9+y3QmmT4xvqxlQJl1GwnYWT6F7POMGP0h6x0GGX
 mcgo66rdH8Z4kXzcm/wL/+QEW5YlKvQ=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-577-XkM5Ncm1OiCY_aRxfwCoLQ-1; Wed, 14 May 2025 04:17:12 -0400
X-MC-Unique: XkM5Ncm1OiCY_aRxfwCoLQ-1
X-Mimecast-MFC-AGG-ID: XkM5Ncm1OiCY_aRxfwCoLQ_1747210632
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-43cf3168b87so28839595e9.2
 for <qemu-devel@nongnu.org>; Wed, 14 May 2025 01:17:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747210631; x=1747815431;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=rux/UKloZxeoFeU7MXEGU/bMDNyvVdMTjKbFt2gcZ2I=;
 b=r1LpMeBYmYubZMM1f7/sylCJVT4Q0HRzPLOrsJ4A2i+0Wi4zvWLK1kXTnH7YLUiH85
 BNfnJvlySZJRMLJXT2dpA8Gb3rRmZT5lHOkE0P6qCj4Vwf7jV1xWyRHtYdiD8uCuSi7n
 Lj+8c9zE+QlSctpqRxRxJnY2u9Z77PVHvm2+GfOckb6BitlOg0Flx11ZUMiPysz6+RDF
 9eyTO+r+eNLOq6upq3UekVR7GB8fn1NNmNu3MFcxYkKNwpRDtwxoAJXwuJ2bB1CN/9Xp
 2f1c7AQGHmj4SHKXuoigZejSo5Qj1Z9p9wEJ1nRAnKddqzXofyfTG4TaphDof9OhP7+v
 cmQg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUbFmYump7iM4OdJCHZ6eX3xfNckyVqhwYIkxDEGnT40VlrjCg9Jej+4lWWvOewqOrOF7TLZq5mMUQm@nongnu.org
X-Gm-Message-State: AOJu0YwxWYnQT20giiGJQNgDKA5jLVoQ3Ogd8iw/QkrC5XrIRRaotLEO
 E+8jI3mtMbukmHabzIriVbJU8vLOPXYMLjede3DOs17vFx4K3GEjmnZ/ISXOJ+N60bVoCLrUQ62
 KvDeZn0tcKTFEK6rOH9V6b3ehRM+xtMy67kgl3VhMaykl12euzOmq
X-Gm-Gg: ASbGnctrOQxlerFSyjw+3DkCJglmsHBZiuZvh4gLggeYfXppaa6zbgSrWtluUvGDwjn
 VJZA5F44RSAQemVv2FZUce9b49HD+FrqCZsVzy3hXrMrH/fatjBCkJ54nwOPV8cNr08eJBH53cr
 4LcIC2EcQxDJj+kX8FoQx3cAq57HcLwynuq8Oqy6/FaG75XR6oY548e9lkLxE2a2urw9EOsOobF
 UhKGIwj3oPnexkHv6qdo6CdQS7OvCqEHQgP3xlkdtXbharnhT0jByx0xlJnV3+aHpqTvbou/qWi
 b3WvV2zUeVHaR1jMinbYoN4pRKRu12f5FNxP
X-Received: by 2002:a05:600c:1553:b0:43c:e9f7:d6a3 with SMTP id
 5b1f17b1804b1-442f20e8186mr17812065e9.13.1747210631668; 
 Wed, 14 May 2025 01:17:11 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGD4DujWzSVLD9QQa5+8MnFc8UozEKQd5F18z1plE7CpGA+gALFbGRvciKKK+Tr5I0GkFRy+Q==
X-Received: by 2002:a05:600c:1553:b0:43c:e9f7:d6a3 with SMTP id
 5b1f17b1804b1-442f20e8186mr17811805e9.13.1747210631281; 
 Wed, 14 May 2025 01:17:11 -0700 (PDT)
Received: from [10.33.192.219] (nat-pool-str-t.redhat.com. [149.14.88.106])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-442f397b6fbsm19033635e9.39.2025.05.14.01.17.09
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 14 May 2025 01:17:10 -0700 (PDT)
Message-ID: <512a9f3e-1ca0-498f-96cf-2eb0ba1227a3@redhat.com>
Date: Wed, 14 May 2025 10:17:08 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 04/25] s390x/diag: Introduce DIAG 320 for certificate
 store facility
To: Zhuoying Cai <zycai@linux.ibm.com>, richard.henderson@linaro.org,
 david@redhat.com, pbonzini@redhat.com
Cc: walling@linux.ibm.com, jjherne@linux.ibm.com, jrossi@linux.ibm.com,
 fiuczy@linux.ibm.com, pasic@linux.ibm.com, borntraeger@linux.ibm.com,
 farman@linux.ibm.com, iii@linux.ibm.com, qemu-s390x@nongnu.org,
 qemu-devel@nongnu.org
References: <20250508225042.313672-1-zycai@linux.ibm.com>
 <20250508225042.313672-5-zycai@linux.ibm.com>
From: Thomas Huth <thuth@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 xsFNBFH7eUwBEACzyOXKU+5Pcs6wNpKzrlJwzRl3VGZt95VCdb+FgoU9g11m7FWcOafrVRwU
 yYkTm9+7zBUc0sW5AuPGR/dp3pSLX/yFWsA/UB4nJsHqgDvDU7BImSeiTrnpMOTXb7Arw2a2
 4CflIyFqjCpfDM4MuTmzTjXq4Uov1giGE9X6viNo1pxyEpd7PanlKNnf4PqEQp06X4IgUacW
 tSGj6Gcns1bCuHV8OPWLkf4hkRnu8hdL6i60Yxz4E6TqlrpxsfYwLXgEeswPHOA6Mn4Cso9O
 0lewVYfFfsmokfAVMKWzOl1Sr0KGI5T9CpmRfAiSHpthhHWnECcJFwl72NTi6kUcUzG4se81
 O6n9d/kTj7pzTmBdfwuOZ0YUSqcqs0W+l1NcASSYZQaDoD3/SLk+nqVeCBB4OnYOGhgmIHNW
 0CwMRO/GK+20alxzk//V9GmIM2ACElbfF8+Uug3pqiHkVnKqM7W9/S1NH2qmxB6zMiJUHlTH
 gnVeZX0dgH27mzstcF786uPcdEqS0KJuxh2kk5IvUSL3Qn3ZgmgdxBMyCPciD/1cb7/Ahazr
 3ThHQXSHXkH/aDXdfLsKVuwDzHLVSkdSnZdt5HHh75/NFHxwaTlydgfHmFFwodK8y/TjyiGZ
 zg2Kje38xnz8zKn9iesFBCcONXS7txENTzX0z80WKBhK+XSFJwARAQABzR5UaG9tYXMgSHV0
 aCA8dGh1dGhAcmVkaGF0LmNvbT7CwXgEEwECACIFAlVgX6oCGwMGCwkIBwMCBhUIAgkKCwQW
 AgMBAh4BAheAAAoJEC7Z13T+cC21EbIP/ii9cvT2HHGbFRl8HqGT6+7Wkb+XLMqJBMAIGiQK
 QIP3xk1HPTsLfVG0ao4hy/oYkGNOP8+ubLnZen6Yq3zAFiMhQ44lvgigDYJo3Ve59gfe99KX
 EbtB+X95ODARkq0McR6OAsPNJ7gpEUzfkQUUJTXRDQXfG/FX303Gvk+YU0spm2tsIKPl6AmV
 1CegDljzjycyfJbk418MQmMu2T82kjrkEofUO2a24ed3VGC0/Uz//XCR2ZTo+vBoBUQl41BD
 eFFtoCSrzo3yPFS+w5fkH9NT8ChdpSlbNS32NhYQhJtr9zjWyFRf0Zk+T/1P7ECn6gTEkp5k
 ofFIA4MFBc/fXbaDRtBmPB0N9pqTFApIUI4vuFPPO0JDrII9dLwZ6lO9EKiwuVlvr1wwzsgq
 zJTPBU3qHaUO4d/8G+gD7AL/6T4zi8Jo/GmjBsnYaTzbm94lf0CjXjsOX3seMhaE6WAZOQQG
 tZHAO1kAPWpaxne+wtgMKthyPLNwelLf+xzGvrIKvLX6QuLoWMnWldu22z2ICVnLQChlR9d6
 WW8QFEpo/FK7omuS8KvvopFcOOdlbFMM8Y/8vBgVMSsK6fsYUhruny/PahprPbYGiNIhKqz7
 UvgyZVl4pBFjTaz/SbimTk210vIlkDyy1WuS8Zsn0htv4+jQPgo9rqFE4mipJjy/iboDzsFN
 BFH7eUwBEAC2nzfUeeI8dv0C4qrfCPze6NkryUflEut9WwHhfXCLjtvCjnoGqFelH/PE9NF4
 4VPSCdvD1SSmFVzu6T9qWdcwMSaC+e7G/z0/AhBfqTeosAF5XvKQlAb9ZPkdDr7YN0a1XDfa
 +NgA+JZB4ROyBZFFAwNHT+HCnyzy0v9Sh3BgJJwfpXHH2l3LfncvV8rgFv0bvdr70U+On2XH
 5bApOyW1WpIG5KPJlDdzcQTyptOJ1dnEHfwnABEfzI3dNf63rlxsGouX/NFRRRNqkdClQR3K
 gCwciaXfZ7ir7fF0u1N2UuLsWA8Ei1JrNypk+MRxhbvdQC4tyZCZ8mVDk+QOK6pyK2f4rMf/
 WmqxNTtAVmNuZIwnJdjRMMSs4W4w6N/bRvpqtykSqx7VXcgqtv6eqoDZrNuhGbekQA0sAnCJ
 VPArerAZGArm63o39me/bRUQeQVSxEBmg66yshF9HkcUPGVeC4B0TPwz+HFcVhheo6hoJjLq
 knFOPLRj+0h+ZL+D0GenyqD3CyuyeTT5dGcNU9qT74bdSr20k/CklvI7S9yoQje8BeQAHtdV
 cvO8XCLrpGuw9SgOS7OP5oI26a0548M4KldAY+kqX6XVphEw3/6U1KTf7WxW5zYLTtadjISB
 X9xsRWSU+Yqs3C7oN5TIPSoj9tXMoxZkCIHWvnqGwZ7JhwARAQABwsFfBBgBAgAJBQJR+3lM
 AhsMAAoJEC7Z13T+cC21hPAQAIsBL9MdGpdEpvXs9CYrBkd6tS9mbaSWj6XBDfA1AEdQkBOn
 ZH1Qt7HJesk+qNSnLv6+jP4VwqK5AFMrKJ6IjE7jqgzGxtcZnvSjeDGPF1h2CKZQPpTw890k
 fy18AvgFHkVk2Oylyexw3aOBsXg6ukN44vIFqPoc+YSU0+0QIdYJp/XFsgWxnFIMYwDpxSHS
 5fdDxUjsk3UBHZx+IhFjs2siVZi5wnHIqM7eK9abr2cK2weInTBwXwqVWjsXZ4tq5+jQrwDK
 cvxIcwXdUTLGxc4/Z/VRH1PZSvfQxdxMGmNTGaXVNfdFZjm4fz0mz+OUi6AHC4CZpwnsliGV
 ODqwX8Y1zic9viSTbKS01ZNp175POyWViUk9qisPZB7ypfSIVSEULrL347qY/hm9ahhqmn17
 Ng255syASv3ehvX7iwWDfzXbA0/TVaqwa1YIkec+/8miicV0zMP9siRcYQkyTqSzaTFBBmqD
 oiT+z+/E59qj/EKfyce3sbC9XLjXv3mHMrq1tKX4G7IJGnS989E/fg6crv6NHae9Ckm7+lSs
 IQu4bBP2GxiRQ+NV3iV/KU3ebMRzqIC//DCOxzQNFNJAKldPe/bKZMCxEqtVoRkuJtNdp/5a
 yXFZ6TfE1hGKrDBYAm4vrnZ4CXFSBDllL59cFFOJCkn4Xboj/aVxxJxF30bn
In-Reply-To: <20250508225042.313672-5-zycai@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.549,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On 09/05/2025 00.50, Zhuoying Cai wrote:
> DIAGNOSE 320 is introduced to support certificate store facility,
> which includes operations such as query certificate storage
> information and provide certificates in the certificate store.
> 
> Currently, only subcode 0 is supported with this patch, which is
> used to query a bitmap of which subcodes are supported.
> 
> Signed-off-by: Zhuoying Cai <zycai@linux.ibm.com>
> ---
>   hw/s390x/ipl.h                 |  1 +
>   include/hw/s390x/ipl/diag320.h | 17 +++++++++++++++
>   target/s390x/diag.c            | 40 ++++++++++++++++++++++++++++++++++
>   target/s390x/kvm/kvm.c         | 14 ++++++++++++
>   target/s390x/s390x-internal.h  |  2 ++
>   5 files changed, 74 insertions(+)
>   create mode 100644 include/hw/s390x/ipl/diag320.h
> 
> diff --git a/hw/s390x/ipl.h b/hw/s390x/ipl.h
> index ac1f7517ea..d9c089928e 100644
> --- a/hw/s390x/ipl.h
> +++ b/hw/s390x/ipl.h
> @@ -19,6 +19,7 @@
>   #include "system/address-spaces.h"
>   #include "system/memory.h"
>   #include "hw/qdev-core.h"
> +#include "hw/s390x/ipl/diag320.h"

Only adding a header #include without any other modifications to this file 
is a good indication that this include is not needed here. Unless you need 
this in later patches, please try to move it to the .c file(s) instead.

  Thanks,
   Thomas



Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3206CA2A4FC
	for <lists+qemu-devel@lfdr.de>; Thu,  6 Feb 2025 10:47:28 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tfyTT-0000AL-Da; Thu, 06 Feb 2025 04:47:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1tfyTR-0000A6-Oo
 for qemu-devel@nongnu.org; Thu, 06 Feb 2025 04:47:05 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1tfyTP-0002ng-W8
 for qemu-devel@nongnu.org; Thu, 06 Feb 2025 04:47:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1738835223;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=KgfcG/kbkWwTsyxXSQUkJ5Hp+hIiEVZ0e01DQfLmSFI=;
 b=J14xpWLuk0VT/SCz70Ny5Yp/K9SHM2/rKPEX4QFl+8MOdvqyzzO1IKZHOuPweDz6q5Bm2w
 vEOl6xACNIl3dx2jS8eViJ6JqFRwbR0aiNsPl2B3U5UFFzGq72haDerVA3Pah93iDLwHCl
 t59OgA3UxVlxc+lgi6q7wZifDXbk5i4=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-75-VlyJg-dMNt24yIlibWc5Cg-1; Thu, 06 Feb 2025 04:47:01 -0500
X-MC-Unique: VlyJg-dMNt24yIlibWc5Cg-1
X-Mimecast-MFC-AGG-ID: VlyJg-dMNt24yIlibWc5Cg
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-38dad88c1a0so250721f8f.1
 for <qemu-devel@nongnu.org>; Thu, 06 Feb 2025 01:47:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738835220; x=1739440020;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=KgfcG/kbkWwTsyxXSQUkJ5Hp+hIiEVZ0e01DQfLmSFI=;
 b=eLD80CIrL5cjEjPTjxPoP3zEgKobEDjs1pkbSJi2yzqV5CZJU8XWve695HnyWhlJwg
 3YTgRiNal6nkJylDrWqlqMRsENuSQ1woX1gjl5E7GqDQ9eFBRLJWqBpzQZjrSmbtQhcF
 p3LEbtd3SMx/Ovt/TGpC5F3YQBHqA3+fkXfvdlqMRuSPnw+9bIhh8qyUxqJs2PCoM2Sg
 cTujNez4LL40QKcHnrI8vzWe5n+TVuYhuVHv6HSGPdrLkHpjBvx/pLu0nrfCF09vT106
 zXWnmMhQB2xaOpQjY4PoGO4PzDuypKlqos5vH+LPxcQG3qeLndVG8xYVww3puk0ZA/ll
 VivA==
X-Gm-Message-State: AOJu0YxpCAF9oKrZoCdWcoxDwF2XFUQRwFoV2relpyP+i1JMLrXmSApr
 MG4tGMQyEMld5j5inYdLHjHo2iYkDOhuRBU0jCJlyGXO1twsZW4DiOXKdoF85s9Xt5/LapP18Mg
 ZhA4I1IcH4IokDzoZHvTHk7ftvuCL9GtKFcXr/BtOnK7w5jDhc1vJkE2dzExINlq2XusI7FdS66
 rQx4D71jy8xdlwmO6+6C5PqRHD6GSWI1p+
X-Gm-Gg: ASbGncu312vx2eDFjXy/gLjtvYJqqZFZ7byGz/mzFCDFxQVJMf1nRdY0qgm+pt0cJEg
 8PxckiGIzO2kXyuzB4RCt5TZC+IlUp1Bwj7deb6y4/doYc0VqjDrTjR7UeN7vuwBGe6buwJezCG
 z7sc/O1HfZVz1sy/wP0q3x4FtvyUnMUV1YNPXfxkfSc1lQEhiAyw1gBjDUH3GZ5kd7efjvRFOJX
 1HNltwqqje7+tKenjxQJS9VKfodbpIuSP4i5CdayXCWMgTv90WPmdW3HI00uBi4pwqb/u1nPc9S
 H6aQHybSqh/ogqLKuUVUwrRR9AXKs308ZaTp
X-Received: by 2002:a05:6000:178a:b0:38d:b325:4712 with SMTP id
 ffacd0b85a97d-38db4886abamr3718287f8f.8.1738835220369; 
 Thu, 06 Feb 2025 01:47:00 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHp1I+/qP1cGTplbR3zWJkAkZlEY2QwbhrIzFlO9A2RlYKtUtQrXHln2I3WLSbdsay2KwcRvw==
X-Received: by 2002:a05:6000:178a:b0:38d:b325:4712 with SMTP id
 ffacd0b85a97d-38db4886abamr3718269f8f.8.1738835219910; 
 Thu, 06 Feb 2025 01:46:59 -0800 (PST)
Received: from [192.168.0.7] (ip-109-42-48-132.web.vodafone.de.
 [109.42.48.132]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38dbde0fd18sm1260878f8f.72.2025.02.06.01.46.59
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 06 Feb 2025 01:46:59 -0800 (PST)
Message-ID: <582aea1e-8bf6-4d72-8c1b-3ef608605a0a@redhat.com>
Date: Thu, 6 Feb 2025 10:46:58 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/5] tests/functional: skip mem addr test on 32-bit hosts
To: qemu-devel@nongnu.org
References: <20250205155946.2811296-1-berrange@redhat.com>
 <20250205155946.2811296-6-berrange@redhat.com>
 <18acac8d-271a-4641-893e-93096f31a2ac@linaro.org>
 <Z6SCeWUMuhUa5zGG@redhat.com>
Content-Language: en-US
From: Thomas Huth <thuth@redhat.com>
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
In-Reply-To: <Z6SCeWUMuhUa5zGG@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

On 06/02/2025 10.35, Daniel P. Berrangé wrote:
> On Wed, Feb 05, 2025 at 10:24:08AM -0800, Richard Henderson wrote:
>> On 2/5/25 07:59, Daniel P. Berrangé wrote:
>>> +
>>> +'''
>>> +Decorator to skip execution of a test on 32-bit targets
>>> +Example:
>>> +
>>> +  @skipIf32BitTarget()
>>> +'''
>>> +def skipIf32BitTarget():
>>> +    enoughBits = sys.maxsize > 2**32
>>
>> This will work for true 32-bit hosts, and possibly for containers running
>> emulation, but it won't work for cross-compilation (x86_64 to i686 or
>> aarch64 to arm).
>>
>> Perhaps "file qemu-system-foo" | grep "ELF 32-bit" ?
>> I don't know that we've actually selected the executable at this point though...
> 
> The QEMU_TEST_QEMU_BINARY env variable exists at all times, though
> grepping for ELF format feels a bit icky.
> 
> We also know the location of the build directory, so was wondering if
> anything there tells us whether the host target is 64-bit, but it
> appears not be the case.

Maybe it's sufficient to wait for Richard's patch to get merged:

  https://lore.kernel.org/qemu-devel/20250204215359.1238808-11-richard.henderson@linaro.org/

?

  Thomas



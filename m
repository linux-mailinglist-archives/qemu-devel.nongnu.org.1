Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 01AA0AA8F1F
	for <lists+qemu-devel@lfdr.de>; Mon,  5 May 2025 11:14:17 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uBrs6-0006zn-Ku; Mon, 05 May 2025 05:12:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1uBrpb-0001iI-LH
 for qemu-devel@nongnu.org; Mon, 05 May 2025 05:09:53 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1uBrpZ-0006fj-CC
 for qemu-devel@nongnu.org; Mon, 05 May 2025 05:09:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1746436184;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=fkHFZS//Zu2P6ae7HsTgt9fn/PJjdj/RqyWgvyb5OMk=;
 b=crr9kHigVTJOWjD6CAt4L7YlLs7K3MgT7KCVEbQLkhS6ReplOQFyLHZfZv1wZPlLa57H6U
 tVLl9rQzAKrvgVWtoSw8EAip4QjvrITOfhvKD5XAYusAXK3Log/XzZR7FfL/+dYIwsoGG2
 zS2vbXmc73SkoUxB/dTQwK52FpXuBGc=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-609-fWBgbGF2MUSTZv8ssCGVaA-1; Mon, 05 May 2025 05:09:43 -0400
X-MC-Unique: fWBgbGF2MUSTZv8ssCGVaA-1
X-Mimecast-MFC-AGG-ID: fWBgbGF2MUSTZv8ssCGVaA_1746436182
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-43e9b0fd00cso17514345e9.0
 for <qemu-devel@nongnu.org>; Mon, 05 May 2025 02:09:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746436182; x=1747040982;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=fkHFZS//Zu2P6ae7HsTgt9fn/PJjdj/RqyWgvyb5OMk=;
 b=cA6UXQvjoQosm2MAmmjh48vhajJ95OwgNrOSqSg/6ML8RzL+aHumeHSxdemIA0Q8un
 1yUh6PECAR0EVS4e7NGuD1gyl1/9P3uXsHxVV98SU+4S7lHxVQh5Ft+Mx2jLctt067oO
 wJASSkkRfT69tFAjbOT+ncn9kP5t1EHMAx2K4a1pqYLFZ94QyuHGlS2uFZnMSvbHNkfi
 ux7SaMsMrgq/XClwDizXcVl5KlUPppJq5XFXWXDRdg+q82ug9fhP/OKpppnOPhxXpD7D
 Iwkh4hwqksZ3WAoWYNJ2TXa2A4+hlFkGKDYS7jxcjuIhQ/QJr80ZVwgRIr6DCig0p8A0
 tIVg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWOIflAf4/I++IENcWbkbGMu83w+aJZ4J8Z16S0QL45wuxHZCBSN9SjCFJQDgbFcbnb2BfQqE2v0Vef@nongnu.org
X-Gm-Message-State: AOJu0YweR8plcD/rPJvXlyA1IC38UtH3PgFXIhtX+47gS1JEwd+XU1CB
 7ErslGW7EPnUdGpuD8xdJnmZDyTdOqEazKSO9/QheY/5OiMdZBKIEm1JCxP+MZRk5Mt0K0W0Iig
 Niaf0bK8RdTjy2RDkNquh82EyxVXIMS2ymPs/fOJjt4PKVgNPkHLT
X-Gm-Gg: ASbGncuvqYaOKRrzuZ1SQc5uRfBsPhdyyKnR2j1f73gXFgYPCqsQu0AlULbT3uFGpqn
 0qPvqbAIhEDD+tlGVWwEEBBSuJONN2slNk6odO2Aqb2oOZWDWwMA9w+h5yDT6ft+qRKWr977C/o
 BaQx1/YTukKZ86Y0EQZo0OYP9k/X7n4e+nzmfWA5vcCoZWUcU517x6ZLj64PjA2C+kjNtrX13G/
 dJQNzXu1ivxuOcn+kzQuL38Pk8edry40grVqEsHTpetmUdtY5DV3X4EodOsnFYaN+6NTVG9Mi6+
 pKW+/8hfOgT4/T2HDSBmgN//X4of9RQnmxatn5jg
X-Received: by 2002:a05:600c:a40a:b0:43d:b33:679c with SMTP id
 5b1f17b1804b1-441c05232f9mr77411345e9.14.1746436181928; 
 Mon, 05 May 2025 02:09:41 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHuU4IU5LLgQBJVX/+0BbJkxX+mmXCTwHAKQ20DTFPpFDruRra/JtGe7vzWrbRAPer3Uj/CrQ==
X-Received: by 2002:a05:600c:a40a:b0:43d:b33:679c with SMTP id
 5b1f17b1804b1-441c05232f9mr77411035e9.14.1746436181555; 
 Mon, 05 May 2025 02:09:41 -0700 (PDT)
Received: from [192.168.0.7] (ip-109-42-49-87.web.vodafone.de. [109.42.49.87])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-441b89ee593sm124994365e9.24.2025.05.05.02.09.39
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 05 May 2025 02:09:41 -0700 (PDT)
Message-ID: <712965d9-4521-4867-98a2-f22c7d311182@redhat.com>
Date: Mon, 5 May 2025 11:09:39 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 05/16] hw/intc/apic: Remove
 APICCommonState::legacy_instance_id field
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Igor Mammedov <imammedo@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?Q?Cl=C3=A9ment_Mathieu--Drif?= <clement.mathieu--drif@eviden.com>,
 Yi Liu <yi.l.liu@intel.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Amit Shah <amit@kernel.org>, Zhao Liu <zhao1.liu@intel.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Sergio Lopez <slp@redhat.com>, Laurent Vivier <lvivier@redhat.com>,
 Jason Wang <jasowang@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
 Yanan Wang <wangyanan55@huawei.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Ani Sinha <anisinha@redhat.com>
References: <20250501183628.87479-1-philmd@linaro.org>
 <20250501183628.87479-6-philmd@linaro.org>
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
In-Reply-To: <20250501183628.87479-6-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -44
X-Spam_score: -4.5
X-Spam_bar: ----
X-Spam_report: (-4.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.411,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
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

On 01/05/2025 20.36, Philippe Mathieu-Daudé wrote:
> The APICCommonState::legacy_instance_id boolean was only set
> in the pc_compat_2_6[] array, via the 'legacy-instance-id=on'
> property. We removed all machines using that array, lets remove
> that property, simplifying apic_common_realize().
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   include/hw/i386/apic_internal.h | 1 -
>   hw/intc/apic_common.c           | 5 -----
>   2 files changed, 6 deletions(-)

Reviewed-by: Thomas Huth <thuth@redhat.com>



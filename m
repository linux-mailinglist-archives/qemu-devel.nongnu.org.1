Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 596FCB4FE73
	for <lists+qemu-devel@lfdr.de>; Tue,  9 Sep 2025 15:59:26 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uvys1-0004AF-JN; Tue, 09 Sep 2025 09:58:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1uvyry-00047v-0V
 for qemu-devel@nongnu.org; Tue, 09 Sep 2025 09:58:50 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1uvyrn-0005pZ-8r
 for qemu-devel@nongnu.org; Tue, 09 Sep 2025 09:58:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1757426316;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=z6EGipz7vidKh7WGpdfosCzRAyYOSWnjgsAPpXUl1Zw=;
 b=CMuhl7hrFw239iRJMOhuJS586vkD27ht2gQtd2YpbscYcHZMd+7m58ZZ2tiNBQ8Z+aDjzY
 1Y5zGJB9V60r92qAv8LvS8EKFwlp0i+J/TEwZuHSuZUj1Tl//npxMru7ZdKkg+kTEsHmhr
 pIH5D/4jEmbFrXesbhxqlv6eNQUtDro=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-10-nvms_T2wNC6IkGzjdmKgrA-1; Tue, 09 Sep 2025 09:58:34 -0400
X-MC-Unique: nvms_T2wNC6IkGzjdmKgrA-1
X-Mimecast-MFC-AGG-ID: nvms_T2wNC6IkGzjdmKgrA_1757426313
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-3e067ef24aaso2925825f8f.3
 for <qemu-devel@nongnu.org>; Tue, 09 Sep 2025 06:58:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1757426313; x=1758031113;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=z6EGipz7vidKh7WGpdfosCzRAyYOSWnjgsAPpXUl1Zw=;
 b=NoaEKwTesfSONqyWGN2GjNtGS58RN6v8kgSTSlP+vD7/eeYxi1NBQ4N1bsfzYmAF2n
 VmVpkVPW9Cxb38zCXZrj+NCPAwPejIHPpH3Q7EhSKqggmqb8+TsCw001yZy/dcgjOHVT
 eZ+D7wCQ/gL1fohPARx6FT9y4RCe7QzgxvLmwsuSfKfAn1i35VUruHv2dASfXHWAkjJB
 +Ufy/Uev9GfNKk57EwJs6FyOGWe5GQffHV8Md+gH2d0ldViA7H/hhcKHj2PZIsGqI6nT
 pesvRrgwhY1iOf6FWsepWNHlOaJvQkczc8a4xdWf7zyo+wvDqB8Vu277v2wwFocxlrP6
 Ucbg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWLIeDbeeXw00GcueiSWTFhn793Ghah1WpLUxPLKWqCiBVoqiwuPOzyWcK0Vja9idyet8MJMOoYmqKY@nongnu.org
X-Gm-Message-State: AOJu0Yx9T2eKNwAZgnju6HlEWsOWhnzViS6uSeM3/CxaxT0QWiYTg61e
 3Ur2oxNe3hLSOMsRv+q9+X80gQdZJ4qC8DA47tuNiwoE5ywZW/kImwz8T+Bwk7WMw+PexUEXsFb
 2QaTOm/KXjPdd3BnwKGhO6xRInIZx6aNCwyBsfTZjT/6gel3PJqoRxogP
X-Gm-Gg: ASbGncuZe/V5rqUQ+xCSv79MxOuYSzNvwkg7O1nobcW/5CM7Z0gNe3eAjpovu/+mSBp
 wFMjeRZZKhM8iWZdlFT/fbf6ShtzrZjXCwmwz6xYHAx8pvHDYxAbrG/07WW6vFod2T0lKq8WOGX
 vYQNWLe7q/jWgPlu3zD26cjKU1jvGLTHJn/kXNHJgrUFw33TNUWddD3CNfBwzNvE37VfkMQ1b1U
 S17fXhHMG1gVDUKpQEmXYv3g8MJk/sdYxulOz+HyZyyHnx71TsshdcKBn80+F1SC+PfNPHD9Hx5
 /GhLkuJHRenK03J+0SDN7DEhY/pECglcbMHk2+t9prRhiZ2C3n911yKlFHhiO/uAiLAh3d80WvF
 /n42xlg==
X-Received: by 2002:a05:6000:4211:b0:3ce:f0a5:d597 with SMTP id
 ffacd0b85a97d-3e64c1c34aamr9915655f8f.47.1757426313253; 
 Tue, 09 Sep 2025 06:58:33 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEx4IlzxsitH9UHIUtpCCO1ep2Fiav12MvBArvi9Yp8UpQH/9Rm+5IhGGLogGrrqgRUzC7ASw==
X-Received: by 2002:a05:6000:4211:b0:3ce:f0a5:d597 with SMTP id
 ffacd0b85a97d-3e64c1c34aamr9915629f8f.47.1757426312846; 
 Tue, 09 Sep 2025 06:58:32 -0700 (PDT)
Received: from [192.168.0.7] (ltea-047-064-113-183.pools.arcor-ip.net.
 [47.64.113.183]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3e75223ea04sm2714645f8f.45.2025.09.09.06.58.31
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 09 Sep 2025 06:58:32 -0700 (PDT)
Message-ID: <183727ca-2e8a-47d5-b3a8-094afce03268@redhat.com>
Date: Tue, 9 Sep 2025 15:58:31 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 0/3] vfio-user client functional test
To: John Levon <john.levon@nutanix.com>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>,
 Thanos Makatos <thanos.makatos@nutanix.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Zhao Liu <zhao1.liu@intel.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, Paolo Bonzini <pbonzini@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
References: <20250903201931.168317-1-john.levon@nutanix.com>
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
In-Reply-To: <20250903201931.168317-1-john.levon@nutanix.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 03/09/2025 22.19, John Levon wrote:
> Add a basic functional test for the vfio-user client, along with a couple of
> test framework extensions to support it.
> 
> v4: generalize the test so it's less sensitive to build/environment
> 
> John Levon (2):
>    tests/functional: return output from cmd.py helpers
>    tests/functional: add vm param to cmd.py helpers
> 
> Mark Cave-Ayland (1):
>    tests/functional: add a vfio-user smoke test

  Hi,

FYI, I've added the first two patches to my current pull request from today 
(since there's another series on the list that needs similar changes to 
cmd.py, so we can hopefully get the conflict sorted that way).

For the third patch, I assume this will go via the vfio-user tree once 
you've addressed Daniels review comments - if not, let me know, then I can 
pick it up the next time.

  Thomas



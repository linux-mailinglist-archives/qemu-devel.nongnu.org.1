Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7531D9D1065
	for <lists+qemu-devel@lfdr.de>; Mon, 18 Nov 2024 13:11:50 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tD0aX-0003Ec-L9; Mon, 18 Nov 2024 07:10:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1tD0aQ-0003Di-G7
 for qemu-devel@nongnu.org; Mon, 18 Nov 2024 07:10:34 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1tD0aO-00075S-N5
 for qemu-devel@nongnu.org; Mon, 18 Nov 2024 07:10:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1731931823;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=xHv2pD9IjAuiXRjPI7vldUH0WTlhycdzI9zUaUm2vPA=;
 b=L3dTd5xQ0OtzpbhOxZkPJLSsDNpWr3f3fnIfUquvkIVRRZvz7MWv4E69U9fqHzUE+48WSn
 c4a105fp+cvU8TkxCLTQ2iMgj2hauDmOQ33CkihuhxA0OjVRg4qMDpj7IUAwuxNo+NiINp
 jIrZcSLvsR2ubo7iVOCNwRxX6FMm3eA=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-688-ZEXvYmtOO0KNNeM39hlJKA-1; Mon, 18 Nov 2024 07:10:19 -0500
X-MC-Unique: ZEXvYmtOO0KNNeM39hlJKA-1
X-Mimecast-MFC-AGG-ID: ZEXvYmtOO0KNNeM39hlJKA
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-7b16223e610so444480285a.2
 for <qemu-devel@nongnu.org>; Mon, 18 Nov 2024 04:10:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731931818; x=1732536618;
 h=content-transfer-encoding:in-reply-to:autocrypt:cc:from
 :content-language:references:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=xHv2pD9IjAuiXRjPI7vldUH0WTlhycdzI9zUaUm2vPA=;
 b=Bmt+Yai5RbhQiQ8HaquYt20LClzG9PTY4EjD4xVNvRwsRMttQNp3VsTgqjhdb6wtz7
 6WKyPAJmf5bAgf/BRNmwx9Bbf+U1F5JqOC+VnDYCiHiKSL22d2FIR8FRliq5J2u3ZXV2
 Wpad/wewR4we4c1QI8amNrkDDeAYL9uA0FE12b80kAtuc4VTWoDFOPxmC3SBicQks09W
 x7mR/mG13kdPgGK0r4Qky25540hL3A03bpZTIVrx1gXfosk2cR81HudD5qeBH4+yOPIY
 A07axBAIhWBtRKb7LW6zjuUvI8jh7czNeXGLLrTOfw3ZBBUC3w9yBit5f8NuSvZPsBhw
 I6zg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWgMplcwq+sYC06y0DQ8Re9C5kPl/hVfR1Iem65uMB3LhQJd3A/LMf983NtXYm2HYxGU1MvmvBukjWJ@nongnu.org
X-Gm-Message-State: AOJu0YzVXPJe7r7bwGu6e+K/FkB1fE7cGxZ9ePYDWUej9AaitXJROPoZ
 /kSHcnetOiKuEjGIGON5s591EhtP4IuAnUTX17BYL+0ZctXTVl1jxnMYPHSfkFqaDPDY/0MDkpA
 AXlMQ0Z6DHQ8huaZEkyB957+k3abe/65oeRmv+UDrugJDQWKwOXtB
X-Received: by 2002:a05:6214:1c07:b0:6d4:1662:348c with SMTP id
 6a1803df08f44-6d41662394bmr106230916d6.17.1731931818369; 
 Mon, 18 Nov 2024 04:10:18 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFhicQBHE0BrvYv32BIX4ALcJzSJNUFZEKa1bstUGJMI+BfePcuBlytylDsKI46NndiyJGOFA==
X-Received: by 2002:a05:6214:1c07:b0:6d4:1662:348c with SMTP id
 6a1803df08f44-6d41662394bmr106230626d6.17.1731931818081; 
 Mon, 18 Nov 2024 04:10:18 -0800 (PST)
Received: from [192.168.0.7] (ip-109-42-48-145.web.vodafone.de.
 [109.42.48.145]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7b35ca51c6csm472825685a.101.2024.11.18.04.10.16
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 18 Nov 2024 04:10:17 -0800 (PST)
Message-ID: <15635bd3-97fa-4c11-9427-c615d1b57dd1@redhat.com>
Date: Mon, 18 Nov 2024 13:10:14 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: tests/functional is eating disk space
To: Peter Maydell <peter.maydell@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>
References: <CAFEAcA8hHMj0718haB_uZhE-LQF4W9PYrL-na0iznp4ueDsq7g@mail.gmail.com>
Content-Language: en-US
From: Thomas Huth <thuth@redhat.com>
Cc: "Daniel P. Berrange" <berrange@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
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
In-Reply-To: <CAFEAcA8hHMj0718haB_uZhE-LQF4W9PYrL-na0iznp4ueDsq7g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.141,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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

On 18/11/2024 11.57, Peter Maydell wrote:
> I just ran out of disk space on my dev machine, because:
> 
> $ du -h build/clang/tests/functional/
> [...]
> 11G     build/clang/tests/functional/

That's indeed a lot. I only got 6.9G in my build tree for all targets ... I 
guess there are some stale files lying around, so as a temporary mitigation, 
just try to delete that folder (it should get recreated the next time you 
run the tests).

> The new functional tests seem to be eating disk space.
> 
> Even the build tree I have that's just arm targets is 7.1GB.
> 
> Could you have a look at what's happening here?

I am aware of the problem and got it on my TODO list already... I think we 
best should set the "workdir" to a temporary folder that we can remove once 
the test has finished, that will automatically delete all binary assets that 
the test created during its runtime.

  Thomas



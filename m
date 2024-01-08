Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E402C827388
	for <lists+qemu-devel@lfdr.de>; Mon,  8 Jan 2024 16:37:07 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rMrfb-0005JN-OJ; Mon, 08 Jan 2024 10:36:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1rMrfZ-0005B2-N9
 for qemu-devel@nongnu.org; Mon, 08 Jan 2024 10:36:05 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1rMrfV-0005cm-Ki
 for qemu-devel@nongnu.org; Mon, 08 Jan 2024 10:36:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1704728160;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=LvwV0TOqkoGSlixMO7zV1TtypS8ZUFgPx4R8cAsUgY8=;
 b=Oxt65Z2NfNl6EKNVrpg9cD/bYCB/OIVSXgW/uXslYNaGXy6KyjZmYeLfjPq6EYQxQCtOu4
 x+YiKZ3Z++XQjQnF9R+lBpFLtGYHxsinCi/aObEOrKZw3cv4Ot5UfitgeI/g09p5+j7fH2
 cwSp0+d4B9sCj4gcMuyA6SFm26tJOq4=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-595-geIAi-z7N2WMXxZJQROXVw-1; Mon, 08 Jan 2024 10:35:58 -0500
X-MC-Unique: geIAi-z7N2WMXxZJQROXVw-1
Received: by mail-qt1-f197.google.com with SMTP id
 d75a77b69052e-4298c15d3a9so25517391cf.0
 for <qemu-devel@nongnu.org>; Mon, 08 Jan 2024 07:35:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704728158; x=1705332958;
 h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=LvwV0TOqkoGSlixMO7zV1TtypS8ZUFgPx4R8cAsUgY8=;
 b=c1QXLmTzkDx2Tse/9Z/7xMFe+io3YQrzdSoC5Z+Dp+OlpeovIDVgCGAJvGj+ONZ/gF
 p+RzXDtIQxJFScG/aFAzgZLQOdEPYFVc5clWsR0JUYbw8iBdQ1Of48F8LiZi+trrqsvQ
 0PQuXhZY/J/f7a+rWjGpoL1ZkkJCHC1dWzZ254ypxVL1s9qhRhk+AxWTjJfutSRYLuwt
 2bAcz0O7m/5VesuUT067XLWNUURDEAa+YpXn8TmtSN37v9/IyUIsxZ85ArxuR1NvJ5NW
 j6COXwvhd9zzzB33JVaI8OhGj/JfD2PnVR/v72vihTePJRB1+P+tuHptNF2AVe0A8RmT
 z7pw==
X-Gm-Message-State: AOJu0YyhyCQw0f1cJmYxpyVDCH2UWE/l7kN1PXz0a59D/iTPUPEjYIXw
 wbyslPG8d4Tg8fUFcm/D9Of+s2tZ4QCathpyJgb+luFRVwhpsv6HlT6g4SDsOUOIbsRA6Iu/WxV
 OOjfaKcJAvNxZFHGLrwCD1nY=
X-Received: by 2002:a05:622a:f:b0:429:9a0e:d2e9 with SMTP id
 x15-20020a05622a000f00b004299a0ed2e9mr928496qtw.108.1704728158292; 
 Mon, 08 Jan 2024 07:35:58 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFIX9u8APkn99XMPv3aCDrFDCFgt9BJ1yaFjx+MHPky41XCsjZNfe21lpg41z8VOGb4SzZceQ==
X-Received: by 2002:a05:622a:f:b0:429:9a0e:d2e9 with SMTP id
 x15-20020a05622a000f00b004299a0ed2e9mr928481qtw.108.1704728157955; 
 Mon, 08 Jan 2024 07:35:57 -0800 (PST)
Received: from [192.168.0.9] (ip-109-43-179-78.web.vodafone.de.
 [109.43.179.78]) by smtp.gmail.com with ESMTPSA id
 v21-20020ac87495000000b00429a0688f8fsm60292qtq.68.2024.01.08.07.35.55
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 08 Jan 2024 07:35:57 -0800 (PST)
Message-ID: <ee980401-5640-418b-a9f1-dc03169f020b@redhat.com>
Date: Mon, 8 Jan 2024 16:35:54 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] docs: use "buses" rather than "busses"
Content-Language: en-US
To: Pavel Pisa <pisa@fel.cvut.cz>, Samuel Tardieu <sam@rfc1149.net>,
 Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, qemu-trivial@nongnu.org,
 Vikram Garhwal <fnu.vikram@xilinx.com>, Jason Wang <jasowang@redhat.com>
References: <20240103172817.2197737-1-sam@rfc1149.net>
 <202401032234.12134.pisa@fel.cvut.cz>
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
In-Reply-To: <202401032234.12134.pisa@fel.cvut.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.243,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

On 03/01/2024 22.34, Pavel Pisa wrote:
> On Wednesday 03 of January 2024 18:28:17 Samuel Tardieu wrote:
>> If "busses" might be encountered as a plural of "bus" (5 instances),
>> the correct spelling is "buses" (26 instances). Fixing those 5
>> instances makes the doc more consistent.
>>
>> Signed-off-by: Samuel Tardieu <sam@rfc1149.net>
> Reviewed-by: Pavel Pisa <pisa@cmp.felk.cvut.cz>
> 
> PS: there is waiting my previous CAN FIX from December 14
> and I have received any feedback if it will be taken
> by somebody with commit rights
> 
>    https://gitlab.com/qemu-project/qemu/-/issues/2028
>    https://patchew.org/QEMU/20231214104623.31147-1-pisa@fel.cvut.cz/
> 
> Should I resend it?

Since you (and Vikram) are listed as a maintainer for the CAN subsystem,  so 
if there were no objections, it's maybe easiest if you send a pull request 
for it. See this page for some more information:

  https://www.qemu.org/docs/master/devel/submitting-a-pull-request.html

Basically:
- Stick your patch(es) in a branch on your public repository
- Create a signed git tag ("git tag -s ...") and push it to your repo
- git format-patch --cover-letter --subject-prefix=PULL ...
- Use "git request-pull" to create the contents of the cover letter
- Send them to the qemu-devel mailing list

  HTH,
   Thomas





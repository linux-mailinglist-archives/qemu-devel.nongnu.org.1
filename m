Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B45FC8BC69A
	for <lists+qemu-devel@lfdr.de>; Mon,  6 May 2024 06:51:34 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s3qIl-0003gq-8l; Mon, 06 May 2024 00:50:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1s3qAo-0001Os-Gh
 for qemu-devel@nongnu.org; Mon, 06 May 2024 00:42:02 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1s3qAm-00026b-9F
 for qemu-devel@nongnu.org; Mon, 06 May 2024 00:41:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1714970512;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=JR8n/Tllmjm0G1lB8+ML5Tpv6SVFI1c7XPk5XjIsyD4=;
 b=iBK42qDy/DQkzgySYvKPg1aJVSQpZHSe+CYvuKnfQrhpQnbtIMJCqAGO8Fmpym5yBHbbV8
 Ws2NmmWl9Lr+RMauWTkuvGpfIknqLDw0J8/47gqqwF6fhBCW3xhso4mJgET1wNk+puyu5o
 u+QKqpFoZ1sAZj9oX2zFFzBdOKRpJCQ=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-686-OcGXeRWaOb6_GU4fo7CEHg-1; Mon, 06 May 2024 00:41:50 -0400
X-MC-Unique: OcGXeRWaOb6_GU4fo7CEHg-1
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-7928d36432bso271120685a.0
 for <qemu-devel@nongnu.org>; Sun, 05 May 2024 21:41:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714970510; x=1715575310;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=JR8n/Tllmjm0G1lB8+ML5Tpv6SVFI1c7XPk5XjIsyD4=;
 b=NeCiK640VP37XXB7Vox9ZGcNM6/fWNNTPbNQlyVqZ2AFkbT6p7zKOuVb/vs52wezz0
 jy0ADk6ia0qoHFVL4H5RncYRDTLAMRzajIvzvE+6dxUWZpu731sffW9KLxEzFQHCiICH
 DHGNDvP+Ukcshq1JTdSmdtmU5DUl0lvDAoEwXjWEMxOUz+4sbaqrrqQHM+IGimpJN02k
 ogqcWNVUx+9oIyZj/JQMi3xZvt45EcD+FxVAQF32/QALQnuQ4eJwXH7MJxXINWIGJe3o
 /sprz3OCX2ddrYtbbgwW4SshRal2SB2ivDhIHBm3bPzvK1DZF0YTjx7Tpfr0zZjQ1GqQ
 IJ+w==
X-Forwarded-Encrypted: i=1;
 AJvYcCWtHaspX6whkYLQO1o9JdWuhSrAbNb9yES4sXZ1ZNMTt1G9lD1LWkFnrpk/9qASiVAXdaV3rk11Ia6AXZHMod0JWp9N3tA=
X-Gm-Message-State: AOJu0YzIgzkVLSYl2xIZVCy3/q4QErH7ELBLiUbEGsmtNlUDt2k/6qHB
 IpPPHhr9LjD3VqJcOgQy5K+fX3zpoVPSrP1dx8dt4+5CTzzW43NWhl0+xWkMw/3vPG8i8R1Vc6+
 1PU3es8V9t5muFGVfwmIhdwtSWFIDwgF6Lys+9bRej6BXdc/Hymzq
X-Received: by 2002:a05:620a:27cd:b0:790:f930:e1ca with SMTP id
 i13-20020a05620a27cd00b00790f930e1camr12220821qkp.26.1714970510348; 
 Sun, 05 May 2024 21:41:50 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH8h5hUygpID12a/NyNyZ1mOTH2BlPIWhlr1oxQWezag4HVTWqZIZ3/sVk5pkk6zEXisZDMxw==
X-Received: by 2002:a05:620a:27cd:b0:790:f930:e1ca with SMTP id
 i13-20020a05620a27cd00b00790f930e1camr12220804qkp.26.1714970509751; 
 Sun, 05 May 2024 21:41:49 -0700 (PDT)
Received: from [192.168.0.9] (ip-109-43-179-34.web.vodafone.de.
 [109.43.179.34]) by smtp.gmail.com with ESMTPSA id
 g4-20020a05620a108400b00790676d0fe2sm3523983qkk.121.2024.05.05.21.41.47
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 05 May 2024 21:41:49 -0700 (PDT)
Message-ID: <b655fa90-d9a8-475b-ac65-27bf12a48916@redhat.com>
Date: Mon, 6 May 2024 06:41:45 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Fixes: Indentation using TABs and improve formatting
To: Michael Tokarev <mjt@tls.msk.ru>, Tanmay <tanmaynpatil105@gmail.com>,
 qemu-stable@nongnu.org, QEMU Developers <qemu-devel@nongnu.org>,
 qemu-arm <qemu-arm@nongnu.org>, Peter Maydell <peter.maydell@linaro.org>
References: <CAHnsOnM6gzcjpmEqCN0cFjZKXZCK_ZGAphuf46xWmUyBcNrAxQ@mail.gmail.com>
 <df14595f-3a26-4b7f-948d-df522f487b92@tls.msk.ru>
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
In-Reply-To: <df14595f-3a26-4b7f-948d-df522f487b92@tls.msk.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.431,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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

On 04/05/2024 22.34, Michael Tokarev wrote:
> 04.05.2024 21:58, Tanmay wrote:
>> Hi,
>>
>> I have attached a patch file that fixes indentation and formatting for 
>> some files as listed in https://gitlab.com/qemu-project/qemu/-/issues/373 
>> <https://gitlab.com/qemu-project/qemu/-/issues/373>.
> 
> it is sort of good you posted this patch to stable@.  It has absolutely 
> nothing to do
> with stable, but it serves as a an example of things which should - in my 
> opinion -
> not be done at all.

I disagree. Yes, clean-up patches like this make it somewhat difficult to 
backport other patches to stable, but that should not be the reason to not 
do cleanups at all. If we keep badly formatted code in the repository, 
people will copy-n-paste it to other places, or if you have to do fixes in 
sources that have mixed TABs and spaces, you often get complaints from 
checkpatch.pl though it is not your fault. So we should get this straight at 
one point in time.

So, Tanmay, could you please resend your patch, this time to 
qemu-devel@nongnu.org instead of qemu-stable, and CC: qemu-arm@nongnu.org 
and the corresponding ARM maintainers (you can use 
scripts/get_maintainers.pl to find out the correct maintainers that should 
be CC:-ed). And if possible, please send your patch inline and not as an 
attachment (so it's possible to comment on the patch via hitting the reply 
button), preferably with "git send-email" instead of using your e-mail program.

  Thanks!
   Thomas



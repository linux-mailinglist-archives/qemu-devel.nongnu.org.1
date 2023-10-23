Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DBCFC7D29D8
	for <lists+qemu-devel@lfdr.de>; Mon, 23 Oct 2023 07:58:58 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qunwA-0003u5-SM; Mon, 23 Oct 2023 01:57:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qunw4-0003tQ-Oa
 for qemu-devel@nongnu.org; Mon, 23 Oct 2023 01:57:08 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qunw1-0001xh-UA
 for qemu-devel@nongnu.org; Mon, 23 Oct 2023 01:57:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1698040625;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=Z9I8Gy+tt9muRxgB7Y4VOE11YLz3BOwS5tkxgCmtRDE=;
 b=U1xM0lG1goWaEX9qvY7p5SFAsm3/sbr5L2En8u2R3QB3Xg/3n8aSnhmqUDtPFAO5Uz170Z
 /rXPGIac4xLEsdBN1sHnuUIRD+0jH14Ue7PfqK7oFmBEqz3Sf8bleZ/SIbVzl9afBqKlsI
 9GYJktjW1SVktVRDtvGig6Bp1c1MwtI=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-198-6DAWWVx9PEyU2N56X541TA-1; Mon, 23 Oct 2023 01:57:01 -0400
X-MC-Unique: 6DAWWVx9PEyU2N56X541TA-1
Received: by mail-ej1-f71.google.com with SMTP id
 a640c23a62f3a-9c7f0a33afbso102843966b.3
 for <qemu-devel@nongnu.org>; Sun, 22 Oct 2023 22:57:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698040620; x=1698645420;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Z9I8Gy+tt9muRxgB7Y4VOE11YLz3BOwS5tkxgCmtRDE=;
 b=Le/6N4FPXieivErQp3/xb00d5EvDKNMQvTTm5ZpSurUwK7538aJ0pnzLC6pL+fJyGt
 rW/swxRb6I0Mi9yFuuy6OmtbQ7IxSG1nsL4JmEtV6jG8Sl74mSMvN0IAMQAYv8gp6ep2
 Zb+Xxa1phZ6GJF8wd7kdsEUzue4eHRlTiyPxOk7bdTNHxjXJI9DIDGzcc2dMrtPhSLw9
 W/JTX9xCzJs8ofE9d2llhoIKEyuP2i3zVO91qnFG7kHwlvDMlkZapS6vFFsfIREP92P+
 kyII1MkEv+Dv48hGdUxqwOQpHO/Rk2flNmTCMfo0LLZ9u41P4zbFwo43bh4YKTvPCMIh
 3zIQ==
X-Gm-Message-State: AOJu0YzmijUboD3KzJp0hyjHNhkC1m8903G7nKiKkHWyc1H2rczhBMRK
 Szip7HYwY466OWzJcylA2RliE5l6XlPi5vsaKXJHjCKXHqkC0YgdYN+jc2h83nL8VDlDI7gHAiF
 4Qyo63F9rD628wFY=
X-Received: by 2002:a05:6402:510d:b0:53f:731a:e513 with SMTP id
 m13-20020a056402510d00b0053f731ae513mr6037318edd.25.1698040620258; 
 Sun, 22 Oct 2023 22:57:00 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHzCbtRLbcftpx1UEFMUW1GK48mVhHVByOCVzDS1CuoPQRu5xP/KWd9pLn80/0//l5x7FR4jg==
X-Received: by 2002:a05:6402:510d:b0:53f:731a:e513 with SMTP id
 m13-20020a056402510d00b0053f731ae513mr6037315edd.25.1698040619978; 
 Sun, 22 Oct 2023 22:56:59 -0700 (PDT)
Received: from [192.168.0.5] (ip-109-43-176-141.web.vodafone.de.
 [109.43.176.141]) by smtp.gmail.com with ESMTPSA id
 co2-20020a0564020c0200b0053ed70ebd7csm5743366edb.31.2023.10.22.22.56.57
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 22 Oct 2023 22:56:58 -0700 (PDT)
Message-ID: <6401be8b-55ac-4967-bb6e-4af15d6ea109@redhat.com>
Date: Mon, 23 Oct 2023 07:56:56 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] MAINTAINERS: Add unvalued folders in tests/tcg/ to the
 right sections
To: Michael Tokarev <mjt@tls.msk.ru>, qemu-devel@nongnu.org
Cc: qemu-trivial@nongnu.org, =?UTF-8?Q?C=C3=A9dric_Le_Goater?=
 <clg@kaod.org>, qemu-ppc@nongnu.org
References: <20231018062401.20746-1-thuth@redhat.com>
 <78323369-f211-4281-b365-7de1fc5788f8@tls.msk.ru>
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
In-Reply-To: <78323369-f211-4281-b365-7de1fc5788f8@tls.msk.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 21/10/2023 13.31, Michael Tokarev wrote:
> [Trim recipient list]
> 
> 18.10.2023 09:24, Thomas Huth:
>> Some subfolders in tests/tcg/ are already listed in the MAINTAINERS
>> file, some others aren't listed yet. Add the missing ones now to the
>> MAINTAINERS file, too, to make sure that get_maintainers.pl reports
>> the correct maintainer.
> 
>> diff --git a/MAINTAINERS b/MAINTAINERS
>> index b3599746c4..b80124f60f 100644
>> --- a/MAINTAINERS
>> +++ b/MAINTAINERS
>> @@ -327,6 +329,7 @@ F: hw/ppc/trace*
>>   F: configs/devices/ppc*
>>   F: docs/system/ppc/embedded.rst
>>   F: docs/system/target-ppc.rst
>> +F: tests/tcg/ppc*/*
> 
> FWIW, this hunk needs earlier series "MAINTAINERS: Collect unmaintained files
> under PPC entries", in particular "MAINTAINERS: Add PPC common files to PowerPC
> TCG CPUs", which is still not in master.  Maybe it's better to fold this change
> to the PPC series.

Ah, right, sorry, I should have used a "Based-on" tag or something like that.
Anyway, fine for me if this gets squashed into Cédric's patch!

  Thomas



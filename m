Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C427D85A28B
	for <lists+qemu-devel@lfdr.de>; Mon, 19 Feb 2024 12:54:33 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rc2Dm-0008JS-KU; Mon, 19 Feb 2024 06:54:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1rc2Dk-0008Hi-Tn
 for qemu-devel@nongnu.org; Mon, 19 Feb 2024 06:54:04 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1rc2Di-0004Ld-Sx
 for qemu-devel@nongnu.org; Mon, 19 Feb 2024 06:54:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1708343642;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=nJTlbNZGSu0rMY5oSLoI1s4ihtcUUXubZG3uqw8d3xs=;
 b=XqLCdw0vyqcNxWXP7Cn09zdVUwBMymbpBorbaUom//Lz+PJJewVvy6hCTXWFx1RXacu0F0
 pVCaWpZQZpF03LBSD1YHcpHqfXcMpm+Aw8XmkSHLyR9O8W7Ii7eut8+LezyykHgRBVF83a
 lb8K+6oMMTfFi2cyIvzJnp+6EAWojY8=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-612-LSm9ZlfkOqygJ-fLjwgH4g-1; Mon, 19 Feb 2024 06:54:00 -0500
X-MC-Unique: LSm9ZlfkOqygJ-fLjwgH4g-1
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-787303d8e32so636794985a.1
 for <qemu-devel@nongnu.org>; Mon, 19 Feb 2024 03:54:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708343640; x=1708948440;
 h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=nJTlbNZGSu0rMY5oSLoI1s4ihtcUUXubZG3uqw8d3xs=;
 b=CatNFykL+76+UMsDrdiwuw174QRAZSJ62THbNInphX3EUOuSDCsKs3ziNu3S/Eg8Yo
 z64zzJANxO3ozUXONlG++kHHnvZ8JVV/03gbUM0Z3pJnJIfJeInO4sLI/3D1KcxaBphA
 Rbqsor3eQhdapIBfoFB0bpBtmQWK8YGAzbN7VhJO7PMSyekySP0Pfc1w57irq3HcWkt3
 NR6Lu9K/fyo1EuQV3YZt4KqXQYnY6pGVycY1k7rrxiCVS5B3E2L2EhdhIwp6teA2utbS
 6sFJY1EiOApRqW6pgpkibNxq9ymAEKSh18yrTaoysaKvPUp/x+qcWYgpiQGOFRtQaXZV
 onXw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXQM5+FHjPOOjC2Kw3cgc4qcjGQcZlRAhIz58fBRk0AkUUF8UGYOUkH4mzwfCVNSeN7vhYD/mkM309Y/f8xaLkANafCYZU=
X-Gm-Message-State: AOJu0Yxo0rzPhxqYhn4AKXXS5II8fRSSM+sXWaMRYPPoV0OWlb2kWDkZ
 4cVOXbOyqzn4UfJ4hk82E6gdp83TLLdUdbW21WKnTi+zxeIyCK77YMMoa+HTjOLpNQXfWz2y8ry
 TKdTrcZS0kiulsJXUV4LsYF7gZBQu1BvRr/LFGCvC2n6Nh3aMokJy
X-Received: by 2002:ae9:e608:0:b0:787:1625:3312 with SMTP id
 z8-20020ae9e608000000b0078716253312mr13904864qkf.44.1708343640238; 
 Mon, 19 Feb 2024 03:54:00 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHU5E6wn6Sboe6ZBdKNF5yeF6m1RrimM58eBFjZljtzjtUwVIF6o4WllSY/qMHRCRZtxEBGhw==
X-Received: by 2002:ae9:e608:0:b0:787:1625:3312 with SMTP id
 z8-20020ae9e608000000b0078716253312mr13904850qkf.44.1708343639934; 
 Mon, 19 Feb 2024 03:53:59 -0800 (PST)
Received: from [192.168.0.9] (ip-109-43-177-48.web.vodafone.de.
 [109.43.177.48]) by smtp.gmail.com with ESMTPSA id
 d26-20020a05620a159a00b007871de8ec59sm2376830qkk.129.2024.02.19.03.53.57
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 19 Feb 2024 03:53:59 -0800 (PST)
Message-ID: <13862227-d782-46fe-b10f-94587c74745e@redhat.com>
Date: Mon, 19 Feb 2024 12:53:55 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/3] tests/migration-test: Stick with gicv3 in aarch64
 test
Content-Language: en-US
To: peterx@redhat.com, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Sebastian Ott <sebott@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, Eric Auger
 <eric.auger@redhat.com>, qemu-arm <qemu-arm@nongnu.org>
References: <20240207005403.242235-1-peterx@redhat.com>
 <20240207005403.242235-2-peterx@redhat.com>
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
In-Reply-To: <20240207005403.242235-2-peterx@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.077,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On 07/02/2024 01.54, peterx@redhat.com wrote:
> From: Peter Xu <peterx@redhat.com>
> 
> Recently we introduced cross-binary migration test.  It's always wanted
> that migration-test uses stable guest ABI for both QEMU binaries in this
> case, so that both QEMU binaries will be compatible on the migration
> stream with the cmdline specified.
> 
> Switch to a static gic version "3" rather than using version "max", so that
> GIC should be stable now across any future QEMU binaries for migration-test.
> 
> Here the version can actually be anything as long as the ABI is stable.  We
> choose "3" because it's the majority of what we already use in QEMU while
> still new enough: "git grep gic-version=3" shows 6 hit, while version 4 has
> no direct user yet besides "max".
> 
> Note that even with this change, aarch64 won't be able to work yet with
> migration cross binary test, but then the only missing piece will be the
> stable CPU model.
> 
> Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
>   tests/qtest/migration-test.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tests/qtest/migration-test.c b/tests/qtest/migration-test.c
> index 7675519cfa..8a5bb1752e 100644
> --- a/tests/qtest/migration-test.c
> +++ b/tests/qtest/migration-test.c
> @@ -819,7 +819,7 @@ static int test_migrate_start(QTestState **from, QTestState **to,
>       } else if (strcmp(arch, "aarch64") == 0) {
>           memory_size = "150M";
>           machine_alias = "virt";
> -        machine_opts = "gic-version=max";
> +        machine_opts = "gic-version=3";
>           arch_opts = g_strdup_printf("-cpu max -kernel %s", bootpath);
>           start_address = ARM_TEST_MEM_START;
>           end_address = ARM_TEST_MEM_END;

Looks like the migration test now fails on aarch64 when "configure" has been 
run with "--without-default-devices", since that disables the gicv3 in the 
binary ... is there a way to check whether the gicv3 is available, and use 
"=max" instead if it is not?

  Thomas



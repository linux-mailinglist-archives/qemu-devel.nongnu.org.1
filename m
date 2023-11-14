Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DA1E97EB6BA
	for <lists+qemu-devel@lfdr.de>; Tue, 14 Nov 2023 20:07:12 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r2ykM-0004E8-Rd; Tue, 14 Nov 2023 14:06:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1r2yk7-00044g-Pu
 for qemu-devel@nongnu.org; Tue, 14 Nov 2023 14:06:39 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1r2yk6-0003YQ-ED
 for qemu-devel@nongnu.org; Tue, 14 Nov 2023 14:06:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1699988793;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=odwvCCpP8x9B6FvGge1QmxE5Q/XZUA+46yQJ21H7LTc=;
 b=c26NqgVVYfWizkHobz107LEU0ducriHGwabmXT41R8CzqhguJXgTWLn5I0V/SGDkhekgfa
 XYXn8/NL8qzs76G+x/IrUq8Y3J9lKDUO+X6J5bYHZCsCzUzMeX38H0RqiQBYVf3o68S9Lg
 dyVvbqzRFAHlpl4B0XjvkZzCtuRfkQc=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-126-pGTcKZNRO12uASyaNWB82w-1; Tue, 14 Nov 2023 14:06:32 -0500
X-MC-Unique: pGTcKZNRO12uASyaNWB82w-1
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-778b25af933so728714785a.3
 for <qemu-devel@nongnu.org>; Tue, 14 Nov 2023 11:06:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699988791; x=1700593591;
 h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=odwvCCpP8x9B6FvGge1QmxE5Q/XZUA+46yQJ21H7LTc=;
 b=RvKuOZW/ikQ1y6un9NrwL7IaNbwBpdQyYJfFkpmxVpYyLTwFmtT4S02+LURCt2VLQu
 ljhsIzvx2Bikduil3qRMOSf/Y5isbwBEZqM1Dknrs5zI2mMZHB2p/Q62wPpkCzOB6tlu
 GdHbV+Ve+nDdpiPm+y7rs75ponStgJeTg4mL1K96lLsKCKh5ylMLE4C1xAiDNdutqalS
 9T4hJYiwdQ6KaLehLCAJadVu1KwNLASvoJenWo0Yh6jrzXmJ24WVPGL1demNiqBWfGun
 zDNu5Abaw5TUP5IMYvCxvWIDe3Y8GM+WaNtemelvWh9ZcIQDsjLyyXvcf8wPNwMd/5HB
 14ng==
X-Gm-Message-State: AOJu0YxT2h9RqVNa9wC6V0OJXOglGBtE4RDz5LH065QMKjXWXnHdJMY5
 w38Gjm1Vd39qglWivbgS4rKnGoS4u6DW7AQ8n23KgdDifVvS9VE8+hEqIEkqA8itTs1uKVR4Hez
 9mmHVCwql2aoCcoU=
X-Received: by 2002:a05:622a:1891:b0:41e:23e6:baaf with SMTP id
 v17-20020a05622a189100b0041e23e6baafmr3548401qtc.68.1699988791478; 
 Tue, 14 Nov 2023 11:06:31 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE/XAl2Ft+i/L7pl9S8s0J8hmk5xiwpg/bg9zTYrxf1cyEmihsiY6CQ6O5k7mEnozKT0X3WvA==
X-Received: by 2002:a05:622a:1891:b0:41e:23e6:baaf with SMTP id
 v17-20020a05622a189100b0041e23e6baafmr3548387qtc.68.1699988791205; 
 Tue, 14 Nov 2023 11:06:31 -0800 (PST)
Received: from [192.168.0.6] (ip-109-43-176-122.web.vodafone.de.
 [109.43.176.122]) by smtp.gmail.com with ESMTPSA id
 s23-20020ac85297000000b00419c39dd28fsm2918316qtn.20.2023.11.14.11.06.29
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 14 Nov 2023 11:06:30 -0800 (PST)
Message-ID: <2fbb05d2-dae5-47be-903f-3c0172b5c3df@redhat.com>
Date: Tue, 14 Nov 2023 20:06:29 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH trivial 07/21] docs/system/arm/emulation.rst: spelling
 fix: Enhacements
Content-Language: en-US
To: Michael Tokarev <mjt@tls.msk.ru>, qemu-devel@nongnu.org
Cc: qemu-trivial@nongnu.org, Aaron Lindsay <aaron@os.amperecomputing.com>
References: <20231114165834.2949011-1-mjt@tls.msk.ru>
 <20231114165834.2949011-8-mjt@tls.msk.ru>
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
In-Reply-To: <20231114165834.2949011-8-mjt@tls.msk.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -5
X-Spam_score: -0.6
X-Spam_bar: /
X-Spam_report: (-0.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SORBS_WEB=1.5, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

On 14/11/2023 17.58, Michael Tokarev wrote:
> Fixes: c7c807f6dd6d "target/arm: Implement FEAT_Pauth2"
> Cc: Aaron Lindsay <aaron@os.amperecomputing.com>
> Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>
> ---
>   docs/system/arm/emulation.rst | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/docs/system/arm/emulation.rst b/docs/system/arm/emulation.rst
> index 47fd648035..0b604f9005 100644
> --- a/docs/system/arm/emulation.rst
> +++ b/docs/system/arm/emulation.rst
> @@ -70,7 +70,7 @@ the following architecture extensions:
>   - FEAT_PAN2 (AT S1E1R and AT S1E1W instruction variants affected by PSTATE.PAN)
>   - FEAT_PAN3 (Support for SCTLR_ELx.EPAN)
>   - FEAT_PAuth (Pointer authentication)
> -- FEAT_PAuth2 (Enhacements to pointer authentication)
> +- FEAT_PAuth2 (Enhancements to pointer authentication)
>   - FEAT_PMULL (PMULL, PMULL2 instructions)
>   - FEAT_PMUv3p1 (PMU Extensions v3.1)
>   - FEAT_PMUv3p4 (PMU Extensions v3.4)

Reviewed-by: Thomas Huth <thuth@redhat.com>



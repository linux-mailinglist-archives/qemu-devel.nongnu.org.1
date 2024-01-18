Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F60183194E
	for <lists+qemu-devel@lfdr.de>; Thu, 18 Jan 2024 13:42:00 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rQRQk-0002gC-Ao; Thu, 18 Jan 2024 07:23:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1rQRQf-0002e1-1W
 for qemu-devel@nongnu.org; Thu, 18 Jan 2024 07:23:29 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1rQRQd-0003uv-D3
 for qemu-devel@nongnu.org; Thu, 18 Jan 2024 07:23:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1705580605;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=bNhDD32Ou8ubt9BIMvCCD5ZiMfRsSkE3+t2CI3B24yA=;
 b=LLLvtkbPrI1HV78op/OX1QdGIiT/ljkWfDbPW4j0GvJTgu+nQm2EQuIVMAWyJ+3VKw7qj9
 FVO5Z3u3pIYxGZGEBlg/ZH9MImmcdYhPc3l28sSQN1DVV7de6jcvPqP3g9+FWVJZK3O9Ia
 +qHvjrENVHzf8ZyFSVCQqmPWDE/DNJo=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-56-mUTTe_77PZ2wVr220eGs8A-1; Thu, 18 Jan 2024 07:23:22 -0500
X-MC-Unique: mUTTe_77PZ2wVr220eGs8A-1
Received: by mail-qt1-f197.google.com with SMTP id
 d75a77b69052e-42a133aac52so21228851cf.0
 for <qemu-devel@nongnu.org>; Thu, 18 Jan 2024 04:23:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705580601; x=1706185401;
 h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=bNhDD32Ou8ubt9BIMvCCD5ZiMfRsSkE3+t2CI3B24yA=;
 b=NJxRsUMs4U9Qy3umZoO5iNwD7jr5Bn5VvdeNx6kRPNRyhW4+tMph0+K3Hd/Y3oFCjL
 LvCVjV4yY371pUQwCcYfzfMUEXm99fJviPCEJ3FtZB+4/00C2evlBUHAQzt/HB+c7cPk
 gJ2y5sGKaz6TRRsPyoy8FrkR2L4latoKNkF7I/r2kep+JPY1MobxlHLoBC98Jwrexwlw
 y3QLz5cEdN6FBZinY3qe7tutIa5tKc/d1hQRXDWKUjpJprjyrfU/LGc7IKibssGdJRQa
 DY65t5DszrWI85TvrmfUVzyj2Kpaq4g5PdNvvI0g4zwl+w6cBipDuZnJJrlpeUFJlERk
 XT8g==
X-Gm-Message-State: AOJu0YyaP+UafegHwTAn2A+ypwzjOZlGXWVpmcT33oOgf1030fqgCqrm
 sgKiD/Pax/+I+9LbMVB673CWhDp0XPjl28wLjAv3zTQZUXqTWxLuN0eXUkItNZDfJsnD/SykUNG
 K78w0tuhZNBKs53ew5bFGpMsc+N2XD/63ZRm/JXi9lQv14dulm90y
X-Received: by 2002:a05:622a:199e:b0:429:7615:4fde with SMTP id
 u30-20020a05622a199e00b0042976154fdemr850346qtc.49.1705580601544; 
 Thu, 18 Jan 2024 04:23:21 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEGrXFtTH44kqNBupR7DR0IFp80r/h3R6fHoP0Ywg8jQDmQDBlhXkk1OO2iqQuWDXrzHQ8cEQ==
X-Received: by 2002:a05:622a:199e:b0:429:7615:4fde with SMTP id
 u30-20020a05622a199e00b0042976154fdemr850340qtc.49.1705580601347; 
 Thu, 18 Jan 2024 04:23:21 -0800 (PST)
Received: from [192.168.0.9] (ip-109-43-179-227.web.vodafone.de.
 [109.43.179.227]) by smtp.gmail.com with ESMTPSA id
 6-20020a05620a04c600b0078324eaba06sm5236624qks.27.2024.01.18.04.23.18
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 18 Jan 2024 04:23:21 -0800 (PST)
Message-ID: <308620a4-6d61-46ac-924d-54e3a629545e@redhat.com>
Date: Thu, 18 Jan 2024 13:23:15 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 7/7] Add tests for the STM32L4x5_RCC
Content-Language: en-US
To: Arnaud Minier <arnaud.minier@telecom-paris.fr>, qemu-devel@nongnu.org
Cc: Laurent Vivier <lvivier@redhat.com>, qemu-arm@nongnu.org,
 =?UTF-8?Q?In=C3=A8s_Varhol?= <ines.varhol@telecom-paris.fr>,
 alistair@alistair23.me, samuel.tardieu@telecom-paris.fr,
 Peter Maydell <peter.maydell@linaro.org>, philmd@linaro.org,
 Paolo Bonzini <pbonzini@redhat.com>
References: <20240118091419.89103-1-arnaud.minier@telecom-paris.fr>
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
In-Reply-To: <20240118091419.89103-1-arnaud.minier@telecom-paris.fr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -38
X-Spam_score: -3.9
X-Spam_bar: ---
X-Spam_report: (-3.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.806,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On 18/01/2024 10.14, Arnaud Minier wrote:

Maybe add a short patch description about what exactly is being tested here?

> Signed-off-by: Arnaud Minier <arnaud.minier@telecom-paris.fr>
> Signed-off-by: Inès Varhol <ines.varhol@telecom-paris.fr>
> ---
>   tests/qtest/meson.build          |   3 +-
>   tests/qtest/stm32l4x5_rcc-test.c | 210 +++++++++++++++++++++++++++++++
...
> +static bool qts_wait_for_flag(QTestState *qts, uint32_t event_addr,
> +                              uint32_t flag, uint32_t value)
> +{
> +    time_t now, start = time(NULL);
> +
> +    while (true) {
> +        if ((qtest_readl(qts, event_addr) & flag) == value) {
> +            return true;
> +        }
> +
> +        /* Wait at most 5 seconds */
> +        now = time(NULL);
> +        if (now - start > 5) {

In the past, we've seen timeouts on constructs like this when tests are 
running on very very loaded CI machines - it often happens that a process 
there is stopped for a couple of seconds 'til it continues running.
I'd suggest to either use a higher value here (maybe 10 instead of 5), or 
preferably ...

> +            break;
> +        }
> +        g_usleep(1000);

... since you're sleeping here anyway, I think you could simply drop the 
time() stuff completely and change the while(true) loop into something that 
counts a certain amount of iterations (5000 in this case to match the 5s 
timeout from above).

  Thomas


> +    }
> +
> +    return false;
> +}
...



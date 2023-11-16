Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E022A7EE634
	for <lists+qemu-devel@lfdr.de>; Thu, 16 Nov 2023 18:55:25 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r3gZj-0007YQ-Qf; Thu, 16 Nov 2023 12:54:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1r3gZi-0007YF-JF
 for qemu-devel@nongnu.org; Thu, 16 Nov 2023 12:54:46 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1r3gZX-0004b6-OS
 for qemu-devel@nongnu.org; Thu, 16 Nov 2023 12:54:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1700157274;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=j6QyxV7Df4go2vIZrDZbOuQ0cdCrMsqVDzyLAyVvZuQ=;
 b=AvYXwqsfoa2XVYSa4rBGgRYQrTBDOCCHw4+iveE1aKzEnnf3cbXvF+R1gPekJbjeKMt/pN
 w1R4GuKq9EiDNY5Cim5RidxKKMbxGH0l6mlNWMyR1XE901kqsHCCIJ7XYZz52va5zuSZ72
 pjxKeUG40vzR8bp0cpU590k0Zy0H/X8=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-33-oMFyXMd3PHeffUaUJ5aNeA-1; Thu, 16 Nov 2023 12:54:33 -0500
X-MC-Unique: oMFyXMd3PHeffUaUJ5aNeA-1
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-32fd8da34fbso506857f8f.1
 for <qemu-devel@nongnu.org>; Thu, 16 Nov 2023 09:54:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700157272; x=1700762072;
 h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=j6QyxV7Df4go2vIZrDZbOuQ0cdCrMsqVDzyLAyVvZuQ=;
 b=i/TVPkweZvL+uYwqPYl0qi2EcgreParzQ48UUTh3J18ManO5vQDWRp1QAil2PJMS+7
 v/p7ZUvRujIUYc8E9zpT155rMYcP2oWHjEl9vXWQ+unR27a45b07/qt+qrbTGDHkDs4n
 x9H7hSYy8YSSIHBCFg2saDbn3aLKmkTwtKinNBKGp6eQ0PD+FWLM06SVGsRL9euxEwaE
 iye3BEntptjHYI/RMTSY+t9yQsfSOoLFT1PtDT6f2nfmwC9voBsbxg4UHFV1tgDHtUps
 mgyJeuRirOTQaXN8kIJonNM2GCpmJHjuGoVCZP+UIO9FZgUHwLS2995Vjgo6J8m+CZnu
 g6Ug==
X-Gm-Message-State: AOJu0YxI8mM9anfRNJXBojHFhZQaZvV8AkkTqd1VyCJCaa7BnXEGw5Tp
 LbG62U5l+Tzh3VZyUuA4jZfjIe46TKCVdN9L8n0aIJ2UUUgu+NJFi8pVl73h7jJvuypz4navC/i
 77zJo1rHvnXJb3+0=
X-Received: by 2002:a05:6000:1548:b0:32d:9a7c:56ed with SMTP id
 8-20020a056000154800b0032d9a7c56edmr14595250wry.10.1700157272440; 
 Thu, 16 Nov 2023 09:54:32 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEMZFYHGzRRHftjF+3VYzPgnlh8Ln4aY3+xzZ/SgXsr+YZF/6vSmLktLS8Etba4pleUr9/ZBQ==
X-Received: by 2002:a05:6000:1548:b0:32d:9a7c:56ed with SMTP id
 8-20020a056000154800b0032d9a7c56edmr14595237wry.10.1700157272102; 
 Thu, 16 Nov 2023 09:54:32 -0800 (PST)
Received: from [192.168.0.6] (ip-109-43-176-122.web.vodafone.de.
 [109.43.176.122]) by smtp.gmail.com with ESMTPSA id
 t4-20020a5d4604000000b0032fbd0c7d04sm28906wrq.55.2023.11.16.09.54.30
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 16 Nov 2023 09:54:31 -0800 (PST)
Message-ID: <ee008c55-89a9-4422-9ea0-cab60a8961af@redhat.com>
Date: Thu, 16 Nov 2023 18:54:29 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 5/5] qom/object: Limit type names to alphanumerical and
 some few special characters
Content-Language: en-US
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>,
 Alistair Francis <alistair@alistair23.me>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>, Paolo Bonzini
 <pbonzini@redhat.com>, Peter Xu <peterx@redhat.com>,
 David Hildenbrand <david@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Francisco Iglesias <francisco.iglesias@amd.com>,
 Eduardo Habkost <eduardo@habkost.net>
References: <20231116131454.541434-1-thuth@redhat.com>
 <20231116131454.541434-6-thuth@redhat.com> <ZVYX8mcanVBl9-ho@redhat.com>
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
In-Reply-To: <ZVYX8mcanVBl9-ho@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.117,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On 16/11/2023 14.24, Daniel P. Berrangé wrote:
> On Thu, Nov 16, 2023 at 02:14:54PM +0100, Thomas Huth wrote:
>> QOM names currently don't have any enforced naming rules. This
>> can be problematic, e.g. when they are used on the command line
>> for the "-device" option (where the comma is used to separate
>> properties). To avoid that such problematic type names come in
>> again, let's restrict the set of acceptable characters during the
>> type registration.
>>
>> Ideally, we'd apply here the same rules as for QAPI, i.e. all type
>> names should begin with a letter, and contain only ASCII letters,
>> digits, hyphen, and underscore. However, we already have so many
>> pre-existing types like:
>>
>>      486-x86_64-cpu
>>      cfi.pflash01
>>      power5+_v2.1-spapr-cpu-core
>>      virt-2.6-machine
>>      pc-i440fx-3.0-machine
>>
>> ... so that we have to allow "." and "+" for now, too. While the
>> dot is used in a lot of places, the "+" can fortunately be limited
>> to two classes of legacy names ("power" and "Sun-UltraSparc" CPUs).
>>
>> We also cannot enforce the rule that names must start with a letter
>> yet, since there are lot of types that start with a digit. Still,
>> at least limiting the first characters to the alphanumerical range
>> should be way better than nothing.
>>
>> Signed-off-by: Thomas Huth <thuth@redhat.com>
>> ---
>>   qom/object.c | 41 +++++++++++++++++++++++++++++++++++++++++
>>   1 file changed, 41 insertions(+)
>>
>> diff --git a/qom/object.c b/qom/object.c
>> index 95c0dc8285..571ef68950 100644
>> --- a/qom/object.c
>> +++ b/qom/object.c
>> @@ -138,9 +138,50 @@ static TypeImpl *type_new(const TypeInfo *info)
>>       return ti;
>>   }
>>   
>> +static bool type_name_is_valid(const char *name)
>> +{
>> +    const int slen = strlen(name);
>> +
>> +    g_assert(slen > 1);
>> +
>> +    /*
>> +     * Ideally, the name should start with a letter - however, we've got
>> +     * too many names starting with a digit already, so allow digits here,
>> +     * too (except '0' which is not used yet)
>> +     */
>> +    if (!g_ascii_isalnum(name[0]) || name[0] == '0') {
>> +        return false;
>> +    }
>> +
>> +    for (int i = 1; i < slen; i++) {
>> +        if (name[i] != '-' && name[i] != '_' && name[i] != '.' &&
>> +            !g_ascii_isalnum(name[i])) {
>> +            if (name[i] == '+') {
>> +                if (i == 6 && !strncmp(name, "power", 5)) {
>> +                    /* It's a legacy name like "power5+" */
>> +                    continue;
>> +                }
>> +                if (i >= 17 && !strncmp(name, "Sun-UltraSparc", 14)) {
>> +                    /* It's a legacy name like "Sun-UltraSparc-IV+" */
>> +                    continue;
>> +                }
>> +            }
>> +            return false;
>> +        }
>> +    }
> 
> Replace this big loop with strspn, which has an asm optimized impl
> in glibc
> 
>        ALPHA_LC "abcdefghijklmnopqrstuvwxyz"
>        ALPHA_UC "ABCDEFGHIJKLMNOPQRSTUVWXYZ"
>        OTHER "0123456789-_."
> 
>        return (strspn(name, ALPHA_UC ALPHA_LC OTHER) == slen) ||
>            (g_str_has_prefix(name, "power") && slen > 6 && name[6] == '+') ||
> 	  (g_str_has_prefix(name, "Sun-UltraSparc") && slen > 17 && name[17] == '+');

It's quite hard to believe that a function that has to check each and every 
character in a string of acceptable characters is faster than a function 
that uses something like g_ascii_asalnum which can check range of characters 
in one go...

So I gave it a try, wrote two test programs, one with my implementation and 
one with yours, and looped on the function 1000000000 times. And indeed, for 
short strings (less than 30 characters), my function is about three times 
faster than the one with strspn() (mine takes ~ 13 seconds, the strspn() one 
takes ~ 39 seconds).

Interestingly, for larger strings (more than 140 characters), the strspn() 
impementation starts to perform better. They indeed must have an 
optimization that kicks in for larger strings.

Now while my implementation seems to be a little bit faster for the strings 
that we are using in QEMU, we certainly don't have 1000000000 different 
types in QEMU, but rather only 1300 or so, so the performance shouldn't 
really matter that much here. And I have to admit that your code is indeed 
more compact to read, so I'll give it a try.

  Thomas




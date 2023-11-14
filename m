Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B59387EAD7B
	for <lists+qemu-devel@lfdr.de>; Tue, 14 Nov 2023 10:56:28 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r2q9X-0002lN-JN; Tue, 14 Nov 2023 04:56:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1r2q9V-0002lB-2W
 for qemu-devel@nongnu.org; Tue, 14 Nov 2023 04:56:13 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1r2q9T-0002cu-5E
 for qemu-devel@nongnu.org; Tue, 14 Nov 2023 04:56:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1699955770;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=OLVSFiti7HgS0ceiNVJPgiMOlhZj5VUokwcxfoV34Ks=;
 b=c2W7fRTBvZGqadey7t3bERRGQGuIUzqSz0wLVF/Dg8QUURrxpTbDK92VGY8jdNJjw8Utet
 ozLug/IWWd9hhW2TgdAZdpciYHjxmgnMTTz6dDHscfXincI1ITvfZ9Yzl6YsciE91wtbZ4
 v0lcvREvr56f9Gc445w6Sb8pIsKTjMk=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-119-z7-_WfTGOS2r8NN0Vj15AQ-1; Tue, 14 Nov 2023 04:56:09 -0500
X-MC-Unique: z7-_WfTGOS2r8NN0Vj15AQ-1
Received: by mail-qv1-f72.google.com with SMTP id
 6a1803df08f44-67049a2c8b3so69097866d6.0
 for <qemu-devel@nongnu.org>; Tue, 14 Nov 2023 01:56:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699955768; x=1700560568;
 h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=OLVSFiti7HgS0ceiNVJPgiMOlhZj5VUokwcxfoV34Ks=;
 b=rtW9VcvD+BIdh6GcY4RzlB3vJI2KCja7ZcPxuFlJldBDzbSsTvYcbyKIUZxOGo6FKF
 APCdSk9VA7yj2qT9D92D9NFY44dnclOfxceiOPrAkCeWxof1IAsBDLMhQ95wopOx754k
 Vwa6DGO3hdzKu6KeFVhdSgL9FWK6YsSQIyK2ztwLfvPTpEF8ZBL2GzYmCY50xBAPevkU
 CoWmqeI7mZxWslLM1VTYIp28JlMsy2kvqCAAcE20UbrDavXoIRR2z+DNV37laj8oe/wS
 C6MQo4qbqqQtJ6aG3TcDqY4ddbLIJbOVIkRD+Hx9mCVkybBaE2sHanofxzgRCIjvXOhD
 GJdA==
X-Gm-Message-State: AOJu0YxpsNr4yBYXbi5BPSvofZ8Jn1l7QCpyQZE6LM+rAeovwuHR0RY1
 M+QFcx42SPxzil7VWZp3QKXvXHmMvYmOCmG09xjJtrvp/AYOcB2LiYP1Pdwvlxwq0/x+VZzLIyT
 0LUmj86xPlYYuYw8=
X-Received: by 2002:a05:6214:1389:b0:677:8fb2:a635 with SMTP id
 pp9-20020a056214138900b006778fb2a635mr1963239qvb.38.1699955768661; 
 Tue, 14 Nov 2023 01:56:08 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFY2uC+fJ0Uzzf1UW/6LBTyGefPh3j/TUhGGjRo4RC8ZQs+dGpsqTZSjlLxKtBsu98DkMmNNw==
X-Received: by 2002:a05:6214:1389:b0:677:8fb2:a635 with SMTP id
 pp9-20020a056214138900b006778fb2a635mr1963224qvb.38.1699955768305; 
 Tue, 14 Nov 2023 01:56:08 -0800 (PST)
Received: from [192.168.0.6] (ip-109-43-176-122.web.vodafone.de.
 [109.43.176.122]) by smtp.gmail.com with ESMTPSA id
 p4-20020ad451c4000000b0065d105f6931sm2805433qvq.59.2023.11.14.01.56.06
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 14 Nov 2023 01:56:08 -0800 (PST)
Message-ID: <c023a3a5-4435-4381-860f-edb5da227c76@redhat.com>
Date: Tue, 14 Nov 2023 10:56:05 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH] qom/object: Disallow comma in type names
Content-Language: en-US
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Markus Armbruster
 <armbru@redhat.com>, Eduardo Habkost <eduardo@habkost.net>
References: <20231114090537.154151-1-thuth@redhat.com>
 <ZVM+hvRk5KYn5WYh@redhat.com>
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
In-Reply-To: <ZVM+hvRk5KYn5WYh@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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


Forgot to CC: qemu-devel (sorry) - thanks to Markus for the hint.
So let's repeat it here:

On 14/11/2023 10.31, Daniel P. Berrangé wrote:
> On Tue, Nov 14, 2023 at 10:05:37AM +0100, Thomas Huth wrote:
>> QOM names currently don't have any enforced naming rules. This can
>> be problematic, e.g. when they are used on the command line for
>> the "-device" option (where the comma is used to separate properties).
>> To avoid that such problematic type names come in again, let's
>> disallow them now by adding an g_assert() during the type registration.
>>
>> Signed-off-by: Thomas Huth <thuth@redhat.com>
>> ---
>>   Based-on: <20231113134344.1195478-1-armbru@redhat.com>
>>   (without Markus' patches, the g_assert() triggers with the current
>>    code base)
>>   
>>   See discussion here:
>>   https://lore.kernel.org/qemu-devel/87y1f0hjdh.fsf@pond.sub.org/
>>
>>   Questions: Should we disallow other characters, too? Slash and
>>   backslash maybe (since they can cause trouble with module names)?
>>   Dot and colon would maybe be good candidates, too, but they seem
>>   to be in wide use already, so these don't really seem to be
>>   feasible...
> 
> There's two questions.
> 
>    * What should we enforce today
>    * What should we ideally enforce in future
> 
> Ideally the answers would be the same, but getting there will
> almost certainly require some cleanup first.
> 
> Given that we can now define QOM types using QAPI, I feel we
> preserve everyone's sanity by enforcing the same rules for
> QOM and QAPI type naming. IOW
> 
>    All QOM type names must begin with a letter, and contain
>    only ASCII letters, digits, hyphen, and underscore.
> 
> is the answer for the second question.
> 
> In terms of what we can enforce today, we can block ',',
> but we can't block '.' without some cleanup, and possibly
> the same for ':'. Can we assume we don't have any other
> non-alphanumeric chars used ?
> 
> If so, I think that today we we could probably get away with
> saying:
> 
>    All QOM type names must begin with a letter, and contain
>    only ASCII letters, digits, hyphen, underscore, period
>    and colon. Usage of period and colon is deprecated.
> 
>>   qom/object.c | 2 ++
>>   1 file changed, 2 insertions(+)
>>
>> diff --git a/qom/object.c b/qom/object.c
>> index 95c0dc8285..85461ab0d2 100644
>> --- a/qom/object.c
>> +++ b/qom/object.c
>> @@ -113,6 +113,8 @@ static TypeImpl *type_new(const TypeInfo *info)
>>           abort();
>>       }
>>   
>> +    g_assert(!strchr(info->name, ','));
> 
> 
> So with helpers:
> 
>    #define QOM_VALID_TYPECHARS "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLNMOPQRSTUVWXYZ0123456789-_.:"
> 
>    static bool qom_valid_typename(const char *name) {
>       return name[0] != '\0' &&
>          g_ascii_isalpha(name[0]) &&
>          strspn(name, QOM_VALID_TYPECHARS) == strlen(name));
>    }
> 
> The check would then become
> 
>       g_assert(qom_valid_typename(info->name));
> 
>       if (strstr(info->name, '.') ||
>           strstr(info->name, ':')) {
>          warn_report("Usage of '.' and ':', in type name %s is deprecated", info->name)
>       }
> 
> 
> The warn_report could be a bit annoying if we the unusual type names are
> something we're going to hit frequently ?
> 
> With regards,
> Daniel

I've added a debug printf, and seems like we register a lot of types like:

  cfi.pflash01
  virt-2.6-machine::hotplug-handler
  aspeed.i2c.slave::vmstate-if
  pc-i440fx-3.0-machine::nmi

... just to name some few. So I don't think it is feasible to use the 
warn_report here.

  Thomas



Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E799B7D6D72
	for <lists+qemu-devel@lfdr.de>; Wed, 25 Oct 2023 15:40:11 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qve5t-0002qW-77; Wed, 25 Oct 2023 09:38:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qve5o-0002mn-Jg
 for qemu-devel@nongnu.org; Wed, 25 Oct 2023 09:38:40 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qve5l-0000ef-Ro
 for qemu-devel@nongnu.org; Wed, 25 Oct 2023 09:38:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1698241116;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=ncZI0WEgzk1jNal+b7ZIMwkCI8K890H4TnMBmwtu+q4=;
 b=bi2pYYe5OmqHVr0YDIJjtqHDg+ERbkcaGBjCzy6BUFiTX/RwzZk7SpSMXIeyEXen55gEv2
 pjmEsY+c2iQxQp60vDlRTt4QS1M5viBOXAhnRL8RUbw+T5p+9f+eibF8U4DZ+xf7Np8D64
 LzurHSu/J9A4r3Ul10LtvmyaTzB0cjw=
Received: from mail-vk1-f199.google.com (mail-vk1-f199.google.com
 [209.85.221.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-211-ARs-XfdEO_CCcjA5o97DHg-1; Wed, 25 Oct 2023 09:38:35 -0400
X-MC-Unique: ARs-XfdEO_CCcjA5o97DHg-1
Received: by mail-vk1-f199.google.com with SMTP id
 71dfb90a1353d-49dcd41cefdso2985335e0c.1
 for <qemu-devel@nongnu.org>; Wed, 25 Oct 2023 06:38:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698241114; x=1698845914;
 h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ncZI0WEgzk1jNal+b7ZIMwkCI8K890H4TnMBmwtu+q4=;
 b=fCnosqWJGZqbs4AyFyC5Ya+OPmvKS1AdasOJpUyiDUAgaTtRqu4Tyaimu6bn5KkROR
 PIRN1e62f+0ZWMbHY2L7OCatTYWpR5ZuVaRN+ZTz1n8QwQOIaH2RI4VG2ST/qkR/M2cr
 sCyFvGuD1uUiTIH7wR8UAFJgv40+GLnPjcn2hJD2+O3ptztbgw701NRZzV08114PEQTf
 7U0KSnXrlNpGXMOTHTwdntbyao0jFtRdjjuJyKQSzNo+1BNUvPFps5HMXbqXO6AQ+Vof
 gqAddKSkF2TxPw8vnmwJ1X52bPrp4ZvAXHbJcSd5cZ3kU9mBBAVlthsl4UFKl8ZQRNj7
 Ig4A==
X-Gm-Message-State: AOJu0YzKaJAnRxaRLWKXcePPSGSppDuL4192TqRWbAi8c3t3Spakj8s7
 EfrwZK8mOjWt6scnors3VflH4MymgPMDOk1PvOlU0RoHSWxiHd3v60NWNw3mkZrH2mLNJnVDugo
 H59HvMTe3ItTZFLE=
X-Received: by 2002:a1f:24c5:0:b0:49e:1be5:de9b with SMTP id
 k188-20020a1f24c5000000b0049e1be5de9bmr13154473vkk.5.1698241114587; 
 Wed, 25 Oct 2023 06:38:34 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHhxFLsly2jqhH70Jv92C/VHef+nKl9fEIMlQVaBLMKlI+dW/0kjgOX6aUDJwETBAnznDTHqw==
X-Received: by 2002:a1f:24c5:0:b0:49e:1be5:de9b with SMTP id
 k188-20020a1f24c5000000b0049e1be5de9bmr13154458vkk.5.1698241114286; 
 Wed, 25 Oct 2023 06:38:34 -0700 (PDT)
Received: from [192.168.0.6] (ip-109-43-176-238.web.vodafone.de.
 [109.43.176.238]) by smtp.gmail.com with ESMTPSA id
 g3-20020ac870c3000000b0041b3a1462fbsm4203129qtp.37.2023.10.25.06.38.29
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 25 Oct 2023 06:38:32 -0700 (PDT)
Message-ID: <9c1c9947-fb66-4f58-9a72-d3a69182283a@redhat.com>
Date: Wed, 25 Oct 2023 15:38:27 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 04/19] vl: move display early init before default
 devices
Content-Language: en-US
To: =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Cc: qemu-devel@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>,
 BALATON Zoltan <balaton@eik.bme.hu>, qemu-ppc@nongnu.org,
 Gerd Hoffmann <kraxel@redhat.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, Markus Armbruster <armbru@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 "Dr. David Alan Gilbert" <dave@treblig.org>, Eric Blake <eblake@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
References: <20231023113047.2572137-1-marcandre.lureau@redhat.com>
 <20231023113047.2572137-5-marcandre.lureau@redhat.com>
 <4af29498-c70f-4969-ba71-2b30ed281ea6@redhat.com>
 <CAMxuvayE4YQk2HsEVQxVNkVP+GFL1wrw683s7jDr5c_Moq=9Cw@mail.gmail.com>
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
In-Reply-To: <CAMxuvayE4YQk2HsEVQxVNkVP+GFL1wrw683s7jDr5c_Moq=9Cw@mail.gmail.com>
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

On 25/10/2023 15.26, Marc-André Lureau wrote:
> Hi
> 
> On Wed, Oct 25, 2023 at 1:56 PM Thomas Huth <thuth@redhat.com> wrote:
>>
>> On 23/10/2023 13.30, marcandre.lureau@redhat.com wrote:
>>> From: Marc-André Lureau <marcandre.lureau@redhat.com>
>>>
>>> The next commit needs to have the display registered itself before
>>> creating the default VCs.
>>>
>>> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
>>> ---
>>>    system/vl.c | 41 +++++++++++++++++++++++------------------
>>>    1 file changed, 23 insertions(+), 18 deletions(-)
>>>
>>> diff --git a/system/vl.c b/system/vl.c
>>> index 92d29bf521..2cecb3d884 100644
>>> --- a/system/vl.c
>>> +++ b/system/vl.c
>>> @@ -1349,6 +1349,28 @@ static void qemu_disable_default_devices(void)
>>>        }
>>>    }
>>>
>>> +static void qemu_early_display_init(void)
>>> +{
>>> +#if defined(CONFIG_VNC)
>>> +    if (!QTAILQ_EMPTY(&(qemu_find_opts("vnc")->head))) {
>>> +        display_remote++;
>>> +    }
>>> +#endif
>>> +    if (dpy.type == DISPLAY_TYPE_DEFAULT && !display_remote) {
>>> +        if (!qemu_display_find_default(&dpy)) {
>>> +            dpy.type = DISPLAY_TYPE_NONE;
>>> +#if defined(CONFIG_VNC)
>>> +            vnc_parse("localhost:0,to=99,id=default");
>>> +#endif
>>> +        }
>>> +    }
>>> +    if (dpy.type == DISPLAY_TYPE_DEFAULT) {
>>> +        dpy.type = DISPLAY_TYPE_NONE;
>>> +    }
>>> +
>>> +    qemu_display_early_init(&dpy);
>>> +}
>>
>> So we now have qemu_early_display_init() and qemu_display_early_init() ... ?
>> That's very confusing, could you maybe come up with a different name for the
>> new function?
> 
> Ok, what about qemu_setup_display() ? I'll also simplify a bit the logic there.

Fine for me.

  Thomas




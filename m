Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 897557E9729
	for <lists+qemu-devel@lfdr.de>; Mon, 13 Nov 2023 09:00:27 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r2Rra-00005c-C0; Mon, 13 Nov 2023 03:00:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1r2RrT-0008WA-A8
 for qemu-devel@nongnu.org; Mon, 13 Nov 2023 02:59:59 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1r2RrQ-0002gv-Or
 for qemu-devel@nongnu.org; Mon, 13 Nov 2023 02:59:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1699862396;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=+Y9kr7m72HHxeCZTk1P99oh0BTXJaJMBvacFiW/naoU=;
 b=ftWOYmaejfTv8VjqjwGgNDjIoyU5SIZq6V0++aP48hG3PjGGmgA37RDiPW3Do/9dIn9ZSE
 NNciCldM+Ynctizc9fvFs/r4HsT+8oZHLpEPIIUjYdrcSYjpZM8QYH+bggiPAebNQ1p7kU
 bRmiKh8alpc0KN1Fjp7O2gyorRbEQOQ=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-37-Au85-lMPPnWG5kempfxW_w-1; Mon, 13 Nov 2023 02:59:53 -0500
X-MC-Unique: Au85-lMPPnWG5kempfxW_w-1
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-7789a691086so505888185a.0
 for <qemu-devel@nongnu.org>; Sun, 12 Nov 2023 23:59:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699862393; x=1700467193;
 h=content-transfer-encoding:in-reply-to:autocrypt:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=+Y9kr7m72HHxeCZTk1P99oh0BTXJaJMBvacFiW/naoU=;
 b=k/Dyws+5N91WGsqaSs3aylAkR5lfWZD43ALDZuEvUXsFULWSiwD6iFVUOBIjhz1+uK
 N/bdYo1UhJETALo+FUKtQdZKrNmDa/Ni1i9lrjsWhPQuUUmJowKfHfIXxe8DAT3hEiQz
 KXi2sb8nnYpCNpuIjHUPx+nIi3C/KKy7kOedduyPnb1yzmsmSHWVvl3daDYkLOUkyuuw
 oSz8N1CXiLjEizdq0IyRSv8aqdz2K7QTo8u2RrnkWdMINvD+nVorkc0zVhrnIuoXJkOx
 cfPpTCrLZ4RbudtcyU1xfWpaJ9lGpdcEZhGVuks7o4XZ+7xhmKFViUhodCVaFVOZmD52
 YZPQ==
X-Gm-Message-State: AOJu0YzgpukIZhPTjS6AvuwybePKP0Yh8XTd4RRjEyELsr/05b/sPywx
 mJd6kfbEE+9/0oIBABWM92HkwZU7+KITnZYmO7jnmftXAjJxRIUTTIl7yL/A3hb/m8AYxrUTifk
 nsC7Ouc40HIf3JR8=
X-Received: by 2002:a05:6214:262e:b0:66d:50a6:da72 with SMTP id
 gv14-20020a056214262e00b0066d50a6da72mr8336513qvb.26.1699862393052; 
 Sun, 12 Nov 2023 23:59:53 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHVKca9MxhO0AoXjePhpZE0rXkH3wZjcHPQQpq/dW6k/Nbj5SldysjRuHBo4mUmcKXB2yQQ5Q==
X-Received: by 2002:a05:6214:262e:b0:66d:50a6:da72 with SMTP id
 gv14-20020a056214262e00b0066d50a6da72mr8336497qvb.26.1699862392845; 
 Sun, 12 Nov 2023 23:59:52 -0800 (PST)
Received: from [192.168.0.6] (ip-109-43-177-79.web.vodafone.de.
 [109.43.177.79]) by smtp.gmail.com with ESMTPSA id
 lg10-20020a056214548a00b0066d1b4ce863sm1884364qvb.31.2023.11.12.23.59.50
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 12 Nov 2023 23:59:52 -0800 (PST)
Message-ID: <c75b931d-de56-433a-924d-f9f48d263117@redhat.com>
Date: Mon, 13 Nov 2023 08:59:49 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH for-8.2] test-resv-mem: Fix CID 1523911
Content-Language: en-US
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>,
 Eric Auger <eric.auger@redhat.com>, eric.auger.pro@gmail.com,
 qemu-devel@nongnu.org, qemu-arm@nongnu.org, peter.maydell@linaro.org,
 "Michael S. Tsirkin" <mst@redhat.com>
References: <20231110083654.277345-1-eric.auger@redhat.com>
 <b92285b4-156b-4a39-baba-ffc2e80e21bf@redhat.com>
 <69f9d31c-893c-492c-aea3-1f0af4f52962@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <69f9d31c-893c-492c-aea3-1f0af4f52962@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

On 13/11/2023 08.56, Cédric Le Goater wrote:
> On 11/13/23 08:21, Thomas Huth wrote:
>> On 10/11/2023 09.36, Eric Auger wrote:
>>> Coverity complains about passing "&expected" to "run_range_inverse_array",
>>> which dereferences null "expected". I guess the problem is that the
>>> compare_ranges() loop dereferences 'e' without testing it. However the
>>> loop condition is based on 'ranges' which is garanteed to have
>>> the same length as 'expected' given the g_assert_cmpint() just
>>> before the loop. So the code looks safe to me.
>>>
>>> Nevertheless adding a test on expected before the loop to get rid of the
>>> warning.
>>>
>>> Fixes: CID 1523901
>>> Signed-off-by: Eric Auger <eric.auger@redhat.com>
>>> Reported-by: Coverity (CID 1523901)
>>>
>>> ---
>>>
>>> Hope this fixes the Coverity warning as I cannot test.
>>> ---
>>>   tests/unit/test-resv-mem.c | 4 ++++
>>>   1 file changed, 4 insertions(+)
>>>
>>> diff --git a/tests/unit/test-resv-mem.c b/tests/unit/test-resv-mem.c
>>> index 5963274e2c..cd8f7318cc 100644
>>> --- a/tests/unit/test-resv-mem.c
>>> +++ b/tests/unit/test-resv-mem.c
>>> @@ -44,6 +44,10 @@ static void compare_ranges(const char *prefix, GList 
>>> *ranges,
>>>       print_ranges("out", ranges);
>>>       print_ranges("expected", expected);
>>>   #endif
>>> +    if (!expected) {
>>> +        g_assert_true(!ranges);
>>> +        return;
>>> +    }
>>>       g_assert_cmpint(g_list_length(ranges), ==, g_list_length(expected));
>>>       for (l = ranges, e = expected; l ; l = l->next, e = e->next) {
>>>           Range *r = (Range *)l->data;
>>
>> Reviewed-by: Thomas Huth <thuth@redhat.com>
>>
>> I'll queue it (unless somebody else wants to take this?).
> 
> There is also another fix for the same series :
> 
>    
> https://lore.kernel.org/qemu-devel/20231109170715.259520-1-eric.auger@redhat.com/
> 
> I was waiting to have a little more for VFIO to queue both but
> they could go through your queue also.

I'm just looking at patches that affect tests/ ... the other fix is not 
related to that, so I won't pick up that one.

  Thomas



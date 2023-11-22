Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DC5D77F440B
	for <lists+qemu-devel@lfdr.de>; Wed, 22 Nov 2023 11:40:04 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r5kd4-0007Ig-Bz; Wed, 22 Nov 2023 05:38:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1r5kcz-0007Hn-8d
 for qemu-devel@nongnu.org; Wed, 22 Nov 2023 05:38:41 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1r5kcv-0002yi-PS
 for qemu-devel@nongnu.org; Wed, 22 Nov 2023 05:38:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1700649516;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=VPueSHtr0SVqTm73zmY/yI62RXgSVTtzaMDPt3eiokY=;
 b=ZVW9BJ0sxxIRse1fYn3UKbva0yvDeDpKnuNdSD+BkYdhzms7O/7D/pzEXvLHnxV9Ok8RCk
 1s6EsAmU7B9jxKVyBzCMhCJq4GXMn49R7oMjt220f5EEM5kR5ze6SzxNEOYQp/Pl3esyfJ
 5h5KIEb1YhssSgEVqpAQ+cxgU7ar6Ds=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-498-4J700x78OqKKY99wf4XSPQ-1; Wed, 22 Nov 2023 05:38:34 -0500
X-MC-Unique: 4J700x78OqKKY99wf4XSPQ-1
Received: by mail-qv1-f72.google.com with SMTP id
 6a1803df08f44-67389986b6dso43496276d6.3
 for <qemu-devel@nongnu.org>; Wed, 22 Nov 2023 02:38:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700649514; x=1701254314;
 h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=VPueSHtr0SVqTm73zmY/yI62RXgSVTtzaMDPt3eiokY=;
 b=CXrq90R+8UKDQDVo+ujFM+9YRqiOZSs+7xxhyeJGsneMtmsvoIeVU0SZBoRfiSk4ge
 +lzO5EnX70VRmNa3ItD28tLzRbS3TRLoT68jZb5mLX0gOM8giiVp2DjiECMqtMmctaTk
 e3P3OlZABwe17iv5ZS2nlIZEfUj0tLWuWrQLFL9xVrsty8m8ZIfgGMcbAqjsXDDz2fL7
 RmfJwyDsIvHyTUmJw8PJwSY2MiNYUslFnAwjiGcFOiEZEXITFKD+0sFyv7JeBMAABWPt
 +S8Wps5DoKZQRUlUT7UFbt5tPTK8EUOnq3Ay+WNJE0VoRsoAa/J9h7x6CaPngAGQ5fe5
 UE+w==
X-Gm-Message-State: AOJu0YwhleWPCegOBoYJKVqZv6grhQE8eeJ0lh0N+14M+nyr+riRtYxf
 +PSaB2Gyx2O7rtH5saHZfBAuZHUVwz/pCqNZYJIVpHkGLgjjaSCAD1NIrRoW+riDe/jjC4PMLAr
 hOAbTYaF3fDdINsQ=
X-Received: by 2002:a05:6214:c43:b0:679:f44d:9085 with SMTP id
 r3-20020a0562140c4300b00679f44d9085mr2156431qvj.3.1700649514399; 
 Wed, 22 Nov 2023 02:38:34 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFHCUOk2adBKbx14WzTPFeNEUPiz/hFpc3BBimh9jntPPs41TdVy0gxEUfizuzIT2ZBVJ5JtQ==
X-Received: by 2002:a05:6214:c43:b0:679:f44d:9085 with SMTP id
 r3-20020a0562140c4300b00679f44d9085mr2156414qvj.3.1700649514085; 
 Wed, 22 Nov 2023 02:38:34 -0800 (PST)
Received: from [192.168.0.6] (ip-109-43-176-233.web.vodafone.de.
 [109.43.176.233]) by smtp.gmail.com with ESMTPSA id
 pq5-20020a05620a84c500b0076f12fcb0easm4363348qkn.2.2023.11.22.02.38.30
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 22 Nov 2023 02:38:33 -0800 (PST)
Message-ID: <99568f4f-2168-4719-8454-90f0e0658c2c@redhat.com>
Date: Wed, 22 Nov 2023 11:38:28 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] chardev: report blocked write to chardev backend
Content-Language: en-US
To: =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Cc: Nicholas Piggin <npiggin@gmail.com>, qemu-devel@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>,
 Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>, Cleber Rosa <crosa@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Beraldo Leal <bleal@redhat.com>, Ani Sinha <anisinha@redhat.com>,
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 John Snow <jsnow@redhat.com>, qemu-ppc@nongnu.org,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
References: <20231116115354.228678-1-npiggin@gmail.com>
 <20231116115354.228678-2-npiggin@gmail.com>
 <CAMxuvawXTrQ3Mu-aGbELnQyBRU4W9kuMQo-XM_zm4FbRymHkqA@mail.gmail.com>
 <CX3OGGIB0IAN.1CDYNM9U7M5Y3@wheely>
 <CAMxuvayyULsyM0bQvCr-WRP39JwbTcDknBYEhj=eDrRQ2+9dUQ@mail.gmail.com>
 <13f96104-9d9d-4f57-9c40-06352b6a6b87@redhat.com>
 <CAMxuvay+vfg+tCq3ZQt5WkLxH69QXTC1vS_7QmEKCPxCoC840g@mail.gmail.com>
From: Thomas Huth <thuth@redhat.com>
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <CAMxuvay+vfg+tCq3ZQt5WkLxH69QXTC1vS_7QmEKCPxCoC840g@mail.gmail.com>
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

On 21/11/2023 12.47, Marc-André Lureau wrote:
> Hi
> 
> On Tue, Nov 21, 2023 at 1:45 PM Thomas Huth <thuth@redhat.com> wrote:
>>
>> On 21/11/2023 10.39, Marc-André Lureau wrote:
>>> Hi
>>>
>>> On Mon, Nov 20, 2023 at 5:36 PM Nicholas Piggin <npiggin@gmail.com> wrote:
>>>>
>>>> On Mon Nov 20, 2023 at 10:06 PM AEST, Marc-André Lureau wrote:
>>>>> Hi
>>>>>
>>>>> On Thu, Nov 16, 2023 at 3:54 PM Nicholas Piggin <npiggin@gmail.com> wrote:
>>>>>>
>>>>>> If a chardev socket is not read, it will eventually fill and QEMU
>>>>>> can block attempting to write to it. A difficult bug in avocado
>>>>>> tests where the console socket was not being read from caused this
>>>>>> hang.
>>>>>>
>>>>>> warn if a chardev write is blocked for 100ms.
>>>>>>
>>>>>> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
>>>>>> ---
>>>>>> This is not necessary for the fix but it does trigger in the
>>>>>> failing avocado test without the previous patch applied. Maybe
>>>>>> it would be helpful?
>>>>>>
>>>>>> Thanks,
>>>>>> Nick
>>>>>>
>>>>>>    chardev/char.c | 6 ++++++
>>>>>>    1 file changed, 6 insertions(+)
>>>>>>
>>>>>> diff --git a/chardev/char.c b/chardev/char.c
>>>>>> index 996a024c7a..7c375e3cc4 100644
>>>>>> --- a/chardev/char.c
>>>>>> +++ b/chardev/char.c
>>>>>> @@ -114,6 +114,8 @@ static int qemu_chr_write_buffer(Chardev *s,
>>>>>>    {
>>>>>>        ChardevClass *cc = CHARDEV_GET_CLASS(s);
>>>>>>        int res = 0;
>>>>>> +    int nr_retries = 0;
>>>>>> +
>>>>>>        *offset = 0;
>>>>>>
>>>>>>        qemu_mutex_lock(&s->chr_write_lock);
>>>>>> @@ -126,6 +128,10 @@ static int qemu_chr_write_buffer(Chardev *s,
>>>>>>                } else {
>>>>>>                    g_usleep(100);
>>>>>>                }
>>>>>> +            if (++nr_retries == 1000) { /* 100ms */
>>>>>> +                warn_report("Chardev '%s' write blocked for > 100ms, "
>>>>>> +                            "socket buffer full?", s->label);
>>>>>> +            }
>>>>>
>>>>> That shouldn't happen, the frontend should poll and only write when it
>>>>> can. What is the qemu command being used here?
>>>>
>>>> You can follow it through the thread here
>>>>
>>>> https://lore.kernel.org/qemu-devel/ZVT-bY9YOr69QTPX@redhat.com/
>>>>
>>>> In short, a console device is attached to a socket pair and nothing
>>>> ever reads from it. It eventually fills, and writing to it fails
>>>> indefinitely here.
>>>>
>>>> It can be reproduced with:
>>>>
>>>> make check-avocado
>>>> AVOCADO_TESTS=tests/avocado/reverse_debugging.py:test_ppc64_pseries
>>>>
>>>>
>>>
>>> How reliably? I tried 10/10.
>>
>> It used to fail for me every time I tried - but the fix has already been
>> merged yesterday (commit cd43f00524070c026), so if you updated today, you'll
>> see the test passing again.
> 
> Ok so the "frontend" is spapr-vty and there:
> 
> void vty_putchars(SpaprVioDevice *sdev, uint8_t *buf, int len)
> {
>      SpaprVioVty *dev = VIO_SPAPR_VTY_DEVICE(sdev);
> 
>      /* XXX this blocks entire thread. Rewrite to use
>       * qemu_chr_fe_write and background I/O callbacks */
>      qemu_chr_fe_write_all(&dev->chardev, buf, len);
> }
> 
> (grep "XXX this blocks", we have a lot...)
> 
> Can H_PUT_TERM_CHAR return the number of bytes written?

You can find the definition of the hypercall in the LoPAPR spec:

  https://elinux.org/images/a/a4/LoPAPR_DRAFT_v11_24March2016.pdf

... and if I get it right, it does not have a way to tell the guest the 
amount of accepted characters. But it could return H_BUSY if it is not able 
to enqueue all characters at once. As far as I can see, this will make the 
guest spin until it can finally send out the characters... not sure whether 
that's so much better...?

  Thomas





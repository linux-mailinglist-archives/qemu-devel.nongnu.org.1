Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C7D3D719EF2
	for <lists+qemu-devel@lfdr.de>; Thu,  1 Jun 2023 15:59:14 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q4ipB-0003u0-Uj; Thu, 01 Jun 2023 09:58:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yin31149@gmail.com>)
 id 1q4ipA-0003ts-Js
 for qemu-devel@nongnu.org; Thu, 01 Jun 2023 09:58:44 -0400
Received: from mail-lj1-x22a.google.com ([2a00:1450:4864:20::22a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <yin31149@gmail.com>)
 id 1q4ip7-0002dg-S8
 for qemu-devel@nongnu.org; Thu, 01 Jun 2023 09:58:44 -0400
Received: by mail-lj1-x22a.google.com with SMTP id
 38308e7fff4ca-2af1e290921so11875341fa.3
 for <qemu-devel@nongnu.org>; Thu, 01 Jun 2023 06:58:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1685627920; x=1688219920;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QFbvsThDHpgKgiYv5DRWbvA5PEE+69CAIs/RpxM1Lyo=;
 b=WObKgLKIlUezZ/7ymzLNW18AbkH0OuYcYg4Cc8GZPuYdvMLK5BpNxcxLDPnUo62YOS
 4sfY/wuKA3CUu0Ql4myvqWA4W8WGgO+v7jn4y3KWqfOv7kn1Ax8iToxKIIT5RSSmqEWC
 yCuXgAbnexZxMdM9DhbCgxIQCoCASLWn24IxiC4HFq55J2ZsFXNBUd7gdYc0o5fL+UrZ
 hCYJ7sKGa8H9lak6rOH1yzGkxgtPQiBVnRkEHRgEcANVJOByGcOrqBeKfP7Gj5l+1nl6
 HF5CBuwWDCJMXepNoW1+Te9bYx2WTrjLbo33NoMqqwXTev39UC5meAPTMk1StVfZ4nzg
 3pDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685627920; x=1688219920;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=QFbvsThDHpgKgiYv5DRWbvA5PEE+69CAIs/RpxM1Lyo=;
 b=Vly/0c7++tcg8CjkRxe9oOfYwHwLYCI0ydBSR2OOXkCQE9MZV8KrI/NoKwAgervY0z
 a103sC4ppNVhNkRTGMenGKZEMMGRKQajX3QdcfVP7wWZR5RDypXQhdWzGFB2l1iRKnTy
 Fjr0IEYlDqtfdgrudeIZt1+EKCEbV8m2l0xBVyHDQ4CL1ZMwma+powGHDyzZBKIY1az+
 8wOi39xQJJYpCpsN04/Xlp7YauNDHBg5bm8Km9GkAHkvWJENPVDyMXaVk7st1Rp6gYuL
 3dbLcq1KJmD3b06aeOBJLs8Lzr8X/UduvtwnMQhCvhfrFrm0UgNp+ntUMrEKFQ/sN6ds
 7DSg==
X-Gm-Message-State: AC+VfDxuvfIsntUGwI6BJobxhdpz9MMZF1DslZQXcIjVrrEW4YdtzF2r
 A0BfiEreQjaecd4hdgyp+rq7FuVQubnjKBBSUwicVGX1H4hd3TNYPoE=
X-Google-Smtp-Source: ACHHUZ50uhJHPcDjFAqiNy8+Oyr3aViue2XVg5U/4bLTsXX6cGNP9XB11lzn6Rxba+6vPQBKIRcTq+bRXP9Hz7pB+P8=
X-Received: by 2002:a2e:9b86:0:b0:2ad:b1cb:faed with SMTP id
 z6-20020a2e9b86000000b002adb1cbfaedmr4849786lji.7.1685627919364; Thu, 01 Jun
 2023 06:58:39 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1685584543.git.yin31149@gmail.com>
 <39fddc462ad4c7619843a4cd7cba92e0bbc48c45.1685584543.git.yin31149@gmail.com>
 <CAKrof1OyEL5RGTWgHjgfMSkMC-afiWW8VAF5qirCy3juErWSqA@mail.gmail.com>
 <CAJaqyWewHKZebftQc6HrhDQEV5cTWiJUkVL4NgzOVqoGdP+6Sw@mail.gmail.com>
In-Reply-To: <CAJaqyWewHKZebftQc6HrhDQEV5cTWiJUkVL4NgzOVqoGdP+6Sw@mail.gmail.com>
From: Hawkins Jiawei <yin31149@gmail.com>
Date: Thu, 1 Jun 2023 21:58:27 +0800
Message-ID: <CAKrof1N0s2prVBUUz=quD-DofUcwJC=Ck_2gry9d2E+14y=Ypw@mail.gmail.com>
Subject: Re: [PATCH v2 4/6] virtio-net: expose
 virtio_net_supported_guest_offloads()
To: Eugenio Perez Martin <eperezma@redhat.com>
Cc: jasowang@redhat.com, mst@redhat.com, qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::22a;
 envelope-from=yin31149@gmail.com; helo=mail-lj1-x22a.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On 2023/6/1 21:43, Eugenio Perez Martin wrote:
> On Thu, Jun 1, 2023 at 11:05=E2=80=AFAM Hawkins Jiawei <yin31149@gmail.co=
m> wrote:
>>
>> On Thu, 1 Jun 2023 at 16:48, Hawkins Jiawei <yin31149@gmail.com> wrote:
>>>
>>> To support restoring offloads state in vdpa, need to expose
>>> the function virtio_net_supported_guest_offloads(), then vdpa
>>> uses this function to get the guest supported offloads.
>>
>> Here it should be changed to "then QEMU uses this function
>> to get the guest supported offloads.". I will correct the commit
>> message in the v3 patch.
>>
>
> Maybe "to get the device supported offloads allow qemu to know the
> defaults, so it can skip the control message sending if they match
> with the driver's configuration"?
>
> We can also add "This will be the default at guest's startup, these
> values can mismatch only at live migration".

Hi Eugenio,

I sent the v3 patch before seeing this email:(.

I refactor the commit message to
"To support restoring offloads state in vdpa, need to expose
the function virtio_net_supported_guest_offloads().
QEMU uses this function to get the guest supported offloads
and no needs to send the corresponding CVQ command if guest
enables all supported features." in v3 patch.

Do you think there is still some refactoring needed here?

Thanks!


>
> What do you think?
>
> Thanks!
>
>> Thanks!
>>
>>>
>>> Signed-off-by: Hawkins Jiawei <yin31149@gmail.com>
>>> ---
>>>   hw/net/virtio-net.c            | 2 +-
>>>   include/hw/virtio/virtio-net.h | 1 +
>>>   2 files changed, 2 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c
>>> index 7b27dad6c4..7e8897a8bc 100644
>>> --- a/hw/net/virtio-net.c
>>> +++ b/hw/net/virtio-net.c
>>> @@ -874,7 +874,7 @@ static uint64_t virtio_net_guest_offloads_by_featur=
es(uint32_t features)
>>>       return guest_offloads_mask & features;
>>>   }
>>>
>>> -static inline uint64_t virtio_net_supported_guest_offloads(const VirtI=
ONet *n)
>>> +uint64_t virtio_net_supported_guest_offloads(const VirtIONet *n)
>>>   {
>>>       VirtIODevice *vdev =3D VIRTIO_DEVICE(n);
>>>       return virtio_net_guest_offloads_by_features(vdev->guest_features=
);
>>> diff --git a/include/hw/virtio/virtio-net.h b/include/hw/virtio/virtio-=
net.h
>>> index ef234ffe7e..5f5dcb4572 100644
>>> --- a/include/hw/virtio/virtio-net.h
>>> +++ b/include/hw/virtio/virtio-net.h
>>> @@ -227,5 +227,6 @@ size_t virtio_net_handle_ctrl_iov(VirtIODevice *vde=
v,
>>>                                     unsigned out_num);
>>>   void virtio_net_set_netclient_name(VirtIONet *n, const char *name,
>>>                                      const char *type);
>>> +uint64_t virtio_net_supported_guest_offloads(const VirtIONet *n);
>>>
>>>   #endif
>>> --
>>> 2.25.1
>>>
>>
>


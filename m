Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AD77781BF5
	for <lists+qemu-devel@lfdr.de>; Sun, 20 Aug 2023 04:22:15 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qXY3c-0008PH-OM; Sat, 19 Aug 2023 22:20:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yin31149@gmail.com>)
 id 1qXY3b-0008P9-K7
 for qemu-devel@nongnu.org; Sat, 19 Aug 2023 22:20:47 -0400
Received: from mail-lf1-x133.google.com ([2a00:1450:4864:20::133])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <yin31149@gmail.com>)
 id 1qXY3Y-0003vj-IZ
 for qemu-devel@nongnu.org; Sat, 19 Aug 2023 22:20:47 -0400
Received: by mail-lf1-x133.google.com with SMTP id
 2adb3069b0e04-4fe457ec6e7so3194100e87.3
 for <qemu-devel@nongnu.org>; Sat, 19 Aug 2023 19:20:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1692498042; x=1693102842;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=11c/8LU/bDdN2YSBz0Z/B0hCL8A0Lz6jJsjwyVR3OsU=;
 b=TAFvxQd/Zm7mvx6uH5aPLUF9+k/MLFJiz6hr/Zcyq4yQeSWtSkBqyqwgOvnFq9jVpC
 Dr5OE6LFuBCEY4fIl+Yy05w1gIEEA9KU3OsQ8lPqHvzKENJokQ9EHLq3dhJt+FHKFCol
 Odszi3VZu9JKvE+A7oSm7kCkc58WXw807ccKE/vttLK1pCx+CWhg0EA9iBMf9PQMYzuM
 zLQ7NBmEp5/yCg8w1IsfY/ZXRukN0avsHcNjbYJmBPe8X72eVRHjCR7ubiWzVYQct3YG
 RZwwz7a2sjiNlHhqhvJwEa37+Xl6fRtoZSUPOvTkSbdgbDMwiGIovE8PMJU+8eGMGfoO
 UriQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692498042; x=1693102842;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=11c/8LU/bDdN2YSBz0Z/B0hCL8A0Lz6jJsjwyVR3OsU=;
 b=AzYHn2aS30GAXatkWZJXFxUqm2DUqao+EoOreK0qG9vx9V+JtzSVcWRQy/+8R9bZda
 /IutaE3pBFvTEbEW/1f2e7MnhxfAtf3q3nfH2/+f46FiqTTavjYKEbRoObN+xQLeCpZp
 ebX4/US3kmSqs8ASzMfRCYFr3jK6JZxJWeqr26B++saP4fbdZQj3T2uoCVrZgTgXIQT5
 E+Fh+NqxynAYI/ww8RndhnLHCsUe2eqpDgoHIzpT6Qd5QhJMSz9IpAXLJHTN2lhT+Y8K
 6azcEGMFdZSTREHUGvnJ2DbnpfRkzMBMGiJSiMxYI3WC0d1p4VSQcBdjN7eLwH72sQdx
 vkJw==
X-Gm-Message-State: AOJu0YwjSNu5pYlpBEw6uS/hT+FcY53FhML88GDjgCX40HMo71sg9RZS
 0NZNfiPwm/ul2LXMqzZ+1bkiuOZ4zp+CoavFEKQ=
X-Google-Smtp-Source: AGHT+IE/6bdldmFJIBxDVJoSQZCyJEKmtNxPqPPPzvwW6PO4qZOucGLr4ssEFJL0ElkCWLpSg9F2QH7sf6qg4cpaSLM=
X-Received: by 2002:a05:6512:1584:b0:4fe:1c40:9266 with SMTP id
 bp4-20020a056512158400b004fe1c409266mr2291640lfb.17.1692498041609; Sat, 19
 Aug 2023 19:20:41 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1689748694.git.yin31149@gmail.com>
 <77c1d8b358644b49992e6dbca55a5c9e62c941a8.1689748694.git.yin31149@gmail.com>
 <CAJaqyWeq=-WCfJX9=6SyQwGtRsrtyUzytjMeReJScfMLKFHc0A@mail.gmail.com>
In-Reply-To: <CAJaqyWeq=-WCfJX9=6SyQwGtRsrtyUzytjMeReJScfMLKFHc0A@mail.gmail.com>
From: Hawkins Jiawei <yin31149@gmail.com>
Date: Sun, 20 Aug 2023 10:20:30 +0800
Message-ID: <CAKrof1PjNBf+XNDLJm+P2vNWgDMFj30yxYxhKvRm_CLvrdQk2g@mail.gmail.com>
Subject: Re: [PATCH v3 1/8] vhost: Add argument to vhost_svq_poll()
To: Eugenio Perez Martin <eperezma@redhat.com>
Cc: jasowang@redhat.com, mst@redhat.com, qemu-devel@nongnu.org, 
 18801353760@163.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::133;
 envelope-from=yin31149@gmail.com; helo=mail-lf1-x133.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 2023/8/18 23:08, Eugenio Perez Martin wrote:
> On Wed, Jul 19, 2023 at 9:54=E2=80=AFAM Hawkins Jiawei <yin31149@gmail.co=
m> wrote:
>>
>
> The subject could be more explicit. What about "add count argument to
> vhost_svq_poll"?

Hi Eugenio,

Thanks for reviewing.
You are right, I will use this new subject in the v4 patch.

Thanks!


>
> Apart from that:
> Acked-by: Eugenio P=C3=A9rez <eperezma@redhat.com>
>
>> Next patches in this series will no longer perform an
>> immediate poll and check of the device's used buffers
>> for each CVQ state load command. Instead, they will
>> send CVQ state load commands in parallel by polling
>> multiple pending buffers at once.
>>
>> To achieve this, this patch refactoring vhost_svq_poll()
>> to accept a new argument `num`, which allows vhost_svq_poll()
>> to wait for the device to use multiple elements,
>> rather than polling for a single element.
>>
>> Signed-off-by: Hawkins Jiawei <yin31149@gmail.com>
>> ---
>>   hw/virtio/vhost-shadow-virtqueue.c | 36 ++++++++++++++++++------------
>>   hw/virtio/vhost-shadow-virtqueue.h |  2 +-
>>   net/vhost-vdpa.c                   |  2 +-
>>   3 files changed, 24 insertions(+), 16 deletions(-)
>>
>> diff --git a/hw/virtio/vhost-shadow-virtqueue.c b/hw/virtio/vhost-shadow=
-virtqueue.c
>> index 49e5aed931..e731b1d2ea 100644
>> --- a/hw/virtio/vhost-shadow-virtqueue.c
>> +++ b/hw/virtio/vhost-shadow-virtqueue.c
>> @@ -514,29 +514,37 @@ static void vhost_svq_flush(VhostShadowVirtqueue *=
svq,
>>   }
>>
>>   /**
>> - * Poll the SVQ for one device used buffer.
>> + * Poll the SVQ to wait for the device to use the specified number
>> + * of elements and return the total length written by the device.
>>    *
>>    * This function race with main event loop SVQ polling, so extra
>>    * synchronization is needed.
>>    *
>> - * Return the length written by the device.
>> + * @svq: The svq
>> + * @num: The number of elements that need to be used
>>    */
>> -size_t vhost_svq_poll(VhostShadowVirtqueue *svq)
>> +size_t vhost_svq_poll(VhostShadowVirtqueue *svq, size_t num)
>>   {
>> -    int64_t start_us =3D g_get_monotonic_time();
>> -    uint32_t len =3D 0;
>> +    size_t len =3D 0;
>> +    uint32_t r;
>>
>> -    do {
>> -        if (vhost_svq_more_used(svq)) {
>> -            break;
>> -        }
>> +    while (num--) {
>> +        int64_t start_us =3D g_get_monotonic_time();
>>
>> -        if (unlikely(g_get_monotonic_time() - start_us > 10e6)) {
>> -            return 0;
>> -        }
>> -    } while (true);
>> +        do {
>> +            if (vhost_svq_more_used(svq)) {
>> +                break;
>> +            }
>> +
>> +            if (unlikely(g_get_monotonic_time() - start_us > 10e6)) {
>> +                return len;
>> +            }
>> +        } while (true);
>> +
>> +        vhost_svq_get_buf(svq, &r);
>> +        len +=3D r;
>> +    }
>>
>> -    vhost_svq_get_buf(svq, &len);
>>       return len;
>>   }
>>
>> diff --git a/hw/virtio/vhost-shadow-virtqueue.h b/hw/virtio/vhost-shadow=
-virtqueue.h
>> index 6efe051a70..5bce67837b 100644
>> --- a/hw/virtio/vhost-shadow-virtqueue.h
>> +++ b/hw/virtio/vhost-shadow-virtqueue.h
>> @@ -119,7 +119,7 @@ void vhost_svq_push_elem(VhostShadowVirtqueue *svq,
>>   int vhost_svq_add(VhostShadowVirtqueue *svq, const struct iovec *out_s=
g,
>>                     size_t out_num, const struct iovec *in_sg, size_t in=
_num,
>>                     VirtQueueElement *elem);
>> -size_t vhost_svq_poll(VhostShadowVirtqueue *svq);
>> +size_t vhost_svq_poll(VhostShadowVirtqueue *svq, size_t num);
>>
>>   void vhost_svq_set_svq_kick_fd(VhostShadowVirtqueue *svq, int svq_kick=
_fd);
>>   void vhost_svq_set_svq_call_fd(VhostShadowVirtqueue *svq, int call_fd)=
;
>> diff --git a/net/vhost-vdpa.c b/net/vhost-vdpa.c
>> index dfd271c456..d1dd140bf6 100644
>> --- a/net/vhost-vdpa.c
>> +++ b/net/vhost-vdpa.c
>> @@ -625,7 +625,7 @@ static ssize_t vhost_vdpa_net_cvq_add(VhostVDPAState=
 *s, size_t out_len,
>>        * descriptor. Also, we need to take the answer before SVQ pulls b=
y itself,
>>        * when BQL is released
>>        */
>> -    return vhost_svq_poll(svq);
>> +    return vhost_svq_poll(svq, 1);
>>   }
>>
>>   static ssize_t vhost_vdpa_net_load_cmd(VhostVDPAState *s, uint8_t clas=
s,
>> --
>> 2.25.1
>>
>


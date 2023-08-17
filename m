Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E1C877F99B
	for <lists+qemu-devel@lfdr.de>; Thu, 17 Aug 2023 16:48:42 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qWeIJ-0004aj-B5; Thu, 17 Aug 2023 10:48:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yin31149@gmail.com>)
 id 1qWeIH-0004aC-9P
 for qemu-devel@nongnu.org; Thu, 17 Aug 2023 10:48:13 -0400
Received: from mail-lj1-x22d.google.com ([2a00:1450:4864:20::22d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <yin31149@gmail.com>)
 id 1qWeID-0007ef-T0
 for qemu-devel@nongnu.org; Thu, 17 Aug 2023 10:48:12 -0400
Received: by mail-lj1-x22d.google.com with SMTP id
 38308e7fff4ca-2b9a828c920so118658961fa.1
 for <qemu-devel@nongnu.org>; Thu, 17 Aug 2023 07:48:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1692283687; x=1692888487;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9tMCZDNY/2Rdc4V8Fh8AK69yoFLkNb9BDzmMBiBj/fo=;
 b=hnh9h1AMGTN59eCoDGbWb/S6XjKTu5gXcvxpSutSbI8yfhusDv2bGnU/B23bj9l+qR
 QDSumvhdddC9HKMFZySUpGIwvdc8WHiJaTTKGZLIDIHm9XqFQ3BWSmxSIyzperN46wt2
 UqXCZlSx66NTtWqZRFfvrJpVGTvTChAD0VeI9UJedWSiqj+0KdBVAPSibZW0KUSQxBwk
 +wmUXVIzJr7LL4DSu4Y4fNAu1WGZQ/nt9KlzhHBqVb+0l8+WvU8Nol/lclM1wUDcQ9cF
 iCDJbokyzn1jqOt3Mz0ycsKrDBgfwgUEwSc8Tiu98Acs4/Bvv5YGENfDCiyx2j5PLog9
 +kvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692283687; x=1692888487;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=9tMCZDNY/2Rdc4V8Fh8AK69yoFLkNb9BDzmMBiBj/fo=;
 b=DosYgpthztLvhV81jE0to/slw/BMcwISatMZmTN1/VxsTScqfilry18G9WSbrjrKkm
 hWdhY4vmIGjykX8O5+E7joP5n+9fkZ0rLVQj9LjpcbwFQpmlL3aQk7sSTvn5+Pjh3eYM
 DQzEo7J5h/1+rLcFX/5FnLuFvIz2p61XmJmyNlPn9jw3EhIPxA2Qm5mQphiFEA9aAdM2
 nYfj0S0BCMK/SOz8KEk45lpHUL5WyR4zvV/Gorx0GYGyaSdVzJii2yrKQgab/ZOCzcGk
 IYHA9kdSvr3G7Day8OGhXiL0EN7NjXd5bGskHZ6z299AVUaPfmj66bEpUV+Y6Ml4MoW3
 8hOg==
X-Gm-Message-State: AOJu0YyCcJ4pvn6JGBdkn82F4zM7mbOy6rct9JJdGJjo9TbwnI/qC2za
 iu2r70S5P7CjCn0td6CvpXkCSFNdnfvRIVZrx/0=
X-Google-Smtp-Source: AGHT+IHYSl1cYwyx4iwzb1M5rdSgzp6iVrK2Z4nwzDG9LgoO6il4UfnErbMw5UIyXawrohHOHjlZd3ohmIU7pQHhSqw=
X-Received: by 2002:a2e:9247:0:b0:2b9:20fe:4bc4 with SMTP id
 v7-20020a2e9247000000b002b920fe4bc4mr4117369ljg.40.1692283686758; Thu, 17 Aug
 2023 07:48:06 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1688743107.git.yin31149@gmail.com>
 <3482cc50eebd13db4140b8b5dec9d0cc25b20b1b.1688743107.git.yin31149@gmail.com>
 <CAJaqyWeZxv6Lf8QEAmw_Ge_BGbPJdDvsGNnze4uavqXhPZQChQ@mail.gmail.com>
 <CAKrof1OwTCbcfTxQ=6B2-iyH2E0Wxt-f+CtkkdBWtiZOPvRNLw@mail.gmail.com>
 <CAJaqyWcSwPV=AKX+HN19-GOyFRyZtWLraPmn8MyJJVG+UmQ1MA@mail.gmail.com>
In-Reply-To: <CAJaqyWcSwPV=AKX+HN19-GOyFRyZtWLraPmn8MyJJVG+UmQ1MA@mail.gmail.com>
From: Hawkins Jiawei <yin31149@gmail.com>
Date: Thu, 17 Aug 2023 22:47:55 +0800
Message-ID: <CAKrof1O_TPs_39uK1ve7Gr4H+x=6tAkMow+u34=pBKAzxkgyfA@mail.gmail.com>
Subject: Re: [PATCH v3 1/7] vdpa: Use iovec for vhost_vdpa_net_load_cmd()
To: Eugenio Perez Martin <eperezma@redhat.com>
Cc: jasowang@redhat.com, mst@redhat.com, qemu-devel@nongnu.org, 
 18801353760@163.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::22d;
 envelope-from=yin31149@gmail.com; helo=mail-lj1-x22d.google.com
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

=E5=9C=A8 2023/8/17 22:05, Eugenio Perez Martin =E5=86=99=E9=81=93:
> On Thu, Aug 17, 2023 at 2:42=E2=80=AFPM Hawkins Jiawei <yin31149@gmail.co=
m> wrote:
>>
>> On 2023/8/17 17:23, Eugenio Perez Martin wrote:
>>> On Fri, Jul 7, 2023 at 5:27=E2=80=AFPM Hawkins Jiawei <yin31149@gmail.c=
om> wrote:
>>>>
>>>> According to VirtIO standard, "The driver MUST follow
>>>> the VIRTIO_NET_CTRL_MAC_TABLE_SET command by a le32 number,
>>>> followed by that number of non-multicast MAC addresses,
>>>> followed by another le32 number, followed by that number
>>>> of multicast addresses."
>>>>
>>>> Considering that these data is not stored in contiguous memory,
>>>> this patch refactors vhost_vdpa_net_load_cmd() to accept
>>>> scattered data, eliminating the need for an addtional data copy or
>>>> packing the data into s->cvq_cmd_out_buffer outside of
>>>> vhost_vdpa_net_load_cmd().
>>>>
>>>> Signed-off-by: Hawkins Jiawei <yin31149@gmail.com>
>>>> ---
>>>> v3:
>>>>     - rename argument name to `data_sg` and `data_num`
>>>>     - use iov_to_buf() suggested by Eugenio
>>>>
>>>> v2: https://lore.kernel.org/all/6d3dc0fc076564a03501e222ef1102a6a7a643=
af.1688051252.git.yin31149@gmail.com/
>>>>     - refactor vhost_vdpa_load_cmd() to accept iovec suggested by
>>>> Eugenio
>>>>
>>>>    net/vhost-vdpa.c | 33 +++++++++++++++++++++++++--------
>>>>    1 file changed, 25 insertions(+), 8 deletions(-)
>>>>
>>>> diff --git a/net/vhost-vdpa.c b/net/vhost-vdpa.c
>>>> index 373609216f..31ef6ad6ec 100644
>>>> --- a/net/vhost-vdpa.c
>>>> +++ b/net/vhost-vdpa.c
>>>> @@ -620,29 +620,38 @@ static ssize_t vhost_vdpa_net_cvq_add(VhostVDPAS=
tate *s, size_t out_len,
>>>>    }
>>>>
>>>>    static ssize_t vhost_vdpa_net_load_cmd(VhostVDPAState *s, uint8_t c=
lass,
>>>> -                                       uint8_t cmd, const void *data,
>>>> -                                       size_t data_size)
>>>> +                                       uint8_t cmd, const struct iove=
c *data_sg,
>>>> +                                       size_t data_num)
>>>>    {
>>>>        const struct virtio_net_ctrl_hdr ctrl =3D {
>>>>            .class =3D class,
>>>>            .cmd =3D cmd,
>>>>        };
>>>> +    size_t data_size =3D iov_size(data_sg, data_num);
>>>>
>>>>        assert(data_size < vhost_vdpa_net_cvq_cmd_page_len() - sizeof(c=
trl));
>>>>
>>>> +    /* pack the CVQ command header */
>>>>        memcpy(s->cvq_cmd_out_buffer, &ctrl, sizeof(ctrl));
>>>> -    memcpy(s->cvq_cmd_out_buffer + sizeof(ctrl), data, data_size);
>>>>
>>>> -    return vhost_vdpa_net_cvq_add(s, sizeof(ctrl) + data_size,
>>>> +    /* pack the CVQ command command-specific-data */
>>>> +    iov_to_buf(data_sg, data_num, 0,
>>>> +               s->cvq_cmd_out_buffer + sizeof(ctrl), data_size);
>>>> +
>>>> +    return vhost_vdpa_net_cvq_add(s, data_size + sizeof(ctrl),
>>>
>>> Nit, any reason for changing the order of the addends? sizeof(ctrl) +
>>> data_size ?
>>
>> Hi Eugenio,
>>
>> Here the code should be changed to `sizeof(ctrl) + data_size` as you
>> point out.
>>
>> Since this patch series has already been merged into master, I will
>> submit a separate patch to correct this problem.
>>
>
> Ouch, I didn't realize that. No need to make it back again, I was just
> trying to reduce lines changed.

Ok, I got it. Regardless, thank you for your review!


>
>>>
>>>>                                      sizeof(virtio_net_ctrl_ack));
>>>>    }
>>>>
>>>>    static int vhost_vdpa_net_load_mac(VhostVDPAState *s, const VirtION=
et *n)
>>>>    {
>>>>        if (virtio_vdev_has_feature(&n->parent_obj, VIRTIO_NET_F_CTRL_M=
AC_ADDR)) {
>>>> +        const struct iovec data =3D {
>>>> +            .iov_base =3D (void *)n->mac,
>>>
>>> Assign to void should always be valid, no need for casting here.
>>
>> Yes, assign to void should be valid for normal pointers.
>>
>> However, `n->mac` is an array and is treated as a const pointer. It will
>> trigger the warning "error: initialization discards =E2=80=98const=E2=80=
=99 qualifier
>> from pointer target type" if we don't add this cast.
>>
>
> Got it, I didn't realize it. Everything is ok then.
>
> Thanks!
>
>> Thanks!
>>
>>
>>>
>>>> +            .iov_len =3D sizeof(n->mac),
>>>> +        };
>>>>            ssize_t dev_written =3D vhost_vdpa_net_load_cmd(s, VIRTIO_N=
ET_CTRL_MAC,
>>>>                                                      VIRTIO_NET_CTRL_M=
AC_ADDR_SET,
>>>> -                                                  n->mac, sizeof(n->m=
ac));
>>>> +                                                  &data, 1);
>>>>            if (unlikely(dev_written < 0)) {
>>>>                return dev_written;
>>>>            }
>>>> @@ -665,9 +674,13 @@ static int vhost_vdpa_net_load_mq(VhostVDPAState =
*s,
>>>>        }
>>>>
>>>>        mq.virtqueue_pairs =3D cpu_to_le16(n->curr_queue_pairs);
>>>> +    const struct iovec data =3D {
>>>> +        .iov_base =3D &mq,
>>>> +        .iov_len =3D sizeof(mq),
>>>> +    };
>>>>        dev_written =3D vhost_vdpa_net_load_cmd(s, VIRTIO_NET_CTRL_MQ,
>>>> -                                          VIRTIO_NET_CTRL_MQ_VQ_PAIRS=
_SET, &mq,
>>>> -                                          sizeof(mq));
>>>> +                                          VIRTIO_NET_CTRL_MQ_VQ_PAIRS=
_SET,
>>>> +                                          &data, 1);
>>>>        if (unlikely(dev_written < 0)) {
>>>>            return dev_written;
>>>>        }
>>>> @@ -706,9 +719,13 @@ static int vhost_vdpa_net_load_offloads(VhostVDPA=
State *s,
>>>>        }
>>>>
>>>>        offloads =3D cpu_to_le64(n->curr_guest_offloads);
>>>> +    const struct iovec data =3D {
>>>> +        .iov_base =3D &offloads,
>>>> +        .iov_len =3D sizeof(offloads),
>>>> +    };
>>>>        dev_written =3D vhost_vdpa_net_load_cmd(s, VIRTIO_NET_CTRL_GUES=
T_OFFLOADS,
>>>>                                              VIRTIO_NET_CTRL_GUEST_OFF=
LOADS_SET,
>>>> -                                          &offloads, sizeof(offloads)=
);
>>>> +                                          &data, 1);
>>>>        if (unlikely(dev_written < 0)) {
>>>>            return dev_written;
>>>>        }
>>>
>>> Apart from that:
>>>
>>> Acked-by: Eugenio P=C3=A9rez <eperezma@redhat.com>
>>>
>>> Thanks!
>>>
>>
>


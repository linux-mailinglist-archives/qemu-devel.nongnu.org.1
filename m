Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id EEA5C7BCBB9
	for <lists+qemu-devel@lfdr.de>; Sun,  8 Oct 2023 04:25:54 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qpJSu-0008CZ-IL; Sat, 07 Oct 2023 22:24:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yin31149@gmail.com>)
 id 1qpJSs-0008CD-FW
 for qemu-devel@nongnu.org; Sat, 07 Oct 2023 22:24:18 -0400
Received: from mail-lf1-x132.google.com ([2a00:1450:4864:20::132])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <yin31149@gmail.com>)
 id 1qpJSq-00016N-2U
 for qemu-devel@nongnu.org; Sat, 07 Oct 2023 22:24:18 -0400
Received: by mail-lf1-x132.google.com with SMTP id
 2adb3069b0e04-50435a9f800so4443738e87.2
 for <qemu-devel@nongnu.org>; Sat, 07 Oct 2023 19:24:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1696731854; x=1697336654; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7dT8t/eGEHQ7s8TasaMWxBgZHgzXHAmu2kDVJe/UfPU=;
 b=lTPkA9ZKMEmGx4GvyyvHPcK1+oCijDkXRGqREhFTGtE8t9jcPgo+HhdZ4t7m34uCCX
 6/EImrB0Nj/8JZohn+owxPIZpt4/az/Zst2XIFkBAORkRxkdw00EJHMcCTzKrInxgzAX
 kreGvLwpHv8ZrpNu/ik60Iuumi4a9GIOVfsHA7n0rex2pB05CaQnevyvlahLjRIASBWN
 YImaIcoBO5Gs8lXOMigsOGyhJGVTyMsVPO1YOwl6D/sC3f0nGHqX9kZl5nTfVbHtjgsJ
 KvjV/FJc34FE91VJyK04uHJ3m1uomYu6wm9vGMRNr25/f94VwXUZymYFZjp0ezJQ0bG/
 wHdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696731854; x=1697336654;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=7dT8t/eGEHQ7s8TasaMWxBgZHgzXHAmu2kDVJe/UfPU=;
 b=qq/RgxN/juuSAHo0mZs1Dqv1ddHyvyzva7285bE2KOv9asdrTenLW8QeJDDDpe5d6w
 bjF05Y6fkIOxPPMJ+NuY1PcVBWeGryH3MnFwxpSZXcc8uDBh7s7WBrm/ptxionXvxShg
 ZnvqpAZnct1yw2XKT0efENqzNFPDVA8z94CJWZjCQb8zRHDGuDZVrVWKFzia0Fn2EjFu
 COn8aBUAd1ekMN7aE9osJYDeJupcwagdhKwNvxiKO2+0VBnV0bQamzEfc9ElzxBUtM+u
 N8mMLHU50aeujKEC0/hJURJlXBg81AP8U2PrUmJX+C21rXqlwkp2IrZmMYuUSFJ3Q0BJ
 LGWQ==
X-Gm-Message-State: AOJu0YxsTbKWLYhT6wzElqDwq38pjWbQ1GgvW+aVi/fNwbRUFLPK9sNx
 sZnWZLIjMvVlXbBn21g3uOW1O2euLmQ4Oxyt4yc=
X-Google-Smtp-Source: AGHT+IG55+Po2fu19AthaeMBjVVpucgwm3BAnNoZ+4lPQyb7JlaZCM1HY9VR5NYqfzIKpkzqWQ9GK1hERY0SKmnlCMM=
X-Received: by 2002:a19:501d:0:b0:503:95b:db0a with SMTP id
 e29-20020a19501d000000b00503095bdb0amr9250590lfb.12.1696731853387; Sat, 07
 Oct 2023 19:24:13 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1693287885.git.yin31149@gmail.com>
 <f25fea0b0aed78bad2dd5744a4cc5538243672e6.1693287885.git.yin31149@gmail.com>
 <CAJaqyWdHkenU+VVZbnBP3Duuj3CLKL7x0ahb-pBrdfJ+Ydro5g@mail.gmail.com>
In-Reply-To: <CAJaqyWdHkenU+VVZbnBP3Duuj3CLKL7x0ahb-pBrdfJ+Ydro5g@mail.gmail.com>
From: Hawkins Jiawei <yin31149@gmail.com>
Date: Sun, 8 Oct 2023 10:24:02 +0800
Message-ID: <CAKrof1Mo3wOpNYmaNyDF0QU9RGrL8j0kcQcfgLndcTfqCvSJ3A@mail.gmail.com>
Subject: Re: [PATCH v4 8/8] vdpa: Send cvq state load commands in parallel
To: Eugenio Perez Martin <eperezma@redhat.com>
Cc: jasowang@redhat.com, mst@redhat.com, qemu-devel@nongnu.org, 
 leiyang@redhat.com, 18801353760@163.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::132;
 envelope-from=yin31149@gmail.com; helo=mail-lf1-x132.google.com
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

=E5=9C=A8 2023/10/4 15:33, Eugenio Perez Martin =E5=86=99=E9=81=93:
> On Tue, Aug 29, 2023 at 7:55=E2=80=AFAM Hawkins Jiawei <yin31149@gmail.co=
m> wrote:
>>
>> This patch enables sending CVQ state load commands
>> in parallel at device startup by following steps:
>>
>>    * Refactor vhost_vdpa_net_load_cmd() to iterate through
>> the control commands shadow buffers. This allows different
>> CVQ state load commands to use their own unique buffers.
>>
>>    * Delay the polling and checking of buffers until either
>> the SVQ is full or control commands shadow buffers are full.
>>
>> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/1578
>> Signed-off-by: Hawkins Jiawei <yin31149@gmail.com>
>> ---
>> v4:
>>    - refactor argument `cmds_in_flight` to `len` for
>> vhost_vdpa_net_svq_full()
>>    - check the return value of vhost_vdpa_net_svq_poll()
>> in vhost_vdpa_net_svq_flush() suggested by Eugenio
>>    - use iov_size(), vhost_vdpa_net_load_cursor_reset()
>> and iov_discard_front() to update the cursors instead of
>> accessing it directly according to Eugenio
>>
>> v3: https://lore.kernel.org/all/3a002790e6c880af928c6470ecbf03e7c65a68bb=
.1689748694.git.yin31149@gmail.com/
>>
>>   net/vhost-vdpa.c | 155 +++++++++++++++++++++++++++++------------------
>>   1 file changed, 97 insertions(+), 58 deletions(-)
>>
>> diff --git a/net/vhost-vdpa.c b/net/vhost-vdpa.c
>> index a71e8c9090..818464b702 100644
>> --- a/net/vhost-vdpa.c
>> +++ b/net/vhost-vdpa.c
>> @@ -646,6 +646,31 @@ static void vhost_vdpa_net_load_cursor_reset(VhostV=
DPAState *s,
>>       in_cursor->iov_len =3D vhost_vdpa_net_cvq_cmd_page_len();
>>   }
>>
>> +/*
>> + * Poll SVQ for multiple pending control commands and check the device'=
s ack.
>> + *
>> + * Caller should hold the BQL when invoking this function.
>> + *
>> + * @s: The VhostVDPAState
>> + * @len: The length of the pending status shadow buffer
>> + */
>> +static ssize_t vhost_vdpa_net_svq_flush(VhostVDPAState *s, size_t len)
>> +{
>> +    /* Device uses a one-byte length ack for each control command */
>> +    ssize_t dev_written =3D vhost_vdpa_net_svq_poll(s, len);
>> +    if (unlikely(dev_written !=3D len)) {
>> +        return -EIO;
>> +    }
>> +
>> +    /* check the device's ack */
>> +    for (int i =3D 0; i < len; ++i) {
>> +        if (s->status[i] !=3D VIRTIO_NET_OK) {
>> +            return -EIO;
>> +        }
>> +    }
>> +    return 0;
>> +}
>> +
>>   static ssize_t vhost_vdpa_net_load_cmd(VhostVDPAState *s,
>>                                          struct iovec *out_cursor,
>>                                          struct iovec *in_cursor, uint8_=
t class,
>> @@ -660,10 +685,30 @@ static ssize_t vhost_vdpa_net_load_cmd(VhostVDPASt=
ate *s,
>>              cmd_size =3D sizeof(ctrl) + data_size;
>>       struct iovec out, in;
>>       ssize_t r;
>> +    unsigned dummy_cursor_iov_cnt;
>>
>>       assert(data_size < vhost_vdpa_net_cvq_cmd_page_len() - sizeof(ctrl=
));
>> +    if (vhost_vdpa_net_svq_available_slots(s) < 2 ||
>> +        iov_size(out_cursor, 1) < cmd_size) {
>> +        /*
>> +         * It is time to flush all pending control commands if SVQ is f=
ull
>> +         * or control commands shadow buffers are full.
>> +         *
>> +         * We can poll here since we've had BQL from the time
>> +         * we sent the descriptor.
>> +         */
>> +        r =3D vhost_vdpa_net_svq_flush(s, in_cursor->iov_base -
>> +                                     (void *)s->status);
>> +        if (unlikely(r < 0)) {
>> +            return r;
>> +        }
>> +
>> +        vhost_vdpa_net_load_cursor_reset(s, out_cursor, in_cursor);
>> +    }
>> +
>
> It would be great to merge this flush with the one at
> vhost_vdpa_net_load. We would need to return ENOSPC or similar and
> handle it there.
>
> But it would make it more difficult to iterate through the loading of
> the different parameters, so I think it can be done on top.
>

Hi Eugenio,

Please forgive my poor English, so do you mean the approach in my
patch is acceptable for you?

>>       /* Each CVQ command has one out descriptor and one in descriptor *=
/
>>       assert(vhost_vdpa_net_svq_available_slots(s) >=3D 2);
>> +    assert(iov_size(out_cursor, 1) >=3D cmd_size);
>>
>
> Same here, I think we can avoid the assertion, right?

You are right, I will remove this assertion.

Thanks!


>
> Apart from that,
>
> Acked-by: Eugenio P=C3=A9rez <eperezma@redhat.com>
>
>>       /* Prepare the buffer for out descriptor for the device */
>>       iov_copy(&out, 1, out_cursor, 1, 0, cmd_size);
>> @@ -681,11 +726,13 @@ static ssize_t vhost_vdpa_net_load_cmd(VhostVDPASt=
ate *s,
>>           return r;
>>       }
>>
>> -    /*
>> -     * We can poll here since we've had BQL from the time
>> -     * we sent the descriptor.
>> -     */
>> -    return vhost_vdpa_net_svq_poll(s, 1);
>> +    /* iterate the cursors */
>> +    dummy_cursor_iov_cnt =3D 1;
>> +    iov_discard_front(&out_cursor, &dummy_cursor_iov_cnt, cmd_size);
>> +    dummy_cursor_iov_cnt =3D 1;
>> +    iov_discard_front(&in_cursor, &dummy_cursor_iov_cnt, sizeof(*s->sta=
tus));
>> +
>> +    return 0;
>>   }
>>
>>   static int vhost_vdpa_net_load_mac(VhostVDPAState *s, const VirtIONet =
*n,
>> @@ -697,15 +744,12 @@ static int vhost_vdpa_net_load_mac(VhostVDPAState =
*s, const VirtIONet *n,
>>               .iov_base =3D (void *)n->mac,
>>               .iov_len =3D sizeof(n->mac),
>>           };
>> -        ssize_t dev_written =3D vhost_vdpa_net_load_cmd(s, out_cursor, =
in_cursor,
>> -                                                  VIRTIO_NET_CTRL_MAC,
>> -                                                  VIRTIO_NET_CTRL_MAC_A=
DDR_SET,
>> -                                                  &data, 1);
>> -        if (unlikely(dev_written < 0)) {
>> -            return dev_written;
>> -        }
>> -        if (*s->status !=3D VIRTIO_NET_OK) {
>> -            return -EIO;
>> +        ssize_t r =3D vhost_vdpa_net_load_cmd(s, out_cursor, in_cursor,
>> +                                               VIRTIO_NET_CTRL_MAC,
>> +                                               VIRTIO_NET_CTRL_MAC_ADDR=
_SET,
>> +                                               &data, 1);
>> +        if (unlikely(r < 0)) {
>> +            return r;
>>           }
>>       }
>>
>> @@ -750,15 +794,12 @@ static int vhost_vdpa_net_load_mac(VhostVDPAState =
*s, const VirtIONet *n,
>>               .iov_len =3D mul_macs_size,
>>           },
>>       };
>> -    ssize_t dev_written =3D vhost_vdpa_net_load_cmd(s, out_cursor, in_c=
ursor,
>> +    ssize_t r =3D vhost_vdpa_net_load_cmd(s, out_cursor, in_cursor,
>>                                   VIRTIO_NET_CTRL_MAC,
>>                                   VIRTIO_NET_CTRL_MAC_TABLE_SET,
>>                                   data, ARRAY_SIZE(data));
>> -    if (unlikely(dev_written < 0)) {
>> -        return dev_written;
>> -    }
>> -    if (*s->status !=3D VIRTIO_NET_OK) {
>> -        return -EIO;
>> +    if (unlikely(r < 0)) {
>> +        return r;
>>       }
>>
>>       return 0;
>> @@ -770,7 +811,7 @@ static int vhost_vdpa_net_load_mq(VhostVDPAState *s,
>>                                     struct iovec *in_cursor)
>>   {
>>       struct virtio_net_ctrl_mq mq;
>> -    ssize_t dev_written;
>> +    ssize_t r;
>>
>>       if (!virtio_vdev_has_feature(&n->parent_obj, VIRTIO_NET_F_MQ)) {
>>           return 0;
>> @@ -781,15 +822,12 @@ static int vhost_vdpa_net_load_mq(VhostVDPAState *=
s,
>>           .iov_base =3D &mq,
>>           .iov_len =3D sizeof(mq),
>>       };
>> -    dev_written =3D vhost_vdpa_net_load_cmd(s, out_cursor, in_cursor,
>> -                                          VIRTIO_NET_CTRL_MQ,
>> -                                          VIRTIO_NET_CTRL_MQ_VQ_PAIRS_S=
ET,
>> -                                          &data, 1);
>> -    if (unlikely(dev_written < 0)) {
>> -        return dev_written;
>> -    }
>> -    if (*s->status !=3D VIRTIO_NET_OK) {
>> -        return -EIO;
>> +    r =3D vhost_vdpa_net_load_cmd(s, out_cursor, in_cursor,
>> +                                   VIRTIO_NET_CTRL_MQ,
>> +                                   VIRTIO_NET_CTRL_MQ_VQ_PAIRS_SET,
>> +                                   &data, 1);
>> +    if (unlikely(r < 0)) {
>> +        return r;
>>       }
>>
>>       return 0;
>> @@ -801,7 +839,7 @@ static int vhost_vdpa_net_load_offloads(VhostVDPASta=
te *s,
>>                                           struct iovec *in_cursor)
>>   {
>>       uint64_t offloads;
>> -    ssize_t dev_written;
>> +    ssize_t r;
>>
>>       if (!virtio_vdev_has_feature(&n->parent_obj,
>>                                    VIRTIO_NET_F_CTRL_GUEST_OFFLOADS)) {
>> @@ -829,15 +867,12 @@ static int vhost_vdpa_net_load_offloads(VhostVDPAS=
tate *s,
>>           .iov_base =3D &offloads,
>>           .iov_len =3D sizeof(offloads),
>>       };
>> -    dev_written =3D vhost_vdpa_net_load_cmd(s, out_cursor, in_cursor,
>> -                                          VIRTIO_NET_CTRL_GUEST_OFFLOAD=
S,
>> -                                          VIRTIO_NET_CTRL_GUEST_OFFLOAD=
S_SET,
>> -                                          &data, 1);
>> -    if (unlikely(dev_written < 0)) {
>> -        return dev_written;
>> -    }
>> -    if (*s->status !=3D VIRTIO_NET_OK) {
>> -        return -EIO;
>> +    r =3D vhost_vdpa_net_load_cmd(s, out_cursor, in_cursor,
>> +                                   VIRTIO_NET_CTRL_GUEST_OFFLOADS,
>> +                                   VIRTIO_NET_CTRL_GUEST_OFFLOADS_SET,
>> +                                   &data, 1);
>> +    if (unlikely(r < 0)) {
>> +        return r;
>>       }
>>
>>       return 0;
>> @@ -853,16 +888,12 @@ static int vhost_vdpa_net_load_rx_mode(VhostVDPASt=
ate *s,
>>           .iov_base =3D &on,
>>           .iov_len =3D sizeof(on),
>>       };
>> -    ssize_t dev_written;
>> +    ssize_t r;
>>
>> -    dev_written =3D vhost_vdpa_net_load_cmd(s, out_cursor, in_cursor,
>> -                                          VIRTIO_NET_CTRL_RX,
>> -                                          cmd, &data, 1);
>> -    if (unlikely(dev_written < 0)) {
>> -        return dev_written;
>> -    }
>> -    if (*s->status !=3D VIRTIO_NET_OK) {
>> -        return -EIO;
>> +    r =3D vhost_vdpa_net_load_cmd(s, out_cursor, in_cursor,
>> +                                VIRTIO_NET_CTRL_RX, cmd, &data, 1);
>> +    if (unlikely(r < 0)) {
>> +        return r;
>>       }
>>
>>       return 0;
>> @@ -1019,15 +1050,12 @@ static int vhost_vdpa_net_load_single_vlan(Vhost=
VDPAState *s,
>>           .iov_base =3D &vid,
>>           .iov_len =3D sizeof(vid),
>>       };
>> -    ssize_t dev_written =3D vhost_vdpa_net_load_cmd(s, out_cursor, in_c=
ursor,
>> -                                                  VIRTIO_NET_CTRL_VLAN,
>> -                                                  VIRTIO_NET_CTRL_VLAN_=
ADD,
>> -                                                  &data, 1);
>> -    if (unlikely(dev_written < 0)) {
>> -        return dev_written;
>> -    }
>> -    if (unlikely(*s->status !=3D VIRTIO_NET_OK)) {
>> -        return -EIO;
>> +    ssize_t r =3D vhost_vdpa_net_load_cmd(s, out_cursor, in_cursor,
>> +                                           VIRTIO_NET_CTRL_VLAN,
>> +                                           VIRTIO_NET_CTRL_VLAN_ADD,
>> +                                           &data, 1);
>> +    if (unlikely(r < 0)) {
>> +        return r;
>>       }
>>
>>       return 0;
>> @@ -1096,6 +1124,17 @@ static int vhost_vdpa_net_load(NetClientState *nc=
)
>>           return r;
>>       }
>>
>> +    /*
>> +     * We need to poll and check all pending device's used buffers.
>> +     *
>> +     * We can poll here since we've had BQL from the time
>> +     * we sent the descriptor.
>> +     */
>> +    r =3D vhost_vdpa_net_svq_flush(s, in_cursor.iov_base - (void *)s->s=
tatus);
>> +    if (unlikely(r)) {
>> +        return r;
>> +    }
>> +
>>       return 0;
>>   }
>>
>> --
>> 2.25.1
>>
>


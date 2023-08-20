Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CAB45781C44
	for <lists+qemu-devel@lfdr.de>; Sun, 20 Aug 2023 05:36:52 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qXZDj-0006PK-Lh; Sat, 19 Aug 2023 23:35:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yin31149@gmail.com>)
 id 1qXZDg-0006PA-Is
 for qemu-devel@nongnu.org; Sat, 19 Aug 2023 23:35:16 -0400
Received: from mail-lj1-x236.google.com ([2a00:1450:4864:20::236])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <yin31149@gmail.com>)
 id 1qXZDd-0007Qx-3M
 for qemu-devel@nongnu.org; Sat, 19 Aug 2023 23:35:16 -0400
Received: by mail-lj1-x236.google.com with SMTP id
 38308e7fff4ca-2b9b5ee9c5aso35181331fa.1
 for <qemu-devel@nongnu.org>; Sat, 19 Aug 2023 20:35:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1692502510; x=1693107310;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=K74PUvP9nvjwWwZ0n3EUA1bucR5fnmhLSgV6F4/mJVs=;
 b=LI7xW3md/sfQrEmN0yEVTeo8udsgl36NkZi8NuykRyHUd+gL00/KY8LfVAteU8i+8I
 yqHSy9OGAzXW9NgxekV562qtnBiTSLiUPWgCCt+QMOV4qQ5F+lpA51xl7ZBxQNtDhZy2
 GaN0Z+gmYzfgVb9H8zKPOUj0BLOta6AlQQtCwbp5LqVbmb2R0eWn3QWBFJcrtqzOR6dC
 vvH7amGY9V8Pz7wscM9NbSI5mE/xFdGSswUaA5zRPDtaY5+/oUUYaldoU3iKTVYYdv+l
 9r/rKpS506j08FoVswMsv+B2VunDsu0DW0TkX7x2GgnWfj6Yk2SkI4cF7nIj9wAoFiL0
 KGXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692502510; x=1693107310;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=K74PUvP9nvjwWwZ0n3EUA1bucR5fnmhLSgV6F4/mJVs=;
 b=cvdLmArGwDGoiJ0dCBdMkqgPqW7PFiOFZofL+QI1pGeRersbh/1K9atagWE3x1NI10
 b3vIOTyiixv7RD49Gb2Pux3aw4SlmgEY1oa9X97ilw7SN6jayTvCdS4TiKefoKvarckw
 jUi1CRHcB4riPtAPB82l2Meff+WCwgkoLRGG1KoAHmLhBTKVqau8JW678gLHZRgH5BtA
 MxOivI0JqKzFaEOtyN4uuGsIGXm0501zStx1DQQALS1+qCyR6zvxcmfbDfRskk5DpBbL
 VK89bxTDq+Fpq+/chiDQP6HjQ3Zq5l+7dQwEzqhoH1e5blc5Bw01inBps0wuZHF/qzWG
 vU+g==
X-Gm-Message-State: AOJu0Yzbit47ouZIXOKzFqhjGERwaCQ51KoV1B1encUpv79hswFxsx4y
 91hULuZnxV7TYtMRK5MLTY6oyHXlrfNGQ6iK7ao=
X-Google-Smtp-Source: AGHT+IF4q5znA/K7hw7vo/sHJuddEWQFcMfVWODVvIrjqCADc2GHaX1Rf7vlujKXv79GeLBvvWX26J6NieRYbL+k4iI=
X-Received: by 2002:a2e:999a:0:b0:2bb:8bc1:db55 with SMTP id
 w26-20020a2e999a000000b002bb8bc1db55mr2207145lji.52.1692502509543; Sat, 19
 Aug 2023 20:35:09 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1689748694.git.yin31149@gmail.com>
 <3a002790e6c880af928c6470ecbf03e7c65a68bb.1689748694.git.yin31149@gmail.com>
 <CAJaqyWc0UAiTo4u4ps_vSLYVJb1KHEUn+c7MEPf2vNuWRFMCiQ@mail.gmail.com>
In-Reply-To: <CAJaqyWc0UAiTo4u4ps_vSLYVJb1KHEUn+c7MEPf2vNuWRFMCiQ@mail.gmail.com>
From: Hawkins Jiawei <yin31149@gmail.com>
Date: Sun, 20 Aug 2023 11:34:57 +0800
Message-ID: <CAKrof1NWWpgMPscnG1oc4Qxwk+rgVUx-tWWNMRSJGcSy-R2hng@mail.gmail.com>
Subject: Re: [PATCH v3 8/8] vdpa: Send cvq state load commands in parallel
To: Eugenio Perez Martin <eperezma@redhat.com>
Cc: jasowang@redhat.com, mst@redhat.com, qemu-devel@nongnu.org, 
 18801353760@163.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::236;
 envelope-from=yin31149@gmail.com; helo=mail-lj1-x236.google.com
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

On 2023/8/19 01:27, Eugenio Perez Martin wrote:
> On Wed, Jul 19, 2023 at 9:54=E2=80=AFAM Hawkins Jiawei <yin31149@gmail.co=
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
>>   net/vhost-vdpa.c | 157 +++++++++++++++++++++++++++++------------------
>>   1 file changed, 96 insertions(+), 61 deletions(-)
>>
>> diff --git a/net/vhost-vdpa.c b/net/vhost-vdpa.c
>> index 795c9c1fd2..1ebb58f7f6 100644
>> --- a/net/vhost-vdpa.c
>> +++ b/net/vhost-vdpa.c
>> @@ -633,6 +633,26 @@ static uint16_t vhost_vdpa_net_svq_available_slots(=
VhostVDPAState *s)
>>       return vhost_svq_available_slots(svq);
>>   }
>>
>> +/*
>> + * Poll SVQ for multiple pending control commands and check the device'=
s ack.
>> + *
>> + * Caller should hold the BQL when invoking this function.
>> + */
>> +static ssize_t vhost_vdpa_net_svq_flush(VhostVDPAState *s,
>> +                                        size_t cmds_in_flight)
>> +{
>> +    vhost_vdpa_net_svq_poll(s, cmds_in_flight);
>> +
>> +    /* Device should and must use only one byte ack each control comman=
d */
>> +    assert(cmds_in_flight < vhost_vdpa_net_cvq_cmd_page_len());
>> +    for (int i =3D 0; i < cmds_in_flight; ++i) {
>> +        if (s->status[i] !=3D VIRTIO_NET_OK) {
>> +            return -EIO;
>> +        }
>> +    }
>> +    return 0;
>> +}
>> +
>>   static ssize_t vhost_vdpa_net_load_cmd(VhostVDPAState *s, void **out_c=
ursor,
>>                                          void **in_cursor, uint8_t class=
,
>>                                          uint8_t cmd, const struct iovec=
 *data_sg,
>> @@ -642,19 +662,41 @@ static ssize_t vhost_vdpa_net_load_cmd(VhostVDPASt=
ate *s, void **out_cursor,
>>           .class =3D class,
>>           .cmd =3D cmd,
>>       };
>> -    size_t data_size =3D iov_size(data_sg, data_num);
>> +    size_t data_size =3D iov_size(data_sg, data_num),
>> +           left_bytes =3D vhost_vdpa_net_cvq_cmd_page_len() -
>> +                        (*out_cursor - s->cvq_cmd_out_buffer);
>>       /* Buffers for the device */
>>       struct iovec out =3D {
>> -        .iov_base =3D *out_cursor,
>>           .iov_len =3D sizeof(ctrl) + data_size,
>>       };
>>       struct iovec in =3D {
>> -        .iov_base =3D *in_cursor,
>>           .iov_len =3D sizeof(*s->status),
>>       };
>>       ssize_t r;
>>
>> -    assert(data_size < vhost_vdpa_net_cvq_cmd_page_len() - sizeof(ctrl)=
);
>> +    if (sizeof(ctrl) > left_bytes || data_size > left_bytes - sizeof(ct=
rl) ||
>
> I'm ok with this code, but maybe we can simplify the code if we use
> two struct iovec as cursors instead of a void **? I think functions
> like iov_size and iov_copy already take care of a few checks here.

Hi Eugenio,

Thanks for the explanation, I will refactor the patch according to your
suggestion!

>
> Apart from that it would be great to merge this call to
> vhost_vdpa_net_svq_flush, but I find it very hard to do unless we
> scatter it through all callers of vhost_vdpa_net_load_cmd.

Yes, I agree with you. Maybe we can consider refactoring like this in
the future if needed.

>
> Apart from the minor comments I think the series is great, thanks!

Thanks for your review:)!


>
>> +        vhost_vdpa_net_svq_available_slots(s) < 2) {
>> +        /*
>> +         * It is time to flush all pending control commands if SVQ is f=
ull
>> +         * or control commands shadow buffers are full.
>> +         *
>> +         * We can poll here since we've had BQL from the time
>> +         * we sent the descriptor.
>> +         */
>> +        r =3D vhost_vdpa_net_svq_flush(s, *in_cursor - (void *)s->statu=
s);
>> +        if (unlikely(r < 0)) {
>> +            return r;
>> +        }
>> +
>> +        *out_cursor =3D s->cvq_cmd_out_buffer;
>> +        *in_cursor =3D s->status;
>> +        left_bytes =3D vhost_vdpa_net_cvq_cmd_page_len();
>> +    }
>> +
>> +    out.iov_base =3D *out_cursor;
>> +    in.iov_base =3D *in_cursor;
>> +
>> +    assert(data_size <=3D left_bytes - sizeof(ctrl));
>>       /* Each CVQ command has one out descriptor and one in descriptor *=
/
>>       assert(vhost_vdpa_net_svq_available_slots(s) >=3D 2);
>>
>> @@ -670,11 +712,11 @@ static ssize_t vhost_vdpa_net_load_cmd(VhostVDPASt=
ate *s, void **out_cursor,
>>           return r;
>>       }
>>
>> -    /*
>> -     * We can poll here since we've had BQL from the time
>> -     * we sent the descriptor.
>> -     */
>> -    return vhost_vdpa_net_svq_poll(s, 1);
>> +    /* iterate the cursors */
>> +    *out_cursor +=3D out.iov_len;
>> +    *in_cursor +=3D in.iov_len;
>> +
>> +    return 0;
>>   }
>>
>>   static int vhost_vdpa_net_load_mac(VhostVDPAState *s, const VirtIONet =
*n,
>> @@ -685,15 +727,12 @@ static int vhost_vdpa_net_load_mac(VhostVDPAState =
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
>> @@ -738,15 +777,12 @@ static int vhost_vdpa_net_load_mac(VhostVDPAState =
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
>> @@ -757,7 +793,7 @@ static int vhost_vdpa_net_load_mq(VhostVDPAState *s,
>>                                     void **out_cursor, void **in_cursor)
>>   {
>>       struct virtio_net_ctrl_mq mq;
>> -    ssize_t dev_written;
>> +    ssize_t r;
>>
>>       if (!virtio_vdev_has_feature(&n->parent_obj, VIRTIO_NET_F_MQ)) {
>>           return 0;
>> @@ -768,15 +804,12 @@ static int vhost_vdpa_net_load_mq(VhostVDPAState *=
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
>> @@ -787,7 +820,7 @@ static int vhost_vdpa_net_load_offloads(VhostVDPASta=
te *s,
>>                                           void **out_cursor, void **in_c=
ursor)
>>   {
>>       uint64_t offloads;
>> -    ssize_t dev_written;
>> +    ssize_t r;
>>
>>       if (!virtio_vdev_has_feature(&n->parent_obj,
>>                                    VIRTIO_NET_F_CTRL_GUEST_OFFLOADS)) {
>> @@ -815,15 +848,12 @@ static int vhost_vdpa_net_load_offloads(VhostVDPAS=
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
>> @@ -838,15 +868,12 @@ static int vhost_vdpa_net_load_rx_mode(VhostVDPASt=
ate *s,
>>           .iov_base =3D &on,
>>           .iov_len =3D sizeof(on),
>>       };
>> -    ssize_t dev_written;
>> +    ssize_t r;
>>
>> -    dev_written =3D vhost_vdpa_net_load_cmd(s, out_cursor, in_cursor,
>> -                                          VIRTIO_NET_CTRL_RX, cmd, &dat=
a, 1);
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
>> @@ -1001,15 +1028,12 @@ static int vhost_vdpa_net_load_single_vlan(Vhost=
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
>> @@ -1078,6 +1102,17 @@ static int vhost_vdpa_net_load(NetClientState *nc=
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
>> +    r =3D vhost_vdpa_net_svq_flush(s, in_cursor - (void *)s->status);
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


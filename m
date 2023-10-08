Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 750357BCBA8
	for <lists+qemu-devel@lfdr.de>; Sun,  8 Oct 2023 04:05:25 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qpJ99-0003G6-3X; Sat, 07 Oct 2023 22:03:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yin31149@gmail.com>)
 id 1qpJ97-0003Fw-Uq
 for qemu-devel@nongnu.org; Sat, 07 Oct 2023 22:03:54 -0400
Received: from mail-lf1-x12a.google.com ([2a00:1450:4864:20::12a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <yin31149@gmail.com>)
 id 1qpJ95-0005LN-B9
 for qemu-devel@nongnu.org; Sat, 07 Oct 2023 22:03:53 -0400
Received: by mail-lf1-x12a.google.com with SMTP id
 2adb3069b0e04-5041cc983f9so4082112e87.3
 for <qemu-devel@nongnu.org>; Sat, 07 Oct 2023 19:03:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1696730629; x=1697335429; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0E3O02TsYGrUY7+SquBNTbmmvpDSZCrNXmTk6Jo0VpY=;
 b=TiyOs0eLlv/xT6i4chuNhQ2vk+/keHF+e10nkh9sejWIeiXaG+eKCdZL22AgE/iJoy
 6KvJCCi0I9YdwadJYFvlQVQDJQVhcypFHawQp9OeaC708r08H7Mskz6m1KdeitRpob7A
 YCIyYUnITT86GMXU+F8nJlQcEjJwQxxBSMGllWmYV1tU0lXYXyq4QncEIHOwsfDLUkZD
 qsSdk8kWeFx32tk9JK0x60j/PsfEGiIGncJYgfayMjsUf3aoz/edX/5OEjhFSn949r7g
 zWfY/Eo0Nhex5cIcf/6gfw0aFM0f1GZSaC6exGV5GPt/tRXhNgTM9QbBD+iiwJZMV0QD
 twng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696730629; x=1697335429;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=0E3O02TsYGrUY7+SquBNTbmmvpDSZCrNXmTk6Jo0VpY=;
 b=ehz28Z4RKqnuB0siNOAZcLYlIm2GIxT6CC1sd5z6f81UZ3YF+S8ACwdIT/LxJaaKI8
 GusThKoMRh07rPSTBOo/lW/3lWFVyYN+NlRAO3I2Pm9rh7ne4ZqWlLbhyiEqYwyB+mZe
 mbuJeaPXGjtRNrPpISt+vWXeyxUhpV9EUdeKJiLykca7gM5aRn0lcCq75hJcc498ITUz
 4BcDHFHU9a54iFcoHs58QTUMC4jIclcB9MeC0qJoglBOzmSjf3Yt2s7+5Qrf2cvrsZqm
 FVn+J4Pdl4onDK0Uh3vIHR4dlbufPzVS2GDcdL9BbnTt4iUghICFwqclt+U/AOGGwWpT
 CGgQ==
X-Gm-Message-State: AOJu0Yyi5EcvlJgSbA9t+TvOVYubg5eV9JXWGf3QcsFroIdkyPxZvak0
 5cOAoGvV8LrLQX21w2MAXklNmufdk4CIQnpJnms=
X-Google-Smtp-Source: AGHT+IGdpawFPUy1Fb1BxxBKz5C3EEABsOTPIQ5VFMpIS+JAydTa4e+xN5isJ+hvww/5ecAmYMwCo6ygcJT0BdtTxig=
X-Received: by 2002:a05:6512:38cd:b0:504:2730:40cc with SMTP id
 p13-20020a05651238cd00b00504273040ccmr7664967lft.49.1696730629046; Sat, 07
 Oct 2023 19:03:49 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1693287885.git.yin31149@gmail.com>
 <0e2af3ed5695a8044877911df791417fe0ba87af.1693287885.git.yin31149@gmail.com>
 <CAJaqyWfQq+cKU5+uJvq2iAVDOmLMbKjBHdMiAiJeA2tWFKuu1Q@mail.gmail.com>
In-Reply-To: <CAJaqyWfQq+cKU5+uJvq2iAVDOmLMbKjBHdMiAiJeA2tWFKuu1Q@mail.gmail.com>
From: Hawkins Jiawei <yin31149@gmail.com>
Date: Sun, 8 Oct 2023 10:03:37 +0800
Message-ID: <CAKrof1N9ZZOVaw45QUc+9YHe+jUnrMAVpEoYasDm+xcHjj6MLg@mail.gmail.com>
Subject: Re: [PATCH v4 7/8] vdpa: Introduce cursors to vhost_vdpa_net_loadx()
To: Eugenio Perez Martin <eperezma@redhat.com>
Cc: jasowang@redhat.com, mst@redhat.com, qemu-devel@nongnu.org, 
 leiyang@redhat.com, 18801353760@163.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::12a;
 envelope-from=yin31149@gmail.com; helo=mail-lf1-x12a.google.com
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

=E5=9C=A8 2023/10/4 15:21, Eugenio Perez Martin =E5=86=99=E9=81=93:
> On Tue, Aug 29, 2023 at 7:55=E2=80=AFAM Hawkins Jiawei <yin31149@gmail.co=
m> wrote:
>>
>> This patch introduces two new arugments, `out_cursor`
>> and `in_cursor`, to vhost_vdpa_net_loadx(). Addtionally,
>> it includes a helper function
>> vhost_vdpa_net_load_cursor_reset() for resetting these
>> cursors.
>>
>> Furthermore, this patch refactors vhost_vdpa_net_load_cmd()
>> so that vhost_vdpa_net_load_cmd() prepares buffers
>> for the device using the cursors arguments, instead
>> of directly accesses `s->cvq_cmd_out_buffer` and
>> `s->status` fields.
>>
>> By making these change, next patches in this series
>> can refactor vhost_vdpa_net_load_cmd() directly to
>> iterate through the control commands shadow buffers,
>> allowing QEMU to send CVQ state load commands in parallel
>> at device startup.
>>
>> Signed-off-by: Hawkins Jiawei <yin31149@gmail.com>
>> ---
>> v4:
>>    - use `struct iovec` instead of `void **` as cursor
>> suggested by Eugenio
>>    - add vhost_vdpa_net_load_cursor_reset() helper function
>> to reset the cursors
>>    - refactor vhost_vdpa_net_load_cmd() to prepare buffers
>> by iov_copy() instead of accessing `in` and `out` directly
>> suggested by Eugenio
>>
>> v3: https://lore.kernel.org/all/bf390934673f2b613359ea9d7ac6c89199c31384=
.1689748694.git.yin31149@gmail.com/
>>
>>   net/vhost-vdpa.c | 114 ++++++++++++++++++++++++++++++++---------------
>>   1 file changed, 77 insertions(+), 37 deletions(-)
>>
>> diff --git a/net/vhost-vdpa.c b/net/vhost-vdpa.c
>> index d9b8b3cf6c..a71e8c9090 100644
>> --- a/net/vhost-vdpa.c
>> +++ b/net/vhost-vdpa.c
>> @@ -633,7 +633,22 @@ static uint16_t vhost_vdpa_net_svq_available_slots(=
VhostVDPAState *s)
>>       return vhost_svq_available_slots(svq);
>>   }
>>
>> -static ssize_t vhost_vdpa_net_load_cmd(VhostVDPAState *s, uint8_t class=
,
>> +static void vhost_vdpa_net_load_cursor_reset(VhostVDPAState *s,
>> +                                             struct iovec *out_cursor,
>> +                                             struct iovec *in_cursor)
>> +{
>> +    /* reset the cursor of the output buffer for the device */
>> +    out_cursor->iov_base =3D s->cvq_cmd_out_buffer;
>> +    out_cursor->iov_len =3D vhost_vdpa_net_cvq_cmd_page_len();
>> +
>> +    /* reset the cursor of the in buffer for the device */
>> +    in_cursor->iov_base =3D s->status;
>> +    in_cursor->iov_len =3D vhost_vdpa_net_cvq_cmd_page_len();
>> +}
>> +
>> +static ssize_t vhost_vdpa_net_load_cmd(VhostVDPAState *s,
>> +                                       struct iovec *out_cursor,
>> +                                       struct iovec *in_cursor, uint8_t=
 class,
>>                                          uint8_t cmd, const struct iovec=
 *data_sg,
>>                                          size_t data_num)
>>   {
>> @@ -641,28 +656,25 @@ static ssize_t vhost_vdpa_net_load_cmd(VhostVDPASt=
ate *s, uint8_t class,
>>           .class =3D class,
>>           .cmd =3D cmd,
>>       };
>> -    size_t data_size =3D iov_size(data_sg, data_num);
>> -    /* Buffers for the device */
>> -    const struct iovec out =3D {
>> -        .iov_base =3D s->cvq_cmd_out_buffer,
>> -        .iov_len =3D sizeof(ctrl) + data_size,
>> -    };
>> -    const struct iovec in =3D {
>> -        .iov_base =3D s->status,
>> -        .iov_len =3D sizeof(*s->status),
>> -    };
>> +    size_t data_size =3D iov_size(data_sg, data_num),
>> +           cmd_size =3D sizeof(ctrl) + data_size;
>> +    struct iovec out, in;
>>       ssize_t r;
>>
>>       assert(data_size < vhost_vdpa_net_cvq_cmd_page_len() - sizeof(ctrl=
));
>>       /* Each CVQ command has one out descriptor and one in descriptor *=
/
>>       assert(vhost_vdpa_net_svq_available_slots(s) >=3D 2);
>>
>> -    /* pack the CVQ command header */
>> -    memcpy(s->cvq_cmd_out_buffer, &ctrl, sizeof(ctrl));
>> +    /* Prepare the buffer for out descriptor for the device */
>> +    iov_copy(&out, 1, out_cursor, 1, 0, cmd_size);
>
> I may be missing something here, but cmd_size should be the bytes
> available in "out", so we don't overrun it.
>
>> +    /* Prepare the buffer for in descriptor for the device. */
>> +    iov_copy(&in, 1, in_cursor, 1, 0, sizeof(*s->status));
>>
>
> Same here, although it is impossible for the moment to overrun it as
> all cmds only return one byte.
>

Here we just use iov_copy() to initialize the `out` and `in` variables,
something like:

/* extract the required buffer from the cursor for output */
out.iov_len =3D cmd_size;
out.iov_base =3D out_cursor->iov_base;
/* extract the required buffer from the cursor for input */
in.iov_len =3D sizeof(*s->status);
in.iov_base =3D in_cursor->iov_base;

I think iov_copy() can improve readability, what do you think?

>> +    /* pack the CVQ command header */
>> +    iov_from_buf(&out, 1, 0, &ctrl, sizeof(ctrl));
>>       /* pack the CVQ command command-specific-data */
>>       iov_to_buf(data_sg, data_num, 0,
>> -               s->cvq_cmd_out_buffer + sizeof(ctrl), data_size);
>> +               out.iov_base + sizeof(ctrl), data_size);
>
> Is it possible to replace this by:
> iov_to_buf(data_sg, data_num, sizeof(ctrl), out.iov_base, data_size)
>
> In other words, let iov_to_but handle the offset in the buffer instead
> of adding it manually.

It seems that iov_to_buf(const struct iovec *iov, const unsigned int
iov_cnt, size_t offset, void *buf, size_t bytes) is copying data
from `iov` starting at offset `offset` and with a length of `bytes`,
to buf starting at offset `0`.

Yet here we want to copy data from `data_sg` starting at offset `0`
and with a length of `data_size`, to `out.iov_base` starting at offset
`sizeof(ctrl)`, so I think we cannot replace this(Please correct me if I
am wrong).

Thanks!


>
> The rest looks good to me.
>
>>
>>       r =3D vhost_vdpa_net_cvq_add(s, &out, 1, &in, 1);
>>       if (unlikely(r < 0)) {
>> @@ -676,14 +688,17 @@ static ssize_t vhost_vdpa_net_load_cmd(VhostVDPASt=
ate *s, uint8_t class,
>>       return vhost_vdpa_net_svq_poll(s, 1);
>>   }
>>
>> -static int vhost_vdpa_net_load_mac(VhostVDPAState *s, const VirtIONet *=
n)
>> +static int vhost_vdpa_net_load_mac(VhostVDPAState *s, const VirtIONet *=
n,
>> +                                   struct iovec *out_cursor,
>> +                                   struct iovec *in_cursor)
>>   {
>>       if (virtio_vdev_has_feature(&n->parent_obj, VIRTIO_NET_F_CTRL_MAC_=
ADDR)) {
>>           const struct iovec data =3D {
>>               .iov_base =3D (void *)n->mac,
>>               .iov_len =3D sizeof(n->mac),
>>           };
>> -        ssize_t dev_written =3D vhost_vdpa_net_load_cmd(s, VIRTIO_NET_C=
TRL_MAC,
>> +        ssize_t dev_written =3D vhost_vdpa_net_load_cmd(s, out_cursor, =
in_cursor,
>> +                                                  VIRTIO_NET_CTRL_MAC,
>>                                                     VIRTIO_NET_CTRL_MAC_=
ADDR_SET,
>>                                                     &data, 1);
>>           if (unlikely(dev_written < 0)) {
>> @@ -735,7 +750,7 @@ static int vhost_vdpa_net_load_mac(VhostVDPAState *s=
, const VirtIONet *n)
>>               .iov_len =3D mul_macs_size,
>>           },
>>       };
>> -    ssize_t dev_written =3D vhost_vdpa_net_load_cmd(s,
>> +    ssize_t dev_written =3D vhost_vdpa_net_load_cmd(s, out_cursor, in_c=
ursor,
>>                                   VIRTIO_NET_CTRL_MAC,
>>                                   VIRTIO_NET_CTRL_MAC_TABLE_SET,
>>                                   data, ARRAY_SIZE(data));
>> @@ -750,7 +765,9 @@ static int vhost_vdpa_net_load_mac(VhostVDPAState *s=
, const VirtIONet *n)
>>   }
>>
>>   static int vhost_vdpa_net_load_mq(VhostVDPAState *s,
>> -                                  const VirtIONet *n)
>> +                                  const VirtIONet *n,
>> +                                  struct iovec *out_cursor,
>> +                                  struct iovec *in_cursor)
>>   {
>>       struct virtio_net_ctrl_mq mq;
>>       ssize_t dev_written;
>> @@ -764,7 +781,8 @@ static int vhost_vdpa_net_load_mq(VhostVDPAState *s,
>>           .iov_base =3D &mq,
>>           .iov_len =3D sizeof(mq),
>>       };
>> -    dev_written =3D vhost_vdpa_net_load_cmd(s, VIRTIO_NET_CTRL_MQ,
>> +    dev_written =3D vhost_vdpa_net_load_cmd(s, out_cursor, in_cursor,
>> +                                          VIRTIO_NET_CTRL_MQ,
>>                                             VIRTIO_NET_CTRL_MQ_VQ_PAIRS_=
SET,
>>                                             &data, 1);
>>       if (unlikely(dev_written < 0)) {
>> @@ -778,7 +796,9 @@ static int vhost_vdpa_net_load_mq(VhostVDPAState *s,
>>   }
>>
>>   static int vhost_vdpa_net_load_offloads(VhostVDPAState *s,
>> -                                        const VirtIONet *n)
>> +                                        const VirtIONet *n,
>> +                                        struct iovec *out_cursor,
>> +                                        struct iovec *in_cursor)
>>   {
>>       uint64_t offloads;
>>       ssize_t dev_written;
>> @@ -809,7 +829,8 @@ static int vhost_vdpa_net_load_offloads(VhostVDPASta=
te *s,
>>           .iov_base =3D &offloads,
>>           .iov_len =3D sizeof(offloads),
>>       };
>> -    dev_written =3D vhost_vdpa_net_load_cmd(s, VIRTIO_NET_CTRL_GUEST_OF=
FLOADS,
>> +    dev_written =3D vhost_vdpa_net_load_cmd(s, out_cursor, in_cursor,
>> +                                          VIRTIO_NET_CTRL_GUEST_OFFLOAD=
S,
>>                                             VIRTIO_NET_CTRL_GUEST_OFFLOA=
DS_SET,
>>                                             &data, 1);
>>       if (unlikely(dev_written < 0)) {
>> @@ -823,6 +844,8 @@ static int vhost_vdpa_net_load_offloads(VhostVDPASta=
te *s,
>>   }
>>
>>   static int vhost_vdpa_net_load_rx_mode(VhostVDPAState *s,
>> +                                       struct iovec *out_cursor,
>> +                                       struct iovec *in_cursor,
>>                                          uint8_t cmd,
>>                                          uint8_t on)
>>   {
>> @@ -832,7 +855,8 @@ static int vhost_vdpa_net_load_rx_mode(VhostVDPAStat=
e *s,
>>       };
>>       ssize_t dev_written;
>>
>> -    dev_written =3D vhost_vdpa_net_load_cmd(s, VIRTIO_NET_CTRL_RX,
>> +    dev_written =3D vhost_vdpa_net_load_cmd(s, out_cursor, in_cursor,
>> +                                          VIRTIO_NET_CTRL_RX,
>>                                             cmd, &data, 1);
>>       if (unlikely(dev_written < 0)) {
>>           return dev_written;
>> @@ -845,7 +869,9 @@ static int vhost_vdpa_net_load_rx_mode(VhostVDPAStat=
e *s,
>>   }
>>
>>   static int vhost_vdpa_net_load_rx(VhostVDPAState *s,
>> -                                  const VirtIONet *n)
>> +                                  const VirtIONet *n,
>> +                                  struct iovec *out_cursor,
>> +                                  struct iovec *in_cursor)
>>   {
>>       ssize_t r;
>>
>> @@ -872,7 +898,8 @@ static int vhost_vdpa_net_load_rx(VhostVDPAState *s,
>>        * configuration only at live migration.
>>        */
>>       if (!n->mac_table.uni_overflow && !n->promisc) {
>> -        r =3D vhost_vdpa_net_load_rx_mode(s, VIRTIO_NET_CTRL_RX_PROMISC=
, 0);
>> +        r =3D vhost_vdpa_net_load_rx_mode(s, out_cursor, in_cursor,
>> +                                        VIRTIO_NET_CTRL_RX_PROMISC, 0);
>>           if (unlikely(r < 0)) {
>>               return r;
>>           }
>> @@ -896,7 +923,8 @@ static int vhost_vdpa_net_load_rx(VhostVDPAState *s,
>>        * configuration only at live migration.
>>        */
>>       if (n->mac_table.multi_overflow || n->allmulti) {
>> -        r =3D vhost_vdpa_net_load_rx_mode(s, VIRTIO_NET_CTRL_RX_ALLMULT=
I, 1);
>> +        r =3D vhost_vdpa_net_load_rx_mode(s, out_cursor, in_cursor,
>> +                                        VIRTIO_NET_CTRL_RX_ALLMULTI, 1)=
;
>>           if (unlikely(r < 0)) {
>>               return r;
>>           }
>> @@ -917,7 +945,8 @@ static int vhost_vdpa_net_load_rx(VhostVDPAState *s,
>>        * configuration only at live migration.
>>        */
>>       if (n->alluni) {
>> -        r =3D vhost_vdpa_net_load_rx_mode(s, VIRTIO_NET_CTRL_RX_ALLUNI,=
 1);
>> +        r =3D vhost_vdpa_net_load_rx_mode(s, out_cursor, in_cursor,
>> +                                        VIRTIO_NET_CTRL_RX_ALLUNI, 1);
>>           if (r < 0) {
>>               return r;
>>           }
>> @@ -934,7 +963,8 @@ static int vhost_vdpa_net_load_rx(VhostVDPAState *s,
>>        * configuration only at live migration.
>>        */
>>       if (n->nomulti) {
>> -        r =3D vhost_vdpa_net_load_rx_mode(s, VIRTIO_NET_CTRL_RX_NOMULTI=
, 1);
>> +        r =3D vhost_vdpa_net_load_rx_mode(s, out_cursor, in_cursor,
>> +                                        VIRTIO_NET_CTRL_RX_NOMULTI, 1);
>>           if (r < 0) {
>>               return r;
>>           }
>> @@ -951,7 +981,8 @@ static int vhost_vdpa_net_load_rx(VhostVDPAState *s,
>>        * configuration only at live migration.
>>        */
>>       if (n->nouni) {
>> -        r =3D vhost_vdpa_net_load_rx_mode(s, VIRTIO_NET_CTRL_RX_NOUNI, =
1);
>> +        r =3D vhost_vdpa_net_load_rx_mode(s, out_cursor, in_cursor,
>> +                                        VIRTIO_NET_CTRL_RX_NOUNI, 1);
>>           if (r < 0) {
>>               return r;
>>           }
>> @@ -968,7 +999,8 @@ static int vhost_vdpa_net_load_rx(VhostVDPAState *s,
>>        * configuration only at live migration.
>>        */
>>       if (n->nobcast) {
>> -        r =3D vhost_vdpa_net_load_rx_mode(s, VIRTIO_NET_CTRL_RX_NOBCAST=
, 1);
>> +        r =3D vhost_vdpa_net_load_rx_mode(s, out_cursor, in_cursor,
>> +                                        VIRTIO_NET_CTRL_RX_NOBCAST, 1);
>>           if (r < 0) {
>>               return r;
>>           }
>> @@ -979,13 +1011,16 @@ static int vhost_vdpa_net_load_rx(VhostVDPAState =
*s,
>>
>>   static int vhost_vdpa_net_load_single_vlan(VhostVDPAState *s,
>>                                              const VirtIONet *n,
>> +                                           struct iovec *out_cursor,
>> +                                           struct iovec *in_cursor,
>>                                              uint16_t vid)
>>   {
>>       const struct iovec data =3D {
>>           .iov_base =3D &vid,
>>           .iov_len =3D sizeof(vid),
>>       };
>> -    ssize_t dev_written =3D vhost_vdpa_net_load_cmd(s, VIRTIO_NET_CTRL_=
VLAN,
>> +    ssize_t dev_written =3D vhost_vdpa_net_load_cmd(s, out_cursor, in_c=
ursor,
>> +                                                  VIRTIO_NET_CTRL_VLAN,
>>                                                     VIRTIO_NET_CTRL_VLAN=
_ADD,
>>                                                     &data, 1);
>>       if (unlikely(dev_written < 0)) {
>> @@ -999,7 +1034,9 @@ static int vhost_vdpa_net_load_single_vlan(VhostVDP=
AState *s,
>>   }
>>
>>   static int vhost_vdpa_net_load_vlan(VhostVDPAState *s,
>> -                                    const VirtIONet *n)
>> +                                    const VirtIONet *n,
>> +                                    struct iovec *out_cursor,
>> +                                    struct iovec *in_cursor)
>>   {
>>       int r;
>>
>> @@ -1010,7 +1047,8 @@ static int vhost_vdpa_net_load_vlan(VhostVDPAState=
 *s,
>>       for (int i =3D 0; i < MAX_VLAN >> 5; i++) {
>>           for (int j =3D 0; n->vlans[i] && j <=3D 0x1f; j++) {
>>               if (n->vlans[i] & (1U << j)) {
>> -                r =3D vhost_vdpa_net_load_single_vlan(s, n, (i << 5) + =
j);
>> +                r =3D vhost_vdpa_net_load_single_vlan(s, n, out_cursor,
>> +                                                    in_cursor, (i << 5)=
 + j);
>>                   if (unlikely(r !=3D 0)) {
>>                       return r;
>>                   }
>> @@ -1027,6 +1065,7 @@ static int vhost_vdpa_net_load(NetClientState *nc)
>>       struct vhost_vdpa *v =3D &s->vhost_vdpa;
>>       const VirtIONet *n;
>>       int r;
>> +    struct iovec out_cursor, in_cursor;
>>
>>       assert(nc->info->type =3D=3D NET_CLIENT_DRIVER_VHOST_VDPA);
>>
>> @@ -1035,23 +1074,24 @@ static int vhost_vdpa_net_load(NetClientState *n=
c)
>>       }
>>
>>       n =3D VIRTIO_NET(v->dev->vdev);
>> -    r =3D vhost_vdpa_net_load_mac(s, n);
>> +    vhost_vdpa_net_load_cursor_reset(s, &out_cursor, &in_cursor);
>> +    r =3D vhost_vdpa_net_load_mac(s, n, &out_cursor, &in_cursor);
>>       if (unlikely(r < 0)) {
>>           return r;
>>       }
>> -    r =3D vhost_vdpa_net_load_mq(s, n);
>> +    r =3D vhost_vdpa_net_load_mq(s, n, &out_cursor, &in_cursor);
>>       if (unlikely(r)) {
>>           return r;
>>       }
>> -    r =3D vhost_vdpa_net_load_offloads(s, n);
>> +    r =3D vhost_vdpa_net_load_offloads(s, n, &out_cursor, &in_cursor);
>>       if (unlikely(r)) {
>>           return r;
>>       }
>> -    r =3D vhost_vdpa_net_load_rx(s, n);
>> +    r =3D vhost_vdpa_net_load_rx(s, n, &out_cursor, &in_cursor);
>>       if (unlikely(r)) {
>>           return r;
>>       }
>> -    r =3D vhost_vdpa_net_load_vlan(s, n);
>> +    r =3D vhost_vdpa_net_load_vlan(s, n, &out_cursor, &in_cursor);
>>       if (unlikely(r)) {
>>           return r;
>>       }
>> --
>> 2.25.1
>>
>


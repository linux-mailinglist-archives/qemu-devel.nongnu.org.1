Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id EF646747D83
	for <lists+qemu-devel@lfdr.de>; Wed,  5 Jul 2023 08:52:56 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qGwMI-0000AY-3q; Wed, 05 Jul 2023 02:51:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yin31149@gmail.com>)
 id 1qGwLz-00009z-Rr
 for qemu-devel@nongnu.org; Wed, 05 Jul 2023 02:51:11 -0400
Received: from mail-lj1-x22e.google.com ([2a00:1450:4864:20::22e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <yin31149@gmail.com>)
 id 1qGwLx-0005oM-E4
 for qemu-devel@nongnu.org; Wed, 05 Jul 2023 02:51:07 -0400
Received: by mail-lj1-x22e.google.com with SMTP id
 38308e7fff4ca-2b6ef64342aso34622151fa.3
 for <qemu-devel@nongnu.org>; Tue, 04 Jul 2023 23:51:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1688539859; x=1691131859;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LCcUqCuE7q6z3+paQ5HqqAwK2q2eKAKDbZlCVuHOWgo=;
 b=NnS7g3e97UikSiggEz+HJHKnKVSq2JXw/JOiM+YayM5M86TKZEO6JmWL5RIs0/6j0F
 VZTR6v6RTKrxaXQz9v4/xQOSd+rbJNxRVbFSB4Y8h8/0OGckiOvzhxmjMg009qTtSl0B
 fVLpgGSDbF6pQsJxWk4lVqvRY4qFNMtH6LTNGwrXMVv/i/CsBjp/YkYXp8l19OAS+xpD
 tcc0kb8aAsUKSGBhs0uJ9V1ajoB1+fRfYRq/p9iRhxrNZyROBl35MdNpjDeB1u+l0Uyh
 iSZn+OT6d2t0kK1RRrhpEdcyEmV0hYyzmUfiAbuUxtdn+TftEgSSlrET4QxXAResp2PK
 wtyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688539859; x=1691131859;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=LCcUqCuE7q6z3+paQ5HqqAwK2q2eKAKDbZlCVuHOWgo=;
 b=iUmkS5sgEkSSKuALlAzjpWJWhroCxMRvelYpgAf49Zk/MrMNAE4WFWNPW8AU5+cBsg
 1gviIil8n2DLxA6aBuVNfGcqnNd1+bbtl2JKEhm9NvKA0HXL0zEemrY8wS4ua5CHTwAL
 2MkPwTxNcHfgWMKio8GBZIEIGxHCOchA9v+Gw7oy3VzXx89ff7Zw7ocJnZUcDK8Ige5n
 +KC2Nnl1PI01SCq4s83KWjJR+WgWBGjkmTD3AM5wxqps4/Usx5LecpfoltZtBKIvAzEd
 2OyYYAIwtkaGN972Jjvpu5DldlTW9tjdx75tWrqvnM663PxJsnyih9dSJg+2gA4TWUzh
 zYgQ==
X-Gm-Message-State: ABy/qLZXK0k0dXNTLn83FPbhzajMpP30MJYBztuKQBWgNKHvXhB8CQqD
 Q85FbdJbsiSNHlhyD+GaeU+RqmjF5tKG71jAH1M=
X-Google-Smtp-Source: APBJJlFOua918uGyt/StWFuxtA5HA1MU7jSyqaaiYD2WA1VpQOLgdvEBm3vy7HioofanFsXOM653xXkozK0cmjtdbM8=
X-Received: by 2002:a2e:9d4e:0:b0:2b6:d8cf:2f44 with SMTP id
 y14-20020a2e9d4e000000b002b6d8cf2f44mr7823656ljj.13.1688539858443; Tue, 04
 Jul 2023 23:50:58 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1688051252.git.yin31149@gmail.com>
 <d9d7641ef25d7a4477f8fc4df8cba026380dab76.1688051252.git.yin31149@gmail.com>
 <CAJaqyWefjZ1-Z08GR8f8kvwxPihEqpzJK17hDnO7wkGx+pCaCw@mail.gmail.com>
 <CAKrof1ODXvY-8U5zSQcFfKyaoSHTVJ6h5wFkxzZfTebmp5X7Rw@mail.gmail.com>
 <CAJaqyWc5QkdWY6K-4SFZq0489S113J=HKH4G3Z_WcwFTiE-YPA@mail.gmail.com>
In-Reply-To: <CAJaqyWc5QkdWY6K-4SFZq0489S113J=HKH4G3Z_WcwFTiE-YPA@mail.gmail.com>
From: Hawkins Jiawei <yin31149@gmail.com>
Date: Wed, 5 Jul 2023 14:50:46 +0800
Message-ID: <CAKrof1Ox-=LCGOYXFmv2O=zpVrwxuv-Ydn7qE7JrT8KzEmVtEw@mail.gmail.com>
Subject: Re: [PATCH RFC v2 3/4] vdpa: Restore packet receive filtering state
 relative with _F_CTRL_RX feature
To: Eugenio Perez Martin <eperezma@redhat.com>
Cc: jasowang@redhat.com, mst@redhat.com, qemu-devel@nongnu.org, 
 18801353760@163.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::22e;
 envelope-from=yin31149@gmail.com; helo=mail-lj1-x22e.google.com
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

On 2023/7/5 14:40, Eugenio Perez Martin wrote:
> On Wed, Jul 5, 2023 at 4:09=E2=80=AFAM Hawkins Jiawei <yin31149@gmail.com=
> wrote:
>>
>> On 2023/7/4 23:39, Eugenio Perez Martin wrote:
>>> On Thu, Jun 29, 2023 at 5:26=E2=80=AFPM Hawkins Jiawei <yin31149@gmail.=
com> wrote:
>>>>
>>>> This patch introduces vhost_vdpa_net_load_rx_mode()
>>>> and vhost_vdpa_net_load_rx() to restore the packet
>>>> receive filtering state in relation to
>>>> VIRTIO_NET_F_CTRL_RX feature at device's startup.
>>>>
>>>> Signed-off-by: Hawkins Jiawei <yin31149@gmail.com>
>>>> ---
>>>> v2:
>>>>     - avoid sending CVQ command in default state suggested by Eugenio
>>>>
>>>> v1: https://lore.kernel.org/all/86eeddcd6f6b04e5c1e44e901ddea3b1b8b6c1=
83.1687402580.git.yin31149@gmail.com/
>>>>
>>>>    net/vhost-vdpa.c | 104 ++++++++++++++++++++++++++++++++++++++++++++=
+++
>>>>    1 file changed, 104 insertions(+)
>>>>
>>>> diff --git a/net/vhost-vdpa.c b/net/vhost-vdpa.c
>>>> index cb45c84c88..9d5d88756c 100644
>>>> --- a/net/vhost-vdpa.c
>>>> +++ b/net/vhost-vdpa.c
>>>> @@ -792,6 +792,106 @@ static int vhost_vdpa_net_load_offloads(VhostVDP=
AState *s,
>>>>        return 0;
>>>>    }
>>>>
>>>> +static int vhost_vdpa_net_load_rx_mode(VhostVDPAState *s,
>>>> +                                       uint8_t cmd,
>>>> +                                       uint8_t on)
>>>> +{
>>>> +    ssize_t dev_written;
>>>> +    const struct iovec data =3D {
>>>> +        .iov_base =3D &on,
>>>> +        .iov_len =3D sizeof(on),
>>>> +    };
>>>> +    dev_written =3D vhost_vdpa_net_load_cmd(s, VIRTIO_NET_CTRL_RX,
>>>> +                                          cmd, &data, 1);
>>>> +    if (unlikely(dev_written < 0)) {
>>>> +        return dev_written;
>>>> +    }
>>>> +    if (*s->status !=3D VIRTIO_NET_OK) {
>>>> +        return -EINVAL;
>>>> +    }
>>>> +
>>>> +    return 0;
>>>> +}
>>>> +
>>>> +static int vhost_vdpa_net_load_rx(VhostVDPAState *s,
>>>> +                                  const VirtIONet *n)
>>>> +{
>>>> +    uint8_t on;
>>>> +    int r;
>>>> +
>>>> +    if (virtio_vdev_has_feature(&n->parent_obj, VIRTIO_NET_F_CTRL_RX)=
) {
>>>
>>> Also suggesting early returns here.
>>
>> So, for CVQ commands related to VIRTIO_NET_F_CTRL_EXTRA_RX, would it be
>> more appropriate to create a new function, maybe
>> vhost_vdpa_net_load_rx_extra, to handle them instead of sending those
>> CVQ commands within this function, if we choose to return early?
>>
>
> My understanding is that VIRTIO_NET_F_CTRL_RX_EXTRA depends on
> VIRTIO_NET_F_CTRL_RX, so we can do:
>
> if (!virtio_vdev_has_feature(&n->parent_obj, VIRTIO_NET_F_CTRL_RX)) {
>    return;
> }
>
> // Process CTRL_RX commands
>
> if (!virtio_vdev_has_feature(&n->parent_obj, VIRTIO_NET_F_CTRL_RX)) {
>    return;
> }
>
> // process CTRL_RX_EXTRA commands

Thanks for your explanation, it makes sense.

I will send the v3 patch based on your suggestion.

Thanks!


>
>>>
>>>> +        /* Load the promiscous mode */
>>>> +        if (n->mac_table.uni_overflow) {
>>>> +            /*
>>>> +             * According to VirtIO standard, "Since there are no guar=
antees,
>>>> +             * it can use a hash filter or silently switch to
>>>> +             * allmulti or promiscuous mode if it is given too many a=
ddresses."
>>>> +             *
>>>> +             * QEMU ignores non-multicast(unicast) MAC addresses and
>>>> +             * marks `uni_overflow` for the device internal state
>>>> +             * if guest sets too many non-multicast(unicast) MAC addr=
esses.
>>>> +             * Therefore, we should turn promiscous mode on in this c=
ase.
>>>> +             */
>>>> +            on =3D 1;
>>>> +        } else {
>>>> +            on =3D n->promisc;
>>>> +        }
>>>
>>> I think we can remove the "on" variable and just do:
>>>
>>> /*
>>>    * According to ...
>>>    */
>>> if (n->mac_table.uni_overflow || n->promisc) {
>>>     r =3D vhost_vdpa_net_load_rx_mode(s, VIRTIO_NET_CTRL_RX_PROMISC, on=
);
>>>     if (r < 0) {
>>>       return r;
>>>     }
>>> ---
>>>
>>> And the equivalent for multicast.
>>>
>>> Would that make sense?
>>
>> Yes, I will refactor these according to your suggestion.
>>
>> Thanks!
>>
>>
>>>
>>> Thanks!
>>>
>>>> +        if (on !=3D 1) {
>>>> +            /*
>>>> +             * According to virtio_net_reset(), device turns promiscu=
ous mode on
>>>> +             * by default.
>>>> +             *
>>>> +             * Therefore, there is no need to send this CVQ command i=
f the
>>>> +             * driver also sets promiscuous mode on, which aligns wit=
h
>>>> +             * the device's defaults.
>>>> +             *
>>>> +             * Note that the device's defaults can mismatch the drive=
r's
>>>> +             * configuration only at live migration.
>>>> +             */
>>>> +            r =3D vhost_vdpa_net_load_rx_mode(s, VIRTIO_NET_CTRL_RX_P=
ROMISC, on);
>>>> +            if (r < 0) {
>>>> +                return r;
>>>> +            }
>>>> +        }
>>>> +
>>>> +        /* Load the all-multicast mode */
>>>> +        if (n->mac_table.multi_overflow) {
>>>> +            /*
>>>> +             * According to VirtIO standard, "Since there are no guar=
antees,
>>>> +             * it can use a hash filter or silently switch to
>>>> +             * allmulti or promiscuous mode if it is given too many a=
ddresses."
>>>> +             *
>>>> +             * QEMU ignores multicast MAC addresses and
>>>> +             * marks `multi_overflow` for the device internal state
>>>> +             * if guest sets too many multicast MAC addresses.
>>>> +             * Therefore, we should turn all-multicast mode on in thi=
s case.
>>>> +             */
>>>> +            on =3D 1;
>>>> +        } else {
>>>> +            on =3D n->allmulti;
>>>> +        }
>>>> +        if (on !=3D 0) {
>>>> +            /*
>>>> +             * According to virtio_net_reset(), device turns all-mult=
icast mode
>>>> +             * off by default.
>>>> +             *
>>>> +             * Therefore, there is no need to send this CVQ command i=
f the
>>>> +             * driver also sets all-multicast mode off, which aligns =
with
>>>> +             * the device's defaults.
>>>> +             *
>>>> +             * Note that the device's defaults can mismatch the drive=
r's
>>>> +             * configuration only at live migration.
>>>> +             */
>>>> +            r =3D vhost_vdpa_net_load_rx_mode(s, VIRTIO_NET_CTRL_RX_A=
LLMULTI, on);
>>>> +            if (r < 0) {
>>>> +                return r;
>>>> +            }
>>>> +        }
>>>> +    }
>>>> +
>>>> +    return 0;
>>>> +}
>>>> +
>>>>    static int vhost_vdpa_net_load(NetClientState *nc)
>>>>    {
>>>>        VhostVDPAState *s =3D DO_UPCAST(VhostVDPAState, nc, nc);
>>>> @@ -818,6 +918,10 @@ static int vhost_vdpa_net_load(NetClientState *nc=
)
>>>>        if (unlikely(r)) {
>>>>            return r;
>>>>        }
>>>> +    r =3D vhost_vdpa_net_load_rx(s, n);
>>>> +    if (unlikely(r)) {
>>>> +        return r;
>>>> +    }
>>>>
>>>>        return 0;
>>>>    }
>>>> --
>>>> 2.25.1
>>>>
>>>
>>
>


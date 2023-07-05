Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F902747B65
	for <lists+qemu-devel@lfdr.de>; Wed,  5 Jul 2023 04:10:08 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qGrx2-0003Zt-Iz; Tue, 04 Jul 2023 22:09:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yin31149@gmail.com>)
 id 1qGrx0-0003Zf-TP
 for qemu-devel@nongnu.org; Tue, 04 Jul 2023 22:09:02 -0400
Received: from mail-lf1-x129.google.com ([2a00:1450:4864:20::129])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <yin31149@gmail.com>)
 id 1qGrwy-0007OE-Lc
 for qemu-devel@nongnu.org; Tue, 04 Jul 2023 22:09:02 -0400
Received: by mail-lf1-x129.google.com with SMTP id
 2adb3069b0e04-4f9fdb0ef35so9981728e87.0
 for <qemu-devel@nongnu.org>; Tue, 04 Jul 2023 19:09:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1688522938; x=1691114938;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Lf7YBHGl8cgVDiGsGm19ct/xlDRLsNXD+G8+wVO7e90=;
 b=i5dszBuBa6yuSBN9368BvGWygLcUP0bgVRrQi5jn8s7SVzrVCzZITc9qWGd1FKxX4Q
 g2+rJaMXvenpdpHTdmS7GhFhiyu/cxmi1P5Z9u92ga9lml3Srrdi/OCBGHopwB3lkZRL
 xPiV03wog+W9PmuZIwd8ZlTWABMhWTCB4O8bQ0RZ2g33WQO60cx29DBwbfsFkGQ3ERcZ
 QOmfdeoo1MCYEAEnu6zSzxKiDcMZ+SZzayWYBq3rEAE/F7C3yuBE4AwdLh3QD8hjUhr7
 SdUTr2E59oy61HZz/Lehx5BKWkzdBgI9ghpWe3moj8nzdaviG7WVGQY88IXhSbeGJzyC
 QT5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688522938; x=1691114938;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Lf7YBHGl8cgVDiGsGm19ct/xlDRLsNXD+G8+wVO7e90=;
 b=HlZKXIcF3Yvg9vAZVOksZio6dknnIGyUr1vUx/3tgUVCPoyun71KHrRIXKFFLJxVF7
 1rtNXgiiGu8so4UBK6f8KQ0Zg6Gm0LOYA5Z/AMcGmy8DTPhEHhxnKwJ1S6aD8WQsddeo
 6x+lNTVYZYSu1vKxq+gu8JBKVVkMKgsLkE7udPTfog5UTCoy12aRAv6URGN5VCvO+o2c
 Lmb9FNNQapEeFEWAhhxq6TZHssB/SmmYKFzvFQsE8cqkRmcroUfH3284a21vI8HUN/SS
 zh3ZnDSpbxUFrE51W0wFTKQNpQ1jL7h5yC8G/Q87lOxXrPtALN2ZT49hlY8yh+f/4VRt
 3+rA==
X-Gm-Message-State: ABy/qLYW31/SfadzqPSz77uHKYzFDmK1y7+Zhg0PFLPqKf5XOE/ZCvzY
 xkiKsq/Xm9+AuFhLHAXEywU3Zg95deMxR9axfsA=
X-Google-Smtp-Source: APBJJlGMrAsmqq4e6kE2NKxkO3HT4GgZCdhLvcknmKuhnwhdbaoHvXCzSmCZ8NP5yzKWTRLLL8kPLLlwZidaUNzlT18=
X-Received: by 2002:a2e:7a0f:0:b0:2b5:81bc:43a8 with SMTP id
 v15-20020a2e7a0f000000b002b581bc43a8mr9098451ljc.0.1688522938041; Tue, 04 Jul
 2023 19:08:58 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1688051252.git.yin31149@gmail.com>
 <d9d7641ef25d7a4477f8fc4df8cba026380dab76.1688051252.git.yin31149@gmail.com>
 <CAJaqyWefjZ1-Z08GR8f8kvwxPihEqpzJK17hDnO7wkGx+pCaCw@mail.gmail.com>
In-Reply-To: <CAJaqyWefjZ1-Z08GR8f8kvwxPihEqpzJK17hDnO7wkGx+pCaCw@mail.gmail.com>
From: Hawkins Jiawei <yin31149@gmail.com>
Date: Wed, 5 Jul 2023 10:08:44 +0800
Message-ID: <CAKrof1ODXvY-8U5zSQcFfKyaoSHTVJ6h5wFkxzZfTebmp5X7Rw@mail.gmail.com>
Subject: Re: [PATCH RFC v2 3/4] vdpa: Restore packet receive filtering state
 relative with _F_CTRL_RX feature
To: Eugenio Perez Martin <eperezma@redhat.com>
Cc: jasowang@redhat.com, mst@redhat.com, qemu-devel@nongnu.org, 
 18801353760@163.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::129;
 envelope-from=yin31149@gmail.com; helo=mail-lf1-x129.google.com
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

On 2023/7/4 23:39, Eugenio Perez Martin wrote:
> On Thu, Jun 29, 2023 at 5:26=E2=80=AFPM Hawkins Jiawei <yin31149@gmail.co=
m> wrote:
>>
>> This patch introduces vhost_vdpa_net_load_rx_mode()
>> and vhost_vdpa_net_load_rx() to restore the packet
>> receive filtering state in relation to
>> VIRTIO_NET_F_CTRL_RX feature at device's startup.
>>
>> Signed-off-by: Hawkins Jiawei <yin31149@gmail.com>
>> ---
>> v2:
>>    - avoid sending CVQ command in default state suggested by Eugenio
>>
>> v1: https://lore.kernel.org/all/86eeddcd6f6b04e5c1e44e901ddea3b1b8b6c183=
.1687402580.git.yin31149@gmail.com/
>>
>>   net/vhost-vdpa.c | 104 +++++++++++++++++++++++++++++++++++++++++++++++
>>   1 file changed, 104 insertions(+)
>>
>> diff --git a/net/vhost-vdpa.c b/net/vhost-vdpa.c
>> index cb45c84c88..9d5d88756c 100644
>> --- a/net/vhost-vdpa.c
>> +++ b/net/vhost-vdpa.c
>> @@ -792,6 +792,106 @@ static int vhost_vdpa_net_load_offloads(VhostVDPAS=
tate *s,
>>       return 0;
>>   }
>>
>> +static int vhost_vdpa_net_load_rx_mode(VhostVDPAState *s,
>> +                                       uint8_t cmd,
>> +                                       uint8_t on)
>> +{
>> +    ssize_t dev_written;
>> +    const struct iovec data =3D {
>> +        .iov_base =3D &on,
>> +        .iov_len =3D sizeof(on),
>> +    };
>> +    dev_written =3D vhost_vdpa_net_load_cmd(s, VIRTIO_NET_CTRL_RX,
>> +                                          cmd, &data, 1);
>> +    if (unlikely(dev_written < 0)) {
>> +        return dev_written;
>> +    }
>> +    if (*s->status !=3D VIRTIO_NET_OK) {
>> +        return -EINVAL;
>> +    }
>> +
>> +    return 0;
>> +}
>> +
>> +static int vhost_vdpa_net_load_rx(VhostVDPAState *s,
>> +                                  const VirtIONet *n)
>> +{
>> +    uint8_t on;
>> +    int r;
>> +
>> +    if (virtio_vdev_has_feature(&n->parent_obj, VIRTIO_NET_F_CTRL_RX)) =
{
>
> Also suggesting early returns here.

So, for CVQ commands related to VIRTIO_NET_F_CTRL_EXTRA_RX, would it be
more appropriate to create a new function, maybe
vhost_vdpa_net_load_rx_extra, to handle them instead of sending those
CVQ commands within this function, if we choose to return early?

>
>> +        /* Load the promiscous mode */
>> +        if (n->mac_table.uni_overflow) {
>> +            /*
>> +             * According to VirtIO standard, "Since there are no guaran=
tees,
>> +             * it can use a hash filter or silently switch to
>> +             * allmulti or promiscuous mode if it is given too many add=
resses."
>> +             *
>> +             * QEMU ignores non-multicast(unicast) MAC addresses and
>> +             * marks `uni_overflow` for the device internal state
>> +             * if guest sets too many non-multicast(unicast) MAC addres=
ses.
>> +             * Therefore, we should turn promiscous mode on in this cas=
e.
>> +             */
>> +            on =3D 1;
>> +        } else {
>> +            on =3D n->promisc;
>> +        }
>
> I think we can remove the "on" variable and just do:
>
> /*
>   * According to ...
>   */
> if (n->mac_table.uni_overflow || n->promisc) {
>    r =3D vhost_vdpa_net_load_rx_mode(s, VIRTIO_NET_CTRL_RX_PROMISC, on);
>    if (r < 0) {
>      return r;
>    }
> ---
>
> And the equivalent for multicast.
>
> Would that make sense?

Yes, I will refactor these according to your suggestion.

Thanks!


>
> Thanks!
>
>> +        if (on !=3D 1) {
>> +            /*
>> +             * According to virtio_net_reset(), device turns promiscuou=
s mode on
>> +             * by default.
>> +             *
>> +             * Therefore, there is no need to send this CVQ command if =
the
>> +             * driver also sets promiscuous mode on, which aligns with
>> +             * the device's defaults.
>> +             *
>> +             * Note that the device's defaults can mismatch the driver'=
s
>> +             * configuration only at live migration.
>> +             */
>> +            r =3D vhost_vdpa_net_load_rx_mode(s, VIRTIO_NET_CTRL_RX_PRO=
MISC, on);
>> +            if (r < 0) {
>> +                return r;
>> +            }
>> +        }
>> +
>> +        /* Load the all-multicast mode */
>> +        if (n->mac_table.multi_overflow) {
>> +            /*
>> +             * According to VirtIO standard, "Since there are no guaran=
tees,
>> +             * it can use a hash filter or silently switch to
>> +             * allmulti or promiscuous mode if it is given too many add=
resses."
>> +             *
>> +             * QEMU ignores multicast MAC addresses and
>> +             * marks `multi_overflow` for the device internal state
>> +             * if guest sets too many multicast MAC addresses.
>> +             * Therefore, we should turn all-multicast mode on in this =
case.
>> +             */
>> +            on =3D 1;
>> +        } else {
>> +            on =3D n->allmulti;
>> +        }
>> +        if (on !=3D 0) {
>> +            /*
>> +             * According to virtio_net_reset(), device turns all-multic=
ast mode
>> +             * off by default.
>> +             *
>> +             * Therefore, there is no need to send this CVQ command if =
the
>> +             * driver also sets all-multicast mode off, which aligns wi=
th
>> +             * the device's defaults.
>> +             *
>> +             * Note that the device's defaults can mismatch the driver'=
s
>> +             * configuration only at live migration.
>> +             */
>> +            r =3D vhost_vdpa_net_load_rx_mode(s, VIRTIO_NET_CTRL_RX_ALL=
MULTI, on);
>> +            if (r < 0) {
>> +                return r;
>> +            }
>> +        }
>> +    }
>> +
>> +    return 0;
>> +}
>> +
>>   static int vhost_vdpa_net_load(NetClientState *nc)
>>   {
>>       VhostVDPAState *s =3D DO_UPCAST(VhostVDPAState, nc, nc);
>> @@ -818,6 +918,10 @@ static int vhost_vdpa_net_load(NetClientState *nc)
>>       if (unlikely(r)) {
>>           return r;
>>       }
>> +    r =3D vhost_vdpa_net_load_rx(s, n);
>> +    if (unlikely(r)) {
>> +        return r;
>> +    }
>>
>>       return 0;
>>   }
>> --
>> 2.25.1
>>
>


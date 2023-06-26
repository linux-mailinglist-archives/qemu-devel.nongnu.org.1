Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id EE0ED73DA8D
	for <lists+qemu-devel@lfdr.de>; Mon, 26 Jun 2023 10:53:52 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qDhxV-0004Rd-02; Mon, 26 Jun 2023 04:52:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yin31149@gmail.com>)
 id 1qDhxS-0004RS-UX
 for qemu-devel@nongnu.org; Mon, 26 Jun 2023 04:52:27 -0400
Received: from mail-lf1-x12a.google.com ([2a00:1450:4864:20::12a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <yin31149@gmail.com>)
 id 1qDhxR-0001dJ-6Z
 for qemu-devel@nongnu.org; Mon, 26 Jun 2023 04:52:26 -0400
Received: by mail-lf1-x12a.google.com with SMTP id
 2adb3069b0e04-4f4b2bc1565so3860229e87.2
 for <qemu-devel@nongnu.org>; Mon, 26 Jun 2023 01:52:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1687769543; x=1690361543;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hDyFjI1ipPTHLurTQQ6I8hgMru94cue9xilZ9PDHnjo=;
 b=nYiSiVsDX7iJrvajgua7BxH6mfzKpHRzyQY2rG/Ug+KAlrrLeSWU2/BR+0sTeR2gfF
 EY6ToE6F3T3Yog8kL08sGILuCCA0AQqXfZFKZUWWc4rSC21FMG7l1EzVgxArT/zxkJZE
 mh5WZ0SkcaEfqPYWPzJtPEf0rBdbGr86yCgkvDEh0sMN7K4pDU9UzZ5Q8TCJsfHT4o8a
 xg54WFr7IvIQmoy8xejiykHl1HeVYL64pfSq47X/ZXvR2WXbeeJj1fgOQO49BLua/iPp
 pfQ6pnC4S2qHT0yxrmraK1YIToCRBMYouKzhHmpgZm1mUr1MoSvxxh6qmhcyoBRhWTgy
 Vjww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687769543; x=1690361543;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=hDyFjI1ipPTHLurTQQ6I8hgMru94cue9xilZ9PDHnjo=;
 b=ERjfB43ngHfhuVRl1SM3ZETHz0CKCwsOEbM+i5q6LINEDH86VOtpLE2+2yojKuZtjM
 5gko8mQea2AHn2C/4urro6LpKaREz+tyW9CI/3CUa9bDrntU2X/XrWgpTm2kfJzzce3u
 J1z8D+HNIYleo78iI3ZwgDyDYlFEfQVp5iVbN6ZCD28xjYsxd8Roxe2cc8OrWMXdYDxZ
 iO5yVzpS7oJw7aPcib/WhXQQ341cof+voOKGvX/+F2nt3pC04wxD6aLRop7ii6DEul8O
 6eREN5TVFj1MBXOs5drfPi/HkBbLSqpHuzrln9uCT1eZKtTJ+tfxEtC1OgxjZYktC800
 TavQ==
X-Gm-Message-State: AC+VfDwcWs2+z/3dBKFoW0tmMTgE9xDp+oFWERkDzz1sc40sReHz4Ost
 46Hp0Tx3HRz3Bb8cgQOx3IJnDaJ0/2rr/StJOds=
X-Google-Smtp-Source: ACHHUZ6/Ab1nhgpFJdA9BBrtGZNA01bjXqj2+Ta9empCAeaIkjUdNMMKvZY/b0+waow3ac1zcFPExu85KMYEt4IvHoc=
X-Received: by 2002:a2e:8887:0:b0:2b4:8239:b12d with SMTP id
 k7-20020a2e8887000000b002b48239b12dmr12028374lji.0.1687769542959; Mon, 26 Jun
 2023 01:52:22 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1687402580.git.yin31149@gmail.com>
 <86eeddcd6f6b04e5c1e44e901ddea3b1b8b6c183.1687402580.git.yin31149@gmail.com>
 <CAJaqyWcERYv=qFD9Aefmcr4yTZd8HzFp37Guxhvtfo9zCcoexw@mail.gmail.com>
In-Reply-To: <CAJaqyWcERYv=qFD9Aefmcr4yTZd8HzFp37Guxhvtfo9zCcoexw@mail.gmail.com>
From: Hawkins Jiawei <yin31149@gmail.com>
Date: Mon, 26 Jun 2023 16:52:11 +0800
Message-ID: <CAKrof1Ohw5W1u4Gc7WSstBjFGPFPAMYaJFg6waNqxdXTMUUgPg@mail.gmail.com>
Subject: Re: [PATCH RFC 2/3] vdpa: Restore packet receive filtering state
 relative with _F_CTRL_RX feature
To: Eugenio Perez Martin <eperezma@redhat.com>
Cc: jasowang@redhat.com, mst@redhat.com, qemu-devel@nongnu.org, 
 18801353760@163.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::12a;
 envelope-from=yin31149@gmail.com; helo=mail-lf1-x12a.google.com
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

On 2023/6/25 18:56, Eugenio Perez Martin wrote:
> On Thu, Jun 22, 2023 at 5:02=E2=80=AFAM Hawkins Jiawei <yin31149@gmail.co=
m> wrote:
>>
>> This patch introduces vhost_vdpa_net_load_rx_mode()
>> and vhost_vdpa_net_load_rx() to restore the packet
>> receive filtering state in relation to
>> VIRTIO_NET_F_CTRL_RX feature at device's startup.
>>
>> Signed-off-by: Hawkins Jiawei <yin31149@gmail.com>
>> ---
>>   net/vhost-vdpa.c | 74 ++++++++++++++++++++++++++++++++++++++++++++++++
>>   1 file changed, 74 insertions(+)
>>
>> diff --git a/net/vhost-vdpa.c b/net/vhost-vdpa.c
>> index 10264d3e96..355a6aef15 100644
>> --- a/net/vhost-vdpa.c
>> +++ b/net/vhost-vdpa.c
>> @@ -754,6 +754,76 @@ static int vhost_vdpa_net_load_offloads(VhostVDPASt=
ate *s,
>>       return *s->status !=3D VIRTIO_NET_OK;
>>   }
>>
>> +static int vhost_vdpa_net_load_rx_mode(VhostVDPAState *s,
>> +                                       uint8_t cmd,
>> +                                       uint8_t on)
>> +{
>> +    ssize_t dev_written;
>> +    dev_written =3D vhost_vdpa_net_load_cmd(s, VIRTIO_NET_CTRL_RX,
>> +                                          cmd, &on, sizeof(on));
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
>> +        r =3D vhost_vdpa_net_load_rx_mode(s, VIRTIO_NET_CTRL_RX_PROMISC=
, on);
>> +        if (r < 0) {
>> +            return r;
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
>> +        r =3D vhost_vdpa_net_load_rx_mode(s, VIRTIO_NET_CTRL_RX_ALLMULT=
I, on);
>> +        if (r < 0) {
>> +            return r;
>> +        }
>
> Can we skip the sending of the CVQ commands if the state matches the
> default state?

Thanks for your reminder, I forgot this part when coding. I will
refactor the patch according to your suggestion and take care of it in
the following patches for this part.

Thanks!


>
> Thanks!
>
>> +    }
>> +
>> +    return 0;
>> +}
>> +
>>   static int vhost_vdpa_net_load(NetClientState *nc)
>>   {
>>       VhostVDPAState *s =3D DO_UPCAST(VhostVDPAState, nc, nc);
>> @@ -780,6 +850,10 @@ static int vhost_vdpa_net_load(NetClientState *nc)
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


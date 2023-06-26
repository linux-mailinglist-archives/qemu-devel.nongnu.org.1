Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 85E5873DA98
	for <lists+qemu-devel@lfdr.de>; Mon, 26 Jun 2023 10:56:18 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qDi0M-0005dm-Mj; Mon, 26 Jun 2023 04:55:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yin31149@gmail.com>)
 id 1qDi0F-0005bq-Vx
 for qemu-devel@nongnu.org; Mon, 26 Jun 2023 04:55:20 -0400
Received: from mail-lj1-x22c.google.com ([2a00:1450:4864:20::22c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <yin31149@gmail.com>)
 id 1qDi0E-0002Uz-BC
 for qemu-devel@nongnu.org; Mon, 26 Jun 2023 04:55:19 -0400
Received: by mail-lj1-x22c.google.com with SMTP id
 38308e7fff4ca-2b699a2fe86so19023421fa.3
 for <qemu-devel@nongnu.org>; Mon, 26 Jun 2023 01:55:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1687769717; x=1690361717;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PwOlu3mF8DL56CvR+20cGi+jit2mkZ6CIwUq6JJjUEA=;
 b=qXe/fgLkDTR9Gh9o+Qf5+/QbzHGsULcka4R1fK5x3yeEgyf8MKTWktedWNdrBJ+d2O
 WYjLjOcAgkZxxr1FsATcwCJC2dWK5YOidd17rZehAQ59ie6j5m0BcLnSmYqr2Ks8593B
 wP+rik0lzUk3qv9tX0oFmI35q5i3hNEd7n6n8JwgID91AQsbepJIbPoUIIwe+RfXqgiw
 2WbhjV/lSrlKQzyY6zx8qZIrmXKeh/5DhXD00iuDU52Bwz6850rhcZyz5+TLx11VyfL6
 bGXB9hG3ax7sQGpMTV9hXAvIgJHEH/OROiwWVIfPzCt4IBHov6VjCOYkT4FWeCu3HcvD
 d+tA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687769717; x=1690361717;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=PwOlu3mF8DL56CvR+20cGi+jit2mkZ6CIwUq6JJjUEA=;
 b=EG7fKTtATkC1TRh9d+oFCGYq4nRGAXc+Cro33HpeIhIoOoyFQj6Zmc80Jt5eNPGbs7
 Zx3O0tx31OBESO+9KfanZfLoBh9PiWez92lbGESqiqyUHs+mrxUb0SEzYtJ6FDyP9uuG
 PdFqXZGQV1vfVebqq8sRUQm6umbxByzaM7INCRDGyChaWWqwdKwuPeAmVq2QVfA5n4Vx
 cv+R3vyQpXKGzkLfOaGBeZ2LBTLgRcPc679DOGLYqgO5vFGbKLaC/iE3krrbcMhGek0G
 7DnSIJhGuKvJTMv1vX4lLgKH60c0NLfp+7C90zmtGO1jYuB0cVqT+ABR1ed2XfUd9HNW
 7FPg==
X-Gm-Message-State: AC+VfDwvZvLLSU53dad/DKYEnpS2NuVT7g8CWFd0Uv25pMrWZFAmkwAV
 8yUM/rfh6XpV3GP71zuAU1K83n4xaxBLk8/mL50=
X-Google-Smtp-Source: ACHHUZ6gAY5Gi1ycjmM8rRkLtGFEmdWha07ZvfttSkD8fcySJK23wZfMuGcRc4DkhvK4Bol6jRme7UJ929iH/AgpgHo=
X-Received: by 2002:a2e:9213:0:b0:2b4:82e5:e4e8 with SMTP id
 k19-20020a2e9213000000b002b482e5e4e8mr12769764ljg.11.1687769716453; Mon, 26
 Jun 2023 01:55:16 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1687524532.git.yin31149@gmail.com>
 <e88a774a47c19ca85ae838b30b75dac549446f5b.1687524532.git.yin31149@gmail.com>
 <CAJaqyWdZgsEs9QWf8a5p5EOYBAnQYRS-gMaQrAeddAuAEmp+Vw@mail.gmail.com>
In-Reply-To: <CAJaqyWdZgsEs9QWf8a5p5EOYBAnQYRS-gMaQrAeddAuAEmp+Vw@mail.gmail.com>
From: Hawkins Jiawei <yin31149@gmail.com>
Date: Mon, 26 Jun 2023 16:55:04 +0800
Message-ID: <CAKrof1OhqsGp_tQbJxvHHs7pkBZveX3pzdiAkQ=vMYJJhNqe8g@mail.gmail.com>
Subject: Re: [PATCH RFC 1/2] vdpa: Restore packet receive filtering state
 relative with _F_CTRL_RX_EXTRA feature
To: Eugenio Perez Martin <eperezma@redhat.com>
Cc: jasowang@redhat.com, mst@redhat.com, qemu-devel@nongnu.org, 
 18801353760@163.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::22c;
 envelope-from=yin31149@gmail.com; helo=mail-lj1-x22c.google.com
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

On 2023/6/25 18:54, Eugenio Perez Martin wrote:
> On Fri, Jun 23, 2023 at 3:26=E2=80=AFPM Hawkins Jiawei <yin31149@gmail.co=
m> wrote:
>>
>> This patch refactors vhost_vdpa_net_load_rx() to
>> restore the packet receive filtering state in relation to
>> VIRTIO_NET_F_CTRL_RX_EXTRA feature at device's startup.
>>
>> Signed-off-by: Hawkins Jiawei <yin31149@gmail.com>
>> ---
>>   net/vhost-vdpa.c | 30 ++++++++++++++++++++++++++++++
>>   1 file changed, 30 insertions(+)
>>
>> diff --git a/net/vhost-vdpa.c b/net/vhost-vdpa.c
>> index ca800f97e2..9b929762c5 100644
>> --- a/net/vhost-vdpa.c
>> +++ b/net/vhost-vdpa.c
>> @@ -822,6 +822,36 @@ static int vhost_vdpa_net_load_rx(VhostVDPAState *s=
,
>>           }
>>       }
>>
>> +    if (virtio_vdev_has_feature(&n->parent_obj, VIRTIO_NET_F_CTRL_RX_EX=
TRA)) {
>> +        /* Load the all-unicast mode */
>> +        on =3D n->alluni;
>> +        r =3D vhost_vdpa_net_load_rx_mode(s, VIRTIO_NET_CTRL_RX_ALLUNI,=
 on);
>> +        if (r < 0) {
>> +            return r;
>> +        }
>> +
>> +        /* Load the non-multicast mode */
>> +        on =3D n->nomulti;
>> +        r =3D vhost_vdpa_net_load_rx_mode(s, VIRTIO_NET_CTRL_RX_NOMULTI=
, on);
>> +        if (r < 0) {
>> +            return r;
>> +        }
>> +
>> +        /* Load the non-unicast mode */
>> +        on =3D n->nouni;
>> +        r =3D vhost_vdpa_net_load_rx_mode(s, VIRTIO_NET_CTRL_RX_NOUNI, =
on);
>> +        if (r < 0) {
>> +            return r;
>> +        }
>> +
>> +        /* Load the non-broadcast mode */
>> +        on =3D n->nobcast;
>> +        r =3D vhost_vdpa_net_load_rx_mode(s, VIRTIO_NET_CTRL_RX_NOBCAST=
, on);
>> +        if (r < 0) {
>> +            return r;
>> +        }
>> +    }
>> +
>
> Can we skip the load if the state matches the virtio defaults? by
> virtio_net_reset the defaults are:
>      n->promisc =3D 1;
>      n->allmulti =3D 0;
>      n->alluni =3D 0;
>      n->nomulti =3D 0;
>      n->nouni =3D 0;
>      n->nobcast =3D 0;

Yes, you are right.

Thanks for your reminder, I forgot this part when coding. I will
refactor the patch according to your suggestion and take care of it in
the following patches for this part.

Thanks!


>
> Thanks!
>
>>       return 0;
>>   }
>>
>> --
>> 2.25.1
>>
>


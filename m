Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AE1175CA87
	for <lists+qemu-devel@lfdr.de>; Fri, 21 Jul 2023 16:49:48 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qMrR7-00025V-82; Fri, 21 Jul 2023 10:48:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yin31149@gmail.com>)
 id 1qMrR2-000232-3U
 for qemu-devel@nongnu.org; Fri, 21 Jul 2023 10:48:48 -0400
Received: from mail-lj1-x22a.google.com ([2a00:1450:4864:20::22a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <yin31149@gmail.com>)
 id 1qMrQu-0004W2-BI
 for qemu-devel@nongnu.org; Fri, 21 Jul 2023 10:48:44 -0400
Received: by mail-lj1-x22a.google.com with SMTP id
 38308e7fff4ca-2b702319893so30370721fa.3
 for <qemu-devel@nongnu.org>; Fri, 21 Jul 2023 07:48:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1689950916; x=1690555716;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=AqcrE03/Oa6EkZMNQ82L5x1u/ymHF1OOI51FNjj29WQ=;
 b=CJ7Ndo9+GGt/2vkxXbsKsmDayzWRFQa5KPfzWLDyyx+c/rdu+9nsv6kTY2qadCdk7j
 huPHltEiOpgNUIywEbmGwdJxS+J64VyFsk+Jd+JM2PmpbZFtTKLH9ymX6qFes5WLuSbH
 yej/iy1zHFBW2htvMA/jOah+7vTtl+xp2c8xU7ZAWHHupHM2T5JHIsxoM4Zk652omc8P
 U5sDHcjwBpCQpnw7yNxVJz3GxKCfhjVXszGxw+414nMT6zgnS+0cSHHLlXnenDKJ+QN6
 Nq+a28FKFrMwwwEGMOQMoKmiFaeOv9nhiwPZ1yl/O2nh+qGNYiSyksr1SX4joJDcxTYW
 TAxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689950916; x=1690555716;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=AqcrE03/Oa6EkZMNQ82L5x1u/ymHF1OOI51FNjj29WQ=;
 b=TaJ8xHRvNtuvAhQmPMFY6p5CqQNlwW3sECvGhUJ3Ql89O69UOb6u7p7ARq5HQzVVJu
 zGab6H4769dgAr7r91quWcBT9rLTCMzKvVplBotylpMYogdGrKFw3uLou0EQ9PHUhQD4
 95szG/buj/0BZtTTkwb7WbrKJnzFcERovNPpsCzEoVlzDh583SSfog1iw2QUPPUIEVWq
 o9WQxRnMh+BLLAE6jjrCiABcEJQrt74+2dH9zdqV3XtTgJYk9gqxMiUrPVQt01nbKzmc
 jXCMQIq0H9c12UEuC48bWOOvusVcXfL7Isswf64DhGPGqd0kn0pjawCdkN6KRJIXwe5+
 aDqg==
X-Gm-Message-State: ABy/qLagFQHbk2B/MpLzopw9pv7MHtClRit88Z+hSBsxTBtA4ww3y0Yv
 nWJv3wuv+XAnT0kBo6yfD4czh+9ypuF+G2QTBFaWFTM1kYjuwM/4UUI=
X-Google-Smtp-Source: APBJJlEX8ycov3eztBJiY5E65X+VR4g1fKbZ4udUljJZ4oniC50HXE6dJ5k34hMImYOzPnAnG1PKGODoYWqfQCYidDc=
X-Received: by 2002:a2e:90da:0:b0:2b6:a22b:42dc with SMTP id
 o26-20020a2e90da000000b002b6a22b42dcmr1727105ljg.16.1689950915781; Fri, 21
 Jul 2023 07:48:35 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1689690854.git.yin31149@gmail.com>
 <0a568cc8a8d2b750c2e09b2237e9f05cece07c3f.1689690854.git.yin31149@gmail.com>
 <CAJaqyWf1ZP6G91skDx4rai=xArkdvPZj8g3-UXC2dHc0iUN3-w@mail.gmail.com>
In-Reply-To: <CAJaqyWf1ZP6G91skDx4rai=xArkdvPZj8g3-UXC2dHc0iUN3-w@mail.gmail.com>
From: Hawkins Jiawei <yin31149@gmail.com>
Date: Fri, 21 Jul 2023 22:48:24 +0800
Message-ID: <CAKrof1O8_9Rrq3ZK-tJOEd_HniKQP7d2T19oHxBce+UZU9=bmA@mail.gmail.com>
Subject: Re: [PATCH 3/4] vdpa: Restore vlan filtering state
To: Eugenio Perez Martin <eperezma@redhat.com>
Cc: jasowang@redhat.com, mst@redhat.com, qemu-devel@nongnu.org, 
 18801353760@163.com
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

On 2023/7/21 19:57, Eugenio Perez Martin wrote:
> On Wed, Jul 19, 2023 at 9:48=E2=80=AFAM Hawkins Jiawei <yin31149@gmail.co=
m> wrote:
>>
>> This patch introduces vhost_vdpa_net_load_single_vlan()
>> and vhost_vdpa_net_load_vlan() to restore the vlan
>> filtering state at device's startup.
>>
>> Co-developed-by: Eugenio P=C3=A9rez <eperezma@redhat.com>
>> Signed-off-by: Eugenio P=C3=A9rez <eperezma@redhat.com>
>> Signed-off-by: Hawkins Jiawei <yin31149@gmail.com>
>> ---
>>   net/vhost-vdpa.c | 49 ++++++++++++++++++++++++++++++++++++++++++++++++
>>   1 file changed, 49 insertions(+)
>>
>> diff --git a/net/vhost-vdpa.c b/net/vhost-vdpa.c
>> index 9795306742..0787dd933b 100644
>> --- a/net/vhost-vdpa.c
>> +++ b/net/vhost-vdpa.c
>> @@ -965,6 +965,51 @@ static int vhost_vdpa_net_load_rx(VhostVDPAState *s=
,
>>       return 0;
>>   }
>>
>> +static int vhost_vdpa_net_load_single_vlan(VhostVDPAState *s,
>> +                                           const VirtIONet *n,
>> +                                           uint16_t vid)
>> +{
>> +    const struct iovec data =3D {
>> +        .iov_base =3D &vid,
>> +        .iov_len =3D sizeof(vid),
>> +    };
>> +    ssize_t dev_written =3D vhost_vdpa_net_load_cmd(s, VIRTIO_NET_CTRL_=
VLAN,
>> +                                                  VIRTIO_NET_CTRL_VLAN_=
ADD,
>> +                                                  &data, 1);
>> +    if (unlikely(dev_written < 0)) {
>> +        return dev_written;
>> +    }
>> +    if (unlikely(*s->status !=3D VIRTIO_NET_OK)) {
>> +        return -EIO;
>> +    }
>> +
>> +    return 0;
>> +}
>> +
>> +static int vhost_vdpa_net_load_vlan(VhostVDPAState *s,
>> +                                    const VirtIONet *n)
>> +{
>> +    int r;
>> +
>> +    if (!virtio_vdev_has_feature(&n->parent_obj, VIRTIO_NET_F_CTRL_VLAN=
)) {
>> +        return 0;
>> +    }
>> +
>> +    for (int i =3D 0; i < MAX_VLAN >> 5; i++) {
>> +        for (int j =3D 0; n->vlans[i] && j <=3D 0x1f; j++) {
>> +            if (n->vlans[i] & (1U << j)) {
>> +                r =3D vhost_vdpa_net_load_single_vlan(s, n, (i << 5) + =
j);
>> +                if (unlikely(r !=3D 0)) {
>> +                    return r;
>> +                }
>> +            }
>> +        }
>> +    }
>> +
>> +    return 0;
>> +}
>> +
>> +
>
> Nit: I'm not sure if it was here originally, but there is an extra newlin=
e here.

Hi Eugenio,

It was not here originally, it was introduced mistakenly during the
refactoring process.

I will fix this in the v2 version.

Thanks!


>
>>   static int vhost_vdpa_net_load(NetClientState *nc)
>>   {
>>       VhostVDPAState *s =3D DO_UPCAST(VhostVDPAState, nc, nc);
>> @@ -995,6 +1040,10 @@ static int vhost_vdpa_net_load(NetClientState *nc)
>>       if (unlikely(r)) {
>>           return r;
>>       }
>> +    r =3D vhost_vdpa_net_load_vlan(s, n);
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


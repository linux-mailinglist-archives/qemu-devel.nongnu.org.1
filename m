Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FFEC717A01
	for <lists+qemu-devel@lfdr.de>; Wed, 31 May 2023 10:25:28 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q4H7j-0002Cg-64; Wed, 31 May 2023 04:24:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yin31149@gmail.com>)
 id 1q4H71-000296-3M
 for qemu-devel@nongnu.org; Wed, 31 May 2023 04:23:19 -0400
Received: from mail-lj1-x22b.google.com ([2a00:1450:4864:20::22b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <yin31149@gmail.com>)
 id 1q4H6z-0001Ak-Gs
 for qemu-devel@nongnu.org; Wed, 31 May 2023 04:23:18 -0400
Received: by mail-lj1-x22b.google.com with SMTP id
 38308e7fff4ca-2af2f4e719eso59664871fa.2
 for <qemu-devel@nongnu.org>; Wed, 31 May 2023 01:23:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1685521394; x=1688113394;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=UWSl2T+RsIMIDZTMfiY16nPRYxLwaxdxhl/NAn9nvJs=;
 b=m+3/PYawCxlqRpm13AX/ogYVug+/AbOu7BYAbfosTqxp+J0h5sMKDKKUovZQTpAQio
 R/z7+0yMAAxKhu6ClDkSjHqMjWOYYPhu5HVotZB29RlGu3JR5GlWXvJ9tS8xqwpI1sSu
 efsR345btSdnjcvTyOFCJeNCdidh1wBmP1dfPPGctqkuMFJtfxmf/qmMuHG92trdcoww
 /0/Y/VeZlPlLE1PO52dyoAt3drHqjNKme7IgyDBP/zWSdV+d1RfeIFAyuBuDQ6f39VuF
 Rms0WFbHICR5CL5kYG1YKpl6IBqSiq6VAEvanc6FAfVZHq0xFYvWFSLmG7GmZN2hSEFv
 ZbUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685521394; x=1688113394;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=UWSl2T+RsIMIDZTMfiY16nPRYxLwaxdxhl/NAn9nvJs=;
 b=Q1l3n3KOPIUokM2t5Ky32GFBR6AGwK83nSAdlmu89cnBNE4kAVWGDhjA66qXpeS61V
 GkZv6zl4Q82RtUnxu3srZvuFRUD5wYrBxE7eLXY5egmJ5pkqbgsN3ddlKCLGjzowlgPk
 rYXpSZdqMRub4+wVzVq8KMQBpju+hYtkdV75yNmDu3QBE9ZsMaHzCfAXAnDaSSHXHsPv
 Ol+E2xdNoC+tP3lTvJpehphCKUSb9/amIUSSzA3vWd50azJQXLYnK/T2MYs5/8hOy3Hj
 3REiCcSBcyyt/p7LhM2omwdYjgj3c5seQNsHDoHcVaBO7nigm6BSGg4khjxe9T9CRC8T
 un4Q==
X-Gm-Message-State: AC+VfDwBCQCpovm+OATJYljmvvRzIi9sBN8eW6J3X41j96c3vbI6WYnW
 N0QwM3Y+jC6LiYgrI5OPtLTvj9G4cFzH8WPYIzM=
X-Google-Smtp-Source: ACHHUZ4BggfyQMBRHwNT2wZpEiF/1W+VgTsJGSAKij/G8XK6+sXTFWNAnO6X5vmx3K64UmgIpo3xB9yn4qI2mlJBRi4=
X-Received: by 2002:a2e:9d15:0:b0:2a8:a859:b5c7 with SMTP id
 t21-20020a2e9d15000000b002a8a859b5c7mr1876702lji.0.1685521393770; Wed, 31 May
 2023 01:23:13 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1685359572.git.yin31149@gmail.com>
 <ab861a8237c5e337bb0f969e1e8e761bc73901d5.1685359572.git.yin31149@gmail.com>
 <CAJaqyWcURXY7GxM2goKHp55pfb-pCjOSYfDwzjsXbtSP1SnSkg@mail.gmail.com>
In-Reply-To: <CAJaqyWcURXY7GxM2goKHp55pfb-pCjOSYfDwzjsXbtSP1SnSkg@mail.gmail.com>
From: Hawkins Jiawei <yin31149@gmail.com>
Date: Wed, 31 May 2023 16:23:02 +0800
Message-ID: <CAKrof1Njyuf5aeA4bX6Z1ryzq6dVK7AFVxrHUfEBi+94ymYNHQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] vdpa: Add vhost_vdpa_net_load_offloads
To: Eugenio Perez Martin <eperezma@redhat.com>
Cc: Jason Wang <jasowang@redhat.com>, 18801353760@163.com,
 qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::22b;
 envelope-from=yin31149@gmail.com; helo=mail-lj1-x22b.google.com
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

On 2023/5/30 0:19, Eugenio Perez Martin wrote:
> On Mon, May 29, 2023 at 3:18=E2=80=AFPM Hawkins Jiawei <yin31149@gmail.co=
m> wrote:
>>
>> This patch introduces vhost_vdpa_net_load_offloads() to
>> restore offloads state at device's startup.
>>
>> Signed-off-by: Hawkins Jiawei <yin31149@gmail.com>
>> ---
>>   net/vhost-vdpa.c | 26 ++++++++++++++++++++++++++
>>   1 file changed, 26 insertions(+)
>>
>> diff --git a/net/vhost-vdpa.c b/net/vhost-vdpa.c
>> index 37cdc84562..682c749b19 100644
>> --- a/net/vhost-vdpa.c
>> +++ b/net/vhost-vdpa.c
>> @@ -680,6 +680,28 @@ static int vhost_vdpa_net_load_mq(VhostVDPAState *s=
,
>>       return *s->status !=3D VIRTIO_NET_OK;
>>   }
>>
>> +static int vhost_vdpa_net_load_offloads(VhostVDPAState *s,
>> +                                        const VirtIONet *n)
>> +{
>> +    uint64_t features, offloads;
>> +    ssize_t dev_written;
>> +
>> +    features =3D n->parent_obj.guest_features;
>> +    if (!(features & BIT_ULL(VIRTIO_NET_F_CTRL_GUEST_OFFLOADS))) {
>> +        return 0;
>> +    }
>> +
>
> Maybe we can avoid sending this CVQ command if the guest already uses
> the default values?

Hi Eugenio,

Thanks for the review. However, I'm curious why we don't need to send
this CVQ command if the guest is using the default values. Is it because
the device automatically applies these default offloads, when the
VIRTIO_NET_F_CTRL_GUEST_OFFLOADS feature is negotiated and QEMU doesn't
send the CVQ command?

Thanks!


>
> By default all features are enabled if I'm not wrong. I think the best
> way is to expose virtio_net_supported_guest_offloads or
> virtio_net_guest_offloads_by_features and then check if
> n->curr_guest_offloads is the same.
>
> We should do the same with vhost_vdpa_net_load_mq, but that is out of
> the scope of this series.
>
> Thanks!
>
>> +    offloads =3D cpu_to_le64(n->curr_guest_offloads);
>> +    dev_written =3D vhost_vdpa_net_load_cmd(s, VIRTIO_NET_CTRL_GUEST_OF=
FLOADS,
>> +                                          VIRTIO_NET_CTRL_GUEST_OFFLOAD=
S_SET,
>> +                                          &offloads, sizeof(offloads));
>> +    if (unlikely(dev_written < 0)) {
>> +        return dev_written;
>> +    }
>> +
>> +    return *s->status !=3D VIRTIO_NET_OK;
>> +}
>> +
>>   static int vhost_vdpa_net_load(NetClientState *nc)
>>   {
>>       VhostVDPAState *s =3D DO_UPCAST(VhostVDPAState, nc, nc);
>> @@ -702,6 +724,10 @@ static int vhost_vdpa_net_load(NetClientState *nc)
>>       if (unlikely(r)) {
>>           return r;
>>       }
>> +    r =3D vhost_vdpa_net_load_offloads(s, n);
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


Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id F3E46717A10
	for <lists+qemu-devel@lfdr.de>; Wed, 31 May 2023 10:28:58 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q4HC1-0003BX-S2; Wed, 31 May 2023 04:28:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yin31149@gmail.com>)
 id 1q4HB4-00038P-JE
 for qemu-devel@nongnu.org; Wed, 31 May 2023 04:27:30 -0400
Received: from mail-lj1-x22c.google.com ([2a00:1450:4864:20::22c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <yin31149@gmail.com>)
 id 1q4HB2-00023H-SI
 for qemu-devel@nongnu.org; Wed, 31 May 2023 04:27:30 -0400
Received: by mail-lj1-x22c.google.com with SMTP id
 38308e7fff4ca-2af2c35fb85so57311521fa.3
 for <qemu-devel@nongnu.org>; Wed, 31 May 2023 01:27:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1685521646; x=1688113646;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=yEYMmSplVeZmQPJzU1gG0HJPgCKD+VeE/dndVc5oJBk=;
 b=C2ySPR/+XgoHGclxYO6tQ4RAW3PMLbfJNbJzmmAJFFZBc30O+dX5DcF9OK/9Ydkl69
 y9so2lJWZb3mn1YSLFpfZ3KiBFHdTUvuM79Wi2yvu2X3+SLMXdb0w0KT375SK0KjAsR5
 lBjh/jFCuyTlWULjkIZIrmi8MkpN1zOK/rHLZFPPwa8KFCxorAmEXFbORO13jxrQUnYL
 9fVrSuF3xqD1QQxcqXPqPVcfys4pA48g9FX9V3djX4iFsGMXbw49tVrCyEXMZxTYtVZ8
 NXkFm8w8kIDafNlF9sMqTUzcPRt3i0ezikF7SkvT+cWjLKVP9utwiWv1sjbgfjrWTmw5
 7QdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685521646; x=1688113646;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=yEYMmSplVeZmQPJzU1gG0HJPgCKD+VeE/dndVc5oJBk=;
 b=kXnEdjG+xOAjzM1KptGxifKNy+yE3WY2PF1WpLBHdXAV31Z8c2pT+FKUWi6NZgZk2x
 NAoaEkX6KGSS7DXMZrjR3674vVdDgYLbArligPKoBbAKTB49uPWCROaaBX+vaPubByJg
 lwRXZSArZozRVid3mrKq2nQNkTP7aK9moZ7FoVYg9yFZzankVNuUDnpTitP6FJxE0FaA
 j5ZDav1hkZLDhgDYvmMogrtGJFMnOB23cuCUNLwL+QwqvRvhdNA+oqowafeZcyAuyeCY
 +pDPUWVcdLk9OYAJivMDA6a0cMBQvivIes0eBmgCXMB85weOy/6/f4V2Vf0eSxzWF8Gm
 QzrA==
X-Gm-Message-State: AC+VfDwicaeKu9FrCOfJ/48SjalBFzTLKaarWQeLabmufvHXDqZ92Mq0
 dYW1f31omBydK3SW45wWWCqWB/+EBRDL6VPPt1U=
X-Google-Smtp-Source: ACHHUZ798jbdMw7Xqu7cPVLSaoQfA+OzzA2fFNDJ8NtbwGRAzi1+ybzhZ44i8x7P3SLQRD6VtS1zhnZhBEldxZCi150=
X-Received: by 2002:a2e:9ed3:0:b0:2af:20c9:3f8a with SMTP id
 h19-20020a2e9ed3000000b002af20c93f8amr1949407ljk.7.1685521645727; Wed, 31 May
 2023 01:27:25 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1685359572.git.yin31149@gmail.com>
 <ab861a8237c5e337bb0f969e1e8e761bc73901d5.1685359572.git.yin31149@gmail.com>
 <CACGkMEvza0nAWqbQ1-KiLGRRxSxYvJoTrtTgUPV-KQpSuJFB6g@mail.gmail.com>
 <CAJaqyWe7e4OAZU+-i73OQ76QtM3Kv0V0LrfCMEjgnNmMH=TGZQ@mail.gmail.com>
In-Reply-To: <CAJaqyWe7e4OAZU+-i73OQ76QtM3Kv0V0LrfCMEjgnNmMH=TGZQ@mail.gmail.com>
From: Hawkins Jiawei <yin31149@gmail.com>
Date: Wed, 31 May 2023 16:27:14 +0800
Message-ID: <CAKrof1P36+86fkrs66tZ2zxGbnZOorj+WBmQa-LUQVmkoxu5XA@mail.gmail.com>
Subject: Re: [PATCH 1/2] vdpa: Add vhost_vdpa_net_load_offloads
To: Eugenio Perez Martin <eperezma@redhat.com>,
 Jason Wang <jasowang@redhat.com>
Cc: 18801353760@163.com, qemu-devel@nongnu.org
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

On 2023/5/31 14:37, Eugenio Perez Martin wrote:
> On Wed, May 31, 2023 at 3:47=E2=80=AFAM Jason Wang <jasowang@redhat.com> =
wrote:
>>
>> On Mon, May 29, 2023 at 9:18=E2=80=AFPM Hawkins Jiawei <yin31149@gmail.c=
om> wrote:
>>>
>>> This patch introduces vhost_vdpa_net_load_offloads() to
>>> restore offloads state at device's startup.
>>>
>>> Signed-off-by: Hawkins Jiawei <yin31149@gmail.com>
>>> ---
>>>   net/vhost-vdpa.c | 26 ++++++++++++++++++++++++++
>>>   1 file changed, 26 insertions(+)
>>>
>>> diff --git a/net/vhost-vdpa.c b/net/vhost-vdpa.c
>>> index 37cdc84562..682c749b19 100644
>>> --- a/net/vhost-vdpa.c
>>> +++ b/net/vhost-vdpa.c
>>> @@ -680,6 +680,28 @@ static int vhost_vdpa_net_load_mq(VhostVDPAState *=
s,
>>>       return *s->status !=3D VIRTIO_NET_OK;
>>>   }
>>>
>>> +static int vhost_vdpa_net_load_offloads(VhostVDPAState *s,
>>> +                                        const VirtIONet *n)
>>> +{
>>> +    uint64_t features, offloads;
>>> +    ssize_t dev_written;
>>> +
>>> +    features =3D n->parent_obj.guest_features;
>>
>> Any reason you need to do tricks like this instead of using
>> virtio_xxx_has_features()?
>>
>
> It can be replaced by virtio_vdev_has_feature, yes.
>
> Current code of vhost_vdpa_net_load_mac and vhost_vdpa_net_load_mq
> access to guest_features directly too, so I think we should change all
> of them at once.

Yes, I agree with you and Jason.

I will refactor the patch as you and Jason have suggested.

Thanks!


>
> Thanks!
>
>>> +    if (!(features & BIT_ULL(VIRTIO_NET_F_CTRL_GUEST_OFFLOADS))) {
>>> +        return 0;
>>> +    }
>>> +
>>> +    offloads =3D cpu_to_le64(n->curr_guest_offloads);
>>> +    dev_written =3D vhost_vdpa_net_load_cmd(s, VIRTIO_NET_CTRL_GUEST_O=
FFLOADS,
>>> +                                          VIRTIO_NET_CTRL_GUEST_OFFLOA=
DS_SET,
>>> +                                          &offloads, sizeof(offloads))=
;
>>> +    if (unlikely(dev_written < 0)) {
>>> +        return dev_written;
>>> +    }
>>> +
>>> +    return *s->status !=3D VIRTIO_NET_OK;
>>> +}
>>> +
>>>   static int vhost_vdpa_net_load(NetClientState *nc)
>>>   {
>>>       VhostVDPAState *s =3D DO_UPCAST(VhostVDPAState, nc, nc);
>>> @@ -702,6 +724,10 @@ static int vhost_vdpa_net_load(NetClientState *nc)
>>>       if (unlikely(r)) {
>>>           return r;
>>>       }
>>> +    r =3D vhost_vdpa_net_load_offloads(s, n);
>>> +    if (unlikely(r)) {
>>> +        return r;
>>> +    }
>>>
>>>       return 0;
>>>   }
>>> --
>>> 2.25.1
>>>
>>
>


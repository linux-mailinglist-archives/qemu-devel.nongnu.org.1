Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3751673DA00
	for <lists+qemu-devel@lfdr.de>; Mon, 26 Jun 2023 10:40:50 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qDhlo-0001NP-Sg; Mon, 26 Jun 2023 04:40:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yin31149@gmail.com>)
 id 1qDhlm-0001N0-9Y
 for qemu-devel@nongnu.org; Mon, 26 Jun 2023 04:40:22 -0400
Received: from mail-lj1-x232.google.com ([2a00:1450:4864:20::232])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <yin31149@gmail.com>)
 id 1qDhlk-0007Ct-CX
 for qemu-devel@nongnu.org; Mon, 26 Jun 2023 04:40:22 -0400
Received: by mail-lj1-x232.google.com with SMTP id
 38308e7fff4ca-2b466744368so43091981fa.0
 for <qemu-devel@nongnu.org>; Mon, 26 Jun 2023 01:40:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1687768818; x=1690360818;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RzxJaWSdKb3k6V3/pRB7DBnt/R8P9njZDHy08yXw3KQ=;
 b=bTh+1I8OjLWIDfiTvuJZRBaMX1BlENW033WFVLMld+skFztgxe3xcXNdIqbT0W2G1V
 aDe4Qt1hCoeQd6bqR+8XQhOrNNkjzNQyttzQ2ln4htzjn18j4qTc/k2X+qjZ5WK5NvS0
 ATQJqDZ3CtXe6XGoLNGoWC9VYAN4hdQiBgNz+lmwFIcJKWQsmb8Ru2qjDcnHXpBfLSWL
 UgF2ka0WUTxrJLHQQV04II6qiMcBhDYwPpS0LelhFZfMo3f7B73oPU11LWAvt9VKsXfL
 q52JWVHEZrrJElHvfIlAbWt8IlzxcaixUzTjfqVohm4W49jM2zHBEv1zZNjFQCiPF1bt
 D6uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687768818; x=1690360818;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=RzxJaWSdKb3k6V3/pRB7DBnt/R8P9njZDHy08yXw3KQ=;
 b=aZGWglJ8Ri1sa6N+SuOiZonsRwsEPNh7Y/nlPLVMDkDn5PEZ1+Oc+KHFQXOjD4mhpO
 PvSBnOGpRxiaqVys5Y9EquIcJv2aNnHKMkgkw9/dXCYUTjjd2FXgGcWj8stIqgz2gIr4
 +J//UrQYgc13L7R20NQwS1yDepsz5RDRgr7zAzhrZTWYdmquUad+Kpf8blMBO/FvjjEn
 eeIqwhn1C8Ko97eNQ6GsGAEp2NaFY/GNoNQBca177JDYPPhSTTiVLp6U0rS9UDzf92ZF
 v1tCS6Nmym2TANqYEYOJvdNR7gMWTOSMfebC3WnmAWpxe6XNqOqswkdVrdSGBWz/vvox
 rPTw==
X-Gm-Message-State: AC+VfDy+YWetpoQmCOHFCM+zwPC6UWjyGERb1Pl2CUIDxyY+vmzTylKo
 nHsBA9Y46iTcZwgXL9d5Slg9vth+ToT3PhvvB2g=
X-Google-Smtp-Source: ACHHUZ4XDqbYvPUn1Iuq3kJsdL2MeK5Ls26iGIQzVi/vW82FaeI1enoj8BPKJb0+Ih+jJzVlFYxlfhttnSP5V00aXtc=
X-Received: by 2002:a2e:8894:0:b0:2b6:a0c2:edaa with SMTP id
 k20-20020a2e8894000000b002b6a0c2edaamr1097731lji.32.1687768817919; Mon, 26
 Jun 2023 01:40:17 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1687402580.git.yin31149@gmail.com>
 <00f72fe154a882fd6dc15bc39e3a1ac63f9dadce.1687402580.git.yin31149@gmail.com>
 <CAJaqyWcS+WN4vyKb4gNLarUsFKbt3hgQ5e9vDe2bGWSz3bue2g@mail.gmail.com>
In-Reply-To: <CAJaqyWcS+WN4vyKb4gNLarUsFKbt3hgQ5e9vDe2bGWSz3bue2g@mail.gmail.com>
From: Hawkins Jiawei <yin31149@gmail.com>
Date: Mon, 26 Jun 2023 16:40:06 +0800
Message-ID: <CAKrof1PmK9MoEh0JyW_gmuPf=tbqD2ahcNMn-G8xi9sDT99-7w@mail.gmail.com>
Subject: Re: [PATCH RFC 1/3] vdpa: Restore MAC address filtering state
To: Eugenio Perez Martin <eperezma@redhat.com>
Cc: jasowang@redhat.com, mst@redhat.com, qemu-devel@nongnu.org, 
 18801353760@163.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::232;
 envelope-from=yin31149@gmail.com; helo=mail-lj1-x232.google.com
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

On 2023/6/25 18:37, Eugenio Perez Martin wrote:
> On Thu, Jun 22, 2023 at 5:02=E2=80=AFAM Hawkins Jiawei <yin31149@gmail.co=
m> wrote:
>>
>> This patch refactors vhost_vdpa_net_load_mac() to
>> restore the MAC address filtering state at device's startup.
>>
>> Signed-off-by: Hawkins Jiawei <yin31149@gmail.com>
>> ---
>>   net/vhost-vdpa.c | 39 ++++++++++++++++++++++++++++++++++++++-
>>   1 file changed, 38 insertions(+), 1 deletion(-)
>>
>> diff --git a/net/vhost-vdpa.c b/net/vhost-vdpa.c
>> index ecfa8852b5..10264d3e96 100644
>> --- a/net/vhost-vdpa.c
>> +++ b/net/vhost-vdpa.c
>> @@ -651,8 +651,45 @@ static int vhost_vdpa_net_load_mac(VhostVDPAState *=
s, const VirtIONet *n)
>>           if (unlikely(dev_written < 0)) {
>>               return dev_written;
>>           }
>> +        if (*s->status !=3D VIRTIO_NET_OK) {
>> +            return -EINVAL;
>> +        }
>
> I think this part should go in its individual patch, explaining why it
> is needed and with corresponding Fixes tag.

Yes, you are right. And I have already submitted that patch "Return
-EINVAL if device's ack is VIRTIO_NET_ERR" at [1], as mentioned in the
cover letter for this series at [2].

[1]. https://lore.kernel.org/all/cover.1686746406.git.yin31149@gmail.com/#t

[2]. https://lore.kernel.org/all/cover.1687402580.git.yin31149@gmail.com/

>
>> +    }
>> +
>> +    if (virtio_vdev_has_feature(&n->parent_obj, VIRTIO_NET_F_CTRL_RX)) =
{
>> +        /* Load the MAC address filtering */
>> +        uint32_t uni_entries =3D n->mac_table.first_multi,
>> +                 uni_macs_size =3D uni_entries * ETH_ALEN,
>> +                 uni_size =3D sizeof(struct virtio_net_ctrl_mac) + uni_=
macs_size,
>> +                 mul_entries =3D n->mac_table.in_use - uni_entries,
>> +                 mul_macs_size =3D mul_entries * ETH_ALEN,
>> +                 mul_size =3D sizeof(struct virtio_net_ctrl_mac) + mul_=
macs_size,
>> +                 data_size =3D uni_size + mul_size;
>> +        void *data =3D g_malloc(data_size);
>
> If we keep this part, please use g_autofree here [1].
>
> But I think it is not worth copying all the data actually. Maybe it is
> worth it to convert vhost_vdpa_net_load_cmd to const iovec?

Yes, you are right. I will try to add a helper function in the v2 patch
as you have suggested.

Thanks!


>
> Thanks!
>
> [1] https://www.qemu.org/docs/master/devel/style#automatic-memory-dealloc=
ation
>
>> +        struct virtio_net_ctrl_mac *ctrl_mac;
>> +
>> +        /* Pack the non-multicast(unicast) MAC addresses */
>> +        ctrl_mac =3D data;
>> +        ctrl_mac->entries =3D cpu_to_le32(uni_entries);
>> +        memcpy(ctrl_mac->macs, n->mac_table.macs, uni_macs_size);
>> +
>> +        /* Pack the multicast MAC addresses */
>> +        ctrl_mac =3D data + uni_size;
>> +        ctrl_mac->entries =3D cpu_to_le32(mul_entries);
>> +        memcpy(ctrl_mac->macs, &n->mac_table.macs[uni_macs_size],
>> +               mul_macs_size);
>> +
>> +        ssize_t dev_written =3D vhost_vdpa_net_load_cmd(s, VIRTIO_NET_C=
TRL_MAC,
>> +                                                  VIRTIO_NET_CTRL_MAC_T=
ABLE_SET,
>> +                                                  data, data_size);
>> +        g_free(data);
>>
>> -        return *s->status !=3D VIRTIO_NET_OK;
>> +        if (unlikely(dev_written < 0)) {
>> +            return dev_written;
>> +        }
>> +        if (*s->status !=3D VIRTIO_NET_OK) {
>> +            return -EINVAL;
>> +        }
>>       }
>>
>>       return 0;
>> --
>> 2.25.1
>>
>


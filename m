Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1235D77F69D
	for <lists+qemu-devel@lfdr.de>; Thu, 17 Aug 2023 14:44:13 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qWcL5-0003ZX-4g; Thu, 17 Aug 2023 08:42:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yin31149@gmail.com>)
 id 1qWcL1-0003Yb-Pp
 for qemu-devel@nongnu.org; Thu, 17 Aug 2023 08:42:56 -0400
Received: from mail-lf1-x130.google.com ([2a00:1450:4864:20::130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <yin31149@gmail.com>)
 id 1qWcKw-0006nY-4R
 for qemu-devel@nongnu.org; Thu, 17 Aug 2023 08:42:54 -0400
Received: by mail-lf1-x130.google.com with SMTP id
 2adb3069b0e04-4fe4762173bso12466759e87.3
 for <qemu-devel@nongnu.org>; Thu, 17 Aug 2023 05:42:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1692276167; x=1692880967;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7lR/B6fEj8psAFygIUraJ+7YcXS3goovl4TUxGEesQ4=;
 b=nnm1cLI4XKdb1L8JsbVJ2UzyPrJdNvAt/tPE1RmLom9zdhPG/QUtDWGoubkErFKQ8+
 nOoe8RurOtC7n3p7tfn86AHlfOALbYi68dVqUHwWFWKaegLDJb5B5hkaaZ1ptKL98YYN
 SkioUjwyA4aB92+GDOthH9GQEN2OTHbusxOjUkDsaxRLlE3kBJ8LN7B9sj17iTB0M9uv
 sp1Pfz6FsP4Qj2XFTfSdwY6XmiFolQHcEt9odT7eWw+N9yhcexCa+B/Mq3DUlu2aqJa8
 PXe6C8R40Vc5PyUY/Oc3UfbOQ1MSQR4kK/d8PAN2KceP2s8OLXAI2ZB2+qJfgoG0IUsi
 ip2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692276167; x=1692880967;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=7lR/B6fEj8psAFygIUraJ+7YcXS3goovl4TUxGEesQ4=;
 b=lFHQ+U8n7jvhbfGqKfBbxAZgGcRxgzbgBXp2pSDE0vAvT/FUlsrkU0nEf8bn05Si3z
 UscjZLFU14yZvwMWXk/tGMNrTOdiOay80vitgLIIbYCMRGo9HtBC4ZYyfNmQlIi4jYGm
 cTVTI7hQPwvX77N174MFLhdl3YMst7Ca8yqtgigLx24coKjpJrrChvq+A0hZ0GcvUql4
 D0t5K5tH/4t19UTw2cDzvqPTQCZNTS+XyrcwKTGhYtGuOaRWXPtR0ygwrnAV9gApRT3e
 nnW4L/VcMnGDAadIlaEkPvc0NAf6TiuTnECp4TZcMJIGNJ+1NqIUe8jQMMPbitbko/dG
 0w+w==
X-Gm-Message-State: AOJu0YzJURQG481e/kW1m1xdzCNey2kCveTdJAP72a0fDKWQLV7indu4
 6tckmtrOXJxr7/RUJRMKTs9c9J2D+tF9kABFXBk=
X-Google-Smtp-Source: AGHT+IEwn6DvBFA2O8540+tuireRSsZ4fXBQfmQB83x7XtNAqn8TPxY1YrqfS0fC8CCWGLwlFvorrxe7qeF+tN3gIAs=
X-Received: by 2002:a05:6512:1dc:b0:4fe:63cf:6048 with SMTP id
 f28-20020a05651201dc00b004fe63cf6048mr3358588lfp.43.1692276166391; Thu, 17
 Aug 2023 05:42:46 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1688743107.git.yin31149@gmail.com>
 <3482cc50eebd13db4140b8b5dec9d0cc25b20b1b.1688743107.git.yin31149@gmail.com>
 <CAJaqyWeZxv6Lf8QEAmw_Ge_BGbPJdDvsGNnze4uavqXhPZQChQ@mail.gmail.com>
In-Reply-To: <CAJaqyWeZxv6Lf8QEAmw_Ge_BGbPJdDvsGNnze4uavqXhPZQChQ@mail.gmail.com>
From: Hawkins Jiawei <yin31149@gmail.com>
Date: Thu, 17 Aug 2023 20:42:34 +0800
Message-ID: <CAKrof1OwTCbcfTxQ=6B2-iyH2E0Wxt-f+CtkkdBWtiZOPvRNLw@mail.gmail.com>
Subject: Re: [PATCH v3 1/7] vdpa: Use iovec for vhost_vdpa_net_load_cmd()
To: Eugenio Perez Martin <eperezma@redhat.com>
Cc: jasowang@redhat.com, mst@redhat.com, qemu-devel@nongnu.org, 
 18801353760@163.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::130;
 envelope-from=yin31149@gmail.com; helo=mail-lf1-x130.google.com
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

On 2023/8/17 17:23, Eugenio Perez Martin wrote:
> On Fri, Jul 7, 2023 at 5:27=E2=80=AFPM Hawkins Jiawei <yin31149@gmail.com=
> wrote:
>>
>> According to VirtIO standard, "The driver MUST follow
>> the VIRTIO_NET_CTRL_MAC_TABLE_SET command by a le32 number,
>> followed by that number of non-multicast MAC addresses,
>> followed by another le32 number, followed by that number
>> of multicast addresses."
>>
>> Considering that these data is not stored in contiguous memory,
>> this patch refactors vhost_vdpa_net_load_cmd() to accept
>> scattered data, eliminating the need for an addtional data copy or
>> packing the data into s->cvq_cmd_out_buffer outside of
>> vhost_vdpa_net_load_cmd().
>>
>> Signed-off-by: Hawkins Jiawei <yin31149@gmail.com>
>> ---
>> v3:
>>    - rename argument name to `data_sg` and `data_num`
>>    - use iov_to_buf() suggested by Eugenio
>>
>> v2: https://lore.kernel.org/all/6d3dc0fc076564a03501e222ef1102a6a7a643af=
.1688051252.git.yin31149@gmail.com/
>>    - refactor vhost_vdpa_load_cmd() to accept iovec suggested by
>> Eugenio
>>
>>   net/vhost-vdpa.c | 33 +++++++++++++++++++++++++--------
>>   1 file changed, 25 insertions(+), 8 deletions(-)
>>
>> diff --git a/net/vhost-vdpa.c b/net/vhost-vdpa.c
>> index 373609216f..31ef6ad6ec 100644
>> --- a/net/vhost-vdpa.c
>> +++ b/net/vhost-vdpa.c
>> @@ -620,29 +620,38 @@ static ssize_t vhost_vdpa_net_cvq_add(VhostVDPASta=
te *s, size_t out_len,
>>   }
>>
>>   static ssize_t vhost_vdpa_net_load_cmd(VhostVDPAState *s, uint8_t clas=
s,
>> -                                       uint8_t cmd, const void *data,
>> -                                       size_t data_size)
>> +                                       uint8_t cmd, const struct iovec =
*data_sg,
>> +                                       size_t data_num)
>>   {
>>       const struct virtio_net_ctrl_hdr ctrl =3D {
>>           .class =3D class,
>>           .cmd =3D cmd,
>>       };
>> +    size_t data_size =3D iov_size(data_sg, data_num);
>>
>>       assert(data_size < vhost_vdpa_net_cvq_cmd_page_len() - sizeof(ctrl=
));
>>
>> +    /* pack the CVQ command header */
>>       memcpy(s->cvq_cmd_out_buffer, &ctrl, sizeof(ctrl));
>> -    memcpy(s->cvq_cmd_out_buffer + sizeof(ctrl), data, data_size);
>>
>> -    return vhost_vdpa_net_cvq_add(s, sizeof(ctrl) + data_size,
>> +    /* pack the CVQ command command-specific-data */
>> +    iov_to_buf(data_sg, data_num, 0,
>> +               s->cvq_cmd_out_buffer + sizeof(ctrl), data_size);
>> +
>> +    return vhost_vdpa_net_cvq_add(s, data_size + sizeof(ctrl),
>
> Nit, any reason for changing the order of the addends? sizeof(ctrl) +
> data_size ?

Hi Eugenio,

Here the code should be changed to `sizeof(ctrl) + data_size` as you
point out.

Since this patch series has already been merged into master, I will
submit a separate patch to correct this problem.

>
>>                                     sizeof(virtio_net_ctrl_ack));
>>   }
>>
>>   static int vhost_vdpa_net_load_mac(VhostVDPAState *s, const VirtIONet =
*n)
>>   {
>>       if (virtio_vdev_has_feature(&n->parent_obj, VIRTIO_NET_F_CTRL_MAC_=
ADDR)) {
>> +        const struct iovec data =3D {
>> +            .iov_base =3D (void *)n->mac,
>
> Assign to void should always be valid, no need for casting here.

Yes, assign to void should be valid for normal pointers.

However, `n->mac` is an array and is treated as a const pointer. It will
trigger the warning "error: initialization discards =E2=80=98const=E2=80=99=
 qualifier
from pointer target type" if we don't add this cast.

Thanks!


>
>> +            .iov_len =3D sizeof(n->mac),
>> +        };
>>           ssize_t dev_written =3D vhost_vdpa_net_load_cmd(s, VIRTIO_NET_=
CTRL_MAC,
>>                                                     VIRTIO_NET_CTRL_MAC_=
ADDR_SET,
>> -                                                  n->mac, sizeof(n->mac=
));
>> +                                                  &data, 1);
>>           if (unlikely(dev_written < 0)) {
>>               return dev_written;
>>           }
>> @@ -665,9 +674,13 @@ static int vhost_vdpa_net_load_mq(VhostVDPAState *s=
,
>>       }
>>
>>       mq.virtqueue_pairs =3D cpu_to_le16(n->curr_queue_pairs);
>> +    const struct iovec data =3D {
>> +        .iov_base =3D &mq,
>> +        .iov_len =3D sizeof(mq),
>> +    };
>>       dev_written =3D vhost_vdpa_net_load_cmd(s, VIRTIO_NET_CTRL_MQ,
>> -                                          VIRTIO_NET_CTRL_MQ_VQ_PAIRS_S=
ET, &mq,
>> -                                          sizeof(mq));
>> +                                          VIRTIO_NET_CTRL_MQ_VQ_PAIRS_S=
ET,
>> +                                          &data, 1);
>>       if (unlikely(dev_written < 0)) {
>>           return dev_written;
>>       }
>> @@ -706,9 +719,13 @@ static int vhost_vdpa_net_load_offloads(VhostVDPASt=
ate *s,
>>       }
>>
>>       offloads =3D cpu_to_le64(n->curr_guest_offloads);
>> +    const struct iovec data =3D {
>> +        .iov_base =3D &offloads,
>> +        .iov_len =3D sizeof(offloads),
>> +    };
>>       dev_written =3D vhost_vdpa_net_load_cmd(s, VIRTIO_NET_CTRL_GUEST_O=
FFLOADS,
>>                                             VIRTIO_NET_CTRL_GUEST_OFFLOA=
DS_SET,
>> -                                          &offloads, sizeof(offloads));
>> +                                          &data, 1);
>>       if (unlikely(dev_written < 0)) {
>>           return dev_written;
>>       }
>
> Apart from that:
>
> Acked-by: Eugenio P=C3=A9rez <eperezma@redhat.com>
>
> Thanks!
>


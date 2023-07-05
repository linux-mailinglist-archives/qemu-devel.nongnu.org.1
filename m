Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D8B1E747ADC
	for <lists+qemu-devel@lfdr.de>; Wed,  5 Jul 2023 03:14:20 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qGr4t-0000pH-Js; Tue, 04 Jul 2023 21:13:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yin31149@gmail.com>)
 id 1qGr4r-0000ou-KR
 for qemu-devel@nongnu.org; Tue, 04 Jul 2023 21:13:05 -0400
Received: from mail-lj1-x235.google.com ([2a00:1450:4864:20::235])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <yin31149@gmail.com>)
 id 1qGr4p-0000lT-Jj
 for qemu-devel@nongnu.org; Tue, 04 Jul 2023 21:13:05 -0400
Received: by mail-lj1-x235.google.com with SMTP id
 38308e7fff4ca-2b69ed7d050so99330541fa.2
 for <qemu-devel@nongnu.org>; Tue, 04 Jul 2023 18:13:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1688519581; x=1691111581;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0fN8225df7qZMzTXTKUAK8qZWumpjCKSs/pakPctGvk=;
 b=hKJuh4UTPalCD4y1hRFEWhUSwATNspRtQG2yPj112Fl6YgZOUK2pvEsV9W3nqkP322
 e411Ifl+OZpd8L9bK4J+T6Rn7Fc/jSv5GFm9/m8QnPkGkIV/Sxsy0nGdOJPRs8wgbzxS
 BZtOasxd2WyBN5E+yVrh1r5LZOESX/V3FZ2xMBotZDOd466/Zh52OTqxMRju3bEfkwQ/
 8RtDQRy+0gi8rmdMDxe9ty8PUyi+qq8sxcWaOc9tnr+oh9IV/mU7PM49TacKG7QEpxy2
 RAKkvpoNsLCg14sfumVnizaOwUWawSDljznSO1uN9OwAHEqHVxVq9jzqLiYxnowWiSpZ
 mK4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688519581; x=1691111581;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=0fN8225df7qZMzTXTKUAK8qZWumpjCKSs/pakPctGvk=;
 b=JrbbY1PdiZh5QUTgO3TTpJad/K6pzog3iHD06Pxq62yri2u6ZnuQYzbyyTtPsYfdy0
 Xjx2Y0xJKgvxo8bXgfgZdDofNhmeOACwTXnwJ4ypuzuuBeeVXwYwCb8I2QiWLvCRMxcD
 3Yd1EiSYw7WrXcD0coRsfhO4eOKWB5HUBV12lMLRHz2n638dW0JpFiXD+piaNImjUwNS
 o5AFX2s+oHsZ0x54nDyoJ3JdG5SBI2uVhsZJPEXwOByQHhfIFwD1r4GJJ3e2hkiVTuWy
 wTaSHM/31is+AxuRioLLO2rW3u0kB/F47b0GYCMDIegaM5FHq/pAzJEN4cq0U4VrcmAf
 cp1w==
X-Gm-Message-State: ABy/qLYX9dBwY16X9SusZg4LAuf7dIf2+oOis7vUJoCotggAoSNkl6NG
 ZFpEeRKwi++YrXFWdOdahUNBRIymTExNvh0WQCE=
X-Google-Smtp-Source: APBJJlFAzIfRvdqqoyZ6rPRAAV4XQS48zgz2VhkZVnVfRJT++bh7ir4T4geWSOtzxtZdI5Hwf8Zy9xYiS/16hVmnrYg=
X-Received: by 2002:a2e:9258:0:b0:2b5:9d2a:ab51 with SMTP id
 v24-20020a2e9258000000b002b59d2aab51mr9933616ljg.5.1688519580387; Tue, 04 Jul
 2023 18:13:00 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1688051252.git.yin31149@gmail.com>
 <6d3dc0fc076564a03501e222ef1102a6a7a643af.1688051252.git.yin31149@gmail.com>
 <CAJaqyWc2OXN9dnTV3Fmsu6=WErgxNbZ4sZ3Fxkyb18uXXJSB=A@mail.gmail.com>
In-Reply-To: <CAJaqyWc2OXN9dnTV3Fmsu6=WErgxNbZ4sZ3Fxkyb18uXXJSB=A@mail.gmail.com>
From: Hawkins Jiawei <yin31149@gmail.com>
Date: Wed, 5 Jul 2023 09:12:46 +0800
Message-ID: <CAKrof1Oe2iJHL9WqHxJeWVsoqRv2w9xPhfs1WwdZ1TN=Qb39Ww@mail.gmail.com>
Subject: Re: [PATCH RFC v2 1/4] vdpa: Use iovec for vhost_vdpa_net_load_cmd()
To: Eugenio Perez Martin <eperezma@redhat.com>
Cc: jasowang@redhat.com, mst@redhat.com, qemu-devel@nongnu.org, 
 18801353760@163.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::235;
 envelope-from=yin31149@gmail.com; helo=mail-lj1-x235.google.com
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

On 2023/7/4 22:17, Eugenio Perez Martin wrote:
> On Thu, Jun 29, 2023 at 5:25=E2=80=AFPM Hawkins Jiawei <yin31149@gmail.co=
m> wrote:
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
>> v2:
>>    - refactor vhost_vdpa_load_cmd() to accept iovec suggested by
>> Eugenio
>>
>>   net/vhost-vdpa.c | 42 ++++++++++++++++++++++++++++++++----------
>>   1 file changed, 32 insertions(+), 10 deletions(-)
>>
>> diff --git a/net/vhost-vdpa.c b/net/vhost-vdpa.c
>> index 6f6a5c6df6..0bd1c7817c 100644
>> --- a/net/vhost-vdpa.c
>> +++ b/net/vhost-vdpa.c
>> @@ -620,29 +620,43 @@ static ssize_t vhost_vdpa_net_cvq_add(VhostVDPASta=
te *s, size_t out_len,
>>   }
>>
>>   static ssize_t vhost_vdpa_net_load_cmd(VhostVDPAState *s, uint8_t clas=
s,
>> -                                       uint8_t cmd, const void *data,
>> -                                       size_t data_size)
>> +                                       uint8_t cmd, const struct iovec =
*data,
>> +                                       size_t data_len)
>>   {
>>       const struct virtio_net_ctrl_hdr ctrl =3D {
>>           .class =3D class,
>>           .cmd =3D cmd,
>>       };
>> +    void *cursor =3D s->cvq_cmd_out_buffer;
>>
>> -    assert(data_size < vhost_vdpa_net_cvq_cmd_page_len() - sizeof(ctrl)=
);
>> +    /* pack the CVQ command header */
>> +    assert(sizeof(ctrl) < vhost_vdpa_net_cvq_cmd_page_len() -
>> +                          (cursor - s->cvq_cmd_out_buffer));
>> +    memcpy(cursor, &ctrl, sizeof(ctrl));
>> +    cursor +=3D sizeof(ctrl);
>>
>> -    memcpy(s->cvq_cmd_out_buffer, &ctrl, sizeof(ctrl));
>> -    memcpy(s->cvq_cmd_out_buffer + sizeof(ctrl), data, data_size);
>> +    /* pack the CVQ command command-specific-data */
>> +    for (int i =3D 0; i < data_len; ++i) {
>> +        assert(data[i].iov_len < vhost_vdpa_net_cvq_cmd_page_len() -
>> +                                 (cursor - s->cvq_cmd_out_buffer));
>> +        memcpy(cursor, data[i].iov_base, data[i].iov_len);
>> +        cursor +=3D data[i].iov_len;
>> +    }
>
> Can we replace all of the above by iov_to_buf?

Yes, you are right.

We should use iov_to_buf() here. I will refactor this patch according to
your suggestion.

Thanks!


>
>>
>> -    return vhost_vdpa_net_cvq_add(s, sizeof(ctrl) + data_size,
>> +    return vhost_vdpa_net_cvq_add(s, cursor - s->cvq_cmd_out_buffer,
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
>> @@ -665,9 +679,13 @@ static int vhost_vdpa_net_load_mq(VhostVDPAState *s=
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
>> @@ -706,9 +724,13 @@ static int vhost_vdpa_net_load_offloads(VhostVDPASt=
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
>> --
>> 2.25.1
>>
>


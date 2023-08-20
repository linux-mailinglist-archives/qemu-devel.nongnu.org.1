Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 63171781C09
	for <lists+qemu-devel@lfdr.de>; Sun, 20 Aug 2023 04:34:15 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qXYFs-000287-RL; Sat, 19 Aug 2023 22:33:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yin31149@gmail.com>)
 id 1qXYFq-00027y-Jt
 for qemu-devel@nongnu.org; Sat, 19 Aug 2023 22:33:26 -0400
Received: from mail-lf1-x12b.google.com ([2a00:1450:4864:20::12b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <yin31149@gmail.com>)
 id 1qXYFo-0005sP-5C
 for qemu-devel@nongnu.org; Sat, 19 Aug 2023 22:33:26 -0400
Received: by mail-lf1-x12b.google.com with SMTP id
 2adb3069b0e04-4fe1b00fce2so3155240e87.3
 for <qemu-devel@nongnu.org>; Sat, 19 Aug 2023 19:33:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1692498802; x=1693103602;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3Y07Dk8TtsOLhL1l3V/vOwICP7y5XZYKKsL7dKnvPPU=;
 b=iYHOB+i2lb2zXRjcd0sp7iU7cloTd0PrAi31jj/fzKANqOFkNaww6Ny5bhe+lVEpsC
 3cTMxa6Vp50btpO6NZkxy9c/fkjrj9sB7/w1CT2Wr2QVn7xykzfmmTvTEpl5x/8/IKsx
 ZxHy3DTZIFP/0TAh4QkqipWj/vIbzXZweef1KcFVX7jD8qjEN5/mryAXx+o0KMUSo7zQ
 B6qJO3SDNgegtMnItmZIQls+XlRx2NaNXyHurQue1jhMYu39MonlBdDSaW8kkTCehAD7
 yUFoWmar8HbS3uSCfdNnmICQzPD6TnTHNH7DoTKBRHeyxurUWOwMnrW/MNlO3LDMAYRX
 I/rA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692498802; x=1693103602;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=3Y07Dk8TtsOLhL1l3V/vOwICP7y5XZYKKsL7dKnvPPU=;
 b=bST8pWOHbv94Xba6YessgZFDaYWAGzIVN/c2nWHHptNmGlX/wrNSvjxKsjlWLMdk85
 hHql8l+ilqBdEpboVhceJBUEZLpLSHm7MUqD5iHqQaLWXGu2yPHJXpv4tsd1N6z2D9hC
 Kn0RIkD/plKsuKsbx6J/SfZmgq0QIZKRlUmcr29m6tbfDBgj7OFRtqq6DE7s2Mhnq8TC
 3RPnAItRdng84aV7qiRXoDBSj6o0kShK+59Ur/mxENHGsBKJMxgJebxbxASeHH6rFX5T
 Cy0qgWPwPS3YPmjCdDFUnFS8fAGdBYYuL7f5Yp+xN4yWnjSdEw4wcQD9JSaCIE9sSUhc
 IEqg==
X-Gm-Message-State: AOJu0YwJScvA4cRSnGHnGi0jn23RIYzF2TiGBPrwTIAodYkuVQBpm9ro
 1fzlpzKMQNUSpLYE0YLHK8JiGC2XOZ4uttsgXjI=
X-Google-Smtp-Source: AGHT+IEpHRlFUUdObTzMnU2sey6q+OUjChnI7/79gKH2M8kPaz0INV1dxr0FwOTdCCpPEPAUsUHSEOSHM8LHUmQBaxo=
X-Received: by 2002:a05:6512:753:b0:4fd:f7fe:c3e with SMTP id
 c19-20020a056512075300b004fdf7fe0c3emr1704963lfs.67.1692498802060; Sat, 19
 Aug 2023 19:33:22 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1689748694.git.yin31149@gmail.com>
 <b1d473772ec4bcb254ab0d12430c9b1efe758606.1689748694.git.yin31149@gmail.com>
 <CAJaqyWeGSdnv-s0X=ZqhQPw7tQ7BtjJuvD_1e5nqbCyN-tFknA@mail.gmail.com>
In-Reply-To: <CAJaqyWeGSdnv-s0X=ZqhQPw7tQ7BtjJuvD_1e5nqbCyN-tFknA@mail.gmail.com>
From: Hawkins Jiawei <yin31149@gmail.com>
Date: Sun, 20 Aug 2023 10:33:10 +0800
Message-ID: <CAKrof1PA3C=AWRKx9XMpR+o_3MebgpTic5ecf_4ttuwVLegvzA@mail.gmail.com>
Subject: Re: [PATCH v3 2/8] vdpa: Use iovec for vhost_vdpa_net_cvq_add()
To: Eugenio Perez Martin <eperezma@redhat.com>
Cc: jasowang@redhat.com, mst@redhat.com, qemu-devel@nongnu.org, 
 18801353760@163.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::12b;
 envelope-from=yin31149@gmail.com; helo=mail-lf1-x12b.google.com
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

On 2023/8/18 23:23, Eugenio Perez Martin wrote:
> On Wed, Jul 19, 2023 at 9:54=E2=80=AFAM Hawkins Jiawei <yin31149@gmail.co=
m> wrote:
>>
>> Next patches in this series will no longer perform an
>> immediate poll and check of the device's used buffers
>> for each CVQ state load command. Consequently, there
>> will be multiple pending buffers in the shadow VirtQueue,
>> making it a must for every control command to have its
>> own buffer.
>>
>> To achieve this, this patch refactor vhost_vdpa_net_cvq_add()
>> to accept `struct iovec`, which eliminates the coupling of
>> control commands to `s->cvq_cmd_out_buffer` and `s->status`,
>> allowing them to use their own buffer.
>>
>> Signed-off-by: Hawkins Jiawei <yin31149@gmail.com>
>> ---
>>   net/vhost-vdpa.c | 38 ++++++++++++++++++++------------------
>>   1 file changed, 20 insertions(+), 18 deletions(-)
>>
>> diff --git a/net/vhost-vdpa.c b/net/vhost-vdpa.c
>> index d1dd140bf6..6b16c8ece0 100644
>> --- a/net/vhost-vdpa.c
>> +++ b/net/vhost-vdpa.c
>> @@ -596,22 +596,14 @@ static void vhost_vdpa_net_cvq_stop(NetClientState=
 *nc)
>>       vhost_vdpa_net_client_stop(nc);
>>   }
>>
>> -static ssize_t vhost_vdpa_net_cvq_add(VhostVDPAState *s, size_t out_len=
,
>> -                                      size_t in_len)
>> +static ssize_t vhost_vdpa_net_cvq_add(VhostVDPAState *s,
>> +                                      struct iovec *out_sg, size_t out_=
num,
>> +                                      struct iovec *in_sg, size_t in_nu=
m)
>>   {
>> -    /* Buffers for the device */
>> -    const struct iovec out =3D {
>> -        .iov_base =3D s->cvq_cmd_out_buffer,
>> -        .iov_len =3D out_len,
>> -    };
>> -    const struct iovec in =3D {
>> -        .iov_base =3D s->status,
>> -        .iov_len =3D sizeof(virtio_net_ctrl_ack),
>> -    };
>>       VhostShadowVirtqueue *svq =3D g_ptr_array_index(s->vhost_vdpa.shad=
ow_vqs, 0);
>>       int r;
>>
>> -    r =3D vhost_svq_add(svq, &out, 1, &in, 1, NULL);
>> +    r =3D vhost_svq_add(svq, out_sg, out_num, in_sg, in_num, NULL);
>>       if (unlikely(r !=3D 0)) {
>>           if (unlikely(r =3D=3D -ENOSPC)) {
>>               qemu_log_mask(LOG_GUEST_ERROR, "%s: No space on device que=
ue\n",
>> @@ -637,6 +629,15 @@ static ssize_t vhost_vdpa_net_load_cmd(VhostVDPASta=
te *s, uint8_t class,
>>           .cmd =3D cmd,
>>       };
>>       size_t data_size =3D iov_size(data_sg, data_num);
>> +    /* Buffers for the device */
>> +    struct iovec out =3D {
>> +        .iov_base =3D s->cvq_cmd_out_buffer,
>> +        .iov_len =3D sizeof(ctrl) + data_size,
>> +    };
>> +    struct iovec in =3D {
>> +        .iov_base =3D s->status,
>> +        .iov_len =3D sizeof(*s->status),
>> +    };
>>
>>       assert(data_size < vhost_vdpa_net_cvq_cmd_page_len() - sizeof(ctrl=
));
>>
>> @@ -647,8 +648,7 @@ static ssize_t vhost_vdpa_net_load_cmd(VhostVDPAStat=
e *s, uint8_t class,
>>       iov_to_buf(data_sg, data_num, 0,
>>                  s->cvq_cmd_out_buffer + sizeof(ctrl), data_size);
>>
>> -    return vhost_vdpa_net_cvq_add(s, data_size + sizeof(ctrl),
>> -                                  sizeof(virtio_net_ctrl_ack));
>> +    return vhost_vdpa_net_cvq_add(s, &out, 1, &in, 1);
>>   }
>>
>>   static int vhost_vdpa_net_load_mac(VhostVDPAState *s, const VirtIONet =
*n)
>> @@ -1222,9 +1222,7 @@ static int vhost_vdpa_net_handle_ctrl_avail(VhostS=
hadowVirtqueue *svq,
>>       struct iovec out =3D {
>>           .iov_base =3D s->cvq_cmd_out_buffer,
>>       };
>> -    /* in buffer used for device model */
>> -    const struct iovec in =3D {
>> -        .iov_base =3D &status,
>> +    struct iovec in =3D {
>
> What if instead of reusing "in" we declare a new struct iovec in the
> condition that calls vhost_vdpa_net_cvq_add? Something in the line of
> "device_in".
>
> I'm also ok with this code, but splitting them would reduce the
> possibility of sending the wrong one to the device / virtio device
> model by mistake.

Hi Eugenio,

Ok, I will refactor this part of code according to your suggestion in
the v4 patch.

Thanks!


>
> Thanks!
>
>>           .iov_len =3D sizeof(status),
>>       };
>>       ssize_t dev_written =3D -EINVAL;
>> @@ -1232,6 +1230,8 @@ static int vhost_vdpa_net_handle_ctrl_avail(VhostS=
hadowVirtqueue *svq,
>>       out.iov_len =3D iov_to_buf(elem->out_sg, elem->out_num, 0,
>>                                s->cvq_cmd_out_buffer,
>>                                vhost_vdpa_net_cvq_cmd_page_len());
>> +    /* In buffer used for the vdpa device */
>> +    in.iov_base =3D s->status;
>>
>>       ctrl =3D s->cvq_cmd_out_buffer;
>>       if (ctrl->class =3D=3D VIRTIO_NET_CTRL_ANNOUNCE) {
>> @@ -1260,7 +1260,7 @@ static int vhost_vdpa_net_handle_ctrl_avail(VhostS=
hadowVirtqueue *svq,
>>               goto out;
>>           }
>>       } else {
>> -        dev_written =3D vhost_vdpa_net_cvq_add(s, out.iov_len, sizeof(s=
tatus));
>> +        dev_written =3D vhost_vdpa_net_cvq_add(s, &out, 1, &in, 1);
>>           if (unlikely(dev_written < 0)) {
>>               goto out;
>>           }
>> @@ -1276,6 +1276,8 @@ static int vhost_vdpa_net_handle_ctrl_avail(VhostS=
hadowVirtqueue *svq,
>>       }
>>
>>       status =3D VIRTIO_NET_ERR;
>> +    /* In buffer used for the device model */
>> +    in.iov_base =3D &status;
>>       virtio_net_handle_ctrl_iov(svq->vdev, &in, 1, &out, 1);
>>       if (status !=3D VIRTIO_NET_OK) {
>>           error_report("Bad CVQ processing in model");
>> --
>> 2.25.1
>>
>


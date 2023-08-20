Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 46D6B781C36
	for <lists+qemu-devel@lfdr.de>; Sun, 20 Aug 2023 04:53:17 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qXYYU-0007as-9q; Sat, 19 Aug 2023 22:52:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yin31149@gmail.com>)
 id 1qXYYR-0007aQ-O7
 for qemu-devel@nongnu.org; Sat, 19 Aug 2023 22:52:39 -0400
Received: from mail-lj1-x234.google.com ([2a00:1450:4864:20::234])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <yin31149@gmail.com>)
 id 1qXYYP-0000jB-9F
 for qemu-devel@nongnu.org; Sat, 19 Aug 2023 22:52:39 -0400
Received: by mail-lj1-x234.google.com with SMTP id
 38308e7fff4ca-2bcb0b973a5so8660711fa.3
 for <qemu-devel@nongnu.org>; Sat, 19 Aug 2023 19:52:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1692499955; x=1693104755;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kkAg3XaInhgYAUWKspB7yVlU+RjuQbLVneJpSV9JHuM=;
 b=qsg2MoJWA7a1LZBVG23zNAbadJCQF5JwLkU+TeoPaWEgpv1db5tv3D3038uD+bkwQA
 9MwaEWJShaT+juj28WPXidcI5694/rBjeh505w//6bulZp1Z3KIZVYRQ9d2mvu7E6+rB
 BRR3qlBMrzfYS7UeJgkooEIES+XwdthG6Gsdg4RKYIqXERGUw1JL/7ctlgNAG+TaLcOT
 ouXpSKzYMgOuIMA0LgDAvWu4w8r4alKyOXS15AF2xwl9gvEdaGeVCtrbdOKwm6xoQElI
 DUBuMWKb5TRtm+njcY/R6jtyYTtae0/lII2s0su0A0p7wuv2lnxt6L3t7nkxAsDvi8Om
 5pIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692499955; x=1693104755;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=kkAg3XaInhgYAUWKspB7yVlU+RjuQbLVneJpSV9JHuM=;
 b=UXwWBDEdN5pxUn82LdF7/DAAp733BNiOFkWl1a0Ixvsjnau424CB1mRbUPGk8nKFf8
 xJrIGD4bQlvHZmJoPt/Au9QuLm7Gklc0heijioYjuksruiH52Q/NcHAcbMWS9lMmS/rQ
 Kdg6vEXekIAyT9ACZ65rjPKmcUL4k2ISr9B2zrcb9JoJWZi4esrucps4JBa96rACp757
 xW1htHbGb5/+Ua9j2EJhMYCWuzZ7pJv8/ubbvmUyKXxneRhHPCqwDRdCuGC3EoI4Q5Bx
 Hd12MfII2NiapJH/H+nakKEfbHM2z8EOIjElhDaegVEDaFcXL6mQvtEAcqF7LZWz/FYl
 qb4w==
X-Gm-Message-State: AOJu0YzkB20Y0omELTsf/MusM1X8YvkvSTqZeCkIxCqQf0t3f7VkcY3e
 RMQ8xFoGf3LVZM37QoIJTDpgX4lAAXkZ/+KJCdE=
X-Google-Smtp-Source: AGHT+IE70MPO09D+J6INabYYBT+CqYlyqURE0FiV+njufyqJ+vi8Q0QY0g/hgxFOXFDUGs/vVMg2D/qlpJFFpJAfhbA=
X-Received: by 2002:a2e:9b4e:0:b0:2b9:ecc5:d1de with SMTP id
 o14-20020a2e9b4e000000b002b9ecc5d1demr2098454ljj.37.1692499954882; Sat, 19
 Aug 2023 19:52:34 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1689748694.git.yin31149@gmail.com>
 <152177c4e7082236fba9d31d535e40f8c2984349.1689748694.git.yin31149@gmail.com>
 <CAJaqyWez2iz1Ew67W_zwY8oqTwG14F4uwJgiint5n+G6fDEPwQ@mail.gmail.com>
In-Reply-To: <CAJaqyWez2iz1Ew67W_zwY8oqTwG14F4uwJgiint5n+G6fDEPwQ@mail.gmail.com>
From: Hawkins Jiawei <yin31149@gmail.com>
Date: Sun, 20 Aug 2023 10:52:23 +0800
Message-ID: <CAKrof1NMrgyt7Xroyn78yyLjNzB=Fg6fJ71-_djXH80M1RNzRQ@mail.gmail.com>
Subject: Re: [PATCH v3 6/8] vdpa: Move vhost_svq_poll() to the caller of
 vhost_vdpa_net_cvq_add()
To: Eugenio Perez Martin <eperezma@redhat.com>
Cc: jasowang@redhat.com, mst@redhat.com, qemu-devel@nongnu.org, 
 18801353760@163.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::234;
 envelope-from=yin31149@gmail.com; helo=mail-lj1-x234.google.com
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

On 2023/8/18 23:48, Eugenio Perez Martin wrote:
> On Wed, Jul 19, 2023 at 9:54=E2=80=AFAM Hawkins Jiawei <yin31149@gmail.co=
m> wrote:
>>
>> This patch moves vhost_svq_poll() to the caller of
>> vhost_vdpa_net_cvq_add() and introduces a helper funtion.
>>
>> By making this change, next patches in this series is
>> able to refactor vhost_vdpa_net_load_x() only to delay
>> the polling and checking process until either the SVQ
>> is full or control commands shadow buffers are full.
>>
>> Signed-off-by: Hawkins Jiawei <yin31149@gmail.com>
>> ---
>>   net/vhost-vdpa.c | 50 ++++++++++++++++++++++++++++++++++++++----------
>>   1 file changed, 40 insertions(+), 10 deletions(-)
>>
>> diff --git a/net/vhost-vdpa.c b/net/vhost-vdpa.c
>> index fe0ba19724..d06f38403f 100644
>> --- a/net/vhost-vdpa.c
>> +++ b/net/vhost-vdpa.c
>> @@ -609,15 +609,21 @@ static ssize_t vhost_vdpa_net_cvq_add(VhostVDPASta=
te *s,
>>               qemu_log_mask(LOG_GUEST_ERROR, "%s: No space on device que=
ue\n",
>>                             __func__);
>>           }
>> -        return r;
>>       }
>>
>> -    /*
>> -     * We can poll here since we've had BQL from the time we sent the
>> -     * descriptor. Also, we need to take the answer before SVQ pulls by=
 itself,
>> -     * when BQL is released
>> -     */
>> -    return vhost_svq_poll(svq, 1);
>> +    return r;
>> +}
>> +
>> +/*
>> + * Convenience wrapper to poll SVQ for multiple control commands.
>> + *
>> + * Caller should hold the BQL when invoking this function, and should t=
ake
>> + * the answer before SVQ pulls by itself when BQL is released.
>> + */
>> +static ssize_t vhost_vdpa_net_svq_poll(VhostVDPAState *s, size_t cmds_i=
n_flight)
>> +{
>> +    VhostShadowVirtqueue *svq =3D g_ptr_array_index(s->vhost_vdpa.shado=
w_vqs, 0);
>> +    return vhost_svq_poll(svq, cmds_in_flight);
>>   }
>>
>>   /* Convenience wrapper to get number of available SVQ descriptors */
>> @@ -645,6 +651,7 @@ static ssize_t vhost_vdpa_net_load_cmd(VhostVDPAStat=
e *s, uint8_t class,
>>           .iov_base =3D s->status,
>>           .iov_len =3D sizeof(*s->status),
>>       };
>> +    ssize_t r;
>>
>>       assert(data_size < vhost_vdpa_net_cvq_cmd_page_len() - sizeof(ctrl=
));
>>       /* Each CVQ command has one out descriptor and one in descriptor *=
/
>> @@ -657,7 +664,16 @@ static ssize_t vhost_vdpa_net_load_cmd(VhostVDPASta=
te *s, uint8_t class,
>>       iov_to_buf(data_sg, data_num, 0,
>>                  s->cvq_cmd_out_buffer + sizeof(ctrl), data_size);
>>
>> -    return vhost_vdpa_net_cvq_add(s, &out, 1, &in, 1);
>> +    r =3D vhost_vdpa_net_cvq_add(s, &out, 1, &in, 1);
>> +    if (unlikely(r < 0)) {
>> +        return r;
>> +    }
>> +
>> +    /*
>> +     * We can poll here since we've had BQL from the time
>> +     * we sent the descriptor.
>> +     */
>> +    return vhost_vdpa_net_svq_poll(s, 1);
>>   }
>>
>>   static int vhost_vdpa_net_load_mac(VhostVDPAState *s, const VirtIONet =
*n)
>> @@ -1152,6 +1168,12 @@ static int vhost_vdpa_net_excessive_mac_filter_cv=
q_add(VhostVDPAState *s,
>>       if (unlikely(r < 0)) {
>>           return r;
>>       }
>> +
>> +    /*
>> +     * We can poll here since we've had BQL from the time
>> +     * we sent the descriptor.
>> +     */
>> +    vhost_vdpa_net_svq_poll(s, 1);
>
> Don't we need to check the return value of vhost_vdpa_net_svq_poll here?

Hi Eugenio,

Yes, we should always check the return value of
vhost_vdpa_net_svq_poll(). I will fix this problem
in the v4 patch.

Thanks!


>
>>       if (*s->status !=3D VIRTIO_NET_OK) {
>>           return sizeof(*s->status);
>>       }
>> @@ -1266,10 +1288,18 @@ static int vhost_vdpa_net_handle_ctrl_avail(Vhos=
tShadowVirtqueue *svq,
>>               goto out;
>>           }
>>       } else {
>> -        dev_written =3D vhost_vdpa_net_cvq_add(s, &out, 1, &in, 1);
>> -        if (unlikely(dev_written < 0)) {
>> +        ssize_t r;
>> +        r =3D vhost_vdpa_net_cvq_add(s, &out, 1, &in, 1);
>> +        if (unlikely(r < 0)) {
>> +            dev_written =3D r;
>>               goto out;
>>           }
>> +
>> +        /*
>> +         * We can poll here since we've had BQL from the time
>> +         * we sent the descriptor.
>> +         */
>> +        dev_written =3D vhost_vdpa_net_svq_poll(s, 1);
>>       }
>>
>>       if (unlikely(dev_written < sizeof(status))) {
>> --
>> 2.25.1
>>
>


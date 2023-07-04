Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id AE6CE7466E0
	for <lists+qemu-devel@lfdr.de>; Tue,  4 Jul 2023 03:31:03 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qGUr2-0000Hw-NN; Mon, 03 Jul 2023 21:29:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yin31149@gmail.com>)
 id 1qGUqz-0000Hh-TU; Mon, 03 Jul 2023 21:29:17 -0400
Received: from mail-lf1-x133.google.com ([2a00:1450:4864:20::133])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <yin31149@gmail.com>)
 id 1qGUqy-0004jl-5Z; Mon, 03 Jul 2023 21:29:17 -0400
Received: by mail-lf1-x133.google.com with SMTP id
 2adb3069b0e04-4fba03becc6so5645006e87.0; 
 Mon, 03 Jul 2023 18:29:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1688434153; x=1691026153;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lJlFlVEk/xcuk45HxphwleXlup/H45gye03T44+tF6k=;
 b=K0ckVkanIvPsVl5MHtYrNjvPoiu5vQfXhktWC6sIWCEg5Jg8TFRSgWlL3EpyytYuo+
 9QVwJ4BjlGQJGGJIncZeDW4CoiiCmWK5+iQvRmYf0+GO7yMHLt4wfmTwwmA2iGLAl6ty
 E1TYezfLH2aJwHulApUxr9RJWwA4xIwjzsHUy1SUMZTKz+VBE+gVDNu9cLtmHmLc/dfZ
 N8v3Wk+FEc5maNhJPiW6gPHgSwhFQW8Malqsn2vVfX6A6y1JpTdUJFvHDBOzyUcC3HpH
 t1EKrVieE6lfvAAxc301ghM1W9Ijmx6LBU1pY8X0JZsUBdOgXuOn8hX6h4HFFRdkAzOc
 mLRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688434153; x=1691026153;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=lJlFlVEk/xcuk45HxphwleXlup/H45gye03T44+tF6k=;
 b=aV6SskN4wFdDCiBj0NaIj952T8yuGWNrRp+cYI/QGcEe79F+lKQ3yD1asdMd5UM6oM
 puL7VN6/l2ZzotmDMvCua62/EWUybpzeKUljhquhBazb4iN778MgCDcCCMrQRCJWf5lU
 6lRlp1XGkdzZWc8pTGihgGqawVW8eonCQOUZXbHCdcjwzoUkD8OryGuvGWzRN0WSmWqJ
 k34Lsq1wGwrqh5yWyW8cpTBWostLEkrAXcntvZSvfIjW5v7XWcfnO617NJEFC0F3CIHo
 MIdg1Fq9WOglIpPc1bwd3OIYPkA9AZaEL4+LZ5JXgKgX6n6NRqsAmW9wO+QCIaMZhgk+
 HvOQ==
X-Gm-Message-State: AC+VfDyj+DyLO0H+z8zR6SlijpoM0HcUEWdErgMO7PiWAZldenl9tJmj
 QOI0B+Mp3qA3YAgXc7mnuWZTnOCkCT6PnsOPfiQ=
X-Google-Smtp-Source: ACHHUZ4+ZV9fXfzDvZ70ptECOXN5/jjzVfxDwfxwkWqF6HP21Ghtyh/uJz6yAhCxy8Pb7SO8kEMpNYSyzMsZ9M8HMOY=
X-Received: by 2002:a05:6512:684:b0:4eb:4258:bf62 with SMTP id
 t4-20020a056512068400b004eb4258bf62mr5715782lfe.8.1688434153120; Mon, 03 Jul
 2023 18:29:13 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1686746406.git.yin31149@gmail.com>
 <07a1133d6c989394b342e35d8202257771e76769.1686746406.git.yin31149@gmail.com>
 <CAJaqyWeM9GmmRLtK50Z-UphWRv0u9OJkoJ3Dcvrz1BSiPNznew@mail.gmail.com>
In-Reply-To: <CAJaqyWeM9GmmRLtK50Z-UphWRv0u9OJkoJ3Dcvrz1BSiPNznew@mail.gmail.com>
From: Hawkins Jiawei <yin31149@gmail.com>
Date: Tue, 4 Jul 2023 09:28:59 +0800
Message-ID: <CAKrof1ODjFqeoX2x9LPMwGKbL1=7xRT2uTMqdSh94CUHeGOvxQ@mail.gmail.com>
Subject: Re: [PATCH RFC 1/1] vdpa: Return -EINVAL if device's ack is
 VIRTIO_NET_ERR
To: Eugenio Perez Martin <eperezma@redhat.com>
Cc: jasowang@redhat.com, mst@redhat.com, qemu-devel@nongnu.org, 
 qemu-stable@nongnu.org, 18801353760@163.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::133;
 envelope-from=yin31149@gmail.com; helo=mail-lf1-x133.google.com
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

On 2023/7/4 0:38, Eugenio Perez Martin wrote:
> On Wed, Jun 14, 2023 at 3:02=E2=80=AFPM Hawkins Jiawei <yin31149@gmail.co=
m> wrote:
>>
>> According to VirtIO standard, "The class, command and
>> command-specific-data are set by the driver,
>> and the device sets the ack byte.
>> There is little it can do except issue a diagnostic
>> if ack is not VIRTIO_NET_OK."
>>
>> Therefore, QEMU should stop sending the queued SVQ commands and
>> cancel the device startup if the device's ack is not VIRTIO_NET_OK.
>>
>> Yet the problem is that, vhost_vdpa_net_load_x() returns 1 based on
>> `*s->status !=3D VIRTIO_NET_OK` when the device's ack is VIRTIO_NET_ERR.
>> As a result, net->nc->info->load() also returns 1, this makes
>> vhost_net_start_one() incorrectly assume the device state is
>> successfully loaded by vhost_vdpa_net_load() and return 0, instead of
>> goto `fail` label to cancel the device startup, as vhost_net_start_one()
>> only cancels the device startup when net->nc->info->load() returns a
>> negative value.
>>
>> This patch fixes this problem by returning -EINVAL when the device's
>> ack is not VIRTIO_NET_OK.
>>
>> Fixes: f73c0c43ac ("vdpa: extract vhost_vdpa_net_load_mac from vhost_vdp=
a_net_load")
>> Fixes: f64c7cda69 ("vdpa: Add vhost_vdpa_net_load_mq")
>> Signed-off-by: Hawkins Jiawei <yin31149@gmail.com>
>
> Maybe we could split the fixes? Either way:

OK, I will split these fixes according to your suggestion.

Thanks!


>
> Acked-by: Eugenio P=C3=A9rez <eperezma@redhat.com>
>
> Thanks!
>
>> ---
>>   net/vhost-vdpa.c | 10 +++++++---
>>   1 file changed, 7 insertions(+), 3 deletions(-)
>>
>> diff --git a/net/vhost-vdpa.c b/net/vhost-vdpa.c
>> index 37cdc84562..630c9bf71e 100644
>> --- a/net/vhost-vdpa.c
>> +++ b/net/vhost-vdpa.c
>> @@ -651,8 +651,9 @@ static int vhost_vdpa_net_load_mac(VhostVDPAState *s=
, const VirtIONet *n)
>>           if (unlikely(dev_written < 0)) {
>>               return dev_written;
>>           }
>> -
>> -        return *s->status !=3D VIRTIO_NET_OK;
>> +        if (*s->status !=3D VIRTIO_NET_OK) {
>> +            return -EINVAL;
>> +        }
>>       }
>>
>>       return 0;
>> @@ -676,8 +677,11 @@ static int vhost_vdpa_net_load_mq(VhostVDPAState *s=
,
>>       if (unlikely(dev_written < 0)) {
>>           return dev_written;
>>       }
>> +    if (*s->status !=3D VIRTIO_NET_OK) {
>> +        return -EINVAL;
>> +    }
>>
>> -    return *s->status !=3D VIRTIO_NET_OK;
>> +    return 0;
>>   }
>>
>>   static int vhost_vdpa_net_load(NetClientState *nc)
>> --
>> 2.25.1
>>
>


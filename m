Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id AF29977F6AA
	for <lists+qemu-devel@lfdr.de>; Thu, 17 Aug 2023 14:47:23 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qWcP2-0005Xr-HY; Thu, 17 Aug 2023 08:47:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yin31149@gmail.com>)
 id 1qWcOy-0005Wv-QD
 for qemu-devel@nongnu.org; Thu, 17 Aug 2023 08:47:00 -0400
Received: from mail-lf1-x132.google.com ([2a00:1450:4864:20::132])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <yin31149@gmail.com>)
 id 1qWcOw-00015u-7v
 for qemu-devel@nongnu.org; Thu, 17 Aug 2023 08:47:00 -0400
Received: by mail-lf1-x132.google.com with SMTP id
 2adb3069b0e04-4fe2de785e7so12373441e87.1
 for <qemu-devel@nongnu.org>; Thu, 17 Aug 2023 05:46:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1692276416; x=1692881216;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wDzDDU0Ry0+TV41daXmqXgqafPhjmoyWvmSLcL2bW1Y=;
 b=HJ8mr+ZJz+ZAE6QJpGsSzFqX4ZzOGxtNybD1QaE0JOmJwh/h8NeMXjgYNDnjlwmBYZ
 4GQVe00e+ETiahkzy83AM8GegzsRVl7GUqJ0rIUqnWCEGNOGDkaOjLpZYdOor4nIx5X6
 jNqptwIsj1lKhAhnIsVvYj1m5/DtcQYPZyr+Sj1P9E/kSwk+q+mEGQSk/yrI3q68rB++
 ldGvlgs1k41CpFpkyYd7gN/45n80S6Um7rUFc8GyU+R++FysI4T7RPJMnqob/XurOtyY
 RGsNJkraCwu5OZ5x6L0gBDM7y8lVB+P4o2hrx1XQU+FHuEBF1ODw9MlY97ztC6jZ//ga
 f+EQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692276416; x=1692881216;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=wDzDDU0Ry0+TV41daXmqXgqafPhjmoyWvmSLcL2bW1Y=;
 b=SVJI1/OwGMCsuVYiRxzBbAdg1JGImFMTQgBu3R62v1SgOx+EzGDjr616ZYBX8YLotw
 E8iZ4Rqk18Y+jnPVpWHLRmhhyZKmKfJSnYEWuw9jg8bd1vzuifr7UlZxlZh2rA8jAGHg
 RaocJAnOY00JBJ+amzkrRNTpJpFeIiJ3wXxcN5CnzMKfErhN6ebkpHIlzd62lZsKTBgs
 Fovm1pPeh9Vs/bZDR5shzBGfPO4KiBxkmU8MIAmxwFNAFukps12P3+dF2QeDqUE95hSw
 4mQydczENcrFLBGjFlBZApKImfoLD/CEg53L7s7EU6+1fVLZXQIon2BMmv0NXd9yA6wM
 hxZw==
X-Gm-Message-State: AOJu0YyVdfq2tvBg2qrR9NiJuo12wxbTWGWApcWXF8ANZmotZAvFHJBb
 WO9fX6l2AsPPQPGdoA/QlPR0ttk19DcR5C+9cpg=
X-Google-Smtp-Source: AGHT+IFhjqwpq2xpq3ipf+F7eZajHRGsvpyUh5Npv6yUs8kmmZ78wZuR3wpYqnAuv/uvaKdKiwgR0iPRfgdLvS4tuuw=
X-Received: by 2002:ac2:4822:0:b0:4f8:7614:48a5 with SMTP id
 2-20020ac24822000000b004f8761448a5mr3251720lft.66.1692276415270; Thu, 17 Aug
 2023 05:46:55 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1688743107.git.yin31149@gmail.com>
 <4b9550c14bc8c98c8f48e04dbf3d3ac41489d3fd.1688743107.git.yin31149@gmail.com>
 <CAJaqyWeWuXn5=OvW99cgnniaZyW=wSp2EutxzROE5Xnp=xvjQw@mail.gmail.com>
In-Reply-To: <CAJaqyWeWuXn5=OvW99cgnniaZyW=wSp2EutxzROE5Xnp=xvjQw@mail.gmail.com>
From: Hawkins Jiawei <yin31149@gmail.com>
Date: Thu, 17 Aug 2023 20:46:43 +0800
Message-ID: <CAKrof1NJx-KAKs60-r06tL0KRL7UxiK7A3WhphGrwE-okk0gew@mail.gmail.com>
Subject: Re: [PATCH v3 2/7] vdpa: Restore MAC address filtering state
To: Eugenio Perez Martin <eperezma@redhat.com>
Cc: jasowang@redhat.com, mst@redhat.com, qemu-devel@nongnu.org, 
 18801353760@163.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::132;
 envelope-from=yin31149@gmail.com; helo=mail-lf1-x132.google.com
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

On 2023/8/17 18:18, Eugenio Perez Martin wrote:
> On Fri, Jul 7, 2023 at 5:27=E2=80=AFPM Hawkins Jiawei <yin31149@gmail.com=
> wrote:
>>
>> This patch refactors vhost_vdpa_net_load_mac() to
>> restore the MAC address filtering state at device's startup.
>>
>> Signed-off-by: Hawkins Jiawei <yin31149@gmail.com>
>> ---
>> v3:
>>    - return early if mismatch the condition suggested by Eugenio
>>
>> v2: https://lore.kernel.org/all/2f2560f749186c0eb1055f9926f464587e419eeb=
.1688051252.git.yin31149@gmail.com/
>>    - use iovec suggested by Eugenio
>>    - avoid sending CVQ command in default state
>>
>> v1: https://lore.kernel.org/all/00f72fe154a882fd6dc15bc39e3a1ac63f9dadce=
.1687402580.git.yin31149@gmail.com/
>>
>>   net/vhost-vdpa.c | 52 ++++++++++++++++++++++++++++++++++++++++++++++++
>>   1 file changed, 52 insertions(+)
>>
>> diff --git a/net/vhost-vdpa.c b/net/vhost-vdpa.c
>> index 31ef6ad6ec..7189ccafaf 100644
>> --- a/net/vhost-vdpa.c
>> +++ b/net/vhost-vdpa.c
>> @@ -660,6 +660,58 @@ static int vhost_vdpa_net_load_mac(VhostVDPAState *=
s, const VirtIONet *n)
>>           }
>>       }
>>
>> +    /*
>> +     * According to VirtIO standard, "The device MUST have an
>> +     * empty MAC filtering table on reset.".
>> +     *
>> +     * Therefore, there is no need to send this CVQ command if the
>> +     * driver also sets an empty MAC filter table, which aligns with
>> +     * the device's defaults.
>> +     *
>> +     * Note that the device's defaults can mismatch the driver's
>> +     * configuration only at live migration.
>> +     */
>> +    if (!virtio_vdev_has_feature(&n->parent_obj, VIRTIO_NET_F_CTRL_RX) =
||
>> +        n->mac_table.in_use =3D=3D 0) {
>> +        return 0;
>> +    }
>> +
>> +    uint32_t uni_entries =3D n->mac_table.first_multi,
>
> QEMU coding style prefers declarations at the beginning of the code
> block. Previous uses of these variable names would need to be
> refactored to met this rule.

Hi Eugenio,

Thanks for the detailed explanation.

Since this patch series has already been merged into master, I will
submit a separate patch to correct this problem.

I will take care of this problem in the future.

Thanks!


>
> Apart from that,
>
> Acked-by: Eugenio P=C3=A9rez <eperezma@redhat.com>
>
>> +             uni_macs_size =3D uni_entries * ETH_ALEN,
>> +             mul_entries =3D n->mac_table.in_use - uni_entries,
>> +             mul_macs_size =3D mul_entries * ETH_ALEN;
>> +    struct virtio_net_ctrl_mac uni =3D {
>> +        .entries =3D cpu_to_le32(uni_entries),
>> +    };
>> +    struct virtio_net_ctrl_mac mul =3D {
>> +        .entries =3D cpu_to_le32(mul_entries),
>> +    };
>> +    const struct iovec data[] =3D {
>> +        {
>> +            .iov_base =3D &uni,
>> +            .iov_len =3D sizeof(uni),
>> +        }, {
>> +            .iov_base =3D n->mac_table.macs,
>> +            .iov_len =3D uni_macs_size,
>> +        }, {
>> +            .iov_base =3D &mul,
>> +            .iov_len =3D sizeof(mul),
>> +        }, {
>> +            .iov_base =3D &n->mac_table.macs[uni_macs_size],
>> +            .iov_len =3D mul_macs_size,
>> +        },
>> +    };
>> +    ssize_t dev_written =3D vhost_vdpa_net_load_cmd(s,
>> +                                VIRTIO_NET_CTRL_MAC,
>> +                                VIRTIO_NET_CTRL_MAC_TABLE_SET,
>> +                                data, ARRAY_SIZE(data));
>> +    if (unlikely(dev_written < 0)) {
>> +        return dev_written;
>> +    }
>> +    if (*s->status !=3D VIRTIO_NET_OK) {
>> +        return -EIO;
>> +    }
>> +
>>       return 0;
>>   }
>>
>> --
>> 2.25.1
>>
>


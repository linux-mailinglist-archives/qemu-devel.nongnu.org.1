Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id ECD817D2360
	for <lists+qemu-devel@lfdr.de>; Sun, 22 Oct 2023 16:35:28 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1quZWR-0002LW-DP; Sun, 22 Oct 2023 10:33:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yin31149@gmail.com>)
 id 1quZWO-0002HN-MI
 for qemu-devel@nongnu.org; Sun, 22 Oct 2023 10:33:40 -0400
Received: from mail-lf1-x132.google.com ([2a00:1450:4864:20::132])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <yin31149@gmail.com>)
 id 1quZWM-0003tb-JS
 for qemu-devel@nongnu.org; Sun, 22 Oct 2023 10:33:40 -0400
Received: by mail-lf1-x132.google.com with SMTP id
 2adb3069b0e04-507a0907896so3508092e87.2
 for <qemu-devel@nongnu.org>; Sun, 22 Oct 2023 07:33:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1697985217; x=1698590017; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3TOxX7Clc2brGwicCRXkvMYCgtCK8527p4vfyY6j5nw=;
 b=KbKwLZURMBfCKHfHrxc2ureiiLmuMGc622CF36M9i1OD9oUnJKWBCT7kCe8pB2kC0G
 tCbi9zeyjUBinZh3GHU57qdCwOZj9ErSGB6wE6MWEi/h+9L9JKbD5y/O6eAXahFarOST
 sQdvFhw/odaEvk1Wh75oqelhG0oFdxRhrWIBjsZiND3YEOW8PTBgSUX67TwSCO+Nh/zx
 maT5nMTVcMnmrDUn3sFmLo2HyPlCw3XyH3Ynmzq9cOiuyQ63OaK9uEYASd3Xdg2N1zrd
 aeJp/PTSBQFuwk9d2+yfdDmNzteZ1qFqyiPe5FCJv9CKld2COPePUD0agkN2vjnx+OrO
 CCTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697985217; x=1698590017;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=3TOxX7Clc2brGwicCRXkvMYCgtCK8527p4vfyY6j5nw=;
 b=XNAQVdcceDBfDKPKmf3NXqrnd+hTsnJYF5Lky7aNcSTidZK3bTtGFqtRSzBv+oHM0A
 v1QR3aYP16i2qJHEwsTeLhl2FaIEPF9vTWzTzz/ZJ0USZR/pmOw2yaD3AMCaqLL5nm6p
 USNsm7uBqBaDfB0GWSgsJddFIqiv7v9a0XY+te+wlRY0fueZ5c+69bw2HJ88GcI5yeTw
 gV4iO+QKa/fXpolnep+qlJLh8k66bvGM9P7MRvurkvHjliLQD45BPs6v7UU6zVrYwqME
 VHsbsOIZLDNqC16Lo3HrwgfNtRXhotZloov598jHAORv8XYgZ9W6WrP9iup+1iPhpcSQ
 bmRQ==
X-Gm-Message-State: AOJu0YyKe5GIPAU5iFxlrwHtAi0iJ7bs7LsPW1cO0iBNWdKlucTsunqF
 W5eU4+/331NqtktcywqbqJ4WFq6Y2G1pY0KD4NI=
X-Google-Smtp-Source: AGHT+IGYqpYKkx0nCBubLX3IFDXR4EdJh/sAz0BtBIr+eO5phczJfZrylTIaHyBwbeHlykaFxWVtaw0Wslbe1pAkdBY=
X-Received: by 2002:a05:6512:41d:b0:504:7ff8:3430 with SMTP id
 u29-20020a056512041d00b005047ff83430mr4697678lfk.10.1697985216055; Sun, 22
 Oct 2023 07:33:36 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1697902949.git.yin31149@gmail.com>
 <b7cd0c8d6a58b16b086f11714d2908ad35c67caa.1697902949.git.yin31149@gmail.com>
 <20231022055541-mutt-send-email-mst@kernel.org>
In-Reply-To: <20231022055541-mutt-send-email-mst@kernel.org>
From: Hawkins Jiawei <yin31149@gmail.com>
Date: Sun, 22 Oct 2023 22:33:24 +0800
Message-ID: <CAKrof1MaQeaU=VhSm2oncaMb--H2vyAKdQpYCU-G43R2XkdFzw@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] vdpa: Restore hash calculation state
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: jasowang@redhat.com, eperezma@redhat.com, qemu-devel@nongnu.org, 
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

=E5=9C=A8 2023/10/22 18:00, Michael S. Tsirkin =E5=86=99=E9=81=93:
> On Sun, Oct 22, 2023 at 10:00:48AM +0800, Hawkins Jiawei wrote:
>> This patch introduces vhost_vdpa_net_load_rss() to restore
>> the hash calculation state at device's startup.
>>
>> Signed-off-by: Hawkins Jiawei <yin31149@gmail.com>
>> ---
>> v3:
>>    - remove the `do_rss` argument in vhost_vdpa_net_load_rss()
>>    - zero reserved fields in "cfg" manually instead of using memset()
>> to prevent compiler "array-bounds" warning
>>
>> v2: https://lore.kernel.org/all/f5ffad10699001107022851e0560cb394039d6b0=
.1693297766.git.yin31149@gmail.com/
>>    - resolve conflict with updated patch
>> "vdpa: Send all CVQ state load commands in parallel"
>>    - move the `table` declaration at the beginning of the
>> vhost_vdpa_net_load_rss()
>>
>> RFC: https://lore.kernel.org/all/a54ca70b12ebe2f3c391864e41241697ab1aba3=
0.1691762906.git.yin31149@gmail.com/
>>
>>   net/vhost-vdpa.c | 89 ++++++++++++++++++++++++++++++++++++++++++++++++
>>   1 file changed, 89 insertions(+)
>>
>> diff --git a/net/vhost-vdpa.c b/net/vhost-vdpa.c
>> index 4b7c3b81b8..2e4bad65b4 100644
>> --- a/net/vhost-vdpa.c
>> +++ b/net/vhost-vdpa.c
>> @@ -817,6 +817,86 @@ static int vhost_vdpa_net_load_mac(VhostVDPAState *=
s, const VirtIONet *n,
>>       return 0;
>>   }
>>
>> +static int vhost_vdpa_net_load_rss(VhostVDPAState *s, const VirtIONet *=
n,
>> +                                   struct iovec *out_cursor,
>> +                                   struct iovec *in_cursor)
>> +{
>> +    struct virtio_net_rss_config cfg;
>> +    ssize_t r;
>> +    g_autofree uint16_t *table =3D NULL;
>> +
>> +    /*
>> +     * According to VirtIO standard, "Initially the device has all hash
>> +     * types disabled and reports only VIRTIO_NET_HASH_REPORT_NONE.".
>> +     *
>> +     * Therefore, there is no need to send this CVQ command if the
>> +     * driver disable the all hash types, which aligns with
>
> disables? or disabled

It should be "disables".
I will correct this in the v4 patch.

>
>> +     * the device's defaults.
>> +     *
>> +     * Note that the device's defaults can mismatch the driver's
>> +     * configuration only at live migration.
>> +     */
>> +    if (!n->rss_data.enabled ||
>> +        n->rss_data.hash_types =3D=3D VIRTIO_NET_HASH_REPORT_NONE) {
>> +        return 0;
>> +    }
>> +
>> +    table =3D g_malloc_n(n->rss_data.indirections_len,
>> +                       sizeof(n->rss_data.indirections_table[0]));
>> +    cfg.hash_types =3D cpu_to_le32(n->rss_data.hash_types);
>> +
>> +    /*
>> +     * According to VirtIO standard, "Field reserved MUST contain zeroe=
s.
>> +     * It is defined to make the structure to match the layout of
>> +     * virtio_net_rss_config structure, defined in 5.1.6.5.7.".
>> +     *
>> +     * Therefore, we need to zero the fields in struct virtio_net_rss_c=
onfig,
>> +     * which corresponds the `reserved` field in
>
> corresponds to

I will correct this in the v4 patch.

>
>> +     * struct virtio_net_hash_config.
>> +     */
>> +    cfg.indirection_table_mask =3D 0;
>> +    cfg.unclassified_queue =3D 0;
>> +    table[0] =3D 0; /* the actual indirection table for cfg */
>> +    cfg.max_tx_vq =3D 0;
>
> Wouldn't it be easier to just do cfg =3D {} where it is defined?

Normally, it should follow your pattern, but there are two reasons why
I'm doing it in a different way here.

Firstly, in the subsequent patchset, both hash calculation and rss will
reuse vhost_vdpa_net_load_rss() to restore their state. Given the
similarity of their CVQ commands, if we only explicitly handle the
fields assignment for rss case, while placing the hash calculation field
assignment at the definition site, it would disperse the logic within
the function, making it look odd.

Secondly, to ensure compatibility for rss case, we cannot use the
'indirection_table' field in the cfg. Instead, we need to allocate a
separate 'table' variable here. Even if we initialize the other fields
of the hash calculation case at the definition site, we still need to
manually set 'table' to 0 here. Hence, it makes more sense to set
everything together at this point.

But I am okay if you think it is better to place the field assignment
for the hash calculation case at the definition site.

>
>> +
>> +    /*
>> +     * Consider that virtio_net_handle_rss() currently does not restore=
 the
>> +     * hash key length parsed from the CVQ command sent from the guest =
into
>> +     * n->rss_data and uses the maximum key length in other code, so we=
 also
>> +     * employthe the maxium key length here.
>
> two typos

I will correct these typos in the v4 patch.

>
>> +     */
>> +    cfg.hash_key_length =3D sizeof(n->rss_data.key);
>> +
>> +    const struct iovec data[] =3D {
>> +        {
>> +            .iov_base =3D &cfg,
>> +            .iov_len =3D offsetof(struct virtio_net_rss_config,
>> +                                indirection_table),
>> +        }, {
>> +            .iov_base =3D table,
>> +            .iov_len =3D n->rss_data.indirections_len *
>> +                       sizeof(n->rss_data.indirections_table[0]),
>> +        }, {
>> +            .iov_base =3D &cfg.max_tx_vq,
>> +            .iov_len =3D offsetof(struct virtio_net_rss_config, hash_ke=
y_data) -
>> +                       offsetof(struct virtio_net_rss_config, max_tx_vq=
),
>> +        }, {
>> +            .iov_base =3D (void *)n->rss_data.key,
>
> cast to void * should not be needed here.

Without this cast, the compiler raises the following warning:

../net/vhost-vdpa.c: In function =E2=80=98vhost_vdpa_net_load_rss=E2=80=99:
../net/vhost-vdpa.c:907:25: error: initialization discards =E2=80=98const=
=E2=80=99
qualifier from pointer target type [-Werror=3Ddiscarded-qualifiers]
   907 |             .iov_base =3D n->rss_data.key,


The issue arises because `n` is a pointer to const, and
`n->rss_data.key` is an array. So `n->rss_data.key` is treated as a
pointer to const.

Thanks!


>
>> +            .iov_len =3D sizeof(n->rss_data.key),
>> +        }
>> +    };
>> +
>> +    r =3D vhost_vdpa_net_load_cmd(s, out_cursor, in_cursor,
>> +                                VIRTIO_NET_CTRL_MQ,
>> +                                VIRTIO_NET_CTRL_MQ_HASH_CONFIG,
>> +                                data, ARRAY_SIZE(data));
>> +    if (unlikely(r < 0)) {
>> +        return r;
>> +    }
>> +
>> +    return 0;
>> +}
>> +
>>   static int vhost_vdpa_net_load_mq(VhostVDPAState *s,
>>                                     const VirtIONet *n,
>>                                     struct iovec *out_cursor,
>> @@ -842,6 +922,15 @@ static int vhost_vdpa_net_load_mq(VhostVDPAState *s=
,
>>           return r;
>>       }
>>
>> +    if (!virtio_vdev_has_feature(&n->parent_obj, VIRTIO_NET_F_HASH_REPO=
RT)) {
>> +        return 0;
>> +    }
>> +
>> +    r =3D vhost_vdpa_net_load_rss(s, n, out_cursor, in_cursor);
>> +    if (unlikely(r < 0)) {
>> +        return r;
>> +    }
>> +
>>       return 0;
>>   }
>>
>> --
>> 2.25.1
>


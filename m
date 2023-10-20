Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D7DCF7D05F9
	for <lists+qemu-devel@lfdr.de>; Fri, 20 Oct 2023 03:00:23 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qtdqf-0003my-Bh; Thu, 19 Oct 2023 20:58:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yin31149@gmail.com>)
 id 1qtdqd-0003mp-GZ
 for qemu-devel@nongnu.org; Thu, 19 Oct 2023 20:58:43 -0400
Received: from mail-lj1-x22e.google.com ([2a00:1450:4864:20::22e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <yin31149@gmail.com>)
 id 1qtdqb-0007QB-Fx
 for qemu-devel@nongnu.org; Thu, 19 Oct 2023 20:58:43 -0400
Received: by mail-lj1-x22e.google.com with SMTP id
 38308e7fff4ca-2c5210a1515so4509941fa.0
 for <qemu-devel@nongnu.org>; Thu, 19 Oct 2023 17:58:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1697763519; x=1698368319; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wDAzEX3h4x5x45OCsxaYH168+2QhwVgjx2z37xN2yqA=;
 b=ASGMxdUg83J3U1LRWF3pea/Wt1YcoNFhGmBCR7PyDeov4+pmqa6BK4234GNqeKFQvD
 SSn648YBM9oVAzYIXnUUhQRd7n34qYuLy9VBiyJcU6NpTeLROqNFBbve2lrFoUUhwMDR
 FvmQN+BHZwg8vO99d2rU2Ljq2mOAdM53U98uqo9pkp8RQQh+AJhL8tsDNvwLnYMOg4x2
 FO3FTtxNwcuWe2gFOL+EeBUgNg1bICrQPUMyOuxOyo3+lYIafr4XhA6z0U6pl6bKuhhd
 uL++8bVvDj5zYb71AcuLRd0UUALZv5L7U/Y5iq/6DWm75sHomYXir0zexgHbM52BA7kk
 0DRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697763519; x=1698368319;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=wDAzEX3h4x5x45OCsxaYH168+2QhwVgjx2z37xN2yqA=;
 b=qmu0qkFnaET079EmnDf0ypbcTlTKwkvf6mAD2hy/w2w8xCK9F3D0IVBxd6zgmH+OE4
 6N4EF5w69fxSTx0zrP8zqs+oxfvm7zhq3aSRrBojkMuHi644UNipUQZfBDoKqBbDO6Bg
 iIgOE5JECO0W7xn8AUhdEvjuyy9cEEDLbvMLLdpwtu3g95k/QHteRb09sq0g/tmspn3h
 4cjFTQKC5ptziLMHVYIxc76cldAjDC7GIinZqZIESuNO/YvuM0oIeFBmqxFDVfpMa+3O
 ZPYp/SfBl6DQeeP+Jx+Yad3uK4iYqe4V5sCNABQsjWKrctfYZwuUYJwGapy/ZtmOel33
 qGGA==
X-Gm-Message-State: AOJu0YzZXmqPWODZybpDXAJfQZOE1N/ppLjr2+eR54BpwyYzAaCZiRwY
 OzThLiTjsLyUIl9+00nWHr4EMClGD6IZzISsHOI=
X-Google-Smtp-Source: AGHT+IHHxQmrK5wr4Ul/az7lcNhGBBApx/lsFR1hf2u4q68S7YGUAITXkhvHdtNHpR7DEoMGIz/9TzAfGLUFg7TZt0w=
X-Received: by 2002:a19:ee14:0:b0:507:9a64:adf0 with SMTP id
 g20-20020a19ee14000000b005079a64adf0mr212898lfb.10.1697763518266; Thu, 19 Oct
 2023 17:58:38 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1697644299.git.mst@redhat.com>
 <1908cfd6e1748d94680e468b9df6321087b8fcf2.1697644299.git.mst@redhat.com>
 <CAJSP0QVTi2QxMdzmPoPF2w5xm-r19W_0GtTaqJzGnoibT9iDNg@mail.gmail.com>
 <20231019140406-mutt-send-email-mst@kernel.org>
In-Reply-To: <20231019140406-mutt-send-email-mst@kernel.org>
From: Hawkins Jiawei <yin31149@gmail.com>
Date: Fri, 20 Oct 2023 08:58:26 +0800
Message-ID: <CAKrof1MQ-aEf4Zjregcnuv0yw886E2F=-g+ApmjtXZLYvEdXsQ@mail.gmail.com>
Subject: Re: [PULL 08/83] vdpa: Restore hash calculation state
To: "Michael S. Tsirkin" <mst@redhat.com>, Stefan Hajnoczi <stefanha@gmail.com>
Cc: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>, 
 Jason Wang <jasowang@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::22e;
 envelope-from=yin31149@gmail.com; helo=mail-lj1-x22e.google.com
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

=E5=9C=A8 2023/10/20 02:07, Michael S. Tsirkin =E5=86=99=E9=81=93:
> On Thu, Oct 19, 2023 at 09:32:28AM -0700, Stefan Hajnoczi wrote:
>> On Wed, 18 Oct 2023 at 08:56, Michael S. Tsirkin <mst@redhat.com> wrote:
>>>
>>> From: Hawkins Jiawei <yin31149@gmail.com>
>>>
>>> This patch introduces vhost_vdpa_net_load_rss() to restore
>>> the hash calculation state at device's startup.
>>>
>>> Note that vhost_vdpa_net_load_rss() has `do_rss` argument,
>>> which allows future code to reuse this function to restore
>>> the receive-side scaling state when the VIRTIO_NET_F_RSS
>>> feature is enabled in SVQ. Currently, vhost_vdpa_net_load_rss()
>>> could only be invoked when `do_rss` is set to false.
>>>
>>> Signed-off-by: Hawkins Jiawei <yin31149@gmail.com>
>>> Message-Id: <f5ffad10699001107022851e0560cb394039d6b0.1693297766.git.yi=
n31149@gmail.com>
>>> Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
>>> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
>>> ---
>>>   net/vhost-vdpa.c | 91 +++++++++++++++++++++++++++++++++++++++++++++++=
+
>>>   1 file changed, 91 insertions(+)
>>>
>>> diff --git a/net/vhost-vdpa.c b/net/vhost-vdpa.c
>>> index 4b7c3b81b8..40d0bcbc0b 100644
>>> --- a/net/vhost-vdpa.c
>>> +++ b/net/vhost-vdpa.c
>>> @@ -817,6 +817,88 @@ static int vhost_vdpa_net_load_mac(VhostVDPAState =
*s, const VirtIONet *n,
>>>       return 0;
>>>   }
>>>
>>> +static int vhost_vdpa_net_load_rss(VhostVDPAState *s, const VirtIONet =
*n,
>>> +                                   struct iovec *out_cursor,
>>> +                                   struct iovec *in_cursor, bool do_rs=
s)
>>> +{
>>> +    struct virtio_net_rss_config cfg;
>>> +    ssize_t r;
>>> +    g_autofree uint16_t *table =3D NULL;
>>> +
>>> +    /*
>>> +     * According to VirtIO standard, "Initially the device has all has=
h
>>> +     * types disabled and reports only VIRTIO_NET_HASH_REPORT_NONE.".
>>> +     *
>>> +     * Therefore, there is no need to send this CVQ command if the
>>> +     * driver disable the all hash types, which aligns with
>>> +     * the device's defaults.
>>> +     *
>>> +     * Note that the device's defaults can mismatch the driver's
>>> +     * configuration only at live migration.
>>> +     */
>>> +    if (!n->rss_data.enabled ||
>>> +        n->rss_data.hash_types =3D=3D VIRTIO_NET_HASH_REPORT_NONE) {
>>> +        return 0;
>>> +    }
>>> +
>>> +    cfg.hash_types =3D cpu_to_le32(n->rss_data.hash_types);
>>> +
>>> +    /*
>>> +     * According to VirtIO standard, "Field reserved MUST contain zero=
es.
>>> +     * It is defined to make the structure to match the layout of
>>> +     * virtio_net_rss_config structure, defined in 5.1.6.5.7.".
>>> +     *
>>> +     * Therefore, we need to zero the fields in struct virtio_net_rss_=
config,
>>> +     * which corresponds the `reserved` field in
>>> +     * struct virtio_net_hash_config.
>>> +     */
>>> +    memset(&cfg.indirection_table_mask, 0,
>>> +           sizeof_field(struct virtio_net_hash_config, reserved));
>>
>> Please take a look at the following CI failure:
>>
>> In file included from /usr/include/string.h:495,
>> from /home/gitlab-runner/builds/-LCfcJ2T/0/qemu-project/qemu/include/qem=
u/osdep.h:116,
>> from ../net/vhost-vdpa.c:12:
>> In function =E2=80=98memset=E2=80=99,
>> inlined from =E2=80=98vhost_vdpa_net_load_rss=E2=80=99 at ../net/vhost-v=
dpa.c:874:9:
>> /usr/include/s390x-linux-gnu/bits/string_fortified.h:71:10: error:
>> =E2=80=98__builtin_memset=E2=80=99 offset [7, 12] from the object at =E2=
=80=98cfg=E2=80=99 is out of
>> the bounds of referenced subobject =E2=80=98indirection_table_mask=E2=80=
=99 with type
>> =E2=80=98short unsigned int=E2=80=99 at offset 4 [-Werror=3Darray-bounds=
]
>> 71 | return __builtin___memset_chk (__dest, __ch, __len, __bos0 (__dest)=
);
>> | ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>> cc1: all warnings being treated as errors
>>
>> https://gitlab.com/qemu-project/qemu/-/jobs/5329820077
>
> Hmm yes - the trick it's trying to implement is this:
>
>
> struct virtio_net_rss_config {
>          uint32_t hash_types;
>          uint16_t indirection_table_mask;
>          uint16_t unclassified_queue;
>          uint16_t indirection_table[1/* + indirection_table_mask */];
>          uint16_t max_tx_vq;
>          uint8_t hash_key_length;
>          uint8_t hash_key_data[/* hash_key_length */];
> };
>
>
> ...
>
> struct virtio_net_hash_config {
>          uint32_t hash_types;
>          /* for compatibility with virtio_net_rss_config */
>          uint16_t reserved[4];
>          uint8_t hash_key_length;
>          uint8_t hash_key_data[/* hash_key_length */];
> };
>
>
> as you see layout matches.
>
>
>
> Using a union is probably the right way to address this.

How about manually resetting these fields to zero instead of
using memset()?

This is how it's handled in "virtio_net.c" for the Linux kernel,
perhaps we can maintain consistency this way.

Thanks!


>
>
> Dropped for now, thanks!
>
>
>
>>> +
>>> +    table =3D g_malloc_n(n->rss_data.indirections_len,
>>> +                       sizeof(n->rss_data.indirections_table[0]));
>>> +    for (int i =3D 0; i < n->rss_data.indirections_len; ++i) {
>>> +        table[i] =3D cpu_to_le16(n->rss_data.indirections_table[i]);
>>> +    }
>>> +
>>> +    /*
>>> +     * Consider that virtio_net_handle_rss() currently does not restor=
e the
>>> +     * hash key length parsed from the CVQ command sent from the guest=
 into
>>> +     * n->rss_data and uses the maximum key length in other code, so w=
e also
>>> +     * employthe the maxium key length here.
>>> +     */
>>> +    cfg.hash_key_length =3D sizeof(n->rss_data.key);
>>> +
>>> +    const struct iovec data[] =3D {
>>> +        {
>>> +            .iov_base =3D &cfg,
>>> +            .iov_len =3D offsetof(struct virtio_net_rss_config,
>>> +                                indirection_table),
>>> +        }, {
>>> +            .iov_base =3D table,
>>> +            .iov_len =3D n->rss_data.indirections_len *
>>> +                       sizeof(n->rss_data.indirections_table[0]),
>>> +        }, {
>>> +            .iov_base =3D &cfg.max_tx_vq,
>>> +            .iov_len =3D offsetof(struct virtio_net_rss_config, hash_k=
ey_data) -
>>> +                       offsetof(struct virtio_net_rss_config, max_tx_v=
q),
>>> +        }, {
>>> +            .iov_base =3D (void *)n->rss_data.key,
>>> +            .iov_len =3D sizeof(n->rss_data.key),
>>> +        }
>>> +    };
>>> +
>>> +    r =3D vhost_vdpa_net_load_cmd(s, out_cursor, in_cursor,
>>> +                                VIRTIO_NET_CTRL_MQ,
>>> +                                VIRTIO_NET_CTRL_MQ_HASH_CONFIG,
>>> +                                data, ARRAY_SIZE(data));
>>> +    if (unlikely(r < 0)) {
>>> +        return r;
>>> +    }
>>> +
>>> +    return 0;
>>> +}
>>> +
>>>   static int vhost_vdpa_net_load_mq(VhostVDPAState *s,
>>>                                     const VirtIONet *n,
>>>                                     struct iovec *out_cursor,
>>> @@ -842,6 +924,15 @@ static int vhost_vdpa_net_load_mq(VhostVDPAState *=
s,
>>>           return r;
>>>       }
>>>
>>> +    if (!virtio_vdev_has_feature(&n->parent_obj, VIRTIO_NET_F_HASH_REP=
ORT)) {
>>> +        return 0;
>>> +    }
>>> +
>>> +    r =3D vhost_vdpa_net_load_rss(s, n, out_cursor, in_cursor, false);
>>> +    if (unlikely(r < 0)) {
>>> +        return r;
>>> +    }
>>> +
>>>       return 0;
>>>   }
>>>
>>> --
>>> MST
>>>
>>>
>


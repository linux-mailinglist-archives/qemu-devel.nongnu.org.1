Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B9A067E0490
	for <lists+qemu-devel@lfdr.de>; Fri,  3 Nov 2023 15:19:35 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qyv0d-0003Bp-SF; Fri, 03 Nov 2023 10:18:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1qyv0a-0003B7-67
 for qemu-devel@nongnu.org; Fri, 03 Nov 2023 10:18:48 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1qyv0Y-0002ZG-DJ
 for qemu-devel@nongnu.org; Fri, 03 Nov 2023 10:18:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1699021124;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=or69juIUzGr/Dr2IdAH2detajWJpJfYzJg/yx30M2WY=;
 b=doT1wWXO1vTzzLRyP3mwHg6eW8YgnaMXH/Vwdi8nbkRRDK+mlSTYb2vvDZzR6bIrBwIWeA
 Z/NuRA/sW4nfr5ghe/H58bxR6NsLAB5G7W78NR8DAVkR0ysEQFKmVfJDK2AEX7l1maJvGw
 Ws/ljX5Rl1QPFvwJ3wcgigPtkzntG6Y=
Received: from mail-yb1-f198.google.com (mail-yb1-f198.google.com
 [209.85.219.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-642-OEw4tO59Nxe9_eUSix6Abw-1; Fri, 03 Nov 2023 10:18:43 -0400
X-MC-Unique: OEw4tO59Nxe9_eUSix6Abw-1
Received: by mail-yb1-f198.google.com with SMTP id
 3f1490d57ef6-d86766bba9fso1224486276.1
 for <qemu-devel@nongnu.org>; Fri, 03 Nov 2023 07:18:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699021123; x=1699625923;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=or69juIUzGr/Dr2IdAH2detajWJpJfYzJg/yx30M2WY=;
 b=Zn2gGnBAGKFzEkOpswugMknYrCas1FEOcMT6dQkj2dmbkP8qBSaG+PzrlA3Bkicv+C
 zEu7HWMdS276B903Z0Pqlh7G0wOLnmAL7cinYPZbblmiMIib6L6aSk7tOyh0gvVVPXw0
 d0H9oUQvk4uZ85RrSkFyoaBq8Gdq7KCA9evSV6HiQdSbNNUFmmjizEJBCphiI5bcalh4
 hbBq/YXFhQnx7+djta4AjRKPgyo0K9ulBhX6X3znO4VclJPCiUUMYnqMG8Fa2yXkrI7Y
 7Ig8rSuOCIxwAGrzjudHZg2fC1cFgH2O+DAjey5AYy0GZ3icPws1H/IAOkzI3GybYSS6
 l3vQ==
X-Gm-Message-State: AOJu0Ywr/SXsQCIq1oYF0ZRU5nMF5PxEDgxVWdG8wELw5W5F44SyAMj+
 yM6qMHQPAm+u82OSiirKEzLn/SbYwFspVoIjaBYtXQ6hnOlt6H1mZmBRFEJk3i2BFWSN2DupnuN
 YiG/eXOWqnkfT2qB9XMRpFFch99osPvs=
X-Received: by 2002:a25:bcb:0:b0:da0:88a1:1e64 with SMTP id
 194-20020a250bcb000000b00da088a11e64mr20758701ybl.40.1699021122965; 
 Fri, 03 Nov 2023 07:18:42 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFhhO8uhc6QliZ9PTxwTgSc8eu+NtvJWfwWvA1UUzKJyauSTep8SKpFbeIDNyDnqfQRziNjyAIaSpFS2FsTHD0=
X-Received: by 2002:a25:bcb:0:b0:da0:88a1:1e64 with SMTP id
 194-20020a250bcb000000b00da088a11e64mr20758682ybl.40.1699021122646; Fri, 03
 Nov 2023 07:18:42 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1698194366.git.yin31149@gmail.com>
 <dbf699acff8c226596136a55a6abe35ebfeac8b0.1698194366.git.yin31149@gmail.com>
In-Reply-To: <dbf699acff8c226596136a55a6abe35ebfeac8b0.1698194366.git.yin31149@gmail.com>
From: Eugenio Perez Martin <eperezma@redhat.com>
Date: Fri, 3 Nov 2023 15:18:06 +0100
Message-ID: <CAJaqyWep4TWqA9qNu8HFbGp0LJ-_Zq_RupfH2rMouLj=PZzNEg@mail.gmail.com>
Subject: Re: [PATCH v4 1/2] vdpa: Restore hash calculation state
To: Hawkins Jiawei <yin31149@gmail.com>
Cc: jasowang@redhat.com, mst@redhat.com, qemu-devel@nongnu.org, 
 18801353760@163.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=eperezma@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.47,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SORBS_WEB=1.5, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

On Wed, Oct 25, 2023 at 3:02=E2=80=AFAM Hawkins Jiawei <yin31149@gmail.com>=
 wrote:
>
> This patch introduces vhost_vdpa_net_load_rss() to restore
> the hash calculation state at device's startup.
>
> Signed-off-by: Hawkins Jiawei <yin31149@gmail.com>
> ---
> v4:
>   - fix some typos pointed out by Michael
>   - zero the `cfg` fields at the definition suggested by Michael
>
> v3: https://patchwork.kernel.org/project/qemu-devel/patch/b7cd0c8d6a58b16=
b086f11714d2908ad35c67caa.1697902949.git.yin31149@gmail.com/
>   - remove the `do_rss` argument in vhost_vdpa_net_load_rss()
>   - zero reserved fields in "cfg" manually instead of using memset()
> to prevent compiler "array-bounds" warning
>
> v2: https://lore.kernel.org/all/f5ffad10699001107022851e0560cb394039d6b0.=
1693297766.git.yin31149@gmail.com/
>   - resolve conflict with updated patch
> "vdpa: Send all CVQ state load commands in parallel"
>   - move the `table` declaration at the beginning of the
> vhost_vdpa_net_load_rss()
>
> RFC: https://lore.kernel.org/all/a54ca70b12ebe2f3c391864e41241697ab1aba30=
.1691762906.git.yin31149@gmail.com/
>
>  net/vhost-vdpa.c | 91 ++++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 91 insertions(+)
>
> diff --git a/net/vhost-vdpa.c b/net/vhost-vdpa.c
> index 7a226c93bc..e59d40b8ae 100644
> --- a/net/vhost-vdpa.c
> +++ b/net/vhost-vdpa.c
> @@ -818,6 +818,88 @@ static int vhost_vdpa_net_load_mac(VhostVDPAState *s=
, const VirtIONet *n,
>      return 0;
>  }
>
> +static int vhost_vdpa_net_load_rss(VhostVDPAState *s, const VirtIONet *n=
,
> +                                   struct iovec *out_cursor,
> +                                   struct iovec *in_cursor)
> +{
> +    struct virtio_net_rss_config cfg =3D {};
> +    ssize_t r;
> +    g_autofree uint16_t *table =3D NULL;

Nitpick, I think the table should actually be introduced in [1], not
here. Otherwise, it adds unneeded complexity to review it.

However I think it is fine if both series get merged one after another, so:

Acked-by: Eugenio P=C3=A9rez <eperezma@redhat.com>

[1] https://patchwork.kernel.org/project/qemu-devel/patch/cf5b78a16ed031898=
2ceffb195f2227f6aad4ac1.1698195059.git.yin31149@gmail.com/

> +
> +    /*
> +     * According to VirtIO standard, "Initially the device has all hash
> +     * types disabled and reports only VIRTIO_NET_HASH_REPORT_NONE.".
> +     *
> +     * Therefore, there is no need to send this CVQ command if the
> +     * driver disables the all hash types, which aligns with
> +     * the device's defaults.
> +     *
> +     * Note that the device's defaults can mismatch the driver's
> +     * configuration only at live migration.
> +     */
> +    if (!n->rss_data.enabled ||
> +        n->rss_data.hash_types =3D=3D VIRTIO_NET_HASH_REPORT_NONE) {
> +        return 0;
> +    }
> +
> +    table =3D g_malloc_n(n->rss_data.indirections_len,
> +                       sizeof(n->rss_data.indirections_table[0]));
> +    cfg.hash_types =3D cpu_to_le32(n->rss_data.hash_types);
> +
> +    /*
> +     * According to VirtIO standard, "Field reserved MUST contain zeroes=
.
> +     * It is defined to make the structure to match the layout of
> +     * virtio_net_rss_config structure, defined in 5.1.6.5.7.".
> +     *
> +     * Therefore, we need to zero the fields in
> +     * struct virtio_net_rss_config, which corresponds to the
> +     * `reserved` field in struct virtio_net_hash_config.
> +     *
> +     * Note that all other fields are zeroed at their definitions,
> +     * except for the `indirection_table` field, where the actual data
> +     * is stored in the `table` variable to ensure compatibility
> +     * with RSS case. Therefore, we need to zero the `table` variable he=
re.
> +     */
> +    table[0] =3D 0;
> +
> +    /*
> +     * Considering that virtio_net_handle_rss() currently does not resto=
re
> +     * the hash key length parsed from the CVQ command sent from the gue=
st
> +     * into n->rss_data and uses the maximum key length in other code, s=
o
> +     * we also employ the maximum key length here.
> +     */
> +    cfg.hash_key_length =3D sizeof(n->rss_data.key);
> +
> +    const struct iovec data[] =3D {
> +        {
> +            .iov_base =3D &cfg,
> +            .iov_len =3D offsetof(struct virtio_net_rss_config,
> +                                indirection_table),
> +        }, {
> +            .iov_base =3D table,
> +            .iov_len =3D n->rss_data.indirections_len *
> +                       sizeof(n->rss_data.indirections_table[0]),
> +        }, {
> +            .iov_base =3D &cfg.max_tx_vq,
> +            .iov_len =3D offsetof(struct virtio_net_rss_config, hash_key=
_data) -
> +                       offsetof(struct virtio_net_rss_config, max_tx_vq)=
,
> +        }, {
> +            .iov_base =3D (void *)n->rss_data.key,
> +            .iov_len =3D sizeof(n->rss_data.key),
> +        }
> +    };
> +
> +    r =3D vhost_vdpa_net_load_cmd(s, out_cursor, in_cursor,
> +                                VIRTIO_NET_CTRL_MQ,
> +                                VIRTIO_NET_CTRL_MQ_HASH_CONFIG,
> +                                data, ARRAY_SIZE(data));
> +    if (unlikely(r < 0)) {
> +        return r;
> +    }
> +
> +    return 0;
> +}
> +
>  static int vhost_vdpa_net_load_mq(VhostVDPAState *s,
>                                    const VirtIONet *n,
>                                    struct iovec *out_cursor,
> @@ -843,6 +925,15 @@ static int vhost_vdpa_net_load_mq(VhostVDPAState *s,
>          return r;
>      }
>
> +    if (!virtio_vdev_has_feature(&n->parent_obj, VIRTIO_NET_F_HASH_REPOR=
T)) {
> +        return 0;
> +    }
> +
> +    r =3D vhost_vdpa_net_load_rss(s, n, out_cursor, in_cursor);
> +    if (unlikely(r < 0)) {
> +        return r;
> +    }
> +
>      return 0;
>  }
>
> --
> 2.25.1
>



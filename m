Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 322BA7E04D9
	for <lists+qemu-devel@lfdr.de>; Fri,  3 Nov 2023 15:44:41 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qyvOX-0001A1-E5; Fri, 03 Nov 2023 10:43:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1qyvOW-00019n-CO
 for qemu-devel@nongnu.org; Fri, 03 Nov 2023 10:43:32 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1qyvOU-0000KG-Cb
 for qemu-devel@nongnu.org; Fri, 03 Nov 2023 10:43:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1699022609;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=qlhWWqE4Z4EgG+0T0sb5Ot7LSBerbffPAteMcsFbfIA=;
 b=KKwYSCoK7d+KQL/GyugZNPWXHkX2QiQbpYmD/3++rqnbh7mTz8NrgnRpeSAFDIJcbptp7G
 DneO3LykQJi6rTGc8TQj0efIUXfTMxRAlsZMxhL0JVUgTZJ/FkpgBD1eUUMIDU5yjrZDUu
 2FU4EtNcZ+CSCufZT2+amPqvQfOL3J0=
Received: from mail-yw1-f198.google.com (mail-yw1-f198.google.com
 [209.85.128.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-263-NocrXujqPzahsiYH0-DSKw-1; Fri, 03 Nov 2023 10:43:27 -0400
X-MC-Unique: NocrXujqPzahsiYH0-DSKw-1
Received: by mail-yw1-f198.google.com with SMTP id
 00721157ae682-5aecf6e30e9so29983647b3.1
 for <qemu-devel@nongnu.org>; Fri, 03 Nov 2023 07:43:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699022606; x=1699627406;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=qlhWWqE4Z4EgG+0T0sb5Ot7LSBerbffPAteMcsFbfIA=;
 b=Nm82sqpMfwFbIoCGveHNBAN3rq2zRmH57igPK0l0lZnQX5EaLwol38A+w/iOD2tG8U
 ADpPpYcVDK3JPYtLikcJcExwhMr9ZbZLIQIVFGQy5JR2MC5ntCpX45iOa+lDgNBqbnEu
 jNcFcRymexi/XQeooOxCXPIXkikH+ZrqKoyXMDFVrIGWLTvJxNjwsGXUF4IGI4Q9xebd
 4Zor7puH9aWTDnkOrbhAu9nuVeC7Mq7rS5lfRGFMjY+OSS2fo2e1r+sdpH538JQWeoQN
 ltQUX8I1yVcFg+Q9MU4AHgq5kKOdOg9tqwO6gl/8/E9QGclCscbYWtsHqi9xWRvtWlaq
 akNg==
X-Gm-Message-State: AOJu0YwnKD8m8Opa/U5AX3bhTAgyCTD+5Dang3slMJgUy9jRIHkFPGVL
 gi8jADa02V580Z5B5GiaNJUzTof3X5E4nml0+x8tQkyq7DxVXjsFuxlmxgPkGWeWgUTXrygFnIa
 vqHJPF153M7nJzZssz52Mu87RY0chwWU=
X-Received: by 2002:a81:9187:0:b0:5a5:65e:b847 with SMTP id
 i129-20020a819187000000b005a5065eb847mr3290967ywg.34.1699022606621; 
 Fri, 03 Nov 2023 07:43:26 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG235mlWNI7HGxelhZmm87Hmti/4HTwwwLQH7NxykoRt6PU6doGNwFGPFgX1HZDbZxtlXw6Gem6RTULDmSn5Mg=
X-Received: by 2002:a81:9187:0:b0:5a5:65e:b847 with SMTP id
 i129-20020a819187000000b005a5065eb847mr3290948ywg.34.1699022606345; Fri, 03
 Nov 2023 07:43:26 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1698195059.git.yin31149@gmail.com>
 <cf5b78a16ed0318982ceffb195f2227f6aad4ac1.1698195059.git.yin31149@gmail.com>
In-Reply-To: <cf5b78a16ed0318982ceffb195f2227f6aad4ac1.1698195059.git.yin31149@gmail.com>
From: Eugenio Perez Martin <eperezma@redhat.com>
Date: Fri, 3 Nov 2023 15:42:50 +0100
Message-ID: <CAJaqyWcT3UJWBkGab3NoXf4Zimbgd9N9auNHs9sfHt1VReqrbg@mail.gmail.com>
Subject: Re: [PATCH v5 2/3] vdpa: Restore receive-side scaling state
To: Hawkins Jiawei <yin31149@gmail.com>
Cc: jasowang@redhat.com, mst@redhat.com, qemu-devel@nongnu.org, 
 18801353760@163.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=eperezma@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.47,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On Wed, Oct 25, 2023 at 3:08=E2=80=AFAM Hawkins Jiawei <yin31149@gmail.com>=
 wrote:
>
> This patch reuses vhost_vdpa_net_load_rss() with some
> refactorings to restore the receive-side scaling state
> at device's startup.
>

Acked-by: Eugenio P=C3=A9rez <eperezma@redhat.com>

> Signed-off-by: Hawkins Jiawei <yin31149@gmail.com>
> ---
> v5:
>   - resolve conflict with the updated patch
> "Vhost-vdpa Shadow Virtqueue Hash calculation Support"
>
> v4: https://lore.kernel.org/all/79caf9bf05778ed5279e11bdd1f26b49baf373ce.=
1697904740.git.yin31149@gmail.com/
>   - add do_rss argument and relative code in vhost_vdpa_net_load_rss()
>
> v3: https://lore.kernel.org/all/47b17e160ba4e55b24790b7d73b22d2b437ebe3c.=
1693299194.git.yin31149@gmail.com/
>   - resolve conflict with updated patch
> "Vhost-vdpa Shadow Virtqueue Hash calculation Support"
>
> RFC v2: https://lore.kernel.org/all/af33aa80bc4ef0b2cec6c21b9448866c517fd=
e80.1691926415.git.yin31149@gmail.com/
>   - Correct the feature usage to VIRTIO_NET_F_HASH_REPORT when
> loading the hash calculation state
>
> RFC v1: https://lore.kernel.org/all/93d5d82f0a5df71df326830033e50358c8b6b=
e7a.1691766252.git.yin31149@gmail.com/
>
>  net/vhost-vdpa.c | 67 +++++++++++++++++++++++++++++++-----------------
>  1 file changed, 44 insertions(+), 23 deletions(-)
>
> diff --git a/net/vhost-vdpa.c b/net/vhost-vdpa.c
> index 3466936b87..a4cc1381fc 100644
> --- a/net/vhost-vdpa.c
> +++ b/net/vhost-vdpa.c
> @@ -828,7 +828,7 @@ static int vhost_vdpa_net_load_mac(VhostVDPAState *s,=
 const VirtIONet *n,
>
>  static int vhost_vdpa_net_load_rss(VhostVDPAState *s, const VirtIONet *n=
,
>                                     struct iovec *out_cursor,
> -                                   struct iovec *in_cursor)
> +                                   struct iovec *in_cursor, bool do_rss)
>  {
>      struct virtio_net_rss_config cfg =3D {};
>      ssize_t r;
> @@ -854,21 +854,35 @@ static int vhost_vdpa_net_load_rss(VhostVDPAState *=
s, const VirtIONet *n,
>                         sizeof(n->rss_data.indirections_table[0]));
>      cfg.hash_types =3D cpu_to_le32(n->rss_data.hash_types);
>
> -    /*
> -     * According to VirtIO standard, "Field reserved MUST contain zeroes=
.
> -     * It is defined to make the structure to match the layout of
> -     * virtio_net_rss_config structure, defined in 5.1.6.5.7.".
> -     *
> -     * Therefore, we need to zero the fields in
> -     * struct virtio_net_rss_config, which corresponds to the
> -     * `reserved` field in struct virtio_net_hash_config.
> -     *
> -     * Note that all other fields are zeroed at their definitions,
> -     * except for the `indirection_table` field, where the actual data
> -     * is stored in the `table` variable to ensure compatibility
> -     * with RSS case. Therefore, we need to zero the `table` variable he=
re.
> -     */
> -    table[0] =3D 0;
> +    if (do_rss) {
> +        /*
> +         * According to VirtIO standard, "Number of entries in indirecti=
on_table
> +         * is (indirection_table_mask + 1)".
> +         */
> +        cfg.indirection_table_mask =3D cpu_to_le16(n->rss_data.indirecti=
ons_len -
> +                                                 1);
> +        cfg.unclassified_queue =3D cpu_to_le16(n->rss_data.default_queue=
);
> +        for (int i =3D 0; i < n->rss_data.indirections_len; ++i) {
> +            table[i] =3D cpu_to_le16(n->rss_data.indirections_table[i]);
> +        }
> +        cfg.max_tx_vq =3D cpu_to_le16(n->curr_queue_pairs);
> +    } else {
> +        /*
> +         * According to VirtIO standard, "Field reserved MUST contain ze=
roes.
> +         * It is defined to make the structure to match the layout of
> +         * virtio_net_rss_config structure, defined in 5.1.6.5.7.".
> +         *
> +         * Therefore, we need to zero the fields in
> +         * struct virtio_net_rss_config, which corresponds to the
> +         * `reserved` field in struct virtio_net_hash_config.
> +         *
> +         * Note that all other fields are zeroed at their definitions,
> +         * except for the `indirection_table` field, where the actual da=
ta
> +         * is stored in the `table` variable to ensure compatibility
> +         * with RSS case. Therefore, we need to zero the `table` variabl=
e here.
> +         */
> +        table[0] =3D 0;
> +    }
>
>      /*
>       * Considering that virtio_net_handle_rss() currently does not resto=
re
> @@ -899,6 +913,7 @@ static int vhost_vdpa_net_load_rss(VhostVDPAState *s,=
 const VirtIONet *n,
>
>      r =3D vhost_vdpa_net_load_cmd(s, out_cursor, in_cursor,
>                                  VIRTIO_NET_CTRL_MQ,
> +                                do_rss ? VIRTIO_NET_CTRL_MQ_RSS_CONFIG :
>                                  VIRTIO_NET_CTRL_MQ_HASH_CONFIG,
>                                  data, ARRAY_SIZE(data));
>      if (unlikely(r < 0)) {
> @@ -933,13 +948,19 @@ static int vhost_vdpa_net_load_mq(VhostVDPAState *s=
,
>          return r;
>      }
>
> -    if (!virtio_vdev_has_feature(&n->parent_obj, VIRTIO_NET_F_HASH_REPOR=
T)) {
> -        return 0;
> -    }
> -
> -    r =3D vhost_vdpa_net_load_rss(s, n, out_cursor, in_cursor);
> -    if (unlikely(r < 0)) {
> -        return r;
> +    if (virtio_vdev_has_feature(&n->parent_obj, VIRTIO_NET_F_RSS)) {
> +        /* load the receive-side scaling state */
> +        r =3D vhost_vdpa_net_load_rss(s, n, out_cursor, in_cursor, true)=
;
> +        if (unlikely(r < 0)) {
> +            return r;
> +        }
> +    } else if (virtio_vdev_has_feature(&n->parent_obj,
> +                                       VIRTIO_NET_F_HASH_REPORT)) {
> +        /* load the hash calculation state */
> +        r =3D vhost_vdpa_net_load_rss(s, n, out_cursor, in_cursor, false=
);
> +        if (unlikely(r < 0)) {
> +            return r;
> +        }
>      }
>
>      return 0;
> --
> 2.25.1
>



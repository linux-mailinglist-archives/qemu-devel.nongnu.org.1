Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5604C7CFFAB
	for <lists+qemu-devel@lfdr.de>; Thu, 19 Oct 2023 18:34:15 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qtVwy-0001wc-Ul; Thu, 19 Oct 2023 12:32:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1qtVwx-0001wU-NF
 for qemu-devel@nongnu.org; Thu, 19 Oct 2023 12:32:43 -0400
Received: from mail-oo1-xc2f.google.com ([2607:f8b0:4864:20::c2f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1qtVwv-0008TS-SR
 for qemu-devel@nongnu.org; Thu, 19 Oct 2023 12:32:43 -0400
Received: by mail-oo1-xc2f.google.com with SMTP id
 006d021491bc7-5840fe01176so40345eaf.1
 for <qemu-devel@nongnu.org>; Thu, 19 Oct 2023 09:32:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1697733160; x=1698337960; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=h+XnnHE5ap/MITar5/thGClptwLe3zGveBf/xEyXoGo=;
 b=VFI14TV7dEoR4lLeeeheBFFIapW50rFuqOhJ1at91nPGPWkOHgg7PNZ3bWsYcXuAP4
 2O0vljEVrK8VsHlZ+VoID2ERrGQiB4bkLB6uj8KMwDkJB/bxYkHuRAYki9U2cOX8wOAi
 4sxDdP6aZMDyze2r4MHe11B5pV3P2MTWNSApLYE3vCB0Fz4fYE4SRUaZz5QRXSMfTtcO
 24BbsSThA8EWIAmMdH2/K5UZ1KIKNFf/Rc5Q/UlFTDe/D4MIlTCXDg2HwVICIvqYrZ2h
 M+2nxZ3LQf61Bvjk1YUOEHXQmsFLbiqndsKOqJ5Ap99hxBjV3Z1s/gfnmnomgSiq8WRB
 GeiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697733160; x=1698337960;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=h+XnnHE5ap/MITar5/thGClptwLe3zGveBf/xEyXoGo=;
 b=dV0WNam0q1wVXG/xNk/r8IRjjnT9rg5VjGBRMYuMtB6kGylOM+pdpeOvZ+o76nPFqn
 NsS4MruzqyR03jigbACAdmrzyKuucw+5XWQ4b/aRRvCi4LJPMB8TnIzN3O75M0XbSIc4
 9LkrWVp1TXzi2cPyEjbfFDqShqTf5I0NVg6bFwUXj/wwDqJyKnrrdfBekqr+wQ5PGMG0
 Q34whozisOf88VkQAPreAdPDvYXwvWWhphZrf93f49oE9k7DsH+Hrp50dmcrZPo5OEw8
 XbjYqigvpsA93iXjSSqqwkj1jjktqdFL/otqSsolGKr/mHe6KFua41Tj1hDC6YRdG/dD
 Byew==
X-Gm-Message-State: AOJu0YwhMHLAMWR/p2XqpnZBGAzajqeU3miv6tL+LifWsgxRrIufQyT2
 IdMcvuYiA6vq75AJqYWC+4Q1Pa1OpVZgUPAEIXI=
X-Google-Smtp-Source: AGHT+IFVNFqSu73HR+IVk86F7zEpqeFtBEw0P3JXTj8RTsJMjwhu8skp/Kxv6m9hYt5QORniIwyCIR7WyPblt0H9XFs=
X-Received: by 2002:a4a:de15:0:b0:581:d7b1:786f with SMTP id
 y21-20020a4ade15000000b00581d7b1786fmr2554615oot.7.1697733160405; Thu, 19 Oct
 2023 09:32:40 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1697644299.git.mst@redhat.com>
 <1908cfd6e1748d94680e468b9df6321087b8fcf2.1697644299.git.mst@redhat.com>
In-Reply-To: <1908cfd6e1748d94680e468b9df6321087b8fcf2.1697644299.git.mst@redhat.com>
From: Stefan Hajnoczi <stefanha@gmail.com>
Date: Thu, 19 Oct 2023 09:32:28 -0700
Message-ID: <CAJSP0QVTi2QxMdzmPoPF2w5xm-r19W_0GtTaqJzGnoibT9iDNg@mail.gmail.com>
Subject: Re: [PULL 08/83] vdpa: Restore hash calculation state
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>, 
 Hawkins Jiawei <yin31149@gmail.com>, Jason Wang <jasowang@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::c2f;
 envelope-from=stefanha@gmail.com; helo=mail-oo1-xc2f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

On Wed, 18 Oct 2023 at 08:56, Michael S. Tsirkin <mst@redhat.com> wrote:
>
> From: Hawkins Jiawei <yin31149@gmail.com>
>
> This patch introduces vhost_vdpa_net_load_rss() to restore
> the hash calculation state at device's startup.
>
> Note that vhost_vdpa_net_load_rss() has `do_rss` argument,
> which allows future code to reuse this function to restore
> the receive-side scaling state when the VIRTIO_NET_F_RSS
> feature is enabled in SVQ. Currently, vhost_vdpa_net_load_rss()
> could only be invoked when `do_rss` is set to false.
>
> Signed-off-by: Hawkins Jiawei <yin31149@gmail.com>
> Message-Id: <f5ffad10699001107022851e0560cb394039d6b0.1693297766.git.yin3=
1149@gmail.com>
> Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> ---
>  net/vhost-vdpa.c | 91 ++++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 91 insertions(+)
>
> diff --git a/net/vhost-vdpa.c b/net/vhost-vdpa.c
> index 4b7c3b81b8..40d0bcbc0b 100644
> --- a/net/vhost-vdpa.c
> +++ b/net/vhost-vdpa.c
> @@ -817,6 +817,88 @@ static int vhost_vdpa_net_load_mac(VhostVDPAState *s=
, const VirtIONet *n,
>      return 0;
>  }
>
> +static int vhost_vdpa_net_load_rss(VhostVDPAState *s, const VirtIONet *n=
,
> +                                   struct iovec *out_cursor,
> +                                   struct iovec *in_cursor, bool do_rss)
> +{
> +    struct virtio_net_rss_config cfg;
> +    ssize_t r;
> +    g_autofree uint16_t *table =3D NULL;
> +
> +    /*
> +     * According to VirtIO standard, "Initially the device has all hash
> +     * types disabled and reports only VIRTIO_NET_HASH_REPORT_NONE.".
> +     *
> +     * Therefore, there is no need to send this CVQ command if the
> +     * driver disable the all hash types, which aligns with
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
> +    cfg.hash_types =3D cpu_to_le32(n->rss_data.hash_types);
> +
> +    /*
> +     * According to VirtIO standard, "Field reserved MUST contain zeroes=
.
> +     * It is defined to make the structure to match the layout of
> +     * virtio_net_rss_config structure, defined in 5.1.6.5.7.".
> +     *
> +     * Therefore, we need to zero the fields in struct virtio_net_rss_co=
nfig,
> +     * which corresponds the `reserved` field in
> +     * struct virtio_net_hash_config.
> +     */
> +    memset(&cfg.indirection_table_mask, 0,
> +           sizeof_field(struct virtio_net_hash_config, reserved));

Please take a look at the following CI failure:

In file included from /usr/include/string.h:495,
from /home/gitlab-runner/builds/-LCfcJ2T/0/qemu-project/qemu/include/qemu/o=
sdep.h:116,
from ../net/vhost-vdpa.c:12:
In function =E2=80=98memset=E2=80=99,
inlined from =E2=80=98vhost_vdpa_net_load_rss=E2=80=99 at ../net/vhost-vdpa=
.c:874:9:
/usr/include/s390x-linux-gnu/bits/string_fortified.h:71:10: error:
=E2=80=98__builtin_memset=E2=80=99 offset [7, 12] from the object at =E2=80=
=98cfg=E2=80=99 is out of
the bounds of referenced subobject =E2=80=98indirection_table_mask=E2=80=99=
 with type
=E2=80=98short unsigned int=E2=80=99 at offset 4 [-Werror=3Darray-bounds]
71 | return __builtin___memset_chk (__dest, __ch, __len, __bos0 (__dest));
| ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
cc1: all warnings being treated as errors

https://gitlab.com/qemu-project/qemu/-/jobs/5329820077

> +
> +    table =3D g_malloc_n(n->rss_data.indirections_len,
> +                       sizeof(n->rss_data.indirections_table[0]));
> +    for (int i =3D 0; i < n->rss_data.indirections_len; ++i) {
> +        table[i] =3D cpu_to_le16(n->rss_data.indirections_table[i]);
> +    }
> +
> +    /*
> +     * Consider that virtio_net_handle_rss() currently does not restore =
the
> +     * hash key length parsed from the CVQ command sent from the guest i=
nto
> +     * n->rss_data and uses the maximum key length in other code, so we =
also
> +     * employthe the maxium key length here.
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
> @@ -842,6 +924,15 @@ static int vhost_vdpa_net_load_mq(VhostVDPAState *s,
>          return r;
>      }
>
> +    if (!virtio_vdev_has_feature(&n->parent_obj, VIRTIO_NET_F_HASH_REPOR=
T)) {
> +        return 0;
> +    }
> +
> +    r =3D vhost_vdpa_net_load_rss(s, n, out_cursor, in_cursor, false);
> +    if (unlikely(r < 0)) {
> +        return r;
> +    }
> +
>      return 0;
>  }
>
> --
> MST
>
>


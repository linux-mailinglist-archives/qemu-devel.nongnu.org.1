Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B3F8474748D
	for <lists+qemu-devel@lfdr.de>; Tue,  4 Jul 2023 16:54:33 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qGhPv-0000rH-Q8; Tue, 04 Jul 2023 10:54:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1qGhPu-0000r8-9T
 for qemu-devel@nongnu.org; Tue, 04 Jul 2023 10:54:10 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1qGhPr-00041x-3e
 for qemu-devel@nongnu.org; Tue, 04 Jul 2023 10:54:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1688482445;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=SMkCYIvAwk7fEVV5JKDNHXNgeltzNeShygy6fHjsB9o=;
 b=RZNcnwGt+o9slZD8vJpuJaHYD9SFPpx3GDiEAozYV6kjFgKMx4DKZ+huoN5qgPJLQfH58J
 95W9fOQmspRCeBKe0wd5rVEejdxaOew5EvW8by2G9hXYKgTzfyvOk62whBg0jjQKOlBOdZ
 GfIiWrwpHZIMIJl449+i0u6x6MqICOk=
Received: from mail-yw1-f198.google.com (mail-yw1-f198.google.com
 [209.85.128.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-606-RQ7aXO1cMhurUhehrw9dpA-1; Tue, 04 Jul 2023 10:54:04 -0400
X-MC-Unique: RQ7aXO1cMhurUhehrw9dpA-1
Received: by mail-yw1-f198.google.com with SMTP id
 00721157ae682-573a92296c7so51675537b3.1
 for <qemu-devel@nongnu.org>; Tue, 04 Jul 2023 07:54:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688482443; x=1691074443;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=SMkCYIvAwk7fEVV5JKDNHXNgeltzNeShygy6fHjsB9o=;
 b=a7cK8uwej3aGe3akCSROlag2tfpqzhtYURwgqoIHGuDz0Q5zWJdJWc7jrqC40Oh2AN
 /j30M8RkMQCTCQnuJ27PYZwfWFSS8u/1qoEyihHsu+IuRgXa8Q3dycG7BIkbhODZnSig
 5zMJv+asRcN0CDcWv53KQHcOn7XnSNQtLnIYrwVul+JFoxWtg6YG6peWK9ZQHYNN+pqq
 24nd3/ov3oliu0fwD6LPv0KOTj9ptHTOD92qaCv11f80sZgUGvNBILH3yZVLbjMVZfH6
 kiiICiSrNX52wteDNCXtCqfDtAs1ZLb3nr6qCCJHrnCYZ60Jp3qGBNxGGNEroKyTzpqm
 afXQ==
X-Gm-Message-State: ABy/qLbkvEtxbWLnCGpff2GapVucyhDAzBpDeic0HVQFGadTRpuCrfPa
 M2HUa3ykj27+MirKGCieRCs1FhEMPCXwd7gcj+GJ5Wyd674gE1HtXsH5Iq3IBB+RBU4RY8y9DJZ
 XMij8uuvmFDtz9gdtLCODc0PuViRG9S0=
X-Received: by 2002:a5b:3ce:0:b0:c18:fa74:8721 with SMTP id
 t14-20020a5b03ce000000b00c18fa748721mr10516567ybp.12.1688482443541; 
 Tue, 04 Jul 2023 07:54:03 -0700 (PDT)
X-Google-Smtp-Source: APBJJlGivd1X9GX72v+l6xrvKJTzpm/A15nokaCKco8hY8JmarRlhO0yEP5RlQJ6SjPWy6Mpc5YpjuZ/lTqDElg5EDc=
X-Received: by 2002:a5b:3ce:0:b0:c18:fa74:8721 with SMTP id
 t14-20020a5b03ce000000b00c18fa748721mr10516557ybp.12.1688482443220; Tue, 04
 Jul 2023 07:54:03 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1688051252.git.yin31149@gmail.com>
 <2f2560f749186c0eb1055f9926f464587e419eeb.1688051252.git.yin31149@gmail.com>
In-Reply-To: <2f2560f749186c0eb1055f9926f464587e419eeb.1688051252.git.yin31149@gmail.com>
From: Eugenio Perez Martin <eperezma@redhat.com>
Date: Tue, 4 Jul 2023 16:53:26 +0200
Message-ID: <CAJaqyWfq0Sec14Y9UCAtYXRCTyyUwEo0NRBu6uksgESkMVgFUQ@mail.gmail.com>
Subject: Re: [PATCH RFC v2 2/4] vdpa: Restore MAC address filtering state
To: Hawkins Jiawei <yin31149@gmail.com>
Cc: jasowang@redhat.com, mst@redhat.com, qemu-devel@nongnu.org, 
 18801353760@163.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=eperezma@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

On Thu, Jun 29, 2023 at 5:26=E2=80=AFPM Hawkins Jiawei <yin31149@gmail.com>=
 wrote:
>
> This patch refactors vhost_vdpa_net_load_mac() to
> restore the MAC address filtering state at device's startup.
>
> Signed-off-by: Hawkins Jiawei <yin31149@gmail.com>
> ---
> v2:
>   - use iovec suggested by Eugenio
>   - avoid sending CVQ command in default state
>
> v1: https://lore.kernel.org/all/00f72fe154a882fd6dc15bc39e3a1ac63f9dadce.=
1687402580.git.yin31149@gmail.com/
>
>  net/vhost-vdpa.c | 51 ++++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 51 insertions(+)
>
> diff --git a/net/vhost-vdpa.c b/net/vhost-vdpa.c
> index 0bd1c7817c..cb45c84c88 100644
> --- a/net/vhost-vdpa.c
> +++ b/net/vhost-vdpa.c
> @@ -665,6 +665,57 @@ static int vhost_vdpa_net_load_mac(VhostVDPAState *s=
, const VirtIONet *n)
>          }
>      }
>
> +    if (virtio_vdev_has_feature(&n->parent_obj, VIRTIO_NET_F_CTRL_RX)) {
> +        if (n->mac_table.in_use !=3D 0) {

This may be just style nitpicking, but I find it more clear to return
early if conditions are not met and then send the CVQ command.
Something like:
/*
 * According to ...
 */
if (!virtio_vdev_has_feature(&n->parent_obj, VIRTIO_NET_F_CTRL_RX)) ||
(n->mac_table.in_use =3D=3D 0)) {
  return 0
}

uni_entries =3D n->mac_table.first_multi,
...
---

Now I just realized vhost_vdpa_net_load_mac does not follow this for
checking VIRTIO_NET_F_CTRL_MAC_ADDR.

I'm ok if you leave it this way though.

Thanks!

> +            /*
> +             * According to virtio_net_reset(), device uses an empty MAC=
 filter
> +             * table as its default state.
> +             *
> +             * Therefore, there is no need to send this CVQ command if t=
he
> +             * driver also sets an empty MAC filter table, which aligns =
with
> +             * the device's defaults.
> +             *
> +             * Note that the device's defaults can mismatch the driver's
> +             * configuration only at live migration.
> +             */
> +            uint32_t uni_entries =3D n->mac_table.first_multi,
> +                     uni_macs_size =3D uni_entries * ETH_ALEN,
> +                     mul_entries =3D n->mac_table.in_use - uni_entries,
> +                     mul_macs_size =3D mul_entries * ETH_ALEN;
> +            struct virtio_net_ctrl_mac uni =3D {
> +                .entries =3D cpu_to_le32(uni_entries),
> +            };
> +            struct virtio_net_ctrl_mac mul =3D {
> +                .entries =3D cpu_to_le32(mul_entries),
> +            };
> +            const struct iovec data[] =3D {
> +                {
> +                    .iov_base =3D &uni,
> +                    .iov_len =3D sizeof(uni),
> +                }, {
> +                    .iov_base =3D n->mac_table.macs,
> +                    .iov_len =3D uni_macs_size,
> +                }, {
> +                    .iov_base =3D &mul,
> +                    .iov_len =3D sizeof(mul),
> +                }, {
> +                    .iov_base =3D &n->mac_table.macs[uni_macs_size],
> +                    .iov_len =3D mul_macs_size,
> +                },
> +            };
> +            ssize_t dev_written =3D vhost_vdpa_net_load_cmd(s,
> +                                        VIRTIO_NET_CTRL_MAC,
> +                                        VIRTIO_NET_CTRL_MAC_TABLE_SET,
> +                                        data, ARRAY_SIZE(data));
> +            if (unlikely(dev_written < 0)) {
> +                return dev_written;
> +            }
> +            if (*s->status !=3D VIRTIO_NET_OK) {
> +                return -EINVAL;
> +            }
> +        }
> +    }
> +
>      return 0;
>  }
>
> --
> 2.25.1
>



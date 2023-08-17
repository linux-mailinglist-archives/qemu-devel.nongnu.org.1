Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id F3ECA77F43C
	for <lists+qemu-devel@lfdr.de>; Thu, 17 Aug 2023 12:21:38 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qWa7z-0007Xf-NB; Thu, 17 Aug 2023 06:21:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1qWa7p-0007Ux-EM
 for qemu-devel@nongnu.org; Thu, 17 Aug 2023 06:21:10 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1qWa7m-00056l-Hn
 for qemu-devel@nongnu.org; Thu, 17 Aug 2023 06:21:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1692267658;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4rTBFF/0S6vCdLJfvxkext+3+RJtvWAn0FO5C0xqdXg=;
 b=V6hHXo+URCY93PM7AKtJnuIk5jwstDPvFm8ZPoJEX3cu2fJDrMgreqLyVHWfJBgoc7QMfn
 rqW1U8U4SKpG/sqKuGhQrUh0IiKXmKSNoV2ONwxsjbGOW89zop/BLghDQYaWd35NjwdEPL
 Cs3WQ/ZBJ5Y36Srwl83ci9wERk7qAS4=
Received: from mail-yb1-f199.google.com (mail-yb1-f199.google.com
 [209.85.219.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-687-eqs_FnoJOMOFXVD7Fg6nxg-1; Thu, 17 Aug 2023 06:20:56 -0400
X-MC-Unique: eqs_FnoJOMOFXVD7Fg6nxg-1
Received: by mail-yb1-f199.google.com with SMTP id
 3f1490d57ef6-d68c0f22fc9so1600896276.0
 for <qemu-devel@nongnu.org>; Thu, 17 Aug 2023 03:20:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692267656; x=1692872456;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=4rTBFF/0S6vCdLJfvxkext+3+RJtvWAn0FO5C0xqdXg=;
 b=QWAEva7vTvXaeE3HN5wd13MeSkq52Itw/MTpxx3SP2YyMNoIJC858/nS0beeQzqqFD
 JPVc8HsjTpTvA4Oe/E22qfF5xgMKTl/Tk7LsyfpSgFLW+4uPkp+b57CUrXPG2TQKjzEw
 dmQT0uQJ2nZpt2LUycYj53rrReLDwSosDxHXiHGNXVnOFG9VAFWsIlynFiySrKGk/ZNm
 EvQ2WMtZX2SZ7oL9tRv49UcNyXxeAlVnlna84sYFeizPx2QeOb8zNjniTF6YkVG8BW84
 JXokFHbZxqX59sVMn90ObbGXzscvsbNOPfJyH3UxQp/pBCeNuIfNwM7iBLaAZQanhbUy
 RzIA==
X-Gm-Message-State: AOJu0YymO5zha++tc/y2vov04AFZHBOqiPLfyFvWbeUVrRwwa9CBfaW8
 DLMx5B9yaxoHWgZpt7nslY85JPrceBnaQoo/Ss/PDYRNz8YkDuarNnmfMWY0+K4H5Siy76WcJuV
 MwrsP0x6LD8fbzbSBIAwV+695JaZc7ZA=
X-Received: by 2002:a25:b112:0:b0:d71:7d2f:c548 with SMTP id
 g18-20020a25b112000000b00d717d2fc548mr2646168ybj.15.1692267656196; 
 Thu, 17 Aug 2023 03:20:56 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFoqNM/UsjIGRFtxm3D0QUpbIxXkveeLb0SuaxHTx4Lu802afO3RBBzbSOql2HOPUbaanP/99hhH44aLcO4LZ4=
X-Received: by 2002:a25:b112:0:b0:d71:7d2f:c548 with SMTP id
 g18-20020a25b112000000b00d717d2fc548mr2646155ybj.15.1692267655969; Thu, 17
 Aug 2023 03:20:55 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1688743107.git.yin31149@gmail.com>
 <ee31c5420ffc8e6a29705ddd30badb814ddbae1d.1688743107.git.yin31149@gmail.com>
In-Reply-To: <ee31c5420ffc8e6a29705ddd30badb814ddbae1d.1688743107.git.yin31149@gmail.com>
From: Eugenio Perez Martin <eperezma@redhat.com>
Date: Thu, 17 Aug 2023 12:20:19 +0200
Message-ID: <CAJaqyWfuwgacuDsWSuBE=eKGqoN8KmjMMCaVme52f9X-nLzXww@mail.gmail.com>
Subject: Re: [PATCH v3 4/7] vhost: Fix false positive out-of-bounds
To: Hawkins Jiawei <yin31149@gmail.com>
Cc: jasowang@redhat.com, mst@redhat.com, qemu-devel@nongnu.org, 
 18801353760@163.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=eperezma@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Fri, Jul 7, 2023 at 5:27=E2=80=AFPM Hawkins Jiawei <yin31149@gmail.com> =
wrote:
>
> QEMU uses vhost_svq_translate_addr() to translate addresses
> between the QEMU's virtual address and the SVQ IOVA. In order
> to validate this translation, QEMU checks whether the translated
> range falls within the mapped range.
>
> Yet the problem is that, the value of `needle_last`, which is calculated
> by `needle.translated_addr + iovec[i].iov_len`, should represent the
> exclusive boundary of the translated range, rather than the last
> inclusive addresses of the range. Consequently, QEMU fails the check
> when the translated range matches the size of the mapped range.
>
> This patch solves this problem by fixing the `needle_last` value to
> the last inclusive address of the translated range.
>
> Note that this bug cannot be triggered at the moment, because QEMU
> is unable to translate such a big range due to the truncation of
> the CVQ command in vhost_vdpa_net_handle_ctrl_avail().
>
> Fixes: 34e3c94eda ("vdpa: Add custom IOTLB translations to SVQ")
> Signed-off-by: Hawkins Jiawei <yin31149@gmail.com>

Acked-by: Eugenio P=C3=A9rez <eperezma@redhat.com>

> ---
>  hw/virtio/vhost-shadow-virtqueue.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/hw/virtio/vhost-shadow-virtqueue.c b/hw/virtio/vhost-shadow-=
virtqueue.c
> index 1b1d85306c..49e5aed931 100644
> --- a/hw/virtio/vhost-shadow-virtqueue.c
> +++ b/hw/virtio/vhost-shadow-virtqueue.c
> @@ -111,7 +111,7 @@ static bool vhost_svq_translate_addr(const VhostShado=
wVirtqueue *svq,
>          addrs[i] =3D map->iova + off;
>
>          needle_last =3D int128_add(int128_make64(needle.translated_addr)=
,
> -                                 int128_make64(iovec[i].iov_len));
> +                                 int128_makes64(iovec[i].iov_len - 1));
>          map_last =3D int128_make64(map->translated_addr + map->size);
>          if (unlikely(int128_gt(needle_last, map_last))) {
>              qemu_log_mask(LOG_GUEST_ERROR,
> --
> 2.25.1
>



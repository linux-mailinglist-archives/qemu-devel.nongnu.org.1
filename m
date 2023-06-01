Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FB6C7197E9
	for <lists+qemu-devel@lfdr.de>; Thu,  1 Jun 2023 11:57:56 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q4f3g-0001Bp-BO; Thu, 01 Jun 2023 05:57:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <leiyang@redhat.com>)
 id 1q4f3d-0000s8-9D
 for qemu-devel@nongnu.org; Thu, 01 Jun 2023 05:57:25 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <leiyang@redhat.com>)
 id 1q4f3W-0007Hf-Uy
 for qemu-devel@nongnu.org; Thu, 01 Jun 2023 05:57:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1685613419;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=TZO+o63Px9u/QtirsfxTDyg861boMW9mJYaRkKi9n80=;
 b=V7x4M65JPkdvgm0ceOXniVn/cak9p4BIEPUyNiP4LsGjpxeVP2D0EytG2NAl8vWRMvJc4b
 8Q2CF5Z9ckcmhx+DKT6TqCbxtGujiygUm6UvtAD4hVb6H1ymkFsuhl9inDv/7zSEtAA3IC
 kTzS7QiL74WaiGM10RkblXBW7vxfJzU=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-447--QHrvC5uPliAf_M_Aet2dw-1; Thu, 01 Jun 2023 05:56:58 -0400
X-MC-Unique: -QHrvC5uPliAf_M_Aet2dw-1
Received: by mail-ed1-f72.google.com with SMTP id
 4fb4d7f45d1cf-5142da822cbso610254a12.2
 for <qemu-devel@nongnu.org>; Thu, 01 Jun 2023 02:56:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685613417; x=1688205417;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=TZO+o63Px9u/QtirsfxTDyg861boMW9mJYaRkKi9n80=;
 b=M0vE1VML+8h+E2VI6peqtgizzZOS2N4OcvvDmdkfKrdGPzkMkva4YGNhZdaXPMxGHG
 dScQIXCiwan2V5xtof7Q2zYImSgoJBsIh4LO+/xz2ALsbCt41tQxlRoCBSzZqdS4b3wS
 WzClbKjrAxe4WdEigFxoWznKq8OXdBxztWLeAhsF+7aoXO/fNwjzZaHP6fxKCyMYvITp
 GEpgompNJU6aqJk87zukK8l6ZelbsH0D2vSJcecK/aIT3szh/fa9phYwldiYDpuzeWhQ
 kPcqpyRx1zkLONT5nwttut7y9NnykteUIzdLQrDuVsfCP8rTMZl0BIPbOyfdswY0r70p
 vjrQ==
X-Gm-Message-State: AC+VfDxUR4YTOHr24bAFTCkaw09JuW0uRhcv+QTGn/WgKzx2xdoa47gV
 2S0MLqnbGYt0Q0jKknOrSkpz7NHoOpCKswfErzRXnAvhKFO107biT6nwNT5R8Vq/R4mzboHLK1N
 535KwOEKVOg4oxZBfDeXSD1/qYMsi2wY=
X-Received: by 2002:a05:6402:1219:b0:510:db93:f034 with SMTP id
 c25-20020a056402121900b00510db93f034mr5413275edw.36.1685613417146; 
 Thu, 01 Jun 2023 02:56:57 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ5dVCUxX1NrIeaVCvDBZX5RSd2PG51PMhu/MzuXxLwMnMvUN9Tl+Ssaqdm7uPKhm6KxnqnCLzQSLNH2TseP3jI=
X-Received: by 2002:a05:6402:1219:b0:510:db93:f034 with SMTP id
 c25-20020a056402121900b00510db93f034mr5413256edw.36.1685613416850; Thu, 01
 Jun 2023 02:56:56 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1685584543.git.yin31149@gmail.com>
In-Reply-To: <cover.1685584543.git.yin31149@gmail.com>
From: Lei Yang <leiyang@redhat.com>
Date: Thu, 1 Jun 2023 17:56:20 +0800
Message-ID: <CAPpAL=yn=Js841iHzXM42+yPrLW7s=YLwY36BBxPDAvPGVaG0Q@mail.gmail.com>
Subject: Re: [PATCH v2 0/6] Vhost-vdpa Shadow Virtqueue Offloads support
To: Hawkins Jiawei <yin31149@gmail.com>
Cc: jasowang@redhat.com, mst@redhat.com, eperezma@redhat.com, 
 qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=leiyang@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.163,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

I'm a QE responsible for vhost_vdpa parts. Could you please provide me
with the test steps for this series? I can test it in my environment
and update the test results.





On Thu, Jun 1, 2023 at 4:29=E2=80=AFPM Hawkins Jiawei <yin31149@gmail.com> =
wrote:
>
> This series enables shadowed CVQ to intercept Offloads commands
> through shadowed CVQ, update the virtio NIC device model so qemu
> send it in a migration, and the restore of that Offloads state
> in the destination.
>
> Changelog
> =3D=3D=3D=3D=3D=3D=3D=3D=3D
> v2:
>   - make some function arguments const
>   - reuse virtio_vdev_has_feature() suggested by Eugenio and Jason
>   - avoid sending CVQ command in default state suggested by Eugenio
>
> v1: https://lore.kernel.org/all/cover.1685359572.git.yin31149@gmail.com/
>
> Hawkins Jiawei (6):
>   include/hw/virtio: make some VirtIODevice const
>   vdpa: reuse virtio_vdev_has_feature()
>   hw/net/virtio-net: make some VirtIONet const
>   virtio-net: expose virtio_net_supported_guest_offloads()
>   vdpa: Add vhost_vdpa_net_load_offloads()
>   vdpa: Allow VIRTIO_NET_F_CTRL_GUEST_OFFLOADS in SVQ
>
>  hw/net/virtio-net.c            |  2 +-
>  include/hw/virtio/virtio-net.h |  1 +
>  include/hw/virtio/virtio.h     |  2 +-
>  net/vhost-vdpa.c               | 45 +++++++++++++++++++++++++++++++---
>  4 files changed, 44 insertions(+), 6 deletions(-)
>
> --
> 2.25.1
>
>



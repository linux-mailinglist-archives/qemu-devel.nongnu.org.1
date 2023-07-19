Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F7F7759379
	for <lists+qemu-devel@lfdr.de>; Wed, 19 Jul 2023 12:54:46 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qM4oX-0005lO-Nb; Wed, 19 Jul 2023 06:53:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yin31149@gmail.com>)
 id 1qM4oT-0005l9-Fn
 for qemu-devel@nongnu.org; Wed, 19 Jul 2023 06:53:46 -0400
Received: from mail-lj1-x231.google.com ([2a00:1450:4864:20::231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <yin31149@gmail.com>)
 id 1qM4oQ-0001bX-KY
 for qemu-devel@nongnu.org; Wed, 19 Jul 2023 06:53:44 -0400
Received: by mail-lj1-x231.google.com with SMTP id
 38308e7fff4ca-2b701e41cd3so105504681fa.3
 for <qemu-devel@nongnu.org>; Wed, 19 Jul 2023 03:53:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1689764020; x=1692356020;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RoSk/ngJAdvYxrIaDFZkjX/y9qFflZbvcQkwOdCZKeA=;
 b=BoKBPgqyMu9umxh92DaMYHcDs2WYDbKVrBFRO8M32wonL3rTPgcjKdHslJpdUYI31+
 KuEw05lPIeplmSXc1DWtrZFTDRcc86Q9xnns4cmTRfx51Lik9KwRpP4FExWvhRUvHbU5
 ZtPcTvDfo0OYMpHLSbXwo+SM+X2JpqsMJQd+QcYLyNwMLGu3YiZ5BGTrX5BoC3B325KL
 hKoCL+NmfaN0ksnPyqydGow5q2vnuyVF6fzM7bnneQK9lEyyzvkWknqAWU2UDZ8KSXw3
 fq2UAQju+5HHrBNZRLKZ8zrK9UwnQ0dOeVfxVCTnuibZ8r68izl0mIVRGIVL12TkJIz9
 XW7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689764020; x=1692356020;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=RoSk/ngJAdvYxrIaDFZkjX/y9qFflZbvcQkwOdCZKeA=;
 b=bC49wKwWEufnNbpJ269bCxNd3+2OoXE1DwXXzsORvjip9KcX2MbbM7bbHgTEVCmhcc
 DVGkGuOU4MMG0VFkKUa8pt2+z9gX0k0i/ZovJyzOlyk5ehimEeLfeBJYlLkSz2EfjfVX
 7BbV7PcSABWf4Y54L9btrvc4WlMMAZn9NkAzqZaHPKQBXSZH3aMqHpDIlGxcGRYEkZwx
 /LONfw5pVjh+4YlKysrBRe4avvYmjx2skXpuVqvjQZlHlJit5q4iM2/YrLw4aYTPhoHa
 4eAWDdPdjL+9z4Vjtu1iA1PU1S+qFDquzzd0XvUr7iEsfW4rdgi9y7N6fTZ9NPz7+l/D
 dutQ==
X-Gm-Message-State: ABy/qLYwgRjbvRkVS62pPtQrqaINv2D6rtl262AGL6Elwr+qwJM42aw4
 tWMebaA8CUWT1tkh+Xe4PqUHfG+mkt1VMFJqRxs=
X-Google-Smtp-Source: APBJJlEfRDQwZ5t1aTzunQteXblyF37eYGVHMv0XjyLwFz0zuGHB3Y23byqwshYmKaUKrQAmcE3KPhWHCn8YgEjR56g=
X-Received: by 2002:a2e:7818:0:b0:2b9:4aa1:71da with SMTP id
 t24-20020a2e7818000000b002b94aa171damr4314662ljc.53.1689764019502; Wed, 19
 Jul 2023 03:53:39 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1689690854.git.yin31149@gmail.com>
In-Reply-To: <cover.1689690854.git.yin31149@gmail.com>
From: Hawkins Jiawei <yin31149@gmail.com>
Date: Wed, 19 Jul 2023 18:53:28 +0800
Message-ID: <CAKrof1Nn83WbjHgBPjYXtxMOC_OC44Si4-J+HsmRu7yF1+gfNw@mail.gmail.com>
Subject: Re: [PATCH 0/4] Vhost-vdpa Shadow Virtqueue VLAN support
To: jasowang@redhat.com, mst@redhat.com, eperezma@redhat.com
Cc: qemu-devel@nongnu.org, 18801353760@163.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::231;
 envelope-from=yin31149@gmail.com; helo=mail-lj1-x231.google.com
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

=E5=9C=A8 2023/7/19 15:47, Hawkins Jiawei =E5=86=99=E9=81=93:
> This series enables shadowed CVQ to intercept VLAN commands
> through shadowed CVQ, update the virtio NIC device model
> so qemu send it in a migration, and the restore of that
> VLAN state in the destination.

This patch series is based on
"[PATCH 0/3] Vhost-vdpa Shadow Virtqueue VLAN support" at [1],
with these changes:

  - move `MAX_VLAN` macro to include/hw/virtio/virtio-net.h
instead of net/vhost-vdpa.c
  - fix conflicts with the master branch

Thanks!

[1]. https://lists.gnu.org/archive/html/qemu-devel/2022-09/msg01016.html


>
> TestStep
> =3D=3D=3D=3D=3D=3D=3D=3D
> 1. test the migration using vp-vdpa device
>    - For L0 guest, boot QEMU with two virtio-net-pci net device with
> `ctrl_vq`, `ctrl_vlan` features on, command line like:
>        -device virtio-net-pci,disable-legacy=3Don,disable-modern=3Doff,
> iommu_platform=3Don,mq=3Don,ctrl_vq=3Don,guest_announce=3Doff,
> indirect_desc=3Doff,queue_reset=3Doff,ctrl_vlan=3Don,...
>
>    - For L1 guest, apply the patch series and compile the source code,
> start QEMU with two vdpa device with svq mode on, enable the `ctrl_vq`,
> `ctrl_vlan` features on, command line like:
>        -netdev type=3Dvhost-vdpa,x-svq=3Dtrue,...
>        -device virtio-net-pci,mq=3Don,guest_announce=3Doff,ctrl_vq=3Don,
> ctrl_vlan=3Don,...
>
>    - For L2 source guest, run the following bash command:
> ```bash
> #!/bin/sh
>
> for idx in {1..4094}
> do
>    ip link add link eth0 name vlan$idx type vlan id $idx
> done
> ```
>
>    - gdb attaches the L2 dest VM and break at the
> vhost_vdpa_net_load_single_vlan(), and execute the following
> gdbscript
> ```gdbscript
> ignore 1 4094
> c
> ```
>
>    - Execute the live migration in L2 source monitor
>
>    - Result
>      * with this series, gdb can hit the breakpoint and continue
> the executing without triggering any error or warning.
>
> Eugenio P=C3=A9rez (1):
>    virtio-net: do not reset vlan filtering at set_features
>
> Hawkins Jiawei (3):
>    virtio-net: Expose MAX_VLAN
>    vdpa: Restore vlan filtering state
>    vdpa: Allow VIRTIO_NET_F_CTRL_VLAN in SVQ
>
>   hw/net/virtio-net.c            |  6 +---
>   include/hw/virtio/virtio-net.h |  6 ++++
>   net/vhost-vdpa.c               | 50 ++++++++++++++++++++++++++++++++++
>   3 files changed, 57 insertions(+), 5 deletions(-)
>


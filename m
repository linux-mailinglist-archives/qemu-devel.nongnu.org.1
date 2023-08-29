Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F48A78C192
	for <lists+qemu-devel@lfdr.de>; Tue, 29 Aug 2023 11:34:04 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qav5e-0006NQ-8j; Tue, 29 Aug 2023 05:32:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yin31149@gmail.com>)
 id 1qav5b-0006Li-KW
 for qemu-devel@nongnu.org; Tue, 29 Aug 2023 05:32:48 -0400
Received: from mail-lj1-x22e.google.com ([2a00:1450:4864:20::22e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <yin31149@gmail.com>)
 id 1qav5U-0000gc-8I
 for qemu-devel@nongnu.org; Tue, 29 Aug 2023 05:32:47 -0400
Received: by mail-lj1-x22e.google.com with SMTP id
 38308e7fff4ca-2bce552508fso63173001fa.1
 for <qemu-devel@nongnu.org>; Tue, 29 Aug 2023 02:32:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1693301555; x=1693906355;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=NMWzLxF38Yr4MtEaNnmg37wxY4egQRlZlFPxiPTZgIQ=;
 b=XylKnyqsIPLTBYu2+Vlf0rWsKVlIhRcpvAR6XAHzJqdh/IUfqLEcNezl/aWHVWP09r
 2W30rh9nxqtGC8VS/UUahf0DHeFyXsjMO9QRlcK3sEYjHpCpBJFmbwWaUUIpkZl8wMGi
 LknR7+edgO+LUIVm2X7tup9Hbcunvs6hpqTsSQnCOzbrNfQTZgluQN8/kZAu0cR2xjNI
 1Tp32BLweiLshIrRyJpc3aABrqoFt0tcjjmfR3h4pa/1t1X0AepfkfC1lTIRtJEqbZVp
 kA0XX4lpkYKFqPfZ9WhIcikdUx5e5N/39Zc7iv0HitQtHhGatr37zVz1+w/yFxmgBGgb
 ecUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693301555; x=1693906355;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=NMWzLxF38Yr4MtEaNnmg37wxY4egQRlZlFPxiPTZgIQ=;
 b=abdscVhbQwXyY+jcosibjKsnkookQG0qtcpfKoDXYKCTesqK5usDrmN2fgenIYWiOh
 kFGfMLHZl+d9Yz8bGoCGGrkhZ9FrkKBYw3++EomRagvt3yB9FsjxE00sxQWoYwVil9ko
 6VCUSGvmrAvFcjgkSVd9ld1IMcYw1MCunob7Ct5rLLUwzLO9ZuxlyWILo852YmbTHfmW
 48xthPk5URbQdgPdSyErYtICM7x5LgqdoCm1pIX1IsBd9x+Y8tqhrmVjePFZaJ2zwrgm
 OwqaX2/Uh06qSSqg/Mh4pa2oFR/VjjsMZG4ms88Kuk0P+IAbR87fylabc5wQlFabDhpw
 69Xg==
X-Gm-Message-State: AOJu0YxZbrAT7jnSu7d87/DE8yjsbySrtE1BceUsoywPbuts1bX/Qfj9
 C68SZavOS4qZiPMQBm7OKKmIfYQQcfm6bbBocpw=
X-Google-Smtp-Source: AGHT+IH9nG+zTnDbe6LlfDo6V53/Qjc/t/Glo+PZPwfvTPczf9/N4ZQgl01EXzw4TxJdypFBEMXI41gAGw4cFPQYoh8=
X-Received: by 2002:a2e:9c10:0:b0:2b6:ee99:fffc with SMTP id
 s16-20020a2e9c10000000b002b6ee99fffcmr19753804lji.36.1693301554789; Tue, 29
 Aug 2023 02:32:34 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1693287885.git.yin31149@gmail.com>
In-Reply-To: <cover.1693287885.git.yin31149@gmail.com>
From: Hawkins Jiawei <yin31149@gmail.com>
Date: Tue, 29 Aug 2023 17:32:22 +0800
Message-ID: <CAKrof1N_udjsqJVgm0jx0Fc8PmZTUOx-7cbVi_yLJeXqR_V4Jg@mail.gmail.com>
Subject: Re: [PATCH v4 0/8] vdpa: Send all CVQ state load commands in parallel
To: jasowang@redhat.com, mst@redhat.com, eperezma@redhat.com
Cc: qemu-devel@nongnu.org, leiyang@redhat.com, 18801353760@163.com
Content-Type: text/plain; charset="UTF-8"
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

On 2023/8/29 13:54, Hawkins Jiawei wrote:
> This patchset allows QEMU to delay polling and checking the device
> used buffer until either the SVQ is full or control commands shadow
> buffers are full, instead of polling and checking immediately after
> sending each SVQ control command, so that QEMU can send all the SVQ
> control commands in parallel, which have better performance improvement.
>
> I use vp_vdpa device to simulate vdpa device, and create 4094 VLANS in
> guest to build a test environment for sending multiple CVQ state load
> commands. This patch series can improve latency from 20455 us to
> 13732 us for about 4099 CVQ state load commands, about 1.64 us per command.
>
> Note that this patch should be based on
> patch "Vhost-vdpa Shadow Virtqueue VLAN support" at [1].
>
> [1]. https://lore.kernel.org/all/cover.1690100802.git.yin31149@gmail.com/

Sorry for the outdated link. The correct link for this patch should
be https://lore.kernel.org/all/cover.1690106284.git.yin31149@gmail.com/

Thanks!


>
> TestStep
> ========
> 1. regression testing using vp-vdpa device
>    - For L0 guest, boot QEMU with two virtio-net-pci net device with
> `ctrl_vq`, `ctrl_rx`, `ctrl_rx_extra` features on, command line like:
>        -device virtio-net-pci,disable-legacy=on,disable-modern=off,
> iommu_platform=on,mq=on,ctrl_vq=on,guest_announce=off,
> indirect_desc=off,queue_reset=off,ctrl_rx=on,ctrl_rx_extra=on,...
>
>    - For L1 guest, apply the patch series and compile the source code,
> start QEMU with two vdpa device with svq mode on, enable the `ctrl_vq`,
> `ctrl_rx`, `ctrl_rx_extra` features on, command line like:
>        -netdev type=vhost-vdpa,x-svq=true,...
>        -device virtio-net-pci,mq=on,guest_announce=off,ctrl_vq=on,
> ctrl_rx=on,ctrl_rx_extra=on...
>
>    - For L2 source guest, run the following bash command:
> ```bash
> #!/bin/sh
>
> for idx1 in {0..9}
> do
>    for idx2 in {0..9}
>    do
>      for idx3 in {0..6}
>      do
>        ip link add macvlan$idx1$idx2$idx3 link eth0
> address 4a:30:10:19:$idx1$idx2:1$idx3 type macvlan mode bridge
>        ip link set macvlan$idx1$idx2$idx3 up
>      done
>    done
> done
> ```
>    - Execute the live migration in L2 source monitor
>
>    - Result
>      * with this series, QEMU should not trigger any error or warning.
>
>
>
> 2. perf using vp-vdpa device
>    - For L0 guest, boot QEMU with two virtio-net-pci net device with
> `ctrl_vq`, `ctrl_vlan` features on, command line like:
>        -device virtio-net-pci,disable-legacy=on,disable-modern=off,
> iommu_platform=on,mq=on,ctrl_vq=on,guest_announce=off,
> indirect_desc=off,queue_reset=off,ctrl_vlan=on,...
>
>    - For L1 guest, apply the patch series, then apply an addtional
> patch to record the load time in microseconds as following:
> ```diff
> diff --git a/hw/net/vhost_net.c b/hw/net/vhost_net.c
> index 6b958d6363..501b510fd2 100644
> --- a/hw/net/vhost_net.c
> +++ b/hw/net/vhost_net.c
> @@ -295,7 +295,10 @@ static int vhost_net_start_one(struct vhost_net *net,
>       }
>
>       if (net->nc->info->load) {
> +        int64_t start_us = g_get_monotonic_time();
>           r = net->nc->info->load(net->nc);
> +        error_report("vhost_vdpa_net_load() = %ld us",
> +                     g_get_monotonic_time() - start_us);
>           if (r < 0) {
>               goto fail;
>           }
> ```
>
>    - For L1 guest, compile the code, and start QEMU with two vdpa device
> with svq mode on, enable the `ctrl_vq`, `ctrl_vlan` features on,
> command line like:
>        -netdev type=vhost-vdpa,x-svq=true,...
>        -device virtio-net-pci,mq=on,guest_announce=off,ctrl_vq=on,
> ctrl_vlan=on...
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
>    - execute the live migration in L2 source monitor
>
>    - Result
>      * with this series, QEMU should not trigger any warning
> or error except something like "vhost_vdpa_net_load() = 13732 us"
>      * without this series, QEMU should not trigger any warning
> or error except something like "vhost_vdpa_net_load() = 20455 us"
>
> ChangeLog
> =========
> v4:
>    - refactor subject line suggested by Eugenio in patch
> "vhost: Add count argument to vhost_svq_poll()"
>    - split `in` to `vdpa_in` and `model_in` instead of reusing `in`
> in vhost_vdpa_net_handle_ctrl_avail() suggested by Eugenio in patch
> "vdpa: Use iovec for vhost_vdpa_net_cvq_add()"
>    - pack CVQ command by iov_from_buf() instead of accessing
> `out` directly suggested by Eugenio in patch
> "vdpa: Avoid using vhost_vdpa_net_load_*() outside vhost_vdpa_net_load()"
>    - always check the return value of vhost_vdpa_net_svq_poll()
> suggested Eugenio in patch
> "vdpa: Move vhost_svq_poll() to the caller of vhost_vdpa_net_cvq_add()"
>    - use `struct iovec` instead of `void **` as cursor,
> add vhost_vdpa_net_load_cursor_reset() helper function
> to reset the cursors, refactor vhost_vdpa_net_load_cmd() to prepare buffers
> by iov_copy() instead of accessing `in` and `out` directly
> suggested by Eugenio in patch
> "vdpa: Introduce cursors to vhost_vdpa_net_loadx()"
>    - refactor argument `cmds_in_flight` to `len` for
> vhost_vdpa_net_svq_full(), check the return value of
> vhost_vdpa_net_svq_poll() in vhost_vdpa_net_svq_flush(),
> use iov_size(), vhost_vdpa_net_load_cursor_reset()
> and iov_discard_front() to update the cursors instead of
> accessing it directly according to Eugenio in patch
> "vdpa: Send cvq state load commands in parallel"
>
> v3: https://lore.kernel.org/all/cover.1689748694.git.yin31149@gmail.com/
>    - refactor vhost_svq_poll() to accept cmds_in_flight
> suggested by Jason and Eugenio
>    - refactor vhost_vdpa_net_cvq_add() to make control commands buffers
> is not tied to `s->cvq_cmd_out_buffer` and `s->status`, so we can reuse
> it suggested by Eugenio
>    - poll and check when SVQ is full or control commands shadow buffers is
> full
>
> v2: https://lore.kernel.org/all/cover.1683371965.git.yin31149@gmail.com/
>    - recover accidentally deleted rows
>    - remove extra newline
>    - refactor `need_poll_len` to `cmds_in_flight`
>    - return -EINVAL when vhost_svq_poll() return 0 or check
> on buffers written by device fails
>    - change the type of `in_cursor`, and refactor the
> code for updating cursor
>    - return directly when vhost_vdpa_net_load_{mac,mq}()
> returns a failure in vhost_vdpa_net_load()
>
> v1: https://lore.kernel.org/all/cover.1681732982.git.yin31149@gmail.com/
>
> Hawkins Jiawei (8):
>    vhost: Add count argument to vhost_svq_poll()
>    vdpa: Use iovec for vhost_vdpa_net_cvq_add()
>    vhost: Expose vhost_svq_available_slots()
>    vdpa: Avoid using vhost_vdpa_net_load_*() outside
>      vhost_vdpa_net_load()
>    vdpa: Check device ack in vhost_vdpa_net_load_rx_mode()
>    vdpa: Move vhost_svq_poll() to the caller of vhost_vdpa_net_cvq_add()
>    vdpa: Introduce cursors to vhost_vdpa_net_loadx()
>    vdpa: Send cvq state load commands in parallel
>
>   hw/virtio/vhost-shadow-virtqueue.c |  38 +--
>   hw/virtio/vhost-shadow-virtqueue.h |   3 +-
>   net/vhost-vdpa.c                   | 380 +++++++++++++++++++----------
>   3 files changed, 276 insertions(+), 145 deletions(-)
>


Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E515174BD19
	for <lists+qemu-devel@lfdr.de>; Sat,  8 Jul 2023 11:26:55 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qI4Cb-0002OA-Sy; Sat, 08 Jul 2023 05:26:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yin31149@gmail.com>)
 id 1qI4CX-0002NQ-Km
 for qemu-devel@nongnu.org; Sat, 08 Jul 2023 05:26:03 -0400
Received: from mail-pg1-x533.google.com ([2607:f8b0:4864:20::533])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <yin31149@gmail.com>)
 id 1qI4CV-00019i-UP
 for qemu-devel@nongnu.org; Sat, 08 Jul 2023 05:26:01 -0400
Received: by mail-pg1-x533.google.com with SMTP id
 41be03b00d2f7-517ab9a4a13so1963099a12.1
 for <qemu-devel@nongnu.org>; Sat, 08 Jul 2023 02:25:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1688808358; x=1691400358;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=ed+mBC48gD50Mkluc3XmnOQVJFrgRWRd34h5tPDKo78=;
 b=c18lz0D7jxxThGGQ7dsZ+B5+qkbFScKq/amucoq7PnKjHbJ4nfs+62AVesxOoaGBy1
 hudVP8X0UCUqhdMG+ZEW1uzxTbOSkIB5Hu+A3dBNOquA9mSnlMX0ePkVa7nxFMTvwtcx
 /vP65trYVCHZ+SjP+oExGps+u6EU5MwpCUKDpySD1Z5JWzGGwFGFMho2BUJswzJVoCm/
 5CAD2VxTxdziGIelvjsPNf+dgRedyjnym5UO3QEN71aghEmBdJSJHDBB3CDIxO/z3BMA
 pkg6kpKfWGy54wMDXZJb31oqxZfA20zbVBFVr/Ix3+i6JyqMbq3thmlu9Vw67izPXGJX
 Zrhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688808358; x=1691400358;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ed+mBC48gD50Mkluc3XmnOQVJFrgRWRd34h5tPDKo78=;
 b=djNCZSAMMqQoNZN1VXb3TRN3SsShm4QOC2qcky2iwc3cH/KgSMYkp9kWIW7Z4Ppz3C
 nd76XZLKrBFnZ6u7JnD3g7m1WkR2gnHMVpm6HFmWDTq5gnlfwLjY+DRyYpGn8jFHzLHi
 l/5n6zbG6B7hd668PwOhsUa0iZbIjDcS59zL7wew1xmQdttDUnWwErVpZ3j42dwqu2/2
 bRku++VkWO9p08qrIvRoKPOWhun8RuFL+al6Q0pNsIboYuVGiv151bKWSoy4KYdVlysi
 Y2A88KinOQHPMMEdNXFljdShdY1KyaIINpDpPGLqIOtnOJsnYLAtyLa8aXchwg4t+zLn
 V2Jg==
X-Gm-Message-State: ABy/qLb0bvSJB/Q9EMcpe47pPDIrPX9Gr49QG4OUBpVeSVQHMpH1x8Jl
 vJrz6qQZ3icByqWgfKu+gL0=
X-Google-Smtp-Source: APBJJlHs/4Zx2nD36JwN7m94gcjDRz0QZ4Pvh+hLZsV7gzwzkwCLEtg2n/f083FAZT3irFqPtMeeHA==
X-Received: by 2002:a17:902:ce84:b0:1b8:5aa1:4d10 with SMTP id
 f4-20020a170902ce8400b001b85aa14d10mr7677478plg.54.1688808357998; 
 Sat, 08 Jul 2023 02:25:57 -0700 (PDT)
Received: from localhost ([159.226.94.115]) by smtp.gmail.com with ESMTPSA id
 t11-20020a170902b20b00b001a69c1c78e7sm4542824plr.71.2023.07.08.02.25.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 08 Jul 2023 02:25:57 -0700 (PDT)
From: Hawkins Jiawei <yin31149@gmail.com>
To: jasowang@redhat.com,
	mst@redhat.com,
	eperezma@redhat.com
Cc: qemu-devel@nongnu.org,
	yin31149@gmail.com,
	18801353760@163.com
Subject: [PATCH v3 0/2] Vhost-vdpa Shadow Virtqueue _F_CTRL_RX_EXTRA commands
 support
Date: Sat,  8 Jul 2023 17:24:50 +0800
Message-Id: <cover.1688797728.git.yin31149@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::533;
 envelope-from=yin31149@gmail.com; helo=mail-pg1-x533.google.com
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

This series enables shadowed CVQ to intercept rx commands related to
VIRTIO_NET_F_CTRL_RX_EXTRA feature through shadowed CVQ, update the virtio
NIC device model so qemu send it in a migration, and the restore of
that rx state in the destination.

To test this patch series, one should modify the `n->parent_obj.guest_features`
value in vhost_vdpa_net_load_rx() using gdb, as the linux virtio-net
driver does not currently support the VIRTIO_NET_F_CTRL_RX_EXTRA
feature.

Note that this patch should be based on
[1] patch "Vhost-vdpa Shadow Virtqueue _F_CTRL_RX commands support"

[1]. https://lore.kernel.org/all/cover.1688743107.git.yin31149@gmail.com/

TestStep
========
1. test the patch series using vp-vdpa device

  - For L0 guest, boot QEMU with virtio-net-pci net device with
`ctrl_vq`, `ctrl_rx` and `ctrl_rx_extra` feature on, something like:
      -device virtio-net-pci,rx_queue_size=256,tx_queue_size=256,
iommu_platform=on,ctrl_vq=on,ctrl_rx=on,ctrl_rx_extra=on...

  - For L1 guest, apply the patch series and compile the code,
start QEMU with vdpa device with svq mode and enable the
`ctrl_vq`, `ctrl_rx` and `ctrl_rx_extra` feature on, something like:
      -netdev type=vhost-vdpa,x-svq=true,...
      -device virtio-net-pci,ctrl_vq=on,ctrl_rx=on,ctrl_rx_extra=on...
Use gdb to attach the VM and break at the net/vhost-vdpa.c:870.

With this series, gdb can hit the breakpoint. Enable the
VIRTIO_NET_F_CTRL_RX_EXTRA feature and enable the non-unicast mode
by entering the following gdb commands:
```gdb
set n->parent_obj.guest_features |= (1 << 20)
set n->nouni = 1
c
```
QEMU should not trigger any errors or warnings.

Without this series, QEMU should fail with
"x-svq=true: vdpa svq does not work with features 0x100000".

ChangeLog
=========
v3:
  - return early if mismatch the condition suggested by Eugenio in
patch 1 "vdpa: Restore packet receive filtering state relative with
_F_CTRL_RX_EXTRA feature"
  - remove the `on` variable suggested by Eugenio in patch 1 "vdpa:
Restore packet receive filtering state relative with
_F_CTRL_RX_EXTRA feature"

v2: https://lore.kernel.org/all/cover.1688365324.git.yin31149@gmail.com/
  - avoid sending CVQ command in default state suggested by Eugenio

v1: https://lists.nongnu.org/archive/html/qemu-devel/2023-06/msg04956.html

Hawkins Jiawei (2):
  vdpa: Restore packet receive filtering state relative with
    _F_CTRL_RX_EXTRA feature
  vdpa: Allow VIRTIO_NET_F_CTRL_RX_EXTRA in SVQ

 net/vhost-vdpa.c | 89 ++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 89 insertions(+)

-- 
2.25.1



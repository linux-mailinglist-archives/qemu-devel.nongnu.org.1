Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B9698719595
	for <lists+qemu-devel@lfdr.de>; Thu,  1 Jun 2023 10:29:48 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q4dgP-0006Zm-PV; Thu, 01 Jun 2023 04:29:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yin31149@gmail.com>)
 id 1q4dgM-0006ZZ-8M
 for qemu-devel@nongnu.org; Thu, 01 Jun 2023 04:29:19 -0400
Received: from mail-pj1-x1029.google.com ([2607:f8b0:4864:20::1029])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <yin31149@gmail.com>)
 id 1q4dgJ-00029w-2R
 for qemu-devel@nongnu.org; Thu, 01 Jun 2023 04:29:18 -0400
Received: by mail-pj1-x1029.google.com with SMTP id
 98e67ed59e1d1-2566ed9328eso384885a91.2
 for <qemu-devel@nongnu.org>; Thu, 01 Jun 2023 01:29:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1685608147; x=1688200147;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=as9SrjoeY0dL+cXxUsgMjAPmEAYGDdZhGcQ/x+yw0QE=;
 b=sRmWNf8XqWQGgioUKSRb1/D2X6OMhpObS8WgxQnmsE7P4JV93wmC+tl4tJYPCGXWPd
 /sOJL+SX508e9Qzn7p3NGcGjcUMsLjccsh0dHQalmbDxVQT/xnCg/W2bmE/7OBJge9bA
 rnxVQYiO3P3k6QjiaNo2Uoegl8J5H0Q2TkROLlcml0uS7WWWOitKPra0kQKju3tUUTLu
 zhQIgTrueOFni4lE+dKAYpPDhEJJ2w+Q18wHUZG24RuVn/lv3v3KOrwuJJvuDrQdJyqc
 IMF7PvjN7jsDGp+1bTtcCNiD20CHjBhYV8exBgTlrub1JZFHm7CVq89w9e2meDDhJ7/c
 6QSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685608147; x=1688200147;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=as9SrjoeY0dL+cXxUsgMjAPmEAYGDdZhGcQ/x+yw0QE=;
 b=iH/HtH8zTJMzrYaZZBIPz4b6radrXz+h7fOxWhQuCKLa1JJ4/obesvjDMlOo2PxEXw
 vBS7tu5/qMgaofjHXWXeB/BgJ3HYih5TtGQdx37QrgwoqY7MfEBQk8wzu4P4ElkDfjnR
 6ClnRk4RIagxVDwnB/k4oC0o/T1KVG4dJqjeqNxL66DXnbbEtCxEiR6WtgxyMT2sOXgI
 yWwz2ODgMtKm8l4RjdRbBZmRy6zahua52DQTsgtIFWoXGNuOjf5xn36K9n5X4ydjLZIt
 NDHv9pNUItPdgVKnbZJVhvfmIcDrrjcRNYr0rbi3ZgDbXqvD2yT86P2XKsBrYKaWU8mr
 yJKA==
X-Gm-Message-State: AC+VfDy2Cm61szLaSa3JQ1KXJBO8/Vwt21VP7jLprK8/aARj7CA02GKk
 Soxrk3fFoE0zAws27V+jZrY=
X-Google-Smtp-Source: ACHHUZ5DpP/mUBUp09fhHPZm+7Z9ropheKUhHxHDARl9/XxBPvdZG7nsv/Ge8XnNM9UrjZ+DFNPCXg==
X-Received: by 2002:a17:90a:db8f:b0:258:9180:1999 with SMTP id
 h15-20020a17090adb8f00b0025891801999mr3033560pjv.32.1685608147208; 
 Thu, 01 Jun 2023 01:29:07 -0700 (PDT)
Received: from localhost ([117.136.38.170]) by smtp.gmail.com with ESMTPSA id
 gj4-20020a17090b108400b0024744818bc5sm884289pjb.9.2023.06.01.01.29.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 01 Jun 2023 01:29:06 -0700 (PDT)
From: Hawkins Jiawei <yin31149@gmail.com>
To: jasowang@redhat.com,
	mst@redhat.com,
	eperezma@redhat.com
Cc: qemu-devel@nongnu.org,
	yin31149@gmail.com
Subject: [PATCH v2 0/6] Vhost-vdpa Shadow Virtqueue Offloads support
Date: Thu,  1 Jun 2023 16:28:43 +0800
Message-Id: <cover.1685584543.git.yin31149@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1029;
 envelope-from=yin31149@gmail.com; helo=mail-pj1-x1029.google.com
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

This series enables shadowed CVQ to intercept Offloads commands
through shadowed CVQ, update the virtio NIC device model so qemu
send it in a migration, and the restore of that Offloads state
in the destination.

Changelog
=========
v2:
  - make some function arguments const
  - reuse virtio_vdev_has_feature() suggested by Eugenio and Jason
  - avoid sending CVQ command in default state suggested by Eugenio

v1: https://lore.kernel.org/all/cover.1685359572.git.yin31149@gmail.com/

Hawkins Jiawei (6):
  include/hw/virtio: make some VirtIODevice const
  vdpa: reuse virtio_vdev_has_feature()
  hw/net/virtio-net: make some VirtIONet const
  virtio-net: expose virtio_net_supported_guest_offloads()
  vdpa: Add vhost_vdpa_net_load_offloads()
  vdpa: Allow VIRTIO_NET_F_CTRL_GUEST_OFFLOADS in SVQ

 hw/net/virtio-net.c            |  2 +-
 include/hw/virtio/virtio-net.h |  1 +
 include/hw/virtio/virtio.h     |  2 +-
 net/vhost-vdpa.c               | 45 +++++++++++++++++++++++++++++++---
 4 files changed, 44 insertions(+), 6 deletions(-)

-- 
2.25.1



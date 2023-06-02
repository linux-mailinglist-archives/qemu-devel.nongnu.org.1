Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E3177200E8
	for <lists+qemu-devel@lfdr.de>; Fri,  2 Jun 2023 13:53:31 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q53KY-000828-3p; Fri, 02 Jun 2023 07:52:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yin31149@gmail.com>)
 id 1q53KW-00080H-IL
 for qemu-devel@nongnu.org; Fri, 02 Jun 2023 07:52:28 -0400
Received: from mail-ot1-x335.google.com ([2607:f8b0:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <yin31149@gmail.com>)
 id 1q53KU-0007EZ-L2
 for qemu-devel@nongnu.org; Fri, 02 Jun 2023 07:52:28 -0400
Received: by mail-ot1-x335.google.com with SMTP id
 46e09a7af769-6af6f83fc49so1831124a34.3
 for <qemu-devel@nongnu.org>; Fri, 02 Jun 2023 04:52:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1685706744; x=1688298744;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=CSc47GYuAJNVwVWHsUlPMYugFsEsmFK4xj66uANW+uA=;
 b=p3KIbGkiVycaFOcTJ9e6ZgJJKNpOzgT9MQWx9/aiuF40AWi48aH8hm4t6BclgKcVjA
 sgFp/+c+HEpRZZIaQLJwSVfiL3yj41ozVCnV+VGE0VQ7F4Op77JaxOeRZjEqjfz6sX8g
 y5ygR3dfacXvNuvpOFJf4cG1Dg7BJ0VlZWvMtILEU9Q3m+5kUHuNAasYdhhNWHhSeTOG
 JjVZ98qlA0EM0QcdbaWAw39akYur7uSPUjEPntvkNQ41zEhkkvp7I1pP0qdtF/jTeZMq
 +KtBeN+QatqZgUzS5t45J0psrRHxhlnWBVUYzW8eZ/OzrkFnWVK/dSJ4zF1bc/JG+kLT
 zyjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685706744; x=1688298744;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=CSc47GYuAJNVwVWHsUlPMYugFsEsmFK4xj66uANW+uA=;
 b=EZ1GWVinP3bV1vw6OMLbBKD3yMg79BcWh+j/lIzNLAd2f2nlD+FppHq9ZLMT6INBJz
 WbPpAlSe3tmU/+379gkqhqlnUcZPpak7JMzJrjAt4dBoHaXCROIc0W5E3EuJYEFIj2l2
 RPpDa2ei1kqoMwBFKXDSr2fsI81FJOXyfgtKHAzsswGemeyUXrzHlXxMxlHBCW1YzZ0X
 s0N8tDtUIGUDaWBPoVAOKEPDofBc9clXTd3mvw0OkRWZ+8I3REJlqsSEB+/fAps/JI0o
 KyOVJfOVn4C8FL1vFl7AyutjlMbv6SjKieasQKJmP5Dmq36ZB8aFgMGb/ekMn7VrF4qg
 Spxw==
X-Gm-Message-State: AC+VfDztBnZovL0e27T3iNxC1haxwDlL3cKZe+0a/E63l9HXCYNmJU4X
 vBESmUwDwoir92+LOBDOM7M=
X-Google-Smtp-Source: ACHHUZ6x+1sU5G5x/2rtgDDqgxabpiO3fMrVTxLxP2JSkk3RkL22k8Fkat4iDpDoPg0mgpf9fttmJw==
X-Received: by 2002:a9d:740d:0:b0:6af:867b:940e with SMTP id
 n13-20020a9d740d000000b006af867b940emr2345281otk.2.1685706744524; 
 Fri, 02 Jun 2023 04:52:24 -0700 (PDT)
Received: from localhost ([159.226.94.115]) by smtp.gmail.com with ESMTPSA id
 u4-20020aa78484000000b0064381853bfcsm876310pfn.89.2023.06.02.04.52.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 02 Jun 2023 04:52:24 -0700 (PDT)
From: Hawkins Jiawei <yin31149@gmail.com>
To: jasowang@redhat.com,
	mst@redhat.com,
	eperezma@redhat.com
Cc: qemu-devel@nongnu.org,
	yin31149@gmail.com,
	18801353760@163.com
Subject: [PATCH v4 0/6] Vhost-vdpa Shadow Virtqueue Offloads support
Date: Fri,  2 Jun 2023 19:52:12 +0800
Message-Id: <cover.1685704856.git.yin31149@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::335;
 envelope-from=yin31149@gmail.com; helo=mail-ot1-x335.google.com
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
v4:
  - refactor the commit message suggested by Eugenio in patch#4
"virtio-net: expose virtio_net_supported_guest_offloads()"
  - fix the wrong "cpu_to_le64()" pointed out by Eugenio in patch$5
"vdpa: Add vhost_vdpa_net_load_offloads()"
  - refactor the comment in patch#5
"vdpa: Add vhost_vdpa_net_load_offloads()"

v3: https://lists.nongnu.org/archive/html/qemu-devel/2023-06/msg00206.html

v2: https://lists.nongnu.org/archive/html/qemu-devel/2023-06/msg00044.html

v1: https://lists.nongnu.org/archive/html/qemu-devel/2023-05/msg07198.html

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
 net/vhost-vdpa.c               | 49 +++++++++++++++++++++++++++++++---
 4 files changed, 48 insertions(+), 6 deletions(-)

-- 
2.25.1



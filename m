Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 20B24A72A4A
	for <lists+qemu-devel@lfdr.de>; Thu, 27 Mar 2025 07:46:03 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1txgyH-0002SC-3u; Thu, 27 Mar 2025 02:44:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <haoqian.he@smartx.com>)
 id 1txgyD-0002Rr-FA
 for qemu-devel@nongnu.org; Thu, 27 Mar 2025 02:44:05 -0400
Received: from mail-pl1-x62d.google.com ([2607:f8b0:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <haoqian.he@smartx.com>)
 id 1txgy9-0004En-S6
 for qemu-devel@nongnu.org; Thu, 27 Mar 2025 02:44:05 -0400
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-223f4c06e9fso11759445ad.1
 for <qemu-devel@nongnu.org>; Wed, 26 Mar 2025 23:43:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=smartx-com.20230601.gappssmtp.com; s=20230601; t=1743057837; x=1743662637;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=C+zfiR6YSWsh1kwihUZptaCkLfGMteo+gW0ow9r6wKY=;
 b=2XjP96Mpvef4wUOzG+7nNwpRqO1cvX0Pxk9qVCAWCIKWO8XIhyFDDp9kVc/cY2DIda
 GhDa7d/tMuJAxplRC7OikfGAdDbYKaHeAL3VrwsgBMm3szka4FT5dU3mP5qpl9h8ifGZ
 6bih/8s3QvUBwpaLXnf1cQ3rxvkZs4wIw21OzpN4gIYnJqR6fHUUkpe8eEs1pDP/r+Kr
 1tVaC7gyC/nG2F8F0SI9voxAXU/qVkqXGOPQRv3hx53vzOUwkBnOZHZ1sS6ZwV7zW6fv
 0Pt7pGBLRkl2mOS/nVlcYxQw6m015Z6Wy1NngBc0FFkilX/7uuZr4gb+qCiowHEneGfZ
 9bJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743057837; x=1743662637;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=C+zfiR6YSWsh1kwihUZptaCkLfGMteo+gW0ow9r6wKY=;
 b=sy6cv/QuQXmNSc10eqZMPS/MB5nfFKucugh8BCQljQZm0ZVcvoAZgUBP6G64RuGxsZ
 m8CSMufQT/bbg8GztW4RfrfnL9ajWvVyn7CF2R2MGcbuBYeaBc2OrE6I3uHMCOs1awcn
 +UFed39pUgI7yWrLa+rSeSgsY2jAQfE4FWNvLBGWbXy3wocZOF7kQNHuVx9erPejcziE
 Db9RTOQOj0KUKQ3EmNYOCTZzvJlg4C/Pa7GLDqKUPQfYalMV/gmVFaa1plOwD3X6wdRJ
 CPJcdP5E1CfQ4jyZ0tSqNvZym/fMERy9EPYgZ5VJiX6QRN47MSh2f0owXGXldM5+dKAv
 hKvQ==
X-Gm-Message-State: AOJu0Yx+DztVhoDYVzL+wl2Yp+rPoAn0Dd/1RZirK73Y2eiq3Aln1jYv
 tq6K2qBFlOIvR3nwZTWcGAj1ZMzWlvDydj0wqYGAZdpIFhp1dV3tayAQ92ZPcE13JiO5UDRSETD
 LrWE=
X-Gm-Gg: ASbGncuUZoNoML7usA41+hocarWPxMZ5DqKCx2pRc/LvDXNWxhnX9ld90jgZ7ydugZX
 4mw8KtQxBMAhbDTPMW8iFSQ6o9uoJ1SRZuN5Bj0f8NQH5WdL9qOOXuFC41NWvcRIMXn46QP7d6m
 zLV5IPqN6/DQP8U0L6mBO3xVeY3OQAw/x974+gxtkDUwBMBU/RXI0LfKzU1BAL4dIPOSn7j+A9m
 dhzbjsR9JqglNnqygZSp+Wr4jfoLUbr/hiooSzPbKA7Vom/oWBg7JbgyBRg3DrpDExuFjW8dEY1
 hymBeCeRkG2RuYmCtqQERPCNp+PLMtZGto3yXqgW/g==
X-Google-Smtp-Source: AGHT+IEieRCHW4TwTVVXc4ir3LRkvx9yWwzXIHRYWzATDJCO+YtsxOOyxsQ+3EIIOu/npBDkBI6Fog==
X-Received: by 2002:a17:902:dac8:b0:226:194f:48ef with SMTP id
 d9443c01a7336-227efb00eafmr95433845ad.13.1743057836599; 
 Wed, 26 Mar 2025 23:43:56 -0700 (PDT)
Received: from fedora.smartx.com ([2001:df0:a640:1::4])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22780f4599fsm121983015ad.67.2025.03.26.23.43.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 26 Mar 2025 23:43:56 -0700 (PDT)
From: Haoqian He <haoqian.he@smartx.com>
To: qemu-devel@nongnu.org, sgarzare@redhat.com, mst@redhat.com,
 raphael@enfabrica.net
Cc: fengli@smartx.com, yuhua@smartx.com, Kevin Wolf <kwolf@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>, Amit Shah <amit@kernel.org>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Jason Wang <jasowang@redhat.com>, Fam Zheng <fam@euphon.net>,
 Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 mzamazal@redhat.com (reviewer:vhost-user-scmi),
 David Hildenbrand <david@redhat.com>,
 "Gonglei (Arei)" <arei.gonglei@huawei.com>,
 Eric Auger <eric.auger@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 qemu-block@nongnu.org (open list:Block layer core),
 virtio-fs@lists.linux.dev (open list:virtiofs)
Subject: [PATCH v3 0/3] vhost: fix the IO error after live migration
Date: Thu, 27 Mar 2025 02:43:44 -0400
Message-ID: <20250327064348.3595732-1-haoqian.he@smartx.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20250314101535.1059308-1-haoqian.he@smartx.com>
References: <20250314101535.1059308-1-haoqian.he@smartx.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62d;
 envelope-from=haoqian.he@smartx.com; helo=mail-pl1-x62d.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

At the end of the VM live migration, the vhost device will be stopped.
Currently, if the vhost-user backend crashes, vhost device's set_status()
would not return failure, live migration won't perceive the disconnection
with the backend. After the live migration is successful, the stale inflight
IO will be submitted to the migration target host, which may be leading to
the IO error.

The following patch series fixes the issue by making the live migration
aware of the loss of connection with the vhost-user backend and aborting
the live migration.

---
  v1 ... v2
    1. Fix some grammar issues in commit message.
    2. Remove assert in vhost_scsi_common_stop and return error upwards.

  v2 ... v3
    1. Added more detailed comments and commit message.
    2. Change the newly added type name and parameter name.
    3. Remove set_status_ext, change the return type of set_status to int.

Haoqian He (3):
  system/runstate: add VM state change cb with return value
  vhost: return failure if stop virtqueue failed in vhost_dev_stop
  vhost-user: return failure if backend crash when live migration

 backends/vhost-user.c                  | 20 +++++++--------
 hw/block/vhost-user-blk.c              | 27 +++++++++++---------
 hw/block/virtio-blk.c                  |  7 +++---
 hw/char/virtio-serial-bus.c            |  3 ++-
 hw/core/vm-change-state-handler.c      | 18 ++++++++-----
 hw/display/vhost-user-gpu.c            | 12 ++++++---
 hw/input/virtio-input.c                |  3 ++-
 hw/net/virtio-net.c                    |  3 ++-
 hw/scsi/scsi-bus.c                     |  2 +-
 hw/scsi/vhost-scsi-common.c            | 13 +++++-----
 hw/scsi/vhost-scsi.c                   |  5 ++--
 hw/scsi/vhost-user-scsi.c              | 18 +++++++------
 hw/vfio/migration.c                    |  2 +-
 hw/virtio/vdpa-dev.c                   |  5 ++--
 hw/virtio/vhost-user-base.c            | 23 ++++++++++-------
 hw/virtio/vhost-user-fs.c              | 23 ++++++++++-------
 hw/virtio/vhost-user-scmi.c            | 27 ++++++++++++--------
 hw/virtio/vhost-user-vsock.c           | 15 +++++++----
 hw/virtio/vhost-vsock-common.c         | 12 ++++-----
 hw/virtio/vhost-vsock.c                | 11 ++++----
 hw/virtio/vhost.c                      | 23 +++++++++--------
 hw/virtio/virtio-balloon.c             |  3 ++-
 hw/virtio/virtio-crypto.c              |  3 ++-
 hw/virtio/virtio-iommu.c               |  3 ++-
 hw/virtio/virtio-rng.c                 |  5 ++--
 hw/virtio/virtio.c                     | 23 +++++++++++------
 include/hw/virtio/vhost-scsi-common.h  |  2 +-
 include/hw/virtio/vhost-vsock-common.h |  2 +-
 include/hw/virtio/vhost.h              |  8 +++---
 include/hw/virtio/virtio.h             |  2 +-
 include/system/runstate.h              | 13 +++++++---
 include/system/vhost-user-backend.h    |  2 +-
 system/cpus.c                          |  8 ++++--
 system/runstate.c                      | 35 ++++++++++++++++++++++----
 34 files changed, 239 insertions(+), 142 deletions(-)

-- 
2.44.0



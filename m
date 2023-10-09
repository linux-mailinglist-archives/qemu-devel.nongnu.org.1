Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 16DA07BD2A0
	for <lists+qemu-devel@lfdr.de>; Mon,  9 Oct 2023 06:49:12 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qpiBY-0008J1-Pr; Mon, 09 Oct 2023 00:48:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <fengli@smartx.com>) id 1qpiBV-0008IZ-9j
 for qemu-devel@nongnu.org; Mon, 09 Oct 2023 00:48:01 -0400
Received: from mail-pg1-x544.google.com ([2607:f8b0:4864:20::544])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <fengli@smartx.com>) id 1qpiBR-0003QM-Ep
 for qemu-devel@nongnu.org; Mon, 09 Oct 2023 00:48:00 -0400
Received: by mail-pg1-x544.google.com with SMTP id
 41be03b00d2f7-565334377d0so3327205a12.2
 for <qemu-devel@nongnu.org>; Sun, 08 Oct 2023 21:47:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=smartx-com.20230601.gappssmtp.com; s=20230601; t=1696826873; x=1697431673;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=0TT3voGAEEEbZsUtmN3qQyrLAc58n1hYMLFCwUVXUGE=;
 b=sXx9mI8SwBzpp7OjzdXNm9PY0y8sRiqqu4kYdXVbChjrCB0hktrrzpufxDAAWyAPmW
 K5JQLw9OZk8SS6FL8eLgccBkHTt9bHZ9MkyAa1+MgbCGZq8zckrtbUAPpa9PLDjzFSCe
 HDmNjcUv0Em8wdU/0ZMNeB0CPuvacCRtJwd1bwg6bUIvGwPbQN5KVXXsKY07AP0bqwYp
 0b2wSeNsN7+yCQ+Yq7j8oCEhJQyptCaKK6281auFuWjJyMO9DSikxv6mw1XlBue2m2YF
 gHyqdjcCn1V3fKEn11eUFgtmJG9vpjHsF7ZzlIiRY1uvkjHfEeYcJwvobmQOhGTlJFYc
 rKKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696826873; x=1697431673;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=0TT3voGAEEEbZsUtmN3qQyrLAc58n1hYMLFCwUVXUGE=;
 b=HDlEbs7ovvlhecv7Cc3L/Z1F2wtjjtnzgpkc3Z0H3ebgE6ZPU6ICNswKF21IWPSlNc
 JEDD7FMb/Fp4lcXfdGoAF6hmmCrAqub8p0KifbcGgwDplCaRDIronrN+CjYfZE9GAn9Q
 UuesPrkzFNNq/s+bgD+QY6lIhJyKXN970/UIfS/ZijhZoQ0MxgpTchGJOf2s7BuMkPyE
 XspM28OQyZUPA53E+dFTasQHNo11F4brf0EFoJR87cyxYrbkqtenoh9j0VIkOn5kEsSt
 wTOZ9IODwJjclqZqbjqlw4zaINwJ769a2DaC2ds/fVYK7EnHhf6w8VUzMgvDnt6ttR6t
 GbXw==
X-Gm-Message-State: AOJu0YyZAjztts3RQuh1VMK/pt3l0KwEk7sSrd/2aU50W0ZSV9+3mJUJ
 aviXtO7wML0/YX5xDcjBKqKPKw==
X-Google-Smtp-Source: AGHT+IFXE2orDzMOg2aOMyUpU65zmB+//rayRLnjrOFRF+iGMq7onWwxXStv6kB/xorBmrOtvvNKTw==
X-Received: by 2002:a05:6a21:4987:b0:16c:c56b:88a2 with SMTP id
 ax7-20020a056a21498700b0016cc56b88a2mr5586084pzc.56.1696826872635; 
 Sun, 08 Oct 2023 21:47:52 -0700 (PDT)
Received: from 64217.gitgo.cc ([8.210.91.195])
 by smtp.gmail.com with ESMTPSA id
 l4-20020a170902ec0400b001c452f827casm8406010pld.257.2023.10.08.21.47.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 08 Oct 2023 21:47:52 -0700 (PDT)
From: Li Feng <fengli@smartx.com>
To: Markus Armbruster <armbru@redhat.com>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Raphael Norwitz <raphael.norwitz@nutanix.com>,
 Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Fam Zheng <fam@euphon.net>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Viresh Kumar <viresh.kumar@linaro.org>,
 qemu-block@nongnu.org (open list:Block layer core),
 qemu-devel@nongnu.org (open list:All patches CC here)
Cc: Li Feng <fengli@smartx.com>
Subject: [PATCH v8 0/5] Implement reconnect for vhost-user-scsi
Date: Mon,  9 Oct 2023 12:46:56 +0800
Message-ID: <20231009044735.941655-1-fengli@smartx.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::544;
 envelope-from=fengli@smartx.com; helo=mail-pg1-x544.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

Changes for v8:
- [PATCH 3/5] vhost-user-scsi: support reconnect to backend
  - Fix code style suggested by Manos Pitsidianakis
- [PATCH 4/5] vhost-user-scsi: start vhost when guest kicks
  - Use 'DEVICE()' macro in vhost_user_scsi_handle_output to replace the
    'parent_obj.parent_obj.parent_obj.parent_obj'.

Changes for v7:
- [PATCH 3/5] vhost-user-scsi: support reconnect to backend
  - Add reporting the error in vhost-scsi;
  - Rebase to master and fix the conflict.
- Add "Reviewed-by" tags.

Changes for v6:
- [PATCH] vhost-user: fix lost reconnect
  - Fix missing assign event_cb.

Changes for v5:
- No logic has been changed, just move part of the code from patch 4 to patch 5.

Changes for v4:
- Merge
  https://lore.kernel.org/all/20230830045722.611224-1-fengli@smartx.com/ to
  this series.
- Add ERRP_GUARD in vhost_user_scsi_realize;
- Reword the commit messages.

Changes for v3:
- Split the vhost_user_scsi_handle_output to a separate patch;
- Move the started_vu from vhost scsi common header to vhost-user-scsi header;
- Fix a log print error;

Changes for v2:
- Split the v1 patch to small separate patchset;
- New patch for fixing fd leak, which has sent to reviewers in another
  mail;
- Implement the `vhost_user_scsi_handle_output`;
- Add the started_vu safe check;
- Fix error handler;
- Check the inflight before set/get inflight fd.

Li Feng (5):
  vhost-user-common: send get_inflight_fd once
  vhost: move and rename the conn retry times
  vhost-user-scsi: support reconnect to backend
  vhost-user-scsi: start vhost when guest kicks
  vhost-user: fix lost reconnect

 hw/block/vhost-user-blk.c             |   6 +-
 hw/scsi/vhost-scsi-common.c           |  47 ++---
 hw/scsi/vhost-scsi.c                  |   6 +-
 hw/scsi/vhost-user-scsi.c             | 250 +++++++++++++++++++++++---
 hw/virtio/vhost-user-gpio.c           |   5 +-
 hw/virtio/vhost-user.c                |  10 +-
 include/hw/virtio/vhost-scsi-common.h |   2 +-
 include/hw/virtio/vhost-user-scsi.h   |   6 +
 include/hw/virtio/vhost-user.h        |   3 +-
 include/hw/virtio/vhost.h             |   2 +
 10 files changed, 277 insertions(+), 60 deletions(-)

-- 
2.41.0



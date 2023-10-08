Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id EBD867BCD74
	for <lists+qemu-devel@lfdr.de>; Sun,  8 Oct 2023 11:14:31 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qpPqO-0001nJ-G3; Sun, 08 Oct 2023 05:13:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <fengli@smartx.com>) id 1qpPqL-0001mk-8z
 for qemu-devel@nongnu.org; Sun, 08 Oct 2023 05:12:57 -0400
Received: from mail-pg1-x542.google.com ([2607:f8b0:4864:20::542])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <fengli@smartx.com>) id 1qpPqI-0002DF-T6
 for qemu-devel@nongnu.org; Sun, 08 Oct 2023 05:12:57 -0400
Received: by mail-pg1-x542.google.com with SMTP id
 41be03b00d2f7-53fa455cd94so2352510a12.2
 for <qemu-devel@nongnu.org>; Sun, 08 Oct 2023 02:12:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=smartx-com.20230601.gappssmtp.com; s=20230601; t=1696756372; x=1697361172;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=rnVFOuHni0KaTAZauv7NaQS2EYHdhrirk0vmciztBVE=;
 b=B2NKQm2pfFZgVi0ckqeBxyvNWgMIkluF9JH20Bnv3feC0fgkGL8COMgL7OaVD8fgqU
 ZoH2E1/vr/BABYqdJUqX7NQk1ipK4F+1CnKKicgdw/SMdPRvqsvvgWFb9k6N0JFdfbx5
 nUMXngQHBfQzBma5zW3cd1L0t0DdrTNoqF74T6HBqzswn2GO8T0qQYmTis3OVMAnFfug
 zi6LxqyTbP8Ke5Gw0hGA5RNYxBhLDM8Ne97r9s4oe4oyaOAcfkheAX3icjd4FgWzv7hH
 Qd1x0oqt4h8jG5k7Jf2eWD/0ITTBFne7GOVdSzsn+DgqUHomGNAtWnmdhgZ0ksHixr8X
 W0NQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696756372; x=1697361172;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=rnVFOuHni0KaTAZauv7NaQS2EYHdhrirk0vmciztBVE=;
 b=M8kEAW201ah4IKCGylXnXgzaFRMxwOCcFYE22wdgnVgo+F+bWd0HAQ4h8yNNtnXUrK
 6PwRn2fI4NK0XRj4NJLuqAqojQVLK9uPgqRUdBC/QbPs4LiFaYyEKqL9b7bV9eALiFbQ
 nJ5uxcy/XJ+I2xqOSav85FXnltp2KUI1pr4bUhzC1W94JY8OuJnZDL42qM0rfOjhCeEj
 Kc//SOinlw45pts2D7B9AoZE5ZRVq8nYw0SYHO/t8Dr4yFJp6UWex+V8oiI7BlLNpzpt
 8MWyN6v7pIsovkRMhYqTtYIQ2nsLyL3LDEclt5oqs81WaaIZBol9HpI+4g549X868UMs
 Fi0Q==
X-Gm-Message-State: AOJu0YznQrdmNYat6c/rEJbwwzNj/LqOEfIrjgZUvSoC3hkfcp4De/Ge
 BeOJXDQrJQHiQPzarONb23F77g==
X-Google-Smtp-Source: AGHT+IHN8WpHZxmbRGXAqhwY/haYRuZNBRp0KcNizAHBe0u2ucipG6ZPtbcltRk0ThSxf6/EE3V0NQ==
X-Received: by 2002:a17:903:11d2:b0:1b8:8b72:fa28 with SMTP id
 q18-20020a17090311d200b001b88b72fa28mr12873520plh.58.1696756371583; 
 Sun, 08 Oct 2023 02:12:51 -0700 (PDT)
Received: from 64217.gitgo.cc ([8.210.91.195])
 by smtp.gmail.com with ESMTPSA id
 e8-20020a17090301c800b001b8a3e2c241sm7118084plh.14.2023.10.08.02.12.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 08 Oct 2023 02:12:50 -0700 (PDT)
From: Li Feng <fengli@smartx.com>
To: Markus Armbruster <armbru@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Raphael Norwitz <raphael.norwitz@nutanix.com>,
 Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Fam Zheng <fam@euphon.net>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Viresh Kumar <viresh.kumar@linaro.org>,
 qemu-block@nongnu.org (open list:Block layer core),
 qemu-devel@nongnu.org (open list:All patches CC here)
Cc: Li Feng <fengli@smartx.com>
Subject: [PATCH v7 0/5] Implement reconnect for vhost-user-scsi
Date: Sun,  8 Oct 2023 17:12:00 +0800
Message-ID: <20231008091220.870171-1-fengli@smartx.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::542;
 envelope-from=fengli@smartx.com; helo=mail-pg1-x542.google.com
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
 hw/scsi/vhost-user-scsi.c             | 253 +++++++++++++++++++++++---
 hw/virtio/vhost-user-gpio.c           |   5 +-
 hw/virtio/vhost-user.c                |  10 +-
 include/hw/virtio/vhost-scsi-common.h |   2 +-
 include/hw/virtio/vhost-user-scsi.h   |   4 +
 include/hw/virtio/vhost-user.h        |   3 +-
 include/hw/virtio/vhost.h             |   2 +
 10 files changed, 278 insertions(+), 60 deletions(-)

-- 
2.41.0



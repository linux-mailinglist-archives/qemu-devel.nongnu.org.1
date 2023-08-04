Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id F27BD76F994
	for <lists+qemu-devel@lfdr.de>; Fri,  4 Aug 2023 07:34:01 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qRnR5-0003rV-7d; Fri, 04 Aug 2023 01:33:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <fengli@smartx.com>) id 1qRnQl-0003bq-Px
 for qemu-devel@nongnu.org; Fri, 04 Aug 2023 01:32:56 -0400
Received: from mail-pf1-x444.google.com ([2607:f8b0:4864:20::444])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <fengli@smartx.com>) id 1qRnQi-0003R1-CE
 for qemu-devel@nongnu.org; Fri, 04 Aug 2023 01:32:55 -0400
Received: by mail-pf1-x444.google.com with SMTP id
 d2e1a72fcca58-68783b2e40bso1208577b3a.3
 for <qemu-devel@nongnu.org>; Thu, 03 Aug 2023 22:30:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=smartx-com.20221208.gappssmtp.com; s=20221208; t=1691127034; x=1691731834;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=Jblu3MFy0QuuzfePW91QPVX7n7VNb5R0HB9GnUG+UVE=;
 b=ZwIb/U2u+0MrLw5eJCq8CEOzrlvNRgLQuk8jkZtTh6KBDiJrxi/r8+LBgfXfN5jAZS
 R8KjURc2sB91csaNT6p/3qEfOJNQ9fh0tKPDAazkmphKXSnbFimBa3IvQ9SEqq6Hv48T
 KLV70VFogqKfRIGmGdGAFaFAVY4MhKnNmKFN4EV3uT4O0vDZRI9A/Kjmacs8Hjvt/jFn
 iHH3d4khJ55Wd1XgvLKgRUFCGUr0RwTd2noevav1Y/vT7WQrZ5Vq0B6WJZdOISKNHx+a
 cw24goughA1qpnoZXaLJk5YjQYfyUsyNP6Yc2YZE8RfL5oiYV/fo6VXawX9O3KxVm38R
 JkNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691127034; x=1691731834;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Jblu3MFy0QuuzfePW91QPVX7n7VNb5R0HB9GnUG+UVE=;
 b=OPkqQlN8aAG1xkdBKhwinAGe+LSSQB9NU7Iri+PS/x1LRYhp0GU4b5ftFsKr2w+0T5
 2W24b5fGJhSfuolL+MZSCbOu81c7zBY1jgqAHc7m+c+kaNo4zr5jQYRnaVmhtN/V0Qkz
 Orrgk17sznjqgtN/8xhBdfD1fxeC2naTE3bv0bEsUZVwmYUKkhisSBTDDloRFhjR9T2i
 JYfZTrqIRQ4oe82m+076O0Xg2ZFYRrZeyLGblDLKCOLaA7OZbgXiZfwl/Dg4J5UhCR6Q
 +dKI7B0bKD2C75dR1OqXGGZ63fp7TJNz2okbPUUyyDcesTEgE7pE/TNLf321CV7P2uAg
 YuXw==
X-Gm-Message-State: AOJu0YwQDVBHv4FM9OBb5BHNBkeeLbE0SbR5N3nnhbmxzPS+aYcALYGL
 b+D9DSQlgOt8w2OXdS6p+KZIWw==
X-Google-Smtp-Source: AGHT+IH6lCfpZlNrvNrOSxMNLxTjgcj9IgBSD4sgCiawjk+P39vM+eg27Ch43TxT4/4HMAf+8mkPKA==
X-Received: by 2002:a05:6a21:9984:b0:13c:a02a:97f6 with SMTP id
 ve4-20020a056a21998400b0013ca02a97f6mr663393pzb.22.1691127033552; 
 Thu, 03 Aug 2023 22:30:33 -0700 (PDT)
Received: from bogon.gitgo.cc ([47.75.78.161])
 by smtp.gmail.com with ESMTPSA id
 p7-20020a170902bd0700b001bc2831e1a8sm781183pls.80.2023.08.03.22.30.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 03 Aug 2023 22:30:33 -0700 (PDT)
From: Li Feng <fengli@smartx.com>
To: Paolo Bonzini <pbonzini@redhat.com>, Fam Zheng <fam@euphon.net>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Raphael Norwitz <raphael.norwitz@nutanix.com>,
 qemu-devel@nongnu.org (open list:All patches CC here)
Cc: Li Feng <fengli@smartx.com>
Subject: [PATCH 0/2] Fix vhost reconnect issues
Date: Fri,  4 Aug 2023 13:29:46 +0800
Message-ID: <20230804052954.2918915-1-fengli@smartx.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::444;
 envelope-from=fengli@smartx.com; helo=mail-pf1-x444.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

The patchset fixes the regression issue of vhost reconnect.
It's a serious bug that the vhost-user will lose the reconnect forever.

The 2nd patch enhances the error handle of vhost-user-scsi.

This patchset's parent commit is:
https://lore.kernel.org/all/20230731121018.2856310-1-fengli@smartx.com/

Li Feng (2):
  vhost-user: fix lost reconnect
  vhost: Add Error parameter to vhost_scsi_common_start()

 hw/scsi/vhost-scsi-common.c           | 17 ++++++++++-------
 hw/scsi/vhost-scsi.c                  |  5 +++--
 hw/scsi/vhost-user-scsi.c             | 14 ++++++++------
 hw/virtio/vhost-user.c                | 10 +---------
 include/hw/virtio/vhost-scsi-common.h |  2 +-
 5 files changed, 23 insertions(+), 25 deletions(-)

-- 
2.41.0



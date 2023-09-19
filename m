Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 89E157A6194
	for <lists+qemu-devel@lfdr.de>; Tue, 19 Sep 2023 13:44:43 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qiZ8L-0007jF-UN; Tue, 19 Sep 2023 07:43:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <fengli@smartx.com>) id 1qiZ8J-0007iv-9J
 for qemu-devel@nongnu.org; Tue, 19 Sep 2023 07:43:11 -0400
Received: from mail-pg1-x541.google.com ([2607:f8b0:4864:20::541])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <fengli@smartx.com>) id 1qiZ8F-0004ER-QL
 for qemu-devel@nongnu.org; Tue, 19 Sep 2023 07:43:10 -0400
Received: by mail-pg1-x541.google.com with SMTP id
 41be03b00d2f7-54290603887so4009660a12.1
 for <qemu-devel@nongnu.org>; Tue, 19 Sep 2023 04:41:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=smartx-com.20230601.gappssmtp.com; s=20230601; t=1695123663; x=1695728463;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=36Zy78dGifgcpU+5/7jjvuFE0XdVLz0pbvI3xaMLK7Y=;
 b=dNY2jGxX7sEKOn/dbF/u43Uqj/VLY/tjf/IVdbDDESI9U4Tsn8D8/N1Z2umByJMOUy
 YouNfzDHFygiWexkOS/cHG11pDVfXreW7G8oEdWwD/L2otRBJFgmsMePzSenUcIMarvF
 ALSBYyict30o/nj/eK8HIxpG/9gcm46D11GBq6DV9QW/N40XK94bONUW/VK1a77S9gL7
 /h2/SpQ/FGjbAPgkruQl42p7niKJ3o9LVAKWrIcbk6Ui5eaM2vkMRnpP1ZU+CwRPsFyt
 03yrN+RNM7REpd+MtAYIdwamoIWfV3Ok76Y0CCH+SiU1jasy/VpFOFZHFLmO+KYXTF0o
 6eNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695123663; x=1695728463;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=36Zy78dGifgcpU+5/7jjvuFE0XdVLz0pbvI3xaMLK7Y=;
 b=CsUCbA4TG2eT1gLeJsM0+1Uwhx26jI1/h6Z0FJYHuwcaXHQERlD6sAXjm+gDzcDUw9
 VBYzW4O4R/b7KZt8N1puH3aC4Dy4k5KCgwGUnY0uX8m6dqMITEw13wqnu8z4i1QfaaIU
 MLn6+0sI7FhOjISq6IHr8pkNBe0hQAWQrm+o2vOE8j5zcrai7+ErIXwU9pWlfmVg70SW
 yMblZ6SsvqxpIQi4D64UvjYG4C0RuJKfnqvb1pIdxlI7V8hNGDIGQ2ASCvJqostiCFh6
 U88bPHbmSWwlXChXfzJjCGsZYXHDJ3BQSLzUrcLDgS2+ov+HpChhIXYCIEstmAF27J98
 9KjA==
X-Gm-Message-State: AOJu0Yx25bQlAFAx1WOBiuUNwCG2V1uExkyxEZwzgr6+7dj+Cq7LDXsY
 XQAt6d8Dat4Ml9WBTBYJQMFe/w==
X-Google-Smtp-Source: AGHT+IHhKokP8TD3ScGoRPw8qmKe6tSOvdT2+p1yzIvMGDnIqAm6Xz4jeHHAeXRT4vSwGPeEZKn6SQ==
X-Received: by 2002:a05:6a20:320d:b0:14b:8023:33c8 with SMTP id
 hl13-20020a056a20320d00b0014b802333c8mr9624092pzc.2.1695123662603; 
 Tue, 19 Sep 2023 04:41:02 -0700 (PDT)
Received: from 64217.gitgo.cc ([8.210.91.195])
 by smtp.gmail.com with ESMTPSA id
 z24-20020aa791d8000000b006887be16675sm8487030pfa.205.2023.09.19.04.40.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 19 Sep 2023 04:41:02 -0700 (PDT)
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
Subject: [PATCH v5 0/5] Implement reconnect for vhost-user-scsi
Date: Tue, 19 Sep 2023 19:40:21 +0800
Message-ID: <20230919114030.280414-1-fengli@smartx.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230721105205.1714449-1-fengli@smartx.com>
References: <20230721105205.1714449-1-fengli@smartx.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::541;
 envelope-from=fengli@smartx.com; helo=mail-pg1-x541.google.com
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

Ping ...
Could anyone review this series and merge them?

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
 hw/scsi/vhost-scsi.c                  |   5 +-
 hw/scsi/vhost-user-scsi.c             | 253 +++++++++++++++++++++++---
 hw/virtio/vhost-user-gpio.c           |   5 +-
 hw/virtio/vhost-user.c                |   9 +-
 include/hw/virtio/vhost-scsi-common.h |   2 +-
 include/hw/virtio/vhost-user-scsi.h   |   4 +
 include/hw/virtio/vhost-user.h        |   3 +-
 include/hw/virtio/vhost.h             |   2 +
 10 files changed, 276 insertions(+), 60 deletions(-)

-- 
2.41.0



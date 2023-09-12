Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F74A79CABF
	for <lists+qemu-devel@lfdr.de>; Tue, 12 Sep 2023 10:57:09 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qfzBf-000826-JD; Tue, 12 Sep 2023 04:55:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <fengli@smartx.com>) id 1qfzBa-0007qH-3q
 for qemu-devel@nongnu.org; Tue, 12 Sep 2023 04:55:54 -0400
Received: from mail-oi1-x242.google.com ([2607:f8b0:4864:20::242])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <fengli@smartx.com>) id 1qfzBW-0002A3-21
 for qemu-devel@nongnu.org; Tue, 12 Sep 2023 04:55:53 -0400
Received: by mail-oi1-x242.google.com with SMTP id
 5614622812f47-3aa14d8641cso4041257b6e.3
 for <qemu-devel@nongnu.org>; Tue, 12 Sep 2023 01:53:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=smartx-com.20230601.gappssmtp.com; s=20230601; t=1694508824; x=1695113624;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=C2k9gMiLzZVeo4D8Gjkxz76JJAzi1GSAMKAtsI6QDH4=;
 b=duj704Wv0HvWX70o3bBcb0/ZqTQ2hOsD0+1TYnSUK9/BViR/APj4MOV1RQ0len8wZ3
 ld584kSvUPr3SiD8DmqqjaUolz7lBH5OHfIck+m34o0aAhexP9O1ccM3x7PfIzBZoxX6
 VEYloksvXv1qRSQ/5wKpHUxeoy7G/95E4xuavZImI96YifMnaVZerb0pMObDQlrqcDpF
 CA3u8lUQZh2FrexjnAz8fXJd/1uuKR7cG3V30znDBsk/0Ji7WMeFN+YWhWMMKZEr24w/
 xlKmK4DGoiVE/Dhj1H4I6rNPQqMe51VeCOWq+fQBF5qAE0QaFI7FjAw39I0siCG6fUi6
 0eig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694508824; x=1695113624;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=C2k9gMiLzZVeo4D8Gjkxz76JJAzi1GSAMKAtsI6QDH4=;
 b=Y24GPt7FGZq99LD8623+Tj1fwKuF6ldFYrDOPHHQqazKb3Zps/+dzHeRsEx3itUUMe
 6KECWpes5XMHVnUc7bM+JDISLEB9bDCINWR8hQyy2k2v+OGMLWXTbT4MyTcOVQwZcA7g
 eb2LhkOmTl8TXs6DNkTSB6PJ/sPzKUPq8M23NokjeVL2rIA7Hl9jZI5U0GbOYqdgP8xu
 fvOrzILq+PrzCaMot+M39viDWLBE3lOP7y0SIw2fR/DYmjdcUXux25ltLJGtkcvsA93D
 2nu+3CcyM8ubdF/yovmZ6dRSL/DLXbuof1Y0qq3IOlu44Rw21GMjrmRzSB8Yk/p6fZia
 pRqQ==
X-Gm-Message-State: AOJu0YxaVPBeXGTz/cR+x2stsFceJbNH86wFwvuPxoC45H3vZ8LAJRBk
 W3GMCCswGfkhP8hB7aXKcHCqKw==
X-Google-Smtp-Source: AGHT+IGmbxqzhP90/87wIzFdfCOfymkyLkSEPuYq9st8biCtIl7qjkXe6YOu1+4oqjfHuVQF3cCP4g==
X-Received: by 2002:a05:6808:3093:b0:3a7:8f94:743a with SMTP id
 bl19-20020a056808309300b003a78f94743amr16599850oib.10.1694508824417; 
 Tue, 12 Sep 2023 01:53:44 -0700 (PDT)
Received: from 64217.gitgo.cc ([8.210.91.195])
 by smtp.gmail.com with ESMTPSA id
 m6-20020a637d46000000b00570668ccd5bsm6523754pgn.14.2023.09.12.01.53.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 12 Sep 2023 01:53:43 -0700 (PDT)
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
Subject: [PATCH v4 0/5] Implement reconnect for vhost-user-scsi
Date: Tue, 12 Sep 2023 16:52:42 +0800
Message-ID: <20230912085315.2524857-1-fengli@smartx.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230721105205.1714449-1-fengli@smartx.com>
References: <20230721105205.1714449-1-fengli@smartx.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::242;
 envelope-from=fengli@smartx.com; helo=mail-oi1-x242.google.com
X-Spam_score_int: 14
X-Spam_score: 1.4
X-Spam_bar: +
X-Spam_report: (1.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=no autolearn_force=no
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

This patchset adds reconnect support for vhost-user-scsi. 
At the same time, improve the error messages and silent errors are now reported.
And fix a lost reconnect issue for all vhost-user backend.

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



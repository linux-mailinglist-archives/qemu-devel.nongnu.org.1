Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A88AC7868DC
	for <lists+qemu-devel@lfdr.de>; Thu, 24 Aug 2023 09:45:16 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qZ50P-0001Zf-KT; Thu, 24 Aug 2023 03:43:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <fengli@smartx.com>) id 1qZ50L-0001Z1-Bi
 for qemu-devel@nongnu.org; Thu, 24 Aug 2023 03:43:45 -0400
Received: from mail-pf1-x444.google.com ([2607:f8b0:4864:20::444])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <fengli@smartx.com>) id 1qZ50H-000481-Dm
 for qemu-devel@nongnu.org; Thu, 24 Aug 2023 03:43:45 -0400
Received: by mail-pf1-x444.google.com with SMTP id
 d2e1a72fcca58-68a41035828so3276838b3a.1
 for <qemu-devel@nongnu.org>; Thu, 24 Aug 2023 00:41:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=smartx-com.20221208.gappssmtp.com; s=20221208; t=1692862897; x=1693467697;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8EKQa3FEGlL5tuwPwaTahdW7yb53EQgSU4NFY042VP8=;
 b=c7t+Mu915O+1kP4WsEF9PBi4+EZPynDLaKy9TCWA1CrAbFJQFScq1uzTo+szc0F4NZ
 mhK3eRktE75xNih/pOm5ME0GO1hMFX70gLp7Hdgoegu2/eJ2g0Rzq606J8WM4xAFaa8H
 Ifluu8Jef0TgYbR8eWHD8fl4S//n/om4oE/SHSxiAL8JuyAut8dUrmfbmYY/Dj5L9EVh
 sqAndDGUlgOPRJFRPgHmBqLPr9fC1lvmay6Zm0c2+s5bbGX9r1LjTnbaFJ20fRSaGUwJ
 1kYxwiBS78c2o6a1IDUekH0heHcqUdhEzW1PKWLAlS1C3FvHVvsdmmMwOq9AunSLOCEM
 X3LA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692862897; x=1693467697;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=8EKQa3FEGlL5tuwPwaTahdW7yb53EQgSU4NFY042VP8=;
 b=Dqknkb1voKA5DS08IhOOEzJcrF3XCmmXTApFgvvS52vQOhNAJftSy4JZl4+iXkjPpn
 Ofyec2/7ZERS+N8EgS9gW6nyTK5IQAZWg4Wa63dXoKzliB2YHmrwzZq+cEqYxVYfFULF
 +E29GQboZmRngfm4A8IOEWxCAbR9Npe2jEYHAnM7i5X8E5GFWD514t4XZNVmHQPIiejT
 T6qT7KtEfAvb1T5fEdQfuyVP1vL1kUfttNGa0Z8MH3MAQeGhK7KcJM4rO+c/AZMTGCIY
 9siyq3pqtTD5Iso/58Yxqx5Gx4HjiMeztKt4f8eCL3N18tT8Fr+eSbtLPjJwsoCrE2xt
 uK+g==
X-Gm-Message-State: AOJu0YxIetXOjQJ4VcIUF957oovja9BRji4p3IbJlcoqVHwSVl28NaNk
 WpEL3OsbmVQgj30c7NWm5qd6BQ==
X-Google-Smtp-Source: AGHT+IF/ml+pFUB7sr+Cpo3wi8l3niCuesMK2RP1n6+oM9ecFTAHlYQkMbxa8YPp1DfM82ynZQ+H5g==
X-Received: by 2002:a05:6a20:429f:b0:137:2d73:707f with SMTP id
 o31-20020a056a20429f00b001372d73707fmr14946021pzj.5.1692862896498; 
 Thu, 24 Aug 2023 00:41:36 -0700 (PDT)
Received: from 64217.gitgo.cc ([8.210.91.195])
 by smtp.gmail.com with ESMTPSA id
 jk8-20020a170903330800b001b672af624esm12070112plb.164.2023.08.24.00.41.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 24 Aug 2023 00:41:36 -0700 (PDT)
From: Li Feng <fengli@smartx.com>
To: Raphael Norwitz <raphael.norwitz@nutanix.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Fam Zheng <fam@euphon.net>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Viresh Kumar <viresh.kumar@linaro.org>,
 qemu-block@nongnu.org (open list:Block layer core),
 qemu-devel@nongnu.org (open list:All patches CC here)
Cc: Li Feng <fengli@smartx.com>
Subject: [PATCH v2 0/2] Fix vhost reconnect issues
Date: Thu, 24 Aug 2023 15:41:00 +0800
Message-ID: <20230824074115.93897-1-fengli@smartx.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230804052954.2918915-1-fengli@smartx.com>
References: <20230804052954.2918915-1-fengli@smartx.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::444;
 envelope-from=fengli@smartx.com; helo=mail-pf1-x444.google.com
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

The patchset fixes the regression issue of vhost reconnect.
It's a serious bug that the vhost-user will lose the reconnect forever.

The 2nd patch enhances the error handle of vhost-user-scsi.

This patchset's parent commit is:
https://lore.kernel.org/all/20230731121018.2856310-1-fengli@smartx.com/

Changes for v2:
- Add a event_cb in VhostAsyncCallback to be called when dev is NULL;
- Fix the error report message.

Li Feng (2):
  vhost-user: Fix lost reconnect
  vhost: Add Error parameter to vhost_scsi_common_start()

 hw/block/vhost-user-blk.c             |  2 +-
 hw/scsi/vhost-scsi-common.c           | 16 +++++++++-------
 hw/scsi/vhost-scsi.c                  |  5 +++--
 hw/scsi/vhost-user-scsi.c             | 17 ++++++++++-------
 hw/virtio/vhost-user-gpio.c           |  2 +-
 hw/virtio/vhost-user.c                | 10 ++++++++--
 include/hw/virtio/vhost-scsi-common.h |  2 +-
 include/hw/virtio/vhost-user.h        |  4 +++-
 8 files changed, 36 insertions(+), 22 deletions(-)

-- 
2.41.0



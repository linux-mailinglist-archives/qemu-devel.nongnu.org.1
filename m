Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A9E7D78D2E4
	for <lists+qemu-devel@lfdr.de>; Wed, 30 Aug 2023 07:00:49 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qbDJ8-0007ud-8A; Wed, 30 Aug 2023 00:59:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <fengli@smartx.com>) id 1qbDIs-0007uF-0n
 for qemu-devel@nongnu.org; Wed, 30 Aug 2023 00:59:42 -0400
Received: from mail-pf1-x444.google.com ([2607:f8b0:4864:20::444])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <fengli@smartx.com>) id 1qbDIl-000419-KO
 for qemu-devel@nongnu.org; Wed, 30 Aug 2023 00:59:41 -0400
Received: by mail-pf1-x444.google.com with SMTP id
 d2e1a72fcca58-68c3b9f83f4so2951690b3a.2
 for <qemu-devel@nongnu.org>; Tue, 29 Aug 2023 21:57:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=smartx-com.20221208.gappssmtp.com; s=20221208; t=1693371452; x=1693976252;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=v0wBKZKqVR4ZGdKIUK18ZV57zImI1DukIahu/mgOI8w=;
 b=4e9IaFXjDtgy7XaxiP02vwAgM/VHRg0r/ALI9fOcJvmAgrdgq2EUlyw5IRVGS5F7e1
 FEvTzmfZe0VlGjvrOHDkIVOdg8o29uHUaPBQbjbYCnVEa9pAw5KLgfW+hRuPPp/odWLE
 fZNKGjrMMu4t1aSZETJOKoq35GE2YtYC+iGP+ZXXASvlvtsnucNafqLLL51aLSrVO4M5
 kcOpQp0D9/KuzwbvR7b4jr1XV3cwWgMutsfw/A3Y7ghjLJAGKaogfHJyducuIAbxBlm5
 48A7Mm3Yudw6GQfRjudCh2iX4pVUkKGE0mQk8mgsL9e29/++8udZf8Z4BGhvs/PF4DHx
 1avw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693371452; x=1693976252;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=v0wBKZKqVR4ZGdKIUK18ZV57zImI1DukIahu/mgOI8w=;
 b=Ces6wFr7Zw8NG9KyvjgpNzbEIDmwCXSciurqmhe+D9AK+cAQKCa4RZlTvORUQYtjoj
 fEd8GCadTUVTFlzjFlXwn6hcB1V4sITtw8vIaTrpfbkBQkFf/8sB2kXbZkE0459p1GXy
 gsqE4NubIefgXtqTKbREcrfgQf2Ih8/Ze3e95uNmLBbM2j9v6upYThIg7gZ/73qMhrxC
 f2Mz+eD0x+8jBvUZTsevJZUg26VoUmc67LIkoAuTJymNN7BJkq/l1KwI7ELH1bapZXV7
 z0cKltS7Qi/m6lLINldHwsaKquNG3hN3N9xBCDw1+axcP2UDCqrtirTqI4UCOEz8zOpw
 1RCg==
X-Gm-Message-State: AOJu0YxLIloMqcXHZFwD7s/Qh/O59yw6iDk6CudevwwCQTYtHdht7G63
 CTrUhnSjf7lSFKnmU9t0/f1r4A==
X-Google-Smtp-Source: AGHT+IEXMz+lyTWZKjSe8xvPbHY7kuPPPkdn0Cy7SLr/xV8kwAmFLJOC6ufk3FtF/OzUyzW098/xUQ==
X-Received: by 2002:a05:6a20:26a5:b0:125:517c:4f18 with SMTP id
 h37-20020a056a2026a500b00125517c4f18mr1026539pze.8.1693371451759; 
 Tue, 29 Aug 2023 21:57:31 -0700 (PDT)
Received: from 64217.gitgo.cc ([8.210.91.195])
 by smtp.gmail.com with ESMTPSA id
 t11-20020a170902a5cb00b001bfd92ec592sm10183553plq.292.2023.08.29.21.57.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Aug 2023 21:57:31 -0700 (PDT)
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
Subject: [PATCH v3 0/2] Fix vhost reconnect issues
Date: Wed, 30 Aug 2023 12:57:12 +0800
Message-ID: <20230830045722.611224-1-fengli@smartx.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230804052954.2918915-1-fengli@smartx.com>
References: <20230804052954.2918915-1-fengli@smartx.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::444;
 envelope-from=fengli@smartx.com; helo=mail-pf1-x444.google.com
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

The patchset fixes the regression issue of vhost reconnect.
It's a serious bug that the vhost-user will lose the reconnect forever.

The 2nd patch enhances the error handle of vhost-user-scsi.

This patchset's parent commit is:
https://lore.kernel.org/all/20230731121018.2856310-1-fengli@smartx.com/

Changes for v3:
- Fix the code style.

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
 hw/virtio/vhost-user.c                |  9 +++++++--
 include/hw/virtio/vhost-scsi-common.h |  2 +-
 include/hw/virtio/vhost-user.h        |  3 ++-
 8 files changed, 34 insertions(+), 22 deletions(-)

-- 
2.41.0



Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A901576112A
	for <lists+qemu-devel@lfdr.de>; Tue, 25 Jul 2023 12:47:09 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qOFXj-0008AK-PZ; Tue, 25 Jul 2023 06:45:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <fengli@smartx.com>) id 1qOFXg-00086W-DV
 for qemu-devel@nongnu.org; Tue, 25 Jul 2023 06:45:24 -0400
Received: from mail-pf1-x42f.google.com ([2607:f8b0:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <fengli@smartx.com>) id 1qOFXb-00034s-Nk
 for qemu-devel@nongnu.org; Tue, 25 Jul 2023 06:45:24 -0400
Received: by mail-pf1-x42f.google.com with SMTP id
 d2e1a72fcca58-666ecb21f86so5011039b3a.3
 for <qemu-devel@nongnu.org>; Tue, 25 Jul 2023 03:43:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=smartx-com.20221208.gappssmtp.com; s=20221208; t=1690281796; x=1690886596;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ei5ruXkzjZDzgePcUGTV3KhKwEzDxYkZ+fYkG0wbwJs=;
 b=XGOqP7fT64ngXSxAQFkLWFi+jaKA/JZvB8X7Jtv5K2eqrEGv0YVyQgsIcEr3f+qooC
 AnSHdAO2sLAtfgOSO0p43ifNqcTHZ03adLAHHNwgniEnKH6+DWEdPlw6h+PKhd6mAuDV
 BqSlYPfPP/k+xlWy+5ANWfb6VuyZLjdyBj/crieVJ+FA3VtxZ5YtWncrep7ndxjRgmBy
 MUq+A+0KWp4qy7WhmoOYVYZ52AaUxl8v/9Z0bbhNjbPoYoB2YU43No7pSOp4/O7FWZny
 ZJ1P4kGzmpdDAWnVQur2Cc0SjG9KkSG2Qn3IVJ3Fa/Qm+6rX7nGBJxElHuh2F/2v8Y4C
 JotQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1690281796; x=1690886596;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ei5ruXkzjZDzgePcUGTV3KhKwEzDxYkZ+fYkG0wbwJs=;
 b=I2sPQ+kKkSVk15vAiglTcOqbtCUV1UGWqPQm5yLEQr1oUzfKE1BJuptZ1mVEgshNSv
 f/hekofMWPUW4IQBZRG/H0oy/EHY0eMqa7oUf/UtEK9A+Qi0lP2Lc5gu3Am/5WVFi+V0
 GaM04bYCAiPxCTbYpQNKcJrdZCcMhoXHnCq6Jhvo9JFqe7SJgiZ1OqP/iUDw6pt3M08v
 7AhODXAZJiH3+JXD5Fd/GYDftqgnyP6vc3LjJGJh1l7A9rG2xePg/npASFO2LQmkQzyB
 H8RsLqQo6eGtqFg/vgPEAun3oGzYjVd34GaI6IbZI9MPA6duv96+bpOzbKecwwVFYx0S
 +1NQ==
X-Gm-Message-State: ABy/qLZSZmMkHB1I9b8H4ohMnm22rv1wRBZjejUF5UHCP60PJOv2ZfKu
 UBR8QNXjntOXwx6/Tv4f8QHllA==
X-Google-Smtp-Source: APBJJlHNWqufOedugi8FaZepC1w7Fc52CFyGPJavVljvF+qsdM1hBy1dwJsw+PIOonFzinKhgqm5lg==
X-Received: by 2002:a05:6a00:16c4:b0:682:4c1c:a0fc with SMTP id
 l4-20020a056a0016c400b006824c1ca0fcmr15950968pfc.19.1690281795797; 
 Tue, 25 Jul 2023 03:43:15 -0700 (PDT)
Received: from localhost.localdomain.gitgo.cc ([47.75.78.161])
 by smtp.gmail.com with ESMTPSA id
 c20-20020aa78c14000000b0062cf75a9e6bsm9343165pfd.131.2023.07.25.03.43.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 25 Jul 2023 03:43:15 -0700 (PDT)
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
Subject: [PATCH v2 0/4] Implement reconnect for vhost-user-scsi
Date: Tue, 25 Jul 2023 18:42:43 +0800
Message-ID: <20230725104256.4861-1-fengli@smartx.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230721105205.1714449-1-fengli@smartx.com>
References: <20230721105205.1714449-1-fengli@smartx.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::42f;
 envelope-from=fengli@smartx.com; helo=mail-pf1-x42f.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

Hi,

This patchset adds reconnect support for vhost-user-scsi. At the same
times, fix vhost fd leak and refactor some code.

Changes for v2:
- Split the v1 patch to small separate patchset;
- New patch for fixing fd leak, which has sent to reviewers in another
  mail;
- Implement the `vhost_user_scsi_handle_output`;
- Add the started_vu safe check;
- Fix error handler;
- Check the inflight before set/get inflight fd.

Li Feng (4):
  vhost: fix the fd leak
  vhost-user-common: send get_inflight_fd once
  vhost: move and rename the conn retry times
  vhost-user-scsi: support reconnect to backend

 hw/block/vhost-user-blk.c             |   4 +-
 hw/scsi/vhost-scsi-common.c           |  43 ++---
 hw/scsi/vhost-user-scsi.c             | 220 +++++++++++++++++++++++---
 hw/virtio/vhost-user-gpio.c           |   3 +-
 hw/virtio/vhost.c                     |   2 +
 include/hw/virtio/vhost-scsi-common.h |   3 +
 include/hw/virtio/vhost-user-scsi.h   |   3 +
 include/hw/virtio/vhost.h             |   2 +
 8 files changed, 235 insertions(+), 45 deletions(-)

-- 
2.41.0



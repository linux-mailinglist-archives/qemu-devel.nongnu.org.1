Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EDAB7AB12E
	for <lists+qemu-devel@lfdr.de>; Fri, 22 Sep 2023 13:49:46 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qjeeo-00084g-Q1; Fri, 22 Sep 2023 07:49:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <fengli@smartx.com>) id 1qjeel-00083i-S0
 for qemu-devel@nongnu.org; Fri, 22 Sep 2023 07:49:12 -0400
Received: from mail-pj1-x1042.google.com ([2607:f8b0:4864:20::1042])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <fengli@smartx.com>) id 1qjeeh-0000cW-Qr
 for qemu-devel@nongnu.org; Fri, 22 Sep 2023 07:49:10 -0400
Received: by mail-pj1-x1042.google.com with SMTP id
 98e67ed59e1d1-276c68e6279so1332670a91.2
 for <qemu-devel@nongnu.org>; Fri, 22 Sep 2023 04:47:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=smartx-com.20230601.gappssmtp.com; s=20230601; t=1695383223; x=1695988023;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=JeVUKWHnoSNLiNfGNoUhmGLrJbUwKabWLt+p+Vj7x4I=;
 b=txl5Mami8VgR+OBTqIhVNRQLkBQkYYg0T5hd4pa4OXF+YosvtcmgqLDBkgFGXXdC/n
 uLcgmAd3aTva8KSisjnpJYvhZ0rUBDBWh1lPQV+PJ6ct4jF4dY42Ysf/P9a2taRTE2qR
 i4xgbhTAu3RwlapVRNgGwILSBbkz/0N1+FUq/pSOdxHzyzNSk8phOrMxm1mByHR/Cvhc
 u/ZHgGlydH9fpSfPmiCqxePzWxBgsTQkvKodvky+37U2LWYLf8g+FuJ2UsuFNZUuRr2t
 An1UmmVxa0QLeOacDEQy10yUSq8lsvV64/972njhwDpa0vgvfGbbg39pyqF/Qbo8pGy4
 KAdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695383223; x=1695988023;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=JeVUKWHnoSNLiNfGNoUhmGLrJbUwKabWLt+p+Vj7x4I=;
 b=VW43P4rkrwVuIpESI6QN5X+bBVlKCyZWxGCY/LU7OQIoIKFb6oDjOzjhV7JeNTwvNY
 7r3jnBMJTgexpjBRLVI6ZH/IAVs86uMyJCXIbB7nA6BjH+OkCuNM0buDW/FdJuzz0Yzb
 XjlbT8josx4WEYzWQ3LfN+0UZGCBp76VKpboXWJiGKDCxy6OR8IpQqDuZMPLgpkBHgjZ
 p4gRL8ISCPtjRlVl7mHe5miMjl5fbY6cxEbYF0lAX/znfoXz2Ip4ZOZwFNn/9SvpRYUX
 APi5sOjKTrIYRPI/LCMIoza6NuptAmkNLDbwSMgV+ux4KNu0fNrrP5bA4UrGTrszgEPQ
 Ee3Q==
X-Gm-Message-State: AOJu0YxEJVeJOEvk4KlVxTtjE2c7ZyZgw+3GMSgtYePoGJHKbWtXr5hK
 ll0QAjNO23SSCKFWcez5mZE94Q==
X-Google-Smtp-Source: AGHT+IF6+jawGl7DaGFawoRo+bz2fdYBC8C80XiHktaBFxyO+sFjORWi1kODXZLBcLcbEWCwmzFYrA==
X-Received: by 2002:a17:90b:1d84:b0:274:6135:8363 with SMTP id
 pf4-20020a17090b1d8400b0027461358363mr7638495pjb.33.1695383221862; 
 Fri, 22 Sep 2023 04:47:01 -0700 (PDT)
Received: from 64217.gitgo.cc ([8.210.91.195])
 by smtp.gmail.com with ESMTPSA id
 r6-20020a17090a438600b00263f41a655esm3303961pjg.43.2023.09.22.04.46.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 22 Sep 2023 04:47:01 -0700 (PDT)
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
Subject: [PATCH v6 0/5] Implement reconnect for vhost-user-scsi
Date: Fri, 22 Sep 2023 19:46:10 +0800
Message-ID: <20230922114625.5786-1-fengli@smartx.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230721105205.1714449-1-fengli@smartx.com>
References: <20230721105205.1714449-1-fengli@smartx.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::1042;
 envelope-from=fengli@smartx.com; helo=mail-pj1-x1042.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=unavailable autolearn_force=no
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
 hw/scsi/vhost-scsi.c                  |   5 +-
 hw/scsi/vhost-user-scsi.c             | 253 +++++++++++++++++++++++---
 hw/virtio/vhost-user-gpio.c           |   5 +-
 hw/virtio/vhost-user.c                |  10 +-
 include/hw/virtio/vhost-scsi-common.h |   2 +-
 include/hw/virtio/vhost-user-scsi.h   |   4 +
 include/hw/virtio/vhost-user.h        |   3 +-
 include/hw/virtio/vhost.h             |   2 +
 10 files changed, 277 insertions(+), 60 deletions(-)

-- 
2.41.0



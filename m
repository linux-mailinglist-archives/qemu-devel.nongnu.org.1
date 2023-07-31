Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BC267695D1
	for <lists+qemu-devel@lfdr.de>; Mon, 31 Jul 2023 14:14:45 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qQRlj-00039E-6o; Mon, 31 Jul 2023 08:12:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <fengli@smartx.com>) id 1qQRlg-00038i-DP
 for qemu-devel@nongnu.org; Mon, 31 Jul 2023 08:12:56 -0400
Received: from mail-pf1-x432.google.com ([2607:f8b0:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <fengli@smartx.com>) id 1qQRld-00052Q-Rp
 for qemu-devel@nongnu.org; Mon, 31 Jul 2023 08:12:56 -0400
Received: by mail-pf1-x432.google.com with SMTP id
 d2e1a72fcca58-686f25d045cso2852762b3a.0
 for <qemu-devel@nongnu.org>; Mon, 31 Jul 2023 05:10:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=smartx-com.20221208.gappssmtp.com; s=20221208; t=1690805448; x=1691410248;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qyUgZh9TwicnD21beZzQv3fygUBvQcNjmz/7LwSmFBY=;
 b=NhroPMxnN9FT8sUzN5GcJa10I5XKkSB4d4jf4VfFN2ml+CxHF+wiWZG2QWs+9PBX5S
 Unxh9Rh5/GTcFjZxpsj6ZKe6LJQqSM676oWNcjcZuV47NEJlyerNM+nGgTuziR1vxmUs
 j18nKZgcUeeMvLANnPdhM3BdvEUTMHSzFfhS12WyCIcOIoe/n851PKwZa/Qr7gUbXKC1
 +oSVD9I+it3ymVDE9GZFjUx+g1uQ/ZJXjGhsh/LlIxkBa2KZSM0QkJB/cuulGmwojj0j
 dWP8f4diJsYimxSmLJa/H7+ScDZKNGWAQvCKaD+icdpo2DB9oxho7yZKDzF+H01/ii4P
 yXiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1690805448; x=1691410248;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=qyUgZh9TwicnD21beZzQv3fygUBvQcNjmz/7LwSmFBY=;
 b=CT6t8Kqvx3rrHcuf3QGEHmdS3VVu51EjvY6uQjEpETnY8H7Mi6CleZEvzp7kW8FwPz
 xXLm/VnxRFUNMbTysqiOHO5tRttOOoQ2IBUsp9yJ6du9s1AXCembmdmYC4X0SU0XxnqD
 jLzyLv/jLCQ7OKdGRZzaqSlSXUW1F2CFMwO5bgz3T+d072zA7c+cxFV9DbZLPhmpRxP8
 EzKoTgjYwgwvL9DCtYzGCauLeeGRwE7o3ANPgP8Y13iaM4Zj0zPjSSzmYDctNKplo+E9
 elm9GuGHaxhryK+iSlmog0llZWVwR1RdXEmo145svgzZbHrYsq9y4NutxvzmrlVmliFn
 EWCg==
X-Gm-Message-State: ABy/qLYnwP6mS4ajAzS82PYqyr/JU9WVBURYlpmec7Gc6EHmLrjQLhq2
 DGxZXHYBdaV5AWtpljjVF2qDWg==
X-Google-Smtp-Source: APBJJlEj9YxpB8KuqNIwBFARddYFEXzyaU1fYN+n+8tQjQDpvpXmQFeYUj6UEJm0g0beELjmXIWp2w==
X-Received: by 2002:a05:6a20:9195:b0:132:a85f:b2e7 with SMTP id
 v21-20020a056a20919500b00132a85fb2e7mr9801548pzd.53.1690805448272; 
 Mon, 31 Jul 2023 05:10:48 -0700 (PDT)
Received: from localhost.localdomain.gitgo.cc ([47.75.78.161])
 by smtp.gmail.com with ESMTPSA id
 a10-20020a62bd0a000000b005d22639b577sm7385690pff.165.2023.07.31.05.10.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 31 Jul 2023 05:10:47 -0700 (PDT)
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
Subject: [PATCH v3 0/5] Implement reconnect for vhost-user-scsi
Date: Mon, 31 Jul 2023 20:10:05 +0800
Message-ID: <20230731121018.2856310-1-fengli@smartx.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230721105205.1714449-1-fengli@smartx.com>
References: <20230721105205.1714449-1-fengli@smartx.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::432;
 envelope-from=fengli@smartx.com; helo=mail-pf1-x432.google.com
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

This patchset adds reconnect support for vhost-user-scsi. At the same
times, fix vhost fd leak and refactor some code.

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
  vhost: fix the fd leak
  vhost-user-common: send get_inflight_fd once
  vhost: move and rename the conn retry times
  vhost-user-scsi: support reconnect to backend
  vhost-user-scsi: start vhost when guest kicks

 hw/block/vhost-user-blk.c           |   4 +-
 hw/scsi/vhost-scsi-common.c         |  37 ++---
 hw/scsi/vhost-user-scsi.c           | 247 +++++++++++++++++++++++++---
 hw/virtio/vhost-user-gpio.c         |   3 +-
 hw/virtio/vhost.c                   |   2 +
 include/hw/virtio/vhost-user-scsi.h |   4 +
 include/hw/virtio/vhost.h           |   2 +
 7 files changed, 252 insertions(+), 47 deletions(-)

-- 
2.41.0



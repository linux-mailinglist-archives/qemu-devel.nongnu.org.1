Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BEB2761126
	for <lists+qemu-devel@lfdr.de>; Tue, 25 Jul 2023 12:46:42 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qOFXk-0008Bg-9i; Tue, 25 Jul 2023 06:45:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <fengli@smartx.com>) id 1qOFXg-00087S-Ew
 for qemu-devel@nongnu.org; Tue, 25 Jul 2023 06:45:24 -0400
Received: from mail-pf1-x432.google.com ([2607:f8b0:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <fengli@smartx.com>) id 1qOFXd-00035C-4Z
 for qemu-devel@nongnu.org; Tue, 25 Jul 2023 06:45:24 -0400
Received: by mail-pf1-x432.google.com with SMTP id
 d2e1a72fcca58-686b643df5dso53399b3a.1
 for <qemu-devel@nongnu.org>; Tue, 25 Jul 2023 03:43:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=smartx-com.20221208.gappssmtp.com; s=20221208; t=1690281800; x=1690886600;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qlztDq/CKb91JnaGmc1JrV/AEfrFJEe1DDcUZ8Ogc1M=;
 b=4SUZaYatOJt3CpRee7EdKVQiuJic1nfITdBVb2XmYuFgiz0+di+Mg0xcSg8WjJoFGy
 g1JUGVwi3jPCJDWV3YOjW87vCVqqpVgqI2lJJ2a868/Zu/sOrNZDldcJH9qrnPzomL70
 mtMw78KxWRq1igsVdsXjjnvO/FDg6YUnPfsnCxSf4wuVceDWXZkp661ziVGaGA0dERoK
 irYRfvt0Vm12tmTBAjiruO3goul2F3qwWKO+Hc8Dg1GbrHbFU9uFPH8gGWxFMS8SMoQu
 p5wx0wBuRi4AEn3EGhOFlRWdnLHDutCo+8mULyYBy/TxD0shZpTl2LY3wcvYMUQvvVNy
 Ps7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1690281800; x=1690886600;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=qlztDq/CKb91JnaGmc1JrV/AEfrFJEe1DDcUZ8Ogc1M=;
 b=iA+UJRW1F7CY4yd6hLRy8Qyco/T80gizONoi6pqZ/7QoECo4OPaxM/qqDTi2TyTez8
 EYaBfGJSiZqpWitS8EUU5y/pSt5b7r69w4h5qIVzAPJTjSPLsdm5fG2s45MyEpd8AMXL
 uFbR9pNkANMA2me2QkRHoimGpZlnjldGidAUG4Mx48ZzVOlyAKoh+R6ZaSYMXK02LgMi
 ZEVR96oYiU9wN4MgUrBIP5J8t9NyIYr3BgkRuxeEOvG6rV5T73tiXhyocPPbIbj+pB9S
 C7mN+f1781o1AmaSN0JrRy7USNgxwYfC0T7pXTi+sCwm6jNRKoPoESErJrkx1Wh4qqUO
 QtvQ==
X-Gm-Message-State: ABy/qLZQYAlLYSorRhfAJb77Q0uT+tQJqLT1qdpjX35aPpg/2Aasjyg8
 UZP8Al9bZtqf2w+QA62IgKC/4t/grbtqz2KuCqHLdaAqTi4=
X-Google-Smtp-Source: APBJJlGS+e19bhiDhSICt2X4ntmLuPrtSZcCk8Tc+HPY+hGXJqYL53dGkyhorwmnL8lek4YqdxyzRg==
X-Received: by 2002:a05:6a21:66c4:b0:13b:79dc:4538 with SMTP id
 ze4-20020a056a2166c400b0013b79dc4538mr10284pzb.62.1690281799665; 
 Tue, 25 Jul 2023 03:43:19 -0700 (PDT)
Received: from localhost.localdomain.gitgo.cc ([47.75.78.161])
 by smtp.gmail.com with ESMTPSA id
 c20-20020aa78c14000000b0062cf75a9e6bsm9343165pfd.131.2023.07.25.03.43.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 25 Jul 2023 03:43:19 -0700 (PDT)
From: Li Feng <fengli@smartx.com>
To: "Michael S. Tsirkin" <mst@redhat.com>,
 Raphael Norwitz <raphael.norwitz@nutanix.com>,
 Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Fam Zheng <fam@euphon.net>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Viresh Kumar <viresh.kumar@linaro.org>,
 qemu-block@nongnu.org (open list:Block layer core),
 qemu-devel@nongnu.org (open list:All patches CC here)
Cc: Li Feng <fengli@smartx.com>
Subject: [PATCH v2 1/4] vhost: fix the fd leak
Date: Tue, 25 Jul 2023 18:42:44 +0800
Message-ID: <20230725104256.4861-2-fengli@smartx.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230725104256.4861-1-fengli@smartx.com>
References: <20230721105205.1714449-1-fengli@smartx.com>
 <20230725104256.4861-1-fengli@smartx.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::432;
 envelope-from=fengli@smartx.com; helo=mail-pf1-x432.google.com
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

When the vhost-user reconnect to the backend, the notifer should be
cleanup. Otherwise, the fd resource will be exhausted.

Fixes: f9a09ca3ea ("vhost: add support for configure interrupt")

Signed-off-by: Li Feng <fengli@smartx.com>
---
 hw/virtio/vhost.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/hw/virtio/vhost.c b/hw/virtio/vhost.c
index abf0d03c8d..e2f6ffb446 100644
--- a/hw/virtio/vhost.c
+++ b/hw/virtio/vhost.c
@@ -2044,6 +2044,8 @@ void vhost_dev_stop(struct vhost_dev *hdev, VirtIODevice *vdev, bool vrings)
     event_notifier_test_and_clear(
         &hdev->vqs[VHOST_QUEUE_NUM_CONFIG_INR].masked_config_notifier);
     event_notifier_test_and_clear(&vdev->config_notifier);
+    event_notifier_cleanup(
+        &hdev->vqs[VHOST_QUEUE_NUM_CONFIG_INR].masked_config_notifier);
 
     trace_vhost_dev_stop(hdev, vdev->name, vrings);
 
-- 
2.41.0



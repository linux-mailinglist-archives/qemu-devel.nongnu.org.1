Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 91726761127
	for <lists+qemu-devel@lfdr.de>; Tue, 25 Jul 2023 12:46:42 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qOFXk-0008By-Ge; Tue, 25 Jul 2023 06:45:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <fengli@smartx.com>) id 1qOFXi-00089f-5i
 for qemu-devel@nongnu.org; Tue, 25 Jul 2023 06:45:26 -0400
Received: from mail-il1-x131.google.com ([2607:f8b0:4864:20::131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <fengli@smartx.com>) id 1qOFXg-00035U-KB
 for qemu-devel@nongnu.org; Tue, 25 Jul 2023 06:45:25 -0400
Received: by mail-il1-x131.google.com with SMTP id
 e9e14a558f8ab-34896a1574dso30334435ab.0
 for <qemu-devel@nongnu.org>; Tue, 25 Jul 2023 03:43:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=smartx-com.20221208.gappssmtp.com; s=20221208; t=1690281803; x=1690886603;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=M1cA9e5yzf2hNCWgBUmfES7GtFkzi9v/WbQPtniu6Bs=;
 b=Jt8PLWhMFaU9PfcHIz3m78nzNlS0NVISaRN6slY/kAfDySBnZRb+Xq3HjM+JEKVIa7
 wut81s25vRaTtib9z7Be3rw/3KuSoSzA2PH3T4eJZmGMftYnpJap2Znv9FdSlf+3yWZQ
 tJWKxQJVT6JxgCHaopdjz5JC0TnQTqT17Zd2m7D1Poot95+0BbnKOMHeaDRAE6017vG4
 Tr3LsBg2L65gg19YLPcuKxLiUI1PRFROqRQBTBZmmqKbijjqKGCNzntAKc1N3ZnUCdKb
 PTkeQsqEZNT6vwciMrOiLfsHoVXcm+3QPxRNFsFaeg95/0IrEewbA7D9gwa0FSQRylmA
 8o3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1690281803; x=1690886603;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=M1cA9e5yzf2hNCWgBUmfES7GtFkzi9v/WbQPtniu6Bs=;
 b=DBW20toXYtFMnrOgT4UF84T70AtkBC76OWQ0AGXwlQNTc5AgdSjpW5tOYCcR73EE6z
 8VJvAoSMgbF9xGiURqv6ljGjnFGXQveWcfXQzsdD3CGOhBDpXRzsaCe8OO2s2sj+IVZn
 YY2Vt7PCJZetNZZPnQwgnLAfi1Q14DO6jjmxKMRql8YpbuVA2TGCsSRdRxR+31dsxTLi
 /tg/YeoQMffTrVMx/F5I5kxYJDeY6C7boxZjhoxwqzUGxBqKvrZ25HsAkHrWQveh6jjs
 opEaxFnPJfdfGRRoIrGHJo0nBXc8FwyK5zoC8IBjQ2EeJXUn6HKvtp23HN0I05a2Hgw2
 NuxA==
X-Gm-Message-State: ABy/qLZmUt2b2SgZFqs/5Snvo2SAbXBoB9WUD47gO2Yt0fjjVNN46Vuw
 of9/UiiN1s0EJ6rOUgfJRRMV2A==
X-Google-Smtp-Source: APBJJlECERw41/DD91Jx5irI1BIUW7VDWwh/Uenlyc5Duq422MI9bs/sZwPJoLPbUrkUaCkpXMd/kA==
X-Received: by 2002:a92:c711:0:b0:343:c8b1:b7f0 with SMTP id
 a17-20020a92c711000000b00343c8b1b7f0mr2420127ilp.23.1690281803196; 
 Tue, 25 Jul 2023 03:43:23 -0700 (PDT)
Received: from localhost.localdomain.gitgo.cc ([47.75.78.161])
 by smtp.gmail.com with ESMTPSA id
 c20-20020aa78c14000000b0062cf75a9e6bsm9343165pfd.131.2023.07.25.03.43.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 25 Jul 2023 03:43:22 -0700 (PDT)
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
Subject: [PATCH v2 2/4] vhost-user-common: send get_inflight_fd once
Date: Tue, 25 Jul 2023 18:42:45 +0800
Message-ID: <20230725104256.4861-3-fengli@smartx.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230725104256.4861-1-fengli@smartx.com>
References: <20230721105205.1714449-1-fengli@smartx.com>
 <20230725104256.4861-1-fengli@smartx.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::131;
 envelope-from=fengli@smartx.com; helo=mail-il1-x131.google.com
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

Get_inflight_fd is sent only once. When reconnecting to the backend,
qemu sent set_inflight_fd to the backend.

Signed-off-by: Li Feng <fengli@smartx.com>
---
 hw/scsi/vhost-scsi-common.c | 37 ++++++++++++++++++-------------------
 1 file changed, 18 insertions(+), 19 deletions(-)

diff --git a/hw/scsi/vhost-scsi-common.c b/hw/scsi/vhost-scsi-common.c
index a06f01af26..664adb15b4 100644
--- a/hw/scsi/vhost-scsi-common.c
+++ b/hw/scsi/vhost-scsi-common.c
@@ -52,20 +52,28 @@ int vhost_scsi_common_start(VHostSCSICommon *vsc)
 
     vsc->dev.acked_features = vdev->guest_features;
 
-    assert(vsc->inflight == NULL);
-    vsc->inflight = g_new0(struct vhost_inflight, 1);
-    ret = vhost_dev_get_inflight(&vsc->dev,
-                                 vs->conf.virtqueue_size,
-                                 vsc->inflight);
+    ret = vhost_dev_prepare_inflight(&vsc->dev, vdev);
     if (ret < 0) {
-        error_report("Error get inflight: %d", -ret);
+        error_report("Error setting inflight format: %d", -ret);
         goto err_guest_notifiers;
     }
 
-    ret = vhost_dev_set_inflight(&vsc->dev, vsc->inflight);
-    if (ret < 0) {
-        error_report("Error set inflight: %d", -ret);
-        goto err_guest_notifiers;
+    if (vsc->inflight) {
+        if (!vsc->inflight->addr) {
+            ret = vhost_dev_get_inflight(&vsc->dev,
+                                        vs->conf.virtqueue_size,
+                                        vsc->inflight);
+            if (ret < 0) {
+                error_report("Error get inflight: %d", -ret);
+                goto err_guest_notifiers;
+            }
+        }
+
+        ret = vhost_dev_set_inflight(&vsc->dev, vsc->inflight);
+        if (ret < 0) {
+            error_report("Error set inflight: %d", -ret);
+            goto err_guest_notifiers;
+        }
     }
 
     ret = vhost_dev_start(&vsc->dev, vdev, true);
@@ -85,9 +93,6 @@ int vhost_scsi_common_start(VHostSCSICommon *vsc)
     return ret;
 
 err_guest_notifiers:
-    g_free(vsc->inflight);
-    vsc->inflight = NULL;
-
     k->set_guest_notifiers(qbus->parent, vsc->dev.nvqs, false);
 err_host_notifiers:
     vhost_dev_disable_notifiers(&vsc->dev, vdev);
@@ -111,12 +116,6 @@ void vhost_scsi_common_stop(VHostSCSICommon *vsc)
     }
     assert(ret >= 0);
 
-    if (vsc->inflight) {
-        vhost_dev_free_inflight(vsc->inflight);
-        g_free(vsc->inflight);
-        vsc->inflight = NULL;
-    }
-
     vhost_dev_disable_notifiers(&vsc->dev, vdev);
 }
 
-- 
2.41.0



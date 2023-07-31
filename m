Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 580967695C3
	for <lists+qemu-devel@lfdr.de>; Mon, 31 Jul 2023 14:13:37 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qQRlk-0003AP-Mr; Mon, 31 Jul 2023 08:13:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <fengli@smartx.com>) id 1qQRlh-00038z-L0
 for qemu-devel@nongnu.org; Mon, 31 Jul 2023 08:12:57 -0400
Received: from mail-pf1-x42d.google.com ([2607:f8b0:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <fengli@smartx.com>) id 1qQRle-00053R-8E
 for qemu-devel@nongnu.org; Mon, 31 Jul 2023 08:12:57 -0400
Received: by mail-pf1-x42d.google.com with SMTP id
 d2e1a72fcca58-686efb9ee0cso4389242b3a.3
 for <qemu-devel@nongnu.org>; Mon, 31 Jul 2023 05:10:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=smartx-com.20221208.gappssmtp.com; s=20221208; t=1690805452; x=1691410252;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=EmF2rPUr8kcukZB0aZbqQbeTdRQhvpW4qihewNCbxJ8=;
 b=pOFSpZF7CJ50fLdrkGKuhXeJbet6VUS/U5k2naveKlfWLRo/uzCSGF+Ho6/wtTguTA
 SmBpt3bZNkxaGLBaWcsPj9bdZ7ryqC0CJ3JpP4JpG3kQvhG4IY5OMnFnBdy7D3cMCbSG
 qSnEkVgi6eAEEv82G9TM+dmz/yEnPS6u/XXPwIgJf70WbnxOtQ4/J39jDEZ2XoxUTHTQ
 M262T3Npr5f+2QtS8oPCWb71hYrZDutQhkCn9+Aq5WFgU+QOK17exfCz18cpTNeyrxG2
 4PUR5YeJqotadjmspOhCnNYRcW6Qnyyayuk+y1ULAIHyyjW8/44yvzBzCah+/BQxPbid
 hAZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1690805452; x=1691410252;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=EmF2rPUr8kcukZB0aZbqQbeTdRQhvpW4qihewNCbxJ8=;
 b=W1lXlN/oXvRjpobDxhoT8tz/YP+NTvJeK/lxInE5iqixTxQt6jQTxVcAxBu7rGmtwo
 ko58oTLGW6r/KvIQwYVUwpCFxDLPxUolYylGYRw7jiQQfH3DngRYFkGkN4HRRCPuYFFX
 VI/skaQD1BFJ+JXg0j8zU8pEmuMSJ4w8V6t01I7abZFYOawZ3QD6hfnF94VoHP9EVXLP
 9IfLFjxmXp7tONYWCJO/+nDLP/mbqJNCnvPggIFzWVJ4YJEJd7WvW8lb7QsQGUaR161q
 LYFrx+CJNntVLgQbz2w4vqHzEn8cX6VsTGsYfCyXjZkt2lL4V3FEAfGwk1/pp5yffDN/
 TVdA==
X-Gm-Message-State: ABy/qLbrpH5hkRpJvnXXEbM2Bi1w5sVVcZk+8oWb+O/VJ6MOVoHQdjaH
 wDy2JnsAByyRE/yEyXRMftPPdw==
X-Google-Smtp-Source: APBJJlGuWp2D80lSbIybokl43feIX4m1gFG4J/5s6SQ7bn38kaDUmY3kJJQd7N2lfPmlN0u8s5boXw==
X-Received: by 2002:a05:6a20:7352:b0:122:c6c4:36b1 with SMTP id
 v18-20020a056a20735200b00122c6c436b1mr11873001pzc.4.1690805452229; 
 Mon, 31 Jul 2023 05:10:52 -0700 (PDT)
Received: from localhost.localdomain.gitgo.cc ([47.75.78.161])
 by smtp.gmail.com with ESMTPSA id
 a10-20020a62bd0a000000b005d22639b577sm7385690pff.165.2023.07.31.05.10.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 31 Jul 2023 05:10:51 -0700 (PDT)
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
Subject: [PATCH v3 1/5] vhost: fix the fd leak
Date: Mon, 31 Jul 2023 20:10:06 +0800
Message-ID: <20230731121018.2856310-2-fengli@smartx.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230731121018.2856310-1-fengli@smartx.com>
References: <20230721105205.1714449-1-fengli@smartx.com>
 <20230731121018.2856310-1-fengli@smartx.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::42d;
 envelope-from=fengli@smartx.com; helo=mail-pf1-x42d.google.com
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

When the vhost-user reconnect to the backend, the notifer should be
cleanup. Otherwise, the fd resource will be exhausted.

Fixes: f9a09ca3ea ("vhost: add support for configure interrupt")

Signed-off-by: Li Feng <fengli@smartx.com>
Reviewed-by: Raphael Norwitz <raphael.norwitz@nutanix.com>
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



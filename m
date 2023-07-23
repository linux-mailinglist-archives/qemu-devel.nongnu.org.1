Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DA8375E0E8
	for <lists+qemu-devel@lfdr.de>; Sun, 23 Jul 2023 11:28:22 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qNVNM-0001et-Ds; Sun, 23 Jul 2023 05:27:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yin31149@gmail.com>)
 id 1qNVNK-0001ek-Gh
 for qemu-devel@nongnu.org; Sun, 23 Jul 2023 05:27:38 -0400
Received: from mail-oa1-x35.google.com ([2001:4860:4864:20::35])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <yin31149@gmail.com>)
 id 1qNVNJ-0001VX-1M
 for qemu-devel@nongnu.org; Sun, 23 Jul 2023 05:27:38 -0400
Received: by mail-oa1-x35.google.com with SMTP id
 586e51a60fabf-1ba5cda3530so2678506fac.3
 for <qemu-devel@nongnu.org>; Sun, 23 Jul 2023 02:27:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1690104455; x=1690709255;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=749c16VfFqHXoK3rBi9xwn3HY6BMtdWqslVMXDL704I=;
 b=fggoczcXHpDtLbhIZ1PrJqmn8Qbzaw2iEtGGoD+DExbqVwCsUDpeZpqSdS+5ByjPxB
 7SLudd4+A4XwWWgfsD6DgM/xTWC8r1pzqm/je05TVy5jvZ2Ey39+wgY6/gaWBULAFYXB
 UPe55c2pRDjbWQ8tmjSFI6xYJcmfRenUtIb5u9eYnIIF+8hMaK8tqvhv0Evi1F81+cHo
 C53LxxLRCawdDa1v+pXIXsKWDqqyo1fRNVv+peISJ7m1RR7xmQsOvLb/mV47w56Kz60P
 TPiIIWKE1Q4Uw5TAfL5CYvhW9h+pZCRZT+dpnHIFkDcqErZpIfvl3KHS7fOavPE6Hl/k
 0SQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1690104455; x=1690709255;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=749c16VfFqHXoK3rBi9xwn3HY6BMtdWqslVMXDL704I=;
 b=FmMKwsK/0DIvn8K0j7zpW8MN4Z5QBecjL/X8FiznHD+PBMYcSI/aAXwkKjxsVf+SNQ
 yIZkYJMH2xd05QKDT0vz+yRq/825zBNt98PJmgy0qQOrZDFiSdWWbPa3nLQAM7GX7W3B
 bq3M909D7HLyu8C8j2nh7advyxKY+msU27bt9aqejHYeV18CtKMXDGSjJRmBtFY4SL95
 uvV6i3PVdGcQVBkMA9u0RXRuLednM0qpsvSSMBQV9Fd/b4EKPJWPaTDVbmUlwdUKxOPs
 65GuE/L01PGbO0SsWx/GSS3YlwkElbC2AFR6QCQz83K3fU25ql+B0ZeP3oBq2E0hqB3W
 sofg==
X-Gm-Message-State: ABy/qLbQSr5jBkcT+6UsfO+qLulZ66PGOO2KaNlAk4WExX2PVqkFVnmW
 iMjEWrvgi5SsqtlO6E7hLh8=
X-Google-Smtp-Source: APBJJlEjOP3VIBtYInrCKzVRrnFX9JQSIM1zm8DqrSQ3N4j9U5i/9sIid7ZcHvPgsAl+4+gKpylOdA==
X-Received: by 2002:a05:6870:5493:b0:1ba:d044:8a4 with SMTP id
 f19-20020a056870549300b001bad04408a4mr7364851oan.18.1690104455419; 
 Sun, 23 Jul 2023 02:27:35 -0700 (PDT)
Received: from localhost ([123.117.183.65]) by smtp.gmail.com with ESMTPSA id
 c3-20020a62e803000000b0067b384d5955sm5696949pfi.26.2023.07.23.02.27.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 23 Jul 2023 02:27:35 -0700 (PDT)
From: Hawkins Jiawei <yin31149@gmail.com>
To: jasowang@redhat.com,
	mst@redhat.com,
	eperezma@redhat.com
Cc: qemu-devel@nongnu.org,
	yin31149@gmail.com,
	18801353760@163.com
Subject: [PATCH v2 1/4] virtio-net: do not reset vlan filtering at set_features
Date: Sun, 23 Jul 2023 17:26:34 +0800
Message-Id: <95af0d013281282f48ad3f47f6ad1ac4ca9e52eb.1690100802.git.yin31149@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1690100802.git.yin31149@gmail.com>
References: <cover.1690100802.git.yin31149@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2001:4860:4864:20::35;
 envelope-from=yin31149@gmail.com; helo=mail-oa1-x35.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

From: Eugenio Pérez <eperezma@redhat.com>

This function is called after virtio_load, so all vlan configuration is
lost in migration case.

Just allow all the vlan-tagged packets if vlan is not configured, and
trust device reset to clear all filtered vlans.

Fixes: 0b1eaa8803 ("virtio-net: Do not filter VLANs without F_CTRL_VLAN")
Signed-off-by: Eugenio Pérez <eperezma@redhat.com>
Reviewed-by: Hawkins Jiawei <yin31149@gmail.com>
Signed-off-by: Hawkins Jiawei <yin31149@gmail.com>
---
 hw/net/virtio-net.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c
index 7102ec4817..d20d5a63cd 100644
--- a/hw/net/virtio-net.c
+++ b/hw/net/virtio-net.c
@@ -1006,9 +1006,7 @@ static void virtio_net_set_features(VirtIODevice *vdev, uint64_t features)
         vhost_net_save_acked_features(nc->peer);
     }
 
-    if (virtio_has_feature(features, VIRTIO_NET_F_CTRL_VLAN)) {
-        memset(n->vlans, 0, MAX_VLAN >> 3);
-    } else {
+    if (!virtio_has_feature(features, VIRTIO_NET_F_CTRL_VLAN)) {
         memset(n->vlans, 0xff, MAX_VLAN >> 3);
     }
 
-- 
2.25.1



Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D99871248E
	for <lists+qemu-devel@lfdr.de>; Fri, 26 May 2023 12:25:21 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q2Ud9-0002Ts-5b; Fri, 26 May 2023 06:25:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1q2Ud2-0002TF-DC
 for qemu-devel@nongnu.org; Fri, 26 May 2023 06:25:00 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1q2Ud0-00047h-Sj
 for qemu-devel@nongnu.org; Fri, 26 May 2023 06:25:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1685096698;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=GCvS+Wps5FVIB+tN+Nmg7N1DE4mgCjC34QpdCzMlYhM=;
 b=Ncx66LG3IiDp1ApPp2ZuitUsBC1LiGKl8zcsFGwFvAFMgk5flJDN8XOw/dnlzIQofpZnSq
 oGD8q/fuv/eqfiS7wOloEpZDKT/Ct4AeRfKPkjDbu9LtOnWu24p/Bl8BhdL90OhQhbFD2C
 YhlW28VeYinGCrYE7gwe5cJ4BcE/Bcs=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-376-mK3I89L2OOSFiyhJHq-mew-1; Fri, 26 May 2023 06:24:56 -0400
X-MC-Unique: mK3I89L2OOSFiyhJHq-mew-1
Received: by mail-ej1-f70.google.com with SMTP id
 a640c23a62f3a-96fd3757c1dso66161066b.1
 for <qemu-devel@nongnu.org>; Fri, 26 May 2023 03:24:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685096695; x=1687688695;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=GCvS+Wps5FVIB+tN+Nmg7N1DE4mgCjC34QpdCzMlYhM=;
 b=FiRDpm6zdA4tlMPmyr+gASaeSa/9r/+ncB+z1YHrUFpQz26MkIfk15DrCkqu79D2x+
 qQyEqoLm2O4eyKuRGsFMlglUkFW7S3vOEb10GT+TmE1x5M/aH+KFhgnsZuJfHDwoVN55
 EqEb38MtfQAQGWcGJIrus9MBEYsZEcwVVe/YFv0i4jallG1xolxwahF7B4AHD3Xvyljq
 V3gYxCp6oX7OoeN81n0vRQzuAY05HZjJT8HkOxFzgalD7xDgGsCT2Ox3XdBITCoHVre8
 nUIegE/L8pCRbys3jPLHBy5x5lEGsWUUsgBemEhpRJCWKDLNckwBeT0CHkpZik+H/8Uc
 3cXA==
X-Gm-Message-State: AC+VfDx7X0anN8fA0fWZfuAUHGqWjEpGXWjIEjt/VWaOiGSp9H2B3Nv0
 VetF6ccTx/BAEFwGUXyxnOWR0/irPC30LswP3I/g4Gc0D0758pcupoaHIatmKRZa5dWltWCivOw
 OyoGSjZiIq1vBrSIlxdzDLi9DclYhC8XN7ogposgxO992thySb7XgVOWin+GVgz9+keXI7SxkMV
 U=
X-Received: by 2002:a17:907:26c9:b0:966:1284:e3e with SMTP id
 bp9-20020a17090726c900b0096612840e3emr1378996ejc.9.1685096695140; 
 Fri, 26 May 2023 03:24:55 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ4g0Ypa1g8hOxWkWJ8aEFfKUfwbQRdoEylZD/hN8P8xXuXtAmbVl17F49u0Rw0nt7EnhmBlOw==
X-Received: by 2002:a17:907:26c9:b0:966:1284:e3e with SMTP id
 bp9-20020a17090726c900b0096612840e3emr1378977ejc.9.1685096694695; 
 Fri, 26 May 2023 03:24:54 -0700 (PDT)
Received: from [192.168.10.118] ([2001:b07:6468:f312:5e2c:eb9a:a8b6:fd3e])
 by smtp.gmail.com with ESMTPSA id
 f26-20020a170906561a00b009664e25c425sm1986263ejq.95.2023.05.26.03.24.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 26 May 2023 03:24:54 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: mst@redhat.com
Subject: [PATCH] virtio: qmp: fix memory leak
Date: Fri, 26 May 2023 12:24:53 +0200
Message-Id: <20230526102453.436440-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

The VirtioInfoList is already allocated by QAPI_LIST_PREPEND and
need not be allocated by the caller.

Fixes Coverity CID 1508724.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 hw/virtio/virtio-qmp.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/hw/virtio/virtio-qmp.c b/hw/virtio/virtio-qmp.c
index e84316dcfd21..b5e183529971 100644
--- a/hw/virtio/virtio-qmp.c
+++ b/hw/virtio/virtio-qmp.c
@@ -668,7 +668,7 @@ VirtioDeviceFeatures *qmp_decode_features(uint16_t device_id, uint64_t bitmap)
 VirtioInfoList *qmp_x_query_virtio(Error **errp)
 {
     VirtioInfoList *list = NULL;
-    VirtioInfoList *node;
+    VirtioInfo *node;
     VirtIODevice *vdev;
 
     QTAILQ_FOREACH(vdev, &virtio_list, next) {
@@ -682,11 +682,10 @@ VirtioInfoList *qmp_x_query_virtio(Error **errp)
             if (!strncmp(is_realized->str, "false", 4)) {
                 QTAILQ_REMOVE(&virtio_list, vdev, next);
             } else {
-                node = g_new0(VirtioInfoList, 1);
-                node->value = g_new(VirtioInfo, 1);
-                node->value->path = g_strdup(dev->canonical_path);
-                node->value->name = g_strdup(vdev->name);
-                QAPI_LIST_PREPEND(list, node->value);
+                node = g_new(VirtioInfo, 1);
+                node->path = g_strdup(dev->canonical_path);
+                node->name = g_strdup(vdev->name);
+                QAPI_LIST_PREPEND(list, node);
             }
            g_string_free(is_realized, true);
         }
-- 
2.40.1



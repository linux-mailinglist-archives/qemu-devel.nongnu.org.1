Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C683573E06E
	for <lists+qemu-devel@lfdr.de>; Mon, 26 Jun 2023 15:20:22 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qDlNL-0006B3-5c; Mon, 26 Jun 2023 08:31:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qDlLk-0002xB-0j
 for qemu-devel@nongnu.org; Mon, 26 Jun 2023 08:29:50 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qDlLe-00037Z-9T
 for qemu-devel@nongnu.org; Mon, 26 Jun 2023 08:29:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1687782577;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=9h5GQO2ixxECW2hjmoc6X163wgQYf5XFJKca0BRTn7c=;
 b=KSvLZRFPrzzNWq3Asrje+25u1s9WCCfWPcj8a7TFWeBN9pDRcN9e4DwtfvaVsDnUW2ovSZ
 9E/qM3NIXDFiE0XJkZlU/gtqhx0blek3q2iJLvU9sZe+HUwpJOUGxBwxSDdANScFXjtfDk
 JgA3djZVcmTAubLM5rsKy2CdHDlckuQ=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-499--uob2gTxPkmhZmzOVXC6ZA-1; Mon, 26 Jun 2023 08:29:35 -0400
X-MC-Unique: -uob2gTxPkmhZmzOVXC6ZA-1
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-3113533a608so1197614f8f.0
 for <qemu-devel@nongnu.org>; Mon, 26 Jun 2023 05:29:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687782574; x=1690374574;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=9h5GQO2ixxECW2hjmoc6X163wgQYf5XFJKca0BRTn7c=;
 b=eE2/W4OTV5jYTo3IfkSeWn9GfVsl1ilMVJptq7jn1ex1Xoj4lEEqK3fZkD9N/PY58J
 rTxtYhKl8nbwYcdEgAFeaJ+6LAvGdIwam5ZSSGDEmG3n/ZQPDka2qPPoUncoVNU3vFlg
 TZ8mjTLltdkAMQ/fF+JiBlHPEoYUCm6jLSsC2Ceyfh8KBq1T/KJj5kZdH2mvubjgr5TZ
 eD1vBuhzoEeP3FQA3JOSlDO7z/V93atUu99xXSYUThpjKKOAx086yb7YGllq42thB79l
 7UCwwMBbD6qsCt9FZWQmwq284aWg6vytl1u6BhFznvXVZhImZUGU4FkWePvztzdwpVtj
 ONTA==
X-Gm-Message-State: AC+VfDwX97fLWeXT4v235c2fh9PhkaKMNYYdFC2ty7OJZ2GqydqM3BEJ
 6TxXp0qdjgvSJ1luItlqUAuzGVH5qVnP1UaXWcLd6MsRgE2vWPhxb4G7TRTSLoN0M9mvdNOilLy
 ux8Yh7kDe14lVKL7YxjonWcykJcBtiPDAn75rbpUoHYT7b+zPsumEx9j59JFNB/MooY0M
X-Received: by 2002:a05:600c:215:b0:3fa:99d6:47a4 with SMTP id
 21-20020a05600c021500b003fa99d647a4mr1211460wmi.22.1687782574353; 
 Mon, 26 Jun 2023 05:29:34 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ7ej65/sB6tUS/Wprf+fPtNtRsma/D6uHi5DXvZuzYopKb26iX9a5l92bTwtBFO82ASCTv+iQ==
X-Received: by 2002:a05:600c:215:b0:3fa:99d6:47a4 with SMTP id
 21-20020a05600c021500b003fa99d647a4mr1211449wmi.22.1687782574113; 
 Mon, 26 Jun 2023 05:29:34 -0700 (PDT)
Received: from redhat.com ([2.52.156.102]) by smtp.gmail.com with ESMTPSA id
 g17-20020a7bc4d1000000b003f7f87ba116sm10511360wmk.19.2023.06.26.05.29.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Jun 2023 05:29:33 -0700 (PDT)
Date: Mon, 26 Jun 2023 08:29:31 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>,
 Lei Yang <leiyang@redhat.com>, Jason Wang <jasowang@redhat.com>
Subject: [PULL 34/53] vdpa: do not block migration if device has cvq and
 x-svq=on
Message-ID: <d3a7a708e1173b712c0ed4c078324cc4577850ac.1687782442.git.mst@redhat.com>
References: <cover.1687782442.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover.1687782442.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

It was a mistake to forbid in all cases, as SVQ is already able to send
all the CVQ messages before start forwarding data vqs.  It actually
caused a regression, making impossible to migrate device previously
migratable.

Fixes: 36e4647247f2 ("vdpa: add vhost_vdpa_net_valid_svq_features")
Signed-off-by: Eugenio Pérez <eperezma@redhat.com>
Message-Id: <20230602143854.1879091-2-eperezma@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Tested-by: Lei Yang <leiyang@redhat.com>
---
 net/vhost-vdpa.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/net/vhost-vdpa.c b/net/vhost-vdpa.c
index 46778d5313..4345f1e6de 100644
--- a/net/vhost-vdpa.c
+++ b/net/vhost-vdpa.c
@@ -915,13 +915,16 @@ static NetClientState *net_vhost_vdpa_init(NetClientState *peer,
         s->cvq_isolated = cvq_isolated;
 
         /*
-         * TODO: We cannot migrate devices with CVQ as there is no way to set
-         * the device state (MAC, MQ, etc) before starting the datapath.
+         * TODO: We cannot migrate devices with CVQ and no x-svq enabled as
+         * there is no way to set the device state (MAC, MQ, etc) before
+         * starting the datapath.
          *
          * Migration blocker ownership now belongs to s->vhost_vdpa.
          */
-        error_setg(&s->vhost_vdpa.migration_blocker,
-                   "net vdpa cannot migrate with CVQ feature");
+        if (!svq) {
+            error_setg(&s->vhost_vdpa.migration_blocker,
+                       "net vdpa cannot migrate with CVQ feature");
+        }
     }
     ret = vhost_vdpa_add(nc, (void *)&s->vhost_vdpa, queue_pair_index, nvqs);
     if (ret) {
-- 
MST



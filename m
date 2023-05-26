Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 22A2F712A67
	for <lists+qemu-devel@lfdr.de>; Fri, 26 May 2023 18:14:05 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q2Zzi-0004Ge-SH; Fri, 26 May 2023 12:08:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1q2Zzg-0004Fb-Gc
 for qemu-devel@nongnu.org; Fri, 26 May 2023 12:08:44 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1q2Zze-0002g3-UA
 for qemu-devel@nongnu.org; Fri, 26 May 2023 12:08:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1685117322;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version: content-type:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8FzBR8mv7HxcHF0wEA+3cPPXa3W2LSqegzyqCMIJnQM=;
 b=jDoWWY6TGrqoBpB3g5gcxt3pQl5rDXs4VXBn3OgoKKPKjejJXymErVDjD36jDK+dCz9zDD
 FoaVjIgZPtVKlwulkaeo/5GWto2Z/9iXVn6M4RXZ5DLRgl3n+IZVCnxctuzMHFt6hvJmyq
 bx4wLb9wsqZS7KVjnL1D/06fJpIrx3o=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-567-Og2JfcDpOKOxHZSHySEt5A-1; Fri, 26 May 2023 12:08:40 -0400
X-MC-Unique: Og2JfcDpOKOxHZSHySEt5A-1
Received: by mail-ej1-f71.google.com with SMTP id
 a640c23a62f3a-96f5157aca5so111882266b.0
 for <qemu-devel@nongnu.org>; Fri, 26 May 2023 09:08:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685117319; x=1687709319;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=8FzBR8mv7HxcHF0wEA+3cPPXa3W2LSqegzyqCMIJnQM=;
 b=lS7017gnQb+cFUqkIKaaipVw1R9J8bwUhjbqSyodX5GDutkgw7wTWBCCoTmbzEVlHY
 WI00pI1/h8l8xItI06efSsmXvmZfx8w2FAL30XZqH3fv46+FBy1y1NPkEvpadHtQh/Xp
 Qkw5vp0wQgJS+qThlEpwpRIGnpLJ1BCPwn1mc3SI02ants0K0UG1ojAoJ5uzI+1g3MKl
 fBn233Biylkk6NZlDzPpMYsB7iHOyw9EkgBewsW09e7M1KYqkx0LOU5gJfVSEFzllUtN
 N8JNcL4PyBxlaulLm+YzqddfIlwmvIzXUyhQ0A+g97moejq2BW63JBEt73+E4y5QrXLZ
 Fy5w==
X-Gm-Message-State: AC+VfDwqvieqW+lcDRxXFJMlGvuLPySJkiiM/ik8DHTKJb1SgILGWn6l
 BfkqJvdbf4LKa6TIDoT5Ag51gq4llQ6iwGVcs0I9C56pd/ts8A7rVniTrwAopcuuYKoe6Pirser
 doSBsLCdqyBA7dCxTQrhjHqCMc+EFPljGEFVlfHHKoEkbPxxBvlMchJgI6AYv6HCvJEUIUl3tXi
 Q=
X-Received: by 2002:a17:907:960f:b0:96f:d8a9:d045 with SMTP id
 gb15-20020a170907960f00b0096fd8a9d045mr2112215ejc.59.1685117319258; 
 Fri, 26 May 2023 09:08:39 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ7blQmYGUlIfITrGqh1fBr5mb9yHfIu8RG1/ZOOHmk9hEGaZcm0cjrl87KM5yIxR+Zzjj4mWw==
X-Received: by 2002:a17:907:960f:b0:96f:d8a9:d045 with SMTP id
 gb15-20020a170907960f00b0096fd8a9d045mr2112198ejc.59.1685117319006; 
 Fri, 26 May 2023 09:08:39 -0700 (PDT)
Received: from [192.168.10.118] ([2001:b07:6468:f312:5e2c:eb9a:a8b6:fd3e])
 by smtp.gmail.com with ESMTPSA id
 bx8-20020a170906a1c800b009584c5bcbc7sm2260876ejb.49.2023.05.26.09.08.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 26 May 2023 09:08:38 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PULL 08/12] virtio: qmp: fix memory leak
Date: Fri, 26 May 2023 18:08:20 +0200
Message-Id: <20230526160824.655279-9-pbonzini@redhat.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230526160824.655279-1-pbonzini@redhat.com>
References: <20230526160824.655279-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
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

Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
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



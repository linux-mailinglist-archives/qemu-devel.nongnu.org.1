Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E00881E657
	for <lists+qemu-devel@lfdr.de>; Tue, 26 Dec 2023 10:25:48 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rI3g6-0001tG-L5; Tue, 26 Dec 2023 04:24:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1rI3g1-0001e4-DK
 for qemu-devel@nongnu.org; Tue, 26 Dec 2023 04:24:42 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1rI3fz-0008IG-Dx
 for qemu-devel@nongnu.org; Tue, 26 Dec 2023 04:24:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1703582678;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=N39XRBVP9UVXyghkAg87M/jQ4XVZeFGKXGSiwW/zl4g=;
 b=cGM/qUG/HErDFz6Uwl5yRoMXaNvRrbf+3ygO/kfM29qkPbQWzlXn1HsQshH8K+RQbMVT+x
 IjsOpL5emdpKx+D8yLAiSy/QYyIrQLvR5awR1/nnlZM1fMDOZD/49RsVlqx31mXf+GicSi
 draqZ+6azle79m/FjeGVxPiI43PdmTI=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-62-EmnAx7ofNDePlMvKK0t_cA-1; Tue, 26 Dec 2023 04:24:36 -0500
X-MC-Unique: EmnAx7ofNDePlMvKK0t_cA-1
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-40d5ae4cdadso2393565e9.0
 for <qemu-devel@nongnu.org>; Tue, 26 Dec 2023 01:24:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703582674; x=1704187474;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=N39XRBVP9UVXyghkAg87M/jQ4XVZeFGKXGSiwW/zl4g=;
 b=Rkx5gZfccvUe3ETmGYQdDJQVCa6BFbUz7nciaqUiHgFrqjBdLjlAyIWV/kD80FMq89
 Ip/N3CX7Xsejkv9HeHMS0uJTzmlI76xYarhs2tIzw8vTmiWomtVAPRQsWzUsiJrSEO4h
 wkNHQWcd3KaAe5Lpj5ntGVHHuvJ+EHwWutF+2Sb2Lz6zE4DRV/FNBZh00xwAsyMEEctD
 ZnClC5jTbza2G6EUAd5YtYVVKjENFdQ60z7c3cNHLkQJRfbYxXPyEa653NPBnW/6AxRB
 lVJkPPYYoPzue5SKWVdVPHBKoooFZJwBTKggzKH5DFrx9jT6Q00TXB14Uuo01bmAWF6e
 2TOA==
X-Gm-Message-State: AOJu0YwQwk+2usNgr7IEq/dWSCKcdgNLdWF7RXDeDI7/KzvESdeVGIL7
 O3SFaRG9cCNo7TQK09gwsDlU1StDi84v428uUdce3ZWoNiCN35TtAhFUaDQ0D/WQ1B6z5J3hGcS
 DXnFv/idXevLsFhICbU5on5NCaucrMLYlxmOo86wUUNXSUqCZfpTcTFFqL7zKCFJNHiC1Ux/kWy
 gJ
X-Received: by 2002:a05:600c:310d:b0:40d:284a:6b6e with SMTP id
 g13-20020a05600c310d00b0040d284a6b6emr2951981wmo.153.1703582674283; 
 Tue, 26 Dec 2023 01:24:34 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFOzbcH/TdJGGAfLy0Kq1ZxG7ykCkkmlt35AtZ5CqzanOTXi21+ZRaKB/EymKIeOC5KrIqOoQ==
X-Received: by 2002:a05:600c:310d:b0:40d:284a:6b6e with SMTP id
 g13-20020a05600c310d00b0040d284a6b6emr2951973wmo.153.1703582673863; 
 Tue, 26 Dec 2023 01:24:33 -0800 (PST)
Received: from redhat.com ([2.55.177.189]) by smtp.gmail.com with ESMTPSA id
 c18-20020a5d4152000000b0033609b71825sm12088512wrq.35.2023.12.26.01.24.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 26 Dec 2023 01:24:31 -0800 (PST)
Date: Tue, 26 Dec 2023 04:24:29 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>
Subject: [PULL 08/21] vdpa: do not set virtio status bits if unneeded
Message-ID: <e6ed6d80556c66e2f76b8c6975c5abe2ace5ca90.1703582625.git.mst@redhat.com>
References: <cover.1703582625.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover.1703582625.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -50
X-Spam_score: -5.1
X-Spam_bar: -----
X-Spam_report: (-5.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.977,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Next commits will set DRIVER and ACKNOWLEDGE flags repeatedly in the
case of a migration destination.  Let's save ioctls with this.

Signed-off-by: Eugenio Pérez <eperezma@redhat.com>
Message-Id: <20231215172830.2540987-2-eperezma@redhat.com>
---
 hw/virtio/vhost-vdpa.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/hw/virtio/vhost-vdpa.c b/hw/virtio/vhost-vdpa.c
index 819b2d811a..401dfa96fd 100644
--- a/hw/virtio/vhost-vdpa.c
+++ b/hw/virtio/vhost-vdpa.c
@@ -511,6 +511,10 @@ static int vhost_vdpa_add_status(struct vhost_dev *dev, uint8_t status)
     if (ret < 0) {
         return ret;
     }
+    if ((s & status) == status) {
+        /* Don't set bits already set */
+        return 0;
+    }
 
     s |= status;
 
-- 
MST



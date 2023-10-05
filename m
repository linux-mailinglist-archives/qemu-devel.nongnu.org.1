Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 28EFB7B9A4A
	for <lists+qemu-devel@lfdr.de>; Thu,  5 Oct 2023 05:44:30 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qoFGo-0001cs-8W; Wed, 04 Oct 2023 23:43:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qoFGl-0001Zw-Ba
 for qemu-devel@nongnu.org; Wed, 04 Oct 2023 23:43:23 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qoFGi-0008LC-IN
 for qemu-devel@nongnu.org; Wed, 04 Oct 2023 23:43:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1696477399;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=BZAf5QAqncqN0Tj7r6/rT3sDH9P2a7sWx1zkWFPC9Wo=;
 b=NoiMXXNnaMWknakIXNCuFPpJcWZLAu8cahLJHSXmyxgn3SYiUtgrDDd3hstPzoxR6fAkXR
 5OxDpn/2Zxw9WkOewW6DyRfCr/73RBNVyfip+a89c2kSeHYoxW3msiIhv5JurUOJynY6hH
 bDcyiTBo8f8+DoLVHCCqUOjq01rD0ag=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-661-2RavlWNWN7CYzSmkyIu8ww-1; Wed, 04 Oct 2023 23:43:18 -0400
X-MC-Unique: 2RavlWNWN7CYzSmkyIu8ww-1
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-32320b9d671so461431f8f.3
 for <qemu-devel@nongnu.org>; Wed, 04 Oct 2023 20:43:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696477396; x=1697082196;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=BZAf5QAqncqN0Tj7r6/rT3sDH9P2a7sWx1zkWFPC9Wo=;
 b=bKPlrJmqTn93i9oXAbwiahlhq9ePnO+HMXsWfMcHxvapFq+dYec9hl1TA0KNvDQNR0
 yPIGGVsJI678DymvgtLtuC1Yz1QhXyfGu86IIjLoQZksMf3GD/pGzFL3oKBL3Gr4Dob7
 9Pfl2/axeJH8VcDiU0EgCtj9Ta3ageumD7SyVokFMpWQOJOhDvBGiWXoYZ/8sIJAYcFu
 kH8MggCCoJlSDAFS++5lbMUJrsWk/sU62fyGO+Rs+79VxLxS1Hil0Cy0pZ4FMtYIffNR
 ZGS4u6xb144OHSvY8xnP6FVk3PyEWqPlpwysIwWewDpRgE9MOU79HgaDd6lmmeQtm5Ya
 et5Q==
X-Gm-Message-State: AOJu0YzIOo4d2511PnzMVLFdSEJOUO/NKJy9+PHmOKMNdEtlHpPZRKxN
 b9jSrLicUkKtbIrMYa1HP/haBDucix7+XxIgBJliRtbKsyT5XYZ4Z/M0rMK74M+PQThivuCS7Xu
 TlqFaGIuXRSPLaOqY39LtPmv1niC90LEEzeti9IinWLHyJQpZ1gbED90NB4Xrvfb5myc7
X-Received: by 2002:adf:cd0a:0:b0:320:5f:c249 with SMTP id
 w10-20020adfcd0a000000b00320005fc249mr3352603wrm.30.1696477396706; 
 Wed, 04 Oct 2023 20:43:16 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG+6Zdn1rEzcALBiUoYxqQlQ//1von9taefyJcXUz2Y1kp57RTpXyRPeWNfvtr9UsDgtd6kUg==
X-Received: by 2002:adf:cd0a:0:b0:320:5f:c249 with SMTP id
 w10-20020adfcd0a000000b00320005fc249mr3352593wrm.30.1696477396451; 
 Wed, 04 Oct 2023 20:43:16 -0700 (PDT)
Received: from redhat.com ([2.52.137.96]) by smtp.gmail.com with ESMTPSA id
 w17-20020a5d4b51000000b0031ad5fb5a0fsm634513wrs.58.2023.10.04.20.43.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Oct 2023 20:43:15 -0700 (PDT)
Date: Wed, 4 Oct 2023 23:43:12 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Hawkins Jiawei <yin31149@gmail.com>,
 Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>,
 Lei Yang <leiyang@redhat.com>, Jason Wang <jasowang@redhat.com>
Subject: [PULL v2 13/53] vdpa: Allow VIRTIO_NET_F_CTRL_VLAN in SVQ
Message-ID: <e213c45a042db2506b5e8f16293f1f1c5083a577.1696477105.git.mst@redhat.com>
References: <cover.1696477105.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover.1696477105.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Hawkins Jiawei <yin31149@gmail.com>

Enable SVQ with VIRTIO_NET_F_CTRL_VLAN feature.

Co-developed-by: Eugenio Pérez <eperezma@redhat.com>
Signed-off-by: Eugenio Pérez <eperezma@redhat.com>
Signed-off-by: Hawkins Jiawei <yin31149@gmail.com>
Message-Id: <38dc63102a42c31c72fd293d0e6e2828fd54c86e.1690106284.git.yin31149@gmail.com>
Tested-by: Lei Yang <leiyang@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 net/vhost-vdpa.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/vhost-vdpa.c b/net/vhost-vdpa.c
index 8648d86f64..144b33f997 100644
--- a/net/vhost-vdpa.c
+++ b/net/vhost-vdpa.c
@@ -114,6 +114,7 @@ static const uint64_t vdpa_svq_device_features =
     BIT_ULL(VIRTIO_NET_F_STATUS) |
     BIT_ULL(VIRTIO_NET_F_CTRL_VQ) |
     BIT_ULL(VIRTIO_NET_F_CTRL_RX) |
+    BIT_ULL(VIRTIO_NET_F_CTRL_VLAN) |
     BIT_ULL(VIRTIO_NET_F_CTRL_RX_EXTRA) |
     BIT_ULL(VIRTIO_NET_F_MQ) |
     BIT_ULL(VIRTIO_F_ANY_LAYOUT) |
-- 
MST



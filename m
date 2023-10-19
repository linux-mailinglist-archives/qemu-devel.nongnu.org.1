Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 284C67D0183
	for <lists+qemu-devel@lfdr.de>; Thu, 19 Oct 2023 20:30:11 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qtXex-0005sD-1x; Thu, 19 Oct 2023 14:22:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qtXeM-0005eQ-FA
 for qemu-devel@nongnu.org; Thu, 19 Oct 2023 14:21:39 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qtXeK-0000cY-9F
 for qemu-devel@nongnu.org; Thu, 19 Oct 2023 14:21:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697739693;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=thscQjX5d6rsLU3psVlcnXGZdg35cG2DFqaiwAr/Wqo=;
 b=hRp8J8SN9lgM4jb+R6Wu/LhGl8jydtkH2QxkDrSX2KmkmZ+vCeobUg9OZFPGxvyPsMNnT1
 z6+BMejCHCD/X/bFMZSl6cYRujCWlLmdPC89i0nE+OfGVoODyg9bsP4az2KthE/CbejSuU
 QLHW4n550xLGzgg2r+0lLEXTSN4P7LM=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-583-zxFtLgjrP4SDisX6mlicMQ-1; Thu, 19 Oct 2023 14:21:32 -0400
X-MC-Unique: zxFtLgjrP4SDisX6mlicMQ-1
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-32dc64b0305so1522f8f.1
 for <qemu-devel@nongnu.org>; Thu, 19 Oct 2023 11:21:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697739690; x=1698344490;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=thscQjX5d6rsLU3psVlcnXGZdg35cG2DFqaiwAr/Wqo=;
 b=oZkwwtyOMYVwh6bFfhCS5Nt79MEfpzj/Tdpl7VimRB5Nw3nGykkXgb8QFeiSgemzgn
 aUfZpsmAthXAJtA092PYfCrPNGGfl4BPt4xxGmOI+vsqHt4wmFjdS8hnSsy19oLSq1Nx
 xDZ4MvrwglPfn75Rzsl0ozUx4SuBlta0694z11Lf4xZz6PFy2mO+S3FNrgMwxW7iy3vi
 4UzfP0OGotQsCOR+F0JxRnZsXyrGMvIjrVjuaAaBEey4eATfFa8wxwhAvRhpcT3jpGBz
 gobz973wVlTBkIdKb9TClq6L6LoIYgbUtzzDSVifZrnm6N6rUgPu3N/5JvLUPf5SwiwO
 lPWg==
X-Gm-Message-State: AOJu0YwTiRc2o8ZtY46Zw8siy1gNK4giUOWJjb6ISbIETcVG2I0Bv+hp
 GfLcqqciZd9Vb3YLewe9FXT7U3GYlzLYNxYQm2NgcR5NBCzNrYuALQx7xW7MY8kQHNu2I8p1z96
 lwK0I51xY7PguZp7zDUDdWWDzCHTgrjbnrhQ8D9tLPj5dl3ADGZnQwyqKZdJShJ5I8GXc
X-Received: by 2002:adf:fa05:0:b0:32d:8f4c:a70b with SMTP id
 m5-20020adffa05000000b0032d8f4ca70bmr2290202wrr.9.1697739690392; 
 Thu, 19 Oct 2023 11:21:30 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHgzgjETyNEQy0bP3xC8/Ra924ScUhaxj/f+pM6Drk5o0ZR3btmdVp3II4zcWE2Xz0IbL6SYQ==
X-Received: by 2002:adf:fa05:0:b0:32d:8f4c:a70b with SMTP id
 m5-20020adffa05000000b0032d8f4ca70bmr2290179wrr.9.1697739689943; 
 Thu, 19 Oct 2023 11:21:29 -0700 (PDT)
Received: from redhat.com ([2a06:c701:73d2:bf00:e379:826:5137:6b23])
 by smtp.gmail.com with ESMTPSA id
 a17-20020a5d5091000000b0032d893d8dc8sm5046554wrt.2.2023.10.19.11.21.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Oct 2023 11:21:29 -0700 (PDT)
Date: Thu, 19 Oct 2023 14:21:27 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Hawkins Jiawei <yin31149@gmail.com>,
 Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>
Subject: [PULL v2 06/78] vhost: Expose vhost_svq_available_slots()
Message-ID: <99d6a32469debf1a48921125879b614d15acfb7a.1697739629.git.mst@redhat.com>
References: <cover.1697739629.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover.1697739629.git.mst@redhat.com>
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

Next patches in this series will delay the polling
and checking of buffers until either the SVQ is
full or control commands shadow buffers are full,
no longer perform an immediate poll and check of
the device's used buffers for each CVQ state load command.

To achieve this, this patch exposes
vhost_svq_available_slots(), allowing QEMU to know
whether the SVQ is full.

Signed-off-by: Hawkins Jiawei <yin31149@gmail.com>
Acked-by: Eugenio Pérez <eperezma@redhat.com>
Message-Id: <25938079f0bd8185fd664c64e205e629f7a966be.1697165821.git.yin31149@gmail.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/virtio/vhost-shadow-virtqueue.h | 1 +
 hw/virtio/vhost-shadow-virtqueue.c | 2 +-
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/hw/virtio/vhost-shadow-virtqueue.h b/hw/virtio/vhost-shadow-virtqueue.h
index 5bce67837b..19c842a15b 100644
--- a/hw/virtio/vhost-shadow-virtqueue.h
+++ b/hw/virtio/vhost-shadow-virtqueue.h
@@ -114,6 +114,7 @@ typedef struct VhostShadowVirtqueue {
 
 bool vhost_svq_valid_features(uint64_t features, Error **errp);
 
+uint16_t vhost_svq_available_slots(const VhostShadowVirtqueue *svq);
 void vhost_svq_push_elem(VhostShadowVirtqueue *svq,
                          const VirtQueueElement *elem, uint32_t len);
 int vhost_svq_add(VhostShadowVirtqueue *svq, const struct iovec *out_sg,
diff --git a/hw/virtio/vhost-shadow-virtqueue.c b/hw/virtio/vhost-shadow-virtqueue.c
index e731b1d2ea..fc5f408f77 100644
--- a/hw/virtio/vhost-shadow-virtqueue.c
+++ b/hw/virtio/vhost-shadow-virtqueue.c
@@ -66,7 +66,7 @@ bool vhost_svq_valid_features(uint64_t features, Error **errp)
  *
  * @svq: The svq
  */
-static uint16_t vhost_svq_available_slots(const VhostShadowVirtqueue *svq)
+uint16_t vhost_svq_available_slots(const VhostShadowVirtqueue *svq)
 {
     return svq->num_free;
 }
-- 
MST



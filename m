Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 16DFF7437CB
	for <lists+qemu-devel@lfdr.de>; Fri, 30 Jun 2023 10:55:13 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qF9u3-0006xN-VR; Fri, 30 Jun 2023 04:54:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yin31149@gmail.com>)
 id 1qF9tt-0006rm-Hh
 for qemu-devel@nongnu.org; Fri, 30 Jun 2023 04:54:45 -0400
Received: from mail-pl1-x629.google.com ([2607:f8b0:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <yin31149@gmail.com>)
 id 1qF9ts-0007na-3k
 for qemu-devel@nongnu.org; Fri, 30 Jun 2023 04:54:45 -0400
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-1b7db2e162cso8983685ad.1
 for <qemu-devel@nongnu.org>; Fri, 30 Jun 2023 01:54:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1688115282; x=1690707282;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ONeskzGL/DTHGYmmfSl7dJNnhbhkYuZqmU9JCoLRDgk=;
 b=r9R9h1SpBayP0FJczs+/IxSx1Ae+w9LFHnj+QVL1V3gMGorkasc6iX66q1DsUIq6+h
 gijXYJuXDz7XURUQu3RoExC0XWbCPOHc5IP3pj7AMvJ/YAy+jbEn+5NRr7/labeuvwIA
 R5XGuTvlPNTjr2rkC/tkzJzjin0Yg+3FXqQ8/UqxT4755dfsHJIbV8C1qeJCyftJNRGW
 xwnYsRSCyUjD3je9rUvEzryczeI5LXkypV63Ui+IUjJ7OyJPin2IUeQK2MBBlkmiFhhB
 msGsXlEE8FBeMv9bvXJiy7nBFXU5r0AFmoPkjHvJTyi+sgsuyUaz43HssRT8hWFmXsqJ
 jteA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688115282; x=1690707282;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ONeskzGL/DTHGYmmfSl7dJNnhbhkYuZqmU9JCoLRDgk=;
 b=jyJPcQojlMMosp+FZFl6sZ/sD/vjR9eo11YGnnTaS8VUNkGLBS4w11zidKP/OYGUPL
 W5BRDK2YUU16/b/YDyUfLQf1uApHgsCf2NvZOwYcXj6xlAYC93XVea3lP22peUuV8Oux
 jAjPUVa2lQkuS2EoS6ns+hqokWC+7NV1TC2n7LA6mJqkxKxMVWqeby3wkT87pwy8sXZf
 5Q4piz4WnwMi2NbEFs246G7mcp7F1cWvJxPRlGJXVsC7l3u/GggSDIs4lhSHNkcWA6bI
 kkMqidXyMeK4/qt+QAoSWJUOTemfQ1TMiM2IGHvf6d42lq2476pO57rsmboWiDU4LOg+
 4cmw==
X-Gm-Message-State: ABy/qLaZkfzPcBXuteiwQoO0buBQwtGgwtxVS6XYUU+TRyYIVE3o9eJe
 pWh2vsG9mE9/hUSFWo0doD4lJ7mvv+uetzSf
X-Google-Smtp-Source: APBJJlGrnpXLXVRU5e6Vo+TD1Ee9CsYLW0njt8CEUDTqCApKgST8h6T2pWV6zVm9DXdxHWxAMiJYNA==
X-Received: by 2002:a17:902:f54e:b0:1b8:5406:a34 with SMTP id
 h14-20020a170902f54e00b001b854060a34mr1637512plf.24.1688115282356; 
 Fri, 30 Jun 2023 01:54:42 -0700 (PDT)
Received: from localhost ([159.226.94.115]) by smtp.gmail.com with ESMTPSA id
 g4-20020a170902868400b001b53953f314sm10350594plo.23.2023.06.30.01.54.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 30 Jun 2023 01:54:42 -0700 (PDT)
From: Hawkins Jiawei <yin31149@gmail.com>
To: jasowang@redhat.com,
	mst@redhat.com,
	eperezma@redhat.com
Cc: qemu-devel@nongnu.org,
	yin31149@gmail.com,
	18801353760@163.com
Subject: [PATCH v2 1/2] vdpa: delete duplicated VIRTIO_NET_F_RSS in
 vdpa_feature_bits
Date: Fri, 30 Jun 2023 16:54:35 +0800
Message-Id: <ee4b5afc22e3db57ba40781089cd84c4d00632b3.1688112025.git.yin31149@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1688112025.git.yin31149@gmail.com>
References: <cover.1688112025.git.yin31149@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::629;
 envelope-from=yin31149@gmail.com; helo=mail-pl1-x629.google.com
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

This entry was duplicated on referenced commit. Removing it.

Fixes: 402378407dbd ("vhost-vdpa: multiqueue support")
Signed-off-by: Hawkins Jiawei <yin31149@gmail.com>
---
 net/vhost-vdpa.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/net/vhost-vdpa.c b/net/vhost-vdpa.c
index e19ab063fa..0479988a79 100644
--- a/net/vhost-vdpa.c
+++ b/net/vhost-vdpa.c
@@ -74,7 +74,6 @@ const int vdpa_feature_bits[] = {
     VIRTIO_NET_F_CTRL_RX_EXTRA,
     VIRTIO_NET_F_CTRL_VLAN,
     VIRTIO_NET_F_CTRL_MAC_ADDR,
-    VIRTIO_NET_F_RSS,
     VIRTIO_NET_F_MQ,
     VIRTIO_NET_F_CTRL_VQ,
     VIRTIO_F_IOMMU_PLATFORM,
-- 
2.25.1



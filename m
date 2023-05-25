Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id F0A1C710CAA
	for <lists+qemu-devel@lfdr.de>; Thu, 25 May 2023 14:58:23 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q2AXc-0003dc-EI; Thu, 25 May 2023 08:58:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <viktor@daynix.com>) id 1q2AXY-0003d9-8B
 for qemu-devel@nongnu.org; Thu, 25 May 2023 08:58:00 -0400
Received: from mail-lf1-x12d.google.com ([2a00:1450:4864:20::12d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <viktor@daynix.com>) id 1q2AXW-0004oO-O2
 for qemu-devel@nongnu.org; Thu, 25 May 2023 08:58:00 -0400
Received: by mail-lf1-x12d.google.com with SMTP id
 2adb3069b0e04-4f4bd608cf4so2511299e87.1
 for <qemu-devel@nongnu.org>; Thu, 25 May 2023 05:57:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20221208.gappssmtp.com; s=20221208; t=1685019476; x=1687611476;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BYrWUYvAm6rLDqyDbruYNdZgW+c/CCYF4lxevzeCCew=;
 b=oeUmBEo2wQxh7AFs4XkLvtc1IDm+WOrlD2rYTvNv2Mwpmz1IRSFlPZSAlYZzelSAbm
 85zQdpX1zOH27jv+D4XjttQ3s+F8GMLCV3g+Skc7bXdTUPUvoIDr+2AMLA66N6R1RXFo
 2k+oVDiAGD8v1zajCsJvrC2SyP7W2U9lrRAq58gBKySKfoXFXfrH328xOBELLv6PrTVv
 ApzlIxRDlLTMOKlDQlf1VhLOLm1G3HYPM5cok1spUNm2z0R9sR1KXytToI0+jWmcBeCl
 xKcnrmV+sXu/0DlgzNZ+k2xJ4jrCvQEKolHW3X+agyyZ7ykDINXShtr6hU9kdmJmybLU
 /aNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685019476; x=1687611476;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=BYrWUYvAm6rLDqyDbruYNdZgW+c/CCYF4lxevzeCCew=;
 b=kaki3LzaUlpiLhOBrV4Uu9rEqAvEvmmz9yMO7KHa96s6+hHfV4GKD4T4UTmAxh0ZlI
 u4RrsR6gZyozWmyIssuGye5iP3Lu4LsL/8oNb1SLCkMEgVsM74xKFc17Y9UJm3zXVeOZ
 dG2pflqvWSU2LO6IHKFgpQpqpccu628KcLWuHSExJhDlSozVrBFeLq5hJntHTEvM+ZRy
 QiDV2q+0juPqk6tHLHs8aDrs/u0roT7WlQVAo/yz7uctF1x0AaY7i+6GZZKhx2hYNeeD
 BvBKpCWBCwPKhOv2s7JNcm9nUldxlLBbn+BzB7yaVcy7bj3T3WkvDjZqHuH6xY1VN7wj
 SWfg==
X-Gm-Message-State: AC+VfDxm8xINc6hzugvMUP0Ufy9CTX7QUhZ8ctQbqZVrVQhEsw+D/tuH
 VBzZT6VbVzTnrzUixkWxfiZSrA==
X-Google-Smtp-Source: ACHHUZ51YQDpolpalGY87jp+y58PUKTz6duUyYfZwdWYpqa2F+sdPIND6G1zj4j6FDYjEvMdCbYnEQ==
X-Received: by 2002:a05:6512:2186:b0:4ea:f526:5bef with SMTP id
 b6-20020a056512218600b004eaf5265befmr7375960lft.28.1685019476777; 
 Thu, 25 May 2023 05:57:56 -0700 (PDT)
Received: from localhost.Dlink ([94.188.60.65])
 by smtp.gmail.com with ESMTPSA id
 r9-20020ac25a49000000b004f1430ee142sm209509lfn.17.2023.05.25.05.57.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 25 May 2023 05:57:56 -0700 (PDT)
From: Viktor Prutyanov <viktor@daynix.com>
To: mst@redhat.com,
	jasowang@redhat.com
Cc: qemu-devel@nongnu.org, yan@daynix.com, yuri.benditovich@daynix.com,
 Viktor Prutyanov <viktor@daynix.com>
Subject: [PATCH v4 2/2] virtio-net: pass Device-TLB enable/disable events to
 vhost
Date: Thu, 25 May 2023 15:57:42 +0300
Message-Id: <20230525125742.4190-3-viktor@daynix.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20230525125742.4190-1-viktor@daynix.com>
References: <20230525125742.4190-1-viktor@daynix.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2a00:1450:4864:20::12d;
 envelope-from=viktor@daynix.com; helo=mail-lf1-x12d.google.com
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

If vhost is enabled for virtio-net, Device-TLB enable/disable events
must be passed to vhost for proper IOMMU unmap flag selection.

Signed-off-by: Viktor Prutyanov <viktor@daynix.com>
---
 hw/net/virtio-net.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c
index 6df6b7329d..30497c00b5 100644
--- a/hw/net/virtio-net.c
+++ b/hw/net/virtio-net.c
@@ -3951,6 +3951,7 @@ static void virtio_net_class_init(ObjectClass *klass, void *data)
     vdc->vmsd = &vmstate_virtio_net_device;
     vdc->primary_unplug_pending = primary_unplug_pending;
     vdc->get_vhost = virtio_net_get_vhost;
+    vdc->toggle_device_iotlb = vhost_toggle_device_iotlb;
 }
 
 static const TypeInfo virtio_net_info = {
-- 
2.21.0



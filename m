Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 37C3A7C995A
	for <lists+qemu-devel@lfdr.de>; Sun, 15 Oct 2023 16:08:23 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qs1it-00026P-Hy; Sun, 15 Oct 2023 10:04:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1qs1ir-00025J-KF
 for qemu-devel@nongnu.org; Sun, 15 Oct 2023 10:04:01 -0400
Received: from mail-pl1-x633.google.com ([2607:f8b0:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1qs1iq-0007nI-4X
 for qemu-devel@nongnu.org; Sun, 15 Oct 2023 10:04:01 -0400
Received: by mail-pl1-x633.google.com with SMTP id
 d9443c01a7336-1c9daca2b85so26369835ad.1
 for <qemu-devel@nongnu.org>; Sun, 15 Oct 2023 07:03:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1697378637; x=1697983437;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TpViEceVleCYIawlYscfsoVZkbkpKrR8cvlBByVpV28=;
 b=bJSWv2ZhmJPOcG+JZQS54CMSXYfeTi1Xl8x5Dk7S5XFS4XWZbeYj7BDFjRRepppgRf
 E5o7yV99oLBz7Ux716dONDpqiGpYmDXkf7T429YoaZdvYoMXvVptew0zu115Kckp04vY
 nfFqi+jzxDUX2FwXJTQOJEeiIOnvJPL/XBQh9WdMzrexwfp4mppWZyJ+of19M+GFAUjy
 fxnZsN7jjZccmr86QDOUWtWzH8Mi8fDV9/q8O744BLKEI4igIvZJFVu/EB4qFh+s0qzu
 QgXxtlTEEScm7N9EcztkwAN50UEXef6UDQ3ilARJZeniAKhXCStjqwxMWEdRlDHuQ6j7
 qVLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697378637; x=1697983437;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=TpViEceVleCYIawlYscfsoVZkbkpKrR8cvlBByVpV28=;
 b=eamDt051N/B/xqI8aPxxcTtHBQk1tICMJFPfhIYgb/DyZKhFTKcRP/lwt7AGNlzfxr
 EdPmhlB/TnsGwL/lRWCB3Z/zDeEpeDhIgwi+mrb77vBm9zNgJ1WFSL+PJO4JfIeD98qi
 Y4IhnOOyUB4m5Ztedn9qF71qP7ksVaPjOMbtEYDN5IpubUXuWVr7HdDZMGLc1sX/Lp6B
 q4K51gZbeCsilv14i/wRUAZ0KDR/RD53nkJivemPw//mOkJLXPjCg7hWyvEd2/C7//2I
 EG5PkpS5O9d3zVib9NBI7CPLVtW6aDQTMk6q0wxxgWAUKXwNCEJJjak13izMV6diI9+X
 6dsQ==
X-Gm-Message-State: AOJu0Yw36NkBGDfgAo5bkb9S1hUkllYWHvnMIfy/BK2tVBjVpQAOF0ui
 iou1lW0zF/w4XQ08gaHEKq8fkkBYYUSiSN0j+VQdwA==
X-Google-Smtp-Source: AGHT+IF2e4lJZOljLG6KMPrTxVfERZlQByqkZd3nqoWTbLZvE5uzAcaz2Cvbs5f2gbT+1nn5RiM9eA==
X-Received: by 2002:a17:902:d502:b0:1ca:42b:f625 with SMTP id
 b2-20020a170902d50200b001ca042bf625mr8801442plg.3.1697378637535; 
 Sun, 15 Oct 2023 07:03:57 -0700 (PDT)
Received: from localhost ([2400:4050:a840:1e00:78d2:b862:10a7:d486])
 by smtp.gmail.com with UTF8SMTPSA id
 d8-20020a170903230800b001b86dd825e7sm6851298plh.108.2023.10.15.07.03.55
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 15 Oct 2023 07:03:57 -0700 (PDT)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
To: 
Cc: qemu-devel@nongnu.org, Yuri Benditovich <yuri.benditovich@daynix.com>,
 Andrew Melnychenko <andrew@daynix.com>,
 "Michael S . Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Akihiko Odaki <akihiko.odaki@daynix.com>
Subject: [PATCH v4 14/20] virtio-net: Do not clear VIRTIO_NET_F_HASH_REPORT
Date: Sun, 15 Oct 2023 23:02:46 +0900
Message-ID: <20231015140259.259434-15-akihiko.odaki@daynix.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231015140259.259434-1-akihiko.odaki@daynix.com>
References: <20231015140259.259434-1-akihiko.odaki@daynix.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::633;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pl1-x633.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

virtio-net can report hash values even if the peer does not have a
virtio-net header.

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
---
 hw/net/virtio-net.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c
index 20df40442d..8865825362 100644
--- a/hw/net/virtio-net.c
+++ b/hw/net/virtio-net.c
@@ -763,8 +763,6 @@ static uint64_t virtio_net_get_features(VirtIODevice *vdev, uint64_t features,
         virtio_clear_feature(&features, VIRTIO_NET_F_GUEST_TSO4);
         virtio_clear_feature(&features, VIRTIO_NET_F_GUEST_TSO6);
         virtio_clear_feature(&features, VIRTIO_NET_F_GUEST_ECN);
-
-        virtio_clear_feature(&features, VIRTIO_NET_F_HASH_REPORT);
     }
 
     if (!peer_has_vnet_hdr(n) || !peer_has_ufo(n)) {
-- 
2.42.0



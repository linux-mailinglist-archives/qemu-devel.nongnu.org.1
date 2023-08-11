Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C132779319
	for <lists+qemu-devel@lfdr.de>; Fri, 11 Aug 2023 17:29:58 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qUU4l-0003NU-07; Fri, 11 Aug 2023 11:29:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yin31149@gmail.com>)
 id 1qUU4V-0003KH-7P
 for qemu-devel@nongnu.org; Fri, 11 Aug 2023 11:29:03 -0400
Received: from mail-pf1-x429.google.com ([2607:f8b0:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <yin31149@gmail.com>)
 id 1qUU4S-0001ZP-TU
 for qemu-devel@nongnu.org; Fri, 11 Aug 2023 11:29:02 -0400
Received: by mail-pf1-x429.google.com with SMTP id
 d2e1a72fcca58-686f38692b3so1911370b3a.2
 for <qemu-devel@nongnu.org>; Fri, 11 Aug 2023 08:28:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1691767738; x=1692372538;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=G4lniF7wupK5k//ouvNO3aQ67CFpv2Z9I/33Tzs/oFA=;
 b=Pd1st+bmw8V0466PJDx52eLUqJNwOe4O6Jm0gmdTOLoUkM2ClEp3wZKjBBJ4jhvZdq
 ghBncBUAzP2jQ7mLKk0doMtHei4Uwm4L266f3HgFMTHYuhGTKwOh9LSI8z0gYE9WPgba
 eAzK0zBYwAgHycb4shz3a9Eflmb8fTSxOQYoaA5JVBBskM2xBTbiWqKXZlgHC0hL64qs
 2UlGGVI8aFfn3QpvLQhyCIGggi/pWBL89WiPTeLjDVfp20Jvwtlj5wnC0VTUtNlpH6cA
 WnXJ4cMj2nOBLJxVRYfR/yOk1WiyqGsxN5ySnRPlLKUqpypu0AQYZkbYlm6p8rpk3BP2
 qTVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691767738; x=1692372538;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=G4lniF7wupK5k//ouvNO3aQ67CFpv2Z9I/33Tzs/oFA=;
 b=S0wVTz9HQDtiTGkgDz26H/udAy7yFZqNb0zDVI7/Z9Cc+yxEOYDKjBbiBz1gGUJXaS
 W7fJM9TcLG9nUAye51wGp+QbCj0W/EbPsDU8VLf/DiXB+XD9ZWye9687DYoDYe6/vXsI
 oKNlZvf9MXSkuhabUekDw5pLIcxeZE6UElSGQuK0IYuWfmJCQplXtKGBSrzlV//S4YAE
 PCIJzay8CpQmplColYPXhiNsu8TWoV3zg8Y9ipaVU5zYAnr6Kiij2KZQ4D2bqvpnFni+
 +kCERCDC5ovgCoCY9HoKKSwxXb6krpLPL3KVlVLaz2P5NBUJb/6piH9Q+7cKD8aO8PHC
 yRyg==
X-Gm-Message-State: AOJu0YyqDu7TSAXxNCaAmseGvruSo/8OP5Qt1sr+ReKPlWuheLC9eSKa
 AP3hmyvKOlOKZEOGdjlntdk=
X-Google-Smtp-Source: AGHT+IF1yKFCQ66/5JCBW2N6YYOz+612z0V8h1hg65m+Uh1pF3GURlJXWy5cHC4F46mirugZgLzAmw==
X-Received: by 2002:a05:6a00:1942:b0:682:2fea:39f0 with SMTP id
 s2-20020a056a00194200b006822fea39f0mr2964424pfk.5.1691767736368; 
 Fri, 11 Aug 2023 08:28:56 -0700 (PDT)
Received: from localhost ([183.242.254.166]) by smtp.gmail.com with ESMTPSA id
 a26-20020aa7865a000000b00663b712bfbdsm3452058pfo.57.2023.08.11.08.28.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 11 Aug 2023 08:28:56 -0700 (PDT)
From: Hawkins Jiawei <yin31149@gmail.com>
To: jasowang@redhat.com,
	mst@redhat.com,
	eperezma@redhat.com
Cc: qemu-devel@nongnu.org,
	yin31149@gmail.com,
	18801353760@163.com
Subject: [RFC PATCH 1/3] vdpa: Add SetSteeringEBPF method for NetClientState
Date: Fri, 11 Aug 2023 23:28:42 +0800
Message-Id: <d01d0de97688c5587935da753c63f0441808cb9d.1691766252.git.yin31149@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1691766252.git.yin31149@gmail.com>
References: <cover.1691766252.git.yin31149@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::429;
 envelope-from=yin31149@gmail.com; helo=mail-pf1-x429.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

At present, to enable the VIRTIO_NET_F_RSS feature, eBPF must
be loaded for the vhost backend.

Given that vhost-vdpa is one of the vhost backend, we need to
implement the SetSteeringEBPF method to support RSS for vhost-vdpa,
even if vhost-vdpa calculates the rss hash in the hardware device
instead of in the kernel by eBPF.

Although this requires QEMU to be compiled with `--enable-bpf`
configuration even if the vdpa device does not use eBPF to
calculate the rss hash, this can avoid adding the specific
conditional statements for vDPA case to enable the VIRTIO_NET_F_RSS
feature, which reduces code maintainbility.

Suggested-by: Eugenio Pérez <eperezma@redhat.com>
Signed-off-by: Hawkins Jiawei <yin31149@gmail.com>
---
 net/vhost-vdpa.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/net/vhost-vdpa.c b/net/vhost-vdpa.c
index a13b267250..4c8e4b19f6 100644
--- a/net/vhost-vdpa.c
+++ b/net/vhost-vdpa.c
@@ -238,6 +238,12 @@ static void vhost_vdpa_cleanup(NetClientState *nc)
     }
 }
 
+/** Dummy SetSteeringEBPF to support RSS for vhost-vdpa backend  */
+static bool vhost_vdpa_set_steering_ebpf(NetClientState *nc, int prog_fd)
+{
+    return true;
+}
+
 static bool vhost_vdpa_has_vnet_hdr(NetClientState *nc)
 {
     assert(nc->info->type == NET_CLIENT_DRIVER_VHOST_VDPA);
@@ -400,6 +406,7 @@ static NetClientInfo net_vhost_vdpa_info = {
         .has_vnet_hdr = vhost_vdpa_has_vnet_hdr,
         .has_ufo = vhost_vdpa_has_ufo,
         .check_peer_type = vhost_vdpa_check_peer_type,
+        .set_steering_ebpf = vhost_vdpa_set_steering_ebpf,
 };
 
 static int64_t vhost_vdpa_get_vring_group(int device_fd, unsigned vq_index,
@@ -1215,6 +1222,7 @@ static NetClientInfo net_vhost_vdpa_cvq_info = {
     .has_vnet_hdr = vhost_vdpa_has_vnet_hdr,
     .has_ufo = vhost_vdpa_has_ufo,
     .check_peer_type = vhost_vdpa_check_peer_type,
+    .set_steering_ebpf = vhost_vdpa_set_steering_ebpf,
 };
 
 /*
-- 
2.25.1



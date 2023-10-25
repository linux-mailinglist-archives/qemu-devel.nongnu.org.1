Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id EA1FD7D5F5A
	for <lists+qemu-devel@lfdr.de>; Wed, 25 Oct 2023 03:09:45 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qvSNm-0000Un-HV; Tue, 24 Oct 2023 21:08:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yin31149@gmail.com>)
 id 1qvSNk-0000Uc-Ib
 for qemu-devel@nongnu.org; Tue, 24 Oct 2023 21:08:24 -0400
Received: from mail-pj1-x102b.google.com ([2607:f8b0:4864:20::102b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <yin31149@gmail.com>)
 id 1qvSNi-0008HE-Lj
 for qemu-devel@nongnu.org; Tue, 24 Oct 2023 21:08:24 -0400
Received: by mail-pj1-x102b.google.com with SMTP id
 98e67ed59e1d1-27d45f5658fso4052462a91.3
 for <qemu-devel@nongnu.org>; Tue, 24 Oct 2023 18:08:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1698196101; x=1698800901; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XjAWBBVREFLGQjbMzAVjjp6ReJtDF1V6LPBKien9+Ys=;
 b=JOw0qGxUqAbpm2Aank4omBB1rcUkgMnFtc1iqjjJEqr406d1+P0l4L8t+bNccVctof
 rPEEqt0pNI7LjDlMo5Vw3byuBqyNjZaaQyA2YlBrgzGpNTuzbYOZwxrdYm3UzAe2gxbd
 GalTQQ1LRmvMsN+A3CEqLgQy5/riYcv+QvTIqvqKEjdy/lkdQycgQkQI0k5AArnq/hA3
 Rzkz/boFUIyNDGNElEYtozfo4Sygousml5mvt5STIFr34WJj9ZXNgTuHI5wqqmsxSxvC
 LaETvL2BkPqgkmv9B3GOM3BeWwiy1XARxs3X7OdsfZbiYDGJGz1sGEDw1sMoaynw5UR/
 2VWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698196101; x=1698800901;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=XjAWBBVREFLGQjbMzAVjjp6ReJtDF1V6LPBKien9+Ys=;
 b=LPITvGIMoP0u6unxiySXFXh/3mlYIjh4hIz98kb0ZRLPYxHMpezLX5AOgKFFzC9Kql
 bwmFtzK7iC7TMn//dYE81B9tWsQ0hLQLouHMhYUrnNcFv1TEP3p3is3L8O5BibuIoMXn
 WM73NdTw7idYoQGNQkCt2u1Abor3SNDZckOIEc1qz//89mVAnmIzg2QZoKQKcs6tTsBR
 MM8U1CSJFqIOo4/aQQhBfjBVIvJz+BEXHjYPfoclIaJ1Qe0+pEZ+HoSdFjPn9B6nxcbw
 XT8KL3yDOhbR3rDiZEllgwn1WQUduKXdFb6lDWkIoOQfvzwPqXI8VuKcHEs4JWd9Ekdf
 Piyg==
X-Gm-Message-State: AOJu0YxTMzTmUbUHH5Es1XhK0JE+N8t2xey9MEyUQIO+oVldon3PJaqw
 jHfL2YZOVnZuj7zytjTjn7M=
X-Google-Smtp-Source: AGHT+IFykQg0tQjXj5dEnPo9bPZiA1Qyp7NbFQe4sbkEHYjjkdNbM1Q+i3WaBatvUWps1B6xNYN05w==
X-Received: by 2002:a17:90a:c202:b0:27d:af3:f15d with SMTP id
 e2-20020a17090ac20200b0027d0af3f15dmr12926771pjt.4.1698196100908; 
 Tue, 24 Oct 2023 18:08:20 -0700 (PDT)
Received: from localhost ([183.242.254.166]) by smtp.gmail.com with ESMTPSA id
 cx3-20020a17090afd8300b0027d1366d113sm9071899pjb.43.2023.10.24.18.08.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Oct 2023 18:08:20 -0700 (PDT)
From: Hawkins Jiawei <yin31149@gmail.com>
To: jasowang@redhat.com,
	mst@redhat.com,
	eperezma@redhat.com
Cc: qemu-devel@nongnu.org,
	yin31149@gmail.com,
	18801353760@163.com
Subject: [PATCH v5 1/3] vdpa: Add SetSteeringEBPF method for NetClientState
Date: Wed, 25 Oct 2023 09:08:04 +0800
Message-Id: <280e20ddce55b6de60f1552ba0865bffffe909b2.1698195059.git.yin31149@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1698195059.git.yin31149@gmail.com>
References: <cover.1698195059.git.yin31149@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102b;
 envelope-from=yin31149@gmail.com; helo=mail-pj1-x102b.google.com
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
v5:
  - no changes

v4: https://lore.kernel.org/all/1c6faf4c5c3304c0bf14929143ccedb2e90dbcb2.1697904740.git.yin31149@gmail.com/
  - no code changes

v3: https://lore.kernel.org/all/30509e3c3b07bcadd95d5932aeb16820cb022902.1693299194.git.yin31149@gmail.com/

 net/vhost-vdpa.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/net/vhost-vdpa.c b/net/vhost-vdpa.c
index 54f748d49d..3466936b87 100644
--- a/net/vhost-vdpa.c
+++ b/net/vhost-vdpa.c
@@ -241,6 +241,12 @@ static void vhost_vdpa_cleanup(NetClientState *nc)
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
@@ -423,6 +429,7 @@ static NetClientInfo net_vhost_vdpa_info = {
         .has_vnet_hdr = vhost_vdpa_has_vnet_hdr,
         .has_ufo = vhost_vdpa_has_ufo,
         .check_peer_type = vhost_vdpa_check_peer_type,
+        .set_steering_ebpf = vhost_vdpa_set_steering_ebpf,
 };
 
 static int64_t vhost_vdpa_get_vring_group(int device_fd, unsigned vq_index,
@@ -1258,6 +1265,7 @@ static NetClientInfo net_vhost_vdpa_cvq_info = {
     .has_vnet_hdr = vhost_vdpa_has_vnet_hdr,
     .has_ufo = vhost_vdpa_has_ufo,
     .check_peer_type = vhost_vdpa_check_peer_type,
+    .set_steering_ebpf = vhost_vdpa_set_steering_ebpf,
 };
 
 /*
-- 
2.25.1



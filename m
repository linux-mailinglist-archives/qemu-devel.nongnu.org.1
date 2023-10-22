Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BCAE7D20BE
	for <lists+qemu-devel@lfdr.de>; Sun, 22 Oct 2023 04:18:06 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1quO12-0005pt-6P; Sat, 21 Oct 2023 22:16:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yin31149@gmail.com>)
 id 1quO0z-0005pW-O4
 for qemu-devel@nongnu.org; Sat, 21 Oct 2023 22:16:29 -0400
Received: from mail-oo1-xc2d.google.com ([2607:f8b0:4864:20::c2d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <yin31149@gmail.com>)
 id 1quO0y-0003LN-4A
 for qemu-devel@nongnu.org; Sat, 21 Oct 2023 22:16:29 -0400
Received: by mail-oo1-xc2d.google.com with SMTP id
 006d021491bc7-5842c251d7cso953776eaf.1
 for <qemu-devel@nongnu.org>; Sat, 21 Oct 2023 19:16:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1697940987; x=1698545787; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lNMeJcS2Kg4+RYFG13jdQCpQGp48YyyVDQuK8zzi30o=;
 b=i1LOWPEwnpruTW2G09sDMVf/3rmjZTyiiPvP6I/aRHovpW5t07OMKZzprzmZh39x3I
 86b8C69FBXpQLTBSAJ6WNMQz+K5YNVnqM+OqYYUuq9fjQS/o+MuiZbcz4nDdsK2pt9bt
 V3/RIKZJbtpPD/bHykDwByTKKgJRMyLKLL7vez/oF5Lv7VUlNeYy2z0iVtYgj9h6+2Nh
 biC8kXSLzIvEy4FgzvapLf+71eYlO0HeXLenc/CawA0if5fVyZ1UHvuUAR2qvYv45gkS
 TGlkq+9gXRg5adLi2SO78ZHf6FrtlIoeBSkvCHEkJ4AqDYsz5otDarlPYlaJ+RPpN4Zb
 yV+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697940987; x=1698545787;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=lNMeJcS2Kg4+RYFG13jdQCpQGp48YyyVDQuK8zzi30o=;
 b=EUbT51Wl0iTgE5Z4YOo5Gmk+waeOFtolkmySEEeu9e9Q15qazgNOahoa9ADbm1zn5v
 0MXs8xGOaIL4NLfHbKUJeAg7D10dKqW1EHbKuxFTAA+c5cHl9Zoab27QVX3KQsM6O8uG
 fWmHmGMSBnDYy1MmhMid6yE8vUuTYwfw7pWZEFK+IDdgEzM0vz6vVGZqkQcrECI4fvur
 witClmofWbbM9yZtwLLENf+d/PWBmd7EfaIVyMijWn4wF7DNUF3ApdcS6NpzFFHOt1C0
 eZZJWZSDSi0gHOGQSMe8CgTPsK+zcvtvieqZaWlUM4ao6oBff5/6NmYe+uOTlESnm7w2
 nL4w==
X-Gm-Message-State: AOJu0Yyv9IRS/1upZ2iqOm02RJkzIYrOycPeJZYk1VLZVLDAL9XGgIln
 OdZBq+/ysaMUYlF6WQO6KdA=
X-Google-Smtp-Source: AGHT+IF8i1FaNMKZpijF5YwCZRLaBI6yCJfsNUL1e3KAmBM7Yv9H5cNvODw0QsLyRaCKidJLcCT1fA==
X-Received: by 2002:a05:6358:9146:b0:140:f6ab:b11e with SMTP id
 r6-20020a056358914600b00140f6abb11emr6962920rwr.28.1697940986596; 
 Sat, 21 Oct 2023 19:16:26 -0700 (PDT)
Received: from localhost ([124.64.17.222]) by smtp.gmail.com with ESMTPSA id
 f23-20020aa79697000000b0068fb783d0c6sm3968457pfk.141.2023.10.21.19.16.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 21 Oct 2023 19:16:26 -0700 (PDT)
From: Hawkins Jiawei <yin31149@gmail.com>
To: jasowang@redhat.com,
	mst@redhat.com,
	eperezma@redhat.com
Cc: qemu-devel@nongnu.org,
	yin31149@gmail.com,
	18801353760@163.com
Subject: [PATCH v4 1/3] vdpa: Add SetSteeringEBPF method for NetClientState
Date: Sun, 22 Oct 2023 10:16:15 +0800
Message-Id: <1c6faf4c5c3304c0bf14929143ccedb2e90dbcb2.1697904740.git.yin31149@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1697904740.git.yin31149@gmail.com>
References: <cover.1697904740.git.yin31149@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::c2d;
 envelope-from=yin31149@gmail.com; helo=mail-oo1-xc2d.google.com
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
v4: no code changes

v3: https://lore.kernel.org/all/30509e3c3b07bcadd95d5932aeb16820cb022902.1693299194.git.yin31149@gmail.com/

 net/vhost-vdpa.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/net/vhost-vdpa.c b/net/vhost-vdpa.c
index 4c65c53fd2..c4b89f5119 100644
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
@@ -422,6 +428,7 @@ static NetClientInfo net_vhost_vdpa_info = {
         .has_vnet_hdr = vhost_vdpa_has_vnet_hdr,
         .has_ufo = vhost_vdpa_has_ufo,
         .check_peer_type = vhost_vdpa_check_peer_type,
+        .set_steering_ebpf = vhost_vdpa_set_steering_ebpf,
 };
 
 static int64_t vhost_vdpa_get_vring_group(int device_fd, unsigned vq_index,
@@ -1255,6 +1262,7 @@ static NetClientInfo net_vhost_vdpa_cvq_info = {
     .has_vnet_hdr = vhost_vdpa_has_vnet_hdr,
     .has_ufo = vhost_vdpa_has_ufo,
     .check_peer_type = vhost_vdpa_check_peer_type,
+    .set_steering_ebpf = vhost_vdpa_set_steering_ebpf,
 };
 
 /*
-- 
2.25.1



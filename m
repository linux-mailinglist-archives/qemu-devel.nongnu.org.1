Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BD6A77A646
	for <lists+qemu-devel@lfdr.de>; Sun, 13 Aug 2023 14:03:21 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qV9nO-0002ck-Ia; Sun, 13 Aug 2023 08:02:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yin31149@gmail.com>)
 id 1qV9nI-0002a4-U9
 for qemu-devel@nongnu.org; Sun, 13 Aug 2023 08:02:05 -0400
Received: from mail-pf1-x42e.google.com ([2607:f8b0:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <yin31149@gmail.com>)
 id 1qV9nH-0007yo-2O
 for qemu-devel@nongnu.org; Sun, 13 Aug 2023 08:02:04 -0400
Received: by mail-pf1-x42e.google.com with SMTP id
 d2e1a72fcca58-686ea67195dso2305763b3a.2
 for <qemu-devel@nongnu.org>; Sun, 13 Aug 2023 05:02:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1691928120; x=1692532920;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=G4lniF7wupK5k//ouvNO3aQ67CFpv2Z9I/33Tzs/oFA=;
 b=KapLnZ9p4wHMh3MWr5AZoUhy7//gAuBZo7fVv3YTiMAXxcAIRkUaa+20K806RWA/tX
 ryiSn+X2H5+4j6umZXbVIy8zsD/qmnUHmjKKHY9pfzpoEGqSLFQq6pTxTQSfW0qJDyp5
 yzhtFxtu/zbFHevOq5Orj3pQhKCTuyhxQDPvnF8JlxAEeE0yom6yStFZw1DwDhBZfLDI
 2ek7AwBky/e88Eb/cCcwm0KTZ/YDXuVkiqFtclh/e9OJbtJOJK+uHqxWYF7MSeQNvcnx
 47zTDbawR8gBqVIv+orVI30yRwNUZMjTvkFOry1FnrvHfQNCyfqWcWyrOMyr/f+K6ORS
 0ZZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691928120; x=1692532920;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=G4lniF7wupK5k//ouvNO3aQ67CFpv2Z9I/33Tzs/oFA=;
 b=L6FWuoXU9B8GVd0wx9JwzJsgju4pOc27g+8XzfovIFJt4ONtaU83k8s37pNLsz3Y10
 8jyso9q7E5gbmy8O0dAb3PfNB98N7ll3m4bKiuzvx/PNZDfLfwad4hdPSn8obGqL19HX
 FEUD0Kws2/b29mfQiKklrhS9Vrw+ctWnRBAjG87uxxUDgE1ks8cJV3uTqrTiap/2yRkQ
 BVz+J858tF+gEzS0tF0G3orV1QDN0gDPfXWSk7HGT1o/X9PcIoCA4J6z7211+g+P7eHw
 9N/SoBnCQgWGYx8YwFMHEbtgTYqIIJUyHVwQVlB9gb93gHTMjWFNO1inTQYxti21aZoU
 XcDw==
X-Gm-Message-State: AOJu0YyV9cSWUQnIy+yjDWnD87a2J1clULiDTF9lZb1q9nl/Af8yLq26
 ZRKSl13z9++/TM65ga6TBxo=
X-Google-Smtp-Source: AGHT+IG6/43sMuBsPsZLmiEyzKUJF9VQFFru69RinX7nkpYkqdQJMBj42WytD2dyZ7gEKN3ZfogAEA==
X-Received: by 2002:a05:6a00:855:b0:687:189c:4e26 with SMTP id
 q21-20020a056a00085500b00687189c4e26mr7355587pfk.2.1691928119742; 
 Sun, 13 Aug 2023 05:01:59 -0700 (PDT)
Received: from localhost ([125.35.86.198]) by smtp.gmail.com with ESMTPSA id
 z3-20020aa785c3000000b0066a613c4a58sm6148033pfn.102.2023.08.13.05.01.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 13 Aug 2023 05:01:59 -0700 (PDT)
From: Hawkins Jiawei <yin31149@gmail.com>
To: jasowang@redhat.com,
	mst@redhat.com,
	eperezma@redhat.com
Cc: qemu-devel@nongnu.org,
	yin31149@gmail.com,
	18801353760@163.com
Subject: [RFC PATCH v2 1/3] vdpa: Add SetSteeringEBPF method for NetClientState
Date: Sun, 13 Aug 2023 20:01:52 +0800
Message-Id: <d01d0de97688c5587935da753c63f0441808cb9d.1691926415.git.yin31149@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1691926415.git.yin31149@gmail.com>
References: <cover.1691926415.git.yin31149@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42e;
 envelope-from=yin31149@gmail.com; helo=mail-pf1-x42e.google.com
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



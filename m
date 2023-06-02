Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 424C77200EB
	for <lists+qemu-devel@lfdr.de>; Fri,  2 Jun 2023 13:53:31 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q53Kg-0008Jy-OL; Fri, 02 Jun 2023 07:52:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yin31149@gmail.com>)
 id 1q53Kf-0008Jn-7D
 for qemu-devel@nongnu.org; Fri, 02 Jun 2023 07:52:37 -0400
Received: from mail-pl1-x636.google.com ([2607:f8b0:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <yin31149@gmail.com>)
 id 1q53Kd-0007GX-ME
 for qemu-devel@nongnu.org; Fri, 02 Jun 2023 07:52:36 -0400
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-1b026657a6fso17264905ad.0
 for <qemu-devel@nongnu.org>; Fri, 02 Jun 2023 04:52:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1685706754; x=1688298754;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=VAms4dm3KCeYAKXoZpA5YggmskcWUP006Xt8FZqxidk=;
 b=S/qkFZYC2wSNSt+GCcqvwdxlG8IA+7ME0ZRyaJ5cNN4nTdniALxHFilkPiiQHaXCPg
 6j2KRa+LQdCgh+kFVRf3Ny8j2HDKgrBxZD0FxeeQzbhxQPed80Q03BhaJWrIVEcDlHlE
 cYvrrMV6tk0KCVKQZsXbyAJIcb2w2TliZy50qZWpY1IA8la7xVKRB52LsytX85QnYoBD
 Cg1mPzDamleiEiC3hXl+a1q9jNPwAUQiawzlw6M+uYbGvzHYZfEzkYBHMMjN887Zg6Ze
 X0PdGcfpUhpv09SZDMSQy1kgb9DRWR/X5xHxFhy+Lr1kCoS2v7duQE5pWVNSVUNpOa64
 QIaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685706754; x=1688298754;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=VAms4dm3KCeYAKXoZpA5YggmskcWUP006Xt8FZqxidk=;
 b=DGCmpmLC3tpEVbkAFE7MiE4wtJr55QxPK00oSUgaKNq782iUCXmNiMm+4X/700Dx79
 l1idD53wjxzZCnQ9tHacyu78sZeoSOumW7JxvW0wp3I+IswdgbeUKQ192kv0HGWPoWLz
 Zu7ATT3u+oWmYAX5t91aPRoMmuyuU+nNLswIBlg7v/oz6jYp6H9Fi21Fa2CieOh3uyOO
 Eu7iG7eYFplIt59RcAekuGaRpC7snDPGcdprUhbYvKxt/Jcw0uMvuLRPI7bir+X+KCLF
 Ue1XTFuhsttKVmT4NaF9QL+lw28Q2PlIIxvioRbzka7P6p7LnsGOIqeOXDx6qIRK6IEK
 nmww==
X-Gm-Message-State: AC+VfDzsu7pL2oxbWa+r5U5DbnW6ZMPA8PkOPtX4z5ll75DXQJQ2fboT
 Eu2kDJvSQDyNh/kN9upk7kU=
X-Google-Smtp-Source: ACHHUZ4eLUD4sr+T1pioYM4U0o4IYg4bJfsIArHF3+eFF8gN1qvX/RF4qjqbsj+RRC+/kvD4IDAvPw==
X-Received: by 2002:a17:902:f7d4:b0:1b0:2f15:e0b3 with SMTP id
 h20-20020a170902f7d400b001b02f15e0b3mr2096535plw.50.1685706754276; 
 Fri, 02 Jun 2023 04:52:34 -0700 (PDT)
Received: from localhost ([159.226.94.115]) by smtp.gmail.com with ESMTPSA id
 n13-20020a170902e54d00b001ae4d4d2676sm1163536plf.269.2023.06.02.04.52.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 02 Jun 2023 04:52:33 -0700 (PDT)
From: Hawkins Jiawei <yin31149@gmail.com>
To: jasowang@redhat.com,
	mst@redhat.com,
	eperezma@redhat.com
Cc: qemu-devel@nongnu.org,
	yin31149@gmail.com,
	18801353760@163.com
Subject: [PATCH v4 4/6] virtio-net: expose
 virtio_net_supported_guest_offloads()
Date: Fri,  2 Jun 2023 19:52:16 +0800
Message-Id: <43679506f3f039a7aa2bdd5b49785107b5dfd7d4.1685704856.git.yin31149@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1685704856.git.yin31149@gmail.com>
References: <cover.1685704856.git.yin31149@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::636;
 envelope-from=yin31149@gmail.com; helo=mail-pl1-x636.google.com
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

To support restoring offloads state in vdpa, it is necessary to
expose the function virtio_net_supported_guest_offloads().

According to VirtIO standard, "Upon feature negotiation
corresponding offload gets enabled to preserve backward compatibility.".
Therefore, QEMU uses this function to get the device supported offloads.
This allows QEMU to know the device's defaults and skip the control
message sending if these defaults align with the driver's configuration.

Note that the device's defaults can mismatch the driver's configuration
only at live migration.

Signed-off-by: Hawkins Jiawei <yin31149@gmail.com>
---
 hw/net/virtio-net.c            | 2 +-
 include/hw/virtio/virtio-net.h | 1 +
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c
index 7b27dad6c4..7e8897a8bc 100644
--- a/hw/net/virtio-net.c
+++ b/hw/net/virtio-net.c
@@ -874,7 +874,7 @@ static uint64_t virtio_net_guest_offloads_by_features(uint32_t features)
     return guest_offloads_mask & features;
 }
 
-static inline uint64_t virtio_net_supported_guest_offloads(const VirtIONet *n)
+uint64_t virtio_net_supported_guest_offloads(const VirtIONet *n)
 {
     VirtIODevice *vdev = VIRTIO_DEVICE(n);
     return virtio_net_guest_offloads_by_features(vdev->guest_features);
diff --git a/include/hw/virtio/virtio-net.h b/include/hw/virtio/virtio-net.h
index ef234ffe7e..5f5dcb4572 100644
--- a/include/hw/virtio/virtio-net.h
+++ b/include/hw/virtio/virtio-net.h
@@ -227,5 +227,6 @@ size_t virtio_net_handle_ctrl_iov(VirtIODevice *vdev,
                                   unsigned out_num);
 void virtio_net_set_netclient_name(VirtIONet *n, const char *name,
                                    const char *type);
+uint64_t virtio_net_supported_guest_offloads(const VirtIONet *n);
 
 #endif
-- 
2.25.1



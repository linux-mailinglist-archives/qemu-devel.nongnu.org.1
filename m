Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 585AC719ECE
	for <lists+qemu-devel@lfdr.de>; Thu,  1 Jun 2023 15:50:14 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q4igd-0007Om-9v; Thu, 01 Jun 2023 09:49:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yin31149@gmail.com>)
 id 1q4igY-0006nx-CF
 for qemu-devel@nongnu.org; Thu, 01 Jun 2023 09:49:50 -0400
Received: from mail-pf1-x42e.google.com ([2607:f8b0:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <yin31149@gmail.com>)
 id 1q4igV-0000VB-1e
 for qemu-devel@nongnu.org; Thu, 01 Jun 2023 09:49:50 -0400
Received: by mail-pf1-x42e.google.com with SMTP id
 d2e1a72fcca58-64d3578c25bso1065599b3a.3
 for <qemu-devel@nongnu.org>; Thu, 01 Jun 2023 06:49:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1685627385; x=1688219385;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=W8L7vEWnN/xHIgbzYUYpFswIiZV89v/BuVnxEb7tavI=;
 b=aWvviQfLmQj609GAVqZNZrhuUifqG7NTDchKgqSQx4oPc3B/7d/suR9VMoDdhBZtfD
 WdmTNZDbiP01Vr8DvBE4dyOpd7emkF1s7bcxTFgitJ9LNhoioAuN8oxg4HPTN64zvmzt
 8Hr6mAZSrXuXnRHCX/3vSudvoHQIb3KghbegFcqgstrXmIqJauG1MrlcieNd9dxWwFp1
 Fz4/BSqarROLBnOhekBDdQbHfF7oq9X+8XvvUf9k/ds7Oz0yEkZ/P70E1xtLPZILYpEG
 CB2+Et1DiYGG/Po7KC2r5pVznCblb1dK8mHXB0LGUMRP71+l+xzCHb4t7YvdXe2Lq2k/
 TtyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685627385; x=1688219385;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=W8L7vEWnN/xHIgbzYUYpFswIiZV89v/BuVnxEb7tavI=;
 b=T4+nXKZ6248js/ghVzGpNO99bmSfse4CqrJUtss1ahzTehz2fOlNwvX9eCmBh6btVZ
 arble6E00E/Bp5U5K/68iK16W7tEZQr2HOW/R2WCrjbJmuQFeWPftjvDLGtMmR9Ju7g2
 nfep6X4zL2zrK2i/x0ap5rN1nfIwlytBlncgZD9Bow42TONFbP2T4SoGwpscTyyJ4l2z
 Gg19OHNQt5xbEvXNovLbV7VWVsK9cb4F/gXU9rUl5RBOf2YSiffCEZFa9Z0RMr5va1GK
 aSNwfZoe8sp7JSMcjxgyDfrMcVduEvYU++iurkQ/KKrVQeukHvDRIvVxVE8mIdwTLHFP
 bC6g==
X-Gm-Message-State: AC+VfDz5dG/NWFMKsyR4Nb13gXMcXWAtCt0BiBDwQKyB6xSV/J2f0TkK
 c0O3iLwIUThy9D5Dv4gi2q6omFqIMGhBd4b0
X-Google-Smtp-Source: ACHHUZ4drAmxffnzCSi4IF1sgVrFPQI5WFPNbgqCx+fcYN6RdhbjWCMr28yZdcJPo/Re5pvbPrr+5A==
X-Received: by 2002:a05:6a20:9f45:b0:10b:91c5:45b5 with SMTP id
 ml5-20020a056a209f4500b0010b91c545b5mr9381515pzb.31.1685627385449; 
 Thu, 01 Jun 2023 06:49:45 -0700 (PDT)
Received: from localhost ([159.226.94.115]) by smtp.gmail.com with ESMTPSA id
 m15-20020aa7900f000000b0064d59e194b3sm5068480pfo.113.2023.06.01.06.49.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 01 Jun 2023 06:49:45 -0700 (PDT)
From: Hawkins Jiawei <yin31149@gmail.com>
To: jasowang@redhat.com,
	mst@redhat.com,
	eperezma@redhat.com
Cc: qemu-devel@nongnu.org,
	yin31149@gmail.com,
	18801353760@163.com
Subject: [PATCH v3 4/6] virtio-net: expose
 virtio_net_supported_guest_offloads()
Date: Thu,  1 Jun 2023 21:48:23 +0800
Message-Id: <68226edccea8d6e51ea3f2da26d5ff2da2abc224.1685623090.git.yin31149@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1685623090.git.yin31149@gmail.com>
References: <cover.1685623090.git.yin31149@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42e;
 envelope-from=yin31149@gmail.com; helo=mail-pf1-x42e.google.com
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

To support restoring offloads state in vdpa, need to expose
the function virtio_net_supported_guest_offloads().
QEMU uses this function to get the guest supported offloads
and no needs to send the corresponding CVQ command if guest
enables all supported features.

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



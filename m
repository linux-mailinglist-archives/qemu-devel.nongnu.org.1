Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5267E77935B
	for <lists+qemu-devel@lfdr.de>; Fri, 11 Aug 2023 17:41:07 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qUUEr-0007CG-Gj; Fri, 11 Aug 2023 11:39:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yin31149@gmail.com>)
 id 1qUUEp-0007C7-Nv
 for qemu-devel@nongnu.org; Fri, 11 Aug 2023 11:39:43 -0400
Received: from mail-pl1-x62f.google.com ([2607:f8b0:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <yin31149@gmail.com>)
 id 1qUUEo-0003W5-Ay
 for qemu-devel@nongnu.org; Fri, 11 Aug 2023 11:39:43 -0400
Received: by mail-pl1-x62f.google.com with SMTP id
 d9443c01a7336-1bc6bfc4b58so16001035ad.1
 for <qemu-devel@nongnu.org>; Fri, 11 Aug 2023 08:39:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1691768381; x=1692373181;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HAYMZxiuocM/qa+y0eR2PNQMALi+Ew2Zz3fzz/azwgs=;
 b=k6iuu1+i9BYYlEvVPoFpFcwlZ8P0/K9pjbmOqkp9POA3kiRGPRODXro9VPhqUlyIyi
 Hqb4BtlI4BFtibxtWtJFN+ZmuYZPc+tbgzUw8UHB6LhOGDWmH4qTXep7amBMaF29dXL2
 86MhHSMastNokkBfihgBQLFJdP1EtxFi0IWEmnckD/VC7CmJUTeneDGq6nvgr12KN6dG
 l5UAzUNuLzga7m7U6zY7fSg37/ZBSnvWONCjGU1N+wxIeZV3wnb9zBSUyorWx4YHLMO1
 OJ+TGfx4LyCOVsuD4uURKK1UbucoaF0vv6/7wlzjR63ZNaSqat2KowxL2ESrzxbnMJQH
 oMwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691768381; x=1692373181;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=HAYMZxiuocM/qa+y0eR2PNQMALi+Ew2Zz3fzz/azwgs=;
 b=A5J7yeM6GKJXw19EcE1uKv+dnOR1ooon+FkFpCPCSaIirvWyc6Jv+QgoWiUhEl1AY1
 OIF4LygCUct0mIwHqgb+6Wn7DmquPxVNyGHRO4A0uQAk/X1cUEFrCl7uQaC8kYIwPx1B
 8d8ddtkBhGqDPW7awwkU7ZgQOVpGyFWpv4IgwzQJYicE3EwMhOP6ZlVpyatSayyMbRiU
 lUtxrT/PV1zRF7RI7ic9GZnlyg6KQC5G6GZS9Y93Ikq/vX+cQyUDUGifsOUjEqIBYWvC
 uwfO9rGfR+mxSv/LKYCb/0EcGhD1XmiIHvKsRJXSdOl3BIuiFtlqMg2xj1RzUdjIVG0U
 4EEw==
X-Gm-Message-State: AOJu0Yzi1PRvbVoyXUxTvbUuAlE4nzzii6xhbMDn18UCzxOgdXmiWfrF
 y7oEu0GLZE5NLPFLz3vOGFI=
X-Google-Smtp-Source: AGHT+IHdaajXZ7jQ8rnRhRl8EmPZdDrHPGAZtZXX2zIOdT8B3j31OAyKkhNhVO9FU87OCD75gc0o3g==
X-Received: by 2002:a17:902:f68f:b0:1bc:25ed:374 with SMTP id
 l15-20020a170902f68f00b001bc25ed0374mr2493093plg.49.1691768380573; 
 Fri, 11 Aug 2023 08:39:40 -0700 (PDT)
Received: from localhost ([183.242.254.166]) by smtp.gmail.com with ESMTPSA id
 p4-20020a170902a40400b001bba1475c92sm4064123plq.113.2023.08.11.08.39.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 11 Aug 2023 08:39:40 -0700 (PDT)
From: Hawkins Jiawei <yin31149@gmail.com>
To: jasowang@redhat.com,
	mst@redhat.com,
	eperezma@redhat.com
Cc: qemu-devel@nongnu.org,
	yin31149@gmail.com,
	18801353760@163.com
Subject: [RFC PATCH 3/3] vdpa: Allow VIRTIO_NET_F_RSS in SVQ
Date: Fri, 11 Aug 2023 23:39:35 +0800
Message-Id: <04fb03443e149871508dc9510897ce52d272b86c.1691766252.git.yin31149@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1691766252.git.yin31149@gmail.com>
References: <cover.1691766252.git.yin31149@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62f;
 envelope-from=yin31149@gmail.com; helo=mail-pl1-x62f.google.com
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

Enable SVQ with VIRTIO_NET_F_RSS feature.

Signed-off-by: Hawkins Jiawei <yin31149@gmail.com>
---
 net/vhost-vdpa.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/vhost-vdpa.c b/net/vhost-vdpa.c
index 7870cbe142..eb08530396 100644
--- a/net/vhost-vdpa.c
+++ b/net/vhost-vdpa.c
@@ -119,6 +119,7 @@ static const uint64_t vdpa_svq_device_features =
     /* VHOST_F_LOG_ALL is exposed by SVQ */
     BIT_ULL(VHOST_F_LOG_ALL) |
     BIT_ULL(VIRTIO_NET_F_HASH_REPORT) |
+    BIT_ULL(VIRTIO_NET_F_RSS) |
     BIT_ULL(VIRTIO_NET_F_RSC_EXT) |
     BIT_ULL(VIRTIO_NET_F_STANDBY) |
     BIT_ULL(VIRTIO_NET_F_SPEED_DUPLEX);
-- 
2.25.1



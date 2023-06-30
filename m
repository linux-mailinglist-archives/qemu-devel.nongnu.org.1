Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E7839743CAD
	for <lists+qemu-devel@lfdr.de>; Fri, 30 Jun 2023 15:24:06 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qFE5N-0008Ue-Vd; Fri, 30 Jun 2023 09:22:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yin31149@gmail.com>)
 id 1qFE5E-0008EY-JI
 for qemu-devel@nongnu.org; Fri, 30 Jun 2023 09:22:44 -0400
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <yin31149@gmail.com>)
 id 1qFE5D-0003Xg-3m
 for qemu-devel@nongnu.org; Fri, 30 Jun 2023 09:22:44 -0400
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-1b80f2e6c17so14713475ad.0
 for <qemu-devel@nongnu.org>; Fri, 30 Jun 2023 06:22:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1688131361; x=1690723361;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HcTU09zHacJzqY8cxed6By7840AcNU8mdxoTHCEcPGY=;
 b=Pz5n5txJo9pA3Oc7aIdVmioMuEfsXfkQozlvnK/KUBqfzMbwc2hBqLthliWr8k+5vv
 4Tr+B1o7MGO9weZC0VXU1hbZd5OjYKdxLnFRTSkkNTlDsN6NfpEkspYxtfl6UnKIXkiw
 GifkEueU6M9vpMdOuNlIfUWYzaxbDpVTLQwkOLaXTfEzjECtKpDsBFzYwS3LU7cUSQ4P
 ePpcdVZ7k79T66R6i2P1OQ+ZWamxWnP+FgVIzykJgxUgtkZodao37Vvl5q1THesIN/F6
 QUJvVbGw6OiNDJaGhWvzD01X2eFOYO2gkdeuVlD5kE9K7DgN/6CiiWVj+FqwrMcz5LJd
 uwEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688131361; x=1690723361;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=HcTU09zHacJzqY8cxed6By7840AcNU8mdxoTHCEcPGY=;
 b=YcbdUy0rthl3r/Z4dCIKjVUr/bwvWnbo3Lp7e1JwuyCGA+kNP/f4+hIYY4inZ/uokU
 SkFNMBB84gzcuu4SNib9iayNXh8nje5K2hkOlLlQ4jDjk6LS1eDmkDExouzQVzvjk0o3
 Qjzma0OvFXwcd2iZKwj/n0iliymi9u/ES0icxjJ8qDcSwDrcLAwI460+0lgQEpYyOYgg
 VEK8Q15xUcVoiKSAvlh2ET7imO5INvkIDMGzDP7bR7YLJH1Vuvi/x6mT1Q6koy4nTaEn
 GStxQioaacsT0Q1A+8DwiVSQO8yVm0jWBrPoe2spl0C4F3RqU8bDZ0BEYa2w1mki8Fcu
 2NNA==
X-Gm-Message-State: ABy/qLZx3UJgErYdGCLipvL9l3wTHIeRuxl/mA/JUaUnMW3NEnUN8TdE
 g+bu0vM3dd2KDiADbta0t8c=
X-Google-Smtp-Source: APBJJlG3Jb3ZOJokBpZpa05cXJTf0kjVbVdFdKNf7MMspZ4hou6W2m2Ls3JldMhmDYazdhFlQBgjtg==
X-Received: by 2002:a17:902:e5c3:b0:1af:a4f0:bce2 with SMTP id
 u3-20020a170902e5c300b001afa4f0bce2mr2550592plf.20.1688131360734; 
 Fri, 30 Jun 2023 06:22:40 -0700 (PDT)
Received: from localhost ([159.226.94.115]) by smtp.gmail.com with ESMTPSA id
 ix14-20020a170902f80e00b001b80b583092sm8032735plb.210.2023.06.30.06.22.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 30 Jun 2023 06:22:40 -0700 (PDT)
From: Hawkins Jiawei <yin31149@gmail.com>
To: jasowang@redhat.com, mst@redhat.com, eperezma@redhat.com, philmd@linaro.org
Cc: qemu-devel@nongnu.org,
	yin31149@gmail.com,
	18801353760@163.com
Subject: [PATCH v3 1/2] vdpa: Delete duplicated VIRTIO_NET_F_RSS in
 vdpa_feature_bits
Date: Fri, 30 Jun 2023 21:21:47 +0800
Message-Id: <ffa46e5e3ac5ccd3ae1f54bd42fbcbf14c139491.1688130570.git.yin31149@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1688130570.git.yin31149@gmail.com>
References: <cover.1688130570.git.yin31149@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::631;
 envelope-from=yin31149@gmail.com; helo=mail-pl1-x631.google.com
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
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
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



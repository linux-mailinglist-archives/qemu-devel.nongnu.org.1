Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BEC2074B535
	for <lists+qemu-devel@lfdr.de>; Fri,  7 Jul 2023 18:46:33 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qHoZf-0008I5-TF; Fri, 07 Jul 2023 12:44:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yin31149@gmail.com>)
 id 1qHoZe-0008Hr-8g; Fri, 07 Jul 2023 12:44:50 -0400
Received: from mail-pg1-x536.google.com ([2607:f8b0:4864:20::536])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <yin31149@gmail.com>)
 id 1qHoZc-0000r0-O7; Fri, 07 Jul 2023 12:44:50 -0400
Received: by mail-pg1-x536.google.com with SMTP id
 41be03b00d2f7-55ba895d457so1231089a12.0; 
 Fri, 07 Jul 2023 09:44:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1688748287; x=1691340287;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=OWQDX4Xl3Fjvr/E7jvIsBsvbBEopMqYj4qNPq2Lua7Q=;
 b=fusblSqBi1O7GtA6pKrt2WHx6q+05yAXgW8zEmmg5/lsKOND92q+v9/Bzgi59tEs/x
 jxNXpiWUPlk0ggPVDxapgbWmLKGgJDvD/WPpf7tL+KbowM8ANUHSe9QVjpXn8nZvnrjL
 WNpabcW/psGuS8D6ybpIh7Mkvlb56k/Y4UVVsdUN1aJlSIoOSLGYGJIt67PAWGIXGMe0
 y41+4JcvL3b1iBPOfu48aBwCk4LrkLrI/+EBIBSzM9NTRbkC2c4HV0EFQ9S26aHzSGhY
 ziqdbK9t1mRn0Xlbd3XqVyWvkDio9oxzJUFs+SPm9QNr2BBps7oVZ+cPcRu/b6Q1tMWU
 aX2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688748287; x=1691340287;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=OWQDX4Xl3Fjvr/E7jvIsBsvbBEopMqYj4qNPq2Lua7Q=;
 b=S1PVs77fkiZSTvvYgucqSFWMgjCK6l1Yu74u9vFkL0bf0ZC6Lqs2nArm+aCgeJIrv3
 SrNiAGmFsku0cYkrNefQ1I8qdvlqQk6g8pbbH1hLnhIbL4dkkWUNjQwhkqFS0+KLWo3V
 gzJooz89qIYdudsN+tChPh6DNLFTy5I6FuRDEtHbHp03LqmrUTlnephqRg/enW2K/qpT
 hNYdE9UqQV6J+D4BHN++EhnclCU6OHPoEF6fbBTjkoUYmX309w1AsfzBEXkyE9RgtZdU
 aRRA9F1a9tQ0dMnqdzSu6d+eVs2Xx8tMqO3vsUDG/naCIPRBhcGI3vgfzGzl8pzTFXeV
 sI8Q==
X-Gm-Message-State: ABy/qLbhdQbfuo3isMzfiQziv9fmkroF9FXL97wLfq75ZaPimJVwd6VL
 KcT28Jb/m9o03rpk9QgDWBs=
X-Google-Smtp-Source: APBJJlEfSYZlszzRsudqIYBN6c3pNJ+FgvLkujUUdVqRm5OyaANznnX6dOj9qSNVvtmWpFNfXDC7kA==
X-Received: by 2002:a05:6a20:9385:b0:127:796d:b70d with SMTP id
 x5-20020a056a20938500b00127796db70dmr5337318pzh.61.1688748286451; 
 Fri, 07 Jul 2023 09:44:46 -0700 (PDT)
Received: from localhost ([159.226.94.115]) by smtp.gmail.com with ESMTPSA id
 16-20020aa79110000000b0065980654baasm3099419pfh.130.2023.07.07.09.44.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 07 Jul 2023 09:44:45 -0700 (PDT)
From: Hawkins Jiawei <yin31149@gmail.com>
To: jasowang@redhat.com,
	mst@redhat.com,
	eperezma@redhat.com
Cc: qemu-stable@nongnu.org, qemu-devel@nongnu.org, yin31149@gmail.com,
 18801353760@163.com
Subject: [PATCH 0/1] vdpa: Fix possible use-after-free for VirtQueueElement 
Date: Sat,  8 Jul 2023 00:44:41 +0800
Message-Id: <cover.1688746840.git.yin31149@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::536;
 envelope-from=yin31149@gmail.com; helo=mail-pg1-x536.google.com
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

This patch fixes the problem that vhost_vdpa_net_handle_ctrl_avail()
mistakenly frees the `elem`, even if it fails to forward the
CVQ command to vdpa device. This can result in a use-after-free

TestStep
========
1. test the patch using vp-vdpa device
  - For L0 guest, boot QEMU with virtio-net-pci net device with `ctrl_vq`
feature on, something like:
      -device virtio-net-pci,rx_queue_size=256,tx_queue_size=256,
iommu_platform=on,ctrl_vq=on,...

  - For L1 guest, apply the patch series, then apply an addtional
patch to make the vhost_vdpa_net_handle_ctrl_avail() fails to process
the CVQ command as below:

diff --git a/net/vhost-vdpa.c b/net/vhost-vdpa.c
index d8f37694ac..1f22355a41 100644
--- a/net/vhost-vdpa.c
+++ b/net/vhost-vdpa.c
@@ -797,7 +797,8 @@ static int vhost_vdpa_net_handle_ctrl_avail(VhostShadowVirtqueue *svq,
         dev_written = sizeof(status);
         *s->status = VIRTIO_NET_OK;
     } else {
-        dev_written = vhost_vdpa_net_cvq_add(s, out.iov_len, sizeof(status));
+        //dev_written = vhost_vdpa_net_cvq_add(s, out.iov_len, sizeof(status));
+        dev_written = -EINVAL;
         if (unlikely(dev_written < 0)) {
             goto out;
         }

start QEMU with vdpa device with svq mode and enable the `ctrl_vq`
feature on, something like:
      -netdev type=vhost-vdpa,x-svq=true,...
      -device virtio-net-pci,ctrl_vq=on,...

With this series, QEMU should not trigger any error or warning.
Without this series, QEMU should fail with
"free(): double free detected in tcache 2".

Hawkins Jiawei (1):
  vdpa: Fix possible use-after-free for VirtQueueElement

 net/vhost-vdpa.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

-- 
2.25.1



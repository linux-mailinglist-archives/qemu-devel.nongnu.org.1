Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BF30739443
	for <lists+qemu-devel@lfdr.de>; Thu, 22 Jun 2023 03:07:50 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qC8n2-00038s-Fg; Wed, 21 Jun 2023 21:07:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yin31149@gmail.com>)
 id 1qC8mx-00038B-WA; Wed, 21 Jun 2023 21:07:08 -0400
Received: from mail-pl1-x62f.google.com ([2607:f8b0:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <yin31149@gmail.com>)
 id 1qC8mw-0004g7-9s; Wed, 21 Jun 2023 21:07:07 -0400
Received: by mail-pl1-x62f.google.com with SMTP id
 d9443c01a7336-1b51780bed0so51587335ad.3; 
 Wed, 21 Jun 2023 18:07:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1687396024; x=1689988024;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=AcyAk4KfNjMaGzogo3bV3Rmv0BQ9Y6yjY3S4Xdz/rzw=;
 b=Sq+3DuPAdSZoRKOOsmqyqA/acx45P580nI8JbNLBR8hM2ziotwPGUmE+hNEQt+lQBY
 DU/wB+w6mhK8zeZf4TVrruuMrfbLutWaihEgDPBAyWcHYBqMyx3xMihbrMHjxm8JxRpX
 5MM/ZNYdJPnbid6mwLQ3tVXsxP0780OxV2dKVCiNfOYNgAd9PsA9roTR40kKf1nfTSAc
 IbTueCRgQ8qP1DfbOpr/SVF1WBRLOMo76nHPY8lXjL3mtwmScTwJFIZR3zp95Cjch5nQ
 FBRhBIUTQuR9DGIbW6C05wOn1mJIRmfDPbcdsmToFKb5cl3BgdElbGo6nhtzs/AXFVAS
 cMlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687396024; x=1689988024;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=AcyAk4KfNjMaGzogo3bV3Rmv0BQ9Y6yjY3S4Xdz/rzw=;
 b=Jmb6kMR/flofYCUTMHnLfoGjTcq0QsEiojcP1Mgymkew+6u5s3cGH25AedPb2xIdVx
 +8XRXmcBUYO0sQy1QprlkFqw4bAKW5Z0V5usZY/AFj7kJM+hGfyKRj/xlmC8LmyEmnLZ
 yYg+uevLOk8mH4sS6E42q1a4uWi3lq0cweXzRouwVbuyPWp+eWquSM6AgOL96ZrvRRm4
 QFwEeo/4bdNtu3ilPUr63ln6Gz9BrArjkvDE+PmYD/iB/V7Y6HJf41Q9pp0kFzBQ3j9e
 9H1tzL+gRKZw3iwCdz4tp6Ak+ca77q714r9NCedMRfBZ3TZqA8F3qGRiImMFjhnSwmub
 MpPg==
X-Gm-Message-State: AC+VfDzLZK7Gy8wU6lPB77b4wahnRT0oA1iAHclP9QZtE24zf2jJytjB
 v83ds70IFdkyYq/JgdLRnlo=
X-Google-Smtp-Source: ACHHUZ7pPPOoDHaUGUtriykEmcp08H5ppyqfmOyrNN1uHuRtSqbgo0YnzpZ3NT6vl0GoK5ku901zuw==
X-Received: by 2002:a17:902:6b88:b0:1b5:553e:4ea1 with SMTP id
 p8-20020a1709026b8800b001b5553e4ea1mr10467735plk.1.1687396023746; 
 Wed, 21 Jun 2023 18:07:03 -0700 (PDT)
Received: from localhost ([117.136.38.170]) by smtp.gmail.com with ESMTPSA id
 z6-20020a170903018600b001b02bd00c61sm4052432plg.237.2023.06.21.18.07.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 21 Jun 2023 18:07:03 -0700 (PDT)
From: Hawkins Jiawei <yin31149@gmail.com>
To: jasowang@redhat.com,
	mst@redhat.com,
	eperezma@redhat.com
Cc: qemu-devel@nongnu.org, qemu-stable@nongnu.org, yin31149@gmail.com,
 18801353760@163.com
Subject: [PATCH] vdpa: Increase out buffer size for CVQ commands
Date: Thu, 22 Jun 2023 09:06:51 +0800
Message-Id: <20230622010651.22698-1-yin31149@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62f;
 envelope-from=yin31149@gmail.com; helo=mail-pl1-x62f.google.com
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

According to the VirtIO standard, "Since there are no guarantees,
it can use a hash filter or silently switch to
allmulti or promiscuous mode if it is given too many addresses."
To achive this, QEMU ignores MAC addresses and marks `mac_table.x_overflow`
in the device internal state in virtio_net_handle_mac()
if the guest sets more than `MAC_TABLE_ENTRIES` MAC addresses
for the filter table.

However, the problem is that QEMU never marks the `mac_table.x_overflow`
for the vdpa device internal state when the guest sets more than
`MAC_TABLE_ENTRIES` MAC addresses.

To be more specific, currently QEMU offers a buffer size of
vhost_vdpa_net_cvq_cmd_len() for CVQ commands, which represents the size of
VIRTIO_NET_CTRL_MAC_TABLE_SET command with a maximum `MAC_TABLE_ENTRIES`
MAC addresses.

Consequently, if the guest sets more than `MAC_TABLE_ENTRIES` MAC addresses,
QEMU truncates the CVQ command data and copies this incomplete command
into the out buffer. In this situation, virtio_net_handle_mac() fails the
integrity check and returns VIRTIO_NET_ERR instead of marking
`mac_table.x_overflow` and returning VIRTIO_NET_OK, since the copied
CVQ command in the buffer is incomplete and flawed.

This patch solves this problem by increasing the buffer size to
vhost_vdpa_net_cvq_cmd_page_len(), which represents the size of the buffer
that is allocated and mmaped. Therefore, everything should work correctly
as long as the guest sets fewer than `(vhost_vdpa_net_cvq_cmd_page_len() -
sizeof(struct virtio_net_ctrl_hdr)
- 2 * sizeof(struct virtio_net_ctrl_mac)) / ETH_ALEN` MAC addresses.

Considering the highly unlikely scenario for the guest setting more than
that number of MAC addresses for the filter table, this patch should
work fine for the majority of cases. If there is a need for more than thoes
entries, we can increase the value for vhost_vdpa_net_cvq_cmd_page_len()
in the future, mapping more than one page for command output.

Fixes: 7a7f87e94c ("vdpa: Move command buffers map to start of net device")
Signed-off-by: Hawkins Jiawei <yin31149@gmail.com>
---
 net/vhost-vdpa.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/net/vhost-vdpa.c b/net/vhost-vdpa.c
index 5a72204899..ecfa8852b5 100644
--- a/net/vhost-vdpa.c
+++ b/net/vhost-vdpa.c
@@ -784,9 +784,18 @@ static int vhost_vdpa_net_handle_ctrl_avail(VhostShadowVirtqueue *svq,
     };
     ssize_t dev_written = -EINVAL;
 
+    /*
+     * This code truncates the VIRTIO_NET_CTRL_MAC_TABLE_SET CVQ command
+     * and prevents QEMU from marking `mac_table.x_overflow` in the device
+     * internal state in virtio_net_handle_mac() if the guest sets more than
+     * `(vhost_vdpa_net_cvq_cmd_page_len() - sizeof(struct virtio_net_ctrl_hdr)
+     * - 2 * sizeof(struct virtio_net_ctrl_mac)) / ETH_ALEN` MAC addresses for
+     * filter table.
+     * However, this situation is considered rare, so it is acceptable.
+     */
     out.iov_len = iov_to_buf(elem->out_sg, elem->out_num, 0,
                              s->cvq_cmd_out_buffer,
-                             vhost_vdpa_net_cvq_cmd_len());
+                             vhost_vdpa_net_cvq_cmd_page_len());
     if (*(uint8_t *)s->cvq_cmd_out_buffer == VIRTIO_NET_CTRL_ANNOUNCE) {
         /*
          * Guest announce capability is emulated by qemu, so don't forward to
-- 
2.25.1


